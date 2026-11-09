# Linien v2.1.0 → Red Pitaya STEMlab 125-14 PRO Z7020 Gen 2

> **2026-11-09 优化分支更新**：当前 `opt/ce-saturation-20261106` 已包含经过本轮功能/综合/route验证的 CE 兼容候选和零新增流水级的饱和位解码。优化前版本已保存到 `backup/20261106-pre-optimization`（`a39000a`）；原目录仍未覆盖。下文 0～10 节是 2026-11-06 历史快照，“未合并”针对当时基线，不能据此判断当前优化分支没有 CE。最新结果、修改与残余风险见第11节和 `docs/OPTIMIZATION_LOG.md`。**最终 STA 仍失败，未生成/部署新 bitstream。**

**Codex 持续开发交接文档 / 工程状态快照**  
快照日期：**2026-11-06 15:22（UTC+08:00）**  
状态：**仍在移植与时序整改；尚未完成可上板的签核版本**。  
重要：以下“通过”主要指有日志证明的仿真、综合或布局布线流程，不代表已经通过闭环激光锁频测试。

## 0. Codex 先读这一节

- 项目目的：在 **STEMlab 125-14 PRO Z7020 Gen 2** 上运行 Linien 2.1.0 gateware，支持 Cs 原子激光锁频（852 nm / 894 nm）、PS↔FPGA CSR、ADC/DAC、实时 PID、扫描、失锁恢复。**目前最优先是让时钟、CDC、快慢 PID 物理时序满足要求，而不是新增 AI 功能。**
- 原版已打通 PS7、Z7020 综合及布线；AXI backpressure、CDC 桥数据快照、无用 500 MHz BUFG 均做过回归修复。
- **Clock Enable 替代慢速逻辑衍生时钟的方案通过了 Migen 测试、Vivado 综合与布线，但仍是候选试验，未正式签核。** 它把 `no_clock` 从 172 减至 1、`unconstrained_internal_endpoints` 从 280 减至 2，同时让慢速 PID 长路径暴露出来；候选布线 WNS 为 **−6.402 ns**。
- 快速 PID 的 125 MHz 长路径仍严重超时；原版布线 WNS **−5.354 ns**。尝试过纯代数乘加表达式重写，WNS 仅改善 0.024 ns（综合），**不建议重复此路线**。
- 最新讨论的“**仅慢速 PID 积分乘法后插一级寄存器**”是一个**待验证的试验提议**。截至本文快照，没有收到其仿真、综合或布局布线结果，**不得写成已完成**。
- 对所有已做过的试验，先核实当前工作树。旧的 A/B 试验脚本通常自动恢复正式源码，因此**最新的 CE 设计很可能不在当前正式 `gateware/logic/*.py` 中**。

## 1. 环境和主要路径

| 项目 | 信息 |
|---|---|
| 主机 | Windows + PowerShell 5.1 + VS Code（根据已上传日志） |
| 仓库 | `D:\RP_Dev\linien-v2.1.0` |
| FPGA 子目录 | `D:\RP_Dev\linien-v2.1.0\gateware` |
| 构建/报告 | `gateware\build`、`gateware\build\reports` |
| Python 虚拟环境 | `D:\RP_Dev\linien-v2.1.0\.venv-gateware` |
| Vivado | **2020.1**，典型安装目录 `D:\Xilinx\Vivado\2020.1\bin` |
| 目标 FPGA | **xc7z020clg400-1**（Vivado 报告 device=`7z020-clg400`，speed grade `-1`） |
| 板卡 | STEMlab **125-14 PRO Z7020 Gen 2** |
| Red Pitaya OS | 曾使用 **2.07-48**；上板兼容性尚未完成签核 |
| 源码工具 | Python 3.10、Migen、MiSoC、Verilog/SystemVerilog、Vivado Tcl/XSim |
| 待核对分支 | 上传日志中曾出现 `z7020-gen2-port`，实际以 `git branch --show-current` 为准 |

**重要路径与文件：**

