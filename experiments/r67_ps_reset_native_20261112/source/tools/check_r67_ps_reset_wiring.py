"""Check actual elaborated RootModule reset wiring, independently of line text."""
from pathlib import Path
import argparse,hashlib,json,sys
p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args()
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Instance
from migen.fhdl.structure import _Assign,_Operator,_Slice,ResetSignal
from migen.genlib.resetsync import AsyncResetSynchronizer
from gateware.hw_platform import Platform
from gateware.linien_module import RootModule
out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
d=RootModule(Platform());axi=d.ps.axi.axi
links=[x for x in d.ps._fragment.comb if isinstance(x,_Assign) and x.l is axi.arstn]
assert len(links)==1
rhs=links[0].r
assert isinstance(rhs,_Operator) and rhs.op=='~' and len(rhs.operands)==1
assert isinstance(rhs.operands[0],ResetSignal) and rhs.operands[0].cd=='sys_ps'
instances=[x for x in d.ps.axi._fragment.specials if isinstance(x,Instance) and x.of=='axi_slave']
assert len(instances)==1
reset_pin=[x for x in instances[0].items if isinstance(x,Instance.Input) and x.name=='axi_rstn_i']
assert len(reset_pin)==1 and reset_pin[0].expr is axi.arstn
asrs=[x for x in d.crg._fragment.specials if isinstance(x,AsyncResetSynchronizer)]
ps=[x for x in asrs if x.cd is d.crg.cd_sys_ps];assert len(ps)==1
raw=ps[0].async_reset
assert isinstance(raw,_Operator) and raw.op=='~' and len(raw.operands)==1
raw=raw.operands[0]
assert isinstance(raw,_Slice) and raw.value is d.ps.frstn and raw.start==0 and raw.stop==1
clks=[x for x in d.crg._fragment.comb if isinstance(x,_Assign) and x.l is d.crg.cd_sys_ps.clk]
assert len(clks)==1 and isinstance(clks[0].r,_Slice)
assert clks[0].r.value is d.ps.fclk and clks[0].r.start==0 and clks[0].r.stop==1
assert len([x for x in asrs if x.cd is d.crg.cd_sys])==1
assert not any(isinstance(x,_Assign) and x.l is d.crg.cd_sys_ps.rst for x in d.crg._fragment.comb)
files=['gateware/lowlevel/crg.py','gateware/lowlevel/pitaya_ps.py','gateware/linien_module.py',str(Path(__file__).relative_to(ROOT)).replace(chr(92),'/')]
(out/'results.json').write_text(json.dumps({'passed':True,'actual_root_module_constructed':True,'ps_raw_reset_to_asr':True,'ps_asr_clock_is_fclk0':True,'axi_instance_reset_from_sys_ps_domain':True,'sys_asr_retained':True,'input_sha256':{n:hashlib.sha256((ROOT/n).read_bytes()).hexdigest() for n in files},'scope':'Migen object identity and instance pin wiring, not a postroute physical CDC or metastability proof'},indent=2),encoding='utf-8')
print('R67_ACTUAL_ROOT_RESET_WIRING_PASS',flush=True)
