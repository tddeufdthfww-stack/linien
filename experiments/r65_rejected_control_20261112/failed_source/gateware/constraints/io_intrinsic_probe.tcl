# R62 necessary silicon-only feasibility budget. ZERO PCB differential skew
# is a diagnostic assumption, not a measured board property or final signoff.
# LTC2145 CMOS data vs CLKOUT+ rising: tSKEW 0..0.6 ns.
# AD9767 RevG data vs IQWRT rising: setup 2 ns, hold 1.5 ns.
# IQSEL, reset, clock/wrt ordering and the 3.5 ns pulse specification must
# be reviewed separately. This file never cuts any timing path.
proc r62_forwarded_clock {name port} {
    set found {}
    foreach c [get_cells -hier -filter {REF_NAME == ODDR}] {
        set q [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]]
        if {$q eq "${port}_OBUF"} {lappend found $c}
    }
    if {[llength $found] != 1} {error "Cannot uniquely trace forwarded clock $port: $found"}
    set cp [get_pins -of_objects [lindex $found 0] -filter {REF_PIN_NAME == C}]
    create_generated_clock -name $name -source $cp -divide_by 1 -invert [get_ports $port]
}
r62_forwarded_clock dac_write dac_wrt
r62_forwarded_clock dac_sample dac_clk
set r62_adc_ports {}
foreach p [get_ports {adc_data_a[*] adc_data_b[*]}] {
    if {[regexp {^adc_data_[ab]\[([0-9]+)\]$} [get_property NAME $p] whole index] && $index >= 2} {
        lappend r62_adc_ports $p
    }
}
set r62_dac_ports [get_ports {dac_data[*]}]
if {[llength $r62_adc_ports] != 28 || [llength $r62_dac_ports] != 14} {
    error "Unexpected active ADC/DAC port count"
}
set_input_delay -clock [get_clocks clk125_p] -min 0.0 $r62_adc_ports
set_input_delay -clock [get_clocks clk125_p] -max 0.6 $r62_adc_ports
set_output_delay -clock [get_clocks dac_write] -max 2.0 $r62_dac_ports
set_output_delay -clock [get_clocks dac_write] -min -1.5 $r62_dac_ports
puts R62_INTRINSIC_IO_DIAGNOSTIC_LOADED_NOT_BOARD_SIGNOFF