```text
linien-v2.1.0/
├── AGENTS.md                            # Codex 指令（本次交付）
├── docs/PORTING_STATUS.md               # 本文件（本次交付）
└── gateware/
    ├── hw_platform.py                  # Z7020 Gen 2 平台、引脚和时钟
    ├── fpga_image_helper.py             # FPGA 镜像生成/构建入口
    ├── linien_module.py                 # 顶层连接、slow_decimation、快慢控制链
    ├── lowlevel/
    │   ├── crg.py                       # PLL、BUFG、复位、时钟域
    │   ├── pitaya_ps.py                 # PS7 AXI GP0 连接
    │   └── analog.py                    # ADC/DAC 数据及时钟
    ├── logic/
    │   ├── pid.py                       # 定点 P/I/D、积分饱和
    │   ├── decimation.py                # 原始逻辑分频 / 候选 DecimateEnable
    │   ├── limit.py                     # 限幅器、限幅相关寄存器
    │   └── chains.py                    # FastChain / SlowChain
    ├── verilog/
    │   ├── axi_slave.v                  # AXI Slave read/write handshake
    │   ├── bus_clk_bridge.v             # PS 与 FPGA 时钟域桥
    │   └── red_pitaya_scope.v           # scope 内也有桥实例
    ├── tests/
    │   ├── axi/
    │   ├── cdc/
    │   └── integration/
    └── build/
        ├── top.v / top.xdc              # Migen 生成；构建时可能被覆盖
        ├── top_synth_first.dcp          # 综合快照；注意版本可能改变
        ├── run_implementation_diagnostic.ps1   # 若用户保留该脚本
        ├── slow_clock_ce_trial/         # 候选与测试（非正式代码）
        └── reports/                     # 各试验诊断 ZIP
```

## 2. 实际已完成与验证依据

### 2.1 平台/PS7 适配（基础流程已成功）

- 使用 Z7020 Gen 2 的 `xc7z020clg400-1`；建立 **PS7 + DDR + AXI GP0 + FCLK0 125 MHz** 硬件模块；有 `linien_ps_only.bd` 和 `linien_ps_only_wrapper.v` 相关设计成果。
- Migen 已能生成完整 `top.v` 和 `top.xdc`；Vivado 整体门级综合已完成；布线脚本也曾 **`route_design completed successfully`**。
- **注意**：综合和 route 成功，不等于硬件可用，当前 WNS 仍为负，CDC 和 I/O 也未签核。

### 2.2 AXI / CDC 通信功能修复（RTL 回归已通过）

- `gateware/verilog/axi_slave.v`：修复 AXI 读通道 `RVALID/RDATA/RRESP/RLAST` 在 `RREADY=0` 时必须保持；写通道 `BVALID/BRESP` 在 `BREADY=0` 时必须保持；完成逻辑以相应响应握手为准。
- `gateware/verilog/bus_clk_bridge.v`：请求/应答同步器增加 `ASYNC_REG`、`SHREG_EXTRACT=NO` 属性；目标时钟域 ACK 当拍捕获 `dst_rdata_hold[31:0]` 和 `dst_err_hold`，避免源域读取已变化的目标数据。
- XSim 回归历史结果：
  - `AXI_READ_HANDSHAKE_TEST_PASS`
  - `AXI_READ_BACKPRESSURE_TEST_PASS`
  - `AXI_WRITE_BACKPRESSURE_TEST_PASS`
  - `BUS_CLK_BRIDGE_READ_SNAPSHOT_TEST_PASS`（两次读、ACK 后目标读数据改变）
  - 标准 CDC 桥：8 次写、8 次读、16 次单周期 ACK；跨时钟相位差用例通过
  - `AXI_BRIDGE_INTEGRATION_TEST_PASS`
  - `AXI_BRIDGE_RESET_RECOVERY_TEST_PASS`
  - `AXI_INTEGRATION_AND_RESET_PASS`
- **范围限制**：这些是 RTL 级功能证据，不是物理 CDC 签核；仍需检查 WSTRB、跨域 bundled-data 相对时序、复位顺序和上板 AXI 行为。

### 2.3 清理未使用 500 MHz BUFG（已验证收益）

- 在 `gateware/lowlevel/crg.py` 移除未被消费的 `cd_sys_quad` 和对应的 500 MHz BUFG；保留其余 PLL 时钟和实际需要的 DAC 相位时钟。
- `unused_clock_cleanup_20261106_131221.zip` 记录了此轮综合和报告。
- BUFG 数 **12 → 11**；`WPWS` **−0.155 ns → +1.500 ns**；脉宽违规端点消除。**没有解决 PID Setup 问题**。
- 基线后续测试均以“已清理无用 500 MHz BUFG”为基础。

## 3. 关键物理指标——必须区分原版和候选版

