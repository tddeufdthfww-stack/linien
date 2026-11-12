# R73：IIR 反馈状态的零新增周期实现候选

2026-11-12。父代码 R72 `662ab1be674f1c638c2e21252e6cad62f203a534`，独立分支
`opt/r73-iir-fabric-feedback-20261112`。原工程及既有候选保持不变。

## 实际依据与最小修改

R72 actual route WNS/TNS = -0.343/-4.308 ns，17 setup 端点，hold +0.027/0。
其中14个DAC必要预算端点、3个内部端点。内部最差：
`fast_a_iir0_z_low0/CLK -> fast_a_iir0_z_high0/CEB2`，slack -0.227 ns，
data 7.625 ns = logic 5.848 + net 1.777，DSP48E1+LUT6。
另有同DSP到low0/CEB2 -0.067 ns，及phase->CORDIC -0.039 ns。
这些是实际路径报告，不是根据实例名推测功能。

对应 `iir.py` 的最终分拆乘加、`railed`判断和反馈y更新。实际映射中low/high均
BREG=1，CEB1=0，CEB2为同一饱和控制组合网，RSTB为SYS reset；反馈保持被吸收成DSP CE。
本轮仅将既有y状态显式实例化成FDRE（CE=1，DONT_TOUCH），把clear/hold选择保留在D，
不增寄存器级。不改变乘法、加法、中间50位截断、饱和表达式或流水线其它状态。
在 `chains.py` 新增默认False的编译参数，仅 `linien_module.py` fast_a/fast_b启用，
raw五阶IIR及其它默认调用保持。没有新增CSR、软件配置或时序例外。

## 等价依据

令R为同步SYS reset，C为clear，H为hold，L为本拍原有y_lim组合值，Y为反馈状态。
原状态转移为 Y[n+1] = R ? 0 : C ? 0 : H ? Y[n] : L[n]。
候选组合D先赋Y，再按原有If/Elif相同优先级执行C清零、非H加载L；FDRE的同步R
优先于CE=1加载D，因此边沿状态转移完全相同。
保持原始过程式条件，避免将未知条件随意改成另一种Mux四态语义。
候选FPGA INIT=0等于原y reset=0；厂商仿真GSR启动另有100 ns，测试共同reset覆盖前24拍。
证明针对正常二态控制与既有复位协议；不宣称未经测试的任意X/Z模拟行为等价。

因此数值精度、滤波阶数、采样吞吐、CSR、正常反馈流水线新增周期均为0。
相对R2b继承+32 ns，不是实测端到端总延迟。可能增加最多8*25=200个fabric反馈FF，
同时减少被吸收的DSP输入状态；实际资源/时序必须等新综合/route，不预报收益。
风险：将CE路径变为D输入选择可能增加LUT/数据布线，DSP输入失去BREG可能形成新长路径。
若实际恶化，保留候选和报告，不合并。不能靠放宽时钟/例外接受它。

## 可重复验证

`check_r73_feedback.py`：冻结R72 IIR SHA256
`89b6b11517c021d2fda055071efa1b954e8bcc8a2a8aebfd2282bfe62eed44a7`，
14/25位、一/二/五阶，同拍输出/error/coeff/真实CSRBank与独立有限位整数模型比较；
包括正负极限、溢出保持、hold、clear、复位、部分热写、b0/bN脉冲延迟。
14位用native MAC，25位用实际registered_c48及DSP48E1/FDRE UNISIM。
`check_r73_fastchain.py`：完整FastChain旧/新独立CSRBank，32000拍，全部I/Q/pre输出、
错误状态、读数据每拍严格比较，复位/CE/配置热写，无延迟容忍。
完整回归仍采用R69b明确的有效响应契约，保留旧无ACK数据差分FAIL证据。
新generate检查CSR映射语义一致；新synth及route分别记录，不沿用R72时序。
实际route后重新审查ADC28条0/-8关系、DNA、同步器结构/保持窗口、CDC/DRC及全部IO。

## 当前开放项

功能、综合、route、最终STA分别记结果，构建程序完成不等于时序通过。
DAC14位必要预算setup仍-0.343 ns，完整CLK/WRT/SEL/外部脉宽/PCB预算待签核。
16输入/32输出无接口延迟、物理CDC整体和DRC风险不能因内部优化而写成通过。
无签核bitstream，无烧录、板卡启动镜像或激光/PZT操作。

## R73已执行定向回归

14/25位一/二/五阶共107706拍，新旧逐拍+独立有限位整数模型PASS（完整CSR/复位/hold/clear/饱和/脉冲延迟）；完整FastChain32000拍PASS，31976已知周期/21317写/24000 CE保持周期。厂商DSP48E1/FDRE原生模型。原件/SHA在experiments/r73_targeted_native_20261112。新完整功能/综合/实际route尚待，不得以此认定时序收敛或上板。
