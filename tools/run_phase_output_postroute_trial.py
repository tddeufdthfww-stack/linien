"""R59 routed checkpoint refinement, frozen inputs, explicit physical options."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess,csv
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',required=True,type=Path);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 previous=a.input_trial.resolve();old=json.loads((previous/'manifest.json').read_text())
 assert old['route']=='COMPLETE' and old['replication']=='COMPLETE' and old['input_r57_dcp_unchanged'] and not old['source_changes_during_run']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=previous/'routed.dcp';before=sha(dcp)
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r59_trial':str(previous),'input_dcp_sha256':before,'r59_code_and_test_hash_matches':same,'functional':'REUSED_R52_VIA_R59_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R52_VIA_R59_EXACT_DCP_NOT_RERUN','postopt':'NOT_RUN','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_ADC_CSR_feedback_cycles':0,'optimization':'Post-route placement/routing/rewire/critical-cell and actual TNS cleanup of R59 2-to-6 parallel FDRE topology. No new source/CSR/clock/serial-stage/timing-exception changes; original functional/synth reused R52, FF copy exact state/load evidence inherited R59. Before/after FF families and all94 DSP properties must be audited. Direct R59 and best R57 timing compared separately.'}
 evidence=json.loads((ROOT/'experiments/r59_physical_20261111/metrics.json').read_text())['physical_register_audit'];assert evidence['passed']
 m.update(inherited_FF_copy_audit=evidence,input_FF_table_sha256=sha(previous/'ff_routed.tsv'))
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):
  if (previous/n).exists():shutil.copyfile(previous/n,out/n)
 tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{dcp.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
open_checkpoint $input_dcp
__FF_FUNCTIONS__
source "$out/signatures.tcl"
family_table "$out/ff_before_phys.tsv" $signatures
report_timing_summary -file "$out/input_routed_timing.rpt"
phys_opt_design -placement_opt -routing_opt -rewire -critical_cell_opt
report_timing_summary -file "$out/postopt_timing.rpt"
report_utilization -file "$out/postopt_utilization.rpt"
write_checkpoint "$out/postopt.dcp"
family_table "$out/ff_after_phys.tsv" $signatures
puts PHASE_OUTPUT_PHYS_PHYSOPT_COMPLETE
route_design -directive Explore -tns_cleanup
family_table "$out/ff_routed.tsv" $signatures
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
puts PHASE_OUTPUT_PHYS_TRIAL_COMPLETE
'''
 rows=list(csv.DictReader((previous/'ff_routed.tsv').open(),delimiter='\t'));assert len(rows)==6
 def brace(v):
  assert not any(c in v for c in '{}\\\r\n'),v
  return '{'+v+'}'
 keys=('ref','D','C','CE','R','INIT','ASYNC_REG','DONT_TOUCH');sig={v['source']:[v[k] for k in keys] for v in rows};assert len(sig)==2
 sigtext='set signatures [dict create]\n'+'\n'.join('dict set signatures '+brace(k)+' [list '+' '.join(brace(v) for v in vals)+']' for k,vals in sig.items())+'\n'
 (out/'signatures.tcl').write_text(sigtext,encoding='utf-8');shutil.copyfile(previous/'ff_routed.tsv',out/'input_ff_routed.tsv')
 source=(ROOT/'tools/run_critical_ff_distribution_trial.py').read_text(encoding='utf-8')
 sigproc=source[source.index('proc ff_sig {c} {'):source.index('set signatures [dict create]')]
 familyproc=source[source.index('proc family_table {file signatures} {'):source.index('set beforeCount [family_table')]
 tcl=tcl.replace('__FF_FUNCTIONS__',sigproc+familyproc)
 script=out/'postroute.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^PHASE_OUTPUT_PHYS_TRIAL_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,h in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=h]
 m.update(postopt='COMPLETE' if bool(re.search(r'(?m)^PHASE_OUTPUT_PHYS_PHYSOPT_COMPLETE\s*$',text)) else 'FAIL',route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r59_dcp_unchanged=before==sha(dcp),input_FF_table_unchanged=m['input_FF_table_sha256']==sha(previous/'ff_routed.tsv'));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r59_dcp_unchanged'] and m['input_FF_table_unchanged'],text[-7000:]
 print('PHASE_OUTPUT_PHYS_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
