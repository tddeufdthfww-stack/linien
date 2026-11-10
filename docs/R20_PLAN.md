# R20：IIR已有状态FF向DSP PREG重定位，新增周期0

基于R19 f73476b，R19物理实现运行中；先单独功能验证，待R19实际route后决定全流程。独立分支，不修改R19或R18。R18真实内部路径：FDRE→low DSP B→PCOUT→high DSP PCIN→P→FDRE，logic5.825ns、route3.873ns，其中low输入1.624ns、high输出2.247ns；不是缺少PCIN专线，原级联已存在。

数学等价依据：原中间状态Q[n+1]=wrap50(Z[n]+X[n]*C[n])。沿用R18低17/高31/顶2位精确分解，将原Q的高31位FF移入high DSP的PREG，同一边沿采样；低17位用普通FF；校正K和high最高2位各在相同边沿采样后进行mod4两位加法。所有返回状态仍等于同拍原50位Q。第一项输入zr和最后一项组合MAC/输出y/overflow-hold保留，避免移动反馈采样边沿。不加反馈流水级、不改每拍吞吐/阶数/位宽/CSR/配置对齐/CE/clear/hold。

只新增iir_registered_c48.py并增加Iir mac_impl=registered_c48选择，生产raw和FastChain复用；默认native和旧split_c48保留。先原生DSP48E1 UNISIM时钟化50位MAC与原表达式及独立整数oracle边界/回绕/复位差分，再order1/2/5完整IIR与冻结RTL/整数oracle，14/25配置帧及既有完整回归。仿真显式包含glbl并在初始GSR期间保持复位，不改变后续复位/hold/clear断言。实际DSP数量/AREG/PREG和WNS需综合route证明，失败不合并。无约束放宽，无bitstream/板上操作。
