import csv,json
from pathlib import Path
b=Path(__file__).resolve().parent;o=b/'r86b_qualified_eye_scan01';rows=list(csv.DictReader((o/'raw.tsv').open(),delimiter='\t'));ans=[]
for ws in ['FAST','SLOW']:
 for wc in [4,8,12,16]:
  bits=[]
  for pin in sorted({r['pin']for r in rows}):
   opts=[r for r in rows if r['wrt_slew']==ws and int(r['wrt_drive'])==wc and r['pin']==pin]
   best=max(opts,key=lambda r:float(r['setup_ns'])+float(r['raw_hold_ns'])+2.0)
   bits.append({**best,'largest_individual_necessary_eye_ns':round(float(best['setup_ns'])+float(best['raw_hold_ns'])+2.0,3)})
  ans.append({'wrt_drive':wc,'wrt_slew':ws,'worst_individual_best_eye_ns':min(x['largest_individual_necessary_eye_ns']for x in bits),'all_individually_feasible':all(x['largest_individual_necessary_eye_ns']>=0 for x in bits),'bits':bits})
(o/'per_bit_maximum_eyes.json').write_text(json.dumps(ans,indent=2));print([(x['wrt_slew'],x['wrt_drive'],x['worst_individual_best_eye_ns'],x['all_individually_feasible'])for x in ans])
