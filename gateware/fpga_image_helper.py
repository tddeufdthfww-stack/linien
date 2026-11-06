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

# this file compiles the FPGA image. You shouldn't call it directly though but
# use `build_fpga_image.sh`
import os
from pathlib import Path

from .bit2bin import bit2bin
from .hw_platform import Platform
from .linien_module import RootModule

REPO_ROOT_DIR = Path(__file__).resolve().parents[1]

# Vivado 2020.1 generated Z20 Gen 2 PS Block Design.
# Update this path if the Vivado reference project is moved.
GEN2_PS_BD = Path(
    r"D:\RP_Dev\Vivado_Projects\linien_ps_g2_ref"
    r"\linien_ps_g2_ref.srcs\sources_1\bd\linien_ps_only\linien_ps_only.bd"
)
GEN2_PS_WRAPPER = GEN2_PS_BD.parent / "hdl" / "linien_ps_only_wrapper.v"


def py_csrconstants(map, fil):
    fil.write("csr_constants = {\n")
    for k, v in root.linien.csrbanks.constants:
        fil.write("    '{}_{}': {},\n".format(k, v.name, v.value.value))
    fil.write("}\n\n")


def get_csrmap(banks):
    for name, csrs, map_addr, rmap in banks:
        reg_addr = 0
        for csr in csrs:
            yield [
                name,
                csr.name,
                map_addr,
                reg_addr,
                csr.size,
                not hasattr(csr, "status"),
            ]
            reg_addr += (csr.size + 8 - 1) // 8


def py_csrmap(it, fil):
    fil.write("csr = {\n")
    for reg in it:
        fil.write("    '{}_{}': ({}, 0x{:03x}, {}, {}),\n".format(*reg))
    fil.write("}\n")


if __name__ == "__main__":
    # Fail before regenerating csrmap.py if the new PS files are absent.
    if not GEN2_PS_BD.is_file() or not GEN2_PS_WRAPPER.is_file():
        raise FileNotFoundError(
            f"Gen 2 PS BD or wrapper is missing: {GEN2_PS_BD} / {GEN2_PS_WRAPPER}"
        )

    platform = Platform()
    root = RootModule(platform)

    with open(
        REPO_ROOT_DIR / "linien-server" / "linien_server" / "csrmap.py", "w"
    ) as fil:
        py_csrconstants(root.linien.csrbanks.constants, fil)
        csr = get_csrmap(root.linien.csrbanks.banks)
        py_csrmap(csr, fil)
        fil.write("states = {}\n".format(repr(root.linien.state_names)))
        fil.write("signals = {}\n".format(repr(root.linien.signal_names)))

    # Include only Linien's logic modules, not the Z7010 legacy PS files.
    verilog_dir = REPO_ROOT_DIR / "gateware" / "verilog"
    for filename in ("axi_slave.v", "bus_clk_bridge.v", "red_pitaya_scope.v"):
        platform.add_source(str(verilog_dir / filename))

    platform.add_source(str(GEN2_PS_WRAPPER))

    # Pre-synthesis Tcl is executed by Migen after adding RTL sources.
    bd_path = GEN2_PS_BD.as_posix()
    platform.toolchain.pre_synthesis_commands.extend(
        [
            f'read_bd "{bd_path}"',
            f'set_property synth_checkpoint_mode None [get_files "{bd_path}"]',
            f'generate_target all [get_files "{bd_path}"]',
        ]
    )

    build_dir = REPO_ROOT_DIR / "gateware" / "build"
    preview = os.environ.get("LINIEN_FPGA_PREVIEW") == "1"
    platform.build(root, build_name="top", build_dir=build_dir, run=not preview)

    if preview:
        tcl_file = build_dir / "top.tcl"

        if not tcl_file.is_file():
            raise FileNotFoundError(
                f"Vivado build script was not generated: {tcl_file}"
            )

        print(f"Vivado Tcl generated successfully: {tcl_file}")
    else:
        bit2bin(
            build_dir / "top.bit",
            REPO_ROOT_DIR / "linien-server" / "linien_server" / "gateware.bin",
            flip=True,
        )
