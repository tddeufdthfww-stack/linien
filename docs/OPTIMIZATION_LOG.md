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


## 2026-11-09 / R3 快速PID前端零新增延迟试验

- **REJECTED / 不合并R2b**。基线R2b `4efa38fda4b4c315b744443a537e9d398843cbad` 保持不变；R3代码提交 `d57c0e2ada0dd57f72d29f1c380a444c323128dd`，独立分支 `opt/r3-fast-front-20261109`，目录 `D:\RP_Dev\linien_trials\20261109-r3-fast-front`。原工程168文件SHA核查无变化，R2b工作树干净。
- 先只读打开R2b routed DCP，复现快速/D=-5.605、慢速/D=-5.242、/S=-5.414ns；慢积分/R接const0无计时路径，整个慢PID/R=+3.533ns；慢积分CE=+0.258ns，但整个慢PID CSR/CE=-0.422ns、快速CSR/CE=-1.660ns。完整起终点、级数、DSP/CARRY/LUT及logic/route见 `docs/R3_RESULT_20261109.md`。
- 数学论证先记录于 `docs/R3_PLAN.md`，只试6位分块借位lookahead/carry-select误差减法。快速实例开启，生产慢实例默认关闭；保留signed输入/unsigned setpoint的w+1位模截断、乘法/右移/饱和、reset/CE/CSR及P/I/D原有寄存器。新增反馈/采样流水级 **0**，新增延迟 **0ns**。
- **功能PASS**：7项pytest、14/25位1600周期逐状态差分与U/L边界、reset/CE、两种位宽真实CSRBank读写、完整divider/Limit回归、65536对缩小位宽借位穷举、14/25位5196/5361组误差oracle（各测running=0/1）、AXI/CDC/integration和四相位XSim。CSR map语义一致；XDC SHA256与R2b相同。
- **综合COMPLETE / 综合STA FAIL**：R3 WNS/TNS=-9.226/-4855.070ns；R2b=-6.094/-4563.029ns。
- **route COMPLETE / 最终Setup FAIL**：R3 WNS/TNS=-8.510/-13011.209ns、违规端点7407；R2b=-5.605/-10473.525ns、6813。WNS恶化2.905ns、TNS恶化2537.684ns、端点增加594，拒绝采用。
- routed Hold/Pulse在当前约束下PASS：WHS=+0.029、WPWS=+1.500ns；0 hold/pulse失败端点。23734条可路由网全部完成、routing errors=0。这不替代最终时序/CDC/I/O签核。
- R3快速最差从pid_only_mode/C到int_reg[10]/D，16.410ns=logic8.031+route8.379，19级（CARRY4=9、DSP=1、LUT2=2、LUT4=1、LUT5=2、LUT6=4）。相对R2b各自最差路径，carry减少但布线增加3.149ns；不能以级数减少推断改善。
- 未改慢PID算法，但综合映射由FDSE/S变为FDRE/R；R3慢/R=-7.177、/D=-5.737、整个慢PID/CE=-0.779ns。积分子集CE=+1.043ns不能代替整组检查；快/慢反馈路径+1.168/+0.523ns。
- no_clock=1、内部未约束端点=2、I/O缺口44/46仍在。CDC-1=444→447，其他14/4/1/2/374不变；详表差集新增10/移除7，均为既有bridge地址/写数据到CSR接收副本。**物理CDC安全未证明**，默认DRC241→238也不是签核。
- 失败源码SHA256：`bac09aa84963259fbf6b5bcdab050ea57bb4aed8f5f42ff0719ad2518004d909`；全输入SHA、top.v/XDC/DCP哈希、所有命令/退出码/PASS标记、实际报告及失败诊断脚本日志归档于 `experiments/r3_fast_front_20261109`。本地DCP未提交Git；测试产物目录 `20261109_104835_r3_error_select`。
- 首两次只读工具附加cell审计因Vivado属性API不支持而FAIL，第三次修正后PASS；最终通用工具分别在R2b/R3 DCP上PASS，DCP输入SHA未变化。工具FAIL不混记为设计功能失败或通过。
- 下一步保持R2b为冻结起点，停止本carry-select路线；单次失败不证明零延迟空间完全耗尽。若分段预算确认需要流水线，先评估A误差快照1级/8ns、B误差+乘积2级/16ns，保持积分反馈递推并对齐P/I/D、增益、running/reset/valid与稀疏CE；激光环路相位/稳定性预算见完整报告。**本轮两方案均NOT IMPLEMENTED**。
- 没有新增false/multicycle/clock-group/放宽周期，没有生成/部署bitstream，没有板上或激光闭环测试。R2b和R3都不是可上板正式版本。


R3变更清单：
- `gateware/logic/pid.py`：可选组合分块减法，不增加寄存器；失败候选保留在隔离分支。
- `gateware/linien_module.py`：仅快速PID启用error_chunks；`chains.py`和生产慢PID配置不变。
- `gateware/tests/timing/tb_r3_error.py`：独立整数误差oracle及借位穷举；`tb_ce_saturation.py`覆盖参数化14/25位及真实CSR。
- `tools/run_gateware_trial.py`：在完整功能阶段增加R3误差测试；`tools/report_r3_pid.tcl`：新目录只读诊断整个PID与积分子集各引脚、反馈、DSP和末级LUT连接。
- `docs/R3_PLAN.md`：修改前数学证明；`docs/R3_RESULT_20261109.md`、状态/本记录：实测结果、零延迟失败原因与8/16ns后续架构评估。
- `experiments/r3_fast_front_20261109`：失败源码、完整输入SHA、CDC差集、日志/报告ZIP与ZIP SHA256。代码提交和文档归档提交分开，基线不变。
