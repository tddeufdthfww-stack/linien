# R27：Root 快速输出五项 CSA，零新增周期

父代码 R26 c105b02（含已修复真实 unsigned CSR 的 R25）；独立分支，不改 R2b/R4a/R16/用户原工程。
实际 R26 全局路径：PID sum[26]/C → limit_fast1.x[17]/D，20 级/14 CARRY4，logic4.528+route4.197ns，WNS−0.910ns。
仅改变 Root FAST OUTPUTS 的五项组合加法，N=W+4（生产18位）；保留每个输入的有符号解释、路由 CSR、18位截断及 Root limit.x 同步边沿，guard5限幅/CSR不变。
数学：a+b+c=(a XOR b XOR c)+2*((a AND b) OR (a AND c) OR (b AND c)) mod2^N；先同宽符号扩展，逐次压缩，最后一次 N 位进位加法。任何带符号溢出/截断均保持原位模式。原始五项W位和也可容纳于N位。
新增反馈周期0；不动 IIR/PID递推/流水级、ADC/DAC/平台/时钟/XDC/CDC。风险是 LUT/路由拥塞和综合重排，必须看完整 route 的 WNS/TNS/端点，不以综合或局部分组通过代替签核。
验证：冻结原表达式，真实 unsigned CSRStorage/CSRBank+signed offset影子FF，14/25位全N位差分和整数oracle、路由所有组合/非法索引、极值/部分写/复位/CE/双限幅；全部既有回归，生成 CSR/XDC 核对，独立综合/route/CDC只读审计。失败保留不合并。
