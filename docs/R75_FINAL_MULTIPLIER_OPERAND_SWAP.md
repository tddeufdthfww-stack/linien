# R75：最后一次 IIR 乘法的操作数拆分方向

2026-11-12。从R72最终归档 `5124a1c14920b8d23bb09b9273a0343d1b85b2e0`
新建 `opt/r75-iir-final-operand-swap-20261112`，不继承R73/R74的寄存器搬移硬件。
R72是当前较好的必要模型候选：actual route -0.343/-4.308ns，17端点；并未签核。

## 等价依据

最终MAC原为 `F = (Z + Y*C) mod 2^N`，候选 `F = (Z + C*Y) mod 2^N`。
Y/C均为同宽signed输入（生产配置25位），没有在相乘前截断任一操作数；
整数乘法交换律及相同模2^N截断保证完整结果逐位一致，不仅输出位切片一致。
Z、系数cohort、所有寄存器边沿、饱和/clear/hold/reset、CSR均不动。

生产配置的最终 `split_c48_mac` 将第一乘数分17位unsigned低半和8位signed高半，
与第二个signed25位乘数分别送DSP；其50位溢出修正逻辑同原函数。
交换后只改变哪个乘数走17+8拆分，乘积仍全50位。其它已注册MAC不交换。
native路径仅最后a1项交换表达式，使14位差分也覆盖相应变换。

## 原/新代码和可能的物理收益

`gateware/logic/iir.py` registered_c48最后一项：

```python
# 原
z = split_c48_mac(self, zr, signal, c[coeff])
# 新（编译参数默认False，仅fast A/B启用）
lhs, rhs = ((c[coeff], signal) if swap_final_operands
            else (signal, c[coeff]))
z = split_c48_mac(self, zr, lhs, rhs)
```

`chains.py`传递编译参数；`linien_module.py`只在fast_a/fast_b设True。
raw五阶、PID、PS7、ADC/DAC、PLL、CSR及AXI/CDC修复保持。
新增采样/反馈周期0，无新状态寄存器，继承R2b+32ns而非总延迟实测。

目标是改变最后两个DSP的输入映射、反馈状态吸收位置、符号/修正路径和布局。
R72实际关键终点为CEB2；交换后可能转到AREG/CEA侧，但须读实际映射确认。
**不能宣称CEA本身更快**：DS187 Table66把CEA/CEB setup列为同一组规格。
因此这是输入结构/逻辑映射候选，收益不预设；不能仅凭终点改名就判定问题解决。
不增加DSP/FF只是数学结构预期，实际资源仍以综合/route报告为准。

## 验证门槛与历史失败

先运行 `check_r75_operand_swap.py`：冻结R72 IIR原件，14/25位一/二/五阶，
全部输出/error/系数/CSR与独立有限位整数模型比较，饱和边界/正负极限/随机、
复位、clear/hold、部分热写、b0/bN脉冲延迟均逐拍检查。
再 `check_r75_fastchain.py`：完整FastChain32000拍，双独立真实CSRBank，
所有I/Q/pre/error/读数据、CE和复位比较，不容忍新增一拍。
通过后冻结输入SHA，独立新generate/CSR语义、新综合及actual route；分别记结果。

R73完整组件功能fresh PASS，顶层生成属性KeyError；原件在其分支2b0fc162。
R73b修正属性后fresh完整功能PASS（b3da3011），但actual route -1.257/-869.526、2041端点，拒绝。
R74饱和状态重排定向PASS，但actual route -0.827/-635.956、1829端点、hold+.049/0，
最差DSP48E1_25/CLK->fast_a_paralleltaplimitcsr0_y_reg[8]/D，8.384ns
（logic3.335/net5.049，11级5CARRY4+2LUT4+3LUT5+MUXF7），拒绝，fresh全功能未重跑。
R75从R72恢复原寄存器/饱和边界，不把失败方案带入生产选择。

## 仍未解决的签核项

