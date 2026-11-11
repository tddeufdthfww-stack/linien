# R63 ADC同一源边沿数据字：IOB实现与时序边沿的明确契约

2026-11-12。独立分支opt/r63-adc-same-word-20261112；冻结R62失败源码/报告及R61b/R60。
R62完整功能PASS但falling ADC FF→CORDIC仅4ns，实际5.209ns，setup/hold均FAIL，已拒绝。
本轮恢复与R61b完全相同的rising FF逻辑，只要求IOB TRUE，不追加整拍反馈延迟、不改
PLL/引脚/位宽/CSR。DAC FAST8继承R62，尚未解决其-.835/-.456ns，不冒称通过。

## 数学和协议依据（先于实验）

T=8ns，LTC2145 full-rate CMOS以CLKOUT+ rising nT为word[n]源边沿；pad上该字
0..0.6ns后到达。设Ldata为实际输入缓冲/走线延迟，Lclk为实际PLL+时钟网插入延迟。
IOB必须保证：

- setup：Lclk_early - (0.6 + Ldata_late) - tsetup - uncertainty >= 0；
- hold：8 + Ldata_early - Lclk_late - thold - uncertainty >= 0。

两式检查同一字的最晚到达和下一字的最早到达，不能只把时钟相位当作理想0ns。
在R62真实IOB走线的报告中，fast setup时Lclk=1.700ns、Ldata=.503ns，slow hold时
Lclk=5.152ns、Ldata=.813ns（各报告自身early/late角，非把它们拼成同一物理角）。
这些数据提示posedge IOB可能满足same-word窗口，但只用于选候选；本轮新route必须
重新检查全部28条路径的setup/hold和物理时钟/数据角落，不能继承裕量数字。

默认STA的1-cycle setup在edge n+1捕获word[n]，相应hold要求word[n]不能早于edge n
到达；这与本次要证明的“edge n经实际插入延迟后捕获word[n]”是不同字编号。
为准确表达上述两式，本轮只对确切28个ADC pad→各自posedge IOB FDRE/D使用：

```tcl
set_multicycle_path 0 -setup -end -from $r62_adc_ports -to $r63_adc_pins
```

该命令把setup要求从8ns收紧为0ns，未增加可用周期，也没有false path。Vivado的
hold关系跟随setup，预期检查源edge0/捕获edge-8（等价整体加8后的源edge8/捕获edge0）。
须核验真实report显示setup Requirement=0ns、hold Requirement=-8ns；不另加hold例外
恢复错误的旧字关系，不切掉任何计算通路，也不变更8ns时钟。约束加载前断言28端点
皆为IOB TRUE的非反相FDRE/D，以免扩散到其他寄存器/CE/R或改结构后静默匹配。
新增例外的硬件依据是这个具体源同步协议和实际IOB结构，不能套用到PID或CDC数据。

AMD说明源同步接口可按同边沿0-cycle或经调整的延迟模板表达；UG903说明setup与hold
关系的联动。参考（仅使用通用STA语义，不把Versal器件特性套到7系列）：
- https://docs.amd.com/r/2020.2-English/ug1387-acap-hardware-ip-platform-dev-methodology/Using-XDC-Templates-Source-Synchronous-Interfaces
- https://docs.amd.com/r/2023.1-English/ug903-vivado-using-constraints/set_multicycle_path-Syntax
- LTC2145-14: https://www.analog.com/media/en/technical-documentation/data-sheets/21454314fa.pdf

## 验证、风险和失败条件

冻结原R61b analog.py（原rising fabric FF）作独立参考，实际Migen+UNISIM新旧analog
检查每个已稳定时钟边沿的全部输出。再用耦合的输入/时钟延迟模型扫完整两路14位、
位间skew、低2位、复位和下一sys消费者的样本号。模型只是数字契约验证，不冒称SDF。
在真实route核验28个实际ILOGIC IFF、全部PVT setup/hold、ADC→消费者整周期、CSR协议，
并记录新增0拍、相对R2b既有快速通路累计+32ns（未作板端延迟实测）。

任何setup/hold<0、样本号混字、新旧settled逻辑不等或例外范围/边沿不符，均判FAIL，
保留源码报告，不合并。外部预算当前仍是明确零PCB偏斜的必要诊断；实物偏斜/接线未
证实，不能因此宣称整板I/O签核或烧录准入完成。DAC/物理CDC/DRC缺口继续单列。

## 原生测试实际结果（物理实现前）

四组功能延迟包络(phi,buffer)=(1.5,.5)/(2,.65)/(3.5,.85)/(5.5,1.0)ns均PASS：
每组两路完整14位、位间0.6ns、5次复位、每个settled输出49位对照及下一sys消费者。
独立时间/周期编号oracle还必须在phi=0的负向用例捕捉旧字：该用例按预期
ADC_WORD_INDEX_FAIL，runner将其单列EXPECTED_WORD_FAILURE，不当作正常用例PASS。
冻结参考RAW SHA与R61b原文件一致。原始fixture/命令/日志/SHA归档
experiments/r63_analog_native_20261112。它们不是SDF或实物PCB测试。

两个测试器入口错误另存：先前inertial时钟延迟压掉快钟，被paired_checks=0捕获；
随后负向oracle在同边沿读取旧testbench变量，负例错误通过被runner拒绝。
均未修改硬件，也未删除断言；分别改用相位起始振荡器和独立时间编号后全量复跑。
旧FAIL源码/日志在对应r63_native_*_setup_failure归档保留，不静默改判。
