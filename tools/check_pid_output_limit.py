"""Production saturation helper vs original Migen comparator and integer oracle."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import ClockDomain,If,Module,Signal
from migen.fhdl import verilog
from gateware.logic.pid_output_limit import pid_output_limit

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for w,n in ((2,5),(3,6),(4,7),(14,51),(25,84)):
        sub=out/str(w);sub.mkdir();upper=(1<<(w-1))-1;lower=-(1<<(w-1));mask=(1<<n)-1
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys');self.x=Signal((n,True),name_override='x');self.old=Signal((w,True),name_override='old_y');self.new=Signal((w,True),name_override='new_y')
                self.comb += If(self.x>upper,self.old.eq(upper)).Elif(self.x<lower,self.old.eq(lower)).Else(self.old.eq(self.x[:w]))
                pid_output_limit(self,self.x,self.new)
        d=Pair();verilog.convert(d,ios={d.x,d.old,d.new},name='pid_output_pair').write(str(sub/'pair.v'))
        if n<=7:vals=list(range(-(1<<(n-1)),1<<(n-1)))
        else:
            vals=[lower-2,lower-1,lower,lower+1,-1,0,1,upper-1,upper,upper+1,upper+2,-(1<<(n-1)),(1<<(n-1))-1]
            for b in range(n):
                for v in (1<<b,-(1<<b),upper^(1<<b),lower^(1<<b)):
                    v&=mask;vals.append(v-(1<<n) if v>>(n-1) else v)
            rng=random.Random(2026111028+w)
            for _ in range(40000):
                v=rng.getrandbits(n);vals.append(v-(1<<n) if v>>(n-1) else v)
                vals.append(rng.randint(lower,upper))
        stats={'upper':sum(v>upper for v in vals),'lower':sum(v<lower for v in vals),'inside':sum(lower<=v<=upper for v in vals)}
        rows=[(v&mask,min(upper,max(lower,v))&((1<<w)-1)) for v in vals]
        (sub/'vectors.txt').write_text('\n'.join(f'{x:x} {y:x}' for x,y in rows)+'\n',encoding='ascii')
        (sub/'tb.sv').write_text(f'''`timescale 1ns/1ps
module tb_pid_output;
reg signed [{n-1}:0] x;wire signed [{w-1}:0] old_y,new_y;reg [{w-1}:0] expected;
integer fd,k,count=0;pid_output_pair dut(.*);
initial begin
fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
while(!$feof(fd))begin
k=$fscanf(fd,"%h %h\\n",x,expected);if(k!=2)$fatal(1,"bad vector");#1;
if(old_y!==expected || new_y!==expected)$fatal(1,"PID_OUTPUT_FAIL W={w} case=%0d x=%h old=%h new=%h expected=%h",count,x,old_y,new_y,expected);
count=count+1;
end
$display("PID_OUTPUT_LIMIT_PASS width={w} sum_width={n} cases=%0d",count);$finish;
end
endmodule
''',encoding='ascii')
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_pid_output','-s','tb_pid_output','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_pid_output','-runall'],f'PID_OUTPUT_LIMIT_PASS width={w} ')]:
            cmd=list(map(str,cmd));p=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(p.stdout);(sub/(label+'.stderr.log')).write_bytes(p.stderr)
            text=(p.stdout+b'\n'+p.stderr).decode(errors='replace');ok=p.returncode==0 and(not marker or marker in text)and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':p.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(w,label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'width':w,'sum_width':n,'cases':len(rows),'stats':stats,'passed':True})
    (out/'results.json').write_text(json.dumps({'passed':True,'scope':'Known finite signed bit-patterns, original comparator vs production helper vs independent integer clamp; full 51/84-bit inputs and target boundaries. No new state. Full PID/CSR/reset/CE separately in trial regressions; not physical signoff.','results':results},indent=2),encoding='utf-8')
    print('PID_OUTPUT_LIMIT_SUITE_PASS',flush=True)
if __name__=='__main__':main()
