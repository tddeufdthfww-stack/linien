open_checkpoint {D:/RP_Dev/linien_trials/20261112-r80-status-cluster/gateware/build/trials/20261112_r80_status_cluster/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r88_r80_lvttl_scan01}
set_param general.maxThreads 2

set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $data]!=14 || [llength $wrt]!=1} {error "port count"}
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property IOSTANDARD $port] [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/raw.tsv" w];puts $f "data_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\thold_ns"
set code [catch {
 set_property IOSTANDARD LVTTL [concat $data $wrt]
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16 24} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16 24} {
  set_property SLEW $ws $wrt;set_property DRIVE $wc $wrt
  set_property SLEW $ds $data;set_property DRIVE $dd $data
  set su {};set ho {}
  foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
  dict for {pin ss} $su {puts $f [join [list $dd $wc $ds $ws $pin $ss [dict get $ho $pin]] "\t"]};flush $f
 }}}}
 set_property DRIVE 24 [concat $data $wrt]
 report_drc -ruledecks bitstream_checks -file "$out/lvttl24_drc.rpt"
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
report_timing -to $data -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -to $data -delay_type min -max_paths 14 -file "$out/restored_hold.rpt"
puts LVTTL100_LEGAL_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
