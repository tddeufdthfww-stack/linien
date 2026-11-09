# 优化记录

## 2026-11-06 / 基线归档

- 原工程：`D:\RP_Dev\linien-v2.1.0`，保持原工作树不动。
- GitHub 备份：`backup/20261106-pre-optimization`，提交 `a39000a802c27e0b6a904491ced4adaaceadfa35`。
- 包含当前有效源码、测试、移植文档、CE 候选、历史关键报告、PS BD/wrapper 与源码 SHA256 清单。
- 优化分支：`opt/ce-saturation-20261106`；全部候选均在独立副本进行。
- 基线状态：有历史功能/综合/route 证据，最终 STA 未签核。

## 2026-11-09 / R0 隔离构建与回归准备

- 状态：RUNNING，未宣称测试或时序通过。
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

- 状态：RUNNING，尚未宣称候选综合/route/STA 通过。
- `gateware/logic/decimation.py`、`pid.py`、`limit.py`、`chains.py`、`linien_module.py`：从已保存候选引入固定 125 MHz、仅数据寄存器 CE 的实现；CSRStorage 写入逻辑保持常时钟运行。
- 与历史候选的明确差异：已从 Migen 0.9.2 的 ArrayProxy/Case.makedefault 证明旧动态数组越界使用最后一项。新 CE 因此保留 16..31 等效第15档，不采用历史候选的非法值停更行为；修正 k=0 相位注释为模型记录的 +4 ns。
- 新增 `gateware/tests/timing/tb_ce_saturation.py`：14/25位 PID 差分、精确饱和边界、CE/reset、真实高分频事件、非法索引/动态配置、LimitCSR 差分、CE=0真实CSR总线读写。
- `experiments/baseline_20261106/{pid,limit}_reference.py`：直接取备份提交中未修改源码，供差分参考，不改变 DUT。
- 未新增反馈流水级；CE 全局复位会重启计数相位，动态切换/复位后的行为不宣称与原逻辑时钟逐边沿等价。
- 测试开发中修正了参考端初始化和调度：Migen 0.9.2 使用 CEInserter；参考 CE 初值与 DUT 的 update_en=1 一致；复位模型按发生沿已采样的 reset 更新，并逐周期断言计数器/started。没有删除错误断言或改动硬件来适配测试。
- 完整验证目录：`gateware/build/trials/20261109_094155_ce`。7 项 pytest、CE_SATURATION_SUITE_PASS、既有 XSim 及四相位用例全部通过；CSR map 完全一致；综合和 route 完成。
- 综合 WNS/TNS=-5.966/-4345.464 ns；routed WNS/TNS=-5.972/-11109.872 ns、Setup失败端点7357、WHS=0.018 ns、WPWS=1.500 ns；no_clock=1、未约束内部端点=2。
- 当前最差路径是快速PID setpoint→int_reg[42]/D，13.911 ns，19个CARRY4+1个DSP。相对原版更差，不能称 CE 已经解决性能；其主要收益仍是时钟安全架构和时序覆盖。状态 CANDIDATE / PASS-FUNCTIONAL / SYNTH_COMPLETE / ROUTE_COMPLETE / STA_FAIL，未并入原工程。
