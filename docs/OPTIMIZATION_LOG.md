> **2026-11-11 R60最新结果**：受约束setup/hold/pulse均PASS，final WNS=+.003ns/TNS=0/0端点；最终STA仍FAIL（DNA/I/O覆盖、物理CDC和DRC未关闭）。候选不部署，完整功能/综合复用R52，见文末与R60_SIGNOFF_GAPS_20261111.md。

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

> **2026-11-10 R16最新结果**：CANDIDATE / 未最终签核，不部署，route WNS/TNS=-4.068/-5780.718ns，最终STA FAIL。详细归档见本文末尾。

# 优化记录

## 2026-11-06 / 基线归档

- 原工程：`D:\RP_Dev\linien-v2.1.0`，保持原工作树不动。
- GitHub 备份：`backup/20261106-pre-optimization`，提交 `a39000a802c27e0b6a904491ced4adaaceadfa35`。
- 包含当前有效源码、测试、移植文档、CE 候选、历史关键报告、PS BD/wrapper 与源码 SHA256 清单。
- 优化分支：`opt/ce-saturation-20261106`；全部候选均在独立副本进行。
- 基线状态：有历史功能/综合/route 证据，最终 STA 未签核。

## 2026-11-09 / R0 隔离构建与回归准备

- 状态：COMPLETED（功能通过、综合与route完成；最终STA失败）。
- `gateware/fpga_image_helper.py`：PS BD 默认使用仓库快照输入，并支持 `LINIEN_PS_BD`、`LINIEN_FPGA_BUILD_DIR`、`LINIEN_CSRMAP_OUTPUT`；试验可将所有生成文件写入新目录。
- `tools/run_gateware_trial.py`：独立输出与 PS 副本、源码哈希、stdout/stderr/退出码、功能标记、综合与 route 分阶段记录；不生成 bitstream。
- 后续候选：CE 数据寄存器使能（不冻结 CSR）、零新增延迟的积分饱和判定化简。
- 反馈延迟：R0 不改算法时序；CE 的 k=0 +4 ns 采样差异单独记录；本轮不插入反馈流水线。
- 环境：新建 Python 3.10.21 虚拟环境；uv 安装因 SciPy TLS 下载错误失败，改用 pip 和本机缓存，完整日志保留。
- 已完成：7 项 pytest 通过；AXI read/write、bridge、snapshot、integration/reset 用例通过，桥相位 1/1250/3999/7999 ps 均有 PASS。
- 测试修复：`gateware/tests/cdc/tb_bus_clk_bridge.sv` 将浮点时钟时间相等判断改为整数皮秒，消除 1 ps 的浮点误报；没有更改通信 RTL。
- 工具适配：xelab 指定 1ns/1ps 默认 timescale；Vivado bat 参数 KEY=VALUE 保留引号；PS BD 与新建 project 目录必须平级，避免 IPI 目录重叠。
- 新基线生成/综合/route：`gateware/build/trials/20261109_093033_baseline`；综合 WNS/TNS=-5.966/-4180.463 ns；routed WNS/TNS=-5.354/-9445.378 ns、WHS=0.027 ns、WPWS=1.500 ns，与历史基线一致。
- 功能证据目录：`gateware/build/trials/20261109_092834_baseline`。其综合阶段目录重叠失败已保留日志，不能算综合通过；上述新目录才是成功构建证据。
- R0 提交：`843a321`。最终时序签核仍 FAIL/INCOMPLETE。

## 2026-11-09 / R1 慢速 CE 兼容候选

- 状态：CANDIDATE（功能通过、综合与route完成；最终STA失败，未并入原工程）。
- `gateware/logic/decimation.py`、`pid.py`、`limit.py`、`chains.py`、`linien_module.py`：从已保存候选引入固定 125 MHz、仅数据寄存器 CE 的实现；CSRStorage 写入逻辑保持常时钟运行。
- 与历史候选的明确差异：已从 Migen 0.9.2 的 ArrayProxy/Case.makedefault 证明旧动态数组越界使用最后一项。新 CE 因此保留 16..31 等效第15档，不采用历史候选的非法值停更行为；修正 k=0 相位注释为模型记录的 +4 ns。
- 新增 `gateware/tests/timing/tb_ce_saturation.py`：14/25位 PID 差分、精确饱和边界、CE/reset、真实高分频事件、非法索引/动态配置、LimitCSR 差分、CE=0真实CSR总线读写。
- `experiments/baseline_20261106/{pid,limit}_reference.py`：直接取备份提交中未修改源码，供差分参考，不改变 DUT。
- 未新增反馈流水级；CE 全局复位会重启计数相位，动态切换/复位后的行为不宣称与原逻辑时钟逐边沿等价。
- 测试开发中修正了参考端初始化和调度：Migen 0.9.2 使用 CEInserter；参考 CE 初值与 DUT 的 update_en=1 一致；复位模型按发生沿已采样的 reset 更新，并逐周期断言计数器/started。没有删除错误断言或改动硬件来适配测试。
- 完整验证目录：`gateware/build/trials/20261109_094155_ce`。7 项 pytest、CE_SATURATION_SUITE_PASS、既有 XSim 及四相位用例全部通过；CSR map 完全一致；综合和 route 完成。
- 综合 WNS/TNS=-5.966/-4345.464 ns；routed WNS/TNS=-5.972/-11109.872 ns、Setup失败端点7357、WHS=0.018 ns、WPWS=1.500 ns；no_clock=1、未约束内部端点=2。
- 当前最差路径是快速PID setpoint→int_reg[42]/D，13.911 ns，19个CARRY4+1个DSP。相对原版更差，不能称 CE 已经解决性能；其主要收益仍是时钟安全架构和时序覆盖。状态 CANDIDATE / PASS-FUNCTIONAL / SYNTH_COMPLETE / ROUTE_COMPLETE / STA_FAIL，未并入原工程。
- R1 提交：`c76d00b`，已推送优化分支。

## 2026-11-09 / R2a 零新增延迟的积分饱和比较

