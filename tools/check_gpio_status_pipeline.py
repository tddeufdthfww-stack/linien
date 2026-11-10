"""Native simulation of real cross_connect and CSRBank; only GPIO lags one edge."""
from pathlib import Path
import argparse, importlib.util, json, random, re, subprocess, sys
ROOT = Path(__file__).resolve().parents[1]
sys.path[:0] = [str(ROOT), str(ROOT/'linien-common')]
from migen import ClockDomain, Module, Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import AutoCSR, CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.chains import cross_connect
spec = importlib.util.spec_from_file_location('gateware.logic.r28_chains_gpio_reference', ROOT/'gateware/tests/timing/reference/r28_chains_gpio.py')
ref = importlib.util.module_from_spec(spec); spec.loader.exec_module(ref)

class GPIO(Module, AutoCSR):
    def __init__(self):
        self.i=Signal(8); self.o=Signal(8)
class Source(Module, AutoCSR):
    def __init__(self):
        self.state_in=[]; self.signal_in=[]
        self.state_out=[Signal(name='flag'+str(i)) for i in range(5)]
        self.signal_out=[Signal((25,True),name='trace'+str(i)) for i in range(2)]
class Sink(Module, AutoCSR):
    def __init__(self):
        self.state_out=[]; self.signal_out=[]
        self.state_in=[Signal(name='accept')]; self.signal_in=[Signal((25,True),name='take')]
class Bundle(Module, AutoCSR):
    def __init__(self,mode):
        self.submodules.gpio=g=GPIO(); self.submodules.source=s=Source(); self.submodules.sink=c=Sink()
        self.names=(ref.cross_connect(g,[('robust',s),('consumer',c)]) if mode<0 else
                    cross_connect(g,[('robust',s),('consumer',c)],gpio_status_pipeline=mode))
        csrs=self.get_csrs(); self.csrs=csrs
        self.submodules.bank=CSRBank(csrs)
class Pair(Module):
    def __init__(self):
        self.clock_domains.cd_sys=ClockDomain('sys'); self.ports={}
        for n,w in [('di',8),('flags',5),('trace_a',25),('trace_b',25),('csr_adr',14),('csr_we',1),('csr_dat_w',8)]:
            self.ports[n]=Signal(w,name_override=n)
        self.bundles=[]
        for tag,mode in [('old',-1),('plain',0),('new',1)]:
            q=Bundle(mode); setattr(self.submodules,tag,q); self.bundles.append(q); p=self.ports
            self.comb += [q.gpio.i.eq(p['di']),q.source.signal_out[0].eq(p['trace_a']),q.source.signal_out[1].eq(p['trace_b']),
                          q.bank.bus.adr.eq(p['csr_adr']),q.bank.bus.we.eq(p['csr_we']),q.bank.bus.dat_w.eq(p['csr_dat_w'])]
            self.comb += [s.eq(p['flags'][i]) for i,s in enumerate(q.source.state_out)]
            for n,w,val in [('gpio',8,q.gpio.o),('accept',1,q.sink.state_in[0]),('take',25,q.sink.signal_in[0]),('read',8,q.bank.bus.dat_r)]:
                x=Signal(w,name_override=tag+'_'+n); self.ports[tag+'_'+n]=x; self.comb += x.eq(val)
        q=self.bundles[0]; self.byte_map={}; self.cfg={}
        shape=lambda q:[(c.name,c.size,type(c).__name__) for c in q.csrs]
        assert all(shape(q)==shape(b) and q.names==b.names for b in self.bundles[1:])
        for c in q.csrs:
            if isinstance(c,CSRStorage):
                self.cfg[c.name]=c.size; pos=c.size
                for sc in c.simple_csrs:
                    pos-=sc.size; self.byte_map[q.bank.simple_csrs.index(sc)]=(c.name,pos,sc.size)
        self.csr_shape=shape(q)

