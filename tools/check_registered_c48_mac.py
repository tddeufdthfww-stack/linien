from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import ClockDomain,Module,Signal
from migen.fhdl import verilog
from gateware.logic.iir_registered_c48 import registered_c48_mac
def signed(v,n):
    v&=(1<<n)-1
    return v-(1<<n) if v&(1<<(n-1)) else v
def main():
    p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain("sys")
            self.x=Signal((25,True),name_override='x');self.c=Signal((25,True),name_override='c');self.z=Signal((50,True),name_override='z')
            self.old_y=Signal((50,True),name_override='old_y');self.new_y=Signal((50,True),name_override='new_y')
            self.sync += self.old_y.eq(self.z+self.x*self.c)
            self.comb += self.new_y.eq(registered_c48_mac(self,self.z,self.x,self.c))
    d=Pair();verilog.convert(d,ios={d.x,d.c,d.z,d.old_y,d.new_y,d.cd_sys.clk,d.cd_sys.rst},name='c48_pair').write(str(out/'pair.v'))
    rng=random.Random(2026111018);values=[]
    for zt in (-2,-1,0,1):
        for zl in [-(1<<47),-(1<<47)+1,-(1<<47)+(1<<41),-1,0,1,(1<<47)-1,(1<<47)-(1<<41)]:
            for x in [-(1<<24),-(1<<24)+1,-(1<<24)+131071,-131072,-131071,-1,0,1,131071,131072,(1<<24)-1]:
                for c in [-(1<<24),-1,0,1,(1<<24)-1]:values.append((x,c,signed(((zt&3)<<48)|(zl&((1<<48)-1)),50)))
    for i in range(70000):
        x=signed(rng.getrandbits(25),25);c=signed(rng.getrandbits(25),25);z=signed(rng.getrandbits(50),50)
        if i%4==0:
            edge=-(1<<47) if c<0 else (1<<47)-1
            zl=edge+(rng.randrange(1<<38) if c<0 else -rng.randrange(1<<38))
            z=signed((rng.randrange(4)<<48)|(zl&((1<<48)-1)),50)
        values.append((x,c,z))
    rows=[];stats={'positive_overflow48':0,'negative_overflow48':0,'final_wrap50':0,'negative_x':0,'negative_c':0}
    for x,c,z in values:
        low_true=c*(x&131071)+signed(z,48)
        stats['positive_overflow48']+=int(low_true>((1<<47)-1));stats['negative_overflow48']+=int(low_true<-(1<<47))
        true=z+x*c;stats['final_wrap50']+=int(true!=signed(true,50));stats['negative_x']+=int(x<0);stats['negative_c']+=int(c<0)
        rows.append([x&((1<<25)-1),c&((1<<25)-1),z&((1<<50)-1),true&((1<<50)-1)])
    assert stats['positive_overflow48']>1000 and stats['negative_overflow48']>1000 and stats['final_wrap50']>1000
    (out/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
    (out/'tb.sv').write_bytes(b'''`timescale 1ns/1ps
module tb_c48;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [24:0] x=0,c=0;reg signed [49:0] z=0;wire [49:0] old_y,new_y;reg [49:0] expected;
c48_pair dut(.*);integer fd,k,count=0;
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 repeat(24)@(posedge sys_clk);
 while(!$feof(fd))begin
  @(negedge sys_clk);sys_rst=(count%9973==1);
  k=$fscanf(fd,"%h %h %h %h\\n",x,c,z,expected);if(k!=4)$fatal(1,"bad vector");if(sys_rst)expected=0;@(posedge sys_clk);#1;
  if(old_y!==expected || new_y!==expected)begin
   $display("C48_DIAGNOSTIC rst=%b low=%h highq=%h correction=%h correctionq=%h lowq=%h cascade=%h",sys_rst,dut.pair_low,dut.pair_high_q,dut.pair_correction,dut.pair_correction_q,dut.pair_low_q,dut.pair_cascade);
   $fatal(1,"C48_MAC_FAIL count=%0d x=%h c=%h z=%h old=%h new=%h expected=%h",count,x,c,z,old_y,new_y,expected);
  end
  count=count+1;
 end
 if(count<70000)$fatal(1,"count");$display("C48_REGISTERED_FULL50_MAC_PASS cases=%0d",count);$finish;
end
endmodule
''')
    tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv',tool.parent/'data/verilog/src/glbl.v'],None),('elaborate',[tool/'xelab.bat','tb_c48','glbl','-L','unisims_ver','-s','tb_c48','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_c48','-runall'],'C48_REGISTERED_FULL50_MAC_PASS')]:
        cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
        txt=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in txt) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',txt)
        (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,txt[-6000:]
        if marker:print(re.search(marker+r'[^\r\n]*',txt)[0],flush=True)
    (out/'results.json').write_bytes(json.dumps({'passed':True,'cases':len(rows),'stats':stats,'scope':'Clocked native DSP48E1 UNISIM full 50-bit registered result vs original registered MAC and independent integer oracle; DSP inference/implementation not yet verified.'},indent=2).encode())
    print('C48_REGISTERED_MAC_SUITE_PASS',stats,flush=True)
if __name__=='__main__':main()
