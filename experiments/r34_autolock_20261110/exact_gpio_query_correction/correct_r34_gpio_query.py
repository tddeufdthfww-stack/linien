from pathlib import Path
import hashlib,json,re,subprocess,shutil
h=Path(__file__).parent;r=Path('D:/RP_Dev/linien_trials/20261110-r34-gpio-status-pipeline');t=r/'gateware/build/trials/20261110_225335_r34_gpio_status_pipeline'
o=h/'r34_gpio_exact_query';o.mkdir(exist_ok=False);dcp=t/'routed.dcp';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();before=sha(dcp)
s='''open_checkpoint {%s}
set cells [get_cells -hier -quiet -filter {NAME =~ *gpio_n_o_reg* && REF_NAME =~ FD*}]
if {![llength $cells]} {error "actual GPIO output FF missing"}
report_timing -to $cells -max_paths 20 -file {%s}
puts EXACT_GPIO_QUERY_PASS
exit 0
'''%(dcp.as_posix(),(o/'gpio_outputs_exact.rpt').as_posix())
(o/'audit.tcl').write_text(s,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(o/'audit.tcl'),'-log',str(o/'vivado.log'),'-journal',str(o/'vivado.jou')]
res=subprocess.run(cmd,cwd=o,capture_output=True);(o/'stdout.log').write_bytes(res.stdout);(o/'stderr.log').write_bytes(res.stderr)
text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');assert res.returncode==0 and 'EXACT_GPIO_QUERY_PASS' in text and not re.search('(?m)^ERROR:',text),text[-6000:]
assert before==sha(dcp)
from analyze_round import worst
value=worst(o/'gpio_outputs_exact.rpt');exp=r/'experiments/r34_autolock_20261110';m=json.loads((exp/'metrics.json').read_text())
old=m['gpio_outputs_to'];m['gpio_outputs_to_initial_broad_prefix_query']=old;m['gpio_outputs_to']=value
record={'passed':True,'input_dcp_sha256':before,'dcp_unchanged':True,'old_prefix_query_included_GPIO_OES_CSR':old,'exact_output_FF_query':value,'correction':'Use *gpio_n_o_reg* not *gpio_n_o*: old prefix also matched gpio_n_oes_storage. Original reports/archive unchanged; WNS/TNS/global/other paths unaffected.'}
m['GPIO_pin_query_correction']=record
(exp/'metrics.json').write_text(json.dumps(m,indent=2),encoding='utf-8');(o/'correction.json').write_text(json.dumps(record,indent=2),encoding='utf-8')
target=exp/'exact_gpio_query_correction';target.mkdir()
for f in o.iterdir():
    if f.is_file():shutil.copyfile(f,target/f.name)
shutil.copyfile(Path(__file__),target/Path(__file__).name)
note=f'\n\nR34 GPIO报告查询更正：初次gpio_outputs_to的*gpio_n_o*前缀包含oes CSR，不能作为精确输出FF数值。改用*gpio_n_o_reg*只读重查，实际最差{value["slack"]}ns，{value["source"]}→{value["destination"]}；原报告/ZIP保留，metrics追加旧查询和更正证据，WNS/TNS/全局及其他路径不变，输入DCP SHA不变。证据见experiments/r34_autolock_20261110/exact_gpio_query_correction。\n'
for rel in ('docs/PORTING_STATUS.md','docs/OPTIMIZATION_LOG.md','docs/R34_RESULT_20261110.md'):
    p=r/rel;p.write_text(p.read_text(encoding='utf-8')+note,encoding='utf-8')
print(json.dumps(record,indent=2))
