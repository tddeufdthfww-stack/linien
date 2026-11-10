# R34：只给外部状态GPIO/LED增加1sys，ADC/PID/FSM新增0

从R29保留硬件（R28 9c5c32a）独立分支；不携带R30/R31/R33失败查表结构。R33功能/一热不变式PASS但route−1.297/−244.445、1022端点，source OH1→GPIO1、logic2.501+route6.582。R29最佳WNS−.617，R32 TNS较低−67.215但WNS−.691。现有GPIO汇聚路径仍未满足8ns，不靠false/multicycle或降频掩盖。

## 两种流水架构与选择

|方案|结构|ADC→DAC/内部PID/robust FSM|外部状态GPIO/LED|新增RTL位|
|---|---|---|---|---|
|A（本轮）|状态V和各GPIO使能E同拍快照，再原有AND/OR输出FF|新增0sys|新增1sys=8ns|V14+8×E14=126，工具可能合并/复制|
|B（仅评估）|同拍V/E快照，4位分组OR寄存器，再末级OR输出FF|新增0sys|新增2sys=16ns|126+8×4=158|

方案A第一段只捕获复杂自动锁定/查表结果，移除后级GPIO汇聚树；第二段只做14位掩码及归并，原输出FF保留以保持无组合毛刺的输出。方案B进一步拆分归并，但额外16ns，没有证据当前需要，故不实施。A/B都不属于ADC连续反馈数据流水；不能因此称整机零延迟。

内部error采样、P/I/D对齐、积分更新、slow CE、lock_running、state_in及signal_in时序均不变，state/status CSR仍用原即时V。源码确认gpio_n.o在Root只驱动外部GPIO和LED，内部scope GPIO触发来自gpio_p.i[0]而非此输出。若用户有板外回接/触发/使能线路，仍会看到8/16ns差异；此类外部关系尚未实测，不宣称没有系统影响。

若外部GPIO参与反馈，纯延迟相位A在100kHz/1MHz为0.288°/2.88°，B为0.576°/5.76°；10–30kHz起调分别为0.0288–0.0864°/0.0576–0.1728°。这不是实测环路稳定裕度。内部ADC→DAC的该项相位增量0，原R4a/R19/R28数字组件周期契约保持；GPIO用于外部同步或调制参考时需重新校准相应边沿/相位。

## 精确时序契约与数学依据

旧O_i[t+1]=reduceOR(V[t] AND E_i[t])。新V1[t+1]=V[t]、E1_i[t+1]=E_i[t]，Onew_i[t+1]=reduceOR(V1[t] AND E1_i[t])，故Onew_i[t+2]=Oold_i[t+1]，任意热写/部分写/数据序列下严格多1sys。必须同时采样E，不能只延迟V后混用新E。global reset清空V1/E1/O并取消在途状态，与独立延迟参考保持。每拍吞吐不降，状态脉冲宽度/顺序保持，最终输出仍FF。

cross_connect参数默认0保留原通用行为；仅Root调用设置1。gpio.state/status/state_clr、全部内部state_in/signal_in、直接软件outs/OE和GPIO输入同步不改。外部状态GPIO与直接outs OR叠加时，只有状态分支延迟，不能把整个pad波形简单说成旧pad延后1拍。CSR地址、5个公开状态名/位号不变。

## 验证与风险

真实cross_connect+真实CSRBank、冻结R28函数、旧GPIO独立1sys参考与Python完整状态/掩码oracle；随机/极值、单拍脉冲/连续脉冲、所有14状态与8输出、enable部分写/读回/复位/CLR、内部控制与信号选择同拍比较、严格X/Z。源V与E快照必须正确同cohort。原完整PID/IIR/AXI/CDC/Scope/CSRmap/XDC回归、独立综合/route与新snapshot D/S/R/CE路径检查。风险是意图明确的外部状态8ns延迟、快照使能配置布线、新FF负载及工具是否保持预期边界；源增126位不等于新增126个实际物理FF，记录真实映射。

R34仅候选，不直接合并或上板；即使内部STA转正，CDC/DNA/I/O/DRC仍需独立签核。无原工程/保护基线修改，无板上/激光操作。
