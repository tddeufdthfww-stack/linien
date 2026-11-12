`timescale 1ps/1ps
module tb_cdc_windows;
parameter integer SH=5000;
reg sclk=0,dclk=0;reg drun=1;always #(SH) sclk=~sclk;
integer phase=1001;
initial begin #(phase);forever #4000 if(drun)dclk=~dclk;end
reg sr=0,dr=0;reg[31:0] sa=0,sd=0;reg sw=0,srden=0;wire[31:0] rd,da,dd;wire ack,err,dw,dren;
reg[31:0] rv=0;reg ae=0,ar=0;integer pending=0,delay_count=0,seen=0,source_acks=0;
integer probe=0,normal_count=0;reg[31:0] ea=0,ed=0,expected=0;
time accepted=0,held=0,min_forward=100000000,min_return=100000000;
bus_clk_bridge dut(.sys_clk_i(sclk),.sys_rstn_i(sr),.sys_addr_i(sa),.sys_wdata_i(sd),.sys_sel_i(4'hf),.sys_wen_i(sw),.sys_ren_i(srden),.sys_rdata_o(rd),.sys_err_o(err),.sys_ack_o(ack),.clk_i(dclk),.rstn_i(dr),.addr_o(da),.wdata_o(dd),.wen_o(dw),.ren_o(dren),.rdata_i(rv),.err_i(ae),.ack_i(ar));
always @(posedge sclk) begin
 if(sr && dut.sys_do==dut.sys_done && (sw||srden))accepted=$time;
 if(sr && ack)begin
  source_acks=source_acks+1;
  if(!probe)begin
   if(rd!==expected || err!==0)$fatal(1,"NORMAL_SOURCE_SNAPSHOT_MISMATCH");
   if($time-held<min_return)min_return=$time-held;
  end
 end
end
always @(posedge dclk)begin
 if(!dr)begin pending<=0;delay_count<=0;ar<=0;rv<=0;ae<=0;end
 else begin
  ar<=0;
  if(dw||dren)begin
   seen=seen+1;
   if(!probe)begin
    if(da!==ea || dd!==ed)$fatal(1,"NORMAL_HELD_PAYLOAD_MISMATCH");
    if($time-accepted<min_forward)min_forward=$time-accepted;
   end
   rv<=da^dd^32'h583cb671;pending<=1;delay_count<=3;
  end
  if(pending)begin if(delay_count==0)begin ar<=1;pending<=0;end else delay_count<=delay_count-1;end
  if(ar)rv<=32'hdeadbeef;
  if(ar && dut.dst_do!=dut.dst_done)held=$time;
 end
end
task reset_both;
 begin @(negedge sclk);sr=0;dr=0;sw=0;srden=0;repeat(8)@(negedge sclk);sr=1;dr=1;repeat(10)@(negedge sclk);end
endtask
task issue(input[31:0] a,input[31:0] d,input integer tolerant,output integer ok);
 integer k;
 begin
  @(negedge sclk);ea=a;ed=d;expected=a^d^32'h583cb671;sa=a;sd=d;sw=1;
  @(negedge sclk);sw=0;sa=~a;sd=~d;k=0;
  while(ack!==1 && k<80)begin @(negedge sclk);k=k+1;end
  ok=(ack===1 && rd===expected && err===0);
  if(!ok && !tolerant)$fatal(1,"NORMAL_TRANSACTION_FAILED ack=%b rd=%h expected=%h",ack,rd,expected);
  repeat(5)@(negedge sclk);
 end
endtask
integer k,ok,source_reset_ok,destination_replay,before_seen,fault_wait;
initial begin
 reset_both();
 for(k=0;k<32;k=k+1)begin issue(32'h40000000+k*4,32'hf00de123^k,0,ok);normal_count=normal_count+1;end
 if(min_forward<16000 || min_return<4*SH)$fatal(1,"PROTOCOL_WINDOW_TOO_SHORT forward=%0t return=%0t",min_forward,min_return);
 $display("CDC_NORMAL_WINDOWS_PASS transactions=%0d forward_min_ps=%0t return_min_ps=%0t",normal_count,min_forward,min_return);
 probe=1;reset_both();
 @(negedge dclk);dr=0;drun=0;repeat(4)@(negedge sclk);before_seen=seen;
 @(negedge sclk);sa=32'h400000e0;sd=32'h11223344;sw=1;
 @(negedge sclk);sw=0;fault_wait=0;
 while(ack!==1 && fault_wait<6)begin @(negedge sclk);fault_wait=fault_wait+1;end
 if(ack!==1 || err!==1 || seen!=before_seen)$fatal(1,"RESET_CLOCK_STOP_REQUEST_NOT_REJECTED_WITH_ERROR");
 repeat(4)@(negedge sclk);drun=1;repeat(4)@(negedge dclk);dr=1;repeat(10)@(negedge sclk);
 issue(32'h400000e4,32'h44332211,0,ok);$display("CDC_CLOCK_STOP_RESET_FAULT_RESPONSE_PASS");
 reset_both();issue(32'h40000040,32'h12345678,0,ok);
 @(negedge sclk);sr=0;repeat(8)@(negedge sclk);sr=1;repeat(10)@(negedge sclk);
 issue(32'h40000044,32'h87654321,1,source_reset_ok);
 $display("SOURCE_ONLY_RESET_NEW_REQUEST_OK=%0d",source_reset_ok);
 reset_both();issue(32'h40000080,32'habcd1234,0,ok);before_seen=seen;
 @(negedge dclk);dr=0;repeat(8)@(negedge dclk);dr=1;repeat(24)@(negedge sclk);
 destination_replay=seen-before_seen;$display("DEST_ONLY_RESET_UNREQUESTED_REPLAY=%0d",destination_replay);
 reset_both();probe=0;issue(32'h400000c0,32'hcafebabe,0,ok);
 $display("CDC_COORDINATED_RESET_RECOVERY_PASS");
 $display("CDC_RESET_AND_WINDOW_DIAGNOSTIC_COMPLETE phase_ps=%0d source_half_ps=%0d",phase,SH);$finish;
end
initial begin #100000000;$fatal(1,"CDC_DIAGNOSTIC_TIMEOUT");end
endmodule
