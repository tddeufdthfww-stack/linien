"""Bit-exact PID, real CSR bus, and full-rate CE regression."""
import importlib.util
from pathlib import Path
import random

from migen import ClockDomain, CEInserter, Constant, Module
from migen.sim import run_simulation
from misoc.interconnect.csr_bus import CSRBank

from gateware.logic.pid import PID
from gateware.logic.decimation import DecimateEnable
from gateware.logic.limit import LimitCSR

ROOT = Path(__file__).resolve().parents[3]


def baseline_pid():
    path = ROOT / 'experiments/baseline_20261106/pid_reference.py'
    spec = importlib.util.spec_from_file_location('pid_reference', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.PID


def check_pid(width):
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys = ClockDomain('sys')
            self.submodules.reference = CEInserter()(baseline_pid()(width=width))
            self.reference.ce.reset = Constant(1, 1)
            self.submodules.candidate = PID(width=width)
    dut = Pair()
    rng = random.Random(20261106 + width)
    fields = ['error', 'ki_mult', 'int_sum', 'int_reg', 'int_out', 'output_p',
              'output_d', 'pid_sum', 'pid_out']
    def bench():
        for step in range(1600):
            enabled = (step < 200 or 400 <= step < 700 or rng.randrange(5) == 0)
            yield dut.reference.ce.eq(enabled)
            yield dut.candidate.update_en.eq(enabled)
            yield dut.cd_sys.rst.eq(step in (150, 151, 735, 736))
            values = [0, 1, (1 << (width-1))-1, 1 << (width-1), (1 << width)-1]
            inp = values[step % len(values)] if step < 200 else rng.getrandbits(width)
            setp = values[(step//3) % len(values)] if step < 200 else rng.getrandbits(width)
            coeffs = [0, 1, 8191, 8192, 16383]
            ki = coeffs[(step//13) % len(coeffs)] if step < 700 else rng.getrandbits(14)
            for pid in (dut.reference, dut.candidate):
                yield pid.input.eq(inp)
                yield pid.setpoint.storage.eq(setp)
                yield pid.kp.storage.eq((step*97) & 16383)
                yield pid.ki.storage.eq(ki)
                yield pid.kd.storage.eq((step*59) & 16383)
                yield pid.running.eq(step % 17 != 0)
                yield pid.reset.storage.eq(step % 101 == 0)
            yield
            for field in fields:
                a = (yield getattr(dut.reference, field))
                b = (yield getattr(dut.candidate, field))
                assert a == b, (width, step, field, a, b)
        # Force accumulator states near every exact saturation boundary, then
        # let both real arithmetic datapaths evolve from identical state.
        n = width + 14 + 4
        upper = ((1 << (width-1))-1) << 18
        lower = -upper-1
        for initial in [upper-1, upper, upper+1, lower-1, lower, lower+1,
                        (1 << (n-1))-1, -(1 << (n-1))]:
            for polarity in [-1, 1]:
                yield dut.reference.ce.eq(0)
                yield dut.candidate.update_en.eq(0)
                for pid in (dut.reference, dut.candidate):
                    yield pid.int_reg.eq(initial)
                    yield pid.input.eq(polarity)
                    yield pid.setpoint.storage.eq(0)
                    yield pid.ki.storage.eq(16)
                    yield pid.running.eq(1)
                    yield pid.reset.storage.eq(0)
                yield
                yield dut.reference.ce.eq(1)
                yield dut.candidate.update_en.eq(1)
                for _ in range(4):
                    yield
                    for field in fields:
                        a = (yield getattr(dut.reference, field))
                        b = (yield getattr(dut.candidate, field))
                        assert a == b, ('boundary', width, initial, polarity, field, a, b)
        print('PID_BIT_EXACT_PASS width=' + str(width), flush=True)
    run_simulation(dut, bench(), clocks={'sys': 8})


def check_divider(settings=None):
    for setting in (list(range(16)) + [16, 31] if settings is None else settings):
        dut = DecimateEnable(16)
        def bench(setting=setting, dut=dut):
            yield dut.decimation.eq(setting)
            # Input assignment settles before the first tested active edge.
            yield
            observed = []
            effective = min(setting, 15)
            for cycle in range(1, 3*(1 << effective)+9):
                actual = (yield dut.enable)
                expected = int(effective == 0 or cycle % (1 << effective) == (1 << (effective-1)))
                assert actual == expected, ('static', setting, cycle, actual, expected)
                if actual:
                    observed.append(cycle)
                yield
            assert len(observed) >= 3, (setting, observed)
            assert all(b-a == (1 << effective) for a,b in zip(observed,observed[1:]))
            print('DIVIDER_REAL_EVENTS_PASS k=%d events=%d' % (setting,len(observed)), flush=True)
        run_simulation(dut, bench(), clocks={'sys': 8})
    top = Module()
    top.clock_domains.cd_sys = ClockDomain('sys')
    top.submodules.divider = dut = DecimateEnable(16)
    rng = random.Random(125)
    def dynamic():
        # Every illegal index is explicitly exercised; the counter keeps
        # running so legal recovery uses its current phase, not a restart.
        schedule = [0, 15] + list(range(16,32)) + [1,0,2,31,3]
        counter = 0
        started = False
        sampled_reset = False
        for cycle in range(2200):
            if cycle < len(schedule):
                setting = schedule[cycle]
            elif cycle % 11 == 0:
                setting = rng.randrange(32)
            yield dut.decimation.eq(setting)
            resetting = cycle in (500,501,1500)
            yield top.cd_sys.rst.eq(resetting)
            yield
            # The generator drives reset after the active-edge evaluation;
            # the next synchronous state transition uses its previous value.
            counter = 0 if sampled_reset else (counter+1) & 0x7fff
            started = not sampled_reset
            sampled_reset = resetting
            assert (yield dut.decimation_counter) == counter, ('counter',cycle,counter)
            assert (yield dut.started) == started, ('started',cycle,started)
            effective = min(setting, 15)
            expected = int(started and (effective == 0 or
                counter % (1 << effective) == (1 << (effective-1))))
            assert (yield dut.enable) == expected, ('dynamic',cycle,setting,
                'counter_model',counter,'counter_dut',(yield dut.decimation_counter),
                'started',(yield dut.started),'reset',(yield top.cd_sys.rst))
        print('DIVIDER_DYNAMIC_AND_INVALID_PASS', flush=True)
    run_simulation(top, dynamic(), clocks={'sys': 8})


def check_limit():
    path = ROOT / 'experiments/baseline_20261106/limit_reference.py'
    spec = importlib.util.spec_from_file_location('gateware.logic.limit_reference', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    class Pair(Module):
        def __init__(self):
            self.submodules.reference = CEInserter()(module.LimitCSR(width=14, guard=5))
            self.reference.ce.reset = Constant(1, 1)
            self.submodules.candidate = LimitCSR(width=14, guard=5)
    dut = Pair()
    rng = random.Random(4096)
    def bench():
        for step in range(900):
            ce = int(step % 7 == 0 or 300 <= step < 400)
            yield dut.reference.ce.eq(ce)
            yield dut.candidate.update_en.eq(ce)
            x = rng.getrandbits(19)
            for limit in (dut.reference,dut.candidate):
                yield limit.x.eq(x)
                yield limit.min.storage.eq((-7000+step) & 16383)
                yield limit.max.storage.eq((8000-step) & 16383)
            yield
            for name in ['y','error']:
                assert (yield getattr(dut.reference,name)) == (yield getattr(dut.candidate,name)), ('limit',step,name)
        print('LIMIT_CE_BIT_EXACT_PASS', flush=True)
    run_simulation(dut, bench(), clocks={'sys': 8})


def check_csr():
    class DUT(Module):
        def __init__(self):
            self.submodules.pid = PID()
            self.submodules.bank = CSRBank(self.pid.get_csrs())
    dut = DUT()
    def bench():
        yield dut.pid.update_en.eq(0)
        yield dut.pid.int_reg.eq(123)
        yield
        for storage, value in [(dut.pid.ki, 0x2a55), (dut.pid.kp, 0x1234),
                               (dut.pid.setpoint, 0x3012), (dut.pid.reset, 1)]:
            remaining = storage.size
            for csr in storage.simple_csrs:
                remaining -= csr.size
                word = (value >> remaining) & ((1 << csr.size)-1)
                address = dut.bank.simple_csrs.index(csr)
                yield dut.bank.bus.adr.eq(address)
                yield dut.bank.bus.dat_w.eq(word)
                yield dut.bank.bus.we.eq(1)
                yield
                yield
                yield dut.bank.bus.we.eq(0)
                yield
                yield
                assert (yield dut.bank.bus.dat_r) == word, ('CSR read',csr.name)
            assert (yield storage.storage) == value, ('CSR storage',storage.name)
            assert (yield dut.pid.int_reg) == 123, 'CE=0 did not hold PID state'
        yield dut.pid.update_en.eq(1)
        yield
        yield
        assert (yield dut.pid.int_reg) == 0, 'PID reset failed on enabled update'
        print('CSR_BUS_WRITE_READ_WITH_CE_ZERO_PASS', flush=True)
    run_simulation(dut, bench(), clocks={'sys': 8})


def main():
    check_pid(14)
    check_pid(25)
    check_divider()
    check_limit()
    check_csr()
    print('CE_SATURATION_SUITE_PASS', flush=True)


if __name__ == '__main__':
    main()
