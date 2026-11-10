# R17：混合器MREG一级与完整采样/配置对齐

2026-11-10。基于冻结R16，独立分支；R16/R4a/R2b/原用户工程不动。R16 WNS/TNS=-4.068/-5780.718、5437端点，STA FAIL。

## 修改前依据与架构比较

最差DSP48E1_1/CLK→error_limit.y[8]/D，11.684ns=logic6.876+route4.808；DSP CLK→P[7]自身4.009ns。A方案增加MREG一级8ns，把乘法与37位求和/限幅分开；B再给求和一级，共16ns，仅在A不足后考虑。本轮只做A，不预报WNS改善值，也不保证所有其他IIR路径同时通过。

数学契约：混合器M_new[n]=M_R16[n-1]，原37位模加法、负数右移、9位系数/CSR部分字节写和复位均保留。DSP A/B寄存器沿用R16，MREG每sys更新，不跟随FastChain CE冻结（系数仍可能热写）。两个bias（先27位3X）、offset、dual及单通道A均寄存同一拍，不能只给DSP加MREG。global reset将乘积和元数据置零；未知的GSR期间不当成功能有效拍。

误差Limit的输入晚一拍，所以min/max配置shadow一拍，保留旧Limit内部bounds/y/error寄存器，并以延迟一拍的limit CE执行。直接ADC和pid_only模式也延迟一拍。新MixerAlignedPID不加积分反馈寄存器，只延迟running、无符号setpoint、Kp/Ki/Kd/reset及接受CE，再复用旧两级PID数学；CSR读写不冻结。

raw IIR的输入整体晚一拍，其系数/z0配置也增加一拍快照，保证热写与数据同一时间线。IIR乘加/反馈/位宽/阶数/吞吐/相对其输入的latency CSR均不改，FastChain IIR不改。原数据链公开监视量会相应推迟8ns；原始ADC监视不推迟。输出路由/调制/扫频控制保持原定义，混合DAC输出不能一概宣称整体波形平移。

## 延迟与控制目标

快PID贡献及Bare路径相对R16增加1sys=8ns，快主支路相对R2b累计24ns；已有慢链额外16ns保留，固定快A→慢→B串接相对R4a额外24ns（在用户32ns内先评估目标内）、相对R2b累计40ns。robust自身判定8ns不再增加，但选择处理后误差信号时，采集/锁定时机需计入误差信号新增8ns。P-only数字模型预计Bare64.1ns、快→慢100.1ns，均为待测预测，不是板级值。
新增8ns纯延迟在100kHz/1MHz为-.288/-2.88度；100kHz/未来1MHz是设计目标，未知模拟响应不停止本次工作，也不构成闭环稳定证明。

## 验证与保留标准

生成原生RTL/UNISIM+glbl，独立冻结R16/原始表达式参考，全部512系数/单双通道/offset/37位结果、min/max饱和/真实CSR部分字节热写/独立CE/全局复位；14/25位完整PID9字段与原始输入/配置单独一拍延迟参考；生产链联合模式切换；raw IIR输入/全部CSR一拍对齐参考。先数学依据再测试，FAIL日志和源码保留。
全部已有14/25位/CE/AXI/CDC/四相位及R13/R14套件、CSR map/XDC字节、独立新目录综合和实际route；分组D/S/R/CE与DSP内部端点、CDC差集/覆盖/DRC/数字延迟。构建时冻结源SHA；不降125MHz，不增加掩盖违例的例外，不生成/部署bitstream，不操作板卡/激光/PZT。WNS恶化不合并；功能PASS、综合/route COMPLETE、最终STA严格分别记录。
