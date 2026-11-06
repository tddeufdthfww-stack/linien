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

from migen import Array, Module, Signal


class Decimate(Module):
    def __init__(self, max_decimation):
        self.decimation = Signal(max_decimation)

        self.decimation_counter = Signal(max_decimation)
        self.sync += [self.decimation_counter.eq(self.decimation_counter + 1)]

        self.output = Signal(1)

        self.sync += [self.output.eq(Array(self.decimation_counter)[self.decimation])]


class DecimateEnable(Module):
    """125 MHz clock-enable replacement for the 250 MHz generated-clock divider.

    Stable settings 0..15 have the same average update rate as Decimate.
    For setting 0 the first event is shifted by one 125 MHz cycle: the
    original generated-clock rising edge occurs between sys rising edges.
    Values >= max_decimation safely disable updates.
    """

    def __init__(self, max_decimation):
        assert max_decimation >= 2
        self.decimation = Signal(max=max_decimation + 1)
        self.decimation_counter = Signal(max_decimation - 1)
        self.started = Signal()
        self.enable = Signal()

        pulses = [1]
        for index in range(1, max_decimation):
            pulses.append(
                self.decimation_counter[:index] == (1 << (index - 1))
            )

        self.comb += self.enable.eq(
            self.started
            & (self.decimation < max_decimation)
            & Array(pulses)[self.decimation]
        )
        self.sync += [
            self.decimation_counter.eq(self.decimation_counter + 1),
            self.started.eq(1),
        ]
