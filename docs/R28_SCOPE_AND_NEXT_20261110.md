# R28实际范围、剩余路径和下一轮


## 2026-11-10 / R28当前候选、范围更正与下一步

R28代码9c5c32a，功能PASS、综合COMPLETE、实际route COMPLETE、最终STA FAIL。WNS/TNS−.788/−99.471ns、566违规端点、WHS.014/THS0/WPWS1.5。相对R26 WNS改善.122ns、TNS改善91.251ns、端点减少185；相对R25 WNS改善.193ns、TNS改善74.580ns、端点减少77。保留为未签核候选，不合并基线、不上板。

**修改范围更正**：PipelinedSlowChain也共享PipelinedPID，故本轮快25/慢14两处输出饱和组合逻辑都替换。先前“只快PID/慢PID未变”说明不准确。原sum同步语句AST和base PID一致；pid.py/slow_pipeline.py/feedback_pipeline.py/Root文件与R26 blob一致。两处只是组合钳位变换，积分/CE/复位/CSR/串行流水级不变。实际Root快83:24、慢50:13高位解码核对PASS；慢链413022拍/32分频/4171提交PASS。原始输入计划已归档，更正发生在构建结束后，不改历史manifest。

快速PID to-group /D+.826、/S+.217、/R+.979、/CE+.801ns；slow PID本体CSR/非CSR负端点0。PID outgoing仍−.204ns，PIDsum[30]/C→limit_fast2.x[17]/D，13级/6CARRY4、logic3.061+route5.146ns；不能因为PID内部正裕量就称整条快通路通过。R26相应路径−.910ns/20级14CARRY4，证明本轮减少了饱和长进位链，但仍有后级求和/布线残余。

全局autolock current_instruction_idx[1]rep3/C→gpio_n_o[6]replica/D，9级、logic2.430+route6.172ns（约72%布线）。FastChain A/B输出路径−.637/−.442ns；raw内部−.177ns（DSP/CLK→DSP/CEB2）和外部入口−.212ns，必须继续区分数据与CE控制。Scope平均控制+2.344ns。下一轮优先同网表post-route critical-cell/fanout/placement/routing优化，新增串行周期0；若失败保留、不合并，再考虑有真实pre-D/同cohort/复位证明的DSP输入寄存器复制。

R28已重新执行当前生产PID/Analog/ODDR指定数字组件模型：±123脉冲Bare72.1ns/9sys、DAC写74.1ns；快慢串接108.1ns/13sys、写110.1ns。R28新增周期0。这不是完整Root/SDF/板端/转换器/模拟延迟，更不是实测闭环带宽。

CDC441/14/4/1/10=1/13=1/15=374，严格名称差集新增380/移除375，仅数量变化不证明物理安全。DNA no_clock1/内部2、44输入/46输出无外部延迟覆盖和DRC413仍未关闭；原8ns约束/XDC保持，未添加掩盖违例的例外。

R27 Root CSA代码cffb1f2/记录e9c9fd5已失败归档、未携入R28。R2b/R4a/R16/原用户工程的源码/head/status再次核验不变。R28上传GitHub目前因TCP443连接失败/连接重置待完成，本地提交/源码和SHA证据完整；不把失败推送标为成功。
