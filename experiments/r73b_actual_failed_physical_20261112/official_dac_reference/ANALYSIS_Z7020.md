# Z7020 DAC 时序：参考源码与签核边界

2026-11-12，只读分析，无硬件/约束修改。

官方仓库固定输入提交：`728a4f37e9c0a9b5ba1d9b7a0d44c38bbd2dc674`。
文件原件和逐文件SHA在 `source_manifest.json`。

## 已核实

官方 `rtl/rtl/red_pitaya_pll.sv` 设置125 MHz DAC1x、250 MHz DAC2x、250 MHz/-45° DAC2p。
`prj/v0.94/rtl/red_pitaya_top.sv` 用2p/2x的反相ODDR分别产生IQCLK/IQWRT，
125 MHz ODDR复用14位数据、产生IQSEL。与当前Linien时钟名不同，但相位方案相同。
这可解释现有继承设计来源，不能证明全PVT/PCB时序通过。

所检查的官方 `sdc/red_pitaya_G2.xdc` 用create_clock描述DAC端口/若干时钟名，
包含多条ADC->DAC相关false_path；没有完整DAC data setup/hold输出预算。
项目专用 `prj/v0.94/sdc/red_pitaya_G2.xdc` 和z20_14版本也未提供可直接移植的完整
CLK/WRT/SEL/脉宽/PCB签核。不能复制这些例外来消除本工程告警。

官方参考板图明确AD9767；参考硬件不是用户实物PCB丝印/布线实测。
AD9767 RevG p7 Table3规定setup2.0ns、hold1.5ns、latch high pulse3.5ns。
p25规定数据在IQWRT上升锁存，IQSEL仅允许在IQWRT/IQCLK均低时改变，
3.3V时不保证CLK/WRT同时驱动可靠。数据setup图64的确切CLK/WRT基准须完整核查。
ADI2024公开125Mbps/3.3V/3.5ns问题当前仍Not Answered，员工回复仅承诺调查，
不能把它当成短脉宽的厂商许可。

## 当前实际STA和能推出的结论

R72 DAC必要零PCB模型：14个setup失败，最差-0.343ns；hold最差+0.070ns。
数据路径已经是OLOGIC FDRE ->0.001ns net ->OBUF，组合数据延迟3.726ns，
其中FDRE C-Q .472ns、OBUF3.253ns（slow corner）。不存在可继续删除的fabric算术链。
hold fast corner数据延迟1.506ns。二者不是同一PVT，不能用典型值互抵。

在固定电气配置、仅将共同IQWRT边沿移动delta的局部模型下：
setup_margin = -0.343 + delta；hold_margin = +0.070 - delta。
两者同时非负分别要求delta>=.343和delta<=.070，区间无交集。
因此仅相移当前整个WRT时钟不能修复这组最差约束；并未证明所有IO架构无解。
R66另外16组合法FAST电流组合、224个位级报告也未找到公共setup/hold区间。

本轮当前内部IIR优化不会直接改变DAC pad delay；重新布局全局可能改变时钟/控制路径，
仍须每轮重查，不能沿用本结果声称新的布线同样通过/失败。

## 后续有意义的实验与开放项

可考虑在独立候选中使用专用MMCM/HPC->BUFIO/BUFR，缩短DAC数据/转发时钟分配，
再以真实STA确认能否降低PVT时钟相对偏斜；PLL不能直接当作MMCM HPC替代。
所有DAC OLOGIC在X1Y2、MMCM_X1Y2可用是已查询的当前几何事实，不是新方案可布线证明。
须保持14位、双125MS/s、A/B字序、IQRESET更新分频相位、软件接口；不能默认换时钟
仍与SYS同拍，也不能漏查跨新MMCM边界及锁定/停钟/复位。

该实验即使改善必要setup/hold，也不自动解决外部3.5ns高脉宽以及IQSEL低电平窗口、
CLK/WRT顺序。当前250 MHz/50%名义高宽2ns，须得到适用模式的可靠规格解释或
设计满足完整协议的接口，不能自行改成较小脉宽要求。PCB偏斜/SI亦需真实依据。

`set_load`在实际Vivado2020.1帮助和AMD文档中明确只用于功耗，不参与时序；
不得用“改5pF负载”冒充时序修复。AD9767的5pF是典型值，不是实测板级最大值。

## 一手来源

- https://github.com/RedPitaya/RedPitaya-FPGA/tree/728a4f37e9c0a9b5ba1d9b7a0d44c38bbd2dc674
- https://downloads.redpitaya.com/doc/Schematics/Schematics_STEM_125-14_PRO_Z7020_Gen2_V2r0_RevA.pdf
- https://www.analog.com/media/en/technical-documentation/data-sheets/ad9763_9765_9767.pdf
- https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/587576/ad976x-interleaved-mode-timing-with-3-3v-125mbps
- https://docs.amd.com/r/en-US/ug835-vivado-tcl-commands/set_load
