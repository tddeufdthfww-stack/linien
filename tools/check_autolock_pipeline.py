"""Generated-RTL predicate oracle and frozen full RobustAutolock/CSR differential."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,os,random,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat,ClockDomain,If,Module,Signal
from misoc.interconnect.csr import CSRStorage
from linien_common.common import AutolockMode
from migen.fhdl import verilog
from misoc.interconnect.csr_bus import CSRBank
from gateware.logic.autolock import FPGAAutolock
from gateware.logic.autolock_pipeline import PipelinedRobustAutolock

def signed(v,n):
    v&=(1<<n)-1
    return v-(1<<n) if v&(1<<(n-1)) else v
def load(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m

def fsm(out):
    refdir=ROOT/'gateware/tests/timing/reference'
    utils=load('gateware.logic.autolock_utils_r4a_late',refdir/'r4a_autolock_utils.py')
    old=load('gateware.logic.autolock_r4a_late',refdir/'r4a_autolock.py')
    old.SumDiffCalculator=utils.SumDiffCalculator
    class DelayedReferenceRobust(old.RobustAutolock):
        def __init__(self,*args,**kwargs):
            super().__init__(*args,**kwargs)
            def lag(value):
                q=Signal.like(value);self.sync += q.eq(value);return q
            for key in ('input','request_lock','at_start','writing_data_now','sweep_up'):
                original=getattr(self,key);public=Signal.like(original);setattr(self,key,public)
                self.comb += original.eq(lag(public))
            def replace(csr):
                public=CSRStorage(csr.size,reset=csr.storage.reset.value,name=csr.name)
                self.comb += csr.storage.eq(lag(public.storage));return public
            for key in ('time_scale','N_instructions','final_wait_time'):setattr(self,key,replace(getattr(self,key)))
            self.peak_heights=[replace(v) for v in self.peak_heights]
            self.wait_for=[replace(v) for v in self.wait_for]
            for i,v in enumerate(self.peak_heights):setattr(self,f'peak_height_{i}',v)
            for i,v in enumerate(self.wait_for):setattr(self,f'wait_for_{i}',v)
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.submodules.reference=rp=FPGAAutolock(max_delay=8191,robust_factory=DelayedReferenceRobust)
            self.submodules.candidate=cp=FPGAAutolock(max_delay=8191,robust_factory=PipelinedRobustAutolock)
            r,c=rp.robust,cp.robust
            self.submodules.rb=rb=CSRBank(rp.get_csrs());self.submodules.cb=cb=CSRBank(cp.get_csrs())
            self.ports={}
            for key,width,sgn in [('data',14,True),('request',1,False),('at_start',1,False),('writing',1,False),('sweep_up',1,False),('csr_adr',14,False),('csr_we',1,False),('csr_dat_w',8,False)]:self.ports[key]=Signal((width,sgn),name_override=key)
            self.index_bits=len(r.current_instruction_idx);self.obs_bits=self.index_bits+5+28+13+13+29+1
            def stores(parent):
                d=parent.robust
                return [('time',d.time_scale),('n',d.N_instructions),('final',d.final_wait_time)]+[(f'p{i}',v) for i,v in enumerate(d.peak_heights)]+[(f'w{i}',v) for i,v in enumerate(d.wait_for)]+[('request',parent.request_lock),('mode',parent.autolock_mode),('target',parent.fast.target_position)]
            self.stores=stores(rp);candidate_stores=dict(stores(cp));self.cfg_bits=sum(v.size for _,v in self.stores)
            def lag(value,reset=None):
                q=Signal.like(value) if reset is None else Signal.like(value,reset=reset)
                self.sync += q.eq(value);return q
            for parent,b,prefix in [(rp,rb,'ref'),(cp,cb,'cand')]:
                d=parent.robust
                self.comb += [d.input.eq(self.ports['data']),d.at_start.eq(self.ports['at_start']),d.writing_data_now.eq(self.ports['writing']),d.sweep_up.eq(self.ports['sweep_up']),parent.fast.sweep_value.eq(self.ports['data']),parent.fast.sweep_up.eq(self.ports['sweep_up']),parent.fast.sweep_step.eq(8),b.bus.adr.eq(self.ports['csr_adr']),b.bus.we.eq(self.ports['csr_we']),b.bus.dat_w.eq(self.ports['csr_dat_w'])]
                debug=[d.sum_diff_calculator.sum_value,d.sum_diff_calculator.delayer.counter,d.sum_diff_calculator.delayer.counter_delayed,d.sum_diff_calculator.output]
                if prefix=='cand':debug=[lag(v,reset=1 if i==2 else None) for i,v in enumerate(debug)]
                obs=Cat(d.current_instruction_idx,*d.state_out,*debug,parent.lock_running.status)
                for suffix,width,value in [('obs',self.obs_bits,obs),('cfg',self.cfg_bits,Cat(*[v.storage for _,v in stores(parent)])),('read',8,b.bus.dat_r),('idx',self.index_bits,d.current_instruction_idx),('watch',1,d.state_out[0]),('turn',1,parent.lock_running.status)]:
                    q=Signal(width,name_override=prefix+'_'+suffix);self.ports[prefix+'_'+suffix]=q;self.comb += q.eq(value)
            q=Signal(2,name_override='cand_prefetch_choice');self.ports['cand_prefetch_choice']=q
            self.comb += q.eq(cp.robust._instruction_prefetch['choice'])
            self.byte_map={};self.addresses={}
            for key,a in self.stores:
                b=candidate_stores[key];remaining=a.size;items=[]
                for ca,cc in zip(a.simple_csrs,b.simple_csrs):
                    remaining-=ca.size;adr=rb.simple_csrs.index(ca);assert adr==cb.simple_csrs.index(cc),(key,adr,cb.simple_csrs.index(cc))
                    self.byte_map[adr]=(key,remaining,ca.size);items.append((adr,remaining,ca.size))
                self.addresses[key]=items
            assert max(self.byte_map)<512
    pair=Pair();verilog.convert(pair,ios=set(pair.ports.values())|{pair.cd_sys.clk,pair.cd_sys.rst},name='robust_pair').write(str(out/'robust_pair.v'))
    rng=random.Random(2026111012);storage={k:0 for k,_ in pair.stores};rows=[]
    def emit(data=0,request=0,start=0,writing=0,sweep=1,rst=0,adr=0,we=0,value=0):
        # request is an annotation: actual lock request travels through CSRBank.
        if not we and not rst and storage['request']!=request:
            adr,shift,bits=pair.addresses['request'][0];we=1;value=request
        if rst:storage.update({k:0 for k in storage});read=0
        else:
            key,shift,bits=pair.byte_map[adr];mask=(1<<bits)-1;read=(storage[key]>>shift)&mask
            if we:storage[key]=(storage[key]&~(mask<<shift))|((value&mask)<<shift)
        rows.append([rst,data&16383,request,start,writing,sweep,adr,we,value,read])
    def configure():
        for key,value in [('mode',int(AutolockMode.ROBUST)),('time',8),('n',3),('final',10),('p0',100),('p1',-100),('p2',100),('w0',0),('w1',1),('w2',1)]:
            for adr,shift,bits in pair.addresses[key]:emit(adr=adr,we=1,value=(value>>shift)&((1<<bits)-1))
    for _ in range(4):emit(rst=1)
    configure()
    for i in range(9000):emit(data=100 if i%2 else -100,writing=1)
    for i in range(41000):
        if i in (13003,26003):configure()
        adr=rng.choice(list(pair.byte_map));we=0;value=0
        if i%97==0:
            addresses=pair.addresses['time'];adr,shift,bits=addresses[(i//97)%len(addresses)]
            v=[0,1,8,127,8191,8192,16383][(i//97)%7];value=(v>>shift)&((1<<bits)-1);we=1
        elif i%113==0:
            adr,shift,bits=pair.addresses['mode'][0];value=int(AutolockMode.SIMPLE if i%226==0 else AutolockMode.ROBUST);we=1
        elif i>20000 and i%89==0:
            key=['p0','p1','p2','n'][(i//89)%4];addresses=pair.addresses[key];adr,shift,bits=addresses[(i//89)%len(addresses)]
            v=3 if key=='n' else [100,-100,-(1<<27),(1<<27)-1][(i//89)%4];value=(v>>shift)&((1<<bits)-1);we=1
        emit(data=6000 if (i//48)%2==0 else -6000,request=int(i%1703<1500),start=int(i%401==0),writing=int(i%23<19),sweep=int(i%701<600),
             rst=int(i in (13001,13002,26001,26002)),adr=adr,we=we,value=value)
    # Keep every original R28 stimulus and oracle byte, then add coverage.
    assert len(rows)==50076
    original_prefix=('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode()
    assert hashlib.sha256(original_prefix).hexdigest()=='ca7dc8c929788b77f392e892728423677edc5173b36d061c6030df7199d14e2e', 'Original R28 50076-vector prefix changed'
    fields=[('mode',int(AutolockMode.ROBUST)),('time',1),('n',31),('final',0)]
    fields += [(f'p{i}',0) for i in range(32)]+[(f'w{i}',0) for i in range(32)]
    for key,value in fields:
        for adr,shift,bits in pair.addresses[key]:emit(data=0,request=0,writing=1,adr=adr,we=1,value=(value>>shift)&((1<<bits)-1))
    for _ in range(256):emit(data=0,request=1,writing=1)
    emit(data=0,request=1,start=1,writing=1)
    for _ in range(512):emit(data=0,request=1,writing=1)
    for _ in range(2):emit(rst=1)
    for key,value in fields[:4]:
        for adr,shift,bits in pair.addresses[key]:emit(data=0,request=0,writing=1,adr=adr,we=1,value=(value>>shift)&((1<<bits)-1))
    for _ in range(64):emit(data=0,request=1,writing=1)
    emit(data=0,request=1,start=1,writing=1)
    for _ in range(512):emit(data=0,request=1,writing=1)
    (out/'robust_vectors.txt').write_bytes(('\n'.join(' '.join(format(v,'x') for v in row) for row in rows)+'\n').encode())
    tb=f'''`timescale 1ns/1ps
module tb_robust;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_rst=1;reg signed [13:0] data=0;reg request=0,at_start=0,writing=0,sweep_up=0;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [{pair.obs_bits-1}:0] ref_obs,cand_obs;wire [{pair.cfg_bits-1}:0] ref_cfg,cand_cfg;wire [1:0] cand_prefetch_choice;wire [7:0] ref_read,cand_read;
wire [{pair.index_bits-1}:0] ref_idx,cand_idx;wire ref_watch,cand_watch,ref_turn,cand_turn;reg [7:0] expected_read;
reg [31:0] seen_index=0;
robust_pair dut(.*);integer fd,n,cycles=0,known=0,unknown=0,watching=0,advanced=0,locking=0;
initial begin
 fd=$fopen("robust_vectors.txt","r");if(!fd)$fatal(1,"missing vectors");
 while(!$feof(fd))begin
  @(negedge sys_clk);n=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h\\n",sys_rst,data,request,at_start,writing,sweep_up,csr_adr,csr_we,csr_dat_w,expected_read);
  if(n!=10)$fatal(1,"bad vector");@(posedge sys_clk);#1;
  if(ref_obs!==cand_obs || ref_cfg!==cand_cfg || ref_read!==cand_read)$fatal(1,"ROBUST_DIFF_FAIL %0d old=%h new=%h read=%h/%h",cycles,ref_obs,cand_obs,ref_read,cand_read);
  if(ref_read!==expected_read)$fatal(1,"CSR_ORACLE_FAIL %0d read=%h expected=%h",cycles,ref_read,expected_read);
  if(cand_prefetch_choice>2 || (^cand_prefetch_choice)===1'bx)$fatal(1,"PREFETCH_CHOICE_FAIL cycle=%0d idx=%0d choice=%h",cycles,cand_idx,cand_prefetch_choice);
  seen_index=seen_index|(32'd1<<cand_idx);
  if((^ref_obs)===1'bx)unknown=unknown+1;else known=known+1;
  if(ref_watch)watching=watching+1;if(ref_idx>0)advanced=advanced+1;if(ref_turn)locking=locking+1;
  cycles=cycles+1;
 end
 if(cycles<50000 || known<40000 || watching<1000 || advanced<1000 || locking<1000)$fatal(1,"coverage failed cycles=%0d known=%0d watch=%0d advanced=%0d lock=%0d",cycles,known,watching,advanced,locking);
 if(seen_index!==32'hffffffff)$fatal(1,"PREFETCH_INDEX_COVERAGE_FAIL mask=%h",seen_index);
 $display("PREFETCH_ALL_32_INDICES_PASS mask=%h",seen_index);
 $display("ROBUST_PIPELINED_CSR_FSM_PASS cycles=%0d known=%0d baseline_unknown=%0d watch=%0d advanced=%0d lock=%0d",cycles,known,unknown,watching,advanced,locking);$finish;
end
initial begin #1000000;$fatal(1,"timeout");end
endmodule
'''
    (out/'tb_robust.sv').write_bytes(tb.encode());return len(rows)

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);args=p.parse_args();out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
    cycles=fsm(out);tool=Path('D:/Xilinx/Vivado/2020.1/bin');commands=[]
    for top,files,marker in [('tb_robust',['robust_pair.v','tb_robust.sv'],'ROBUST_PIPELINED_CSR_FSM_PASS')]:
        for name,cmd,required in [('compile',[tool/'xvlog.bat','--sv',*[out/f for f in files]],None),('elaborate',[tool/'xelab.bat',top,'-s',top,'--timescale','1ns/1ps'],None),('simulate',[tool/'xsim.bat',top,'-runall'],marker)]:
            cmd=[str(v) for v in cmd];r=subprocess.run(cmd,cwd=out,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            stem=top+'_'+name;(out/(stem+'.stdout.log')).write_bytes(r.stdout);(out/(stem+'.stderr.log')).write_bytes(r.stderr)
            text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not required or required in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
            commands.append({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)});(out/'commands.json').write_bytes(json.dumps(commands,indent=2).encode())
            print(stem,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
            if required:print(re.search(required+r'[^\r\n]*',text)[0],flush=True)
    cmd=[sys.executable,'-m','pytest','tests/test_robust_autolock.py','-m','not slow','-q','--basetemp',str(out/'pytest-temp')]
    r=subprocess.run(cmd,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    (out/'pytest_robust.stdout.log').write_bytes(r.stdout);(out/'pytest_robust.stderr.log').write_bytes(r.stderr)
    ok=r.returncode==0 and re.search(rb'\b5 passed\b',r.stdout) is not None
    (out/'pytest_robust.json').write_bytes(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':ok},indent=2).encode());assert ok,(r.stdout+r.stderr).decode(errors='replace')[-5000:]
    (out/'results.json').write_bytes(json.dumps({'passed':True,'decision_latency_sys':1,'adc_dac_added_sys':0,'fsm_cycles':cycles,'existing_robust_non_slow':5,'prefetch_choice_valid_every_cycle':True,'indices_visited':32,'original_R28_vectors_preserved':50076,'original_prefix_sha256':'ca7dc8c929788b77f392e892728423677edc5173b36d061c6030df7199d14e2e','commands':commands,'scope':'Production parent FPGAAutolock+real CSR and frozen Robust with independently delayed raw inputs/configuration; includes raw request cancellation and mode gates, known/unknown RAM cycles disclosed; not physical or board proof.'},indent=2).encode())
    print('AUTOLOCK_DECISION_PIPELINE_SUITE_PASS',flush=True)
if __name__=='__main__':main()
