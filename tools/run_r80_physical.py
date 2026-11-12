"""Reproducible placement/routing-only trial on an immutable parent routed DCP."""
from pathlib import Path
import argparse,difflib,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--input-dcp',required=True,type=Path);p.add_argument('--out',required=True,type=Path);a=p.parse_args()
dcp=a.input_dcp.resolve();out=(ROOT/a.out).resolve();assert dcp.is_file()
assert not any(c in str(dcp)+str(out) for c in '{}')
out.mkdir(parents=True,exist_ok=False);digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
parent=json.loads((dcp.parent/'manifest.json').read_text(encoding='utf-8'))
assert digest=='697b393c087361d7c8356967a2a4fcff35d9243f1a724b3ee79bf03e9b7f6f12'
assert parent['head']=='cbdbc736119c699c9022598afa7a6442b9783845' and parent['route']=='COMPLETE'
assert not parent['source_changes_during_run'] and 'failure' not in parent
hardware={n:h for n,h in parent['source_hashes'].items() if n.startswith(('gateware/','hardware/','linien-common/')) and not n.startswith(('gateware/tests/','gateware/build/'))}
assert all((ROOT/n).is_file() and hashlib.sha256((ROOT/n).read_bytes()).hexdigest()==h for n,h in hardware.items())
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
status=subprocess.check_output(['git','status','--short'],cwd=ROOT,text=True)
assert not status,'Commit the reviewable physical-trial recipe before running'
meta={'head':head,'branch':subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip(),'source_hashes':hardware,'input_dcp':str(dcp),'input_dcp_sha256':digest,'input_source_head':parent['head'],'synthesis':'REUSED_R78_NOT_NEW_SYNTHESIS','route':'RUNNING','functional':'R78_TARGETED_72000_LIMIT_32000_FASTCHAIN_PASS_FRESH_FULL_RUNNING_SEPARATE','new_data_pipeline_stages':0,'timing_signoff':'NOT_EVALUATED','optimizations':['manual_four_existing_status_cells'],'tns_cleanup':'UNSUPPORTED_ON_Z7020_NOT_USED','optimization_path_group':'specific existing GPIO status cone (all clocks remain timed/reported)','excluded_optimizations':['retime','negative_edge_ff_insertion','register_optimization','cell_replication','rewire','clock_opt'],'clock_or_exception_changes':False}
for name in ['synth_timing.rpt','synth_utilization.rpt','top.v','top.xdc','top.tcl','csrmap.py']:
 assert (dcp.parent/name).is_file();shutil.copyfile(dcp.parent/name,out/name)
