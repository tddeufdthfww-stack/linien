# R82：相位明确的SYS参考与提前输出候选 / 2026-11-12

保留R80 60ba54e9和R81输入4e86132d。R81实际CRG单元原语PASS，但新Bare PID组合模型（SYS第一上升4ns、double第一上升0ns）FAIL：参考能出现+123脉冲，候选始终只有B。逐IO边沿日志显示模型内SYS同边沿frame已翻转、frame_seen在中间边沿后100ps更新，候选IO采样时select_b总为1；原49bit功能对照不足以穷尽这种多时钟事件关系。必须保留FAIL，不把原语一次PASS当成整个通路等价。该模型诊断不是已验证板级故障或SDF证明；同时250参考生成125 SEL的相位不应靠启动巧合保证。

R82只将新增MMCM参考从原250改为原SYS125（period8、mult8，仍VCO1000），四IO输出整体提前.5ns：data250 -45°→采样-.5/3.5；WRT250 -22.5°反相ODDR→上升1.75/5.75、下降-.25/3.75；CLK250 -135°反相→上升.5/4.5；SEL125 5.625°反相→变化.125/4.125。新MMCM所有分频相位直接以125 SYS为参考，原CRG/PLL/ADC/PS/算法不动。

数学：A在SYS前.5ns采旧daca，仍对应原SYS同边沿读取的旧A；B在SYS后3.5ns读取已更新dacb，仍对应原+4ns新B。WRT相对各IO字仍2.25ns setup/1.75ns hold理想预算；SEL位于WRT下降-.25到CLK上升.5的共同低窗中央.125，各留.375ns；CLK领先WRT1.25ns，距前WRT2.75ns。新增数据级0，样本编号不变；输出边沿有意提前.5ns，实际C-Q/时钟树/PCB仍须STA和测量，不当作整数8ns增减。

先重跑原native全14bit/ADC/DAC锁存/复位/停钟后显式PS恢复，再用导致R81 FAIL的相同Bare PID组合测试正负123脉冲。要求data模型R80=72.1ns/R82=71.6ns，WRT模型R80=74.1ns/R82=73.85ns；同样本、幅值、CSR、完整输出，不用只看cycle计数的8/9标签（新边沿在SYS前.5ns，计数标签会少1但实际仅提前.5ns）。这些是组件功能模型，不是全Root/SDF/真实ADC转换/DAC模拟建立时间。

所有原R81 FAIL生成RTL/TB/日志/命令/SHA见experiments/r81_additional_latency_failure_20261112。R81物理结果仍单独记录，不因局部STA改善选用功能未通过候选。本轮需新综合、以R80不可变DCP作incremental参考的新route，并完整审计hold/ADC/接口/CDC/DRC。不改任何真实时钟要求、IO预算或时序例外。板级脉宽/PCB仍不能据此签核。

## R82 首轮实际原语与原失败用例均PASS

实际CRG PLL+SYS参考MMCM+4BUFIO原语：73474次新旧WRT逐字检查、37205次ADC对照、36731对DAC锁存输出、两个通道各16384取值、3次释放epoch，PASS；停钟后IQRESET保持，显式PS reset恢复。完整原件/SHA在experiments/r82_native_and_latency_20261112。

原先拒绝R81的Bare PID组件通路、同样手工SYS/2x初相位现已PASS：正负123脉冲R80数据72.100ns/R82 71.600ns，R80对应WRT74.100ns/R82 73.850ns，样本/幅值/CSR一致。data早.500ns、WRT早.250ns是有意接口相位差，不是省掉8ns整拍；数据整数新增级0。先前R28/R80两帧+两级快PID累计相对R2b+4个125MHz周期/+32ns；R82此配置功能模型将数据边沿提前.5ns（相对早期R2b模型40.1ns，差31.5ns），完整ADC转换、DAC内部更新/模拟建立、滤波/MTS选择及全Root/SDF/板测延迟仍未测，不能套用到真实锁频带宽。

新完整回归已加入R82实际原语和Bare延迟测试；新生成/综合/route待执行，不能用这些功能PASS预报时序收益。增量参考仍是R80精确SHA，R81只保留失败诊断，不以其物理DCP作参考。本轮未改原CRG/PLL/ADC/PS/CSR/控制算法或时钟周期/例外，接口脉宽/PCB/物理CDC/DRC仍未签核。

## R82 实际失败与独立后继 / 2026-11-12

输入56f8772b8ec2482dad7924193d4adbbf95809d23，新生成CSR语义PASS、新综合COMPLETE（WNS/TNS=-0.773/-79.121ns）；actual route COMPLETE，WNS/TNS=-0.484/-6.2ns、16 setup端点，WHS/THS=-0.562/-7.362ns、14 hold端点，WPWS=1.5ns。source_changes=[]。最终STA FAIL，REJECTED_NOT_MERGED，不能作为可上板正式版。

实际原CRG原语定向PASS及R81失败的Bare模型正负脉冲PASS：数据R80 72.1/R82 71.6ns、对应WRT74.1/73.85ns，新增数据级0，仅子周期相位提前。fresh整套功能NOT RUN，不能以R78旧整套PASS冒称R82重跑。

ADC全部28条setup+.429/hold+3.304ns、同字0/-8逐条PASS。54ASYNC/27同SLICE配对、一级Q仅到二级D；GPIO16级间setup7.193/hold.122ns。旧v4/v5分类器对新最差decoded字段FAIL保留；v6逐项核实真实wen守卫、地址、字段位宽和同一src_capture保持，当前导出未分类0。只是协议/布线inventory，不是整体物理CDC/MTBF/故障签核。

当前不同MMCM输出驱动数据与WRT。.183ns clock uncertainty中包含.120ns跨MMCM输出PhaseError；实际min最差在Slow角，不能只用Fast角典型值或调小uncertainty“修复”。后继R83在独立分支把WRT真正接到DATA同一CLKOUT0/BUFIO，由工具重新计算共享路径与相位误差，保持data提前.5ns防止同边沿采样歧义。不改变原CRG/PLL/SYS/ADC/PS/算法/CSR、时钟周期、IO2/-1.5预算或时序例外。

原件见experiments/r82_rejected_physical_20261112；DCP SHA256=1b9557b5162e4f4b4cc5b2df8782d2f41e3ba4c5770e8e324e2c29b8e65f94cd。保留R80最佳内部已闭合候选60ba54e9；新增反馈整数级0。R82相位提前.5ns不是少8ns，端到端硬件/ADC转换/DAC模拟建立/激光环路未测。DAC外部3.5ns脉宽、CLK/WRT/SEL完整协议、真实PCB/SI、物理CDC/DRC仍未签核，不生成bit/bin、不刷写、不驱动激光/PZT。
