"""Frozen R38 synthesis, explicit Scope CE->D, fresh implementation; no bitstream."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    p=argparse.ArgumentParser();p.add_argument('--input-trial',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
    previous=a.input_trial.resolve();old=json.loads((previous/'manifest.json').read_text());assert old['functional']=='PASS' and old['synthesis']=='COMPLETE' and old['route']=='COMPLETE'
    leaf=ROOT/'gateware/build/control_enable_leaf_r39_explicit/results.json';leaf_result=json.loads(leaf.read_text());assert leaf_result['passed'] and leaf_result['FF_before']==leaf_result['FF_after']==78 and leaf_result['all_CE_after_VCC']
    names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
    same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
    out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
    files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
    hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=previous/'synth.dcp';before=sha(dcp)
    manifest={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r38_trial':str(previous),'input_checkpoint_kind':'SYNTH_UNPLACED','input_dcp_sha256':before,'r38_code_and_test_hash_matches':same,'functional':'REUSED_R38_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R38_EXACT_DCP_NOT_RERUN','new_native_postopt_leaf':leaf_result,'logical_opt':'NOT RUN','route':'NOT RUN','timing_signoff':'NOT EVALUATED','new_ADC_robust_GPIO_cycles':0,'optimization':'Explicit CE-to-D on nonconstant-enable Scope set_* FDRE/FDSE only; LUT3 INIT8hAC, CE=1, FF state boundary protected. Same normal opt/place/phys/route flow as R38; no clock/exception/RTL changes.'}
    mp=out/'manifest.json';mp.write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):shutil.copyfile(previous/n,out/n)
    tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{dcp.as_posix()}}}\nset helper {{{(ROOT/"tools/control_enable_remap.tcl").as_posix()}}}\n'+r'''
set_param general.maxThreads 2
open_checkpoint $input_dcp
source $helper
set candidates [get_cells -hier -quiet -filter {NAME =~ red_pitaya_scope/set_* && (REF_NAME == FDRE || REF_NAME == FDSE)}]
set targets {}
foreach c $candidates {
 set cp [get_pins -of_objects $c -filter {REF_PIN_NAME == C}]
 if {[get_clocks -of_objects $cp] ne "clk_2"} {error "Unexpected Scope configuration clock: $c"}
 set net [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == CE}]]
 set drv [get_cells -quiet -of_objects [get_pins -quiet -of_objects $net -filter {DIRECTION == OUT}]]
 set ref ""
 if {[llength $drv]} {set ref [get_property REF_NAME $drv]}
 if {$ref ni {VCC GND}} {lappend targets $c}
}
if {![llength $targets]} {error "No live Scope configuration enables"}
proc target_table {file cells} {
 set f [open $file w];puts $f "cell\tref\tCE_net\tCE_driver_ref\tINIT\tDONT_TOUCH"
 foreach c $cells {
  set n [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == CE}]]
  set drv [get_cells -quiet -of_objects [get_pins -quiet -of_objects $n -filter {DIRECTION == OUT}]]
  set ref "INPUT_PORT"
  if {[llength $drv]} {set ref [get_property REF_NAME $drv]}
  puts $f "$c\t[get_property REF_NAME $c]\t$n\t$ref\t[get_property INIT $c]\t[get_property DONT_TOUCH $c]"
 };close $f
}
target_table "$out/scope_targets_before.tsv" $targets
set count [explicit_enable_to_d $targets]
puts "SCOPE_ENABLE_REMAP_COUNT $count"
target_table "$out/scope_targets_after_rewire.tsv" $targets
opt_design
target_table "$out/scope_targets_after_opt.tsv" $targets
report_utilization -file "$out/opt_utilization.rpt"
report_timing_summary -file "$out/opt_timing.rpt"
write_checkpoint "$out/opt.dcp"
puts SCOPE_LOGICAL_OPT_COMPLETE
place_design
phys_opt_design
route_design
target_table "$out/scope_targets_after_route.tsv" $targets
report_route_status -file "$out/routed_status.rpt"
report_timing_summary -max_paths 30 -file "$out/routed_timing.rpt"
report_timing -max_paths 100 -file "$out/routed_setup.rpt"
report_timing -delay_type min -max_paths 30 -file "$out/routed_hold.rpt"
report_utilization -file "$out/routed_utilization.rpt"
check_timing -verbose -file "$out/routed_checks.rpt"
report_cdc -details -file "$out/routed_cdc.rpt"
report_drc -file "$out/routed_drc.rpt"
report_clock_interaction -file "$out/routed_clocks.rpt"
report_exceptions -file "$out/routed_exceptions.rpt"
write_checkpoint "$out/routed.dcp"
puts SCOPE_ENABLE_IMPLEMENTATION_COMPLETE
'''
    script=out/'implementation.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
    cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
    res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
    text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and 'SCOPE_ENABLE_IMPLEMENTATION_COMPLETE' in text and not re.search('(?m)^ERROR:',text)
    (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok),'marker':'SCOPE_ENABLE_IMPLEMENTATION_COMPLETE'},indent=2),encoding='utf-8')
    changed=[n for n,h in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=h]
    manifest.update(logical_opt='COMPLETE' if 'SCOPE_LOGICAL_OPT_COMPLETE' in text else 'FAIL',route='COMPLETE' if ok else 'FAIL',input_r38_dcp_unchanged=before==sha(dcp),source_changes_during_run=changed)
    mp.write_text(json.dumps(manifest,indent=2),encoding='utf-8');assert ok and not changed and manifest['input_r38_dcp_unchanged'],text[-6000:]
    print('SCOPE_ENABLE_TRIAL_COMPLETE',flush=True)
if __name__=='__main__':main()
