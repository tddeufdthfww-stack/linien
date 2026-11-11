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

## 2026-11-12 R66实际：控制路径候选保留，整机STA FAIL

代码decd142b1f1f98f736efc15ce7861a3bc541d71e，新完整功能PASS（全部原生算术/14/25位/CE/CSR/复位/AXI背压/CDC/Scope回归），CSR映射PASS，新综合和actual route COMPLETE；两manifest raw输入SHA完全一致且运行中源码变化0。

综合WNS/TNS=-.773/-77.722ns（301端点），综合hold-.757/-361.422不是布线值。route WNS/TNS=-.343/-6.398ns（47端点），WHS/THS=+.024/0（0端点），WPWS=+1.500ns。最差已转为FDRE_34/C→dac_data[1]，3.726ns数据延迟（logic3.725/route.001，1OBUF）。时隙控制frame→FDRE_33/D自然4ns路径+.098ns，R65的2ns控制瓶颈消除，未用时序例外；同域最差fast_b_zi0__11/C→fast_a_cordic17[16]/D仍-.249ns，11级（7CARRY4+4LUT）。

ADC28端点setup/hold+.429/+3.304ns，0/-8ns真实边沿逐条PASS。DAC必要零PCB预算-.343/+.070ns；DNA+.376/+.174ns。LUT11700/FF13478/DSP94/BRAM35/BUFG6，no_clock0/内部未约束0、no_input16/no_output32仍待接口分类约束。50ASYNC FF/25配对同SLICE、一级Q只驱动二级D；整体物理CDC仍NOT PROVEN。数据反馈新增级0，继承相对R2b+32ns。

归档experiments/r66_fullcycle_candidate_20261112含完整功能/新物理/源码/SHA及R65补充I/O诊断（工具失败与不可能ODDR边沿已分别标明）。R66 routed DCP SHA256=06ca5db5b7f81432e015401c05cc57017eea6067be737fd726c0820ac3f60f6b。候选不部署，R67 PS复位同步修复与R68同pad波形DAC clock重编码独立继续。最终STA/I/O/CDC/DRC不通过，没有正式bit/bin。
