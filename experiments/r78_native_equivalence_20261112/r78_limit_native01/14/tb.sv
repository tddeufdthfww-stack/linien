`timescale 1ns/1ps
module tb_r78_limit;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [9:0] dx=0,offset=0;reg signed [13:0] t0=0,t1=0,t2=0;
reg ce=1,inv=0;reg [1:0] sel=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] ref_y,cand_y;wire ref_error,cand_error,ref_rail,cand_rail;
wire [16:0] ref_pre,cand_pre,ref_lo,cand_lo,ref_hi,cand_hi,ref_neg_lo,cand_neg_lo,ref_neg_hi,cand_neg_hi;
wire [16:0] thr_lo,thr_hi,thr_neg_lo,thr_neg_hi;wire [13:0] ref_common,cand_common;
wire [7:0] ref_read,cand_read;wire [27:0] ref_cfg,cand_cfg;
r78_limit_pair dut(.*);
reg signed [63:0] com,lo,hi,tap,total,oracle,theta,desired,desired_tap;
reg rail;reg [13:0] expected_y=0;reg expected_error=0;
integer i,seed=780112+14,holds=0,writes=0,held_writes=0,reversed=0,equal_bounds=0,boundary=0,changes=0;
reg [13:0] previous=0;
task check_pre;
begin
 com=$signed(cand_common);com=com<<<4;lo=$signed(cand_lo);hi=$signed(cand_hi);
 case(sel)0:tap=$signed(t0);1:tap=$signed(t1);default:tap=$signed(t2);endcase
 total=tap+com;if(inv)total=-total;
 if(total>=hi)begin oracle=hi;rail=1;end else if(total<=lo)begin oracle=lo;rail=1;end else begin oracle=total;rail=0;end
 if(ref_pre!==oracle[16:0] || cand_pre!==oracle[16:0] || ref_rail!==rail || cand_rail!==rail)
  $fatal(1,"R78_PRE_ORACLE_FAIL W=14 cycle=%0d pre=%h/%h expected=%h lo=%d hi=%d c=%d t=%d inv=%b",i,ref_pre,cand_pre,oracle,lo,hi,com,tap,inv);
 theta=lo-com;if(thr_lo!==theta[16:0])$fatal(1,"threshold low mismatch");
 theta=hi-com;if(thr_hi!==theta[16:0])$fatal(1,"threshold high mismatch");
 theta=-hi-com;if(thr_neg_hi!==theta[16:0])$fatal(1,"negative high threshold mismatch");
 theta=-lo-com;if(thr_neg_lo!==theta[16:0])$fatal(1,"negative low threshold mismatch");
end endtask
initial begin
 for(i=0;i<36000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==9013 || i==9014 || i==17007);
  dx=(i<2000?0:$random(seed));offset=(i<2000?0:$random(seed));
  t0=$random(seed);t1=$random(seed);t2=$random(seed);ce=(i<2000 || i%11==0);sel=i%4;inv=(i/4)%2;
  csr_we=0;csr_adr=0;csr_dat_w=0;
  if(i>=2000)begin csr_adr=$unsigned($random(seed))%4;csr_we=(i%3==0);csr_dat_w=$random(seed);end
  case(i)
24: begin csr_adr=0;csr_we=1;csr_dat_w=8'h3f;end
25: begin csr_adr=1;csr_we=1;csr_dat_w=8'h9c;end
26: begin csr_adr=2;csr_we=1;csr_dat_w=8'h00;end
27: begin csr_adr=3;csr_we=1;csr_dat_w=8'h64;end
500: begin csr_adr=0;csr_we=1;csr_dat_w=8'h00;end
501: begin csr_adr=1;csr_we=1;csr_dat_w=8'h64;end
502: begin csr_adr=2;csr_we=1;csr_dat_w=8'h3f;end
503: begin csr_adr=3;csr_we=1;csr_dat_w=8'h9c;end
1000: begin csr_adr=0;csr_we=1;csr_dat_w=8'h00;end
1001: begin csr_adr=1;csr_we=1;csr_dat_w=8'h00;end
1002: begin csr_adr=2;csr_we=1;csr_dat_w=8'h00;end
1003: begin csr_adr=3;csr_we=1;csr_dat_w=8'h00;end
1500: begin csr_adr=0;csr_we=1;csr_dat_w=8'h20;end
1501: begin csr_adr=1;csr_we=1;csr_dat_w=8'h00;end
1502: begin csr_adr=2;csr_we=1;csr_dat_w=8'h1f;end
1503: begin csr_adr=3;csr_we=1;csr_dat_w=8'hff;end
  endcase
  if(i>=40 && i<2000)begin
   desired=(i%6<3 ? $signed(ref_lo):$signed(ref_hi));desired=desired+(i%3)-1;
   if(inv)desired=-desired;com=$signed(ref_common);com=com<<<4;desired_tap=desired-com;
   if(desired_tap>=-8192 && desired_tap<=8191)begin t0=desired_tap;t1=desired_tap;t2=desired_tap;boundary=boundary+1;end
  end
  #1;check_pre();
  if(sys_rst)begin expected_y=0;expected_error=0;end
  else if(ce)begin expected_y=oracle[13:0];expected_error=rail;end
  @(posedge sys_clk);#1;check_pre();
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error)
   $fatal(1,"R78_OUTPUT_CE_FAIL W=14 cycle=%0d y=%h/%h expected=%h",i,ref_y,cand_y,expected_y);
  if({ref_lo,ref_hi,ref_neg_lo,ref_neg_hi,ref_common,ref_read,ref_cfg}!=={cand_lo,cand_hi,cand_neg_lo,cand_neg_hi,cand_common,cand_read,cand_cfg})
   $fatal(1,"R78_CSR_STATE_FAIL cycle=%0d",i);
  if((^{cand_y,cand_pre,cand_read,cand_cfg})===1'bx)$fatal(1,"unknown outputs");
  if(!ce)holds=holds+1;if(csr_we)writes=writes+1;if(csr_we&&!ce)held_writes=held_writes+1;
  if(lo>hi)reversed=reversed+1;if(lo==hi)equal_bounds=equal_bounds+1;
  if(cand_y!==previous)changes=changes+1;previous=cand_y;
 end
 if(holds<10000 || held_writes<1000 || reversed<100 || equal_bounds<100 || boundary<1000 || changes<1000)$fatal(1,"coverage");
 $display("R78_EARLY_LIMIT_PASS width=14 cycles=%0d writes=%0d ce0_writes=%0d holds=%0d reversed=%0d equal=%0d boundary=%0d changes=%0d",i,writes,held_writes,holds,reversed,equal_bounds,boundary,changes);$finish;
end
initial begin #500000;$fatal(1,"timeout");end
endmodule
