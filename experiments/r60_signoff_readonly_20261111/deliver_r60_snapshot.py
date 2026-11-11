from pathlib import Path
import json,hashlib,re,subprocess,shutil
h=Path(__file__).parent;out=h.parents[1]/'outputs';root=Path('D:/RP_Dev/linien_trials/20261111-r60-phase-output-postroute');exp=root/'experiments/r60_physical_20261111'
m=json.loads((exp/'metrics.json').read_text());t=Path(m['trial']);ma=json.loads((t/'manifest.json').read_text());sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert m['constrained_setup']==m['hold']==m['pulse_width']=='PASS' and m['timing_signoff']=='FAIL' and m['physical_register_audit']['passed']
dcp_sha=sha(t/'routed.dcp');assert dcp_sha==m['output_routed_DCP_SHA256']
net=h/'r60_mapped/routed_netlist.v';text=net.read_text();name=text.index('  p_1_out\n');start=text.rfind('  DSP48E1 #(',0,name);end=text.index(');',name)+2;block=text[start:end]
assert start>=0
op=re.sub(r'\s+','',re.search(r'\.OPMODE\((.*?)\)',block,re.S)[1]);assert op=="{1'b0,linienmodule_mixeralignedpid_error_s1,linienmodule_mixeralignedpid_error_s1,1'b0,1'b1,1'b0,1'b1}",op
preg=int(re.search(r'\.PREG\((\d+)\)',block)[1]);assert preg==0
model=Path('D:/Xilinx/Vivado/2020.1/data/verilog/src/unisims/DSP48E1.v');mt=model.read_text();assert "3'b000 : qz_o_mux <= 48'b0;" in mt and "3'b011 : qz_o_mux <= qc_o_mux;" in mt and "3'b010 : qz_o_mux <= qp_o_mux;" in mt
reachable=[int(''.join(map(str,[0,s,s,0,1,0,1])),2) for s in (0,1)];assert reachable==[5,53] and {v>>4 for v in reachable}=={0,3}
rules=m['drc_rules'] if 'drc_rules' in m else []
# The exact summary is independently parsed, rather than relying on JSON field naming.
drc=(t/'routed_drc.rpt').read_text();rule_rows=[{'rule':a,'severity':b,'count':int(c)} for a,b,c in re.findall(r'^\|\s*(\S+)\s*\|\s*(Warning|Advisory|Error|Critical Warning)\s*\|.*?\|\s*(\d+)\s*\|',drc,re.M)]
assert sum(v['count'] for v in rule_rows)==405
evidence={'scope':'R60 read-only signoff triage, not new synthesis/route or final closure','routed_DCP_SHA256_before':dcp_sha,'routed_funcsim_netlist_SHA256':sha(net),'input_DCP_SHA256':ma['input_dcp_sha256'],'code_commit':m['code_commit'],'reports_SHA256':{n:sha(t/n) for n in ('routed_timing.rpt','routed_checks.rpt','routed_cdc.rpt','routed_drc.rpt','routed_clocks.rpt','routed_exceptions.rpt')},'DPREG4_stable_binary_reachability':{'cell':'p_1_out','PREG':preg,'OPMODE_connection':op,'reachable_known_OPMODE_decimal':reachable,'reachable_Z_mux_selects':[0,3],'Z_mux_sources':['zero','C'],'internal_P_feedback_reachable_for_stable_known_control':False,'model':str(model),'model_SHA256':sha(model),'model_Z_mux_lines':'1139-1148','status':'STATIC_BINARY_EXPLANATION_ONLY_WARNING_REMAINS','limitations':'Does not prove transient hazards/skew/unknown-control behavior, postmap fullRoot numerical/cycle equivalence or final DRC signoff. Do not change PREG or suppress DRC merely to remove warning.'},'DRC_rules':rule_rows,'coverage':m['coverage'],'CDC_direct_path_differences':m['cdc_direct_comparisons'],'physical_CDC_safety':'NOT_PROVEN'}
evidence['routed_DCP_SHA256_after']=sha(t/'routed.dcp');assert evidence['routed_DCP_SHA256_after']==dcp_sha
extra=root/'experiments/r60_signoff_readonly_20261111';extra.mkdir(exist_ok=False);(extra/'evidence.json').write_text(json.dumps(evidence,indent=2,ensure_ascii=False),encoding='utf-8');shutil.copyfile(__file__,extra/'deliver_r60_snapshot.py')
rows=[]
for lab,folder in [('R53','20261111-r53-carry-fold-postroute'),('R57','20261111-r57-critical-ff-postroute'),('R58','20261111-r58-cordic-preserved-route'),('R59','20261111-r59-phase-output-distribution'),('R60',root.name)]:
 p=next((root.parent/folder/'experiments').glob(lab.lower()+'_physical_*/metrics.json'));v=json.loads(p.read_text());r=v['route'];rows.append(f"| {lab} | {r['wns']:+.3f} | {r['tns']:.3f} | {r['setup_failing']} | {'受约束setup PASS；最终STA FAIL' if lab=='R60' else 'setup FAIL'} |")
