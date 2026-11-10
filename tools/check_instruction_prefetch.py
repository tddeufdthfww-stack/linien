"""Native real-CSR cohort differential + independent finite integer oracle."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Array,ClockDomain,If,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.instruction_prefetch import next_instruction_word,prefetch_instruction

def signed(v,n):
    v&=(1<<n)-1;return v-(1<<n) if v&(1<<(n-1)) else v

class Pair(Module):
    def __init__(self,width):
        self.clock_domains.cd_sys=ClockDomain('sys'); self.ports={}
        for n,w in [('start',1),('advance',1),('csr_adr',14),('csr_we',1),('csr_dat_w',8),('probe_index',5)]:self.ports[n]=Signal(w,name_override=n)
        peaks=[CSRStorage(width,name='peak_'+str(i)) for i in range(32)]
        waits=[CSRStorage(14,name='wait_'+str(i)) for i in range(32)]
        assert all(not c.storage.signed for c in peaks+waits)
        self.submodules.bank=bank=CSRBank(peaks+waits);p=self.ports
        self.comb += [bank.bus.adr.eq(p['csr_adr']),bank.bus.we.eq(p['csr_we']),bank.bus.dat_w.eq(p['csr_dat_w'])]
        index=Signal(5);self.sync += If(p['start'],index.eq(0)).Elif(p['advance'],index.eq(index+1))
        # The original R28 bank structure. None of these FFs depend on idx.
        mags=[];negs=[];poss=[];oldwait=[]
        for peak,wait in zip(peaks,waits):
            raw=Signal((width,True));absolute=Signal.like(raw);extended=Signal((width+1,True))
            mag=Signal.like(raw);neg=Signal.like(extended);pos=Signal();w=Signal(14)
            self.comb += [raw.eq(peak.storage),If(raw>=0,absolute.eq(raw)).Else(absolute.eq(-raw)),extended.eq(absolute)]
            self.sync += [mag.eq(absolute),neg.eq(-extended),pos.eq(raw>0),w.eq(wait.storage)]
            mags.append(mag);negs.append(neg);poss.append(pos);oldwait.append(w)
        new=prefetch_instruction(self,peaks,waits,index,p['start'],p['advance'])
        next_probe=Signal(5);self.comb += next_probe.eq(p['probe_index']+1)
        rotated_probe=next_instruction_word(self,[v.storage for v in peaks],p['probe_index'])
        for n,w,val in [('idx',5,index),('choice',2,new['choice']),('csr_read',8,bank.bus.dat_r),('old_probe',width,Array([v.storage for v in peaks])[next_probe]),('new_probe',width,rotated_probe)]+[
            (prefix+'_'+name,bits,value) for name,bits,old in [('mag',width,Array(mags)[index]),('neg',width+1,Array(negs)[index]),('pos',1,Array(poss)[index]),('wait',14,Array(oldwait)[index])]
            for prefix,value in [('old',old),('new',new[{'mag':'magnitude','neg':'negative','pos':'positive','wait':'wait'}[name]])]]:
            q=Signal(w,name_override=n);self.ports[n]=q;self.comb += q.eq(val)
        self.byte_map={};self.addr={}
        for key,c in [(f'p{i}',v) for i,v in enumerate(peaks)]+[(f'w{i}',v) for i,v in enumerate(waits)]:
            pos=c.size;self.addr[key]=[]
            for sc in c.simple_csrs:
                pos-=sc.size;a=bank.simple_csrs.index(sc);self.byte_map[a]=(key,pos,sc.size);self.addr[key].append((a,pos,sc.size))

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for width in (14,25,28):
        sub=out/str(width);sub.mkdir();d=Pair(width)
        verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='prefetch_pair').write(str(sub/'pair.v'))
        rng=random.Random(2026111136+width);storage={n:0 for n in d.addr};index=0;rows=[];visited=set();stats={'writes':0,'resets':0,'wraps':0,'unknown':0,'min_peak':0}
        def emit(start=0,advance=0,rst=0,adr=None,we=0,data=None,known=True):
            nonlocal index
            adr=rng.choice(list(d.byte_map)) if adr is None else adr;data=rng.randrange(256) if data is None else data
            if known:
                old=index;index=0 if rst or start else (index+1)&31 if advance else index
                key,shift,bits=d.byte_map[adr];read=(storage[key]>>shift)&((1<<bits)-1)
                raw=signed(storage['p'+str(index)],width);mag=signed(abs(raw),width)
                neg=(-mag)&((1<<(width+1))-1);pos=int(raw>0);wait=storage['w'+str(index)]
                if rst:
                    mag=neg=pos=wait=read=0;storage.update({n:0 for n in storage})
                elif we:
                    mask=((1<<bits)-1)<<shift;storage[key]=(storage[key]&~mask)|((data<<shift)&mask)
                visited.add(index);stats['wraps']+=int(old==31 and advance and not start and not rst);stats['min_peak']+=int(raw==-(1<<(width-1)))
            else:mag=neg=pos=wait=read=0
            probe_index=rng.randrange(32) if known else rng.choice(['xx','zz','1x','x1',0,31])
            values=[rst,start,advance,adr,we,data,probe_index,int(known),index,mag&((1<<width)-1),neg,pos,wait,read]
            rows.append(' '.join(v if isinstance(v,str) else format(v,'x') for v in values));stats['writes']+=we;stats['resets']+=rst;stats['unknown']+=int(not known)
        def write(key,value,reverse=False):
            for adr,shift,bits in (list(reversed(d.addr[key])) if reverse else d.addr[key]):emit(adr=adr,we=1,data=(value>>shift)&((1<<bits)-1))
        for _ in range(4):emit(rst=1)
        values=[0,1,-1,-(1<<(width-1)),(1<<(width-1))-1,-123,123]
        for reverse in (False,True):
            for i in range(32):write('p'+str(i),values[i%len(values)],reverse);write('w'+str(i),(i*521)&16383,reverse)
            for i in range(128):emit(advance=1,start=int(i==67))
        for i in range(60000):emit(start=int(i%193==0),advance=int(i%5!=0),rst=int(i in (103,104,20001,40001)),we=int(i%2==0))
        assert len(visited)==32 and stats['min_peak']>0 and stats['wraps']>100
        for i in range(3000):emit(start=rng.choice([0,1,'x','z']),advance=rng.choice([0,1,'x','z']),we=int(i%2==0),data=rng.choice(['xx','zz','a5','5a']),known=False)
        for _ in range(4):emit(rst=1)
        (sub/'vectors.txt').write_text('\n'.join(rows)+'\n',encoding='ascii')
        declarations=[]
        for name,sig in d.ports.items():
            is_input=name in ('start','advance','csr_adr','csr_we','csr_dat_w','probe_index')
            declarations.append(('reg' if is_input else 'wire')+f' [{len(sig)-1}:0] {name}'+('=0;' if is_input else ';'))
        sv='''`timescale 1ns/1ps
module tb_prefetch;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
'''+ '\n'.join(declarations)+f'''
prefetch_pair dut(.*);
reg known;reg [4:0] ei;reg [{width-1}:0] em;reg [{width}:0] en;reg ep;reg [13:0] ew;reg [7:0] er;
integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,start,advance,csr_adr,csr_we,csr_dat_w,probe_index,known,ei,em,en,ep,ew,er);if(k!=14)$fatal(1,"vector malformed");
  @(posedge sys_clk);#1;
  if({{old_mag,old_neg,old_pos,old_wait,old_probe}}!=={{new_mag,new_neg,new_pos,new_wait,new_probe}} || choice>2)
   $fatal(1,"PREFETCH_DIFF width={width} cycle=%0d idx=%d choice=%d mag=%h/%h neg=%h/%h pos=%b/%b wait=%h/%h",count,idx,choice,old_mag,new_mag,old_neg,new_neg,old_pos,new_pos,old_wait,new_wait);
  if(known && ({{idx,old_mag,old_neg,old_pos,old_wait,csr_read}}!=={{ei,em,en,ep,ew,er}}))
   $fatal(1,"PREFETCH_ORACLE width={width} cycle=%0d idx=%d/%d mag=%h/%h neg=%h/%h read=%h/%h",count,idx,ei,old_mag,em,old_neg,en,csr_read,er);
  count=count+1;
 end
 $display("INSTRUCTION_PREFETCH_NATIVE_PASS width={width} cycles=%0d",count);$finish;
end
endmodule
'''
        (sub/'tb.sv').write_text(sv,encoding='ascii')
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_prefetch','-s','tb_prefetch','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_prefetch','-runall'],f'INSTRUCTION_PREFETCH_NATIVE_PASS width={width}')]:
            cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(res.stdout);(sub/(label+'.stderr.log')).write_bytes(res.stderr)
            text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-8000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'width':width,'cycles':len(rows),'indices':len(visited),'stats':stats,'byte_map':d.byte_map})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'cycles_added':0,'scope':'Real unsigned32-CSRBank per field, original whole bank vs production same-edge current/next/zero helper and independent integer oracle. Full width/finite min abs, 31->0, all32indices, continuous advances, partial writes/readback/both orders/reset and 3000 strict X/Z per width. Not full Root/SDF/board.'},indent=2),encoding='utf-8')
    print('INSTRUCTION_PREFETCH_SUITE_PASS',flush=True)
if __name__=='__main__':main()
