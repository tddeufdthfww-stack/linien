# R77：解调 CORDIC 第一次旋转的等价并行选择

2026-11-12；独立分支opt/r77-speculative-demod-20261112，保留R75乘法交换，
不采用R73/R74的状态搬移。R76实际物理优化WNS/TNS=-.343/-6.077ns、33端点，
内部最差倍频CSR->first CORDIC/D -.205ns，8.072ns（logic4.068/net4.004），
12级8CARRY4+LUT2+2LUT4+LUT6。R76前后逻辑网表严格一致，但STA仍FAIL。

## 精确等价

Demodulate的输入是signed W位ADC、yi=0，进入原Cordic时x被扩到signed W+1位，
guard=2。原始相位P为W+1位；象限修正q=P[-2] XOR P[-1]。
修正后的相位是P+q*2^W，模2^(W+1)，因此其符号d=P[-1] XOR q=P[-2]。

第一旋转i=0且y=0：

```
X0 = ADC << guard
x1 = (-1)^q * X0
y1 = (-1)^(q XOR d) * X0 = (-1)^P[-1] * X0
```

候选并行计算X0/-X0，第一拍的x/y只按q和P[-1]选择，不等待相位后再做ADC取负。
仍使用原`_stage`的第三条相位递推，所有后续级与原代码相同。
ADC有额外一位头间隔，±ADC在W+1位均可表示，先取负再加guard与先移位再取负
在W+3位完全一致；包括ADC最小负数。没有减小任何输出、guard或中间精度。
第一拍x/y/z逐位相同，初始/reset全0且后续递推相同，可按级/拍归纳得完整I/Q相同。
证明针对已定义二态输入，不冒称任意X/Z条件分支的模拟行为等价。

## 实施范围

- 新 `speculative_demod_cordic.py`仅重写i=0的x/y赋值，构造时断言pipelined/rotate/circular、
  ADC signed及额外1位头间隔；继承原相位更新及全部后续旋转。
- `modulate.py` Demodulate增加默认False编译开关、精确同宽相位wire和显式yi=0。
  DDS Modulate/通用Cordic源码不改，delay/multiplier CSR不改。
- `chains.py`传递开关，Root仅fast_a/fast_b启用，raw IIR/PID/PS7/ADC/DAC/PLL/AXI/CDC保持。
- 原第一拍寄存器位置不变，新增采样/反馈周期0，吞吐仍1样本/周期，
  Demodulate延迟保持W+1周期，相对R2b继承+32ns，不是总ADC-DAC实测。

预期只缩短相位到第一向量寄存器的串行组合链；不保证整机自动通过。
ADC到预计算取负仍需STA，第一z以及上游倍频加法可能成为新瓶颈；布局变化也可能
影响未改IIR/limiter。采用必须看actual route WNS/TNS/端点，不凭路径改名判断。

## 可重复验证

`check_r77_demod.py`使用冻结R75完整Demodulate源，独立两套真实CSRBank。
14位所有ADC值×4象限；25位边界和随机；完整pipeline每拍I/Q、raw phase、CSR读数、
delay/multiplier存储严格比较；16种倍频、相位绕回、32位delay边界/部分热写、复位。
还按有限位数学独立穷举第一步，并独立核对当前phase乘加截断。
新`check_r77_fastchain.py`保持R75 IIR交换两边都启用，仅候选启用speculative Demod，
整链32000拍、CE/复位/全部输出/error/CSR逐拍比较，不允许延迟容忍。
通过后冻结输入，CSR语义、新综合和actual route独立执行；再审计全部域/IO/CDC/DRC。

最终DAC必要模型仍setup-.343ns，完整CLK/WRT/SEL/3.5ns脉宽/PCB未签核。
不能因内部改善就声称可直接烧录。无bitstream发布、烧录或激光/PZT操作。

## R77已执行新定向PASS / 2026-11-12

14位完整Demod93226拍、25位27701拍，均真实独立CSRBank、16/16倍频、delay部分热写/边界/相位绕回/27复位拍/IQ及phase全输出每拍严格PASS；延迟分别原15/26拍不变。第一步独立数学65536组14位与40020组25位边界随机PASS。原R75冻结Demod源作为reference。全FastChain32000拍PASS（31976已知/21317写/24000 CE保持）。所有原件/SHA在experiments/r77_native_equivalence_20261112。新生成/综合/route与fresh全功能待验证，不预报最终收益。

R76最新物理归档提交7d62979be0644264b8ba75595d9595b68dfe784a：route -0.343/-6.077ns、33端点、前后逻辑一致PASS，最终STA仍FAIL。R77不加任何寄存器级，不改变原IIR/limiter状态边界；所有延迟结论仍不等于端到端或闭环带宽实测。完整DAC协议/PCB/CDC/DRC尚未签核。

## R77实际：相位违规消除，整机STA仍FAIL

输入557745122e3041fc9a0bc7e9074ff71f05d4ee9c。新生成CSR语义PASS；新综合COMPLETE -.786/-81.445ns、297端点；actual route COMPLETE -.437/-9.451ns、102端点，WHS/THS+.006/0、WPWS1.500。全部102负路径无CORY/phase端点，但最差IIR y0/C→parallel limit y[23]/D，8.029ns（logic3.273/route4.756，5CARRY4+LUT4+2LUT5+MUXF7）；另有49 IIR微小违规最差-.019和3GPIO最差-.113ns。整体未优于R72/R76，不合并正式设计。

14/25位完整Demod120927拍及FastChain32000拍新定向PASS，fresh全功能NOT RERUN。source_changes=[]。ADC28条+.429/+3.304及0/-8关系PASS、52ASYNC/26同SLICE双级结构PASS；CDC元数据地址9在部分实际端点成为最差源，旧v3分类器FAIL保留，不称物理CDC通过。全部原件/DCP/输入SHA/只读审计见experiments/r77_actual_demod_20261112，DCP SHA=ca1a1541ee72c65073ead943c37eedafb21cceced6165c88de671e85cdb65fcc。

后继R78在原公共量/边界更新边沿预算限幅阈值B-C，末级比较T无需等待T+C，使用有限位carry-save而非两条串行进位。新增控制辅助FF但正常反馈整数周期0；所有CE/CSR/复位/cohort须逐拍验证。DAC协议/外部脉宽/PCB/物理CDC/DRC未签核，不发布可上板声明。
