`timescale 1ns/1ps
module tb_r82;
reg adc_p=0,clock_run=1;always #4 if(clock_run)adc_p=~adc_p;
wire adc_n=~adc_p;reg ps_clk=0;always #4 ps_clk=~ps_clk;reg ps_reset=1;
reg[15:0]adc_data_a=0,adc_data_b=0;reg[13:0]dac_a=0,dac_b=0;
wire sys_clk,sys_rst,new_locked,new_data_clock;
wire[13:0]old_data,new_data,old_adc_a,new_adc_a,old_adc_b,new_adc_b;
wire old_rst,new_rst,old_sel,new_sel,old_clk,new_clk,old_wrt,new_wrt;
regional_dac_pair dut(.*);
integer sample=0,checks=0,adc_checks=0,clk_checks=0,sel_checks=0,epochs=0,qualified=0,old_writes=0;
integer a_checks=0,b_checks=0,bits_seen=0,reset_checks=0;
reg[13:0]a_reg=0,slot_a=0,slot_b=0;
real last_sys=-1000,delta;
reg[16383:0]seen_a=0,seen_b=0;
function automatic[13:0]encode(input[13:0]v);encode=v^14'h1fff;endfunction
always@(negedge sys_clk)begin
 sample=sample+1;dac_a=sample[13:0];dac_b=~sample[13:0];
 adc_data_a={sample[13:0],sample[1:0]};adc_data_b=~adc_data_a;
end
always@(posedge sys_clk)begin
 last_sys=$realtime;
 slot_a<=a_reg;a_reg<=sys_rst?0:encode(dac_a);slot_b<=sys_rst?0:encode(dac_b);
 if(new_rst===0)qualified<=qualified+1;else qualified<=0;
 #0.01;
 if(old_adc_a!==new_adc_a || old_adc_b!==new_adc_b)$fatal(1,"R82_ADC_PAIR_MISMATCH");
 adc_checks=adc_checks+1;
 if(new_rst && (sys_rst || !new_locked))reset_checks=reset_checks+1;
end
always@(negedge new_rst)begin
 if(new_locked!==1 || sys_rst!==0)$fatal(1,"R82_RESET_RELEASE_WITHOUT_LOCK");
 // Vivado2020.1 FDPE.v has assign #100 Q=Q_out (1ps unit).
 delta=$realtime-last_sys;if(delta<0.099 || delta>0.101)$fatal(1,"R82_RESET_NOT_SYS_EDGE_PLUS_UNISIM_100PS %f",delta);
 epochs=epochs+1;
end
always@(posedge new_wrt)if(new_rst===0 && qualified>3)begin
 delta=$realtime-last_sys;
 if(delta>1.84 && delta<1.86)begin
  if(new_sel!==0 || new_data!==slot_a)$fatal(1,"R82_A_SLOT_FAIL t=%f phase=%f data=%h expected=%h sel=%b",$realtime,delta,new_data,slot_a,new_sel);
  a_checks=a_checks+1;seen_a[new_data]=1;
 end else if(delta>5.84 && delta<5.86)begin
  if(new_sel!==1 || new_data!==slot_b)$fatal(1,"R82_B_SLOT_FAIL t=%f phase=%f data=%h expected=%h sel=%b",$realtime,delta,new_data,slot_b,new_sel);
  b_checks=b_checks+1;seen_b[new_data]=1;
 end else $fatal(1,"R82_WRT_PHASE_FAIL %f",delta);
 checks=checks+1;
end
always@(posedge old_wrt)if(new_rst===0 && qualified>3)begin
 delta=$realtime-last_sys;
 // ODDR.v specify(C=>Q)=(100:100:100) in Vivado2020.1.
 if(delta>2.09 && delta<2.11)begin
  if(old_data!==slot_a || old_sel!==0)$fatal(1,"R82_FROZEN_A_ORACLE_FAIL");
 end else if(delta>6.09 && delta<6.11)begin
  if(old_data!==slot_b || old_sel!==1)$fatal(1,"R82_FROZEN_B_ORACLE_FAIL");
 end else $fatal(1,"R82_FROZEN_WRT_PHASE_FAIL %f",delta);
 old_writes=old_writes+1;
end
always@(posedge new_clk)if(new_rst===0 && qualified>3)begin
 delta=$realtime-last_sys;
 if(!((delta>0.59&&delta<0.61)||(delta>4.59&&delta<4.61)))$fatal(1,"R82_CLK_PHASE_FAIL %f",delta);
 clk_checks=clk_checks+1;
end
always@(new_sel)if(new_rst===0 && qualified>3)begin
 delta=$realtime-last_sys;
 if(!((delta>0.215&&delta<0.235)||(delta>4.215&&delta<4.235)))$fatal(1,"R82_SEL_PHASE_FAIL %f",delta);
 if(new_wrt!==0 || new_clk!==0)$fatal(1,"R82_SEL_LOW_WINDOW_FAIL");
 sel_checks=sel_checks+1;
end
always@(posedge new_data_clock)if(new_rst===0 && qualified>3 && checks<3)
 $display("R82_MEASURED_DATA_CLOCK_SYS_DELTA=%0.3f",$realtime-last_sys);
// Independently model the documented DAC port latches and divide-by-two
// update. Compare samples after both nominal CLK phases, not the moving edges.
reg[13:0]old_la=0,old_lb=0,new_la=0,new_lb=0,old_ya=0,old_yb=0,new_ya=0,new_yb=0;
reg old_div=0,new_div=0;integer output_checks=0;
always@(posedge old_wrt)if(old_sel)old_lb=old_data;else old_la=old_data;
always@(posedge new_wrt)if(new_sel)new_lb=new_data;else new_la=new_data;
always@(posedge old_clk or posedge old_rst)begin
 if(old_rst)old_div=0;
 else begin if(!old_div)begin old_ya=old_la;old_yb=old_lb;end old_div=~old_div;end
end
always@(posedge new_clk or posedge new_rst)begin
 if(new_rst)new_div=0;
 else begin if(!new_div)begin new_ya=new_la;new_yb=new_lb;end new_div=~new_div;end
end
always@(negedge sys_clk)if(new_rst===0 && qualified>5)begin
 #0.02;if(old_ya!==new_ya || old_yb!==new_yb)$fatal(1,"R82_DAC_LATCH_OUTPUT_WORD_FAIL %h/%h %h/%h",old_ya,new_ya,old_yb,new_yb);
 output_checks=output_checks+1;
end
initial begin
 #1200;ps_reset=0;#280000;ps_reset=1;#19;ps_reset=0;#7000;
 @(negedge adc_p);clock_run=0;#2000;
 if(new_rst!==1)$fatal(1,"R82_UNLOCK_RESET_ASSERT_FAIL");
 // Existing CRG/PLLE2 requires explicit PS reset after reference-clock loss.
 // Confirm safe hold on return, then exercise that documented recovery.
 clock_run=1;#500;
 if(new_rst!==1)$fatal(1,"R82_CLOCK_RETURN_RELEASED_BEFORE_PLL_RECOVERY_RESET");
 ps_reset=1;#200;ps_reset=0;#9000;
 for(integer j=0;j<16384;j=j+1)begin if(seen_a[j])bits_seen=bits_seen+1;if(seen_b[j])bits_seen=bits_seen+1;end
 if(checks<65000 || adc_checks<33000 || a_checks<32000 || b_checks<32000 || bits_seen!=32768 || epochs<3 || output_checks<32000 || reset_checks<10)
  $fatal(1,"R82_COVERAGE_FAIL check=%0d adc=%0d A=%0d B=%0d bits=%0d epochs=%0d outputs=%0d reset=%0d",checks,adc_checks,a_checks,b_checks,bits_seen,epochs,output_checks,reset_checks);
 $display("R82_REGIONAL_DAC_NATIVE_PASS writes=%0d frozen=%0d ADC=%0d CLK=%0d SEL=%0d all14values=%0d epochs=%0d output_pairs=%0d resetchecks=%0d",checks,old_writes,adc_checks,clk_checks,sel_checks,bits_seen,epochs,output_checks,reset_checks);$finish;
end
initial begin #310000;$fatal(1,"R82_TIMEOUT");end
endmodule
