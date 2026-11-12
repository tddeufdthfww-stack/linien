if {[catch {
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r78-early-clamp-thresholds/gateware/build/trials/20261112_172556_r78_early_clamp_implementation/routed.dcp}

write_verilog -force -mode funcsim logical_before.v
# Explicit options disable all implicit optimization categories. No retiming,
# FF insertion, DSP/BRAM register optimization, duplication, rewire or clock_opt.

# Exact geometry checked on the immutable parent; change placement only.
proc exact_cell {name} {
 set c [get_cells -hier -quiet -filter "NAME == \"$name\""]
 if {[llength $c] != 1} {error "Expected exact cell $name"};return $c
}
set target_site [get_sites SLICE_X67Y118]
if {[llength [get_cells -quiet -of_objects [get_bels -of_objects $target_site]]]} {error "Chosen parent slice is no longer empty"}
set assignments [list {linienmodule_gpio_n_o[7]_i_2} SLICE_X67Y118/A6LUT \
                      {linienmodule_gpio_n_o[7]_i_1} SLICE_X67Y118/B6LUT \
                      {linienmodule_gpio_n_o_reg[7]} SLICE_X67Y118/BFF \
                      {linienmodule_gpio_n_o_reg[7]_lopt_replica} SLICE_X67Y118/CFF]
set moved {};set f [open manual_locations_before.tsv w];puts $f "cell\tref\tLOC\tBEL"
foreach {name bel} $assignments {
 set c [exact_cell $name];lappend moved $c
 puts $f [join [list $name [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c]] "\t"]
 set_property IS_LOC_FIXED false $c;set_property IS_BEL_FIXED false $c
};close $f
set q0 [exact_cell {linienmodule_gpio_n_o_reg[7]}]
set q1 [exact_cell {linienmodule_gpio_n_o_reg[7]_lopt_replica}]
foreach p {C R CE} {
 if {[get_nets -of_objects [get_pins -of_objects $q0 -filter "REF_PIN_NAME == $p"]] ne [get_nets -of_objects [get_pins -of_objects $q1 -filter "REF_PIN_NAME == $p"]]} {error "GPIO copies disagree on $p"}
}
place_cell $assignments
set_property IS_LOC_FIXED true $moved
set_property IS_BEL_FIXED true $moved
set f [open manual_locations_after.tsv w];puts $f "cell\tref\tLOC\tBEL"
foreach {name expected} $assignments {
 set c [exact_cell $name];set location [get_property LOC $c];set bel [get_property BEL $c]
 if {$location ne "SLICE_X67Y118" || ![string match "*.[lindex [split $expected /] 1]" $bel]} {error "Unexpected moved location for $name"}
 puts $f [join [list $name [get_property REF_NAME $c] $location $bel] "\t"]
};close $f

route_design -directive Explore
report_route_status -file routed_status.rpt
report_timing_summary -max_paths 30 -file routed_timing.rpt
report_timing -delay_type max -max_paths 100 -file routed_setup.rpt
report_timing -delay_type min -max_paths 30 -file routed_hold.rpt
report_timing -from [get_clocks clk_2] -to [get_clocks clk_2] -max_paths 50 -file core_sys_setup.rpt
check_timing -verbose -file routed_checks.rpt
report_cdc -details -file routed_cdc.rpt
report_drc -file routed_drc.rpt
report_utilization -file routed_utilization.rpt
report_clock_interaction -file routed_clocks.rpt
write_verilog -force -mode funcsim logical_after.v
write_checkpoint -force routed.dcp
puts R80_PLACEMENT_ROUTING_ONLY_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
