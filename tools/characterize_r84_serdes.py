"""Real standalone synthesis/route comparison; never writes bitstreams."""
from pathlib import Path
import argparse, hashlib, json, re, subprocess
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);p.add_argument('--mode',choices=['reference','serdes'],required=True);a=p.parse_args()
out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
src=ROOT/'gateware/tests/timing/r84/dac_serdes_probe.v'
pins={'clk125_p':'U18','clk125_n':'U19','reset_i':'G17','dac_wrt':'M17','dac_clk':'M18','dac_sel':'N16','dac_rst':'N15'}
pins.update({f'dac_data[{i}]':v for i,v in enumerate('M19 M20 L19 L20 K19 J19 J20 H20 G19 G20 F19 F20 D20 D19'.split())})
xdc=['create_clock -name clk125 -period 8.000 [get_ports clk125_p]']
for port,pin in pins.items():
 xdc.append(f'set_property PACKAGE_PIN {pin} [get_ports {{{port}}}]')
 xdc.append(f'set_property IOSTANDARD {"DIFF_HSTL_I_18" if port.startswith("clk125_") else "LVCMOS33"} [get_ports {{{port}}}]')
xdc+=['set_property DRIVE 8 [get_ports {dac_data[*] dac_wrt dac_clk dac_sel dac_rst}]','set_property SLEW FAST [get_ports {dac_data[*] dac_wrt dac_clk dac_sel dac_rst}]']
(out/'pins.xdc').write_text('\n'.join(xdc)+'\n',encoding='utf-8')
tcl=r'''
set_param general.maxThreads 2
read_verilog {%SOURCE%}
read_xdc {%OUT%/pins.xdc}
synth_design -top dac_serdes_probe -part xc7z020clg400-1 -generic USE_SERDES=%USE%
proc forwarding_clock {port clock_name} {
 set obuf [get_cells -of_objects [get_nets -of_objects [get_ports $port]] -filter {REF_NAME == OBUF}]
 if {[llength $obuf]!=1} {error "Ambiguous output buffer $port: $obuf"}
 set net [get_nets -segments -of_objects [get_pins $obuf/I]]
 set drivers [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 set driver [get_cells -of_objects $drivers]
 if {[llength $driver]!=1} {error "Ambiguous forwarded driver $port: $driver"}
 set ref [get_property REF_NAME $driver]
 if {$ref eq "ODDR"} {set clockpin C} elseif {$ref eq "OSERDESE2"} {set clockpin CLK} else {error "Unknown forwarding primitive $ref"}
 create_generated_clock -name $clock_name -source [get_pins $driver/$clockpin] -divide_by 1 -invert [get_ports $port]
 puts "R84_FORWARD_CLOCK $port $driver/$clockpin inverted true"
}
forwarding_clock dac_wrt dac_wrt_forward
forwarding_clock dac_clk dac_clk_forward
set_output_delay -clock dac_wrt_forward -max 2.000 [get_ports {dac_data[*]}]
set_output_delay -clock dac_wrt_forward -min -1.500 [get_ports {dac_data[*]}]
report_timing_summary -delay_type min_max -file {%OUT%/synth_timing.rpt}
write_checkpoint {%OUT%/synth.dcp}
opt_design
place_design
phys_opt_design
route_design
report_route_status -file {%OUT%/route_status.rpt}
report_timing_summary -delay_type min_max -report_unconstrained -file {%OUT%/routed_timing.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type max -path_type full_clock_expanded -input_pins -max_paths 28 -file {%OUT%/data_setup.rpt}
report_timing -to [get_ports {dac_data[*]}] -delay_type min -path_type full_clock_expanded -input_pins -max_paths 28 -file {%OUT%/data_hold.rpt}
report_timing -delay_type max -path_type full_clock_expanded -input_pins -max_paths 40 -file {%OUT%/worst_setup.rpt}
report_timing -delay_type min -path_type full_clock_expanded -input_pins -max_paths 40 -file {%OUT%/worst_hold.rpt}
report_clocks -file {%OUT%/clocks.rpt}
report_clock_utilization -file {%OUT%/clock_utilization.rpt}
report_drc -file {%OUT%/drc.rpt}
report_cdc -details -file {%OUT%/cdc.rpt}
check_timing -verbose -file {%OUT%/check_timing.rpt}
report_utilization -file {%OUT%/utilization.rpt}
write_checkpoint {%OUT%/routed.dcp}
set f [open {%OUT%/paths.tsv} w]
puts $f "port\tdelay_type\tslack\tdatapath_delay\tstartpoint\tendpoint"
foreach port [get_ports {dac_data[*]}] {
 foreach typ {max min} {
  set p [get_timing_paths -to $port -delay_type $typ -max_paths 1]
  if {[llength $p]} {puts $f "$port\t$typ\t[get_property SLACK $p]\t[get_property DATAPATH_DELAY $p]\t[get_property STARTPOINT_PIN $p]\t[get_property ENDPOINT_PIN $p]"}
 }
}
close $f
puts R84_PROBE_ROUTE_COMPLETE
'''.replace('%SOURCE%',src.as_posix()).replace('%OUT%',out.as_posix()).replace('%USE%','0' if a.mode=='reference' else '1')
(out/'run.tcl').write_text(tcl,encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(out/'run.tcl'),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
with (out/'stdout.log').open('wb') as so,(out/'stderr.log').open('wb') as se:r=subprocess.run(cmd,cwd=out,stdout=so,stderr=se)
log=(out/'stdout.log').read_text(errors='replace')+'\n'+(out/'stderr.log').read_text(errors='replace')
ok=r.returncode==0 and 'R84_PROBE_ROUTE_COMPLETE' in log and not re.search(r'(?m)^ERROR:',log)
result={'mode':a.mode,'route_completed':ok,'command':cmd,'exit_code':r.returncode,'input_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),'scope':'standalone characterization, not whole Linien; no PCB delay invented; async reset input unbudgeted; no bitstream'}
if (out/'routed.dcp').exists():result['dcp_sha256']=hashlib.sha256((out/'routed.dcp').read_bytes()).hexdigest()
(out/'results.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print(json.dumps(result),flush=True)
if not ok:print(log[-6000:]);raise SystemExit(1)
print('R84_PROBE_PHYSICAL_COMPLETE',flush=True)
