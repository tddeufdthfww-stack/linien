# R21：FastChain tap选择移到并行求和/符号/限幅之后，新增周期0

基于R19 9e7a38f独立工作树。R19真实最差y_tap_storage[0]/C→fast_a y_limit.y[5]/D，WNS=-1.852ns、逻辑4.351ns/布线5.385ns、13级6 CARRY4，tap控制第一条网扇出88。R20独立物理验证进行中；本轮先原生功能验证，再根据物理结果决定是否组合，不提前合并。

数学依据：原数据D=clamp(wrapN(sign*(tap[k]+A+B)),lo,hi)，k=3沿用原Array默认tap2，N=width+guard。当前tap/invert/lo/hi为组合操作参数，故可对每个k和sign先计算同一clamp再选择；纯函数选择交换完全等价。先wrapN(sum)再按N位取负与原宽乘±1最终wrapN一致，包括最小负数。clamp保持先x>=hi、再x<=lo的优先级（含相等/非法lo>hi）。保留原bound_min/max与y/error同拍CE和复位，CSR存储常时钟。没有新增FF周期、阶数/吞吐/精度或接口变化。

新增parallel_tap_limit.py，chains.py可选parallel_output=False默认原样，生产Root选择True；三个tap×两种符号共六路限幅并行，最后选择。以KEEP保留意图，风险为比较器/求和器复制的LUT/CARRY/扇出与布线成本，不能预判route一定改善。

先14/25位生成RTL与未修改LimitCSR+原表达式、独立整数oracle逐拍比较，真实CSR部分写/读回、边界、28/17位回绕、tap0/1/2/非法3、invert、复位、CE；完整FastChain/旧PID/AXI/CDC回归，CSR/XDC一致后新目录综合route并审查/D/S/R/CE、CDC和资源。原R19新增CDC-13保持单独未签核问题，不用计数降低证明安全。无约束放宽或bitstream/板上操作。
