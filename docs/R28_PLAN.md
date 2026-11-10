# R28：快速 PID 输出饱和位解码，零新增周期

从 R26 c105b02 / 记录5d9af0a建独立工作树；不携带R27的Root CSA（该版route退步，单独拒绝归档）。R2b/R4a/R16和原用户工程不改。

R26真实关键路径从PID sum[26]经输出饱和比较8个CARRY4，再经Root求和6个CARRY4到limit_fast1.x[17]/D，合计20级、logic4.528+route4.197ns、WNS−.910。R28只重写PipelinedPID的组合输出钳位，不改base PID/慢PID/Root求和/流水线/IIR/CSR/CE/reset/时钟或XDC。

数学：N位signed S限制为W位补码区间[L=−2^(W−1), U=2^(W−1)−1]。取H=S[N−1:W−1]（含目标符号位）：S非负时H非0恰为S>U；S负时H非全1恰为S<L；其余S低W位已准确表示原值。原上下限相等时不溢出，等价保留。高位检查只需OR/AND树，不需84/51位大小比较进位链。先独立整数模型5/6/7位穷举与14/25位各60013组PASS，这不是RTL/STA证明。

实现文件pid_output_limit.py与pid_pipeline.py.calculate_sum：原sum位宽/表达式/FF/CE边沿逐字保持，仅替换输出组合钳位。快链新增0拍（继承R19组件72.1ns的周期契约，未冒充full Root/板端实测）；慢PID未变。

验证：原比较器/新生产helper/整数oracle原生Verilog，14/25位完整51/84位输入、饱和边界、符号扩展高位和低位极值、随机；原生完整联合PID/真实CSR/饱和/CE/reset/帧14与25位，全部既有IIR/AXI/CDC/Scope回归；CSRmap/XDC核对；独立综合和实际route、PID outgoing与D/S/R/CE、CDC及覆盖/DRC审计。风险是综合器本已优化常数比较，或减少carry后布局使其他模块退步。任何时序改善待route证明，不新增流水线/例外，不直接合并。
