if {[catch {
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r83-dac-shared-bufio/gateware/build/trials/20261112_195916_r83_shared_bufio_implementation/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r83_full_dac_electrical_scan}
set_param general.maxThreads 2

set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $data]!=14 || [llength $wrt]!=1} {error "DAC coverage"}
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/per_pin_extra.tsv" w];puts $f "data_drive	wrt_drive	data_slew	wrt_slew	pin	setup_ns	hold_ns"
set code [catch {
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16} {
  if {$ws eq "FAST" && $ds eq "FAST"} {continue}
  set_property SLEW $ws $wrt;set_property DRIVE $wc $wrt
  set_property SLEW $ds $data;set_property DRIVE $dd $data
  set su {};set ho {}
  foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  if {[dict size $su]!=14 || [dict size $ho]!=14} {error "Missing bit coverage"}
  dict for {pin ss} $su {puts $f [join [list $dd $wc $ds $ws $pin $ss [dict get $ho $pin]] "	"]};flush $f
 }}}}
} msg opts]
close $f
dict for {name values} $saved {set_property DRIVE [lindex $values 0] [get_ports $name];set_property SLEW [lindex $values 1] [get_ports $name]}
if {$code} {return -options $opts $msg}
report_timing -to $data -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -to $data -delay_type min -max_paths 14 -file "$out/restored_hold.rpt"
puts DAC_ALL_LEGAL_DRIVE_SLEW_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF

} msg opts]} {puts stderr $msg;puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
