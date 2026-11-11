# R66 DAC full-cycle slot control

2026-11-12，独立opt/r66-dac-fullcycle-select-20261112。R65冻结0d7f00d，原工程/全部旧基线不改。

## 修改前数学依据

令T=8ns，F在nT的125MHz正边沿翻转，H在每个250MHz正边沿采样F；两者INIT0，均不受sys reset清除。数据输出IOB在同样250MHz正边沿采样Mux(F xor H,B,A)。使用真实触发器的边沿前状态：
- 在nT前，H已经等于F，XOR=0，输出A[n-1]；在该边沿F翻转、H采样旧F。
- 在nT+4ns前，XOR=1，输出B[n]；该边沿H采样新F，之后XOR恢复0。
- 下一nT+8ns重复，保持原版125MHz OPPOSITE_EDGE的A旧字/B新字顺序；原数据FF/编码/复位均不变。

R65的负边沿H/选择FF到IOB只给2ns。本方案改成同边沿正FF历史+XOR，F/H和数据FF到IOB自然预算4ns，不增加数据级，不用multicycle或false path。frame到H的同边沿hold必须真实通过，绝不切掉；组合XOR/Mux是否合并为单LUT和扇出/布线影响由新综合确定，不预报必然PASS。

## 修改、验证和边界

仅analog.py控制寄存器及新的check_r66_analog.py/回归入口，另更新记录。生成RTL预期32ADC+14DAC+1phase-history正边沿显式FDRE，无负边沿FDRE。冻结R61b完整analog黄金不改，逐稳定边沿全部49位比较（含启动GSR/复位），四时钟/数据包络、完整14位两路样本、下游消费样本标记与负向控制均须PASS。后续fresh全功能、CSR映射、新综合和route分别记录。

新增ADC→DAC串行数据级0，继承R4a/R17/R19相对R2b+32ns。复位外部波形和原数据复位保持。PLL/频率/相位/引脚/电平/DRIVE8 FAST/算法/CSR/滤波阶数/吞吐率不变。

R65 readonly合法DRIVE组合8/8、12/8、16/8、16/12、16/16、12/12未发现DAC setup/hold同时满足的组合，完整probe作为诊断保留，未选为源码更改。R66不声明解决DAC外部setup-.343ns、CLK/WRT/SEL/pulse、PCB、PS异步reset释放或所有物理CDC问题。这些必须另有验证和后续针对性整改。新SYS相位时序hold、2:1真实相位和FPGA配置启动仍有风险；原生仿真不是SDF/PVT证明。任何route FAIL继续归档，不直接合并或部署。


实际新旧原生analog检查：四功能时钟/数据包络、启动GSR/复位、完整14位、全部49位稳定输出、ADC样本号和下游消费样本PASS；负向零相位旧字模型按预期FAIL。每功能模型32813个样本/约131334个边沿；生成RTL正FDRE47/负FDRE0检查PASS。归档experiments/r66_fullcycle_native_20261112。功能仿真不能替代物理setup/hold；接下来运行新完整回归及综合/route。
