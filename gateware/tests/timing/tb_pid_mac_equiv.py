"""Differential Migen simulation of original and candidate Linien PID.
Run by run_pid_mac_trial.ps1 from the project root environment.
"""
import argparse
import importlib.machinery
import importlib.util
import random
from migen import Module
from migen.sim import run_simulation


def load_module(path, name):
    loader = importlib.machinery.SourceFileLoader(name, path)
    spec = importlib.util.spec_from_loader(name, loader)
    obj = importlib.util.module_from_spec(spec)
    loader.exec_module(obj)
    return obj


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--original', required=True)
    parser.add_argument('--candidate', required=True)
    args = parser.parse_args()
    orig_class = load_module(args.original, 'pid_mac_original').PID
    cand_class = load_module(args.candidate, 'pid_mac_candidate').PID

    class Pair(Module):
        def __init__(self):
            self.submodules.original = orig_class(width=25, coeff_width=14)
            self.submodules.candidate = cand_class(width=25, coeff_width=14)

    dut = Pair()
    rng = random.Random(20261106)
    mask25 = (1 << 25) - 1
    mask14 = (1 << 14) - 1
    cases = [
        (0, 0, 0, 0, 1),
        ((1 << 24)-1, -(1 << 24), (1 << 13)-1, 1, 0),
        (-(1 << 24), (1 << 24)-1, -(1 << 13), 1, 0),
        (-1, 1, -1, 1, 0),
        (1, -1, 1, 1, 0),
    ]
    for idx in range(450):
        cases.append((
            rng.randint(-(1 << 24), (1 << 24)-1),
            rng.randint(-(1 << 24), (1 << 24)-1),
            rng.randint(-(1 << 13), (1 << 13)-1),
            int(idx % 11 != 0),
            int(idx % 97 == 0),
        ))

    def run_cases():
        fields = ('error', 'ki_mult', 'int_sum', 'int_reg', 'int_out',
                  'pid_sum', 'pid_out', 'output_d')
        for i, (inp, sp, ki, running, reset) in enumerate(cases):
            for pid in (dut.original, dut.candidate):
                yield pid.input.eq(inp & mask25)
                yield pid.setpoint.storage.eq(sp & mask25)
                yield pid.ki.storage.eq(ki & mask14)
                yield pid.running.eq(running)
                yield pid.reset.storage.eq(reset)
            yield
            for field in fields:
                a = (yield getattr(dut.original, field))
                b = (yield getattr(dut.candidate, field))
                if a != b:
                    raise AssertionError(
                        f'PID_MAC_EQUIV_FAIL: cycle={i} {field}: original={a} candidate={b}'
                    )
        print(f'PID_MAC_EQUIV_PASS: {len(cases)} cycles, {len(fields)} signals/cycle')

    run_simulation(dut, run_cases(), clocks={'sys': 8})


if __name__ == '__main__':
    main()