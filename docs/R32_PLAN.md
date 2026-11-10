# R32：R28冻结综合检查点，重新布局与激进扇出优化

回到有效硬件代码R28 9c5c32a，独立分支从R29记录5903089建立，不携带失败的R30/R31阈值结构。R30全并行把瓶颈移向sum_diff（−1.204），R31分组把瓶颈移向高位index（−1.407），均仅功能PASS/物理失败，不合并。

R29较优post-route −.617/−91.147、545端点，已验证控制路径logic2.973+route5.330，现有初始摆放限制了后续局部移动空间。R32只替换实现策略，复用同一个R28 synth.dcp和74个硬件/测试原始输入SHA，RTL/8ns XDC/CSR/时钟/流水级不改；功能与综合明确REUSED_R28_NOT_RERUN，不冒充新执行。

执行opt_design，place_design -directive Explore，**布线前**phys_opt_design -directive AggressiveFanoutOpt，再route_design -directive Explore -tns_cleanup。2020.1本机help支持这两个directive，避免已证实不支持的post-route fanout_opt。没有retime/AddRetime/clock_opt/负沿FF插入选项，不修改约束；物理复制保留触发边沿，0新增串行反馈周期。此项不是数学算法更改，等价依据是完整原硬件/RTL测试SHA及同综合DCP；仍非形式postroute/SDF等价。

保存物理优化前后placed.dcp及最终routed.dcp、源/输入SHA前后核对、所有WNS/TNS/hold/pulse、PID D/S/R/CE与outgoing、IIR和CDC/DRC/覆盖。跟R28默认和R29后优化分开比；若退步或未显著改善，不反复盲试策略，失败保留再回实际算术/布局根因。始终不动保护基线或板上硬件。
