"""Native DSP, real CSR and joint frame/limiter/PID differential vs frozen R16."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,If,Module,Mux,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr import AutoCSR,CSRStorage
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.registered_error_mixer import MixerFactorCSR,RegisteredErrorMixer
from gateware.logic.feedback_pipeline import AlignedInputLimitCSR,FeedbackInputAlignment,MixerAlignedPID
from gateware.logic.limit import LimitCSR

FIELDS=['kp_mult','output_p','ki_mult','int_sum','int_reg','int_out','output_d','pid_sum','pid_out']
PIDCONFIG=['setpoint','kp','ki','kd','reset']

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args()
    out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    frozen=ROOT/'gateware/tests/timing/reference/r16_pid_pipeline.py'
    spec=importlib.util.spec_from_file_location('gateware.logic.r16_pid_pipeline_frame',frozen);old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
    results=[]
    for width in (14,25):
        sub=out/str(width);sub.mkdir();n=width+18
        class Controls(Module,AutoCSR):
            def __init__(self):
                self.factor_a=MixerFactorCSR('factor_a');self.factor_b=MixerFactorCSR('factor_b')
                self.offset=CSRStorage(14);self.dual=CSRStorage(1);self.mode=CSRStorage(1)
                self.submodules.limit=AlignedInputLimitCSR(width=25,guard=4)
                self.submodules.pid=MixerAlignedPID(width=width)
                self.offset_signed=Signal((14,True));self.sync += self.offset_signed.eq(self.offset.storage)
        class Pair(Module):
            def __init__(self):
                self.clock_domains.cd_sys=ClockDomain('sys')
                self.submodules.controls=c=Controls()
                self.submodules.bank=bank=CSRBank(c.get_csrs())
                self.submodules.mixer=m=RegisteredErrorMixer(product_pipeline=True)
                self.submodules.alignment=align=FeedbackInputAlignment()
                self.submodules.a_limit=la=LimitCSR(width=25,guard=3)
                self.submodules.b_limit=lb=LimitCSR(width=25,guard=3)
                self.submodules.ref_limit=rl=LimitCSR(width=25,guard=4)
                self.submodules.ref_pid=rp=old.PipelinedPID(width=width)
                self.ports={}
                for key,bits,sgn in [('ax',28,True),('bx',28,True),('adc',14,True),('ce_a',1,False),('ce_b',1,False),('limit_ce',1,False),('pid_ce',1,False),('running',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False),('seed',1,False),('seed_value',n,True)]:self.ports[key]=Signal((bits,sgn),name_override=key)
                ports=self.ports
                def lag(value):
                    q=Signal.like(value);self.sync += q.eq(value);return q
                refa,refb,fa,fb,off,dual,mode,adc=[lag(x) for x in (la.y,lb.y,c.factor_a.storage,c.factor_b.storage,c.offset_signed,c.dual.storage,c.mode.storage,ports['adc'])]
                refmix=Signal((37,True));refinput=Signal((25,True))
                self.comb += [la.x.eq(ports['ax']),lb.x.eq(ports['bx']),la.update_en.eq(ports['ce_a']),lb.update_en.eq(ports['ce_b']),
                    la.min.storage.eq(1<<24),lb.min.storage.eq(1<<24),la.max.storage.eq((1<<24)-1),lb.max.storage.eq((1<<24)-1),
                    m.a.eq(la.y),m.b.eq(lb.y),m.pre_a.eq(la.limit.y),m.pre_b.eq(lb.limit.y),m.ce_a.eq(la.update_en),m.ce_b.eq(lb.update_en),
                    m.high_a.eq(c.factor_a.storage[8]),m.high_b.eq(c.factor_b.storage[8]),m.low_a.eq(c.factor_a.encoded_low_data),m.low_b.eq(c.factor_b.encoded_low_data),
                    m.write_a.eq(c.factor_a.encoded_low_write),m.write_b.eq(c.factor_b.encoded_low_write),m.offset.eq(c.offset_signed),m.dual.eq(c.dual.storage),
                    If(dual,refmix.eq(fa*refa+fb*refb+(off<<19))).Else(refmix.eq((refa<<8)+(off<<19))),
                    c.limit.x.eq(m.y>>8),rl.x.eq(refmix>>8),
                    rl.min.storage.eq(lag(c.limit.min.storage)),rl.max.storage.eq(lag(c.limit.max.storage)),rl.update_en.eq(lag(ports['limit_ce'])),
                    align.direct_adc.eq(ports['adc']),align.mixed_error.eq(c.limit.y),align.pid_only.eq(c.mode.storage),align.limit_accept_en.eq(ports['limit_ce']),
                    c.limit.update_en.eq(align.limit_execute_en),
                    refinput.eq(Mux(mode,adc<<11,rl.y)),
                    rp.input.eq(refinput>>(25-width)),c.pid.input.eq(align.output>>(25-width)),
                    rp.running.eq(lag(ports['running'])),c.pid.running.eq(ports['running']),rp.update_en.eq(lag(ports['pid_ce'])),c.pid.update_en.eq(ports['pid_ce'])]
                for key in PIDCONFIG:self.comb += getattr(rp,key).storage.eq(lag(getattr(c.pid,key).storage))
                self.comb += [bank.bus.adr.eq(ports['csr_adr']),bank.bus.we.eq(ports['csr_we']),bank.bus.dat_w.eq(ports['csr_dat_w'])]
                self.stores=[('fa',c.factor_a),('fb',c.factor_b),('offset',c.offset),('dual',c.dual),('mode',c.mode),('min',c.limit.min),('max',c.limit.max)]+[(k,getattr(c.pid,k)) for k in PIDCONFIG]
                self.config_bits=sum(csr.size for _,csr in self.stores);self.field_bits=sum(len(getattr(rp,k)) for k in FIELDS)
                def port(key,bits,value):
                    q=Signal(bits,name_override=key);ports[key]=q;self.comb += q.eq(value)
                for key,bits,value in [('ref_mix',37,refmix),('cand_mix',37,m.y),('ref_input',25,refinput),('cand_input',25,align.output),
                    ('ref_y',25,rl.y),('cand_y',25,c.limit.y),('ref_rail',1,rl.error),('cand_rail',1,c.limit.error),
                    ('ref_lo',29,rl.limit.min),('ref_hi',29,rl.limit.max),('ref_lx',29,rl.x),('ref_lce',1,rl.update_en),
                    ('ref_fields',self.field_bits,Cat(*[getattr(rp,k) for k in FIELDS])),('cand_fields',self.field_bits,Cat(*[getattr(c.pid,k) for k in FIELDS])),
                    ('ref_ir',n,rp.int_reg),('cand_ir',n,c.pid.int_reg),('ref_execute',1,rp.execute_en),('cand_execute',1,c.pid.execute_en),
                    ('config_value',self.config_bits,Cat(*[csr.storage for _,csr in self.stores])),('csr_read',8,bank.bus.dat_r),
                    ('ref_a',25,refa),('ref_b',25,refb),('ref_fa',9,fa),('ref_fb',9,fb),('ref_offset',14,off),('ref_dual',1,dual)]:port(key,bits,value)
                self.sync += If(ports['seed'] & ~c.pid.execute_en,rp.int_reg.eq(ports['seed_value']),c.pid.int_reg.eq(ports['seed_value']))
                self.byte_map={};self.addresses={}
                for key,csr in self.stores:
                    remaining=csr.size;entries=[]
                    for sc in csr.simple_csrs:
                        remaining-=sc.size;adr=bank.simple_csrs.index(sc);self.byte_map[adr]=(key,remaining,sc.size);entries.append((adr,remaining,sc.size))
                    self.addresses[key]=entries
        d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='feedback_frame_pair').write(str(sub/'pair.v'))
        storage={key:csr.storage.reset.value for key,csr in d.stores};defaults=storage.copy();sizes={key:csr.size for key,csr in d.stores}
        rng=random.Random(2026111017+width);rows=[];stats={'writes':0,'reset':0,'seed':0,'pid_ce_zero':0,'limit_ce_zero':0}
        def emit(rst=0,ax=None,bx=None,adc=None,ca=None,cb=None,lce=1,pce=1,run=1,adr=None,we=0,data=None,seed=0,seedval=0):
            adr=rng.choice(list(d.byte_map)) if adr is None else adr;data=rng.randrange(256) if data is None else data
            key,shift,bits=d.byte_map[adr];mask=(1<<bits)-1;read=(storage[key]>>shift)&mask
            if rst:storage.update(defaults);read=0
            elif we:storage[key]=(storage[key]&~(mask<<shift))|((data&mask)<<shift)
            cfg=0;pos=0
            for key,_ in d.stores:cfg|=storage[key]<<pos;pos+=sizes[key]
            rows.append([rst,(rng.randrange(1<<28) if ax is None else ax)&((1<<28)-1),(rng.randrange(1<<28) if bx is None else bx)&((1<<28)-1),
                (rng.randrange(16384) if adc is None else adc)&16383,rng.randrange(2) if ca is None else ca,rng.randrange(2) if cb is None else cb,lce,pce,run,adr,we,data,seed,seedval&((1<<n)-1),read,cfg])
            stats['writes']+=we;stats['reset']+=rst;stats['seed']+=seed;stats['pid_ce_zero']+=1-pce;stats['limit_ce_zero']+=1-lce
        def write(key,value,**kwargs):
            for adr,shift,bits in d.addresses[key]:emit(adr=adr,we=1,data=(value>>shift)&((1<<bits)-1),**kwargs)
        for _ in range(24):emit(rst=1,we=0)
        for f in range(512):
            for key,value in [('fa',f),('fb',511-f),('dual',f&1),('mode',(f>>1)&1)]:write(key,value,ca=1,cb=1)
            emit(ca=1,cb=1);emit(ca=1,cb=1)
        for key,value in [('mode',1),('kp',4096),('ki',16),('kd',128),('setpoint',0),('reset',0)]:write(key,value,pce=0)
        upper=((1<<(width-1))-1)<<18;lower=-upper-1
        for state in [upper-1,upper,upper+1,lower-1,lower,lower+1,(1<<(n-1))-1,-(1<<(n-1))]:
            for _ in range(6):emit(pce=0,adc=1 if state>=0 else -1)
            emit(pce=0,seed=1,seedval=state,adc=1 if state>=0 else -1)
            for _ in range(12):emit(adc=1 if state>=0 else -1)
        edge=[-(1<<27),-(1<<24),-1,0,1,(1<<24)-1,(1<<27)-1]
        for i in range(40000):
            emit(rst=int(i in (2001,11002,11003,30007)),ax=edge[i%7] if i<4000 else None,bx=edge[(i//7)%7] if i<4000 else None,
                adc=[-8192,-1,0,1,8191][i%5] if i<4000 else None,lce=int(i<6000 or i%7==0),pce=int(i<8000 or i%11==0),run=int(i%19!=0),we=int(i%2==0))
        for _ in range(8):emit(pce=0,lce=0,we=0)
        (sub/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
        tb=f'''`timescale 1ns/1ps
module tb_feedback_frame;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [27:0] ax=0,bx=0;reg signed [13:0] adc=0;reg ce_a=0,ce_b=0,limit_ce=0,pid_ce=0,running=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;reg seed=0;reg [{n-1}:0] seed_value=0;
wire [36:0] ref_mix,cand_mix;wire [24:0] ref_input,cand_input,ref_y,cand_y,ref_a,ref_b;
wire ref_rail,cand_rail,ref_lce,ref_execute,cand_execute,ref_dual;wire [28:0] ref_lo,ref_hi,ref_lx;
wire [{d.field_bits-1}:0] ref_fields,cand_fields;wire [{n-1}:0] ref_ir,cand_ir;
wire [{d.config_bits-1}:0] config_value;wire [7:0] csr_read;wire [8:0] ref_fa,ref_fb;wire [13:0] ref_offset;
reg [7:0] expected_read;reg [{d.config_bits-1}:0] expected_config;
reg [24:0] expected_y=0;reg expected_rail=0;reg signed [63:0] lx,lo,hi,aa,bb,fa,fb,offs,total;reg [36:0] expected_mix;
reg [511:0] seen_a=0,seen_b=0;integer fd,k,cycles=0,known=0,positive=0,negative=0,rails=0,holds=0;
feedback_frame_pair dut(.*);
initial begin
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);k=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,ax,bx,adc,ce_a,ce_b,limit_ce,pid_ce,running,csr_adr,csr_we,csr_dat_w,seed,seed_value,expected_read,expected_config);
  if(k!=16)$fatal(1,"bad vector");#1;
  if(seed && cand_execute)$fatal(1,"seed overlaps valid");
  @(posedge sys_clk);
  if(sys_rst)begin expected_y=0;expected_rail=0;end
  else if(ref_lce)begin
   lx=$signed(ref_lx);lo=$signed(ref_lo);hi=$signed(ref_hi);
   if(lx>=hi)begin expected_y=hi[24:0];expected_rail=1;end
   else if(lx<=lo)begin expected_y=lo[24:0];expected_rail=1;end
   else begin expected_y=lx[24:0];expected_rail=0;end
  end
  #1;
  if(config_value!==expected_config || csr_read!==expected_read)$fatal(1,"FRAME_CSR_FAIL W={width} cycle=%0d",cycles);
  if(ref_y!==expected_y || cand_y!==expected_y || ref_rail!==expected_rail || cand_rail!==expected_rail)$fatal(1,"FRAME_LIMIT_FAIL W={width} cycle=%0d old=%h new=%h expected=%h",cycles,ref_y,cand_y,expected_y);
  if(ref_input!==cand_input || ref_fields!==cand_fields || ref_ir!==cand_ir || ref_execute!==cand_execute || (^ref_fields)===1'bx)$fatal(1,"FRAME_PID_FAIL W={width} cycle=%0d old=%h new=%h input=%h/%h",cycles,ref_fields,cand_fields,ref_input,cand_input);
  if(cycles>=24)begin
   aa=$signed(ref_a);bb=$signed(ref_b);fa=ref_fa;fb=ref_fb;offs=$signed(ref_offset);
   total=(ref_dual ? fa*aa+fb*bb : (aa<<<8))+(offs<<<19);expected_mix=total[36:0];
   if(ref_mix!==expected_mix || cand_mix!==expected_mix)$fatal(1,"FRAME_MIX_FAIL W={width} cycle=%0d old=%h new=%h expected=%h",cycles,ref_mix,cand_mix,expected_mix);
   known=known+1;seen_a[ref_fa]=1;seen_b[ref_fb]=1;
  end
  if(cand_ir=={n}'h{upper:x})positive=positive+1;
  if(cand_ir=={n}'h{lower&((1<<n)-1):x})negative=negative+1;
  if(cand_rail)rails=rails+1;if(!ref_lce)holds=holds+1;cycles=cycles+1;
 end
 if(known<40000 || positive<3 || negative<3 || rails<1000 || holds<1000 || seen_a!=={{512{{1'b1}}}} || seen_b!=={{512{{1'b1}}}})$fatal(1,"frame coverage W={width} known=%0d sat=%0d/%0d rails=%0d holds=%0d",known,positive,negative,rails,holds);
 $display("FEEDBACK_FRAME_1SYS_PASS width={width} cycles=%0d known=%0d positive_sat=%0d negative_sat=%0d rails=%0d limit_holds=%0d factors=512/512",cycles,known,positive,negative,rails,holds);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
'''
        (sub/'tb.sv').write_bytes(tb.encode())
        for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',sub/'pair.v',sub/'tb.sv',tool.parent/'data/verilog/src/glbl.v'],None),
            ('elaborate',[tool/'xelab.bat','tb_feedback_frame','glbl','-L','unisims_ver','-s','tb_feedback_frame','--timescale','1ns/1ps'],None),
            ('simulate',[tool/'xsim.bat','tb_feedback_frame','-runall'],f'FEEDBACK_FRAME_1SYS_PASS width={width}')]:
            cmd=[str(v) for v in cmd];r=subprocess.run(cmd,cwd=sub,capture_output=True);(sub/(label+'.stdout.log')).write_bytes(r.stdout);(sub/(label+'.stderr.log')).write_bytes(r.stderr)
            txt=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in txt) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',txt)
            (sub/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(width,label,'PASS' if ok else 'FAIL',flush=True);assert ok,txt[-7000:]
            if marker:print(re.search(marker+r'[^\r\n]*',txt)[0],flush=True)
        stats['cycles']=len(rows);results.append({'width':width,'stats':stats,'CSR_addresses':d.addresses})
    (out/'results.json').write_bytes(json.dumps({'passed':True,'results':results,'frozen_pid_sha256':hashlib.sha256(frozen.read_bytes()).hexdigest(),
        'scope':'Native UNISIM MREG+real CSR; exact 37-bit integer oracle; original limiter with delayed raw config, clamp oracle, frozen R16 PID with independently delayed controls; full mode/CE/reset/hot-write frame comparison. No implementation/board proof.'},indent=2).encode())
    print('FEEDBACK_FRAME_SUITE_PASS',flush=True)
if __name__=='__main__':main()
