`timescale 1ns/1ps
module tb_latency;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_double_clk=1;always #2 sys_double_clk=~sys_double_clk;
reg dac_2p_clk=0;initial begin #1.5;forever #2 dac_2p_clk=~dac_2p_clk;end
reg sys_rst=1;reg [15:0] adc_word=16'h7ffc;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] ref_data,cand_data,ref_kp,cand_kp;wire ref_wrt,cand_wrt,ref_sel,cand_sel;
latency_pair dut(.*);
integer cycle=0,sample_cycle=0,ref_cycle=-1,cand_cycle=-1;
always @(posedge sys_clk)cycle=cycle+1;
reg armed=0;reg [13:0] target;real sample_time,ref_time=-1,cand_time=-1,ref_write=-1,cand_write=-1;
always @(ref_data)if(armed && ref_data===target && ref_time<0)begin ref_time=$realtime;ref_cycle=cycle;end
always @(cand_data)if(armed && cand_data===target && cand_time<0)begin cand_time=$realtime;cand_cycle=cycle;end
always @(posedge ref_wrt)if(armed && ref_data===target && ref_sel==0 && ref_write<0)ref_write=$realtime;
always @(posedge cand_wrt)if(armed && cand_data===target && cand_sel==0 && cand_write<0)cand_write=$realtime;
always @(posedge dut.dac_io_clk)if(armed)$display("R81_DEBUG_IO t=%0.3f sys=%b frame=%b seen=%b selB=%b inputword=%h",$realtime,sys_clk,dut.pair_analog_frame,dut.pair_analog_frame_seen,dut.pair_analog_select_b,dut.pair_analog_dac_word);
always @(posedge cand_wrt)if(armed)$display("R81_DEBUG_WRT t=%0.3f data=%h sel=%b",$realtime,cand_data,cand_sel);
task write_byte(input [13:0] adr,input [7:0] value);
 begin @(negedge sys_clk);csr_adr=adr;csr_dat_w=value;csr_we=1;
 @(negedge sys_clk);csr_we=0;end
endtask
task pulse(input [15:0] word_value,input [13:0] expected,input integer amplitude);
 begin
  armed=0;ref_time=-1;cand_time=-1;ref_write=-1;cand_write=-1;ref_cycle=-1;cand_cycle=-1;
  repeat(8)@(posedge sys_clk);
  @(negedge sys_clk);target=expected;sample_time=$realtime+4;sample_cycle=cycle+1;adc_word=word_value;armed=1;
  @(negedge sys_clk);adc_word=16'h7ffc;
  repeat(20)@(posedge sys_clk);#1;
  if(ref_time<0 || cand_time<0 || ref_write<0 || cand_write<0)$fatal(1,"missing pulse ref=%f cand=%f wrref=%f wrcand=%f nowdata=%h/%h target=%h",ref_time,cand_time,ref_write,cand_write,ref_data,cand_data,target);
  if(cand_cycle-ref_cycle!=0 || cand_time-ref_time< -0.001 || cand_time-ref_time>0.001)$fatal(1,"data latency delta failed");
  if(cand_cycle-sample_cycle!=9 || ref_cycle-sample_cycle!=9 || cand_time-sample_time<72.099 || cand_time-sample_time>72.101)$fatal(1,"absolute ADC-sample-to-DAC-data latency failed");
  if(cand_write-ref_write<0.249 || cand_write-ref_write>0.251)$fatal(1,"DAC WRT phase-only delta failed");
  $display("R81_BARE_DIGITAL_LATENCY amplitude=%0d ref_cycles=%0d cand_cycles=%0d ref_dq_ns=%0.3f cand_dq_ns=%0.3f ref_wrt_ns=%0.3f cand_wrt_ns=%0.3f delta_ns=%0.3f",amplitude,ref_cycle-sample_cycle,cand_cycle-sample_cycle,ref_time-sample_time,cand_time-sample_time,ref_write-sample_time,cand_write-sample_time,cand_time-ref_time);
  armed=0;
 end
endtask
initial begin
 repeat(20)@(posedge sys_clk);@(negedge sys_clk);sys_rst=0;
 write_byte(14'd4,8'd16);
 write_byte(14'd5,8'd0);
 repeat(300)@(posedge sys_clk);#1;
 if(ref_kp!==14'd4096 || cand_kp!==14'd4096)$fatal(1,"KP configuration failed");
 pulse(16'h7e10,14'h1f84,123);
 pulse(16'h81e8,14'h207a,-123);
 $display("R81_BARE_DIGITAL_LATENCY_PASS");$finish;
end
initial begin #10000;$fatal(1,"timeout");end
endmodule
