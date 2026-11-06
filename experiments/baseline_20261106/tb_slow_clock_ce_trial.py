"""Linien slow-clock CE trial checks (for Python in .venv-gateware).

No physical CDC or timing claims. Stable divider event rates and target-PID
register behavior are tested, plus unchanged fast-PID functional behavior.
"""
import argparse
import importlib.machinery
import importlib.util
import random
from pathlib import Path


def check_divider_model():
    """Compare original 250 MHz selected counter-bit rising edges with 125 MHz CE.

    Clock edges are indexed in 4 ns fast-clock ticks. For k>=1 edges agree,
    while for k=0 sys cannot sample original 4 ns interleaved edges, so the
    first sys CE and subsequent events are one fast tick later.
    """
    for k in range(16):
        n_ticks = max(16, 3 * (1 << (k + 1)) + 4)
        reference = []
        candidate = []
        count_fast = 0
        old_clock = 0
        count_sys = 0
        valid = False
        for tick in range(n_ticks):
            if tick % 2 == 0:
                pulse = valid and (k == 0 or (count_sys & ((1 << k) - 1)) == (1 << (k - 1)))
                if pulse:
                    candidate.append(tick)
                valid = True
                count_sys = (count_sys + 1) & 0x7fff
            next_clock = (count_fast >> k) & 1
            if next_clock and not old_clock:
                reference.append(tick)
            old_clock = next_clock
            count_fast = (count_fast + 1) & 0xffff
        if k == 0:
            expected = [t + 1 for t in reference if t + 1 < n_ticks]
            assert candidate == expected, f'k=0 event-phase mismatch {candidate[:5]} vs {expected[:5]}'
        else:
            assert candidate == reference, f'k={k} event mismatch: {candidate[:5]} vs {reference[:5]}'
        assert len(reference) >= 2, (k, len(reference))
    print('DIVIDER_MODEL_PASS: all 16 stable rates; n=0 phase +4 ns explicitly allowed')


def load_original_pid(path):
    loader = importlib.machinery.SourceFileLoader('baseline_pid_slow_clock_trial', str(path))
    spec = importlib.util.spec_from_loader('baseline_pid_slow_clock_trial', loader)
    obj = importlib.util.module_from_spec(spec)
    loader.exec_module(obj)
    return obj.PID


def check_migen(original_pid_path):
    from migen import Module
    from migen.sim import run_simulation
    from gateware.logic.pid import PID
    from gateware.logic.chains import SlowChain
    from gateware.logic.decimation import DecimateEnable

    # Real Migen divider check: compare observed enables with independent
    # reference model for both small and large divide settings.
    divider = DecimateEnable(16)

    def divider_generator():
        count = 0
        started = 0
        for k in (0, 1, 2, 3, 5, 8, 15, 16, 31):
            yield divider.decimation.eq(k)
            yield
            started = 1
            count = (count + 1) & 0x7fff
            # Multiple events for small rates; sample a valid interval for
            # slow rates too. 16 and 31 must never produce an enable.
            for i in range(80 if k >= 8 else 64):
                actual = (yield divider.enable)
                expected = int(bool(started) and k < 16 and (
                    k == 0 or (count & ((1 << k) - 1)) == (1 << (k - 1))
                ))
                if actual != expected:
                    raise AssertionError(f'DIVIDER_MIGEN_FAIL k={k} step={i} actual={actual} expected={expected}')
                yield
                started = 1
                count = (count + 1) & 0x7fff
        print('DIVIDER_MIGEN_PASS: static and dynamic config cases including invalid indices')

    run_simulation(divider, divider_generator(), clocks={'sys': 8})

    class Pair(Module):
        def __init__(self):
            self.submodules.original = load_original_pid(original_pid_path)(width=14, coeff_width=14)
            self.submodules.updated = PID(width=14, coeff_width=14)

    pair = Pair()
    rng = random.Random(20261106)
    def fast_pid_test():
        fields = ('error', 'ki_mult', 'int_sum', 'int_reg', 'int_out', 'pid_sum', 'pid_out', 'output_d')
        for step in range(255):
            inp = rng.randrange(1 << 14)
            setp = rng.randrange(1 << 14)
            coeff = rng.randrange(1 << 14)
            for pid in (pair.original, pair.updated):
                yield pid.input.eq(inp)
                yield pid.setpoint.storage.eq(setp)
                yield pid.ki.storage.eq(coeff)
                yield pid.kp.storage.eq((coeff + step) & 0x3fff)
                yield pid.kd.storage.eq((coeff * 3 + step) & 0x3fff)
                yield pid.running.eq(int(step % 13 != 0))
                yield pid.reset.storage.eq(int(step % 71 == 0))
            yield
            for field in fields:
                a = (yield getattr(pair.original, field))
                b = (yield getattr(pair.updated, field))
                if a != b:
                    raise AssertionError(f'FAST_PID_REGRESSION_FAIL {field} step={step} old={a} new={b}')
        print('FAST_PID_REGRESSION_PASS: 255 cycles, 8 signals/cycle')
    run_simulation(pair, fast_pid_test(), clocks={'sys': 8})

    slow = SlowChain()
    slow_changes = [0]
    def slow_test():
        # With CE=0 none of the slow datapath registers may change, even
        # when inputs and configuration signals are intentionally varied.
        for step in range(220):
            ce = int(step % 9 == 0)
            yield slow.update_en.eq(ce)
            yield slow.input.eq((step * 977 + 2047) & 0x3fff)
            yield slow.pid.running.eq(1)
            yield slow.pid.setpoint.storage.eq(2048)
            yield slow.pid.ki.storage.eq(64)
            yield slow.pid.kp.storage.eq(128)
            yield slow.pid.kd.storage.eq(256)
            yield slow.limit.x.eq((step * 37) & ((1 << 19) - 1))
            monitor = (
                slow.pid.int_reg, slow.pid.output_d,
                slow.pid.pid_sum, slow.limit.y, slow.limit.error,
                slow.limit.limit.min, slow.limit.limit.max,
            )
            yield  # Apply CE and input configuration
            observed_en = (yield slow.update_en)
            if observed_en != ce:
                raise AssertionError(f"SLOW_PID_CE_CONFIG_FAIL step={step} actual={observed_en} expected={ce}")
            before = []
            for signal in monitor:
                before.append((yield signal))
            yield
            after = []
            for signal in monitor:
                after.append((yield signal))
            if not ce and after != before:
                raise AssertionError(f'SLOW_PID_CE_HOLD_FAIL step={step} old={before} new={after}')
            if ce and after != before:
                slow_changes[0] += 1
        if slow_changes[0] < 5:
            raise AssertionError('SLOW_PID_CE_UPDATE_FAIL: too few enabled state updates')
        print(f'SLOW_PID_CE_HOLD_PASS: 220 cycles; {slow_changes[0]} enabled updates')
    run_simulation(slow, slow_test(), clocks={'sys': 8})


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--original-pid', type=Path)
    parser.add_argument('--model-only', action='store_true')
    args = parser.parse_args()
    check_divider_model()
    if not args.model_only:
        if not args.original_pid or not args.original_pid.is_file():
            raise SystemExit('--original-pid must point to the backed up original PID source')
        check_migen(args.original_pid)
        print('SLOW_CLOCK_CE_TRIAL_TEST_PASS')

if __name__ == '__main__':
    main()
