"""Fail closed on FPGA release checks. Does not generate or program a bitstream."""
from pathlib import Path
import argparse,hashlib,json,re,sys
p=argparse.ArgumentParser();p.add_argument('--physical',type=Path,required=True);p.add_argument('--functional',type=Path,required=True)
p.add_argument('--audit',type=Path,required=True);p.add_argument('--mapped-audit',type=Path,required=True);p.add_argument('--out',type=Path,required=True)
for name in ['io-review','cdc-review','drc-review']:p.add_argument('--'+name,type=Path)
a=p.parse_args();assert not a.out.exists(),'Use a new output filename; evidence is never overwritten'
read=lambda path:json.loads(path.read_text(encoding='utf-8'))
physical=read(a.physical/'manifest.json');functional=read(a.functional/'manifest.json');metrics=read(a.mapped_audit/'metrics.json')
dcp=a.physical/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest()
def hw(manifest):
 return {n:h for n,h in manifest['source_hashes'].items() if n.startswith(('gateware/','hardware/','linien-common/')) and not n.startswith(('gateware/tests/','gateware/build/'))}
def gate(ok,detail):return {'status':'PASS' if ok else 'FAIL','detail':detail}
gates={}
gates['functional']=gate(functional.get('functional')=='PASS' and not functional.get('source_changes_during_run'),{'input_head':functional['head'],'result':functional.get('functional'),'source_changes':functional.get('source_changes_during_run')})
source_equal=hw(physical)==hw(functional) and bool(hw(physical))
identity=physical['head']==functional['head'] or physical.get('logical_tokens_identical_without_known_physical_annotations') is True
gates['functional_covers_physical_hardware']=gate(source_equal and identity,{'hardware_raw_hashes_equal':source_equal,'same_input_or_strict_physical_logic_identity':identity,'files':len(hw(physical))})
gates['source_frozen_during_physical']=gate(physical.get('source_changes_during_run')==[],physical.get('source_changes_during_run'))
gates['synthesis_completed']=gate(physical.get('synthesis')=='COMPLETE' or str(physical.get('synthesis','')).startswith('REUSED_'),physical.get('synthesis'))
status_path=next((a.physical/n for n in ['routed_status.rpt','route_status.rpt'] if (a.physical/n).exists()),None)
errors=re.search(r'# of nets with routing errors\.+\s*:\s*(\d+)',status_path.read_text(errors='replace')) if status_path else None
gates['placement_route_completed']=gate(physical.get('route')=='COMPLETE' and bool(errors) and int(errors[1])==0,{'route':physical.get('route'),'routing_errors':int(errors[1]) if errors else 'NOT_PARSED'})
r=metrics['route']
gates['global_setup']=gate(r['wns']>=0 and r['tns']==0 and r['setup_failing']==0,{'WNS_ns':r['wns'],'TNS_ns':r['tns'],'violating_endpoints':r['setup_failing']})
gates['global_hold']=gate(r['whs']>=0 and r['ths']==0 and r['hold_failing']==0,{'WHS_ns':r['whs'],'THS_ns':r['ths'],'violating_endpoints':r['hold_failing']})
gates['FPGA_internal_pulse_width']=gate(r['wpws']>=0 and r['tpws']==0 and r['pulse_failing']==0,{'WPWS_ns':r['wpws'],'note':'Does not check external DAC minimum high pulse width.'})
checks=(a.audit/'checks.rpt').read_text(errors='replace')
coverage={name:int(re.search(r'checking '+name+r' \((\d+)\)',checks)[1]) for name in ['no_clock','unconstrained_internal_endpoints','no_input_delay','no_output_delay']}
gates['internal_clock_coverage']=gate(coverage['no_clock']==0 and coverage['unconstrained_internal_endpoints']==0,coverage)
clocks=(a.audit/'clocks.rpt').read_text(errors='replace');sys_period=re.search(r'^clk_2\s+([\d.]+)\s',clocks,re.M)
gates['target_125MHz_preserved']=gate(bool(sys_period) and float(sys_period[1])==8.0,{'SYS_period_ns':float(sys_period[1]) if sys_period else 'NOT_PARSED'})
adc=read(a.audit/'adc_protocol_validation.json')
gates['ADC_necessary_protocol_model']=gate(all(adc[n]['passed'] and adc[n]['complete_28_port_coverage'] for n in ['setup','hold']),{'setup':adc['setup']['worst_slack_ns'],'hold':adc['hold']['worst_slack_ns'],'scope':adc['scope']})
sync=read(a.audit/'sync_structure_validation.json')
gates['synchronizer_structure_only']=gate(sync['all_async_cells_exactly_one_two_stage_pair'] and sync['all_first_Q_only_second_D'] and all(q['slice_distance']==0 for q in sync['pairs']),{'ASYNC_FF':sync['async_registers'],'pairs':len(sync['pairs']),'scope':'Not the overall physical CDC signoff.'})
for field,argument in [('external_IO_full_protocol_and_PCB',a.io_review),('physical_CDC_protocol_faults_and_reliability',a.cdc_review),('DRC_risks_reviewed',a.drc_review)]:
 if argument is None:gates[field]={'status':'OPEN','detail':'No completed, matching-DCP engineering review supplied; statistics or structural checks do not replace this review.'}
 else:
  proof=read(argument);ok=proof.get('status')=='PASS' and proof.get('routed_dcp_sha256')==digest and bool(proof.get('evidence'))
  gates[field]=gate(ok,{'review_sha256':hashlib.sha256(argument.read_bytes()).hexdigest(),'review':proof})
ready=all(v['status']=='PASS' for v in gates.values())
result={'release_ready':ready,'status':'READY_FOR_ARTIFACT_BUILD_REVIEW' if ready else 'BLOCKED_NOT_RELEASED','physical_input_head':physical['head'],'functional_input_head':functional['head'],'routed_dcp_sha256':digest,'gates':gates,'source':'Read-only evidence gate. Never modifies a clock, timing exception, HDL, DCP or existing report. An OPEN is never silently promoted to PASS.'}
a.out.parent.mkdir(parents=True,exist_ok=True);a.out.write_text(json.dumps(result,indent=2),encoding='utf-8')
print(result['status']);print(json.dumps({n:v['status'] for n,v in gates.items()},indent=2))
sys.exit(0 if ready else 2)
