# 2026-11-09 首轮优化证据

代码提交：`502be6c9edc1269e21c766d9cce053025aa321fa`。优化前备份：`a39000a`；CE对照：`c76d00b`。当前保留的是**功能已回归、物理时序仍失败的候选**。

| 目录/ZIP | 用途 | Routed WNS/TNS ns |
|---|---|---|
| 20261109_092834_baseline | 基线功能通过；综合目录问题失败日志 | 不用作综合/route证据 |
| 20261109_093033_baseline | 成功复现原版综合和实现 | -5.354 / -9445.378 |
| 20261109_094155_ce | CE兼容候选、完整功能与实现 | -5.972 / -11109.872 |
| 20261109_095327_ce_sat | 通用高位比较，REJECTED | -6.448 / -10445.604 |
| 20261109_100550_ce_sat_bits | 保留的位解码候选 | -5.605 / -10473.525 |
| 20261109_101735_ce_sat_bits_repeat_route | 同DCP、同directive重复实现 | -5.605 / -10473.525 |

- `metrics.json` 含分阶段数据、原目录168文件不变检查、输入源码哈希、基线功能证据绑定和重复实现验证；其中收集时Git HEAD为代码提交，运行时manifest也保留其父HEAD和实际dirty输入哈希。
- `pid_sat_compare_rejected.py` 是失败候选，只归档、不被生产代码或回归DUT导入。其SHA已与对应运行输入manifest核对一致。
- `cdc1_delta.json` 记录CE到位解码的CDC-1条目变化，物理安全未证明，不是豁免清单。
- ZIP保存完整顶层stdout/stderr、退出码JSON、Tcl、Vivado日志、报告、约束和CSR map；分组诊断在`pid_details/`。大型DCP、PS生成缓存和仿真二进制保留在本机各轮目录，不放入Git。
- WNS/TNS改善不等于STA通过；仍有6813个Setup违规端点、未约束DNA和I/O、CDC及DRC遗留项目。

在已安装本次锁定环境的独立副本中，下面一段PowerShell可再次运行；每次生成新目录，不覆盖旧结果：

```powershell
Set-Location 'D:\RP_Dev\linien_trials\20261106-ce-saturation'
$PY = Join-Path (Get-Location) '.venv-gateware\Scripts\python.exe'
& $PY tools\run_gateware_trial.py --label repeat_ce_sat_bits --stages functional,generate,synth,route
if ($LASTEXITCODE -ne 0) { throw 'Trial failed; inspect the complete per-stage logs.' }
```

运行新的源码候选前必须先保存分支/commit并记录改变。`tools/report_pid_details.tcl` 可对已有routed DCP再次只读生成/D、/R、/S、/CE及反馈分组报告。环境依赖见根`requirements-gateware.lock.txt`；不要执行历史归档里的覆盖式脚本。
