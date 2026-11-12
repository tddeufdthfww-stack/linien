`timescale 1ns/1ps
module tb_prefetch;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg [0:0] start=0;
reg [0:0] advance=0;
reg [13:0] csr_adr=0;
reg [0:0] csr_we=0;
reg [7:0] csr_dat_w=0;
reg [4:0] probe_index=0;
wire [4:0] idx;
wire [1:0] choice;
wire [7:0] csr_read;
wire [13:0] old_probe;
wire [13:0] new_probe;
wire [13:0] old_mag;
wire [13:0] new_mag;
wire [14:0] old_neg;
wire [14:0] new_neg;
wire [0:0] old_pos;
wire [0:0] new_pos;
wire [13:0] old_wait;
wire [13:0] new_wait;
prefetch_pair dut(.*);
reg known;reg [4:0] ei;reg [13:0] em;reg [14:0] en;reg ep;reg [13:0] ew;reg [7:0] er;
integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,start,advance,csr_adr,csr_we,csr_dat_w,probe_index,known,ei,em,en,ep,ew,er);if(k!=14)$fatal(1,"vector malformed");
  @(posedge sys_clk);#1;
  if({old_mag,old_neg,old_pos,old_wait,old_probe}!=={new_mag,new_neg,new_pos,new_wait,new_probe} || choice>2)
   $fatal(1,"PREFETCH_DIFF width=14 cycle=%0d idx=%d choice=%d mag=%h/%h neg=%h/%h pos=%b/%b wait=%h/%h",count,idx,choice,old_mag,new_mag,old_neg,new_neg,old_pos,new_pos,old_wait,new_wait);
  if(known && ({idx,old_mag,old_neg,old_pos,old_wait,csr_read}!=={ei,em,en,ep,ew,er}))
   $fatal(1,"PREFETCH_ORACLE width=14 cycle=%0d idx=%d/%d mag=%h/%h neg=%h/%h read=%h/%h",count,idx,ei,old_mag,em,old_neg,en,csr_read,er);
  count=count+1;
 end
 $display("INSTRUCTION_PREFETCH_NATIVE_PASS width=14 cycles=%0d",count);$finish;
end
endmodule
