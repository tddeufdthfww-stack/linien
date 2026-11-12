`timescale 1ns/1ps
module tb_iir_frame;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;reg signed [13:0] x=0;reg hold=0,clear=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] ref_y,cand_y;wire ref_error,cand_error;wire [7:0] read_value;wire [41:0] ref_coeff,cand_coeff;wire [57:0] cfg;
reg [7:0] expected_read;reg [13:0] expected_y;reg expected_error;reg [41:0] expected_coeff;reg [57:0] expected_cfg;
iir_frame_pair dut(.*);integer fd,k,cycles=0,rails=0,nonzero=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,x,hold,clear,csr_adr,csr_we,csr_dat_w,expected_read,expected_y,expected_error,expected_coeff,expected_cfg);
  if(k!=12)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error || ref_coeff!==expected_coeff || cand_coeff!==expected_coeff || cfg!==expected_cfg || read_value!==expected_read)
   $fatal(1,"IIR_FRAME_FAIL W=14 cycle=%0d y=%h/%h/%h rail=%b/%b/%b coeff=%h/%h/%h cfg=%h/%h read=%h/%h",cycles,ref_y,cand_y,expected_y,ref_error,cand_error,expected_error,ref_coeff,cand_coeff,expected_coeff,cfg,expected_cfg,read_value,expected_read);
  if(cand_error)rails=rails+1;if(cand_y!=0)nonzero=nonzero+1;cycles=cycles+1;
 end
 if(cycles<17000 || rails<100 || nonzero<1000)$fatal(1,"coverage");
 $display("C48_FILTER_PASS order=1 width=14 cycles=%0d rails=%0d nonzero=%0d b0_latency=2 bN_latency=3",cycles,rails,nonzero);$finish;
end
initial begin #500000;$fatal(1,"timeout");end
endmodule
