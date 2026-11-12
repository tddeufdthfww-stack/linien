# R74：在原输出边沿捕获乘加结果，饱和状态组合重构

2026-11-12，独立候选 `opt/r74-iir-saturation-retime-20261112`。
父代码R73b `5543e7477b7073468529d703d9afde7d181418ab`。
R73b原fabric反馈方案实际route -1.257/-869.526 ns，2041 setup违规，hold +.014/0；
最差 feedback_fabric_16_3/C -> fast_a_iir1_y2_reg[0]/CE，8.993ns（logic6.259/net2.734），
5级（2DSP+3LUT6）。不合并。原输入、实际报告和完整功能回归保持独立，不覆盖。

## 数学等价（先证明再测试）

设 F[n] 是原有本拍最终有限位乘加结果（每步截断规则完全不变），O是溢出判定，
T是原位切片，Y是输出状态，B是反馈状态，C/H是clear/hold。
原实现：

```
Y[n+1] = O(F[n]) ? Y[n] : T(F[n])
B[n+1] = C[n] ? 0 : H[n] ? B[n] : Y[n+1]
error[n+1] = O(F[n])
```

候选在同一个原输出时钟边沿捕获：

```
M[n+1] = F[n]
P[n+1] = Y[n]
Q[n+1] = B[n]
CQ[n+1] = C[n]; HQ[n+1] = H[n]
```

边沿后组合重构：

```
Y[n+1] = O(M[n+1]) ? P[n+1] : T(M[n+1])
B[n+1] = CQ[n+1] ? 0 : HQ[n+1] ? Q[n+1] : Y[n+1]
error[n+1] = O(M[n+1])
```

代入得每项与原递推相同，初始/复位所有状态为0，按拍归纳可得全部合法输入、
系数、hold、clear及热写序列逐拍等价。不忽略hold/clear，优先级仍reset>clear>hold。
CSR系数及z0 cohort寄存器完全不改。只支持pipelined模式；原iterative及默认调用不启用。

25位实际registered_c48模式：最后一次split组合MAC改为现存registered_c48_mac，
删除原self.y/error/feedback输出FF边沿，采用上述重构。中间所有MAC状态不变。
native/split其它宽度：在原最终组合MAC之后捕获M，替代原Y边沿，同一证明适用。
同拍全位有限位结果，不改变滤波阶数/系数/舍入/溢出保持/样本编号/吞吐率。

这不是在原输出后额外串接一拍。新增正常反馈整数周期0，继承R2b+32ns；
组合传播位置发生变化，不能承诺相同纳秒级边沿后稳定时间，必须重新STA。
额外保存上一输出/反馈和控制cohort，资源可能增加；固定clear/hold=0的FastChain可优化冗余。

## 修改范围与风险

- `gateware/logic/iir.py`：默认False的retimed_output编译参数、状态重构、最后MAC寄存器。
- `gateware/logic/chains.py`：向四个实际fast滤波器传递参数。
- `gateware/linien_module.py`：fast_a/b选择R74，关闭未选用R73fabric实现；raw5阶不变。
- 定向测试与完整runner增加独立入口；没有CSR/板级引脚/PLL/IO例外改动。

主要风险：PREG输出之后的50位修正、饱和mux再到下级DSP输入可能形成新长路径；
反馈环路并非由注册位置变化自动变短。组合输出存在边沿后传播/瞬态，所有同步消费
必须在真实STA下满足setup/hold。不能用仿真等价代替物理证明。

## 验证与采用门槛

`check_r74_retimed_iir.py`：冻结R72、独立整数模型、14/25位一/二/五阶，真实CSRBank、
正负饱和边界/随机全位/hold/clear/全局复位/partial热写/脉冲延迟逐拍比较。
`check_r74_fastchain.py`：整FastChain32000拍双CSRBank/全部输出/error/读数据/复位/CE比较。
通过后独立新generate（CSR语义）、新综合、actual route；最后重新核查DNA、28ADC边沿、
全部内部D/CE/R等路径、CDC物理结构/保持窗口、DRC以及IO，不借用R72或R73b裕量。
候选劣于R72时保持失败记录，不合并；必要时继续局部零延迟方案，而非放宽时钟。

DAC CLK/WRT/SEL及外部高脉宽/PCB签核仍开放，不能因内部通过就发布可烧录版本。

## R74已执行定向功能PASS

14/25位一/二/五阶107706拍严格差分+独立整数模型PASS，b0/bN脉冲延迟分别保持order+1和2*order+1；全FastChain32000拍PASS（31976已知/21317写/24000 CE保持）。clear/hold/复位/饱和/部分CSR写全部逐拍比较，未允许多一拍误差。完整原件/SHA在experiments/r74_native_equivalence_20261112。新生成/综合/route尚待，完整功能暂未重跑，最终STA未签核。
