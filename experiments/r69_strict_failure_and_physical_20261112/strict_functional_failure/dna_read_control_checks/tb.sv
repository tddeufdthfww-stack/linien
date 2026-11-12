`timescale 1ns/1ps
module tb_dna_pair;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;integer k;
wire [63:0] old0_status;
wire [0:0] old0_read;
wire [63:0] new0_status;
wire [0:0] new0_read;
wire [7:0] new0_count;
wire [63:0] old1_status;
wire [0:0] old1_read;
wire [63:0] new1_status;
wire [0:0] new1_read;
wire [7:0] new1_count;
wire [63:0] old2_status;
wire [0:0] old2_read;
wire [63:0] new2_status;
wire [0:0] new2_read;
wire [7:0] new2_count;
wire [63:0] old3_status;
wire [0:0] old3_read;
wire [63:0] new3_status;
wire [0:0] new3_read;
wire [7:0] new3_count;
dna_pair dut(.*);
initial begin
for(k=0;k<4096;k=k+1)begin
 @(negedge sys_clk);sys_rst=(k<4 || k%211==0 || k%211==1 || k%617==123);
 @(posedge sys_clk);#1;if(old0_status!==new0_status || old0_read!==new0_read || new0_read!==(new0_count<2))$fatal(1,"DNA_MISMATCH pattern=0 cycle=%0d old=%h new=%h count=%d",k,old0_status,new0_status,new0_count);
if(old1_status!==new1_status || old1_read!==new1_read || new1_read!==(new1_count<2))$fatal(1,"DNA_MISMATCH pattern=1 cycle=%0d old=%h new=%h count=%d",k,old1_status,new1_status,new1_count);
if(old2_status!==new2_status || old2_read!==new2_read || new2_read!==(new2_count<2))$fatal(1,"DNA_MISMATCH pattern=2 cycle=%0d old=%h new=%h count=%d",k,old2_status,new2_status,new2_count);
if(old3_status!==new3_status || old3_read!==new3_read || new3_read!==(new3_count<2))$fatal(1,"DNA_MISMATCH pattern=3 cycle=%0d old=%h new=%h count=%d",k,old3_status,new3_status,new3_count);
end
$display("R61_DNA_READ_CONTROL_NATIVE_PASS cycles=4096 patterns=4");$finish;
end
endmodule
