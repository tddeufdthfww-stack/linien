# R56：真实负路径起点寄存器同拍分发

输入最佳R53 e25e8f0/5886146，-.014/-.052ns、6端点，WHS.014/THS0/WPWS1.5，仍最终STA FAIL。R54输入换脚0对象/重复局部无收益；R55两网auto_delay最终-1.349/-19.090ns、32端点退步，均隔离拒绝，不作为本轮输入。继续R52 C48 carry fold原输出FF结构，原始90硬件测试SHA同R53，功能和综合REUSED_R52_VIA_R53_NOT_RERUN。

1. **在任何unroute之前**枚举真实routed负路径，选择起点普通FDRE、ADC clk_2、非ASYNC_REG/非DONT_TOUCH、Q负载>=4，按完整状态输入签名去重，不只凭名称或未布线估计选择；记录源/实际slack/负载/排除原因。
2. 数学依据：FDRE状态q'=R?0:(CE?D:q)。原始和副本类型、INIT以及D/C/CE/R完全相同，则由初态及逐拍归纳在所有已知控制序列、包括复位/CE暂停/CSR部分写时输出相同；重新分配Q负载不新增串行边沿。不能把该数字结构依据当作模拟亚稳态/物理CDC证明。
3. 只unroute选中Q网后force_replication_on_nets；若工具仍判定post-route而不支持，则保留入口错误与源码/日志，在新目录通过显式--unroute-all兼容模式使用已验证全unroute流程，不重复未改命令。模式与源DCP SHA分别记录。不得覆盖原R53。
4. 逐组D/C/CE/R/INIT/ASYNC_REG/DONT_TOUCH及完整leaf负载集合审计，必须确实有匹配副本且负载无丢失/无重复。随后仅route Explore -preserve -tns_cleanup，尽量保留其他完整路由；不再运行其他物理优化以便完整连接审计，不retime/clock/DSP/BRAM寄存器优化或新增pblock/时序例外。
5. 全部94DSP与R53参数核对、实际FF数量增量与匹配副本数核对，记录source/top/CSR/XDC/DCP SHA和完整setup/hold/pulse/route/CDC/DRC/coverage。新增ADC/反馈/CSR采样周期0，CSR写操作没有CE冻结。时钟/器件/引脚/算法/精度/阶数/吞吐不改，失败保留不合并/不部署。


## R56部分unroute兼容中止

ae4f9a8默认只拆4条选中Q网后，工具仍以post-route执行，force_replication_on_nets在入口被Vivado_Tcl4-265拒绝；实际复制和新route均NOT RUN。原真实routed选择/源码/日志/manifest和纠正说明保存experiments/r56_partial_unroute_setup_failure_20261111。按既有CLI --unroute-all在全新目录改运行模式；先从原routed报告选4个来源，再全拆线，避免选择未布线估计负slack。该兼容模式不保留原全部走线，-preserve仅对执行时已完成的走线有效；原R53 DCP/源码保持。