DAC必要零PCB模型setup -0.343ns、完整CLK/WRT/SEL/3.5ns高脉宽及PCB预算仍待处理。
内部no_clock=0不等于外部16输入/32输出已有完整约束。
52ASYNC/26同SLICE双级结构不是多位CDC总体安全证明；CDC数量下降不作为通过依据。
DRC告警风险须逐项审查。无签核bitstream，不进行烧录、启动镜像或激光/PZT操作。

## R75候选输入及定向PASS / 2026-11-12

从R72最终5124a1c另建opt/r75-iir-final-operand-swap-20261112，只交换fast A/B最终a1 MAC两个完整乘数的拆分方向，原输出饱和/反馈寄存器/CSR/PLL/ADC/DAC/PS7/AXI/CDC不动，新增反馈周期0。依据docs/R75_FINAL_MULTIPLIER_OPERAND_SWAP.md。14/25位一/二/五阶107706拍对照冻结R72及独立整数模型PASS，FastChain32000拍PASS，31976已知/21317写/24000 CE保持；完整原件和SHA在experiments/r75_native_equivalence_20261112。新生成/新综合/actual route待执行，fresh全功能未重跑，不能预判收益。

R73最新完整功能PASS和生成失败归档2b0fc162b26fb07829ccc02e2c4c9311a30e700a；R73b完整功能PASS但物理失败归档b3da30114366b1fe608a98d449c08518aafb60d4；R74定向PASS但route -0.827/-635.956ns、1829端点失败归档2a0a04836b8799b0626e4a4599b222b45c272b85，fresh全功能NOT RUN。均保持独立，没有合并进本R75硬件选择。当前较好参考仍R72 -0.343/-4.308ns、17端点，最终STA FAIL。

完整DAC/PCB/物理CDC/DRC及16输入32输出接口约束仍待签核，无可部署bitstream、无烧录/激光/PZT操作。

## R75实际结果：目标CE改善，整机STA仍FAIL / 2026-11-12

输入769a86b0a91b4c8a1dd1a4c73cc4abed98dbd954，source_changes=[]。生成/CSR语义PASS、新综合COMPLETE WNS/TNS=-.786/-80.690ns（301端点）；actual route COMPLETE -0.365/-6.307ns（34端点），WHS/THS+.025/0、WPWS1.500。整体尚未优于R72 -0.343/-4.308、17端点，不合并。最大common_reg→parallel tap y/D，8.047ns（logic3.290/route4.757，5CARRY4+LUT2+LUT4+2LUT5+MUXF7）。目标IIR CE最差+.138ns；仍有a2_reg[24]/C→z_high1_i_2_psdsp_21/D -.003ns。实际目标low/high DSP AREG1/BREG1/PREG0，饱和控制进CEA2，CEB2=1，不能称CEA器件规格本身更快。

14/25 IIR107706拍及FastChain32000拍新定向PASS，fresh全功能NOT RERUN。全套实际新综合/route/输入/DCP/SHA/只读映射和分类见experiments/r75_actual_operand_swap_20261112，DCP SHA=0d568f7c3e1d0476b81dd7a30a3471563898d697cc822ca97032777911820b1f。ADC28条+.429/+3.304及0/-8关系PASS，DNA setup+.285ns，DAC必要预算-.343/+.070ns。52ASYNC/26同SLICE双级，GPIO16对实际setup+7.207/hold+.119ns；接口库存32无输出延迟分16GPIO/8LED/4PWM/2DAC控制/2LOW生成时钟，不混为32个相同同步数据失败。六Scope元数据已按实际src_capture_o同请求cohort分类，正常16ns窗口只是扣除guard前诊断，不是整体物理CDC签核。

后继R76仅在冻结R75 DCP重做核心placement/routing/pin优化，逐token逻辑比较；综合REUSED_R75不冒称新综合。新增正常反馈级0，继承R2b+32ns；完整DAC协议/外部脉宽/PCB、物理CDC/DRC仍待签核。无可部署bit/bin或板卡/激光/PZT操作。
