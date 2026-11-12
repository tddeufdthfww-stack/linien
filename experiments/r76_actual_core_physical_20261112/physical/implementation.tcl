if {[catch {
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r75-iir-final-operand-swap/gateware/build/trials/20261112_130415_r75_final_operand_swap_implementation/routed.dcp}

write_verilog -force -mode funcsim logical_before.v
# Explicit options disable all implicit optimization categories. No retiming,
# FF insertion, DSP/BRAM register optimization, duplication, rewire or clock_opt.
phys_opt_design -placement_opt -routing_opt -critical_pin_opt -path_groups clk_2
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
puts R76_PLACEMENT_ROUTING_ONLY_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
