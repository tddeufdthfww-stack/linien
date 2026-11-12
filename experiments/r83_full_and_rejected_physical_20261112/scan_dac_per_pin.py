"""Legal per-pin electrical feasibility scan on an immutable routed DCP."""
from pathlib import Path
import argparse,csv,hashlib,json,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--trial',type=Path,required=True);p.add_argument('--label',required=True);a=p.parse_args()
out=Path(__file__).resolve().parent/a.label;out.mkdir(exist_ok=False);dcp=a.trial.resolve()/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
tcl=f'set out {{{out.as_posix()}}}\nset_param general.maxThreads 2\nopen_checkpoint {{{dcp.as_posix()}}}\n'+r'''
set ports [get_ports {dac_data[*]}];set wrt [get_ports dac_wrt]
if {[llength $ports]!=14 || [llength $wrt]!=1} {error "DAC port count"}
set original {};foreach port [concat $ports $wrt] {dict set original [get_property NAME $port] [list [get_property DRIVE $port] [get_property SLEW $port]]}
set f [open "$out/per_pin.tsv" w];puts $f "data_drive\twrt_drive\tpin\tsetup_ns\thold_ns"
set scan_code [catch {
 foreach wc {4 8 12 16} {
  foreach dd {4 8 12 16} {
   set_property DRIVE $wc $wrt;set_property SLEW FAST $wrt
   set_property DRIVE $dd $ports;set_property SLEW FAST $ports
   set su {};set ho {}
   foreach path [get_timing_paths -to $ports -delay_type max -max_paths 100 -nworst 1] {dict set su [get_property ENDPOINT_PIN $path] [get_property SLACK $path]}
   foreach path [get_timing_paths -to $ports -delay_type min -max_paths 100 -nworst 1] {dict set ho [get_property ENDPOINT_PIN $path] [get_property SLACK $path]}
   if {[dict size $su]!=14 || [dict size $ho]!=14} {error "Missing per-pin coverage"}
   dict for {pin ss} $su {puts $f [join [list $dd $wc $pin $ss [dict get $ho $pin]] "\t"]}
   flush $f
  }
 }
} scan_error scan_options]
close $f
# Also restore on diagnostic failure, never save a modified checkpoint.
dict for {name properties} $original {set_property DRIVE [lindex $properties 0] [get_ports $name];set_property SLEW [lindex $properties 1] [get_ports $name]}
if {$scan_code} {return -options $scan_options $scan_error}
report_timing -to $ports -max_paths 14 -file "$out/restored_setup.rpt"
report_timing -delay_type min -to $ports -max_paths 14 -file "$out/restored_hold.rpt"
puts DAC_PER_PIN_LEGAL_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF
'''
tcl=tcl.replace('\\t','\t');script=out/'scan.tcl';script.write_text('if {[catch {\n'+tcl+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'scan.vivado.log'),'-journal',str(out/'scan.jou')]
r=subprocess.run(cmd,cwd=out,capture_output=True);(out/'stdout.log').write_bytes(r.stdout);(out/'stderr.log').write_bytes(r.stderr);text=(r.stdout+b'\n'+r.stderr).decode(errors='replace')
ok=r.returncode==0 and 'DAC_PER_PIN_LEGAL_CHARACTERIZATION_COMPLETE_NOT_SIGNOFF' in text and not re.search('(?m)^ERROR:',text)
result={'diagnostic_completed':bool(ok),'command':cmd,'exit_code':r.returncode,'input_dcp_sha256':digest,'input_dcp_unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==digest,'scope':'16 legal FAST configurations, WRT-drive only, other control ports unchanged. Per-pin independent timing feasibility; not simultaneous reimplemented candidate or PCB/SI signoff.'}
if ok:
 rows=list(csv.DictReader((out/'per_pin.tsv').open(),delimiter='\t'));assert len(rows)==224
 groups=[]
 for wc in [4,8,12,16]:
  pins=sorted({r['pin'] for r in rows});choices=[];intersection=[(-100,100)]
  for pin in pins:
   opts=[r for r in rows if r['pin']==pin and int(r['wrt_drive'])==wc]
   best=max(opts,key=lambda r:min(float(r['setup_ns']),float(r['hold_ns'])))
   choices.append({'pin':pin,'data_drive':int(best['data_drive']),'setup_ns':float(best['setup_ns']),'hold_ns':float(best['hold_ns'])})
   intervals=[(-float(r['setup_ns']),float(r['hold_ns'])) for r in opts if -float(r['setup_ns'])<=float(r['hold_ns'])]
   intersection=[(max(x,l),min(y,u)) for x,y in intersection for l,u in intervals if max(x,l)<=min(y,u)]
  groups.append({'wrt_drive':wc,'best_minimum_per_pin_margin_no_phase_change_ns':min(min(r['setup_ns'],r['hold_ns']) for r in choices),'choices':choices,'hypothetical_clock_phase_shift_feasible_intervals_ns':sorted(set(intersection))})
 result['configurations']=groups
(out/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print(json.dumps({k:v for k,v in result.items() if k!='configurations'},indent=2));print([(g['wrt_drive'],g['best_minimum_per_pin_margin_no_phase_change_ns'],g['hypothetical_clock_phase_shift_feasible_intervals_ns']) for g in result.get('configurations',[])],flush=True)
assert ok,text[-4000:]
