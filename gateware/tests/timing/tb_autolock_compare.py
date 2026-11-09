"""R5 arithmetic oracle and full same-cycle robust-autolock differential."""
import importlib.util
from pathlib import Path
import random

from migen import ClockDomain, If, Module, Signal
from migen.sim import run_simulation

from gateware.logic.autolock import RobustAutolock
from gateware.logic.magnitude_compare import SignedMagnitudeGE


class LegacyMagnitudeGE(Module):
    def __init__(self, n, m):
        self.value = Signal((n, True))
        self.threshold = Signal((m, True))
        self.match = Signal()
        ax, ah = Signal((n, True)), Signal((m, True))
        self.comb += [If(self.value >= 0, ax.eq(self.value)).Else(ax.eq(-1*self.value)),
                      If(self.threshold >= 0, ah.eq(self.threshold)).Else(ah.eq(-1*self.threshold)),
                      self.match.eq(ax >= ah)]


def signed(v, bits):
    v &= (1 << bits)-1
    return v-(1 << bits) if v & (1 << (bits-1)) else v


def check_predicate(n, m, exhaustive=False):
    dut = Module()
    dut.submodules.reference = ref = LegacyMagnitudeGE(n, m)
    dut.submodules.candidate = new = SignedMagnitudeGE(n, m)
    if exhaustive:
        vectors = [(a,b) for a in range(1 << n) for b in range(1 << m)]
    else:
        rng = random.Random(20261109)
        xs = [0,1,-1,-2,2,-(1 << (n-1)),-(1 << (n-1))+1,(1 << (n-1))-1,
              -(1 << (m-1)),-(1 << (m-1))+1,(1 << (m-1))-1]
        hs = [0,1,-1,-2,2,-(1 << (m-1)),-(1 << (m-1))+1,(1 << (m-1))-1]
        vectors = [(x,h) for x in xs for h in hs]
        for h in hs:
            vectors += [(x,h) for x in [abs(h)-1,abs(h),abs(h)+1,-abs(h)-1,-abs(h),-abs(h)+1]]
        vectors += [(rng.getrandbits(n),rng.getrandbits(m)) for _ in range(14000)]
    def bench():
        for step,(xraw,hraw) in enumerate(vectors):
            x,h = signed(xraw,n),signed(hraw,m)
            expected = int(signed(abs(x),n) >= signed(abs(h),m))
            for c in (ref,new):
                yield c.value.eq(xraw)
                yield c.threshold.eq(hraw)
            yield
            a,b = (yield ref.match),(yield new.match)
            assert a==b==expected,(n,m,step,x,h,expected,a,b)
        print('MAGNITUDE_LEGACY_ORACLE_PASS n=%d m=%d cases=%d exhaustive=%s' %
              (n,m,len(vectors),exhaustive),flush=True)
    run_simulation(dut,bench(),clocks={'sys':8})


def check_robust():
    path=Path(__file__).resolve().parents[3]/'experiments/r5_autolock_20261109/autolock_reference.py'
    spec=importlib.util.spec_from_file_location('gateware.logic.autolock_r4a_reference',path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    dut=Module();dut.clock_domains.cd_sys=ClockDomain('sys')
    # Keep actual 29/28-bit production arithmetic, shrink only memory depth.
    dut.submodules.reference = ref = module.RobustAutolock(width=14,N_points=16383,max_delay=127)
    dut.submodules.candidate = new = RobustAutolock(width=14,N_points=16383,max_delay=127)
    rng=random.Random(125001)
    hits={0:0,1:0};transitions=0
    def bench():
        nonlocal transitions
        for step in range(4200):
            yield dut.cd_sys.rst.eq(step in (997,998,2901))
            values=dict(input=signed(rng.getrandbits(14),14),request_lock=int(step%173<150),
                        at_start=int(step%97==0),writing_data_now=int(step%7!=0),sweep_up=int(step%211<190))
            for c in (ref,new):
                for k,v in values.items():yield getattr(c,k).eq(v)
                yield c.time_scale.storage.eq([0,1,2,7,31,127,128,16383][(step//53)%8])
                yield c.N_instructions.storage.eq((step//73)%len(c.peak_heights))
                yield c.final_wait_time.storage.eq((step//101)%13)
                idx=(step//11)%len(c.peak_heights)
                peak=[0,1,-1,-(1 << 27),(1 << 27)-1,150,-200][(step//29)%7]
                yield c.peak_heights[idx].storage.eq(peak)
                yield c.wait_for[idx].storage.eq((step//17)%23)
            yield
            for i,(a,b) in enumerate(zip(ref.state_out,new.state_out)):
                assert (yield a)==(yield b),('state_out',step,i)
            for field in ('current_instruction_idx','turn_on_lock'):
                assert (yield getattr(ref,field))==(yield getattr(new,field)),(field,step)
            for field in ('sum_value','output'):
                assert (yield getattr(ref.sum_diff_calculator,field))==(yield getattr(new.sum_diff_calculator,field)),(field,step)
            hits[(yield new.state_out[3])]+=1
            transitions+=int((yield new.current_instruction_idx)!=0)
        assert hits[0] and hits[1] and transitions,('coverage',hits,transitions)
        print('ROBUST_AUTOLOCK_SAME_CYCLE_PASS cycles=4200 arithmetic=29/28 memory_depth=127 over_threshold=%s nonzero_instruction_cycles=%d' % (hits,transitions),flush=True)
    run_simulation(dut,bench(),clocks={'sys':8})


def main():
    check_predicate(6,5,True)
    check_predicate(8,7,True)
    check_predicate(29,28)
    check_robust()
    print('AUTOLOCK_COMPARE_SUITE_PASS',flush=True)


if __name__=='__main__':main()
