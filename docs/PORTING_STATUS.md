> **2026-11-12 R75候选：从R72独立试验最终MAC乘数拆分，定向功能PASS；新综合/route尚待，最终未签核。R73b/R74物理失败均未选入。**

> **R72候选：core关键LUT物理pin交换待实际结果**。R69b fresh完整有效响应回归PASS，原strict idle差分FAIL保留；R71实际-.343/-5.363ns、24端点、core-.234。R72不改源码/周期/约束/反馈级，综合复用R69，功能复用R69b，逻辑和实际STA各自验收。

> **R71候选：内部clk_2 placement/routing TNS cleanup待结果**。R70实际-.343/-5.900ns、core-.205、hold+.027；逻辑仅新增3物理标记的等价已独立证明，原严格比较FAIL保留。R71无源码/反馈级/时钟/约束更改，综合复用R69，仍全局计时签核。

> **R70候选：仅placement/routing物理优化待运行**。硬件源逐RAW继承R69，综合REUSED_R69，不改寄存器/算术/时钟/约束，新增数据级0；新物理与完整逻辑网表严格等价检查结果待出。R69b fresh有效响应全回归仍在运行，原strict FAIL保留。

> **R69b候选：测试响应契约待运行，硬件逐RAW不改**。原R69 strict full FAIL保留。新检查ACK始终四态严格比较，有资格响应数据/ERR严格比较，数值/CSR/内存/状态断言不动；物理数据只复用R69 STA FAIL。

> **2026-11-12 R69实际：严格旧全回归FAIL、最终STA FAIL**。32新增故障例PASS；Scope在无ACK复位周期RDATA0/1差分FAIL，后续项未运行。route -.411/-30.808ns、242端点，WHS+.027/THS0。独立R69b将核对有效响应契约，硬件暂不改；原始FAIL完整保留，不能宣称完整通过或可上板。

> **R69输入冻结前：32例新增故障/重放/非法数据检查及actual Root取消连线PASS**。当前实际硬件是R66 DAC+R67 PS ASR+R69 timeout cancel，精确组件和SHA见R69_INPUT_COMPONENTS.md。新完整功能/综合/route待运行，整体未签核。

> **R69组合选择更新**：R68实际route变差且hold FAIL，不采用其clock重编码；R69实际源码已恢复R66 DAC+R67 PS ASR，继续超时取消整改。R68失败现场独立保留。

> **2026-11-12 R69候选：已复现停钟超时写重放，新增SYS epoch取消与无效读payload隔离，待验证**。正常反馈级/CSR地址不变；父R68物理仍运行，不假定其签核。

> **2026-11-12 R68候选：同pad波形正边沿DAC时钟输出，待原生/实际PLL/物理实现**。父R67 PS reset修复原生PASS；R66 route -.343/-6.398ns仍FAIL。WRT/CLK通过实际PLL相位+ODDR极性重编码保留引脚边沿，新增数据级0，未降低采样率或改I/O预算。

> **2026-11-12 R67候选：PS reset释放整改待验证**。独立分支，新增sys_ps标准ASR和AXI reset连线；只加复位释放2个FCLK等待，不加正常数据反馈级。继承R66待完成物理输入，未假定其STA通过。

> **2026-11-12 R66候选：待原生验证/综合/route**。DAC时隙改正边沿phase-history+XOR，以真实4ns预算代替2ns控制路径；新增数据级0，必须验证同边沿hold及完整A/B启动/复位波形。R65失败源码及报告冻结保留，其他I/O/CDC签核未关闭。

> **2026-11-12 R65实际：REJECTED**。新综合/route完成，WNS/TNS=-.683/-55.023ns、312端点；WHS/THS=+.024/0、无hold违例，最终STA FAIL。原生analog PASS，完整功能本轮NOT RERUN。ADC+.429/+3.304，DAC-.343/+.070ns（必要零PCB模型）。失败源码/DCP/日志/SHA保留，不部署。以下待运行条目是历史。

> **2026-11-12 R65候选：物理实现待运行**。14个SAME_EDGE/D1=D2 data ODDR换为250MHz SDR IOB FDRE，原控制/数据FF保持，数学同波形、目标额外数据级0。完整原生新旧analog49位稳定边沿/启动/复位/四包络/样本负例PASS；新综合/route待结果。其他组件暂参考R64同源完整PASS，不写成本轮完整重跑。见R65_DAC_SDR_IOB.md；I/O/物理CDC/DRC未最终签核。

> **2026-11-12 R64实际结果：REJECTED**。新完整功能PASS、CSR map PASS、新综合/route完成；WNS/TNS=-.748/-44.222ns、254端点，WHS/THS=-1.901/-26.110ns、14端点。2ns控制→ODDR路径FAIL；SAME_EDGE/D1=D2虽实际是SDR波形，STA仍有下降沿输出路径；下一候选用真实SDR IOB FF表达，不能cut路径。ADC仍+.429/+3.304ns。源/日志/DCP/SHA归档，不合并、不部署。以下为历史。

> **2026-11-12 R63实际结果：ADC_COMPONENT_CANDIDATE**。28个ADC必要预算setup+.429/hold+3.304ns，真实0-cycle setup/-8ns hold边沿逐条核验PASS；新综合和route完成。整机WNS/TNS=-.835/-14.041、32端点，hold-.456/-5.876、14端点；DAC仍FAIL，内部18端点WNS-.389。最终未签核，不部署。完整功能本轮NOT RERUN，原生analog本轮PASS，其他组件参考R62同SHA完整回归。以下为历史。

> **2026-11-12 R62实际结果：REJECTED**。完整功能PASS，新综合及route完成；硅器件必要I/O预算下WNS/TNS=-1.261/-2245.782ns、3604端点；WHS/THS=-.696/-23.517ns、42端点，最终STA FAIL。下降沿导致ADC→CORDIC只有4ns预算，实际5.209ns。原源码/全部阶段日志/DCP/SHA均保留，不合并。原R61b/R60冻结。以下条目为历史快照。

> **2026-11-11 R60历史结果**：受约束setup/hold/pulse均PASS，final WNS=+.003ns/TNS=0/0端点；最终STA仍FAIL（DNA/I/O覆盖、物理CDC和DRC未关闭）。候选不部署，完整功能/综合复用R52，见文末与R60_SIGNOFF_GAPS_20261111.md。

> **2026-11-11 R59最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.204/-5.183ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R57最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.006/-0.016ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R56最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.205/-0.942ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R53最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.014/-0.052ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R52最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.222/-6.177ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R48最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.179/-4.904ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R47最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.282/-5.173ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R46最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.539/-18.344ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R44最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.691/-136.392ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R43最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.578/-43.286ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R41最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.791/-90.059ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R38最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.619/-83.023ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-11 R36最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-0.656/-59.314ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R29最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.617/-91.147ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R28最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.788/-99.471ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R26最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-0.91/-190.722ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R20最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-1.838/-600.003ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R18最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-2.326/-1448.239ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R18 RUNNING**：IIR C48精确MAC零新增周期候选。71760组全50位乘加、order1/2/5各约18000拍完整滤波器以及14/25位配置一拍对齐原生差分均PASS；尚无综合/route结果。当前保留R17 -2.800/-4213.790ns、STA FAIL，新增反馈8ns；R18相对R17新增0。R16/基线不改，见R18_PLAN.md。

> **2026-11-10 R17 RUNNING**：独立混合器MREG一级与采样/配置对齐候选；新增快速数据延迟8ns，不能视为签核版本。联合原生RTL14/25位44290/44292拍、IIR配置对齐17930/18016拍PASS；尚无本轮综合/route结果。R16冻结不动，WNS/TNS=-4.068/-5780.718ns，STA FAIL。详见R17_PLAN.md。

> **2026-11-10 R16最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-4.068/-5780.718ns，最终STA FAIL。详细归档见本文末尾。

> **2026-11-10 R16 RUNNING**：R14与R12混合器组合的独立候选，尚无本轮完整功能/综合/route结果。当前更优候选仍R14 -4.093/-6274.995ns、STA FAIL。新增延迟相对R14为0，R4a/R2b/原工程不改。见R16_PLAN.md。

> **2026-11-10 R14 RUNNING**：独立组合试验，含R13慢支路16ns候选，再给robust判定增加1sys=8ns，ADC→DAC持续数据通路相对R13不再加级。R13非CSR慢PID算术端点无负裕量，但全局WNS/TNS=-5.137/-9054.302，仍REJECTED且未合并R4a。R14父模块/真实CSR/独立延迟原始输入配置参考的RTL差分50076拍通过，已知50021、RAM未知55均严格四态比较；综合/route/STA尚未验收。详见R14_PLAN.md。

> **2026-11-10 R13 RUNNING**：独立慢PID事务流水线候选；保留R4a/R2b/原工程不变。R12 route WNS/TNS=-5.156/-9847.520ns，REJECTED。R13实际RTL差分413022拍、4171提交、32分频配置及正/负饱和51/57通过；额外慢支路16ns、快速主支路额外0，analog0扫频贡献也延后16ns。尚无R13综合/route/STA结果，不能上板。详见R13_PLAN.md与CONTROL_DESIGN_TARGETS.md。

# Linien v2.1.0 → Red Pitaya STEMlab 125-14 PRO Z7020 Gen 2

> **R4更新 2026-11-09**：两级快速PID新增16ns，当前保留R4a候选；功能按明确延迟契约通过、综合和route完成、最终STA失败。R4a route WNS=-4.822ns；R4b=-5.820ns。R2b/原工程/R3不变。最新见第12/13节及docs/R4_RESULT_20261109.md。

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


## 13. 2026-11-09 / R4b KEEP共享误差级对照

