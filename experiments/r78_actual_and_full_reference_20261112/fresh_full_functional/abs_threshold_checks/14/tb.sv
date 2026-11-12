`timescale 1ns/1ps
module tb_abs_predicate;
reg signed [13:0] value;reg signed [12:0] threshold;wire old_result,new_result;reg expected;
abs_predicate_pair dut(.*);integer fd,k,count=0,i;integer seed=2026111024;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%h %h %h\n",value,threshold,expected);if(k!=3)$fatal(1,"bad vector");#1;
  if(old_result!==expected || new_result!==expected)$fatal(1,"ABS_PREDICATE_FAIL N=14 cycle=%0d value=%h threshold=%h old=%b new=%b expected=%b",count,value,threshold,old_result,new_result,expected);
  count=count+1;
 end
 for(i=0;i<2000;i=i+1)begin
  value=$random(seed);threshold=$random(seed);
  case(i%4)
   0:begin value=14'h2000;threshold[0]=1'bx;end
   1:value[i%14]=1'bx;
   2:threshold[i%13]=1'bx;
   3:begin value[i%14]=1'bx;threshold[i%13]=1'bx;end
  endcase
  #1;if(old_result!==new_result)$fatal(1,"ABS_PREDICATE_X_FAIL N=14 case=%0d value=%h threshold=%h old=%b new=%b",i,value,threshold,old_result,new_result);
 end
 $display("ABS_PREDICATE_FULL_PASS N=14 M=13 cases=%0d unknown_cases=2000",count);$finish;
end
endmodule
