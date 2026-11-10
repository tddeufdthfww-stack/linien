"""Modulo-width five-input sum, no state or extra feedback cycle."""
from migen import Signal


def fast_output_sum(module, output, inputs):
    width = len(output)
    operands = []
    for value in inputs:
        extended = Signal((width, True))
        module.comb += extended.eq(value)
        operands.append(extended)
    while len(operands) > 2:
        a, b, c = operands[:3]
        total, carry = Signal(width), Signal(width)
        module.comb += [total.eq(a ^ b ^ c),
                        carry.eq(((a & b) | (a & c) | (b & c)) << 1)]
        operands = operands[3:] + [total, carry]
    module.comb += output.eq(operands[0] + operands[1])
