# R62 ADC falling-edge capture / DAC output-drive candidate

2026-11-12。独立分支opt/r62-adc-fall-dac-fast-20261112，父代码4aba6ce。
冻结R61b与R60不变；R61b完整功能PASS、综合COMPLETE、route COMPLETE，但routed
WNS/TNS=-.232/-2.317ns、25失败端点，WHS=.010/THS0、WPWS1.5。
no_clock=0、内部未约束0，外部I/O/物理CDC/DRC尚未签核。原生及物理原件见
experiments/r61b_fresh_full_20261112，输入/输出RAW SHA分别保留。

1. analog.py只把ADC输入的同一组寄存器改为FDRE IS_C_INVERTED=1、IOB TRUE。
   原有14位变换T(v)=concat(~v[2:15],v[15])完全不改。新增整拍串行FF数0，采样
   边沿相对sys上升沿移到+4ns；PLL/引脚/频率/吞吐率/CSR保持。ADC CLKOUT上升后
   intrinsic skew=0..0.6ns，下降沿可置于稳定字窗口；实际IBUF/时钟插入与下游
   半周期4ns路径必须在真实PVT STA通过，不能只依据理想时序推断。
2. 必须单列采样契约：设CLKOUT rising n*8ns后数据变为word[n]，在n*8+4ns捕获，
   下一sys rising的消费者使用word[n]；旧理想零延迟posedge模型可能使用word[n-1]。
   因旧板级捕获未签核，不能声称原采样编号/端到端物理延迟已逐拍等价，也不把它
   写成“零相位变化”。原生测试检查样本编号、双通道、极值、复位与DAC编码/时隙，
   按该明确边沿契约判定；后续板端解调相位仍需实测校准。
3. hw_platform.py只将DAC data SLOW/4mA改为FAST/8mA，与wrt/clk/sel驱动一致，
   不改任何管脚/电平/PLL/软件。希望减少数据相对转发时钟的实现偏差，但效果待
   actual route，不预报WNS改善数字；更快边沿的噪声/过冲仍需板端SI验证。
4. 先原生模拟实际Migen输出+厂商FDRE/ODDR、再全回归与全新综合/route；新增真实
   ADC/DAC必要延迟预算要在实现前生效，先明确零PCB偏斜诊断或声明的偏斜范围，
   不冒称已知实际PCB。I/Q SEL须只在IQWRT/IQCLK均低时变动，IQCLK/WRT关系及
   手册3.5ns脉宽另核对；当前250MHz/50%时钟不能仅凭setup/hold通过认定全部满足。
5. R61b新CDC复位结构的物理路径/保持窗口/异常集成还需闭合。不得全局cut异步数据、
   放宽8ns周期或隐去未用GPIO/LED/PWM的未约束性质。失败源码与报告均保留不合并。

依据：官方Z7020 Gen2 V2r0 RevA原理图（器件LTC2145CUP-14/AD9767ASTZ、MODE=0、
DVDD3.3V，公开图不是实物PCB丝印/走线偏斜证明）；LTC2145-14 full-rate CMOS
Table/时序图；AD9763/9765/9767 RevG Table3、Figure64及ADI官方EngineerZone补充。
来源URL、下载SHA和必要算式将随本轮结果单独保存，不上传完整第三方资料。

仍为候选，不生成可部署签核声明，不烧录、不操作激光或PZT。
