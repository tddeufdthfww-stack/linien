from pathlib import Path
import argparse,datetime,json,random,re,subprocess,sys
p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);args=p.parse_args()
root=Path(__file__).resolve().parents[1];sys.path[:0]=[str(root),str(root/'linien-common')]
from migen import If,Module,Signal
from migen.fhdl import verilog
from gateware.logic.abs_threshold import signed_abs_over_threshold
out=args.out.resolve();out.mkdir(parents=True,exist_ok=False);results=[]
def signed(v,n):
 v&=(1<<n)-1;return v-(1<<n) if v&(1<<(n-1)) else v
tool=Path('D:/Xilinx/Vivado/2020.1/bin')
for n in (5,14,25,29):
 m=n-1;sub=out/str(n);sub.mkdir()
 class Pair(Module):
  def __init__(self):
   self.value=Signal((n,True),name_override='value');self.threshold=Signal((m,True),name_override='threshold')
   self.old=Signal(name_override='old_result');self.new=Signal(name_override='new_result')
   magnitude=Signal.like(self.value);extended=Signal.like(self.value);negative=Signal.like(self.value)
   self.comb += [If(self.value>=0,magnitude.eq(self.value)).Else(magnitude.eq(-1*self.value)),
      self.old.eq(magnitude>=self.threshold),extended.eq(self.threshold),negative.eq(-extended)]
   signed_abs_over_threshold(self,self.value,self.threshold,negative,self.new)
 d=Pair();verilog.convert(d,ios={d.value,d.threshold,d.old,d.new},name='abs_predicate_pair').write(str(sub/'pair.v'))
 rng=random.Random(2026111024+n)
 if n==5:values=[(s,t) for s in range(-(1<<(n-1)),1<<(n-1)) for t in range(-(1<<(m-1)),1<<(m-1))]
 else:
  es=[-(1<<(n-1)),-(1<<(n-1))+1,-(1<<(m-1))-1,-(1<<(m-1)),-1,0,1,(1<<(m-1))-1,1<<(m-1),(1<<(n-1))-1]
  et=[-(1<<(m-1)),-(1<<(m-1))+1,-1,0,1,(1<<(m-1))-1]
  values=[(s,t) for s in es for t in et]
  for _ in range(30000):values.append((signed(rng.getrandbits(n),n),signed(rng.getrandbits(m),m)))
  for t in et:
   for s in (t-1,t,t+1,-t-1,-t,-t+1):values.append((signed(s,n),t))
 rows=[]
 for s,t in values:rows.append([s&((1<<n)-1),t&((1<<m)-1),int(signed(abs(s),n)>=t)])
 (sub/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
 (sub/'tb.sv').write_bytes(f'''`timescale 1ns/1ps
module tb_abs_predicate;
reg signed [{n-1}:0] value;reg signed [{m-1}:0] threshold;wire old_result,new_result;reg expected;
abs_predicate_pair dut(.*);integer fd,k,count=0,i;integer seed=2026111024;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  k=$fscanf(fd,"%h %h %h\\n",value,threshold,expected);if(k!=3)$fatal(1,"bad vector");#1;
  if(old_result!==expected || new_result!==expected)$fatal(1,"ABS_PREDICATE_FAIL N={n} cycle=%0d value=%h threshold=%h old=%b new=%b expected=%b",count,value,threshold,old_result,new_result,expected);
  count=count+1;
 end
 for(i=0;i<2000;i=i+1)begin
  value=$random(seed);threshold=$random(seed);
  case(i%4)
   0:begin value={n}'h{1<<(n-1):x};threshold[0]=1'bx;end
   1:value[i%{n}]=1'bx;
   2:threshold[i%{m}]=1'bx;
   3:begin value[i%{n}]=1'bx;threshold[i%{m}]=1'bx;end
  endcase
  #1;if(old_result!==new_result)$fatal(1,"ABS_PREDICATE_X_FAIL N={n} case=%0d value=%h threshold=%h old=%b new=%b",i,value,threshold,old_result,new_result);
 end
 $display("ABS_PREDICATE_FULL_PASS N={n} M={m} cases=%0d unknown_cases=2000",count);$finish;
end
endmodule
'''.encode())
 for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_abs_predicate','-s','tb_abs_predicate','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_abs_predicate','-runall'],f'ABS_PREDICATE_FULL_PASS N={n}')]:
  cmd=[str(v) for v in cmd];r=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(r.stdout);(sub/(label+'.stderr.log')).write_bytes(r.stderr)
  text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
  (sub/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(n,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
  if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
 results.append({'N':n,'M':m,'cases':len(values),'unknown_cases':2000,'exhaustive':n==5})
(out/'results.json').write_bytes(json.dumps({'passed':True,'results':results,'scope':'Native combinational helper; native finite-width original abs RTL plus independent signed integer oracle. Does not prove CSR cohort integration or physical timing.'},indent=2).encode())
print('ABS_PREDICATE_SUITE_PASS',out,flush=True)
