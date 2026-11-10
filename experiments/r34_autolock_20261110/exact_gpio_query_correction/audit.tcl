open_checkpoint {D:/RP_Dev/linien_trials/20261110-r34-gpio-status-pipeline/gateware/build/trials/20261110_225335_r34_gpio_status_pipeline/routed.dcp}
set cells [get_cells -hier -quiet -filter {NAME =~ *gpio_n_o_reg* && REF_NAME =~ FD*}]
if {![llength $cells]} {error "actual GPIO output FF missing"}
report_timing -to $cells -max_paths 20 -file {C:/Users/admin/Documents/Codex/2026-11-05/ba/work/r6_execution/r34_gpio_exact_query/gpio_outputs_exact.rpt}
puts EXACT_GPIO_QUERY_PASS
exit 0
