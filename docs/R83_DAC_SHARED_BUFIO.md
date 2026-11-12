# R83：数据与WRT同一BUFIO / 2026-11-12

R82 frozen56f8772b保留，实际route-.484/-6.200ns、16setup，hold-.562/-7.362ns、14端点，不选用。先前native和Bare通路PASS只证明功能，不能覆盖STA FAIL。新独立R83硬件只改analog.py一行：regional的write_domain从dac_write_io改为dac_io，使14数据IOB与WRT ODDR真正共用同一MMCM CLKOUT0/BUFIO，不改MMCM输入或任何数据寄存器。

实际R81/82报告确认源数据CLKOUT0、目的WRT CLKOUT1；R82时钟uncertainty .183ns含MMCM跨输出PhaseError .120ns，同时源捕获不同分配分支造成额外min/max相对差。不能靠降低.183数值签核；本轮从结构上改为真正同源，再由工具自行计算不确定度、CPPR和所有PVT角。未使用输出1的BUFIO允许综合自然删除，不做全局DONT_TOUCH/waiver。

功能依据：DATA仍SYS前.5/后3.5ns采旧A/新B，WRT由同一250MHz时钟反相ODDR产生，理想上升SYS+1.5/+5.5，相对data理想setup2/hold2ns。SEL .125仍位于WRT下降-.5到CLK上升.5的共同低窗内，距前边.625、距后边.375；CLK .5领先WRT1ns，距前WRT3ns。所有14位、吞吐率双125MS/s、样本编号、CSR、ADC、PID/IIR/PS/原PLL完全保持，新增反馈级0。

新native逐WRT oracle仍逐字严格对照冻结R80与独立SYS样本；只将预期WRT pad phase按真实结构改为1.6/5.6ns（100ps ODDR模型），不放宽数据检查。Bare正负脉冲要求数据仍71.6ns，对应WRT从R82 73.85改为73.6ns（相对R80 74.1提前.5ns），新旧无整拍延迟容忍。接口波形相位有意改变，不能声称逐时刻clock波形完全相同。先功能再新综合/以R80原DCP作增量参考的实际route，失败保留不合并。

本轮未放宽任何8ns时钟、IO setup2/hold1.5预算或例外。CLK/WRT/SEL全协议、ADC同字0/-8、物理CDC/DRC和3.5ns外部pulse/真实PCB仍必须独立检查；不因架构合理预判PASS，不部署。

## R83 实际功能与延迟定向PASS

73474次原语逐WRT数据/通道检查、37205次ADC、36731组DAC锁存输出、双路各16384取值、3次epoch，全部PASS。原语100ps传播精确计入，参考停钟后按原PLLE2要求显式PS reset恢复；不宣称自动恢复。正负123的Bare通路独立真实CSR/输入寄存器/限幅/PIO原语模型PASS：数据R80 72.100/R83 71.600ns，对应WRT R80 74.100/R83 73.600ns。两者早.500ns、样本编号不变；cycle标签8/9只是小于SYS边界，不是少8ns。

证据/SHA在experiments/r83_shared_native_20261112。本轮硬件相对R82只有analog.py的WRT clock source一行变化，新完整回归仍须独立运行，先前R81/R82物理失败不能作物理PASS依据。下一新综合、R80精确DCP增量参考的新route仍完整检查全部时钟、setup/hold/IO/CDC/DRC。累计串行新增4个125MHz数据级相对R2b不变，本轮接口相位早.5ns；不是全Root/SDF/板卡/模拟链总延迟或真实锁频带宽测量。当前不签发bitstream。
