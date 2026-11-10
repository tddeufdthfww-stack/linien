"""Frozen R28 synthesis netlist, fresh placement/fanout/routing; no RTL change."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,os,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--input-trial',type=Path,required=True);ap.add_argument('--label',required=True);a=ap.parse_args();assert re.fullmatch('[a-zA-Z0-9_-]+',a.label)
    previous=a.input_trial.resolve();prior=json.loads((previous/'manifest.json').read_text());assert prior['functional']=='PASS' and prior['synthesis']=='COMPLETE' and prior['route']=='COMPLETE'
    names=[n for n in prior['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
    matches={n:sha(ROOT/n)==prior['source_hashes'][n] for n in names};assert all(matches.values()),[n for n,v in matches.items() if not v]
    out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
    files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
    hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if(ROOT/n).is_file()};dcp=previous/'synth.dcp';before=sha(dcp)
    manifest={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r28_trial':str(previous),'input_checkpoint_kind':'SYNTH_UNPLACED','input_dcp_sha256':before,'r28_code_and_test_hash_matches':matches,'functional':'REUSED_R28_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R28_EXACT_DCP_NOT_RERUN','route':'NOT RUN','timing_signoff':'NOT EVALUATED','additional_latency_vs_r28_sys':0,'optimization':'opt_design; fresh place Explore; post-place phys_opt AggressiveFanoutOpt; route Explore/tns_cleanup. No RTL/constraints/retime/clock_opt/negative-edge FF options.'}
    def save():(out/'manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    save()
    for name in ('synth_timing.rpt','synth_utilization.rpt','top.v','top.xdc','csrmap.py','synthesis.json','versions.json'):
        if(previous/name).is_file():shutil.copyfile(previous/name,out/name)
    body=f'''set_param general.maxThreads 2
open_checkpoint {{{dcp.as_posix()}}}
opt_design
place_design -directive Explore
write_checkpoint {{{(out/'placed_before_phys.dcp').as_posix()}}}
phys_opt_design -directive AggressiveFanoutOpt
write_checkpoint {{{(out/'placed_after_phys.dcp').as_posix()}}}
route_design -directive Explore -tns_cleanup
report_route_status -file {{{(out/'routed_status.rpt').as_posix()}}}
report_timing_summary -max_paths 30 -file {{{(out/'routed_timing.rpt').as_posix()}}}
report_timing -max_paths 100 -file {{{(out/'routed_setup.rpt').as_posix()}}}
report_timing -delay_type min -max_paths 30 -file {{{(out/'routed_hold.rpt').as_posix()}}}
report_utilization -file {{{(out/'routed_utilization.rpt').as_posix()}}}
check_timing -verbose -file {{{(out/'routed_checks.rpt').as_posix()}}}
report_cdc -details -file {{{(out/'routed_cdc.rpt').as_posix()}}}
report_drc -file {{{(out/'routed_drc.rpt').as_posix()}}}
report_clock_interaction -file {{{(out/'routed_clocks.rpt').as_posix()}}}
report_exceptions -file {{{(out/'routed_exceptions.rpt').as_posix()}}}
write_checkpoint {{{(out/'routed.dcp').as_posix()}}}
puts FRESH_PLACE_TRIAL_COMPLETE
'''
    script=out/'fresh_place.tcl';script.write_text('if {[catch {\n'+body+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
    cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
    p=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(p.stdout);(out/'implementation.stderr.log').write_bytes(p.stderr)
    text=(p.stdout+b'\n'+p.stderr).decode(errors='replace');ok=p.returncode==0 and'FRESH_PLACE_TRIAL_COMPLETE'in text and not re.search('(?m)^ERROR:',text)
    (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':p.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
    changed=[n for n,h in hashes.items() if not(ROOT/n).is_file() or sha(ROOT/n)!=h]
    manifest.update(route='COMPLETE'if ok else'FAIL',source_changes_during_run=changed,input_r28_dcp_unchanged=sha(dcp)==before);save()
    assert ok and not changed and manifest['input_r28_dcp_unchanged'],text[-6000:];print('FRESH_PLACE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
