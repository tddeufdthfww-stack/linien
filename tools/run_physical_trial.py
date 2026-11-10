"""One post-route physical pass, frozen input DCP, no RTL/clock changes."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,os,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser();p.add_argument('--input-trial',required=True,type=Path);p.add_argument('--label',required=True);a=p.parse_args()
    assert re.fullmatch('[a-zA-Z0-9_-]+',a.label)
    previous=a.input_trial.resolve();prior=json.loads((previous/'manifest.json').read_text(encoding='utf-8'))
    assert prior['functional']=='PASS' and prior['synthesis']=='COMPLETE' and prior['route']=='COMPLETE'
    # Raw hardware and test files copied exactly before freezing this worktree.
    names=[n for n in prior['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
    equal={n:sha(ROOT/n)==prior['source_hashes'][n] for n in names}
    # New driver is additional; all R28 hardware/test inputs must match.
    assert all(equal.values()),[n for n,v in equal.items() if not v]
    out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
    files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')
    files+=subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
    hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()}
    dcp=previous/'routed.dcp';before=sha(dcp)
    manifest={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        'source_hashes':hashes,'input_r28_trial':str(previous),'input_dcp_sha256':before,'r28_code_and_test_hash_matches':equal,
        'functional':'REUSED_R28_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R28_EXACT_DCP_NOT_RERUN','route':'NOT RUN','timing_signoff':'NOT EVALUATED',
        'additional_latency_vs_r28_sys':0,'optimization':'post-route placement_opt/routing_opt/rewire/critical_cell_opt + route Explore/tns_cleanup only; no retime, clock_opt, DSP/BRAM register changes, edge FF insertion or constraints'}
    (out/'manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    for name in ['synth_timing.rpt','top.v','top.xdc','csrmap.py','synthesis.json']:
        if (previous/name).is_file():shutil.copyfile(previous/name,out/name)
    text=f'''set_param general.maxThreads 2
open_checkpoint {{{dcp.as_posix()}}}
report_timing_summary -file {{{(out/'input_routed_timing.rpt').as_posix()}}}
phys_opt_design -placement_opt -routing_opt -rewire -critical_cell_opt
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
puts POSTROUTE_TRIAL_COMPLETE
'''
    script=out/'postroute.tcl';script.write_text('if {[catch {\n'+text+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
    cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')]
    print('RUN_DIRECTORY',out,flush=True)
    r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(r.stdout);(out/'implementation.stderr.log').write_bytes(r.stderr)
    txt=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and 'POSTROUTE_TRIAL_COMPLETE' in txt and not re.search('(?m)^ERROR:',txt)
    (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
    changed=[n for n,h in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=h]
    manifest.update(route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r28_dcp_unchanged=sha(dcp)==before)
    (out/'manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    assert ok and not changed and manifest['input_r28_dcp_unchanged'],txt[-6000:]
    print('POSTROUTE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