来源于 2026-11-06 两个 `implementation_diagnostic_*.zip` 的 **route 后**报告，均为 Vivado 2020.1，主要同步时钟约束 125 MHz（周期 8 ns）。

| 指标 | **原版/已清理无用 BUFG** `132616` | **Slow CE 候选版** `151752` | 解释 |
|---|---:|---:|---|
| Routed WNS | **−5.354 ns** | **−6.402 ns** | 均未通过 |
| Routed TNS | −9445.378 ns | −13909.426 ns | CE 候选暴露更多数据通路 |
| Setup 失败端点 | 6300 | 8069 | CE 不是单独的性能优化 |
| Routed WHS | +0.027 ns | +0.043 ns | 当前约束下 Hold 通过 |
| Routed WPWS | +1.500 ns | +1.500 ns | 脉宽通过 |
| `check_timing no_clock` | **172** | **1** | 原 171 个来自动态逻辑慢时钟；剩 1 个与 `DNA_PORT/CLK` 有关 |
| unconstrained internal endpoints | **280** | **2** | 剩余与 `DNA_PORT` 有关 |
| no_input_delay | 44 | 44 | 仍需分类并补齐 FPGA I/O 约束 |
| no_output_delay | 46 | 46 | 同上 |
| CDC-1 | 443 | 439 | CDC 告警不等于全部是已证实缺陷 |
| CDC-2 | 14 | 14 | 继续分类 |
| CDC-3 | 4 | 4 | 部分 2FF 同步器已识别 |
| CDC-4 | 1 | 1 | 多位 CDC 仍待审查 |
| CDC-10 | 2 | 2 | 同步器前组合逻辑待审查 |
| CDC-15 | 374 | 374 | CE 控制跨域结构，需握手和物理证明 |

> **重要**：`route_design completed successfully` 只代表路由成功。上述两版均 **`Timing constraints are not met`**，不得将 `route success` 写成 STA pass。

综合阶段资源（原版 vs CE 候选，仅比较综合，不能与布线后 utilization 混用）：

| 资源 | 原版 | CE 候选 | Z7020 总资源 |
|---|---:|---:|---:|
| LUT | 11655 | 11616 | 53200 |
| FF | 11962 | 11948 | 106400 |
| DSP48E1 | 95 | 95 | 220 |
| BRAM36 | 35 | 35 | 140 |
| BUFG | 11 | 10 | 32 |

资源容量不是当前首要瓶颈，**关键是满足实时环路时序和跨域稳定性**。

## 4. 快速 PID：已定位、仍待优化

相关源：`gateware/logic/pid.py` 中的误差计算、`calculate_i()`、积分饱和。原算式在候选改造前后基本相同：

```python
self.ki_mult.eq((self.error * ki_signed) >> 4)
self.int_sum.eq(self.ki_mult + self.int_reg)
# 后续 int_sum 与 max_pos_extra/max_neg_extra 比较并写 int_reg
```

- 原版路由最差路径为 125 MHz PID 长算术路径，WNS **−5.354 ns**，数据路径经过约 17 个 CARRY4、1 个 DSP48E1；属于误差→乘法→积分累加/饱和的组合链。
- Slow CE 候选中，快速 PID 仍存在约 **−6.200 ns** 的路径，起点 `linienmodule_logic_pid_only_mode_storage_full_reg`，终点 `linienmodule_logic_pid_int_reg_reg[14]/D`（根据候选 routed report）。
- 做过乘加式代数合并 A/B 测试（`pid_mac_trial_20261106_135632.zip`）：455 个仿真周期、8 个信号/周期比较通过；综合 WNS **−5.966 → −5.942 ns**，仅改善 **0.024 ns**；TNS、失败端点略恶化；**方案回退、未采用**。
- 下一步应综合研究 **位宽/符号截断及饱和化简、DSP48E1 映射和内部寄存器、流水线划分、P/I/D 对齐**。若增加一级 125 MHz 寄存器，额外延迟 **8 ns**，需要量化闭环环路影响。
- **不能直接以综合 WNS 判断优化效果**；优先保留时序分段诊断，必要时做相同约束、相同实现参数的 route 后 A/B 对比。

## 5. 慢速 Clock Enable：已验证候选，尚未正式合并

### 原始架构

- `logic/decimation.py` 的 `Decimate` 使用计数器与动态选择的分频位输出。
- `linien_module.py` 把 `decimate.output` 用作 `cd_decimated_clock.clk`，这个动态逻辑衍生时钟驱动 SlowChain/PID 相关寄存器。
- 原版在约束报告中造成 **171 个慢速链寄存器时钟未识别**，导致慢速长算术链不被充分检查；还可能有逻辑钟沿和占空比风险。

