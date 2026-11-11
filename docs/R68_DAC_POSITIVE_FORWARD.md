# R68 positive-edge DAC clock forwarding (candidate)

2026-11-12，独立opt/r68-dac-positive-forward-20261112，父R67代码78cd9df，PS reset修复原生及actual RootModule wiring已PASS，R67综合仍在独立运行。本轮R66实际route -.343/-6.398ns、47端点、hold+.024/0；其最差为DAC数据输出。R66整个设计仍STA FAIL。

## 修改前等价推导

250MHz周期4ns。旧WRT ODDR在phase0时钟D1=0/D2=1，pad rising=2+4k、falling=4+4k ns。将原本未使用的PLL CLKOUT5保留divide4频率、phase改180°，新增一BUFG给dac_wrt；ODDR D1=1/D2=0，则pad rising=2+4k、falling=4+4k，完全相同。旧CLK的PLL phase=-45°，负边沿=1.5+4k；改PLL phase=+135°，正边沿=1.5+4k，ODDR常量同样反转，pad波形仍相同。INIT0/CE1/R0/S0照旧。

目的不是修改时序例外，而是使数据正边沿与WRT有效边沿采用实际正边沿硬件，在保留相同pad波形情况下研究PVT/公共路径悲观消除及实际布线影响。是否改善只由实际报告判定，不把相位重编码必然成功当事实。source有效极性改变后，生成forwarded clock必须去掉旧-invert；不是放宽clock周期或改变I/O setup2/hold1.5。

修改crg.py的CLKOUT4/5相位、新dac_wrt BUFG；analog.py仅WRT/CLK两个ODDR常量/时钟；io_intrinsic_probe.tcl按实际源极性更新generated clock。ADC/PID/CSR/PS7/引脚/电平/DRIVE8 FAST/吞吐率不变。SEL时钟和波形原样，已知其均低窗口未签核。本轮新增数据反馈级0，继承相对R2b+32ns；理论pad边沿不变，不能写成新增/减少了一个数据周期。

## 验证

冻结R67实际CRG源码为reference/r67_crg.py，冻结R61b analog不动。四组独立功能时钟包络比较全部49位、启动/复位/14位样本/下游样本，原生实际Migen与UNISIM；再用真实两个CRG/PLL原语生成时钟比较新旧接口，区分稳定锁定区间与未锁定启动区间，不将人工注入相位当作实际PLL模型。

之后新生成/CSR映射、新综合和actual route；核对forwarded WRT rising2/fall4、CLK rising1.5/fall3.5、14 DAC SDR IOB、ADC28 setup/hold、正边沿时隙控制hold、所有内部路径、PS新增ASR物理位置、coverage/CDC/DRC。失败完整保留不合并。R67独立route若未运行写NOT RUN，不能借本轮完整组合结果伪造独立结果。

本方案尚不解决SEL低窗口、CLK领先WRT严格裕量、DAC外部3.5ns pulse手册解释/PCB实测及异常复位return-data物理CDC问题。所有都必须独立处理，不能签发正式板用镜像或宣称可闭环。

实际四包络/49位/启动GSR/复位/14位/样本负例PASS；实际old/new CRG+PLL+analog两锁定复位释放epoch的49位严格比较及真实C source phase1.5/2.0ns PASS。初版fixture忽略ODDR原语传播100ps导致相位断言FAIL，已保留失败日志并改为检查C source，pad49位严格比较未放宽。归档experiments/r68_positive_forward_native_20261112。随后新生成/综合/route；本轮全功能暂NOT RERUN，未改组件对应R66完整同源PASS，不把继承写作本轮重跑。

## 2026-11-12 R68实际：REJECTED，回到R66 DAC组件

输入82924f5deaf33d20255def030599c162a264973d；目标原生四包络49位/启动/复位/14位/负例PASS，实际两个CRG+PLL+analog两锁定epoch对照PASS；新综合/route均COMPLETE，CSR map PASS；完整功能本轮NOT RERUN，不冒用R66完整回归。综合WNS/TNS=-.873/-86.177ns，hold-.757/-368.604。actual route WNS/TNS=-.829/-16.583ns（45端点），WHS/THS=-.412/-5.257ns（14端点），WPWS+1.500；DAC必要预算-.829/-.412恶化，同域内部最差-.554（fast_a_zi0__8/C→fast_b_cordic17[16]/D），均FAIL。

ADC28端点+.429/+3.304和0/-8ns边沿逐条PASS；DNA+.337/+.188ns；PS ASR加入后52ASYNC FF/26pair同SLICE、一级Q仅二级D，没有把数量增加/减少当整体安全证明。noClock0/内部未约束0、noInput16/noOutput32；LUT11720/FF13398/DSP94/BRAM35/BUFG7。源码/所有阶段日志/DCP/输入输出SHA及只读诊断归档experiments/r68_rejected_positive_forward_20261112，DCP SHA256=df47a79ed4bd5c5780412d5ed5e07f4386c94b49e5070a09530e4a7d4d29ae0a。

同pad波形正边沿clock重编码没有物理收益，拒绝合并；R69在冻结输入前恢复R66 DAC+R67 PS ASR的精确raw文件，不丢PS reset成果，不覆盖R68失败现场。新增正常反馈级0。额外故障诊断确证目标停钟超时后旧写重放等缺口，结果独立记录，旧完整常规回归不假装覆盖这些情景。I/O/物理CDC/最终STA/DRC仍未签核，不部署。
