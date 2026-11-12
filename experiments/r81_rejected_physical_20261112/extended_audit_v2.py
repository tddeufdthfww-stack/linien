from pathlib import Path
import argparse,hashlib,json,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--trial',required=True,type=Path);p.add_argument('--label',required=True);p.add_argument('--add-io-probe',action='store_true');a=p.parse_args()
assert re.fullmatch('[a-zA-Z0-9_-]+',a.label)
base=Path(__file__).resolve().parent;out=base/a.label;out.mkdir(exist_ok=False)
dcp=a.trial.resolve()/'routed.dcp';before=hashlib.sha256(dcp.read_bytes()).hexdigest()
text=f'set out {{{out.as_posix()}}}\nset_param general.maxThreads 2\nset_param tcl.collectionResultDisplayLimit 100000\nopen_checkpoint {{{dcp.as_posix()}}}\n'
if a.add_io_probe:text+='source {D:/RP_Dev/linien_trials/20261112-r62-adc-fall-dac-fast/gateware/constraints/io_intrinsic_probe.tcl}\n'
text+=r'''
report_timing_summary -file "$out/timing.rpt"
report_exceptions -file "$out/exceptions.rpt"
report_clocks -file "$out/clocks.rpt"
check_timing -verbose -file "$out/checks.rpt"
report_timing -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 8 -file "$out/dna_setup.rpt"
report_timing -delay_type min -to [get_pins {DNA_PORT/DIN DNA_PORT/READ}] -max_paths 8 -file "$out/dna_hold.rpt"
foreach pair {{clk_fpga_0 clk_2} {clk_2 clk_fpga_0}} {
 set from [lindex $pair 0];set to [lindex $pair 1]
 foreach delay {max min} {
  set paths [get_timing_paths -from [get_clocks $from] -to [get_clocks $to] -delay_type $delay -max_paths 10000 -nworst 1]
  set f [open "$out/cdc_${from}_to_${to}_${delay}.tsv" w]
  puts $f "start\tend\tdata_ns\tlogic_ns\troute_ns\tslack\tlevels\trequirement_ns"
  foreach q $paths {set row {};foreach prop {STARTPOINT_PIN ENDPOINT_PIN DATAPATH_DELAY DATAPATH_LOGIC_DELAY DATAPATH_NET_DELAY SLACK LOGIC_LEVELS REQUIREMENT} {lappend row [get_property $prop $q]};puts $f [join $row "\t"]};close $f
 }
}
set sync [get_cells -hier -filter {ASYNC_REG == TRUE}]
report_timing -from $sync -to $sync -max_paths 1000 -file "$out/sync_setup.rpt"
report_timing -delay_type min -from $sync -to $sync -max_paths 1000 -file "$out/sync_hold.rpt"
set pair_first {};set pair_second {}
foreach c $sync {
 set loads [get_pins -leaf -of_objects [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]] -filter {DIRECTION == IN}]
 if {[llength $loads] == 1 && [get_property REF_PIN_NAME $loads] eq "D"} {
  set target [get_cells -of_objects $loads]
  if {[string is true -strict [get_property ASYNC_REG $target]] &&
      [get_property NAME [get_nets -of_objects [get_pins -of_objects $c -filter {REF_PIN_NAME == C}]]] eq [get_property NAME [get_nets -of_objects [get_pins -of_objects $target -filter {REF_PIN_NAME == C}]]]} {
   lappend pair_first [get_property NAME [get_pins -of_objects $c -filter {REF_PIN_NAME == C}]]
   lappend pair_second [get_property NAME $loads]
  }
 }
}
if {[llength $pair_first]} {
 report_timing -from [get_pins $pair_first] -to [get_pins $pair_second] -max_paths 1000 -file "$out/sync_pair_setup.rpt"
 report_timing -delay_type min -from [get_pins $pair_first] -to [get_pins $pair_second] -max_paths 1000 -file "$out/sync_pair_hold.rpt"
}
set dac_control {}
set unconnected_f [open "$out/unconnected_ff_Q.tsv" w];puts $unconnected_f "cell\tref\tQ_pin"
foreach c [get_cells -hier -filter {REF_NAME =~ FD*}] {
 set qp [get_pins -quiet -of_objects $c -filter {REF_PIN_NAME == Q}]
 set qn [get_nets -quiet -of_objects $qp]
 if {![llength $qn]} {puts $unconnected_f [join [list $c [get_property REF_NAME $c] $qp] "\t"];continue}
 set qnames [get_property NAME $qn]
 if {[regexp {linienmodule_analog_(frame|frame_seen|select_b)} $qnames] || [regexp {^FDRE_3[23]} [get_property NAME $c]]} {lappend dac_control $c}
}
close $unconnected_f
if {[llength $dac_control]} {
 report_timing -to $dac_control -max_paths 30 -file "$out/dac_control_setup.rpt"
 report_timing -delay_type min -to $dac_control -max_paths 30 -file "$out/dac_control_hold.rpt"
 report_timing -from $dac_control -max_paths 50 -file "$out/dac_control_outgoing.rpt"
}
set f [open "$out/synchronizers.tsv" w];puts $f "cell\tref\tLOC\tBEL\tC\tD\tQ\tQ_loads"
foreach c $sync {
 set row [list $c [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c]]
 foreach pin {C D Q} {lappend row [get_nets -of_objects [get_pins -of_objects $c -filter "REF_PIN_NAME == $pin"]]}
 set q [get_pins -of_objects $c -filter {REF_PIN_NAME == Q}]
 set loads {};foreach load [get_pins -leaf -of_objects [get_nets -of_objects $q] -filter {DIRECTION == IN}] {lappend loads [get_property NAME $load]}
 lappend row $loads
 puts $f [join $row "\t"]
};close $f
set ap {}
foreach pp [get_ports {adc_data_a[*] adc_data_b[*]}] {if {[regexp {^adc_data_[ab]\[([0-9]+)\]$} [get_property NAME $pp] whole index] && $index>=2} {lappend ap $pp}}
set dp [get_ports {dac_data[*]}]
foreach delay {max min} {
 report_timing -from $ap -delay_type $delay -max_paths 60 -nworst 2 -file "$out/adc_${delay}.rpt"
 report_timing -to $dp -delay_type $delay -max_paths 60 -nworst 2 -file "$out/dac_${delay}.rpt"
}
set adc_regs {}
foreach q [all_fanout -flat -endpoints_only -from $ap] {
 set c [get_cells -of_objects $q]
 if {[llength $c] && [get_property REF_NAME $c] in {FDRE FDSE FDCE FDPE}} {lappend adc_regs $c}
}
set adc_regs [lsort -unique $adc_regs]
set f [open "$out/adc_registers.tsv" w];puts $f "cell\tref\tLOC\tBEL\tIOB\tIS_C_INVERTED"
foreach c $adc_regs {puts $f [join [list $c [get_property REF_NAME $c] [get_property LOC $c] [get_property BEL $c] [get_property IOB $c] [get_property IS_C_INVERTED $c]] "\t"]};close $f
report_timing -from $adc_regs -max_paths 80 -file "$out/adc_to_consumers.rpt"
set f [open "$out/min_pulse_command_support.txt" w]
puts $f "matching_commands=[info commands *pulse*]"
set pulse_help_status [catch {help set_min_pulse_width} pulse_help]
puts $f "help_status=$pulse_help_status\nhelp_result=$pulse_help";close $f
report_drc -ruledeck bitstream_checks -file "$out/bitstream_drc.rpt"
puts EXTENDED_READONLY_AUDIT_COMPLETE
'''
text=text.replace('\\\\t','\\t')
script=out/'audit.tcl';script.write_text('if {[catch {\n'+text+'\n} msg opts]} {puts stderr "ERROR: $msg";puts stderr [dict get $opts -errorinfo];exit 3}\nexit 0\n',encoding='utf-8')
cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(script),'-log',str(out/'audit.vivado.log'),'-journal',str(out/'audit.jou')]
res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'stdout.log').write_bytes(res.stdout);(out/'stderr.log').write_bytes(res.stderr)
s=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and 'EXTENDED_READONLY_AUDIT_COMPLETE' in s and not re.search('(?m)^ERROR:',s)
record={'passed':bool(ok),'command':cmd,'input_dcp':str(dcp),'input_dcp_sha256':before,'input_dcp_unchanged':hashlib.sha256(dcp.read_bytes()).hexdigest()==before,'io_probe_added_in_memory':a.add_io_probe}
(out/'result.json').write_text(json.dumps(record,indent=2),encoding='utf-8')
print(record,flush=True)
assert ok,s[-4000:]
