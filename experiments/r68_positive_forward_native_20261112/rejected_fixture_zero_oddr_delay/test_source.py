"""Actual old/new CRG+PLL+analog UNISIM comparison, qualified after lock/reset."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomainsRenamer,Instance,Module,Record,Signal
from migen.fhdl import verilog
from migen.genlib.resetsync import AsyncResetSynchronizer
from migen.build.xilinx.common import XilinxAsyncResetSynchronizer
from gateware.lowlevel.crg import CRG
from gateware.lowlevel.analog import PitayaAnalog
p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
def load(label,path):
 s=importlib.util.spec_from_file_location(label,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
oldcrg=load('oldcrg',ROOT/'gateware/tests/timing/reference/r67_crg.py').CRG
oldanalog=load('oldanalog',ROOT/'gateware/tests/timing/reference/r61b_analog.py').PitayaAnalog
d=Module();pad=Record([('p',1),('n',1)]);pad.p.name_override='adc_p';pad.n.name_override='adc_n'
ps_clk=Signal(name_override='ps_clk');ps_reset=Signal(name_override='ps_reset')
ports={'adc_p':pad.p,'adc_n':pad.n,'ps_clk':ps_clk,'ps_reset':ps_reset,
       'adc_data_a':Signal(16),'adc_data_b':Signal(16),'dac_a':Signal((14,True)),'dac_b':Signal((14,True))}
for label,crgcls,analogcls in [('old',oldcrg,oldanalog),('new',CRG,PitayaAnalog)]:
 sub=Module();crg=crgcls(pad,ps_clk,ps_reset);sub.submodules.crg=crg
 adc=Record([('data_a',16),('data_b',16),('clk',2),('cdcs',1)])
 dac=Record([('data',14),('rst',1),('sel',1),('clk',1),('wrt',1)])
 analog=analogcls(adc,dac);sub.submodules.analog=analog
 sub.comb += [adc.data_a.eq(ports['adc_data_a']),adc.data_b.eq(ports['adc_data_b']),analog.dac_a.eq(ports['dac_a']),analog.dac_b.eq(ports['dac_b'])]
 packed=Signal(49);sub.comb += packed.eq(Cat(analog.adc_a,analog.adc_b,dac.data,adc.clk,adc.cdcs,dac.rst,dac.sel,dac.clk,dac.wrt))
 ports[label+'_outputs']=packed;ports[label+'_sys_clk']=crg.cd_sys.clk;ports[label+'_sys_rst']=crg.cd_sys.rst
 pll=next(x for x in crg._fragment.specials if isinstance(x,Instance) and x.of=='PLLE2_BASE')
 ports[label+'_locked']=next(x.expr for x in pll.items if isinstance(x,Instance.Output) and x.name=='LOCKED')
 if label=='old':sub=ClockDomainsRenamer({name:'old_'+name for name in ['sys','sys_ps','sys_double','sys_slow','dac_2p']})(sub)
 setattr(d.submodules,label,sub)
for name,sig in ports.items():sig.name_override=name
verilog.convert(d,ios=set(ports.values()),name='actual_pll_analog_pair',special_overrides={AsyncResetSynchronizer:XilinxAsyncResetSynchronizer}).write(str(out/'pair.v'))
tb=r'''`timescale 1ns/1ps
module tb_actual_pll_pair;
reg adc_p=0;always #4 adc_p=~adc_p;wire adc_n=~adc_p;
reg ps_clk=0;always #4 ps_clk=~ps_clk;reg ps_reset=1;
reg[15:0]adc_data_a=0,adc_data_b=0;reg[13:0]dac_a=0,dac_b=0;
wire[48:0]old_outputs,new_outputs;wire old_sys_clk,new_sys_clk,old_sys_rst,new_sys_rst,old_locked,new_locked;
actual_pll_analog_pair dut(.*);
integer checked=0,wr_edges=0,clk_edges=0,seed=2026111268,epochs=0;reg active=0;
real last_sys=-100,delta;
always@(posedge new_sys_clk)last_sys=$realtime;
always@(negedge adc_p)begin adc_data_a=$random(seed);adc_data_b=$random(seed);dac_a=$random(seed);dac_b=$random(seed);end
always #0.125 begin
 if(old_locked===1 && new_locked===1 && old_sys_rst===0 && new_sys_rst===0)begin
  if(!active)begin active=1;epochs=epochs+1;end
  if(old_outputs!==new_outputs || old_sys_clk!==new_sys_clk)$fatal(1,"ACTUAL_PLL_ANALOG_MISMATCH t=%0t old=%h new=%h",$time,old_outputs,new_outputs);
  checked=checked+1;
 end else active=0;
end
always@(posedge new_outputs[48])if(active)begin
 delta=$realtime-last_sys;
 if(!((delta>1.998 && delta<2.002)||(delta>5.998 && delta<6.002)))$fatal(1,"ACTUAL_PLL_WRT_PHASE_FAIL delta=%0.3f",delta);
 wr_edges=wr_edges+1;
end
always@(posedge new_outputs[47])if(active)begin
 delta=$realtime-last_sys;
 if(!((delta>1.498 && delta<1.502)||(delta>5.498 && delta<5.502)))$fatal(1,"ACTUAL_PLL_CLK_PHASE_FAIL delta=%0.3f",delta);
 clk_edges=clk_edges+1;
end
initial begin
 #1200;ps_reset=0;#5000;ps_reset=1;#17;ps_reset=0;#6000;
 if(checked<50000 || wr_edges<1000 || clk_edges<1000 || epochs!=2)$fatal(1,"ACTUAL_PLL_COVERAGE_FAIL %0d/%0d/%0d epochs=%0d",checked,wr_edges,clk_edges,epochs);
 $display("R68_ACTUAL_PLL_ANALOG_PAIR_PASS samples=%0d wr_edges=%0d clk_edges=%0d epochs=%0d",checked,wr_edges,clk_edges,epochs);$finish;
end
initial begin #15000;$fatal(1,"actual PLL timeout");end
endmodule
'''
(out/'tb.sv').write_text(tb,encoding='utf-8')
tool=Path('D:/Xilinx/Vivado/2020.1/bin')
commands=[('compile',[tool/'xvlog.bat','--sv',tool.parent/'data/verilog/src/glbl.v',out/'pair.v',out/'tb.sv']),('elaborate',[tool/'xelab.bat','-L','unisims_ver','tb_actual_pll_pair','glbl','--timescale','1ns/1ps','-s','actual_pll_pair']),('simulate',[tool/'xsim.bat','actual_pll_pair','-runall'])]
for label,cmd in commands:
 cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
 text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and not re.search('(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text) and (label!='simulate' or 'R68_ACTUAL_PLL_ANALOG_PAIR_PASS' in text)
 (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');assert ok,text[-5000:]
 print(label,'PASS',flush=True)
(out/'results.json').write_text(json.dumps({'passed':True,'scope':'Actual Migen CRGs including two actual PLL UNISIMs and old/new analog. Compares all49 output bits and SYSclock in two stable locked/reset-released epochs; nominal WRT2ns/CLK1.5ns verified. Unlocked startup outputs are explicitly unqualified. Does not prove analog PVT, jitter, metastability or PCB skew.','input_sha256':{name:hashlib.sha256((ROOT/name).read_bytes()).hexdigest() for name in ['gateware/lowlevel/crg.py','gateware/lowlevel/analog.py','gateware/tests/timing/reference/r67_crg.py','gateware/tests/timing/reference/r61b_analog.py','tools/check_r68_actual_pll.py']}},indent=2),encoding='utf-8')
print('R68_ACTUAL_PLL_SUITE_PASS',flush=True)
