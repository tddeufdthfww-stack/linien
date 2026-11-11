"""R47 routed checkpoint refinement, frozen inputs, explicit physical options."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',required=True,type=Path);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 previous=a.input_trial.resolve();old=json.loads((previous/'manifest.json').read_text())
 assert old['route']=='COMPLETE' and old['functional']=='REUSED_R46_EXACT_INPUTS_NOT_RERUN' and old['synthesis']=='REUSED_R46_EXACT_DCP_NOT_RERUN' and old['input_r46_dcp_unchanged']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=previous/'routed.dcp';before=sha(dcp)
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r47_trial':str(previous),'input_dcp_sha256':before,'r47_code_and_test_hash_matches':same,'functional':'REUSED_R46_VIA_R47_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R46_VIA_R47_EXACT_DCP_NOT_RERUN','postopt':'NOT_RUN','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_ADC_CSR_feedback_cycles':0,'optimization':'Post-route compatible placement/routing/rewire/critical-cell only, then actual Explore/tns_cleanup route. No phys tns_cleanup or critical_pin_opt; initial rejected options archived. No unroute-first selection, retime, clock_opt, DSP/BRAM register changes, new edge FFs or constraints.'}
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):
  if (previous/n).exists():shutil.copyfile(previous/n,out/n)
 tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{dcp.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
open_checkpoint $input_dcp
report_timing_summary -file "$out/input_routed_timing.rpt"
phys_opt_design -placement_opt -routing_opt -rewire -critical_cell_opt
report_timing_summary -file "$out/postopt_timing.rpt"
report_utilization -file "$out/postopt_utilization.rpt"
write_checkpoint "$out/postopt.dcp"
puts ROUTED_PIN_PHYSOPT_COMPLETE
route_design -directive Explore -tns_cleanup
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
puts ROUTED_PIN_TRIAL_COMPLETE
'''
 script=out/'postroute.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^ROUTED_PIN_TRIAL_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,h in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=h]
 m.update(postopt='COMPLETE' if bool(re.search(r'(?m)^ROUTED_PIN_PHYSOPT_COMPLETE\s*$',text)) else 'FAIL',route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r47_dcp_unchanged=before==sha(dcp));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r47_dcp_unchanged'],text[-7000:]
 print('ROUTED_PIN_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
