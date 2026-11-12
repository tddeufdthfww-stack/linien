# Z7020 Gen2 工程验收口径（工程假设与证据分列）

用户于2026-11-12明确授权：官方查不到的PCB/时钟信息由工程师决定验收口径并继续，不因资料缺失停工。此授权用于制定保守设计边界，不把未知数写成测量事实，也不把负STA改成通过。

## 支持的硬件与工作配置

目标为STEMlab125-14PRO Z7020Gen2、xc7z020clg400-1、官方V2r0 RevA开发原理图的ADC/DAC/FPGA接线。该版本是当前受支持的参考硬件配置，不宣称已经核验用户实物背面丝印。已有PS7/DDR/AXI适配保持；官方网页1GB RAM与开发图简化框图4Gb标注不同，不据此擅改已验证PS7。

125MHz/8ns、内置时钟模式，E2 CLK_SEL高或不接。外部改频、运行中时钟切换不在此版本支持范围；官方明确改频需复位或重配置。E1现有GPIO按独立异步控制/状态位使用，不作为外部同步采样总线或时钟输入。此为本版支持的接口协议，不代表已获知实际接线。

## 证据与自行选定的保守边界

官方事实：ADC LTC2145-14，DAC AD9767，14位双125MS/s；DIO0-7 LVCMOS33，DIO8-10为2.5V。官方只公开开发原理图，无完整PCB走线时延表。

工程自行选择：ADC相对PCB传播偏差预留±0.200ns，另要求保留0.100ns正裕量。DAC总数据眼只有4−2−1.5=0.500ns，不能给setup和hold各强塞0.300ns而制造数学上不可达的目标；其预算须从实际全角结果反推，并明确报告最大可容许PCB偏差与保留裕量。零PCB模型尚为负时，任何非负PCB预算都不能批准。±0.200ns是ADC设计验收假设，不是公开规格或板测结果；仅对标准官方板卡连接和片内板载接口成立，扩展线缆不包含在内。如果以后实测或更完整官方资料超出选定边界，必须重签。正式报告必须同时列零PCB必要模型与加预算结果。不能以预算抵消已有负slack。

ADC按官方数据手册真实CMOS/时钟到输出关系、原样本编号检查全部28位，并保留已证明的同字0/-8约束。不因默认setup分析错配采样周期而放宽要求。

DAC数据继续要求tSU>=2.000ns、tH>=1.500ns；3.3V交织CLK/WRT/SEL协议独立核对。ADI官方员工确认交织每路125MS/s支持能力，但公开答复未明确给出替代3.5ns脉宽数值，所以不能把它写为“数据手册脉宽数值PASS”。可另评估“与官方Gen2参考输出结构一致”的应用工程验收项；必须明确这是按板卡厂应用方式接受的风险，和数据手册逐项保证不同。没有这一项的明确适用波形与输出比较证据时仍OPEN。

## 必须达到的门槛

1. 硬件功能全回归PASS，包含固定点、饱和、复位、CE/动态分频、CSR ABI、AXI背压、bundled-data CDC故障/取消、IIR/解调/限幅与实际IO原语。冻结源SHA；原版/R2b/R4a/R16/R60/R80不变。
2. 新硬件新综合、布局、route分别记录；最终所有已约束路径WNS>=0、TNS=0、setup违规0，WHS>=0、hold违规0，WPWS>=0；核心8ns保持。PCB预算与附加裕量按上节明确检查。
3. no_clock=0、内部未约束=0。所有无input/output_delay端口逐个按真实协议分类；异步独立GPIO、静态LED、非同步PWM可按适用协议验收，不声称外部有同步setup/hold保证。真正同步端口不能漏约束。
4. CDC需逐类证明控制同步器结构/邻近布局/首级Q无扇出，bundled-data需验证稳定期覆盖握手、物理最小保持/最大到达与复位/取消。数量减少不是证明，不伪造MTBF实测。
5. DRC Error/Critical=0；性能型DSP流水线建议按具体功能/时序证据评审，不为清零而新增反馈级。RTSTAT no-load要证明是无功能负载残留，不能当成未路由负载通过。动态OPMODE必须核对所有可达模式不含不允许的组合反馈，不能全局waiver。
6. 外部DAC复位在时钟稳定/状态机就绪后释放，失锁复位响应明确；真实输入停钟不承诺无缝恢复，保持原规定显式PS复位。

以上达成可产生带SHA的“标准参考硬件下、限定接口配置的上板验证镜像”，仍不等同实板运行或激光锁频性能验证。实际烧录/驱动激光/PZT/修改启动镜像需另外明确操作授权和硬件条件，当前不执行。闭环带宽目标100kHz不是已验证性能，ADC转换/DAC模拟建立/激光/探测器/PZT频响尚未实测。

来源（查阅日期2026-11-12）：
- https://redpitaya.readthedocs.io/en/latest/developerGuide/hardware/GEN2/125-14_Gen2_Z7020_Pro/top.html
- https://downloads.redpitaya.com/doc/Schematics/Schematics_STEM_125-14_PRO_Z7020_Gen2_V2r0_RevA.pdf
- https://www.analog.com/media/en/technical-documentation/data-sheets/AD9763_9765_9767.pdf
- https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/164567/ad9763-ad9765-ad9767-interleaved-mode-with-125-msps-update-rate-possible/380408
- https://ez.analog.com/data_converters/high-speed_dacs/a/documents/c/ad9767-faq/DO13491/ad9767-input-timing-for-interleaved-mode
