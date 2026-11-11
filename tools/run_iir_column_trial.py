"""Isolated R50 synthesis reuse, DSP-column locality experiment; no timing exceptions."""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',required=True,type=Path);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 prior=a.input_trial.resolve();old=json.loads((prior/'manifest.json').read_text());assert old['functional']=='PASS' and old['synthesis']=='COMPLETE' and old['route']=='COMPLETE' and not old['source_changes_during_run']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 same={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(same.values()),[n for n,v in same.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};inputs={n:sha(prior/n) for n in ('synth.dcp','routed.dcp')}
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r50_trial':str(prior),'input_dcp_sha256':inputs,'r50_code_and_test_hash_matches':same,'functional':'REUSED_R50_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R50_EXACT_DCP_NOT_RERUN','placement':'NOT_RUN','postopt':'NOT_RUN','route':'NOT_RUN','timing_signoff':'NOT_EVALUATED','new_serial_ADC_CSR_feedback_cycles':0,'optimization':'Actual DSP site inventory and minimum horizontal relocation assign distinct capacity-qualified columns for fastA32, fastB32, raw22. Hard placement pblocks contain DSP cells only; no routing containment or timing exceptions. Reuse R50 synth, new opt/place/explicit placement-rewire-critical-cell/route Explore TNS cleanup. No retime, clock_opt, DSP/BRAM register optimization or source changes.'}
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','top.xdc','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):shutil.copyfile(prior/n,out/n)
 tcl=f'set out {{{out.as_posix()}}}\nset prior {{{prior.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
proc groups {} {
    set result [dict create fast_a {} fast_b {} raw {}]
    foreach c [get_cells -hier -quiet -filter {REF_NAME == DSP48E1}] {
        set pp [get_pins -quiet -of_objects $c -filter {DIRECTION == OUT}]
        set nets [get_nets -quiet -of_objects $pp]
        foreach kind {fast_a fast_b raw} {
            if {$kind eq "raw"} {set hits [filter $nets {NAME =~ *raw_acquisition_iir* || NAME =~ linienmodule_iir_* || NAME =~ linienmodule_logic_iir_*}]
            } else {set hits [filter $nets "NAME =~ linienmodule_${kind}_iir*"]}
            if {[llength $hits]} {dict lappend result $kind [get_property NAME $c]}
        }
    }
    foreach {kind count} {fast_a 32 fast_b 32 raw 22} {
        if {[llength [dict get $result $kind]] != $count} {error "DSP group $kind count differs from frozen R50: [llength [dict get $result $kind]]"}
    }
    return $result
}
open_checkpoint "$prior/routed.dcp"
set originalGroups [groups]
set inventory [dict create]
foreach site [get_sites -filter {SITE_TYPE == DSP48E1}] {
    if {![regexp {DSP48_X([0-9]+)Y([0-9]+)$} [get_property NAME $site] -> x y]} {error "Unexpected DSP site $site"}
    dict lappend inventory $x $y
}
set cols [lsort -integer [dict keys $inventory]]
set f [open "$out/dsp_columns.tsv" w];puts $f "column\tcapacity\tminY\tmaxY"
foreach x $cols {set ys [lsort -integer [dict get $inventory $x]];puts $f "$x\t[llength $ys]\t[lindex $ys 0]\t[lindex $ys end]"};close $f
set originalXs [dict create]
foreach kind {fast_a fast_b raw} {
    foreach c [dict get $originalGroups $kind] {
        if {![regexp {DSP48_X([0-9]+)Y([0-9]+)$} [get_property LOC [get_cells $c]] -> x y]} {error "Unplaced input DSP $c"}
        dict lappend originalXs $kind $x
    }
}
set bestCost 1000000;set assignment {}
foreach a $cols {foreach b $cols {foreach c $cols {
    if {$a==$b || $a==$c || $b==$c} {continue}
    if {[llength [dict get $inventory $a]]<32 || [llength [dict get $inventory $b]]<32 || [llength [dict get $inventory $c]]<22} {continue}
    set cost 0
    foreach kind {fast_a fast_b raw} target [list $a $b $c] {foreach x [dict get $originalXs $kind] {incr cost [expr {abs($x-$target)}]}}
    if {$cost<$bestCost} {set bestCost $cost;set assignment [dict create fast_a $a fast_b $b raw $c]}
}}}
if {[dict size $assignment]!=3} {error "No legal distinct column assignment from actual sites"}
puts "IIR_COLUMN_SELECTION $assignment relocation_cost=$bestCost"
set f [open "$out/column_assignment.tsv" w];puts $f "group\tcolumn\tDSPcount\tminY\tmaxY"
foreach kind {fast_a fast_b raw} {set x [dict get $assignment $kind];set ys [lsort -integer [dict get $inventory $x]];puts $f "$kind\t$x\t[llength [dict get $originalGroups $kind]]\t[lindex $ys 0]\t[lindex $ys end]"};close $f
close_project
open_checkpoint "$prior/synth.dcp"
opt_design
set newGroups [groups]
set f [open "$out/pblock_members.tsv" w];puts $f "group\tcell"
foreach kind {fast_a fast_b raw} {
    if {[lsort [dict get $originalGroups $kind]] ne [lsort [dict get $newGroups $kind]]} {error "Synthesis/routed group member mismatch $kind"}
    set x [dict get $assignment $kind];set ys [lsort -integer [dict get $inventory $x]]
    set pb [create_pblock "IIR_COLUMN_$kind"]
    add_cells_to_pblock $pb [get_cells [dict get $newGroups $kind]]
    resize_pblock $pb -add "DSP48_X${x}Y[lindex $ys 0]:DSP48_X${x}Y[lindex $ys end]"
    set_property IS_SOFT false $pb
    foreach c [dict get $newGroups $kind] {puts $f "$kind\t$c"}
};close $f
place_design -directive Explore
puts IIR_COLUMN_PLACE_ONLY_COMPLETE
phys_opt_design -placement_opt -rewire -critical_cell_opt
report_timing_summary -file "$out/postopt_timing.rpt"
write_checkpoint "$out/placed.dcp"
puts IIR_COLUMN_PLACEMENT_COMPLETE
route_design -directive Explore -tns_cleanup
set f [open "$out/routed_pblock_members.tsv" w];puts $f "group\tcell\tLOC"
foreach kind {fast_a fast_b raw} {
    set x [dict get $assignment $kind]
    foreach c [dict get $newGroups $kind] {
        set loc [get_property LOC [get_cells $c]]
        if {![regexp "^DSP48_X${x}Y" $loc]} {error "DSP escaped hard column pblock: $kind $c $loc"}
        puts $f "$kind\t$c\t$loc"
    }
};close $f
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
puts IIR_COLUMN_TRIAL_COMPLETE
'''
 script=out/'column_trial.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and bool(re.search(r'(?m)^IIR_COLUMN_TRIAL_COMPLETE\s*$',text)) and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 changed=[n for n,d in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=d]
 m.update(placement='COMPLETE' if re.search(r'(?m)^IIR_COLUMN_PLACE_ONLY_COMPLETE\s*$',text) else 'FAIL',postopt='COMPLETE' if re.search(r'(?m)^IIR_COLUMN_PLACEMENT_COMPLETE\s*$',text) else 'FAIL',route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r50_dcps_unchanged=all(sha(prior/n)==d for n,d in inputs.items()));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r50_dcps_unchanged'],text[-7000:]
 print('IIR_COLUMN_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
