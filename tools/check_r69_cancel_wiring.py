"""Actual RootModule source reset cancellation path, not only a bench wire."""
from pathlib import Path
import argparse,hashlib,json,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Instance
from migen.fhdl.structure import _Assign,_Operator
from gateware.hw_platform import Platform
from gateware.linien_module import RootModule
p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
d=RootModule(Platform());m=d.ps.axi
ins=[x for x in m._fragment.specials if isinstance(x,Instance) and x.of=='axi_slave'];assert len(ins)==1
ab=[x.expr for x in ins[0].items if isinstance(x,Instance.Output) and x.name=='sys_abort_o'];assert len(ab)==1
links=[x for x in m._fragment.comb if isinstance(x,_Assign) and x.l is m.sys.rstn];assert len(links)==1
r=links[0].r;assert isinstance(r,_Operator) and r.op=='&' and len(r.operands)==2
assert r.operands[0] is m.axi.arstn
inv=r.operands[1];assert isinstance(inv,_Operator) and inv.op=='~' and inv.operands[0] is ab[0]
axi_reset=[x.expr for x in ins[0].items if isinstance(x,Instance.Input) and x.name=='axi_rstn_i'];assert len(axi_reset)==1 and axi_reset[0] is m.axi.arstn
slaves=[d.hk.sys,d.linien.scopegen.scope_sys,d.linien.scopegen.asg_sys,d.linien.syscdc.source]
for slave in slaves:
 links=[x for x in d.ic._fragment.comb if isinstance(x,_Assign) and x.l is slave.rstn]
 assert len(links)==1 and links[0].r is m.sys.rstn
(out/'results.json').write_text(json.dumps({'passed':True,'actual_root':True,'abort_connected_to_source_bus_epoch':True,'axi_response_state_not_reset_by_abort':True,'all_four_sys_slave_reset_paths_connected':True,'source_sha256':{n:hashlib.sha256((ROOT/n).read_bytes()).hexdigest() for n in ['gateware/lowlevel/pitaya_ps.py','gateware/linien_module.py','gateware/verilog/axi_slave.v']},'scope':'Actual Migen object/instance wiring only; native transactional tests and physical CDC/route are separate.'},indent=2),encoding='utf-8')
print('R69_ACTUAL_ROOT_CANCEL_WIRING_PASS',flush=True)
