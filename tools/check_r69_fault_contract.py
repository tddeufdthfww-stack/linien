"""Actual AXI+bridge invalid-payload/timeout replay contract, no source edit."""
from pathlib import Path
import argparse,hashlib,json,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);p.add_argument('--out',type=Path,required=True);p.add_argument('--expect',choices=['legacy-gaps','fixed'],default='fixed');p.add_argument('--modes',default='0,1,2,3,4,5,6,7');a=p.parse_args()
root=a.root.resolve();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
prefix=(root/'gateware/tests/integration/tb_axi_bridge_integration.sv').read_text(encoding='utf-8').split('  integer i;\n  initial begin')[0]
assert prefix.count('module tb_axi_bridge_integration;')==1
prefix=prefix.replace('reg dst_clk = 1\'b0;', 'reg dst_clk = 1\'b0; reg run_dst=1; reg[2:0]arsize=3\'b010;')
prefix=prefix.replace('forever #4 dst_clk = ~dst_clk;', 'forever #4 if(run_dst)dst_clk = ~dst_clk;')
prefix=prefix.replace('.axi_arsize_i(3\'b010)', '.axi_arsize_i(arsize)')
# Fixed case follows actual Axi2Sys wiring; old baseline has no abort port.
new_abort='sys_abort_o' in (root/'gateware/verilog/axi_slave.v').read_text(encoding='utf-8')
if new_abort:
 prefix=prefix.replace('  wire sys_wen, sys_ren, sys_ack, sys_err;', '  wire sys_wen, sys_ren, sys_ack, sys_err; wire sys_abort; wire sys_bus_rstn=sys_rstn & ~sys_abort;')
 prefix=prefix.replace('.sys_ack_i(sys_ack)', '.sys_ack_i(sys_ack), .sys_abort_o(sys_abort)')
 prefix=prefix.replace('.sys_rstn_i(sys_rstn)', '.sys_rstn_i(sys_bus_rstn)')
