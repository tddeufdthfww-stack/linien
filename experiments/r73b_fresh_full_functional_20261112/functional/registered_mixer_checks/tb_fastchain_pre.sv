`timescale 1ns/1ps
module tb_fastchain_pre;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dy=0;reg [31:0] phase=0;
reg ce=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire signed [24:0] pre,y;reg signed [24:0] expected=0,previous=0;
fastchain_pre_wrapper dut(.*);integer i,changes=0,hold=0;integer seed=20261110;
initial begin
 for(i=0;i<10000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==4003 || i==7007);adc=$random(seed);offset=$random(seed);dy=$random(seed);phase=$random(seed);
  ce=((i%5)==0 || i<2000);csr_adr=$unsigned($random(seed))%103;csr_we=((i%17)==0);csr_dat_w=$random(seed);
  @(posedge sys_clk);if(sys_rst)expected=0;else if(ce)expected=pre;
  #1;if(y!==expected)$fatal(1,"FASTCHAIN_PRE_EXPORT_FAIL cycle=%0d pre=%h out=%h expected=%h",i,pre,y,expected);
  if(y!==previous)changes=changes+1;previous=y;if(!ce && !sys_rst)hold=hold+1;
 end
 if(changes<100 || hold<100)$fatal(1,"fastchain coverage changes=%0d hold=%0d",changes,hold);
 $display("FASTCHAIN_ORIGINAL_FF_PRE_EXPORT_PASS cycles=10000 changes=%0d hold=%0d",changes,hold);$finish;
end
endmodule
