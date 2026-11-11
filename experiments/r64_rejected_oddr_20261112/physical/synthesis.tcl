if {[catch {
create_project -force -name top -dir vivado_project -part xc7z020clg400-1
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
add_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\bus_clk_bridge.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\bus_clk_bridge.v}]
add_files {top.v}
set_property library work [get_files {top.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\axi_slave.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\axi_slave.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\build\trials\20261112_034833_r64_shared_dac_implementation\ps\linien_ps_only\hdl\linien_ps_only_wrapper.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\build\trials\20261112_034833_r64_shared_dac_implementation\ps\linien_ps_only\hdl\linien_ps_only_wrapper.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\red_pitaya_scope.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r64-dac-shared-clock\gateware\verilog\red_pitaya_scope.v}]
read_xdc top.xdc
read_bd "D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/build/trials/20261112_034833_r64_shared_dac_implementation/ps/linien_ps_only/linien_ps_only.bd"
set_property synth_checkpoint_mode None [get_files "D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/build/trials/20261112_034833_r64_shared_dac_implementation/ps/linien_ps_only/linien_ps_only.bd"]
generate_target all [get_files "D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/build/trials/20261112_034833_r64_shared_dac_implementation/ps/linien_ps_only/linien_ps_only.bd"]

set_param general.maxThreads 2
synth_design -top top -part xc7z020clg400-1
source {D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/constraints/dna_clock.tcl}
source {D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/constraints/io_intrinsic_probe.tcl}
source {D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/constraints/adc_same_word_capture.tcl}
report_timing_summary -file synth_timing.rpt
report_utilization -file synth_utilization.rpt
write_checkpoint -force synth.dcp
puts SYNTHESIS_COMPLETE

} msg opts]} {
puts stderr "ERROR: $msg"
puts stderr [dict get $opts -errorinfo]
exit 3
}
exit 0
