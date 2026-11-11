# R48：已布线R47之上的局部post-route优化

输入R47 d839e67/5fd2991，route−.282/−5.173ns、70端点、WHS.015/THS0/WPWS1.5，最终STA FAIL。完整原生功能来自R46 827dfec/b7b94f3，R47实际重复18个CEB2驱动LUT函数核对/94DSP参数与原始SHA不变；R47选择发生在unroute后按估算slack，最终指标为真实route，不混淆。

1. 只读入R47 routed.dcp，保留现有路由为post-route优化起点，不重新综合或源架构修改，全部原始硬件测试SHA相同。
2. phys_opt_design显式placement_opt/routing_opt/rewire/critical_cell_opt/critical_pin_opt/tns_cleanup，只请求这些选项；本机2020.1 help说明显式选项关闭其他默认优化，关键引脚交换用于LUT快引脚。
3. 不clock_opt、不retime、不DSP/BRAM寄存器优化、不插负沿FF，不改PLL/周期/XDC/例外；不携入R45 IIR重定时，新增任何反馈/CSR/采样周期0。
4. 物理优化后实际route Explore/tns_cleanup，保存postopt及route时序/利用率、DCP、CDC/DRC/coverage与源码SHA；94DSP真实参数独立与R47对照，LUT/FF实际变更与hold同时审查。
5. 功能及综合明确REUSED_R46_VIA_R47_NOT_RERUN，不冒称本轮重跑或postroute形式等价/物理CDC证明；工具若不支持post-route critical_pin_opt则保留原报错/源码，另新目录以兼容选项继续，不覆盖失败。
6. 只据同8ns真实route WNS/TNS/端点及功能/hold/CDC等判断，不合并保护基线/不上板，不以仅某项裕度为正宣称最终签核。