- 状态：REJECTED；功能通过，但routed WNS恶化，失败源码与报告已归档。
- 唯一算法文件：`gateware/logic/pid.py`。保留完整 int_sum、积分位宽、乘法/右移、饱和常数、复位和 CE 优先级，仅把比较拆成有符号高位比较与低位 reduction。
- 精确边界仍为 U=max_pos<<extra_width、L=-U-1，不改成普通二补码上下限。高位切片先赋给明确的有符号 Signal，避免无符号比较错误。
- 新增寄存器=0，新增反馈流水周期=0；快慢PID均用相同参数化恒等变换，分别以14/25位差分和边界用例验收。
- 对照版本：`c76d00b` 的 CE 实现与 `20261109_094155_ce` 报告。时序收益未测前不作通过声明。
- R2a 结果：`20261109_095327_ce_sat` 的完整功能回归通过，综合/route完成，但综合WNS=-7.460 ns、routed WNS/TNS=-6.448/-10445.604 ns、Setup失败端点6955。TNS虽改善，最差WNS却比CE对照恶化0.476 ns，因此 REJECTED，未将其当作优化保留。
- 失败源码保存为 `experiments/optimization_20261109/pid_sat_compare_rejected.py`，报告和输入哈希保留。

## 2026-11-09 / R2b 饱和边界直接位解码

- 状态：CANDIDATE / PASS-FUNCTIONAL / SYNTH-COMPLETE / ROUTE-COMPLETE / STA-FAIL。只修改 `gateware/logic/pid.py` 的组合饱和判定，不改变数据寄存器、位宽、截断、CSR或反馈延迟。
- 用 int_sum 的两位高位、边界中段全1/全0、低位非0/非全1解码精确 U/L，避免 R2a 的通用有符号大小比较；保留N+1位和的进位/符号信息。
- 继续采用同一14/25位差分、极限/饱和/复位、CE、CSR和RTL回归；对照仍为c76d00b的CE。未测前不宣称改善。
- R2b 首轮结果：`20261109_100550_ce_sat_bits` 的7项pytest、完整CE/数值/CSR套件、XSim回归及CSR map检查通过；综合/route完成。
- 综合WNS/TNS=-6.094/-4563.029 ns；routed WNS/TNS=-5.605/-10473.525 ns、Setup失败端点6813、WHS=0.051 ns、WPWS=1.500 ns。
- 相对CE：WNS改善0.367 ns、TNS减少636.347 ns负裕量、失败端点减少544；仍有严重Setup违规，不能签核。保留为候选并做一次同DCP、同directive的route重复验证，不与原版未约束慢时钟的数据直接比较优劣。
- 新分组只读报告工具补查 /D、/R、/S、/CE 与积分反馈。CE的慢速R/CE最差来自slow_decimation CSR，布线约7.2ns；R2a引入的最差饱和控制到/S，说明必须同时追踪同步set/reset/data控制。
- `tools/run_gateware_trial.py` 的非功能阶段控制台改为 COMPLETE，避免把命令成功输出的PASS误读为STA通过；不改变构建算法或directive。
- 重复实现：`20261109_101735_ce_sat_bits_repeat_route`，使用相同synth DCP与相同opt/place/phys_opt/route，WNS/TNS=-5.605/-10473.525、Setup6813、WHS0.051、WPWS1.500完全一致。保留R2b为下一轮候选起点，不覆盖原工程/备份分支。
- 当前快PID最差/D=-5.605 ns；慢PID/S=-5.414、/D=-5.242；积分反馈快+1.658、慢+2.101 ns。前端误差/乘法是下一阶段主要切分对象；未引入8/16ns流水线。
- CDC-1从439到444：报告差集为新增15/移除10条，均为既有bus_clk_bridge地址/写数据到CSR接收寄存器副本的变化。其物理CDC安全仍未证明，不能豁免；其他CDC类别未改善。
- `requirements-gateware.lock.txt` 固定本次环境，`experiments/baseline_20261106/README.md` 警示历史覆盖式脚本仅归档；`tools/report_pid_details.tcl` 提供可重复只读分组诊断；小体积日志/报告、输入哈希和失败源码保存到 `experiments/optimization_20261109`。
- `docs/PORTING_STATUS.md` 增加2026-11-09当前分支说明和第11节四级验证结果、全部A/B数字、已知风险及后续目标；没有把负WNS写成时序通过。
- R2b代码提交：`502be6c9edc1269e21c766d9cce053025aa321fa`。原目录168文件核查未变化；当前PID与已测试R2b输入哈希一致，失败候选归档也与R2a输入一致；证据ZIP均完成完整性检查。


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
# R61b 新构建与 R62 接口候选 / 2026-11-12

R61b 输入4aba6ce，完整功能PASS、CSR语义PASS、新综合/route完成，route WNS/TNS
-.232/-2.317ns、25端点，hold .010/0、pulse1.5/0，no_clock/internal-unconstrained均0；
最终STA FAIL。真实原件及SHA归档experiments/r61b_fresh_full_20261112，R61b/R60冻结。

R62硬件只改gateware/lowlevel/analog.py的ADC输入捕获FF到同sys下降沿及IOB TRUE，
gateware/hw_platform.py的DAC data到FAST/8mA。新增完整sys流水级0，ADC采样边沿移4ns，
明确word[n]在fall捕获next rising使用，不冒称旧采样编号等价。完整原生双路14位/复位/
样本号/DAC原时隙功能PASS，工具/fixture/日志另存；全回归及route待实际结果。
run_gateware_trial纳入该原生测试及io_intrinsic_probe.tcl器件必要预算、maxThreads2。
零PCB偏斜仅诊断假设；PLL/引脚/CSR保持，IQSEL/CLK-WRT/脉宽/物理CDC/DRC均不能借此
宣称关闭。失败保留不合并。详细计划/原理/风险见docs/R62_PLAN.md与PORTING_STATUS文末。

R62实际结果：输入cb81bdd，fresh完整功能PASS、新综合COMPLETE、新route COMPLETE，
两个trial输入逐文件SHA同且构建期间变化=[]。route WNS/TNS=-1.261/-2245.782、3604端点，
hold-.696/-23.517、42端点；最终STA FAIL，REJECTED不合并。ADC falling→CORDIC只有4ns
预算而实际5.209ns，28输入FF实际IOB；DAC必要预算setup-.835/hold-.456。异常AXI+bridge
4相位集成PASS，bitstream_checks无Error/Critical但406 Warning/Advisory，仍需处置。
源码/manifest/全部阶段报告/DCP/功能和输入输出SHA见experiments/r62_failed_physical_20261112。

