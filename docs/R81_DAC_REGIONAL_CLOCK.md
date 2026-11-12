# R81 DAC区域时钟候选：实施前依据 / 2026-11-12

R80输入60ba54e9保留在独立分支；本轮只改analog.py可选DAC时钟来源，新增dac_regional_clock.py，Root显式启用。原CRG/PLL、SYS/PS、ADC、算法及CSR完全不动。原r80_analog.py按RAW冻结供对照。新增数据寄存器级0、吞吐率双125MS/s保持；MMCM锁定使IQRESET释放变晚，必须单独测试。

原内部已+.055ns，但DAC必要data -0.343/+0.070；SEL低窗口-.883ns、CLK提前WRT .5ns模型-.829ns。不得通过删约束签核。本候选250MHz输入→独立1000MHz MMCM→四个HPC/BUFIO，data250相位0，WRT250相位22.5°，CLK250相位-90°，SEL125相位28.125°。原ODDR反相后，理想data边沿0/4，WRT上升2.25/6.25、下降.25/4.25；CLK上升1/5、下降3/7；SEL变化.625/4.625。

稳定理想边沿证明：data仍0槽旧A、4槽新B，原frame/frame_seen与数据FF均不动；WRT上升落在各4ns字槽中且SEL仍指同一通道。每槽setup理想2.25、hold1.75ns；SEL在两个时钟均低的.25..1ns内变化，距两边各.375ns；CLK领先WRT1.25ns且距前WRT2.75ns，满足必要先后/2ns keepout。这只是无传播延迟的可行排布，不预判PVT/PCB实际结果。新BUFIO仅驱动OLOGIC，不驱动fabric，原frame_seen仍sys_double。新增reset同步器用原SYS clock异步置位、双边沿释放，MMCM未锁定不可认为输出合格。

UG472规定仅MMCM CLKOUT0..3可直接经HPC到BUFIO，PLL不能替代；COMPENSATION留默认交工具按拓扑选。四个实际BUFIO必须在DAC bank/region内合法放置，输入关系、所有hold、ADC与PS路径仍完整签核。不能用CLOCK_DEDICATED_ROUTE FALSE绕过失败。

先用实际原CRG/新增MMCM/BUFIO/FDRE/ODDR/复位同步器UNISIM验证：全14位/word索引、旧A新B时隙、WRT每次锁存值、SEL通道、ADC同拍、启动/两轮PS复位/停钟重锁；按实际边沿独立记分，不用时间容忍掩盖整拍。现有回归的默认analog保留旧行为，新测试必须明确regional=True。之后新生成CSR语义核验、新综合/route，保留所有失败。

板级3.5ns pulse数值规格、真实PCB/SI未闭合；此实验不能单独将整机变成可烧录正式版本。2021ADI回复确认每路125MS/s能力和SEL低窗含义，但不是数值短脉宽豁免。不降低采样率，不改滤波器阶数，不开时序例外。

参考：https://www.amd.com/content/dam/xilinx/support/documents/user_guides/ug472_7Series_Clocking.pdf
https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/164567/ad9763-ad9765-ad9767-interleaved-mode-with-125-msps-update-rate-possible/380408

## R81 首次实际原语功能完成

native06 PASS，实际原CRG PLL+新增MMCM+4BUFIO+FDRE/ODDR及双级复位模型；每次WRT锁存独立按SYS样本索引验证旧A/新B，两个通道各16384值完整覆盖，ADC逐拍一致、DAC双锁存/内部÷2更新独立模型按帧一致；启动、再次PS复位、参考停钟时保持IQRESET、参考恢复后显式PS复位重锁均覆盖。具体计数见native06 simulate.stdout.log。Vivado FDPE输出100ps/ODDR specify100ps已精确计入控制边沿断言，不用于放宽字序。native01语法、02-04原断言未计原语100ps、05恢复流程缺少原PLLE2要求的PS reset，全部原始FAIL保留。硬件区域时钟参数从native01到06没有改动；不是通过放松数据比较解决失败。

参考丢失后原CRG PLLE2不保证无复位自行恢复；测试确认保持IQRESET，再施加PS reset恢复。没有宣称自动无缝恢复，不改原CRG。所有新MMCM波形仅锁定/复位释放后合格，停钟/抖动的真实电气特性仍需物理与板测。

只读R80器件数据库确认X1Y2四个BUFIO和MMCME2_ADV_X1Y2均空闲；无占用、无修改原DCP。新实现使用R80精确SHA82adfcf0...作为incremental reference，尽量保留已闭合内部布局/路由；新综合及所有真实路径仍完整分析。不是复用旧综合，也不豁免新MMCM传输时序。综合/route尚待，fresh整套回归尚待。正常反馈新增数据级0，累计R2b+32ns非端到端实测。

## R81 实际失败与独立后继 / 2026-11-12

输入4e86132d0d1c200dbbebc24bc578ba04dfb26639，新生成CSR语义PASS、新综合COMPLETE（WNS/TNS=-0.773/-79.039ns）；actual route COMPLETE，WNS/TNS=-0.478/-6.52ns、21 setup端点，WHS/THS=-0.556/-7.281ns、14 hold端点，WPWS=0.833ns。source_changes=[]。最终STA FAIL，REJECTED_NOT_MERGED，不能作为可上板正式版。

实际原CRG原语定向PASS，但补充Bare通路模型FAIL：参考+123出现，候选未出现，IO边沿采样的selectB始终1。原始RTL/TB/日志/SHA与波形诊断完整保留，不能把该模型FAIL说成已验证板级故障，也不能用原语某一启动相位PASS覆盖。fresh整套功能NOT RUN。

ADC全部28条setup+.429/hold+3.304ns、同字0/-8逐条PASS。54ASYNC/27同SLICE配对、一级Q仅到二级D；GPIO16级间setup7.193/hold.122ns。旧只读审计因无负载FF/Q的get_property空集合失败，原FAIL保留；v2单独记录无连接Q并完整报告全部时序，未改DCP/约束。

当前不同MMCM输出驱动数据与WRT。.177ns clock uncertainty中包含.120ns跨MMCM输出PhaseError；实际min最差在Slow角，不能只用Fast角典型值或调小uncertainty“修复”。后继R83在独立分支把WRT真正接到DATA同一CLKOUT0/BUFIO，由工具重新计算共享路径与相位误差，保持data提前.5ns防止同边沿采样歧义。不改变原CRG/PLL/SYS/ADC/PS/算法/CSR、时钟周期、IO2/-1.5预算或时序例外。

原件见experiments/r81_rejected_physical_20261112；DCP SHA256=ab74f022bfe44585d2eb51079a24a8c82542f1f158b064467050197c9dc0b132。保留R80最佳内部已闭合候选60ba54e9；新增反馈整数级0。R82相位提前.5ns不是少8ns，端到端硬件/ADC转换/DAC模拟建立/激光环路未测。DAC外部3.5ns脉宽、CLK/WRT/SEL完整协议、真实PCB/SI、物理CDC/DRC仍未签核，不生成bit/bin、不刷写、不驱动激光/PZT。
