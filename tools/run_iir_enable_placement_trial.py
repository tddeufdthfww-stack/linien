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
    # New driver is additional; all R46 hardware/test inputs must match.
    assert all(equal.values()),[n for n,v in equal.items() if not v]
    out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
    files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')
    files+=subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
    hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()}
    dcp=previous/'routed.dcp';before=sha(dcp)
    manifest={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        'source_hashes':hashes,'input_r46_trial':str(previous),'input_dcp_sha256':before,'r46_code_and_test_hash_matches':equal,
        'functional':'REUSED_R46_EXACT_INPUTS_NOT_RERUN','synthesis':'REUSED_R46_EXACT_DCP_NOT_RERUN','route':'NOT RUN','timing_signoff':'NOT EVALUATED',
        'additional_latency_vs_r46_sys':0,'optimization':'Unroute in-memory R46 DCP; force actual negative-slack IIR BREG1/BCASCREG1 CEB2 ordinary LUT drivers; CSR Q>=192 only if actual negative output slack. placement/rewire/critical-cell; route Explore/tns_cleanup; no retime/clock_opt/DSP/BRAM register/serial-edge/constraint changes'}
    (out/'manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    for name in ['synth_timing.rpt','top.v','top.xdc','csrmap.py','synthesis.json']:
        if (previous/name).is_file():shutil.copyfile(previous/name,out/name)
    text=f'''set_param general.maxThreads 2
open_checkpoint {{{dcp.as_posix()}}}
report_timing_summary -file {{{(out/'input_routed_timing.rpt').as_posix()}}}
# Explicitly return the in-memory design to post-place state before forcing
# replication; no unsupported post-route fanout_opt call is made.
route_design -unroute
report_route_status -file {{{(out/'unrouted_status.rpt').as_posix()}}}
proc csr_cells {{}} {{
 return [get_cells -hier -quiet -filter {{NAME =~ linienmodule_csr_dat_w_reg* && REF_NAME =~ FD*}}]
}}
proc csr_table {{file}} {{
 set f [open $file w]
 puts $f "cell\tref\tD\tC\tCE\tR\tINIT\tASYNC_REG\tDONT_TOUCH\tQ_net\tloads\tload_pins"
 foreach c [lsort [csr_cells]] {{
  set values [list $c [get_property REF_NAME $c]]
  foreach pin {{D C CE R}} {{lappend values [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter "REF_PIN_NAME == $pin"]]}}
  foreach prop {{INIT ASYNC_REG DONT_TOUCH}} {{lappend values [get_property $prop $c]}}
  set qn [get_nets -quiet -of_objects [get_pins -quiet -of_objects $c -filter {{REF_PIN_NAME == Q}}]]
  set pins [lsort [get_pins -quiet -of_objects $qn -filter {{DIRECTION == IN}}]]
  lappend values $qn [llength $pins] [join $pins "|"]
  puts $f [join $values "\t"]
 }};close $f
}}
csr_table {{{(out/'csr_replication_before.tsv').as_posix()}}}
set chosen {{}}
foreach c [csr_cells] {{
 set cp [get_pins -of_objects $c -filter {{REF_PIN_NAME == C}}]
 if {{[get_clocks -of_objects $cp] ne "clk_2"}} {{error "CSR data is not ADC-clocked: $c"}}
 if {{[get_property ASYNC_REG $c] eq "1"}} {{error "Refuse synchronizer replication: $c"}}
 set ce [get_nets -of_objects [get_pins -of_objects $c -filter {{REF_PIN_NAME == CE}}]]
 set cedrv [get_cells -quiet -of_objects [get_pins -quiet -of_objects $ce -filter {{DIRECTION == OUT}}]]
 if {{[get_property REF_NAME $cedrv] ne "VCC"}} {{error "CSR data CE is not constant1: $c"}}
 foreach n [get_nets -of_objects [get_pins -of_objects $c -filter {{REF_PIN_NAME == Q}}]] {{
  if {{[llength [get_pins -of_objects $n -filter {{DIRECTION == IN}}]] >= 192}} {{
   set paths [get_timing_paths -quiet -from $c -max_paths 1]
   if {{[llength $paths] && [get_property SLACK $paths]<0}} {{lappend chosen $n}}
  }}
 }}
}}
proc ce_table {{file}} {{
 set f [open $file w];puts $f "DSP\tclock\tBREG\tBCASCREG\tCE_net\tdriver\tref\tINIT\tinputs\tloads\tslack"
 set selected {{}}
 foreach c [lsort [get_cells -hier -quiet -filter {{REF_NAME == DSP48E1}}]] {{
  if {{![string match *iir* $c] || [get_property BREG $c]!=1}} {{continue}}
  set clk [get_clocks -of_objects [get_pins -of_objects $c -filter {{REF_PIN_NAME == CLK}}]]
  if {{$clk ne "clk_2" || [get_property BCASCREG $c]!=1}} {{error "Unexpected IIR input state boundary: $c"}}
  set ce [get_pins -of_objects $c -filter {{REF_PIN_NAME == CEB2}}]
  set seg [get_nets -quiet -segments -of_objects $ce]
  set drv [get_cells -quiet -of_objects [get_pins -quiet -leaf -of_objects $seg -filter {{DIRECTION == OUT}}]]
  if {{[llength $drv]!=1}} {{error "Nonunique CE driver: $c $drv"}}
  set ref [get_property REF_NAME $drv];set init {{}};set inputs {{}}
  if {{[string match LUT? $ref]}} {{
   set init [get_property INIT $drv]
   foreach pin [lsort [get_pins -of_objects $drv -filter {{DIRECTION == IN}}]] {{lappend inputs "[get_property REF_PIN_NAME $pin]=[get_nets -quiet -of_objects $pin]"}}
  }}
  set paths [get_timing_paths -quiet -to $ce -max_paths 1];set slack NO_PATH
  if {{[llength $paths]}} {{set slack [get_property SLACK $paths]}}
  puts $f "$c\t$clk\t[get_property BREG $c]\t[get_property BCASCREG $c]\t[get_nets -of_objects $ce]\t$drv\t$ref\t$init\t[join $inputs |]\t[llength [get_pins -quiet -leaf -of_objects $seg -filter {{DIRECTION == IN}}]]\t$slack"
  if {{$slack ne "NO_PATH" && $slack<0}} {{
   if {{![string match LUT? $ref]}} {{error "Refuse non-LUT violating CE driver: $c $drv $ref"}}
   if {{[get_property DONT_TOUCH $drv] eq "1"}} {{error "Refuse protected CE driver: $drv"}}
   lappend selected [get_nets -of_objects $ce]
  }}
 }};close $f
 return [lsort -unique $selected]
}}
set ce_chosen [ce_table {{{(out/'iir_ce_before.tsv').as_posix()}}}]
if {{![llength $ce_chosen]}} {{error "No actual violating IIR CEB2 LUT driver found"}}
puts "IIR_ENABLE_SELECTED $ce_chosen"
puts "NEGATIVE_CSR_DATA_SELECTED $chosen"
set chosen [lsort -unique [concat $chosen $ce_chosen]]
puts "FORCE_REPLICATION_SELECTED $chosen"
write_checkpoint {{{(out/'placed_before_replication.dcp').as_posix()}}}
phys_opt_design -force_replication_on_nets $chosen
write_checkpoint {{{(out/'placed_after_replication.dcp').as_posix()}}}
csr_table {{{(out/'csr_replication_after.tsv').as_posix()}}}
ce_table {{{(out/'iir_ce_after_replication.tsv').as_posix()}}}
phys_opt_design -placement_opt -rewire -critical_cell_opt
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
csr_table {{{(out/'csr_replication_routed.tsv').as_posix()}}}
ce_table {{{(out/'iir_ce_routed.tsv').as_posix()}}}
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
    manifest.update(route='COMPLETE' if ok else 'FAIL',source_changes_during_run=changed,input_r46_dcp_unchanged=sha(dcp)==before)
    (out/'manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    assert ok and not changed and manifest['input_r46_dcp_unchanged'],txt[-6000:]
    print('POSTROUTE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
