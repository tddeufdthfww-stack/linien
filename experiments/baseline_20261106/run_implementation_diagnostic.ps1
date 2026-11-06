# Linien Gen2: diagnostic implementation only. No RTL edits, no bitstream.
# Run from PowerShell with:
# powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run_implementation_diagnostic.ps1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$build  = 'D:\RP_Dev\linien-v2.1.0\gateware\build'
$gateware = Split-Path $build -Parent
$vivado = 'D:\Xilinx\Vivado\2020.1\bin\vivado.bat'
$dcp    = Join-Path $build 'top_synth_first.dcp'
$topv   = Join-Path $build 'top.v'
$topxdc = Join-Path $build 'top.xdc'

foreach ($p in @($build, $vivado, $dcp, $topv, $topxdc)) {
    if (-not (Test-Path -LiteralPath $p)) { throw "Missing prerequisite: $p" }
}

# Prevent inadvertently diagnosing an outdated checkpoint.
$dcpTime = (Get-Item -LiteralPath $dcp).LastWriteTimeUtc
$sourceFiles = @(
    $topv, $topxdc,
    (Join-Path $gateware 'verilog\axi_slave.v'),
    (Join-Path $gateware 'verilog\bus_clk_bridge.v'),
    (Join-Path $gateware 'verilog\red_pitaya_scope.v'),
    (Join-Path $gateware 'logic\pid.py'),
    (Join-Path $gateware 'lowlevel\crg.py')
)
foreach ($p in $sourceFiles) {
    if (-not (Test-Path -LiteralPath $p)) { throw "Missing source: $p" }
    if ((Get-Item -LiteralPath $p).LastWriteTimeUtc -gt $dcpTime.AddSeconds(5)) {
        throw "Checkpoint may be stale; source is newer: $p . Re-synthesize first."
    }
}

$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$run = Join-Path $build "reports\implementation_diagnostic_$stamp"
New-Item -ItemType Directory -Path $run -Force | Out-Null
$toPosix = { param($p) ([string]$p).Replace('\','/') }
$runP = & $toPosix $run
$dcpP = & $toPosix $dcp

$tclTemplate = @'
# Diagnostic-only implementation: never calls write_bitstream.
set out {%RUN%}
set stage OPEN_CHECKPOINT
if {[catch {
    puts "[clock format [clock seconds]] : Opening current synthesis checkpoint"
    open_checkpoint {%DCP%}

    set stage OPT_DESIGN
    puts "STEP_OPT_DESIGN_START"
    opt_design

    set stage PLACE_DESIGN
    puts "STEP_PLACE_DESIGN_START"
    place_design
    report_timing_summary -max_paths 20 -file "$out/placed_timing_summary.rpt"
    report_utilization -file "$out/placed_utilization.rpt"
    report_drc -file "$out/placed_drc.rpt"
    write_checkpoint -force "$out/placed.dcp"
    puts "STEP_PLACE_DESIGN_PASS"

    set stage PHYS_OPT_DESIGN
    puts "STEP_PHYS_OPT_DESIGN_START"
    phys_opt_design
    report_timing_summary -max_paths 20 -file "$out/physopt_timing_summary.rpt"
    puts "STEP_PHYS_OPT_DESIGN_PASS"

    set stage ROUTE_DESIGN
    puts "STEP_ROUTE_DESIGN_START"
    route_design
    report_timing_summary -max_paths 30 -file "$out/routed_timing_summary.rpt"
    report_timing -delay_type max -max_paths 30 -file "$out/routed_setup_paths.rpt"
    report_timing -delay_type min -max_paths 30 -file "$out/routed_hold_paths.rpt"
    report_clock_interaction -file "$out/routed_clock_interaction.rpt"
    check_timing -verbose -file "$out/routed_timing_checks.rpt"
    report_cdc -details -file "$out/routed_cdc.rpt"
    report_drc -file "$out/routed_drc.rpt"
    report_utilization -file "$out/routed_utilization.rpt"
    write_checkpoint -force "$out/routed.dcp"
    puts "STEP_ROUTE_DESIGN_PASS"
    puts "IMPLEMENTATION_DIAGNOSTIC_FLOW_PASS"
} msg opts]} {
    puts stderr "IMPLEMENTATION_STAGE_FAILED: $stage"
    puts stderr "DETAIL: $msg"
    exit 3
}
exit 0
'@
$tcl = $tclTemplate.Replace('%RUN%', $runP).Replace('%DCP%', $dcpP)
$tclFile = Join-Path $run 'implementation_diagnostic.tcl'
$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($tclFile, $tcl, $utf8)

Write-Host "[1/4] Input checkpoint: $dcp" -ForegroundColor Cyan
Write-Host "[2/4] opt_design + place_design + phys_opt_design + route_design" -ForegroundColor Cyan
Write-Host "      This may take several minutes or longer. No bitstream is generated."

Push-Location $build
try {
    & $vivado -mode batch -source $tclFile -log (Join-Path $run 'vivado.log') -journal (Join-Path $run 'vivado.jou')
    $vivadoExit = $LASTEXITCODE
} finally {
    Pop-Location
}

Write-Host "[3/4] Packaging diagnostics (checkpoints kept locally, not uploaded)." -ForegroundColor Cyan
$manifest = @(
    "Run: $stamp",
    "Vivado exit code: $vivadoExit",
    "Input synth checkpoint SHA256: $((Get-FileHash -LiteralPath $dcp -Algorithm SHA256).Hash)",
    'This flow does not change RTL or generate a bitstream.',
    'Implementation results are not CDC sign-off.'
)
[System.IO.File]::WriteAllLines((Join-Path $run 'manifest.txt'), $manifest, $utf8)
$upload = Join-Path $run 'upload'
New-Item -ItemType Directory -Path $upload -Force | Out-Null
Get-ChildItem -LiteralPath $run -File | Where-Object { $_.Extension -in @('.log','.rpt','.txt','.tcl') } |
    ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $upload -Force }
$zip = Join-Path $build "reports\implementation_diagnostic_$stamp.zip"
Compress-Archive -Path (Join-Path $upload '*') -DestinationPath $zip -Force

Write-Host "[4/4] Done. Vivado exit code: $vivadoExit" -ForegroundColor Cyan
if ($vivadoExit -eq 0 -and (Test-Path (Join-Path $run 'routed_timing_summary.rpt'))) {
    Write-Host 'IMPLEMENTATION_DIAGNOSTIC_PASS' -ForegroundColor Green
} elseif (Test-Path (Join-Path $run 'placed_timing_summary.rpt')) {
    Write-Warning 'IMPLEMENTATION_DIAGNOSTIC_PARTIAL: placement completed; later stage failed. Upload ZIP for analysis.'
} else {
    Write-Warning 'IMPLEMENTATION_DIAGNOSTIC_FAILED: see ZIP log; do not attempt bitstream.'
}
Write-Host "UPLOAD_THIS_ZIP: $zip" -ForegroundColor Yellow
Write-Host "LOCAL_CHECKPOINTS_DIRECTORY: $run"
