"""Latency-aware differential against R2b with independently delayed raw inputs."""
import random

from migen import ClockDomain, Module, Signal
from migen.sim import run_simulation
from misoc.interconnect.csr_bus import CSRBank

from gateware.logic.pid import PID
from gateware.logic.pid_pipeline import PipelinedPID


FIELDS = ('kp_mult', 'output_p', 'ki_mult', 'int_sum', 'int_reg',
          'int_out', 'output_d', 'pid_sum', 'pid_out')


class Pair(Module):
    def __init__(self, width):
        self.clock_domains.cd_sys = ClockDomain('sys')
        self.submodules.reference = PID(width=width)
        self.submodules.candidate = PipelinedPID(width=width)
        self.controls = {}
        for name, size in [('input', width), ('running', 1), ('setpoint', width),
                           ('kp', 14), ('ki', 14), ('kd', 14),
                           ('reset', 1), ('update_en', 1)]:
            source, s1, s2 = Signal(size), Signal(size), Signal(size)
            self.controls[name] = source
            self.sync += [s1.eq(source), s2.eq(s1)]
            a, b = getattr(self.candidate, name), getattr(self.reference, name)
            if name in ('setpoint', 'kp', 'ki', 'kd', 'reset'):
                a, b = a.storage, b.storage
            self.comb += [a.eq(source), b.eq(s2)]


def check_differential(width):
    dut = Pair(width)
    rng = random.Random(20261109+width)
    counts = {'cycles': 0, 'enabled': 0}

    def compare(label):
        for field in FIELDS:
            a = (yield getattr(dut.reference, field))
            b = (yield getattr(dut.candidate, field))
            assert a == b, (width, label, field, a, b)
        assert (yield dut.reference.update_en) == (yield dut.candidate.execute_en)
        counts['cycles'] += 1
        counts['enabled'] += (yield dut.candidate.execute_en)

    def bench():
        for step in range(4500):
            ce = int(step < 800 or 1500 <= step < 2000 or rng.randrange(9)==0)
            # Dynamic rates include sparse CE and immediate config changes.
            if 800 <= step < 1100:
                ce = int(step % (1 << ((step//30) % 6)) == 0)
            edge = [0, 1, (1 << (width-1))-1, 1 << (width-1), (1 << width)-1]
            values = dict(input=edge[step % 5] if step < 500 else rng.getrandbits(width),
                          setpoint=edge[(step//3) % 5] if step < 500 else rng.getrandbits(width),
                          kp=rng.getrandbits(14), ki=[0,1,8191,8192,16383][(step//7)%5],
                          kd=rng.getrandbits(14), running=int(step%19 != 0),
                          reset=int(step%103==0), update_en=ce)
            for name,value in values.items():
                yield dut.controls[name].eq(value)
            # Assert while work is in flight; pending old transactions must vanish.
            yield dut.cd_sys.rst.eq(step in (320, 321, 1777, 1778, 2999))
            yield
            yield from compare(('random',step))
        yield dut.cd_sys.rst.eq(0)
        yield dut.controls['update_en'].eq(0)
        yield dut.controls['reset'].eq(0)
        for _ in range(6):
            yield
            yield from compare('drain')
        n = width+18
        upper = ((1 << (width-1))-1) << 18
        lower = -upper-1
        for initial in [upper-1,upper,upper+1,lower-1,lower,lower+1,
                        (1 << (n-1))-1,-(1 << (n-1))]:
            for polarity in (-1,1):
                yield dut.controls['update_en'].eq(0)
                for _ in range(5):
                    yield
                yield dut.reference.int_reg.eq(initial)
                yield dut.candidate.int_reg.eq(initial)
                for key,value in dict(input=polarity & ((1 << width)-1),setpoint=0,
                                      ki=16,running=1,reset=0,kp=0,kd=0).items():
                    yield dut.controls[key].eq(value)
                yield
                yield dut.controls['update_en'].eq(1)
                for step in range(12):
                    yield
                    yield from compare(('saturation',initial,polarity,step))
        print('PIPELINE_2SYS_DIFFERENTIAL_PASS width=%d cycles=%d enabled_observations=%d fields=9' %
              (width,counts['cycles'],counts['enabled']), flush=True)
        print('PIPELINE_SATURATION_RESET_CE_CONFIG_PASS width=%d' % width, flush=True)
    run_simulation(dut,bench(),clocks={'sys':8})


def check_real_csr(width):
    class DUT(Module):
        def __init__(self):
            self.submodules.pid = PipelinedPID(width=width)
            self.submodules.bank = CSRBank(self.pid.get_csrs())
    dut=DUT()
    def bench():
        yield dut.pid.update_en.eq(0)
        for _ in range(5):
            yield
        yield dut.pid.int_reg.eq(123)
        yield
        for storage,value in [(dut.pid.ki,0x2a55),(dut.pid.kp,0x1234),
                              (dut.pid.kd,0x1fff),
                              (dut.pid.setpoint,(1 << width)-1),(dut.pid.reset,1)]:
            remaining=storage.size
            for csr in storage.simple_csrs:
                remaining-=csr.size
                word=(value>>remaining)&((1 << csr.size)-1)
                yield dut.bank.bus.adr.eq(dut.bank.simple_csrs.index(csr))
                yield dut.bank.bus.dat_w.eq(word)
                yield dut.bank.bus.we.eq(1)
                yield
                yield
                yield dut.bank.bus.we.eq(0)
                yield
                yield
                assert (yield dut.bank.bus.dat_r)==word, (width,'readback',csr.name)
            assert (yield storage.storage)==value,(width,'storage',storage.name)
            assert (yield dut.pid.int_reg)==123,'CSR writes incorrectly enabled state'
        yield dut.pid.update_en.eq(1)
        for _ in range(2):
            yield
            assert (yield dut.pid.int_reg)==123,'integral reset bypassed pipeline'
        for _ in range(4):
            yield
        assert (yield dut.pid.int_reg)==0,'ordered reset token not consumed'
        print('PIPELINE_REAL_CSR_CE_HOLD_ORDERED_RESET_PASS width=%d' % width,flush=True)
    run_simulation(dut,bench(),clocks={'sys':8})


def main():
    for width in (14,25):
        check_differential(width)
        check_real_csr(width)
    print('PID_PIPELINE_SUITE_PASS',flush=True)


if __name__=='__main__':
    main()
