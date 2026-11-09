from pathlib import Path
import hashlib,json,re,subprocess
ROOT=Path('D:/RP_Dev/linien_trials/20261109-r3-fast-front')
BASE=Path('D:/RP_Dev/linien_trials/20261106-ce-saturation/gateware/build/trials/20261109_100550_ce_sat_bits')
OUT=Path('C:/Users/admin/Documents/Codex/2026-11-05/ba/outputs')

def paths(folder):
    output={}
    inventory=folder/'pin_inventory.txt'
    if inventory.exists():
        for line in inventory.read_text().splitlines():
            parts=line.split()
            if len(parts)==5 and parts[3]=='PINS' and parts[4]=='0':
                output['_'.join(parts[:3])]={'physical_pins':0,'timed_path':'NO PHYSICAL PIN'}
    for path in sorted(folder.glob('*.rpt')):
        text=path.read_text(errors='replace')
        if not re.search(r'Slack \(',text):
            output[path.stem]={'timed_path':'NONE'};continue
        section=re.split(r'(?=Slack \()',text)[1]
        item={}
        for key,pattern in [('slack_ns',r'Slack .*?:\s*([-\d.]+)ns'),
                ('source',r'^  Source:\s*(.+)'),('destination',r'^  Destination:\s*(.+)'),
                ('data_path',r'^  Data Path Delay:\s*(.+)'),('logic_levels',r'^  Logic Levels:\s*(.+)')]:
            match=re.search(pattern,section,re.M)
            if match:item[key]=match[1].strip()
        output[path.stem]=item
    return output

def timing(file):
    if not file.exists():return {'status':'NOT RUN'}
    text=file.read_text(errors='replace');lines=text.splitlines();item={}
    for i,line in enumerate(lines):
        if line.lstrip().startswith('WNS(ns)'):
            item.update(dict(zip(['wns','tns','setup_failed','setup_total','whs','ths','hold_failed','hold_total','wpws','tpws','pulse_failed','pulse_total'],lines[i+2].split())))
            break
    for key in ('no_clock','unconstrained_internal_endpoints','no_input_delay','no_output_delay'):
        match=re.search('checking '+key+r' \((\d+)\)',text)
        if match:item[key]=int(match[1])
    return item

def util(file):
    if not file.exists():return {}
    output={}
    for line in file.read_text(errors='replace').splitlines():
        m=re.match(r'\|\s*(Slice LUTs|Slice Registers|Block RAM Tile|DSPs|BUFGCTRL)\*?\s*\|\s*([\d.]+)\s*\|',line)
        if m:output[m[1]]=m[2]
    return output

def cdc(file):
    if not file.exists():return {}
    out={}
    for line in file.read_text(errors='replace').splitlines():
        m=re.match(r'(CDC-\d+)\s+(\w+)\s+(\d+)\s+',line)
        if m:out[m[1]]={'severity':m[2],'count':int(m[3])}
    return out

def cdc_edges(file):
    source=destination='';edges=set()
    for line in file.read_text(errors='replace').splitlines():
        if line.startswith('Source Clock:'):source=line.split(':',1)[1].strip()
        if line.startswith('Destination Clock:'):destination=line.split(':',1)[1].strip()
        words=line.split()
        if len(words)>8 and words[0].isdigit() and words[1].startswith('CDC-'):
            edges.add((words[1],source,destination,words[-2],words[-1]))
    return edges

def metrics(run):
    manifest=json.loads((run/'manifest.json').read_text())
    hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in run.iterdir() if p.name in ('top.v','top.xdc','top.tcl','synth.dcp','routed.dcp')}
    markers=[]
    for p in sorted(run.glob('*.stdout.log')):
        for line in p.read_text(errors='replace').splitlines():
            if re.search(r'\b[A-Z][A-Z0-9_]*PASS\b',line):markers.append({'log':p.name,'marker':line.strip()})
    commands={p.stem:json.loads(p.read_text()) for p in sorted(run.glob('*.json')) if p.name!='manifest.json'}
    return {'directory':str(run),'manifest':manifest,'synth':timing(run/'synth_timing.rpt'),'routed':timing(run/'routed_timing.rpt'),'synth_util':util(run/'synth_utilization.rpt'),'routed_util':util(run/'routed_utilization.rpt'),'cdc':cdc(run/'routed_cdc.rpt'),'hashes':hashes,'pass_markers':markers,'commands':commands}

baseline_details=ROOT/'gateware/build/r3_baseline_final'
if not (baseline_details/'critical_cells.txt').exists():baseline_details=ROOT/'gateware/build/r3_baseline_readonly_v3'
result={'baseline':metrics(BASE),'baseline_pid_paths':paths(baseline_details)}
trials=list((ROOT/'gateware/build/trials').glob('*r3_error_select'))
if trials:
    run=trials[-1];result['candidate']=metrics(run)
    if (run/'pid_details').exists():result['candidate_pid_paths']=paths(run/'pid_details')
    if (run/'routed_cdc.rpt').exists():
        old=cdc_edges(BASE/'routed_cdc.rpt');new=cdc_edges(run/'routed_cdc.rpt')
        norm=lambda e:tuple(x.replace('logic_pid_pid_','logic_pid_') for x in e)
        old_norm={norm(e) for e in old};new_norm={norm(e) for e in new}
        added=sorted(new_norm-old_norm);removed=sorted(old_norm-new_norm)
        result['cdc_delta']={'old_rows':len(old),'new_rows':len(new),'raw_added':sorted(new-old),'raw_removed':sorted(old-new),
                'normalized_added':added,'normalized_removed':removed,
                'normalization':'Only source naming prefix logic_pid_pid_ -> logic_pid_; replicas retained.',
                'all_changed_edges_existing_bridge_payload_to_csr':all(e[0]=='CDC-1' and e[3].startswith(('bus_clk_bridge/addr_o_reg','bus_clk_bridge/wdata_o_reg')) and e[4].startswith(('linienmodule_csr_adr_reg','linienmodule_csr_dat_w_reg')) for e in added+removed),
                'physical_safety':'NOT PROVEN'}
orig=json.loads((ROOT/'experiments/baseline_20261106/source_manifest.json').read_text())
result['original_source_changes']=[n for n,digest in orig['effective_source_sha256'].items() if hashlib.sha256((Path(orig['source_directory'])/n).read_bytes()).hexdigest()!=digest]
result['r2b_status']=subprocess.check_output(['git','status','--porcelain'],cwd=BASE.parents[3],text=True).strip()
OUT.mkdir(exist_ok=True)
(OUT/'LINIEN_R3_METRICS_20261109.json').write_text(json.dumps(result,indent=2,ensure_ascii=False),encoding='utf-8')
print('BASELINE PATHS',json.dumps(result['baseline_pid_paths'],indent=2))
if 'candidate' in result:
    c=result['candidate'];print('CANDIDATE',c['manifest']['functional'],c['manifest']['synthesis'],c['manifest']['route'],c['synth'],c['routed'])
print('PRESERVATION',result['original_source_changes'],repr(result['r2b_status']))
