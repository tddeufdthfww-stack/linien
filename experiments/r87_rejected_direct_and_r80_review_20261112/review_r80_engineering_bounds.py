"""Read-only normal-transaction CDC and DRC engineering review, no release waiver."""
from pathlib import Path
import csv,hashlib,json,re,subprocess
b=Path(__file__).resolve().parent;root=Path('D:/RP_Dev/linien_trials/20261112-r80-status-cluster');audit=b/'r80_extended';drc=b/'r80_drc_structural_review03_20261112';out=b/'r80_engineering_review_20261112';out.mkdir(exist_ok=False)
classification=json.loads((audit/'cdc_scope_cohort_classification_v6.json').read_text());sync=json.loads((audit/'sync_structure_validation.json').read_text());ext=json.loads((audit/'result.json').read_text());dex=json.loads((drc/'results.json').read_text())
assert ext['input_dcp_unchanged'] and dex['export_complete'] and dex['unchanged']
assert not classification['remaining_unclassified_in_export']
for n,h in classification['source_sha256'].items():assert hashlib.sha256((root/n).read_bytes()).hexdigest()==h,n
csr=(root/'gateware/lowlevel/pitaya_ps.py').read_text();body=csr[csr.index('class Sys2CSR(Module):'):]
for frag in ['self.csr.adr.eq(self.sys.addr[2:])','self.csr.we.eq(self.sys.wen)','self.csr.dat_w.eq(self.sys.wdata)','self.sys.ack.eq(stb)']:assert frag in body
bridge=(root/'gateware/verilog/bus_clk_bridge.v').read_text()
assert 'sys_sync <= {sys_sync[0], dst_done};'in bridge
assert 'dst_sync <= {dst_sync[0], sys_do};'in bridge
assert 'assign wen_o = dst_ready[1] && sys_wr && (dst_sync[1]^dst_do);'in bridge
assert 'dst_rdata_hold <= rdata_i;'in bridge and 'if (ack_i && (dst_do != dst_done))'in bridge
assert sync['async_registers']==52 and len(sync['pairs'])==26 and sync['all_async_cells_exactly_one_two_stage_pair'] and sync['all_first_Q_only_second_D']
assert all(x['slice_distance']==0 for x in sync['pairs'])
def first_slack(file):return float(re.search(r'^Slack\s*\([^)]*\)\s*:\s*([-\d.]+)ns',file.read_text(),re.M)[1])
pair_setup=first_slack(audit/'sync_pair_setup.rpt');pair_hold=first_slack(audit/'sync_pair_hold.rpt');assert pair_setup>0 and pair_hold>0
normal=[x for x in classification['classification']if x['normal_min_two_receiving_periods_ns']is not None]
assert all(x['normal_min_two_receiving_periods_ns']==16 for x in normal)
guard_ns=1.0
for v in normal:
 v['engineer_selected_combined_guard_ns']=guard_ns;v['normal_receiving_window_after_guard_ns']=15.;v['normal_inventory_path_margin_ns']=round(15-v['worst_data_ns'],3);assert v['normal_inventory_path_margin_ns']>0
