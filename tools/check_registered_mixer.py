"""Native UNISIM DSP + real CSRBank + production LimitCSR FF differential."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,If,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.registered_error_mixer import MixerFactorCSR,RegisteredErrorMixer
from gateware.logic.limit import LimitCSR

def check_fastchain(out):
    from types import SimpleNamespace
    from gateware.logic.chains import FastChain
    class Wrapper(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.ports={k:Signal((n,s),name_override=k) for k,n,s in [('adc',14,True),('offset',14,True),('dy',25,True),('phase',32,False),('ce',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False),('pre',25,True),('y',25,True)]}
            p=self.ports
            self.submodules.chain=c=FastChain(mod=SimpleNamespace(phase=p['phase']),offset_signal=p['offset'])
            self.submodules.bank=b=CSRBank(c.get_csrs())
            self.comb += [c.adc.eq(p['adc']),c.signal_in[0].eq(0),c.signal_in[1].eq(p['dy']),c.y_limit_1.update_en.eq(p['ce']),p['pre'].eq(c.pre_out_i),p['y'].eq(c.out_i),b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
            self.addresses=len(b.simple_csrs)
    d=Wrapper();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='fastchain_pre_wrapper').write(str(out/'fastchain_pre.v'))
    tb=f'''`timescale 1ns/1ps
module tb_fastchain_pre;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] adc=0,offset=0;reg signed [24:0] dy=0;reg [31:0] phase=0;
reg ce=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire signed [24:0] pre,y;reg signed [24:0] expected=0,previous=0;
fastchain_pre_wrapper dut(.*);integer i,changes=0,hold=0;integer seed=20261110;
initial begin
 for(i=0;i<10000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==4003 || i==7007);adc=$random(seed);offset=$random(seed);dy=$random(seed);phase=$random(seed);
  ce=((i%5)==0 || i<2000);csr_adr=$unsigned($random(seed))%{d.addresses};csr_we=((i%17)==0);csr_dat_w=$random(seed);
  @(posedge sys_clk);if(sys_rst)expected=0;else if(ce)expected=pre;
  #1;if(y!==expected)$fatal(1,"FASTCHAIN_PRE_EXPORT_FAIL cycle=%0d pre=%h out=%h expected=%h",i,pre,y,expected);
  if(y!==previous)changes=changes+1;previous=y;if(!ce && !sys_rst)hold=hold+1;
 end
 if(changes<100 || hold<100)$fatal(1,"fastchain coverage changes=%0d hold=%0d",changes,hold);
 $display("FASTCHAIN_ORIGINAL_FF_PRE_EXPORT_PASS cycles=10000 changes=%0d hold=%0d",changes,hold);$finish;
end
endmodule
'''
    (out/'tb_fastchain_pre.sv').write_bytes(tb.encode());tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [('fc_compile',[tool/'xvlog.bat','--sv',out/'fastchain_pre.v',out/'tb_fastchain_pre.sv'],None),('fc_elaborate',[tool/'xelab.bat','tb_fastchain_pre','-s','tb_fastchain_pre','--timescale','1ns/1ps'],None),('fc_simulate',[tool/'xsim.bat','tb_fastchain_pre','-runall'],'FASTCHAIN_ORIGINAL_FF_PRE_EXPORT_PASS')]:
        cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
        text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
        (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
        if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--out',type=Path,required=True);args=parser.parse_args()
    out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.submodules.candidate=c=RegisteredErrorMixer()
            self.submodules.a_limit=la=LimitCSR(width=25,guard=3)
            self.submodules.b_limit=lb=LimitCSR(width=25,guard=3)
            fa,fb=MixerFactorCSR('factor_a'),MixerFactorCSR('factor_b')
            ra,rb=CSRStorage(9,reset=128,name='factor_a'),CSRStorage(9,reset=128,name='factor_b')
            self.submodules.cbank=cb=CSRBank([fa,fb]);self.submodules.rbank=rbk=CSRBank([ra,rb])
            self.ports={}
            for name,width,sgn in [('ax',28,True),('bx',28,True),('ce_a',1,False),('ce_b',1,False),('offset',14,True),('dual',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:
                self.ports[name]=Signal((width,sgn),name_override=name)
            p=self.ports
            self.comb += [la.x.eq(p['ax']),lb.x.eq(p['bx']),la.update_en.eq(p['ce_a']),lb.update_en.eq(p['ce_b']),
                c.a.eq(la.y),c.b.eq(lb.y),c.pre_a.eq(la.limit.y),c.pre_b.eq(lb.limit.y),c.ce_a.eq(la.update_en),c.ce_b.eq(lb.update_en),
                c.high_a.eq(fa.storage[8]),c.high_b.eq(fb.storage[8]),c.low_a.eq(fa.encoded_low_data),c.low_b.eq(fb.encoded_low_data),
                c.write_a.eq(fa.encoded_low_write),c.write_b.eq(fb.encoded_low_write),c.offset.eq(p['offset']),c.dual.eq(p['dual'])]
            # Real LimitCSR FF, with fixed full-range CSR bounds for this mixer test.
            self.comb += [la.min.storage.eq(1<<24),lb.min.storage.eq(1<<24),la.max.storage.eq((1<<24)-1),lb.max.storage.eq((1<<24)-1)]
            old=Signal((37,True));self.comb += If(p['dual'],old.eq(ra.storage*la.y+rb.storage*lb.y+(p['offset']<<19))).Else(old.eq((la.y<<8)+(p['offset']<<19)))
            for bank in (cb,rbk):self.comb += [bank.bus.adr.eq(p['csr_adr']),bank.bus.we.eq(p['csr_we']),bank.bus.dat_w.eq(p['csr_dat_w'])]
            for name,width,value in [('ref_mix',37,old),('cand_mix',37,c.y),('ref_read',8,rbk.bus.dat_r),('cand_read',8,cb.bus.dat_r),
                ('ref_cfg',18,Cat(ra.storage,rb.storage)),('cand_cfg',18,Cat(fa.storage,fb.storage)),('a_value',25,la.y),('b_value',25,lb.y)]:
                q=Signal(width,name_override=name);p[name]=q;self.comb += q.eq(value)
            assert [x.size for x in cb.simple_csrs]==[1,8,1,8]
    dut=Pair();verilog.convert(dut,ios=set(dut.ports.values())|{dut.cd_sys.clk,dut.cd_sys.rst},name='registered_mixer_pair').write(str(out/'pair.v'))
    rng=random.Random(2026111012);rows=[];coverage={'ce_a_hold':0,'ce_b_hold':0,'reset':0,'writes':0,'high_only':0,'low_only':0,'single':0,'dual':0}
    def emit(rst=0,ax=None,bx=None,ca=None,cb=None,off=None,dual=None,adr=None,we=None,data=None):
        ax=rng.randrange(-(1<<27),1<<27) if ax is None else ax;bx=rng.randrange(-(1<<27),1<<27) if bx is None else bx
        ca=rng.randrange(2) if ca is None else ca;cb=rng.randrange(2) if cb is None else cb;off=rng.randrange(-8192,8192) if off is None else off
        dual=rng.randrange(2) if dual is None else dual;adr=rng.randrange(4) if adr is None else adr;we=int(rng.random()<.7) if we is None else we;data=rng.randrange(256) if data is None else data
        rows.append([rst,ax&((1<<28)-1),bx&((1<<28)-1),ca,cb,off&16383,dual,adr,we,data])
        for k,n in [('ce_a_hold',1-ca),('ce_b_hold',1-cb),('reset',rst),('writes',we),('high_only',int(we and adr%2==0)),('low_only',int(we and adr%2==1)),('single',1-dual),('dual',dual)]:coverage[k]+=n
    for _ in range(24):emit(rst=1,we=0)
    edge=[-(1<<27),-(1<<24)-1,-(1<<24),-1,0,1,(1<<24)-1,1<<24,(1<<27)-1]
    # All 512 factors are actually written and observed, both high/low orders.
    for f in range(512):
        for adr,val in [(0,f>>8),(1,f&255),(3,(511-f)&255),(2,(511-f)>>8)]:emit(ax=edge[f%9],bx=edge[(f//9)%9],ca=1,cb=1,dual=1,adr=adr,we=1,data=val)
        for mode in (0,1):emit(ca=1,cb=1,dual=mode,we=0)
    for i in range(30000):
        emit(rst=int(i in (777,778,4091,17003)),ax=edge[i%9] if i<2000 else None,bx=edge[(i//9)%9] if i<2000 else None,
             ca=int(i%13==0) if 4000<i<8000 else None,cb=int(i%17==0) if 4000<i<8000 else None)
    (out/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
    tb=r'''`timescale 1ns/1ps
module tb_registered_mixer;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_rst=1;reg signed [27:0] ax=0,bx=0;reg ce_a=0,ce_b=0;reg signed [13:0] offset=0;reg dual=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [36:0] ref_mix,cand_mix;wire [7:0] ref_read,cand_read;wire [17:0] ref_cfg,cand_cfg;wire [24:0] a_value,b_value;
registered_mixer_pair dut(.*);
integer fd,n,cycles=0,known=0,lo_a=128,hi_a=0,lo_b=128,hi_b=0,read_expected=0;
reg [17:0] cfg_expected;reg signed [63:0] va,vb,fa,fb,ofs,result;reg [36:0] expected;
reg [511:0] seen_a=0,seen_b=0;
task check_result;
begin
 va=$signed(a_value);vb=$signed(b_value);fa=lo_a+256*hi_a;fb=lo_b+256*hi_b;ofs=$signed(offset);
 result=(dual ? fa*va+fb*vb : (va<<<8))+(ofs<<<19);expected=result[36:0];
 if(ref_mix!==expected || cand_mix!==expected)begin
 $display("DSP debug opport=%h inport=%h opin=%h inin=%h A=%h B=%h R=%b/%b CE=%b/%b qa=%h qb=%h mult=%h X=%h Y=%h Z=%h op=%h in=%h alu=%h P=%h",dut.DSP48E1.OPMODE,dut.DSP48E1.INMODE,dut.DSP48E1.opmode_in,dut.DSP48E1.inmode_in,dut.DSP48E1.A,dut.DSP48E1.B,dut.DSP48E1.RSTA,dut.DSP48E1.RSTB,dut.DSP48E1.CEA2,dut.DSP48E1.CEB2,dut.DSP48E1.qa_o_mux,dut.DSP48E1.qb_o_mux,dut.DSP48E1.qmult_o_mux,dut.DSP48E1.qx_o_mux,dut.DSP48E1.qy_o_mux,dut.DSP48E1.qz_o_mux,dut.DSP48E1.qopmode_o_mux,dut.DSP48E1.qinmode_o_mux,dut.DSP48E1.alu_o,dut.DSP48E1.P);
 $fatal(1,"MIXER_FAIL cycle=%0d old=%h new=%h expected=%h F=%d/%d X=%d/%d",cycles,ref_mix,cand_mix,expected,fa,fb,va,vb);end
 if((ref_mix>>>8)!==(cand_mix>>>8))$fatal(1,"shift mismatch");
end endtask
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h\n",sys_rst,ax,bx,ce_a,ce_b,offset,dual,csr_adr,csr_we,csr_dat_w);
  if(n!=10)$fatal(1,"bad vector");#1;
  if(cycles>=24)check_result();
  case(csr_adr) 0:read_expected=hi_a;1:read_expected=lo_a;2:read_expected=hi_b;3:read_expected=lo_b;endcase
  @(posedge sys_clk);
  if(sys_rst)begin lo_a=128;hi_a=0;lo_b=128;hi_b=0;read_expected=0;end
  else if(csr_we)case(csr_adr)0:hi_a=csr_dat_w&1;1:lo_a=csr_dat_w;2:hi_b=csr_dat_w&1;3:lo_b=csr_dat_w;endcase
  #1;cfg_expected={hi_b[0],lo_b[7:0],hi_a[0],lo_a[7:0]};
  if(ref_cfg!==cfg_expected || cand_cfg!==cfg_expected || ref_read!==read_expected[7:0] || cand_read!==read_expected[7:0])$fatal(1,"CSR_FAIL cycle=%0d cfg=%h/%h/%h read=%h/%h/%h",cycles,ref_cfg,cand_cfg,cfg_expected,ref_read,cand_read,read_expected[7:0]);
  if(cycles>=24)begin check_result();known=known+1;seen_a[lo_a+hi_a*256]=1;seen_b[lo_b+hi_b*256]=1;end
  cycles=cycles+1;
 end
 if(known<30000 || seen_a!=={512{1'b1}} || seen_b!=={512{1'b1}})$fatal(1,"coverage cycles=%0d known=%0d",cycles,known);
 $display("REGISTERED_MIXER_FULL37_CSR_CE_PASS cycles=%0d known=%0d factors=512/512",cycles,known);$finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
'''
    (out/'tb.sv').write_bytes(tb.encode());tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv',tool.parent/'data/verilog/src/glbl.v'],None),
        ('elaborate',[tool/'xelab.bat','tb_registered_mixer','glbl','-L','unisims_ver','-s','tb_registered_mixer','--timescale','1ns/1ps'],None),
        ('simulate',[tool/'xsim.bat','tb_registered_mixer','-runall'],'REGISTERED_MIXER_FULL37_CSR_CE_PASS')]:
        cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
        text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
        (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode())
        print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
        if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
    (out/'results.json').write_bytes(json.dumps({'passed':True,'cycles':len(rows),'coverage':coverage,'scope':'Real DSP48E1 UNISIM+glbl, CSRBank, production LimitCSR output FF; combinational oracle pre/post edge; no added sample stage.'},indent=2).encode())
    check_fastchain(out)
    print('REGISTERED_MIXER_SUITE_PASS',flush=True)
if __name__=='__main__':main()
