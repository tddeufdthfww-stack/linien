"""Complete missing mixed LVCMOS33/LVTTL source-synchronous cases, diagnostic."""
from pathlib import Path
import csv,hashlib,json,subprocess
b=Path(__file__).resolve().parent;o=b/'r89_mixed33_r86b_scan01';o.mkdir(exist_ok=False)
dcp=Path('D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp');digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
native=Path('D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_native02');assert 'R86_SERDES_NATIVE_PASS'in(native/'simulate.stdout.log').read_text()
assert json.loads((native/'results.json').read_text())['source_sha256']=='a9bb116b7265dbc074646f073512fbf741f44a8db9bb16c4802c9ef6cc7069b7'
tcl=f'open_checkpoint {{{dcp.as_posix()}}}\nset out {{{o.as_posix()}}}\nset_param general.maxThreads 2\n'+r'''
set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach p [concat $data $wrt] {dict set saved [get_property NAME $p] [list [get_property IOSTANDARD $p] [get_property DRIVE $p] [get_property SLEW $p]]}
set f [open "$out/raw.tsv" w];puts $f "data_std\twrt_std\tdata_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
set code [catch {
 foreach ds {LVCMOS33 LVTTL} {
  if {$ds eq "LVCMOS33"} {set ws LVTTL;set drives {4 8 12 16};set wdrives {4 8 12 16 24}} else {set ws LVCMOS33;set drives {4 8 12 16 24};set wdrives {4 8 12 16}}
  set_property IOSTANDARD $ds $data;set_property IOSTANDARD $ws $wrt
  foreach wd $wdrives {foreach wsl {FAST SLOW} {foreach dd $drives {foreach dsl {FAST SLOW} {
   set_property DRIVE $wd $wrt;set_property SLEW $wsl $wrt;set_property DRIVE $dd $data;set_property SLEW $dsl $data
   set su {};set ho {}
   foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
   foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
   if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
   dict for {pin ss} $su {puts $f [join [list $ds $ws $dd $wd $dsl $wsl $pin $ss [dict get $ho $pin]] "\t"]};flush $f
  }}}}
 }
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
puts MIXED33_160_CASES_COMPLETE_NOT_SIGNOFF
'''
(o/'scan.tcl').write_text(tcl,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(o/'scan.tcl'),'-log',str(o/'vivado.log'),'-journal',str(o/'vivado.jou')]
r=subprocess.run(cmd,cwd=o,capture_output=True);(o/'stdout.log').write_bytes(r.stdout);(o/'stderr.log').write_bytes(r.stderr);ok=r.returncode==0 and b'MIXED33_160_CASES_COMPLETE_NOT_SIGNOFF'in r.stdout
result={'diagnostic_complete':ok,'input_dcp_sha256':digest,'unchanged':digest==hashlib.sha256(dcp.read_bytes()).hexdigest(),'scope':'160 mixed LVTTL/LVCMOS33 cases, no exception or DCP/bitstream write. +2ns qualified BBAA hold is only necessary diagnostic arithmetic with verified native source; raw STA retained.'}
if ok:
 rows=list(csv.DictReader((o/'raw.tsv').open(),delimiter='\t'));assert len(rows)==2240
 result['rows']=len(rows);result['best_single_row_eye_ns']=round(max(float(v['setup_ns'])+float(v['raw_hold_ns'])+2. for v in rows),3);result['best_single_row_min_margin_ns']=max(min(float(v['setup_ns']),float(v['raw_hold_ns'])+2.)for v in rows)
(o/'result.json').write_text(json.dumps(result,indent=2));print(result,flush=True);assert ok and result['unchanged']