### CE 候选修改涉及的文件

| 文件 | 修改点 |
|---|---|
| `gateware/logic/decimation.py` | 新增 `DecimateEnable`，以 125 MHz 时钟发出使能脉冲 |
| `gateware/logic/pid.py` | 为 PID 积分、微分、`pid_sum` 等**数据寄存器**增加 `update_en` |
| `gateware/logic/limit.py` | 为慢速限幅的数据寄存器增加 `update_en` |
| `gateware/logic/chains.py` | `SlowChain.update_en` 下发给慢速 PID 与限幅器 |
| `gateware/linien_module.py` | 移除 `cd_decimated_clock` 生成时钟连接，改用 `self.decimate.enable` 驱动 `self.slow_chain.update_en` |

### 试验和等价性边界

历史日志 `slow_clock_ce_trial_20261106_151430.zip`：

```text
DIVIDER_MODEL_PASS: all 16 stable rates; n=0 phase +4 ns explicitly allowed
DIVIDER_MIGEN_PASS: static and dynamic config cases including invalid indices
FAST_PID_REGRESSION_PASS: 255 cycles, 8 signals/cycle
SLOW_PID_CE_HOLD_PASS: 220 cycles; 25 enabled updates
SLOW_CLOCK_CE_TRIAL_TEST_PASS
```

- Stable decimation index **1～15**：参考模型更新事件频率与相位相符。
- Index **0**：相对于原 250 MHz 衍生时钟存在约 **+4 ns 的采样相位差**（半个 125 MHz 周期）；不能声称全配置严格逐周期等价。
- 候选对超范围设置 **16～31** 禁用更新脉冲；原版相同设置的实际行为与软件含义仍需核实。
- 动态改变分频值可能产生不同过渡相位，必须做针对性回归；参考模型和有限 Migen 仿真不构成形式等价证明。
- 试验脚本 `manifest.txt` 写明 `Succeeded=True`，同时说明原工程文件已恢复；**CE 并非已经合入正式工程**。

### CE 候选最差路径（路由后）

来自 `implementation_diagnostic_20261106_151752.zip`：

```text
Startpoint: linienmodule_logic_control_channel_storage_full_reg_replica/C
Endpoint:   linienmodule_slow_chain_pid_int_reg_reg[17]/R
Clock:      clk_2, 125 MHz, period 8.000 ns
Data path delay: 13.837 ns
Logic delay: 8.788 ns; routed net delay: 5.049 ns
Logic levels: 18 (CARRY4=12, DSP48E1=1, LUT2=3, LUT4=2)
WNS:        -6.402 ns
```

**注意终点 `/R` 是同步复位/控制相关引脚，不是普通 `/D` 数据引脚；优化时必须同时追踪复位、饱和控制和乘法相关的控制映射。**

### 当前正在规划的下一实验：慢速积分乘法流水线

- 提议只在 `SlowChain` 中选择性使能 `pipeline_i=True`，在积分乘法后添加 `ki_mult_stage`，快速 PID 保持未修改。
- 原积分寄存器仍由 CE 控制；新增中间寄存器若每个 125 MHz 周期更新，会导致慢速 PID 使用上一周期的乘积值（**8 ns 输入采样延迟**）。
- **状态：待验证 / 未收到任何成功日志**。上一次对话曾提供一个 PowerShell 临时补丁脚本，**不要在没有检查代码和风险前直接视为已合并**。该脚本基于精确字符串匹配和 SHA256；须检查其定位点、测试是否真实覆盖所需行为，以及异常时是否安全回退。
- 若硬件时序改善也仍需补充：启动、持续 CE、CE 间隔、误差阶跃、增益突变、积分饱和、reset、lock_running 变化、动态分频切换及对输出的 8 ns 延迟影响；区分 data `/D` 路径与 sync reset `/R` 路径是否均得到优化。

## 6. CDC / 时钟 / I/O 剩余问题

