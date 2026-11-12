`timescale 1ns/1ps
module tb_scope_average;
reg [13:0] raw_i;reg [47:0] sum_i;reg [31:0] dec_i;reg avg_i;wire [13:0] old_value,new_value;reg [13:0] expected;
scope_average_legacy old_dut(raw_i,sum_i,dec_i,avg_i,old_value);
scope_average_select new_dut(raw_i,sum_i,dec_i,avg_i,new_value);
integer fd,k,count=0,i;integer seed=2026111026;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%h %h %h %h %h\n",raw_i,sum_i,dec_i,avg_i,expected);if(k!=5)$fatal(1,"bad vector");#1;
  if(old_value!==expected || new_value!==expected)$fatal(1,"SCOPE_AVERAGE_FAIL cycle=%0d dec=%h avg=%b old=%h new=%h expected=%h",count,dec_i,avg_i,old_value,new_value,expected);
  count=count+1;
 end
 for(i=0;i<3000;i=i+1)begin
  raw_i=$random(seed);sum_i={$random(seed),$random(seed)};dec_i=$random(seed);avg_i=i[0];
  case(i%6)
   0:begin avg_i=1'bx;dec_i=0;end
   1:begin avg_i=1'bz;dec_i=1<<(i%32);end
   2:begin avg_i=1'bx;dec_i=3;end
   3:dec_i[i%32]=1'bx;
   4:begin avg_i=1'bx;dec_i[i%32]=1'bx;end
   5:begin raw_i[i%14]=1'bx;sum_i[i%48]=1'bx;end
  endcase
  #1;if(old_value!==new_value)$fatal(1,"SCOPE_AVERAGE_X_FAIL cycle=%0d dec=%h avg=%b old=%h new=%h",i,dec_i,avg_i,old_value,new_value);
 end
 $display("SCOPE_AVERAGE_SCALAR_PASS cases=%0d valid_factors=32 low16_exhaustive=65536 both_avg=1 unknown_cases=3000",count);$finish;
end
endmodule
