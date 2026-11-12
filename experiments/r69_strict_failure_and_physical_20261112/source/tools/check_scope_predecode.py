"""R41 native full-Scope/cohort comparison; old regression is unchanged."""
from pathlib import Path
import argparse,hashlib,json,re
from check_scope_average import simulate
ROOT=Path(__file__).resolve().parents[1]
PHASE=0

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
integer adc_cycles=0,writes=0,bus_transactions=0,known_memory_reads=0;integer seed=2026111026;
integer k,v,j;reg [31:0] factor,rd;
always @(negedge adc_clk)begin
 a=$random(seed);b=~a;aq=$random(seed);bq=aq^14'h1555;ext=(adc_cycles%127==9);asg=(adc_cycles%61==7);
end
always @(posedge adc_clk)begin
 #1;if(OLD_STATE!==NEW_STATE || {baseline_written,baseline_position,baseline_writing}!=={candidate_written,candidate_position,candidate_writing})$fatal(1,"SCOPE_PARENT_ADC_FAIL cycle=%0d old_dat=%h/%h new_dat=%h/%h",adc_cycles,baseline.adc_a_dat,baseline.adc_b_q_dat,candidate.adc_a_dat,candidate.adc_b_q_dat);
 if(baseline_writing===1'b1)writes=writes+1;adc_cycles=adc_cycles+1;
end
always @(posedge sys_clk)begin
 #1;if({baseline_rdata,baseline_ack,baseline_err}!=={candidate_rdata,candidate_ack,candidate_err})$fatal(1,"SCOPE_PARENT_BUS_FAIL adr=%h",addr);
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
 p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 reference=ROOT/'gateware/tests/timing/reference/r38_red_pitaya_scope.v'
 bridge=ROOT/'gateware/tests/timing/reference/r38_bus_clk_bridge.v'
 (out/'reference_bridge.v').write_bytes(bridge.read_bytes().replace(b'module bus_clk_bridge',b'module bus_clk_bridge_reference'))
 for PHASE in (0,1,2,3):parent(out/('phase_'+str(PHASE)),reference)
 (out/'results.json').write_text(json.dumps({'passed':True,'additional_ADC_CSR_trigger_cycles':0,'source_phases_ns':[0,1,2,3],'reference_scope_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'reference_bridge_sha256':hashlib.sha256(bridge.read_bytes()).hexdigest(),'scope':'Independently frozen full Scope/bridge, exact every-ADC config/trigger state and every-source bus differential. Busy input mutations, all configs, aliases/invalid/XZ, coordinated reset. Not independent-reset/metastability/physical CDC proof.'},indent=2),encoding='utf-8')
 print('SCOPE_SOURCE_PREDECODE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
