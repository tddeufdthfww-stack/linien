# R18：IIR的精确C48乘加，新增反馈周期0

2026-11-10。基于R17代码78db834，独立分支。R17完整功能/综合/route完成，WNS/TNS=-2.800/-4213.790、端点4523，STA FAIL；最差FastChain A IIR z20/CLK→z50/CEB2，10.072ns=logic7.833+route2.239，DSP与9 CARRY4。R16/17代码冻结不覆盖。

## 修改前数学依据（全部有限位宽）

旧MAC：R=wrap50(Z+C*X)，Z signed50，C/X signed25。
X=L+H*2^17，L为unsigned17（显式补0构成signed18），H为signed8。
令ZL=signed48(Z mod2^48)，ZT=signed2(Z[49:48])，s=ZL符号位，则Z=ZL+(ZT+s)*2^48。
T=C*L+ZL，Q=wrap48(T)。乘积C*L只有43位，所以T仅可能发生一次signed48正/负溢出：o+=!sign(ZL)&!sign(C)&sign(Q)，o-=sign(ZL)&sign(C)&!sign(Q)。L=0时不会产生误判，因为Q=ZL。
因此T=Q+(o+ - o-)*2^48。
令P= C*H + arithmetic_shift(Q,17)，K=ZT+s+o+-o-，则R的低17位为Q[16:0]，高33位为wrap33(P+K*2^31)。所以只有最高2位需加K（mod4），其余48位直接拼接。中间Q严格48位wrap，不可用无限精度Q替换。

目标推断：两次乘加各适合单个DSP48E1的25x18乘法及48位ALU，第二级可使用前一级结果右移17；消除外部宽50位进位链。能否映射成该结构、是否改善时序尚未验证，不预先承诺DSP数量或WNS。

## 修改范围与功能约束

新增iir_c48_mac.py组合helper；Iir增加mac_impl参数，native默认不变，仅生产25/25/50 pipelined路径选择split_c48。FastChain的order1/2与raw order5均复用同一数学MAC，全部旧zr/y/hold/clear/系数/z0寄存器、饱和保持逻辑、latency/interval CSR原样。R17配置一拍对齐保留。不增加IIR反馈或ADC→DAC周期，不改阶数/精度/吞吐/软件ABI。

## 验证再综合

先完整50位组合结果与冻结原表达式及独立整数oracle比较，专门覆盖ZL接近±2^47、零/极值C/X、正/负48位溢出与50位最终回绕。再对生产order1/2/5、真实CSR热写、hold/clear/复位/overflow-hold进行原生RTL全IIR差分。既有14/25位、R17联合帧及配置对齐套件不省略；CSR map/XDC一致后新目录综合/route，检查实际DSP/CARRY/寄存器吸收及D/S/R/CE、CDC/覆盖/DRC。失败源码和诊断保留，不直接合并；无时序例外或时钟放宽，无bitstream/板上操作。