R63：ADC恢复原rising FF/IOB，新增整数反馈级0。以明确same-word源同步协议收紧28个
ADC pad→IOB D的setup8ns到0-cycle，并验证下一word hold；不是计算通路多周期放宽。
详见R63_ADC_CAPTURE_PROTOCOL.md公式、AMD语义、确切端点断言及拟核验报告边沿。
四组完整14位/复位/位间偏差/新旧R61b完整analog settled输出/消费者样本号原生PASS，
独立负向控制按预期失败，证明oracle可检测旧字；两处测试器入口错误原样另存。
新综合和route待执行，DAC必要预算/脉宽、物理CDC/DRC仍OPEN，不部署不合并。

R63实际route：整机-.835/-14.041、32 setup端点，hold-.456/-5.876、14端点，仍FAIL。
ADC组件取得零PCB必要预算setup+.429/hold+3.304，28个源/目的、0/-8ns关系逐条核验PASS；
保留ADC_COMPONENT_CANDIDATE，不当作整板完成。DAC-.835/-.456、内部clk_2-.389/18端点
继续；本轮未重跑完整组件功能，明确继承R62共同输入RAW SHA相同的完整回归，analog本轮
新原生PASS。输入7ef3cf5，源码变化=[]，全部DCP/日志/输入输出SHA与范围说明归档
experiments/r63_adc_solution_candidate_20261112。不烧录，不把元件级通过当作最终签核。

R64候选：analog data ODDR125 OPPOSITE_EDGE→250 SAME_EDGE/D1=D2；原数据FF保持，新增
F/S/B三个纯控制FF，以sys翻转在250 falling处差分建立A/B相位，目标数据额外0级。
数学逐时隙和启动/复位依据见R64_DAC_SHARED_CLOCK.md。实际完整analog49位新旧原生
稳定边沿对照（启动2ns起）/四组包络/全部14位/复位/原A旧B新/负向样本检测PASS。
PLL、相位、引脚和DRIVE保持，无计算通路放宽。新全回归/综合/route待执行，2ns控制
路径和DAC I/O/PW/SEL、CDC/DRC仍未签核；全部原生原件在r64_shared_dac_native_20261112。

R64实际：fresh全功能PASS、CSR PASS、新综合/route完成，输入a4b349d、输入SHA同且变化=[]。
route -.748/-44.222、254端点；hold-1.901/-26.110、14端点；REJECTED。2ns select→ODDR
路径-.748，frame→select-.331；DAC必要预算setup-.343/hold-1.901（后者ODDR fall路径，
D1=D2的真实同边沿波形不翻转，不能cut，应下一候选用SDR FF表达）。ADC仍+.429/+3.304，
DNA+.538/+.199，25对ASYNC实际同SLICE且首级仅次级D。完整原件/源码/输入输出SHA及非法
DRIVE24内存诊断失败（未改DCP或源码）在experiments/r64_rejected_oddr_20261112。

R65候选：14个DAC data SAME_EDGE/D1=D2 ODDR→250MHz SDR FDRE/IOB TRUE，原数据/3控制FF
保持，额外数据级0。声明数字契约下数学等价，并实际UNISIM新旧49位全输出/启动/复位/
四组完整14位/样本负例PASS；生成结构46正/2负FDRE和无dataSAMEEDGE检查PASS，原件在
experiments/r65_sdr_dac_native_20261112。新综合/route待执行；其他完整功能明确暂参考
R64同源PASS不重跑，最终候选发布前完整回归。PLL/引脚/驱动/CSR未改，无新增例外。

## 2026-11-12 R65 实际结果：REJECTED_NOT_MERGED

输入代码82699d8960817ab2d08517eb8705aed0835c667f；新综合/实际route均COMPLETE，CSR映射PASS。原生analog新旧同波形/启动/复位/四包络/完整14位/样本负例PASS，本轮完整功能NOT RERUN，未改组件参考R64同源fresh全功能PASS，不能当成本轮全功能重跑。

实际route WNS/TNS=-.683/-55.023ns，312 setup端点；WHS/THS=+.024/0、0 hold端点，WPWS=+1.500ns。SDR表达消除了R64负hold；最差FDRE_33/C负边沿到FDRE_40/D正边沿，2ns路径仍FAIL。DAC必要零PCB预算setup/hold=-.343/+.070ns；ADC全28端点+.429/+3.304ns、0/-8ns边沿关系逐条PASS。内部clk_2 WNS=-.345ns。no_clock=0、内部未约束=0，16输入/32输出尚须接口分类/真实约束。物理CDC25对50FF同SLICE且一级Q只到二级D，仍不足以宣布跨域整体安全；PS原始异步reset释放已被独立实际CRG仿真确认为待修复项。

源码、完整阶段日志、DCP、物理诊断及SHA归档experiments/r65_rejected_control_20261112，DCP SHA256=5e7c3b93c8a3e02d91b25586981e483a11e70d17319175f3d22cfba97d335aee。失败候选不合并/不部署。R65相对R64新增数据串行级0，继承相对R2b主反馈+32ns；最终STA/板级I/O/CDC/DRC仍未签核，没有生成发布bit/bin。


## R66候选计划

# R66 DAC full-cycle slot control

2026-11-12，独立opt/r66-dac-fullcycle-select-20261112。R65冻结0d7f00d，原工程/全部旧基线不改。

## 修改前数学依据

令T=8ns，F在nT的125MHz正边沿翻转，H在每个250MHz正边沿采样F；两者INIT0，均不受sys reset清除。数据输出IOB在同样250MHz正边沿采样Mux(F xor H,B,A)。使用真实触发器的边沿前状态：
- 在nT前，H已经等于F，XOR=0，输出A[n-1]；在该边沿F翻转、H采样旧F。
- 在nT+4ns前，XOR=1，输出B[n]；该边沿H采样新F，之后XOR恢复0。
- 下一nT+8ns重复，保持原版125MHz OPPOSITE_EDGE的A旧字/B新字顺序；原数据FF/编码/复位均不变。

R65的负边沿H/选择FF到IOB只给2ns。本方案改成同边沿正FF历史+XOR，F/H和数据FF到IOB自然预算4ns，不增加数据级，不用multicycle或false path。frame到H的同边沿hold必须真实通过，绝不切掉；组合XOR/Mux是否合并为单LUT和扇出/布线影响由新综合确定，不预报必然PASS。

