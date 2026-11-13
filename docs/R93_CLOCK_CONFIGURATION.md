# R93 时钟配置有边界试验 / 2026-11-13

父R92 d2df0b3f。生产Root/PS/ADC/DAC引脚/CSR/算法均不改。先只读磁盘DCP在内存检查R80 PLL与R84 MMCM的OPTIMIZED/HIGH/LOW，全部有效clock PERIOD/WAVEFORM逐项保持，不新增路径例外，不手改input jitter。此阶段无新综合/route，若工具数值不变不能推断全部重新实现的物理配置无效。

唯一新硬件probe：R84 FDRE reference拓扑，MMCM VCO1000→750，mult8→6，250MHz divider4→3，125MHz divider8→6；相位全部保持。750MHz VCO最小相位步长166.667ps，-.5/-4.5/-1.5/-5.5ns均为3/27/9/33步，理论可精确表示。输入125MHz不变，500MHz未在此probe使用。HIGH模式由工具计算jitter，不能手动给出较小uncertainty。

MMCM倍频/输出分频的比值恒等，因此名义频率/输出相位不变；锁定时间及硅上jitter不能由这个恒等式证明，需实际UNISIM重启/停钟检查和新综合/route。正常反馈整拍目标0，probe不代表整机ADC→DAC延迟。先完整native，再fresh synth，只有新数据窗口改善才route。功能/综合/route/最终签核分别标记，未运行不得写PASS。

官方依据：https://docs.amd.com/r/en-US/ug953-vivado-7series-libraries/MMCME2_BASE 及 UG472 7-series Clocking。不能把同频理解为同抖动；不能假设新750MHz比1000MHz好。


# R93 时钟配置筛查结束 / 2026-11-13

NOT RELEASED。生产Root/PS/ADC/DAC/CSR/PID/IIR源码不改；所有新硬件仅为独立probe。14个历史checkout的67247项已跟踪文件哈希/HEAD/status检查全部PASS，当前对父R92的51份生产gateware逐RAW完全相同。完整Linien新回归NOT RUN，无新整机时序数值，不生成.bit/.bin。

R80 PLL和R84 MMCM各OPTIMIZED/HIGH/LOW内存诊断完成（合计84行），R84额外update_timing -full重算42行。实际频率与波形逐项不变，输入DCP哈希不变；工具窗口分别始终-.273/-.274ns，无配置改善。仅为固定网表模型结果，不能声称三种硬件配置已新route或穷尽一切架构。

750MHz VCO/HIGH新probe的native01严格旧测试FAIL：两个MMCM锁定时间不同，自生成counter在不同SYS时刻起跑，1652.125ns为000d/0013。完整失败TB/日志保留，不抹除。native02仅在测试台将双方输入counter/a_hold/b_hold钳零至双方各自复位释放，再同时喂同一SYS序列；未force时钟、复位、输出寄存器、SEL、serializer、锁定或被测反馈状态。复位释放合法性及停钟2usreset/显式恢复仍检查。共同输入有效态波形与oracle PASS：73645writes、A36824/B36821、2356639比较点、32768码值、3epochs。1000MHz/LOW同条件独立native也PASS，数量相同。故只能报告共同输入下的功能PASS，不能宣称两种PLL锁定时间完全等价，或原native01从FAIL改为PASS。

新综合均COMPLETE，但没有新增route：750/HIGH综合global WNS/TNS=-.337/-4.137ns、16setup，WHS/THS=-1.218/-16.672ns、16hold；必要DAC setup/hold=-.337/+.066ns，DJ=.112ns、uncertainty=.066ns。1000/LOW综合global=-.334/-4.416ns、16setup，WHS/THS=-1.382/-19.294ns、16hold；DAC=-.334/+.069ns，DJ=.104ns、uncertainty=.063ns。作为对照，旧R84综合global=-.334/-4.050ns、16setup，WHS/THS=-1.199/-16.370ns。新750配置jitter反而增大，LOW没带来新数据眼收益。因此不投入盲目新route，更不能将综合结果当作布局布线结果。presynthesis hold包含未实现内部路由，不用它冒充routed结论。

硬件SHA：750/HIGH b792adf5b4c6f6456afbe08d6bc3e84c25c84a9f4de66498a062af3703cc184c；1000/LOW fe6b5c00a55615b8cd13b2611b092519ea205c855e4d0efded1a040d00c8c953。完整命令、synth DCP、波形TB、输入SHA和PASS/FAIL/NOT RUN索引见experiments/r93_clock_configuration_20261113。

当前推荐基线仍为R80 60ba54e9，不是本分支继承的失败R83生产输入；R80内部+.055ns，整体-.343/-3.974ns、14DAC负setup、整体hold+.038ns，最终STA失败。R90/R91/R92不合并；R93不集成。新增正常反馈级0（未采用任何新硬件），现有R80相对R2b累计4 SYS级=32ns不是端到端数字总延迟。新综合本身不能缩减这一残余风险。

下一阶段必须针对DAC4ns实际引脚数据眼与CLK/WRT/SEL联合窗口提出新的可证实现，而不是继续给PID加流水线。最低预算2ns setup+1.5ns hold已经占3.5ns。共同延后WRT的数学必要条件是max(-setup_i)<=min(hold_i)；当前R80需要delta>=.343ns却又delta<=.070ns，窗口空集。此公式仅固定网表必要筛查，不替代实际换相后route；R89较广电气扫描亦已保留。继续仅调同一拓扑相位/驱动/tap没有已验证的收敛方案。不得保证还需固定几轮，也不得把未知PCB工程假设或官方125MSPS能力说明当成已知负STA的豁免。若新架构无法给出正窗口，应明确报告现有严格条件下未完成，不能生成或宣称正式可烧录镜像。

官方复核：AD9767 RevG Table3/Fig64仍为2ns setup、1.5ns hold及SEL在两个clock均低时切换。ADI 125MSPS问答并未给本工程PVT/PCB负裕量豁免。Epson SG3225VAN 125MHz资料的0.34ps是2.5V条件下12kHz–20MHz的典型phase jitter，不是本板峰峰周期jitter保证，未据此降低当前0.071ns TSJ或抹去负裕量。
https://www.analog.com/media/en/technical-documentation/data-sheets/AD9763_9765_9767.pdf
https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/164567/ad9763-ad9765-ad9767-interleaved-mode-with-125-msps-update-rate-possible/380408
https://download.epsondevice.com/td/pdf/td_spxo_spso_mhz/SG3225VAN_X1G0042410020_en.pdf
