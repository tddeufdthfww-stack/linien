
# R88/R89：完整361种3.3V输出电气模式的必要窗口仍FAIL / 2026-11-13

独立审计分支opt/r89-dac-aperture-audit-20261113（复用R87工作树路径，不改变R87分支提交5f0ad61c）。本轮仅只读DCP诊断和新增工具/记录，不改Root/算法/PS7/ADC/原PLL/CSR、正式引脚标准或任何反馈延迟。

先按DS187/UG471核查DC兼容边界：FPGA LVTTL在3.3V HR bank保证VOH2.4/VOL.4，与AD9767 DVDD3.3时VIH2.1/VIL.9有静态余量；LVTTL合法24mA而LVCMOS33不允许24。PCI33_3同3.3V、VOH=VCCO-.5/VOL=.1VCCO，仅作为输出电气模式候选，不变更外部数据协议。此不代替真实PCB/SI/脉宽验证。所有改动只在Vivado内存，恢复IOSTANDARD/DRIVE/SLEW且DCP SHA不变，没有向真实板卡改变驱动。

R80额外LVTTL100配置/1400bit记录全部完成，无固定相位可行及无固定路径假设移相公共窗口，最好不移相最小必要裕量-.126ns。R86b匹配结构统一枚举：LVCMOS33 8种、LVTTL10种、PCI33_3默认1种，共19种data和19种WRT模式，覆盖361配置/5054bit记录（64+100+160混合+37PCI相关）。允许每bit独立选择19种data电气模式；19种WRT均无公共可行区间。最佳单个位setup+有效hold余量之和仍-.044ns；该有界固定路径模型在零PCB偏差时已无正窗口，未知PCB假设不能使其通过。不是所有未来校准/新架构/器件均不可能的证明。

有效hold诊断只在R86b源码SHAa9bb116b...和完整native02 PASS核对后使用raw hold+2ns，代表BBAA重复中间UI之后的下一次真实数据变化；它不是新增2ns反馈，也未写入任何时序例外。所有原始default STA保留。既然必要模型已失败，不会通过multicycle/false_path把它变成PASS。R88/R89没有新的RTL，所以fresh功能/综合/新place-route均NOT RUN；完成的是已有实际routed DCP上的电气诊断，不冒充新实现。

另查UG471 p117：IDELAYE2 DATAIN只能回到fabric/输入逻辑，不能直接驱动IOB，不能直接当本HR输出ODELAY使用。没有开展违反资源限制的实现；ODELAY并非本3.3V HR bank可直接取得的输出资源。

所有输入、原始行、诊断脚本、DCP/native源码证明、SHA在experiments/r88_r89_aperture_audit_20261113。新增只读tools/check_r89_io_aperture_evidence.py可用新的--out目录重复验证361/5054覆盖、native/RTL/DCP SHA和无可行区间；其成功标记明确是“EVIDENCE_VERIFIED_NECESSARY_WINDOW_FAIL_NOT_RELEASED”，不是硬件PASS。原始源码同R83的生产文件逐个raw SHA复核changed=[]；R80仍独立保持最佳。

工程验收决定：官方未知PCB/时钟资料不再作为必须询问用户的条件；按已写明的参考板/内部125MHz/独立异步GPIO配置继续评审。已知DAC负时序与控制协议未闭合仍FAIL，不批准正式烧录，不生成bit/bin、不操作板卡或激光。可批准的是已有功能回归、R80内部125MHz静态时序、DNA以及有边界的ADC/正常CDC/非致命DRC结构审查；不能把这些局部批准等同全FPGA签核。

后续有效方向：需要具备合法可校准相对延迟的新IO架构或带实测依据的板级接口时序模型，先证明实际数据眼，再整合R80和完整新回归/实现。继续增加PID/IIR反馈流水线不会扩大4ns DAC串行UI；在当前setup2+hold1.5固定要求下，额外8/16ns整帧延迟不能直接解决pad窗口，故未盲加延迟。板测/校准目前NOT RUN，无法承诺固定几轮即可正式签核。
