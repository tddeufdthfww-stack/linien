`timescale 1ns/1ps
module tb_r77_demod;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [24:0] x=0;reg [24:0] phase=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [24:0] ref_i,ref_q,cand_i,cand_q;wire [25:0] ref_phase,cand_phase;
wire [31:0] ref_delay,cand_delay;wire [3:0] ref_mult,cand_mult;wire [7:0] ref_read,cand_read;
r77_demod_pair dut(.*);integer fd,k,cycles=0,writes=0,resets=0,changes=0;
reg [15:0] seen=0;reg [49:0] previous=0;reg [63:0] expected_phase;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h\n",sys_rst,x,phase,csr_adr,csr_we,csr_dat_w);
  if(k!=6)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if({ref_i,ref_q,ref_phase,ref_delay,ref_mult,ref_read}!=={cand_i,cand_q,cand_phase,cand_delay,cand_mult,cand_read})
   $fatal(1,"R77_DEMOD_FAIL W=25 cycle=%0d IQ=%h/%h/%h/%h phase=%h/%h",cycles,ref_i,ref_q,cand_i,cand_q,ref_phase,cand_phase);
  expected_phase=phase;expected_phase=((expected_phase*cand_mult)+cand_delay)<<1;
  if(cand_phase!==expected_phase[25:0])$fatal(1,"phase arithmetic mismatch");
  if((^{cand_i,cand_q,cand_delay,cand_mult,cand_read})===1'bx)$fatal(1,"unknown outputs");
  seen[cand_mult]=1;if(csr_we)writes=writes+1;if(sys_rst)resets=resets+1;
  if({cand_i,cand_q}!==previous)changes=changes+1;previous={cand_i,cand_q};cycles=cycles+1;
 end
 if(seen!==16'hffff || changes<1000 || resets<24 || writes<7000)$fatal(1,"coverage");
 $display("R77_DEMOD_PASS width=25 cycles=%0d writes=%0d resets=%0d changes=%0d multipliers=16/16 latency=26",cycles,writes,resets,changes);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
