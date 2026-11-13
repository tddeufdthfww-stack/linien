"""Read-only on-disk R92 DCP; in-memory legal tap diagnostic, no checkpoint."""
from pathlib import Path
import hashlib,json,re,subprocess
base=Path(__file__).resolve().parent
root=Path('D:/RP_Dev/linien_trials/20261113-r92-calibrated-wrt')
dcp=root/'gateware/build/r92_physical01/routed.dcp'
out=base/'r92_tap_audit01';out.mkdir(exist_ok=False)
sha=hashlib.sha256(dcp.read_bytes()).hexdigest()
body=r'''
set_param general.maxThreads 2
open_checkpoint {%DCP%}
set delay_cell [get_cells reference.write_delay]
set f [open {%OUT%/taps.tsv} w]
puts $f "tap\tbit\tsetup_ns\thold_ns\tsum_ns"
foreach tap {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31} {
 set_property IDELAY_VALUE $tap $delay_cell
 foreach port [get_ports {dac_data[*]}] {
  set a [get_timing_paths -to $port -delay_type max -max_paths 1]
  set b [get_timing_paths -to $port -delay_type min -max_paths 1]
  if {[llength $a]!=1 || [llength $b]!=1} {error "Missing timing: $tap/$port"}
  set s [get_property SLACK $a]; set h [get_property SLACK $b]
  puts $f "$tap\t$port\t$s\t$h\t[expr {$s+$h}]"
 }
}
close $f
set_property IDELAY_VALUE 22 $delay_cell
set sel [get_ports dac_sel]
foreach c {dac_wrt_forward dac_clk_forward} {
 set_output_delay -clock [get_clocks $c] -max 0.0 -add_delay $sel
 set_output_delay -clock [get_clocks $c] -clock_fall -min 0.0 -add_delay $sel
}
report_timing -to $sel -delay_type max -max_paths 30 -nworst 10 -path_type full_clock_expanded -file {%OUT%/sel_before_rises.rpt}
report_timing -to $sel -delay_type min -max_paths 30 -nworst 10 -path_type full_clock_expanded -file {%OUT%/sel_after_falls.rpt}
set sample [get_cells reference.output_sample]
if {[get_property REF_NAME $sample] ne "ODDR"} {error "Wrong sample primitive"}
set_output_delay -clock dac_wrt_forward -max 0.5 [get_ports dac_clk]
set_output_delay -clock dac_wrt_forward -min -2.0 [get_ports dac_clk]
report_timing -fall_from [get_clocks c2] -rise_to [get_ports dac_clk] -delay_type max -max_paths 10 -nworst 5 -path_type full_clock_expanded -file {%OUT%/clk_before_wrt.rpt}
report_timing -fall_from [get_clocks c2] -rise_to [get_ports dac_clk] -delay_type min -max_paths 10 -nworst 5 -path_type full_clock_expanded -file {%OUT%/clk_after_previous_wrt.rpt}
set f [open {%OUT%/placement.tsv} w]
foreach c [get_cells -hier -filter {REF_NAME == IDELAYE2 || REF_NAME == LUT1 || NAME =~ *dac_wrt_OBUF_inst || NAME =~ *output_select}] {
 puts $f "$c\t[get_property REF_NAME $c]\t[get_property LOC $c]\t[get_sites -of_objects $c]"
}
close $f
puts R92_TAP_AND_PROTOCOL_DIAGNOSTIC_COMPLETE
'''.replace('%DCP%',dcp.as_posix()).replace('%OUT%',out.as_posix())
script=out/'audit.tcl';script.write_text('if {[catch {\n'+body+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
with (out/'stdout.log').open('wb') as so,(out/'stderr.log').open('wb') as se:r=subprocess.run(cmd,cwd=out,stdout=so,stderr=se)
log=(out/'stdout.log').read_text(errors='replace')+'\n'+(out/'stderr.log').read_text(errors='replace')
ok=r.returncode==0 and 'R92_TAP_AND_PROTOCOL_DIAGNOSTIC_COMPLETE' in log and not re.search(r'(?m)^ERROR:',log)
record={'completed':ok,'command':cmd,'exit_code':r.returncode,'input_sha256':sha,'input_unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==sha,'scope':'in-memory legal tap characterization at fixed routed topology, not a fresh route or whole design signoff'}
if ok:
 import csv
 rows=list(csv.DictReader((out/'taps.tsv').open(),delimiter='\t'))
 record.update(rows=len(rows),feasible_rows=sum(float(x['setup_ns'])>=0 and float(x['hold_ns'])>=0 for x in rows),best_single_bit_sum_ns=max(float(x['sum_ns'])for x in rows))
 record['tap_windows']=[{'tap':t,'setup_ns':min(float(x['setup_ns'])for x in rows if int(x['tap'])==t),'hold_ns':min(float(x['hold_ns'])for x in rows if int(x['tap'])==t)}for t in range(32)]
 for n in ['sel_before_rises','sel_after_falls','clk_before_wrt','clk_after_previous_wrt']:
  values=[float(x)for x in re.findall(r'Slack \([^)]*\)\s*:\s*(-?[\d.]+)ns',(out/(n+'.rpt')).read_text(errors='replace'))]
  record[n]={'paths':len(values),'worst_ns':min(values)if values else None,'status':('PASS_NECESSARY_ONLY'if min(values)>=0 else 'FAIL')if values else 'NOT_CHECKED'}
(out/'result.json').write_text(json.dumps(record,indent=2))
print(json.dumps({k:v for k,v in record.items()if k not in ['command','tap_windows']},indent=2),flush=True)
assert ok,log[-2500:]
