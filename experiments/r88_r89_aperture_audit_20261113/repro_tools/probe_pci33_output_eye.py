"""Read-only PCI33_3 DC-compatible output primitive diagnostic, not PCI protocol."""
from pathlib import Path
import csv,hashlib,json,subprocess
b=Path(__file__).resolve().parent;o=b/'r89_pci33_r86b_probe01';o.mkdir(exist_ok=False)
dcp=Path('D:/RP_Dev/linien_trials/20261112-r86-dac-common-sdr4/gateware/build/r86_serdes02/routed.dcp');digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
tcl=f'open_checkpoint {{{dcp.as_posix()}}}\nset out {{{o.as_posix()}}}\nset_param general.maxThreads 2\n'+r'''
set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach p [concat $data $wrt] {dict set saved [get_property NAME $p] [list [get_property IOSTANDARD $p] [get_property DRIVE $p] [get_property SLEW $p]]}
set f [open "$out/raw.tsv" w];puts $f "data_std\twrt_std\tdata_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
proc row {f data wrt ds ws dd wd dsl wsl} {
 set_property IOSTANDARD $ds $data;set_property IOSTANDARD $ws $wrt
 foreach {ps std drive slew} [list $data $ds $dd $dsl $wrt $ws $wd $wsl] {
  if {$std eq "PCI33_3"} {reset_property DRIVE $ps;reset_property SLEW $ps} else {set_property DRIVE $drive $ps;set_property SLEW $slew $ps}
 }
 set su {};set ho {}
 foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
 foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
 if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
 dict for {pin ss} $su {puts $f [join [list $ds $ws $dd $wd $dsl $wsl $pin $ss [dict get $ho $pin]] "\t"]};flush $f
}
set code [catch {
 row $f $data $wrt PCI33_3 PCI33_3 DEFAULT DEFAULT DEFAULT DEFAULT
 report_drc -ruledecks bitstream_checks -file "$out/pci33_both_drc.rpt"
 foreach std {LVCMOS33 LVTTL} {foreach d {4 8 12 16 24} {foreach slew {FAST SLOW} {
  if {$std eq "LVCMOS33" && $d==24} {continue}
  row $f $data $wrt PCI33_3 $std DEFAULT $d DEFAULT $slew
  row $f $data $wrt $std PCI33_3 $d DEFAULT $slew DEFAULT
 }}}
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
puts PCI33_OUTPUT_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
'''
(o/'probe.tcl').write_text(tcl,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(o/'probe.tcl'),'-log',str(o/'vivado.log'),'-journal',str(o/'vivado.jou')]
r=subprocess.run(cmd,cwd=o,capture_output=True);(o/'stdout.log').write_bytes(r.stdout);(o/'stderr.log').write_bytes(r.stderr);ok=r.returncode==0 and b'PCI33_OUTPUT_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF'in r.stdout
result={'diagnostic_complete':ok,'input_dcp_sha256':digest,'unchanged':digest==hashlib.sha256(dcp.read_bytes()).hexdigest(),'scope':'PCI33_3 output standard DC alternative at same3.3V bank, not a PCI protocol. All original attributes restored. Raw STA preserved. +2ns BBAA normal hold used only for necessary-window diagnostic, not applied exception or signoff. Actual source/native proof remains R86b.'}
if ok:
 rows=list(csv.DictReader((o/'raw.tsv').open(),delimiter='\t'));assert len(rows)==518
 for v in rows:v['qualified_hold_ns']=float(v['raw_hold_ns'])+2.;v['eye_ns']=float(v['setup_ns'])+v['qualified_hold_ns']
 result['best_row_eye_ns']=max(v['eye_ns']for v in rows);result['best_row_min_margin_ns']=max(min(float(v['setup_ns']),v['qualified_hold_ns'])for v in rows);result['best_rows_by_eye']=sorted(rows,key=lambda v:v['eye_ns'],reverse=True)[:14]
(o/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print({k:v for k,v in result.items()if k!='best_rows_by_eye'},flush=True)
assert ok and result['unchanged']
