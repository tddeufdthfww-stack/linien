"""Native parallel tap clamp vs original RTL plus independent integer oracle."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Array,Cat,ClockDomain,Module,Mux,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import AutoCSR,CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.parallel_tap_limit import ParallelTapLimitCSR
from gateware.logic.limit import LimitCSR

def check_fastchain(out):
 from types import SimpleNamespace
 from gateware.logic.chains import FastChain
 out.mkdir()
 class Pair(Module):
  def __init__(self):
   self.clock_domains.cd_sys=ClockDomain('sys');self.ports={}
   for k,n,s in [('adc',14,1),('offset',14,1),('dx',25,1),('dy',25,1),('phase',32,0),('cei',1,0),('ceq',1,0),('csr_adr',14,0),('csr_we',1,0),('csr_dat_w',8,0)]:self.ports[k]=Signal((n,bool(s)),name_override=k)
   p=self.ports;maps=[]
   for prefix,parallel in [('ref',False),('cand',True)]:
    chain=FastChain(mod=SimpleNamespace(phase=p['phase']),offset_signal=p['offset'],coeff_width=25,iir_mac_impl='split_c48',parallel_output=parallel)
    setattr(self.submodules,prefix,chain);bank=CSRBank(chain.get_csrs());setattr(self.submodules,prefix+'_bank',bank)
    self.comb += [chain.adc.eq(p['adc']),chain.signal_in[0].eq(p['dx']),chain.signal_in[1].eq(p['dy']),
                 chain.y_limit_1.update_en.eq(p['cei']),chain.y_limit_2.update_en.eq(p['ceq']),
                 bank.bus.adr.eq(p['csr_adr']),bank.bus.we.eq(p['csr_we']),bank.bus.dat_w.eq(p['csr_dat_w'])]
    for suffix,n,value in [('i',25,chain.out_i),('q',25,chain.out_q),('pre',25,chain.pre_out_i),('ei',1,chain.y_limit_1.error),('eq',1,chain.y_limit_2.error),('read',8,bank.bus.dat_r)]:
     sig=Signal(n,name_override=prefix+'_'+suffix);self.ports[prefix+'_'+suffix]=sig;self.comb += sig.eq(value)
    maps.append([(v.name,v.size) for v in bank.simple_csrs])
   assert maps[0]==maps[1],maps;self.addresses=len(maps[0]);self.csr_map=maps[0]
 d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='fastchain_parallel_pair').write(str(out/'pair.v'))
 tb=f'''`timescale 1ns/1ps
module tb_fastchain_parallel;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dx=0,dy=0;reg [31:0] phase=0;
reg cei=0,ceq=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [24:0] ref_i,cand_i,ref_q,cand_q,ref_pre,cand_pre;wire ref_ei,cand_ei,ref_eq,cand_eq;wire [7:0] ref_read,cand_read;
reg [24:0] previous_i=0,previous_q=0,expected_i=0;integer i,changes=0,holds=0;integer seed=2026111021;
fastchain_parallel_pair dut(.*);
initial begin
 for(i=0;i<30000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==4003 || i==14007 || i==14008);adc=$random(seed);offset=$random(seed);dx=$random(seed);dy=$random(seed);phase=$random(seed);
  cei=((i%5)==0 || i<2000);ceq=((i%11)==0 || i<3000);csr_adr=$unsigned($random(seed))%{d.addresses};csr_we=((i%2)==0);csr_dat_w=$random(seed);
  @(posedge sys_clk);if(sys_rst)expected_i=0;else if(cei)expected_i=ref_pre;
  #1;
  if(ref_i!==cand_i || ref_q!==cand_q || ref_pre!==cand_pre || ref_ei!==cand_ei || ref_eq!==cand_eq || ref_read!==cand_read || cand_i!==expected_i || (^(cand_i^cand_q^cand_pre))===1'bx)$fatal(1,"FASTCHAIN_PARALLEL_FAIL cycle=%0d i=%h/%h q=%h/%h pre=%h/%h",i,ref_i,cand_i,ref_q,cand_q,ref_pre,cand_pre);
  if(!cei && !sys_rst && cand_i!==previous_i)$fatal(1,"CE I hold");if(!ceq && !sys_rst && cand_q!==previous_q)$fatal(1,"CE Q hold");
  if(cand_i!==previous_i || cand_q!==previous_q)changes=changes+1;previous_i=cand_i;previous_q=cand_q;if(!cei && !ceq && !sys_rst)holds=holds+1;
 end
 if(changes<100 || holds<1000)$fatal(1,"coverage");$display("FASTCHAIN_PARALLEL_PAIR_PASS cycles=30000 changes=%0d both_hold=%0d",changes,holds);$finish;
end
endmodule
'''
 (out/'tb.sv').write_bytes(tb.encode());tool=Path('D:/Xilinx/Vivado/2020.1/bin')
 for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_fastchain_parallel','-s','tb_fastchain_parallel','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_fastchain_parallel','-runall'],'FASTCHAIN_PARALLEL_PAIR_PASS')]:
  cmd=[str(v) for v in cmd];res=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(res.stdout);(out/(label+'.stderr.log')).write_bytes(res.stderr)
  text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
  (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2).encode());print('fastchain',label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
  if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
 (out/'results.json').write_bytes(json.dumps({'passed':True,'cycles':30000,'CSR_bytes_identical':d.csr_map,'scope':'Full two-phase production-width FastChain pair with real CSR banks, IIR order1/2, demod/offset/tap/invert/bounds hot writes and independent output CE; old expression vs parallel clamp, zero-cycle differential.'},indent=2).encode())

def main():
 p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);args=p.parse_args();out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
 tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
 for width in (14,25):
  n=width+3;sub=out/str(width);sub.mkdir()
  class Controls(Module,AutoCSR):
   def __init__(self):
    self.tap=CSRStorage(2);self.invert=CSRStorage(1)
    self.submodules.limit=ParallelTapLimitCSR(width=width,guard=3)
  class Pair(Module):
   def __init__(self):
    self.clock_domains.cd_sys=ClockDomain('sys');self.submodules.controls=c=Controls()
    self.submodules.reference=r=LimitCSR(width=width,guard=3);self.submodules.bank=b=CSRBank(c.get_csrs());cand=c.limit
    self.ports={}
    for key,bits,sgn in [('t0',width,1),('t1',width,1),('t2',width,1),('ca',n,1),('cb',n,1),('ce',1,0),('csr_adr',14,0),('csr_we',1,0),('csr_dat_w',8,0)]:self.ports[key]=Signal((bits,bool(sgn)),name_override=key)
    ports=self.ports;taps=[ports['t'+str(i)] for i in range(3)]
    self.comb += [r.x.eq(Mux(c.invert.storage,-1,1)*(Array(taps)[c.tap.storage]+ports['ca']+ports['cb'])),
      r.update_en.eq(ports['ce']),cand.update_en.eq(ports['ce']),
      r.min.storage.eq(cand.min.storage),r.max.storage.eq(cand.max.storage),
      cand.common_a.eq(ports['ca']),cand.common_b.eq(ports['cb']),cand.tap_select.eq(c.tap.storage),cand.invert.eq(c.invert.storage),
      b.bus.adr.eq(ports['csr_adr']),b.bus.we.eq(ports['csr_we']),b.bus.dat_w.eq(ports['csr_dat_w'])]
    self.comb += [a.eq(v) for a,v in zip(cand.taps,taps)]
    self.stores=[('tap',c.tap),('invert',c.invert),('min',cand.min),('max',cand.max)]
    self.cfg_bits=sum(v.size for _,v in self.stores)
    for key,bits,value in [('ref_y',width,r.y),('cand_y',width,cand.y),('ref_error',1,r.error),('cand_error',1,cand.error),
      ('ref_pre',n,r.limit.y),('cand_pre',n,cand.pre_y),('ref_rail',1,r.limit.railed),('cand_rail',1,cand.pre_rail),
      ('ref_lo',n,r.limit.min),('ref_hi',n,r.limit.max),('cand_lo',n,cand.bound_min),('cand_hi',n,cand.bound_max),
      ('tap_current',2,c.tap.storage),('invert_current',1,c.invert.storage),('cfg',self.cfg_bits,Cat(*[v.storage for _,v in self.stores])),('csr_read',8,b.bus.dat_r)]:
     q=Signal(bits,name_override=key);self.ports[key]=q;self.comb += q.eq(value)
    self.byte_map={};self.addresses={}
    for key,csr in self.stores:
     pos=csr.size;entries=[]
     for sc in csr.simple_csrs:
      pos-=sc.size;adr=b.simple_csrs.index(sc);entries.append((adr,pos,sc.size));self.byte_map[adr]=(key,pos,sc.size)
     self.addresses[key]=entries
  d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='parallel_tap_pair').write(str(sub/'pair.v'))
  defaults={'tap':0,'invert':0,'min':1<<(width-1),'max':(1<<(width-1))-1};storage=defaults.copy();rng=random.Random(2026111021+width);rows=[]
  def emit(rst=0,ce=None,adr=None,we=0,data=None,taps=None,ca=None,cb=None):
   adr=rng.choice(list(d.byte_map)) if adr is None else adr;data=rng.randrange(256) if data is None else data
   key,pos,bits=d.byte_map[adr];mask=(1<<bits)-1;read=(storage[key]>>pos)&mask
   if rst:storage.update(defaults);read=0
   elif we:storage[key]=(storage[key]&~(mask<<pos))|((data&mask)<<pos)
   cfg=0;pos=0
   for key,csr in d.stores:cfg|=storage[key]<<pos;pos+=csr.size
   ts=[rng.getrandbits(width) for _ in range(3)] if taps is None else taps
   rows.append([rst,*[v&((1<<width)-1) for v in ts],(rng.getrandbits(n) if ca is None else ca)&((1<<n)-1),(rng.getrandbits(n) if cb is None else cb)&((1<<n)-1),rng.randrange(2) if ce is None else ce,adr,we,data,read,cfg])
  def write(key,v,**kw):
   for adr,pos,bits in d.addresses[key]:emit(adr=adr,we=1,data=(v>>pos)&((1<<bits)-1),**kw)
  for _ in range(8):emit(rst=1)
  edges=[-(1<<(width-1)),-(1<<(width-1))+1,-1,0,1,(1<<(width-1))-2,(1<<(width-1))-1]
  for tap in range(4):
   write('tap',tap,ce=0)
   for inv in range(2):
    write('invert',inv,ce=0)
    for lo,hi in [(-(1<<(width-1)),(1<<(width-1))-1),(-123,123),(0,0),(123,-123),(-1,1)]:
     write('min',lo,ce=0);write('max',hi,ce=0)
     emit(ce=1,ca=0,cb=0)
     for a in edges:
      for b in edges:emit(ce=1,taps=[a,b,-a],ca=b,cb=a)
  for i in range(40000):emit(rst=int(i in (3000,10001,10002,25000)),we=int(i%2==0),ce=int(i%7==0) if 6000<i<18000 else None)
  (sub/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
  tb=f'''`timescale 1ns/1ps
module tb_parallel_tap;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [{width-1}:0] t0=0,t1=0,t2=0;reg signed [{n-1}:0] ca=0,cb=0;reg ce=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{width-1}:0] ref_y,cand_y;wire ref_error,cand_error,ref_rail,cand_rail,invert_current;
wire [{n-1}:0] ref_pre,cand_pre,ref_lo,ref_hi,cand_lo,cand_hi;wire [1:0] tap_current;
wire [{d.cfg_bits-1}:0] cfg;wire [7:0] csr_read;reg [{d.cfg_bits-1}:0] expected_cfg;reg [7:0] expected_read;
reg [{width-1}:0] expected_y=0;reg expected_error=0;reg signed [63:0] value,lo,hi,total;
reg signed [{n-1}:0] trunc_value;reg [{n-1}:0] expected_pre;reg expected_rail;
integer fd,k,cycles=0,rails=0,clear_cycles=0,holds=0;reg [7:0] seen=0;
parallel_tap_pair dut(.*);
task oracle;
begin
 case(tap_current)0:total=$signed(t0);1:total=$signed(t1);default:total=$signed(t2);endcase
 total=total+$signed(ca)+$signed(cb);if(invert_current)total=-total;
 trunc_value=total;value=trunc_value;lo=$signed(ref_lo);hi=$signed(ref_hi);
 if(value>=hi)begin expected_pre=hi;expected_rail=1;end
 else if(value<=lo)begin expected_pre=lo;expected_rail=1;end
 else begin expected_pre=trunc_value;expected_rail=0;end
end endtask
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,t0,t1,t2,ca,cb,ce,csr_adr,csr_we,csr_dat_w,expected_read,expected_cfg);
  if(k!=12)$fatal(1,"bad vector");#1;oracle();
  if(ref_pre!==expected_pre || cand_pre!==expected_pre || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"PARALLEL_PRE_FAIL width={width} cycle=%0d",cycles);
  @(posedge sys_clk);
  if(sys_rst)begin expected_y=0;expected_error=0;end
  else if(ce)begin expected_y=expected_pre[{width-1}:0];expected_error=expected_rail;end
  #1;oracle();
  if(ref_pre!==expected_pre || cand_pre!==expected_pre || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"PARALLEL_POST_FAIL width={width} cycle=%0d",cycles);
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error || ref_lo!==cand_lo || ref_hi!==cand_hi)$fatal(1,"PARALLEL_FF_FAIL width={width} cycle=%0d",cycles);
  if(cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"PARALLEL_CSR_FAIL width={width} cycle=%0d",cycles);
  seen[{{tap_current,invert_current}}]=1;
  if(expected_rail)rails=rails+1;else clear_cycles=clear_cycles+1;if(!ce)holds=holds+1;cycles=cycles+1;
 end
 if(cycles<40000 || rails<1000 || clear_cycles<100 || holds<1000 || seen!==8'hff)$fatal(1,"coverage");
 $display("PARALLEL_TAP_FULL_PASS width={width} cycles=%0d rails=%0d clear=%0d holds=%0d tap_sign=8/8",cycles,rails,clear_cycles,holds);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
'''
  (sub/'tb.sv').write_bytes(tb.encode())
  for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_parallel_tap','-s','tb_parallel_tap','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_parallel_tap','-runall'],f'PARALLEL_TAP_FULL_PASS width={width}')]:
   cmd=[str(v) for v in cmd];res=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(res.stdout);(sub/(label+'.stderr.log')).write_bytes(res.stderr)
   text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
   (sub/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2).encode());print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
   if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
  results.append({'width':width,'cycles':len(rows),'CSR_addresses':d.addresses})
 (out/'results.json').write_bytes(json.dumps({'passed':True,'results':results,'additional_cycles':0,'scope':'Native RTL and original LimitCSR/expression plus independent finite-width integer clamp oracle; true CSR partial writes/readback, every tap/sign, CE/reset, bounds equality/inversion and wrap edges. Not physical signoff.'},indent=2).encode())
 check_fastchain(out/'fastchain')
 print('PARALLEL_TAP_SUITE_PASS',flush=True)
if __name__=='__main__':main()
