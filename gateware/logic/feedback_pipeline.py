"""Configurable mixer-frame alignment; PID recurrence and CSR ABI are unchanged."""
from migen import Cat, If, Module, Mux, Replicate, Signal
from misoc.interconnect.csr import CSRStorage
from .filter import Filter
from .limit import Limit
from .pid import PID
from .pid_pipeline import PipelinedPID


class MixerAlignedPID(PipelinedPID):
    """PipelinedPID receiving data already delayed frame_delay cycles by the frontend.

    Public CSR storage/running/CE are current; the corresponding sample controls
    are shifted frame_delay sys clocks. P/I/D then retain the R4 two-stage frontend.
    """
    def __init__(self, width=14, coeff_width=14, frame_delay=1):
        assert frame_delay in (1,2)
        self.error_s1 = Signal((width+1, True))
        self.kp_s1, self.ki_s1, self.kd_s1 = [Signal((coeff_width, True)) for _ in range(3)]
        self.reset_s1, self.reset_s2 = Signal(), Signal()
        self.valid_s1, self.valid_s2 = Signal(), Signal()
        self.setpoint_cohort = Signal(width)
        self.running_cohort = Signal()
        self.kp_cohort, self.ki_cohort, self.kd_cohort = [Signal(coeff_width) for _ in range(3)]
        self.reset_cohort, self.valid_cohort = Signal(), Signal()
        # Calls inherited P/I/D implementations, with exactly the original widths.
        PID.__init__(self, width, coeff_width)
        self.execute_en = self.update_en
        self.update_en = Signal(reset=1)
        self.comb += self.execute_en.eq(self.valid_s2)
        for target, source in ((self.setpoint_cohort,self.setpoint.storage),
                (self.running_cohort,self.running),(self.kp_cohort,self.kp.storage),
                (self.ki_cohort,self.ki.storage),(self.kd_cohort,self.kd.storage),
                (self.reset_cohort,self.reset.storage),(self.valid_cohort,self.update_en)):
            for _ in range(frame_delay-1):
                q=Signal.like(target); self.sync += q.eq(source); source=q
            self.sync += target.eq(source)
        self.sync += [
            self.valid_s1.eq(self.valid_cohort), self.valid_s2.eq(self.valid_s1),
            self.error_s1.eq(self.error),
            self.kp_s1.eq(self.kp_cohort), self.ki_s1.eq(self.ki_cohort),
            self.kd_s1.eq(self.kd_cohort),
            self.reset_s1.eq(self.reset_cohort), self.reset_s2.eq(self.reset_s1),
        ]

    def calculate_error_signal(self):
        self.setpoint = CSRStorage(self.width)
        self.error = Signal((self.width+1, True))
        # Original unsigned setpoint arithmetic, including W+1-bit wrap, retained.
        self.comb += If(self.running_cohort,
            self.error.eq(self.input-self.setpoint_cohort)).Else(self.error.eq(0))


class AlignedInputLimitCSR(Filter):
    """Original LimitCSR, with frame_delay-cycle CSR-bound transport before its old FFs.

    update_en is execution CE (already aligned by FeedbackInputAlignment).
    CSR writes are not gated. Original internal bound/y/error FFs remain.
    """
    def __init__(self, guard=0, frame_delay=1, **kwargs):
        assert frame_delay in (1,2)
        super().__init__(**kwargs)
        self.update_en = Signal(reset=1)
        width = len(self.y)
        self.min = CSRStorage(width, reset=1 << (width-1))
        self.max = CSRStorage(width, reset=(1 << (width-1))-1)
        if guard:
            self.x = Signal((width+guard, True))
        self.submodules.limit = Limit(width+guard)
        lo = Signal(width, reset=1 << (width-1))
        hi = Signal(width, reset=(1 << (width-1))-1)
        low_source, high_source = self.min.storage, self.max.storage
        for _ in range(frame_delay-1):
            lq=Signal.like(lo); hq=Signal.like(hi)
            self.sync += [lq.eq(low_source), hq.eq(high_source)]
            low_source, high_source = lq, hq
        self.sync += [lo.eq(low_source), hi.eq(high_source)]
        low_value = Cat(lo, Replicate(lo[-1],guard)) if guard else lo
        high_value = Cat(hi, Replicate(hi[-1],guard)) if guard else hi
        self.comb += self.limit.x.eq(self.x)
        self.sync += If(self.update_en,
            self.limit.min.eq(low_value), self.limit.max.eq(high_value),
            self.y.eq(self.limit.y), self.error.eq(self.limit.railed))


class FeedbackInputAlignment(Module):
    """Align direct ADC/mode with pipelined mixed error, no extra output FF."""
    def __init__(self, width=14, signal_width=25, frame_delay=1):
        assert frame_delay in (1,2)
        self.direct_adc = Signal((width,True))
        self.mixed_error = Signal((signal_width,True))
        self.pid_only = Signal()
        self.limit_accept_en = Signal(reset=1)
        self.limit_execute_en = Signal()
        self.output = Signal((signal_width,True))
        adc_cohort = Signal.like(self.direct_adc)
        mode_cohort = Signal()
        for target, source in ((adc_cohort,self.direct_adc),(mode_cohort,self.pid_only),
                               (self.limit_execute_en,self.limit_accept_en)):
            for _ in range(frame_delay-1):
                q=Signal.like(target); self.sync += q.eq(source); source=q
            self.sync += target.eq(source)
        self.comb += self.output.eq(Mux(mode_cohort,
            adc_cohort << (signal_width-width), self.mixed_error))
