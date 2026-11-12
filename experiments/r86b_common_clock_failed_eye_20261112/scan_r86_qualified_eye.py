"""Diagnostic ONLY: no exception, qualified hold inferred +2ns from BBAA protocol.
Run only after independent native BBAA PASS; no file or final STA is changed.
"""
from pathlib import Path
import argparse,csv,hashlib,json,subprocess
p=argparse.ArgumentParser();p.add_argument('--trial',type=Path,required=True);p.add_argument('--native',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args()
native=(a.native/'simulate.stdout.log').read_text(errors='replace');assert 'R86_SERDES_NATIVE_PASS' in native and 'Fatal:' not in native
out=Path(__file__).resolve().parent/a.label;out.mkdir(exist_ok=False);dcp=a.trial.resolve()/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
tcl=f'open_checkpoint {{{dcp.as_posix()}}}\nset out {{{out.as_posix()}}}\nset_param general.maxThreads 2\n'+r'''
set data [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
set saved {};foreach port [concat $data $wrt] {dict set saved [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/raw.tsv" w];puts $f "data_drive\twrt_drive\tdata_slew\twrt_slew\tpin\tsetup_ns\traw_hold_ns"
set code [catch {
 foreach ws {FAST SLOW} {foreach wc {4 8 12 16} {foreach ds {FAST SLOW} {foreach dd {4 8 12 16} {
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
puts R86_QUALIFIED_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF
'''
script=out/'scan.tcl';script.write_text(tcl,encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'stdout.log').write_bytes(r.stdout);(out/'stderr.log').write_bytes(r.stderr);ok=r.returncode==0 and b'R86_QUALIFIED_EYE_DIAGNOSTIC_COMPLETE_NOT_SIGNOFF' in r.stdout
result={'diagnostic_completed':ok,'input_dcp_sha256':digest,'unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==digest,'scope':'64 legal drive/slew configs. Raw STA retained. +2ns hold is only mathematical necessary model of proved BBAA duplicates. No timing exception applied, no final signoff. Shift feasibility keeps paths fixed, not an implemented clock.'}
if ok:
 rows=list(csv.DictReader((out/'raw.tsv').open(),delimiter='\t'));assert len(rows)==896
 groups=[]
 def merged(xs):
  ans=[]
  for lo,hi in sorted(xs):
   if ans and lo<=ans[-1][1]:ans[-1]=(ans[-1][0],max(hi,ans[-1][1]))
   else:ans.append((lo,hi))
  return ans
 for ws in ['FAST','SLOW']:
  for wc in [4,8,12,16]:
   intersection=[(-100.,100.)];choices=[]
   for pin in sorted({v['pin']for v in rows}):
    opts=[v for v in rows if v['pin']==pin and v['wrt_slew']==ws and int(v['wrt_drive'])==wc]
    for v in opts:v['qualified_hold_ns']=float(v['raw_hold_ns'])+2.0
    best=max(opts,key=lambda v:min(float(v['setup_ns']),v['qualified_hold_ns']));choices.append(best)
    intervals=merged([(-float(v['setup_ns']),v['qualified_hold_ns'])for v in opts if -float(v['setup_ns'])<=v['qualified_hold_ns']])
    intersection=merged([(max(x,lo),min(y,hi))for x,y in intersection for lo,hi in intervals if max(x,lo)<=min(y,hi)])
   groups.append({'wrt_slew':ws,'wrt_drive':wc,'fixed_phase_necessary_min_margin_ns':min(min(float(v['setup_ns']),v['qualified_hold_ns'])for v in choices),'hypothetical_phase_intersection_ns':intersection,'choices':choices})
 result['groups']=groups
(out/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print({k:v for k,v in result.items()if k!='groups'},flush=True);print([(v['wrt_slew'],v['wrt_drive'],v['fixed_phase_necessary_min_margin_ns'],v['hypothetical_phase_intersection_ns'])for v in result.get('groups',[])],flush=True)
assert ok and result['unchanged']
