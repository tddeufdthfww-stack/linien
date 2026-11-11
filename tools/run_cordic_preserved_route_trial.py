"""R57 checkpoint: two documented auto_delay net reroutes, no logic changes."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 prior=a.input_trial.resolve();old=json.loads((prior/'manifest.json').read_text());assert old['route']=='COMPLETE' and old['postopt']=='COMPLETE' and old['input_r56_dcp_unchanged'] and old['input_FF_table_unchanged'] and not old['source_changes_during_run']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=prior/'routed.dcp';before=sha(dcp)
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r57_trial':str(prior),'input_dcp_sha256':before,'r57_code_and_test_hash_matches':same,'functional':'REUSED_R52_VIA_R57_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R52_VIA_R57_EXACT_DCP_NOT_RERUN','target_routing':'NOT_RUN','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_cycles':0,'optimization':'R57 critical two-load LUT output only: unroute selected net, then ordinary timing-driven route_design -preserve without -nets or -directive; preserve other completed routes for that command. Separate final TNS cleanup may change other routes. No auto_delay, custom delay bounds, logic/copy/clock/retime/RTL/XDC/serial-stage changes.'}
 evidence=json.loads((ROOT/'experiments/r57_physical_20261111/metrics.json').read_text())['physical_register_audit'];assert evidence['passed']
 m['inherited_R57_rewire_and_FF_audit']=evidence
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):shutil.copyfile(prior/n,out/n)
 tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{dcp.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
open_checkpoint $input_dcp
report_timing_summary -file "$out/input_routed_timing.rpt"
set targets {}
foreach wanted {{linienmodule_fast_b_cordic33[10]_i_8_n_0}} {
    set matches {}
    foreach n [get_nets -hier -quiet -filter {NAME =~ linienmodule_fast_b_*}] {
        if {[get_property NAME $n] eq $wanted} {lappend matches $n}
    }
    if {[llength $matches]!=1} {error "Expected exactly one selected data net $wanted: $matches"}
    set n [lindex $matches 0]
    if {[get_property IS_ROUTE_FIXED $n]} {error "Refuse fixed route: $n"}
    set dp [get_pins -quiet -leaf -of_objects $n -filter {DIRECTION == OUT}]
    set lp [get_pins -quiet -leaf -of_objects $n -filter {DIRECTION == IN}]
    if {[llength $dp]!=1 || [llength $lp]!=2} {error "Unexpected original driver/load count: $n $dp [llength $lp]"}
    set paths [get_timing_paths -quiet -through $n -max_paths 1]
    if {![llength $paths] || [get_property SLACK $paths]>=0} {error "Selected original R57 net no longer lies on a negative path: $n"}
    lappend targets $n
}
proc target_table {file targets} {
    set f [open $file w];puts $f "net\tdrivers\tloads\tload_pins"
    foreach n $targets {
        set dp [lsort [get_pins -quiet -leaf -of_objects $n -filter {DIRECTION == OUT}]]
        set lp [lsort [get_pins -quiet -leaf -of_objects $n -filter {DIRECTION == IN}]]
        puts $f "$n\t[join $dp |]\t[llength $lp]\t[join $lp |]"
    };close $f
}
target_table "$out/target_nets_before.tsv" $targets
set index 0
foreach n $targets {
    route_design -unroute -nets [get_nets $n]
    route_design -preserve
    report_timing_summary -file "$out/target${index}_timing.rpt"
    puts "CORDIC_PRESERVED_TARGET_COMPLETE $index $n"
    incr index
}
target_table "$out/target_nets_after.tsv" $targets
write_checkpoint "$out/local_routed.dcp"
puts CORDIC_PRESERVED_TARGETS_COMPLETE
route_design -tns_cleanup
target_table "$out/target_nets_routed.tsv" $targets
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
puts CORDIC_PRESERVED_ROUTE_TRIAL_COMPLETE
'''
 script=out/'local_route.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^CORDIC_PRESERVED_ROUTE_TRIAL_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,d in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=d]
 m.update(target_routing='COMPLETE' if re.search(r'(?m)^CORDIC_PRESERVED_TARGETS_COMPLETE\s*$',text) else 'FAIL',route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r57_dcp_unchanged=before==sha(dcp));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r57_dcp_unchanged'],text[-6000:]
 print('CORDIC_PRESERVED_ROUTE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
