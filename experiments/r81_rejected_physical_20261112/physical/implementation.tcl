if {[catch {
set_param general.maxThreads 2
open_checkpoint synth.dcp
opt_design
read_checkpoint -incremental {D:/RP_Dev/linien_trials/20261112-r80-status-cluster/gateware/build/trials/20261112_r80_status_cluster/routed.dcp}
place_design
phys_opt_design
route_design
report_incremental_reuse -file incremental_reuse.rpt
report_route_status -file routed_status.rpt
report_timing_summary -max_paths 30 -file routed_timing.rpt
report_timing -delay_type max -max_paths 100 -file routed_setup.rpt
report_timing -delay_type min -max_paths 30 -file routed_hold.rpt
check_timing -verbose -file routed_checks.rpt
report_cdc -details -file routed_cdc.rpt
report_drc -file routed_drc.rpt
report_utilization -file routed_utilization.rpt
report_clock_interaction -file routed_clocks.rpt
write_checkpoint -force routed.dcp
puts ROUTE_COMPLETE

} msg opts]} {
puts stderr "ERROR: $msg"
puts stderr [dict get $opts -errorinfo]
exit 3
}
exit 0
