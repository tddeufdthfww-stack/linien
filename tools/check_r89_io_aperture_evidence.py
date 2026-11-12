from pathlib import Path
import csv,hashlib,json,argparse
ap=argparse.ArgumentParser();ap.add_argument('--evidence-root',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);args=ap.parse_args()
b=args.evidence_root.resolve();o=args.out.resolve();o.mkdir(parents=True,exist_ok=False);rows=[]
proof=b/'r86b_qualified_proof';native=json.loads((proof/'results.json').read_text());physical=json.loads((proof/'physical_results.json').read_text())
assert native['passed'] and native['source_sha256']==physical['input_sha256']==hashlib.sha256((proof/'source.v').read_bytes()).hexdigest()=='a9bb116b7265dbc074646f073512fbf741f44a8db9bb16c4802c9ef6cc7069b7'
assert hashlib.sha256((proof/'routed.dcp').read_bytes()).hexdigest()==physical['dcp_sha256']=='c3a441afd3bd574d4c973d69a2ef1bd7759a506b1a8eb3366cff53730b2978bc'
log=(proof/'simulate.stdout.log').read_text();assert 'R86_SERDES_NATIVE_PASS'in log and 'Fatal:'not in log

for folder,file,kind in [('r86b_qualified_eye_scan01','raw.tsv','LVCMOS33'),('r88_r86b_lvttl_scan01','raw.tsv','LVTTL'),('r89_mixed33_r86b_scan01','raw.tsv',None),('r89_pci33_r86b_probe01','raw.tsv',None)]:
 for v in csv.DictReader((b/folder/file).open(),delimiter='\t'):
  if kind:v['data_std']=v['wrt_std']=kind
  v['raw_hold_ns']=v.get('raw_hold_ns',v.get('hold_ns'));v.pop('hold_ns',None)
  v['qualified_hold_ns']=round(float(v['raw_hold_ns'])+2.,6);v['qualified_eye_ns']=round(float(v['setup_ns'])+v['qualified_hold_ns'],6);v['provenance']=folder;rows.append(v)
assert len(rows)==5054 and len({(v['data_std'],v['wrt_std'],v['data_drive'],v['wrt_drive'],v['data_slew'],v['wrt_slew'])for v in rows})==361
def merge(xs):
 ans=[]
 for lo,hi in sorted(xs):
  if ans and lo<=ans[-1][1]:ans[-1]=(ans[-1][0],max(hi,ans[-1][1]))
  else:ans.append((lo,hi))
 return ans
groups=[]
for wstd,wd,ws in sorted({(v['wrt_std'],v['wrt_drive'],v['wrt_slew'])for v in rows}):
 intersect=[(-100.,100.)];choices=[]
 for pin in sorted({v['pin']for v in rows}):
  opts=[v for v in rows if (v['wrt_std'],v['wrt_drive'],v['wrt_slew'],v['pin'])==(wstd,wd,ws,pin)];assert len(opts)==19
  choices.append(max(opts,key=lambda v:v['qualified_eye_ns']))
  ivals=merge([(-float(v['setup_ns']),v['qualified_hold_ns'])for v in opts if -float(v['setup_ns'])<=v['qualified_hold_ns']])
  intersect=merge([(max(x,lo),min(y,hi))for x,y in intersect for lo,hi in ivals if max(x,lo)<=min(y,hi)])
 groups.append({'wrt_standard':wstd,'wrt_drive':wd,'wrt_slew':ws,'fixed_clock_paths_hypothetical_common_phase_interval_ns':intersect,'worst_individual_largest_eye_ns':min(v['qualified_eye_ns']for v in choices),'individual_best_choices':choices})
result={'diagnostic_completed':True,'source_dcp_sha256':'c3a441afd3bd574d4c973d69a2ef1bd7759a506b1a8eb3366cff53730b2978bc','qualified_source_sha256':'a9bb116b7265dbc074646f073512fbf741f44a8db9bb16c4802c9ef6cc7069b7','configurations':361,'bit_rows':5054,'data_electrical_modes_per_pin':19,'WRT_electrical_modes':19,'best_single_bit_necessary_eye_ns':max(v['qualified_eye_ns']for v in rows),'all_groups_no_common_interval':not any(v['fixed_clock_paths_hypothetical_common_phase_interval_ns']for v in groups),'scope':'Immutable R86b mapped paths, all19 DC-compatible3.3V output electrical choices for data and WRT. +2ns BBAA normal hold is mathematical necessary diagnostic, not an applied exception. No PCB/jitter assumptions relaxed. Fixed-path hypothetical phase intervals are not proof of implementable clocks. Not universal impossibility across all architectures, calibrated hardware, constraints or devices. No bitstream.','groups':groups}
assert result['all_groups_no_common_interval'] and result['best_single_bit_necessary_eye_ns']<0
with (o/'all_5054_rows.tsv').open('w',newline='')as f:
 w=csv.DictWriter(f,fieldnames=list(rows[0]),delimiter='\t');w.writeheader();w.writerows(rows)
(o/'result.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print({k:v for k,v in result.items()if k!='groups'},flush=True)

print('R89_EVIDENCE_VERIFIED_NECESSARY_WINDOW_FAIL_NOT_RELEASED',flush=True)
