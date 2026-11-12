`timescale 1ns/1ps
module tb_registered_mixer;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_rst=1;reg signed [27:0] ax=0,bx=0;reg ce_a=0,ce_b=0;reg signed [13:0] offset=0;reg dual=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [36:0] ref_mix,cand_mix;wire [7:0] ref_read,cand_read;wire [17:0] ref_cfg,cand_cfg;wire [24:0] a_value,b_value;
registered_mixer_pair dut(.*);
integer fd,n,cycles=0,known=0,lo_a=128,hi_a=0,lo_b=128,hi_b=0,read_expected=0;
reg [17:0] cfg_expected;reg signed [63:0] va,vb,fa,fb,ofs,result;reg [36:0] expected;
reg [511:0] seen_a=0,seen_b=0;
task check_result;
begin
 va=$signed(a_value);vb=$signed(b_value);fa=lo_a+256*hi_a;fb=lo_b+256*hi_b;ofs=$signed(offset);
 result=(dual ? fa*va+fb*vb : (va<<<8))+(ofs<<<19);expected=result[36:0];
 if(ref_mix!==expected || cand_mix!==expected)begin
 $display("DSP debug opport=%h inport=%h opin=%h inin=%h A=%h B=%h R=%b/%b CE=%b/%b qa=%h qb=%h mult=%h X=%h Y=%h Z=%h op=%h in=%h alu=%h P=%h",dut.DSP48E1.OPMODE,dut.DSP48E1.INMODE,dut.DSP48E1.opmode_in,dut.DSP48E1.inmode_in,dut.DSP48E1.A,dut.DSP48E1.B,dut.DSP48E1.RSTA,dut.DSP48E1.RSTB,dut.DSP48E1.CEA2,dut.DSP48E1.CEB2,dut.DSP48E1.qa_o_mux,dut.DSP48E1.qb_o_mux,dut.DSP48E1.qmult_o_mux,dut.DSP48E1.qx_o_mux,dut.DSP48E1.qy_o_mux,dut.DSP48E1.qz_o_mux,dut.DSP48E1.qopmode_o_mux,dut.DSP48E1.qinmode_o_mux,dut.DSP48E1.alu_o,dut.DSP48E1.P);
 $fatal(1,"MIXER_FAIL cycle=%0d old=%h new=%h expected=%h F=%d/%d X=%d/%d",cycles,ref_mix,cand_mix,expected,fa,fb,va,vb);end
 if((ref_mix>>>8)!==(cand_mix>>>8))$fatal(1,"shift mismatch");
end endtask
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h\n",sys_rst,ax,bx,ce_a,ce_b,offset,dual,csr_adr,csr_we,csr_dat_w);
  if(n!=10)$fatal(1,"bad vector");#1;
  if(cycles>=24)check_result();
  case(csr_adr) 0:read_expected=hi_a;1:read_expected=lo_a;2:read_expected=hi_b;3:read_expected=lo_b;endcase
  @(posedge sys_clk);
  if(sys_rst)begin lo_a=128;hi_a=0;lo_b=128;hi_b=0;read_expected=0;end
  else if(csr_we)case(csr_adr)0:hi_a=csr_dat_w&1;1:lo_a=csr_dat_w;2:hi_b=csr_dat_w&1;3:lo_b=csr_dat_w;endcase
  #1;cfg_expected={hi_b[0],lo_b[7:0],hi_a[0],lo_a[7:0]};
  if(ref_cfg!==cfg_expected || cand_cfg!==cfg_expected || ref_read!==read_expected[7:0] || cand_read!==read_expected[7:0])$fatal(1,"CSR_FAIL cycle=%0d cfg=%h/%h/%h read=%h/%h/%h",cycles,ref_cfg,cand_cfg,cfg_expected,ref_read,cand_read,read_expected[7:0]);
  if(cycles>=24)begin check_result();known=known+1;seen_a[lo_a+hi_a*256]=1;seen_b[lo_b+hi_b*256]=1;end
  cycles=cycles+1;
 end
 if(known<30000 || seen_a!=={512{1'b1}} || seen_b!=={512{1'b1}})$fatal(1,"coverage cycles=%0d known=%0d",cycles,known);
 $display("REGISTERED_MIXER_FULL37_CSR_CE_PASS cycles=%0d known=%0d factors=512/512",cycles,known);$finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
