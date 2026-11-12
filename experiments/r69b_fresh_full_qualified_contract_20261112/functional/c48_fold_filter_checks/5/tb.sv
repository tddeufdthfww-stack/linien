`timescale 1ns/1ps
module tb_iir_frame;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;reg signed [24:0] x=0;reg hold=0,clear=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [24:0] ref_y,cand_y;wire ref_error,cand_error;wire [7:0] read_value;wire [274:0] ref_coeff,cand_coeff;wire [301:0] cfg;
reg [7:0] expected_read;reg [24:0] expected_y;reg expected_error;reg [274:0] expected_coeff;reg [301:0] expected_cfg;
iir_frame_pair dut(.*);integer fd,k,cycles=0,rails=0,nonzero=0;integer xi;integer xseed=2026111145;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,x,hold,clear,csr_adr,csr_we,csr_dat_w,expected_read,expected_y,expected_error,expected_coeff,expected_cfg);
  if(k!=12)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error || ref_coeff!==expected_coeff || cand_coeff!==expected_coeff || cfg!==expected_cfg || read_value!==expected_read)
   $fatal(1,"IIR_FRAME_FAIL W=25 cycle=%0d y=%h/%h/%h rail=%b/%b/%b coeff=%h/%h/%h cfg=%h/%h read=%h/%h",cycles,ref_y,cand_y,expected_y,ref_error,cand_error,expected_error,ref_coeff,cand_coeff,expected_coeff,cfg,expected_cfg,read_value,expected_read);
  if(cand_error)rails=rails+1;if(cand_y!=0)nonzero=nonzero+1;cycles=cycles+1;
 end
 // Separate strict four-state phase, not evaluated by the finite integer oracle.
 for(xi=0;xi<3000;xi=xi+1)begin
  @(negedge sys_clk);sys_rst=(xi%97==0);x=$random(xseed);hold=(xi%13<4);clear=(xi%71==0);
  csr_adr=xi%48;csr_we=(xi%3==0);csr_dat_w=$random(xseed);
  case(xi%8)
   0:x[xi%25]=1'bx;
   1:x[xi%25]=1'bz;
   2:hold=1'bx;
   3:hold=1'bz;
   4:clear=1'bx;
   5:clear=1'bz;
   6:csr_dat_w[xi%8]=1'bx;
   7:csr_dat_w[xi%8]=1'bz;
  endcase
  @(posedge sys_clk);#1;
  if(ref_y!==cand_y || ref_error!==cand_error || ref_coeff!==cand_coeff)
   $fatal(1,"C48_FOLD_FILTER_XZ_FAIL order=5 cycle=%0d y=%h/%h error=%b/%b hold=%b clear=%b",xi,ref_y,cand_y,ref_error,cand_error,hold,clear);
 end
 if(cycles<17000 || rails<100 || nonzero<1000)$fatal(1,"coverage");
 $display("C48_FILTER_PASS order=5 width=25 cycles=%0d rails=%0d nonzero=%0d b0_latency=6 bN_latency=11 config_delay=2 unknown_cycles=3000",cycles,rails,nonzero);$finish;
end
initial begin #500000;$fatal(1,"timeout");end
endmodule