## 修改、验证和边界

仅analog.py控制寄存器及新的check_r66_analog.py/回归入口，另更新记录。生成RTL预期32ADC+14DAC+1phase-history正边沿显式FDRE，无负边沿FDRE。冻结R61b完整analog黄金不改，逐稳定边沿全部49位比较（含启动GSR/复位），四时钟/数据包络、完整14位两路样本、下游消费样本标记与负向控制均须PASS。后续fresh全功能、CSR映射、新综合和route分别记录。

新增ADC→DAC串行数据级0，继承R4a/R17/R19相对R2b+32ns。复位外部波形和原数据复位保持。PLL/频率/相位/引脚/电平/DRIVE8 FAST/算法/CSR/滤波阶数/吞吐率不变。

R65 readonly合法DRIVE组合8/8、12/8、16/8、16/12、16/16、12/12未发现DAC setup/hold同时满足的组合，完整probe作为诊断保留，未选为源码更改。R66不声明解决DAC外部setup-.343ns、CLK/WRT/SEL/pulse、PCB、PS异步reset释放或所有物理CDC问题。这些必须另有验证和后续针对性整改。新SYS相位时序hold、2:1真实相位和FPGA配置启动仍有风险；原生仿真不是SDF/PVT证明。任何route FAIL继续归档，不直接合并或部署。


实际新旧原生analog检查：四功能时钟/数据包络、启动GSR/复位、完整14位、全部49位稳定输出、ADC样本号和下游消费样本PASS；负向零相位旧字模型按预期FAIL。每功能模型32813个样本/约131334个边沿；生成RTL正FDRE47/负FDRE0检查PASS。归档experiments/r66_fullcycle_native_20261112。功能仿真不能替代物理setup/hold；接下来运行新完整回归及综合/route。


# R67 PS-domain reset release

2026-11-12 独立opt/r67-ps-reset-release-20261112；以R66输入decd142为父，R66物理/完整回归仍在独立运行，其结果未假定通过。保留所有旧基线。

## 已证事实与修改依据

实际CRG+Migen原生UNISIM诊断已复现：PS reset在FCLK停止时释放，会立即释放原sys_ps.rst，未经过FCLK有效边沿。这是复位释放协议缺口，不是给跨域数量作标记可以消除的告警。AMD UG1046 UltraFast Embedded Design Methodology确认FCLK_RESET异步于PL，需按实际时钟域同步。
https://docs.amd.com/api/khub/documents/7KECH4F2hgvQrFavb20mVg/content

CRG中sys_ps.clk继续直连原FCLK0；sys_ps.rst由原PS raw reset经过标准Migen AsyncResetSynchronizer异步置位、两拍同步释放。PitayaPS的AXI arstn改接~ResetSignal('sys_ps')，使AXI/DummyHK/源总线在同一FCLK复位契约下。RootModule给CRG的输入仍是原始~ps.frstn[0]，没有同步reset反馈到自己的组合环。

## 延迟、范围和验证

只多2个控制FF，新增PS复位释放等待2个FCLK周期（125MHz时16ns），可能影响复位后首次AXI事务等待；正常事务/CSR地址/数据/背压/ADC→DAC反馈数据流水级全部不变。SYS域PLL失锁异步置位+两边沿释放、PLL/PS7/器件/引脚/时钟频率相位保持原样。

实际CRG UNISIM：停止SYS时失锁异步置位，恢复LOCKED且SYS停钟不提前释放，两个SYS有效边沿后释放；停止FCLK时PS复位异步置位，解除PS原始reset不能提前释放，两个FCLK有效边沿后释放。此模型强制LOCKED/sysclock，只证明数字reset逻辑，不是假装验证PLL物理失锁检测或模拟亚稳态。另从实际RootModule Migen对象检查PS raw reset→CRG async_reset、正确时钟域、AXI instance reset wiring，不能只看两行源码。

原生检查后完整功能回归、顶层CSR映射、新综合/route，检查新增同步器物理配对与reset恢复/去除路径。源桥自身ready仍有两拍，故源reset释放后还需要既有ready等待；不改变故障语义。本轮不修改bridge/axi_slave的错误数据处理，也不宣布其异常复位期间的数据保持已完成物理CDC证明。

R66继承的ADC/DAC与内部物理时序待实际结果，其他外部I/O协议、PCB、DAC脉宽解释和物理CDC签核仍OPEN。不生成正式上板镜像。

实际CRG原生compile/elaborate/simulate全PASS，SYS及PS两域停钟/异步置位/两有效边沿释放PASS；实际RootModule对象身份和axi_slave instance reset端口连线PASS。归档experiments/r67_ps_reset_native_20261112。下一步新生成/综合；独立R67 route尚未运行，不虚报物理CDC签核。


# R68 positive-edge DAC clock forwarding (candidate)

2026-11-12，独立opt/r68-dac-positive-forward-20261112，父R67代码78cd9df，PS reset修复原生及actual RootModule wiring已PASS，R67综合仍在独立运行。本轮R66实际route -.343/-6.398ns、47端点、hold+.024/0；其最差为DAC数据输出。R66整个设计仍STA FAIL。

## 修改前等价推导

250MHz周期4ns。旧WRT ODDR在phase0时钟D1=0/D2=1，pad rising=2+4k、falling=4+4k ns。将原本未使用的PLL CLKOUT5保留divide4频率、phase改180°，新增一BUFG给dac_wrt；ODDR D1=1/D2=0，则pad rising=2+4k、falling=4+4k，完全相同。旧CLK的PLL phase=-45°，负边沿=1.5+4k；改PLL phase=+135°，正边沿=1.5+4k，ODDR常量同样反转，pad波形仍相同。INIT0/CE1/R0/S0照旧。

目的不是修改时序例外，而是使数据正边沿与WRT有效边沿采用实际正边沿硬件，在保留相同pad波形情况下研究PVT/公共路径悲观消除及实际布线影响。是否改善只由实际报告判定，不把相位重编码必然成功当事实。source有效极性改变后，生成forwarded clock必须去掉旧-invert；不是放宽clock周期或改变I/O setup2/hold1.5。

