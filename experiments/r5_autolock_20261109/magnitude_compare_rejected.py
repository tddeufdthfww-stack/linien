"""Exact legacy signed-absolute-value threshold, with parallel add/subtract."""
from migen import Module, Mux, Signal


class SignedMagnitudeGE(Module):
    def __init__(self, value_width, threshold_width):
        # SumDiffCalculator has one more bit than its peak-height CSR.
        assert value_width == threshold_width + 1
        self.value = Signal((value_width, True))
        self.threshold = Signal((threshold_width, True))
        self.match = Signal()
        difference = Signal((value_width + 1, True))
        total = Signal((value_width + 1, True))
        self.comb += [difference.eq(self.value - self.threshold),
                      total.eq(self.value + self.threshold)]
        same_sign = self.value[-1] == self.threshold[-1]
        normal = Mux(same_sign,
                     Mux(self.value[-1], difference <= 0, difference >= 0),
                     Mux(self.value[-1], total <= 0, total >= 0))
        self.comb += self.match.eq(
            (self.value != -(1 << (value_width-1)))
            & ((self.threshold == -(1 << (threshold_width-1))) | normal))
