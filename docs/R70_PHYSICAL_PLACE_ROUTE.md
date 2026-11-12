# R70 placement/routing-only physical trial

2026-11-12 独立opt/r70-physical-place-route-20261112。实际硬件继承R69，输入为R69 routed DCP SHA256 63e1f2a98a3d335dff9880408e35ac0cbf36573d6859663e6bdb6dbd14c2be40；56个gateware/hardware/common实际源文件逐raw一致。R69b有效响应契约fresh full仍运行，原R69严格包括idle数据的FAIL保留。

当前R69最差fast_a_zi0__10/C→fast_b_cordic17[16]/D，14级9carry+5LUT、logic4.140/route4.255ns、WNS-.411。此次只执行Vivado2020.1明确的phys_opt_design -placement_opt -routing_opt，再route_design -directive Explore；本地工具-help确认显式选项禁用其他隐含类别。不开retime、不插负边沿FF、不做DSP/BRAM寄存器优化、不复制FF、不rewire、不clock_opt，不改PLL/时钟周期/I/O参数/约束/CSR/算法/吞吐率。新增正常反馈级0、复位协议不变。

新物理DCP写唯一目录，原DCP只读并核验前后SHA。新综合NOT RUN，综合数据REUSED_R69；actual postroute结果单独报告，不把父综合复制件叫新综合。完整funcsim导出before/after，仅去注释和LOC/BEL物理位置属性后严格字符比较所有逻辑参数/连接/初始化；若不相等则不接受逻辑等价，保留差异诊断。仍须新实际setup/hold/pulse/ADC/DAC/DNA/CDC/DRC报告；相等不代表已经签核。

当前DAC必要零PCBsetup-.343/hold+.070，合法FAST16组合/逐位扫描无可行解，单纯核心布线优化不自动解决外部数据/SEL/CLK/pulse/PCB。ADC28+.429/+3.304、DNAsetup+.009很小，任何新的hold或DNA违例均不能忽略。物理试验按结果保留/拒绝，不部署。
