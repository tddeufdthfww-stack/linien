`timescale 1ns/1ps
module tb_fastchain_parallel;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dx=0,dy=0;reg [31:0] phase=0;
reg cei=0,ceq=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] offset_cfg;wire [24:0] ref_i,cand_i,ref_q,cand_q,ref_pre,cand_pre;wire ref_ei,cand_ei,ref_eq,cand_eq;wire [7:0] ref_read,cand_read;
reg [24:0] previous_i=0,previous_q=0,expected_i=0;integer i,changes=0,holds=0,negative_offsets=0;integer seed=2026111021;
fastchain_parallel_pair dut(.*);
initial begin
 for(i=0;i<30000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==4003 || i==14007 || i==14008);adc=$random(seed);offset=$random(seed);dx=$random(seed);dy=$random(seed);phase=$random(seed);
  cei=((i%5)==0 || i<2000);ceq=((i%11)==0 || i<3000);csr_adr=$unsigned($random(seed))%119;csr_we=((i%2)==0);csr_dat_w=$random(seed);
  @(posedge sys_clk);if(sys_rst)expected_i=0;else if(cei)expected_i=ref_pre;
  #1;
  if(ref_i!==cand_i || ref_q!==cand_q || ref_pre!==cand_pre || ref_ei!==cand_ei || ref_eq!==cand_eq || ref_read!==cand_read || cand_i!==expected_i || (^(cand_i^cand_q^cand_pre))===1'bx)$fatal(1,"FASTCHAIN_PARALLEL_FAIL cycle=%0d i=%h/%h q=%h/%h pre=%h/%h",i,ref_i,cand_i,ref_q,cand_q,ref_pre,cand_pre);
  if(!cei && !sys_rst && cand_i!==previous_i)$fatal(1,"CE I hold");if(!ceq && !sys_rst && cand_q!==previous_q)$fatal(1,"CE Q hold");
  if(offset_cfg[13])negative_offsets=negative_offsets+1;
  if(cand_i!==previous_i || cand_q!==previous_q)changes=changes+1;previous_i=cand_i;previous_q=cand_q;if(!cei && !ceq && !sys_rst)holds=holds+1;
 end
 if(changes<100 || holds<1000 || negative_offsets<1000)$fatal(1,"coverage");$display("FASTCHAIN_PARALLEL_PAIR_PASS cycles=30000 changes=%0d both_hold=%0d negative_offsets=%0d",changes,holds,negative_offsets);$finish;
end
endmodule
