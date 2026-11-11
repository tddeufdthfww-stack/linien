# R47：违规IIR DSP输入使能LUT的局部物理复制

基线R46 827dfec/b7b94f3，原生全功能PASS，综合/route COMPLETE、最终STA FAIL。route−.539/−18.344ns、131端点，WHS.049/THS0/WPWS1.5；三项优于旧R40。阈值MSB+.654/8级4CARRY4，预取全部+.171、fast PID outgoing+.367、Scope缓存→数据+1.381、CSR data输出+.168；剩global FastB IIR0 lowDSP CLK→highDSP CEB2，5.972logic+1.957route，3级(1DSP+2LUT6)。不携入R45 IIR源重定时。

1. 复用R46全部原始硬件/测试SHA、routed.dcp，只在内存unroute；实际查询ADC clk_2、BREG1/BCASCREG1、CEB2有负slack且由单个普通LUT驱动的IIR DSP，按真实端口和slack选择，非仅名称猜根因。
2. 使用标准force_replication_on_nets分发这些LUT输出；原组合truth table/输入网按每DSP使能逐项记录，原状态/DSP参数不改，新增串行边沿0。全segment/leaf统计负载。禁止复制ASYNC_REG或随意改DSP寄存器参数。
3. CSR数据只选择非ASYNC_REG、CE恒1、Q负载>=192且其真实输出最差slack<0者，当前R46该组+.168ns，预期不额外扰动；如实际非同则记录原因与候选列表。
4. 只placement/rewire/critical-cell后route Explore/tns_cleanup，不retime/clock_opt/DSP/BRAM寄存器优化，不改XDC/周期或新增例外；保存复制前/后/route表和94DSP属性，真实route判断WNS/TNS/端点/hold/coverage/CDC/DRC。
5. 完整功能及综合明确REUSED_R46_NOT_RERUN，物理结构/route为本轮新执行；相同SHA和标准复制不当作postroute/SDF/形式等价或物理CDC签核。逐个使能LUT的直接输入函数在复制前后作静态truth-table审计，若网络重构不能直接匹配先诊断，不伪称通过。
6. 与R46整体对照，恶化保留失败不合并、不部署；仅WNS改善而TNS/count变坏时保留tradeoff点，不冒称整体胜出。原用户工程/R2b/R4a/R16与现有候选分支均不动。
