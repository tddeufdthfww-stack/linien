`timescale 1ns/1ps
module tb_crg_reset;
reg adc_p=0;always #4 adc_p=~adc_p;wire adc_n=~adc_p;
reg ps_clk=0,manual_sys=0,run_ps=1,run_sys=1;
always #4 if(run_sys)manual_sys=~manual_sys;
initial begin #1.25;forever begin #4;if(run_ps)ps_clk=~ps_clk;end end
reg ps_reset=1,lock_force=1;
wire sys_clk,sys_rst,sys_ps_rst;
actual_crg dut(.*);
initial begin
 force dut.sys_clk=manual_sys;
 force dut.pll_locked_probe=lock_force;
 #160;ps_reset=0;#32;
 if(sys_rst!==0 || sys_ps_rst!==0)$fatal(1,"INITIAL_RESET_NOT_RELEASED");
 @(negedge manual_sys);run_sys=0;#2;lock_force=0;#0.2;
 if(sys_rst!==1 || sys_ps_rst!==0)$fatal(1,"STOPPED_SYS_ASYNC_ASSERT_OR_DOMAIN_ISOLATION_FAIL");
 lock_force=1;#16;
 if(sys_rst!==1)$fatal(1,"STOPPED_SYS_EARLY_RELEASE");
 run_sys=1;@(posedge manual_sys);#0.2;if(sys_rst!==1)$fatal(1,"SYS_RELEASE_FIRST_EDGE_FAIL");
 @(posedge manual_sys);#0.2;if(sys_rst!==0)$fatal(1,"SYS_RELEASE_SECOND_EDGE_FAIL");
 $display("CRG_SYS_STOP_ASSERT_TWO_EDGE_RELEASE_PASS");
 @(negedge ps_clk);run_ps=0;#2;ps_reset=1;#0.2;
 if(sys_rst!==1 || sys_ps_rst!==1)$fatal(1,"PS_ASSERT_FAIL");
 ps_reset=0;#0.2;
 if(1)begin
  if(sys_ps_rst!==1)$fatal(1,"PS_RESET_RELEASED_WITHOUT_PS_CLOCK_EDGE");
  #16;if(sys_ps_rst!==1)$fatal(1,"STOPPED_PS_EARLY_RELEASE");
  run_ps=1;@(posedge ps_clk);#0.2;if(sys_ps_rst!==1)$fatal(1,"PS_RELEASE_FIRST_EDGE_FAIL");
  @(posedge ps_clk);#0.2;if(sys_ps_rst!==0)$fatal(1,"PS_RELEASE_SECOND_EDGE_FAIL");
  $display("CRG_PS_STOP_ASSERT_TWO_EDGE_RELEASE_PASS");
 end else begin
  if(sys_ps_rst!==0)$fatal(1,"EXPECTED_BASELINE_RAW_RESET_NOT_OBSERVED");
  $display("RAW_PS_RESET_RELEASE_WITHOUT_CLOCK_EDGE_DETECTED");
 end
 $display("CRG_RESET_LOGIC_DIAGNOSTIC_COMPLETE");$finish;
end
initial begin #2000;$fatal(1,"reset test timeout");end
endmodule