- R4a提交4e98ddb431ad19d6233399e6e4cb1740bee5e75d；R4b代码提交6846b99543e9abe1fed75b0fc55a07e605c80b5b。R4b判定：REJECTED / not merged into R4a；当前保留候选R4a，仍STA_FAIL，未合并R2b、未部署。
- 相比R4a仅新增error_s1输出KEEP，数学/协议/两级结构不变，新增反馈延迟仍16ns。8项pytest、两种位宽延迟参考/边界/reset/CE/真实CSR、全部原CE/AXI/CDC/四相位PASS；CSR映射及XDC字节与R2b相同。
- 综合WNS/TNS=-6.288/-4154.476ns；route=-5.820/-9325.396ns、Setup失败端点6960，WHS/WPWS=0.022/1.500ns。综合/route COMPLETE与STA FAIL分开记录。
- DSP内部和普通数据/控制引脚细分、实际AREG/BREG/PREG、CDC完整差集、输入SHA与所有PASS/FAIL见docs/R4_RESULT_20261109.md和experiments/r4_pipeline_20261109/metrics.json。两组源码与ZIP完整性已检查，测试输入未变化。
- CDC-1=435，对R2b规范化新增357/移除366；物理CDC未证明。no_clock/内部未约束/I/O仍1/2/44/46。默认DRC与其它剩余路径按原始报告保留，未签核。
- 原工程168文件SHA未变，R2b/R3工作树干净。pid.py、chains.py、decimation/limit、AXI/CDC/时钟/板级代码在Git中保持R2b原样；新候选只在新分支/文件实现。
- 下一轮根据实际最差路径安排：快速误差级和积分饱和物理收敛、慢PID事务/下游采样协议、robust动态延迟/abs/阈值链与CSR译码分别评估；不能把当前结果当作最终可上板版本，也没有证据说明125MHz目标“无论如何不可能”。


## R16 / 2026-11-10归档 / mixer时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `e7abddf066877c27ee1fde34c69d6af50fde0cb3`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r16-combined-mixer-pipelines`；R4a/R2b/原用户工程保持原样。
- 功能：原生RTL父FPGAAutolock+真实CSR+独立延迟原始输入/配置的冻结R4a Robust参考50076拍PASS，已知50021、RAM未知55均严格四态比较，watch31468/advanced32181/lock27427；原robust非slow5项PASS；R13完整慢链413022拍/32分频/4171提交/饱和51与57再次PASS；指定Bare及快→慢串接数字延迟正负脉冲PASS；混合器实际DSP/CSR/FastChainFF差分重新PASS（33096与10000拍）；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=快速主支路相对R4a新增0拍；慢PID/analog0扫频贡献新增2sys=16ns；robust判定新增1sys=8ns；快→慢串接相对R2b累计新增32ns。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-3.911/-3598.924ns。实际route COMPLETE，WNS/TNS=-4.068/-5780.718ns，失败端点5437；WHS/WPWS=0.038/1.5ns，THS=0。
- raw IIR内部最差=-2.834ns，入口=-4.059ns；全局最差 `DSP48E1_1/CLK` → `linienmodule_logic_limit_error_signal_limitcsr_y_reg[8]/D`，逻辑/布线=['6.876', '4.808']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 14008, 'ff': 13768, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=218。
- CDC={'CDC-1': 453, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 2, 'CDC-15': 374}，严格名称差集新增21/移除4；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，无时序例外/时钟放宽。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r16_mixer_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## 2026-11-10 本轮交付与当前保留关系

当前较优源码候选R16，代码e7abddf，原生回归PASS、综合COMPLETE、实际route COMPLETE、最终STA FAIL。route WNS/TNS=-4.068/-5780.718ns、Setup失败5437、WHS=.038、THS0、WPWS1.5；相对R4a改善.754ns/2121.447ns，减少851端点。R11–R13失败保留；R14/R15/R16为未签核候选，全部未合并R4a/R2b和原用户工程。

快主支路相对R4a新增0，保留相对R2b累计16ns；慢/analog0贡献相对R4a新增16ns，特定快→慢串接累计32ns；robust判定额外8ns，不能加到全部持续样本上。已重新测量指定P-only数字模型Bare DAC A56.1ns、快A→慢→DAC B92.1ns；此前漏顶层FF的32.1/48.1ns绝对值作废，完整更正在OPTIMIZATION_ROUNDS_20261110.md。模型不含转换器内部/模拟/板级，不是已验证闭环带宽。

全局瓶颈DSP48E1_1/CLK→error limit.y[8]/D，logic6.876+route4.808ns；快速PID/S仍-.105ns，慢PID含CSR当前最差+.936ns且负端点0，但慢链其他路径及IIR/autolock仍违规。CDC-1=453、其他14/4/1/2/374，物理CDC NOT_PROVEN；DNA no_clock1/未约束2、I/O44/46与DRC218未签核。没有新增放宽时钟或掩盖违例的例外，没有bitstream或板上/激光操作。

完整六轮对比、每类/D/S/R/CE实际路径、数学依据、文件变更、全部PASS/FAIL/REUSED、下一阶段8/16ns方案（尚未实施）及PowerShell重复入口见docs/OPTIMIZATION_ROUNDS_20261110.md。逐文件输入SHA与证据索引见experiments/r16_mixer_20261110/verification_index.json；原生日志/报告/源码/测试向量见各独立轮次experiments归档。所有构建期间和记录前源哈希差异为空；归档后的文档更新不属于硬件输入改变。


