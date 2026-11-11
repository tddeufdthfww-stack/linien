"""Shared-clock DAC and rising IOB ADC vs frozen R61b, including startup.

Clock/data delays below are functional envelope cases, not measured SDF.
PVT and PCB timing must be assessed independently from routed reports.
"""
from pathlib import Path
import argparse, hashlib, importlib.util, json, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'linien-common')]
from migen import Cat, ClockDomain, Module, Record, Signal
from migen.fhdl import verilog
from gateware.lowlevel.analog import PitayaAnalog


def main():
    p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path)
    args=p.parse_args();out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
    reference=ROOT/'gateware/tests/timing/reference/r61b_analog.py'
    spec=importlib.util.spec_from_file_location('r61b_frozen_analog',reference)
    ref=importlib.util.module_from_spec(spec);spec.loader.exec_module(ref)
    d=Module();d.clock_domains.cd_sys=ClockDomain('sys')
    d.clock_domains.cd_sys_double=ClockDomain('sys_double',reset_less=True)
    d.clock_domains.cd_dac_2p=ClockDomain('dac_2p',reset_less=True)
    ports={'sys_clk':d.cd_sys.clk,'sys_rst':d.cd_sys.rst,
           'sys_double_clk':d.cd_sys_double.clk,'dac_2p_clk':d.cd_dac_2p.clk,
           'adc_data_a':Signal(16),'adc_data_b':Signal(16),
           'dac_a':Signal((14,True)),'dac_b':Signal((14,True))}
    for label,cls in [('old',ref.PitayaAnalog),('new',PitayaAnalog)]:
        adc=Record([('data_a',16),('data_b',16),('clk',2),('cdcs',1)])
        dac=Record([('data',14),('rst',1),('sel',1),('clk',1),('wrt',1)])
        module=cls(adc,dac);setattr(d.submodules,label,module)
        d.comb += [adc.data_a.eq(ports['adc_data_a']),adc.data_b.eq(ports['adc_data_b']),
                   module.dac_a.eq(ports['dac_a']),module.dac_b.eq(ports['dac_b'])]
        signals=[module.adc_a,module.adc_b,dac.data,adc.clk,adc.cdcs,dac.rst,dac.sel,dac.clk,dac.wrt]
        packed=Signal(49);ports[label+'_outputs']=packed;d.comb+=packed.eq(Cat(*signals))
        ports[label+'_adc_a']=module.adc_a;ports[label+'_adc_b']=module.adc_b
    for name,s in ports.items():s.name_override=name
    generated=verilog.convert(d,ios=set(ports.values()),name='analog_pair')
    generated.write(str(out/'pair.v'))
    assert (out/'pair.v').read_text().count('.IS_C_INVERTED(1\'d0)')==32
    assert (out/'pair.v').read_text().count('.DDR_CLK_EDGE("SAME_EDGE")')==14
    assert (out/'pair.v').read_text().count('.IS_C_INVERTED(1\'d1)')==2
    tb=r'''`timescale 1ns/1ps
module tb_r64_analog;
localparam real PHI=PHI_VALUE, BUFFER=BUFFER_VALUE;
reg clk125_pad=1;always #4 clk125_pad=~clk125_pad;
// Explicit phase-started oscillators: a continuous assignment with #PHI
// would inertially suppress pulses when PHI exceeds a half period.
reg sys_clk=0;initial begin #(PHI);sys_clk=1;forever #4 sys_clk=~sys_clk;end
reg sys_double_clk=0;initial begin #(PHI);sys_double_clk=1;forever #2 sys_double_clk=~sys_double_clk;end
reg dac_2p_clk=0;initial begin #(PHI);dac_2p_clk=1;#1.5;dac_2p_clk=0;forever #2 dac_2p_clk=~dac_2p_clk;end
reg sys_rst=1;reg[15:0]adc_data_a=0,adc_data_b=0;
reg[13:0]dac_a=0,dac_b=0;
wire[48:0]old_outputs,new_outputs;
wire[13:0]old_adc_a,old_adc_b,new_adc_a,new_adc_b;
analog_pair dut(.*);
integer k=0,i,seed=2026111263,checked=0,reset_checks=0,paired_checks=0,source_index;
reg[15:0]word_a=0,word_b=0;
reg[13:0]expected_a=14'h1fff,expected_b=14'h1fff,last_a=14'h1fff,last_b=14'h1fff;
reg[13:0]old_cons_a=0,new_cons_a=0,old_cons_b=0,new_cons_b=0;
reg[16383:0]seen_a=0,seen_b=0;
function automatic[13:0]encode(input[15:0]v);encode=v[15:2]^14'h1fff;endfunction
always@(posedge sys_clk)begin
 old_cons_a<=old_adc_a;new_cons_a<=new_adc_a;old_cons_b<=old_adc_b;new_cons_b<=new_adc_b;
 // Independent cycle/time oracle. Reading word_a here would use the previous
 // testbench assignment when PHI=0 and incorrectly accept a stale word.
 source_index=$rtoi(($realtime-PHI)/8.0)-1;
 if(source_index>32831)source_index=32831;
 expected_a=sys_rst?14'h1fff:encode({source_index[13:0],source_index[1:0]});
 expected_b=sys_rst?14'h1fff:encode({~source_index[13:0],~source_index[1:0]});
 #0.2;
 if(k>20)begin
  if(old_adc_a!==expected_a || new_adc_a!==expected_a || old_adc_b!==expected_b || new_adc_b!==expected_b)
   $fatal(1,"ADC_WORD_INDEX_FAIL k=%0d phi=%0.3f a=%h/%h/%h b=%h/%h/%h",k,PHI,old_adc_a,new_adc_a,expected_a,old_adc_b,new_adc_b,expected_b);
  if(old_cons_a!==last_a || new_cons_a!==last_a || old_cons_b!==last_b || new_cons_b!==last_b)
   $fatal(1,"ADC_NEXT_CONSUMER_WORD_FAIL k=%0d",k);
  checked=checked+1;
  if(sys_rst)reset_checks=reset_checks+1;
  else begin seen_a[word_a[15:2]]=1;seen_b[word_b[15:2]]=1;end
 end
 last_a=expected_a;last_b=expected_b;
end
always@(posedge sys_double_clk or negedge sys_double_clk)begin
 #0.2;
 if($realtime>2)begin
  if(old_outputs!==new_outputs)$fatal(1,"ANALOG_SETTLED_PAIR_MISMATCH k=%0d",k);
  paired_checks=paired_checks+1;
 end
end
initial begin
 for(k=0;k<32832;k=k+1)begin
  @(posedge clk125_pad);#0.01;
  word_a={k[13:0],k[1:0]};word_b={~k[13:0],~k[1:0]};
  for(i=0;i<16;i=i+1)begin
   adc_data_a[i]<=#(BUFFER+(i%7)*0.1)word_a[i];
   adc_data_b[i]<=#(BUFFER+((15-i)%7)*0.1)word_b[i];
  end
  sys_rst=(k<20 || (k>=16410 && k<16415));
  dac_a=$random(seed);dac_b=$random(seed);
 end
 repeat(2)@(negedge sys_clk);#1;
 if(checked<32800 || reset_checks!=5 || (&seen_a)!==1 || (&seen_b)!==1 || paired_checks<130000)
  $fatal(1,"R64_COVERAGE_FAIL checks=%0d resets=%0d all=%b/%b paired=%0d",checked,reset_checks,&seen_a,&seen_b,paired_checks);
 $display("R64_ANALOG_SAME_WORD_NATIVE_PASS checks=%0d paired=%0d full14bit_both_lanes=1 reset_checks=%0d phi=%0.3f buffer=%0.3f",checked,paired_checks,reset_checks,PHI,BUFFER);
 $finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
'''
    tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
    for index,(phi,buffer,negative) in enumerate([(1.5,.5,False),(2,.65,False),(3.5,.85,False),(5.5,1,False),(0,.5,True)]):
        case=out/('case_'+str(index));case.mkdir()
        (case/'tb.sv').write_text(tb.replace('PHI_VALUE',str(phi)).replace('BUFFER_VALUE',str(buffer)),encoding='utf-8')
        commands=[('compile',[tool/'xvlog.bat','--sv',tool.parent/'data/verilog/src/glbl.v',out/'pair.v',case/'tb.sv']),
                  ('elaborate',[tool/'xelab.bat','-L','unisims_ver','tb_r64_analog','glbl','--timescale','1ns/1ps','-s','r64_analog']),
                  ('simulate',[tool/'xsim.bat','r64_analog','-runall'])]
        for label,cmd in commands:
            cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=case,capture_output=True)
            (case/(label+'.stdout.log')).write_bytes(res.stdout);(case/(label+'.stderr.log')).write_bytes(res.stderr)
            text=(res.stdout+b'\n'+res.stderr).decode(errors='replace')
            if label=='simulate' and negative:
                ok=res.returncode==0 and 'Fatal: ADC_WORD_INDEX_FAIL' in text and 'R64_ANALOG_SAME_WORD_NATIVE_PASS' not in text
            else:
                ok=res.returncode==0 and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',text) and (label!='simulate' or 'R64_ANALOG_SAME_WORD_NATIVE_PASS' in text)
            (case/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok),'expected_word_index_failure':negative and label=='simulate'},indent=2),encoding='utf-8')
            assert ok,text[-5000:]
        results.append({'phi_ns':phi,'data_buffer_ns':buffer,'passed':True,'negative_control_expected_word_failure':negative})
        print('R64_ANALOG_CASE_PASS',index,'EXPECTED_WORD_FAILURE' if negative else 'FUNCTIONAL',flush=True)
    (out/'results.json').write_text(json.dumps({'passed':True,'cases':results,
        'new_serial_sys_stages':0,'rtl_edge':'Rising, same as frozen R61b',
        'scope':'Settled outputs of actual new Migen+UNISIM analog vs frozen R61b analog; source word tags and next consumer; both full 14bit lanes, perbit skew, reset, DAC slots. Functional envelope models, not SDF/PVT/PCB signoff.',
        'production_sha256':hashlib.sha256((ROOT/'gateware/lowlevel/analog.py').read_bytes()).hexdigest(),
        'frozen_r61b_sha256':hashlib.sha256(reference.read_bytes()).hexdigest()},indent=2),encoding='utf-8')
    print('R64_ANALOG_SUITE_PASS',flush=True)


if __name__=='__main__':main()
