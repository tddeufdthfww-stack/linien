"""Identical downstream-error/backpressure fixtures fail frozen R60, pass candidate."""
from pathlib import Path
import argparse,json,re,subprocess
ROOT=Path(__file__).resolve().parents[1]
def main():
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,required=True);a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=False);tool=Path('D:/Xilinx/Vivado/2020.1/bin');results=[]
 for kind in ('read','write'):
  top='tb_r61_axi_'+kind+'_error';bench=ROOT/'gateware/tests/axi'/(top+'.sv');marker='R61_AXI_'+kind.upper()+'_ERROR_BACKPRESSURE_PASS'
  for variant,src in [('frozen_r60',ROOT/'gateware/tests/timing/reference/r60_axi_slave.v'),('candidate',ROOT/'gateware/verilog/axi_slave.v')]:
   d=out/(kind+'_'+variant);d.mkdir()
   for stage,cmd in [('compile',[tool/'xvlog.bat','--sv',src,bench]),('elaborate',[tool/'xelab.bat',top,'--timescale','1ns/1ps','-s',top]),('simulate',[tool/'xsim.bat',top,'-runall'])]:
    cmd=list(map(str,cmd));res=subprocess.run(cmd,cwd=d,capture_output=True);(d/(stage+'.stdout.log')).write_bytes(res.stdout);(d/(stage+'.stderr.log')).write_bytes(res.stderr);s=(res.stdout+b'\n'+res.stderr).decode(errors='replace')
    passed=res.returncode==0 and not re.search(r'(?m)^(ERROR:|Fatal:|FATAL_ERROR:)',s) and (stage!='simulate' or marker in s)
    expected_failure=stage=='simulate' and variant=='frozen_r60'
    if expected_failure:assert not passed and ('RRESP=00' in s or 'BRESP=00' in s),s[-4000:]
    else:assert passed,s[-4000:]
    (d/(stage+'.json')).write_text(json.dumps({'command':cmd,'exit_code':res.returncode,'functional_pass':bool(passed),'expected_frozen_functional_failure':expected_failure},indent=2))
   results.append({'kind':kind,'variant':variant,'downstream_error_response':'FAIL' if variant=='frozen_r60' else 'PASS','same_fixture':str(bench)});print(results[-1],flush=True)
 (out/'results.json').write_text(json.dumps({'passed':True,'results':results,'scope':'Frozen original and candidate same fixture, downstream SYS error coincident ACK; ERROR response must remain stable during backpressure. Existing ordinary-response tests remain unchanged.'},indent=2));print('R61_AXI_ERROR_SUITE_PASS',flush=True)
if __name__=='__main__':main()
