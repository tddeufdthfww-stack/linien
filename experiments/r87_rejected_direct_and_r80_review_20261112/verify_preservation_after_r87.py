from pathlib import Path
import hashlib,json,subprocess
b=Path(__file__).resolve().parent;records=json.loads((b.parent/'r6_execution/preserved_baselines.json').read_text(encoding='utf-8'))
for f in [b.parent/'r6_execution/preserved_r16_before_r17.json',b/'r60_preserved_before.json',b/'r80_pre_r81_frozen_before.json',b/'r83_pre_r84_frozen_before.json',b/'r84_pre_r85_frozen_before.json',b/'r85_pre_r86_frozen_before.json',b/'r86_pre_r87_frozen_before.json']:
 v=json.loads(f.read_text(encoding='utf-8'));records[v['root']]=v
ans={}
for name,v in records.items():
 root=Path(name);changed=[n for n,h in v['files'].items()if not(root/n).is_file()or hashlib.sha256((root/n).read_bytes()).hexdigest()!=h]
 head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip();status=subprocess.check_output(['git','status','--short'],cwd=root,text=True)
 ans[name]={'passed':not changed and head==v['head'] and status==v.get('status',''),'files_checked':len(v['files']),'changed':changed,'head_unchanged':head==v['head'],'status_unchanged':status==v.get('status','')}
result={'passed':all(x['passed']for x in ans.values()),'roots':ans};(b/'preserved_baselines_after_r87_20261112.json').write_text(json.dumps(result,indent=2));print('PRESERVED_BASELINES_AFTER_R87',result['passed'],[(n,v['files_checked'])for n,v in ans.items()]);assert result['passed']
