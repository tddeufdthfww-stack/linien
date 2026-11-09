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
