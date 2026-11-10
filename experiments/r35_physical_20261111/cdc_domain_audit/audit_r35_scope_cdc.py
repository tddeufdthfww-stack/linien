from pathlib import Path
import hashlib,json,re,subprocess
from analyze_round import worst
h=Path(__file__).parent;r=Path('D:/RP_Dev/linien_trials/20261110-r35-index-driver-replication');t=r/'gateware/build/trials/20261110_231828_r35_index_driver_replication'
o=h/'r35_scope_cdc_audit';o.mkdir(exist_ok=False);dcp=t/'routed.dcp';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();before=sha(dcp)
s='''open_checkpoint {%s}
set cfg [get_cells -hier -quiet -filter {NAME =~ red_pitaya_scope/set_* && REF_NAME =~ FD*}]
report_timing -from [get_clocks clk_2] -to $cfg -max_paths 20 -file scope_adc_control.rpt
report_timing -from [get_clocks clk_fpga_0] -to $cfg -max_paths 20 -file scope_fclk_control.rpt
report_timing -from [get_clocks clk_2] -to [get_clocks clk_2] -max_paths 20 -file same_adc_domain.rpt
report_clock_interaction -file clock_interaction.rpt
set f [open cdc_control_registers.tsv w]
puts $f "cell\\tclock\\tASYNC_REG\\tINIT"
foreach c [get_cells -hier -quiet -filter {NAME =~ red_pitaya_scope/i_bridge/* && REF_NAME =~ FD*}] {
 set cp [get_pins -quiet -of_objects $c -filter {IS_CLOCK == 1}]
 puts $f "$c\\t[get_clocks -quiet -of_objects $cp]\\t[get_property ASYNC_REG $c]\\t[get_property INIT $c]"
}
close $f
puts SCOPE_CDC_READONLY_AUDIT_PASS
exit 0
'''%dcp.as_posix()
(o/'audit.tcl').write_text(s,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(o/'audit.tcl'),'-log',str(o/'vivado.log'),'-journal',str(o/'vivado.jou')]
res=subprocess.run(cmd,cwd=o,capture_output=True);(o/'stdout.log').write_bytes(res.stdout);(o/'stderr.log').write_bytes(res.stderr)
text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');assert res.returncode==0 and 'SCOPE_CDC_READONLY_AUDIT_PASS' in text and not re.search('(?m)^ERROR:',text),text[-6000:]
assert before==sha(dcp)
record={'passed':True,'DCP_SHA256_unchanged':before,'new_constraints':False,'new_DCP_written':False,'physical_CDC_safety':'NOT_PROVEN','paths':{n:worst(o/(n+'.rpt')) for n in ('scope_adc_control','scope_fclk_control','same_adc_domain')}}
(o/'results.json').write_text(json.dumps(record,indent=2),encoding='utf-8');print(json.dumps(record,indent=2))
