"""Precompute clamp thresholds on the ORIGINAL common/bound state edge.

Restricted signed D/O inputs prove the sum fits the original guard width.
No register is inserted after the original common or final output state.
"""
from migen import Array, Cat, Constant, If, Mux, Replicate, Signal
from misoc.interconnect.csr import CSRStorage
from .filter import Filter


class EarlyCommonTapLimitCSR(Filter):
    def __init__(self, width=25, guard=3, input_width=14):
        super().__init__(width=width)
        assert 2 <= input_width < width and guard >= 3
        n, shift = width + guard, width - input_width
        self.update_en = Signal(reset=1)
        self.taps = [Signal((width, True)) for _ in range(3)]
        self.common_x = Signal((input_width, True))
        self.common_offset = Signal.like(self.common_x)
        self.common_reg = Signal((input_width + 1, True))
        self.tap_select, self.invert = Signal(2), Signal()
        self.min = CSRStorage(width, reset=1 << (width-1))
        self.max = CSRStorage(width, reset=(1 << (width-1))-1)
        self.bound_min, self.bound_max = Signal((n, True)), Signal((n, True))
        self.neg_bound_min, self.neg_bound_max = Signal((n, True)), Signal((n, True))
        lo = Cat(self.min.storage, Replicate(self.min.storage[-1], guard))
        hi = Cat(self.max.storage, Replicate(self.max.storage[-1], guard))
        next_lo, next_hi = Signal((width, True)), Signal((width, True))
        self.comb += [next_lo.eq(Mux(self.update_en, self.min.storage, self.bound_min[:width])),
                      next_hi.eq(Mux(self.update_en, self.max.storage, self.bound_max[:width]))]
        self.sync += self.common_reg.eq(self.common_x + self.common_offset)

        def threshold(bound, negative=False):
            h = input_width + 2
            bh, dx, offset = [Signal((h, True)) for _ in range(3)]
            a, b, c, s0, c0, s1, c1 = [Signal(h) for _ in range(7)]
            for value in (s0, c0, s1, c1):
                value.attr.add('keep')
            self.comb += [bh.eq(bound >> shift), dx.eq(self.common_x), offset.eq(self.common_offset),
                          a.eq(~bh if negative else bh), b.eq(~dx), c.eq(~offset),
                          s0.eq(a ^ b ^ c), c0.eq(((a & b) | (a & c) | (b & c)) << 1)]
            compensation = (Cat(bound[:shift] == 0, Constant(1, 1), Constant(0, h-2))
                            if negative else Constant(2, h))
            self.comb += [s1.eq(s0 ^ c0 ^ compensation),
                          c1.eq(((s0 & c0) | (s0 & compensation) | (c0 & compensation)) << 1)]
            high = Signal((h, True))
            low = Signal(shift)
            self.comb += [high.eq(s1 + c1), low.eq(-bound[:shift] if negative else bound[:shift])]
            result = Signal((n, True))
            self.sync += result.eq(Cat(low, high, Replicate(high[-1], n-shift-h)))
            return result

        self.threshold_min = threshold(next_lo)
        self.threshold_max = threshold(next_hi)
        self.threshold_neg_max = threshold(next_hi, negative=True)
        self.threshold_neg_min = threshold(next_lo, negative=True)
        positive, negative, pos_rail, neg_rail = [], [], [], []
        for tap in self.taps:
            total = Signal((n, True))
            self.comb += total.eq(tap + (self.common_reg << shift))
            pv, nv = Signal((n, True)), Signal((n, True))
            pr, nr = Signal(), Signal()
            for value in (pv, nv, pr, nr):
                value.attr.add('keep')
            # Preserve max-first priority, including reversed/equal CSR bounds.
            self.comb += If(tap >= self.threshold_max,
                pv.eq(self.bound_max), pr.eq(1)
            ).Elif(tap <= self.threshold_min,
                pv.eq(self.bound_min), pr.eq(1)
            ).Else(pv.eq(total), pr.eq(0))
            self.comb += If(tap <= self.threshold_neg_max,
                nv.eq(self.bound_max), nr.eq(1)
            ).Elif(tap >= self.threshold_neg_min,
                nv.eq(self.bound_min), nr.eq(1)
            ).Else(nv.eq(-total), nr.eq(0))
            positive.append(pv); negative.append(nv); pos_rail.append(pr); neg_rail.append(nr)
        self.pre_y, self.pre_rail = Signal((n, True)), Signal()
        self.comb += [self.pre_y.eq(Mux(self.invert, Array(negative)[self.tap_select], Array(positive)[self.tap_select])),
                      self.pre_rail.eq(Mux(self.invert, Array(neg_rail)[self.tap_select], Array(pos_rail)[self.tap_select]))]
        self.sync += If(self.update_en,
            self.bound_min.eq(lo), self.bound_max.eq(hi),
            self.neg_bound_min.eq(-lo), self.neg_bound_max.eq(-hi),
            self.y.eq(self.pre_y), self.error.eq(self.pre_rail))
