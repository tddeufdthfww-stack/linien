`timescale 1ns/1ps
module tb_c48;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [24:0] x=0,c=0;reg signed [49:0] z=0;wire [49:0] old_y,new_y;reg [49:0] expected;
c48_pair dut(.*);integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 repeat(24)@(posedge sys_clk);
 while(!$feof(fd))begin
  @(negedge sys_clk);sys_rst=(count%9973==1);
  k=$fscanf(fd,"%h %h %h %h\n",x,c,z,expected);if(k!=4)$fatal(1,"bad vector");if(sys_rst)expected=0;@(posedge sys_clk);#1;
  if(old_y!==expected || new_y!==expected)begin
   $display("C48_DIAGNOSTIC rst=%b low=%h highq=%h correction=%h correctionq=%h lowq=%h cascade=%h",sys_rst,dut.pair_low,dut.pair_high_q,dut.pair_correction,dut.pair_correction_q,dut.pair_low_q,dut.pair_cascade);
   $fatal(1,"C48_MAC_FAIL count=%0d x=%h c=%h z=%h old=%h new=%h expected=%h",count,x,c,z,old_y,new_y,expected);
  end
  count=count+1;
 end
 if(count<70000)$fatal(1,"count");$display("C48_REGISTERED_FULL50_MAC_PASS cases=%0d",count);$finish;
end
endmodule
