if {[catch {
set_param general.maxThreads 2
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r78-early-clamp-thresholds/gateware/build/trials/20261112_172556_r78_early_clamp_implementation/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r80_status_geometry}

help place_cell
help unplace_cell
proc exact_cell {name} {
 set result [get_cells -hier -quiet -filter "NAME == \"$name\""]
 if {[llength $result] != 1} {error "Expected exact cell $name"}
 return $result
}
set cells [list {linienmodule_gpio_n_o[7]_i_6} {linienmodule_gpio_n_o[7]_i_2} {linienmodule_gpio_n_o[7]_i_1} {linienmodule_gpio_n_o_reg[7]}]
set f [open "$out/cells.tsv" w];puts $f "cell\tref\tLOC\tBEL\tC_net\tR_net\tCE_net"
foreach name $cells {
 set c [exact_cell $name];set row [list $name [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c]]
 foreach p {C R CE} {lappend row [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter "REF_PIN_NAME == $p"]]}
 puts $f [join $row "\t"]
};close $f
set f [open "$out/last_lut_loads.tsv" w];puts $f "pin\tcell\tref\tLOC\tBEL\tclock\treset\tCE"
set c [exact_cell {linienmodule_gpio_n_o[7]_i_1}]
set nets [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == O}]]
foreach pin [get_pins -leaf -of_objects $nets -filter {DIRECTION == IN}] {
 set cc [get_cells -of_objects $pin];set row [list $pin $cc [get_property REF_NAME $cc] [get_property LOC $cc] [get_property BEL $cc]]
 foreach pp {C R CE} {lappend row [get_nets -quiet -of_objects [get_pins -quiet -of_objects $cc -filter "REF_PIN_NAME == $pp"]]}
 puts $f [join $row "\t"]
};close $f
set f [open "$out/last_lut_fanin.tsv" w];puts $f "target\tpin\tnet\tdriver\tLOC\tBEL"
foreach name [list {linienmodule_gpio_n_o[7]_i_2} {linienmodule_gpio_n_o[7]_i_1}] {
 set c [exact_cell $name]
 foreach p [get_pins -of_objects $c -filter {DIRECTION == IN}] {
  set net [get_nets -of_objects $p];set dp [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}];set dc [get_cells -of_objects $dp]
  puts $f [join [list $name $p $net $dp [get_property LOC $dc] [get_property BEL $dc]] "\t"]
 }
};close $f
set f [open "$out/sites.tsv" w];puts $f "site\ttype\tcells\tfree_bels"
for {set x 64} {$x <= 74} {incr x} {
 for {set y 116} {$y <= 124} {incr y} {
  set s [get_sites -quiet SLICE_X${x}Y${y}];if {![llength $s]} {continue}
  set all [lsort -unique [get_cells -quiet -of_objects [get_bels -of_objects $s]]]
  set free {}
  foreach b {A6LUT A5LUT B6LUT B5LUT C6LUT C5LUT D6LUT D5LUT AFF A5FF BFF B5FF CFF C5FF DFF D5FF} {
   set bel [get_bels -quiet ${s}/${b}]
   if {[llength $bel] && ![llength [get_cells -quiet -of_objects $bel]]} {lappend free $b}
  }
  puts $f [join [list $s [get_property SITE_TYPE $s] $all $free] "\t"]
 }
};close $f
puts STATUS_GEOMETRY_READONLY_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
