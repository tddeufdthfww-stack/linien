create_project -force -name top -part xc7z020clg400-1
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
add_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\axi_slave.v}
set_property library work [get_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\axi_slave.v}]
add_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\bus_clk_bridge.v}
set_property library work [get_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\bus_clk_bridge.v}]
add_files {top.v}
set_property library work [get_files {top.v}]
add_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\red_pitaya_scope.v}
set_property library work [get_files {D:\RP_Dev\linien-v2.1.0\gateware\verilog\red_pitaya_scope.v}]
add_files {D:\RP_Dev\Vivado_Projects\linien_ps_g2_ref\linien_ps_g2_ref.srcs\sources_1\bd\linien_ps_only\hdl\linien_ps_only_wrapper.v}
set_property library work [get_files {D:\RP_Dev\Vivado_Projects\linien_ps_g2_ref\linien_ps_g2_ref.srcs\sources_1\bd\linien_ps_only\hdl\linien_ps_only_wrapper.v}]
read_xdc top.xdc
read_bd "D:/RP_Dev/Vivado_Projects/linien_ps_g2_ref/linien_ps_g2_ref.srcs/sources_1/bd/linien_ps_only/linien_ps_only.bd"
set_property synth_checkpoint_mode None [get_files "D:/RP_Dev/Vivado_Projects/linien_ps_g2_ref/linien_ps_g2_ref.srcs/sources_1/bd/linien_ps_only/linien_ps_only.bd"]
generate_target all [get_files "D:/RP_Dev/Vivado_Projects/linien_ps_g2_ref/linien_ps_g2_ref.srcs/sources_1/bd/linien_ps_only/linien_ps_only.bd"]
synth_design -top top -part xc7z020clg400-1
report_utilization -file top_synth_utilization.rpt
report_timing_summary -file top_synth_timing.rpt
write_checkpoint -force top_synth_first.dcp
exit
