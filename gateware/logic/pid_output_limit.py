"""Exact two's-complement full-range saturation, with no carry propagation."""
from migen import If


def pid_output_limit(module, value, output):
    width = len(output)
    high = value[width - 1:]
    upper = (1 << (width - 1)) - 1
    lower = -(1 << (width - 1))
    module.comb += If(~value[-1] & (high != 0), output.eq(upper)).Elif(
        value[-1] & (high != (1 << len(high)) - 1), output.eq(lower)
    ).Else(output.eq(value[:width]))
