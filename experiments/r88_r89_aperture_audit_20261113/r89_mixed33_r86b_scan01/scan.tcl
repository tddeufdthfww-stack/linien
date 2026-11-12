open_checkpoint {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r89_mixed33_r86b_scan01}
set_param general.maxThreads 2

set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach p [concat $data $wrt] {dict set saved [get_property NAME $p] [list [get_property IOSTANDARD $p] [get_property DRIVE $p] [get_property SLEW $p]]}
set f [open "$out/raw.tsv" w];puts $f "data_std\twrt_std\tdata_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
set code [catch {
 foreach ds {LVCMOS33 LVTTL} {
  if {$ds eq "LVCMOS33"} {set ws LVTTL;set drives {4 8 12 16};set wdrives {4 8 12 16 24}} else {set ws LVCMOS33;set drives {4 8 12 16 24};set wdrives {4 8 12 16}}
  set_property IOSTANDARD $ds $data;set_property IOSTANDARD $ws $wrt
  foreach wd $wdrives {foreach wsl {FAST SLOW} {foreach dd $drives {foreach dsl {FAST SLOW} {
   set_property DRIVE $wd $wrt;set_property SLEW $wsl $wrt;set_property DRIVE $dd $data;set_property SLEW $dsl $data
   set su {};set ho {}
   foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
   foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
   if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
   dict for {pin ss} $su {puts $f [join [list $ds $ws $dd $wd $dsl $wsl $pin $ss [dict get $ho $pin]] "\t"]};flush $f
  }}}}
 }
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
puts MIXED33_160_CASES_COMPLETE_NOT_SIGNOFF
