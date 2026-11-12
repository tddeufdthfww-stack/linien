`timescale 1ns/1ps
module tb_slow_pipeline;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] x=0,sweep=0,offset=0;reg running=0,ce=0,use_divider=0;reg [4:0] divider=0;reg [1:0] sweep_channel=0,slow_channel=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;reg seed_enable=0;reg [31:0] seed_value=0;
wire [237:0] ref_fields,cand_fields;wire [53:0] ref_limit,cand_limit;wire [16:0] ref_analog,cand_analog;
wire [13:0] ref_contrib0,cand_contrib0,ref_contrib1,cand_contrib1;wire [7:0] ref_read;wire [84:0] csr_config;wire accept_ce,execute_ce;
reg [7:0] expected_read;reg [84:0] expected_cfg;reg ce1=0,ce2=0;integer events[0:31];
slow_pipeline_pair dut(.*);integer fd,n,cycles=0,i,commits=0,positive=0,negative=0;
initial begin
 for(i=0;i<32;i=i+1)events[i]=0;
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",sys_rst,x,running,ce,use_divider,divider,sweep,offset,sweep_channel,slow_channel,csr_adr,csr_we,csr_dat_w,seed_enable,seed_value,expected_read,expected_cfg);
  if(n!=17)$fatal(1,"bad vector");#1;
  if(seed_enable && execute_ce)$fatal(1,"seed overlaps pending commit");
  if(use_divider && accept_ce)events[divider]=events[divider]+1;
  @(posedge sys_clk);
  if(sys_rst)begin ce1=0;ce2=0;end else begin ce2=ce1;ce1=accept_ce;end
  #1;
  if(ref_fields!==cand_fields || (^ref_fields)===1'bx)$fatal(1,"SLOW_PID_FAIL cycle=%0d old=%h new=%h",cycles,ref_fields,cand_fields);
  if(ref_limit!==cand_limit || ref_analog!==cand_analog || ref_contrib0!==cand_contrib0 || ref_contrib1!==cand_contrib1)$fatal(1,"SLOW_CONTEXT_FAIL cycle=%0d limit=%h/%h analog=%h/%h",cycles,ref_limit,cand_limit,ref_analog,cand_analog);
  if(csr_config!==expected_cfg || ref_read!==expected_read)$fatal(1,"SLOW_CSR_ORACLE_FAIL cycle=%0d cfg=%h/%h read=%h/%h",cycles,csr_config,expected_cfg,ref_read,expected_read);
  if(execute_ce!==ce2)$fatal(1,"TWO_SYS_TOKEN_FAIL %0d",cycles);
  if(execute_ce)commits=commits+1;
  if(cand_fields[135:104]==32'h7ffc0000)positive=positive+1;
  if(cand_fields[135:104]==32'h8003ffff)negative=negative+1;
  cycles=cycles+1;
 end
 for(i=0;i<32;i=i+1)if((i<16 || i==16 || i==31) && events[i]<2)$fatal(1,"divider coverage rate=%0d events=%0d",i,events[i]);
 if(positive<1 || negative<1)$fatal(1,"rail coverage pos=%0d neg=%0d",positive,negative);
 if(commits<2000)$fatal(1,"commit coverage");
 $display("SLOW_PIPELINE_CSR_CONTEXT_DIVIDER_PASS cycles=%0d commits=%0d divider_modes=32 positive_sat=%0d negative_sat=%0d",cycles,commits,positive,negative);$finish;
end
initial begin #20000000;$fatal(1,"timeout");end
endmodule
