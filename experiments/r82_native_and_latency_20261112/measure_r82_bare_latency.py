"""Canonical P-only Bare PID FPGA digital-segment latency, not board latency.

Compose the actual Analog -> PID -> fast LimitCSR -> Analog/ODDR components.
Unused sweep/modulation/offset/slow contributions are zero in this configuration.
Includes the explicit top-level fast_outs -> LimitCSR.x register.
No PS, converter internal latency, analog plant or post-route SDF is modeled.
"""
from pathlib import Path
import argparse,hashlib,json,os,re,subprocess,sys

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',type=Path,required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args()
    root=a.root.resolve();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    sys.path[:0]=[str(root),str(root/'linien-common')]
    from migen import ClockDomain,Module,Signal
    from migen.genlib.record import Record
    from migen.fhdl import verilog
    from migen.genlib.resetsync import AsyncResetSynchronizer
    from migen.build.xilinx.common import XilinxAsyncResetSynchronizer
    import importlib.util
    spec=importlib.util.spec_from_file_location('frozen_r80_analog',root/'gateware/tests/timing/reference/r80_analog.py')
    frozen=importlib.util.module_from_spec(spec);spec.loader.exec_module(frozen)
    from misoc.interconnect.csr_bus import CSRBank
    from gateware.logic.pid import PID
    from gateware.logic.pid_pipeline import PipelinedPID
    from gateware.logic.feedback_pipeline import MixerAlignedPID,FeedbackInputAlignment
    from gateware.logic.limit import LimitCSR
    from gateware.lowlevel.analog import PitayaAnalog
    class Pair(Module):
        def __init__(self):
            self.clock_domains.cd_sys=ClockDomain('sys')
            self.clock_domains.cd_sys_double=ClockDomain('sys_double',reset_less=True)
            self.clock_domains.cd_dac_2p=ClockDomain('dac_2p',reset_less=True)
            self.ports={}
            for name,width in [('adc_word',16),('csr_adr',14),('csr_we',1),('csr_dat_w',8)]:self.ports[name]=Signal(width,name_override=name)
            addresses=[]
            for prefix,factory in [('ref',MixerAlignedPID),('cand',MixerAlignedPID)]:
                adc=Record([('data_a',16),('data_b',16),('cdcs',1),('clk',2)])
                dac=Record([('data',14),('clk',1),('wrt',1),('sel',1),('rst',1)])
                analog=frozen.PitayaAnalog(adc,dac) if prefix=="ref" else PitayaAnalog(adc,dac,regional_dac=True);core=factory(width=25,frame_delay=2);limit=LimitCSR(width=14,guard=5)
                setattr(self.submodules,prefix+'_analog',analog);setattr(self.submodules,prefix+'_pid',core);setattr(self.submodules,prefix+'_limit',limit)
                bank=CSRBank(core.get_csrs());setattr(self.submodules,prefix+'_bank',bank)
                self.comb += [adc.data_a.eq(self.ports['adc_word']),adc.data_b.eq(0x7ffc),
                    core.running.eq(1),core.update_en.eq(1),
                    analog.dac_a.eq(limit.y),analog.dac_b.eq(0),
                    bank.bus.adr.eq(self.ports['csr_adr']),bank.bus.we.eq(self.ports['csr_we']),bank.bus.dat_w.eq(self.ports['csr_dat_w'])]
                # LinienModule registers fast_outs into limit_fast.x explicitly.
                self.sync += limit.x.eq(core.pid_out>>11)
                if prefix in ('ref','cand'):
                    alignment=FeedbackInputAlignment(frame_delay=2);setattr(self.submodules,prefix+'_alignment',alignment)
                    self.comb += [alignment.direct_adc.eq(analog.adc_a),alignment.pid_only.eq(1),alignment.mixed_error.eq(0),core.input.eq(alignment.output)]
                else:self.comb += core.input.eq(analog.adc_a<<11)
                for suffix,width,value in [('data',14,dac.data),('wrt',1,dac.wrt),('sel',1,dac.sel),('kp',14,core.kp.storage)]:
                    q=Signal(width,name_override=prefix+'_'+suffix);self.ports[prefix+'_'+suffix]=q;self.comb += q.eq(value)
                addresses.append([(bank.simple_csrs.index(csr),csr.size) for csr in core.kp.simple_csrs])
            assert addresses[0]==addresses[1];self.kp_bytes=addresses[0]
    dut=Pair();ios=set(dut.ports.values())|{dut.cd_sys.clk,dut.cd_sys.rst,dut.cd_sys_double.clk,dut.cd_dac_2p.clk}
    verilog.convert(dut,ios=ios,name='latency_pair',special_overrides={AsyncResetSynchronizer:XilinxAsyncResetSynchronizer}).write(str(out/'latency_pair.v'))
    remaining=14;writes=[]
    for adr,width in dut.kp_bytes:
        remaining-=width;value=(4096>>remaining)&((1<<width)-1);writes.append(f'write_byte(14\'d{adr},8\'d{value});')
    tb='''`timescale 1ns/1ps
module tb_latency;
reg sys_clk=0;always #4 sys_clk=~sys_clk;
reg sys_double_clk=1;always #2 sys_double_clk=~sys_double_clk;
reg dac_2p_clk=0;initial begin #1.5;forever #2 dac_2p_clk=~dac_2p_clk;end
reg sys_rst=1;reg [15:0] adc_word=16'h7ffc;reg [13:0] csr_adr=0;reg csr_we=0;reg [7:0] csr_dat_w=0;
wire [13:0] ref_data,cand_data,ref_kp,cand_kp;wire ref_wrt,cand_wrt,ref_sel,cand_sel;
latency_pair dut(.*);
integer cycle=0,sample_cycle=0,ref_cycle=-1,cand_cycle=-1;
always @(posedge sys_clk)cycle=cycle+1;
reg armed=0;reg [13:0] target;real sample_time,ref_time=-1,cand_time=-1,ref_write=-1,cand_write=-1;
always @(ref_data)if(armed && ref_data===target && ref_time<0)begin ref_time=$realtime;ref_cycle=cycle;end
always @(cand_data)if(armed && cand_data===target && cand_time<0)begin cand_time=$realtime;cand_cycle=cycle;end
always @(posedge ref_wrt)if(armed && ref_data===target && ref_sel==0 && ref_write<0)ref_write=$realtime;
always @(posedge cand_wrt)if(armed && cand_data===target && cand_sel==0 && cand_write<0)cand_write=$realtime;
task write_byte(input [13:0] adr,input [7:0] value);
 begin @(negedge sys_clk);csr_adr=adr;csr_dat_w=value;csr_we=1;
 @(negedge sys_clk);csr_we=0;end
endtask
task pulse(input [15:0] word_value,input [13:0] expected,input integer amplitude);
 begin
  armed=0;ref_time=-1;cand_time=-1;ref_write=-1;cand_write=-1;ref_cycle=-1;cand_cycle=-1;
  repeat(8)@(posedge sys_clk);
  @(negedge sys_clk);target=expected;sample_time=$realtime+4;sample_cycle=cycle+1;adc_word=word_value;armed=1;
  @(negedge sys_clk);adc_word=16'h7ffc;
  repeat(20)@(posedge sys_clk);#1;
  if(ref_time<0 || cand_time<0 || ref_write<0 || cand_write<0)$fatal(1,"missing pulse ref=%f cand=%f wrref=%f wrcand=%f nowdata=%h/%h target=%h",ref_time,cand_time,ref_write,cand_write,ref_data,cand_data,target);
  if(cand_cycle-ref_cycle!= -1 || cand_time-ref_time< -0.501 || cand_time-ref_time> -0.499)$fatal(1,"subcycle data phase delta failed");
  if(cand_cycle-sample_cycle!=8 || ref_cycle-sample_cycle!=9 || cand_time-sample_time<71.599 || cand_time-sample_time>71.601)$fatal(1,"absolute ADC-sample-to-DAC-data latency failed");
  if(cand_write-ref_write< -0.251 || cand_write-ref_write> -0.249)$fatal(1,"DAC WRT phase-only delta failed");
  $display("R82_BARE_DIGITAL_LATENCY amplitude=%0d ref_cycles=%0d cand_cycles=%0d ref_dq_ns=%0.3f cand_dq_ns=%0.3f ref_wrt_ns=%0.3f cand_wrt_ns=%0.3f delta_ns=%0.3f",amplitude,ref_cycle-sample_cycle,cand_cycle-sample_cycle,ref_time-sample_time,cand_time-sample_time,ref_write-sample_time,cand_write-sample_time,cand_time-ref_time);
  armed=0;
 end
endtask
initial begin
 repeat(20)@(posedge sys_clk);@(negedge sys_clk);sys_rst=0;
 WRITES
 repeat(300)@(posedge sys_clk);#1;
 if(ref_kp!==14'd4096 || cand_kp!==14'd4096)$fatal(1,"KP configuration failed");
 pulse(16'h7e10,14'h1f84,123);
 pulse(16'h81e8,14'h207a,-123);
 $display("R82_BARE_DIGITAL_LATENCY_PASS");$finish;
end
initial begin #10000;$fatal(1,"timeout");end
endmodule
'''.replace('WRITES','\n '.join(writes))
    (out/'tb_latency.sv').write_bytes(tb.encode())
    tool=Path('D:/Xilinx/Vivado/2020.1/bin');glbl=tool.parent/'data/verilog/src/glbl.v';commands=[];observations=[]
    for name,cmd,marker in [('compile',[tool/'xvlog.bat','--sv',out/'latency_pair.v',out/'tb_latency.sv',glbl],None),
        ('elaborate',[tool/'xelab.bat','tb_latency','glbl','-L','unisims_ver','-L','unimacro_ver','-s','tb_latency','--timescale','1ns/1ps'],None),
        ('simulate',[tool/'xsim.bat','tb_latency','-runall'],'R82_BARE_DIGITAL_LATENCY_PASS')]:
        cmd=[str(v) for v in cmd];r=subprocess.run(cmd,cwd=out,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        (out/(name+'.stdout.log')).write_bytes(r.stdout);(out/(name+'.stderr.log')).write_bytes(r.stderr)
        text=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in text) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text)
        commands.append({'command':cmd,'exit_code':r.returncode,'passed':bool(ok)});(out/'commands.json').write_bytes(json.dumps(commands,indent=2).encode())
        print(name,'PASS' if ok else 'FAIL',flush=True);assert ok,text[-6000:]
        if marker:observations=re.findall(r'^R82_BARE_DIGITAL_LATENCY [^\r\n]+',text,re.M);print('\n'.join(observations),flush=True)
    inputs={rel:hashlib.sha256((root/rel).read_bytes()).hexdigest() for rel in ['gateware/lowlevel/analog.py','gateware/lowlevel/crg.py','gateware/logic/pid.py','gateware/logic/pid_pipeline.py','gateware/logic/pid_output_limit.py','gateware/logic/limit.py','gateware/linien_module.py','gateware/logic/feedback_pipeline.py','gateware/lowlevel/dac_regional_clock.py','gateware/tests/timing/reference/r80_analog.py']}
    results={'passed':True,'configuration':'Frozen R80 analog vs R82 actual regional MMCM/BUFIO analog with identical current two-frame aligned PID/FeedbackInputAlignment and real CSRBank; P-only Bare PID, KP4096, KI/KD/setpoint0, running1, zero sweep/mod/offset/slow, full-range limits, includes top-level fast_outs input FF; not full Root or analog board latency',
        'clock_period_ns':8,'reference_dac_clock_phase_deg_at_250MHz':-45,'candidate_sample_mmcm_phase_deg':-135,'candidate_wrt_mmcm_phase_deg':-22.5,'observations':observations,'inputs':inputs,
        'scope':'Actual components composed for this configuration; XSim with actual secondary MMCM/BUFIO/IOB/ODDR UNISIM; SYS clocks ideal, original CRG not instantiated here. FPGA digital segment only, not full-root/SDF/board or converter/analog latency.'}
    (out/'results.json').write_bytes(json.dumps(results,indent=2).encode());print('DIGITAL_LATENCY_MEASUREMENT_COMPLETE',flush=True)
if __name__=='__main__':main()