修改crg.py的CLKOUT4/5相位、新dac_wrt BUFG；analog.py仅WRT/CLK两个ODDR常量/时钟；io_intrinsic_probe.tcl按实际源极性更新generated clock。ADC/PID/CSR/PS7/引脚/电平/DRIVE8 FAST/吞吐率不变。SEL时钟和波形原样，已知其均低窗口未签核。本轮新增数据反馈级0，继承相对R2b+32ns；理论pad边沿不变，不能写成新增/减少了一个数据周期。

## 验证

冻结R67实际CRG源码为reference/r67_crg.py，冻结R61b analog不动。四组独立功能时钟包络比较全部49位、启动/复位/14位样本/下游样本，原生实际Migen与UNISIM；再用真实两个CRG/PLL原语生成时钟比较新旧接口，区分稳定锁定区间与未锁定启动区间，不将人工注入相位当作实际PLL模型。

之后新生成/CSR映射、新综合和actual route；核对forwarded WRT rising2/fall4、CLK rising1.5/fall3.5、14 DAC SDR IOB、ADC28 setup/hold、正边沿时隙控制hold、所有内部路径、PS新增ASR物理位置、coverage/CDC/DRC。失败完整保留不合并。R67独立route若未运行写NOT RUN，不能借本轮完整组合结果伪造独立结果。

本方案尚不解决SEL低窗口、CLK领先WRT严格裕量、DAC外部3.5ns pulse手册解释/PCB实测及异常复位return-data物理CDC问题。所有都必须独立处理，不能签发正式板用镜像或宣称可闭环。

实际四包络/49位/启动GSR/复位/14位/样本负例PASS；实际old/new CRG+PLL+analog两锁定复位释放epoch的49位严格比较及真实C source phase1.5/2.0ns PASS。初版fixture忽略ODDR原语传播100ps导致相位断言FAIL，已保留失败日志并改为检查C source，pad49位严格比较未放宽。归档experiments/r68_positive_forward_native_20261112。随后新生成/综合/route；本轮全功能暂NOT RERUN，未改组件对应R66完整同源PASS，不把继承写作本轮重跑。


# R69 AXI timeout cancellation and invalid payload isolation

2026-11-12独立opt/r69-timeout-cancel-20261112。父R68物理仍运行，不预判其通过；R66 full回归PASS/route FAIL。原工程及历史有效/失败候选均保留。

## 修改前实际故障证据

对冻结R68实际AXI+bridge源码的只读六情景检查确认：目标停钟+复位恢复fault ACK、无复位目标停钟read timeout、非法ARSIZE读，三种SLVERR原样带出上一个destination held数据；目标在写接受前停钟，AXI超时并完成B响应后恢复目标clock，会迟到执行旧写；复位会清除可能正处于消费窗口的return held数据。正常下游ERR保留有效payload/背压测试PASS。以上是新要求的故障契约缺口，不将旧全功能回归改写为FAIL，也不声称旧回归覆盖了它。

## 具体修改与正常事务等价

axi_slave增加内部sys_abort_o：仅ack_cnt[5]且存在活动事务、响应尚未valid时为1。Axi2Sys的source SYS rstn=既有同步PS AXI resetn AND NOT abort，AXI自身reset仍只用同步PSreset。取消只清空桥握手epoch，不复位ADC控制算法或软件CSR，不丢弃AXI错误响应。正常事务未超时时abort恒0，rstn及一切握手逐拍与原来一致。

axi_slave对timeout或已锁存rd_error读RDATA置本地0，原先这些情景没有经过正常destinationACK资格，不再把异步旧payload当成有效数据采样；正常ACK包括sys_err_i=1时，数据保持原样，RRESP仍SLVERR。R/B背压锁存规则不变。

bus_clk_bridge对本地src_fault_ack读数据强制0；return payload/error寄存器改为INIT0，仅正常qualified ACK更新，epoch取消不改其值。无ACK时旧held值不是有效响应；fault用local0隔离，normalACK在数据先保持、两级ACK同步后才消费，因此正常协议数学归纳保持。ren/wen增加dst_ready[1]资格，取消后即使目标clock恢复也不能在旧控制清理前执行旧脉冲。正常稳态ready=11故原脉冲不改。

## 取消边界、验证与限制

承诺：目标在请求处理前已停钟，超时取消epoch已传播后再恢复clock，不得执行旧请求；已有副作用在timeout前已提交的写不能回滚，不能把SLVERR解释成硬件必然未写。复位/取消临界边沿的完成与取消允许保守错误，仍须物理CDC/恢复去除及实际时序核查，数字仿真不是亚稳态或MTBF证明。

新增正常ADC→DAC流水级0、正常CSR事务额外时钟0；只改故障/取消语义与无效payload，CSR地址不变。源总线epoch新增取消恢复的两边沿ready等待，AXI错误响应继续稳定；后续请求若尚未ready，应按原src_fault_ack返回错误，不能静默遗失。

六情景×4异步相位：恢复fault、停钟timeout读、非法读、停钟timeout写无replay+新正常事务恢复、正常下游ERR保留payload、无效epoch保留return payload。另actual RootModule对象检查新增abort输出→source rstn且不回接AXIreset；现有AXI读写、CDC snapshot/多相位、Scope/背压/CSR等完整回归不删除断言。新综合/实际route、CDC物理结构/最大最小延迟与DRC独立记录，失败保留。

本轮不加任何时序例外，保持ADC同字捕获既有严格0-cycle约束与8ns时钟。DAC/PCB外部时序及手册pulse问题、完整物理CDC签核仍未关闭，不生成正式上板镜像。


R68实际route已失败：WNS/TNS=-.829/-16.583ns、45端点，WHS/THS=-.412/-5.257ns、14端点；同pad波形正边沿clock重编码无物理收益，拒绝保留于生产候选。R69在完整物理输入冻结前，将crg.py/analog.py/io_intrinsic_probe.tcl逐RAW字节恢复到R67（即R66 DAC + R67 PS ASR），保留R68分支原失败源和报告。R68脚本和参考文件仅为历史重现，R69回归入口恢复check_r66_analog，保留R67 reset检查并加入R69 fault/wiring检查。不是回退PS reset成果、不是覆盖R68失败现场；只是选取较优组件组合，额外数据级0。

