if {[catch {

set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt/gateware/build/r92_physical01/routed.dcp}
set delay_cell [get_cells reference.write_delay]
set f [open {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/taps.tsv} w]
puts $f "tap\tbit\tsetup_ns\thold_ns\tsum_ns"
foreach tap {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31} {
 set_property IDELAY_VALUE $tap $delay_cell
 foreach port [get_ports {dac_data[*]}] {
  set a [get_timing_paths -to $port -delay_type max -max_paths 1]
  set b [get_timing_paths -to $port -delay_type min -max_paths 1]
  if {[llength $a]!=1 || [llength $b]!=1} {error "Missing timing: $tap/$port"}
  set s [get_property SLACK $a]; set h [get_property SLACK $b]
  puts $f "$tap\t$port\t$s\t$h\t[expr {$s+$h}]"
 }
}
close $f
set_property IDELAY_VALUE 22 $delay_cell
set sel [get_ports dac_sel]
foreach c {dac_wrt_forward dac_clk_forward} {
 set_output_delay -clock [get_clocks $c] -max 0.0 -add_delay $sel
 set_output_delay -clock [get_clocks $c] -clock_fall -min 0.0 -add_delay $sel
}
report_timing -to $sel -delay_type max -max_paths 30 -nworst 10 -path_type full_clock_expanded -file {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/sel_before_rises.rpt}
report_timing -to $sel -delay_type min -max_paths 30 -nworst 10 -path_type full_clock_expanded -file {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/sel_after_falls.rpt}
set sample [get_cells reference.output_sample]
if {[get_property REF_NAME $sample] ne "ODDR"} {error "Wrong sample primitive"}
set_output_delay -clock dac_wrt_forward -max 0.5 [get_ports dac_clk]
set_output_delay -clock dac_wrt_forward -min -2.0 [get_ports dac_clk]
report_timing -fall_from [get_clocks c2] -rise_to [get_ports dac_clk] -delay_type max -max_paths 10 -nworst 5 -path_type full_clock_expanded -file {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/clk_before_wrt.rpt}
report_timing -fall_from [get_clocks c2] -rise_to [get_ports dac_clk] -delay_type min -max_paths 10 -nworst 5 -path_type full_clock_expanded -file {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/clk_after_previous_wrt.rpt}
set f [open {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r92_tap_audit01/placement.tsv} w]
foreach c [get_cells -hier -filter {REF_NAME == IDELAYE2 || REF_NAME == LUT1 || NAME =~ *dac_wrt_OBUF_inst || NAME =~ *output_select}] {
 puts $f "$c\t[get_property REF_NAME $c]\t[get_property LOC $c]\t[get_sites -of_objects $c]"
}
close $f
puts R92_TAP_AND_PROTOCOL_DIAGNOSTIC_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
