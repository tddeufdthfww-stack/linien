# R19：混合求和出口寄存器与两拍事务对齐

基于R18 ff50a01，独立工作树；修改前工作树干净。R18 route WNS/TNS=-2.326/-1448.239ns、1955违规端点，STA FAIL。全局最差混合器DSP→raw IIR输入MAC，logic4.816+route5.178ns。

数学依据：S=wrap37(Fa*A+Fb*B+(offset<<19))，single分支同样保留原37位截断；R17已将乘积和偏置同拍延后1sys，本轮只加入S寄存器，故S19[n]=S18[n-1]，不改位宽、符号、舍入和每拍吞吐。由此输入帧延迟从1变2sys，directADC、mode、limit CE、边界CSR、PID running/setpoint/gains/reset/CE、raw IIR系数/z0也必须从1变2拍。CSR存储常时钟，既有饱和与IIR反馈递推不改。

修改registered_error_mixer.py（可选sum_pipeline）、feedback_pipeline.py（frame_delay=1/2，默认1）、iir.py（config_delay支持2）、linien_module.py（生产选择2）、联合帧和IIR配置测试。没有更改PS7/时钟/板级/AXI/CDC/CSR地址或时序例外。

相对R18新增1sys=8ns；相对R16追加16ns，快主链相对R2b累计32ns；快→慢串接相对R4a额外32ns、相对R2b累计48ns。预计指定Bare模型72.1ns、快→慢108.1ns，均待实际测量。额外16ns在100kHz/1MHz纯延迟相位分别0.576°/5.76°，不是稳定性证明。

先原生14/25位真实CSR/512系数/独立CE/reset/积分饱和/模式/37位oracle联合差分，再28/50位IIR热写/hold/clear/反馈整数oracle，完整既有功能回归，生成CSR/XDC校验，新目录综合+route+只读D/S/R/CE和CDC审计。失败源码和诊断独立保留，不合并或上板。