本轮针对性实际native结果：六原故障情景×4异步相位=24例PASS；新增“目标请求已到同步器末级但尚未提交即停钟”和“timeout控制断言100ps后立即恢复目标clock”两例×4相位=8例PASS。同一两个新增fixture在冻结R68均按预期复现超时后旧写replay FAIL；正常下游ERR payload两边PASS。实际RootModule取消连线/四SYS slave/source epoch与AXI自身reset分离检查PASS。全部32候选例、对应旧缺口FAIL、原源码/SHA均在experiments/r69_fault_native_20261112。完整功能和新物理将在冻结输入后另跑，不把这些32例写作完整回归。

## 2026-11-12 R69实际：32故障PASS，严格旧空闲总线差分FAIL，STA FAIL

输入afdfa18334a9cb34ccd6419f8c5e02286e903296；新32故障/取消/重放/非法payload及实际Root连线PASS。完整回归在Scope factor-cache parent phase0的79926ns FAIL：复位0/0、ACK0/0、ERR0/0，旧RDATA0/新RDATA1。保留return payload导致无有效响应周期数据变化，符合新计划的fault隔离，但旧严格“包括无ACK周期数据相等”检查不成立，不能写全功能PASS。后续未执行项NOT RUN。原manifest functional仍初始NOT RUN，其failure和原生日志明确实际FAIL，原件不回写；下一runner需将运行/失败状态准确记录。

新综合COMPLETE：WNS/TNS=-.773/-80.399ns（312端点）；actual route COMPLETE：WNS/TNS=-.411/-30.808ns（242端点），WHS/THS=+.027/0（0端点），WPWS+1.500ns。最差fast_a_zi0__10/C→fast_b_cordic17[16]/D，8.395ns（logic4.140/route4.255，14级9CARRY4+5LUT）；DAC必要预算-.343/+.070，ADC28+.429/+3.304及0/-8ns逐条PASS，DNA+.009/+.216ns。LUT11803/FF13386/DSP94/BRAM35/BUFG6；noClock0/内部未约束0、noInput16/noOutput32。52ASYNC FF/26pair同SLICE一级Q只驱动二级D，CDC总体NOT PROVEN（报告当前451 CDC1，不能拿数量判断已签核）。

全部原始strict失败源/日志、生成文件、新物理DCP/SHA、实际总线值诊断及clock geometry在experiments/r69_strict_failure_and_physical_20261112。DCP SHA256=63e1f2a98a3d335dff9880408e35ac0cbf36573d6859663e6bdb6dbd14c2be40。R66只读FAST合法16电气组合、逐14位224行扫描无同时setup/hold可行解，含整体相移假设也未找到交集，仅诊断未选入源码。

下一R69b仅明确测试契约，硬件源码逐RAW保持本输入：ACK始终严格比较，payload/ERR仅在任一ACK非确知0时四态比较，保留所有数值/状态/内存/CSR/cohort断言和原始strict FAIL。必须独立跑过才能写更新契约PASS，不能将旧FAIL删掉；不预判是否存在有效响应或Scope数值问题。最终未签核、不部署，正常反馈新增级0（继承+32ns相对R2b）。


# R69b qualified SYS response regression contract

2026-11-12。只改测试/记录；硬件源码逐raw保持R69 afdfa183，无新综合/route，物理数据明确复用R69（-.411/-30.808ns，STA FAIL）。

R69原始严格full在Scope复位79926ns FAIL：reset0/0、ACK0/0、ERR0/0，数据0/1。R69刻意让return payload跨epoch无效化时保持，而有效fault ACK本地置0；ACK0时数据不构成事务响应。原件和FAIL全保留，不将其改成PASS。

数学/接口依据：SYS总线数据由AXI在rd_do && ack时锁存；Scope母模块同样以ACK资格返回事务。ACK为0时payload/ERR不构成有效响应。R69新fault/timeout/invalid读在AXI端明确置零并已有32独立故障例覆盖。正常qualified ACK包括下游ERR时payload仍与原来相同，必须继续证明。

新wrapper保留冻结R38 Scope+bridge参考和原3测试脚本SHA；不替换成候选bridge、不改DUT、不改原脚本。原生生成fixture仅保留R61既有reset三SYS等待，并把原“无ACK周期也相同”监视器拆为：ACK始终严格四态比较；任一ACK非确知0（包括X/Z）时payload+ERR严格比较；两ACK均0的差分计数并报告。Scope数值/所有内部状态/CSR/cohort/BRAM/触发/时序脉冲断言逐字保留。原runner旧scope声明另外归档，新的结果明确写实际契约，不能伪称全周期raw bus相同。

这一步并非提前宣布有效响应PASS。先运行新Scope suite，通过后才完整回归；任何有效ACK/数值/状态失败必须修源码，不可继续放宽断言。该branch不做新的时序例外、不改clock/反馈延迟/CSR接口。run_gateware_trial功能阶段新增RUNNING/FAIL状态，修复异常中断时manifest残留NOT RUN的记录问题；旧manifest原件不改。

R69b目标factor-cache回归四相位全部PASS：161872 scalar固定点及3000 X/Z案例、四整Scope原生数值/状态/内存/CSR/cohort/无条件ACK/有资格payload检查。无ACK周期差分计数保留。初版wrapper变量遮蔽了simulate的字符串marker，工具TypeError导致未完成；原fixture/日志/source归档并修正变量名，未改任何DUT或仿真断言。56个实际gateware/hardware/common文件逐RAW与冻结R69一致，物理结果仅REUSED_R69。完整契约回归尚待运行，原严格空闲payload差分FAIL保持。


# R70 placement/routing-only physical trial

2026-11-12 独立opt/r70-physical-place-route-20261112。实际硬件继承R69，输入为R69 routed DCP SHA256 63e1f2a98a3d335dff9880408e35ac0cbf36573d6859663e6bdb6dbd14c2be40；56个gateware/hardware/common实际源文件逐raw一致。R69b有效响应契约fresh full仍运行，原R69严格包括idle数据的FAIL保留。

当前R69最差fast_a_zi0__10/C→fast_b_cordic17[16]/D，14级9carry+5LUT、logic4.140/route4.255ns、WNS-.411。此次只执行Vivado2020.1明确的phys_opt_design -placement_opt -routing_opt，再route_design -directive Explore；本地工具-help确认显式选项禁用其他隐含类别。不开retime、不插负边沿FF、不做DSP/BRAM寄存器优化、不复制FF、不rewire、不clock_opt，不改PLL/时钟周期/I/O参数/约束/CSR/算法/吞吐率。新增正常反馈级0、复位协议不变。

