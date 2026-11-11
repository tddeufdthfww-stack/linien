"""Complete 50-bit MAC vs frozen R48 helper, integer oracle and partial X/Z."""
from pathlib import Path
import argparse,hashlib,importlib.util,itertools,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Module,Signal
from migen.fhdl import verilog
from gateware.logic.iir_c48_mac import split_c48_mac
def main():
 p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
 frozen=ROOT/'gateware/tests/timing/reference/r48_iir_c48_mac.py'
 spec=importlib.util.spec_from_file_location('gateware.logic.r48_c48_frozen',frozen);old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
 class Pair(Module):
  def __init__(self):
   self.x=Signal((25,True),name_override='x');self.c=Signal((25,True),name_override='c');self.z=Signal((50,True),name_override='z')
   self.ref=Signal((50,True),name_override='ref_y');self.new=Signal((50,True),name_override='new_y')
   self.comb += [self.ref.eq(old.split_c48_mac(self,self.z,self.x,self.c)),self.new.eq(split_c48_mac(self,self.z,self.x,self.c))]
 d=Pair();verilog.convert(d,ios={d.x,d.c,d.z,d.ref,d.new},name='carry_fold_pair').write(str(out/'pair.v'))
 rng=random.Random(2026111152);rows=[];known=0
 def bits(v,n):return format(v&((1<<n)-1),'0'+str(n)+'b')
 for x,c,z in itertools.product([-(1<<24),-(1<<24)+1,-131072,-1,0,1,131071,(1<<24)-1],[-(1<<24),-1,0,1,(1<<24)-1],[-(1<<49),-(1<<49)+1,-(1<<47),-1,0,1,(1<<47)-1,(1<<49)-1]):
  rows.append([bits(x,25),bits(c,25),bits(z,50),'1',bits(z+x*c,50)]);known+=1
 for _ in range(8):
  seed=[bits(rng.getrandbits(n),n) for n in (25,25,50)]
  for field,n in enumerate((25,25,50)):
   for bit in range(n):
    for v in ('x','z'):
     case=seed.copy();s=list(case[field]);s[bit]=v;case[field]=''.join(s);rows.append(case+['0','0'*50])
 for field,n in enumerate((25,25,50)):
  for v in ('x','z'):
   case=['0'*25,'0'*25,'0'*50];case[field]=v*n;rows.append(case+['0','0'*50])
 for _ in range(3000):
  case=[]
  for n in (25,25,50):
   s=list(bits(rng.getrandbits(n),n))
   for bit in range(n):
    if rng.randrange(9)==0:s[bit]=rng.choice(('x','z'))
   case.append(''.join(s))
  rows.append(case+['0','0'*50])
 (out/'vectors.txt').write_text('\n'.join(' '.join(v) for v in rows)+'\n',encoding='ascii')
 tb='''`timescale 1ns/1ps
module tb_carry_fold;
reg signed [24:0] x,c;reg signed [49:0] z;wire [49:0] ref_y,new_y;reg [49:0] expected;reg known;
carry_fold_pair dut(.*);integer fd,k,count=0,known_count=0,unknown_count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%b %b %b %b %b\\n",x,c,z,known,expected);if(k!=5)$fatal(1,"bad vector");#1;
  if(ref_y!==new_y)$fatal(1,"CARRY_FOLD_FROZEN_XZ_FAIL n=%0d x=%b c=%b z=%b ref=%b new=%b",count,x,c,z,ref_y,new_y);
  if(known && (ref_y!==expected || new_y!==expected))$fatal(1,"CARRY_FOLD_INTEGER_FAIL n=%0d",count);
  count=count+1;if(known)known_count=known_count+1;else unknown_count=unknown_count+1;
 end
 if(known_count!=320 || unknown_count!=4606)$fatal(1,"coverage");
 $display("CARRY_FOLD_FULL50_FROZEN_INTEGER_XZ_PASS known=%0d unknown=%0d",known_count,unknown_count);$finish;
end
endmodule
'''
 (out/'tb.sv').write_text(tb,encoding='ascii');tool=Path('D:/Xilinx/Vivado/2020.1/bin')
 for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_carry_fold','-s','tb_carry_fold','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_carry_fold','-runall'],'CARRY_FOLD_FULL50_FROZEN_INTEGER_XZ_PASS')]:
  cmd=[str(v) for v in cmd];res=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(res.stdout);(out/(label+'.stderr.log')).write_bytes(res.stderr)
  text=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
  (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
  if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
 rec={'passed':True,'known_integer_cases':known,'partial_X_Z_cases':len(rows)-known,'strict_full50_frozen_helper_comparison':True,'frozen_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),'scope':'Generated combinational full50 MAC RTL vs unchanged R48 helper with strict case equality and known integer oracle. Standalone sign predicate is not claimed four-state equivalent; checks actual reachable MAC outputs. Not synthesized/SDF/formal/wholeRoot or physical CDC proof.'}
 (out/'results.json').write_text(json.dumps(rec,indent=2),encoding='utf-8');print('C48_CARRY_FOLD_SUITE_PASS',flush=True)
if __name__=='__main__':main()
