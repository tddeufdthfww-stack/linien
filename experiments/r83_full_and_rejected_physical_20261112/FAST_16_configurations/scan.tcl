if {[catch {
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r83_legal_dac_scan}
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r83-dac-shared-bufio/gateware/build/trials/20261112_195916_r83_shared_bufio_implementation/routed.dcp}

set ports [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $ports]!=14 || [llength $wrt]!=1} {error "DAC port count"}
set original {};foreach port [concat $ports $wrt] {dict set original [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/per_pin.tsv" w];puts $f "data_drive	wrt_drive	pin	setup_ns	hold_ns"
set scan_code [catch {
 foreach wc {4 8 12 16} {
  foreach dd {4 8 12 16} {
   set_property DRIVE $wc $wrt;set_property SLEW FAST $wrt
   set_property DRIVE $dd $ports;set_property SLEW FAST $ports
   set su {};set ho {}
   foreach path [get_timing_paths -to $ports -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $path] [get_property SLACK $path]}
   foreach path [get_timing_paths -to $ports -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $path] [get_property SLACK $path]}
   if {[dict size $su]!=14 || [dict size $ho]!=14} {error "Missing per-pin coverage"}
   dict for {pin ss} $su {puts $f [join [list $dd $wc $pin $ss [dict get $ho $pin]] "	"]}
   flush $f
  }
 }
} scan_error scan_options]
close $f
# Also restore on diagnostic failure, never save a modified checkpoint.
dict for {name properties} $original {set_property DRIVE [lindex $properties 0] [get_ports $name];set_property SLEW [lindex $properties 1] [get_ports $name]}
if {$scan_code} {return -options $scan_options $scan_error}
report_timing -to $ports -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -delay_type min -to $ports -max_paths 14 -file "$out/restored_hold.rpt"
puts DAC_PER_PIN_LEGAL_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