新物理DCP写唯一目录，原DCP只读并核验前后SHA。新综合NOT RUN，综合数据REUSED_R69；actual postroute结果单独报告，不把父综合复制件叫新综合。完整funcsim导出before/after，仅去注释和LOC/BEL物理位置属性后严格字符比较所有逻辑参数/连接/初始化；若不相等则不接受逻辑等价，保留差异诊断。仍须新实际setup/hold/pulse/ADC/DAC/DNA/CDC/DRC报告；相等不代表已经签核。

当前DAC必要零PCBsetup-.343/hold+.070，合法FAST16组合/逐位扫描无可行解，单纯核心布线优化不自动解决外部数据/SEL/CLK/pulse/PCB。ADC28+.429/+3.304、DNAsetup+.009很小，任何新的hold或DNA违例均不能忽略。物理试验按结果保留/拒绝，不部署。


# R71 core-targeted placement/routing TNS cleanup

2026-11-12独立opt/r71-core-physical-cleanup-20261112。硬件源码仍逐raw等于R69；R69b有效响应fresh full运行中，不能提前填PASS；原R69严格idle数据等价FAIL保持。

R70实际postroute WNS/TNS=-.343/-5.900ns、70端点，hold+.027/0、WPWS1.5；核心最差-.205ns，为fast_a_iir0_z_low0/CLK→fast_a_iir0_z_high0/CEB2，DSP+LUT2级、7.603ns(logic5.848/route1.755)，不可仅看phase路径名称。新综合NOT RUN，综合REUSED_R69。

R70脚本原严格文本比较FAIL，因为只忽略LOC/BEL，输出增加3处PHYS_OPT_MODIFIED=PLACEMENT_OPT标注。独立证据确认完整diff仅3新增行，额外去掉该精确物理标签后全部原语/参数/INIT/连接逐token相等；原manifest的false与脚本退出1不改，追加placement_annotation_identity_proof.json提供正确限定的逻辑等价证据，不能把原严格比较器说成PASS。

本轮输入为R70实际routed DCP db5c8f6e20818363d39d884136a855d488db484c725c611cd6fb61fce7df8c4b，验证追加identity proof对应SHA后，在独立输出目录执行phys_opt_design -placement_opt -routing_opt -tns_cleanup -path_groups clk_2，再实际route Explore。path_groups只限制优化器工作范围，所有时钟和路径仍完整计时、报告，不增加任何时序例外。不开retime/FF插入/复制/寄存器优化/rewire/clock_opt，无新增反馈级；不改Migen/CSR/ADC/DAC/PLL/电气参数/时钟周期。

逻辑before/after完整funcsim严格比较，只忽略注释、LOC/BEL及精确PLACEMENT_OPT物理标签；输入canonical hash还须等于R70独立证明的canonical hash。原DCP前后SHA保持。若发生实际逻辑变化，不接受等价。全局DAC仍-.343ns必要预算，DNA旧+.009ns裕量很小，必须继续核查所有setup/hold/pulse/CDC/I/O/DRC，不能仅拿core过线宣称可上板。


R71-v1配置失败：Vivado2020.1明确-tns_cleanup只能用于SLR crossing的UltraScale/UltraScale+，不适用7020；未产生新route，不能写成硬件STA结果。原始命令/源码/退出3/日志与输入DCP未改SHA在experiments/r71_unsupported_tns_option_20261112。v2已删除该选项，保留-placement_opt -routing_opt -path_groups clk_2，独立新目录重跑；核心算法/寄存器/时钟和全部计时约束不改。


# R72 core LUT physical pin optimization

2026-11-12独立opt/r72-core-pin-opt-20261112。Migen/Verilog/CSR/PLL/约束源均逐RAW保持R69，功能参考R69b新完整有效响应契约PASS（20a397d输入；4c4f965记录），原strict无ACK payload差分FAIL保留。

R71-v2实际route WNS/TNS=-.343/-5.363ns、24端点，hold+.027/0；core最差-.234ns。输入DCP SHA256 55c46b57ccc79a6662765b7265a33a2ca52f9f2af0abdbfae13f6ddf4b11efc7。整体未签核。

R71-v2自身before/after逻辑token已严格相同；原脚本退出1是跨checkpoint重载的canonical检查：R71重开R70 DCP时多出30个PinAttr:HOLD_DETOUR数值布线元数据。所有diff仅这些新增属性；独立证明四份完整export（R70 before/after，R71 before/after）去掉明确的物理标注后，所有实际原语/INIT/参数/连接一致。原manifest false和退出1保留，追加proof绑定全部文件SHA及DCP SHA。物理hold属性从未删除或改写，实际WH仍完整检查。

本轮只phys_opt_design -critical_pin_opt -path_groups clk_2，然后实际route Explore。依据本地Vivado2020.1 help，此选项在LUT慢物理输入脚到快输入脚之间交换，逻辑输入函数仍应相同。无新reg/pipeline，无retime/寄存器优化/复制/rewire/clock_opt，无数学/软件接口变化。综合REUSED_R69，功能REUSED_R69b，新的实际物理与before/after逻辑等价必须各自报告。

比较器仅忽略注释、LOC/BEL、PHYS_OPT_MODIFIED以及数值PinAttr:HOLD_DETOUR路由标签，其余INIT/连接/寄存器/DSP参数严格不忽略。若pin优化引起真实逻辑连接/INIT变化，不能直接声称等价，必须保留diff并另证函数。所有时钟/路径仍完整计时，没有增加任何例外。保留原DCP且核验前后SHA。DAC必要预算仍-.343ns，board I/O/CDC/DRC未最终关闭，不部署。

## R69b后续完整功能结论

4c4f9650d1404126ecd6db448b7cc9c183160f05：明确的有效响应契约fresh完整PASS，32故障测试、9整Scope测试225588 ADC cycles/15404事务/1890已知读取。原strict无ACK周期数据FAIL完整保留。该结论对应R69原硬件，不自动替代R73新硬件功能回归。

## R70 actual物理候选 / 2026-11-12

