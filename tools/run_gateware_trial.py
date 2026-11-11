"""Isolated functional/synthesis/implementation runs; never writes a bitstream."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
from datetime import datetime

ROOT = Path(__file__).resolve().parents[1]


def execute(args, cwd, output, name, env, marker=None):
    command = [str(a) for a in args]
    if os.name == 'nt' and command[0].lower().endswith('.bat'):
        # Vivado's batch argument parser splits unquoted KEY=VALUE tokens.
        command = ' '.join('"' + a + '"' if '=' in a else subprocess.list2cmdline([a])
                           for a in command)
    result = subprocess.run(command, cwd=cwd, env=env,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output / (name + '.stdout.log')).write_bytes(result.stdout)
    (output / (name + '.stderr.log')).write_bytes(result.stderr)
    text = (result.stdout + b'\n' + result.stderr).decode('utf-8', errors='replace')
    status = {'command': [str(a) for a in args], 'cwd': str(cwd),
              'exit_code': result.returncode, 'required_marker': marker}
    status['passed'] = result.returncode == 0 and (not marker or marker in text)
    if re.search(r'(?m)^(ERROR:|FATAL_ERROR:|Traceback \(most recent call last\):|AssertionError:)', text):
        status['passed'] = False
    (output / (name + '.json')).write_text(json.dumps(status, indent=2), encoding='utf-8')
    success = 'COMPLETE' if name in ('versions', 'migen_generate', 'synthesis', 'implementation') else 'PASS'
    print(name, success if status['passed'] else 'FAIL', flush=True)
    if not status['passed']:
        print(text[-6000:], flush=True)
        raise RuntimeError(name + ' failed; see complete logs')
    return text


def tcl_run(text, output, name, env, marker, vivado):
    script = output / (name + '.tcl')
    script.write_text('if {[catch {\n' + text + '\n} msg opts]} {\n'
                      'puts stderr "ERROR: $msg"\nputs stderr [dict get $opts -errorinfo]\nexit 3\n}\nexit 0\n',
                      encoding='utf-8')
    return execute([vivado, '-mode', 'batch', '-source', script,
                    '-log', output / (name + '.vivado.log'),
                    '-journal', output / (name + '.jou')], output, output, name, env, marker)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--label', required=True)
    parser.add_argument('--stages', default='functional,generate,synth,route')
    parser.add_argument('--vivado', default='D:/Xilinx/Vivado/2020.1/bin/vivado.bat')
    args = parser.parse_args()
    if not re.fullmatch(r'[A-Za-z0-9_-]+', args.label):
        parser.error('label must be a simple directory name')
    out = ROOT / 'gateware/build/trials' / (datetime.now().strftime('%Y%m%d_%H%M%S') + '_' + args.label)
    out.mkdir(parents=True, exist_ok=False)
    env = os.environ.copy()
    env['PYTHONDONTWRITEBYTECODE'] = '1'
    env['PYTHONPATH'] = str(ROOT) + os.pathsep + str(ROOT / 'linien-common')
    env['MPLBACKEND'] = 'Agg'
    files = subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0')
    files += subprocess.check_output(['git', 'ls-files', '--others', '--exclude-standard', '-z'], cwd=ROOT).decode().split('\0')
    hashes = {n: hashlib.sha256((ROOT / n).read_bytes()).hexdigest()
              for n in sorted(set(files) - {''}) if (ROOT / n).is_file()}
    manifest = {'label': args.label, 'source_hashes': hashes,
                'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
                'status': subprocess.check_output(['git', 'status', '--short'], cwd=ROOT, text=True),
                'python': sys.version, 'output': str(out), 'stages': args.stages,
                'functional': 'NOT RUN', 'synthesis': 'NOT RUN', 'route': 'NOT RUN',
                'timing_signoff': 'NOT EVALUATED'}
    manifest_path = out / 'manifest.json'
    def save():
        manifest_path.write_text(json.dumps(manifest, indent=2), encoding='utf-8')
    save()
    print('RUN_DIRECTORY', out, flush=True)
    try:
        execute([sys.executable, '-c', 'import sys, importlib.metadata as m, linien_common; '
                 'print(sys.version); print(linien_common.__file__); '
                 'print("\\n".join(n+"=="+m.version(n) for n in ["migen","misoc","linien-common","pytest","pytest-plt"]))'],
                ROOT, out, 'versions', env)
        stages = args.stages.split(',')
        if 'functional' in stages:
            execute([sys.executable, ROOT / 'tools/check_dna_read_control.py', '--out', out / 'dna_read_control_checks'],
                    ROOT, out, 'dna_read_control', env, 'DNA_READ_CONTROL_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_r61_cdc_reset.py', '--out', out / 'r61_cdc_reset_checks'],
                    ROOT, out, 'r61_cdc_reset', env, 'R61_CDC_RESET_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_r61_axi_error.py', '--out', out / 'r61_axi_error_checks'],
                    ROOT, out, 'r61_axi_error', env, 'R61_AXI_ERROR_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_c48_carry_fold.py', '--out', out / 'c48_carry_fold_checks'],
                    ROOT, out, 'c48_carry_fold', env, 'C48_CARRY_FOLD_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_c48_fold_filter.py', '--out', out / 'c48_fold_filter_checks'],
                    ROOT, out, 'c48_fold_filter', env, 'C48_FOLD_FILTER_CONFIG2_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_scope_factor_cache.py', '--out', out / 'scope_factor_cache_checks'],
                    ROOT, out, 'scope_factor_cache', env, 'SCOPE_FACTOR_CACHE_SUITE_PASS')
            execute([sys.executable, ROOT / 'tools/check_scope_predecode.py', '--out', out / 'scope_predecode_checks'],
                    ROOT, out, 'scope_predecode', env, 'SCOPE_SOURCE_PREDECODE_SUITE_PASS')
            if (ROOT / 'tools/check_instruction_prefetch.py').exists():
                execute([sys.executable, ROOT / 'tools/check_instruction_prefetch.py', '--out', out / 'instruction_prefetch_checks'],
                        ROOT, out, 'instruction_prefetch', env, 'INSTRUCTION_PREFETCH_SUITE_PASS')
            text = execute([sys.executable, '-m', 'pytest', 'tests/test_pid.py',
                            'tests/test_limit.py', 'tests/test_sweep.py',
                            'tests/test_simple_autolock_fpga.py', '-q',
                            '--basetemp', str(out / 'pytest-temp')], ROOT, out, 'pytest', env)
            if not re.search(r'\b\d+ passed\b', text):
                raise RuntimeError('pytest did not execute passing tests')
            custom = ROOT / 'gateware/tests/timing/tb_ce_saturation.py'
            if custom.exists():
                execute([sys.executable, '-m', 'gateware.tests.timing.tb_ce_saturation'],
                        ROOT, out, 'ce_saturation', env, 'CE_SATURATION_SUITE_PASS')
            if (ROOT / 'gateware/tests/timing/tb_pid_pipeline.py').exists():
                execute([sys.executable, '-m', 'gateware.tests.timing.tb_pid_pipeline'],
                        ROOT, out, 'pid_pipeline', env, 'PID_PIPELINE_SUITE_PASS')
            if (ROOT / 'tools/check_slow_pipeline.py').exists():
                execute([sys.executable, ROOT / 'tools/check_slow_pipeline.py', '--out', out / 'slow_pipeline_checks'],
                        ROOT, out, 'slow_pipeline', env, 'SLOW_PIPELINE_SUITE_PASS')
            if (ROOT / 'tools/check_autolock_pipeline.py').exists():
                execute([sys.executable, ROOT / 'tools/check_autolock_pipeline.py', '--out', out / 'autolock_pipeline_checks'],
                        ROOT, out, 'autolock_pipeline', env, 'AUTOLOCK_DECISION_PIPELINE_SUITE_PASS')
            if (ROOT / 'tools/check_registered_mixer.py').exists():
                execute([sys.executable, ROOT / 'tools/check_registered_mixer.py', '--out', out / 'registered_mixer_checks'],
                        ROOT, out, 'registered_mixer', env, 'REGISTERED_MIXER_SUITE_PASS')
            if (ROOT / 'tools/check_feedback_frame.py').exists():
                execute([sys.executable, ROOT / 'tools/check_feedback_frame.py', '--out', out / 'feedback_frame_checks'],
                        ROOT, out, 'feedback_frame', env, 'FEEDBACK_FRAME_SUITE_PASS')
            if (ROOT / 'tools/check_iir_frame.py').exists():
                execute([sys.executable, ROOT / 'tools/check_iir_frame.py', '--out', out / 'iir_frame_checks'],
                        ROOT, out, 'iir_frame', env, 'IIR_CONFIG_FRAME_SUITE_PASS')
            if (ROOT / 'tools/check_c48_mac.py').exists():
                execute([sys.executable, ROOT / 'tools/check_c48_mac.py', '--out', out / 'c48_mac_checks'],
                        ROOT, out, 'c48_mac', env, 'C48_MAC_SUITE_PASS')
            if (ROOT / 'tools/check_c48_filter.py').exists():
                execute([sys.executable, ROOT / 'tools/check_c48_filter.py', '--out', out / 'c48_filter_checks'],
                        ROOT, out, 'c48_filter', env, 'C48_FILTER_SUITE_PASS')
            if (ROOT / 'tools/check_registered_c48_mac.py').exists():
                execute([sys.executable, ROOT / 'tools/check_registered_c48_mac.py', '--out', out / 'registered_c48_mac_checks'],
                        ROOT, out, 'registered_c48_mac', env, 'C48_REGISTERED_MAC_SUITE_PASS')
            if (ROOT / 'tools/check_parallel_tap.py').exists():
                execute([sys.executable, ROOT / 'tools/check_parallel_tap.py', '--out', out / 'parallel_tap_checks'],
                        ROOT, out, 'parallel_tap', env, 'PARALLEL_TAP_SUITE_PASS')
            if (ROOT / 'tools/check_abs_threshold.py').exists():
                execute([sys.executable, ROOT / 'tools/check_abs_threshold.py', '--out', out / 'abs_threshold_checks'],
                        ROOT, out, 'abs_threshold', env, 'ABS_PREDICATE_SUITE_PASS')
            if (ROOT / 'tools/check_common_csr.py').exists():
                execute([sys.executable, ROOT / 'tools/check_common_csr.py', '--out', out / 'common_csr_checks'],
                        ROOT, out, 'common_csr', env, 'COMMON_CSR_SUITE_PASS')
            if (ROOT / 'tools/check_pid_output_limit.py').exists():
                execute([sys.executable, ROOT / 'tools/check_pid_output_limit.py', '--out', out / 'pid_output_checks'],
                        ROOT, out, 'pid_output_limit', env, 'PID_OUTPUT_LIMIT_SUITE_PASS')
            if (ROOT / 'tools/check_scope_average.py').exists():
                execute([sys.executable, ROOT / 'tools/check_scope_average.py', '--out', out / 'scope_average_checks'],
                        ROOT, out, 'scope_average', env, 'SCOPE_AVERAGE_SUITE_PASS')
            sim = out / 'xsim'
            sim.mkdir()
            toolbin = Path(args.vivado).parent
            cases = [('axi/tb_axi_slave_read.sv', 'AXI_READ_BACKPRESSURE_TEST_PASS'),
                     ('axi/tb_axi_slave_write.sv', 'AXI_WRITE_BACKPRESSURE_TEST_PASS'),
                     ('cdc/tb_bus_clk_bridge.sv', 'BUS_CLK_BRIDGE_TEST_PASS'),
                     ('cdc/tb_bus_clk_bridge_read_snapshot.sv', 'BUS_CLK_BRIDGE_READ_SNAPSHOT_TEST_PASS'),
                     ('integration/tb_axi_bridge_integration.sv', 'AXI_BRIDGE_RESET_RECOVERY_TEST_PASS')]
            for rel, marker in cases:
                bench = ROOT / 'gateware/tests' / rel
                top = bench.stem
                execute([toolbin / 'xvlog.bat', '--sv', ROOT / 'gateware/verilog/axi_slave.v',
                         ROOT / 'gateware/verilog/bus_clk_bridge.v', bench], sim, out, top + '_compile', env)
                execute([toolbin / 'xelab.bat', top, '-s', top, '--timescale', '1ns/1ps'],
                        sim, out, top + '_elaborate', env)
                phases = [1, 1250, 3999, 7999] if top == 'tb_bus_clk_bridge' else [None]
                for phase in phases:
                    command = [toolbin / 'xsim.bat', top, '-runall']
                    if phase is not None:
                        command += ['--testplusarg', 'PHASE_PS=' + str(phase)]
                    execute(command, sim, out, top + '_simulate_' + str(phase), env, marker)
            manifest['functional'] = 'PASS'; save()
        if 'generate' in stages:
            ps = out / 'ps/linien_ps_only'
            shutil.copytree(ROOT / 'hardware/ps_reference/linien_ps_only', ps)
            env.update(LINIEN_FPGA_PREVIEW='1', LINIEN_PS_BD=str(ps / 'linien_ps_only.bd'),
                       LINIEN_FPGA_BUILD_DIR=str(out), LINIEN_CSRMAP_OUTPUT=str(out / 'csrmap.py'))
            execute([sys.executable, '-m', 'gateware.fpga_image_helper'], ROOT, out,
                    'migen_generate', env, 'Vivado Tcl generated successfully')
            # Compare register protocol semantically, independently of line endings.
            reference = {}; generated = {}
            exec((ROOT / 'linien-server/linien_server/csrmap.py').read_text(), reference)
            exec((out / 'csrmap.py').read_text(), generated)
            for key in ['csr', 'csr_constants', 'states', 'signals']:
                if reference[key] != generated[key]:
                    raise RuntimeError('CSR protocol changed: ' + key)
            print('CSR_MAP_EQUIVALENT_PASS', flush=True)
            manifest['generated_files'] = {name: hashlib.sha256((out / name).read_bytes()).hexdigest()
                                           for name in ['top.v', 'top.xdc', 'top.tcl', 'csrmap.py']}
            save()
        if 'synth' in stages:
            prefix = (out / 'top.tcl').read_text().split('synth_design', 1)[0]
            # IPI rejects a BD below the project directory; keep project and
            # per-run PS inputs as siblings, without touching the shared BD.
            prefix = prefix.replace('create_project -force -name top -part',
                                    'create_project -force -name top -dir vivado_project -part', 1)
            script = prefix + '\nsynth_design -top top -part xc7z020clg400-1\n'
            script += 'source {' + (ROOT / 'gateware/constraints/dna_clock.tcl').as_posix() + '}\n'
            script += 'report_timing_summary -file synth_timing.rpt\nreport_utilization -file synth_utilization.rpt\n'
            script += 'write_checkpoint -force synth.dcp\nputs SYNTHESIS_COMPLETE\n'
            tcl_run(script, out, 'synthesis', env, 'SYNTHESIS_COMPLETE', args.vivado)
            manifest['synthesis'] = 'COMPLETE'; save()
        if 'route' in stages:
            script = 'open_checkpoint synth.dcp\nopt_design\nplace_design\nphys_opt_design\nroute_design\n'
            script += 'report_route_status -file routed_status.rpt\n'
            script += 'report_timing_summary -max_paths 30 -file routed_timing.rpt\n'
            script += 'report_timing -delay_type max -max_paths 100 -file routed_setup.rpt\n'
            script += 'report_timing -delay_type min -max_paths 30 -file routed_hold.rpt\n'
            script += 'check_timing -verbose -file routed_checks.rpt\nreport_cdc -details -file routed_cdc.rpt\n'
            script += 'report_drc -file routed_drc.rpt\nreport_utilization -file routed_utilization.rpt\n'
            script += 'report_clock_interaction -file routed_clocks.rpt\nwrite_checkpoint -force routed.dcp\nputs ROUTE_COMPLETE\n'
            tcl_run(script, out, 'implementation', env, 'ROUTE_COMPLETE', args.vivado)
            manifest['route'] = 'COMPLETE'
            manifest['timing_signoff'] = 'INCOMPLETE: requires Setup/Hold/Pulse/CDC/I/O/DRC review'
            save()
    except Exception as exc:
        manifest['failure'] = str(exc); save(); raise
    finally:
        changed = [n for n, digest in hashes.items() if not (ROOT / n).is_file()
                   or hashlib.sha256((ROOT / n).read_bytes()).hexdigest() != digest]
        manifest['source_changes_during_run'] = changed; save()
        if changed:
            raise RuntimeError('Source changed during run: ' + repr(changed))
    print('TRIAL_FLOW_COMPLETE', flush=True)


if __name__ == '__main__':
    main()
