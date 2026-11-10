"""Two-clock slow transaction transport; accumulator recurrence is unchanged."""
from linien_common.common import OutputChannel
from migen import Cat, If, Module, Mux, Replicate, Signal
from misoc.interconnect.csr import AutoCSR, CSRStorage
from .filter import Filter
from .limit import Limit
from .pid_pipeline import PipelinedPID


class AlignedSlowLimitCSR(Filter):
    """CSR writes remain live. Apply each sample's original bounds two clocks later."""
    def __init__(self, width=14, guard=5):
        super().__init__(width=width)
        self.update_en = Signal(reset=1)
        self.min = CSRStorage(width, reset=1 << (width-1))
        self.max = CSRStorage(width, reset=(1 << (width-1))-1)
        self.x = Signal((width+guard, True))
        self.submodules.limit = Limit(width+guard)
        minimum_s1 = Signal(width, reset=1 << (width-1))
        minimum_s2 = Signal.like(minimum_s1)
        maximum_s1 = Signal(width, reset=(1 << (width-1))-1)
        maximum_s2 = Signal.like(maximum_s1)
        self.sync += [minimum_s1.eq(self.min.storage), minimum_s2.eq(minimum_s1),
                      maximum_s1.eq(self.max.storage), maximum_s2.eq(maximum_s1)]
        self.comb += self.limit.x.eq(self.x)
        self.sync += If(self.update_en,
            self.limit.min.eq(Cat(minimum_s2,Replicate(minimum_s2[-1],guard))),
            self.limit.max.eq(Cat(maximum_s2,Replicate(maximum_s2[-1],guard))),
            self.y.eq(self.limit.y), self.error.eq(self.limit.railed))


class PipelinedSlowChain(Module, AutoCSR):
    """Original SlowChain at a two-sys-clock shifted sample/config timeline."""
    def __init__(self, width=14, signal_width=25):
        self.input = Signal((width,True))
        self.output = Signal((width,True))
        self.update_en = Signal(reset=1)
        out = Signal((signal_width,True))
        self.state_in,self.state_out,self.signal_in = [],[],[]
        self.signal_out = [out]
        # Keep the original SlowChain PID default width=14, including for width !=14.
        self.submodules.pid = PipelinedPID()
        self.submodules.limit = AlignedSlowLimitCSR(width=width,guard=5)
        self.comb += [self.pid.update_en.eq(self.update_en),
                      self.limit.update_en.eq(self.pid.execute_en),
                      self.pid.input.eq(self.input),self.output.eq(self.pid.pid_out),
                      out.eq(self.limit.y << (signal_width-width))]


class SlowOutputTransport(Module):
    """Retiming only slow contributions; fast PID/sweep/modulation stay in place."""
    def __init__(self,width=14):
        self.slow_channel = Signal(2)
        self.sweep_channel = Signal(2)
        self.sweep = Signal((width,True))
        self.offset = Signal((width,True))
        self.slow_pid = Signal((width,True))
        self.aligned_slow_channel = Signal(2)
        self.analog_out = Signal((width+3,True))
        channel_s1 = Signal(2)
        sweep_s1,sweep_s2 = Signal((width+3,True)),Signal((width+3,True))
        contribution = Signal((width+3,True))
        self.comb += contribution.eq(Mux(self.sweep_channel == OutputChannel.ANALOG_OUT0,
                                        self.sweep+self.offset,0))
        self.sync += [channel_s1.eq(self.slow_channel),self.aligned_slow_channel.eq(channel_s1),
                      sweep_s1.eq(contribution),sweep_s2.eq(sweep_s1)]
        self.comb += self.analog_out.eq(sweep_s2+Mux(
            self.aligned_slow_channel == OutputChannel.ANALOG_OUT0,self.slow_pid,0))
