# R26：Scope平均使能从32位掩码移到数据末端，新增周期0

基于功能修正版R25 759cba4独立工作树。R25实际route WNS/TNS=-.981/-174.051，643端点，WHS.019；生产真实unsigned CSR缺陷已修复，完整旧回归/真实CSR中间值/顶层Verilog类型核对PASS，但STA FAIL。最差scope set_avg_en/C→adc_b_q_dat[0]/D，8.789ns=logic1.830+route6.959，9级LUT/MUX。

原case键D & {32{E}}。已知E=0时键0，输出raw14；E=1时保留D=0 raw、32种单bit因子的48位sum切片、非法因子default sum低14位。可先独立case(D)求mean14，再在原数据FF前按E选raw/mean，精确保持原16位切片赋给14位输出的截断。E为X/Z时，原mask仅在D严格全0时成为已知0，否则case落default；新default显式保留该四态规则。所有数据FF、累加48位、计数32位、adc_dv、触发/BRAM地址/配置/握手不变，无新增数据或控制周期。

只改red_pitaya_scope.v的组合选择组织，新helper定义在同文件，不修改平台源列表或既有AXI/CDC桥。KEEP仅保留独立平均结果以避免综合重新把E推入32位解码。先原生真实helper/冻结原case/独立整数oracle，覆盖全部低16位因子、所有32种有效因子、随机32位非法因子及X/Z严格对照；再完整双Scope模块（旧源码冻结）+实际bus_clk_bridge、100MHz sys/125MHz ADC功能异步时钟、真实配置读写、动态avg/dec、四路不同ADC、arm/触发/重置/BRAM读回全状态逐拍四态比较。功能异步测试不是生产时钟约束修改或CDC物理证明。

完整既有功能/真实CSR/IIR/PID/AXI/CDC回归和CSR/XDC一致后新目录综合+route，检查实际平均使能路径、全局最差与资源/CDC。失败源码和报告独立保留不合并。ADC→DAC反馈新增0周期，Scope采集也0周期、吞吐不变；不增加例外、不放宽时钟，无bitstream/板上操作。
