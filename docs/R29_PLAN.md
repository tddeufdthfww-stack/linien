# R29：冻结R28的post-route扇出/关键单元/摆放和重布线

R28代码9c5c32a/记录3f369c6，route−.788/−99.471ns、566违规端点，候选未签核。独立工作树，仅增加本实验驱动和文档；全部RTL/测试/原8ns XDC逐输入SHA与R28匹配。

依据：全局autolock instruction_idx rep3→GPIO[6]replica，logic2.430+route6.172ns，约72%布线；FastChain/tap和PID outgoing亦有4–5ns布线。尝试同网表真实物理改善，不能靠新false/multicycle/降频或未约束端点绕过。

只读输入R28 routed.dcp（前后SHA），新目录写新DCP。明确功能REUSED_R28_EXACT_INPUTS_NOT_RERUN、综合REUSED_R28_EXACT_DCP_NOT_RERUN，不冒充本轮重新测试/综合。新执行phys_opt_design -fanout_opt -placement_opt -routing_opt -rewire -critical_cell_opt，随后route_design -directive Explore -tns_cleanup。参数来自本机Vivado2020.1 help；显式优化列表关闭未指定DSP/BRAM/retime/clock_opt/负沿FF插入；无新增串行数据周期/CSR变化。

物理复制是相同触发边沿/复位的逻辑副本；功能/延迟契约复用R28；不把RTL回归当作本轮post-route/SDF等价证明。比较WNS/TNS/违规端点、hold/pulse、全部关键分组和CDC/DRC/覆盖；即使内部WNS转正也仍未完成外部IO/CDC/板端签核。若退步或命令不支持，保留脚本、错误日志/诊断且不合并，不强行宣称有效。原R28/R26及保护基线不改。
