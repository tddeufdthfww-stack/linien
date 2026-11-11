# R53：R52零新增采样周期的布线后物理优化

输入R52 7eb4ed9/61da23a/e5cdf33，完整新原生功能PASS；综合-.773/-60.316ns、259端点；实际默认route-.222/-6.177ns、73端点，WHS.014/THS0/WPWS1.5，最终STA FAIL。直接RTL对照R46默认-.539/-18.344ns、131端点，最佳单独物理R48-.179/-4.904ns、70端点。raw IIR内部+.203ns、DSP+单LUT共2级；FastB仍-.100ns，全局变成IIR输出FF→tap限幅→混合器输入FF，3.180logic+4.579route。

1. 全部89个原始硬件/测试SHA同R52，功能和综合REUSED_R52_NOT_RERUN；读真实R52 routed.dcp，不重写源码或重新综合，已有R52实际DSP映射就是本轮核对基准。
2. 只执行已在2020.1 post-route验证可用的placement_opt/routing_opt/rewire/critical_cell_opt四项，再真实route TNS cleanup。若fully routed时Explore被忽略就明确记录，不宣称新从零全局布线。
3. 不retime/clock_opt/DSP或BRAM寄存器优化，不unroute、新pblock/时序例外/放宽周期，原IIR/PID控制和ADC→DAC新增采样周期0；94DSP属性(忽略LOC/BEL)须对R52逐项检查。
4. 保存postopt和final实际setup/hold/pulse/coverage/CDC/DRC/资源及输入DCP/源码SHA，独立只读所有IIR/PID引脚和外部consumer。RTL原生PASS不等于postroute/SDF/形式或物理CDC证明。
5. 以WNS/TNS/违规端点/hold和功能证据同时比较直接R52与最佳R48；失败保留不合并保护基线，不部署。R52相对R48的两项PREG差异已记录，不冒称此前94映射全同；本轮新物理变更必须单独审计。
