if {[catch {
open_checkpoint {D:/RP_Dev/linien_trials/20261112-r80-status-cluster/gateware/build/trials/20261112_r80_status_cluster/routed.dcp}
set out {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r61_signoff/r81_clock_sites}

set_param general.maxThreads 2
set f [open "$out/sites.tsv" w];puts $f "site\ttype\tregion\tcells"
foreach s [get_sites -of_objects [get_clock_regions X1Y2] -filter {SITE_TYPE =~ BUFIO* || SITE_TYPE =~ MMCME2* || SITE_TYPE =~ BUFR*}] {
 puts $f [join [list $s [get_property SITE_TYPE $s] [get_clock_regions -of_objects $s] [get_cells -quiet -of_objects [get_bels -of_objects $s]]] "\t"]
};close $f
puts R81_CLOCK_SITES_READONLY_COMPLETE

} msg opts]} {puts stderr $msg;puts stderr [dict get $opts -errorinfo];exit 3}
exit 0
