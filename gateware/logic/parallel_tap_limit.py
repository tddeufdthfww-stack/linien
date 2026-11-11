"""Parallel tap arithmetic and clamp; original LimitCSR register edges retained."""
from migen import Array, Cat, If, Mux, Replicate, Signal
from misoc.interconnect.csr import CSRStorage
from .filter import Filter
from .limit import Limit


class ParallelTapLimitCSR(Filter):
    def __init__(self, width=25, guard=3):
        super().__init__(width=width)
        assert guard > 0
        self.update_en = Signal(reset=1)
        self.taps = [Signal((width, True)) for _ in range(3)]
        self.common_a = Signal((width+guard, True))
        self.common_b = Signal.like(self.common_a)
        self.tap_select, self.invert = Signal(2), Signal()
        self.min = CSRStorage(width, reset=1 << (width-1))
        self.max = CSRStorage(width, reset=(1 << (width-1))-1)
        self.bound_min = Signal((width+guard, True))
        self.bound_max = Signal.like(self.bound_min)
        self.neg_bound_min = Signal.like(self.bound_min)
        self.neg_bound_max = Signal.like(self.bound_max)
        common_sum = Signal((width+guard, True))
        self.comb += common_sum.eq(self.common_a+self.common_b)
        positive, negative, pos_rail, neg_rail = [], [], [], []
        for tap in self.taps:
            total = Signal((width+guard, True))
            self.comb += total.eq(tap+common_sum)
            limiter = Limit(width+guard)
            self.submodules += limiter
            limiter.y.attr.add('keep');limiter.railed.attr.add('keep')
            self.comb += [limiter.x.eq(total),limiter.min.eq(self.bound_min),limiter.max.eq(self.bound_max)]
            positive.append(limiter.y);pos_rail.append(limiter.railed)
            neg_value = Signal((width+guard, True));neg_rail_value=Signal()
            neg_value.attr.add('keep');neg_rail_value.attr.add('keep')
            self.comb += If(total == -(1 << (width+guard-1)),
                neg_value.eq(self.bound_min),neg_rail_value.eq(1)
            ).Elif(total <= self.neg_bound_max,
                neg_value.eq(self.bound_max),neg_rail_value.eq(1)
            ).Elif(total >= self.neg_bound_min,
                neg_value.eq(self.bound_min),neg_rail_value.eq(1)
            ).Else(neg_value.eq(-total),neg_rail_value.eq(0))
            negative.append(neg_value);neg_rail.append(neg_rail_value)
        self.pre_y = Signal((width+guard, True))
        self.pre_rail = Signal()
        # Migen Array retains the original out-of-range selector=3 -> last tap.
        self.comb += [self.pre_y.eq(Mux(self.invert,Array(negative)[self.tap_select],Array(positive)[self.tap_select])),
                      self.pre_rail.eq(Mux(self.invert,Array(neg_rail)[self.tap_select],Array(pos_rail)[self.tap_select]))]
        lo = Cat(self.min.storage,Replicate(self.min.storage[-1],guard))
        hi = Cat(self.max.storage,Replicate(self.max.storage[-1],guard))
        self.sync += If(self.update_en,
            self.bound_min.eq(lo),self.bound_max.eq(hi),
            self.neg_bound_min.eq(-lo),self.neg_bound_max.eq(-hi),
            self.y.eq(self.pre_y),self.error.eq(self.pre_rail))
