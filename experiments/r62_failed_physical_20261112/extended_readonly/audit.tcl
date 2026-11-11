if {[catch {
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r62_extended}
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r62-adc-fall-dac-fast/gateware/build/trials/20261112_025605_r62_intrinsic_io_implementation/routed.dcp}

report_timing_summary -file "$out/timing.rpt"
report_exceptions -file "$out/exceptions.rpt"
report_clocks -file "$out/clocks.rpt"
check_timing -verbose -file "$out/checks.rpt"
report_timing -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 8 -file "$out/dna_setup.rpt"
report_timing -delay_type min -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 8 -file "$out/dna_hold.rpt"
foreach pair {{clk_fpga_0 clk_2} {clk_2 clk_fpga_0}} {
 set from [lindex $pair 0];set to [lindex $pair 1]
 foreach delay {max min} {
  set paths [get_timing_paths -from [get_clocks $from] -to [get_clocks $to] -delay_type $delay -max_paths 10000 -nworst 1]
  set f [open "$out/cdc_${from}_to_${to}_${delay}.tsv" w]
  puts $f "start\tend\tdata_ns\tlogic_ns\troute_ns\tslack\tlevels\trequirement_ns"
  foreach q $paths {set row {};foreach prop {STARTPOINT_PIN ENDPOINT_PIN DATAPATH_DELAY DATAPATH_LOGIC_DELAY DATAPATH_NET_DELAY SLACK LOGIC_LEVELS REQUIREMENT} {lappend row [get_property $prop $q]};puts $f [join $row "\t"]};close $f
 }
}
set sync [get_cells -hier -filter {ASYNC_REG == TRUE}]
report_timing -from $sync -to $sync -max_paths 1000 -file "$out/sync_setup.rpt"
report_timing -delay_type min -from $sync -to $sync -max_paths 1000 -file "$out/sync_hold.rpt"
set f [open "$out/synchronizers.tsv" w];puts $f "cell\tref\tLOC\tBEL\tC\tD\tQ\tQ_loads"
foreach c $sync {
 set row [list $c [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c]]
 foreach pin {C D Q} {lappend row [get_nets -of_objects [get_pins -of_objects $c -filter "REF_PIN_NAME == $pin"]]}
 set q [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]
 lappend row [get_pins -leaf -of_objects [get_nets -of_objects $q] -filter {DIRECTION == IN}]
 puts $f [join $row "\t"]
};close $f
set ap {}
foreach pp [get_ports {adc_data_a[*] adc_data_b[*]}] {if {[regexp {^adc_data_[ab]\[([0-9]+)\]$} [get_property NAME $pp] whole index] && $index>=2} {lappend ap $pp}}
set dp [get_ports {dac_data[*]}]
foreach delay {max min} {
 report_timing -from $ap -delay_type $delay -max_paths 60 -nworst 2 -file "$out/adc_${delay}.rpt"
 report_timing -to $dp -delay_type $delay -max_paths 60 -nworst 2 -file "$out/dac_${delay}.rpt"
}
set adc_regs {}
foreach q [all_fanout -flat -endpoints_only -from $ap] {
 set c [get_cells -of_objects $q]
 if {[llength $c] && [get_property REF_NAME $c] in {FDRE FDSE FDCE FDPE}} {lappend adc_regs $c}
}
set adc_regs [lsort -unique $adc_regs]
set f [open "$out/adc_registers.tsv" w];puts $f "cell\tref\tLOC\tBEL\tIOB\tIS_C_INVERTED"
foreach c $adc_regs {puts $f [join [list $c [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c] [get_property IOB $c] [get_property IS_C_INVERTED $c]] "\t"]};close $f
report_timing -from $adc_regs -max_paths 80 -file "$out/adc_to_consumers.rpt"
set f [open "$out/min_pulse_command_support.txt" w]
puts $f "matching_commands=[info commands *pulse*]"
set pulse_help_status [catch {help set_min_pulse_width} pulse_help]
puts $f "help_status=$pulse_help_status\nhelp_result=$pulse_help";close $f
report_drc -ruledeck bitstream_checks -file "$out/bitstream_drc.rpt"
puts EXTENDED_READONLY_AUDIT_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
