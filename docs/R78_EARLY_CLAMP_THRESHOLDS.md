# R78：同拍预计算限幅比较阈值，保持原反馈采样周期

2026-11-12。独立opt/r78-early-clamp-thresholds-20261112，保留R75最终MAC交换与
R77第一旋转组件。它们尚不是正式签核版本；R77整体actual route -.437/-9.451ns、
102端点，CORY/phase违规0，但最差IIR yFF->parallel limit y/D，8.029ns
（logic3.273/net4.756，5CARRY4+LUT4+2LUT5+MUXF7）。原版/所有试验不覆盖。

## 状态/周期等价先行

原FastChain在第n边沿得到公共量C[n]=(D[n-1]+O[n-1])<<s，其中D=dy>>s、
O=signed原offset CSR，都是A位signed；s=W-A。边界L/H按原update_en在该边沿
从CSRStorage或旧边界选择；输出寄存器在同边沿消费前一拍组合限幅结果。

候选将C的原同拍FF放入新的限幅组件（不在旧FF之后再接FF），同时捕获：

```
theta_low[n]  = L[n] - C[n]
theta_high[n] = H[n] - C[n]
theta_neg_high[n] = -H[n] - C[n]
theta_neg_low[n]  = -L[n] - C[n]
```

预计算使用边沿前的D/O，及 `next_bound = update_en ? CSR : old_bound`，因此
与第n边沿更新后的C、L/H严格同cohort。阈值每拍更新，即使CE=0；边界和y/error
仍按原CE保持，CSR写入照常，不因CE冻结。全局reset令C、边界、阈值均0，关系成立。

于是原正向比较 `T+C >= H` / `<=L` 可精确替换为 `T>=theta_high` / `<=theta_low`。
反向原比较 `T+C <= -H` / `>=-L` 则为 `T<=theta_neg_high` / `>=theta_neg_low`。
保持原Limit的 **max优先于min** 及等号算railed，min>max/相等仍按原优先级。
未饱和的输出仍计算原T+C或其负值；原最后y/error FF与CE边沿不动。
因此只是把控制比较所需的辅助值放在原状态边界计算，新增正常反馈整数周期0。

## 位宽和可达范围

本组件仅用于有pre_offset的真实FastChain，输入D/O为A位signed，T和CSR边界为W位signed。
C的整数和需要A+1位；移位后W+1位，T+C和边界-C最多W+2位。
原guard=3提供W+3位，因此不会发生原有限位总和wrap，也不会达到-N位最小负数。
这由新组件窄接口保证；不把结论推广到原ParallelTapLimitCSR任意满N位common_a/b。
原通用组件/default调用保留不变。

生产W25/A14/s11：T+C范围[-50331648,50327551]，在27位signed内；原28位保持全部精度。
没有降阶、降低吞吐或减少输出精度。

## 阈值预计算不引入串行长进位链

分解B=Bh*2^s+Bl，0<=Bl<2^s。
正阈值高部为 Bh-D-O，低部Bl。
负阈值高部为 -Bh-D-O-[Bl!=0]，低部(-Bl) mod2^s。
高部用A+2位（生产16位）表示，先3操作数carry-save，再吸收补偿2或2+[Bl==0]，
最后仅一条16位进位加法。低部取负独立计算，不串入高部进位链。
实现前独立整数验证14/10位与25/14位各200500种正/负阈值，边界+随机全部PASS。
辅助FF可能增加约4*(W+3)*4=448位，另有公共量同拍副本；实际综合优化后资源另报。
预期消除末级“先加法再比较”的串行依赖，不能保证新的阈值producer/布线自动收敛。

## 变更与验证

新增EarlyCommonTapLimitCSR，仅Root fast A/B编译开关启用；FastChain提供原公共量FF
的D/O输入，其他信号/CSR/原最后输出FF不动。IIR/PID/PLL/PS7/ADC/DAC/AXI/CDC不改。
先14/25位完整真实CSR、正负/反置/相等边界、tap3、inversion、CE0热写、复位及
独立64位整数pre/post-edge oracle，再全FastChain逐拍差分。不得接受一拍偏移。
通过才新生成（CSR语义）/综合/actual route，分别记录；不以仿真代替STA。
若新producer超时，保留失败源码/报告，再调整组合结构，不隐加周期或例外。

累计继承R2b+32ns，非端到端实测。完整DAC时序/脉宽/PCB/物理CDC/DRC仍待签核，
不发布“可直接上板”声明，不烧录或操作激光/PZT。

## R78已执行新功能验证PASS

实施前14/10位与25/14位阈值CSA数学各200500例PASS。实际14/25位限幅各36000拍，真实独立CSRBank+signed64 oracle在每个边沿前后核对所有阈值/pre_y/rail/y/error/bound/CSR/common，PASS。两例各10303次CE0写、30909保持拍，反置边界17545/16266拍、相等539/535拍、边界1795/1796例；全FastChain32000拍PASS。没有延迟容忍。原件/SHA在experiments/r78_native_equivalence_20261112。新生成/综合/route和fresh全功能尚待。

R77最新物理失败/相位改善归档99dc108e0ba799bfa4dee40118b8150ba45f5f56；全部102负路径无phase/CORY。R78仅优化限幅控制比较，未更改原IIR/PID/PLL/PS7/ADC/DAC/AXI/CDC和输出接受边沿。新增辅助阈值FF不是新增反馈数据级，累计R2b+32ns非全链路实测。最终DAC/PCB/CDC/DRC签核未完成，不上板。
