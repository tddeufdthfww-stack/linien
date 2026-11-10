"""Same-edge CSR encoding and data-register relocation; no extra sample stage."""
from migen import Cat, Constant, ClockSignal, If, Instance, Module, Replicate, ResetSignal, Signal
from misoc.interconnect.csr import CSRStorage


class MixerFactorCSR(CSRStorage):
    """Keep the original unsigned 9-bit ABI; export the actual low-byte write."""
    def __init__(self, name):
        super().__init__(9, reset=128, name=name)
        self.encoded_low_data = Signal(8)
        self.encoded_low_write = Signal()

    def do_finalize(self, busword):
        assert busword == 8 and not self.atomic_write
        super().do_finalize(busword)
        low = self.simple_csrs[-1]
        assert low.size == 8
        self.comb += [self.encoded_low_data.eq(low.r ^ 128),
                      self.encoded_low_write.eq(low.re)]


class RegisteredErrorMixer(Module):
    """F*X = signed8(F_low-128)*X + (F_high ? 3*X : X)*128.

    AREG copies the existing FastChain output FF on the same edge, from its D
    and CE. BREG copies an encoded CSR low byte on the same CSR write edge.
    DSP resets to zero, matching data=0 and F=128 (encoded low=0).
    """
    def __init__(self, product_pipeline=False):
        self.a, self.b = Signal((25, True)), Signal((25, True))
        self.pre_a, self.pre_b = Signal((25, True)), Signal((25, True))
        self.ce_a, self.ce_b = Signal(reset=1), Signal(reset=1)
        self.high_a, self.high_b = Signal(), Signal()
        self.low_a, self.low_b = Signal(8), Signal(8)
        self.write_a, self.write_b = Signal(), Signal()
        self.offset = Signal((14, True))
        self.dual = Signal()
        self.y = Signal((37, True))
        operands = []
        for data, pre, ce, high, low, write in (
            (self.a, self.pre_a, self.ce_a, self.high_a, self.low_a, self.write_a),
            (self.b, self.pre_b, self.ce_b, self.high_b, self.low_b, self.write_b),
        ):
            p = Signal((48, True))
            kwargs = dict(p_AREG=1, p_ACASCREG=1, p_BREG=1, p_BCASCREG=1,
                          p_ADREG=0, p_MREG=int(product_pipeline), p_PREG=0, p_CREG=0, p_DREG=0,
                          p_ALUMODEREG=0, p_CARRYINREG=0, p_CARRYINSELREG=0,
                          p_INMODEREG=0, p_OPMODEREG=0,
                          p_A_INPUT="DIRECT", p_B_INPUT="DIRECT",
                          p_USE_DPORT="FALSE", p_USE_MULT="MULTIPLY", p_USE_SIMD="ONE48",
                          i_A=Cat(pre, Replicate(pre[-1], 5)),
                          i_B=Cat(low, Replicate(low[-1], 10)), o_P=p,
                          i_CLK=ClockSignal(), i_CEA2=ce, i_CEB2=write,
                          i_RSTA=ResetSignal(), i_RSTB=ResetSignal(),
                          i_OPMODE=Constant(5,7), i_ALUMODE=Constant(0,4), i_INMODE=Constant(0,5), i_CARRYINSEL=Constant(0,3))
            for name in ('ACIN', 'BCIN', 'C', 'D', 'PCIN', 'CARRYCASCIN', 'CARRYIN',
                         'MULTSIGNIN', 'CEA1', 'CEB1', 'CEAD', 'CEALUMODE', 'CEC',
                         'CECARRYIN', 'CECTRL', 'CED', 'CEINMODE', 'CEM', 'CEP',
                         'RSTALLCARRYIN', 'RSTALUMODE', 'RSTC', 'RSTCTRL', 'RSTD',
                         'RSTINMODE', 'RSTM', 'RSTP'):
                kwargs['i_' + name] = Constant(int(product_pipeline) if name == 'CEM' else 0, {'ACIN':30,'BCIN':18,'C':48,'D':25,'PCIN':48}.get(name,1))
            self.specials += Instance('DSP48E1', **kwargs)
            product = Signal((37, True))
            triple = Signal((27, True))
            bias = Signal((37, True))
            self.comb += [product.eq(p), triple.eq(data + (data << 1)),
                          If(high, bias.eq(triple << 7)).Else(bias.eq(data << 7))]
            if product_pipeline:
                bias_cohort = Signal.like(bias)
                self.sync += bias_cohort.eq(bias)
                bias = bias_cohort
            operands += [product, bias]
        off = Signal((37, True))
        self.comb += off.eq(self.offset << 19)
        selected_a, selected_dual = self.a, self.dual
        if product_pipeline:
            off_cohort = Signal.like(off)
            a_cohort = Signal.like(self.a)
            dual_cohort = Signal()
            self.sync += [off_cohort.eq(off),a_cohort.eq(self.a),dual_cohort.eq(self.dual)]
            off,selected_a,selected_dual = off_cohort,a_cohort,dual_cohort
        operands.append(off)
        while len(operands) > 2:
            u, v, w = operands[:3]
            total, carry = Signal(37), Signal(37)
            self.comb += [total.eq(u ^ v ^ w),
                          carry.eq(((u & v) | (u & w) | (v & w)) << 1)]
            operands = operands[3:] + [total, carry]
        merged = Signal((37, True))
        self.comb += [merged.eq(operands[0] + operands[1]),
                      If(selected_dual, self.y.eq(merged)).Else(
                          self.y.eq((selected_a << 8) + off))]
