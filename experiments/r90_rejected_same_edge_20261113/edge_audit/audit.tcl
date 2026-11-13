open_checkpoint {D:/RP_Dev/linien_trials/20261113-r90-matched-oddr/gateware/build/r90_physical01/routed.dcp}
set_param general.maxThreads 2
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r90_edge_audit01}

set cells [get_cells -hier -filter {REF_NAME == ODDR && DDR_CLK_EDGE == SAME_EDGE}]
if {[llength $cells]!=14} {error "14cells"}
set clocks [get_clocks -of_objects [get_pins [lindex $cells 0]/C]]
if {[llength $clocks]!=1} {error "clock"}
foreach edge {rise fall} {
 foreach typ {max min} {
  report_timing -${edge}_from $clocks -to [get_ports {dac_data[*]}] -delay_type $typ -path_type full_clock_expanded -input_pins -max_paths 14 -file "$out/${edge}_${typ}.rpt"
 }
}
puts R90_EDGES_EXPORTED
