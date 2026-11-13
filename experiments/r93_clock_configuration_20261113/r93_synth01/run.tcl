
set_param general.maxThreads 2
read_verilog {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/tests/timing/r93/dac_vco750_probe.v}
read_xdc {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/pins.xdc}
synth_design -top dac_vco750_probe -part xc7z020clg400-1 -generic USE_SERDES=0
proc forwarding_clock {port clock_name} {
 set obuf [get_cells -of_objects [get_nets -of_objects [get_ports $port]] -filter {REF_NAME == OBUF}]
 if {[llength $obuf]!=1} {error "Ambiguous output buffer $port: $obuf"}
 set net [get_nets -segments -of_objects [get_pins $obuf/I]]
 set drivers [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 set driver [get_cells -of_objects $drivers]
 if {[llength $driver]!=1} {error "Ambiguous forwarded driver $port: $driver"}
 set ref [get_property REF_NAME $driver]
 if {$ref eq "ODDR"} {set clockpin C} elseif {$ref eq "OSERDESE2"} {set clockpin CLK} else {error "Unknown forwarding primitive $ref"}
 create_generated_clock -name $clock_name -source [get_pins $driver/$clockpin] -divide_by 1 -invert [get_ports $port]
 puts "R93_FORWARD_CLOCK $port $driver/$clockpin inverted true"
}
forwarding_clock dac_wrt dac_wrt_forward
forwarding_clock dac_clk dac_clk_forward
set_output_delay -clock dac_wrt_forward -max 2.000 [get_ports {dac_data[*]}]
set_output_delay -clock dac_wrt_forward -min -1.500 [get_ports {dac_data[*]}]
report_timing_summary -delay_type min_max -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/synth_timing.rpt}
write_checkpoint {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/synth.dcp}

report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -max_paths 14 -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/data_setup.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -max_paths 14 -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/data_hold.rpt}
report_clocks -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/clocks.rpt}
report_property [get_cells clock_manager] -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_synth01/clock_manager.rpt}
puts R93_PROBE_SYNTH_COMPLETE
