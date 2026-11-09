# Read-only DCP inspection. Output must be new; source DCP is never rewritten.
if {[llength $argv] != 2} {puts stderr "usage: <checkpoint> <new-output-directory>"; exit 2}
set checkpoint [file normalize [lindex $argv 0]]
set out [file normalize [lindex $argv 1]]
if {![file isfile $checkpoint] || [file exists $out]} {
    puts stderr "ERROR: checkpoint missing or output already exists"; exit 2
}
file mkdir $out
if {[catch {
open_checkpoint $checkpoint
set inventory [open "$out/pin_inventory.txt" w]
foreach scope {integrator all_pid} {
    foreach group {fast slow} {
        if {$group eq "fast"} {set pattern *logic_pid_*} else {set pattern *slow_chain_pid_*}
        set cells [get_cells -hier -filter "REF_NAME =~ FD* && NAME =~ $pattern"]
        if {$scope eq "integrator"} {set cells [filter $cells {NAME =~ *int_reg_reg*}]}
        if {![llength $cells]} {error "No cells for $scope $group"}
        puts $inventory "$scope $group CELLS [llength $cells]"
        foreach pin {D S R CE} {
            set ends [get_pins -quiet -of_objects $cells -filter "REF_PIN_NAME == $pin"]
            puts $inventory "$scope $group $pin PINS [llength $ends]"
            if {[llength $ends]} {
                report_timing -delay_type max -max_paths 20 -to $ends -file "$out/${scope}_${group}_${pin}.rpt"
            }
        }
        if {$scope eq "integrator"} {
            set starts [get_pins -of_objects $cells -filter {REF_PIN_NAME == Q}]
            set ends [get_pins -of_objects $cells -filter {REF_PIN_NAME == D || REF_PIN_NAME == R || REF_PIN_NAME == S || REF_PIN_NAME == CE}]
            report_timing -delay_type max -max_paths 20 -from $starts -to $ends -file "$out/${group}_feedback.rpt"
        }
    }
}
close $inventory
set f [open "$out/dsp_registers.txt" w]
foreach c [get_cells -hier -filter {REF_NAME == DSP48E1}] {
    puts $f "$c LOC=[get_property LOC $c] AREG=[get_property AREG $c] BREG=[get_property BREG $c] MREG=[get_property MREG $c] PREG=[get_property PREG $c]"
}
close $f
set f [open "$out/critical_cells.txt" w]
foreach group {fast slow} {
    if {$group eq "fast"} {set pattern *logic_pid*int_reg_reg*} else {set pattern *slow_chain_pid_int_reg_reg*}
    set cells [get_cells -hier -filter "REF_NAME =~ FD* && NAME =~ $pattern"]
    foreach pin {D S R CE} {
        set ends [get_pins -quiet -of_objects $cells -filter "REF_PIN_NAME == $pin"]
        if {![llength $ends]} {continue}
        foreach path [get_timing_paths -quiet -max_paths 1 -to $ends] {
            puts $f "GROUP $group $pin"
            foreach c [all_fanin -flat -levels 2 -only_cells -to [get_property ENDPOINT_PIN $path]] {
                set ref [get_property REF_NAME $c]
                if {[string match LUT* $ref]} {
                    puts $f "$c $ref INIT=[get_property INIT $c]"
                    foreach p [get_pins -of_objects $c -filter {DIRECTION == IN}] {
                        set net [get_nets -of_objects $p]
                        puts $f "  $p NET=$net DRIVER=[get_pins -quiet -of_objects $net -filter {DIRECTION == OUT}]"
                    }
                } else {puts $f "$c $ref"}
            }
        }
    }
}
close $f
# Include DSP internal sequential endpoints, which FD-only groups omit.
set fastDsp {}
foreach c [get_cells -hier -filter {REF_NAME == DSP48E1}] {
    set inputs [get_pins -of_objects $c -filter {DIRECTION == IN}]
    set nets [get_nets -of_objects $inputs]
    set drivers [get_pins -quiet -of_objects $nets -filter {DIRECTION == OUT}]
    if {[regexp {linienmodule_logic_pid} "$nets $drivers"]} {lappend fastDsp $c}
}
set f [open "$out/fast_dsp_cells.txt" w]
puts $f $fastDsp
close $f
if {[llength $fastDsp]} {
    report_timing -delay_type max -max_paths 30 -to $fastDsp -file "$out/fast_dsp_endpoints.rpt"
    report_timing -delay_type max -max_paths 30 -from $fastDsp -file "$out/fast_dsp_starts.rpt"
}
set fastData [get_cells -hier -filter {REF_NAME =~ FD* && NAME =~ *logic_pid_* && NAME !~ *storage*}]
report_timing -delay_type max -max_paths 30 -to [concat $fastData $fastDsp] -file "$out/fast_datapath.rpt"
puts R4_PID_READONLY_COMPLETE
} msg opts]} {
    puts stderr "ERROR: $msg"
    puts stderr [dict get $opts -errorinfo]
    exit 3
}
exit 0


