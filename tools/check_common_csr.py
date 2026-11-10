"""Full intermediate common word vs original FFs and true-CSR integer oracle."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import ClockDomain,Module,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.same_edge_common import same_edge_common

def signed(v,n):
 v&=(1<<n)-1;return v-(1<<n) if v&(1<<(n-1)) else v

def main():
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 results=[];tool=Path('D:/Xilinx/Vivado/2020.1/bin')
 for width in (14,25):
  shift=11;dw=width+shift;n=width+4;sub=out/str(width);sub.mkdir()
  class Pair(Module):
   def __init__(self):
    self.clock_domains.cd_sys=ClockDomain('sys');self.offset=CSRStorage(width,name='offset');assert not self.offset.storage.signed
    self.submodules.bank=b=CSRBank([self.offset]);self.ports={}
    for k,bits,sgn in [('dy',dw,True),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:self.ports[k]=Signal((bits,sgn),name_override=k)
    p=self.ports;ya=Signal((width+3,True));old_offset=Signal((width,True))
    self.sync += [ya.eq(p['dy']>>shift),old_offset.eq(self.offset.storage)]
    q=same_edge_common(self,p['dy'],self.offset.storage,width,shift)
    for k,bits,val in [('old_word',n,ya+old_offset),('new_word',n,q),('cfg',width,self.offset.storage),('csr_read',8,b.bus.dat_r)]:
     sig=Signal(bits,name_override=k);self.ports[k]=sig;self.comb += sig.eq(val)
    self.comb += [b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
    pos=width;self.byte_map={}
    for sc in self.offset.simple_csrs:
     pos-=sc.size;self.byte_map[b.simple_csrs.index(sc)]=(pos,sc.size)
  d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='common_csr_pair').write(str(sub/'pair.v'))
  rows=[];storage=0;rng=random.Random(2026111025+width);stats={'writes':0,'negative_offsets':0,'positive_common':0,'negative_common':0,'resets':0}
  def emit(dy=None,rst=0,adr=None,we=0,data=None):
   nonlocal storage
   dy=signed(rng.getrandbits(dw),dw) if dy is None else dy
   adr=rng.choice(list(d.byte_map)) if adr is None else adr;data=rng.randrange(256) if data is None else data
   pos,bits=d.byte_map[adr];mask=(1<<bits)-1;read=(storage>>pos)&mask
   before=signed(storage,width);expected=(dy>>shift)+before
   if rst:storage=0;expected=0;read=0
   elif we:storage=(storage&~(mask<<pos))|((data&mask)<<pos)
   rows.append([rst,dy&((1<<dw)-1),adr,we,data,expected&((1<<n)-1),storage,read])
   for k,v in [('writes',we),('negative_offsets',int(before<0)),('positive_common',int(expected>0)),('negative_common',int(expected<0)),('resets',rst)]:stats[k]+=v
  for _ in range(8):emit(rst=1)
  for value in [0,-1,1,-(1<<(width-1)),(1<<(width-1))-1,-123,123]:
   for order in (list(d.byte_map),list(reversed(d.byte_map))):
    for adr in order:
     pos,bits=d.byte_map[adr];emit(adr=adr,we=1,data=(value>>pos)&((1<<bits)-1),dy=0)
    for x in [0,-1,1,-(1<<(dw-1)),(1<<(dw-1))-1]:emit(dy=x)
  for i in range(30000):emit(rst=int(i in (1101,1102,9007,20001)),we=int(i%2==0))
  assert stats['negative_offsets']>1000 and stats['negative_common']>1000 and stats['positive_common']>1000
  (sub/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
  (sub/'tb.sv').write_bytes(f'''`timescale 1ns/1ps
module tb_common_csr;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [{dw-1}:0] dy=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{n-1}:0] old_word,new_word;wire [{width-1}:0] cfg;wire [7:0] csr_read;
reg [{n-1}:0] expected;reg [{width-1}:0] expected_cfg;reg [7:0] expected_read;integer fd,k,count=0;
common_csr_pair dut(.*);
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h\\n",sys_rst,dy,csr_adr,csr_we,csr_dat_w,expected,expected_cfg,expected_read);if(k!=8)$fatal(1,"bad vector");
  @(posedge sys_clk);#1;
  if(old_word!==expected || new_word!==expected || cfg!==expected_cfg || csr_read!==expected_read)$fatal(1,"COMMON_CSR_FAIL W={width} cycle=%0d old=%h new=%h expected=%h cfg=%h/%h read=%h/%h",count,old_word,new_word,expected,cfg,expected_cfg,csr_read,expected_read);
  count=count+1;
 end
 $display("COMMON_CSR_FULL_WORD_PASS width={width} cycles=%0d",count);$finish;
end
endmodule
'''.encode())
  for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_common_csr','-s','tb_common_csr','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_common_csr','-runall'],f'COMMON_CSR_FULL_WORD_PASS width={width}')]:
   cmd=[str(v) for v in cmd];res=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(res.stdout);(sub/(label+'.stderr.log')).write_bytes(res.stderr)
   txt=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in txt) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',txt)
   (sub/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2).encode());print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,txt[-6000:]
   if marker:print(re.search(marker+r'[^\r\n]*',txt)[0],flush=True)
  results.append({'width':width,'stats':stats,'cycles':len(rows),'CSR_bytes':d.byte_map})
 (out/'results.json').write_bytes(json.dumps({'passed':True,'results':results,'scope':'Actual production helper with unsigned CSRStorage plus original signed shadow/ya FFs and independent integer oracle; entire common word before clipping, partial byte writes both orders/readback/reset, no extra cycles.'},indent=2).encode())
 print('COMMON_CSR_SUITE_PASS',flush=True)
if __name__=='__main__':main()
