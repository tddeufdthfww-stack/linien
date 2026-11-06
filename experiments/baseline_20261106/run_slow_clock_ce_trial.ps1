# Linien slow PID clock-enable A/B trial.
# Runs only with -Run. All project source/build targets are restored in finally.
# Does NOT implement a bitstream or program hardware.
param([switch]$Run)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not $Run) { throw 'Diagnostic only: explicitly pass -Run to start.' }

$bundleDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Split-Path -Parent $bundleDir
$gatewareDir = Split-Path -Parent $buildDir
$repoDir = Split-Path -Parent $gatewareDir
$vivadoExe = 'D:\Xilinx\Vivado\2020.1\bin\vivado.bat'
$testScript = Join-Path $bundleDir 'tb_slow_clock_ce_trial.py'
$patchFile = Join-Path $bundleDir 'slow_clock_ce_trial.patch'
$timeTag = Get-Date -Format 'yyyyMMdd_HHmmss'
$trialDir = Join-Path $buildDir "reports\slow_clock_ce_trial_$timeTag"
$backupDir = Join-Path $trialDir 'backup'
$uploadDir = Join-Path $trialDir 'upload'
$utf8 = New-Object System.Text.UTF8Encoding($false)

# The reviewed sources are from timing_source_collection_20261106_113036.zip.
# If any source differs, stop before changing anything and request a new review.
$sourceHashes = [ordered]@{
  'logic\decimation.py' = 'CF0D4FCFF15228DB9D1897265331C4990CE331797C4895EBBEAFD80727179DE3'
  'logic\pid.py' = '578F0AA6DE7312AE5FE0F054FD9F4E7EBF7D3166FED418EBB82FB56A6D2CFDDF'
  'logic\limit.py' = '8FB6145EB0921ECBA2A3B3A9F5DD89879BE617B857B7A5D545E4557E59279468'
  'logic\chains.py' = '515284D3ABD1DDCE78C394F3B47FDDF7FBF746EA80790DB1E5B60E3DDEE02239'
  'linien_module.py' = 'B1428B0B8011AE601F5D69D0F04909ABC2BBB3902C2809240B8028D2F9B8C364'
}

$sourceFiles = [ordered]@{}
foreach ($relName in $sourceHashes.Keys) {
    $sourceFile = Join-Path $gatewareDir $relName
    $replacementFile = Join-Path (Join-Path $bundleDir 'candidate') $relName
    if (-not (Test-Path -LiteralPath $sourceFile)) { throw "Missing source: $sourceFile" }
    if (-not (Test-Path -LiteralPath $replacementFile)) { throw "Missing candidate: $replacementFile" }
    $fingerprint = (Get-FileHash -LiteralPath $sourceFile -Algorithm SHA256).Hash
    if ($fingerprint -ne $sourceHashes[$relName]) {
        throw "SOURCE_HASH_MISMATCH: $relName. Expected $($sourceHashes[$relName]); Actual $fingerprint. No files changed."
    }
    $sourceFiles[$relName] = $sourceFile
}

$csrmapPath = Join-Path $repoDir 'linien-server\linien_server\csrmap.py'
$synthScript = Join-Path $buildDir 'top_synth_only.tcl'
if (-not (Test-Path -LiteralPath $synthScript)) { throw "Missing $synthScript" }
if (-not (Test-Path -LiteralPath $testScript)) { throw "Missing $testScript" }
if (-not (Test-Path -LiteralPath $vivadoExe)) { throw "Missing Vivado $vivadoExe" }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw 'Activate .venv-gateware (python not found).' }

# Verify Python imports without Windows PowerShell 5.1 string-quoting ambiguity.
& python -c 'import migen; import misoc'
if ($LASTEXITCODE -ne 0) { throw 'Python Migen/MiSoC imports failed. Activate .venv-gateware.' }
Write-Host 'MIGEN_IMPORT_PASS' -ForegroundColor Green

