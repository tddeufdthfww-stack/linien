`timescale 1ns/1ps
module tb_pid_output;
reg signed [83:0] x;wire signed [24:0] old_y,new_y;reg [24:0] expected;
integer fd,k,count=0;pid_output_pair dut(.*);
initial begin
fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
while(!$feof(fd))begin
k=$fscanf(fd,"%h %h\n",x,expected);if(k!=2)$fatal(1,"bad vector");#1;
if(old_y!==expected || new_y!==expected)$fatal(1,"PID_OUTPUT_FAIL W=25 case=%0d x=%h old=%h new=%h expected=%h",count,x,old_y,new_y,expected);
count=count+1;
end
$display("PID_OUTPUT_LIMIT_PASS width=25 sum_width=84 cases=%0d",count);$finish;
end
endmodule
