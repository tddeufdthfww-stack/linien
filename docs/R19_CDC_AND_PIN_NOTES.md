# R19补充：CDC变化和不存在的同步S引脚

2026-11-10，只读审计r19_mapped；routed DCP分析前后SHA一致。

快速PID全部实际映射顺序单元最差+0.349ns，/D=+0.349ns，/R=+3.761ns，/CE=+0.538ns。本次实现没有可报告的快速PID物理/S引脚，audit的get_pins -quiet计数为0，所以没有生成fast_S.rpt；应标NO_MAPPED_PIN，不能把缺少报告当作独立/S时序PASS。当前/D与全部DSP/FD顺序单元报告覆盖现有数据/控制引脚，但全工程仍WNS=-1.852ns、STA FAIL。

CDC-1=441、CDC-10从2变1，同时出现CDC-13=1；其他CDC-2/3/4/15=14/4/1/374。这不是跨域安全改善的证明。新增CDC-13：red_pitaya_scope/i_bridge/sys_wr_reg/C → red_pitaya_scope/adc_rval_reg[1]_srl2___linienmodule_iir_z0_cohort1_reg_r/D。

实际布线后功能网表中，该端点为SRL16E，A=1（两拍）、CE=1、CLK=sys_clk、D=p_1_out；后接FDRE adc_rval_reg[2]_linienmodule_iir_z0r_reg_r，R=0。p_1_out由LUT4(sys_rd,dst_do,dst_sync[1],sys_wr)驱动。Vivado合并/重构了共享的状态或复位序列，不能仅根据包含iir_z0_cohort的名字认为这是新系数跨域；同样不能因为仅改同域数据流水就豁免该CDC。需要审查原bridge握手保持窗口、这条组合控制链及SRL实际采样关系、复位和物理约束。当前结论为NOT_PROVEN，未新增false path/clock group等掩盖告警。
