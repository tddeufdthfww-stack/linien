set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r80-status-cluster/gateware/build/trials/20261112_r80_status_cluster/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r80_drc_structural_review03_20261112}

report_drc -checks [get_drc_checks RTSTAT-10] -file "$out/no_load_drc.rpt"
set violations [get_drc_violations -filter {NAME =~ RTSTAT-10*}]
set names [get_nets -of_objects $violations]
if {[llength $names]!=84} {error "Expected exact84 no-load nets, got [llength $names]"}
set f [open "$out/no_loads.tsv" w];puts $f "net\tleaf_input_pins\toutput_ports\tloads"
foreach name $names {
 set net [get_nets -quiet $name]
 if {[llength $net]!=1} {error "No-load exact net missing $name"}
 set segments [get_nets -segments $net]
 set loads [get_pins -leaf -of_objects $segments -filter {DIRECTION == IN}]
 set ports [get_ports -of_objects $segments -filter {DIRECTION == OUT}]
 puts $f [join [list $name [llength $loads] [llength $ports] $loads] "\t"]
}
close $f
set f [open "$out/opmode.tsv" w];puts $f "pin\tnet\tdriver\tconstant"
foreach i {0 1 2 3 4 5 6} {
 set pin [get_pins [format {p_1_out/OPMODE[%d]} $i]]
 set net [get_nets -segments -of_objects $pin]
 set driver [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 puts $f [join [list $i $net $driver [get_property TYPE [get_nets -of_objects $pin]]] "\t"]
}
close $f
report_property [get_cells p_1_out] -file "$out/dsp_properties.rpt"
report_route_status -file "$out/route_status.rpt"
report_drc -ruledecks bitstream_checks -file "$out/bitstream_drc.rpt"
puts R80_DRC_STRUCTURAL_EXPORT_COMPLETE