1. `clk_fpga_0`（PS FCLK0 125 MHz）和 `clk_2`（ADC PLL 125 MHz）虽名义频率相同，**不是同一时钟源**；报告中的跨域路径标注 **No Common Clock / Timed (unsafe)**，不能当同步路径处理。
2. `bus_clk_bridge.v` 含双向请求/应答同步控制和目标域读数据快照，但数据位宽较大，需证明 bundled-data 保持窗口和物理路由时序，正确使用 `ASYNC_REG`；**不得仅靠 suppress CDC 告警**。
3. CDC 报告还包含 `red_pitaya_scope/i_bridge`，审查时不能只检查顶层一个桥实例。
4. CE 候选版剩余 `DNA_PORT/CLK` 1 个 `no_clock`、2 个 unconstrained endpoints；可能是 DNA primitive 的特殊计数时钟，需确认语义后处理，而不是直接忽略或设置虚假时钟。
5. FPGA 端口还有 `no_input_delay=44`、`no_output_delay=46`；必须根据 Gen 2 板级 ADC/DAC、电平/时钟/PCB 布局、数据手册和实际接口时序补约束。很多警告为不同类型，不一定所有端口都应套相同 `set_input_delay`。
6. 完整 signoff 尚未实现；还要复核 DRC、XDC、外部 ADC/DAC 的真正采样和建立/保持裕量。

## 7. 建议的后续实施计划（按优先级）

### Phase A：冻结可复现的当前基线

- 核实 `git status`、Vivado/venv 版本、当前 `crg.py` 是否已清理 `sys_quad`、AXI/CDC 修复是否在工作树。
- 建立可复现的 `baseline` 测试命令，确保备份两种实现（原版已清理 500 MHz 与 CE 候选版），不要把相同名字的报告混作同一设计。
- 对 `gateware/build/reports/*` 等实验产物合理 `.gitignore`，保留摘要及真正需要的对照报告，不把巨大 DCP/ZIP 全部提交到 Git。

### Phase B：收敛慢速 PID

- 在独立分支上引入 CE 候选，跑已有 16 种分频、220 周期 CE 等测试；扩展 CSR 读写不冻结、随机分频、复位、饱和、参数变更用例。
- 明确 `no_clock` 是否仍只剩 1 个以及剩余 `DNA_PORT` 原因。
- 对慢速 PID 关键路径先做细粒度 `report_timing`（含 `/R`），隔离乘法输入生成、DSP、积分累加、饱和/复位贡献。
- 评估一个或多个 **低延迟、可解释、受 CE 支配** 的流水方案；必要时引入新的中间寄存器，明确固定点输出影响。每次先仿真再综合，收益明显后再 route。

### Phase C：收敛快速 PID

- 单独 A/B 试验。不要重复已证明收益微小的乘加合并法。
- 目标：125 MHz 真实布局布线后的 Setup 满足时序（理想 ≥ +0.5 ns margin），并记录额外反馈延迟；既要 PID 正常也要扫频、锁定控制状态机保持一致。
- 比较候选与基线的 LUT、FF、DSP、BRAM、CE、latency、动态范围，尤其有符号乘法和饱和边界。

### Phase D：CDC 和接口签核

- 针对 PS↔FPGA 与 Scope 桥审核 CDC 结构和约束；评估异步时钟握手与真正的同步器数据窗口。
- 补 ADC/DAC 输入输出外部时序约束，按 FPGA 引脚实物和参考器件建立 timing budgets，重新 report_cdc/check_timing/STA/DRC。

### Phase E：bitstream / 板上验证 / 激光闭环

- 只有在 Setup、Hold、Pulse Width、CDC、相关 I/O、DRC 签核后才生成或部署候选 bitstream。
- 先使用**不接激光电流/PZT 的低风险回环/模拟信号**验证启动、CSR 读写、ADC 采集、DAC 输出、慢/快反馈端时序、重启和自动重连，再逐级进入真实激光稳频。

## 8. 每轮 Codex 实验记录模板（必须持续更新）

复制此模板在本文件末尾追加：

```markdown
### YYYY-MM-DD / 实验名
- 状态：PROPOSED / RUNNING / PASS-FUNCTIONAL / PASS-SYNTH / PASS-ROUTE / REJECTED / MERGED
- Git 分支/commit/工作树状态：
- 改动文件/关键实现：
- 预期收益、风险及反馈延迟变化：
- 仿真与数值比较（周期数、具体 PASS 标记）：
- 综合 WNS/TNS / LUT-FF-DSP-BRAM-BUFG：
- Routed WNS/TNS/WHS/WPWS、Setup 违规端点：
- check_timing no_clock、unconstrained、I/O：
- CDC 类别与物理安全说明：
- 关键路径起点→终点及 `/D`/`/R`：
- 与哪个 baseline 的哪份日志对照：
- 结论：保留 / 回退 / 需追加测试；下一轮：
```

