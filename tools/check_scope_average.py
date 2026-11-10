"""Native real Scope selector and full Scope/bridge pair vs frozen R25 RTL."""
from pathlib import Path
import argparse,hashlib,json,random,re,subprocess
ROOT=Path(__file__).resolve().parents[1]
TOOL=Path('D:/Xilinx/Vivado/2020.1/bin')

def simulate(out,top,sources,marker):
 for label,cmd,expected in [('compile',[TOOL/'xvlog.bat','--sv',*sources],None),('elaborate',[TOOL/'xelab.bat',top,'-s',top,'--timescale','1ns/1ps'],None),('simulate',[TOOL/'xsim.bat',top,'-runall'],marker)]:
  cmd=[str(v) for v in cmd];res=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(res.stdout);(out/(label+'.stderr.log')).write_bytes(res.stderr)
  text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not expected or expected in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
  (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2).encode());print(top,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-8000:]
  if expected:print(re.search(expected+r'[^\r\n]*',text)[0],flush=True)

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
scope_average_select new_dut(raw_i,sum_i,dec_i,avg_i,new_value);
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
 simulate(out,'tb_scope_average',[ROOT/'gateware/verilog/red_pitaya_scope.v',out/'legacy.v',out/'tb.sv'],'SCOPE_AVERAGE_SCALAR_PASS')
 (out/'results.json').write_bytes(json.dumps({'passed':True,'known_cases':len(rows),'unknown_cases':3000,'valid_factors':32,'exhaustive_low16':65536,'legacy_source_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'scope':'Actual production helper vs unchanged frozen case and independent bit-slice integer oracle; all invalid/default and strict X/Z behavior preserved.'},indent=2).encode())

def parent(out,reference):
 out.mkdir();original=reference.read_text();assert original.count('module red_pitaya_scope\n')==1
 (out/'reference_scope.v').write_bytes(original.replace('module red_pitaya_scope\n','module red_pitaya_scope_reference\n').encode())
 mapping={'adc_a_i':'a','adc_b_i':'b','adc_a_q_i':'aq','adc_b_q_i':'bq','adc_clk_i':'adc_clk','adc_rstn_i':'adc_rstn','trig_ext_i':'ext','trig_asg_i':'asg','automatically_rearm_i':'auto_rearm','sys_clk_i':'sys_clk','sys_rstn_i':'sys_rstn','sys_addr_i':'addr','sys_wdata_i':'wdata','sys_sel_i':'sel','sys_wen_i':'we','sys_ren_i':'ren'}
 instances=''
 for prefix,module in [('baseline','red_pitaya_scope_reference'),('candidate','red_pitaya_scope')]:
  outputs={'sys_rdata_o':prefix+'_rdata','sys_err_o':prefix+'_err','sys_ack_o':prefix+'_ack','written_data':prefix+'_written','scope_position':prefix+'_position','scope_writing_now':prefix+'_writing'}
  instances+=module+' '+prefix+'('+','.join('.'+k+'('+v+')' for k,v in {**mapping,**outputs}.items())+');\n'
 fields=['adc_a_dat','adc_b_dat','adc_a_q_dat','adc_b_q_dat','adc_a_sum','adc_b_sum','adc_a_q_sum','adc_b_q_sum','adc_dec_cnt','adc_dv','adc_we','adc_wp','adc_wp_cur','adc_wp_trig','adc_dly_cnt','adc_dly_do','adc_trig','set_dec','set_avg_en']
 old='{'+','.join('baseline.'+k for k in fields)+'}';new='{'+','.join('candidate.'+k for k in fields)+'}'
 tb='''`timescale 1ns/1ps
module tb_scope_parent;
reg adc_clk=0;always #4 adc_clk=~adc_clk;reg sys_clk=0;always #5 sys_clk=~sys_clk;
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
 repeat(100)@(negedge adc_clk);
 if(writes<500 || bus_transactions<500 || known_memory_reads<10)$fatal(1,"parent coverage writes=%0d bus=%0d knownmem=%0d",writes,bus_transactions,known_memory_reads);
 $display("SCOPE_FULL_PARENT_PASS adc_cycles=%0d writes=%0d bus=%0d known_memory_reads=%0d sys100_adc125=1",adc_cycles,writes,bus_transactions,known_memory_reads);$finish;
end
initial begin #2000000;$fatal(1,"timeout");end
endmodule
'''.replace('INSTANCES',instances).replace('OLD_STATE',old).replace('NEW_STATE',new)
 (out/'tb.sv').write_bytes(tb.encode())
 simulate(out,'tb_scope_parent',[out/'reference_scope.v',ROOT/'gateware/verilog/red_pitaya_scope.v',ROOT/'gateware/verilog/bus_clk_bridge.v',out/'tb.sv'],'SCOPE_FULL_PARENT_PASS')
 (out/'results.json').write_bytes(json.dumps({'passed':True,'reference_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'scope':'Actual full Scope + unchanged real bridge pair, all32 factors +0/3/5/default, live modes, byte masks/readback, distinct4 ADC lanes, sums/decimation/trigger/BRAM/write metadata and bus checked every clock with strict four-state equality; reset/rearm/trigger/readback, sys100MHz ADC125MHz functional CDC only.'},indent=2).encode())

def main():
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 reference=ROOT/'gateware/tests/timing/reference/r25_red_pitaya_scope.v'
 scalar(out/'scalar',reference);parent(out/'parent',reference)
 (out/'results.json').write_bytes(json.dumps({'passed':True,'additional_cycles':0,'reference_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),'scope':'Native production helper scalar integer oracle + full frozen-reference Scope/real bridge functional differential. No physical CDC/STA proof.'},indent=2).encode())
 print('SCOPE_AVERAGE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
