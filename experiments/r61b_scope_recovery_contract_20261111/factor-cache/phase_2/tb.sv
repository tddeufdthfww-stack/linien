`timescale 1ns/1ps
module tb_scope_parent;
reg adc_clk=0;always #4 adc_clk=~adc_clk;reg sys_clk=0;initial begin #(2);forever #5 sys_clk=~sys_clk;end
reg adc_rstn=0,sys_rstn=0;reg [13:0] a=0,b=0,aq=0,bq=0;reg ext=0,asg=0,auto_rearm=1;
reg [31:0] addr=0,wdata=0;reg [3:0] sel=15;reg we=0,ren=0;
wire [31:0] baseline_rdata,candidate_rdata;wire baseline_ack,candidate_ack,baseline_err,candidate_err;
wire [13:0] baseline_written,candidate_written,baseline_position,candidate_position;wire baseline_writing,candidate_writing;
red_pitaya_scope_reference baseline(.adc_a_i(a),.adc_b_i(b),.adc_a_q_i(aq),.adc_b_q_i(bq),.adc_clk_i(adc_clk),.adc_rstn_i(adc_rstn),.trig_ext_i(ext),.trig_asg_i(asg),.automatically_rearm_i(auto_rearm),.sys_clk_i(sys_clk),.sys_rstn_i(sys_rstn),.sys_addr_i(addr),.sys_wdata_i(wdata),.sys_sel_i(sel),.sys_wen_i(we),.sys_ren_i(ren),.sys_rdata_o(baseline_rdata),.sys_err_o(baseline_err),.sys_ack_o(baseline_ack),.written_data(baseline_written),.scope_position(baseline_position),.scope_writing_now(baseline_writing));
red_pitaya_scope candidate(.adc_a_i(a),.adc_b_i(b),.adc_a_q_i(aq),.adc_b_q_i(bq),.adc_clk_i(adc_clk),.adc_rstn_i(adc_rstn),.trig_ext_i(ext),.trig_asg_i(asg),.automatically_rearm_i(auto_rearm),.sys_clk_i(sys_clk),.sys_rstn_i(sys_rstn),.sys_addr_i(addr),.sys_wdata_i(wdata),.sys_sel_i(sel),.sys_wen_i(we),.sys_ren_i(ren),.sys_rdata_o(candidate_rdata),.sys_err_o(candidate_err),.sys_ack_o(candidate_ack),.written_data(candidate_written),.scope_position(candidate_position),.scope_writing_now(candidate_writing));

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
 if({baseline.adc_a_dat,baseline.adc_b_dat,baseline.adc_a_q_dat,baseline.adc_b_q_dat,baseline.adc_a_sum,baseline.adc_b_sum,baseline.adc_a_q_sum,baseline.adc_b_q_sum,baseline.adc_dec_cnt,baseline.adc_dv,baseline.adc_we,baseline.adc_wp,baseline.adc_wp_cur,baseline.adc_wp_trig,baseline.adc_dly_cnt,baseline.adc_dly_do,baseline.adc_trig,baseline.set_dec,baseline.set_avg_en,baseline.set_a_tresh,baseline.set_b_tresh,baseline.set_dly,baseline.set_a_hyst,baseline.set_b_hyst,baseline.set_a_filt_aa,baseline.set_a_filt_bb,baseline.set_a_filt_kk,baseline.set_a_filt_pp,baseline.set_b_filt_aa,baseline.set_b_filt_bb,baseline.set_b_filt_kk,baseline.set_b_filt_pp,baseline.set_trig_src,baseline.adc_arm_do,baseline.adc_rst_do,baseline.adc_trig_sw,baseline.addr,baseline.wdata,baseline.wen,baseline.ren}!=={candidate.adc_a_dat,candidate.adc_b_dat,candidate.adc_a_q_dat,candidate.adc_b_q_dat,candidate.adc_a_sum,candidate.adc_b_sum,candidate.adc_a_q_sum,candidate.adc_b_q_sum,candidate.adc_dec_cnt,candidate.adc_dv,candidate.adc_we,candidate.adc_wp,candidate.adc_wp_cur,candidate.adc_wp_trig,candidate.adc_dly_cnt,candidate.adc_dly_do,candidate.adc_trig,candidate.set_dec,candidate.set_avg_en,candidate.set_a_tresh,candidate.set_b_tresh,candidate.set_dly,candidate.set_a_hyst,candidate.set_b_hyst,candidate.set_a_filt_aa,candidate.set_a_filt_bb,candidate.set_a_filt_kk,candidate.set_a_filt_pp,candidate.set_b_filt_aa,candidate.set_b_filt_bb,candidate.set_b_filt_kk,candidate.set_b_filt_pp,candidate.set_trig_src,candidate.adc_arm_do,candidate.adc_rst_do,candidate.adc_trig_sw,candidate.addr,candidate.wdata,candidate.wen,candidate.ren} || {baseline_written,baseline_position,baseline_writing}!=={candidate_written,candidate_position,candidate_writing})$fatal(1,"SCOPE_PARENT_ADC_FAIL cycle=%0d old_dat=%h/%h new_dat=%h/%h",adc_cycles,baseline.adc_a_dat,baseline.adc_b_q_dat,candidate.adc_a_dat,candidate.adc_b_q_dat);
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
 @(negedge sys_clk);sys_rstn=0;adc_rstn=0;repeat(12)@(negedge adc_clk);adc_rstn=1;repeat(4)@(negedge sys_clk);sys_rstn=1;repeat(3)@(negedge sys_clk);if(candidate.i_bridge.src_ready!==2'b11 || candidate.i_bridge.dst_ready!==2'b11)$fatal(1,"R61_SCOPE_RECOVERY_NOT_READY");
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
