# R23：利用已有ya/offset采样边沿预加公共项，新增周期0

基于R22 fccfb49独立工作树，R22物理结果仍待完成，先原生等价验证；R21失败版归档e4f6f0d不合并。R21真实最差fast_b ya[2]/C→mixer物理复制的FastChain输出FF/D，路径经过Limit4求和、Limit5取负与比较，共6 CARRY4，logic4.376+route5.338ns。R22保留反相比较并行；本轮针对公共求和跨越已有采样边沿。

数学依据：原Root中offset_signed[n+1]=CSRoffset[n]，FastChain中ya[n+1]=trunc17(dy[n]>>>11)，二者均sys常时钟、reset0。故K[n+1]=ya[n+1]+offset_signed[n+1]可直接由K<=trunc17(dy>>>11)+CSRoffset在同一边沿计算，signed18保存；没有增加数据/配置周期。新y_limit输入仍wrap28(tap+(K<<11))，与原wrap28(tap+(ya<<11)+(offset_signed<<11))逐位相等。真实dy为signed25，右移11后实际14位，18位和无损。CSR部分热写按旧storage-before-edge采样，和原offset_signed FF一致；不随limit CE冻结。

只在Root生产FastChain传入pre_offset_signal=对应原CSRStorage.storage，并在chains.py可选路径建立common_reg；默认构造/原串行路径不变，原ya寄存器仍存在于默认路径。R22并行limiter公共第二输入置0，由综合消除后级公共加法；不修改CSR地址/PS/板级/时钟/AXI/CDC/IIR递推。风险为把一段加法转移到dy/CSR→common_reg setup路径，必须报告新起终点并实际route，不预判改善。

原生14/25位limiter旧表达式/有限位宽整数oracle继续测试，完整FastChain pair加入真实Root offset_signed FF参考，候选用CSR写入前源作同拍common副本；动态offset/所有CSR、独立CE、reset、tap、invert、IIR组合30000拍差分。全部旧功能回归与CSR map/XDC SHA检查后新目录综合/route/D-S-R-CE/CDC/资源。构建时源码冻结；R22原样保留；无时序放宽、无bitstream/板上操作。
