# R72 core LUT physical pin optimization

2026-11-12独立opt/r72-core-pin-opt-20261112。Migen/Verilog/CSR/PLL/约束源均逐RAW保持R69，功能参考R69b新完整有效响应契约PASS（20a397d输入；4c4f965记录），原strict无ACK payload差分FAIL保留。

R71-v2实际route WNS/TNS=-.343/-5.363ns、24端点，hold+.027/0；core最差-.234ns。输入DCP SHA256 55c46b57ccc79a6662765b7265a33a2ca52f9f2af0abdbfae13f6ddf4b11efc7。整体未签核。

R71-v2自身before/after逻辑token已严格相同；原脚本退出1是跨checkpoint重载的canonical检查：R71重开R70 DCP时多出30个PinAttr:HOLD_DETOUR数值布线元数据。所有diff仅这些新增属性；独立证明四份完整export（R70 before/after，R71 before/after）去掉明确的物理标注后，所有实际原语/INIT/参数/连接一致。原manifest false和退出1保留，追加proof绑定全部文件SHA及DCP SHA。物理hold属性从未删除或改写，实际WH仍完整检查。

本轮只phys_opt_design -critical_pin_opt -path_groups clk_2，然后实际route Explore。依据本地Vivado2020.1 help，此选项在LUT慢物理输入脚到快输入脚之间交换，逻辑输入函数仍应相同。无新reg/pipeline，无retime/寄存器优化/复制/rewire/clock_opt，无数学/软件接口变化。综合REUSED_R69，功能REUSED_R69b，新的实际物理与before/after逻辑等价必须各自报告。

比较器仅忽略注释、LOC/BEL、PHYS_OPT_MODIFIED以及数值PinAttr:HOLD_DETOUR路由标签，其余INIT/连接/寄存器/DSP参数严格不忽略。若pin优化引起真实逻辑连接/INIT变化，不能直接声称等价，必须保留diff并另证函数。所有时钟/路径仍完整计时，没有增加任何例外。保留原DCP且核验前后SHA。DAC必要预算仍-.343ns，board I/O/CDC/DRC未最终关闭，不部署。
