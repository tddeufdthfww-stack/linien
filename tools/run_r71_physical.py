"""Reproducible placement/routing-only trial on an immutable parent routed DCP."""
from pathlib import Path
import argparse,difflib,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--input-dcp',required=True,type=Path);p.add_argument('--out',required=True,type=Path);a=p.parse_args()
dcp=a.input_dcp.resolve();out=(ROOT/a.out).resolve();assert dcp.is_file()
assert not any(c in str(dcp)+str(out) for c in '{}')
out.mkdir(parents=True,exist_ok=False);digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
parent=json.loads((dcp.parent/'manifest.json').read_text(encoding='utf-8'))
assert parent['head']=='444ea6a9f029093bfdd2c9fc42d1049d9fb56f00' and parent['route']=='COMPLETE'
proof=json.loads((dcp.parent/'placement_annotation_identity_proof.json').read_text(encoding='utf-8'))
assert proof['passed'] and proof['all_logic_parameters_initialization_connections_identical']
assert proof['output_dcp_sha256']==digest==parent['output_dcp_sha256']
hardware={n:h for n,h in parent['source_hashes'].items() if n.startswith(('gateware/','hardware/','linien-common/')) and not n.startswith(('gateware/tests/','gateware/build/'))}
assert all((ROOT/n).is_file() and hashlib.sha256((ROOT/n).read_bytes()).hexdigest()==h for n,h in hardware.items())
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
status=subprocess.check_output(['git','status','--short'],cwd=ROOT,text=True)
assert not status,'Commit the reviewable physical-trial recipe before running'
meta={'head':head,'branch':subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip(),'source_hashes':hardware,'input_dcp':str(dcp),'input_dcp_sha256':digest,'input_source_head':parent['head'],'synthesis':'REUSED_R69_NOT_NEW_SYNTHESIS','route':'RUNNING','functional':'R69B_FRESH_CONTRACT_RUN_PENDING_OR_SEPARATE','new_data_pipeline_stages':0,'timing_signoff':'NOT_EVALUATED','optimizations':['placement_opt','routing_opt'],'tns_cleanup':'UNSUPPORTED_ON_Z7020_NOT_USED','optimization_path_group':'clk_2 (all clock groups remain timed/reported)','excluded_optimizations':['retime','negative_edge_ff_insertion','register_optimization','cell_replication','rewire','clock_opt'],'clock_or_exception_changes':False}
for name in ['synth_timing.rpt','synth_utilization.rpt','top.v','top.xdc','top.tcl','csrmap.py']:
 assert (dcp.parent/name).is_file();shutil.copyfile(dcp.parent/name,out/name)
