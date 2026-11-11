"""Actual CRG lowering; forced lock/clock only tests reset logic, not PLL physics."""
from pathlib import Path
import argparse,hashlib,json,os,re,subprocess,sys
p=argparse.ArgumentParser();p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);p.add_argument('--out',type=Path,required=True);p.add_argument('--expect-ps-mode',choices=['raw','sync'],default='sync');a=p.parse_args()
root=a.root.resolve();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
sys.dont_write_bytecode=True;sys.path[:0]=[str(root),str(root/'linien-common')]
from migen import Instance,Record,Signal
from migen.fhdl import verilog
from migen.genlib.resetsync import AsyncResetSynchronizer
from migen.build.xilinx.common import XilinxAsyncResetSynchronizer
from gateware.lowlevel.crg import CRG
adc=Record([('p',1),('n',1)]);psclk=Signal(name_override='ps_clk');reset=Signal(name_override='ps_reset')
d=CRG(adc,psclk,reset)
pll=next(x for x in d._fragment.specials if isinstance(x,Instance) and x.of=='PLLE2_BASE')
locked=next(x.expr for x in pll.items if isinstance(x,Instance.Output) and x.name=='LOCKED')
locked.name_override='pll_locked_probe';adc.p.name_override='adc_p';adc.n.name_override='adc_n'
d.cd_sys.clk.name_override='sys_clk';d.cd_sys.rst.name_override='sys_rst';d.cd_sys_ps.rst.name_override='sys_ps_rst'
generated=verilog.convert(d,ios={adc.p,adc.n,psclk,reset,d.cd_sys.clk,d.cd_sys.rst,d.cd_sys_ps.rst},
                         name='actual_crg',special_overrides={AsyncResetSynchronizer:XilinxAsyncResetSynchronizer})
generated.write(str(out/'crg.v'))
tb=r'''`timescale 1ns/1ps
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
 if(EXPECT_SYNC)begin
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
'''.replace('EXPECT_SYNC','1' if a.expect_ps_mode=='sync' else '0')
(out/'tb.sv').write_text(tb,encoding='utf-8')
tool=Path('D:/Xilinx/Vivado/2020.1/bin')
commands=[('compile',[tool/'xvlog.bat','--sv',tool.parent/'data/verilog/src/glbl.v',out/'crg.v',out/'tb.sv']),
          ('elaborate',[tool/'xelab.bat','-L','unisims_ver','tb_crg_reset','glbl','--timescale','1ns/1ps','-s','crg_reset']),
          ('simulate',[tool/'xsim.bat','crg_reset','-runall'])]
for label,cmd in commands:
 cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=out,capture_output=True)
 (out/(label+'.stdout.log')).write_bytes(res.stdout);(out/(label+'.stderr.log')).write_bytes(res.stderr)
 text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and not re.search('(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text) and (label!='simulate' or 'CRG_RESET_LOGIC_DIAGNOSTIC_COMPLETE' in text)
 (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
 assert ok,text[-4500:]
 print(label,'PASS',flush=True)
(out/'results.json').write_text(json.dumps({'passed':True,'root':str(root),'expected_ps_mode':a.expect_ps_mode,
 'ps_reset_safety_status':'GAP_CONFIRMED_RAW_ASYNC_RELEASE' if a.expect_ps_mode=='raw' else 'TWO_EDGE_SYNCHRONOUS_RELEASE_LOGIC_VERIFIED',
 'crg_sha256':hashlib.sha256((root/'gateware/lowlevel/crg.py').read_bytes()).hexdigest(),
 'scope':'Actual CRG + installed Xilinx ASR lowering and UNISIM, with forced sys clock and LOCKED for reset-logic checks. Not actual PLL loss detection, analog metastability, PVT or board proof.'},indent=2),encoding='utf-8')
print('CRG_RESET_DIAGNOSTIC_FINISHED',a.expect_ps_mode,flush=True)
