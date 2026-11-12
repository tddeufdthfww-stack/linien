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
