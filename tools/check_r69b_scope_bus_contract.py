"""Explicit R69b response contract with frozen Scope/bridge references.

The original strict comparison including invalid bus payload remains a recorded
FAIL. ACK and numerical/state/cohort checks remain unconditional; RDATA/ERR
are compared whenever either ACK is nonzero or unknown. No original script or
reference source is edited. R69 native fault tests independently check local
zero error data, cancellation, replay and valid downstream error payload.
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
            bus_old = b'if({baseline_rdata,baseline_ack,baseline_err}!=={candidate_rdata,candidate_ack,candidate_err})'
            assert patched.count(bus_old) == 1, 'Scope bus monitor changed; review observer contract'
            bus_new = (
                b'if(baseline_ack===1\'b0 && candidate_ack===1\'b0 && '
                b'{baseline_rdata,baseline_err}!=={candidate_rdata,candidate_err})'
                b'r69b_idle_differences=r69b_idle_differences+1;\n '
                b'if(baseline_ack!==candidate_ack)$fatal(1,"R69B_SCOPE_ACK_MISMATCH");\n '
                b'if((baseline_ack!==1\'b0 || candidate_ack!==1\'b0) && '
                b'({baseline_rdata,baseline_err}!=={candidate_rdata,candidate_err}))')
            patched = patched.replace(bus_old,bus_new)
            header = b'module tb_scope_parent;'
            assert patched.count(header)==1
            patched = patched.replace(header,header+b'\ninteger r69b_idle_differences=0;')
            display_marker = b'$display("SCOPE_FULL_PARENT_PASS'
            assert patched.count(display_marker)==1
            patched = patched.replace(display_marker,b'$display("R69B_IDLE_PAYLOAD_DIFF_CYCLES=%0d",r69b_idle_differences);\n '+display_marker)

            (output / 'original_immediate_reset_tb.sv').write_bytes(raw)
            fixture.write_bytes(patched)
            changes.append({'fixture': str(fixture),
                            'original_sha256': hashlib.sha256(raw).hexdigest(),
                            'recovery_fixture_sha256': hashlib.sha256(patched).hexdigest(),
                            'change': 'Keep R61 recovery stimulus; ACK always strict, RDATA/ERR strict if either ACK is not known zero. All numeric/state/memory/CSR/cohort assertions untouched; idle differences counted.'})
        return original_simulate(output, top, sources, marker)

    module.simulate = simulate
    saved_argv = sys.argv
    passed = False
    try:
        sys.argv = [str(path), '--out', str(args.out)]
        module.main()
        assert path.read_bytes() == before, 'Original regression was modified'
        assert len(changes) == (1 if args.suite == 'average' else 4)
        report_path = args.out / 'results.json'
        if report_path.exists():
            upstream = json.loads(report_path.read_text(encoding='utf-8'))
            (args.out/'original_runner_metadata_before_annotation.json').write_text(json.dumps(upstream,indent=2),encoding='utf-8')
            upstream['scope'] = 'R69b frozen Scope/bridge response contract: unconditional ACK plus every original numerical, internal state, memory, CSR and cohort check; RDATA/ERR only qualified by either ACK nonzero or unknown. Original strict invalid-cycle bus equality remains recorded FAIL. Not physical CDC/STA/MTBF proof.'
            upstream['strict_invalid_bus_equivalence'] = 'FAIL_RECORDED_NOT_CLAIMED'
            upstream['r69b_contract_adapter'] = changes
            report_path.write_text(json.dumps(upstream,indent=2),encoding='utf-8')
        passed = True
    finally:
        sys.argv = saved_argv
        if args.out.exists():
            (args.out / 'r69b_scope_contract.json').write_text(json.dumps({
                'passed': passed, 'suite': args.suite,
                'unchanged_original_script_sha256': hashlib.sha256(before).hexdigest(),
                'strict_immediate_reset_equivalence': 'FAIL_RECORDED_NOT_CLAIMED',
                'strict_invalid_bus_equivalence':'FAIL_RECORDED_NOT_CLAIMED',
                'scope':'ACK is strict at every observed cycle. Payload/ERR are strict when either ACK is nonzero or unknown. All numerical/state/memory/CSR/cohort assertions remain enabled; original raw invalid payload equality FAIL is retained. R61 recovery stimulus retained. Not physical CDC/STA/MTBF proof.',
                'fixtures': changes}, indent=2), encoding='utf-8')
    print('R69B_SCOPE_BUS_CONTRACT_PASS', args.suite, flush=True)


if __name__ == '__main__':
    main()
