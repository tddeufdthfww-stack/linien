# Codex 项目指令：Linien 2.1.0 → Red Pitaya Z7020 Gen 2

> 此文件专门供 Codex 在仓库根目录自动读取。首次执行任务前，**必须阅读 `docs/PORTING_STATUS.md`**。
> 当前状态基线：2026-11-06。本文不是“移植已经完成”的声明。

## 项目目标

把 Linien 2.1.0 的 FPGA gateware 从旧版 Red Pitaya 平台移植到 **STEMlab 125-14 PRO，Zynq-7020 Gen 2**，最终实现可验证的 Cs 激光锁频系统：ADC 采样、AXI/CSR 通信、快/慢 PID、扫频、失锁检测和自动重锁。优先级是 **数值正确性 / 时钟安全 / CDC 安全 / 闭环延迟 / 物理时序签核**，而不是简单让 Vivado 生成 bitstream。

## 开始每项任务前必须做的事

1. 阅读 `docs/PORTING_STATUS.md`，以及相关 Python/Migen、Verilog、Tcl、XDC 和既有 testbench。核对现有仓库内容与文档版本，**不要假定此前试验候选已经合并**。
2. 执行 `git status --short`、`git branch --show-current`、`git diff --stat`，记录用户未提交的修改。不要覆盖、清理或重置它们。
3. 找到精确的时钟域、模块调用者、数据位宽（signedness / shift / saturation / reset）、CSR 地址及实际已有测试入口，再提出最小变更。
4. 开始修改前给出 3～6 行计划，并指出可能改变的采样周期、反馈延迟和控制行为。
5. 在独立的 Git 分支或可回退补丁中试验，**不要直接覆盖已经通过验证的基线**；尽量用 git diff 检查变更。

## 严格工程规则

- **不要用 `set_false_path`、`set_clock_groups`、`set_multicycle_path` 或删除约束来“制造时序通过”。** 只有证明实际时钟关系、同步结构及协议后才可加例外，并写下可审查的依据。
- **不能仅因 Migen/RTL 仿真通过或 Vivado `route_design` 成功，就宣称可上板或可闭环运行。** 必须核对 WNS/TNS、WHS、WPWS、unconstrained endpoints、CDC、I/O 时序、DRC。
- 修改 PID 时保留其固定位宽、有符号算术、右移舍入/截断、饱和、复位、CSR 接口。需要增加流水线时，必须明确**新增几个 125 MHz 周期延迟**、P/I/D 对齐方案、Clock Enable 下寄存器的生效时间及对环路带宽/相位裕度的影响。
- 慢速 PID 建议用 **固定 125 MHz 时钟 + Clock Enable**，但只使能慢速数据通路寄存器，**CSR 写操作和必要的状态配置不能被 CE 冻结**。
- 动态分频 0～15、从合法到非法设置、复位中/复位后、配置变更中，都要测试。原始动态逻辑时钟与 CE 的边沿相位不一定逐周期等价；不可静默改变控制行为。
- 读写跨域桥属于 **bundled-data / handshake CDC**；2FF `ASYNC_REG` 属性仅证明同步控制链存在，不代表多位数据已完成物理 CDC 安全验证。必须审查数据保持时间、同步器时序、复位及版图约束。
- AXI 读响应与写响应必须在 `RREADY`/`BREADY` 握手前保持稳定，回归背压、读写交错和复位；不要破坏既有修复。
- 不随意修改板级 ADC/DAC 接线、引脚映射、PLL 或 DAC 多相位时钟；硬件连接前必须查证 Gen 2 引脚及 I/O 电气约束。
- 禁止在未经明确许可和硬件安全检查时刷写 FPGA、驱动激光二极管电流/PZT、打开激光反馈环路或修改板卡启动镜像。
- PowerShell 变量名不区分大小写；**不要使用 `$pid`（与内置 `$PID` 冲突），也不要同时使用 `[switch]$Run` 和 `$run` 路径变量。** 建议 `$pidSourcePath`、`$trialDir`。Python -c 命令留意 Windows PowerShell 5.1 引号传递。
- PowerShell 执行外部 Python/Vivado 命令必须捕获 stdout 与 stderr、退出码和完整日志；测试通过须检查 **显式 PASS 标记及无异常**，不能仅凭进程退出 0。

## 应保留的文件与接口

