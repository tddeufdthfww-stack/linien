`timescale 1ns/1ps
module tb_feedback_frame;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [27:0] ax=0,bx=0;reg signed [13:0] adc=0;reg ce_a=0,ce_b=0,limit_ce=0,pid_ce=0,running=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;reg seed=0;reg [42:0] seed_value=0;
wire [36:0] ref_mix,cand_mix;wire [24:0] ref_input,cand_input,ref_y,cand_y,ref_a,ref_b;
wire ref_rail,cand_rail,ref_lce,ref_execute,cand_execute,ref_dual;wire [28:0] ref_lo,ref_hi,ref_lx;
wire [358:0] ref_fields,cand_fields;wire [42:0] ref_ir,cand_ir;
wire [151:0] config_value;wire [7:0] csr_read;wire [8:0] ref_fa,ref_fb;wire [13:0] ref_offset;
reg [7:0] expected_read;reg [151:0] expected_config;
reg [24:0] expected_y=0;reg expected_rail=0;reg signed [63:0] lx,lo,hi,aa,bb,fa,fb,offs,total;reg [36:0] expected_mix;
reg [511:0] seen_a=0,seen_b=0;integer fd,k,cycles=0,known=0,positive=0,negative=0,rails=0,holds=0;
feedback_frame_pair dut(.*);
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,ax,bx,adc,ce_a,ce_b,limit_ce,pid_ce,running,csr_adr,csr_we,csr_dat_w,seed,seed_value,expected_read,expected_config);
  if(k!=16)$fatal(1,"bad vector");#1;
  if(seed && cand_execute)$fatal(1,"seed overlaps valid");
  @(posedge sys_clk);
  if(sys_rst)begin expected_y=0;expected_rail=0;end
  else if(ref_lce)begin
   lx=$signed(ref_lx);lo=$signed(ref_lo);hi=$signed(ref_hi);
   if(lx>=hi)begin expected_y=hi[24:0];expected_rail=1;end
   else if(lx<=lo)begin expected_y=lo[24:0];expected_rail=1;end
   else begin expected_y=lx[24:0];expected_rail=0;end
  end
  #1;
  if(config_value!==expected_config || csr_read!==expected_read)$fatal(1,"FRAME_CSR_FAIL W=25 cycle=%0d",cycles);
  if(ref_y!==expected_y || cand_y!==expected_y || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"FRAME_LIMIT_FAIL W=25 cycle=%0d old=%h new=%h expected=%h",cycles,ref_y,cand_y,expected_y);
  if(ref_input!==cand_input || ref_fields!==cand_fields || ref_ir!==cand_ir || ref_execute!==cand_execute || (^ref_fields)===1'bx)$fatal(1,"FRAME_PID_FAIL W=25 cycle=%0d old=%h new=%h input=%h/%h",cycles,ref_fields,cand_fields,ref_input,cand_input);
  if(cycles>=24)begin
   aa=$signed(ref_a);bb=$signed(ref_b);fa=ref_fa;fb=ref_fb;offs=$signed(ref_offset);
   total=(ref_dual ? fa*aa+fb*bb : (aa<<<8))+(offs<<<19);expected_mix=total[36:0];
   if(ref_mix!==expected_mix || cand_mix!==expected_mix)$fatal(1,"FRAME_MIX_FAIL W=25 cycle=%0d old=%h new=%h expected=%h",cycles,ref_mix,cand_mix,expected_mix);
   known=known+1;seen_a[ref_fa]=1;seen_b[ref_fb]=1;
  end
  if(cand_ir==43'h3fffffc0000)positive=positive+1;
  if(cand_ir==43'h4000003ffff)negative=negative+1;
  if(cand_rail)rails=rails+1;if(!ref_lce)holds=holds+1;cycles=cycles+1;
 end
 if(known<40000 || positive<3 || negative<3 || rails<1000 || holds<1000 || seen_a!=={512{1'b1}} || seen_b!=={512{1'b1}})$fatal(1,"frame coverage W=25 known=%0d sat=%0d/%0d rails=%0d holds=%0d",known,positive,negative,rails,holds);
 $display("FEEDBACK_FRAME_2SYS_PASS width=25 cycles=%0d known=%0d positive_sat=%0d negative_sat=%0d rails=%0d limit_holds=%0d factors=512/512",cycles,known,positive,negative,rails,holds);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
