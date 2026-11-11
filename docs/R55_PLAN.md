# R55：仅两条CORDIC数据网络的约束感知局部重布线

直接输入R53 e25e8f0/5886146，route-.014/-.052ns、6端点，WHS.014/THS0/WPWS1.5，最终STA FAIL。R54关键输入换脚0对象+重复局部物理优化无收益，结果同R53，拒绝。当前最差倍率CSR bit1→CORDIC17，首段Q网fo28/1.057ns；其后的zi[14]网fo43/.852ns，两者均原始真实负路径，不能只根据名字猜根因。

1. 原始90硬件测试SHA同R53，功能/综合REUSED_R52_VIA_R53_NOT_RERUN。只读R53 routed.dcp，全逻辑/FF/94DSP/CSR/XDC/输入SHA保持，新采样及ADC→DAC延迟0周期，不携入失败R50/R51架构。
2. 本机Vivado2020.1 help确认 -unroute -nets 仅拆指定网络；-auto_delay -nets基于现有setup/hold做约束驱动局部布线，推荐<100网。本轮明确使用auto_delay，不用忽略时序约束的普通-nets快速路由或-delay；不设置任何-max_delay/-min_delay边界，不改变8ns/XDC/例外。
3. 只选择精确multiplier_storage[1]与zi[14]两网，逐一核对唯一驱动、>=20负载、非FIXED_ROUTE且位于当前真实routed负路径；记录驱动及完整leaf负载集合。每次仅该网unroute→auto_delay，两个中间报告分开，最后真实route TNS cleanup与完整STA/hold/pulse/route合法性/CDC/DRC/coverage。
4. 不phys_opt、不复制FF、不retime/clock/DSP/BRAM寄存器优化/新pblock。只改变走线，不插逻辑或串行边沿；94DSP对R53、目标网驱动/负载集合及源DCP SHA完整核对。原始RTL功能复用不代表fullRoot postroute/SDF/形式或物理CDC/板端证明。
5. 工具若不支持或不能改变目标路由，保留原错误/源/报告，不把中间0估算当最终成功。最终受约束setup需WNS>=0/TNS0/负端点0同时；仍需独立关闭DNA/外部I/O/物理CDC/DRC，禁止签核或部署声明。R53原检查点保持，失败直接不采用。
