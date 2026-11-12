`timescale 1ns/1ps
module tb_parallel_tap;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] t0=0,t1=0,t2=0;reg signed [16:0] ca=0,cb=0;reg ce=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] ref_y,cand_y;wire ref_error,cand_error,ref_rail,cand_rail,invert_current;
wire [16:0] ref_pre,cand_pre,ref_lo,ref_hi,cand_lo,cand_hi;wire [1:0] tap_current;
wire [30:0] cfg;wire [7:0] csr_read;reg [30:0] expected_cfg;reg [7:0] expected_read;
reg [13:0] expected_y=0;reg expected_error=0;reg signed [63:0] value,lo,hi,total;
reg signed [16:0] trunc_value;reg [16:0] expected_pre;reg expected_rail;
integer fd,k,cycles=0,rails=0,clear_cycles=0,holds=0;reg [7:0] seen=0;
parallel_tap_pair dut(.*);
task oracle;
begin
 case(tap_current)0:total=$signed(t0);1:total=$signed(t1);default:total=$signed(t2);endcase
 total=total+$signed(ca)+$signed(cb);if(invert_current)total=-total;
 trunc_value=total;value=trunc_value;lo=$signed(ref_lo);hi=$signed(ref_hi);
 if(value>=hi)begin expected_pre=hi;expected_rail=1;end
 else if(value<=lo)begin expected_pre=lo;expected_rail=1;end
 else begin expected_pre=trunc_value;expected_rail=0;end
end endtask
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,t0,t1,t2,ca,cb,ce,csr_adr,csr_we,csr_dat_w,expected_read,expected_cfg);
  if(k!=12)$fatal(1,"bad vector");#1;oracle();
  if(ref_pre!==expected_pre || cand_pre!==expected_pre || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"PARALLEL_PRE_FAIL width=14 cycle=%0d",cycles);
  @(posedge sys_clk);
  if(sys_rst)begin expected_y=0;expected_error=0;end
  else if(ce)begin expected_y=expected_pre[13:0];expected_error=expected_rail;end
  #1;oracle();
  if(ref_pre!==expected_pre || cand_pre!==expected_pre || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"PARALLEL_POST_FAIL width=14 cycle=%0d",cycles);
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error || ref_lo!==cand_lo || ref_hi!==cand_hi)$fatal(1,"PARALLEL_FF_FAIL width=14 cycle=%0d",cycles);
  if(cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"PARALLEL_CSR_FAIL width=14 cycle=%0d",cycles);
  seen[{tap_current,invert_current}]=1;
  if(expected_rail)rails=rails+1;else clear_cycles=clear_cycles+1;if(!ce)holds=holds+1;cycles=cycles+1;
 end
 if(cycles<40000 || rails<1000 || clear_cycles<100 || holds<1000 || seen!==8'hff)$fatal(1,"coverage");
 $display("PARALLEL_TAP_FULL_PASS width=14 cycles=%0d rails=%0d clear=%0d holds=%0d tap_sign=8/8",cycles,rails,clear_cycles,holds);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
