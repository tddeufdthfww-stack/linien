# R40：CSR写数据同拍物理分发候选

基线：R38代码291fbec、记录3fef5e4，真实route −0.619/−83.023ns，451端点，最终STA FAIL。R39最差CSR数据路径为0级逻辑、8.054ns布线，2/3/4位466–517负载；R40重新检查R38实际网表，不携入R39 Scope CE→D。

1. 从R38 routed.dcp读取、只在内存unroute；核对实际clk_2 ADC域、CE=VCC、非ASYNC_REG的CSR数据FF，选择Q直接负载>=192的网。
2. force_replication_on_nets及placement/rewire/critical-cell，route Explore/tns_cleanup；不retime/clock_opt/DSP或BRAM寄存器优化，不增时序例外/修改时钟或板级接口。
3. 物理复制数学依据：原FF和副本同D/C/CE/R/INIT，每个合法采样沿状态相等，输出负载重新分配，新增串行寄存器级0，CSR/ADC→DAC周期0变化。复制前后逐组核查上述连接与负载集合；DSP寄存器属性独立审计。
4. 全78个硬件/测试原始SHA保持R38，整套功能/综合明确REUSED_R38_NOT_RERUN；本轮新做结构审计、实际物理优化/route/STA/CDC/DRC。不是全Root postroute/SDF等价证明。
5. D来自FCLK跨域桥保持数据，复制不等于同步器，不能证明亚稳态或总线相干安全；输入所有副本与输出系数路径单独分析。已有握手功能测试只复用，物理CDC/独立复位安全仍NOT_PROVEN。
6. WNS/TNS/违规端点与R38/R29/R36比较，恶化保留失败源码/报告、不合并。最终STA、CDC、I/O覆盖未签核前不宣称可上板。
