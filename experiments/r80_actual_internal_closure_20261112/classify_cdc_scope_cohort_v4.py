from pathlib import Path
import argparse,csv,hashlib,io,json,re,collections
p=argparse.ArgumentParser();p.add_argument('--audit',type=Path,required=True);p.add_argument('--root',type=Path,required=True);a=p.parse_args()
root=a.root.resolve();audit=a.audit.resolve()
bridge=(root/'gateware/verilog/bus_clk_bridge.v').read_text();scope=(root/'gateware/verilog/red_pitaya_scope.v').read_text()
# Provenance checks for the specifically reviewed source, not a general HDL proof.
for fragment in ['else if (scope_src_capture)', 'scope_dec_shift_source <= scope_dec_shift_next;',
                 'scope_dec_zero_source <= scope_dec_zero_next;']:
 assert fragment in scope,fragment
assert re.search(r'\.src_capture_o\s*\(\s*scope_src_capture\s*\)',scope)
assert "scope_addr_match[1] <= (sys_addr_i[19:0] == 20'h4);" in scope
assert 'adc_trig_sw <= wen && (scope_addr_match[1])' in scope
assert 'if (wen && (scope_addr_match[1]))' in scope
assert 'set_trig_src <= wdata[3:0]' in scope
for fragment in ['assign src_capture_o = src_ready[1] &&',
                 '(sys_do == sys_done) && (sys_wen_i || sys_ren_i)',
                 'dst_sync <= {dst_sync[0], sys_do};', 'dst_do   <= dst_sync[1];',
                 'sys_sync <= {sys_sync[0], dst_done};','sys_done <= sys_sync[1];']:
 assert fragment in bridge,fragment
groups=collections.defaultdict(list);unclassified=[]
for file in sorted(audit.glob('cdc_*_max.tsv')):
 rows=list(csv.DictReader(io.StringIO(file.read_text().replace(r'\t','\t')),delimiter='\t'))
 for row in rows:
  so,en=row['start'],row['end']
  if re.search(r'/(dst_sync|sys_sync)_reg\[0\]/D$',en):group='first_control_synchronizer'
  elif en.endswith('/CLR') and 'ready_reg' in en:group='asynchronous_reset_assertion_to_release_pair'
  elif re.search(r'/(addr_o|wdata_o|sys_rd|sys_wr)_reg',so):group='forward_request_bundle'
  elif '/dst_rdata_hold_reg' in so or '/dst_err_hold_reg' in so:group='returned_response_bundle'
  elif re.search(r'/scope_addr_match_reg\[1\]/C$',so) and re.search(r'/(set_trig_src_reg\[[0-3]\]/CE|adc_trig_sw_reg/D)$',en):group='scope_address4_decode_same_request_cohort'
  elif re.search(r'/scope_addr_match_reg\[0\]/C$',so) and re.search(r'/adc_arm_do_reg(?:_rep(?:__\d+)?)?/D$',en):group='scope_address0_arm_same_request_cohort'
  elif re.search(r'/scope_addr_match_reg\[8\]/C$',so) and re.search(r'/set_avg_en_reg/(?:D|CE)$',en):group='scope_address28_average_same_request_cohort'
  elif re.search(r'/scope_addr_match_reg\[9\]/C$',so) and re.search(r'/set_a_filt_aa_reg\[\d+\]/CE$',en):group='scope_address30_filter_same_request_cohort'
  elif re.search(r'/scope_dec_(shift_source_reg\[[0-4]\]|zero_source_reg)/C$',so) and re.search(r'/set_dec_(shift_reg\[[0-4]\]|zero_reg)/D$',en):group='scope_dec_metadata_same_request_cohort'
  else:unclassified.append({'file':file.name,**row});continue
  groups[(file.name,group)].append(row)
assert not unclassified,unclassified[:10]
report=[]
for (file,group),rows in sorted(groups.items()):
 worst=max(rows,key=lambda r:float(r['data_ns']))
 window=16 if group in ['forward_request_bundle','returned_response_bundle','scope_dec_metadata_same_request_cohort','scope_address4_decode_same_request_cohort','scope_address0_arm_same_request_cohort','scope_address28_average_same_request_cohort','scope_address30_filter_same_request_cohort'] else None
 report.append({'file':file,'group':group,'endpoints':len(rows),'worst_data_ns':float(worst['data_ns']),
  'source':worst['start'],'end':worst['end'],'normal_min_two_receiving_periods_ns':window,
  'provisional_margin_before_setup_jitter_hold_fault_review_ns':round(window-float(worst['data_ns']),3) if window else None})
assert sum(r['endpoints'] for r in report if r['group']=='scope_dec_metadata_same_request_cohort')==6
out={'source_sha256':{n:hashlib.sha256((root/n).read_bytes()).hexdigest() for n in ['gateware/verilog/bus_clk_bridge.v','gateware/verilog/red_pitaya_scope.v']},
 'classification':report,'remaining_unclassified_in_export':unclassified,
 'proof_scope':'Source-reviewed exact publish/hold guards plus routed endpoint inventory. Six decimation metadata bits and address4 trigger-select decode are captured on the same src_capture_o edge as address/data and held until a later accepted request. Address4, address0 arm, address28 average-enable and address30 A-filter-aa consumers explicitly gated by wen in the reviewed source. This classifier only adds the exact reviewed source/sink pairs, not a broad name waiver. Original v3 FAIL is retained. Normal consumer cannot act until request traverses two receiver stages. Return is captured with destination ACK/toggle. No timing exception or source modification.',
 'limitations':'16ns is nominal normal minimum of two receiving periods, not a complete physical CDC signoff. Must include actual minimum period/jitter, setup/hold guards, all response-qualified sinks, metastability resolution/MTBF, startup/independent reset/timeout cancellation. Reset CLR and first synchronizer data are separate categories, not 16ns bundles. Existing original classification files are retained.',
 'final_physical_CDC':'NOT_SIGNED_OFF_BY_THIS_CLASSIFICATION_ALONE'}
(audit/'cdc_scope_cohort_classification_v4.json').write_text(json.dumps(out,indent=2))
print(json.dumps({'classification':report,'unclassified':len(unclassified),'final_physical_CDC':out['final_physical_CDC']},indent=2))