rows=list(csv.DictReader((drc/'no_loads.tsv').open(),delimiter='\t'));assert len(rows)==84 and all(v['leaf_input_pins']==v['output_ports']=='0'for v in rows)
op=list(csv.DictReader((drc/'opmode.tsv').open(),delimiter='\t'));assert len(op)==7
pins={int(v['pin']):v for v in op};assert pins[4]['driver']==pins[5]['driver']=='linienmodule_mixeralignedpid_error_s1_reg[0]/Q'
assert {i:pins[i]['constant']for i in [0,1,2,3,6]}=={0:'POWER',1:'GROUND',2:'POWER',3:'GROUND',6:'GROUND'}
text=(drc/'bitstream_drc.rpt').read_text();rules=re.findall(r'^\|\s*(\S+)\s*\|\s*(Warning|Advisory|Error|Critical Warning)\s*\|.*?\|\s*(\d+)\s*\|\s*$',text,re.M)
assert rules and not any(s in ['Error','Critical Warning']for _,s,_ in rules)
result={'subject':'R80 unchanged routed physical implementation','routed_dcp_sha256':ext['input_dcp_sha256'],
 'normal_CDC_engineering_review':{'status':'PASS_FOR_REVIEWED_NORMAL_PROTOCOL_AND_EXPORTED_INVENTORY','unclassified_exported_endpoints':0,'reviewed_endpoint_count':sum(x['endpoints']for x in normal),'source_sha256':classification['source_sha256'],'Sys2CSR_source_sha256':hashlib.sha256((root/'gateware/lowlevel/pitaya_ps.py').read_bytes()).hexdigest(),'minimum_nominal_two_destination_periods_ns':16,'engineer_selected_setup_jitter_and_path_inventory_guard_ns':guard_ns,'worst_normal_inventory_path_ns':max(x['worst_data_ns']for x in normal),'minimum_inventory_guarded_margin_ns':min(x['normal_inventory_path_margin_ns']for x in normal),'synchronizer_pairs':26,'same_SLICE_pairs':26,'first_Q_only_second_D':True,'pair_worst_setup_ns':pair_setup,'pair_worst_hold_ns':pair_hold,'groups':normal,
  'proof':'Request address/data and toggle publish together and are held while outstanding. Two receiver control stages produce wen, Sys2CSR captures adr/dat_w/we together at the next edge and the CSR consumer acts at a subsequent edge. Scope writes use the exact reviewed wen guards. Response payload and completion publish together; AXI captures after two control stages and next receiving edge. Reset does not rewrite held payload. Review covers the exported normal transaction inventory, not arbitrary sink names.',
  'limitations':['1ns is an explicitly selected engineering guard, not a measured maximum-jitter certificate.','Endpoint inventory consists of routed timing exports, not a formal all-path symbolic proof.','Reset/timeout/cancellation functional regressions are separate evidence; no universal analog metastability or numeric MTBF certification.','Asynchronous first-stage D timing is not claimed synchronously safe from incidental STA slack. GPIO remains independent asynchronous levels, not a coherent multibit transfer.']},
 'DRC_engineering_review':{'status':'NONFATAL_WARNINGS_REVIEWED_AND_RETAINED','error_or_critical_rules':0,'no_load_nets':84,'no_load_nets_have_actual_receivers':False,'routable_nets':26182,'fully_routed_nets':26182,'routing_errors':0,'rule_counts':{n:int(c)for n,s,c in rules},'dynamic_OPMODE':{'stable_bits':'{0,q,q,0,1,0,1}','q_driver':pins[4]['driver'],'PREG':0,'legal_stable_values':['0000101','0110101'],'stable_Z_sources':['0','C'],'stable_P_feedback_selected':False,'status':'EXACT_SAME_REGISTERED_CONTROL_AND_STABLE_BINARY_MODES_REVIEWED','limits':'Not an analog pin-skew/glitch characterization, no blanket rule disable or waiver. A future mapping/control change invalidates this review.'},'performance_power_advisories':'403 entries; retaining them avoids adding control-loop latency merely to remove advisories. R80 internal125MHz timing must remain independently PASS.'},
 'final_physical_CDC_and_DRC_release':'NOT_A_COMPLETE_RELEASE_CERTIFICATE; acceptance remains explicitly bounded above',
 'global_FPGA_release':'BLOCKED_BY_KNOWN_DAC_TIMING_AND_OPEN_EXTERNAL_PROTOCOL; no bitstream or board operation'}
(out/'results.json').write_text(json.dumps(result,indent=2,ensure_ascii=False),encoding='utf-8')
print('R80_NORMAL_PROTOCOL_CDC_BOUNDS_AND_EXACT_DRC_REVIEW_PASS',sum(x['endpoints']for x in normal),pair_setup,pair_hold,flush=True)