输入444ea6a9f029093bfdd2c9fc42d1049d9fb56f00。综合REUSED_R69，不是新综合；route COMPLETE，WNS/TNS=-0.343/-5.9ns，70 setup端点，WHS/THS=0.027/0.0ns，WPWS=1.5ns。最终STA FAIL。功能引用同RAW硬件R69b完整有效响应契约PASS（4c4f965），原无ACK数据严格差分FAIL保留。

逻辑比较：Original strict export comparator FAIL: exactly three physical placement annotations. Independent exact logical proof PASS; original exit1 retained.

全部原始manifest/exit/实际报告/DCP、独立证明、只读审计在experiments/r70_actual_physical_20261112，DCP SHA256=db5c8f6e20818363d39d884136a855d488db484c725c611cd6fb61fce7df8c4b。只忽略物理注释做文本逻辑比较，未移除实际DCP属性，hold始终检查。ADC28端点+.429/+3.304ns、同字0/-8关系；52ASYNC/26同SLICE双级结构不等于整体CDC安全。外部DAC必要setup仍-.343ns，CLK/WRT/SEL/3.5ns外部脉宽/真实PCB及16输入32输出接口约束未签核。正常反馈新增周期0，继承相对R2b+32ns；无签核bitstream或烧录。

## R71 actual物理候选 / 2026-11-12

输入41c22164c181b256f81833e972784e7ba9c19240。综合REUSED_R69，不是新综合；route COMPLETE，WNS/TNS=-0.343/-5.363ns，24 setup端点，WHS/THS=0.027/0.0ns，WPWS=1.5ns。最终STA FAIL。功能引用同RAW硬件R69b完整有效响应契约PASS（4c4f965），原无ACK数据严格差分FAIL保留。

逻辑比较：Within-trial logical equality PASS; original cross-reopen comparator FAIL on 30 HOLD_DETOUR physical pin annotations. Independent transitive proof PASS; original exit1 retained. v1 unsupported TNS option separately archived.

全部原始manifest/exit/实际报告/DCP、独立证明、只读审计在experiments/r71_actual_physical_20261112，DCP SHA256=55c46b57ccc79a6662765b7265a33a2ca52f9f2af0abdbfae13f6ddf4b11efc7。只忽略物理注释做文本逻辑比较，未移除实际DCP属性，hold始终检查。ADC28端点+.429/+3.304ns、同字0/-8关系；52ASYNC/26同SLICE双级结构不等于整体CDC安全。外部DAC必要setup仍-.343ns，CLK/WRT/SEL/3.5ns外部脉宽/真实PCB及16输入32输出接口约束未签核。正常反馈新增周期0，继承相对R2b+32ns；无签核bitstream或烧录。

## R72 actual物理候选 / 2026-11-12

输入662ab1be674f1c638c2e21252e6cad62f203a534。综合REUSED_R69，不是新综合；route COMPLETE，WNS/TNS=-0.343/-4.308ns，17 setup端点，WHS/THS=0.027/0.0ns，WPWS=1.5ns。最终STA FAIL。功能引用同RAW硬件R69b完整有效响应契约PASS（4c4f965），原无ACK数据严格差分FAIL保留。

逻辑比较：Original run exit0 and within-trial / input canonical logical equality PASS.

全部原始manifest/exit/实际报告/DCP、独立证明、只读审计在experiments/r72_actual_physical_20261112，DCP SHA256=3c8b72a77450f5fbaf21f759982405472637883baa23261b4721ed8f6e4a3696。只忽略物理注释做文本逻辑比较，未移除实际DCP属性，hold始终检查。ADC28端点+.429/+3.304ns、同字0/-8关系；52ASYNC/26同SLICE双级结构不等于整体CDC安全。外部DAC必要setup仍-.343ns，CLK/WRT/SEL/3.5ns外部脉宽/真实PCB及16输入32输出接口约束未签核。正常反馈新增周期0，继承相对R2b+32ns；无签核bitstream或烧录。

## R73已执行定向回归

14/25位一/二/五阶共107706拍，新旧逐拍+独立有限位整数模型PASS（完整CSR/复位/hold/clear/饱和/脉冲延迟）；完整FastChain32000拍PASS，31976已知周期/21317写/24000 CE保持周期。厂商DSP48E1/FDRE原生模型。原件/SHA在experiments/r73_targeted_native_20261112。新完整功能/综合/实际route尚待，不得以此认定时序收敛或上板。

## R73b属性兼容修正 / 2026-11-12

R73输入9fbcc83定向功能PASS，但顶层generate在Migen `_printattr` 的 `attr_translate["DONT_TOUCH"]` KeyError，综合/route NOT RUN。原源码/manifest/完整失败日志保留experiments/r73_original_generation_failure_20261112。独立R73b仅将属性集合改成显式(DONT_TOUCH,true)键值，不改变任何状态、位宽或周期，按实际库源规避属性名转换。重新顶层生成、功能、新综合/route分别验证；未签核。

## R73b实际物理失败与R74后继

R73b输入5543e747，新生成CSR映射PASS，新综合COMPLETE WNS/TNS=-1.953/-648.235ns；actual route COMPLETE但STA FAIL -1.257/-869.526ns、2041 setup端点，WHS/THS+.014/0、WPWS1.500。最差fabric反馈→两个DSP+三LUT→输出CE，8.993ns（6.259逻辑/2.734布线）。REJECTED_NOT_MERGED。定向功能PASS，fresh完整功能仍在原独立trial运行，未提前写PASS。完整物理/DCP/输入SHA及只读审计在experiments/r73b_rejected_physical_20261112。

R74采用docs/R74_IIR_SATURATION_RETIME.md的逐拍状态等价重排，替代原输出边沿，新增反馈整数周期0；只有fast A/B启用，raw/PS7/引脚/PLL/CSR/现有AXI与CDC修复保持。先14/25位逐拍及整链测试，未取得实际报告前不预判时序。DAC/PCB/CDC/DRC尚未整体签核，无可部署bitstream。

## R74已执行定向功能PASS

14/25位一/二/五阶107706拍严格差分+独立整数模型PASS，b0/bN脉冲延迟分别保持order+1和2*order+1；全FastChain32000拍PASS（31976已知/21317写/24000 CE保持）。clear/hold/复位/饱和/部分CSR写全部逐拍比较，未允许多一拍误差。完整原件/SHA在experiments/r74_native_equivalence_20261112。新生成/综合/route尚待，完整功能暂未重跑，最终STA未签核。