meta['reused_files_sha256']={n:hashlib.sha256((out/n).read_bytes()).hexdigest() for n in ['synth_timing.rpt','synth_utilization.rpt','top.v','top.xdc','top.tcl','csrmap.py']}
def save(): (out/'manifest.json').write_text(json.dumps(meta,indent=2),encoding='utf-8')
save()
tcl='set_param general.maxThreads 2\nopen_checkpoint {'+dcp.as_posix()+'}\n'+r'''
write_verilog -force -mode funcsim logical_before.v
# Explicit options disable all implicit optimization categories. No retiming,
# FF insertion, DSP/BRAM register optimization, duplication, rewire or clock_opt.
phys_opt_design -placement_opt -routing_opt -path_groups clk_2
route_design -directive Explore
report_route_status -file routed_status.rpt
report_timing_summary -max_paths 30 -file routed_timing.rpt
report_timing -delay_type max -max_paths 100 -file routed_setup.rpt
report_timing -delay_type min -max_paths 30 -file routed_hold.rpt
report_timing -from [get_clocks clk_2] -to [get_clocks clk_2] -max_paths 50 -file core_sys_setup.rpt
check_timing -verbose -file routed_checks.rpt
report_cdc -details -file routed_cdc.rpt
report_drc -file routed_drc.rpt
report_utilization -file routed_utilization.rpt
report_clock_interaction -file routed_clocks.rpt
write_verilog -force -mode funcsim logical_after.v
write_checkpoint -force routed.dcp
puts R71_PLACEMENT_ROUTING_ONLY_COMPLETE
'''
script=out/'implementation.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')]
print('R71_PHYSICAL_RUNNING',str(out),flush=True)
r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(r.stdout);(out/'implementation.stderr.log').write_bytes(r.stderr)
text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and 'R71_PLACEMENT_ROUTING_ONLY_COMPLETE' in text and not re.search('(?m)^ERROR:',text)
meta.update(command=cmd,exit_code=r.returncode,route='COMPLETE' if ok else 'FAIL',input_dcp_unchanged=hashlib.sha256(dcp.read_bytes()).hexdigest()==digest)
meta['source_changes_during_run']=[n for n,h in hardware.items() if hashlib.sha256((ROOT/n).read_bytes()).hexdigest()!=h]
def normalize(source):
 # Preserve string contents and all logic parameters; remove comments and
 # standalone physical LOC/BEL and exact PLACEMENT_OPT annotations only. All other tokens stay strict.
 source=re.sub(r'"(?:\\.|[^"\\])*"|//[^\n]*|/\*.*?\*/',lambda m:m[0] if m[0].startswith('"') else '',source,flags=re.S)
 source=re.sub(r'\(\*\s*(?:LOC|BEL)\s*=\s*"[^"\n]*"\s*\*\)','',source)
 source=source.replace('(* PHYS_OPT_MODIFIED = "PLACEMENT_OPT" *)','')
 return '\n'.join(line.strip() for line in source.splitlines() if line.strip())
if ok:
 before=normalize((out/'logical_before.v').read_text(errors='replace'));after=normalize((out/'logical_after.v').read_text(errors='replace'))
 meta['logical_tokens_identical_without_physical_placement_annotations']=before==after
 meta['input_logic_matches_proved_r70']=hashlib.sha256(before.encode()).hexdigest()==proof['canonical_logic_sha256']
 meta['normalized_netlist_sha256']={'before':hashlib.sha256(before.encode()).hexdigest(),'after':hashlib.sha256(after.encode()).hexdigest()}
 if before!=after:
  diff='\n'.join(difflib.unified_diff(before.splitlines(),after.splitlines(),fromfile='before',tofile='after'))
  (out/'logical_diff.txt').write_text(diff,encoding='utf-8')
 def timing(path):
  s=path.read_text(errors='replace');m=re.search(r'^\s*(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)\s+(\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)\s+(\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)',s,re.M);assert m
  names=['wns','tns','setup_failing','setup_total','whs','ths','hold_failing','hold_total','wpws','tpws','pulse_failing']
  return dict(zip(names,[int(v) if i in [2,3,6,7,10] else float(v) for i,v in enumerate(m.groups())]))
 meta['route_metrics']=timing(out/'routed_timing.rpt');meta['synth_metrics_reused_r69']=timing(out/'synth_timing.rpt')
 meta['timing_signoff']='INCOMPLETE: actual STA/IO/CDC/DRC review required even when flow completes'
 meta['output_dcp_sha256']=hashlib.sha256((out/'routed.dcp').read_bytes()).hexdigest()
save();assert meta['input_dcp_unchanged'] and not meta['source_changes_during_run']
print(json.dumps({k:v for k,v in meta.items() if k not in ['source_hashes','reused_files_sha256','command']},indent=2),flush=True)
assert ok,text[-4000:]
assert meta['input_logic_matches_proved_r70'],'Input no longer matches independently proved R70 canonical logic'
assert meta['logical_tokens_identical_without_physical_placement_annotations'],'Logical export changed; retain results for diagnosis, do not accept equivalence'
print('R71_PHYSICAL_FLOW_AND_STRICT_LOGICAL_NETLIST_IDENTITY_PASS_NOT_SIGNOFF',flush=True)
