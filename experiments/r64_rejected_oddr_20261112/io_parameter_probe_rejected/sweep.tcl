if {[catch {
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r64_dac_io_characterization}
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r64-dac-shared-clock/gateware/build/trials/20261112_034833_r64_shared_dac_implementation/routed.dcp}

set data_ports [get_ports {dac_data[*]}]
set clocks_ports [get_ports {dac_wrt dac_clk dac_sel dac_rst}]
if {[llength $data_ports]!=14 || [llength $clocks_ports]!=4} {error "Wrong DAC port selection"}
set original {}
foreach port [concat $data_ports $clocks_ports] {dict set original [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/sweep.tsv" w];puts $f "data_drive	clock_drive	data_slew	clock_slew	setup_ns	hold_ns	data_delay_ns	data_logic_ns	setup_clock_skew_ns	hold_clock_skew_ns"
foreach data_drive {8 12 16 24} {
 foreach clock_drive {8 12 16 24} {
  foreach data_slew {FAST SLOW} {
   set_property DRIVE $data_drive $data_ports
   set_property DRIVE $clock_drive $clocks_ports
   set_property SLEW $data_slew $data_ports
   set_property SLEW FAST $clocks_ports
   set su [lindex [get_timing_paths -to $data_ports -delay_type max -max_paths 100 -nworst 1] 0]
   set ho [lindex [get_timing_paths -to $data_ports -delay_type min -max_paths 100 -nworst 1] 0]
   puts $f [join [list $data_drive $clock_drive $data_slew FAST [get_property SLACK $su] [get_property SLACK $ho] [get_property DATAPATH_DELAY $su] [get_property DATAPATH_LOGIC_DELAY $su] [get_property SKEW $su] [get_property SKEW $ho]] "	"]
   flush $f
  }
 }
}
close $f
dict for {name properties} $original {
 set_property DRIVE [lindex $properties 0] [get_ports $name]
 set_property SLEW [lindex $properties 1] [get_ports $name]
}
report_timing -to $data_ports -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -delay_type min -to $data_ports -max_paths 14 -file "$out/restored_hold.rpt"
puts DAC_IO_PARAMETER_CHARACTERIZATION_COMPLETE_NOT_BOARD_SIGNOFF

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
