from pathlib import Path
import hashlib,json,re,subprocess
base=Path(__file__).resolve().parent
root=Path('D:/RP_Dev/linien_trials/20261112-r80-status-cluster')
scope=(root/'gateware/verilog/red_pitaya_scope.v').read_text(encoding='utf-8')
# Inspect only these additional source/sink pairs, not every named decoder.
assert 'scope_addr_match[0] <= (sys_addr_i[19:0] == 20\'h0);' in scope
assert 'adc_arm_do  <= (automatically_rearm_i && (adc_we == 1\'b0)) || (wen && (scope_addr_match[0]) && wdata[0])' in scope
assert 'scope_addr_match[8] <= (sys_addr_i[19:0] == 20\'h28);' in scope
assert 'scope_addr_match[9] <= (sys_addr_i[19:0] == 20\'h30);' in scope
block=scope[scope.index('      if (wen) begin',scope.index('set_a_filt_aa <=  18\'h0')):]
assert re.search(r'if \(scope_addr_match\[8\]\)\s+set_avg_en\s+<= wdata\[\s*0\]',block)
assert re.search(r'if \(scope_addr_match\[9\]\)\s+set_a_filt_aa\s+<= wdata\[18-1:0\]',block)
source=(base/'classify_cdc_scope_cohort_v3.py').read_text(encoding='utf-8')
anchor="  elif re.search(r'/scope_dec_(shift_source_reg"
index=source.index(anchor)
extra="""  elif re.search(r'/scope_addr_match_reg\\[0\\]/C$',so) and re.search(r'/adc_arm_do_reg(?:_rep(?:__\\d+)?)?/D$',en):group='scope_address0_arm_same_request_cohort'
  elif re.search(r'/scope_addr_match_reg\\[8\\]/C$',so) and re.search(r'/set_avg_en_reg/(?:D|CE)$',en):group='scope_address28_average_same_request_cohort'
  elif re.search(r'/scope_addr_match_reg\\[9\\]/C$',so) and re.search(r'/set_a_filt_aa_reg\\[\\d+\\]/CE$',en):group='scope_address30_filter_same_request_cohort'
"""
source=source[:index]+extra+source[index:]
source=source.replace("'scope_address4_decode_same_request_cohort']", "'scope_address4_decode_same_request_cohort','scope_address0_arm_same_request_cohort','scope_address28_average_same_request_cohort','scope_address30_filter_same_request_cohort']")
source=source.replace('cdc_scope_cohort_classification_v3.json','cdc_scope_cohort_classification_v4.json')
source=source.replace('Address4 consumers explicitly gated by wen.', 'Address4, address0 arm, address28 average-enable and address30 A-filter-aa consumers explicitly gated by wen in the reviewed source. This classifier only adds the exact reviewed source/sink pairs, not a broad name waiver. Original v3 FAIL is retained.')
p=base/'classify_cdc_scope_cohort_v4.py';p.write_text(source,encoding='utf-8')
cmd=['python','-X','utf8',str(p),'--audit',str(base/'r80_extended'),'--root',str(root)]
r=subprocess.run(cmd,capture_output=True);(base/'r80_cohort_v4.stdout.log').write_bytes(r.stdout);(base/'r80_cohort_v4.stderr.log').write_bytes(r.stderr)
assert r.returncode==0,r.stderr.decode(errors='replace')
net=base.parent/'r6_execution/r80_status_routed_audit/routed_netlist.v'
text=net.read_text(encoding='utf-8')
match=re.search(r'DSP48E1\s*#\((.*?)\)\s+p_1_out\s*\((.*?)\);',text,re.S);assert match
params,ports=match.groups();assert '.PREG(0)' in params and '.OPMODEREG(0)' in params
mode=re.search(r'\.OPMODE\((.*?)\)',ports)[1]
assert mode=="{1'b0,linienmodule_mixeralignedpid_error_s1,linienmodule_mixeralignedpid_error_s1,1'b0,1'b1,1'b0,1'b1}",mode
cases=[{'control':c,'OPMODE':f'{(0x05 if c==0 else 0x35):07b}','z_select':f'{(0 if c==0 else 3):03b}','Z':'0' if c==0 else 'C','P_feedback_selected':False} for c in [0,1]]
out={'netlist_sha256':hashlib.sha256(net.read_bytes()).hexdigest(),'cell':'p_1_out','PREG':0,'OPMODEREG':0,
 'actual_OPMODE_connection':mode,'stable_binary_cases':cases,
 'stable_state_P_feedback':'UNREACHABLE_FOR_KNOWN_BINARY_CONTROL',
 'scope':'UG479 Table2-9 Z=000 is 0, Z=011 is C; P feedback requires 010/100/110. Exact two select pins share the same net. No DRC waiver or source change.',
 'limitations':'This proves stable binary selection only. It is not an analog select-pin skew/glitch proof, not four-state startup equivalence and not a blanket DRC signoff. Preserve DPREG-4 and review physical behavior before release.',
 'reference':'https://docs.amd.com/v/u/en-US/ug479_7Series_DSP48E1'}
(base/'r80_dpreg4_stable_mode_review.json').write_text(json.dumps(out,indent=2),encoding='utf-8')
print('R80_EXACT_COHORT_INVENTORY_CLASSIFIED_NOT_CDC_SIGNOFF; DPREG4_STABLE_BINARY_SELECTION_REVIEW_COMPLETE')
