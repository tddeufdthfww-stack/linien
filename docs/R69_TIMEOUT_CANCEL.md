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
