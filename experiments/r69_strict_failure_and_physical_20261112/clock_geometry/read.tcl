if {[catch {
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r69-timeout-cancel/gateware/build/trials/20261112_052126_r69_timeout_cancel_implementation/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r69_clock_geometry}

set_param general.maxThreads 2
set f [open "$out/dac_driver_geometry.tsv" w]
puts $f "port	driver_cell	ref	loc	region	clock_pin_net"
foreach p [get_ports {dac_data[*] dac_wrt dac_clk dac_sel dac_rst}] {
 set bufs [get_cells -of_objects [get_nets -of_objects $p] -filter {REF_NAME =~ OBUF*}]
 if {[llength $bufs]!=1} {error "No unique OBUF for $p"}
 set ip [get_pins -of_objects $bufs -filter {REF_PIN_NAME == I}]
 set drivers [get_cells -of_objects [get_pins -of_objects [get_nets -of_objects $ip] -filter {DIRECTION == OUT}]]
 foreach c $drivers {
  set cp [get_pins -quiet -of_objects $c -filter {REF_PIN_NAME == C}]
  puts $f [join [list [get_property NAME $p] [get_property NAME $c] [get_property REF_NAME $c] [get_property LOC $c] [get_clock_regions -quiet -of_objects [get_sites -quiet -of_objects $c]] [get_nets -quiet -of_objects $cp]] "	"]
 }
}
close $f
puts DAC_GEOMETRY_READONLY_COMPLETE

} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