**严禁**凭预期写 `PASS`；原先的实验候选源码被自动恢复时，必须把状态标为 `CANDIDATE/NOT_MERGED`。

## 9. 历史关键报告索引（在用户既有 `gateware/build/reports` 或上传记录中寻找）

| 文件 | 主要用途 | 证据范围 |
|---|---|---|
| `unused_clock_cleanup_20261106_131221.zip` | 无用 500 MHz BUFG 清理 | 综合 + clock/CDC/timing |
| `implementation_diagnostic_20261106_132616.zip` | 原版布局布线基线 | routed WNS −5.354 ns；no_clock=172 |
| `pid_mac_trial_20261106_135632.zip` | 乘加代数合并试验 | 455-cycle 比较 + synth，优化基本无收益 |
| `slow_clock_ce_trial_20261106_150257.zip` | 第一份完整慢速 CE 候选综合与仿真 | all test pass + synth |
| `slow_clock_ce_trial_20261106_151430.zip` | CE 候选仿真、综合、路线调用记录 | trial 成功、源码恢复；不代表 timings pass |
| `implementation_diagnostic_20261106_151752.zip` | CE 候选布局布线 | routed WNS −6.402 ns；no_clock=1 |
| `cdc_timing_20261106_110016.zip` | 原始 CDC/时序审查 | 综合检查、CDC 类别 |
| `timing_source_collection_20261106_113036.zip` | 当时的 17 份源码备份 | 源码审阅/方案依据，非当前源码权威版本 |

> 日志是工程证据，但**当前工作树才是当前源码事实**。若报告与当前代码不一致，先重建同样版本的实现并标明差异，不要强行用旧数据验收新代码。

## 10. 给 Codex 的首次任务（建议原样使用）

> 请阅读根目录 `AGENTS.md` 和 `docs/PORTING_STATUS.md`，然后检查当前 Git 状态和源码、现有 Vivado/XSim 报告。不要修改基线。先确认慢速 Clock Enable 候选是否已合并、源码是否与 2026-11-06 报告一致，以及慢速 PID 到 `/R` 的最长 125 MHz 路径为何经过乘法、饱和控制。给出可验证、可回退的最小优化方案，列明可能增加的反馈延迟和实验测试清单。确认后再在单独分支修改；先跑 Migen/RTL 回归和综合 A/B，对效果明显的方案再做布局布线。完成后更新状态文档，并报告全部未通过项目，严禁把 route success 当成 timing pass。


## 11. 2026-11-09 / 首轮隔离优化结果

- 状态：CANDIDATE / PASS-FUNCTIONAL / SYNTH-COMPLETE / ROUTE-COMPLETE / **STA-FAIL**。这四类状态不能互相替代；仅记录本机 Windows/Vivado 2020.1 实际结果，不宣称 GitHub CI、上板或闭环验证通过。
- 基线备份分支 `backup/20261106-pre-optimization`，提交 `a39000a802c27e0b6a904491ced4adaaceadfa35`；R0 隔离工具提交 `843a321`；R1 CE 提交 `c76d00b`；R2b代码提交 `502be6c9edc1269e21c766d9cce053025aa321fa`。
- 独立工作目录 `D:\RP_Dev\linien_trials\20261106-ce-saturation`。原 `D:\RP_Dev\linien-v2.1.0` 的168个有效源码/测试/文档文件SHA256核对未变化。
- 工具链：CPython 3.10.21、Migen 0.9.2、MiSoC 0.13（源码commit 98227d90be73ead8b797eca74da7c58d0c18f378）、Linien Common 2.1.0、Vivado 2020.1 build 2902540。完整环境锁定见 `requirements-gateware.lock.txt`。

| 实现 | 综合 WNS/TNS (ns) | Routed WNS/TNS (ns) | Setup失败端点 | WHS/WPWS (ns) | 决策 |
|---|---:|---:|---:|---:|---|
| 冻结原版 B0 | -5.966 / -4180.463 | -5.354 / -9445.378 | 6300 | 0.027 / 1.500 | 已备份，复现历史结果 |
| R1 CE兼容候选 | -5.966 / -4345.464 | -5.972 / -11109.872 | 7357 | 0.018 / 1.500 | 保留为架构候选，未签核 |
| R2a 通用高位比较 | -7.460 / -4609.988 | -6.448 / -10445.604 | 6955 | 0.021 / 1.500 | **REJECTED**，WNS恶化，不保留在生产PID源码 |
| R2b 直接位解码 | -6.094 / -4563.029 | -5.605 / -10473.525 | 6813 | 0.051 / 1.500 | 保留为候选，未签核 |
| R2b 同DCP重复实现 | 不重综合 | -5.605 / -10473.525 | 6813 | 0.051 / 1.500 | 同工具/directive完整重现 |

