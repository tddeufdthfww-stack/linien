from pathlib import Path
import hashlib,json,re,subprocess
b=Path(__file__).resolve().parent;r=Path('D:/RP_Dev/linien_trials/20261112-r80-status-cluster');trial=r/'gateware/build/trials/20261112_r80_status_cluster';out=b/'r80_drc_structural_review03_20261112';out.mkdir(exist_ok=False)
dcp=trial/'routed.dcp';digest=hashlib.sha256(dcp.read_bytes()).hexdigest();assert digest=='82adfcf0187ddf27c15c5cc54f8cfcbf9a927faa3fe3443886e752b65f13273'.replace('927faa','9279faa')
report=(trial/'routed_drc.rpt').read_text();section=re.search(r'RTSTAT-10#1.*?problem bus\(es\) and/or net\(s\) are (.*?)\nRelated violations:',report,re.S)[1]
header=f'set_param general.maxThreads 2\nopen_checkpoint {{{dcp.as_posix()}}}\nset out {{{out.as_posix()}}}\n'
tcl=header+r'''
report_drc -checks [get_drc_checks RTSTAT-10] -file "$out/no_load_drc.rpt"
set violations [get_drc_violations -filter {NAME =~ RTSTAT-10*}]
set names [get_nets -of_objects $violations]
if {[llength $names]!=84} {error "Expected exact84 no-load nets, got [llength $names]"}
set f [open "$out/no_loads.tsv" w];puts $f "net\tleaf_input_pins\toutput_ports\tloads"
foreach name $names {
 set net [get_nets -quiet $name]
 if {[llength $net]!=1} {error "No-load exact net missing $name"}
 set segments [get_nets -segments $net]
 set loads [get_pins -leaf -of_objects $segments -filter {DIRECTION == IN}]
 set ports [get_ports -of_objects $segments -filter {DIRECTION == OUT}]
 puts $f [join [list $name [llength $loads] [llength $ports] $loads] "\t"]
}
close $f
set f [open "$out/opmode.tsv" w];puts $f "pin\tnet\tdriver\tconstant"
foreach i {0 1 2 3 4 5 6} {
 set pin [get_pins [format {p_1_out/OPMODE[%d]} $i]]
 set net [get_nets -segments -of_objects $pin]
 set driver [get_pins -leaf -of_objects $net -filter {DIRECTION == OUT}]
 puts $f [join [list $i $net $driver [get_property TYPE [get_nets -of_objects $pin]]] "\t"]
}
close $f
report_property [get_cells p_1_out] -file "$out/dsp_properties.rpt"
report_route_status -file "$out/route_status.rpt"
report_drc -ruledecks bitstream_checks -file "$out/bitstream_drc.rpt"
puts R80_DRC_STRUCTURAL_EXPORT_COMPLETE
'''
(out/'review.tcl').write_text(tcl,encoding='utf-8');cmd=['D:/Xilinx/Vivado/2020.1/bin/vivado.bat','-mode','batch','-source',str(out/'review.tcl'),'-log',str(out/'vivado.log'),'-journal',str(out/'vivado.jou')]
res=subprocess.run(cmd,cwd=out,capture_output=True);(out/'stdout.log').write_bytes(res.stdout);(out/'stderr.log').write_bytes(res.stderr)
ok=res.returncode==0 and b'R80_DRC_STRUCTURAL_EXPORT_COMPLETE'in res.stdout
result={'export_complete':ok,'unchanged':digest==hashlib.sha256(dcp.read_bytes()).hexdigest(),'dcp_sha256':digest,'command':cmd,'no_load_nets_expected':84,'scope':'Exact no-load pins and dynamic OPMODE source connections. Not a waiver, analog glitch proof or whole design release.'}
(out/'results.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print(result,flush=True)
if not ok:print(res.stdout.decode(errors='replace')[-3000:]);print(res.stderr.decode(errors='replace')[-1500:]);raise SystemExit(1)
