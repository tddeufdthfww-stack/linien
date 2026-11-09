"""Two-cycle, full-throughput PID frontend; R2b PID remains the reference.

Every accepted sample, including its gains and integral-reset bit, commits two
sys clocks later. Global reset cancels pending samples. No accumulator feedback
register is added. See docs/R4_PLAN.md for the precise latency contract.
"""
from migen import If, Signal
from misoc.interconnect.csr import CSRStorage

from .pid import PID


class PipelinedPID(PID):
    def __init__(self, width=14, coeff_width=14):
        self.error_s1 = Signal((width + 1, True))
        # Preserve the shared frontend FFs instead of absorbing them into DSP
        # AREGs; this is a placement experiment, with identical cycle behavior.
        self.error_s1.attr.add(("KEEP", "TRUE"))
        self.kp_s1 = Signal((coeff_width, True))
        self.ki_s1 = Signal((coeff_width, True))
        self.kd_s1 = Signal((coeff_width, True))
        self.reset_s1 = Signal()
        self.reset_s2 = Signal()
        self.valid_s1 = Signal()
        self.valid_s2 = Signal()
        super().__init__(width, coeff_width)
        # The inherited recurrence/sum statements retain this exact signal.
        self.execute_en = self.update_en
        # Public CE accepts samples; execution CE is its two-clock delayed valid.
        self.update_en = Signal(reset=1)
        self.comb += self.execute_en.eq(self.valid_s2)
        self.sync += [
            self.valid_s1.eq(self.update_en),
            self.valid_s2.eq(self.valid_s1),
            self.error_s1.eq(self.error),
            self.kp_s1.eq(self.kp.storage),
            self.ki_s1.eq(self.ki.storage),
            self.kd_s1.eq(self.kd.storage),
            self.reset_s1.eq(self.reset.storage),
            self.reset_s2.eq(self.reset_s1),
        ]

    def calculate_p(self):
        self.kp = CSRStorage(self.coeff_width)
        self.kp_mult = Signal((self.width + self.coeff_width, True))
        self.sync += self.kp_mult.eq(self.error_s1 * self.kp_s1)
        self.output_p = Signal((self.width, True))
        self.comb += self.output_p.eq(self.kp_mult >> (self.coeff_width - 2))

    def calculate_i(self):
        self.ki = CSRStorage(self.coeff_width)
        self.reset = CSRStorage()
        self.ki_mult = Signal((1 + self.width + self.coeff_width, True))
        self.sync += self.ki_mult.eq((self.error_s1 * self.ki_s1) >> 4)
        int_reg_width = self.width + self.coeff_width + 4
        extra_width = int_reg_width - self.width
        self.int_reg = Signal((int_reg_width, True))
        self.int_sum = Signal((int_reg_width + 1, True))
        self.int_out = Signal((self.width, True))
        self.comb += [self.int_sum.eq(self.ki_mult + self.int_reg),
                      self.int_out.eq(self.int_reg >> extra_width)]
        upper = self.max_pos << extra_width
        lower = -upper - 1
        overflow_pos, overflow_neg = Signal(), Signal()
        low = self.int_sum[:extra_width]
        middle = self.int_sum[extra_width:-2]
        # Exact R2b boundary decode; no truncation of the N+1-bit sum.
        self.comb += [
            overflow_pos.eq(~self.int_sum[-1] &
                (self.int_sum[-2] | ((middle == (1 << (self.width-1))-1) & (low != 0)))),
            overflow_neg.eq(self.int_sum[-1] &
                (~self.int_sum[-2] | ((middle == 0) & (low != (1 << extra_width)-1)))),
        ]
        self.sync += If(self.update_en,
            If(self.reset_s2, self.int_reg.eq(0))
            .Elif(overflow_pos, self.int_reg.eq(upper))
            .Elif(overflow_neg, self.int_reg.eq(lower))
            .Else(self.int_reg.eq(self.int_sum)))

    def calculate_d(self):
        self.d_shift = 6
        mult_width = self.coeff_width + self.width + 2
        out_width = mult_width - self.coeff_width + self.d_shift + 1
        self.kd = CSRStorage(self.coeff_width)
        self.kd_mult = Signal((mult_width, True))
        self.sync += self.kd_mult.eq(self.error_s1 * self.kd_s1)
        self.kd_reg = Signal((out_width, True))
        self.kd_reg_r = Signal((out_width, True))
        self.output_d = Signal((out_width, True))
        self.sync += If(self.update_en,
            self.kd_reg.eq(self.kd_mult >> (self.coeff_width - self.d_shift)),
            self.kd_reg_r.eq(self.kd_reg),
            self.output_d.eq(self.kd_reg - self.kd_reg_r))
