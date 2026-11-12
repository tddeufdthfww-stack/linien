`timescale 1ns/1ps
module tb_c48;
reg signed [24:0] x,c;reg signed [49:0] z;wire [49:0] old_y,new_y;reg [49:0] expected;
c48_pair dut(.*);integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%h %h %h %h\n",x,c,z,expected);if(k!=4)$fatal(1,"bad vector");#1;
  if(old_y!==expected || new_y!==expected)$fatal(1,"C48_MAC_FAIL count=%0d x=%h c=%h z=%h old=%h new=%h expected=%h",count,x,c,z,old_y,new_y,expected);
  count=count+1;
 end
 if(count<70000)$fatal(1,"count");$display("C48_FULL50_MAC_PASS cases=%0d",count);$finish;
end
endmodule
