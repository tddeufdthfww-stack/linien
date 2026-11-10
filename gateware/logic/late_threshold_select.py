"""Eight predicate lanes: 4-way wide select, then 8-way one-bit select."""
from migen import Array, Case, Signal
from .abs_threshold import signed_abs_over_threshold


def late_threshold_select(module, value, thresholds, negative_thresholds, index, out):
    assert len(thresholds) == len(negative_thresholds) == 32
    assert len(index) == 5
    predicates = []
    for lane in range(8):
        threshold = Signal.like(thresholds[0])
        negative = Signal.like(negative_thresholds[0])
        module.comb += [
            threshold.eq(Array(thresholds[lane::8])[index[3:]]),
            negative.eq(Array(negative_thresholds[lane::8])[index[3:]]),
        ]
        result = Signal()
        # Keep only these eight predicate boundaries, not source/control FFs.
        result.attr.add('keep')
        signed_abs_over_threshold(module, value, threshold, negative, result)
        predicates.append(result)
    # A full-index default preserves the original Migen Array behavior for X/Z
    # in any index bit. Binary hardware uses the eight-lane low-index selector.
    fallback = Signal()
    signed_abs_over_threshold(module, value, thresholds[-1], negative_thresholds[-1], fallback)
    cases = {i: out.eq(predicates[i % 8]) for i in range(32)}
    cases['default'] = out.eq(fallback)
    module.comb += Case(index, cases)
