if {[catch {
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r83_dac_extra_protocol}
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r83-dac-shared-bufio/gateware/build/trials/20261112_195916_r83_shared_bufio_implementation/routed.dcp}

set sel [get_ports dac_sel]
if {[llength $sel]!=1 || [llength [get_clocks dac_write]]!=1 || [llength [get_clocks dac_sample]]!=1} {error "Missing exact DAC interface"}
# Real condition in Fig64/ADI explanation: SEL changes only while BOTH clocks low.
# Setup to next rising edge and hold after preceding falling edge; 0 means the
# stated logic-level window condition, NOT an assumed zero board delay budget.
set_output_delay -clock [get_clocks dac_write] -max 0.0 $sel
set_output_delay -clock [get_clocks dac_write] -clock_fall -min 0.0 $sel
set_output_delay -clock [get_clocks dac_sample] -max 0.0 -add_delay $sel
set_output_delay -clock [get_clocks dac_sample] -clock_fall -min 0.0 -add_delay $sel
report_timing -to $sel -delay_type max -max_paths 30 -nworst 10 -file "$out/sel_before_rises.rpt"
report_timing -to $sel -delay_type min -max_paths 30 -nworst 10 -file "$out/sel_after_falls.rpt"
set clk_cells {}
foreach c [get_cells -hier -filter {REF_NAME == ODDR}] {
 set q [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]]
 if {$q eq "dac_clk_OBUF"} {lappend clk_cells $c}
}
if {[llength $clk_cells]!=1} {error "Cannot trace DAC CLK ODDR"}
set clk_c [get_pins -of_objects $clk_cells -filter {REF_PIN_NAME == C}]
# Actual frozen R65 CLK ODDR D1=0,D2=1: only C-fall generates Q-rise.
# A clock-as-data path from C-rise to Q-rise is an unreachable primitive
# timing arc. Select the actual physical launch edge in diagnostic reports;
# no disable_timing/false_path is installed and no DCP is written.
# Fig64 nominal CLK leads WRT by 500ps. This necessary edge-order model is
# additional to the unchanged data setup/hold model; PCB skew still absent.
set_output_delay -clock [get_clocks dac_write] -max 0.5 [get_ports dac_clk]
# FAQ: next CLK must not occur within 2ns after the preceding WRT.
set_output_delay -clock [get_clocks dac_write] -min -2.0 [get_ports dac_clk]
report_timing -fall_from $clk_c -rise_to [get_ports dac_clk] -delay_type max -max_paths 10 -nworst 5 -file "$out/clk_before_wrt.rpt"
report_timing -fall_from $clk_c -rise_to [get_ports dac_clk] -delay_type min -max_paths 10 -nworst 5 -file "$out/clk_after_previous_wrt.rpt"
report_clocks -file "$out/clocks.rpt"
report_exceptions -file "$out/exceptions.rpt"
puts DAC_EXTRA_PROTOCOL_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
