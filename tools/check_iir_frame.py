"""Config-shadow IIR: frozen RTL plus independent fixed-width integer oracle."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.iir import Iir
COEFFS=[f'a{i}' for i in range(1,6)]+[f'b{i}' for i in range(6)]
TERMS=[f'b{i}' for i in range(5,-1,-1)]+[f'a{i}' for i in range(5,0,-1)]
def signed(v,n):
    v&=(1<<n)-1
    return v-(1<<n) if v&(1<<(n-1)) else v
def packed(values,widths):
    result=0;pos=0
    for v,n in zip(values,widths):result|=(v&((1<<n)-1))<<pos;pos+=n
    return result

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    frozen=ROOT/'gateware/tests/timing/reference/r16_iir.py'
    spec=importlib.util.spec_from_file_location('gateware.logic.r16_iir_frame_reference',frozen);old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
    results=[];tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for width in (14,25):
        cw=width;shift=cw-2;n=width+cw;skip=shift+width-1;sub=out/str(width);sub.mkdir()
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys')
                self.submodules.candidate=c=Iir(order=5,width=width,coeff_width=cw,shift=shift,config_delay=1,mac_impl="split_c48" if width==25 else "native")
                self.submodules.reference=r=old.Iir(order=5,width=width,coeff_width=cw,shift=shift)
                self.submodules.bank=b=CSRBank(c.get_csrs());self.ports={}
                for key,bits,sgn in [('x',width,True),('hold',1,False),('clear',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:self.ports[key]=Signal((bits,sgn),name_override=key)
                def lag(value):
                    q=Signal.like(value);self.sync += q.eq(value);return q
                for key in ['x','hold','clear']:
                    self.comb += [getattr(c,key).eq(lag(self.ports[key])),getattr(r,key).eq(lag(self.ports[key]))]
                self.stores=[('z0',c.z0)]+[(k,getattr(c,'r_'+k)) for k in COEFFS]
                self.comb += r.z0.storage.eq(lag(c.z0.storage))
                for k in COEFFS:self.comb += getattr(r,'r_'+k).storage.eq(lag(getattr(c,'r_'+k).storage))
                self.comb += [b.bus.adr.eq(self.ports['csr_adr']),b.bus.we.eq(self.ports['csr_we']),b.bus.dat_w.eq(self.ports['csr_dat_w'])]
                self.cfg_bits=sum(v.size for _,v in self.stores)
                for key,bits,value in [('ref_y',width,r.y),('cand_y',width,c.y),('ref_error',1,r.error),('cand_error',1,c.error),('read_value',8,b.bus.dat_r),
                    ('ref_coeff',cw*11,Cat(*[r.c[k] for k in COEFFS])),('cand_coeff',cw*11,Cat(*[c.c[k] for k in COEFFS])),('cfg',self.cfg_bits,Cat(*[v.storage for _,v in self.stores]))]:
                    q=Signal(bits,name_override=key);self.ports[key]=q;self.comb += q.eq(value)
                self.byte_map={};self.addresses={}
                for key,csr in self.stores:
                    pos=csr.size;entries=[]
                    for sc in csr.simple_csrs:
                        pos-=sc.size;adr=b.simple_csrs.index(sc);entries.append((adr,pos,sc.size));self.byte_map[adr]=(key,pos,sc.size)
                    self.addresses[key]=entries
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='iir_frame_pair').write(str(sub/'pair.v'))
        class Oracle:
            def __init__(self):self.reset()
            def reset(self):
                self.storage={k:0 for k,_ in d.stores};self.coeff={k:0 for k in COEFFS};self.seed=0;self.z=[0]*11;self.y=0;self.fb=0;self.error=0
            def step(self,x,hold,clear,adr,we,data):
                vals=[signed(self.z[i]+(signed(x,width) if k[0]=='b' else self.fb)*self.coeff[k],n) for i,k in enumerate(TERMS)]
                upper=(vals[-1]&((1<<n)-1))>>skip
                self.error=int(upper not in (0,(1<<(n-skip))-1))
                result=self.y if self.error else signed(vals[-1]>>shift,width)
                self.y=result;self.fb=0 if clear else self.fb if hold else result
                self.z=[self.seed]+vals[:-1];self.seed=signed(self.storage['z0']<<shift,n)
                self.coeff={k:signed(self.storage[k],cw) for k in COEFFS}
                if we and adr in d.byte_map:
                    key,pos,bits=d.byte_map[adr];mask=(1<<bits)-1;self.storage[key]=(self.storage[key]&~(mask<<pos))|((data&mask)<<pos)
        model=Oracle();current={k:0 for k,_ in d.stores};previous=(0,0,0,0,0,0);rng=random.Random(2026111018+width)
        rows=[];stats={'writes':0,'holds':0,'clears':0,'resets':0,'rail':0,'nonzero':0};latencies={}
        def emit(x=0,hold=0,clear=0,rst=0,adr=0,we=0,data=0):
            nonlocal previous
            if rst:model.reset();current.update({k:0 for k in current});previous=(0,0,0,0,0,0);read=0
            else:
                model.step(*previous)
                key,pos,bits=d.byte_map[adr];mask=(1<<bits)-1;read=(current[key]>>pos)&mask
                if we:current[key]=(current[key]&~(mask<<pos))|((data&mask)<<pos)
                previous=(x,hold,clear,adr,we,data)
            rows.append([rst,x&((1<<width)-1),hold,clear,adr,we,data,read,model.y&((1<<width)-1),model.error,
                packed([model.coeff[k] for k in COEFFS],[cw]*11),packed([current[k] for k,_ in d.stores],[v.size for _,v in d.stores])])
            for key,value in [('writes',we),('holds',hold),('clears',clear),('resets',rst),('rail',model.error),('nonzero',int(model.y!=0))]:stats[key]+=value
        def write(key,value):
            for adr,pos,bits in d.addresses[key]:emit(adr=adr,we=1,data=(value>>pos)&((1<<bits)-1))
        for _ in range(4):emit(rst=1)
        for tap,delay in [('b0',7),('b5',12)]:
            for key in COEFFS:write(key,(1<<shift) if key==tap else 0)
            for _ in range(40):emit()
            start=len(rows);emit(x=123)
            for _ in range(40):emit()
            hit=next(i for i in range(start,len(rows)) if signed(rows[i][8],width)==123)
            assert hit-start+1==delay,(width,tap,hit-start+1);latencies[tap]=delay
        for key in COEFFS:write(key,0)
        for val in [1,-1,(1<<(width-1))-1,-(1<<(width-1)),(1<<(width+1))-1,-(1<<(width+1)),0]:
            write('z0',val)
            for _ in range(24):emit()
        write('z0',0);write('b0',1<<(shift-1));write('a1',1<<(shift-1))
        for i in range(1500):emit(x=signed(rng.getrandbits(width),width),hold=int(i%31<5),clear=int(i%137==0))
        for i in range(16000):
            adr=rng.choice(list(d.byte_map));emit(x=[-(1<<(width-1)),-1,0,1,(1<<(width-1))-1][i%5] if i<2000 else rng.getrandbits(width),
                hold=int(i%17<4),clear=int(i%193==0),rst=int(i in (3301,3302,11003)),adr=adr,we=int(i%2==0),data=rng.randrange(256))
        for _ in range(10):emit()
        assert stats['rail']>100 and stats['nonzero']>1000 and stats['holds']>1000,stats
        (sub/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
        tb=f'''`timescale 1ns/1ps
module tb_iir_frame;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;reg signed [{width-1}:0] x=0;reg hold=0,clear=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{width-1}:0] ref_y,cand_y;wire ref_error,cand_error;wire [7:0] read_value;wire [{cw*11-1}:0] ref_coeff,cand_coeff;wire [{d.cfg_bits-1}:0] cfg;
reg [7:0] expected_read;reg [{width-1}:0] expected_y;reg expected_error;reg [{cw*11-1}:0] expected_coeff;reg [{d.cfg_bits-1}:0] expected_cfg;
iir_frame_pair dut(.*);integer fd,k,cycles=0,rails=0,nonzero=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,x,hold,clear,csr_adr,csr_we,csr_dat_w,expected_read,expected_y,expected_error,expected_coeff,expected_cfg);
  if(k!=12)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error || ref_coeff!==expected_coeff || cand_coeff!==expected_coeff || cfg!==expected_cfg || read_value!==expected_read)
   $fatal(1,"IIR_FRAME_FAIL W={width} cycle=%0d y=%h/%h/%h rail=%b/%b/%b coeff=%h/%h/%h cfg=%h/%h read=%h/%h",cycles,ref_y,cand_y,expected_y,ref_error,cand_error,expected_error,ref_coeff,cand_coeff,expected_coeff,cfg,expected_cfg,read_value,expected_read);
  if(cand_error)rails=rails+1;if(cand_y!=0)nonzero=nonzero+1;cycles=cycles+1;
 end
 if(cycles<17000 || rails<100 || nonzero<1000)$fatal(1,"coverage");
 $display("IIR_CONFIG_FRAME_PASS width={width} cycles=%0d rails=%0d nonzero=%0d raw_b0_latency=7 raw_b5_latency=12",cycles,rails,nonzero);$finish;
end
initial begin #500000;$fatal(1,"timeout");end
endmodule
'''
        (sub/'tb.sv').write_bytes(tb.encode())
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_iir_frame','-s','tb_iir_frame','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_iir_frame','-runall'],f'IIR_CONFIG_FRAME_PASS width={width}')]:
            cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(r.stdout);(sub/(label+'.stderr.log')).write_bytes(r.stderr)
            txt=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in txt) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',txt)
            (sub/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,txt[-7000:]
            if marker:print(re.search(marker+r'[^\r\n]*',txt)[0],flush=True)
        stats['cycles']=len(rows);results.append({'width':width,'stats':stats,'latency_from_undelayed_raw_input':latencies,'latency_CSR_relative_to_filter_x':6,'CSR_addresses':d.addresses})
    (out/'results.json').write_bytes(json.dumps({'passed':True,'results':results,'frozen_iir_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),'scope':'Native generated RTL, frozen R16 IIR with independent raw input/config delay and integer 28/50-bit oracle, true CSRBank and hot partial writes; no IIR recurrence register change.'},indent=2).encode())
    print('IIR_CONFIG_FRAME_SUITE_PASS',flush=True)
if __name__=='__main__':main()