body=r'''
  localparam integer MODE=MODE_VALUE;
  task automatic read_error(input[31:0]expected);
    integer n;reg[31:0]snapshot;
    begin
      @(negedge sys_clk);araddr=32'h40000000;arid=12'h692;arvalid=1;
      if(MODE==2)arsize=3'b001;
      @(posedge sys_clk);if(!arready)$fatal(1,"ARREADY_FAIL");
      @(negedge sys_clk);arvalid=0;n=0;
      while(rvalid!==1)begin @(negedge sys_clk);n=n+1;if(n>65)$fatal(1,"ERROR_READ_TIMEOUT");end
      if(rresp!==2'b10 || rid!==12'h692 || rlast!==1)$fatal(1,"ERROR_RESPONSE_FAIL");
      if(rdata!==expected)$fatal(1,"INVALID_PAYLOAD_NOT_SOURCE_ZERO mode=%0d value=%h expected=%h",MODE,rdata,expected);
      snapshot=rdata;
      repeat(8)begin @(posedge sys_clk);#0.001;if(!rvalid || rresp!==2'b10 || rid!==12'h692 || rdata!==snapshot || !rlast)$fatal(1,"ERROR_BACKPRESSURE_FAIL");end
      @(negedge sys_clk);rready=1;@(posedge sys_clk);#0.001;if(rvalid || rlast)$fatal(1,"R_NOT_RETIRED");
      @(negedge sys_clk);rready=0;arsize=3'b010;
    end
  endtask
  task automatic write_timeout;
    integer n;
    begin
      @(negedge sys_clk);awaddr=32'h40000004;awid=12'h693;wid=12'h693;awvalid=1;
      @(posedge sys_clk);if(!awready)$fatal(1,"AWREADY_FAIL");
      @(negedge sys_clk);awvalid=0;wdata=32'hbaadf00d;wvalid=1;
      @(posedge sys_clk);if(!wready)$fatal(1,"WREADY_FAIL");
      @(negedge sys_clk);wvalid=0;
      if(MODE==6 || MODE==7)begin
        wait(bridge.dst_sync[1] != bridge.dst_do);#0.1;run_dst=0;
      end
      n=0;
      while(!bvalid)begin @(negedge sys_clk);n=n+1;if(n>65)$fatal(1,"WRITE_TIMEOUT_MISSING");end
      repeat(8)begin @(posedge sys_clk);#0.001;if(!bvalid || bresp!==2'b10 || bid!==12'h693)$fatal(1,"WRITE_TIMEOUT_BACKPRESSURE_FAIL");end
      @(negedge sys_clk);bready=1;@(posedge sys_clk);#0.001;if(bvalid)$fatal(1,"B_NOT_RETIRED");
      @(negedge sys_clk);bready=0;
    end
  endtask
  integer before_writes;
  initial begin
    repeat(6)@(negedge sys_clk);sys_rstn=1;dst_rstn=1;repeat(8)@(negedge sys_clk);
    write_word(32'h40000000,32'h11223344,12'h101);
    read_word(32'h40000000,32'h11223344,12'h201);
    if(bridge.dst_rdata_hold!==32'h11223344)$fatal(1,"PRECONDITION_HELD_DATA_FAIL");
    if(MODE==0)begin
      @(negedge dst_clk);run_dst=0;#0.1;dst_rstn=0;
      read_error(32'h0);
    end else if(MODE==1)begin
      @(negedge dst_clk);run_dst=0;
      read_error(32'h0);
    end else if(MODE==2)begin
      read_error(32'h0);
    end else if(MODE==3 || MODE==6 || MODE==7)begin
      if(MODE==3)begin @(negedge dst_clk);run_dst=0;end
      before_writes=writes_seen;
      if(MODE==7)fork
        begin wait(axi.ack_cnt[5]===1);#0.1;run_dst=1;end
      join_none
      write_timeout();run_dst=1;
      repeat(24)@(negedge sys_clk);
      if(writes_seen!=before_writes)$fatal(1,"TIMED_OUT_WRITE_REPLAYED_AFTER_CLOCK_RESUME before=%0d now=%0d",before_writes,writes_seen);
      write_word(32'h40000004,32'h55667788,12'h104);
      read_word(32'h40000004,32'h55667788,12'h204);
    end else if(MODE==4)begin
      dst_err=1;read_error(32'h11223344);dst_err=0;
    end else if(MODE==5)begin
      @(negedge dst_clk);dst_rstn=0;repeat(8)@(negedge dst_clk);
      if(bridge.dst_rdata_hold!==32'h11223344)$fatal(1,"INVALID_EPOCH_CHANGED_HELD_RETURN_PAYLOAD");
    end
    $display("R69_FAULT_PAYLOAD_AND_TIMEOUT_CONTRACT_PASS mode=%0d",MODE);$finish;
  end
  initial begin #30000;$fatal(1,"fault contract timeout");end
endmodule
'''
results=[];tool=Path('D:/Xilinx/Vivado/2020.1/bin')
phases=[1.25] if a.expect=='legacy-gaps' else [.001,1.25,3.999,7.999]
expected_failure={0:'INVALID_PAYLOAD_NOT_SOURCE_ZERO',1:'INVALID_PAYLOAD_NOT_SOURCE_ZERO',2:'INVALID_PAYLOAD_NOT_SOURCE_ZERO',3:'TIMED_OUT_WRITE_REPLAYED_AFTER_CLOCK_RESUME',5:'INVALID_EPOCH_CHANGED_HELD_RETURN_PAYLOAD',6:'TIMED_OUT_WRITE_REPLAYED_AFTER_CLOCK_RESUME',7:'TIMED_OUT_WRITE_REPLAYED_AFTER_CLOCK_RESUME'}
for phase in phases:
 for mode in map(int,a.modes.split(',')):
  case=out/(f'phase_{phase}_mode_{mode}');case.mkdir()
  tb=prefix.replace('module tb_axi_bridge_integration;', 'module tb_fault_contract;').replace('#1.25;',f'#{phase};')+body.replace('MODE_VALUE',str(mode))
  (case/'tb.sv').write_text(tb,encoding='utf-8')
  commands=[('compile',[tool/'xvlog.bat','--sv',root/'gateware/verilog/axi_slave.v',root/'gateware/verilog/bus_clk_bridge.v',case/'tb.sv']),('elaborate',[tool/'xelab.bat','tb_fault_contract','--timescale','1ns/1ps','-s','fault_contract']),('simulate',[tool/'xsim.bat','fault_contract','-runall'])]
  for label,cmd in commands:
   cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=case,capture_output=True);(case/(label+'.stdout.log')).write_bytes(r.stdout);(case/(label+'.stderr.log')).write_bytes(r.stderr)
   text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');negative=label=='simulate' and a.expect=='legacy-gaps' and mode in expected_failure
   ok=r.returncode==0 and (('Fatal: '+expected_failure[mode]) in text and 'R69_FAULT_PAYLOAD_AND_TIMEOUT_CONTRACT_PASS' not in text if negative else not re.search('(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text) and (label!='simulate' or 'R69_FAULT_PAYLOAD_AND_TIMEOUT_CONTRACT_PASS' in text))
   (case/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed_expected_outcome':bool(ok),'expected_legacy_contract_failure':negative},indent=2),encoding='utf-8');assert ok,text[-4000:]
  results.append({'phase_ns':phase,'mode':mode,'outcome':'LEGACY_GAP_CONFIRMED' if mode in expected_failure and a.expect=='legacy-gaps' else 'PASS'});print(results[-1],flush=True)
(out/'results.json').write_text(json.dumps({'expected_outcomes_passed':True,'expectation':a.expect,'source_abort_wiring':new_abort,'cases':results,'source_sha256':{n:hashlib.sha256((root/n).read_bytes()).hexdigest() for n in ['gateware/verilog/axi_slave.v','gateware/verilog/bus_clk_bridge.v','gateware/lowlevel/pitaya_ps.py','gateware/tests/integration/tb_axi_bridge_integration.sv']},'scope':'Actual AXI+bridge functional fault contracts. Fixed test connects abort exactly as Axi2Sys must. Not physical metastability proof or rollback of a destination write already committed before timeout.'},indent=2),encoding='utf-8')
print('FAULT_CONTRACT_EXPECTED_OUTCOMES_COMPLETE',a.expect,flush=True)
