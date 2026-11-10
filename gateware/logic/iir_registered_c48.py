"""Move an existing 50-bit IIR MAC state edge into the high DSP PREG.

The return is register(z+c*x), never an additional filter pipeline edge.
Caller must replace an existing state register with this function.
"""
from migen import Cat,ClockSignal,Constant,Instance,Replicate,ResetSignal,Signal


def registered_c48_mac(module,z,x,c):
    assert len(z)==50 and len(x)==len(c)==25
    low=Signal((48,True));cascade=Signal(48);high_q=Signal((48,True))
    for high in (False,True):
        b=Cat(x[17:],Replicate(x[-1],10)) if high else Cat(x[:17],Constant(0,1))
        kw=dict(p_AREG=0,p_ACASCREG=0,p_BREG=0,p_BCASCREG=0,p_CREG=0,
                p_MREG=0,p_PREG=int(high),p_ADREG=0,p_DREG=0,
                p_ALUMODEREG=0,p_CARRYINREG=0,p_CARRYINSELREG=0,
                p_INMODEREG=0,p_OPMODEREG=0,p_A_INPUT="DIRECT",p_B_INPUT="DIRECT",
                p_USE_DPORT="FALSE",p_USE_MULT="MULTIPLY",p_USE_SIMD="ONE48",
                i_CLK=ClockSignal(),i_A=Cat(c,Replicate(c[-1],5)),i_B=b,
                i_C=Constant(0,48) if high else z[:48],
                i_PCIN=cascade if high else Constant(0,48),
                i_OPMODE=Constant(0x65 if high else 0x35,7),
                i_ALUMODE=Constant(0,4),i_INMODE=Constant(0,5),i_CARRYINSEL=Constant(0,3),
                o_P=high_q if high else low)
        if not high:kw['o_PCOUT']=cascade
        for name in ('ACIN','BCIN','D','CARRYCASCIN','CARRYIN','MULTSIGNIN',
                     'CEA1','CEA2','CEB1','CEB2','CEAD','CEALUMODE','CEC','CECARRYIN',
                     'CECTRL','CED','CEINMODE','CEM','CEP','RSTA','RSTB','RSTALLCARRYIN',
                     'RSTALUMODE','RSTC','RSTCTRL','RSTD','RSTINMODE','RSTM','RSTP'):
            kw['i_'+name]=ResetSignal() if name=='RSTP' and high else Constant(int(name=='CEP' and high),{'ACIN':30,'BCIN':18,'D':25}.get(name,1))
        module.specials += Instance('DSP48E1',**kw)
    positive,negative=Signal(),Signal()
    correction=Signal((4,True));correction_q=Signal.like(correction)
    low_q=Signal(17);top=Signal(2);result=Signal((50,True))
    zlo=Signal((48,True));ztop=Signal((2,True))
    module.comb += [zlo.eq(z[:48]),ztop.eq(z[48:]),
        positive.eq(~zlo[-1]&~c[-1]&low[-1]),negative.eq(zlo[-1]&c[-1]&~low[-1]),
        correction.eq(ztop+zlo[-1]+positive-negative),
        top.eq(high_q[31:33]+correction_q),result.eq(Cat(low_q,high_q[:31],top))]
    module.sync += [low_q.eq(low[:17]),correction_q.eq(correction)]
    return result
