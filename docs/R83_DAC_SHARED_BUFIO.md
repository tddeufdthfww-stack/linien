# R83：数据与WRT同一BUFIO / 2026-11-12

R82 frozen56f8772b保留，实际route-.484/-6.200ns、16setup，hold-.562/-7.362ns、14端点，不选用。先前native和Bare通路PASS只证明功能，不能覆盖STA FAIL。新独立R83硬件只改analog.py一行：regional的write_domain从dac_write_io改为dac_io，使14数据IOB与WRT ODDR真正共用同一MMCM CLKOUT0/BUFIO，不改MMCM输入或任何数据寄存器。

实际R81/82报告确认源数据CLKOUT0、目的WRT CLKOUT1；R82时钟uncertainty .183ns含MMCM跨输出PhaseError .120ns，同时源捕获不同分配分支造成额外min/max相对差。不能靠降低.183数值签核；本轮从结构上改为真正同源，再由工具自行计算不确定度、CPPR和所有PVT角。未使用输出1的BUFIO允许综合自然删除，不做全局DONT_TOUCH/waiver。

功能依据：DATA仍SYS前.5/后3.5ns采旧A/新B，WRT由同一250MHz时钟反相ODDR产生，理想上升SYS+1.5/+5.5，相对data理想setup2/hold2ns。SEL .125仍位于WRT下降-.5到CLK上升.5的共同低窗内，距前边.625、距后边.375；CLK .5领先WRT1ns，距前WRT3ns。所有14位、吞吐率双125MS/s、样本编号、CSR、ADC、PID/IIR/PS/原PLL完全保持，新增反馈级0。

新native逐WRT oracle仍逐字严格对照冻结R80与独立SYS样本；只将预期WRT pad phase按真实结构改为1.6/5.6ns（100ps ODDR模型），不放宽数据检查。Bare正负脉冲要求数据仍71.6ns，对应WRT从R82 73.85改为73.6ns（相对R80 74.1提前.5ns），新旧无整拍延迟容忍。接口波形相位有意改变，不能声称逐时刻clock波形完全相同。先功能再新综合/以R80原DCP作增量参考的实际route，失败保留不合并。

本轮未放宽任何8ns时钟、IO setup2/hold1.5预算或例外。CLK/WRT/SEL全协议、ADC同字0/-8、物理CDC/DRC和3.5ns外部pulse/真实PCB仍必须独立检查；不因架构合理预判PASS，不部署。

## R83 实际功能与延迟定向PASS

73474次原语逐WRT数据/通道检查、37205次ADC、36731组DAC锁存输出、双路各16384取值、3次epoch，全部PASS。原语100ps传播精确计入，参考停钟后按原PLLE2要求显式PS reset恢复；不宣称自动恢复。正负123的Bare通路独立真实CSR/输入寄存器/限幅/PIO原语模型PASS：数据R80 72.100/R83 71.600ns，对应WRT R80 74.100/R83 73.600ns。两者早.500ns、样本编号不变；cycle标签8/9只是小于SYS边界，不是少8ns。

证据/SHA在experiments/r83_shared_native_20261112。本轮硬件相对R82只有analog.py的WRT clock source一行变化，新完整回归仍须独立运行，先前R81/R82物理失败不能作物理PASS依据。下一新综合、R80精确DCP增量参考的新route仍完整检查全部时钟、setup/hold/IO/CDC/DRC。累计串行新增4个125MHz数据级相对R2b不变，本轮接口相位早.5ns；不是全Root/SDF/板卡/模拟链总延迟或真实锁频带宽测量。当前不签发bitstream。

## 2026-11-12 R83最终：完整功能PASS，物理FAIL，保留R80

冻结输入4b9cfc84c794c2de9e62e3fe95038240c75b5047。新Migen生成/CSR映射PASS；新完整功能全部PASS：Scope/分频CE/快慢PID/CSR/AXI读写与背压/CDC故障和取消/复位/集成，以及R75 IIR、R77 Demod、R78限幅/FastChain、R83实际MMCM/BUFIO和Bare延迟。物理与全功能运行期间source_changes均[]。新综合COMPLETE -.773/-76.419ns、285 setup端点；实际route COMPLETE -.346/-4.728ns、26 setup端点，WHS/THS=-.006/-.006ns、1 hold端点，WPWS+1.500ns。最终STA FAIL，不作为正式版本合并。

全部26负setup=14 DAC（最差-.346）+12 fast_b IIR（最差-.139），1负hold=daca_reg[1]/C→FDRE_34/D -.006ns，非DAC外部hold。DAC必要零PCB模型hold+.072ns；共用MMCM输出确实将clock uncertainty从R82 .183降到.063ns、移除了跨输出.120ns PhaseError，但setup仍-.346，与R80 -.343几乎相同，不能宣传区域时钟已解决DAC。data逻辑3.725ns=CQ.472+OBUF3.253，net仅.001ns，不是PID/IIR算术长链。