doc=r'''# Z7020 R60：受约束时序已通过，最终工程签核仍未完成

日期：2026-11-11。目标STEMlab 125-14 PRO Z7020 Gen2 / xc7z020clg400-1，Vivado2020.1。本报告只使用本机实际源码、DCP和报告；没有重新移植板卡，没有生成或部署bitstream，没有激光/PZT/板端操作。

## 这一阶段取得的结果

R60最终route：WNS **+0.003ns**，TNS **0**，setup失败端点 **0**；WHS **+0.014ns**、THS **0**；WPWS **+1.500ns**、TPWS **0**。postopt和最终route分别报告，二者均为上述值。3ps是此输入/此实现的实际正裕量，不能取代完整覆盖或被宣传为宽裕设计；将来改源码/约束/工具/布局后必须重测。

| 实现 | Routed WNS ns | Routed TNS ns | Setup失败端点 | 判定 |
|---|---:|---:|---:|---|
| R2b | -5.605 | -10473.525 | 6813 | setup FAIL |
__ROWS__

R58未改善，R59恶化，均保留失败源码、输入和诊断，不合并。R59虽拒绝作为成品，R60仍可作为其独立、重新验证的后续候选。R60保留为当前最好候选；原用户工程、R2b、R4a和R16逐文件SHA/HEAD/原工作树状态核验保持。所有修改只在独立工作树。

## 修改究竟发生在哪里

本组R57–R60没有再修改Migen/Verilog硬件源码；沿用R52已完整回归的RTL。新增/修改的是独立物理实现驱动与工程记录：R58 `tools/run_cordic_preserved_route_trial.py`；R59 `tools/run_phase_output_distribution_trial.py`；R60 `tools/run_phase_output_postroute_trial.py`，以及对应docs/实验包。具体源码由各轮代码commit和manifest逐文件SHA定位。

R59从真实routed负路径精确选B相位bit9与B IIR输出bit15，2→6同拍FF，普通状态递推与完整聚合负载分配核验通过，但全局route变差。R60对该等价拓扑执行placement/routing/rewire/critical-cell，再实际TNS cleanup；日志35-558确认fully-routed场景其他route选项被忽略，不将其说成从零重布全部设计。

R60实际新增4个平行FF：B common bit4、B IIR y0 bit2、B multiplier bit1为FDRE；B multiplier bit0为FDSE/INIT=1，保持CSR默认乘数1及原同步置位S。FDRE满足q'=R?0:(CE?D:q)，FDSE满足q'=S?1:(CE?D:q)，相同INIT/C/CE/D及R或S由归纳保持同状态；没有新增串行采样边沿。新旧30,623/30,627个已解析模块实例，全部原实例参数/端口在验证副本Q别名与有序向量展开后相同；本轮没有新增/删除LUT，也没有需要额外局部truth-table的函数变化。94DSP实际参数对输入R59相同。

资源：LUT11783 / FF13540 / DSP94 / BRAM35 / BUFG6。相比R53多1LUT、28个同拍FF，新增反馈周期0；快速路径相对R2b累计+32ns保持。指定组件数字模型Bare72.1ns、快→慢108.1ns仅继承旧测试，不是本轮全Root/SDF/板端端到端测量，实际原子锁频带宽尚未验证。

## 测试状态与证据范围

| 项目 | 本轮状态 | 实际范围 |
|---|---|---|
| R52完整原生功能回归 | PASS，R60明确复用、NOT RERUN | 14/25位PID、CE/复位/饱和/真实CSR、完整50位MAC、IIR order1/2/5及XZ、FastChain、Scope、AXI/CDC等原记录；94个硬件/测试/工具输入SHA同R59 |
| 综合 | REUSED_R52经R59，NOT RERUN | 综合WNS=-.773ns/TNS=-60.316ns/259端点；不得混写成R60综合时序通过 |
| 映射状态/连接审计 | PASS，新执行 | FDRE/FDSE状态、全部已解析实例/参数/位顺序、94DSP及输入DCP/CSV冻结 |
| 物理优化与实际route | COMPLETE，新执行 | 独立postopt和final报告、实际routed.dcp |
| 受约束setup / hold / pulse | PASS / PASS / PASS | 当前已建模时钟与时序路径 |
| 最终STA/CDC/I/O/DRC签核 | FAIL / 未完成 | 见下方真实缺口 |
| FullRoot postmap/SDF/独立形式等价、板测、激光闭环 | NOT RUN | 不能用局部结构证明或源RTL回归替代 |

输入与输出SHA、命令、stdout/stderr/退出码、PASS/FAIL/复用标记见逐轮metrics/manifest和汇总JSON。审计最初因FDSE不在允许列表，以及Verilog整条向量和逐位拼接的表示差异而中止；检查实际primitive和声明后补齐显式证明/有序展开，不修改生产网表、不跳过端口、不削弱功能断言。初始中止原因也随审计记录保存。

## 当前真正的剩余瓶颈

R60全局最差已变成B IIR输出y2[11]→并行tap限幅y[19]/D：+0.003ns，10级（5 CARRY4、LUT2×1、LUT4×1、LUT5×2、MUXF7×1），logic3.081ns/route4.513ns。raw IIR内部+0.343ns，DSP+LUT6两级，logic5.848ns/route1.205ns。快速PID /D +.814ns；慢速PID /D +1.224ns、/R +.558ns、/CE +1.790ns；这些局部结果不替代全局或未约束端点。

下一阶段主要是签核覆盖，不宜继续为“消告警”随意插入流水线：

1. **DNA时钟与2个内部端点**：`gateware/lowlevel/dna.py`实际将cnt[0]连接DNA_PORT/CLK，cnt运行至128后停止。报告明确no_clock=1（DNA_PORT/CLK），DIN/READ未约束2项。先核对实际分频/停钟、READ/SHIFT与DIN/DOUT边沿及本机原语/器件文档，再在独立分支建立有依据的时钟与端点时序模型；不能直接false-path或未经频率验证把CLK换成sys_clk。保持DNA CSR布局和读值语义。
2. **外部I/O覆盖**：无input_delay44项=ADC A/B各14位+扩展口16位；无output_delay46项=DAC数据及控制18+扩展口16+PWM4+LED8。ADC/DAC需要目标Gen2真实器件、时钟边沿、板上走线/偏斜、setup/hold数据；GPIO/PWM/LED按是否存在同步外部采样协议分别记录。不能填统一0ns或假数字让计数归零，也不应给LED虚构不存在的采样时钟。
3. **物理CDC**：FCLK↔ADC仍NoCommonClock/Timed(unsafe)。R60与R59、R57的CDC严格路径差集均0/0，分类计数相同，但RC路线改变；需证明bundled-data数据保持、同步控制、请求/应答、最早/最晚数据窗口、复位/PLL失锁及同步器物理位置。源功能异步回归PASS不等于物理跨域安全。未经协议依据不添加clock_groups/false/multicycle。
4. **DRC逐类处置**：405条=333 Warning+72 Advisory，无本报告Error/Critical Warning。331条DPIP/DPOP主要是DSP流水线性能建议，不能为了归零给反馈链盲加延迟；RTSTAT-10对应84条无可路由负载网，需核查是否为有意未消费的标志/高位；其余按原语使用逐项解释。
5. **DPREG-4的只读核查**：实际p_1_out PREG=0，OPMODE={0,s,s,0,1,0,1}，相同s线控制两位。已知稳定s∈{0,1}仅可达0x05/0x35，Z选择000/011。本机DSP48E1.v模型对应0/C，不会选P反馈。这解释了稳定二进制模式下告警可能来自保守的位相关性分析，但**没有完成动态毛刺、未知控制、物理偏斜或全Root映射波形证明**，原告警不删除、不降级，不能冒称最终DRC已经关闭。

不需要重新移植Z7020，也不因以上缺口更改现有引脚、PS7、PLL、ADC/DAC或AXI/CSR协议。先冻结R60，再以独立分支逐项补证；任何约束变更后都重跑全套实际route/时钟交互/coverage/CDC/DRC。3ps裕量很小，工程变化可能重开路径，必须继续保留R57及全部失败候选。

## 可重复运行与回退

以下重放**物理R60阶段**，复用本机冻结R59 DCP/原完整功能与综合，不是重新跑源功能或综合。驱动自动创建新时间戳目录，核对94个输入SHA及DCP/CSV哈希，不覆盖旧试验。

```powershell
Set-Location D:\RP_Dev\linien_trials\20261111-r60-phase-output-postroute
$gatewarePython = 'D:\RP_Dev\linien_trials\20261109-r5-autolock-compare\.venv-gateware\Scripts\python.exe'
& $gatewarePython .\tools\run_phase_output_postroute_trial.py `
  --input-trial 'D:\RP_Dev\linien_trials\20261111-r59-phase-output-distribution\gateware\build\trials\20261111_191728_r59_phase_output_distribution' `
  --label r60_replay
```

之后必须重新分析新目录的routed.dcp、核对funcsim实例/状态/94DSP/CDC及coverage，不能直接复制本轮PASS标记。若从RTL重新生成，先在独立工作树按R52锁定环境完整functional,generate,synth,route，再按已归档R53/R56/R57/R59/R60阶段逐个冻结输入、复制拓扑和物理结果；不承诺不同新实现仍有相同3ps。回退选既有隔离工作树/分支，不reset/覆盖用户工程。

代码提交：`__CODE__`。结果归档提交：`__RESULT__`。输入R59 DCP SHA256：`__INPUT__`。输出R60 routed.dcp SHA256：`__OUTPUT__`。完整分支：[opt/r60-phase-output-postroute-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r60-phase-output-postroute-20261111)。GitHub上传按每次push后ls-remote==本地HEAD核验，后续文档可能有独立提交，应以远程最终核验为准。
'''
result=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip()
doc=doc.replace('__ROWS__','\n'.join(rows)).replace('__CODE__',m['code_commit']).replace('__RESULT__',result).replace('__INPUT__',ma['input_dcp_sha256']).replace('__OUTPUT__',dcp_sha)
(root/'docs/R60_SIGNOFF_GAPS_20261111.md').write_bytes(doc.encode());(out/'Z7020_R60_结果与签核缺口_20261111.md').write_bytes(doc.encode());(extra/'report.md').write_bytes(doc.encode());print('R60_SNAPSHOT_AND_READONLY_SIGNOFF_TRIAGE_COMPLETE',dcp_sha)