# Start-Process keeps native stderr separate from PowerShell's terminating-error stream.
# This preserves COMPLETE Python traceback text, rather than just its first line.
function Invoke-PythonWithLog {
    param(
        [Parameter(Mandatory=$true)][string[]]$PythonArgs,
        [Parameter(Mandatory=$true)][string]$LogPath
    )
    $pythonExe = (Get-Command python -ErrorAction Stop).Source
    $stdoutPath = "$LogPath.stdout"
    $stderrPath = "$LogPath.stderr"
    # ArgumentList is joined by Start-Process, so quote each path / argument.
    $quotedArgs = @()
    foreach ($oneArg in $PythonArgs) {
        $quotedArgs += ('"' + $oneArg.Replace('"', '\"') + '"')
    }
    $process = Start-Process -FilePath $pythonExe -ArgumentList $quotedArgs `
        -Wait -PassThru -NoNewWindow `
        -RedirectStandardOutput $stdoutPath `
        -RedirectStandardError $stderrPath

    $stdout = if (Test-Path -LiteralPath $stdoutPath) { [System.IO.File]::ReadAllText($stdoutPath) } else { '' }
    $stderr = if (Test-Path -LiteralPath $stderrPath) { [System.IO.File]::ReadAllText($stderrPath) } else { '' }
    $combined = $stdout + [Environment]::NewLine + $stderr
    [System.IO.File]::WriteAllText($LogPath, $combined, (New-Object System.Text.UTF8Encoding($false)))
    return [int]$process.ExitCode
}

New-Item -ItemType Directory -Path $backupDir, $uploadDir -Force | Out-Null
$tracked = [ordered]@{}
foreach ($relName in $sourceHashes.Keys) {
    $tracked["source:$relName"] = $sourceFiles[$relName]
}
$tracked['build:top.v'] = Join-Path $buildDir 'top.v'
$tracked['build:top.xdc'] = Join-Path $buildDir 'top.xdc'
$tracked['build:top.tcl'] = Join-Path $buildDir 'top.tcl'
$tracked['build:top_synth_first.dcp'] = Join-Path $buildDir 'top_synth_first.dcp'
$tracked['build:top_synth_timing.rpt'] = Join-Path $buildDir 'top_synth_timing.rpt'
$tracked['build:top_synth_utilization.rpt'] = Join-Path $buildDir 'top_synth_utilization.rpt'
$tracked['server:csrmap.py'] = $csrmapPath

$hadFile = @{}
$backupPaths = @{}
$idx = 0
foreach ($name in $tracked.Keys) {
    $idx++
    $filePath = [string]$tracked[$name]
    $backupPath = Join-Path $backupDir ("file_{0:00}.bak" -f $idx)
    $backupPaths[$name] = $backupPath
    $hadFile[$name] = Test-Path -LiteralPath $filePath
    if ($hadFile[$name]) {
        Copy-Item -LiteralPath $filePath -Destination $backupPath -Force
    }
}

$baselineTimingPath = [string]$tracked['build:top_synth_timing.rpt']
if ($hadFile['build:top_synth_timing.rpt']) {
    Copy-Item -LiteralPath $baselineTimingPath -Destination (Join-Path $uploadDir 'baseline_timing.rpt') -Force
}
if ($hadFile['build:top_synth_utilization.rpt']) {
    Copy-Item -LiteralPath $tracked['build:top_synth_utilization.rpt'] -Destination (Join-Path $uploadDir 'baseline_utilization.rpt') -Force
}

$trialSucceeded = $false
$failureMessage = ''
try {
    # Model test does not need any code changes.
    $modelLogPath = Join-Path $trialDir 'model.log'
    $modelExit = Invoke-PythonWithLog -PythonArgs @($testScript, '--model-only') -LogPath $modelLogPath
    if ($modelExit -ne 0) { throw 'Model clock-divider check failed. See model.log.' }
    $modelLogText = Get-Content -LiteralPath (Join-Path $trialDir 'model.log') -Raw
    if (-not $modelLogText.Contains('DIVIDER_MODEL_PASS')) { throw 'Model test did not print its PASS marker.' }
    Write-Host '[1/5] Divider model verified.' -ForegroundColor Green

    # Temporarily install reviewed candidate source files.
    foreach ($relName in $sourceHashes.Keys) {
        $replacementFile = Join-Path (Join-Path $bundleDir 'candidate') $relName
        Copy-Item -LiteralPath $replacementFile -Destination $sourceFiles[$relName] -Force
    }
    Write-Host '[2/5] Candidate temporarily installed. Original files backed up.' -ForegroundColor Cyan

    # Migen tests from the project root so package-relative imports work.
    Push-Location $repoDir
    try {
        $testLogPath = Join-Path $trialDir 'migen_test.log'
        $testExitCode = Invoke-PythonWithLog -PythonArgs @(
            $testScript, '--original-pid', [string]$backupPaths['source:logic\pid.py']
        ) -LogPath $testLogPath
    } finally { Pop-Location }
    if ($testExitCode -ne 0) { throw 'Migen test failed. Inspect migen_test.log.' }
    $testLogText = Get-Content -LiteralPath (Join-Path $trialDir 'migen_test.log') -Raw
    foreach ($requiredMarker in @('DIVIDER_MIGEN_PASS', 'FAST_PID_REGRESSION_PASS', 'SLOW_PID_CE_HOLD_PASS', 'SLOW_CLOCK_CE_TRIAL_TEST_PASS')) {
        if (-not $testLogText.Contains($requiredMarker)) { throw "Missing Migen test marker: $requiredMarker" }
    }
    Write-Host '[3/5] Migen tests passed, including fast PID unchanged.' -ForegroundColor Green

    Push-Location $repoDir
    try {
        $oldPreview = $env:LINIEN_FPGA_PREVIEW
        $env:LINIEN_FPGA_PREVIEW = '1'
        try {
            $previewLogPath = Join-Path $trialDir 'migen_preview.log'
            $previewExitCode = Invoke-PythonWithLog -PythonArgs @(
                '-m', 'gateware.fpga_image_helper'
            ) -LogPath $previewLogPath
        } finally {
            if ($null -eq $oldPreview) { Remove-Item Env:\LINIEN_FPGA_PREVIEW -ErrorAction SilentlyContinue }
            else { $env:LINIEN_FPGA_PREVIEW = $oldPreview }
        }
    } finally { Pop-Location }
    if ($previewExitCode -ne 0) { throw 'Full Migen preview failed. See migen_preview.log.' }

    $generatedVerilog = [System.IO.File]::ReadAllText((Join-Path $buildDir 'top.v'))
    if ($generatedVerilog.Contains('decimated_clock')) { throw 'Old generated decimated_clock still appears in candidate top.v.' }
    if ($hadFile['server:csrmap.py']) {
        $oldMapHash = (Get-FileHash -LiteralPath $backupPaths['server:csrmap.py'] -Algorithm SHA256).Hash
        $newMapHash = (Get-FileHash -LiteralPath $csrmapPath -Algorithm SHA256).Hash
        if ($oldMapHash -ne $newMapHash) { throw "CSR_MAP_CHANGED: previous=$oldMapHash candidate=$newMapHash" }
    }
    Write-Host '[4/5] Top-level generated; old logic clock removed; CSR map verified.' -ForegroundColor Green

    Push-Location $buildDir
    try {
        & $vivadoExe -mode batch -source top_synth_only.tcl -log (Join-Path $trialDir 'synthesis.log') -journal (Join-Path $trialDir 'synthesis.jou')
        $synthExitCode = $LASTEXITCODE
    } finally { Pop-Location }
    if ($synthExitCode -ne 0) { throw 'Vivado candidate synthesis failed. See synthesis.log.' }
    foreach ($name in @('top_synth_timing.rpt', 'top_synth_utilization.rpt')) {
        if (-not (Test-Path -LiteralPath (Join-Path $buildDir $name))) { throw "Missing synthesized report: $name" }
    }
    Copy-Item -LiteralPath (Join-Path $buildDir 'top_synth_timing.rpt') -Destination (Join-Path $uploadDir 'candidate_timing.rpt') -Force
    Copy-Item -LiteralPath (Join-Path $buildDir 'top_synth_utilization.rpt') -Destination (Join-Path $uploadDir 'candidate_utilization.rpt') -Force
    foreach ($relName in $sourceHashes.Keys) {
        $safeName = $relName.Replace('\', '_')
        Copy-Item -LiteralPath $sourceFiles[$relName] -Destination (Join-Path $uploadDir "candidate_$safeName") -Force
    }
    # CE_ROUTE_DIAGNOSTIC_INVOKED
    # Run placement and routing while candidate DCP is active.
    $routeTool = Join-Path $buildDir 'run_implementation_diagnostic.ps1'

    if (!(Test-Path -LiteralPath $routeTool)) {
        throw "Missing implementation diagnostic script"
    }

    $routeLog = Join-Path $trialDir 'ce_route_wrapper.log'

    Write-Host '[6/6] Running candidate place and route...' -ForegroundColor Cyan

    & powershell.exe -NoProfile -ExecutionPolicy Bypass `
        -File $routeTool | Tee-Object -FilePath $routeLog

    $routeExitCode = $LASTEXITCODE
    $routeText = [System.IO.File]::ReadAllText($routeLog)

    Copy-Item -LiteralPath $routeLog `
        -Destination (Join-Path $uploadDir 'ce_route_wrapper.log') -Force

    if ($routeExitCode -ne 0 -or
        -not $routeText.Contains('IMPLEMENTATION_DIAGNOSTIC_PASS')) {
        throw "Candidate implementation incomplete. Check diagnostic ZIP."
    }

    Write-Host 'CE_ROUTE_DIAGNOSTIC_PASS' -ForegroundColor Green
    $trialSucceeded = $true
    Write-Host '[5/5] Trial synthesis finished. Reports collected.' -ForegroundColor Green
} catch {
    $failureMessage = $_.Exception.Message
    Write-Warning "SLOW_CLOCK_CE_TRIAL_FAILED: $failureMessage"
    foreach ($failureLog in @('migen_test.log', 'migen_preview.log', 'model.log')) {
        $failurePath = Join-Path $trialDir $failureLog
        if (Test-Path -LiteralPath $failurePath) {
            $logContent = [System.IO.File]::ReadAllText($failurePath)
            if ($logContent -match '(?m)^(Traceback|Exception|AssertionError|ImportError|ModuleNotFoundError|TypeError|ValueError)') {
                Write-Host "---- $failureLog last 35 lines ----" -ForegroundColor Yellow
                Get-Content -LiteralPath $failurePath -Tail 35 | ForEach-Object { Write-Host $_ }
                break
            }
        }
    }
} finally {
    # The original source and generated build artifacts are ALWAYS restored
    # on normal exit or a trapped error. Forced termination needs manual backup.
    foreach ($name in $tracked.Keys) {
        $destPath = [string]$tracked[$name]
        if ($hadFile[$name]) {
            Copy-Item -LiteralPath $backupPaths[$name] -Destination $destPath -Force
        } elseif (Test-Path -LiteralPath $destPath) {
            Remove-Item -LiteralPath $destPath -Force
        }
    }
    $restoreError = $false
    foreach ($relName in $sourceHashes.Keys) {
        $restoredHash = (Get-FileHash -LiteralPath $sourceFiles[$relName] -Algorithm SHA256).Hash
        if ($restoredHash -ne $sourceHashes[$relName]) { $restoreError = $true }
    }
    if ($restoreError) { throw "CRITICAL: source restore mismatch. Restore manually from $backupDir" }
    foreach ($logName in @('model.log', 'migen_test.log', 'migen_preview.log', 'synthesis.log')) {
        $logPath = Join-Path $trialDir $logName
        if (Test-Path -LiteralPath $logPath) {
            Copy-Item -LiteralPath $logPath -Destination (Join-Path $uploadDir $logName) -Force
        }
    }
    Copy-Item -LiteralPath $patchFile -Destination (Join-Path $uploadDir 'slow_clock_ce_trial.patch') -Force
    $notes = @(
        "Date=$timeTag",
        'Candidate is for experimentation only; all project sources and build files restored.',
        'Divider index 0 has an unavoidable +4 ns sampling phase shift.',
        'For stable divider settings 1..15, event rate/phase matches the reference model.',
        'Out-of-range decimation values (16..31) stop update pulses in candidate.',
        'Clock setting changes can cause phase discontinuities; not guaranteed cycle-equivalent.',
        'Fast PID should remain cycle-equivalent with update_en tied high.',
        'No hardware bitstream is generated. No routed timing or CDC safety guaranteed.',
        "Succeeded=$trialSucceeded",
        "Failure=$failureMessage"
    )
    [System.IO.File]::WriteAllLines((Join-Path $uploadDir 'manifest.txt'), $notes, $utf8)
    $zipPath = Join-Path $buildDir "reports\slow_clock_ce_trial_$timeTag.zip"
    Compress-Archive -Path (Join-Path $uploadDir '*') -DestinationPath $zipPath -Force
    Write-Host 'ORIGINAL_SOURCE_AND_BUILD_RESTORED' -ForegroundColor Green
    if ($trialSucceeded) { Write-Host 'SLOW_CLOCK_CE_TRIAL_PASS' -ForegroundColor Green }
    else { Write-Host 'SLOW_CLOCK_CE_TRIAL_INCOMPLETE' -ForegroundColor Yellow }
    Write-Host "UPLOAD_THIS_ZIP: $zipPath" -ForegroundColor Cyan
}
