"""Full-word lookup oracle; production state invariant is checked in parent suite."""
from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Array,Module,Signal
from migen.fhdl import verilog
from gateware.logic.onehot_select import onehot_select_word

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for width,sgn in ((1,False),(14,False),(14,True),(25,True),(28,True),(29,True)):
        sub=out/f'{width}_{int(sgn)}';sub.mkdir();total=32*width;mask=(1<<width)-1
        class Pair(Module):
            def __init__(self):
                self.packed=Signal(total,name_override='packed_words');self.index=Signal(5,name_override='index');self.onehot=Signal(32,name_override='onehot')
                self.old=Signal((width,sgn),name_override='old_word');self.new=Signal.like(self.old,name_override='new_word');words=[]
                for i in range(32):
                    x=Signal((width,sgn));self.comb += x.eq(self.packed[i*width:(i+1)*width]);words.append(x)
                selected=onehot_select_word(self,words,self.onehot);assert selected.signed==sgn
                self.comb += [self.old.eq(Array(words)[self.index]),self.new.eq(selected)]
        d=Pair();verilog.convert(d,ios={d.packed,d.index,d.onehot,d.old,d.new},name='onehot_word_pair').write(str(sub/'pair.v'))
        rng=random.Random(2026111033+width+int(sgn));rows=[];coverage=set()
        def emit(index,packed=None,value=None):
            if packed is None:packed=rng.getrandbits(total)
            if value is not None:packed=(packed&~(mask<<(index*width)))|((value&mask)<<(index*width))
            expected=(packed>>(index*width))&mask;rows.append([packed,index,1<<index,expected]);coverage.add(index)
        for index in range(32):
            for value in (0,mask,1<<(width-1),max(0,(1<<(width-1))-1),1):emit(index,value=value)
        for _ in range(12000):emit(rng.randrange(32))
        assert len(coverage)==32
        (sub/'vectors.txt').write_text('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n',encoding='ascii')
        unknown=[]
        for i in range(1000):
            idx=i%32;bits=''.join(rng.choice('0011x') for _ in range(total));unknown.append([bits,format(idx,'05b'),format(1<<idx,'08x')])
        for i in range(1000):
            bits=''.join(rng.choice('0011x') for _ in range(total));index=list(format(i%32,'05b'));index[i%5]=rng.choice('xz');unknown.append([bits,''.join(index),'80000000'])
        (sub/'unknown.txt').write_text('\n'.join(' '.join(row) for row in unknown)+'\n',encoding='ascii')
        (sub/'tb.sv').write_text(f'''`timescale 1ns/1ps
module tb_onehot_word;
reg [{total-1}:0] packed_words;reg [4:0] index;reg [31:0] onehot;wire [{width-1}:0] old_word,new_word;reg [{width-1}:0] expected;
integer fd,k,count=0,unknown_count=0;onehot_word_pair dut(.*);
initial begin
fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
while(!$feof(fd))begin
k=$fscanf(fd,"%h %h %h %h\\n",packed_words,index,onehot,expected);if(k!=4)$fatal(1,"bad vector");#1;
if(old_word!==expected || new_word!==expected)$fatal(1,"ONEHOT_WORD_FAIL W={width} signed={int(sgn)} cycle=%0d index=%0d old=%h new=%h expected=%h",count,index,old_word,new_word,expected);count=count+1;
end
$fclose(fd);fd=$fopen("unknown.txt","r");
while(!$feof(fd))begin
k=$fscanf(fd,"%b %b %h\\n",packed_words,index,onehot);if(k!=3)$fatal(1,"bad unknown vector");#1;
if(old_word!==new_word)$fatal(1,"ONEHOT_WORD_UNKNOWN_FAIL W={width} case=%0d idx=%b OH=%h old=%b new=%b",unknown_count,index,onehot,old_word,new_word);unknown_count=unknown_count+1;
end
$display("ONEHOT_WORD_PASS width={width} signed={int(sgn)} cases=%0d unknown=%0d indices=32",count,unknown_count);$finish;
end
endmodule
''',encoding='ascii')
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_onehot_word','-s','tb_onehot_word','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_onehot_word','-runall'],f'ONEHOT_WORD_PASS width={width} signed={int(sgn)} ')]:
            cmd=list(map(str,cmd));p=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(p.stdout);(sub/(label+'.stderr.log')).write_bytes(p.stderr)
            text=(p.stdout+b'\n'+p.stderr).decode(errors='replace');ok=p.returncode==0 and(not marker or marker in text)and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            (sub/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':p.returncode,'passed':bool(ok)},indent=2),encoding='utf-8');print(width,int(sgn),label,'PASS'if ok else'FAIL',flush=True);assert ok,text[-6000:]
            if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
        results.append({'width':width,'signed':sgn,'cases':len(rows),'X_data_and_XZ_index_cases':len(unknown),'indices':32,'passed':True})
    (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'scope':'Actual onehot word helper vs Migen Array and independent packed-bit oracle. Valid one-hot supplied from independent Python index; X/Z index models original default31. X data vectors use0/1/X, not arbitrary Z words. Actual OH sequential invariant and reset/CSR/FSM proved separately by parent native suite.'},indent=2),encoding='utf-8')
    print('ONEHOT_TABLE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
