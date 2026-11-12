# R76：交换乘数候选的定向物理优化

## R76物理候选输入 / 2026-11-12

源为R75 769a86b0a91b4c8a1dd1a4c73cc4abed98dbd954实际routed DCP，SHA256=0d568f7c3e1d0476b81dd7a30a3471563898d697cc822ca97032777911820b1f。
硬件源码逐RAW同R75，无RTL改动。综合明确REUSED_R75，功能引用R75新107706拍IIR及32000拍FastChain定向PASS，fresh全功能尚未重跑。
R75actual -0.365/-6.307ns、34 setup，hold+.025/0，pulse1.5；原IIR CE已+.138ns，仍有IIR数据-.003ns、common/phase/限幅布线长路径及14DAC失败。
本轮仅phys_opt_design -placement_opt -routing_opt -critical_pin_opt -path_groups clk_2，再route Explore。
不启用retime、FF插入、DSP寄存器搬移、复制、rewire、clock_opt，不改时钟/IO预算/例外。
导出前后funcsim逻辑网表，除已明确物理注释外逐token严格比对；INIT/实际端口/位宽/DSP参数不忽略。若不一致，保留诊断，不接受等价。
所有时钟域仍完整报告；core路径定位不等于只签core。新增反馈周期0，继承相对R2b+32ns；实际总ADC-DAC延迟未测。
actual route/STA/CDC/DRC/IO待独立结果，不能先写PASS。R72基线不覆盖，R73/R74失败不合并。

## R76实际物理完成：逻辑一致PASS，STA FAIL

输入9ee0c2f820f81f4f55fd773b93a119889eb05e21，原R75 DCP0d568f7c不变，硬件RAW源码变化0。仅placement/routing/critical_pin，actual route COMPLETE -0.343/-6.077ns、33setup，WHS/THS+.025/0、WPWS1.500。综合REUSED_R75，功能引用R75定向107706+32000拍PASS，不冒称fresh全功能。前后funcsim除已知物理注释外逐token一致PASS，INIT/DSP配置/端口/宽度未忽略；整体仍未优于R72 -0.343/-4.308、17，未合并完成设计。

内部最差fast_a_multiplier_storage_full_reg[2]/C→fast_a_cordic17_reg[16]/D -.205ns，8.072ns（logic4.068/route4.004），8CARRY4+LUT2+2LUT4+LUT6。ADC28条+.429/+3.304及0/-8关系PASS、52FF/26同SLICE同步器结构PASS。新Scope地址4译码在5个端点成为最差源，旧分类器断言FAIL原件保留；核查同请求发布/保持以及实际wen门控后v3显式分类，不删除路径或例外。库存/保持窗口分类均非整体物理CDC/IO签核。完整原件在experiments/r76_actual_core_physical_20261112，DCP SHA256=04682eb8cb177440c1a97f86b8e020ae7f80e131c703c7d4ed6f2e9ac22267ea。

R77仅修改第一Demod旋转组合表达式并保持原第一拍状态，新增反馈周期0；先数学及14/25位完整pipeline/CSR/复位/整链差分，再新综合/route。DAC完整协议/脉宽/PCB、CDC/DRC仍未签核，不发布可上板声明。
