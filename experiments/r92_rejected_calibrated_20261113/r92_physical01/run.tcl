
set_param general.maxThreads 2
read_verilog {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/tests/timing/r92/dac_calibrated_wrt_probe.v}
read_xdc {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/pins.xdc}
synth_design -top dac_calibrated_wrt_probe -part xc7z020clg400-1 -generic USE_SERDES=0
proc forwarding_clock {port clock_name} {
 if {$port eq "dac_wrt"} {
  create_generated_clock -name $clock_name -source [get_pins data_clock/O] -divide_by 1 [get_ports dac_wrt]
  puts R92_WRT_SAME_SOURCE_EVENT_PROPAGATED_DELAY
  return
 }

 set obuf [get_cells -of_objects [get_nets -of_objects [get_ports $port]] -filter {REF_NAME == OBUF}]
 if {[llength $obuf]!=1} {error "Ambiguous output buffer $port: $obuf"}
 set net [get_nets -segments -of_objects [get_pins $obuf/I]]
 set drivers [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 set driver [get_cells -of_objects $drivers]
 if {[llength $driver]!=1} {error "Ambiguous forwarded driver $port: $driver"}
 set ref [get_property REF_NAME $driver]
 if {$ref eq "ODDR"} {set clockpin C} elseif {$ref eq "OSERDESE2"} {set clockpin CLK} else {error "Unknown forwarding primitive $ref"}
 create_generated_clock -name $clock_name -source [get_pins $driver/$clockpin] -divide_by 1 -invert [get_ports $port]
 puts "R92_FORWARD_CLOCK $port $driver/$clockpin inverted true"
}
forwarding_clock dac_wrt dac_wrt_forward
forwarding_clock dac_clk dac_clk_forward
set_output_delay -clock dac_wrt_forward -max 2.000 [get_ports {dac_data[*]}]
set_output_delay -clock dac_wrt_forward -min -1.500 [get_ports {dac_data[*]}]
# Physical delay represents SAME clock event, not a later 4ns event.
# Tighten setup from default next-cycle to same-event; derived hold must be -4ns.
report_timing -to [get_ports {dac_data[*]}] -delay_type max -max_paths 14 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/before_zero_cycle_tightening.rpt}
set data_c [get_pins -hier -filter {NAME =~ *output_data/C && REF_PIN_NAME == C}]
if {[llength $data_c]!=14} {error "R92 fourteen data launch pins required"}
set_multicycle_path 0 -setup -from $data_c -to [get_ports {dac_data[*]}]
report_exceptions -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/exceptions.rpt}
set delays [get_cells -hier -filter {REF_NAME == IDELAYE2}]
set luts [get_cells -hier -filter {NAME =~ *write_fabric_buffer}]
if {[llength $delays]!=1 || [llength $luts]!=1} {error "R92 preserved calibrated-to-fabric path missing"}
report_property $delays -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/delay_properties_synth.rpt}
report_timing_summary -delay_type min_max -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/synth_timing.rpt}
write_checkpoint {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/synth.dcp}
opt_design
place_design
phys_opt_design
route_design
report_route_status -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/route_status.rpt}
report_timing_summary -delay_type min_max -report_unconstrained -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/routed_timing.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -input_pins -max_paths 28 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/data_setup.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -input_pins -max_paths 28 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/data_hold.rpt}
report_timing -delay_type max -path_type full_clock_expanded -input_pins -max_paths 40 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/worst_setup.rpt}
report_timing -delay_type min -path_type full_clock_expanded -input_pins -max_paths 40 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/worst_hold.rpt}
report_property [get_cells -hier -filter {REF_NAME == IDELAYE2}] -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/delay_properties_routed.rpt}
report_timing -from [get_pins -hier -filter {REF_PIN_NAME == Q && NAME =~ *calibration*}] -max_paths 28 -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/calibration_control_paths.rpt}
report_clocks -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/clocks.rpt}
report_clock_utilization -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/clock_utilization.rpt}
report_drc -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/drc.rpt}
report_cdc -details -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/cdc.rpt}
check_timing -verbose -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/check_timing.rpt}
report_utilization -file {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/utilization.rpt}
write_checkpoint {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/routed.dcp}
set f [open {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/paths.tsv} w]
puts $f "port\tdelay_type\tslack\tdatapath_delay\tstartpoint\tendpoint"
foreach port [get_ports {dac_data[*]}] {
 foreach typ {max min} {
  set p [get_timing_paths -to $port -delay_type $typ -max_paths 1]
  if {[llength $p]} {puts $f "$port\t$typ\t[get_property SLACK $p]\t[get_property DATAPATH_DELAY $p]\t[get_property STARTPOINT_PIN $p]\t[get_property ENDPOINT_PIN $p]"}
 }
}
close $f
puts R92_PROBE_ROUTE_COMPLETE
