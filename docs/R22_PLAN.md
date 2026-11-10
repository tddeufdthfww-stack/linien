# R22：公共加法先行、反相比较并行，与零周期IIR PREG候选组合

基于R20 c5c6be1独立工作树（route -1.838/-600.003，1287端点，raw内部-.518，STA FAIL），移入R21已通过14/25位42180/42340拍及完整FastChain30000拍的并行tap结构（R21物理结果尚在运行，不能当作已证明改善）。本轮新增周期0，保留R19两拍帧对齐和所有旧数据/反馈边沿。不合并保护基线。

修改前数学依据：所有求和最终wrapN，N=width+guard。因此wrapN(tap+A+B)=wrapN(tap+wrapN(A+B))，先公共A+B可缩短tap起点的加法链。原负支路v=wrapN(-S)，S=wrapN(sum)。当S不是最小N位负数时，v>=hi等价S<=-hi，v<=lo等价S>=-lo；upper判断仍先于lower，兼容lo>hi。N>width，已符号扩展的width位边界在取负后不会N位溢出。S=-2^(N-1)时，v=S（回绕），必小于可表示的width位lo/hi，因此选择lo、rail=1，必须显式处理。中间比较与取负可以并行。

在原bound_min/max同一个CE边沿计算负边界寄存器(-min/-max)，reset同为0，CSR存储仍常时钟，不增加配置或数据周期。正支路仍原Limit；负支路保持相同最终N位结果及width位输出截断、相等边界/非法上下限优先级。CSR地址、IIR反馈递推、阶数/精度/吞吐及ADC/DAC/PS/AXI/CDC代码不变。

修改parallel_tap_limit.py、chains.py生产可选结构和Root开关，沿用R20 IIR PREG；工具增加真实生产组合FastChain pair（参考旧split_c48，候选registered_c48+parallel）和glbl/UNISIM。新增定向N位最小负数及邻值/最大值，14/25位独立整数oracle、真实CSR/CE/reset与完整旧回归先PASS，再新目录综合/route/D-S-R-CE/CDC/资源。R21与R20的收益不能简单相加，组合结果必须实际验证。失败全部独立保留，零时序例外或放宽，无bitstream/上板。
