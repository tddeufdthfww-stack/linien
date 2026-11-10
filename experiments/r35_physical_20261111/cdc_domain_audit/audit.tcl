open_checkpoint {D:/RP_Dev/linien_trials/20261110-r35-index-driver-replication/gateware/build/trials/20261110_231828_r35_index_driver_replication/routed.dcp}
set cfg [get_cells -hier -quiet -filter {NAME =~ red_pitaya_scope/set_* && REF_NAME =~ FD*}]
report_timing -from [get_clocks clk_2] -to $cfg -max_paths 20 -file scope_adc_control.rpt
report_timing -from [get_clocks clk_fpga_0] -to $cfg -max_paths 20 -file scope_fclk_control.rpt
report_timing -from [get_clocks clk_2] -to [get_clocks clk_2] -max_paths 20 -file same_adc_domain.rpt
report_clock_interaction -file clock_interaction.rpt
set f [open cdc_control_registers.tsv w]
puts $f "cell\tclock\tASYNC_REG\tINIT"
foreach c [get_cells -hier -quiet -filter {NAME =~ red_pitaya_scope/i_bridge/* && REF_NAME =~ FD*}] {
 set cp [get_pins -quiet -of_objects $c -filter {IS_CLOCK == 1}]
 puts $f "$c\t[get_clocks -quiet -of_objects $cp]\t[get_property ASYNC_REG $c]\t[get_property INIT $c]"
}
close $f
puts SCOPE_CDC_READONLY_AUDIT_PASS
exit 0
