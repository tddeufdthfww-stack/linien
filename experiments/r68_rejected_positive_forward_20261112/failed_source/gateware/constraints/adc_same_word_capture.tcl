# R63 source-synchronous sample definition, NOT a relaxed compute path.
# Word[n] is launched 0..0.6 ns after external CLKOUT+ edge n. Its IOB
# capture uses the corresponding PLL/sys rising edge n plus its actual
# insertion delay. Setup must therefore be checked at edge n (0-cycle),
# and hold against the next incoming word at edge n+1 (8 ns later).
# This reduces setup time by 8 ns vs default and retains a real hold check.
# See docs/R63_ADC_CAPTURE_PROTOCOL.md for equations, evidence and limits.
if {[llength $r62_adc_ports] != 28} {error "Expected exact 28 ADC input ports"}
set r63_adc_pins [all_fanout -flat -endpoints_only -from $r62_adc_ports]
if {[llength $r63_adc_pins] != 28} {error "ADC fanout no longer has exactly 28 capture endpoints"}
foreach p $r63_adc_pins {
    set c [get_cells -of_objects $p]
    if {[get_property REF_PIN_NAME $p] ne "D" || [get_property REF_NAME $c] ne "FDRE" ||
        [get_property IS_C_INVERTED $c] ne "1'b0" || [get_property IOB $c] ne "TRUE"} {
        error "Unexpected ADC capture structure at $p"
    }
}
set_multicycle_path 0 -setup -end -from $r62_adc_ports -to $r63_adc_pins
puts R63_ADC_SAME_WORD_ZERO_CYCLE_SETUP_TIGHTENED
