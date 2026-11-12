`timescale 1ns/1ps
module tb_common_csr;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [35:0] dy=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [28:0] old_word,new_word;wire [24:0] cfg;wire [7:0] csr_read;
reg [28:0] expected;reg [24:0] expected_cfg;reg [7:0] expected_read;integer fd,k,count=0;
common_csr_pair dut(.*);
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h\n",sys_rst,dy,csr_adr,csr_we,csr_dat_w,expected,expected_cfg,expected_read);if(k!=8)$fatal(1,"bad vector");
  @(posedge sys_clk);#1;
  if(old_word!==expected || new_word!==expected || cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"COMMON_CSR_FAIL W=25 cycle=%0d old=%h new=%h expected=%h cfg=%h/%h read=%h/%h",count,old_word,new_word,expected,cfg,expected_cfg,csr_read,expected_read);
  count=count+1;
 end
 $display("COMMON_CSR_FULL_WORD_PASS width=25 cycles=%0d",count);$finish;
end
endmodule
