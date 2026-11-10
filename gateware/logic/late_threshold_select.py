"""Commute a pure signed predicate with its instruction-table selection."""
from migen import Array, Signal
from .abs_threshold import signed_abs_over_threshold


def late_threshold_select(module, value, thresholds, negative_thresholds, index, out):
    assert len(thresholds) == len(negative_thresholds)
    predicates = []
    for threshold, negative in zip(thresholds, negative_thresholds):
        result = Signal()
        # Keep the predicate boundary; avoid remapping to wide-select then compare.
        result.attr.add('keep')
        signed_abs_over_threshold(module, value, threshold, negative, result)
        predicates.append(result)
    module.comb += out.eq(Array(predicates)[index])
