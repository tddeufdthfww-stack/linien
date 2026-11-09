foreach runDir $argv {
    puts "DETAIL_RUN $runDir"
    set out "$runDir/pid_details"
    file mkdir $out
    open_checkpoint "$runDir/routed.dcp"
    set allPid [get_cells -hier -filter {REF_NAME =~ FD* && NAME =~ *pid_int_reg_reg*}]
    foreach group {slow fast} {
        if {$group eq "slow"} {
            set cells [filter $allPid {NAME =~ *slow_chain*}]
        } else {
            set cells [filter $allPid {NAME !~ *slow_chain*}]
        }
        puts "DETAIL_GROUP $group REGISTERS [llength $cells]"
        if {[llength $cells] == 0} {error "PID registers not found: $group"}
        foreach pin {D R S CE} {
            set endpoints [get_pins -quiet -of_objects $cells -filter "REF_PIN_NAME == $pin"]
            if {[llength $endpoints] != 0} {
                report_timing -delay_type max -max_paths 20 -to $endpoints -file "$out/${group}_${pin}.rpt"
            }
        }
        set starts [get_pins -of_objects $cells -filter {REF_PIN_NAME == Q}]
        set ends [get_pins -of_objects $cells -filter {REF_PIN_NAME == D || REF_PIN_NAME == R || REF_PIN_NAME == S || REF_PIN_NAME == CE}]
        report_timing -delay_type max -max_paths 20 -from $starts -to $ends -file "$out/${group}_feedback.rpt"
    }
    set f [open "$out/dsp_registers.txt" w]
    foreach c [get_cells -hier -filter {REF_NAME == DSP48E1}] {
        puts $f "[get_property NAME $c] LOC=[get_property LOC $c] AREG=[get_property AREG $c] BREG=[get_property BREG $c] MREG=[get_property MREG $c] PREG=[get_property PREG $c]"
    }
    close $f
    close_design
}
puts PID_DETAIL_READONLY_COMPLETE
exit 0
