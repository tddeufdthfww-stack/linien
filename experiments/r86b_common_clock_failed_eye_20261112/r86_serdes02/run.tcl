
set_param general.maxThreads 2
read_verilog {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/tests/timing/r86/dac_common_sdr4_probe.v}
read_xdc {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/pins.xdc}
synth_design -top dac_common_sdr4_probe -part xc7z020clg400-1 -generic USE_SERDES=1
proc forwarding_clock {port clock_name} {
 set obuf [get_cells -of_objects [get_nets -of_objects [get_ports $port]] -filter {REF_NAME == OBUF}]
 if {[llength $obuf]!=1} {error "Ambiguous output buffer $port: $obuf"}
 set net [get_nets -segments -of_objects [get_pins $obuf/I]]
 set drivers [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 set driver [get_cells -of_objects $drivers]
 if {[llength $driver]!=1} {error "Ambiguous forwarded driver $port: $driver"}
 set ref [get_property REF_NAME $driver]
 if {$ref eq "ODDR"} {set clockpin C} elseif {$ref eq "OSERDESE2"} {set clockpin CLK} else {error "Unknown forwarding primitive $ref"}
 set divide 1
 if {$ref eq "OSERDESE2" && [get_property DATA_RATE_OQ $driver] eq "SDR"} {set divide 2}
 create_generated_clock -name $clock_name -source [get_pins $driver/$clockpin] -divide_by $divide -invert [get_ports $port]
 puts "R86_FORWARD_CLOCK $port $driver/$clockpin inverted true"
}
forwarding_clock dac_wrt dac_wrt_forward
forwarding_clock dac_clk dac_clk_forward
set_output_delay -clock dac_wrt_forward -max 2.000 [get_ports {dac_data[*]}]
set_output_delay -clock dac_wrt_forward -min -1.500 [get_ports {dac_data[*]}]
report_timing_summary -delay_type min_max -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/synth_timing.rpt}
write_checkpoint {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/synth.dcp}
opt_design
place_design
phys_opt_design
route_design
report_route_status -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/route_status.rpt}
report_timing_summary -delay_type min_max -report_unconstrained -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed_timing.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -input_pins -max_paths 28 -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/data_setup.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -input_pins -max_paths 28 -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/data_hold.rpt}
report_timing -delay_type max -path_type full_clock_expanded -input_pins -max_paths 40 -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/worst_setup.rpt}
report_timing -delay_type min -path_type full_clock_expanded -input_pins -max_paths 40 -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/worst_hold.rpt}
report_clocks -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/clocks.rpt}
report_clock_utilization -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/clock_utilization.rpt}
report_drc -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/drc.rpt}
report_cdc -details -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/cdc.rpt}
check_timing -verbose -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/check_timing.rpt}
report_utilization -file {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/utilization.rpt}
write_checkpoint {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp}
set f [open {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/paths.tsv} w]
puts $f "port\tdelay_type\tslack\tdatapath_delay\tstartpoint\tendpoint"
foreach port [get_ports {dac_data[*]}] {
 foreach typ {max min} {
  set p [get_timing_paths -to $port -delay_type $typ -max_paths 1]
  if {[llength $p]} {puts $f "$port\t$typ\t[get_property SLACK $p]\t[get_property DATAPATH_DELAY $p]\t[get_property STARTPOINT_PIN $p]\t[get_property ENDPOINT_PIN $p]"}
 }
}
close $f
puts R86_PROBE_ROUTE_COMPLETE