def main():
    p=argparse.ArgumentParser(); p.add_argument('--out',type=Path,required=True); a=p.parse_args()
    out=a.out.resolve(); out.mkdir(parents=True,exist_ok=False)
    d=Pair(); verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='gpio_pair').write(str(out/'pair.v'))
    masks=[next(n for n in d.cfg if n.endswith('do'+str(i)+'_en')) for i in range(8)]
    control=next(n for n in d.cfg if n.endswith('accept_en')); selector=next(n for n in d.cfg if n.endswith('take_sel'))
    assert [d.cfg[n] for n in masks]==[14]*8 and d.cfg[control]==14 and d.cfg[selector]==2
    cfg={n:0 for n in d.cfg}; rows=[]; rng=random.Random(2026111034)
    old_prev=0; stats={'writes':0,'resets':0,'unknown':0}; addresses=list(d.byte_map)
    alladdresses=list(range(len(d.bundles[0].bank.simple_csrs)))
    def emit(di=None,flags=None,ta=None,tb=None,rst=0,adr=None,we=0,data=None,known=True):
        nonlocal old_prev
        di=rng.randrange(256) if di is None else di; flags=rng.randrange(32) if flags is None else flags
        ta=rng.getrandbits(25) if ta is None else ta; tb=rng.getrandbits(25) if tb is None else tb
        adr=rng.choice(alladdresses) if adr is None else adr; data=rng.randrange(256) if data is None else data
        if known:
            v=1|(di<<1)|(flags<<9)
            gpio=sum(int(bool(v&cfg[n]))<<i for i,n in enumerate(masks))
            accept=int(bool(v&cfg[control])); take=0 if cfg[selector]==0 else ta if cfg[selector]==1 else tb
            delayed=old_prev
            if rst: gpio=delayed=accept=take=0; cfg.update({n:0 for n in cfg})
            elif we and adr in d.byte_map:
                n,pos,bits=d.byte_map[adr]; m=((1<<bits)-1)<<pos
                cfg[n]=(cfg[n]&~m)|((data<<pos)&m)
            old_prev=gpio
        else: gpio=delayed=accept=take=0
        vals=[rst,di,flags,ta,tb,adr,we,data,int(known),gpio,delayed,accept,take]
        rows.append(' '.join(v if isinstance(v,str) else format(v,'x') for v in vals))
        stats['writes']+=we; stats['resets']+=rst; stats['unknown']+=int(not known)
    def write(n,value):
        for adr,(name,pos,bits) in d.byte_map.items():
            if name==n: emit(adr=adr,we=1,data=(value>>pos)&((1<<bits)-1))
    for _ in range(6):emit(rst=1)
    for statebit in range(14):
        for n in masks+[control]:write(n,1<<statebit)
        for value in [0,1<<statebit,0,1<<statebit,1<<statebit,0]:
            emit(di=(value>>1)&255,flags=(value>>9)&31)
    for sel in range(4):
        write(selector,sel)
        for ta,tb in [(0,0),(1,2),(0x1000000,0xffffff),(0x1ffffff,0x1000000)]:emit(ta=ta,tb=tb)
    for i in range(60000):
        emit(rst=int(i in (71,72,703,7001,23000,23001,49000)),we=int(i%2==0),adr=rng.choice(addresses if i%4 else alladdresses))
    # Four-state comparisons use independent native old output delay; oracle is finite-only.
    for i in range(3000):
        emit(di=rng.choice(['xx','zz','a5','5a']),flags=rng.choice(['xx','zz','15','0a']),
             ta=rng.choice(['xxxxxxx','zzzzzzz','1000000']),tb=rng.choice(['xxxxxxx','zzzzzzz','0ffffff']),known=False,we=0)
    for _ in range(4):emit(rst=1)
    (out/'vectors.txt').write_text('\n'.join(rows)+'\n',encoding='ascii')
    declarations=[]
    for n,s in d.ports.items():
        is_input=n in ('di','flags','trace_a','trace_b','csr_adr','csr_we','csr_dat_w')
        declarations.append(('reg' if is_input else 'wire')+f' [{len(s)-1}:0] {n}'+('=0;' if is_input else ';'))
    sv='''`timescale 1ns/1ps
module tb_gpio;
reg sys_clk=0; always #4 sys_clk=~sys_clk; reg sys_rst=1;
'''+ '\n'.join(declarations)+'''
gpio_pair dut(.*);
reg [7:0] lag=0; always @(posedge sys_clk) if(sys_rst) lag<=0; else lag<=old_gpio;
reg known; reg [7:0] eg,ed; reg ea; reg [24:0] et;
integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r"); if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk); k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,di,flags,trace_a,trace_b,csr_adr,csr_we,csr_dat_w,known,eg,ed,ea,et);
  if(k!=13)$fatal(1,"vector malformed");
  @(posedge sys_clk); #1;
  if(plain_gpio!==old_gpio || new_gpio!==lag || plain_accept!==old_accept || new_accept!==old_accept || plain_take!==old_take || new_take!==old_take || plain_read!==old_read || new_read!==old_read)
   $fatal(1,"GPIO_DIFF cycle=%0d gpio=%h/%h/%h lag=%h accept=%h/%h take=%h/%h read=%h/%h",count,old_gpio,plain_gpio,new_gpio,lag,old_accept,new_accept,old_take,new_take,old_read,new_read);
  if(known && (old_gpio!==eg || new_gpio!==ed || old_accept!==ea || old_take!==et))
   $fatal(1,"GPIO_ORACLE cycle=%0d gpio=%h/%h new=%h/%h accept=%h/%h take=%h/%h",count,old_gpio,eg,new_gpio,ed,old_accept,ea,old_take,et);
  count=count+1;
 end
 $display("GPIO_STATUS_NATIVE_PASS cycles=%0d",count); $finish;
end
endmodule
'''
    (out/'tb.sv').write_text(sv,encoding='ascii'); tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_gpio','-s','tb_gpio','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_gpio','-runall'],'GPIO_STATUS_NATIVE_PASS')]:
        cmd=list(map(str,cmd)); r=subprocess.run(cmd,cwd=out,capture_output=True)
        (out/(label+'.stdout.log')).write_bytes(r.stdout); (out/(label+'.stderr.log')).write_bytes(r.stderr)
        t=(r.stdout+b'\n'+r.stderr).decode(errors='replace'); ok=r.returncode==0 and (not marker or marker in t) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',t)
        (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2),encoding='utf-8')
        print(label,'PASS' if ok else 'FAIL',flush=True); assert ok,t[-8000:]
        if marker: print(re.search(marker+r'[^\r\n]*',t)[0],flush=True)
    (out/'results.json').write_text(json.dumps({'passed':True,'cycles':len(rows),'stats':stats,'csr_shape':d.csr_shape,'byte_map':d.byte_map,'feedback_extra_cycles':0,'derived_gpio_extra_cycles':1,'scope':'Real cross_connect and real CSRBank; frozen R28 reference/default exact same cycle; GPIO-only independent one-edge native lag and finite Python oracle; partial CSR writes/reads/reset/clear, all14 state bits/8 outputs, internal state/signal consumers same cycle, 3000 X/Z vectors. Not full Root, SDF or board.'},indent=2),encoding='utf-8')
    print('GPIO_STATUS_PIPELINE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
