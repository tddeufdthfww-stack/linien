# R92 同事件校准WRT经fabric探针 / 2026-11-13

父R91 de0859a7，独立最小probe，不改生产Root/ADC/PS/原PLL/CSR/算法。数据仍250MHz正沿旧A/新B，WRT从同一BUFH250事件经IDELAYE2 DATAIN→DATAOUT返回fabric、保留LUT1缓冲后驱动OBUF；不是直接IDELAY→IOB。先由Vivado真实DRC/place/route判断是否合法，不绕过专用路由规则。

新增200MHz BUFG参考、IDELAYCTRL和局部IODELAY_GROUP，ref reset至少16参考周期，RDY经SYS两级后再等16SYS释放DACreset；RDY丢失异步拉高外部reset。只增加启动等待，不增加正常反馈整拍。IDELAY固定22tap、SIGNAL_PATTERN CLOCK/HIGH_PERFORMANCE_MODE TRUE，实际延迟链抖动必须由工具计入，不手动改uncertainty。

数学：源事件t_k=4k-.5，data FF在同一事件采u[k]，WRT是该事件经真实组合/校准延迟后的波形；下一字u[k+1]仍4ns后。源和转发clock名义同相位，物理DCD包含实际延迟。默认下一周期setup会误给额外4ns，所以对14个data/C到data端口使用setup multiplier0收紧为同事件；必须报告setup requirement0和hold对应下一字(-4ns)，不恢复到宽松原始关系。不是放宽周期或屏蔽失败。

实际UNISIM固定延迟=600+22*78=2316ps，BUFH/保留LUT功能模型零延迟，WRT正沿SYS+1.816/5.816，data/SEL/CLK仍严格对照参考，WRT每正沿独立查原SYS字序。硅上LUT/路由延迟不在此功能常数内，因此必须另做新STA，不能用功能相位保证物理setup/hold。原语RDY、复位、停钟显式恢复与全码均需验证。

依据UG471p117/UG953：DATAOUT可回fabric逻辑，不能直接IOB；CLOCK模式计入delay-chain jitter。本轮额外fabric路径可能使PVT散布更差，不能预判PASS。若校准资源/路由不合法或实际必要窗口仍失败，保留不集成、不生成bitstream。
https://docs.amd.com/r/2023.1-English/ug953-vivado-7series-libraries/IDELAYE2


# R92 实际失败与有边界诊断 / 2026-11-13

状态 REJECTED；功能探针 PASS，新综合/布局布线 COMPLETE，最终 STA FAIL，整机集成/整机新回归/bitstream/上板均 NOT RUN。R80 最佳整机保留，不能正式烧录。

实际 UNISIM：73509 writes、A36756/B36753、2352287 比较点、32768 码值、3 epochs PASS。此 oracle 证明字序/复位/启动，不覆盖硅上延迟或 SEL 低电平窗口。新物理 global WNS/TNS=-1.702/-18.314ns、15 setup；WHS/THS=-3.832/-53.150ns、14 hold；WPWS=+.264ns。DAC data setup +.466ns、hold -3.832ns；正确0周期 setup / -4ns 下一字 hold关系已保留。最差内部 frame_copy_replica_2/C→output_data/D 为 -1.702ns，数据2.156ns=逻辑.580+route1.576，时钟偏斜-2.030ns。输出setup单独改善并不代表可用。

实际123可路由net全部route、0routing error；DRC 4 Warning（3混合clockbuffer、1独立probe无PS7），0Error/Critical，并非整机DRC通过。report_cdc显示All paths Safely Timed仅限同源参考探针，不能当作完整物理CDC/失锁RDY协议证明。no_clock=0、内部未约束=0；reset input未预算、2控制输出未预算，不能最终签核。

只读磁盘DCP内存诊断：32合法tap×14位=448行，0可行行；最好单bit setup+hold之和仍-3.005ns。tap0整体setup/hold=-1.149/-1.952ns；tap22为+.466/-3.832ns。仅证明当前固定物理拓扑不能靠tap或共同相移关闭，并非证明所有其他架构不可行。输入DCP哈希始终不变。

必要零PCB SEL低电平窗口最差hold -4.259ns；CLK领先WRT检查+4.597ns但下一CLK避让前WRT2ns检查-7.328ns。额外协议诊断保留完整时钟路径，未保存修改约束的DCP，未豁免违例；delay长于一个UI，不能凭功能模型相位断言硅上同字锁存。未计PCB差分走线、DAC引脚负载及外部pulse最终预算，不夸大PASS。

RTL SHA256 beffcbcedf17dcc776ec2c367ae37bc67d8677aeb5c51746fce4fe0c80a3ea54；routed DCP 971380270884de6adb20c0e9b6589e959a0c415ae9602c1d0581851115fa632d。原版/R2b/R4a/R80/R89/R90/R91均不回写。延迟链失败源码、工具、完整报告、波形TB、DCP与哈希归档 experiments/r92_rejected_calibrated_20261113。

下一步R93先对冻结DCP做合法PLL/MMCM BANDWIDTH配置诊断：保持频率/相位/约束/整数反馈级不变，让Vivado重新计算jitter/phase error，而非手动缩减uncertainty。只有有必要窗口才投新综合/route；此诊断不是新的物理实现。普通增加PID流水线不能改善固定4ns DAC外部数据眼。
