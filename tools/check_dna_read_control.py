"""Actual new/frozen DNA, nonzero UNISIM DNA patterns, reset and READ invariant."""
from pathlib import Path
import argparse,importlib.util,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Module,ClockDomain,Signal,Instance,Constant
from migen.fhdl import verilog
from gateware.lowlevel.dna import DNA
def main():
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 spec=importlib.util.spec_from_file_location('r60_frozen_dna',ROOT/'gateware/tests/timing/reference/r60_dna.py');ref=importlib.util.module_from_spec(spec);spec.loader.exec_module(ref)
 rng=random.Random(2026111161);cnt=0;read=1;resets=0
 for i in range(50000):
  rst=i<3 or rng.randrange(101)==0;resets+=int(rst)
  if rst:cnt,read=0,1
  else:read=0 if cnt&1 else read;cnt=min(cnt+1,128)
  assert read==int(cnt<2),(i,cnt,read)
 patterns=(0,(1<<57)-1,0x1123456789abcde,0x0edcba987654321)
 class Pair(Module):
  def __init__(self):
   self.clock_domains.cd_sys=ClockDomain('sys');self.ports={}
   for i,pattern in enumerate(patterns):
    old=ref.DNA();new=DNA();setattr(self.submodules,'old'+str(i),old);setattr(self.submodules,'new'+str(i),new)
    for label,d in [('old',old),('new',new)]:
     inst=next(v for v in d._fragment.specials if isinstance(v,Instance));inst.items.append(Instance.Parameter('SIM_DNA_VALUE',Constant(pattern,57)))
     ins={v.name:v.expr for v in inst.items if isinstance(v,Instance.Input)}
     for suffix,size,value in [('status',64,d.dna.status),('read',1,ins['READ'])]+([('count',8,ins['CLK'].value)] if label=='new' else []):
      name=label+str(i)+'_'+suffix;s=Signal(size,name_override=name);self.ports[name]=s;self.comb+=s.eq(value)
 d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='dna_pair').write(str(out/'pair.v'))
 decl='\n'.join('wire ['+str(len(s)-1)+':0] '+name+';' for name,s in d.ports.items())
 checks='\n'.join(f'if(old{i}_status!==new{i}_status || old{i}_read!==new{i}_read || new{i}_read!==(new{i}_count<2))$fatal(1,"DNA_MISMATCH pattern={i} cycle=%0d old=%h new=%h count=%d",k,old{i}_status,new{i}_status,new{i}_count);' for i in range(len(patterns)))
 tb=f'''`timescale 1ns/1ps
module tb_dna_pair;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;integer k;
{decl}
dna_pair dut(.*);
initial begin
for(k=0;k<4096;k=k+1)begin
 @(negedge sys_clk);sys_rst=(k<4 || k%211==0 || k%211==1 || k%617==123);
 @(posedge sys_clk);#1;{checks}
end
$display("R61_DNA_READ_CONTROL_NATIVE_PASS cycles=4096 patterns=4");$finish;
end
endmodule
''';(out/'tb.sv').write_bytes(tb.encode())
 tool=Path('D:/Xilinx/Vivado/2020.1/bin');commands=[('compile',[tool/'xvlog.bat','--sv',tool.parent/'data/verilog/src/glbl.v',out/'pair.v',out/'tb.sv']),('elaborate',[tool/'xelab.bat','-L','unisims_ver','tb_dna_pair','glbl','--timescale','1ns/1ps','-s','dna_pair']),('simulate',[tool/'xsim.bat','dna_pair','-runall'])]
 for label,cmd in commands:
  cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(res.stdout);(out/(label+'.stderr.log')).write_bytes(res.stderr);s=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',s) and (label!='simulate' or 'R61_DNA_READ_CONTROL_NATIVE_PASS' in s);(out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2));assert ok,s[-5000:];print(label,'PASS',flush=True)
 (out/'results.json').write_text(json.dumps({'passed':True,'invariant_known_cycles':50000,'invariant_reset_cycles':resets,'native_cycles':4096,'native_patterns':patterns,'checked_full_64bit_snapshots':4096*len(patterns),'new_serial_feedback_cycles':0,'scope':'Actual production DNA and frozen R60 DNA plus installed UNISIM DNA_PORT. All status bits, READ pin and count invariant each sys edge; reset during/after shifts. Known reachable digital state equivalence, not SDF/board proof.'},indent=2));print('DNA_READ_CONTROL_SUITE_PASS',flush=True)
if __name__=='__main__':main()
