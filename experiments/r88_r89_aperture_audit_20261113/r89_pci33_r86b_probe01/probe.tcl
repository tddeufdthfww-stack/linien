open_checkpoint {D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r89_pci33_r86b_probe01}
set_param general.maxThreads 2

set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach p [concat $data $wrt] {dict set saved [get_property NAME $p] [list [get_property IOSTANDARD $p] [get_property DRIVE $p] [get_property SLEW $p]]}
set f [open "$out/raw.tsv" w];puts $f "data_std\twrt_std\tdata_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
proc row {f data wrt ds ws dd wd dsl wsl} {
 set_property IOSTANDARD $ds $data;set_property IOSTANDARD $ws $wrt
 foreach {ps std drive slew} [list $data $ds $dd $dsl $wrt $ws $wd $wsl] {
  if {$std eq "PCI33_3"} {reset_property DRIVE $ps;reset_property SLEW $ps} else {set_property DRIVE $drive $ps;set_property SLEW $slew $ps}
 }
 set su {};set ho {}
 foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
 foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
 if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
 dict for {pin ss} $su {puts $f [join [list $ds $ws $dd $wd $dsl $wsl $pin $ss [dict get $ho $pin]] "\t"]};flush $f
}
set code [catch {
 row $f $data $wrt PCI33_3 PCI33_3 DEFAULT DEFAULT DEFAULT DEFAULT
 report_drc -ruledecks bitstream_checks -file "$out/pci33_both_drc.rpt"
 foreach std {LVCMOS33 LVTTL} {foreach d {4 8 12 16 24} {foreach slew {FAST SLOW} {
  if {$std eq "LVCMOS33" && $d==24} {continue}
  row $f $data $wrt PCI33_3 $std DEFAULT $d DEFAULT $slew
  row $f $data $wrt $std PCI33_3 $d DEFAULT $slew DEFAULT
 }}}
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
puts PCI33_OUTPUT_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