额外协议必要检查：SEL在上升之前-.359ns FAIL、在前一下降之后-.157ns FAIL；CLK至少领先WRT .5ns的模型-.232ns FAIL；CLK距前WRT的2ns keepout模型+.242ns PASS。原DCP未改。当前250MHz/50%名义高宽2ns，AD9767 RevG3.5ns脉宽与3.3V双125MS/s适用数值规则仍待可靠澄清。ADI官方确认能力与SEL低窗含义，不等于2ns脉宽数值豁免。真实PCB/SI与外接GPIO用途未知，不捏造为零偏斜/未连接。

只读扫描完整覆盖LVCMOS33 DRIVE4/8/12/16、FAST/SLOW：16原FAST+48新增=64组合、896个位级记录。即使允许逐位选择data的drive/slew并考虑固定路径模型下整体移动WRT边沿，14位公共可行区间仍为空；不移相各WRT组的最优最小裕量全负，最好-.158ns。所有原电气属性恢复，未保存修改DCP，输入SHA保持。这个结论只限当前物理架构/约束/合法扫描参数，不声称所有SERDES/IO架构均无解，也不拿假设相移当成已实现时钟。

ADC28 setup+.429/hold+3.304ns、同字0/-8关系PASS；DNA setup+.830/hold+.071ns；no_clock0、内部未约束0。16无输入延迟为真实双级独立位GPIO；32无输出延迟分类为16GPIO/8LED/4PWM/2DAC控制+2 forwarded-clock LOW，不能一概删除约束或一概当成同步签核。54ASYNC/27同SLICE双级、首Q仅到次D，GPIO级间setup7.193/hold.122ns。v6逐项核对Scope写字段地址/位宽/wen守卫后，当前导出未分类0；旧v3/v4/v5错误与诊断保留。这些结构与normal cohort库存检查不代替整体物理CDC/MTBF/复位/故障签核。

bitstream DRC406：184 DPIP-1、57 DPOP-1、91 DPOP-2、1 DPREG-4、1 RTSTAT-10警告，70 AVAL-4、2 REQP-20建议。原R80 p_1_out稳定二态OPMODE选择分析保留，不自动替代本轮瞬态/映射/风险审查，不做全局waiver。发布核验新工具tools/check_release_gate.py只读核对功能RAW覆盖、source冻结、综合/route、全局setup/hold/pulse/125MHz/ADC/同步结构及IO/CDC/DRC证明，当前按预期exit2=BLOCKED_NOT_RELEASED。不能用PASS的功能、综合或route字段覆盖FAIL/OPEN。

R83实际原语73474次逐字WRT、37205次ADC、36731对DAC锁存、双通道全部16384值、3次epoch PASS；时钟丢失后保持IQRESET，参考恢复需原PLLE2规定的显式PS reset，不宣称无复位自动恢复。Bare组件正负123：R80数据72.100/WRT74.100ns，R83数据71.600/WRT73.600ns。新增串行数据级0，累计R2b+4个SYS级/+32ns调度保持，接口边沿早.5ns；cycle标签8/9不代表少8ns。全链路ADC转换、DAC内部更新与模拟建立、激光/探测器/PZT/MTS频响及实际闭环带宽仍未测。完成全功能后修正Bare测试报告中误继承的未使用WRT输出1相位字段为真实data/output0 -45°，未改HDL/激励/断言，定向重跑PASS，旧原件保留。

保留R80 60ba54e9cef8b672eba3988bd436aaac16e7179a为当前最佳候选：内部125MHz WNS+.055/TNS0/0端点，整体仍-.343/-3.974ns、14 DAC端点、hold+.038ns。R83等后继未合并。原用户工程/R2b/R4a/R16/R60/R80逐文件SHA、HEAD、工作树状态再核对全部PASS。全部R83原件、完整功能、合成/route、896行扫描、原始失败与gate/SHA在experiments/r83_full_and_rejected_physical_20261112；DCP SHA256=be4ae22a2dcd3313bcb48118065d06e05486ff1aea6f61c858c2772742f00226。

下一步应先获得AD9767该模式完整数值时序/脉宽与真实PCB预算；以独立最小I/O设计评估共源SERDES并匹配data/clock输出路径，确认实际物理窗口后再接入R80。当前扫描已不支持继续盲调同一驱动/相位参数；不能承诺再跑固定几轮必定签核。没有降低125MHz、牺牲14位精度/双125MS/s或滤波器阶数，没有新增掩盖违例的例外，没有生成发布bit/bin或操作板卡/激光/PZT。
