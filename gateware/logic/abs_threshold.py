"""Exact finite-width abs(value)>=threshold without serial absolute-value carry.

threshold may be negative (finite abs of its own minimum). negative_threshold
must be its exact wider signed negation captured on the SAME cohort edge.
"""
from migen import Mux

def signed_abs_over_threshold(module,value,threshold,negative_threshold,out):
    assert len(value)==len(negative_threshold)>len(threshold)
    # Minimum negative wraps to itself under finite-width abs: use its original
    # signed comparison. Keeping that comparison also preserves X propagation.
    use_negative = value[-1] & (value != -(1 << (len(value)-1)))
    module.comb += out.eq(Mux(use_negative,value<=negative_threshold,value>=threshold))
