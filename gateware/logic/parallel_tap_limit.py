"""Parallel tap arithmetic and clamp; original LimitCSR register edges retained."""
from migen import Array, Cat, If, Mux, Replicate, Signal
from misoc.interconnect.csr import CSRStorage
from .filter import Filter
from .limit import Limit


class ParallelTapLimitCSR(Filter):
    def __init__(self, width=25, guard=3):
        super().__init__(width=width)
        self.update_en = Signal(reset=1)
        self.taps = [Signal((width, True)) for _ in range(3)]
        self.common_a = Signal((width+guard, True))
        self.common_b = Signal.like(self.common_a)
        self.tap_select, self.invert = Signal(2), Signal()
        self.min = CSRStorage(width, reset=1 << (width-1))
        self.max = CSRStorage(width, reset=(1 << (width-1))-1)
        self.bound_min = Signal((width+guard, True))
        self.bound_max = Signal.like(self.bound_min)
        positive, negative, pos_rail, neg_rail = [], [], [], []
        for tap in self.taps:
            total = Signal((width+guard, True))
            self.comb += total.eq(tap+self.common_a+self.common_b)
            for invert, values, rails in ((False,positive,pos_rail),(True,negative,neg_rail)):
                limiter = Limit(width+guard)
                self.submodules += limiter
                # Preserve the intended parallel clamp structure through synthesis.
                limiter.y.attr.add('keep'); limiter.railed.attr.add('keep')
                self.comb += [limiter.x.eq(-total if invert else total),
                              limiter.min.eq(self.bound_min),limiter.max.eq(self.bound_max)]
                values.append(limiter.y); rails.append(limiter.railed)
        self.pre_y = Signal((width+guard, True))
        self.pre_rail = Signal()
        # Migen Array retains the original out-of-range selector=3 -> last tap.
        self.comb += [self.pre_y.eq(Mux(self.invert,Array(negative)[self.tap_select],Array(positive)[self.tap_select])),
                      self.pre_rail.eq(Mux(self.invert,Array(neg_rail)[self.tap_select],Array(pos_rail)[self.tap_select]))]
        lo = Cat(self.min.storage,Replicate(self.min.storage[-1],guard))
        hi = Cat(self.max.storage,Replicate(self.max.storage[-1],guard))
        self.sync += If(self.update_en,
            self.bound_min.eq(lo),self.bound_max.eq(hi),
            self.y.eq(self.pre_y),self.error.eq(self.pre_rail))
