from pathlib import Path
import argparse,json,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from linien_common.common import OutputChannel
from migen import Cat,ClockDomain,If,Module,Mux,Signal
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.chains import SlowChain
from gateware.logic.slow_pipeline import PipelinedSlowChain,SlowOutputTransport
from gateware.logic.decimation import DecimateEnable

FIELDS=['kp_mult','output_p','ki_mult','int_sum','int_reg','int_out','output_d','pid_sum','pid_out']
CONFIG=['setpoint','kp','ki','kd','reset']

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--out',type=Path,required=True);args=parser.parse_args()
    out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.submodules.candidate=c=PipelinedSlowChain()
            self.submodules.reference=r=SlowChain()
            self.submodules.transport=t=SlowOutputTransport()
            self.submodules.bank=b=CSRBank(c.get_csrs())
            self.submodules.decimate=div=DecimateEnable(16)
            self.ports={}
            for name,n,sgn in [('x',14,True),('running',1,False),('ce',1,False),('use_divider',1,False),('divider',5,False),('sweep',14,True),('offset',14,True),('sweep_channel',2,False),('slow_channel',2,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False),('seed_enable',1,False),('seed_value',32,True)]:self.ports[name]=Signal((n,sgn),name_override=name)
            p=self.ports;accept=Signal();self.comb += [div.decimation.eq(p['divider']),accept.eq(Mux(p['use_divider'],div.enable,p['ce']))]
            self.comb += [c.input.eq(p['x']),c.pid.running.eq(p['running']),c.update_en.eq(accept),t.sweep.eq(p['sweep']),t.offset.eq(p['offset']),t.sweep_channel.eq(p['sweep_channel']),t.slow_channel.eq(p['slow_channel']),t.slow_pid.eq(c.output),c.limit.x.eq(t.analog_out)]
            def lag(value,reset=0):
                s1=Signal.like(value,reset=reset);s2=Signal.like(value,reset=reset)
                self.sync += [s1.eq(value),s2.eq(s1)];return s2
            self.comb += [r.input.eq(lag(p['x'])),r.pid.running.eq(lag(p['running'])),r.update_en.eq(lag(accept))]
            configs=[]
            for key in CONFIG:
                cand,ref=getattr(c.pid,key),getattr(r.pid,key);self.comb += ref.storage.eq(lag(cand.storage));configs.append((key,cand,0))
            for key,reset in [('min',8192),('max',8191)]:
                cand,ref=getattr(c.limit,key),getattr(r.limit,key);self.comb += ref.storage.eq(lag(cand.storage,reset));configs.append((key,cand,reset))
            # Original output expressions, recomputed from independently delayed raw context.
            sw,off,swch,slch=lag(p['sweep']),lag(p['offset']),lag(p['sweep_channel']),lag(p['slow_channel'])
            ref_analog=Signal((17,True));self.comb += [ref_analog.eq(Mux(swch==OutputChannel.ANALOG_OUT0,sw,0)+Mux(swch==OutputChannel.ANALOG_OUT0,off,0)+Mux(slch==OutputChannel.ANALOG_OUT0,r.output,0)),r.limit.x.eq(ref_analog)]
            self.field_bits=sum(len(getattr(r.pid,k)) for k in FIELDS)
            for name,n,value in [('ref_fields',self.field_bits,Cat(*[getattr(r.pid,k) for k in FIELDS])),('cand_fields',self.field_bits,Cat(*[getattr(c.pid,k) for k in FIELDS])),
                ('ref_limit',54,Cat(r.limit.y,r.limit.error,r.limit.limit.min,r.limit.limit.max,r.limit.update_en)),('cand_limit',54,Cat(c.limit.y,c.limit.error,c.limit.limit.min,c.limit.limit.max,c.limit.update_en)),
                ('ref_analog',17,ref_analog),('cand_analog',17,t.analog_out),('ref_read',8,b.bus.dat_r),('csr_config',85,Cat(*[v.storage for _,v,_ in configs])),('accept_ce',1,accept),('execute_ce',1,c.pid.execute_en)]:
                q=Signal(n,name_override=name);p[name]=q;self.comb += q.eq(value)
            for channel in (0,1):
                q1,q2=Signal(14,name_override=f'ref_contrib{channel}'),Signal(14,name_override=f'cand_contrib{channel}')
                self.ports[f'ref_contrib{channel}']=q1;self.ports[f'cand_contrib{channel}']=q2
                self.comb += [q1.eq(Mux(slch==channel,r.output,0)),q2.eq(Mux(t.aligned_slow_channel==channel,c.output,0))]
            self.comb += [b.bus.adr.eq(p['csr_adr']),b.bus.we.eq(p['csr_we']),b.bus.dat_w.eq(p['csr_dat_w'])]
            self.byte_map={};self.addresses={}
            for key,csr,reset in configs:
                remaining=csr.size;entries=[]
                for sc in csr.simple_csrs:
                    remaining-=sc.size;adr=b.simple_csrs.index(sc);self.byte_map[adr]=(key,remaining,sc.size);entries.append((adr,remaining,sc.size))
                self.addresses[key]=entries
            self.sync += If(p['seed_enable'] & ~c.pid.execute_en,r.pid.int_reg.eq(p['seed_value']),c.pid.int_reg.eq(p['seed_value']))
    d=Pair();verilog.convert(d,ios=set(d.ports.values())|{d.cd_sys.clk,d.cd_sys.rst},name='slow_pipeline_pair').write(str(out/'pair.v'))
    rng=random.Random(2026111013);storage={k:0 for k in CONFIG};storage.update(min=8192,max=8191)
    rows=[];stats={'writes':0,'resets':0,'seed':0};modes=set()
    def emit(rst=0,x=None,running=1,ce=1,use=0,divider=0,sweep=None,offset=None,swch=None,slch=None,adr=None,we=0,data=None,seed=0,seedval=0):
        adr=rng.choice(list(d.byte_map)) if adr is None else adr;key,shift,bits=d.byte_map[adr]
        data=rng.randrange(256) if data is None else data
        read=(storage[key]>>shift)&((1<<bits)-1)
        if rst:storage.update({k:0 for k in CONFIG});storage.update(min=8192,max=8191);read=0
        elif we:mask=((1<<bits)-1)<<shift;storage[key]=(storage[key]&~mask)|((data<<shift)&mask)
        cfg=0;sh=0
        for k in CONFIG+['min','max']:
            n=1 if k=='reset' else 14;cfg|=storage[k]<<sh;sh+=n
        assert sh==85
        rows.append([rst,(rng.randrange(16384) if x is None else x)&16383,running,ce,use,divider,
            (rng.randrange(16384) if sweep is None else sweep)&16383,(rng.randrange(16384) if offset is None else offset)&16383,
            rng.randrange(4) if swch is None else swch,rng.randrange(4) if slch is None else slch,adr,we,data,seed,seedval&0xffffffff,read,cfg])
        stats['writes']+=we;stats['resets']+=rst;stats['seed']+=seed
        if use:modes.add(divider)
    def write(key,value):
        for adr,shift,bits in d.addresses[key]:emit(ce=0,adr=adr,we=1,data=(value>>shift)&((1<<bits)-1))
    for _ in range(5):emit(rst=1)
    for key,value in [('kp',1024),('ki',16),('kd',131),('setpoint',0),('reset',0)]:write(key,value)
    upper=8191<<18;lower=-upper-1
    for value in [upper-1,upper,upper+1,lower-1,lower,lower+1,2147483647,-2147483648]:
        for _ in range(5):emit(ce=0)
        emit(ce=0,seed=1,seedval=value)
        for _ in range(9):emit(x=1 if value>=0 else -1,ce=1)
    for i in range(16000):emit(x=[-8192,-1,0,1,8191][i%5] if i<2000 else None,running=int(i%19!=0),ce=int(i<3000 or i%13==0),rst=int(i in (1099,1100,7301,14503)),we=int(i%3==0))
    # Actual divider integration: every legal rate has >=3 events; all illegal
    # values preserve the original last-index behavior. No synthetic CE oracle.
    for rate in range(32):
        ticks=max(32,3*(1<<rate)) if rate<16 else (3*(1<<15) if rate in (16,31) else 256)
        for i in range(ticks):emit(use=1,divider=rate,we=int(i%1057==0),running=int(i%71!=0))
    for _ in range(8):emit(ce=0)
    stats.update(cycles=len(rows),divider_modes=sorted(modes))
    (out/'vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
    tb=f'''`timescale 1ns/1ps
module tb_slow_pipeline;
reg sys_clk=0;always #4 sys_clk=~sys_clk;reg sys_rst=1;
reg signed [13:0] x=0,sweep=0,offset=0;reg running=0,ce=0,use_divider=0;reg [4:0] divider=0;reg [1:0] sweep_channel=0,slow_channel=0;
reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;reg seed_enable=0;reg [31:0] seed_value=0;
wire [{d.field_bits-1}:0] ref_fields,cand_fields;wire [53:0] ref_limit,cand_limit;wire [16:0] ref_analog,cand_analog;
wire [13:0] ref_contrib0,cand_contrib0,ref_contrib1,cand_contrib1;wire [7:0] ref_read;wire [84:0] csr_config;wire accept_ce,execute_ce;
reg [7:0] expected_read;reg [84:0] expected_cfg;reg ce1=0,ce2=0;integer events[0:31];
slow_pipeline_pair dut(.*);integer fd,n,cycles=0,i,commits=0,positive=0,negative=0;
initial begin
 for(i=0;i<32;i=i+1)events[i]=0;
 fd=$fopen("vectors.txt","r");if(!fd)$fatal(1,"vectors missing");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\\n",sys_rst,x,running,ce,use_divider,divider,sweep,offset,sweep_channel,slow_channel,csr_adr,csr_we,csr_dat_w,seed_enable,seed_value,expected_read,expected_cfg);
  if(n!=17)$fatal(1,"bad vector");#1;
  if(seed_enable && execute_ce)$fatal(1,"seed overlaps pending commit");
  if(use_divider && accept_ce)events[divider]=events[divider]+1;
  @(posedge sys_clk);
  if(sys_rst)begin ce1=0;ce2=0;end else begin ce2=ce1;ce1=accept_ce;end
  #1;
  if(ref_fields!==cand_fields || (^ref_fields)===1'bx)$fatal(1,"SLOW_PID_FAIL cycle=%0d old=%h new=%h",cycles,ref_fields,cand_fields);
  if(ref_limit!==cand_limit || ref_analog!==cand_analog || ref_contrib0!==cand_contrib0 || ref_contrib1!==cand_contrib1)$fatal(1,"SLOW_CONTEXT_FAIL cycle=%0d limit=%h/%h analog=%h/%h",cycles,ref_limit,cand_limit,ref_analog,cand_analog);
  if(csr_config!==expected_cfg || ref_read!==expected_read)$fatal(1,"SLOW_CSR_ORACLE_FAIL cycle=%0d cfg=%h/%h read=%h/%h",cycles,csr_config,expected_cfg,ref_read,expected_read);
  if(execute_ce!==ce2)$fatal(1,"TWO_SYS_TOKEN_FAIL %0d",cycles);
  if(execute_ce)commits=commits+1;
  if(cand_fields[135:104]==32'h7ffc0000)positive=positive+1;
  if(cand_fields[135:104]==32'h8003ffff)negative=negative+1;
  cycles=cycles+1;
 end
 for(i=0;i<32;i=i+1)if((i<16 || i==16 || i==31) && events[i]<2)$fatal(1,"divider coverage rate=%0d events=%0d",i,events[i]);
 if(positive<1 || negative<1)$fatal(1,"rail coverage pos=%0d neg=%0d",positive,negative);
 if(commits<2000)$fatal(1,"commit coverage");
 $display("SLOW_PIPELINE_CSR_CONTEXT_DIVIDER_PASS cycles=%0d commits=%0d divider_modes=32 positive_sat=%0d negative_sat=%0d",cycles,commits,positive,negative);$finish;
end
initial begin #20000000;$fatal(1,"timeout");end
endmodule
'''
    (out/'tb.sv').write_bytes(tb.encode());tool=Path('D:/Xilinx/Vivado/2020.1/bin')
    for label,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'pair.v',out/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_slow_pipeline','-s','tb_slow_pipeline','--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat','tb_slow_pipeline','-runall'],'SLOW_PIPELINE_CSR_CONTEXT_DIVIDER_PASS')]:
        cmd=[str(x) for x in cmd];r=subprocess.run(cmd,cwd=out,capture_output=True);(out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
        text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
        (out/(label+'.json')).write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)},indent=2).encode());print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
        if marker:print(re.search(marker+r'[^\r\n]*',text)[0],flush=True)
    (out/'results.json').write_bytes(json.dumps({'passed':True,'stats':stats,'reference':'Unmodified production SlowChain/PID/LimitCSR with independently delayed raw input/configuration/context. Actual CSRBank only on candidate; readback has integer oracle. Actual DecimateEnable all32 rates. No extra accumulator feedback state.'},indent=2).encode())
    print('SLOW_PIPELINE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
