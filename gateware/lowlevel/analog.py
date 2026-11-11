# This file is part of Linien and based on redpid.
#
# Copyright (C) 2016-2024 Linien Authors (https://github.com/linien-org/linien#license)
#
# Linien is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Linien is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Linien.  If not, see <http://www.gnu.org/licenses/>.

from migen import Cat, ClockSignal, Instance, Module, Mux, ResetSignal, Signal


class PitayaAnalog(Module):
    def __init__(self, adc, dac):
        self.comb += adc.cdcs.eq(1), adc.clk.eq(0b10)

        # sign = 1<<(len(dac.data) - 1)
        size = len(dac.data), True

        self.adc_a = Signal(size)
        self.adc_b = Signal(size)
        self.dac_a = Signal(size)
        self.dac_b = Signal(size)

        adca = Signal.like(adc.data_b)
        adcb = Signal.like(adc.data_a)
        # Preserve the original rising-edge register function, and put it
        # in the input IOB. The source-synchronous same-word timing model
        # explicitly checks data after CLKOUT+ rising against the delayed
        # physical sys rising edge; it tightens setup to a zero-cycle check.
        # Both that setup and next-word hold must pass at every PVT corner.
        for lane, captured in ((adc.data_a, adca), (adc.data_b, adcb)):
            for data_bit, captured_bit in zip(lane, captured):
                self.specials += Instance(
                    "FDRE",
                    p_INIT=0,
                    p_IS_C_INVERTED=0,
                    i_C=ClockSignal("sys"),
                    i_CE=1,
                    i_R=ResetSignal("sys"),
                    i_D=data_bit,
                    o_Q=captured_bit,
                    attr={("IOB", "TRUE")},
                )
        # self.sync += self.adc_a.eq(-(sign ^ adca[2:])),
        # self.adc_b.eq(-(sign ^ adcb[2:]))
        self.comb += [
            # this is off by one LSB but otherwise min and max fail
            self.adc_a.eq(Cat(~adca[2:-1], adca[-1])),
            self.adc_b.eq(Cat(~adcb[2:-1], adcb[-1])),
        ]

        daca = Signal.like(dac.data)
        dacb = Signal.like(dac.data)
        # dacai, dacbi = Signal.like(dac.data), Signal.like(dac.data)
        # self.comb += dacai.eq(-self.dac_a), dacbi.eq(-self.dac_b)
        # self.sync += daca.eq(dacai ^ sign), dacb.eq(dacbi ^ sign)
        self.sync += [
            daca.eq(Cat(~self.dac_a[:-1], self.dac_a[-1])),
            dacb.eq(Cat(~self.dac_b[:-1], self.dac_b[-1])),
        ]

        # Same-edge registered phase history, with a full fast-clock cycle
        # available to the output mux. On a common sys/sys_double rising
        # edge both registers sample pre-edge state: the IOB emits old A,
        # frame toggles, and frame_seen retains old frame. Thus XOR is 1
        # for the next +4 ns B slot, then returns to 0 for the next A slot.
        # The coincident-edge frame -> frame_seen hold check remains real.
        frame = Signal(reset=0, reset_less=True)
        frame_seen = Signal(reset=0)
        select_b = Signal(reset=0)
        self.sync += frame.eq(~frame)
        self.specials += Instance(
            "FDRE",
            p_INIT=0,
            p_IS_C_INVERTED=0,
            i_C=ClockSignal("sys_double"),
            i_CE=1,
            i_R=0,
            i_D=frame,
            o_Q=frame_seen,
        )
        self.comb += select_b.eq(frame ^ frame_seen)
        dac_word = Signal.like(dac.data)
        self.comb += dac_word.eq(Mux(select_b, dacb, daca))

        self.comb += dac.rst.eq(ResetSignal("sys"))
        self.specials += [
            Instance(
                "ODDR",
                i_D1=1,
                i_D2=0,
                i_C=ClockSignal("dac_2p"),
                o_Q=dac.clk,
                i_CE=1,
                i_R=0,
                i_S=0,
            ),
            Instance(
                "ODDR",
                i_D1=1,
                i_D2=0,
                i_C=ClockSignal("dac_wrt"),
                o_Q=dac.wrt,
                i_CE=1,
                i_R=0,
                i_S=0,
            ),
            Instance(
                "ODDR",
                i_D1=0,
                i_D2=1,
                i_C=ClockSignal("sys"),
                o_Q=dac.sel,
                i_CE=1,
                i_R=0,
                i_S=0,
            ),
            [
                Instance(
                    "FDRE",
                    p_INIT=0,
                    p_IS_C_INVERTED=0,
                    i_D=value,
                    i_C=ClockSignal("sys_double"),
                    o_Q=pad,
                    i_CE=1,
                    i_R=0,
                    attr={("IOB", "TRUE")},
                )
                for value, pad in zip(dac_word, dac.data)
            ],
        ]
