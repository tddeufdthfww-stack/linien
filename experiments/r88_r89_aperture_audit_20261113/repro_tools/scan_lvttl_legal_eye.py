"""3.3V LVTTL alternative electrical modes, immutable routed input, no bitstream."""
from pathlib import Path
import argparse,csv,hashlib,json,subprocess
p=argparse.ArgumentParser();p.add_argument('--trial',type=Path,required=True);p.add_argument('--label',required=True);p.add_argument('--qualified-bbaa-native',type=Path);a=p.parse_args();b=Path(__file__).resolve().parent;o=b/a.label;o.mkdir(exist_ok=False)
dcp=a.trial.resolve()/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
hold_shift=0.
if a.qualified_bbaa_native:
 native=json.loads((a.qualified_bbaa_native/'results.json').read_text());physical=json.loads((a.trial/'results.json').read_text());log=(a.qualified_bbaa_native/'simulate.stdout.log').read_text()
 assert native['passed'] and 'R86_SERDES_NATIVE_PASS'in log and native['source_sha256']==physical['input_sha256']=='a9bb116b7265dbc074646f073512fbf741f44a8db9bb16c4802c9ef6cc7069b7'
 hold_shift=2.
tcl=f'open_checkpoint {{{dcp.as_posix()}}}\nset out {{{o.as_posix()}}}\nset_param general.maxThreads 2\n'+r'''
set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $data]!=14 || [llength $wrt]!=1} {error "port count"}
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property IOSTANDARD $port] [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/raw.tsv" w];puts $f "data_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\thold_ns"
set code [catch {
 set_property IOSTANDARD LVTTL [concat $data $wrt]
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16 24} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16 24} {
  set_property SLEW $ws $wrt;set_property DRIVE $wc $wrt
  set_property SLEW $ds $data;set_property DRIVE $dd $data
  set su {};set ho {}
  foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  if {[dict size $su]!=14 || [dict size $ho]!=14} {error "14bit coverage"}
  dict for {pin ss} $su {puts $f [join [list $dd $wc $ds $ws $pin $ss [dict get $ho $pin]] "\t"]};flush $f
 }}}}
 set_property DRIVE 24 [concat $data $wrt]
 report_drc -ruledecks bitstream_checks -file "$out/lvttl24_drc.rpt"
} msg opts]
close $f
dict for {name vals} $saved {set_property IOSTANDARD [lindex $vals 0] [get_ports $name];set_property DRIVE [lindex $vals 1] [get_ports $name];set_property SLEW [lindex $vals 2] [get_ports $name]}
if {$code} {return -options $opts $msg}
report_timing -to $data -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -to $data -delay_type min -max_paths 14 -file "$out/restored_hold.rpt"
puts LVTTL100_LEGAL_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
'''
(o/'scan.tcl').write_text(tcl,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(o/'scan.tcl'),'-log',str(o/'vivado.log'),'-journal',str(o/'vivado.jou')]
r=subprocess.run(cmd,cwd=o,capture_output=True);(o/'stdout.log').write_bytes(r.stdout);(o/'stderr.log').write_bytes(r.stderr);ok=r.returncode==0 and b'LVTTL100_LEGAL_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF'in r.stdout
result={'diagnostic_complete':ok,'input_dcp_sha256':digest,'unchanged':digest==hashlib.sha256(dcp.read_bytes()).hexdigest(),'diagnostic_qualified_BBAA_hold_shift_ns':hold_shift,'scope':'100 LVTTL 3.3V modes, including legal24mA. Original electrical attributes restored; no DCP/bitstream write, no exception. If BBAA is explicitly supplied and raw SHA/native PASS verified, add2ns only in diagnostic necessary-window mathematics, retaining all raw STA. DC compatibility assumes AD9767 digital DVDD3.3V and standard board connection; signal integrity and physical implementation qualification are separate.'}
if ok:
 rows=list(csv.DictReader((o/'raw.tsv').open(),delimiter='\t'));assert len(rows)==1400
 if hold_shift:
  for v in rows:v['raw_hold_ns']=v['hold_ns'];v['hold_ns']=str(float(v['hold_ns'])+hold_shift)
 groups=[]
 def merged(xs):
  ans=[]
  for lo,hi in sorted(xs):
   if ans and lo<=ans[-1][1]:ans[-1]=(ans[-1][0],max(hi,ans[-1][1]))
   else:ans.append((lo,hi))
  return ans
 for ws in ['FAST','SLOW']:
  for wc in [4,8,12,16,24]:
   intersect=[(-100.,100.)];choices=[];besteyes=[]
   for pin in sorted({v['pin']for v in rows}):
    opts=[v for v in rows if v['pin']==pin and v['wrt_slew']==ws and int(v['wrt_drive'])==wc]
    choices.append(max(opts,key=lambda v:min(float(v['setup_ns']),float(v['hold_ns']))))
    besteyes.append(max(float(v['setup_ns'])+float(v['hold_ns'])for v in opts))
    intervals=merged([(-float(v['setup_ns']),float(v['hold_ns']))for v in opts if -float(v['setup_ns'])<=float(v['hold_ns'])])
    intersect=merged([(max(x,lo),min(y,hi))for x,y in intersect for lo,hi in intervals if max(x,lo)<=min(y,hi)])
   groups.append({'wrt_slew':ws,'wrt_drive':wc,'best_fixed_phase_min_margin_ns':min(min(float(v['setup_ns']),float(v['hold_ns']))for v in choices),'worst_individual_best_eye_ns':round(min(besteyes),3),'fixed_path_hypothetical_phase_intervals_ns':intersect,'choices':choices})
 result['groups']=groups
(o/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print({k:v for k,v in result.items()if k!='groups'},flush=True);print([(v['wrt_slew'],v['wrt_drive'],v['best_fixed_phase_min_margin_ns'],v['worst_individual_best_eye_ns'],v['fixed_path_hypothetical_phase_intervals_ns'])for v in result.get('groups',[])],flush=True)
assert ok and result['unchanged']
