create_project -force -name top -part xc7z020clg400-1
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
add_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\bus_clk_bridge.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\bus_clk_bridge.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\red_pitaya_scope.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\red_pitaya_scope.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\build\trials\20261112_123254_r73b_explicit_feedback_implementation\ps\linien_ps_only\hdl\linien_ps_only_wrapper.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\build\trials\20261112_123254_r73b_explicit_feedback_implementation\ps\linien_ps_only\hdl\linien_ps_only_wrapper.v}]
add_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\axi_slave.v}
set_property library work [get_files {D:\RP_Dev\linien_trials\20261112-r73b-iir-fabric-attr\gateware\verilog\axi_slave.v}]
add_files {top.v}
set_property library work [get_files {top.v}]
read_xdc top.xdc
read_bd "D:/RP_Dev/linien_trials/20261112-r73b-iir-fabric-attr/gateware/build/trials/20261112_123254_r73b_explicit_feedback_implementation/ps/linien_ps_only/linien_ps_only.bd"
set_property synth_checkpoint_mode None [get_files "D:/RP_Dev/linien_trials/20261112-r73b-iir-fabric-attr/gateware/build/trials/20261112_123254_r73b_explicit_feedback_implementation/ps/linien_ps_only/linien_ps_only.bd"]
generate_target all [get_files "D:/RP_Dev/linien_trials/20261112-r73b-iir-fabric-attr/gateware/build/trials/20261112_123254_r73b_explicit_feedback_implementation/ps/linien_ps_only/linien_ps_only.bd"]
synth_design -top top -part xc7z020clg400-1
report_timing_summary -file top_timing_synth.rpt
report_utilization -hierarchical -file top_utilization_hierarchical_synth.rpt
report_utilization -file top_utilization_synth.rpt
opt_design
place_design
phys_opt_design -directive AddRetime
report_utilization -hierarchical -file top_utilization_hierarchical_place.rpt
report_utilization -file top_utilization_place.rpt
report_io -file top_io.rpt
report_control_sets -verbose -file top_control_sets.rpt
report_clock_utilization -file top_clock_utilization.rpt
route_design
phys_opt_design
report_timing_summary -no_header -no_detailed_paths
write_checkpoint -force top_route.dcp
report_route_status -file top_route_status.rpt
report_drc -file top_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file top_timing.rpt
report_power -file top_power.rpt
write_bitstream -force top.bit 
quit