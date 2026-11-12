# R71 core-targeted placement/routing TNS cleanup

2026-11-12独立opt/r71-core-physical-cleanup-20261112。硬件源码仍逐raw等于R69；R69b有效响应fresh full运行中，不能提前填PASS；原R69严格idle数据等价FAIL保持。

R70实际postroute WNS/TNS=-.343/-5.900ns、70端点，hold+.027/0、WPWS1.5；核心最差-.205ns，为fast_a_iir0_z_low0/CLK→fast_a_iir0_z_high0/CEB2，DSP+LUT2级、7.603ns(logic5.848/route1.755)，不可仅看phase路径名称。新综合NOT RUN，综合REUSED_R69。

R70脚本原严格文本比较FAIL，因为只忽略LOC/BEL，输出增加3处PHYS_OPT_MODIFIED=PLACEMENT_OPT标注。独立证据确认完整diff仅3新增行，额外去掉该精确物理标签后全部原语/参数/INIT/连接逐token相等；原manifest的false与脚本退出1不改，追加placement_annotation_identity_proof.json提供正确限定的逻辑等价证据，不能把原严格比较器说成PASS。

本轮输入为R70实际routed DCP db5c8f6e20818363d39d884136a855d488db484c725c611cd6fb61fce7df8c4b，验证追加identity proof对应SHA后，在独立输出目录执行phys_opt_design -placement_opt -routing_opt -tns_cleanup -path_groups clk_2，再实际route Explore。path_groups只限制优化器工作范围，所有时钟和路径仍完整计时、报告，不增加任何时序例外。不开retime/FF插入/复制/寄存器优化/rewire/clock_opt，无新增反馈级；不改Migen/CSR/ADC/DAC/PLL/电气参数/时钟周期。

逻辑before/after完整funcsim严格比较，只忽略注释、LOC/BEL及精确PLACEMENT_OPT物理标签；输入canonical hash还须等于R70独立证明的canonical hash。原DCP前后SHA保持。若发生实际逻辑变化，不接受等价。全局DAC仍-.343ns必要预算，DNA旧+.009ns裕量很小，必须继续核查所有setup/hold/pulse/CDC/I/O/DRC，不能仅拿core过线宣称可上板。
