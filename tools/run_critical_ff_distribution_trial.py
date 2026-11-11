"""R53 negative-path FDRE distribution with exact state/load-set auditing."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',type=Path,required=True);p.add_argument('--label',required=True);p.add_argument('--unroute-all',action='store_true',default=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 prior=a.input_trial.resolve();old=json.loads((prior/'manifest.json').read_text());assert old['route']=='COMPLETE' and old['postopt']=='COMPLETE' and old['input_r52_dcp_unchanged'] and not old['source_changes_during_run']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=prior/'routed.dcp';before=sha(dcp)
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r53_trial':str(prior),'input_dcp_sha256':before,'r53_code_and_test_hash_matches':same,'functional':'REUSED_R52_VIA_R53_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R52_VIA_R53_EXACT_DCP_NOT_RERUN','replication':'NOT_RUN','unroute_scope':'all' if a.unroute_all else 'selected_Q_nets','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_cycles':0,'optimization':'Select actual original routed negative-path ordinary FDRE sources before unroute, ADC clock/non-ASYNC/non-protected/Q loads>=4. Force only driver replication, same D/C/CE/R/INIT and exact aggregated load sets. Default all-unroute compatibility mode; actual Explore/TNS cleanup without incompatible preserve flag. No retime/clock/DSP/BRAM register optimization, RTL/XDC or serial stages. Optional all-unroute compatibility mode is separately recorded.'}
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):shutil.copyfile(prior/n,out/n)
 tcl=f'set out {{{out.as_posix()}}}\nset input_dcp {{{dcp.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
open_checkpoint $input_dcp
report_timing_summary -file "$out/input_routed_timing.rpt"

proc ff_sig {c} {
    set sig [list [get_property REF_NAME $c]]
    foreach pin {D C CE R} {lappend sig [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter "REF_PIN_NAME == $pin"]]}
    foreach prop {INIT ASYNC_REG DONT_TOUCH} {lappend sig [get_property $prop $c]}
    return $sig
}
set signatures [dict create];set targets {};set seen {}
set f [open "$out/ff_selection.tsv" w];puts $f "cell\tslack\tQ_net\tloads\tclock\tstatus"
foreach path [get_timing_paths -slack_lesser_than 0 -max_paths 1000 -nworst 1] {
    set sp [get_property STARTPOINT_PIN $path]
    set c [get_cells -quiet -of_objects [get_pins -quiet $sp]]
    if {[llength $c]!=1 || [get_property REF_NAME $c] ne "FDRE"} {continue}
    set clk [get_clocks -quiet -of_objects [get_pins -quiet -of_objects $c -filter {REF_PIN_NAME == C}]]
    set q [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter {REF_PIN_NAME == Q}]]
    set loads [llength [get_pins -quiet -leaf -of_objects $q -filter {DIRECTION == IN}]]
    set sig [ff_sig $c];set status SELECTED
    if {$clk ne "clk_2" || [get_property ASYNC_REG $c] eq "1" || [get_property DONT_TOUCH $c] eq "1" || $loads<4} {set status EXCLUDED}
    if {[lsearch -exact $seen $sig]>=0} {set status DUPLICATE_SIGNATURE}
    puts $f "$c\t[get_property SLACK $path]\t$q\t$loads\t$clk\t$status"
    if {$status ne "SELECTED"} {continue}
    lappend seen $sig;dict set signatures $c $sig
    foreach n $q {lappend targets $n}
};close $f
set targets [lsort -unique $targets]
if {![llength $targets]} {error "No eligible original routed negative-path FDRE driver"}
proc family_table {file signatures} {
    set f [open $file w];puts $f "source\tcell\tref\tD\tC\tCE\tR\tINIT\tASYNC_REG\tDONT_TOUCH\tQ_net\tloads\tload_pins"
    set count 0
    dict for {source sig} $signatures {
        set dn [lindex $sig 1]
        set candidates [get_cells -quiet -of_objects [get_pins -quiet -leaf -of_objects [get_nets $dn] -filter {DIRECTION == IN && REF_PIN_NAME == D}]]
        foreach c [lsort -unique $candidates] {
            if {[get_property REF_NAME $c] ne "FDRE" || [ff_sig $c] ne $sig} {continue}
            set q [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter {REF_PIN_NAME == Q}]]
            set lp [lsort [get_pins -quiet -leaf -of_objects $q -filter {DIRECTION == IN}]]
            puts $f [join [concat [list $source $c] $sig [list $q [llength $lp] [join $lp |]]] "\t"]
            incr count
        }
    };close $f
    return $count
}
set beforeCount [family_table "$out/ff_before.tsv" $signatures]
if {$beforeCount<[dict size $signatures]} {error "Missing original source family in before table"}
puts "CRITICAL_FF_SELECTED_ORIGINAL_ROUTED $targets"
__UNROUTE_COMMAND__
report_route_status -file "$out/partially_unrouted_status.rpt"
phys_opt_design -force_replication_on_nets [get_nets $targets]
set afterCount [family_table "$out/ff_after.tsv" $signatures]
if {$afterCount<=$beforeCount} {error "Force replication produced no additional matching FDRE: $beforeCount -> $afterCount"}
write_checkpoint "$out/replicated.dcp"
puts CRITICAL_FF_TARGETS_COMPLETE
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
puts CRITICAL_FF_ROUTE_TRIAL_COMPLETE
'''
 tcl=tcl.replace('__UNROUTE_COMMAND__','route_design -unroute' if a.unroute_all else 'route_design -unroute -nets [get_nets $targets]')
 script=out/'local_route.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^CRITICAL_FF_ROUTE_TRIAL_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,d in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=d]
 m.update(replication='COMPLETE' if re.search(r'(?m)^CRITICAL_FF_TARGETS_COMPLETE\s*$',text) else 'FAIL',route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r53_dcp_unchanged=before==sha(dcp));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r53_dcp_unchanged'],text[-6000:]
 print('CRITICAL_FF_ROUTE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
