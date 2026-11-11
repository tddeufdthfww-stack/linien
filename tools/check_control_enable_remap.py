"""Actual post-opt fabric netlist vs native original CE flops; no timing claim."""
from pathlib import Path
import argparse,csv,json,re,subprocess
TOOL=Path('D:/Xilinx/Vivado/2020.1/bin')

def run(out,label,cmd,marker=None):
    cmd=list(map(str,cmd));r=subprocess.run(cmd,cwd=out,capture_output=True)
    (out/(label+'.stdout.log')).write_bytes(r.stdout);(out/(label+'.stderr.log')).write_bytes(r.stderr)
    t=(r.stdout+b'\n'+r.stderr).decode(errors='replace');ok=r.returncode==0 and (not marker or marker in t) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',t)
    (out/(label+'.json')).write_text(json.dumps({'command':cmd,'exit_code':r.returncode,'passed':bool(ok),'marker':marker},indent=2),encoding='utf-8')
    print(label,'PASS' if ok else 'FAIL',flush=True);assert ok,t[-7000:]
    if marker:print(re.search(marker+r'[^\r\n]*',t)[0],flush=True)

def main():
    p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False)
    source='''module ce_leaf(input clk,input rst14,ce14,input [13:0] din14,input rst25,ce25,input [24:0] din25,
output reg [13:0] qr14=14'd0,qs14=14'h3fff,output reg [24:0] qr25=25'd0,qs25=25'h1ffffff);
always @(posedge clk) begin
 if(rst14) begin qr14<=0;qs14<=14'h3fff;end else if(ce14)begin qr14<=din14;qs14<=din14;end
 if(rst25) begin qr25<=0;qs25<=25'h1ffffff;end else if(ce25)begin qr25<=din25;qs25<=din25;end
end
endmodule
''';(out/'leaf.v').write_text(source,encoding='ascii')
    tcl='''proc ff_table {file} {
 set f [open $file w];puts $f "cell\\tref\\tCE_net\\tCE_driver_ref\\tINIT"
 foreach c [get_cells -hier -filter {REF_NAME == FDRE || REF_NAME == FDSE}] {
  set p [get_pins -of_objects $c -filter {REF_PIN_NAME == CE}]
  set n [get_nets -of_objects $p]
  set d [get_cells -quiet -of_objects [get_pins -quiet -of_objects $n -filter {DIRECTION == OUT}]]
  set dtype INPUT_PORT
  if {[llength $d]} {set dtype [get_property REF_NAME $d]}
  puts $f "$c\\t[get_property REF_NAME $c]\\t$n\\t$dtype\\t[get_property INIT $c]"
 };close $f
}
read_verilog leaf.v
synth_design -top ce_leaf -part xc7z020clg400-1 -mode out_of_context
create_clock -period 8 [get_ports clk]
ff_table before.tsv
set ffs [get_cells -hier -filter {REF_NAME == FDRE || REF_NAME == FDSE}]
if {[llength $ffs]!=78} {error "unexpected leaf FF count"}
source __REMAP_SCRIPT__
if {[explicit_enable_to_d $ffs]!=78} {error "unexpected remap count"}
opt_design
ff_table after.tsv
if {[llength [get_cells -hier -filter {REF_NAME == FDRE || REF_NAME == FDSE}]]!=78} {error "leaf register count changed"}
write_verilog -force -mode funcsim -rename_top ce_leaf_mapped mapped.v
write_checkpoint leaf_opt.dcp
puts CONTROL_ENABLE_LEAF_OPT_COMPLETE
exit 0
''';tcl=tcl.replace('__REMAP_SCRIPT__','{'+(Path(__file__).with_name('control_enable_remap.tcl').as_posix())+'}');(out/'leaf.tcl').write_text(tcl,encoding='ascii')
    run(out,'opt',[TOOL/'vivado.bat','-mode','batch','-source',out/'leaf.tcl','-log',out/'vivado.log','-journal',out/'vivado.jou'],'CONTROL_ENABLE_LEAF_OPT_COMPLETE')
    before=list(csv.DictReader((out/'before.tsv').open(),delimiter='\t'));after=list(csv.DictReader((out/'after.tsv').open(),delimiter='\t'))
    assert len(before)==len(after)==78 and all(row['CE_driver_ref']=='VCC' for row in after),after[:4]
    bench='''`timescale 1ns/1ps
module tb_ce_remap;
reg clk=0;always #4 clk=~clk;
reg rst14=1,ce14=0,rst25=1,ce25=0;reg [13:0] din14=0;reg [24:0] din25=0;
wire [13:0] qr14,qs14,ref_r14,ref_s14;wire [24:0] qr25,qs25,ref_r25,ref_s25;
ce_leaf_mapped dut(.*);
genvar g;
generate for(g=0;g<14;g=g+1)begin:ref14
 FDRE #(.INIT(1'b0)) r(.C(clk),.R(rst14),.CE(ce14),.D(din14[g]),.Q(ref_r14[g]));
 FDSE #(.INIT(1'b1)) s(.C(clk),.S(rst14),.CE(ce14),.D(din14[g]),.Q(ref_s14[g]));
end
for(g=0;g<25;g=g+1)begin:ref25
 FDRE #(.INIT(1'b0)) r(.C(clk),.R(rst25),.CE(ce25),.D(din25[g]),.Q(ref_r25[g]));
 FDSE #(.INIT(1'b1)) s(.C(clk),.S(rst25),.CE(ce25),.D(din25[g]),.Q(ref_s25[g]));
end endgenerate
integer i,cycles=0;integer seed=2026111139;
always @(posedge clk)begin
 #1;if({qr14,qs14,qr25,qs25}!=={ref_r14,ref_s14,ref_r25,ref_s25})
 $fatal(1,"CE_REMAP_DIFF cycle=%0d ctl=%b%b%b%b d14=%h actual=%h/%h ref=%h/%h d25=%h actual=%h/%h ref=%h/%h",cycles,rst14,ce14,rst25,ce25,din14,qr14,qs14,ref_r14,ref_s14,din25,qr25,qs25,ref_r25,ref_s25);
 cycles=cycles+1;
end
initial begin
 repeat(25)@(negedge clk);
 for(i=0;i<40000;i=i+1)begin
  @(negedge clk);ce14=i[0];ce25=i[1];rst14=(i%97==0);rst25=(i%89==0);
  if(i<32)begin rst14=i[0];ce14=i[1];rst25=i[2];ce25=i[3];end
  din14=$random(seed);din25=$random(seed);
  if(i%11==0)begin din14=14'h2000;din25=25'h1000000;end
  if(i%13==0)begin din14=14'h3fff;din25=25'h1ffffff;end
 end
 for(i=0;i<3000;i=i+1)begin
  @(negedge clk);rst14=(i%101==0);rst25=(i%113==0);ce14=i[0];ce25=i[1];din14=$random(seed);din25=$random(seed);
  case(i%4)
   0:begin din14[i%14]=1'bx;din25[i%25]=1'bx;end
   1:begin din14[i%14]=1'bz;din25[i%25]=1'bz;end
   2:begin din14='hx;din25='hx;end
   3:begin din14='hz;din25='hz;end
  endcase
 end
 @(negedge clk);rst14=1;rst25=1;repeat(5)@(negedge clk);
 $display("CONTROL_ENABLE_POSTOPT_NATIVE_PASS cycles=%0d widths=14,25 reset_zero_and_one=1 known_controls=1 XZ_data=3000",cycles);$finish;
end
endmodule
''';(out/'tb.sv').write_text(bench,encoding='ascii')
    run(out,'compile',[TOOL/'xvlog.bat','--sv',out/'mapped.v',out/'tb.sv',TOOL.parent/'data/verilog/src/glbl.v'])
    run(out,'elaborate',[TOOL/'xelab.bat','tb_ce_remap','glbl','-L','unisims_ver','-s','tb_ce_remap','--timescale','1ns/1ps'])
    run(out,'simulate',[TOOL/'xsim.bat','tb_ce_remap','-runall'],'CONTROL_ENABLE_POSTOPT_NATIVE_PASS')
    record={'passed':True,'method':'Explicit LUT3 INIT8hAC D=CE?D:Q, CE=1; FF boundary protected','widths':[14,25],'FF_before':len(before),'FF_after':len(after),'all_CE_after_VCC':True,'known_vector_cycles':40000,'XZ_data_cycles':3000,'known_CE_reset_only':True,'added_registers':0,'added_cycles':0,'synthesis_and_opt':'COMPLETE','native_postopt_functional':'PASS','leaf_route':'NOT_RUN','scope':'Actual explicit post-opt mapped netlist vs original native UNISIM FDRE/FDSE. Reset0/1 priority, CE hold/write and X/Z data strict equality; unknown/metastable controls and full Root/SDF/CDC safety NOT_PROVEN. Initial property-only prototype did not move CE and was structurally rejected, not silently accepted.'}
    (out/'results.json').write_text(json.dumps(record,indent=2),encoding='utf-8');print('CONTROL_ENABLE_REMAP_SUITE_PASS',flush=True)
if __name__=='__main__':main()
