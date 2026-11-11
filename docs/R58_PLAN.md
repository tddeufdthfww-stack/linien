# R58：R57剩余关键路径的两负载局部路线

R57代码6a7705d，结果f64fad2；实际routed WNS=-.006ns/TNS=-.016ns/5端点，WHS=.014/THS0/WPWS1.5。R57新3同拍FF及1LUT的状态/256组局部Boolean切面/94DSP审计PASS，原始负载变化已明确记录，不是全Root/SDF/物理CDC签核。原生功能和综合继承R52 NOT RERUN。

1. 93个原始硬件/测试/工具输入SHA同R57；只试验最差路径里B CORDIC i8_n0（2个负载，实际route .822ns）连接。125MHz/8ns、RTL/CSR/ADC-DAC/复位/CE/板级和精度保持；新增串行周期0。
2. 在原始routed DCP查精确名称、单驱动/2负载/非固定路由且确实通过负路径后，只unroute该网；使用普通timing-driven route_design -preserve（不带-nets/Explore），保持该命令内其他完整路线。不是R55的高扇出auto_delay实验。
3. 独立报告target0，再实际TNS cleanup并输出route/STA/hold/CDC/DRC/时钟交互/约束与94DSP；cleanup没有preserve故可能修改其他路线，不能宣称整个实验所有路线原样不变。不设置max/min delay或任何时序例外。
4. 全部逻辑/FF/LUT参数和连接须对R57核对，不能仅看资源数；输入DCP和原始source/top/XDC/CSR SHA冻结。优劣看final，坏结果只归档不采用；原R57/R53和R2b/R4a保持，无bitstream/板端/激光操作。