## R18 / 2026-11-10归档 / iir时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `32b813910a6f74572ce180e354608be5333274e9`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r18-iir-c48-mac`；R4a/R2b/原用户工程保持原样。
- 功能：新增原生UNISIM DSP/真实CSR联合帧14/25位44290/44292拍、全512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；IIR配置对齐14/25位17930/18016拍与冻结RTL及28/50位整数oracle PASS；R13慢链与R14 robust父模块套件再次PASS；R17指定Bare/快慢串接模型正负脉冲确认新增8ns（64.1/100.1ns），R18继承同组件/零周期MAC契约，未重跑数字模型；C48完整50位MAC71760组PASS（正/负48位溢出6776/6995，50位回绕4039），order1/2/5完整IIR17920/17944/18016拍三方差分PASS，MAC增加周期0；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增1sys=8ns，快速相对R2b累计24ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外24ns、相对R2b累计40ns；robust自身判定仍8ns；R18 MAC自身新增0拍。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-1.818/-592.081ns。实际route COMPLETE，WNS/TNS=-2.326/-1448.239ns，失败端点1955；WHS/WPWS=0.051/1.5ns，THS=0。
- raw IIR内部最差=-2.05ns，入口=-2.326ns；全局最差 `DSP48E1_1/CLK` → `linienmodule_iir_low0_i_16_psdsp_5/D`，逻辑/布线=['4.816', '5.178']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 12223, 'ff': 12395, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=224。
- CDC={'CDC-1': 444, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 2, 'CDC-15': 374}，严格名称差集新增378/移除370；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r18_iir_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R20 / 2026-11-10归档 / iir时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `ac35a5beb1860163f0d0658d04a05d77e2ebef01`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r20-iir-preg-relocation`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；R20继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；新增时钟化原生DSP完整50位乘加71760组PASS，order1/2/5完整IIR/真实CSR/热写/hold/clear/reset/overflow-hold三方差分PASS；初始错误OPMODE0x65原生仿真FAIL，失败提交e113a81与日志保留，依据本机UNISIM Z-mux实现改为0x55后重新全套验证；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20只重定位既有IIR状态寄存器，新增周期0。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-1.811/-391.486ns。实际route COMPLETE，WNS/TNS=-1.838/-600.003ns，失败端点1287；WHS/WPWS=0.04/1.5ns，THS=0。
- raw IIR内部最差=-0.518ns，入口=-0.519ns；全局最差 `linienmodule_fast_a_iir0_y2_reg[15]/C` → `DSP48E1_68_i_18_psdsp/D`，逻辑/布线=['3.805', '5.955']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 12064, 'ff': 14715, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=411。
- CDC={'CDC-1': 436, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增381/移除381；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r20_iir_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R26 / 2026-11-10归档 / mixer时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `c105b02bc8c156792b36cf64cd615be2315b47dd`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r26-scope-late-average`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-1.908/-316.14ns。实际route COMPLETE，WNS/TNS=-0.91/-190.722ns，失败端点751；WHS/WPWS=0.02/1.5ns，THS=0。
- raw IIR内部最差=-0.296ns，入口=-0.257ns；全局最差 `linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast1_x_reg[17]/D`，逻辑/布线=['4.528', '4.197']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 15218, 'ff': 15800, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=410。
- CDC={'CDC-1': 439, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增369/移除366；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r26_mixer_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R28 / 2026-11-10归档 / pid时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `9c5c32a46c53a7eb4cd38e7c9e7acba233cfc119`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r28-pid-output-bitdecode`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；R28已重新执行当前生产PID/Analog/ODDR组件模型，±123脉冲Bare72.1ns/快慢串接108.1ns，0新增周期；并非full-root/SDF/板端测量，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；共用PipelinedPID快25/慢14两处输出饱和高位解码（更正初始fast-only范围说明）：原生生产helper/原比较器/整数oracle14位完整51位输入80217组、25位完整84位输入80349组及小位宽穷举224组PASS；高位全0/全1、正负饱和边界、邻值、随机区间内外；原完整联合PID/真实CSR/CE/reset等回归再次执行，新增反馈周期0，不携带已拒绝的R27 Root CSA；原生慢链413022拍/32分频/4171提交再次PASS，原sum同步语句AST与base PID一致；两处输出钳位改变，但积分/CE/reset/CSR/流水级不变，实际Root生成位段与signed CSR边界核对PASS；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-1.908/-307.63ns。实际route COMPLETE，WNS/TNS=-0.788/-99.471ns，失败端点566；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=-0.177ns，入口=-0.212ns；全局最差 `linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`，逻辑/布线=['2.430', '6.172']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 15139, 'ff': 15857, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=413。
- CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增380/移除375；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r28_pid_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## 2026-11-10 / R28当前候选、范围更正与下一步

R28代码9c5c32a，功能PASS、综合COMPLETE、实际route COMPLETE、最终STA FAIL。WNS/TNS−.788/−99.471ns、566违规端点、WHS.014/THS0/WPWS1.5。相对R26 WNS改善.122ns、TNS改善91.251ns、端点减少185；相对R25 WNS改善.193ns、TNS改善74.580ns、端点减少77。保留为未签核候选，不合并基线、不上板。

**修改范围更正**：PipelinedSlowChain也共享PipelinedPID，故本轮快25/慢14两处输出饱和组合逻辑都替换。先前“只快PID/慢PID未变”说明不准确。原sum同步语句AST和base PID一致；pid.py/slow_pipeline.py/feedback_pipeline.py/Root文件与R26 blob一致。两处只是组合钳位变换，积分/CE/复位/CSR/串行流水级不变。实际Root快83:24、慢50:13高位解码核对PASS；慢链413022拍/32分频/4171提交PASS。原始输入计划已归档，更正发生在构建结束后，不改历史manifest。

快速PID to-group /D+.826、/S+.217、/R+.979、/CE+.801ns；slow PID本体CSR/非CSR负端点0。PID outgoing仍−.204ns，PIDsum[30]/C→limit_fast2.x[17]/D，13级/6CARRY4、logic3.061+route5.146ns；不能因为PID内部正裕量就称整条快通路通过。R26相应路径−.910ns/20级14CARRY4，证明本轮减少了饱和长进位链，但仍有后级求和/布线残余。

全局autolock current_instruction_idx[1]rep3/C→gpio_n_o[6]replica/D，9级、logic2.430+route6.172ns（约72%布线）。FastChain A/B输出路径−.637/−.442ns；raw内部−.177ns（DSP/CLK→DSP/CEB2）和外部入口−.212ns，必须继续区分数据与CE控制。Scope平均控制+2.344ns。下一轮优先同网表post-route critical-cell/fanout/placement/routing优化，新增串行周期0；若失败保留、不合并，再考虑有真实pre-D/同cohort/复位证明的DSP输入寄存器复制。

R28已重新执行当前生产PID/Analog/ODDR指定数字组件模型：±123脉冲Bare72.1ns/9sys、DAC写74.1ns；快慢串接108.1ns/13sys、写110.1ns。R28新增周期0。这不是完整Root/SDF/板端/转换器/模拟延迟，更不是实测闭环带宽。

CDC441/14/4/1/10=1/13=1/15=374，严格名称差集新增380/移除375，仅数量变化不证明物理安全。DNA no_clock1/内部2、44输入/46输出无外部延迟覆盖和DRC413仍未关闭；原8ns约束/XDC保持，未添加掩盖违例的例外。

R27 Root CSA代码cffb1f2/记录e9c9fd5已失败归档、未携入R28。R2b/R4a/R16/原用户工程的源码/head/status再次核验不变。R28上传GitHub目前因TCP443连接失败/连接重置待完成，本地提交/源码和SHA证据完整；不把失败推送标为成功。


## R29 / 2026-11-10归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `be6a64e596b6db1c910e982444fb2a0422a2a2ec`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r29-postroute-fanout`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R28_EXACT_INPUTS_NOT_RERUN：74个硬件/测试输入原始SHA与R28完全一致，复用9c5c32a原生功能回归；本轮未重新运行RTL回归，不是post-route/SDF形式等价证明。未修改RTL/寄存器串行边沿/CSR/8ns XDC，新增周期0。输入R28 routed.dcp前后SHA相同，R29b只执行合法post-route placement/routing/rewire/critical-cell和route Explore/tns_cleanup；R29a不支持fanout_opt调用FAIL单独保留，无新WNS；没有修改Migen evaluator。
- REUSED_R28：原pytest/PID/慢链/IIR/Scope/AXI/CDC/CSR回归均有R28 PASS证据，本轮NOT RERUN；原约束及输入DCP哈希核验PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=REUSED_R28_EXACT_DCP_NOT_RERUN，WNS/TNS=-1.908/-307.63ns。实际route COMPLETE，WNS/TNS=-0.617/-91.147ns，失败端点545；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=-0.177ns，入口=-0.212ns；全局最差 `linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__0/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`，逻辑/布线=['2.973', '5.330']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 15139, 'ff': 15860, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=413。
- CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增380/移除375；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r29_physical_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R36 / 2026-11-11归档 / autolock时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `52fba6b91be6e7db1e00a7603d77dabb617d7446`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r36-instruction-prefetch`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R28指定数字组件已重测Bare72.1ns/快慢108.1ns；本轮PID/Analog/Root源码未改，继承同周期契约，本轮未重测组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；新增同原CSR采样沿的current/next/zero指令预取：真实32项unsigned峰值/wait CSRBank，原整bank/生产helper/独立整数oracle，14/25/28位63520/63648/63648拍，全部32索引与31→0/连续递增/保持/at_start优先/有限最小负数abs/完整负阈值/部分字节热写两顺序/读回/复位PASS，各3000严格X/Z（含旋转next Case与原wrap5加法索引独立probe的X/Z默认31）；原父模块50076向量前缀SHA ca7dc8c929788b77f392e892728423677edc5173b36d061c6030df7199d14e2e原样保留且全部旧断言保留，扩展51628拍/51573known/55unknown、32自然索引、kind0/1/2合法PASS，软件5项robust测试PASS。原FSM及元数据同步AST相同，实际生成3组缓存/choice2位、CSR/XDC及PID/IIR/Root/GPIO/AXI/CDC/Scope源码保持检查PASS。理论cohort位2304→218，不预先等同物理FF数。ADC→DAC/robust/GPIO本轮新增0周期，不携入R34外部8ns或R35驱动105副本；不是简单延迟旧选中阈值。跨域与同ADC域违例独立报告，不添加时序例外；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-1.908/-303.52ns。实际route COMPLETE，WNS/TNS=-0.656/-59.314ns，失败端点371；WHS/WPWS=0.015/1.5ns，THS=0。
- raw IIR内部最差=-0.162ns，入口=0.018ns；全局最差 `linienmodule_fast_a_common_reg[5]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`，逻辑/布线=['2.435', '5.703']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 12485, 'ff': 13648, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=408。
- CDC={'CDC-1': 432, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增369/移除373；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r36_autolock_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R38 / 2026-11-11归档 / autolock时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `291fbec246fe0e7764aee34a03b9b8909c128186`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r38-common-alias-buffer`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R28指定数字组件已重测Bare72.1ns/快慢108.1ns；本轮PID/Analog/Root源码未改，继承同周期契约，本轮未重测组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；原R36同cohort指令预取、32项CSR14/25/28位63520/63648/63648拍（各3000X/Z）、父模块51628拍/32自然索引/原50076前缀SHA与所有旧断言再次PASS。本轮只删除common_sum.keep一条源元数据调用，后端实际解除4个DONT_TOUCH声明；全行为AST及整个生产top.v除精确4属性外与R36相同，正负限幅值和两类错误标志保护均原样保留，未携入R37的24值属性删除。R36实际网表LUT1 INIT2h2恒等BUF已验证，试图允许别名合并；只读证据不预先证明当前BUF已消除，实际映射与route单独审计。完整tap/FastChain/CSR/CE/reset/全部回归本轮重新执行，ADC/robust/GPIO新增0周期，无新例外；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-1.908/-263.098ns。实际route COMPLETE，WNS/TNS=-0.619/-83.023ns，失败端点451；WHS/WPWS=0.032/1.5ns，THS=0。
- raw IIR内部最差=-0.22ns，入口=-0.125ns；全局最差 `red_pitaya_scope/i_bridge/addr_o_reg[17]/C` → `red_pitaya_scope/set_a_filt_kk_reg[15]/CE`，逻辑/布线=['1.694', '8.021']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 12168, 'ff': 13573, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=406。
- CDC={'CDC-1': 432, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增368/移除372；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r38_autolock_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R41 / 2026-11-11归档 / physical时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `9479e4e72e84a0b5464bf6492544eb0a1ad6d1e6`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r41-scope-source-predecode`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；Scope源域同请求沿17个地址预译码替换19处写配置/ARM/复位/触发比较，桥只增加原请求接收条件输出，原状态/2FF/ACK/数据快照逐句不变，其他Scope逻辑词法还原完全相同；冻结R38完整Scope和bridge独立原生四相位0/1/2/3ns、每组1652事务，全部配置/控制/保持/热写/读回/高位别名/非法/XZ地址、源忙时输入变化与协调复位逐拍严格四态PASS，ADC/CSR/触发新增0周期；旧Scope回归源码未改，完整旧功能重新运行。源码检查初版把CRLF原始文件与git LF blob作字节比较误报，改为R38原始字节与独立规范化git检查，保留旧checker；未改生产或弱化原功能断言。源码数学同cohort等价与新物理CDC预算是不同结论，独立复位/亚稳态/板端物理安全未由该测试证明；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-1.908/-250.466ns。实际route COMPLETE，WNS/TNS=-0.791/-90.059ns，失败端点522；WHS/WPWS=0.05/1.5ns，THS=0。
- raw IIR内部最差=-0.114ns，入口=0.17ns；全局最差 `red_pitaya_scope/set_dec_reg[23]/C` → `red_pitaya_scope/adc_a_dat_reg[7]/D`，逻辑/布线=['1.634', '6.943']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 12108, 'ff': 13548, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=406。
- CDC={'CDC-1': 422, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增398/移除412；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r41_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R43首次物理流程查询中止 / 2026-11-11

失败代码1403c56：只计Scope局部层次net负载（最大43）而非整条网全部层次segment的leaf负载（真实4网154/169/99/121），因此没有选出>=96目标，主动ERROR并在复制前退出。属于流程查询错误，不是本轮物理优化WNS结果；本轮新route NOT RUN。输入R41 DCP SHA不变、源码运行中无修改，原FAIL日志/TCL/源码/manifest和只读全segment诊断归档experiments/r43_query_setup_failure_20261111。修正为get_nets -segments/get_pins -leaf后新建试验目录重跑，不覆盖初版。


## R43 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `4038738b7ca622dba2b7a741f4b8c496e2bf7790`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r43-scope-csr-distribution`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R41_EXACT_INPUTS_NOT_RERUN：81个原始硬件测试SHA一致，原生全功能/Scope冻结四相位/14与25位/真实CSR/PID/IIR/AXI/CDC明确复用R41，本轮未重跑RTL或综合。对ADC域CE恒1非ASYNC_REG的CSR Q>=192网及Scope average_select单输出LUT>=96 leaf负载网作工具物理复制，Scope LUT638→675、最大leaf169→69，CSR FD16→70、最大负载598→193。CSR复制D/C/CE/R/INIT及聚合负载完全一致、全部94DSP寄存器属性相同，输入DCP SHA不变，追加串行周期0。首次局部segment计数漏跨层次负载而在复制前主动中止，失败源码/日志与诊断保留，修正全segment/leaf后新目录重跑成功；不是把中止当实际route失败/成功。完整Root postroute/SDF形式等价NOT_RUN，跨域物理安全NOT_PROVEN。；没有修改Migen evaluator。
- 完整功能与综合REUSED_R41_NOT_RERUN；本轮新做物理复制结构/DSP审计及实际route/STA/CDC；CSR map与XDC保持R4a一致。延迟=本轮只复制同拍CSR数据驱动/Scope组合译码，ADC/CSR/Scope/触发新增周期0；R41原始硬件测试SHA完全一致，R28组件Bare72.1ns/串接108.1ns只继承，不是本轮重测或板端测量。
- 综合来源=REUSED_R41_EXACT_DCP_NOT_RERUN，WNS/TNS=-1.908/-250.466ns。实际route COMPLETE，WNS/TNS=-0.578/-43.286ns，失败端点366；WHS/WPWS=0.019/1.5ns，THS=0。
- raw IIR内部最差=-0.124ns，入口=0.552ns；全局最差 `red_pitaya_scope/set_dec_reg[17]_replica/C` → `red_pitaya_scope/adc_a_dat_reg[11]/D`，逻辑/布线=['1.634', '6.728']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 12146, 'ff': 13620, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=406。
- CDC={'CDC-1': 494, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 392}，严格名称差集新增488/移除412；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r43_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R44 / 2026-11-11归档 / physical时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `408d899de3235f582d6b5722ff4a7dbe4eb08dd4`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r44-scope-factor-cache`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；Scope因子伴随缓存：在原FCLK请求接收沿编码5位shift/1位exactzero，与原wdata_o同cohort；原ADC写set_dec沿同时提交6位，原32位set_dec/读回/decimation比较/CSR/触发与采样寄存器不变。仅新增12位平行metadata，数据/反馈/Scope/CSR/触发新增串行周期0。实际新decoder+cached barrel helper与冻结case/整数oracle161872已知+3000X/Z、全部32power2/零/非法/低16位穷举、avgX/Z/局部未知数据PASS；完整独立冻结R38 Scope+bridge四相位0/1/2/3ns、每组2036事务，原配置/触发/忙时输入变动/别名/非法未知地址外新增真实未知写数据和avgX/Z，源每个accept与目标每个ADC沿cohort断言PASS。原helper和旧测试原始字节保留，逆变换还原完整旧Scope其他逻辑；完整所有旧功能重新执行。不是postroute/SDF/物理CDC证明，新FCLK/ADC缓存与数据路径需各自审计；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-1.376/-207.877ns。实际route COMPLETE，WNS/TNS=-0.691/-136.392ns，失败端点707；WHS/WPWS=0.03/1.5ns，THS=0。
- raw IIR内部最差=-0.505ns，入口=0.015ns；全局最差 `linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__1/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`，逻辑/布线=['3.727', '4.805']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 12234, 'ff': 13642, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=408。
- CDC={'CDC-1': 435, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除374；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r44_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R46 / 2026-11-11归档 / autolock时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `827dfeca13acd2ccc6640e6ac7217800bf3d4e12`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r46-prefetch-negative-fold`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；R44 Scope源域/因子缓存全部再次原生PASS（新decoder+cached helper161872已知+3000X-Z、冻结完整Scope四相位每组2036事务及source/target cohort断言），本轮只改instruction_prefetch负阈值组合输入。旧signed abs_N再加宽取负保留MIN→正2^(N-1)特殊值；新lowN=(p<0?p:-p)、high=(p>0)|((p<0)&p!=MIN)，拼接N+1位，消去串行双重取负。修改前N1..16全131070例和14/25/28各100006随机边界数学PASS；原样真实unsigned32CSRBank/整bank冻结RTL/整数oracle14/25/28分别63520/63648/63648拍、MIN/全32索引/两序部分写/复位/各3000X-Z PASS，父模块及全部旧回归重新执行。完整源逆变换精确还原旧helper，所有FSM/choice/magnitude/positive/wait/CSR/其他源和旧测试保持，采样及ADC/robust/GPIO/CSR新增周期0，不携入R45 IIR重定时。MSB与低位物理路径、其他瓶颈按实际report单独比较；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-1.376/-180.925ns。实际route COMPLETE，WNS/TNS=-0.539/-18.344ns，失败端点131；WHS/WPWS=0.049/1.5ns，THS=0。
- raw IIR内部最差=-0.162ns，入口=0.278ns；全局最差 `linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`，逻辑/布线=['5.972', '1.957']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11679, 'ff': 13502, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增382/移除374；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r46_autolock_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R47 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `d839e67c7977772cc2113a8d70cc91db2fa41020`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r47-iir-enable-placement`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R46_EXACT_INPUTS_NOT_RERUN：83个原始硬件测试SHA一致，R46完整14/25/28预取/真实CSR/父模块/Scope同cohort/IIR/PID/AXI/CDC原生PASS和综合明确复用，本轮未重跑。内存unroute R46 checkpoint后按实际BREG1/BCASCREG1/ADC时钟/CEB2驱动LUT查询，并以此时未布线估算负slack筛选8条网；这一筛选不是R46 routed slack，已单独记录，不混用。标准force_replication、placement/rewire/critical-cell与真实route Explore/tns_cleanup。CSR组当时未选中，CSR D/C/CE/R/INIT/聚合负载一致、18个DSP CEB2直接LUT函数在force前后完整truth-table含输入置换审计相同、全部94DSP参数及寄存器属性同真实输入R46、DCP SHA不变，新增串行周期0。最终route才用于候选优劣判断；不是fullRoot postroute/SDF/形式等价或CDC物理签核。；没有修改Migen evaluator。
- 完整功能和综合REUSED_R46_NOT_RERUN；本轮新做LUT函数/结构/DSP审计与实际route/STA/CDC；CSR map与XDC保持R4a一致。延迟=本轮只标准工具物理复制IIR组合使能驱动，83个原始硬件/测试SHA同R46，新增任何ADC/反馈/CSR/采样边沿0；R28指定组件Bare72.1/快慢108.1ns只继承，不是本轮重测或板端。
- 综合来源=REUSED_R46_EXACT_DCP_NOT_RERUN，WNS/TNS=-1.376/-180.925ns。实际route COMPLETE，WNS/TNS=-0.282/-5.173ns，失败端点70；WHS/WPWS=0.015/1.5ns，THS=0。
- raw IIR内部最差=-0.202ns，入口=0.259ns；全局最差 `linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`，逻辑/布线=['5.972', '1.700']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11692, 'ff': 13504, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增382/移除374；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r47_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R48选项兼容性中止与阶段日志修正 / 2026-11-11

代码1f0b1dc在phys_opt_design入口因Vivado_Tcl4-1061中止：该post-route场景下-tns_cleanup只能配合-slr_crossing_opt。新route NOT RUN，优化未开始，输入R47 DCP SHA不变、源码冻结未改变。初版postopt字段因匹配到Tcl源码回显的puts文本而误写COMPLETE，修正审计明确FAIL_BEFORE_OPTIMIZATION；原始manifest不覆盖，日志和修正说明保留。修复前置校验因此失败，一次未改命令重试重复相同错误，两套日志均归档experiments/r48_option_setup_failure_20261111。现在以精确整行标记判断阶段，采用已验证post-route placement/routing/rewire/critical-cell四项在新目录重跑；不增加无关SLR/clock/时序例外。critical_pin_opt也省略，不声称发生引脚交换。


## R48 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `b0824e307ae5b0f1ce64a64f5aaef5820f9075ab`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r48-routed-pin-refine`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R46_VIA_R47_EXACT_INPUTS_NOT_RERUN：完整原生功能来自R46、R47同83个硬件测试SHA和18个CEB2 LUT函数/94DSP参数审计，本轮原始硬件测试再同R47（84个），功能与综合均未重跑。以R47 routed DCP作兼容post-route placement/routing/rewire/critical-cell四项，再实际route_design tns_cleanup；设计已fully routed时Vivado明确忽略Explore等其他route选项，仅执行TNS cleanup，不宣称新全局从零布线。postopt与final实际时序分别保存，94DSP寄存器与输入不变，新增串行边沿0。初版phys -tns_cleanup不兼容、以及回显puts误判阶段及未修改重试的全部原日志/manifest与修正审计保留；实际两次都在优化入口退出，新route NOT RUN，输入DCP未变。现以精确独立输出行判阶段；critical_pin_opt与phys tns_cleanup本兼容配方未执行，不冒称有引脚交换。不是fullRoot postroute/SDF等价或物理CDC签核。；没有修改Migen evaluator。
- 功能/综合明确REUSED_R46_VIA_R47_NOT_RERUN；本轮新post-route物理及实际TNS route与STA/CDC/DRC审计；CSR map与XDC保持R4a一致。延迟=只兼容post-route布局/布线/重连/关键单元优化，未做pin/clock/retime/DSP或BRAM寄存器优化；新增ADC/反馈/CSR采样周期0，原始输入同R47，指定R28数字模型只继承。
- 综合来源=REUSED_R46_VIA_R47_EXACT_DCP_NOT_RERUN，WNS/TNS=-1.376/-180.925ns。实际route COMPLETE，WNS/TNS=-0.179/-4.904ns，失败端点70；WHS/WPWS=0.015/1.5ns，THS=0。
- raw IIR内部最差=-0.162ns，入口=0.259ns；全局最差 `linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`，逻辑/布线=['5.972', '1.597']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11693, 'ff': 13504, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增382/移除374；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r48_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R52 / 2026-11-11归档 / iir时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `7eb4ed96c9155075b14d88b9e0de2e8d9fcdf61d`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r52-c48-carry-fold`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；本轮仅split_c48_mac有限符号修正knownU=Z+pos-neg改为majority(Z,L,!C)，correction原4位/完整50位乘加/截断/输出FF/所有寄存器保持，registered MAC helper不改；修改前8种符号/4种ztop及100320完整整数数学PASS。不声称独立符号谓词对任意X等价，新原生完整50位MAC对独立冻结R48 helper的320边界整数+4606部分X/Z严格case equality PASS；原样71760全50位MAC oracle、原config0完整滤波器、新config2/order1/2/5真实CSR/独立冻结R48 IIR及旧helper/整数oracle/每阶3000XZ PASS。完整旧回归、综合和真实route重新执行，新物理结果不沿用R48 DCP。首次冻结参考模块私有加载路径错误中止在比较前，旧源码/命令/诊断保留，先显式加载冻结helper后在新目录PASS，没有改生产算法或弱化旧断言。回到R48原输出FF结构，不携入R50/R51，新增反馈/CSR/采样周期0。；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合来源=COMPLETE_THIS_ROUND，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=-0.222/-6.177ns，失败端点73；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.203ns，入口=0.299ns；全局最差 `linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`，逻辑/布线=['3.180', '4.579']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r52_iir_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R52 实际映射与比较范围补充

本轮默认route-.222/-6.177ns、73端点，较直接RTL对照R46默认route-.539/-18.344ns、131端点改善；还未超过单独物理优化R48-.179/-4.904ns、70端点。保留为后续物理优化输入，不视作已胜出/正式合并。
raw IIR内部最差+.203ns，DSP+LUT6共2级（原DSP+2LUT共3级）；logic5.848+route1.345ns。FastB仍48负端点、最差-.100ns；全局IIR输出FF→并行tap限幅→混合器输入FF-.222ns，3.180logic+4.579route。慢PID输入各类已报告，跨模块输出仍需全局STA，不用模块局部正裕量替代。
实际94DSP与R48按单元名比较有2个PREG差异：DSP48E1_47 0→1，slow_chain_pid_pipelinedpid_ki_mult1 1→0。原全部同步源码、IIR/registeredMAC/Chains/Root均原始SHA相同，目标新增采样周期0，指定原生全功能/逐拍测试PASS；DSP PREG变化本身既不能证明新增一拍也不能证明postmap周期等价。实际参数差异原样列于generated audit，未做fullRoot postroute/SDF/形式周期等价或板测，不能冒称全部94属性不变。后续R53物理候选须对真实输入R52独立核对94DSP，而非与R48混比。
最终STA仍FAIL，DNA/I/O/CDC/DRC未签核，无bitstream/板端/激光操作。


## R53 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `e25e8f0c6af4f694533e3d25f5626ae9e3ec7b18`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r53-carry-fold-postroute`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R52_EXACT_INPUTS_NOT_RERUN：89个原始硬件测试SHA一致，R52完整14/25/28/完整50位MAC/原cfg0与新cfg2/order1/2/5/4606部分XZ与各阶3000XZ/真实CSR/Scope/AXI/CDC功能及综合明确继承，本轮未重跑。只在R52真实routed DCP上执行兼容postroute placement/routing/rewire/critical-cell和真实TNS route cleanup；fully routed时Explore等其他选项被忽略应按工具日志记录，不称新从零全局布线。原DSP参数对R52全部94项核验同，源码/CSR/XDC/DCP SHA不变，新增串行采样周期0；未做clock_opt/retime/DSP或BRAM寄存器优化/新pblock/时序例外。R52相对R48的两项PREG差异按原证据继承，不混称全部历史参数都没变化。不是fullRoot postroute/SDF/形式或物理CDC证明。；没有修改Migen evaluator。
- 完整功能与综合REUSED_R52_NOT_RERUN；本轮新物理优化/真实route/STA/CDC/DRC/94DSP及冻结输入审计；CSR map与XDC保持R4a一致。延迟=本轮post-route标准物理优化，新增ADC/反馈/CSR采样周期0；89原始硬件测试SHA同R52，功能和综合NOT RERUN；原指定组件数字延迟仅继承，非板端或本轮重测。
- 综合来源=REUSED_R52_EXACT_DCP_NOT_RERUN，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=-0.014/-0.052ns，失败端点6；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.203ns，入口=0.299ns；全局最差 `linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic17_reg[16]/D`，逻辑/布线=['4.135', '3.846']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r53_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R56部分unroute兼容中止

ae4f9a8默认只拆4条选中Q网后，工具仍以post-route执行，force_replication_on_nets在入口被Vivado_Tcl4-265拒绝；实际复制和新route均NOT RUN。原真实routed选择/源码/日志/manifest和纠正说明保存experiments/r56_partial_unroute_setup_failure_20261111。按既有CLI --unroute-all在全新目录改运行模式；先从原routed报告选4个来源，再全拆线，避免选择未布线估计负slack。该兼容模式不保留原全部走线，-preserve仅对执行时已完成的走线有效；原R53 DCP/源码保持。


## R56复制完成后的路由选项兼容修正

d8c429b全unroute后force复制成功，4→21 FDRE、max Q负载28→13，D/C/CE/R/INIT/属性和完整负载集合初检PASS；replicated.dcp已保存。随后Explore+preserve被本机执行器Common17-69拒绝，虽然同机help文字称兼容；实际新route NOT RUN，全部源码/日志/表格和帮助对照保存experiments/r56_route_option_setup_failure_20261111。去掉preserve（全unroute本就无原完整路线可保留），默认全unroute的fresh-run驱动已修正；本次另用恢复工具从该已验证replicated.dcp继续，复制不重跑，新目录保存完整route/STA。输入原R53与复制DCP SHA分别冻结，不把本次入口失败当时序失败或成功。


## R56 / 2026-11-11归档 / physical时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `7e177b13a3d605cbea9fc7acb366c7670cfe0837`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r56-critical-ff-distribution`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R52_VIA_R53_EXACT_INPUTS_NOT_RERUN：90原始硬件测试SHA同R53，完整源功能和综合继承R52，本轮未重跑。先依据真实routed负路径选择普通FDRE/ADC clk_2/非ASYNC非保护/Q>=4并按签名去重，实际4来源；只force驱动复制，4→21 FDRE、+17平行副本，D/C/CE/R/INIT/ASYNC/DONT及完整聚合负载集合从原始/复制后/恢复后/最终完全同，无重复丢失，最大Q负载28→13，资源FF增量17精确匹配；94DSP属性对R53同、source/top/CSR/XDC和原DCP/复制DCP SHA均保持。FDRE逐拍归纳证明同状态输入副本输出相同，不新增ADC/反馈/CSR串行周期。首次部分unroute仍被判postroute、force入口拒绝NOT RUN；兼容全unroute后复制成功但Explore+preserve实际CLI拒绝(本机帮助称兼容)，入口失败/旧源/日志保留。修正fresh-run工具默认全unroute/不preserve，并直接从已验证复制DCP新目录恢复，只重做实际route，复制未重复。不是原走线被保留，也不是本轮重新综合/native或fullRoot postroute/SDF/形式/物理CDC证明。；没有修改Migen evaluator。
- 源功能/综合REUSED_R52经R53_NOT_RERUN；V2新复制及已知数字状态/连接审计PASS，V3新真实完整route/STA/CDC/DRC，三种工具入口/阶段结果分别保存；CSR map与XDC保持R4a一致。延迟=新增17个平行FDRE，不增加任何ADC/反馈/CSR采样边沿；本轮串行周期0。原指定组件数字延迟仅继承，未作全Root/板端延迟或模拟环路带宽测量。
- 综合来源=REUSED_R52_VIA_R53_EXACT_DCP_NOT_RERUN，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=-0.205/-0.942ns，失败端点16；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.332ns，入口=0.678ns；全局最差 `linienmodule_fast_a_common_reg[3]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[15]/D`，逻辑/布线=['3.156', '4.750']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 11782, 'ff': 13529, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r56_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R57 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `6a7705d36288e39888c85ec83b974b2db7279500`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r57-critical-ff-postroute`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R52_VIA_R56_EXACT_INPUTS_NOT_RERUN：92原始硬件测试/工具SHA同R56，完整原生功能及综合继承R52，本轮未重跑。从R56已验证4→21同拍FDRE拓扑继续兼容postroute四项及实际TNS cleanup；fully-routed时Explore被忽略，不称从零全局route。工具实际新增3个平行FDRE及1个LUT。全部既有FDRE状态输入与INIT在验证副本Q别名后同，3个新增FF分别精确匹配原commonA3/commonB0/系数B2的D/C/CE/R/INIT；其余既有LUT在副本别名后同。原4家族21FF签名保持，但原始聚合负载并不相同：B相位11网多一直接重连LUT输入，差异原样记录。原i20+i9到新i20_replica_rewire+i9_rewire完整同输出组合切面8个独立输入/256组穷举Boolean PASS，解释该负载变化。94DSP属性同R56、源/top/CSR/XDC与DCP/CSV SHA保持，串行新增周期0。不是任意XZ组合函数或全Root postmap/SDF/形式等价，也非物理CDC证明。；没有修改Migen evaluator。
- 源功能/综合REUSED_R52经R56_NOT_RERUN；本轮新增FDRE逐拍归纳、局部LUT穷举/连接/94DSP审计PASS，实际postroute/route/STA/CDC/DRC新执行；setup仍FAIL；CSR map与XDC保持R4a一致。延迟=本轮只同拍平行寄存器复制及组合LUT重连，新增ADC/反馈/CSR采样周期0；快速路径相对R2b累计32ns保持。指定组件数字延迟仅继承，非本轮全Root/SDF或板端重测。
- 综合来源=REUSED_R52_VIA_R56_EXACT_DCP_NOT_RERUN，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=-0.006/-0.016ns，失败端点5；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.332ns，入口=0.678ns；全局最差 `linienmodule_fast_b_zi0__9/C` → `linienmodule_fast_b_cordic17_reg[16]/D`，逻辑/布线=['3.982', '3.991']ns。
- 决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11783, 'ff': 13532, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r57_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R59 / 2026-11-11归档 / physical时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `4d74ae3610463f3e780f560490870b9aef3960f3`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r59-phase-output-distribution`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R52_VIA_R57_EXACT_INPUTS_NOT_RERUN：93原始硬件测试工具SHA同R57，完整原生功能及综合继承R52_NOT_RERUN。只从原始真实routed负路径选择phase9/17负载和IIRy15/3负载，后全unroute以兼容force入口；2→6普通FDRE，新增4同拍副本，相位网最大负载17→9，IIR输出分1/2负载。D/C/CE/R/INIT/属性及完整聚合负载集合在复制前/后/final同，无重复丢失；所有已解析模块实例参数/连接在精确副本Q别名后与原R57同，94DSP属性同，FF资源增量恰4/LUT不变，source/top/CSR/XDC和输入DCP SHA保持。已知数字控制下相同状态归纳不增加串行采样边沿。实际完整Explore+TNS新route，不保留原全部走线，不是SDF/fullRoot形式/物理CDC证明。；没有修改Migen evaluator。
- 源功能/综合REUSED_R52经R57_NOT_RERUN；本轮新状态副本/全部已解析实例/负载/94DSP审计PASS，实际完整route与STA/CDC/DRC另行判定；CSR map与XDC保持R4a一致。延迟=新增4个同拍平行FDRE，ADC/反馈/CSR新增串行周期0；相对R2b快速累计32ns保持。指定组件数字延迟仅继承，未重做全Root/SDF或板端测量。
- 综合来源=REUSED_R52_VIA_R57_EXACT_DCP_NOT_RERUN，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=-0.204/-5.183ns，失败端点59；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.343ns，入口=0.883ns；全局最差 `linienmodule_fast_a_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_a_cordic17_reg[16]/D`，逻辑/布线=['4.168', '4.016']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 11783, 'ff': 13536, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r59_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R60 / 2026-11-11归档 / physical时序候选试验

- **CANDIDATE / 未最终签核，不部署**。代码提交 `f544059e13ad6a2447903271bc099ad76b6f2f7e`，独立工作树 `D:\RP_Dev\linien_trials\20261111-r60-phase-output-postroute`；R4a/R2b/原用户工程保持原样。
- 功能：REUSED_R52_VIA_R59_EXACT_INPUTS_NOT_RERUN：94原始硬件测试工具SHA同R59，完整原生功能及综合继承R52，本轮未重跑。输入R59新2→6同拍FF拓扑做标准postroute placement/routing/rewire/critical-cell，再实际route TNS cleanup；日志35-558确认fullyrouted时Explore等其他选项忽略。完整状态图及所有已解析实例参数/端口在验证同状态Q别名和有序位展开后核对，任何变化的LUT切面另穷举已知Boolean；具体新增FF/LUT数量与局部证明见audit，不默许原始聚合负载相同。94DSP同真实R59，源/top/CSR/XDC及输入DCP/CSV SHA保持；新增串行采样周期0。最终受约束setup PASS（+.003ns/0/0端点），hold PASS（.014/0）、pulse PASS（1.5/0），最终STA仍FAIL：DNA无时钟1/内部未约束2/输入44/输出46缺延迟，以及物理CDC/DRC未关闭。不是全Root postmap/SDF/形式或板端等价/锁频性能证明。；没有修改Migen evaluator。
- 源功能/综合REUSED_R52经R59_NOT_RERUN；本轮新映射状态/逻辑/94DSP审计PASS、实际物理优化/route COMPLETE、受约束setup与hold/pulse PASS、最终STA FAIL；CDC直接对R59/R57按实际路径差集核验而非只数数量；CSR map与XDC保持R4a一致。延迟=本轮仅标准postroute同拍复制/组合物理优化，新增ADC/反馈/CSR采样周期0；快速相对R2b累计32ns保持。组件模型数字延迟只继承，非本轮全Root/SDF/板测。
- 综合来源=REUSED_R52_VIA_R59_EXACT_DCP_NOT_RERUN，WNS/TNS=-0.773/-60.316ns。实际route COMPLETE，WNS/TNS=0.003/0.0ns，失败端点0；WHS/WPWS=0.014/1.5ns，THS=0。
- raw IIR内部最差=0.343ns，入口=0.883ns；全局最差 `linienmodule_fast_b_iir0_y2_reg[11]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[19]/D`，逻辑/布线=['3.081', '4.513']ns。
- 受约束setup=PASS，hold=PASS，pulse_width=PASS。决策=CANDIDATE_NOT_SIGNED_OFF；最终STA FAIL，不能上板验收。资源={'lut': 11783, 'ff': 13540, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=405。
- CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，严格名称差集新增379/移除360；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r60_physical_20261111/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。


## R60 最终审计及下一阶段 / 2026-11-11

受约束setup PASS：final WNS=+.003ns/TNS=0/0端点，hold .014/0、pulse1.5/0 PASS；完整源功能和综合明确REUSED_R52经R59_NOT_RERUN，综合本身仍-.773/-60.316ns，不混称综合时序通过。实际新增3 FDRE+1 FDSE平行副本（乘数bit0原INIT1/S保持），无新增/删除LUT；30,623→30,627已解析实例在同状态Q别名和真实声明的有序位展开后原实例参数/端口等价，94DSP与R59相同。94输入SHA、DCP/CSV冻结，新增串行周期0，快速相对R2b+32ns保持。原用户/R2b/R4a/R16保护核验PASS。

当前最差转至B IIR y2[11]→tap限幅y19/D，+.003ns，logic3.081+route4.513ns，10级/5CARRY4；raw内部+.343ns；快速PID /D+.814，慢PID /D+1.224、/R+.558、/CE+1.790ns。3ps仅该实现正裕量，不是充足余量或板端安全证明。

CDC对R57/R59严格路径差集0/0且计数同，但物理安全NOT_PROVEN。最终STA仍FAIL：DNA无时钟1/DIN-READ未约束2；ADC/扩展输入44、DAC/扩展/PWM/LED输出46未建外部延迟；FCLK↔ADC NoCommonClock/Timedunsafe。默认DRC405=333 Warning+72 Advisory；p_1_out PREG0的OPMODE={0,s,s,0,1,0,1}稳定二进制仅0x05/0x35、Z=0/C，已依本机原语模型解释不选P反馈的可达性，但动态/未知/物理毛刺未证明，原DPREG-4告警不删除、不声称签核关闭。

本阶段暂以R60冻结候选；下一阶段先补DNA/CDC/I/O/DRC的真实证据和时序模型，再实际route/STA复核，不能靠例外或假延迟消警，也不盲加反馈流水线。完整变化、测试边界、输入输出SHA、物理阶段重放命令见docs/R60_SIGNOFF_GAPS_20261111.md及experiments/r60_signoff_readonly_20261111；无fullRoot/SDF/板测，无bitstream/部署/激光操作。

## R61b / 2026-11-11 / 复位与 DNA 候选，尚未完成物理实现

状态：CANDIDATE / NOT SIGNED OFF。冻结 R60 保持不变。代码 4516124 的四处局部
硬件变更为 DNA READ 控制 FF、标准 CRG 异步断言/两拍释放、CDC 桥复位 epoch
与恢复错误响应、AXI 对 sys_err_i 的响应锁存；具体数学依据和复位行为差异见 R61B_PLAN。
正常反馈新增串行周期为0；快速通路相对R2b累计+32ns继承，非本轮全链路实测。
复位恢复时间改变必须单列，不能称所有旧复位瞬态逐拍相同。

已执行定向 DNA 完整64位/四组原生值/复位对照 PASS；五组频率相位的 CDC 正常事务、
独立复位、不重放、停钟期间错误响应及恢复 PASS；AXI 读写 SLVERR/背压修复定向 PASS，
同一错误用例对冻结 R60 失败的证据保留。上述不证明物理跨域或板端可用。

首次完整回归 `20261111_223325_r61b_protocol_full` 在 Scope 严格立即复位比较 FAIL，
综合/route NOT RUN。经定位，新旧恢复契约不同；只加三SYS周期恢复等待、不改变任何
比较断言的 phase0 诊断 PASS（28781 ADC周期、2036事务、210已知存储读取）。原严格
FAIL 及原始源码/SHA/日志已归档，不静默改判。新增测试适配入口保留原三个Scope
测试与所有断言，独立检查恢复ready；全部相位及重新完整回归尚待结果。

R61a 真实 DNA 时钟消除无时钟1/内部未约束2后，hold 曾为READ-.320/DIN-.188ns；
物理hold修补/局部重布令hold通过，但READ setup分别-.315/-.372ns，均不能采用。
R61b新控制FF只有定向等价证据，实际新综合/route WNS/TNS/CDC/DRC均待验证，不能
借用R60+.003ns。ADC/DAC数据手册零PCB偏斜必要预算诊断分别出现ADC hold-2.788ns、
DAC setup-2.571ns；该模型不是实物PCB签核，完整I/O/物理CDC/DRC仍未关闭。
尚无签核bitstream，无烧录、板上反馈或激光/PZT操作。

### R61b 恢复契约 Scope 定向回归结果

新的明确恢复契约入口已实际执行：factor-cache/predecode各4组相位、average完整
父模块合计9组 PASS，225588 ADC周期/15404事务；两组scalar各161872已知向量与
3000 X/Z PASS。每拍状态/响应/数值断言保持启用，factor-cache/predecode还检查实际
ready=11。原三个测试脚本及四个硬件文件RAW SHA与4516124完整失败试验相同；
仅新adapter在共同复位释放后增加3 SYS negedge的stimulus等待，未删除断言。
原严格立即复位测试仍FAIL。证据归档experiments/r61b_scope_recovery_contract_20261111。
R60冻结基线410个文件RAW SHA/HEAD/干净状态再核验PASS。重新完整功能/综合/route
仍必须单独执行，本次定向PASS不替代它们。

## R61b 完整新构建实际结果 / 2026-11-12归档

输入4aba6ce630de6feee5cd01dea79051f76f605cf2，trial 20261111_225502_r61b_recovery_contract_full。
完整功能PASS（明确采用新复位契约入口，旧立即请求严格比较FAIL另存），CSR协议语义比较PASS；
从源码新综合COMPLETE、布局布线COMPLETE，输入变动=[]。综合WNS/TNS=-.773/-60.316ns；
routed=-.232/-2.317ns、25失败端点，WHS=.010/THS0、WPWS1.5/TPWS0。内部no_clock=0、
unconstrained_internal=0。最差phase/CORDIC路径fast_a_zi0__8/C→fast_b_cordic17[16]/D，
10级/6CARRY4+4LUT、logic3.282+route4.885ns。raw内部+.375ns。完整原件、只读审计、
输入/输出SHA及DCP归档experiments/r61b_fresh_full_20261112，R61b工作树/代码冻结不变。
此轮最终STA仍FAIL，尚无签核bitstream；外部接口与物理CDC/DRC不能沿用R60的正裕量。

## R62 / 2026-11-12 / ADC捕获边沿与DAC驱动独立候选

仅analog.py ADC输入FF改FDRE IS_C_INVERTED=1、IOB TRUE；hw_platform.py DAC data改FAST8，
其余引脚/PLL/PS7/CSR/控制算法保持。ADC边沿移动4ns，不新增整拍串行FF；按CLKOUT rising n
后的word[n]在following fall捕获、next rising消费，不能声称原未签核采样编号全瞬态等价。
真实半周期4ns到下游路径必须STA。DAC驱动效益及板端SI待验证，不能先写PASS。
实际Migen+厂商FDRE/ODDR原生测试PASS：两路完整14位、低2位变化、0.6ns位间到达展开、
复位及下一sys样本消费、原DAC编码/时隙。全功能回归和新综合/route尚待执行。新增硅器件
必要I/O预算在综合后checkpoint前生效：ADC0..0.6ns、DACsetup2/hold1.5ns，明确零PCB偏斜
诊断假设，非真实PCB签核。IQSEL/复位/CLK-WRT先后及3.5ns脉宽另核查，不隐去。
来源/数学依据/采样行为/风险见R62_PLAN.md。候选不部署，原工程/R2b/R4a/R60/R61b不覆盖。

### R62 实际完成与失败判定

输入cb81bdd56e88872c729e37369785d25b08226277。功能trial 20261112_025604_r62_functional
完整PASS；实现trial 20261112_025605_r62_intrinsic_io_implementation的输入SHA逐文件完全同，
两者source_changes=[]。新综合WNS/TNS=-1.171/-105.689ns，route COMPLETE但STA FAIL：
WNS/TNS=-1.261/-2245.782ns、3604端点，WHS/THS=-.696/-23.517ns、42端点，pulse1.5/0。
最差FDRE_3/C（falling）→fast_a_cordic17[16]/D，4ns预算，logic2.617+route2.592=5.209ns，
7级/6CARRY4+1LUT。28个ADC FF实际都进入ILOGIC，证据见extended/adc_registers.tsv。
新约束下DAC setup-.835/hold-.456ns；相较之前零PCB诊断setup改善但两项仍FAIL，不能
以改善掩盖失效。IOB捕获的实际时钟插入延迟必须与ADC字编号一起分析；默认边沿关系
并不自动表达同一CLKOUT边沿之后数据word[n]的捕获，不通过随意放宽周期处理。
新增4相位真实AXI+bridge异常集成：复位保持错误、在途读/写取消超时SLVERR、背压稳定、
不重放和恢复正常事务均PASS；物理CDC仍非仅凭仿真证明。
bitstream_checks规则集406项（334 Warning+72 Advisory，无Error/Critical），仍需逐项
风险处置，默认FPGA pulse1.5不等于AD9767外部3.5ns脉宽已签核。全部真实源码、fresh
综合/route/原生/集成/只读审计/DCP/输入输出SHA归档experiments/r62_failed_physical_20261112。
决策REJECTED_NOT_MERGED；不生成可部署声明、不烧录，后续候选在新工作树实施。

## R63 候选输入与验证范围

独立工作树20261112-r63-adc-same-word，以冻结d0f7823为父。不改R62/R61b/R60。
analog仅恢复原rising逻辑并IOB TRUE，新增整数sys反馈级0；保留DAC FAST8待后续优化。
对确切28个ADC pad→rising IOB/D设置set_multicycle_path 0 -setup，收紧setup8ns，
用同一源边沿后word[n]、实际PLL/clock插入延迟捕获；hold检查下一word[n+1]。
不是放宽周期或切路径，必须核对setup Requirement0和hold Requirement-8以及全部PVT。
完整数学/硬件依据和限定结构见R63_ADC_CAPTURE_PROTOCOL.md。四组原生延迟包络及原R61b
analog的49位全部settled输出严格比较PASS；两路完整14位/位间skew/复位/下一拍样本号
PASS，0插入延迟负控制按预期捕获ADC_WORD_INDEX_FAIL。两处testbench模型错误源码/旧FAIL
日志另存，未删断言，最终native03证据归档experiments/r63_analog_native_20261112。
本轮选择先新综合/route验证ADC约束/实现是否有效；完整组件功能参考R62同源回归，
不写成本轮又重跑完整功能。最终合并/发布前仍须对最终冻结输入跑完整流程。

### R63 实际实现与约束边沿核验

输入7ef3cf5dc3a216c32b706dd462d976a453501f3d，新综合/route COMPLETE，构建期间SHA变化=[]。
全部28个输入→28个IOB/D实际setup Requirement0ns、hold Requirement-8ns逐条验证；
setup最差+.429ns，hold最差+3.304ns，物理FF为rising ILOGIC IFF。该结果是零PCB偏斜
硅器件必要预算PASS，不能冒称实物板级签核；采样逻辑与冻结R61b原生严格对照PASS，新增
反馈整数周期0。DAC仍setup-.835/hold-.456ns；整机route WNS/TNS=-.835/-14.041、32端点，
WHS/THS=-.456/-5.876、14端点，内部clk_2 WNS=-.389/18端点，pulse1.5/0。
无时钟0/内部未约束0；完整功能本轮NOT_RERUN，R63新analog原生PASS，其他共同硬件/
工具/测试原始SHA同R62完整PASS输入（例外清单及逐文件核验见functional_scope.json）。
原manifest功能NOT RUN保持原样，不改写成重跑PASS。完整真实DCP/报告/参数/输入输出SHA
见experiments/r63_adc_solution_candidate_20261112。保留ADC组件候选供下一轮，不合并正式
版本、不签发bitstream、不操作板卡或激光。

## R64 共享DAC时钟的独立候选

冻结R63 43438021，在20261112-r64-dac-shared-clock工作树只改analog DAC输出前端。
保留125MHz daca/dacb原数据FF/编码/复位；data ODDR用sys_double250 SAME_EDGE且D1=D2，
F/S/B三个控制FF从sys翻转建立每4ns原A/B时隙，不增数据串行级。严格数学时隙依据/
启动建立与2ns物理控制风险见R64_DAC_SHARED_CLOCK.md。PLL/相位/引脚/DRIVE8/FAST/CSR
和所有算法保持。新check_r64_analog.py按四组包络与冻结R61b完整analog49位稳定输出
从2ns起逐边沿比较，含GSR启动/复位/原A旧字B新字时隙、双路完整14位/下一拍样本，
全部PASS；负向控制按预期失败。源码/fixture/完整命令/日志/SHA归档
experiments/r64_shared_dac_native_20261112。新完整功能与新综合/route待运行；不能用
原生对照冒称物理时序通过，DAC脉宽/SEL/真实PCB/物理CDC/DRC仍待签核。

### R64 实际失败与后继方向

输入a4b349dc8be3ae909a9490119c9451e7acc124d9，两独立trial的全部输入SHA同，source_changes=[]。
本轮新完整功能PASS（含启动的新analog/全部旧组件/CSR/AXI/CDC），新综合/route完成。
route WNS/TNS=-.748/-44.222ns、254端点，hold-1.901/-26.110ns、14端点，pulse1.5/0。
最差FDRE_33_replica_1/C→ODDR_16/D1：2ns预算，logic.721+route1.049ns；ODDR输入
setup要求使其仍差.748ns。frame→control另-.331ns。DAC外部setup-.343ns，相对R63
-.835改善，但仍FAIL；hold报告为ODDR falling C→DAC，与真实D1=D2 SAME_EDGE不翻转
波形存在结构性悲观，不能以此自行删路径，应改用真实SDR输出FF表达等价逻辑。
ADC全部28条仍+.429/+3.304ns，0/-8ns关系核验保持；DNA setup+.538/hold+.199ns。
实际50个ASYNC FF形成25个同SLICE双级对，首级Q仅驱动对应次级D；不是仅统计CDC数量，
仍须审查级间时序/保持窗口/复位/故障响应，不能单靠结构就签核。
一项内存IO参数诊断被非法LVCMOS33 DRIVE24拒绝（合法4/8/12/16），原DCP SHA未变、
无源码/硬件修改，部分结果未选用，原失败完整另存。完整原件含fresh功能/综合/route、
94DSP/路径只读审计、源/DCP/输入输出SHA在experiments/r64_rejected_oddr_20261112。
REJECTED_NOT_MERGED，无烧录/激光/PZT操作；下一独立候选优先消除冗余DDR状态，不加数据级。

## R65 原语简化候选

独立20261112-r65-dac-sdr-iob工作树，父9d773b1保持。analog只将14个DAC data ODDR
SAME_EDGE/D1=D2换为250MHz rising FDRE/IOB TRUE；初始值/CE/R及原数据FF/3控制FF
保持，PLL/引脚/电气/CSR/数值算法/吞吐率不变，额外数据采样级0。已按实际厂商原语
完整对照冻结R61b analog：2ns后每个快速时钟稳定边沿49位输出、启动/GSR/复位、
四组声明包络/全部14位/样本号/负控制全部PASS；新结构46个positiveFDRE/2个negative
控制FDRE/0个SAME_EDGE data ODDR在生成RTL匹配。原件在r65_sdr_dac_native_20261112。
同边沿相同D1/D2到SDR的逐时隙等价、范围和风险见R65_DAC_SDR_IOB.md。此轮先新
综合/route，未重跑完整组件功能，明确参考R64同源完整回归；最终签发前必须完整重跑。
外部DAC WRT setup/hold仅必要模型，图64的CLK/WRT/SEL与脉宽、真实PCB/SI及CDC/DRC仍待核验。

## 2026-11-12 R65 实际结果：REJECTED_NOT_MERGED

输入代码82699d8960817ab2d08517eb8705aed0835c667f；新综合/实际route均COMPLETE，CSR映射PASS。原生analog新旧同波形/启动/复位/四包络/完整14位/样本负例PASS，本轮完整功能NOT RERUN，未改组件参考R64同源fresh全功能PASS，不能当成本轮全功能重跑。

实际route WNS/TNS=-.683/-55.023ns，312 setup端点；WHS/THS=+.024/0、0 hold端点，WPWS=+1.500ns。SDR表达消除了R64负hold；最差FDRE_33/C负边沿到FDRE_40/D正边沿，2ns路径仍FAIL。DAC必要零PCB预算setup/hold=-.343/+.070ns；ADC全28端点+.429/+3.304ns、0/-8ns边沿关系逐条PASS。内部clk_2 WNS=-.345ns。no_clock=0、内部未约束=0，16输入/32输出尚须接口分类/真实约束。物理CDC25对50FF同SLICE且一级Q只到二级D，仍不足以宣布跨域整体安全；PS原始异步reset释放已被独立实际CRG仿真确认为待修复项。

源码、完整阶段日志、DCP、物理诊断及SHA归档experiments/r65_rejected_control_20261112，DCP SHA256=5e7c3b93c8a3e02d91b25586981e483a11e70d17319175f3d22cfba97d335aee。失败候选不合并/不部署。R65相对R64新增数据串行级0，继承相对R2b主反馈+32ns；最终STA/板级I/O/CDC/DRC仍未签核，没有生成发布bit/bin。

## 2026-11-12 R69实际：32故障PASS，严格旧空闲总线差分FAIL，STA FAIL

输入afdfa18334a9cb34ccd6419f8c5e02286e903296；新32故障/取消/重放/非法payload及实际Root连线PASS。完整回归在Scope factor-cache parent phase0的79926ns FAIL：复位0/0、ACK0/0、ERR0/0，旧RDATA0/新RDATA1。保留return payload导致无有效响应周期数据变化，符合新计划的fault隔离，但旧严格“包括无ACK周期数据相等”检查不成立，不能写全功能PASS。后续未执行项NOT RUN。原manifest functional仍初始NOT RUN，其failure和原生日志明确实际FAIL，原件不回写；下一runner需将运行/失败状态准确记录。

新综合COMPLETE：WNS/TNS=-.773/-80.399ns（312端点）；actual route COMPLETE：WNS/TNS=-.411/-30.808ns（242端点），WHS/THS=+.027/0（0端点），WPWS+1.500ns。最差fast_a_zi0__10/C→fast_b_cordic17[16]/D，8.395ns（logic4.140/route4.255，14级9CARRY4+5LUT）；DAC必要预算-.343/+.070，ADC28+.429/+3.304及0/-8ns逐条PASS，DNA+.009/+.216ns。LUT11803/FF13386/DSP94/BRAM35/BUFG6；noClock0/内部未约束0、noInput16/noOutput32。52ASYNC FF/26pair同SLICE一级Q只驱动二级D，CDC总体NOT PROVEN（报告当前451 CDC1，不能拿数量判断已签核）。

全部原始strict失败源/日志、生成文件、新物理DCP/SHA、实际总线值诊断及clock geometry在experiments/r69_strict_failure_and_physical_20261112。DCP SHA256=63e1f2a98a3d335dff9880408e35ac0cbf36573d6859663e6bdb6dbd14c2be40。R66只读FAST合法16电气组合、逐14位224行扫描无同时setup/hold可行解，含整体相移假设也未找到交集，仅诊断未选入源码。

下一R69b仅明确测试契约，硬件源码逐RAW保持本输入：ACK始终严格比较，payload/ERR仅在任一ACK非确知0时四态比较，保留所有数值/状态/内存/CSR/cohort断言和原始strict FAIL。必须独立跑过才能写更新契约PASS，不能将旧FAIL删掉；不预判是否存在有效响应或Scope数值问题。最终未签核、不部署，正常反馈新增级0（继承+32ns相对R2b）。

## R72 actual物理候选 / 2026-11-12

输入662ab1be674f1c638c2e21252e6cad62f203a534。综合REUSED_R69，不是新综合；route COMPLETE，WNS/TNS=-0.343/-4.308ns，17 setup端点，WHS/THS=0.027/0.0ns，WPWS=1.5ns。最终STA FAIL。功能引用同RAW硬件R69b完整有效响应契约PASS（4c4f965），原无ACK数据严格差分FAIL保留。

逻辑比较：Original run exit0 and within-trial / input canonical logical equality PASS.

全部原始manifest/exit/实际报告/DCP、独立证明、只读审计在experiments/r72_actual_physical_20261112，DCP SHA256=3c8b72a77450f5fbaf21f759982405472637883baa23261b4721ed8f6e4a3696。只忽略物理注释做文本逻辑比较，未移除实际DCP属性，hold始终检查。ADC28端点+.429/+3.304ns、同字0/-8关系；52ASYNC/26同SLICE双级结构不等于整体CDC安全。外部DAC必要setup仍-.343ns，CLK/WRT/SEL/3.5ns外部脉宽/真实PCB及16输入32输出接口约束未签核。正常反馈新增周期0，继承相对R2b+32ns；无签核bitstream或烧录。

## R75候选输入及定向PASS / 2026-11-12

从R72最终5124a1c另建opt/r75-iir-final-operand-swap-20261112，只交换fast A/B最终a1 MAC两个完整乘数的拆分方向，原输出饱和/反馈寄存器/CSR/PLL/ADC/DAC/PS7/AXI/CDC不动，新增反馈周期0。依据docs/R75_FINAL_MULTIPLIER_OPERAND_SWAP.md。14/25位一/二/五阶107706拍对照冻结R72及独立整数模型PASS，FastChain32000拍PASS，31976已知/21317写/24000 CE保持；完整原件和SHA在experiments/r75_native_equivalence_20261112。新生成/新综合/actual route待执行，fresh全功能未重跑，不能预判收益。

R73最新完整功能PASS和生成失败归档2b0fc162b26fb07829ccc02e2c4c9311a30e700a；R73b完整功能PASS但物理失败归档b3da30114366b1fe608a98d449c08518aafb60d4；R74定向PASS但route -0.827/-635.956ns、1829端点失败归档2a0a04836b8799b0626e4a4599b222b45c272b85，fresh全功能NOT RUN。均保持独立，没有合并进本R75硬件选择。当前较好参考仍R72 -0.343/-4.308ns、17端点，最终STA FAIL。

完整DAC/PCB/物理CDC/DRC及16输入32输出接口约束仍待签核，无可部署bitstream、无烧录/激光/PZT操作。

## R76物理候选输入 / 2026-11-12

源为R75 769a86b0a91b4c8a1dd1a4c73cc4abed98dbd954实际routed DCP，SHA256=0d568f7c3e1d0476b81dd7a30a3471563898d697cc822ca97032777911820b1f。
硬件源码逐RAW同R75，无RTL改动。综合明确REUSED_R75，功能引用R75新107706拍IIR及32000拍FastChain定向PASS，fresh全功能尚未重跑。
R75actual -0.365/-6.307ns、34 setup，hold+.025/0，pulse1.5；原IIR CE已+.138ns，仍有IIR数据-.003ns、common/phase/限幅布线长路径及14DAC失败。
本轮仅phys_opt_design -placement_opt -routing_opt -critical_pin_opt -path_groups clk_2，再route Explore。
不启用retime、FF插入、DSP寄存器搬移、复制、rewire、clock_opt，不改时钟/IO预算/例外。
导出前后funcsim逻辑网表，除已明确物理注释外逐token严格比对；INIT/实际端口/位宽/DSP参数不忽略。若不一致，保留诊断，不接受等价。
所有时钟域仍完整报告；core路径定位不等于只签core。新增反馈周期0，继承相对R2b+32ns；实际总ADC-DAC延迟未测。
actual route/STA/CDC/DRC/IO待独立结果，不能先写PASS。R72基线不覆盖，R73/R74失败不合并。
