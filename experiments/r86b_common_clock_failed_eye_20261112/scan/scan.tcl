open_checkpoint {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r86b_qualified_eye_scan01}
set_param general.maxThreads 2

set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/raw.tsv" w];puts $f "data_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
set code [catch {
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16} {
  set_property SLEW $ws $wrt;set_property DRIVE $wc $wrt
  set_property SLEW $ds $data;set_property DRIVE $dd $data
  set su {};set ho {}
  foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  if {[dict size $su]!=14 || [dict size $ho]!=14} {error "Missing bit coverage"}
  dict for {pin ss} $su {puts $f [join [list $dd $wc $ds $ws $pin $ss [dict get $ho $pin]] "\t"]};flush $f
 }}}}
} msg opts]
close $f
dict for {name values} $saved {set_property DRIVE [lindex $values 0] [get_ports $name];set_property SLEW [lindex $values 1] [get_ports $name]}
if {$code} {return -options $opts $msg}
puts R86_QUALIFIED_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