R2b相对R1：WNS改善0.367 ns；TNS减少636.347 ns负裕量；Setup失败端点减少544。原版慢速逻辑时钟有大量未约束端点，不能用原版全局WNS更好来证明原版慢速链已经满足要求。所有新候选仍为125 MHz、8 ns约束，没有新增false path/clock group/multicycle或删除I/O约束来制造通过。

实际保留的修改：

1. `fpga_image_helper.py` 和 `tools/run_gateware_trial.py`：PS BD、build、CSR map生成输出可隔离；每轮新目录，PS输入副本与Vivado project平级，防止改写原PS项目；stdout/stderr/退出码与标记、CSR协议和源码哈希检查；不生成bitstream。
2. `decimation.py`、`pid.py`、`limit.py`、`chains.py`、`linien_module.py`：固定sys125 MHz、数据寄存器CE，CSR读写不冻结。与旧候选不同，非法16..31保留Migen原Array默认最后一项的第15档行为，而非停更。k=0的+4ns采样相位差以及全局复位重启分频相位仍需明确接受，不宣称与旧逻辑时钟逐边沿等价。
3. `pid.py`：只对积分饱和条件作位模式解码；保留N+1位和、精确U和L=-U-1、符号/右移/截断、CE和复位优先级。新增PID数据寄存器/流水级为0。快慢PID分别以14/25位对照冻结参考；没有修改setpoint编码、Ki量纲、P/I/D固有延迟或CSR接口。
4. 新的 `tb_ce_saturation.py`：14/25位逐状态差分、极限积分状态、CE/reset、k=0..15至少三个真实事件、16/31完整事件、全部非法索引的动态用例、LimitCSR差分、CE=0真实CSRBank读写。Migen测试按其实际时钟调度构建参考模型，不以人工PASS替代断言。
5. `tb_bus_clk_bridge.sv`：浮点时间相等比较改为整数皮秒，消除1ps相位误报；通信RTL未改变。
6. `tools/report_pid_details.tcl`：仅打开已有routed DCP，分别输出快慢PID /D、/R、/S、/CE、反馈路径和DSP寄存器信息。`experiments/optimization_20261109` 保存失败候选、汇总和小体积日志/报告档案；不提交DCP/工具缓存。

测试证据：

- 每个实际候选均有7项既有pytest通过；CE和两种SAT候选均有 `PID_BIT_EXACT_PASS width=14/25`、完整分频事件、`DIVIDER_DYNAMIC_AND_INVALID_PASS`、`LIMIT_CE_BIT_EXACT_PASS`、`CSR_BUS_WRITE_READ_WITH_CE_ZERO_PASS`、`CE_SATURATION_SUITE_PASS`。
- 五个既有AXI/CDC/integration bench均通过；bridge的1/1250/3999/7999ps四相位用例通过；显式检查read/write背压、snapshot、8写8读及16单周期ACK、integration/reset PASS标记。
- B0功能证据目录 `20261109_092834_baseline`，其后构建隔离目录问题修正后的构建目录为 `20261109_093033_baseline`；功能相关输入SHA一致。失败运行日志保留，不冒充综合成功。
- R1：`20261109_094155_ce`；R2a：`20261109_095327_ce_sat`；R2b：`20261109_100550_ce_sat_bits`；重复实现：`20261109_101735_ce_sat_bits_repeat_route`。均在 `gateware/build/trials/` 下。
- 没有执行板上测试、激光/PZT操作、完整项目所有软件测试、形式等价证明或最终I/O/CDC签核。

关键路径和下一轮目标：

