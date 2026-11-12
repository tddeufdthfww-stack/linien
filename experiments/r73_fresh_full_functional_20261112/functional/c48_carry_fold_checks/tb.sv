`timescale 1ns/1ps
module tb_carry_fold;
reg signed [24:0] x,c;reg signed [49:0] z;wire [49:0] ref_y,new_y;reg [49:0] expected;reg known;
carry_fold_pair dut(.*);integer fd,k,count=0,known_count=0,unknown_count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%b %b %b %b %b\n",x,c,z,known,expected);if(k!=5)$fatal(1,"bad vector");#1;
  if(ref_y!==new_y)$fatal(1,"CARRY_FOLD_FROZEN_XZ_FAIL n=%0d x=%b c=%b z=%b ref=%b new=%b",count,x,c,z,ref_y,new_y);
  if(known && (ref_y!==expected || new_y!==expected))$fatal(1,"CARRY_FOLD_INTEGER_FAIL n=%0d",count);
  count=count+1;if(known)known_count=known_count+1;else unknown_count=unknown_count+1;
 end
 if(known_count!=320 || unknown_count!=4606)$fatal(1,"coverage");
 $display("CARRY_FOLD_FULL50_FROZEN_INTEGER_XZ_PASS known=%0d unknown=%0d",known_count,unknown_count);$finish;
end
endmodule
