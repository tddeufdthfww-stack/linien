"""Late one-bit selection vs frozen R28 structure, true CSR cohorts and oracle."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Array,ClockDomain,If,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.abs_threshold import signed_abs_over_threshold
from gateware.logic.late_threshold_select import late_threshold_select

def signed(v,n):
    v&=(1<<n)-1
    return v-(1<<n) if v&(1<<(n-1)) else v

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for n in (14,25,29):
        m=n-1;sub=out/str(n);sub.mkdir()
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys');self.ports={}
                for key,bits,sgn in [('value',n,True),('index',5,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:self.ports[key]=Signal((bits,sgn),name_override=key)
                p=self.ports;self.csrs=[CSRStorage(m,name=f'peak{i:02}') for i in range(32)];assert all(not x.storage.signed for x in self.csrs)
                self.submodules.bank=b=CSRBank(self.csrs);self.comb += [b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
                thresholds=[];negatives=[]
                for csr in self.csrs:
                    height=Signal((m,True));absolute=Signal.like(height);wide=Signal((n,True));q=Signal.like(height);neg=Signal.like(wide)
                    self.comb += [height.eq(csr.storage),If(height>=0,absolute.eq(height)).Else(absolute.eq(-height)),wide.eq(absolute)]
                    self.sync += [q.eq(absolute),neg.eq(-wide)];thresholds.append(q);negatives.append(neg)
                selected=Signal((m,True));selected_neg=Signal((n,True));old=Signal();new=Signal()
                self.comb += [selected.eq(Array(thresholds)[p['index']]),selected_neg.eq(Array(negatives)[p['index']])]
                signed_abs_over_threshold(self,p['value'],selected,selected_neg,old)
                late_threshold_select(self,p['value'],thresholds,negatives,p['index'],new)
                for key,bits,value in [('old_y',1,old),('new_y',1,new),('selected_t',m,selected),('selected_neg',n,selected_neg),('cfg',m,Array([c.storage for c in self.csrs])[p['index']]),('csr_read',8,b.bus.dat_r)]:
                    sig=Signal(bits,name_override=key);self.ports[key]=sig;self.comb += sig.eq(value)
                self.byte_map={};self.addresses={}
                for i,csr in enumerate(self.csrs):
                    pos=m;self.addresses[i]=[]
                    for sc in csr.simple_csrs:
                        pos-=sc.size;adr=b.simple_csrs.index(sc);self.byte_map[adr]=(i,pos,sc.size);self.addresses[i].append(adr)
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='threshold_bank_pair').write(str(sub/'pair.v'))
        cfg=[0]*32;rows=[];rng=random.Random(2026111030+n);stats={'writes':0,'reset':0,'minimum_sum_abs_wrap':0,'negative_threshold':0,'true':0,'false':0};covered=set()
        def emit(value=None,index=None,rst=0,adr=None,we=0,data=None):
            nonlocal cfg
            if value is None:value=signed(rng.getrandbits(n),n)
            if adr is None:adr=rng.choice(list(d.byte_map))
            i,pos,bits=d.byte_map[adr]
            if index is None:index=i if rng.randrange(2) else rng.randrange(32)
            if data is None:data=rng.randrange(256)
            threshold=signed(abs(signed(cfg[index],m)),m);negative=-threshold;read=(cfg[i]>>pos)&((1<<bits)-1)
            if rst:cfg=[0]*32;threshold=0;negative=0;read=0
            elif we:cfg[i]=(cfg[i]&~(((1<<bits)-1)<<pos))|((data&((1<<bits)-1))<<pos)
            expected=int(signed(abs(value),n)>=threshold);covered.add(index)
            stats['writes']+=we;stats['reset']+=rst;stats['minimum_sum_abs_wrap']+=int(value==-(1<<(n-1)));stats['negative_threshold']+=int(threshold<0);stats['true' if expected else 'false']+=1
            rows.append([rst,value&((1<<n)-1),index,adr,we,data,expected,threshold&((1<<m)-1),negative&((1<<n)-1),cfg[index],read])
        for _ in range(5):emit(rst=1)
        for index in range(32):
            for height in (0,1,-1,(1<<(m-1))-1,-(1<<(m-1)),123,-123):
                for order in (d.addresses[index],list(reversed(d.addresses[index]))):
                    for adr in order:
                        _,pos,bits=d.byte_map[adr];emit(index=index,adr=adr,we=1,data=(height>>pos)&((1<<bits)-1))
                    threshold=signed(abs(signed(height,m)),m)
                    for value in (-(1<<(n-1)),-(1<<(n-1))+1,-1,0,1,threshold-1,threshold,threshold+1,-threshold-1,-threshold,-threshold+1,(1<<(n-1))-1):emit(value=signed(value,n),index=index)
        for i in range(40000):emit(rst=int(i in (1111,1112,9009,20002)),we=int(i%2==0))
        assert len(covered)==32 and stats['negative_threshold']>=64 and stats['minimum_sum_abs_wrap']>=32 and stats['true']>1000 and stats['false']>1000,stats
        (sub/'vectors.txt').write_text('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n',encoding='ascii')
        # Unknown index keeps Migen Array's default-last case; scalar semantics unchanged.
        unknown=[]
        for _ in range(2000):
            value=''.join(rng.choice('000111xz') for _ in range(n));idx=''.join(rng.choice('0011xz') for _ in range(5));unknown.append((value,idx))
        (sub/'unknown.txt').write_text('\n'.join(' '.join(row) for row in unknown)+'\n',encoding='ascii')
        (sub/'tb.sv').write_text(f'''`timescale 1ns/1ps
module tb_threshold_bank;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [{n-1}:0] value=0;reg [4:0] index=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire old_y,new_y;wire [{m-1}:0] selected_t,cfg;wire [{n-1}:0] selected_neg;wire [7:0] csr_read;
reg expected;reg [{m-1}:0] expected_t,expected_cfg;reg [{n-1}:0] expected_neg;reg [7:0] expected_read;
integer fd,k,count=0,unknown_count=0;threshold_bank_pair dut(.*);
initial begin
fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"missing vectors");
while(!$feof(fd))begin
@(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,value,index,csr_adr,csr_we,csr_dat_w,expected,expected_t,expected_neg,expected_cfg,expected_read);if(k!=11)$fatal(1,"bad vector");
@(posedge sys_clk);#1;
if(old_y!==expected || new_y!==expected || selected_t!==expected_t || selected_neg!==expected_neg || cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"THRESHOLD_BANK_FAIL N={n} cycle=%0d idx=%0d old=%b new=%b expected=%b threshold=%h/%h cfg=%h/%h read=%h/%h",count,index,old_y,new_y,expected,selected_t,expected_t,cfg,expected_cfg,csr_read,expected_read);
count=count+1;
end
$fclose(fd);fd=$fopen("unknown.txt","r");sys_rst=0;csr_we=0;
while(!$feof(fd))begin
@(negedge sys_clk);k=$fscanf(fd,"%b %b\\n",value,index);if(k!=2)$fatal(1,"bad unknown vector");
@(posedge sys_clk);#1;if(old_y!==new_y)$fatal(1,"THRESHOLD_BANK_XZ_FAIL N={n} case=%0d idx=%b value=%b old=%b new=%b",unknown_count,index,value,old_y,new_y);
unknown_count=unknown_count+1;
end
$display("THRESHOLD_BANK_FULL_PASS N={n} M={m} cycles=%0d unknown=%0d indices=32",count,unknown_count);$finish;
end
endmodule
''',encoding='ascii')
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_threshold_bank','-s','tb_threshold_bank','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_threshold_bank','-runall'],f'THRESHOLD_BANK_FULL_PASS N={n} ')]:
            cmd=list(map(str,cmd));p=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(p.stdout);(sub/(label+'.stderr.log')).write_bytes(p.stderr)
            text=(p.stdout+b'\n'+p.stderr).decode(errors='replace');ok=p.returncode==0 and(not marker or marker in text)and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':p.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(n,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'value_width':n,'threshold_width':m,'cycles':len(rows),'unknown_cases':len(unknown),'indices':32,'stats':stats,'CSR_bytes':d.byte_map})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'scope':'Actual late-select helper vs R28 select-then-scalar-helper, known finite abs oracle, true 32-CSR bank and same-cohort abs/negative FFs; all indices/hot partial writes/reset/readback/strict XZ. Full FPGAAutolock separately regressed; not physical signoff.'},indent=2),encoding='utf-8')
    print('THRESHOLD_BANK_SUITE_PASS',flush=True)
if __name__=='__main__':main()