- R2b最差快速路径：`linienmodule_logic_pid_setpoint_storage_full_reg[1]/C` → `linienmodule_logic_pid_int_reg_reg[3]/D`，13.547ns（logic8.317、route5.230），16个CARRY4+1个DSP，仍严重违反8ns要求。
- R2b慢速 /D=-5.242ns、/S=-5.414ns；积分反馈路径慢速+2.101ns、快速+1.658ns。优先切分前端误差/乘法，不应盲目在已满足的积分反馈递推中加延迟。
- R1还发现 `slow_decimation` CSR → 慢速PID /R、/CE 的违规，布线约7.2ns；R2b布局下慢速/CE最差+0.258ns，裕量仍紧，应继续独立分组跟踪，不以一次布局结果宣称控制路径彻底解决。
- 后续带寄存器方案必须明确8/16ns等新增输入/输出延迟、保留P/I/D固有递推、携带采样/配置/reset/valid，并防止稀疏CE误变成整慢速tick延迟；本轮未实施。
- R2b no_clock=1、未约束内部端点=2（DNA）；no_input_delay=44、no_output_delay=46。CDC仍有Critical/Warning，默认DRC仍有241项Warning/Advisory。WHS/WPWS为正只对应当前已分析路径，**未完成CDC、I/O、DRC与完整STA签核**。
- R2b CDC-1=444，R1=439；差集为15条新增/10条移除，均为既有bridge payload到CSR接收寄存器副本的变化。没有新增时钟域的源码修改，但不能据此豁免，必须继续验证这些副本的物理CDC窗口。


## 12. 2026-11-09 / R4a 两级快速PID前端

- 状态CANDIDATE / FUNCTIONAL_PASS（明确新增延迟契约） / SYNTH_COMPLETE / ROUTE_COMPLETE / STA_FAIL。从R2b新建独立分支，R2b及原工程未变；R3失败分支仍独立保留。
- 新增pid_pipeline.py，快速PID使用误差/同拍系数快照+乘积两级；增加固定16ns真实反馈延迟，保持每拍吞吐、原积分递推、P/I/D相对时序、原CSR地址与常时钟读写。reset CSR随有效采样延后两拍，global reset立即清空在途事务；生产慢PID未修改。
- 原pid.py/chains.py Git代码无变更。新克隆core.autocrlf导致pid.py raw SHA不同，换行归一化后文本和Git blob一致；不把CRLF检出当作逻辑修改。
- 功能：原R2b测试保留；新增独立两拍原始输入参考、14/25位各4698周期9字段差分、饱和/CE/配置/reset和真实CSR；顶层3目标各750周期严格两拍输出比较、sweep/running同拍；最终8项pytest及全部AXI/CDC/四相位/既有CE套件PASS。首轮零延迟旧契约测试1失败/6通过，失败源码/日志保留，不能计作PASS。
- 综合WNS/TNS=-6.516/-4242.386ns（R2b=-6.094/-4563.029）；route WNS/TNS=-4.822/-7902.165ns、违规端点6288（R2b=-5.605/-10473.525、6813）。route改善WNS0.783ns、TNS2571.360ns、端点减少525；仍未签核。
- routed WHS=0.028、WPWS=1.500ns；hold/pulse失败0。no_clock=1、内部未约束2、I/O44/46仍在；XDC字节SHA与R2b完全相同。
- 全局最差改为robust time_scale[0]/C→gpio_n_o[0]/D，12.704ns=logic6.799+route5.905，24级（16 CARRY4+1 LUT2+1 LUT3+2 LUT4+3 LUT5+1 LUT6）。源码未改此监视逻辑，不能因其是GPIO而假设false path。
- 快速积分/D=-0.035ns；DSP内部前端仍-1.842ns（logic1.650、route7.568）。3个快速DSP均AREG=1/BREG=1/PREG=1/MREG=0，S1被吸入DSP输入寄存器；只看FD端点会漏检，不宣称快速PID已通过。
- CDC-1=436（R2b444），其余14/4/1/2/374不变；物理CDC未证明。默认DRC229条仍未签核。
- 原始报告、输入SHA、失败初次契约用例及恢复源码见experiments/r4_pipeline_20261109/r4a_logs_reports.zip和r4a_metrics.json。没有生成/部署bitstream或上板/激光闭环。
- 下一对照R4b：仅对error_s1输出加KEEP，保留独立S1误差寄存器，避免吸入DSP AREG；不改变运算、流水级数或16ns延迟。依据AMD UG901 DSP Block Implementation（https://docs.amd.com/r/2025.1-English/ug901-vivado-synthesis/DSP-Block-Implementation），KEEP可限制乘法操作数寄存器吸入DSP。效果需本机Vivado2020.1实际证明，不预判时序通过。
