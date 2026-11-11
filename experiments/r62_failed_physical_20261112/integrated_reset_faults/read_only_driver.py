"""Independent fault integration checks against actual R62 source, read-only."""
from pathlib import Path
import hashlib,json,sys
root=Path('D:/RP_Dev/linien_trials/20261112-r62-adc-fall-dac-fast')
sys.path.insert(0,str(root/'tools'))
from check_scope_average import simulate
out=root/'gateware/build/r62_integrated_reset_faults01';out.mkdir(exist_ok=False)
original=(root/'gateware/tests/integration/tb_axi_bridge_integration.sv').read_text(encoding='utf-8')
prefix=original.split('  integer i;\n  initial begin')[0]
assert prefix.count('module tb_axi_bridge_integration;')==1
body=r'''
  task automatic error_read(input cancel_inflight,input[11:0] id);
    integer n;reg[31:0] snapshot;
    begin
      @(negedge sys_clk);araddr=32'h40000000;arid=id;arvalid=1;
      @(posedge sys_clk);if(!arready)$fatal(1,"AR_READY_FAIL");
      @(negedge sys_clk);arvalid=0;
      if(cancel_inflight)begin
        wait(bridge.sys_do!=bridge.sys_done);#0.1;dst_rstn=0;
      end
      n=0;
      while(rvalid!==1)begin
        @(negedge sys_clk);n=n+1;
        if(n>60)$fatal(1,"ERROR_READ_TIMEOUT");
      end
      if(rresp!==2'b10 || rid!==id || rlast!==1)$fatal(1,"ERROR_READ_RESPONSE_FAIL resp=%b id=%h",rresp,rid);
      snapshot=rdata;
      repeat(8)begin @(posedge sys_clk);#0.001;
        if(!rvalid || rresp!==2'b10 || rid!==id || rdata!==snapshot || rlast!==1)$fatal(1,"ERROR_READ_BACKPRESSURE_FAIL");
      end
      @(negedge sys_clk);rready=1;@(posedge sys_clk);#0.001;
      if(rvalid || rlast)$fatal(1,"ERROR_READ_NOT_RETIRED");
      @(negedge sys_clk);rready=0;
      $display("INTEGRATED_ERROR_READ_PASS cancel=%b cycles=%0d",cancel_inflight,n);
    end
  endtask
  task automatic cancelled_write;
    integer n;
    begin
      @(negedge sys_clk);awaddr=32'h40000000;awid=12'h751;wid=12'h751;awvalid=1;
      @(posedge sys_clk);if(!awready)$fatal(1,"AW_READY_FAIL");
      @(negedge sys_clk);awvalid=0;wdata=32'hbaadf00d;wvalid=1;
      @(posedge sys_clk);if(!wready)$fatal(1,"W_READY_FAIL");
      @(negedge sys_clk);wvalid=0;
      wait(bridge.sys_do!=bridge.sys_done);#0.1;dst_rstn=0;
      n=0;while(bvalid!==1)begin @(negedge sys_clk);n=n+1;if(n>60)$fatal(1,"ERROR_WRITE_TIMEOUT");end
      repeat(8)begin @(posedge sys_clk);#0.001;
        if(!bvalid || bresp!==2'b10 || bid!==12'h751)$fatal(1,"ERROR_WRITE_BACKPRESSURE_FAIL");
      end
      @(negedge sys_clk);bready=1;@(posedge sys_clk);#0.001;if(bvalid)$fatal(1,"ERROR_WRITE_NOT_RETIRED");
      @(negedge sys_clk);bready=0;
      $display("INTEGRATED_CANCELLED_WRITE_PASS cycles=%0d",n);
    end
  endtask
  initial begin
    repeat(6)@(negedge sys_clk);sys_rstn=1;
    // Destination remains in reset: source request must return SLVERR.
    repeat(5)@(negedge sys_clk);error_read(0,12'h701);
    dst_rstn=1;repeat(8)@(negedge sys_clk);
    write_word(32'h40000000,32'h11223344,12'h101);
    read_word(32'h40000000,32'h11223344,12'h201);
    // Reset destination after source acceptance, before request arrival.
    error_read(1,12'h702);
    dst_rstn=1;repeat(8)@(negedge sys_clk);
    if(writes_seen!==0 || reads_seen!==0)$fatal(1,"RESET_READ_REPLAY_FAIL");
    write_word(32'h40000000,32'h55667788,12'h102);
    read_word(32'h40000000,32'h55667788,12'h202);
    cancelled_write;
    dst_rstn=1;repeat(8)@(negedge sys_clk);
    if(writes_seen!==0 || reads_seen!==0)$fatal(1,"RESET_WRITE_REPLAY_FAIL");
    write_word(32'h40000000,32'h99aabbcc,12'h103);
    read_word(32'h40000000,32'h99aabbcc,12'h203);
    $display("R62_AXI_BRIDGE_RESET_FAULT_INTEGRATION_PASS");$finish;
  end
  initial begin #30000;$fatal(1,"integration timeout");end
endmodule
'''
results=[]
for phase in [0.001,1.25,3.999,7.999]:
    case=out/('phase_'+str(phase));case.mkdir()
    tb=prefix.replace('module tb_axi_bridge_integration;','module tb_r62_faults;').replace('#1.25;',f'#{phase};')+body
    (case/'tb.sv').write_text(tb,encoding='utf-8')
    simulate(case,'tb_r62_faults',[root/'gateware/verilog/axi_slave.v',root/'gateware/verilog/bus_clk_bridge.v',case/'tb.sv'],'R62_AXI_BRIDGE_RESET_FAULT_INTEGRATION_PASS')
    results.append({'phase_ns':phase,'passed':True})
    (out/'results.json').write_text(json.dumps({'passed':len(results)==4,'cases':results,'axi_sha256':hashlib.sha256((root/'gateware/verilog/axi_slave.v').read_bytes()).hexdigest(),'bridge_sha256':hashlib.sha256((root/'gateware/verilog/bus_clk_bridge.v').read_bytes()).hexdigest(),'scope':'Actual AXI+bridge error during destination reset, accepted read/write cancelled by destination reset, timeout/SLVERR, backpressure, no replay and normal recovery. No clock-stopped-without-reset or physical CDC proof.'},indent=2),encoding='utf-8')
print('R62_INTEGRATED_FAULT_SUITE_PASS',flush=True)
