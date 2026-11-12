"""Frozen full CORDIC pipeline/CSR differential and independent first-step proof."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.modulate import Demodulate

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',required=True,type=Path)
    out=ap.parse_args().out.resolve();out.mkdir(parents=True,exist_ok=False)
    frozen=ROOT/'gateware/tests/timing/reference/r75_modulate.py'
    spec=importlib.util.spec_from_file_location('gateware.logic.r75_frozen_modulate',frozen)
    old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
    results=[];tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for width in (14,25):
        sub=out/str(width);sub.mkdir();rng=random.Random(770112+width)
        edges=[-(1<<(width-1)),-1,0,1,(1<<(width-1))-1]
        samples=range(-(1<<13),1<<13) if width==14 else edges+[rng.randrange(-(1<<24),1<<24) for _ in range(10000)]
        proof=0
        for x in samples:
            for quadrant in range(4):
                z=quadrant<<(width-1);q=((z>>(width-1))^(z>>width))&1
                mapped=(z+(q<<width))&((1<<(width+1))-1);direction=(mapped>>width)&1
                mx=-x if q else x
                original=(mx<<2,(-mx if direction else mx)<<2)
                optimized=((-x if q else x)<<2,(-x if z&(1<<width) else x)<<2)
                assert original==optimized,(width,x,z,original,optimized);proof+=1
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys')
                self.ports={k:Signal((n,s),name_override=k) for k,n,s in [
                    ('x',width,True),('phase',width,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]}
                self.submodules.reference=r=old.Demodulate(width=width)
                self.submodules.candidate=c=Demodulate(width=width,speculative_first_rotation=True)
                self.submodules.reference_bank=rb=CSRBank(r.get_csrs())
                self.submodules.candidate_bank=cb=CSRBank(c.get_csrs())
                assert [(v.name,v.size) for v in rb.simple_csrs]==[(v.name,v.size) for v in cb.simple_csrs]
                assert r.cordic.latency==c.cordic.latency==width+1 and r.cordic.interval==c.cordic.interval==1
                p=self.ports
                for d,b in [(r,rb),(c,cb)]:
                    self.comb += [d.x.eq(p['x']),d.phase.eq(p['phase']),b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
                for prefix,d,b in [('ref',r,rb),('cand',c,cb)]:
                    for k,n,v in [('i',width,d.i),('q',width,d.q),('phase',width+1,d.cordic.zi),
                                  ('delay',32,d.delay.storage),('mult',4,d.multiplier.storage),('read',8,b.bus.dat_r)]:
                        q=Signal(n,name_override=prefix+'_'+k);p[prefix+'_'+k]=q;self.comb += q.eq(v)
                self.delay_map=[];pos=c.delay.size
                for v in c.delay.simple_csrs:pos-=v.size;self.delay_map.append((cb.simple_csrs.index(v),pos,v.size))
                self.mult_addr=cb.simple_csrs.index(c.multiplier.simple_csrs[0]);self.addresses=len(cb.simple_csrs)
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='r77_demod_pair').write(str(sub/'pair.v'))
        rows=[]
        def emit(x=0,phase=0,rst=0,adr=0,we=0,data=0):rows.append([rst,x&((1<<width)-1),phase&((1<<width)-1),adr,we,data])
        for _ in range(24):emit(rst=1)
        if width==14:
            for x in range(-(1<<13),1<<13):
                for q in range(4):emit(x=x,phase=q<<(width-2))
        phases=[0,1,(1<<(width-2))-1,1<<(width-2),(1<<(width-1))-1,1<<(width-1),(1<<width)-2,(1<<width)-1]
        delays=[0,1,2,(1<<(width-1))-1,1<<(width-1),(1<<width)-1,0x80000000,0xffffffff]
        for mult in range(16):
            emit(adr=d.mult_addr,we=1,data=mult)
            for delay in delays:
                for adr,pos,bits in d.delay_map:emit(adr=adr,we=1,data=(delay>>pos)&((1<<bits)-1))
                for phase in phases:
                    for x in edges:emit(x=x,phase=phase)
        for i in range(22000):emit(x=rng.getrandbits(width),phase=rng.getrandbits(width),rst=int(i in (7013,7014,17007)),adr=rng.randrange(d.addresses),we=int(i%3==0),data=rng.randrange(256))
        for _ in range(width+4):emit()
        (sub/'vectors.txt').write_text('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n')
        tb=f'''`timescale 1ns/1ps
module tb_r77_demod;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [{width-1}:0] x=0;reg [{width-1}:0] phase=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{width-1}:0] ref_i,ref_q,cand_i,cand_q;wire [{width}:0] ref_phase,cand_phase;
wire [31:0] ref_delay,cand_delay;wire [3:0] ref_mult,cand_mult;wire [7:0] ref_read,cand_read;
r77_demod_pair dut(.*);integer fd,k,cycles=0,writes=0,resets=0,changes=0;
reg [15:0] seen=0;reg [{width*2-1}:0] previous=0;reg [63:0] expected_phase;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h\\n",sys_rst,x,phase,csr_adr,csr_we,csr_dat_w);
  if(k!=6)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if({{ref_i,ref_q,ref_phase,ref_delay,ref_mult,ref_read}}!=={{cand_i,cand_q,cand_phase,cand_delay,cand_mult,cand_read}})
   $fatal(1,"R77_DEMOD_FAIL W={width} cycle=%0d IQ=%h/%h/%h/%h phase=%h/%h",cycles,ref_i,ref_q,cand_i,cand_q,ref_phase,cand_phase);
  expected_phase=phase;expected_phase=((expected_phase*cand_mult)+cand_delay)<<1;
  if(cand_phase!==expected_phase[{width}:0])$fatal(1,"phase arithmetic mismatch");
  if((^{{cand_i,cand_q,cand_delay,cand_mult,cand_read}})===1'bx)$fatal(1,"unknown outputs");
  seen[cand_mult]=1;if(csr_we)writes=writes+1;if(sys_rst)resets=resets+1;
  if({{cand_i,cand_q}}!==previous)changes=changes+1;previous={{cand_i,cand_q}};cycles=cycles+1;
 end
 if(seen!==16'hffff || changes<1000 || resets<24 || writes<7000)$fatal(1,"coverage");
 $display("R77_DEMOD_PASS width={width} cycles=%0d writes=%0d resets=%0d changes=%0d multipliers=16/16 latency={width+1}",cycles,writes,resets,changes);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
'''
        (sub/'tb.sv').write_bytes(tb.encode())
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),
          ('elaborate',[tool/'xelab.bat','tb_r77_demod','-s','tb_r77_demod','--timescale','1ns/1ps'],None),
          ('simulate',[tool/'xsim.bat','tb_r77_demod','-runall'],f'R77_DEMOD_PASS width={width}')]:
            cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=sub,capture_output=True)
            (sub/(label+'.stdout.log')).write_bytes(r.stdout);(sub/(label+'.stderr.log')).write_bytes(r.stderr)
            text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2))
            print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'width':width,'cycles':len(rows),'first_step_independent_math_cases':proof,'original_latency_cycles':width+1,'added_cycles':0,'CSR_delay_byte_map':d.delay_map,'CSR_multiplier_address':d.mult_addr})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'frozen_source_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),
        'scope':'Complete original frozen Demodulate including real independent CSRBank vs speculative first rotation; all outputs/phase/config/read every cycle and independent exact first-step arithmetic. 14-bit allADC*4quadrants; 25-bit boundaries/random; all16mult,delaywrap/partialhotwrite/reset. No latency tolerance. Binary reachable inputs, no arbitrary X/Z equivalence claimed.'},indent=2))
    print('R77_DEMOD_SUITE_PASS',flush=True)
if __name__=='__main__':main()
