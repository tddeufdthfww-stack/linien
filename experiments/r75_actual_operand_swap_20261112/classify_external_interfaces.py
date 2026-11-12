from pathlib import Path
import argparse,csv,hashlib,io,json,re
p=argparse.ArgumentParser();p.add_argument('--audit',type=Path,required=True);a=p.parse_args()
audit=a.audit.resolve();s=(audit/'checks.rpt').read_text();start=s.index('6. checking no_output_delay',s.index('6. checking no_output_delay')+1)
end=s.index('7. checking multiple_clock',start);section=s[start:end]
groups={
 'bidirectional_GPIO_level_interface':sorted(re.findall(r'^exp_[np]\[\d+\]$',section,re.M)),
 'LED_status_outputs':sorted(re.findall(r'^user_led(?:_\d+)?$',section,re.M)),
 'PWM_slow_output_waveforms':sorted(re.findall(r'^pwm(?:_\d+)?$',section,re.M)),
 'DAC_synchronous_controls':sorted(re.findall(r'^dac_(?:rst|sel)$',section,re.M)),
 'forwarded_DAC_clock_outputs_LOW':sorted(re.findall(r'^dac_(?:clk|wrt)$',section,re.M))}
assert list(map(len,groups.values()))==[16,8,4,2,2],groups
csv.field_size_limit(4_000_000)
rows=list(csv.DictReader(io.StringIO((audit/'synchronizers.tsv').read_text().replace(r'\t','\t')),delimiter='\t'))
structure=json.loads((audit/'sync_structure_validation.json').read_text())
gpio={r['cell']:r for r in rows if re.fullmatch(r'exp_[np]_IBUF\[\d+\]',r['D'])}
assert len(gpio)==16
pairs=[q for q in structure['pairs'] if q['first'] in gpio]
assert len(pairs)==16 and all(q['first_only_drives_second_D'] and q['slice_distance']==0 for q in pairs)
timing={}
for label,name in [('setup','sync_pair_setup.rpt'),('hold','sync_pair_hold.rpt')]:
 matches=[]
 for block in re.split(r'(?=Slack \((?:MET|VIOLATED)\))',(audit/name).read_text())[1:]:
  so=re.search(r'Source:\s*(\S+)',block);de=re.search(r'Destination:\s*(\S+)',block);sl=re.search(r'Slack \([^)]*\)\s*:\s*(-?[\d.]+)ns',block)
  if so and de and so[1].rsplit('/',1)[0] in gpio:matches.append({'source':so[1],'destination':de[1],'slack_ns':float(sl[1])})
 assert len({q['destination'] for q in matches})==16,(label,len(matches))
 timing[label]={'covered_gpio_pairs':16,'worst_slack_ns':min(q['slack_ns'] for q in matches),'paths':matches}
out={'audit_checks_sha256':hashlib.sha256((audit/'checks.rpt').read_bytes()).hexdigest(),
 'reported_no_output_delay':32,'HIGH_ports':30,'LOW_clock_ports':2,'output_groups':groups,
 'GPIO_async_input_pair_count':16,'GPIO_inputs':[{'port_buffer':gpio[q['first']]['D'],'first':q['first'],'second':q['second'],'same_slice':True,'first_Q_only_second_D':True} for q in pairs],
 'GPIO_pair_actual_STA':timing,
 'interpretation':{
 'GPIO':'RTL implements independent bit-level asynchronous level synchronization, not coherent multi-bit words or guaranteed arbitrary short pulse capture. External use/edge rates and MTBF remain unspecified.',
 'LED':'Status indicators have no declared external synchronous receiver; no-output-delay here is an interface category, not by itself a failed synchronous setup check.',
 'PWM':'Slow-output waveform interface, to be assessed with its actual board reconstruction/load rather than invented external sampling clock.',
 'DAC_controls':'IQSEL and IQRESET require real CLK/WRT protocol/edge timing; cannot waive as generic status signals.',
 'DAC_clocks':'Vivado LOW category already has propagated clock. Lack of output_delay is not missing data receiver setup budget, but external waveform/pulse requirements still apply.'},
 'signoff':'INVENTORY_AND_INTERNAL_GPIO_PAIR_TIMING_ONLY; not all external_IO/physical_CDC signed off. No constraints or source changed.'}
(audit/'external_interface_classification.json').write_text(json.dumps(out,indent=2))
print(json.dumps({'groups':{k:len(v) for k,v in groups.items()},'GPIO_pair_timing':{k:{x:v for x,v in d.items() if x!='paths'} for k,d in timing.items()},'signoff':out['signoff']},indent=2))
