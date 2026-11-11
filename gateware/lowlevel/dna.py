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

from migen import Cat, If, Instance, Module, Signal
from misoc.interconnect.csr import AutoCSR, CSRStatus


class DNA(Module, AutoCSR):
    def __init__(self, version=0b1000001):
        n = 64
        self.dna = CSRStatus(n, reset=version << 57)

        ###

        do = Signal()
        cnt = Signal(max=2 * n + 1)
        # Reachable-state invariant: read == (cnt < 2). Both reset to
        # 1/0; the first odd counter state clears READ as cnt becomes 2.
        # Keep the original DNA clock, sample edges, CSR and 64 shifts.
        read = Signal(reset=1, name_override="r61_dna_read")
        self.sync += If(cnt[0], read.eq(0))

        self.specials += Instance(
            "DNA_PORT",
            i_DIN=self.dna.status[-1],
            o_DOUT=do,
            i_CLK=cnt[0],
            i_READ=read,
            i_SHIFT=1,
        )

        self.sync += [
            If(
                cnt < 2 * n,
                cnt.eq(cnt + 1),
                If(cnt[0], self.dna.status.eq(Cat(do, self.dna.status))),
            )
        ]
