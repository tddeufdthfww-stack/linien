# R50：零新增采样周期 IIR 输出边沿重定位整机验证

输入 RTL 为 R46 827dfec（经 R48 b0824e3/76dd452 保存），保留 Scope 缓存、源地址预译码与负阈值折叠；不继承 R47/R48 DCP 布局，重新综合、布局和 route。对照 R46 默认 route=-0.539/-18.344ns；最佳物理 R48=-0.179/-4.904ns，最终 STA 均 FAIL。R45 d0b8e2f 只有小模块原生验证，不当成整机通过。

1. 仅 IIR pipelined+registered_c48 模式改变：把原末级组合 split_c48_mac 后的 y 输出 FF 边沿移入现有 registered_c48_mac；原 50 位精确乘加、25 位系数、移位截断、阶数、逐拍吞吐保持，非目标模式不变。
2. 修改前数学依据：F 为旧末级有限50位 MAC，V/T 为原溢出判据与截断。旧 O'=V(F)?T(F):O；B'=clear?0:(!hold?O':B)；E'=!V(F)。新 M'=F，Op'=O，Bp'=B，Cp/Hp'=clear/hold；组合 O=V(M)?T(M):Op，B=Cp?0:(!Hp?O:Bp)，E=!V(M)。代入逐式相同；保存状态并行而非串联新增周期。全局 reset 的 M/Op/Bp/Cp/Hp 均0，对应 O/B/E=0。未知控制仍用原 If/Elif 优先。
3. 原样 R17 冻结 IIR/50位整数oracle order1/2/5，与 R45 新增的 cfg2/冻结 R44/真实CSR/独立双影子整数oracle/X-Z 各3000，必须重新 PASS；再执行所有14/25 PID、Scope、阈值预取、AXI/CDC/复位/背压旧回归。禁止修改旧断言来通过。
4. 目标新增 ADC→DAC/反馈/CSR 采样周期0，latency CSR 不变；输出/error 从 FF Q 改成 MAC 结果寄存器后组合选择，因此模拟传播/毛刺以及输出到后续消费者的 setup 必须新做 STA，不能用离散周期等价替代物理签核。
5. 新综合、place/phys/route、只读路径/全部 DSP 参数/资源/hold/CDC/DRC/覆盖审计与输入 SHA，分别记录 PASS/FAIL/NOT RUN。PS7/PLL/ADC/DAC/AXI/CDC/CSR/约束不改，不降低精度/阶数/吞吐，不加时序例外；失败保留源码/日志不合并保护基线，不上板。
