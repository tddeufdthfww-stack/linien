# R45：IIR现有输出状态边沿移入最后MAC，零新增采样周期候选

当前R44 Scope缓存仍在完整回归/物理验证，不能预认定时序通过。R45是独立小模块等价预验证，先不跑整机综合/route，不修改R44或保护基线；不携入R42 KEEP。IIR仅改变registered_c48+pipelined模式，native/split_c48/iterative保持原逻辑。

1. 原既有最终y FF边沿移入末项registered_c48_mac的50位结果寄存器（高DSP PREG+低17/补偿FF），此前最后MAC是组合split_c48、随后y FF。使用已经原生验证的精确50位MAC，不新增串行边沿或DSP乘法项。
2. 同沿保存上一拍输出/反馈状态及hold/clear，寄存后的选择精确重建溢出保持与反馈控制。设F[n]为原末MAC有限50位和，V/T为原合法范围/截断：旧O[n+1]=V(F[n])?T(F[n]):O[n]；旧B[n+1]=clear[n]?0:(!hold[n]?O[n+1]:B[n])，E[n+1]=!V(F[n])。
3. 新M[n+1]=F[n]，Op[n+1]=O[n]，Bp[n+1]=B[n]，Cp/Hp[n+1]=clear/hold[n]；新O=V(M)?T(M):Op，B=Cp?0:(!Hp?O:Bp)，E=!V(M)。逐式代入与旧递推相同；clear/hold用原if优先及~hold条件，保留未知控制仿真分支。全局reset：M/Op/Bp/Cp/Hp为0，故O/B/E均0。
4. 先运行原样order1/2/5真实CSR/热写/hold/clear/reset/overflow-hold/50位整数oracle原生差分，验证原b0/bN周期；失败保留诊断，不启动全构建。通过后才对14/25位与所有旧功能再完整回归，并独立新综合/route，不引用R40/R43旧物理结果。
5. 输出/错误从旧FF变为DSP结果寄存器后组合选择，周期数相同不等于模拟传播时间相同；要审查IIR输出到后续mixer/限幅/控制消费者和新反馈路径，所有同步消费者须实际8ns STA收敛。error目前未发现接到板级异步输出，但不预先声称无瞬态或物理等价；无fullRoot/SDF/板测证明。
6. 只有等价/功能与WNS/TNS/端点/资源/CDC综合有益才保留候选；不降低阶数/精度/吞吐，不放宽时钟或加时序例外，不部署。R44未完成前本候选只做小模块验证，原ADC→DAC采样周期和滤波器latency CSR均保持目标不变。
