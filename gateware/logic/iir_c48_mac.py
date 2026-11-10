"""Exact 50-bit MAC via 48-bit DSP MAC and signed overflow compensation.

No register is added. x,c are signed25, z/result signed50. All arithmetic below
is finite-width and must be tested at the signed48 wrap boundaries.
"""
from migen import Cat,Constant,Signal


def split_c48_mac(module,z,x,c):
    assert len(z)==50 and len(x)==len(c)==25
    xlo=Signal((18,True));xhi=Signal((8,True))
    zlo=Signal((48,True));ztop=Signal((2,True))
    low=Signal((48,True));high=Signal((48,True))
    low.attr.add(('use_dsp','yes'));high.attr.add(('use_dsp','yes'))
    positive_overflow,negative_overflow=Signal(),Signal()
    correction=Signal((4,True));top=Signal(2)
    result=Signal((50,True))
    module.comb += [
        xlo.eq(Cat(x[:17],Constant(0,1))),xhi.eq(x[17:]),
        zlo.eq(z[:48]),ztop.eq(z[48:]),
        low.eq(c*xlo+zlo),
        high.eq(c*xhi+(low>>17)),
        positive_overflow.eq(~zlo[-1] & ~c[-1] & low[-1]),
        negative_overflow.eq(zlo[-1] & c[-1] & ~low[-1]),
        correction.eq(ztop+zlo[-1]+positive_overflow-negative_overflow),
        top.eq(high[31:33]+correction),
        result.eq(Cat(low[:17],high[:31],top)),
    ]
    return result
