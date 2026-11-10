"""Native old Root expression / production CSA / integer oracle, real CSR types."""
from pathlib import Path
import argparse, json, random, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import ClockDomain, Module, Mux, Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.fast_output_sum import fast_output_sum
from gateware.logic.limit import LimitCSR

def signed(v,n):
    v&=(1<<n)-1
    return v-(1<<n) if v&(1<<(n-1)) else v

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',type=Path,required=True);args=ap.parse_args()
    out=args.out.resolve();out.mkdir(parents=True,exist_ok=False);results=[];tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for width in (14,25):
        n=width+4;sub=out/str(width);sub.mkdir()
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys');self.ports={}
                self.cfg={k:CSRStorage(bits,name=k) for k,bits in [('control',1),('mod',1),('sweep',2),('slow',2),('offset',width)]}
                assert not self.cfg['offset'].storage.signed
                self.submodules.bank=bank=CSRBank(list(self.cfg.values()))
                for k,bits,sgn in [('pid',width,True),('mod_data',width,True),('sweep_data',width,True),('slow_data',width,True),('ce',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:self.ports[k]=Signal((bits,sgn),name_override=k)
                p=self.ports;c={k:v.storage for k,v in self.cfg.items()};offset=Signal((width,True));self.sync += offset.eq(c['offset'])
                self.comb += [bank.bus.adr.eq(p['csr_adr']),bank.bus.we.eq(p['csr_we']),bank.bus.dat_w.eq(p['csr_dat_w'])]
                for ch in (0,1):
                    old=Signal((n,True));new=Signal((n,True))
                    # Literal parent Root arithmetic, before output FF and clipping.
                    self.comb += old.eq(Mux(c['control']==ch,p['pid'],0)+Mux(c['mod']==ch,p['mod_data'],0)+Mux(c['sweep']==ch,p['sweep_data'],0)+Mux(c['sweep']==ch,offset,0)+Mux(c['slow']==ch,p['slow_data'],0))
                    fast_output_sum(self,new,(Mux(c['control']==ch,p['pid'],0),Mux(c['mod']==ch,p['mod_data'],0),Mux(c['sweep']==ch,p['sweep_data'],0),Mux(c['sweep']==ch,offset,0),Mux(c['slow']==ch,p['slow_data'],0)))
                    lo,ln=LimitCSR(width=width,guard=5),LimitCSR(width=width,guard=5)
                    setattr(self.submodules,'old_limit'+str(ch),lo);setattr(self.submodules,'new_limit'+str(ch),ln)
                    self.sync += [lo.x.eq(old),ln.x.eq(new)] # exact existing Root input FF
                    self.comb += [lo.update_en.eq(p['ce']),ln.update_en.eq(p['ce'])]
                    for suffix,bits,value in [('old_word',n,old),('new_word',n,new),('old_x',width+5,lo.x),('new_x',width+5,ln.x),('old_y',width,lo.y),('new_y',width,ln.y),('old_error',1,lo.error),('new_error',1,ln.error)]:
                        key=f'{suffix}{ch}';sig=Signal(bits,name_override=key);self.ports[key]=sig;self.comb += sig.eq(value)
                for key,bits,value in [('cfg',width,c['offset']),('csr_read',8,bank.bus.dat_r)]:
                    self.ports[key]=sig=Signal(bits,name_override=key);self.comb += sig.eq(value)
                self.byte_map={}
                for key,csr in self.cfg.items():
                    pos=csr.size
                    for sc in csr.simple_csrs:
                        pos-=sc.size;self.byte_map[bank.simple_csrs.index(sc)]=(key,pos,sc.size)
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='fast_output_pair').write(str(sub/'pair.v'))
        rng=random.Random(2026111027+width);cfg={k:0 for k in d.cfg};offset=0;rows=[];stats={'negative_offset':0,'writes':0,'reset':0,'ce_hold':0,'positive_rail':0,'negative_rail':0};m=(1<<n)-1;coverage=set()
        addresses={k:[a for a,v in d.byte_map.items() if v[0]==k] for k in cfg}
        old_x=[0,0];ys=[0,0];errors=[0,0];limlo=[0,0];limhi=[0,0]
        def sums(values,config,off):
            return [sum([values[0] if config['control']==ch else 0,values[1] if config['mod']==ch else 0,values[2] if config['sweep']==ch else 0,off if config['sweep']==ch else 0,values[3] if config['slow']==ch else 0]) for ch in (0,1)]
        def emit(values=None,rst=0,ce=None,adr=None,we=0,data=None):
            nonlocal cfg,offset,old_x,ys,errors,limlo,limhi
            if values is None:values=[signed(rng.getrandbits(width),width) for _ in range(4)]
            if ce is None:ce=int(rng.randrange(4)!=0)
            if adr is None:adr=rng.choice(list(d.byte_map))
            if data is None:data=rng.randrange(256)
            before=sums(values,cfg,offset);key,pos,bits=d.byte_map[adr];read=(cfg[key]>>pos)&((1<<bits)-1)
            if rst:
                cfg={k:0 for k in cfg};offset=0;old_x=[0,0];ys=[0,0];errors=[0,0];limlo=[0,0];limhi=[0,0];read=0
            else:
                if ce:
                    for ch in (0,1):
                        x=old_x[ch];upper=x>=limhi[ch];lower=x<=limlo[ch]
                        ys[ch]=signed(limhi[ch] if upper else limlo[ch] if lower else x,width);errors[ch]=int(upper or lower)
                        stats['positive_rail']+=int(upper);stats['negative_rail']+=int(not upper and lower)
                    limlo=[-(1<<(width-1))]*2;limhi=[(1<<(width-1))-1]*2
                old_x=[signed(v,n) for v in before];offset=signed(cfg['offset'],width)
                if we:cfg[key]=(cfg[key]&~(((1<<bits)-1)<<pos))|((data&((1<<bits)-1))<<pos)
            after=sums(values,cfg,offset);coverage.add(tuple(cfg[k] for k in ('control','mod','sweep','slow')))
            stats['negative_offset']+=int(offset<0);stats['writes']+=we;stats['reset']+=rst;stats['ce_hold']+=int(not ce)
            rows.append([rst,*(v&((1<<width)-1) for v in values),ce,adr,we,data,*(v&m for v in after),*(v&((1<<(width+5))-1) for v in old_x),*(v&((1<<width)-1) for v in ys),*errors,cfg['offset'],read])
        def write(key,value,reverse=False):
            for adr in (list(reversed(addresses[key])) if reverse else addresses[key]):
                _,pos,bits=d.byte_map[adr];emit(adr=adr,we=1,data=(value>>pos)&((1<<bits)-1))
        for _ in range(5):emit(rst=1)
        # Exhaustive valid/invalid selector combinations, both channel outputs.
        for control in range(2):
            write('control',control)
            for mod in range(2):
                write('mod',mod)
                for sweep in range(4):
                    write('sweep',sweep)
                    for slow in range(4):
                        write('slow',slow)
                        for value in (0,1,-1,-(1<<(width-1)),(1<<(width-1))-1):
                            write('offset',value,reverse=bool(slow&1));emit([value]*4);emit([value,-1,1,-value if value!=-(1<<(width-1)) else 0],ce=0)
        for i in range(40000):emit(rst=int(i in (1101,1102,9007,20001)),we=int(i%2==0))
        assert len(coverage)==64 and stats['negative_offset']>1000 and stats['positive_rail']>1000 and stats['negative_rail']>1000,stats
        (sub/'vectors.txt').write_text('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n',encoding='ascii')
        ports=['pid','mod_data','sweep_data','slow_data'];decl='\n'.join(f'reg signed [{width-1}:0] {x}=0;' for x in ports)
        for ch in (0,1):
            for key,bits in [('old_word',n),('new_word',n),('old_x',width+5),('new_x',width+5),('old_y',width),('new_y',width),('old_error',1),('new_error',1)]:decl+=f'\nwire [{bits-1}:0] {key}{ch};'
        expected=[('word0',n),('word1',n),('x0',width+5),('x1',width+5),('y0',width),('y1',width),('error0',1),('error1',1),('cfg',width),('read',8)]
        decl+='\n'+'\n'.join(f'reg [{bits-1}:0] expected_{key};' for key,bits in expected)
        fields=['sys_rst',*ports,'ce','csr_adr','csr_we','csr_dat_w',*('expected_'+key for key,_ in expected)]
        checks=[]
        for ch in (0,1):
            for key in ('word','x','y','error'):
                checks.append(f'if(old_{key}{ch} !== expected_{key}{ch} || new_{key}{ch} !== expected_{key}{ch}) $fatal(1,"FAST_OUTPUT_FAIL W={width} cycle=%0d field={key}{ch} old=%h new=%h expected=%h",count,old_{key}{ch},new_{key}{ch},expected_{key}{ch});')
        (sub/'tb.sv').write_text('''`timescale 1ns/1ps
module tb_fast_output;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg ce=1;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
'''+decl+f'''
wire [{width-1}:0] cfg;wire [7:0] csr_read;
integer fd,k,count=0;fast_output_pair dut(.*);
initial begin
fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
while(!$feof(fd))begin
@(negedge sys_clk);k=$fscanf(fd,"{' '.join(['%h']*len(fields))}\\n",{','.join(fields)});if(k!={len(fields)})$fatal(1,"bad vector");
@(posedge sys_clk);#1;
'''+ '\n'.join(checks)+'''
if(cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"CSR_READ_FAIL cycle=%0d",count);
count=count+1;
end
'''+f'$display("FAST_OUTPUT_FULL_WORD_PASS width={width} cycles=%0d",count);$finish;\nend\nendmodule\n',encoding='ascii')
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_fast_output','-s','tb_fast_output','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_fast_output','-runall'],f'FAST_OUTPUT_FULL_WORD_PASS width={width}')]:
            cmd=list(map(str,cmd));p=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(p.stdout);(sub/(label+'.stderr.log')).write_bytes(p.stderr)
            txt=(p.stdout+b'\n'+p.stderr).decode(errors='replace');ok=p.returncode==0 and(not marker or marker in txt)and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',txt)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':p.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,txt[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',txt)[0],flush=True)
        results.append({'width':width,'cycles':len(rows),'stats':stats,'route_combinations':len(coverage),'CSR_bytes':d.byte_map})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'scope':'Native generated original Root expression and production CSA vs full-word integer oracle, exact Root input FF, dual actual LimitCSR including independent reset/CE/saturation oracle, true unsigned byte CSRStorage and signed shadow, all 64 routing tuples/invalid2-3, partial writes/readback. Not complete PS7/Root or physical proof.'},indent=2),encoding='utf-8')
    print('FAST_OUTPUT_SUM_SUITE_PASS',flush=True)
if __name__=='__main__':main()
