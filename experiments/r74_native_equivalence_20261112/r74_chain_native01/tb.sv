`timescale 1ns/1ps
module tb_r74_chain;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dx=0,dy=0;
reg [31:0] phase=0;reg ce=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [87:0] reference_result,candidate_result;
r74_chain_pair dut(.*);integer i,seed=730112,known=0,writes=0,holds=0,changes=0;
reg [87:0] previous=0;
initial begin
 for(i=0;i<32000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==9001 || i==9002 || i==21017);
  adc=$random(seed);offset=$random(seed);dx=$random(seed);dy=$random(seed);phase=$random(seed);
  ce=((i%7)==0 || i<4000);csr_adr=(i<8000 ? (i/4)%119 : $unsigned($random(seed))%119);
  csr_we=(i>=24 && i%3!=0);csr_dat_w=(i<8000 ? i%256 : $random(seed));
  @(posedge sys_clk);#1;
  if(reference_result!==candidate_result)$fatal(1,"R74_FASTCHAIN_FAIL cycle=%0d ref=%h cand=%h",i,reference_result,candidate_result);
  if(i>=24 && (^candidate_result===1'bx))$fatal(1,"R74_FASTCHAIN_UNKNOWN cycle=%0d",i);
  if(i>=24)known=known+1;if(csr_we)writes=writes+1;if(!ce)holds=holds+1;
  if(candidate_result!==previous)changes=changes+1;previous=candidate_result;
 end
 if(known<31000 || writes<10000 || holds<10000 || changes<1000)$fatal(1,"coverage");
 $display("R74_WHOLE_FASTCHAIN_CSR_CE_PASS cycles=%0d known=%0d writes=%0d holds=%0d changes=%0d",i,known,writes,holds,changes);$finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
