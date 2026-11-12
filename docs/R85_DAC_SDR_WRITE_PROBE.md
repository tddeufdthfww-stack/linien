# R85：500MHz SDR2写时钟原语表征

父版本R84 75e4225c，R80整机保持。仅新增独立probe/test/physical，未集成原硬件。
数据SDR2仍250MHz CLK(-.5/3.5)/125MHz DIV(-4.5/3.5)，半帧加载旧A/新B，无新增整数反馈级。WRT改SDR2 CLK500MHz(-.5/1.5/3.5/5.5)、DIV250MHz(-.5/3.5)，常量D1=1/D2=0；1CLK=2ns latency后正沿1.5/5.5，负沿-.5/3.5，与前基准同波形。转发WRT为实际500MHz源的divide2+invert，正沿对应源正沿，不伪造异步clock或例外。采样CLK仍250MHz ODDR相位-135°，输出正沿.5/4.5。SEL目前仍SDR2同data，必要低窗未解决，不预报签核。

先严格逐字oracle/全码/波形/复位/停钟显式恢复，再新综合与实际route。14bit/每路125MS/s/原8ns和setup2/hold1.5不变，MMCM VCO1000MHz，500只走BUFIO到IO，不引入500MHz fabric运算或反馈寄存器。额外FPGA pulse/clockdiv/reset合法性与外部AD9767 pulse/protocol/PCB、整机CDC/DRC均须核验。

# R85 同类SDR2写时钟候选拒绝 / 2026-11-12

父R84 75e4225c，原整机R80保持。本轮仅独立probe，不改Root/PS/算法/CSR。数据SDR2 250/125不变；WRT SDR2 CLK500/DIV250，D1=1/D2=0，一CLK2ns输出正沿SYS1.5/5.5，保持原波形、旧A/新B、14位全码/双125MS/s、零新增整数数据级。native01实际原语/独立oracle/全码/逐125ps波形/复位/停钟后显式复位恢复PASS，整机回归NOT RUN。

新综合COMPLETE、新route COMPLETE；最终STA FAIL，global WNS/TNS=-3.981/-16.872ns，16setup，WHS/THS=-.312/-3.862ns、14hold，WPWS+.333ns。14DAC setup最差-.696（CQ.472+OBUF3.253+net.001=3.726ns，Slow角），hold-.312；WRT和data不同MMCM输出，uncertainty.183含PhaseError.120，CPR.467。最差另外两条为WRTDIV250→SYS复位同步器PRE的recovery，最差-3.981，不能豁免或声称复位安全。输入源码SHA837700a92d19e62e384e9b4d6a200d1d3c7e767e880af1f994faef6edee8d7b8，DCPc6c30591665d88a050cd4b08dd890d3173d8094539b6771abb705773c379e628。

拒绝、不接整机、不生成bitstream。原功能与物理日志均保留。独立probe无PS7所以ZPS7-1预期但未作为板级DRC合格；BUFR/BUFIO混合REQP-1577还须核对实际相位/物理合法性。后续R86试同一500MHz BUFIO、相同SDR4模式数据AABB和WRT0101，同CLKDIV125；数据重复只定义真实有效边沿，先保留默认严格STA，不立即加例外。若分析工具把不可能改变值的重复位边沿当成有效数据变化，必须先证明协议并单独审查正确的路径关系，不得直接放宽周期。
