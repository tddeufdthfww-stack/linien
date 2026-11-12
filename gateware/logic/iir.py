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

from migen import ClockSignal, Constant, If, Instance, ResetSignal, Signal
from migen.genlib.misc import timeline
from misoc.interconnect.csr import CSRConstant, CSRStorage

from .filter import Filter
from .iir_c48_mac import split_c48_mac
from .iir_registered_c48 import registered_c48_mac


class Iir(Filter):
    def __init__(
        self,
        order=1,
        mode="pipelined",
        width=25,
        coeff_width=18,
        shift=16,
        intermediate_width=None,
        config_delay=0,
        mac_impl="native",
        fabric_feedback=False,
        retimed_output=False,
    ):
        Filter.__init__(self, width)
        assert not (retimed_output and fabric_feedback)
        assert not retimed_output or mode == "pipelined"
        assert config_delay in (0,1,2)
        assert mode in ("pipelined", "iterative")
        assert mac_impl in ("native","split_c48","registered_c48")
        if intermediate_width is None:
            intermediate_width = width + coeff_width
            # + bits_for(2*(order + 1))

        if mac_impl in ("split_c48","registered_c48"):
            assert mode == "pipelined" and width == coeff_width == 25 and intermediate_width == 50

        self.z0 = CSRStorage(intermediate_width - shift, reset=0)
        self.shift = CSRConstant(shift)
        self.width = CSRConstant(coeff_width)
        self.interval = CSRConstant(0, 8)
        self.latency = CSRConstant(0, 8)
        self.order = CSRConstant(order, 8)
        self.iterative = CSRConstant(mode == "iterative", 1)

        self.c = c = {}
        for i in "ab":
            for j in range(order + 1):
                name = f"{i}{j}"
                if name == "a0":
                    continue
                ci = Signal((coeff_width, True), name=name)
                rci = CSRStorage(len(ci), name=name)
                source = rci.storage
                for _ in range(config_delay):
                    cohort = Signal.like(source)
                    self.sync += cohort.eq(source)
                    source = cohort
                self.sync += ci.eq(source)
                c[name] = ci
                setattr(self, "r_" + name, rci)

        ###

        z = Signal((intermediate_width, True), name="z0r")
        z0_source = self.z0.storage
        for _ in range(config_delay):
            z0_cohort = Signal.like(z0_source)
            self.sync += z0_cohort.eq(z0_source)
            z0_source = z0_cohort
        self.sync += z.eq(z0_source << shift)

        y_lim = Signal.like(self.y)
        y_next = Signal.like(z)
        skip = shift + width - 1
        y_over = y_next[skip:]
        y_pat = Signal.like(y_over, reset=2 ** (intermediate_width - skip) - 1)
        y = Signal.like(self.y)
        railed = Signal()
        previous_y = Signal.like(self.y) if retimed_output else self.y
        self.comb += [
            railed.eq(~((y_over == y_pat) | (y_over == ~y_pat))),
            If(railed, y_lim.eq(previous_y)).Else(y_lim.eq(y_next[shift:])),
        ]
        if retimed_output:
            # Capture the old states/controls on the ORIGINAL output edge.
            # The raw MAC result is registered on that same edge below.
            previous_feedback = Signal.like(y)
            hold_q, clear_q = Signal(), Signal()
            self.sync += [previous_y.eq(self.y), previous_feedback.eq(y),
                          hold_q.eq(self.hold), clear_q.eq(self.clear)]
            self.comb += [self.error.eq(railed), self.y.eq(y_lim),
                          If(clear_q, y.eq(0)).Elif(hold_q, y.eq(previous_feedback))
                          .Else(y.eq(y_lim))]
        else:
            self.sync += [self.error.eq(railed), self.y.eq(y_lim)]
        if retimed_output:
            pass  # Feedback is reconstructed from this edge's registered cohort.
        elif fabric_feedback:
            # The ORIGINAL feedback state edge, explicitly kept outside DSP BREG.
            # D selects hold/clear; CE is constant. No extra pipeline state.
            y_d = Signal.like(y)
            self.comb += [y_d.eq(y),
                          If(self.clear, y_d.eq(0)).Elif(~self.hold, y_d.eq(y_lim))]
            for bit in range(len(y)):
                self.specials += Instance(
                    "FDRE", name=f"feedback_fabric_{bit}",
                    p_INIT=0, i_C=ClockSignal(), i_CE=1, i_R=ResetSignal(),
                    i_D=y_d[bit], o_Q=y[bit],
                    attr={("DONT_TOUCH", "true")})
        else:
            self.sync += If(self.clear, y.eq(0)).Elif(~self.hold, y.eq(y_lim))

        if mode == "pipelined":
            r = [(f"b{i}", self.x) for i in reversed(range(order + 1))]
            r += [(f"a{i}", y) for i in reversed(range(1, order + 1))]
            if mac_impl == "registered_c48":
                zr = Signal.like(z)
                self.sync += zr.eq(z)
                for i, (coeff, signal) in enumerate(r):
                    if i < len(r)-1:
                        zr = registered_c48_mac(self,zr,signal,c[coeff])
                    else:
                        # Replace the output state edge with full MAC state,
                        # not an extra edge after the original output FF.
                        z = (registered_c48_mac if retimed_output else split_c48_mac)(
                            self,zr,signal,c[coeff])
            else:
                for coeff, signal in r:
                    zr = Signal.like(z)
                    self.sync += zr.eq(z)
                    z = Signal.like(zr)
                    if mac_impl == "split_c48":
                        self.comb += z.eq(split_c48_mac(self,zr,signal,c[coeff]))
                    else:
                        self.comb += z.eq(zr + signal * c[coeff])
            if retimed_output and mac_impl != "registered_c48":
                raw_q = Signal.like(z)
                self.sync += raw_q.eq(z)
                self.comb += y_next.eq(raw_q)
            else:
                self.comb += y_next.eq(z)
            self.latency.value = Constant(order + 1)
            self.interval.value = Constant(1)

        elif mode == "iterative":
            ma = Signal.like(self.y)
            mb = Signal.like(c["a1"])
            mm = Signal.like(z)
            mc = Signal.like(z)
            mp = Signal.like(z)
            self.sync += mm.eq(ma * mb), mc.eq(mp)
            self.comb += mp.eq(mm + mc)
            steps = []
            x = [self.x] + [Signal.like(self.x) for i in range(order + 1)]
            for i in reversed(range(order + 1)):
                steps.append([x[i + 1].eq(x[i]), ma.eq(x[i]), mb.eq(c[f"b{i}"])])
            y = [None, y] + [Signal.like(y) for i in range(1, order + 1)]
            for i in reversed(range(1, order + 1)):
                steps.append([y[i + 1].eq(y[i]), ma.eq(y[i]), mb.eq(c[f"a{i}"])])
            steps[1].append(mc.eq(z))
            latency = order + 4
            if order == 1:
                steps.append([])
                latency += 1
            self.latency.value = Constant(latency)
            steps[int(order > 1)].append(y_next.eq(mp))
            self.sync += timeline(1, list(enumerate(steps)))
            self.interval.value = Constant(len(steps))

        else:
            raise ValueError
