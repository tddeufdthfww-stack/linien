"""R82 experimental DAC-only regional clocks. Not a board-qualified interface."""
from migen import ClockDomain, ClockSignal, Instance, Module, ResetSignal, Signal
from migen.genlib.resetsync import AsyncResetSynchronizer


class DACRegionalClock(Module):
    def __init__(self):
        self.clock_domains.cd_dac_io = ClockDomain(reset_less=True)
        self.clock_domains.cd_dac_write_io = ClockDomain(reset_less=True)
        self.clock_domains.cd_dac_sample_io = ClockDomain(reset_less=True)
        self.clock_domains.cd_dac_select_io = ClockDomain(reset_less=True)
        self.clock_domains.cd_dac_ready = ClockDomain()
        raw = [Signal() for _ in range(4)]
        feedback = Signal()
        self.locked = Signal()
        # Default compensation is intentionally left to the implementation
        # tools, per UG472 Table3-7 note1. Feedback is direct; input is BUFG.
        self.specials += Instance(
            "MMCME2_BASE", p_BANDWIDTH="OPTIMIZED", p_CLKIN1_PERIOD=8.0,
            p_DIVCLK_DIVIDE=1, p_CLKFBOUT_MULT_F=8.0,
            p_CLKOUT0_DIVIDE_F=4.0, p_CLKOUT0_PHASE=-45.0,
            p_CLKOUT1_DIVIDE=4, p_CLKOUT1_PHASE=-22.5,
            p_CLKOUT2_DIVIDE=4, p_CLKOUT2_PHASE=-135.0,
            p_CLKOUT3_DIVIDE=8, p_CLKOUT3_PHASE=5.625,
            p_STARTUP_WAIT="FALSE", p_REF_JITTER1=0.01,
            i_CLKIN1=ClockSignal("sys"), i_RST=ResetSignal("sys"),
            i_PWRDWN=0, i_CLKFBIN=feedback, o_CLKFBOUT=feedback,
            o_CLKOUT0=raw[0], o_CLKOUT1=raw[1],
            o_CLKOUT2=raw[2], o_CLKOUT3=raw[3], o_LOCKED=self.locked,
        )
        for signal, domain in zip(raw, [self.cd_dac_io, self.cd_dac_write_io,
                                        self.cd_dac_sample_io, self.cd_dac_select_io]):
            self.specials += Instance("BUFIO", i_I=signal, o_O=domain.clk)
        # IQRESET asserts immediately on SYS reset/secondary MMCM unlock,
        # releases on two SYS edges. No new clocks drive fabric data FFs.
        self.comb += self.cd_dac_ready.clk.eq(ClockSignal("sys"))
        self.specials += AsyncResetSynchronizer(
            self.cd_dac_ready, ResetSignal("sys") | ~self.locked)
