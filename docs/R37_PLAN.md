# R37 / 2026-11-11：允许tap限幅值与末级选择合并，新增周期0

独立分支基于R36代码52fba6b/归档0f6649a。R36功能完整PASS、综合/route COMPLETE，但WNS−.656略逊R29−.617，已失败保留不合并；R36 TNS−59.314/371端点和资源12485LUT/13648FF优于R29，作为下一实验输入，不追认正式保留。R2b/R4a/R29/原用户工程保持。

1. 只删除parallel_tap_limit.py中正向limiter.y与负向neg_value的两处KEEP调用；common_sum和两类railed KEEP保留，不改变并行算术/比较的RTL。
2. 去除的仅是综合元数据，忽略这两条attr.add后的完整行为AST应与R36一致；模2^N运算/上下界优先级/最小负数回绕/CSR热写/CE/reset/所有同步语句完全相同，数学结果每拍恒等。
3. 原14/25位真实CSR/整数oracle/冻结LimitCSR差分、全FastChain30000拍和全部PID/IIR/Slow/robust51628/AXI/CDC/Scope回归重新运行；独立SHA、综合及route。
4. 核查数据选择节点是否合并、关键D/S/R/CE与实际路由、所有违规端点/CDC/覆盖/DRC；WNS/TNS/count综合选择，失败保存不合并。

路径依据：R36 fast_a_common_reg[5]/C→paralleltaplimitcsr0_y[17]/D −.656ns，9级/2CARRY4/1MUXF7，logic2.435+route5.703。原FF Q实际扇出4，不应照搬R35高扇出复制。路径经过common_sum、tap加法、neg_value1饱和选择及最终tap/invert选择；neg_value选择节点扇出29、布线1.259ns，末端还有LUT5/MUXF7。允许限幅值与最终选择跨网优化可能省去级数或重分配局部逻辑；实际能否受益以route为准。

原railed、neg_rail_value及common_sum的KEEP保留。没有删除饱和比较或错误标志，不减位宽、不改滤波阶数/吞吐、不加时序例外/放宽周期。风险是工具可能重构或共享限幅数据路径，降低并行度、增加面积/扇出或使时序恶化；原全功能语义由同AST和原生测试约束。

ADC→DAC、robust、GPIO新增周期均0，不携入R34外部GPIO8ns和R35索引副本；R28指定组件模型Bare72.1ns/快慢108.1ns继承，非本轮重测/fullRoot/SDF/板端。Scope同ADC域与握手跨域仍分开审计，CDC物理安全NOT_PROVEN，完整最终签核未完成。无bitstream/板卡/激光/PZT操作。
