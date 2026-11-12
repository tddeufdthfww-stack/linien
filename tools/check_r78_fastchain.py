"""Whole production FastChain R72/R78 paired native UNISIM/CSR regression."""
from pathlib import Path
from types import SimpleNamespace
import argparse,json,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.chains import FastChain

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',required=True,type=Path)
    out=ap.parse_args().out.resolve();out.mkdir(parents=True,exist_ok=False)
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.ports={k:Signal((n,s),name_override=k) for k,n,s in [
                ('adc',14,True),('offset',14,True),('dy',25,True),('dx',25,True),
                ('phase',32,False),('ce',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]}
            p=self.ports;chains=[];maps=[]
            for name,fabric in [('reference',False),('candidate',True)]:
                c=FastChain(width=14,signal_width=25,coeff_width=25,
                    mod=SimpleNamespace(phase=p['phase']),offset_signal=p['offset'],
                    pre_offset_signal=p['offset'],iir_mac_impl='registered_c48',
                    parallel_output=True,iir_swap_final_operands=True,speculative_demod=True,early_common_limits=fabric)
                setattr(self.submodules,name,c)
                b=CSRBank(c.get_csrs());setattr(self.submodules,name+'_bank',b)
                self.comb += [c.adc.eq(p['adc']),c.signal_in[0].eq(p['dx']),c.signal_in[1].eq(p['dy']),
                    c.y_limit_1.update_en.eq(p['ce']),c.y_limit_2.update_en.eq(p['ce']),
                    b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
                values=[c.out_i,c.out_q,c.pre_out_i,c.out_i_update_en,b.bus.dat_r,
                    c.iir_c_1.error,c.iir_d_1.error,c.iir_c_2.error,c.iir_d_2.error]
                q=Signal(sum(len(v) for v in values),name_override=name+'_result')
                p[name+'_result']=q;self.comb += q.eq(Cat(*values))
                maps.append([(x.name,x.size) for x in b.simple_csrs]);chains.append(c)
            assert maps[0]==maps[1],maps
            self.mapping=maps[0];self.bits=len(p['reference_result'])
    d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='r78_chain_pair').write(str(out/'pair.v'))
    tb=f'''`timescale 1ns/1ps
module tb_r78_chain;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dx=0,dy=0;
reg [31:0] phase=0;reg ce=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{d.bits-1}:0] reference_result,candidate_result;
r78_chain_pair dut(.*);integer i,seed=730112,known=0,writes=0,holds=0,changes=0;
reg [{d.bits-1}:0] previous=0;
initial begin
 for(i=0;i<32000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==9001 || i==9002 || i==21017);
  adc=$random(seed);offset=$random(seed);dx=$random(seed);dy=$random(seed);phase=$random(seed);
  ce=((i%7)==0 || i<4000);csr_adr=(i<8000 ? (i/4)%{len(d.mapping)} : $unsigned($random(seed))%{len(d.mapping)});
  csr_we=(i>=24 && i%3!=0);csr_dat_w=(i<8000 ? i%256 : $random(seed));
  @(posedge sys_clk);#1;
  if(reference_result!==candidate_result)$fatal(1,"R78_FASTCHAIN_FAIL cycle=%0d ref=%h cand=%h",i,reference_result,candidate_result);
  if(i>=24 && (^candidate_result===1'bx))$fatal(1,"R78_FASTCHAIN_UNKNOWN cycle=%0d",i);
  if(i>=24)known=known+1;if(csr_we)writes=writes+1;if(!ce)holds=holds+1;
  if(candidate_result!==previous)changes=changes+1;previous=candidate_result;
 end
 if(known<31000 || writes<10000 || holds<10000 || changes<1000)$fatal(1,"coverage");
 $display("R78_WHOLE_FASTCHAIN_CSR_CE_PASS cycles=%0d known=%0d writes=%0d holds=%0d changes=%0d",i,known,writes,holds,changes);$finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
'''
    (out/'tb.sv').write_bytes(tb.encode());tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [
        ('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv',tool.parent/'data/verilog/src/glbl.v'],None),
        ('elaborate',[tool/'xelab.bat','tb_r78_chain','glbl','-L','unisims_ver','-s','tb_r78_chain','--timescale','1ns/1ps'],None),
        ('simulate',[tool/'xsim.bat','tb_r78_chain','-runall'],'R78_WHOLE_FASTCHAIN_CSR_CE_PASS')]:
        cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=out,capture_output=True)
        (out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
        text=(r.stdout+b'\n'+r.stderr).decode(errors='replace')
        ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
        (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2))
        print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
        if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
    (out/'results.json').write_text(json.dumps({'passed':True,'cycles':32000,'CSR_byte_map':d.mapping,
        'scope':'Identical FastChain defaults except explicit feedback state implementation; real DSP/FDRE UNISIM; both full independent CSRBank; all outputs/error/CSR read compared each edge, reset/CE/partial writes. No sample latency tolerance.'},indent=2))
    print('R78_FASTCHAIN_SUITE_PASS',flush=True)
if __name__=='__main__':main()
