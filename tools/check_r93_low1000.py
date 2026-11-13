"""R93 VCO1000 LOW MMCM vs original VCO1000 OPTIMIZED, FDRE reference."""
from pathlib import Path
import argparse,hashlib,json,re,subprocess
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args()
out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
source=ROOT/'gateware/tests/timing/r93/dac_low1000_probe.v'
tb=r'''`timescale 1ns/1ps
module tb_r84;
reg clk125_p=0,clock_run=1;always #4 if(clock_run)clk125_p=~clk125_p;
wire clk125_n=~clk125_p;reg reset_i=1;
wire[13:0]old_data,new_data;
wire old_wrt,new_wrt,old_clk,new_clk,old_sel,new_sel,old_rst,new_rst;
dac_serdes_probe #(.USE_SERDES(0)) old(.clk125_p(clk125_p),.clk125_n(clk125_n),.reset_i(reset_i),.dac_data(old_data),.dac_wrt(old_wrt),.dac_clk(old_clk),.dac_sel(old_sel),.dac_rst(old_rst));
dac_low1000_probe #(.USE_SERDES(0)) dut(.clk125_p(clk125_p),.clk125_n(clk125_n),.reset_i(reset_i),.dac_data(new_data),.dac_wrt(new_wrt),.dac_clk(new_clk),.dac_sel(new_sel),.dac_rst(new_rst));
reg producer_enabled=0;
integer qualified=0,checks=0,pair_checks=0,frames=0,epochs=0,clock_checks=0;
integer a_checks=0,b_checks=0,all_values=0;
// Both probes generate their stimuli internally. Different MMCM lock times
// must not accidentally turn the comparison into different input streams.
// Clamp only stimulus counters/holds, never clock/reset/serializer state.
initial forever begin
 producer_enabled=0;
 force old.counter=0; force old.a_hold=0; force old.b_hold=0;
 force dut.counter=0; force dut.a_hold=0; force dut.b_hold=0;
 wait(reset_i===0 && clock_run===1);
 wait(old_rst===0 && new_rst===0);
 repeat(4)@(negedge old.sys_clk);
 #1;
 release old.counter; release old.a_hold; release old.b_hold;
 release dut.counter; release dut.a_hold; release dut.b_hold;
 producer_enabled=1;
 wait(reset_i===1 || clock_run===0);
end

// A stopped reference has no stable phase oracle until reacquisition.
// The separately bounded reset assertion remains checked below.
always@(negedge clock_run)qualified=0;
reg[13:0]model_count=0,model_a=0,slot_a=0,slot_b=0;
reg[16383:0]seen_a=0,seen_b=0;real last_sys=-1000,delta;
always@(posedge old.sys_clk)begin
 last_sys=$realtime;
 if(old.sys_rst || !producer_enabled)begin model_count<=0;model_a<=0;slot_a<=0;slot_b<=0;end
 else begin slot_a<=model_a;slot_b<=~model_count;model_a<=model_count;model_count<=model_count+1'b1;end
 if(producer_enabled && clock_run && old_rst===0 && new_rst===0)qualified<=qualified+1;else qualified<=0;
end
always@(negedge new_rst)begin
 if(dut.locked!==1 || dut.data_rst!==0 || dut.sample_rst!==0 || dut.sys_rst!==0)$fatal(1,"R93_RELEASE_WITHOUT_STABLE_DOMAINS");
 epochs=epochs+1;
end
always #0.125 if(clock_run && qualified>12 && old_rst===0 && new_rst===0)begin
 if({old_data,old_wrt,old_clk,old_sel}!={new_data,new_wrt,new_clk,new_sel})
  $fatal(1,"R93_NATIVE_PAIR_FAIL t=%f data=%h/%h wrt=%b/%b clk=%b/%b sel=%b/%b",$realtime,old_data,new_data,old_wrt,new_wrt,old_clk,new_clk,old_sel,new_sel);
 if((^{new_data,new_wrt,new_clk,new_sel})===1'bx)$fatal(1,"R93_UNKNOWN_VALID_OUTPUT");
 pair_checks=pair_checks+1;
end
always@(posedge new_wrt)if(clock_run && qualified>12 && new_rst===0 && old_rst===0)begin
 delta=$realtime-last_sys;
 if(delta>1.59 && delta<1.61)begin
  if(new_sel!==0 || new_data!==slot_a)$fatal(1,"R93_A_SAMPLE_FAIL t=%f data=%h expected=%h sel=%b",$realtime,new_data,slot_a,new_sel);
  a_checks=a_checks+1;seen_a[new_data]=1;
 end else if(delta>5.59 && delta<5.61)begin
  if(new_sel!==1 || new_data!==slot_b)$fatal(1,"R93_B_SAMPLE_FAIL t=%f data=%h expected=%h sel=%b",$realtime,new_data,slot_b,new_sel);
  b_checks=b_checks+1;seen_b[new_data]=1;
 end else $fatal(1,"R93_WRT_PHASE_FAIL %f",delta);
 checks=checks+1;
end
always@(posedge new_clk)if(clock_run && qualified>12 && new_rst===0 && old_rst===0)begin
 delta=$realtime-last_sys;
 if(!((delta>0.59&&delta<0.61)||(delta>4.59&&delta<4.61)))$fatal(1,"R93_SAMPLE_CLOCK_PHASE_FAIL %f",delta);
 clock_checks=clock_checks+1;
end
initial begin
 #1200;reset_i=0;#280000;reset_i=1;#19;reset_i=0;#7000;
 @(negedge clk125_p);clock_run=0;#2000;
 if(new_rst!==1)$fatal(1,"R93_CLOCK_LOSS_NOT_RESET");
 clock_run=1;#500;reset_i=1;#200;reset_i=0;#9000;
 for(integer i=0;i<16384;i=i+1)begin if(seen_a[i])all_values=all_values+1;if(seen_b[i])all_values=all_values+1;end
 if(checks<65000 || a_checks<32000 || b_checks<32000 || pair_checks<1000000 || all_values!=32768 || epochs<3)
  $fatal(1,"R93_COVERAGE_FAIL total=%d A=%d B=%d pairs=%d values=%d epochs=%d",checks,a_checks,b_checks,pair_checks,all_values,epochs);
 $display("R93_SERDES_NATIVE_PASS writes=%0d A=%0d B=%0d pairs=%0d values=%0d epochs=%0d clk=%0d",checks,a_checks,b_checks,pair_checks,all_values,epochs,clock_checks);$finish;
end
initial begin #310000;$fatal(1,"R93_TIMEOUT");end
endmodule
'''
(out/'tb.sv').write_text(tb,encoding='utf-8')
tool=Path('D:/Xilinx/Vivado/2020.1/bin')
commands=[('compile',[tool/'xvlog.bat','--sv',tool.parent/'data/verilog/src/glbl.v',ROOT/'gateware/tests/timing/r84/dac_serdes_probe.v',source,out/'tb.sv']),('elaborate',[tool/'xelab.bat','-L','unisims_ver','-L','secureip','tb_r84','glbl','--timescale','1ns/1ps','-s','r93_serdes_pair']),('simulate',[tool/'xsim.bat','r93_serdes_pair','-runall'])]
records=[]
for label,cmd in commands:
 cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
 text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:|Attribute Syntax Error)',text) and (label!='simulate' or 'R93_SERDES_NATIVE_PASS' in text)
 records.append({'stage':label,'command':cmd,'exit_code':r.returncode,'passed':bool(ok)});(out/'commands.json').write_text(json.dumps(records,indent=2),encoding='utf-8');assert ok,text[-5000:]
 print(label,'PASS',flush=True)
result={'passed':True,'scope':'Fresh VCO1000 LOW actual MMCM against VCO1000 OPTIMIZED FDRE reference; native02 clamps only internal stimulus counters/holds until both independently released resets, then launches identical SYS input stream. Original native01 startup-cohort FAIL preserved. Frequencies/phases preserved, not a whole core change. Independent SYS counter oracle, same A-old/B-new cohorts, full14bit values, complete stable waveform comparison, reset/explicit clock recovery. Not full Linien, PVT/SDF/PCB/pulse/CDC signoff. No bitstream.',
 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'source_file':str(source),'zero_added_integer_feedback_stages':'Candidate zero-stage schedule, only valid after actual native checks and future physical analysis; whole-core integration NOT RUN'}
(out/'results.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print('R93_SERDES_PROBE_SUITE_PASS',flush=True)
