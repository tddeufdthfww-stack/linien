# R16：R14流水候选与R12零额外数据延迟混合器的组合验证

2026-11-10。独立分支，基于R14代码e6906dc。R14当前是更优候选但STA FAIL（route -4.093/-6274.995、失败5991），R12单独全局恶化(-5.156/-9847.520)仍REJECTED，不合并R4a。本轮只组合其已验证的局部结构，不改PID/IIR/控制算法，不在R4a直接merge失败分支。

当前R14最差正是F_B[3]/C→raw IIR输入DSP/D，11.842ns=logic7.362+route4.480，含2个DSP。R12曾将系数BREG改为1，入口局部改善；新的物理背景中是否有效须实测。不能将局部改善预设为整机成功。

数学依据同R12：F(unsigned9)=signed8(F_low XOR128)+128+256*F_high，F*X=G*X+128*(H?3X:X)；G在原低字节CSR写边沿进入DSP BREG，reset0对应Freset128。数据AREG复制原FastChain输出FF的D/CE，故ADC→DAC数据新增0拍。37位模加法/右移/符号/限幅入口全部保持；CSR高/低字节热写与读回原样，写操作不受数据CE。详见registered_error_mixer.py文档。

只将R12的chains.py导出D/CE、新mixer类和CSR子类、Root混合部分接入R14；完整保留R14慢链上下文对齐和robust一拍判定。所有时钟/约束/PS/AXI/CDC原样。相对R4a快速主支路额外0、慢/analog0额外16ns、robust判定额外8ns；指定数字模型Bare DAC A 56.1ns、快A→慢→DAC B92.1ns仍应保持（不是板级测量）。

重新执行实际DSP/CSR/原FastChainFF差分、R13完整慢链、R14父模块/CSR/FSM以及既有14/25位/CE/AXI/CDC，CSRmap与XDC字节比较，重新综合和实际route。WNS/TNS/端点和功能/CDC综合判断；若恶化不合并，保存源码/日志。源码冻结；无bitstream。
