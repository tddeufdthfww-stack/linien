from pathlib import Path
import subprocess,json,re,shutil
import argparse
root=Path(__file__).resolve().parents[1];p=argparse.ArgumentParser();p.add_argument('--out',required=True,type=Path);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
for phase,sh in ((1,4000),(1250,4000),(3999,4000),(7999,4000),(1001,5000)):
 d=out/(str(phase)+'_'+str(sh));d.mkdir();bench=(root/'gateware/tests/cdc/tb_r61_link_reset_windows.sv').read_text().replace('parameter integer SH=4000;','parameter integer SH='+str(sh)+';').replace('integer phase=1;','integer phase='+str(phase)+';').replace('if(!$value$plusargs("PHASE=%d",phase))phase=1;','');(d/'tb.sv').write_text(bench)
 commands=[('compile',[tool/'xvlog.bat','--sv',root/'gateware/verilog/bus_clk_bridge.v',d/'tb.sv'],None),('elaborate',[tool/'xelab.bat','tb_cdc_windows','--timescale','1ps/1ps','-s','cdc_windows'],None),('simulate',[tool/'xsim.bat','cdc_windows','-runall'],'CDC_RESET_AND_WINDOW_DIAGNOSTIC_COMPLETE')]
 for name,cmd,marker in commands:
  cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=d,capture_output=True);(d/(name+'.stdout.log')).write_bytes(res.stdout);(d/(name+'.stderr.log')).write_bytes(res.stderr);s=(res.stdout+b'\n'+res.stderr).decode(errors='replace');ok=res.returncode==0 and (not marker or marker in s) and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',s);(d/(name+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'passed':bool(ok)},indent=2));assert ok,s[-4500:]
  if marker:
   normal=re.search(r'CDC_NORMAL_WINDOWS_PASS transactions=(\d+) forward_min_ps=(\d+) return_min_ps=(\d+)',s);assert normal
   assert 'CDC_CLOCK_STOP_RESET_FAULT_RESPONSE_PASS' in s
   source=int(re.search(r'SOURCE_ONLY_RESET_NEW_REQUEST_OK=(\d+)',s)[1]);replay=int(re.search(r'DEST_ONLY_RESET_UNREQUESTED_REPLAY=(\d+)',s)[1]);row={'phase_ps':phase,'source_half_ps':sh,'normal_transactions':int(normal[1]),'forward_min_ps':int(normal[2]),'return_min_ps':int(normal[3]),'normal_held_payload_and_snapshot':'PASS','coordinated_reset_recovery':'PASS','source_only_reset_liveness':'PASS' if source else 'FAIL','destination_only_no_unrequested_replay':'PASS' if replay==0 else 'FAIL','unrequested_replays':replay};results.append(row);print(row,flush=True)
assert all(v['source_only_reset_liveness']=='PASS' and v['destination_only_no_unrequested_replay']=='PASS' for v in results),results
(out/'results.json').write_text(json.dumps({'executed':'COMPLETE','results':results,'physical_CDC_safety':'NOT_PROVEN','scope':'Actual candidate bridge RTL, native XSim. Stable normal data windows and snapshots plus newly diagnosed independent reset contracts. Functional asynchronous clocks do not simulate metastability, routed RC, clock-loss/PLL behavior or prove MTBF. Independent reset FAIL is a newly uncovered unsupported contract, not silently converted into a normal regression PASS.'},indent=2));print('R61_CDC_RESET_SUITE_PASS',flush=True)
