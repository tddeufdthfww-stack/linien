if {[catch {

set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/experiments/r80_actual_internal_closure_20261112/physical/routed.dcp}
set managers [get_cells -hier -filter {REF_NAME == MMCME2_ADV || REF_NAME == PLLE2_ADV}]
if {[llength $managers]!=1} {error "Expected one exact clock manager, got $managers"}
set manager [lindex $managers 0]
set original [get_property BANDWIDTH $manager]
set clocks_before {}
foreach c [lsort [get_clocks]] {dict set clocks_before $c [list [get_property PERIOD $c] [get_property WAVEFORM $c]]}
set f [open {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/windows.tsv} w]
puts $f "bandwidth\tport\tsetup_ns\thold_ns\tsum_ns"
foreach mode {OPTIMIZED HIGH LOW} {
 set_property BANDWIDTH $mode $manager
 foreach port [get_ports {dac_data[*]}] {
  set a [get_timing_paths -to $port -delay_type max -max_paths 1]
  set b [get_timing_paths -to $port -delay_type min -max_paths 1]
  if {[llength $a]!=1 || [llength $b]!=1} {error "Missing path $mode/$port"}
  set s [get_property SLACK $a];set h [get_property SLACK $b]
  puts $f "$mode\t$port\t$s\t$h\t[expr {$s+$h}]"
 }
 report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -max_paths 14 -file "D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/${mode}_setup.rpt"
 report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -max_paths 14 -file "D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/${mode}_hold.rpt"
 report_clocks -file "D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/${mode}_clocks.rpt"
 report_property $manager -file "D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/${mode}_primitive.rpt"
 foreach c [lsort [get_clocks]] {
  if {[dict get $clocks_before $c] ne [list [get_property PERIOD $c] [get_property WAVEFORM $c]]} {error "Clock waveform changed: $c"}
 }
}
close $f
set_property BANDWIDTH $original $manager
report_exceptions -file {D:/RP_Dev/linien_trials/20261113-r93-clock-bandwidth/gateware/build/r93_pll01/unchanged_exceptions.rpt}
puts R93_CLOCK_BANDWIDTH_DIAGNOSTIC_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
