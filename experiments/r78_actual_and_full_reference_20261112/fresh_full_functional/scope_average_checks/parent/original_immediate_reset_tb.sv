`timescale 1ns/1ps
module tb_scope_parent;
reg adc_clk=0;always #4 adc_clk=~adc_clk;reg sys_clk=0;always #5 sys_clk=~sys_clk;
reg adc_rstn=0,sys_rstn=0;reg [13:0] a=0,b=0,aq=0,bq=0;reg ext=0,asg=0,auto_rearm=1;
reg [31:0] addr=0,wdata=0;reg [3:0] sel=15;reg we=0,ren=0;
wire [31:0] baseline_rdata,candidate_rdata;wire baseline_ack,candidate_ack,baseline_err,candidate_err;
wire [13:0] baseline_written,candidate_written,baseline_position,candidate_position;wire baseline_writing,candidate_writing;
red_pitaya_scope_reference baseline(.adc_a_i(a),.adc_b_i(b),.adc_a_q_i(aq),.adc_b_q_i(bq),.adc_clk_i(adc_clk),.adc_rstn_i(adc_rstn),.trig_ext_i(ext),.trig_asg_i(asg),.automatically_rearm_i(auto_rearm),.sys_clk_i(sys_clk),.sys_rstn_i(sys_rstn),.sys_addr_i(addr),.sys_wdata_i(wdata),.sys_sel_i(sel),.sys_wen_i(we),.sys_ren_i(ren),.sys_rdata_o(baseline_rdata),.sys_err_o(baseline_err),.sys_ack_o(baseline_ack),.written_data(baseline_written),.scope_position(baseline_position),.scope_writing_now(baseline_writing));
red_pitaya_scope candidate(.adc_a_i(a),.adc_b_i(b),.adc_a_q_i(aq),.adc_b_q_i(bq),.adc_clk_i(adc_clk),.adc_rstn_i(adc_rstn),.trig_ext_i(ext),.trig_asg_i(asg),.automatically_rearm_i(auto_rearm),.sys_clk_i(sys_clk),.sys_rstn_i(sys_rstn),.sys_addr_i(addr),.sys_wdata_i(wdata),.sys_sel_i(sel),.sys_wen_i(we),.sys_ren_i(ren),.sys_rdata_o(candidate_rdata),.sys_err_o(candidate_err),.sys_ack_o(candidate_ack),.written_data(candidate_written),.scope_position(candidate_position),.scope_writing_now(candidate_writing));

integer adc_cycles=0,writes=0,bus_transactions=0,known_memory_reads=0;integer seed=2026111026;
integer k,v,j;reg [31:0] factor,rd;
always @(negedge adc_clk)begin
 a=$random(seed);b=~a;aq=$random(seed);bq=aq^14'h1555;ext=(adc_cycles%127==9);asg=(adc_cycles%61==7);
end
always @(posedge adc_clk)begin
 #1;if({baseline.adc_a_dat,baseline.adc_b_dat,baseline.adc_a_q_dat,baseline.adc_b_q_dat,baseline.adc_a_sum,baseline.adc_b_sum,baseline.adc_a_q_sum,baseline.adc_b_q_sum,baseline.adc_dec_cnt,baseline.adc_dv,baseline.adc_we,baseline.adc_wp,baseline.adc_wp_cur,baseline.adc_wp_trig,baseline.adc_dly_cnt,baseline.adc_dly_do,baseline.adc_trig,baseline.set_dec,baseline.set_avg_en}!=={candidate.adc_a_dat,candidate.adc_b_dat,candidate.adc_a_q_dat,candidate.adc_b_q_dat,candidate.adc_a_sum,candidate.adc_b_sum,candidate.adc_a_q_sum,candidate.adc_b_q_sum,candidate.adc_dec_cnt,candidate.adc_dv,candidate.adc_we,candidate.adc_wp,candidate.adc_wp_cur,candidate.adc_wp_trig,candidate.adc_dly_cnt,candidate.adc_dly_do,candidate.adc_trig,candidate.set_dec,candidate.set_avg_en} || {baseline_written,baseline_position,baseline_writing}!=={candidate_written,candidate_position,candidate_writing})$fatal(1,"SCOPE_PARENT_ADC_FAIL cycle=%0d old_dat=%h/%h new_dat=%h/%h",adc_cycles,baseline.adc_a_dat,baseline.adc_b_q_dat,candidate.adc_a_dat,candidate.adc_b_q_dat);
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
