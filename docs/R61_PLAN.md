# R61：R60冻结后的集中签核检查与DNA时钟/hold修复

输入R60 c39e3fa，实际routed+.003/0ns/0端点，未约束DNA_CLK1、DIN/READ2、输入44/输出46；物理CDC和DRC未关闭。独立工作树，原用户/R2b/R4a/R16/R60保持。不重移植硬件，不变PS7/PLL/引脚/ADC-DAC/CSR/PID/IIR数据和精度，每拍吞吐及快速相对R2b+32ns保持，本轮新增串行周期0。

1. 对原DNA cnt[0]/Q建立实际sys125MHz的divide2派生时钟（62.5MHz），原128边沿突发/停钟结构不改。DS187 v1.21 DNA_PORT上限100MHz；不添加false/multicycle/clockgroups。只读探针发现原两条未约束端点变为hold负路径READ-.320/DIN-.188ns，真实修复而非消警。
2. 在冻结R60 DCP上aggressive_hold_fix插入物理数据延迟，再实际route，独立保存before/posthold/final setup/hold/pulse/coverage/CDC/DRC。输出网表对输入做状态/组合功能审计；新增纯延迟缓冲不等于新增反馈寄存器。源完整功能在本工作树独立重跑，综合明确复用R52经R60。
3. 两桥和GPIO同步结构按实际routed数据/控制完整路径、同步FF位置与最短/最长延迟分析。held-data源与请求同步、捕获、应答的窗口逐段核对；不因计数下降或同步属性存在就签核。复位与PLL失锁独立标明支持范围。
4. 官方PRO Z7020 Gen2 V2r0 RevA开发原理图确认LTC2145CUP-14/AD9767ASTZ及当前所用ADC/DAC/E1映射；用户实物PCB修订、E1接线和外部时钟选择仍未知。以数据手册内在时序+零PCB差分偏斜作独立必要预算诊断，明确NOT BOARD SIGNOFF；该诊断约束只在保存物理候选之后的内存副本使用，不写入物理候选DCP，不假定PCB偏斜为0。ADC全速CMOS相对CLKOUT+上升tSKEW0..0.6ns，DAC交织数据相对IQWRT上升tSU2/tH1.5ns；IQSEL/双时钟低电平/500ps关系与启动复位另行评估，不能仅数据延迟通过就称接口通过。
5. DRC逐条分类，特别p_1_out PREG0/OPMODE稳定可达05/35与物理瞬态证明的区别；不压告警或盲加流水线。汇报功能PASS/综合复用/routeCOMPLETE/受约束STA/物理CDC/外部IO/最终签核各自状态。失败结果完整保留，不合并R60，不生成bitstream或上板/激光操作。
