"""R61: frozen R60 design, real DNA clock/hold repair, complete signoff evidence.

The ADC/DAC zero-PCB-skew model is an explicitly separate feasibility probe.
It is never written into the physical candidate or labelled board signoff.
"""
from pathlib import Path
from datetime import datetime
import argparse,hashlib,json,re,shutil,subprocess
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--input-trial',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args();assert re.fullmatch('[A-Za-z0-9_-]+',a.label)
 prior=a.input_trial.resolve();old=json.loads((prior/'manifest.json').read_text());assert old['route']=='COMPLETE' and not old['source_changes_during_run']
 names=[n for n in old['source_hashes'] if n.startswith(('gateware/','tools/')) and not n.startswith(('gateware/build/','gateware/ps_project/'))]
 matches={n:sha(ROOT/n)==old['source_hashes'][n] for n in names};assert all(matches.values()),[n for n,v in matches.items() if not v]
 out=ROOT/'gateware/build/trials'/(datetime.now().strftime('%Y%m%d_%H%M%S')+'_'+a.label);out.mkdir(parents=True,exist_ok=False)
 files=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')+subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=ROOT).decode().split('\0')
 hashes={n:sha(ROOT/n) for n in sorted(set(files)-{''}) if (ROOT/n).is_file()};dcp=prior/'routed.dcp';before=sha(dcp)
 m={'label':a.label,'head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),'source_hashes':hashes,'input_r60_trial':str(prior),'input_dcp_sha256':before,'r60_hardware_tool_hash_matches':matches,'functional':'SEPARATE_FRESH_SUITE_REQUIRED','synthesis':'REUSED_R52_VIA_R60_EXACT_DCP_NOT_RERUN','hold_fix':'NOT_RUN','route':'NOT_RUN','physical_CDC_safety':'NOT_PROVEN','timing_signoff':'NOT_EVALUATED','new_serial_ADC_feedback_CSR_cycles':0,'board_assumptions':{'physical_PCB_revision':'UNCONFIRMED','PCB_clock_data_skew':'UNCONFIRMED','E1_external_connections_and_clock':'UNCONFIRMED'},'io_probe_scope':'Datasheet intrinsic timing at zero PCB differential skew; diagnostic necessary budget only, NOT board signoff and NOT physical-candidate constraints'}
 mp=out/'manifest.json';mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 for n in ('top.v','csrmap.py','synth_timing.rpt','synth_utilization.rpt','synthesis.json'):shutil.copyfile(prior/n,out/n)
 shutil.copyfile(prior/'top.xdc',out/'input_top.xdc');clock=(ROOT/'gateware/constraints/dna_clock.tcl').read_text(encoding='utf-8');(out/'dna_clock.tcl').write_text(clock,encoding='utf-8');(out/'top.xdc').write_bytes((prior/'top.xdc').read_bytes()+b'\n'+clock.encode())
 tcl=f'set out {{{out.as_posix()}}}\nopen_checkpoint {{{dcp.as_posix()}}}\n'+r'''
set_param general.maxThreads 2
source "$out/dna_clock.tcl"
check_timing -verbose -file "$out/before_checks.rpt"
report_timing_summary -file "$out/before_timing.rpt"
report_timing -delay_type min -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 10 -file "$out/before_dna_hold.rpt"
phys_opt_design -aggressive_hold_fix
report_timing_summary -file "$out/posthold_timing.rpt"
write_checkpoint "$out/posthold.dcp"
puts R61_HOLD_FIX_COMPLETE
route_design -directive Explore -tns_cleanup
report_route_status -file "$out/routed_status.rpt"
report_timing_summary -max_paths 30 -file "$out/routed_timing.rpt"
report_timing -max_paths 100 -file "$out/routed_setup.rpt"
report_timing -delay_type min -max_paths 30 -file "$out/routed_hold.rpt"
report_timing -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 10 -file "$out/dna_setup.rpt"
report_timing -delay_type min -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 10 -file "$out/dna_hold.rpt"
report_timing -from [get_pins DNA_PORT/DOUT] -max_paths 10 -file "$out/dna_return_setup.rpt"
report_timing -delay_type min -from [get_pins DNA_PORT/DOUT] -max_paths 10 -file "$out/dna_return_hold.rpt"
report_utilization -file "$out/routed_utilization.rpt"
check_timing -verbose -file "$out/routed_checks.rpt"
report_cdc -details -file "$out/routed_cdc.rpt"
report_drc -file "$out/routed_drc.rpt"
report_clock_interaction -file "$out/routed_clocks.rpt"
report_clocks -file "$out/all_clocks.rpt"
report_exceptions -file "$out/routed_exceptions.rpt"
write_checkpoint "$out/routed.dcp"
write_verilog -mode funcsim "$out/routed_funcsim.v"
foreach pair {{clk_fpga_0 clk_2} {clk_2 clk_fpga_0}} {
 set from [lindex $pair 0];set to [lindex $pair 1]
 foreach delay {max min} {
  report_timing -from [get_clocks $from] -to [get_clocks $to] -delay_type $delay -max_paths 5000 -nworst 1 -file "$out/cdc_${from}_to_${to}_${delay}.rpt"
 }
}
set sync [get_cells -hier -quiet -filter {ASYNC_REG == TRUE}]
report_timing -from $sync -to $sync -max_paths 1000 -file "$out/synchronizer_setup.rpt"
report_timing -delay_type min -from $sync -to $sync -max_paths 1000 -file "$out/synchronizer_hold.rpt"
set f [open "$out/synchronizers.tsv" w];puts $f "cell\tref\tLOC\tBEL\tASYNC_REG\tC\tD\tQ"
foreach c $sync {set row [list $c [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c] [get_property ASYNC_REG $c]];foreach pin {C D Q} {lappend row [get_nets -quiet -of_objects [get_pins -of_objects $c -filter "REF_PIN_NAME == $pin"]]};puts $f [join $row "\t"]};close $f
puts R61_PHYSICAL_CANDIDATE_COMPLETE
# Separate in-memory I/O feasibility model. The saved candidate above is unchanged.
proc forwarded_clock {name port} {
 set found {}
 foreach c [get_cells -hier -filter {REF_NAME == ODDR}] {
  set q [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]]
  if {$q eq "${port}_OBUF"} {lappend found $c}
 }
 if {[llength $found]!=1} {error "Cannot uniquely trace forwarded clock $port: $found"}
 set c [lindex $found 0];set cp [get_pins -of_objects $c -filter {REF_PIN_NAME == C}]
 create_generated_clock -name $name -source $cp -divide_by 1 -invert [get_ports $port]
}
forwarded_clock dac_write dac_wrt
forwarded_clock dac_sample dac_clk
set ap [get_ports {adc_data_a[*] adc_data_b[*]}]
set dp [get_ports {dac_data[*]}]
if {[llength $ap]!=28 || [llength $dp]!=14} {error "Unexpected ADC/DAC port sizes"}
# LTC2145-14 full-rate CMOS: data follows CLKOUT+ rising edge, tSKEW=0..0.6 ns.
set_input_delay -clock [get_clocks clk125_p] -min 0.0 $ap
set_input_delay -clock [get_clocks clk125_p] -max 0.6 $ap
# AD9767 interleaved mode: data captured on IQWRT rising, tSU=2 ns, tH=1.5 ns.
set_output_delay -clock [get_clocks dac_write] -max 2.0 $dp
set_output_delay -clock [get_clocks dac_write] -min -1.5 $dp
report_timing_summary -max_paths 30 -file "$out/io_DIAGNOSTIC_NOT_SIGNOFF_timing.rpt"
report_timing -from $ap -max_paths 28 -file "$out/adc_diagnostic_setup.rpt"
report_timing -delay_type min -from $ap -max_paths 28 -file "$out/adc_diagnostic_hold.rpt"
report_timing -to $dp -max_paths 14 -file "$out/dac_diagnostic_setup.rpt"
report_timing -delay_type min -to $dp -max_paths 14 -file "$out/dac_diagnostic_hold.rpt"
check_timing -verbose -file "$out/io_DIAGNOSTIC_NOT_SIGNOFF_checks.rpt"
report_clocks -file "$out/io_diagnostic_clocks.rpt"
puts R61_IO_DIAGNOSTIC_COMPLETE
'''
 script=out/'implementation.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
 cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'implementation.vivado.log'),'-journal',str(out/'implementation.jou')];print('RUN_DIRECTORY',out,flush=True)
 res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'implementation.stdout.log').write_bytes(res.stdout);(out/'implementation.stderr.log').write_bytes(res.stderr);text=(res.stdout+b'\n'+res.stderr).decode(errors='replace')
 mark=lambda s:bool(re.search('(?m)^'+s+r'\s*$',text));physical=mark('R61_PHYSICAL_CANDIDATE_COMPLETE');io=mark('R61_IO_DIAGNOSTIC_COMPLETE');ok=res.returncode==0 and physical and io and not re.search('(?m)^ERROR:',text)
 (out/'implementation.json').write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok),'physical_complete':physical,'io_diagnostic_complete':io},indent=2),encoding='utf-8')
 changed=[n for n,v in hashes.items() if not (ROOT/n).is_file() or sha(ROOT/n)!=v]
 m.update(hold_fix='COMPLETE' if mark('R61_HOLD_FIX_COMPLETE') else 'FAIL',route='COMPLETE' if physical else 'FAIL',io_diagnostic='COMPLETE' if io else 'FAIL',source_changes_during_run=changed,input_r60_dcp_unchanged=before==sha(dcp));mp.write_text(json.dumps(m,indent=2),encoding='utf-8')
 assert ok and not changed and m['input_r60_dcp_unchanged'],text[-6000:]
 print('R61_SIGNOFF_EVIDENCE_SUITE_COMPLETE',flush=True)
if __name__=='__main__':main()
