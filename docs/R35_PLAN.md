# R35：只复制高扇出指令索引驱动，不增加流水级

R34功能PASS、综合COMPLETE、route COMPLETE，但WNS/TNS−.845/−146.894ns、575端点，拒绝合并；R29最佳WNS−.617不变。R34原生63366拍GPIO契约与完整PID/IIR/Scope/AXI/CDC通过。新分支保留R34源代码/DCP不改，仅研究是否能改善其已拆分GPIO的物理实现；不能称R34已正式保留。

1. 逐文件核对R34所有gateware/tools原始SHA（新driver为额外文件），功能与综合明确REUSED_R34_NOT_RERUN，不伪造新功能PASS。
2. 只在内存中打开R34 routed.dcp，用route_design -unroute回到post-place，再对已有current_instruction_idx FD的Q网中>=64 loads者force_replication_on_nets；记录具体对象、扇出及复制前后DCP。避免Vivado2020.1已知不支持的post-route fanout_opt。
3. 明确选择placement/rewire/critical_cell，不启用retime/clock_opt/DSP/BRAM register/负沿FF优化；完整route Explore/tns_cleanup及同8ns约束报告。
4. 检查真实D/S/R/CE、GPIO快照与输出、IIR、PID outgoing，比较WNS/TNS/端点/hold/pulse/CDC/覆盖/DRC，并核对全部DSP寄存器属性与输入DCP SHA不变。失败保留、不合并。

数学/周期依据：物理复制已有FF，复制体必须继承原D/CLK/CE/S/R/INIT及同步边沿，归纳得到每拍Qcopy=Qoriginal，只有组合负载划分/位置改变，不是增加串行寄存器。工具报告和映射核对用于确认实际做了什么；这不是额外的postroute/SDF形式等价证明。R34原有外部状态GPIO/LED额外8ns仍在，ADC→DAC/PID/robust FSM本轮额外0。直接软件outs/OE不改，外部回接未测；不能称整机零延迟。

路径依据：R34 idx[1]_rep3/C→waited_for[6]/R，8级/2CARRY4/1MUXF7，logic2.430ns+route5.772ns；索引Q单网100 loads/1.541ns，后级mux输出还有1.228ns布线。经过峰值阈值选择/比较、state[12]=robustover_threshold与原FSM清零条件，不是依据终点名字猜测。强制复制会增加源D/CE/复位负载和FF面积，可能改善该网却恶化前驱；只按实际route选择，不能按扇出下降认定时序成功。

最终STA、bundled-data CDC物理安全、DNA/I/O约束、DRC、板上和激光/PZT操作均不在本轮宣称已完成。没有改约束或添加时序例外。