- `gateware/lowlevel/crg.py`：当前确认清理了**未使用的 500 MHz `sys_quad` BUFG**；其余 PLL、ADC、DAC 时钟不能盲删。
- `gateware/lowlevel/pitaya_ps.py`、`gateware/hw_platform.py`、`gateware/fpga_image_helper.py`：Z7020 Gen 2 适配；不得无缘由回退到旧 Z7010 PS7 配置。
- `gateware/verilog/axi_slave.v`、`gateware/verilog/bus_clk_bridge.v`：已有握手/读数据快照修复；保留测试和必要的 `ASYNC_REG` 属性。
- `gateware/logic/pid.py`、`gateware/logic/decimation.py`、`gateware/logic/chains.py`、`gateware/logic/limit.py`、`gateware/linien_module.py`：当前时钟/控制优化重点。
- 现存 CSR 地址、Linien UI/服务端软件的寄存器协议、ADC/DAC 延迟与量纲必须兼容；改动时给出明确迁移方式。

## 测试与证据要求

优先运行已有测试（以仓库实际入口为准，不凭空创建 PASS）：

- `gateware/tests/axi/tb_axi_slave_read.sv`
- `gateware/tests/axi/tb_axi_slave_write.sv`
- `gateware/tests/cdc/tb_bus_clk_bridge.sv`
- `gateware/tests/cdc/tb_bus_clk_bridge_read_snapshot.sv`
- `gateware/tests/integration/tb_axi_bridge_integration.sv`
- `gateware/build/slow_clock_ce_trial/tb_slow_clock_ce_trial.py`（如果本地还保留实验目录）
- Migen 顶层生成、Vivado 2020.1 `synth_design`、`opt_design`、`place_design`、`phys_opt_design`、`route_design`；取得 `report_timing_summary`、`check_timing`、`report_cdc`、`report_drc`、`report_utilization` 与实际关键路径报告。

每轮实验应有：

1. 原版与候选版 commit/hash、测试方法、精确工具版本、时钟约束。
2. 功能回归结果（周期数、固定点/溢出/饱和/复位/CSR/动态分频）。
3. 原版与候选版的 **routed** WNS/TNS、Setup 失败端点、WHS、WPWS、no_clock、CDC 分类、LUT/FF/DSP/BRAM/BUFG。
4. 每条关键路径的起点、终点（包括 `/D` 和 `/R` 等实际引脚）、逻辑/布线延迟、时钟关系。
5. 回退策略，明确本次修改是 **[正式保留] / [候选试验] / [失败回退] / [待验证]** 的哪一个。

## 当前任务优先级

1. **确认当前 git 工作树与已验证基线；** 慢速时钟 CE 目前只是候选试验，曾成功综合和布线，但没有证据已正式合并。
2. **解决慢速 PID 125 MHz 长路径（候选版 routed WNS −6.402 ns）**，尤其终点为 `slow_chain_pid_int_reg_reg[17]/R` 的组合链；先研究减少路径深度，再有依据地试验积分乘法流水线，提供明确时序/延迟验证。
3. **解决快速 PID 125 MHz 长路径**（原版 routed WNS −5.354 ns；CE 候选还有快速 PID −6.200 ns 级路径）。优先研究 DSP48E1 寄存器/位宽/饱和架构，避免不必要的反馈延迟。
4. 核查 AXI/CSR bundled-data CDC、PS FCLK0 与 ADC PLL 派生时钟关系及其物理约束，分类关闭真正已证明安全的 CDC 告警。
5. 完成 ADC/DAC I/O 时序约束、DRC/STA 签核；随后才考虑 bitstream、板端闭环前自检与安全的真实锁频测试。

## 每轮交付格式

- **进度**：已完成、正在做、下一步；只报告实际执行结果。
- **变更清单**：文件名、模块名、关键修改；附 `git diff --stat`。
- **测试证据**：命令和日志名，PASS/FAIL，未执行项明确标 `NOT RUN`。
- **物理时序**：与对应基线比较的表格，综合与布线数据必须分开。
- **风险与回退**：新增延迟、数值影响、CDC 和尚未签核项目。
- 完成后**更新 `docs/PORTING_STATUS.md` 的日期、实验记录、当前目标及残余风险**；没有验证的数据不得写成通过。

与用户沟通使用**简体中文**，路径、Verilog/Migen、Vivado 和 PowerShell 术语可保留英文。用户偏好**可直接复制粘贴的一整段 PowerShell 命令**，尽量不要要求反复下载脚本；如果命令涉及自动改写源码，必须备份、验证定位点且 `try/finally` 回退。请使用普通 Markdown 和标准代码块，不要使用复杂 UI 标签。
