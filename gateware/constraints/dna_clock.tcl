# Exact existing DNA topology: cnt[0] toggles every 125 MHz sys edge
# during the 128-edge startup burst, then stops. No clock frequency is relaxed.
# DS187 v1.21: DNA_PORT maximum clock 100 MHz; this derived clock is 62.5 MHz.
# Keep READ/DIN and DOUT paths timed; no false/multicycle/clock-group exception.
set dna_divider [get_cells -quiet {linienmodule_dna_cnt_reg[0]}]
if {[llength $dna_divider] != 1 || [get_property REF_NAME $dna_divider] ne "FDRE"} {
    error "Expected original DNA counter bit0 FDRE"
}
set dna_parent [get_pins -of_objects $dna_divider -filter {REF_PIN_NAME == C}]
set dna_q [get_pins -of_objects $dna_divider -filter {REF_PIN_NAME == Q}]
set dna_master [get_clocks -of_objects $dna_parent]
if {[llength $dna_master] != 1 || abs([get_property PERIOD $dna_master]-8.0)>0.0001} {
    error "DNA derivation requires actual 8 ns sys clock"
}
if {[llength [get_clocks -quiet dna_clk]]} {error "Refuse duplicate DNA clock"}
create_generated_clock -name dna_clk -source $dna_parent -divide_by 2 $dna_q
if {abs([get_property PERIOD [get_clocks dna_clk]]-16.0)>0.0001} {
    error "Incorrect derived DNA period"
}
