"""Run unchanged Scope regressions with explicit R61 reset-recovery stimulus.

The old, immediate-post-reset differential is NOT equivalent and remains a
recorded FAIL. This runner checks steady-state numerical/state equivalence
after both bridges are ready. Dedicated check_r61_cdc_reset.py covers requests
during recovery, stopped clocks, reset parity and replay. No assertion is gated
or removed here, and the frozen Scope/bridge references remain untouched.
"""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import sys

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--suite', required=True, choices=['factor-cache', 'predecode', 'average'])
    args = parser.parse_args()
    names = {'factor-cache': 'check_scope_factor_cache',
             'predecode': 'check_scope_predecode', 'average': 'check_scope_average'}
    path = ROOT / 'tools' / (names[args.suite] + '.py')
    before = path.read_bytes()
    spec = importlib.util.spec_from_file_location('r61_scope_under_test', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    original_simulate = module.simulate
    changes = []

    def simulate(output, top, sources, marker):
        if top == 'tb_scope_parent':
            fixture = output / 'tb.sv'
            raw = fixture.read_bytes()
            needle = b'repeat(4)@(negedge sys_clk);sys_rstn=1;'
            assert raw.count(needle) == 1, 'Reset fixture changed; review contract adapter'
            # SYS=100 MHz, ADC=125 MHz in these fixtures. Three SYS cycles
            # cover both two-edge releases; comparisons remain active throughout.
            wait = b'repeat(3)@(negedge sys_clk);'
            if args.suite != 'average':
                wait += (b'if(candidate.i_bridge.src_ready!==2\'b11 || '
                         b'candidate.i_bridge.dst_ready!==2\'b11)'
                         b'$fatal(1,"R61_SCOPE_RECOVERY_NOT_READY");')
            patched = raw.replace(needle, needle + wait)
            (output / 'original_immediate_reset_tb.sv').write_bytes(raw)
            fixture.write_bytes(patched)
            changes.append({'fixture': str(fixture),
                            'original_sha256': hashlib.sha256(raw).hexdigest(),
                            'recovery_fixture_sha256': hashlib.sha256(patched).hexdigest(),
                            'change': 'Only add three SYS negedge waits and readiness assertion after coordinated reset release'})
        return original_simulate(output, top, sources, marker)

    module.simulate = simulate
    saved_argv = sys.argv
    passed = False
    try:
        sys.argv = [str(path), '--out', str(args.out)]
        module.main()
        assert path.read_bytes() == before, 'Original regression was modified'
        assert len(changes) == (1 if args.suite == 'average' else 4)
        passed = True
    finally:
        sys.argv = saved_argv
        if args.out.exists():
            (args.out / 'r61_reset_contract.json').write_text(json.dumps({
                'passed': passed, 'suite': args.suite,
                'unchanged_original_script_sha256': hashlib.sha256(before).hexdigest(),
                'strict_immediate_reset_equivalence': 'FAIL_RECORDED_NOT_CLAIMED',
                'scope': 'All original numerical/state/bus assertions remain enabled. Only coordinated reset recovery stimulus changes. Not physical CDC or instantaneous old reset equivalence.',
                'fixtures': changes}, indent=2), encoding='utf-8')
    print('R61_SCOPE_RESET_CONTRACT_PASS', args.suite, flush=True)


if __name__ == '__main__':
    main()
