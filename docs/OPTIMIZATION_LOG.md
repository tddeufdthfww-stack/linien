> **2026-11-10 R27最新结果**：REJECTED / 不合并R4a，route WNS/TNS=-1.042/-229.718ns，最终STA FAIL。详细归档见本文末尾。

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


## R27 / 2026-11-10归档 / mixer时序候选试验

- **REJECTED / 不合并R4a**。代码提交 `cffb1f283f0ebd138bea4b932937c02ff846988f`，独立工作树 `D:\RP_Dev\linien_trials\20261110-r27-fast-output-csa`；R4a/R2b/原用户工程保持原样。
- 功能：原生UNISIM/真实CSR两拍联合帧14/25位44290/44292拍、512/512系数/独立CE/复位/模式/饱和/完整37位整数oracle PASS；14/25 IIR配置帧与冻结RTL/28与50位整数oracle PASS（从未延迟输入到b0/b5=8/13拍，滤波器latency CSR仍6）；完整旧功能回归PASS。R19指定Bare/快慢串接组件数字模型正负脉冲确认72.1/108.1ns，较R16追加16ns；后续版本继承同组件契约，未重跑该组件模型，IIR周期由完整滤波器测试独立验证；并行tap限幅14/25位原生RTL/旧LimitCSR/独立整数oracle、全部tap与符号/非法上下限/回绕/真实CSR/CE/reset PASS；完整FastChain pair 30000拍、CSR字节映射、I/Q/原寄存器前信号/独立CE PASS（精确周期与统计见trial/parallel_tap_checks/results.json和fastchain/results.json）；包含公共求和优先及反相比较并行的数学变换，额外覆盖N位最小负数回绕及邻值；FastChain pair比较旧split_c48+串行tap与生产registered_c48+新tap组合，显式UNISIM/glbl；原生时钟MAC71760组及IIR order1/2/5/CSR/hold/clear/复位再次PASS；R23/R24生产类型缺陷已明确修复：先测试专用cba82d1真实unsigned CSR复现第45拍FAIL，再生产759cba4显式同宽signed解释；同一夹具原样30000拍PASS（负偏置15053），完整common中间值14/25位30106/30134拍与原FF及整数oracle PASS，实际Root signed14声明/RHS核对PASS。新增robust谓词90800已知+8000未知、父模块50076（55未知）严格四态PASS；覆盖不等于完整PS7/板级Root或物理签核；实际Scope helper/冻结原case/整数oracle161872组、32有效因子、低16位穷举65536及3000 X/Z PASS；完整双Scope+真实桥sys100/ADC125功能异步、配置/四路数据/触发/BRAM/接口逐拍四态PASS，Scope新增周期0（本轮精确统计以trial/scope_average_checks日志为准）；Root五项求和CSA与冻结原表达式、独立完整N位整数oracle14/25位41371/42011拍PASS，64种路由组合/非法2–3、真实unsigned CSR部分写/符号影子FF、原Root限幅输入FF、实际LimitCSR/独立限幅及CE/reset状态模型PASS；新增反馈周期0，精确本轮统计见fast_output_checks/results.json；没有修改Migen evaluator。
- 原8项pytest、CE/饱和/流水线/真实CSR、AXI/CDC/四相位既有回归PASS；CSR map与XDC保持R4a一致。延迟=相对R16快速/Bare及处理误差流新增2sys=16ns，快速相对R2b累计32ns；既有慢PID16ns保留，特定快→慢串接相对R4a额外32ns、相对R2b累计48ns；robust自身判定仍8ns；R20之后IIR/tap/common/阈值/Scope组合优化均新增周期0。
- 综合（R15为REUSED_R14，其他为本轮COMPLETE），WNS/TNS=-1.908/-301.989ns。实际route COMPLETE，WNS/TNS=-1.042/-229.718ns，失败端点795；WHS/WPWS=0.018/1.5ns，THS=0。
- raw IIR内部最差=-0.271ns，入口=-0.153ns；全局最差 `linienmodule_autolock_pipelinedrobustautolock_magnitude5_reg[8]/C` → `linienmodule_gpio_n_o_reg[7]/D`，逻辑/布线=['2.999', '5.637']ns。
- 决策=REJECTED_NOT_MERGED；最终STA FAIL，不能上板验收。资源={'lut': 15281, 'ff': 15762, 'dsp': 94, 'bram': 35, 'bufg': 6}；覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC总数=410。
- CDC={'CDC-1': 430, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，严格名称差集新增374/移除380；数量变化不是物理安全证明。DNA/外部I/O覆盖和DRC未签核，未新增掩盖问题的例外或放宽时钟。
- 构建期间source_changes_during_run=[]；记录前输入哈希差异=[]。构建manifest采样HEAD与代码提交可能不同，具体源码以manifest逐文件SHA为准，原生日志保留。
- 全部报告、输入SHA、源码副本及XSim向量见 `experiments/r27_mixer_20261110/`。无bitstream生成/部署，无板上/激光操作。按用户授权自动继续下一项有依据的独立候选。
