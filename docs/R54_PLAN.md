# R54：最后六条负裕量路径的引脚及局部物理优化

输入R53 e25e8f0/5886146，route-.014/-.052ns、6端点，WHS.014/THS0/WPWS1.5，最终STA FAIL。FastB multiplier配置FF→CORDIC17 D最差-.014/- .012，另四条common/IIR→tap/混合器输入为-.009/-.008/-.008/-.001。raw IIR内部+.203ns；R53全部94DSP属性同真实输入R52，功能及综合复用R52而非重跑。

1. 原始90硬件测试SHA同R53，从独立分支读R53 routed.dcp；RTL/系数/时钟/CSR/8ns约束均不改，新增ADC/反馈/CSR采样周期0，完整功能/综合REUSED_R52_VIA_R53_NOT_RERUN。
2. 单独critical_pin_opt，只请求合法的LUT快引脚交换，保存pinonly时序及真实优化对象数量；原R49对旧架构无收益，不将其当作本轮结果，也不预认定一定发生引脚交换。
3. 再兼容post-route placement/routing/rewire/critical-cell四项，保存postopt，再实际route TNS cleanup；fully-routed下Explore被忽略要记录。不phys_tns_cleanup/unroute/retime/clock_opt/DSP或BRAM寄存器优化/新pblock/时序例外。
4. source/DCP SHA、全部94DSP参数对R53核验；新完整STA/hold/pulse/CDC/DRC/coverage。受约束路径setup通过需WNS>=0、TNS0、负端点0三项同时，哪怕-0.001仍FAIL；即使setup通过也不能代替DNA/I/O/物理CDC/DRC最终签核。
5. 若恶化保留完整失败源/报告，不合并保护基线、不部署；以R53三项基准比较，记录每阶段而非只挑最佳中间数。
