# R49：R48 布线后关键 LUT 引脚优化

输入 R48 b0824e3/76dd452，实际 route WNS/TNS=-0.179/-4.904ns，70 违规端点，WHS=0.015ns，最终 STA FAIL。
1. 只读取 R48 routed.dcp，在独立分支执行 phys_opt_design -critical_pin_opt，随后真实 route TNS cleanup。
2. LUT 输入换脚在同步边界内只重映射同一布尔函数，不增加寄存器或延迟周期。没有 RTL、CSR、时钟、约束或 DSP 寄存器修改；并非已完成形式等价证明。
3. 本轮功能和综合明确复用原始 SHA 完全一致的 R46 经 R47/R48 证据，NOT RERUN；新做实际物理/route/STA/CDC/DRC/结构审计。
4. 原始输入 SHA、DCP、94 DSP 参数和全部寄存器属性、top.v/XDC/CSR 不变逐项核对；工具是否支持与是否实际有换脚分开记录。
5. 若失败或恶化保留源码与全部原始日志，不修改 R48/R2b/R4a 或用户工程；不新增 false/multicycle/clock group 例外，不降频，不部署。
