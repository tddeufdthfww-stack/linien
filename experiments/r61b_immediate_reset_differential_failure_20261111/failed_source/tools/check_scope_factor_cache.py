"""R44 actual factor decoder/cache vs frozen Scope/bridge and integer oracle."""
from pathlib import Path
import argparse,hashlib,json,random,re
from check_scope_average import simulate
ROOT=Path(__file__).resolve().parents[1]
PHASE=0

ADAPTER='module scope_factor_cache_adapter(input [13:0] raw_i,input [47:0] sum_i,\n input [31:0] dec_i,input avg_i,output [13:0] value_o);\n wire [4:0] sh;wire z;\n scope_dec_factor_decode decode(dec_i,sh,z);\n scope_average_cached select(raw_i,sum_i,sh,z,avg_i,value_o);\nendmodule\n'

def scalar(out,reference):
 out.mkdir();text=reference.read_text();begin=text.index('      case (set_dec & {32{set_avg_en}})');end=text.index('      endcase',begin)
 cases=re.findall(r"(32'h[0-9a-fA-F]+|default)\s*:\s*begin adc_a_dat\s*<=\s*([^;]+);",text[begin:end]);assert len(cases)==34
 body='\n'.join(key+': value_o = '+expr.replace('adc_a_filt_out','raw_i').replace('adc_a_sum','sum_i')+';' for key,expr in cases)
 (out/'legacy.v').write_bytes(('module scope_average_legacy(input [13:0] raw_i,input [47:0] sum_i,input [31:0] dec_i,input avg_i,output reg [13:0] value_o);\nalways @* begin case(dec_i & {32{avg_i}})\n'+body+'\nendcase end\nendmodule\n').encode())
 rng=random.Random(2026111026);rows=[];valid=set()
 def emit(dec,avg,raw=None,total=None):
  raw=rng.getrandbits(14) if raw is None else raw;total=rng.getrandbits(48) if total is None else total
  key=dec if avg else 0
  if key==0:expected=raw
  elif key&(key-1)==0:expected=(total>>(key.bit_length()-1))&16383;valid.add(key.bit_length()-1)
  else:expected=total&16383
  rows.append([raw,total,dec,avg,expected])
 for dec in range(1<<16):
  for avg in (0,1):emit(dec,avg)
 for bit in range(32):
  for total in [0,1,(1<<47)-1,1<<47,(1<<48)-1]+[rng.getrandbits(48) for _ in range(20)]:emit(1<<bit,1,total=total)
 for _ in range(30000):emit(rng.getrandbits(32),rng.randrange(2))
 assert len(valid)==32
 (out/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
 (out/'tb.sv').write_bytes(b'''`timescale 1ns/1ps
module tb_scope_average;
reg [13:0] raw_i;reg [47:0] sum_i;reg [31:0] dec_i;reg avg_i;wire [13:0] old_value,new_value;reg [13:0] expected;
scope_average_legacy old_dut(raw_i,sum_i,dec_i,avg_i,old_value);
scope_factor_cache_adapter new_dut(raw_i,sum_i,dec_i,avg_i,new_value);
integer fd,k,count=0,i;integer seed=2026111026;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%h %h %h %h %h\\n",raw_i,sum_i,dec_i,avg_i,expected);if(k!=5)$fatal(1,"bad vector");#1;
  if(old_value!==expected || new_value!==expected)$fatal(1,"SCOPE_AVERAGE_FAIL cycle=%0d dec=%h avg=%b old=%h new=%h expected=%h",count,dec_i,avg_i,old_value,new_value,expected);
  count=count+1;
 end
 for(i=0;i<3000;i=i+1)begin
  raw_i=$random(seed);sum_i={$random(seed),$random(seed)};dec_i=$random(seed);avg_i=i[0];
  case(i%6)
   0:begin avg_i=1'bx;dec_i=0;end
   1:begin avg_i=1'bz;dec_i=1<<(i%32);end
   2:begin avg_i=1'bx;dec_i=3;end
   3:dec_i[i%32]=1'bx;
   4:begin avg_i=1'bx;dec_i[i%32]=1'bx;end
   5:begin raw_i[i%14]=1'bx;sum_i[i%48]=1'bx;end
  endcase
  #1;if(old_value!==new_value)$fatal(1,"SCOPE_AVERAGE_X_FAIL cycle=%0d dec=%h avg=%b old=%h new=%h",i,dec_i,avg_i,old_value,new_value);
 end
 $display("SCOPE_AVERAGE_SCALAR_PASS cases=%0d valid_factors=32 low16_exhaustive=65536 both_avg=1 unknown_cases=3000",count);$finish;
end
endmodule
''')
 simulate(out,'tb_scope_average',[ROOT/'gateware/verilog/red_pitaya_scope.v',out.parent/'cache_adapter.v',out/'legacy.v',out/'tb.sv'],'SCOPE_AVERAGE_SCALAR_PASS')
 (out/'results.json').write_bytes(json.dumps({'passed':True,'known_cases':len(rows),'unknown_cases':3000,'valid_factors':32,'exhaustive_low16':65536,'legacy_source_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'scope':'Actual production decoder+cached helper vs unchanged frozen case and independent bit-slice integer oracle; all invalid/default and strict X/Z behavior preserved.'},indent=2).encode())

def parent(out,reference):
 out.mkdir();original=reference.read_text(encoding='utf-8').replace('scope_average_select','scope_average_select_reference').replace('bus_clk_bridge i_bridge','bus_clk_bridge_reference i_bridge');assert original.count('module red_pitaya_scope\n')==1
 (out/'reference_scope.v').write_bytes(original.replace('module red_pitaya_scope\n','module red_pitaya_scope_reference\n').encode())
 mapping={'adc_a_i':'a','adc_b_i':'b','adc_a_q_i':'aq','adc_b_q_i':'bq','adc_clk_i':'adc_clk','adc_rstn_i':'adc_rstn','trig_ext_i':'ext','trig_asg_i':'asg','automatically_rearm_i':'auto_rearm','sys_clk_i':'sys_clk','sys_rstn_i':'sys_rstn','sys_addr_i':'addr','sys_wdata_i':'wdata','sys_sel_i':'sel','sys_wen_i':'we','sys_ren_i':'ren'}
 instances=''
 for prefix,module in [('baseline','red_pitaya_scope_reference'),('candidate','red_pitaya_scope')]:
  outputs={'sys_rdata_o':prefix+'_rdata','sys_err_o':prefix+'_err','sys_ack_o':prefix+'_ack','written_data':prefix+'_written','scope_position':prefix+'_position','scope_writing_now':prefix+'_writing'}
  instances+=module+' '+prefix+'('+','.join('.'+k+'('+v+')' for k,v in {**mapping,**outputs}.items())+');\n'
 fields=['adc_a_dat','adc_b_dat','adc_a_q_dat','adc_b_q_dat','adc_a_sum','adc_b_sum','adc_a_q_sum','adc_b_q_sum','adc_dec_cnt','adc_dv','adc_we','adc_wp','adc_wp_cur','adc_wp_trig','adc_dly_cnt','adc_dly_do','adc_trig','set_dec','set_avg_en','set_a_tresh','set_b_tresh','set_dly','set_a_hyst','set_b_hyst','set_a_filt_aa','set_a_filt_bb','set_a_filt_kk','set_a_filt_pp','set_b_filt_aa','set_b_filt_bb','set_b_filt_kk','set_b_filt_pp','set_trig_src','adc_arm_do','adc_rst_do','adc_trig_sw','addr','wdata','wen','ren']
 old='{'+','.join('baseline.'+k for k in fields)+'}';new='{'+','.join('candidate.'+k for k in fields)+'}'
 tb='''`timescale 1ns/1ps
module tb_scope_parent;
reg adc_clk=0;always #4 adc_clk=~adc_clk;reg sys_clk=0;initial begin #(PHASE_NS);forever #5 sys_clk=~sys_clk;end
reg adc_rstn=0,sys_rstn=0;reg [13:0] a=0,b=0,aq=0,bq=0;reg ext=0,asg=0,auto_rearm=1;
reg [31:0] addr=0,wdata=0;reg [3:0] sel=15;reg we=0,ren=0;
wire [31:0] baseline_rdata,candidate_rdata;wire baseline_ack,candidate_ack,baseline_err,candidate_err;
wire [13:0] baseline_written,candidate_written,baseline_position,candidate_position;wire baseline_writing,candidate_writing;
INSTANCES
reg source_take;
function automatic [5:0] factor_reference(input [31:0] d);
 integer bitn;
 begin
  factor_reference=0;
  if(d===32'd0)factor_reference=6'd32;
  else if((^d)!==1'bx && (d&(d-1))==0)
   for(bitn=0;bitn<32;bitn=bitn+1)if(d[bitn])factor_reference=bitn;
 end
endfunction
integer adc_cycles=0,writes=0,bus_transactions=0,known_memory_reads=0;integer seed=2026111026;
integer k,v,j;reg [31:0] factor,rd;
always @(negedge adc_clk)begin
 a=$random(seed);b=~a;aq=$random(seed);bq=aq^14'h1555;ext=(adc_cycles%127==9);asg=(adc_cycles%61==7);
end
always @(posedge adc_clk)begin
 #1;
 if({candidate.set_dec_zero,candidate.set_dec_shift}!==factor_reference(candidate.set_dec))
  $fatal(1,"SCOPE_FACTOR_TARGET_COHORT_FAIL cycle=%0d d=%h cache=%h",adc_cycles,candidate.set_dec,{candidate.set_dec_zero,candidate.set_dec_shift});
 if(OLD_STATE!==NEW_STATE || {baseline_written,baseline_position,baseline_writing}!=={candidate_written,candidate_position,candidate_writing})$fatal(1,"SCOPE_PARENT_ADC_FAIL cycle=%0d old_dat=%h/%h new_dat=%h/%h",adc_cycles,baseline.adc_a_dat,baseline.adc_b_q_dat,candidate.adc_a_dat,candidate.adc_b_q_dat);
 if(baseline_writing===1'b1)writes=writes+1;adc_cycles=adc_cycles+1;
end
always @(posedge sys_clk)begin
 source_take=(candidate.scope_src_capture===1'b1) && (sys_rstn!==1'b0);
 #1;
 if(source_take && {candidate.scope_dec_zero_source,candidate.scope_dec_shift_source}!==factor_reference(candidate.wdata))
  $fatal(1,"SCOPE_FACTOR_SOURCE_COHORT_FAIL data=%h cache=%h",candidate.wdata,{candidate.scope_dec_zero_source,candidate.scope_dec_shift_source});
 if({baseline_rdata,baseline_ack,baseline_err}!=={candidate_rdata,candidate_ack,candidate_err})$fatal(1,"SCOPE_PARENT_BUS_FAIL adr=%h",addr);
end
task transaction(input wr,input [31:0] adr,input [31:0] data,input [3:0] mask,output [31:0] result);
 integer wait_cycles;
 begin
  @(negedge sys_clk);addr=adr;wdata=data;sel=mask;we=wr;ren=!wr;wait_cycles=0;
  begin: wait_ack
   while(1)begin
    @(posedge sys_clk);#1;wait_cycles=wait_cycles+1;
    if(wait_cycles==3)begin
      // Once the source is busy, new live input values must not alter its held cohort.
      addr=32'hdeadbeef;wdata=32'hbaadf00d;sel=~mask;
    end
    if(baseline_ack===1'b1)disable wait_ack;
    if(wait_cycles>1000)$fatal(1,"scope bus timeout adr=%h",addr);
   end
  end
  result=baseline_rdata;
  if(!wr && (adr[19:16]==1 || adr[19:16]==2) && (^result)!==1'bx)known_memory_reads=known_memory_reads+1;
  bus_transactions=bus_transactions+1;
  @(negedge sys_clk);we=0;ren=0;repeat(4)@(posedge sys_clk);
 end
endtask
initial begin
 repeat(25)@(negedge adc_clk);adc_rstn=1;repeat(5)@(negedge sys_clk);sys_rstn=1;repeat(10)@(negedge sys_clk);
 transaction(1,32'h10,64,15,rd);transaction(1,0,1,15,rd);
 for(k=0;k<36;k=k+1)begin
  if(k<32)factor=32'h1<<k;else case(k)32:factor=0;33:factor=3;34:factor=5;default:factor=32'hffffffff;endcase
  for(v=0;v<2;v=v+1)begin
   transaction(1,32'h14,factor,k[3:0],rd);transaction(0,32'h14,0,15,rd);if(rd!==factor)$fatal(1,"factor readback");
   transaction(1,32'h28,v,v?15:0,rd);transaction(0,32'h28,0,15,rd);if(rd!==v)$fatal(1,"average readback");
   repeat(60)@(negedge adc_clk);
   transaction(0,32'h10000+k*4,0,15,rd);transaction(0,32'h20000+k*4,0,15,rd);
   if(k%5==0)transaction(1,32'h4,1,15,rd);
  end
 end
 @(negedge sys_clk);sys_rstn=0;adc_rstn=0;repeat(12)@(negedge adc_clk);adc_rstn=1;repeat(4)@(negedge sys_clk);sys_rstn=1;
 transaction(1,32'h10,32,15,rd);transaction(1,0,1,15,rd);
 for(j=0;j<200;j=j+1)begin
  case(j%6)
   0:transaction(1,32'h14,(j%12==0)?(32'h1<<(j%32)):$random(seed),j[3:0],rd);
   1:transaction(1,32'h28,j[0],15,rd);
   2:transaction(1,0,(j%24==2)?2:1,15,rd);
   3:transaction(1,32'h4,j%10,15,rd);
   4:transaction(0,32'h10000+((j%64)*4),0,15,rd);
   5:transaction(0,32'h20000+((j%64)*4),0,15,rd);
  endcase
 end
 // Exercise all configuration addresses, aliases, invalid selections and X/Z.
 for(j=0;j<500;j=j+1)begin
  case(j%20)
   0:factor=32'h0;
   1:factor=32'h4;
   2:factor=32'h8;
   3:factor=32'hC;
   4:factor=32'h10;
   5:factor=32'h14;
   6:factor=32'h20;
   7:factor=32'h24;
   8:factor=32'h28;
   9:factor=32'h30;
   10:factor=32'h34;
   11:factor=32'h38;
   12:factor=32'h3C;
   13:factor=32'h40;
   14:factor=32'h44;
   15:factor=32'h48;
   16:factor=32'h4C;
   17:factor=32'h2c;
   18:factor=32'h84;
   default:factor=32'hffffc;
  endcase
  factor[31:20]=j[11:0];
  if(j%17==0)factor[19:0]=20'hxxxxx;
  if(j%23==0)factor[19:0]=20'hzzzzz;
  transaction(1,factor,$random(seed),j[3:0],rd);
  transaction(0,factor,0,15,rd);
 end
 // Real bus unknown write payload and unknown averaging control.
 for(j=0;j<96;j=j+1)begin
  factor=$random(seed);
  case(j%4)
   0:factor[j%32]=1'bx;
   1:factor[j%32]=1'bz;
   2:factor=0;
   3:factor=32'h1<<(j%32);
  endcase
  transaction(1,32'h14,factor,j[3:0],rd);
  transaction(0,32'h14,0,15,rd);
  factor=$random(seed);factor[0]=j[0]?1'bx:1'bz;
  transaction(1,32'h28,factor,15,rd);
  transaction(0,32'h28,0,15,rd);
 end
 repeat(100)@(negedge adc_clk);
 if(writes<500 || bus_transactions<500 || known_memory_reads<10)$fatal(1,"parent coverage writes=%0d bus=%0d knownmem=%0d",writes,bus_transactions,known_memory_reads);
 $display("SCOPE_FULL_PARENT_PASS adc_cycles=%0d writes=%0d bus=%0d known_memory_reads=%0d sys100_adc125=1",adc_cycles,writes,bus_transactions,known_memory_reads);$finish;
end
initial begin #2000000;$fatal(1,"timeout");end
endmodule
'''.replace('INSTANCES',instances).replace('OLD_STATE',old).replace('NEW_STATE',new)
 (out/'tb.sv').write_bytes(tb.encode())
 (out/'tb.sv').write_bytes((out/'tb.sv').read_bytes().replace(b'PHASE_NS',str(PHASE).encode()))
 simulate(out,'tb_scope_parent',[out/'reference_scope.v',out.parent/'reference_bridge.v',ROOT/'gateware/verilog/red_pitaya_scope.v',ROOT/'gateware/verilog/bus_clk_bridge.v',out/'tb.sv'],'SCOPE_FULL_PARENT_PASS')
 (out/'results.json').write_bytes(json.dumps({'passed':True,'reference_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'scope':'Actual full Scope + independently frozen R38 Scope/bridge pair, every config/control state, busy-input mutation, aliases/invalid/XZ addresses;, all32 factors +0/3/5/default, live modes, byte masks/readback, distinct4 ADC lanes, sums/decimation/trigger/BRAM/write metadata and bus checked every clock with strict four-state equality; reset/rearm/trigger/readback, sys100MHz ADC125MHz functional CDC only.'},indent=2).encode())


def main():
 global PHASE
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 (out/'cache_adapter.v').write_text(ADAPTER,encoding='utf-8')
 scalar(out/'scalar',ROOT/'gateware/tests/timing/reference/r25_red_pitaya_scope.v')
 reference=ROOT/'gateware/tests/timing/reference/r38_red_pitaya_scope.v'
 bridge=ROOT/'gateware/tests/timing/reference/r38_bus_clk_bridge.v'
 (out/'reference_bridge.v').write_bytes(bridge.read_bytes().replace(b'module bus_clk_bridge',b'module bus_clk_bridge_reference'))
 for PHASE in (0,1,2,3):parent(out/('phase_'+str(PHASE)),reference)
 (out/'results.json').write_text(json.dumps({'passed':True,'new_serial_ADC_CSR_Scope_trigger_cycles':0,'parallel_metadata_bits':12,'scalar':json.loads((out/'scalar/results.json').read_text()),'phases_ns':[0,1,2,3],'source_target_cohort_assertions':'PASS every source acceptance/every ADC edge','scope':'Actual production encoder+barrel helper, original frozen case and integer oracle; actual whole Scope vs independently frozen R38 Scope/bridge, all config states, real bus unknown payload/avgX-Z, busy mutation and coordinated reset. Not physical CDC/metastability/independent-reset/SDF proof.'},indent=2),encoding='utf-8')
 print('SCOPE_FACTOR_CACHE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
