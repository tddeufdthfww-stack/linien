"""Real CSRBank pair plus independent signed64 threshold/clamp edge oracle."""
from pathlib import Path
import argparse,json,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.parallel_tap_limit import ParallelTapLimitCSR
from gateware.logic.early_common_tap_limit import EarlyCommonTapLimitCSR

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True)
    out=p.parse_args().out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for width,aw in [(14,10),(25,14)]:
        n=width+3;shift=width-aw;sub=out/str(width);sub.mkdir()
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys')
                self.ports={k:Signal((v,s),name_override=k) for k,v,s in [
                    ('dx',aw,True),('offset',aw,True),('t0',width,True),('t1',width,True),('t2',width,True),
                    ('ce',1,False),('sel',2,False),('inv',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]}
                p=self.ports
                self.submodules.reference=r=ParallelTapLimitCSR(width=width,guard=3)
                self.submodules.candidate=c=EarlyCommonTapLimitCSR(width=width,guard=3,input_width=aw)
                self.submodules.reference_bank=rb=CSRBank(r.get_csrs());self.submodules.candidate_bank=cb=CSRBank(c.get_csrs())
                assert [(v.name,v.size) for v in rb.simple_csrs]==[(v.name,v.size) for v in cb.simple_csrs]
                old_common=Signal((aw+4,True));self.sync += old_common.eq(p['dx']+p['offset'])
                self.comb += [r.common_a.eq(old_common<<shift),r.common_b.eq(0),c.common_x.eq(p['dx']),c.common_offset.eq(p['offset'])]
                for d,b in [(r,rb),(c,cb)]:
                    self.comb += [d.update_en.eq(p['ce']),d.tap_select.eq(p['sel']),d.invert.eq(p['inv']),
                        b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
                    self.comb += [t.eq(p['t'+str(i)]) for i,t in enumerate(d.taps)]
                for prefix,d,b,common in [('ref',r,rb,old_common),('cand',c,cb,c.common_reg)]:
                    for key,bits,value in [('y',width,d.y),('error',1,d.error),('pre',n,d.pre_y),('rail',1,d.pre_rail),
                        ('lo',n,d.bound_min),('hi',n,d.bound_max),('neg_lo',n,d.neg_bound_min),('neg_hi',n,d.neg_bound_max),
                        ('common',aw+4,common),('read',8,b.bus.dat_r),('cfg',2*width,Cat(d.min.storage,d.max.storage))]:
                        q=Signal(bits,name_override=prefix+'_'+key);p[prefix+'_'+key]=q;self.comb += q.eq(value)
                for key,v in [('thr_lo',c.threshold_min),('thr_hi',c.threshold_max),('thr_neg_hi',c.threshold_neg_max),('thr_neg_lo',c.threshold_neg_min)]:
                    q=Signal(n,name_override=key);p[key]=q;self.comb += q.eq(v)
                self.byte_map=[]
                for key,csr in [('min',c.min),('max',c.max)]:
                    pos=csr.size
                    for sc in csr.simple_csrs:pos-=sc.size;self.byte_map.append((key,cb.simple_csrs.index(sc),pos,sc.size))
                self.addresses=len(cb.simple_csrs)
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='r78_limit_pair').write(str(sub/'pair.v'))
        writes=[]
        for start,lo,hi in [(24,-100,100),(500,100,-100),(1000,0,0),(1500,-(1<<(width-1)),(1<<(width-1))-1)]:
            for i,(key,adr,pos,bits) in enumerate(d.byte_map):
                value=lo if key=='min' else hi;writes.append(f'{start+i}: begin csr_adr={adr};csr_we=1;csr_dat_w=8\'h{((value>>pos)&((1<<bits)-1)):02x};end')
        cases='\n'.join(writes)
        tb=f'''`timescale 1ns/1ps
module tb_r78_limit;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [{aw-1}:0] dx=0,offset=0;reg signed [{width-1}:0] t0=0,t1=0,t2=0;
reg ce=1,inv=0;reg [1:0] sel=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{width-1}:0] ref_y,cand_y;wire ref_error,cand_error,ref_rail,cand_rail;
wire [{n-1}:0] ref_pre,cand_pre,ref_lo,cand_lo,ref_hi,cand_hi,ref_neg_lo,cand_neg_lo,ref_neg_hi,cand_neg_hi;
wire [{n-1}:0] thr_lo,thr_hi,thr_neg_lo,thr_neg_hi;wire [{aw+3}:0] ref_common,cand_common;
wire [7:0] ref_read,cand_read;wire [{2*width-1}:0] ref_cfg,cand_cfg;
r78_limit_pair dut(.*);
reg signed [63:0] com,lo,hi,tap,total,oracle,theta,desired,desired_tap;
reg rail;reg [{width-1}:0] expected_y=0;reg expected_error=0;
integer i,seed=780112+{width},holds=0,writes=0,held_writes=0,reversed=0,equal_bounds=0,boundary=0,changes=0;
reg [{width-1}:0] previous=0;
task check_pre;
begin
 com=$signed(cand_common);com=com<<<{shift};lo=$signed(cand_lo);hi=$signed(cand_hi);
 case(sel)0:tap=$signed(t0);1:tap=$signed(t1);default:tap=$signed(t2);endcase
 total=tap+com;if(inv)total=-total;
 if(total>=hi)begin oracle=hi;rail=1;end else if(total<=lo)begin oracle=lo;rail=1;end else begin oracle=total;rail=0;end
 if(ref_pre!==oracle[{n-1}:0] || cand_pre!==oracle[{n-1}:0] || ref_rail!==rail || cand_rail!==rail)
  $fatal(1,"R78_PRE_ORACLE_FAIL W={width} cycle=%0d pre=%h/%h expected=%h lo=%d hi=%d c=%d t=%d inv=%b",i,ref_pre,cand_pre,oracle,lo,hi,com,tap,inv);
 theta=lo-com;if(thr_lo!==theta[{n-1}:0])$fatal(1,"threshold low mismatch");
 theta=hi-com;if(thr_hi!==theta[{n-1}:0])$fatal(1,"threshold high mismatch");
 theta=-hi-com;if(thr_neg_hi!==theta[{n-1}:0])$fatal(1,"negative high threshold mismatch");
 theta=-lo-com;if(thr_neg_lo!==theta[{n-1}:0])$fatal(1,"negative low threshold mismatch");
end endtask
initial begin
 for(i=0;i<36000;i=i+1)begin
  @(negedge sys_clk);sys_rst=(i<24 || i==9013 || i==9014 || i==17007);
  dx=(i<2000?0:$random(seed));offset=(i<2000?0:$random(seed));
  t0=$random(seed);t1=$random(seed);t2=$random(seed);ce=(i<2000 || i%11==0);sel=i%4;inv=(i/4)%2;
  csr_we=0;csr_adr=0;csr_dat_w=0;
  if(i>=2000)begin csr_adr=$unsigned($random(seed))%{d.addresses};csr_we=(i%3==0);csr_dat_w=$random(seed);end
  case(i)
{cases}
  endcase
  if(i>=40 && i<2000)begin
   desired=(i%6<3 ? $signed(ref_lo):$signed(ref_hi));desired=desired+(i%3)-1;
   if(inv)desired=-desired;com=$signed(ref_common);com=com<<<{shift};desired_tap=desired-com;
   if(desired_tap>=-{1<<(width-1)} && desired_tap<={((1<<(width-1))-1)})begin t0=desired_tap;t1=desired_tap;t2=desired_tap;boundary=boundary+1;end
  end
  #1;check_pre();
  if(sys_rst)begin expected_y=0;expected_error=0;end
  else if(ce)begin expected_y=oracle[{width-1}:0];expected_error=rail;end
  @(posedge sys_clk);#1;check_pre();
  if(ref_y!==expected_y || cand_y!==expected_y || ref_error!==expected_error || cand_error!==expected_error)
   $fatal(1,"R78_OUTPUT_CE_FAIL W={width} cycle=%0d y=%h/%h expected=%h",i,ref_y,cand_y,expected_y);
  if({{ref_lo,ref_hi,ref_neg_lo,ref_neg_hi,ref_common,ref_read,ref_cfg}}!=={{cand_lo,cand_hi,cand_neg_lo,cand_neg_hi,cand_common,cand_read,cand_cfg}})
   $fatal(1,"R78_CSR_STATE_FAIL cycle=%0d",i);
  if((^{{cand_y,cand_pre,cand_read,cand_cfg}})===1'bx)$fatal(1,"unknown outputs");
  if(!ce)holds=holds+1;if(csr_we)writes=writes+1;if(csr_we&&!ce)held_writes=held_writes+1;
  if(lo>hi)reversed=reversed+1;if(lo==hi)equal_bounds=equal_bounds+1;
  if(cand_y!==previous)changes=changes+1;previous=cand_y;
 end
 if(holds<10000 || held_writes<1000 || reversed<100 || equal_bounds<100 || boundary<1000 || changes<1000)$fatal(1,"coverage");
 $display("R78_EARLY_LIMIT_PASS width={width} cycles=%0d writes=%0d ce0_writes=%0d holds=%0d reversed=%0d equal=%0d boundary=%0d changes=%0d",i,writes,held_writes,holds,reversed,equal_bounds,boundary,changes);$finish;
end
initial begin #500000;$fatal(1,"timeout");end
endmodule
'''
        (sub/'tb.sv').write_bytes(tb.encode())
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),
          ('elaborate',[tool/'xelab.bat','tb_r78_limit','-s','tb_r78_limit','--timescale','1ns/1ps'],None),
          ('simulate',[tool/'xsim.bat','tb_r78_limit','-runall'],f'R78_EARLY_LIMIT_PASS width={width}')]:
            cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=sub,capture_output=True)
            (sub/(label+'.stdout.log')).write_bytes(r.stdout);(sub/(label+'.stderr.log')).write_bytes(r.stderr)
            text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2))
            print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'width':width,'input_width':aw,'cycles':36000,'CSR_byte_map':d.byte_map,'passed':True})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,
      'scope':'Actual old ParallelTapLimit and new EarlyCommon pair, independent real CSR banks; signed64 threshold/current common/clamp oracle before and after edges; all y/error/pre/bounds/config/read; CE0 hot writes/reversed/equal/positive-negative boundaries/reset/selector3. No sample delay tolerance; narrow D/O domain is a hardware interface guarantee.'},indent=2))
    print('R78_EARLY_LIMIT_SUITE_PASS',flush=True)
if __name__=='__main__':main()
