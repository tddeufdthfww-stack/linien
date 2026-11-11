"""Resume an exactly hashed R56 replication checkpoint without repeating replication."""
from pathlib import Path
from datetime import datetime
import argparse,csv,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--replication-trial',required=True,type=Path);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 rep=a.replication_trial.resolve();old=json.loads((rep/'manifest.json').read_text());assert old['replication']=='COMPLETE' and old['unroute_scope']=='all' and old['input_r53_dcp_unchanged'] and not old['source_changes_during_run']
 prior=Path(old['input_r53_trial']);original=json.loads((prior/'manifest.json').read_text())
 names=[n for n in original['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==original['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 rows=lambda n:list(csv.DictReader((rep/n).open(),delimiter='\t'))
 before,after=rows('ff_before.tsv'),rows('ff_after.tsv');keys=('ref','D','C','CE','R','INIT','ASYNC_REG','DONT_TOUCH')
 def group(v):
  d={}
  for row in v:
   key=(row['source'],)+tuple(row[n] for n in keys);lp=row['load_pins'].split('|') if row['load_pins'] else [];assert len(lp)==int(row['loads']) and not d.get(key,set()).intersection(lp);d.setdefault(key,set()).update(lp)
  return d
 assert group(before)==group(after) and len(before)==4 and len(after)==21
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};rdcp=prior/'routed.dcp';pdcp=rep/'replicated.dcp';rsha,psha=sha(rdcp),sha(pdcp)
 assert rsha==old['input_dcp_sha256']
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r53_trial':str(prior),'input_replication_trial':str(rep),'input_dcp_sha256':psha,'input_r53_dcp_sha256':rsha,'original_replication_manifest_sha256':sha(rep/'manifest.json'),'original_replication_code_commit':old['head'],'r53_code_and_test_hash_matches':same,'functional':'REUSED_R52_VIA_R53_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R52_VIA_R53_EXACT_DCP_NOT_RERUN','replication':'REUSED_R56_V2_EXACT_DCP_NOT_RERUN','unroute_scope':'ALL_IN_REUSED_V2','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_cycles':0,'optimization':'Exact R56 replicated.dcp resume, no re-replication; compatible route_design Explore/tns_cleanup without preserve. R53 original routed negative path selection and 4->21 FDRE state/load equivalence verified. No new timing bounds/retime/clock/DSP/BRAM register/RTL/CSR changes.'}
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json','input_routed_timing.rpt','ff_selection.tsv','ff_before.tsv','ff_after.tsv'):shutil.copyfile(rep/n,out/n)
 def brace(v):
  assert not any(c in v for c in '{}\\\r\n'),v
  return '{'+v+'}'
 signatures={}
 for row in before:signatures[row['source']]=[row[k] for k in keys]
 sigtext='set signatures [dict create]\n'+'\n'.join('dict set signatures '+brace(k)+' [list '+' '.join(brace(v) for v in vals)+']' for k,vals in signatures.items())+'\n'
 (out/'signatures.tcl').write_text(sigtext,encoding='utf-8')
 source=(ROOT/'tools/run_critical_ff_distribution_trial.py').read_text(encoding='utf-8')
 sigproc=source[source.index('proc ff_sig {c} {'):source.index('set signatures [dict create]')]
 familyproc=source[source.index('proc family_table {file signatures} {'):source.index('set beforeCount [family_table')]
 tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{pdcp.as_posix()}}}\nset_param general.maxThreads 2\nopen_checkpoint $input_dcp\n'+sigproc+familyproc+'\nsource "$out/signatures.tcl"\n'+r'''
family_table "$out/ff_before_resume.tsv" $signatures
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
puts CRITICAL_FF_RESUME_ROUTE_COMPLETE
'''
 script=out/'resume_route.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^CRITICAL_FF_RESUME_ROUTE_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,d in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=d]
 m.update(route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r53_dcp_unchanged=rsha==sha(rdcp),input_replication_dcp_unchanged=psha==sha(pdcp));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r53_dcp_unchanged'] and m['input_replication_dcp_unchanged'],text[-6000:]
 print('CRITICAL_FF_RESUME_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
