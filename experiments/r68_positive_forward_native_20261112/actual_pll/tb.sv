`timescale 1ns/1ps
module tb_actual_pll_pair;
reg adc_p=0;always #4 adc_p=~adc_p;wire adc_n=~adc_p;
reg ps_clk=0;always #4 ps_clk=~ps_clk;reg ps_reset=1;
reg[15:0]adc_data_a=0,adc_data_b=0;reg[13:0]dac_a=0,dac_b=0;
wire[48:0]old_outputs,new_outputs;wire old_sys_clk,new_sys_clk,old_sys_rst,new_sys_rst,old_locked,new_locked,new_wrt_source,new_clk_source;
actual_pll_analog_pair dut(.*);
integer checked=0,wr_edges=0,clk_edges=0,seed=2026111268,epochs=0;reg active=0;
real last_sys=-100,delta;
always@(posedge new_sys_clk)last_sys=$realtime;
always@(negedge adc_p)begin adc_data_a=$random(seed);adc_data_b=$random(seed);dac_a=$random(seed);dac_b=$random(seed);end
always #0.125 begin
 if(old_locked===1 && new_locked===1 && old_sys_rst===0 && new_sys_rst===0)begin
  if(!active)begin active=1;epochs=epochs+1;end
  if(old_outputs!==new_outputs || old_sys_clk!==new_sys_clk)$fatal(1,"ACTUAL_PLL_ANALOG_MISMATCH t=%0t old=%h new=%h",$time,old_outputs,new_outputs);
  checked=checked+1;
 end else active=0;
end
always@(posedge new_wrt_source)if(active)begin
 delta=$realtime-last_sys;
 if(!((delta>1.998 && delta<2.002)||(delta>5.998 && delta<6.002)))$fatal(1,"ACTUAL_PLL_WRT_PHASE_FAIL delta=%0.3f",delta);
 wr_edges=wr_edges+1;
end
always@(posedge new_clk_source)if(active)begin
 delta=$realtime-last_sys;
 if(!((delta>1.498 && delta<1.502)||(delta>5.498 && delta<5.502)))$fatal(1,"ACTUAL_PLL_CLK_PHASE_FAIL delta=%0.3f",delta);
 clk_edges=clk_edges+1;
end
initial begin
 #1200;ps_reset=0;#5000;ps_reset=1;#17;ps_reset=0;#6000;
 if(checked<50000 || wr_edges<1000 || clk_edges<1000 || epochs!=2)$fatal(1,"ACTUAL_PLL_COVERAGE_FAIL %0d/%0d/%0d epochs=%0d",checked,wr_edges,clk_edges,epochs);
 $display("R68_ACTUAL_PLL_ANALOG_PAIR_PASS samples=%0d wr_edges=%0d clk_edges=%0d epochs=%0d",checked,wr_edges,clk_edges,epochs);$finish;
end
initial begin #15000;$fatal(1,"actual PLL timeout");end
endmodule
