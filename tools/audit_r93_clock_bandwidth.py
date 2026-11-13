"""Bounded in-memory legal clock-primitive configuration diagnostic.

Never writes checkpoints/bitstreams or changes timing exceptions, jitter inputs,
clock periods, pin assignments or production RTL. Not a fresh implementation.
"""
from pathlib import Path
import argparse,csv,hashlib,json,re,subprocess
p=argparse.ArgumentParser()
p.add_argument('--dcp',type=Path,required=True)
p.add_argument('--out',type=Path,required=True)
a=p.parse_args();dcp=a.dcp.resolve();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
sha=hashlib.sha256(dcp.read_bytes()).hexdigest()
body=r'''
set_param general.maxThreads 2
open_checkpoint {%DCP%}
set managers [get_cells -hier -filter {REF_NAME == MMCME2_ADV || REF_NAME == PLLE2_ADV}]
if {[llength $managers]!=1} {error "Expected one exact clock manager, got $managers"}
set manager [lindex $managers 0]
set original [get_property BANDWIDTH $manager]
set clocks_before {}
foreach c [lsort [get_clocks]] {dict set clocks_before $c [list [get_property PERIOD $c] [get_property WAVEFORM $c]]}
set f [open {%OUT%/windows.tsv} w]
puts $f "bandwidth\tport\tsetup_ns\thold_ns\tsum_ns"
foreach mode {OPTIMIZED HIGH LOW} {
 set_property BANDWIDTH $mode $manager
 update_timing -full
 foreach port [get_ports {dac_data[*]}] {
  set a [get_timing_paths -to $port -delay_type max -max_paths 1]
  set b [get_timing_paths -to $port -delay_type min -max_paths 1]
  if {[llength $a]!=1 || [llength $b]!=1} {error "Missing path $mode/$port"}
  set s [get_property SLACK $a];set h [get_property SLACK $b]
  puts $f "$mode\t$port\t$s\t$h\t[expr {$s+$h}]"
 }
 report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -max_paths 14 -file "%OUT%/${mode}_setup.rpt"
 report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -max_paths 14 -file "%OUT%/${mode}_hold.rpt"
 report_clocks -file "%OUT%/${mode}_clocks.rpt"
 report_property $manager -file "%OUT%/${mode}_primitive.rpt"
 foreach c [lsort [get_clocks]] {
  if {[dict get $clocks_before $c] ne [list [get_property PERIOD $c] [get_property WAVEFORM $c]]} {error "Clock waveform changed: $c"}
 }
}
close $f
set_property BANDWIDTH $original $manager
report_exceptions -file {%OUT%/unchanged_exceptions.rpt}
puts R93_CLOCK_BANDWIDTH_DIAGNOSTIC_COMPLETE
'''.replace('%DCP%',dcp.as_posix()).replace('%OUT%',out.as_posix())
script=out/'audit.tcl';script.write_text('if {[catch {\n'+body+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
with (out/'stdout.log').open('wb')as so,(out/'stderr.log').open('wb')as se:r=subprocess.run(cmd,cwd=out,stdout=so,stderr=se)
log=(out/'stdout.log').read_text(errors='replace')+'\n'+(out/'stderr.log').read_text(errors='replace')
ok=r.returncode==0 and 'R93_CLOCK_BANDWIDTH_DIAGNOSTIC_COMPLETE' in log and not re.search(r'(?m)^ERROR:',log)
record={'completed':ok,'command':cmd,'exit_code':r.returncode,'input_dcp':str(dcp),'input_sha256':sha,'input_unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==sha,'scope':'BANDWIDTH reparameterized in memory, fixed routed topology; not fresh synthesis/route or full signoff; unchanged input jitter and constraints; no checkpoint written','modes':[]}
if ok:
 rows=list(csv.DictReader((out/'windows.tsv').open(),delimiter='\t'))
 for mode in ['OPTIMIZED','HIGH','LOW']:
  rr=[x for x in rows if x['bandwidth']==mode];assert len(rr)==14
  lo=max(-float(x['setup_ns'])for x in rr);hi=min(float(x['hold_ns'])for x in rr)
  record['modes'].append({'bandwidth':mode,'rows':len(rr),'setup_ns':-lo,'hold_ns':hi,'hypothetical_common_phase_lower_ns':lo,'hypothetical_common_phase_upper_ns':hi,'aperture_ns':hi-lo,'necessary_window_status':'POSSIBLE_ONLY'if lo<=hi else 'FAIL','best_single_bit_sum_ns':max(float(x['sum_ns'])for x in rr)})
(out/'result.json').write_text(json.dumps(record,indent=2))
print(json.dumps({k:v for k,v in record.items()if k!='command'},indent=2),flush=True)
assert ok,log[-3000:]
