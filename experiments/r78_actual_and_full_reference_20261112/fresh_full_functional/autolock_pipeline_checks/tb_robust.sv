`timescale 1ns/1ps
module tb_robust;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_rst=1;reg signed [13:0] data=0;reg request=0,at_start=0,writing=0,sweep_up=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [93:0] ref_obs,cand_obs;wire [1393:0] ref_cfg,cand_cfg;wire [1:0] cand_prefetch_choice;wire [7:0] ref_read,cand_read;
wire [4:0] ref_idx,cand_idx;wire ref_watch,cand_watch,ref_turn,cand_turn;reg [7:0] expected_read;
reg [31:0] seen_index=0;
robust_pair dut(.*);integer fd,n,cycles=0,known=0,unknown=0,watching=0,advanced=0,locking=0;
initial begin
 fd=$fopen("robust_vectors.txt","r");if(!fd)$fatal(1,"missing vectors");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h\n",sys_rst,data,request,at_start,writing,sweep_up,csr_adr,csr_we,csr_dat_w,expected_read);
  if(n!=10)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if(ref_obs!==cand_obs || ref_cfg!==cand_cfg || ref_read!==cand_read)$fatal(1,"ROBUST_DIFF_FAIL %0d old=%h new=%h read=%h/%h",cycles,ref_obs,cand_obs,ref_read,cand_read);
  if(ref_read!==expected_read)$fatal(1,"CSR_ORACLE_FAIL %0d read=%h expected=%h",cycles,ref_read,expected_read);
  if(cand_prefetch_choice>2 || (^cand_prefetch_choice)===1'bx)$fatal(1,"PREFETCH_CHOICE_FAIL cycle=%0d idx=%0d choice=%h",cycles,cand_idx,cand_prefetch_choice);
  seen_index=seen_index|(32'd1<<cand_idx);
  if((^ref_obs)===1'bx)unknown=unknown+1;else known=known+1;
  if(ref_watch)watching=watching+1;if(ref_idx>0)advanced=advanced+1;if(ref_turn)locking=locking+1;
  cycles=cycles+1;
 end
 if(cycles<50000 || known<40000 || watching<1000 || advanced<1000 || locking<1000)$fatal(1,"coverage failed cycles=%0d known=%0d watch=%0d advanced=%0d lock=%0d",cycles,known,watching,advanced,locking);
 if(seen_index!==32'hffffffff)$fatal(1,"PREFETCH_INDEX_COVERAGE_FAIL mask=%h",seen_index);
 $display("PREFETCH_ALL_32_INDICES_PASS mask=%h",seen_index);
 $display("ROBUST_PIPELINED_CSR_FSM_PASS cycles=%0d known=%0d baseline_unknown=%0d watch=%0d advanced=%0d lock=%0d",cycles,known,unknown,watching,advanced,locking);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
