# R43：R41已验证源域预译码之上的局部物理分发

输入R41 9479e4e/a8f93bd，功能完整PASS、综合/route COMPLETE，但全局−.791/−90.059ns、522端点，故R41整体拒绝未合并。Scope预译码Q→配置CE局部+2.437ns、FCLK/ADC配置+1.460/+1.529ns；新global set_dec[23]→adc_a_dat[7] 9级逻辑，1.634logic+6.943route，路径中LUT6译码网负载169。R43只是独立探索后继，不将失败R41合并任何保护基线。

1. 复用R41完整原始硬件/测试SHA和routed.dcp，在内存unroute；不改RTL/CSR/XDC/时钟/同步状态。
2. 对ADC域非ASYNC_REG、CE恒1的CSR数据Q负载>=192网沿用R40已有效方法；并只选Scope average_select_*单输出LUT驱动且负载>=96的组合网作工具force_replication。
3. 复制是同一状态/组合函数的空间分发，不新增串行边沿、反馈/CSR/Scope/触发周期0变化。保留前后逐FF的D/C/CE/R/INIT及聚合负载、LUT INIT/输入/输出/扇出表；全部94DSP寄存器配置另核对。未做自写算法ECO或CE→D变换。
4. placement/rewire/critical-cell与route Explore/tns_cleanup，实际route/STA/CDC/DRC/覆盖；完整功能与综合明确REUSED_R41_NOT_RERUN，不当作本轮重测或postroute形式等价。
5. 原FCLK载荷/复位/同步器保持，新普通数据副本不是2FF同步器；跨域所有副本与组合译码仍需物理安全审查。CDC数量不作签核依据。
6. 与R41/R40 WNS/TNS/端点综合比较；恶化保留失败诊断，不合并、不部署，不加false/multicycle/clockgroup或放宽周期。不携入R42反馈y KEEP。
