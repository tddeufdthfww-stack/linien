# R13 下一轮方案：慢 PID 两级事务流水线

2026-11-10。R12已完成route且WNS恶化，失败独立保留。本候选从R4a创建独立分支，不修改R4a/R2b/原用户源码。

至少两种架构比较：

| 架构 | 新增延迟 | 主要作用 | 主要不足 |
|---|---:|---|---|
| A：仅积分乘积后一级，P/D和复位/有效令牌对齐 | 8 ns | 将乘法与积分累加/饱和分开 | 误差选择/减法与乘法仍同周期；需重写并验证P/D与配置对齐，不能只给I插寄存器 |
| B：误差与同拍系数一级、三个乘积一级，沿用R4快PID已验证结构 | 16 ns | 把误差生成、乘法、积分递推分开；已有14/25位内核差分证据可复用 | 慢速外部限幅、CE、上下限CSR、输出通道路由和analog0扫频贡献必须整体延迟2个sys周期 |

推荐B：当前慢PID前端严重违规，仅乘积一级不能保证误差→乘法满足8ns。该方案不增加积分状态反馈寄存器，积分仍每个有效采样更新一次；valid延迟两sys拍而非两次慢CE事件，动态分频/连续CE不降吞吐。使用旧PID作用于输入、running、所有系数/setpoint/reset和CE统一延迟2拍的数学参考，验证状态递推。

## 精确对齐与接口

- 新slow_pipeline.py：PipelinedSlowChain复用PipelinedPID(width默认14)，保持SlowChain接口和信号监视名字。AlignedSlowLimitCSR保留原min/max读写ABI和复位，但min/max配置快照延迟2拍，其数据CE来自pid.execute_en。
- SlowOutputTransport：slow_control_channel延迟2拍给快DAC的慢贡献；analog0扫频+offset贡献整体延迟2拍，与慢PID输出同一时间线后进入慢限幅。快速DAC的快速PID/扫频/调制贡献不延迟。
- linien_module.py：仅生产SlowChain选择新类、增加上述slow transport连接，模拟通道/快慢混合的对应selector使用对齐版本。原PS、ADC/DAC引脚、时钟、AXI/CDC、原pid.py不改。
- CSR写一直活跃；reset CSR随有效样本排队，全局reset立即清空在途有效位和输出状态。跨复位不宣称纯波形平移。分字节写与热改配置保留。
- 慢限幅已有上下限寄存器本身仍保留原相对时序；不能把新的shadow直接用作组合bounds从而省掉旧边沿。

## 延迟与控制影响

相对R4a：快速PID主支路新增0；慢PID/慢贡献新增2sys=16ns；analog0扫频支路也新增16ns。相对R2b：经过R4a快PID再进入慢回路的特定支路累计新增32ns。不能把混合输出各支路不同延迟写成整个输出统一平移。

新增16ns纯延迟在10/30/100kHz和1MHz分别增加0.0576/0.1728/0.576/5.76度相位滞后。PZT慢反馈预计低频补偿，但实际交越/相位裕度仍未知；不得把计算当成Cs锁频性能实测。积分不改变反馈状态递推阶数；误差样本和配置统一对齐，吞吐仍每sys可接受1样本。

## 执行门槛和证据

先独立生成Verilog，以冻结旧SlowChain/原PID和旧LimitCSR为参考，在延迟2拍的原始输入及实际CSR配置上逐拍比较PID9字段、限幅数据/railed、模拟输出及通道贡献；真实CSRBank读写、CE=0热写、动态0–31分频、连续/稀疏CE、饱和边界/复位/锁运行。另测对齐前后的原始事件时间线，避免把候选同样的错误复制进参考。

完整已有功能套件、CSR map/XDC字节、综合、实际route、slow /D/R/S/CE和DSP全部时序、CDC差集。WNS恶化保留失败而不合并。时序目标125MHz不变，不增加掩盖问题的例外。