meta['reused_files_sha256']={n:hashlib.sha256((out/n).read_bytes()).hexdigest() for n in ['synth_timing.rpt','synth_utilization.rpt','top.v','top.xdc','top.tcl','csrmap.py']}
def save(): (out/'manifest.json').write_text(json.dumps(meta,indent=2),encoding='utf-8')
save()
tcl='set_param general.maxThreads 2\nopen_checkpoint {'+dcp.as_posix()+'}\n'+r'''
write_verilog -force -mode funcsim logical_before.v
# Explicit options disable all implicit optimization categories. No retiming,
# FF insertion, DSP/BRAM register optimization, duplication, rewire or clock_opt.

# Exact geometry checked on the immutable parent; change placement only.
proc exact_cell {name} {
 set c [get_cells -hier -quiet -filter "NAME == \"$name\""]
 if {[llength $c] != 1} {error "Expected exact cell $name"};return $c
}
set target_site [get_sites SLICE_X67Y118]
if {[llength [get_cells -quiet -of_objects [get_bels -of_objects $target_site]]]} {error "Chosen parent slice is no longer empty"}
set assignments [list {linienmodule_gpio_n_o[7]_i_2} SLICE_X67Y118/A6LUT \
                      {linienmodule_gpio_n_o[7]_i_1} SLICE_X67Y118/B6LUT \
                      {linienmodule_gpio_n_o_reg[7]} SLICE_X67Y118/BFF \
                      {linienmodule_gpio_n_o_reg[7]_lopt_replica} SLICE_X67Y118/CFF]
set moved {};set f [open manual_locations_before.tsv w];puts $f "cell\tref\tLOC\tBEL"
foreach {name bel} $assignments {
 set c [exact_cell $name];lappend moved $c
 puts $f [join [list $name [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c]] "\t"]
 set_property IS_LOC_FIXED false $c;set_property IS_BEL_FIXED false $c
};close $f
set q0 [exact_cell {linienmodule_gpio_n_o_reg[7]}]
set q1 [exact_cell {linienmodule_gpio_n_o_reg[7]_lopt_replica}]
foreach p {C R CE} {
 if {[get_nets -of_objects [get_pins -of_objects $q0 -filter "REF_PIN_NAME == $p"]] ne [get_nets -of_objects [get_pins -of_objects $q1 -filter "REF_PIN_NAME == $p"]]} {error "GPIO copies disagree on $p"}
}
place_cell $assignments
set_property IS_LOC_FIXED true $moved
set_property IS_BEL_FIXED true $moved
set f [open manual_locations_after.tsv w];puts $f "cell\tref\tLOC\tBEL"
foreach {name expected} $assignments {
 set c [exact_cell $name];set location [get_property LOC $c];set bel [get_property BEL $c]
 if {$location ne "SLICE_X67Y118" || ![string match "*.[lindex [split $expected /] 1]" $bel]} {error "Unexpected moved location for $name"}
 puts $f [join [list $name [get_property REF_NAME $c] $location $bel] "\t"]
};close $f

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
puts R80_PLACEMENT_ROUTING_ONLY_COMPLETE
'''
script=out/'implementation.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')]
print('R80_PHYSICAL_RUNNING',str(out),flush=True)
r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(r.stdout);(out/'implementation.stderr.log').write_bytes(r.stderr)
text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and 'R80_PLACEMENT_ROUTING_ONLY_COMPLETE' in text and not re.search('(?m)^ERROR:',text)
meta.update(command=cmd,exit_code=r.returncode,route='COMPLETE' if ok else 'FAIL',input_dcp_unchanged=hashlib.sha256(dcp.read_bytes()).hexdigest()==digest)
meta['source_changes_during_run']=[n for n,h in hardware.items() if hashlib.sha256((ROOT/n).read_bytes()).hexdigest()!=h]
def normalize(source):
 # Preserve string contents and all logic parameters; remove comments and
 # standalone physical LOC/BEL and exact PLACEMENT_OPT annotations only. All other tokens stay strict.
 source=re.sub(r'"(?:\\.|[^"\\])*"|//[^\n]*|/\*.*?\*/',lambda m:m[0] if m[0].startswith('"') else '',source,flags=re.S)
 source=re.sub(r'\(\*\s*(?:LOC|BEL)\s*=\s*"[^"\n]*"\s*\*\)','',source)
 source=re.sub(r'\(\*\s*PHYS_OPT_MODIFIED\s*=\s*"[^"]*"\s*\*\)','',source)
 source=re.sub(r'\(\*\s*\\PinAttr:[A-Za-z0-9_\[\]]+:HOLD_DETOUR\s*=\s*"\d+"\s*\*\)','',source)
 return '\n'.join(line.strip() for line in source.splitlines() if line.strip())
if ok:
 before=normalize((out/'logical_before.v').read_text(errors='replace'));after=normalize((out/'logical_after.v').read_text(errors='replace'))
 meta['logical_tokens_identical_without_known_physical_annotations']=before==after
 meta['input_checkpoint_sha256_verified_unchanged']=hashlib.sha256(dcp.read_bytes()).hexdigest()==digest
 meta['normalized_netlist_sha256']={'before':hashlib.sha256(before.encode()).hexdigest(),'after':hashlib.sha256(after.encode()).hexdigest()}
 if before!=after:
  diff='\n'.join(difflib.unified_diff(before.splitlines(),after.splitlines(),fromfile='before',tofile='after'))
  (out/'logical_diff.txt').write_text(diff,encoding='utf-8')
 def timing(path):
  s=path.read_text(errors='replace');m=re.search(r'^\s*(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)\s+(\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)\s+(\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(\d+)',s,re.M);assert m
  names=['wns','tns','setup_failing','setup_total','whs','ths','hold_failing','hold_total','wpws','tpws','pulse_failing']
  return dict(zip(names,[int(v) if i in [2,3,6,7,10] else float(v) for i,v in enumerate(m.groups())]))
 meta['route_metrics']=timing(out/'routed_timing.rpt');meta['synth_metrics_reused_r78']=timing(out/'synth_timing.rpt')
 meta['timing_signoff']='INCOMPLETE: actual STA/IO/CDC/DRC review required even when flow completes'
 meta['output_dcp_sha256']=hashlib.sha256((out/'routed.dcp').read_bytes()).hexdigest()
save();assert meta['input_dcp_unchanged'] and not meta['source_changes_during_run']
print(json.dumps({k:v for k,v in meta.items() if k not in ['source_hashes','reused_files_sha256','command']},indent=2),flush=True)
assert ok,text[-4000:]
assert meta['input_checkpoint_sha256_verified_unchanged'],'Parent input checkpoint changed'
assert meta['logical_tokens_identical_without_known_physical_annotations'],'Logical export changed; retain results for diagnosis, do not accept equivalence'
print('R80_PHYSICAL_FLOW_AND_STRICT_LOGICAL_NETLIST_IDENTITY_PASS_NOT_SIGNOFF',flush=True)
