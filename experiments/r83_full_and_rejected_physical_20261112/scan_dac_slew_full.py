"""Remaining legal slew/drive diagnostics, preserving the original DCP."""
from pathlib import Path
import argparse,csv,hashlib,json,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--trial',type=Path,required=True);p.add_argument('--fast-scan',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args()
base=Path(__file__).resolve().parent;out=base/a.label;out.mkdir(exist_ok=False)
dcp=a.trial.resolve()/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
fast=json.loads((a.fast_scan/'result.json').read_text());assert fast['diagnostic_completed'] and fast['input_dcp_unchanged'] and fast['input_dcp_sha256']==digest
tcl=f'open_checkpoint {{{dcp.as_posix()}}}\nset out {{{out.as_posix()}}}\nset_param general.maxThreads 2\n'+r'''
set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $data]!=14 || [llength $wrt]!=1} {error "DAC coverage"}
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/per_pin_extra.tsv" w];puts $f "data_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\thold_ns"
set code [catch {
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16} {
  if {$ws eq "FAST" && $ds eq "FAST"} {continue}
  set_property SLEW $ws $wrt;set_property DRIVE $wc $wrt
  set_property SLEW $ds $data;set_property DRIVE $dd $data
  set su {};set ho {}
  foreach q [get_timing_paths -to $data -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  foreach q [get_timing_paths -to $data -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $q] [get_property SLACK $q]}
  if {[dict size $su]!=14 || [dict size $ho]!=14} {error "Missing bit coverage"}
  dict for {pin ss} $su {puts $f [join [list $dd $wc $ds $ws $pin $ss [dict get $ho $pin]] "\t"]};flush $f
 }}}}
} msg opts]
close $f
dict for {name values} $saved {set_property DRIVE [lindex $values 0] [get_ports $name];set_property SLEW [lindex $values 1] [get_ports $name]}
if {$code} {return -options $opts $msg}
report_timing -to $data -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -to $data -delay_type min -max_paths 14 -file "$out/restored_hold.rpt"
puts DAC_ALL_LEGAL_DRIVE_SLEW_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF
'''
tcl=tcl.replace('\\t','\t');script=out/'scan.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr $msg;puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'stdout.log').write_bytes(r.stdout);(out/'stderr.log').write_bytes(r.stderr)
ok=r.returncode==0 and b'DAC_ALL_LEGAL_DRIVE_SLEW_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF' in r.stdout
result={'diagnostic_completed':ok,'command':cmd,'exit_code':r.returncode,'input_dcp_sha256':digest,'input_dcp_unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==digest,'scope':'Actual mapped fixed-clock source-synchronous DAC data model. 16 original FAST cases plus 48 additional slew/drive cases, full14bit coverage. In-memory only, all original attributes restored, no checkpoint saved. Hypothetical phase shifts keep current clock path/skew/uncertainty fixed and are not implementable-clock proof. No PCB/SI/pulse/SEL/fullSTA signoff.'}
if ok:
 rows=list(csv.DictReader((a.fast_scan/'per_pin.tsv').open(),delimiter='\t'))
 assert len(rows)==224
 for row in rows:row.update(data_slew='FAST',wrt_slew='FAST')
 extra=list(csv.DictReader((out/'per_pin_extra.tsv').open(),delimiter='\t'));assert len(extra)==672
 rows+=extra
 fields=['data_drive','wrt_drive','data_slew','wrt_slew','pin','setup_ns','hold_ns']
 with (out/'all_896_rows.tsv').open('w',newline='') as f:
  w=csv.DictWriter(f,fieldnames=fields,delimiter='\t');w.writeheader();w.writerows(rows)
 def merged(intervals):
  answer=[]
  for lo,hi in sorted(intervals):
   if answer and lo<=answer[-1][1]:answer[-1]=(answer[-1][0],max(answer[-1][1],hi))
   else:answer.append((lo,hi))
  return answer
 groups=[]
 for ws in ['FAST','SLOW']:
  for wc in [4,8,12,16]:
   choices=[];intersection=[(-100.0,100.0)]
   for pin in sorted({row['pin'] for row in rows}):
    options=[row for row in rows if row['pin']==pin and row['wrt_slew']==ws and int(row['wrt_drive'])==wc]
    assert len(options)==8
    best=max(options,key=lambda row:min(float(row['setup_ns']),float(row['hold_ns'])))
    choices.append(best)
    intervals=merged([(-float(row['setup_ns']),float(row['hold_ns'])) for row in options if -float(row['setup_ns'])<=float(row['hold_ns'])])
    intersection=merged([(max(x,lo),min(y,hi)) for x,y in intersection for lo,hi in intervals if max(x,lo)<=min(y,hi)])
   margin=min(min(float(row['setup_ns']),float(row['hold_ns'])) for row in choices)
   groups.append({'wrt_slew':ws,'wrt_drive':wc,'best_per_pin_min_margin_ns':margin,'no_phase_feasible':margin>=0,'fixed_clock_model_hypothetical_phase_intersection_ns':intersection,'choices':choices})
 result.update(total_configs=64,covered_rows=896,groups=groups,any_no_phase_feasible=any(v['no_phase_feasible'] for v in groups),any_fixed_clock_model_phase_feasible=any(v['fixed_clock_model_hypothetical_phase_intersection_ns'] for v in groups))
(out/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='groups'},indent=2),flush=True)
print([(v['wrt_slew'],v['wrt_drive'],v['best_per_pin_min_margin_ns'],v['fixed_clock_model_hypothetical_phase_intersection_ns']) for v in result.get('groups',[])],flush=True)
assert ok and result['input_dcp_unchanged']
