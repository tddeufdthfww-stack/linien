# R84 独立 DAC 原语表征，非整机候选

父版本R83 55c5190e保持；R80仍保留最佳。只新增gateware/tests/timing/r84探针和tools测试/实现脚本，原Root、PS7、CRG、ADC、PID、IIR、CSR及接口约束文件均不改。这个探针不可上板，不生成bitstream。

比较同一目标器件/引脚/电气/波形/计数样本源下的两种输出结构：基准IOB FDRE+ODDR，对照OSERDESE2 SDR2数据与SEL、DDR4固定0101模式的CLK/WRT。所有输出的CLK均250MHz；不把快速数据重复后再切掉真实路径。目标SYS125/双125MS/s/14位不变。

数学依据：令SYS n时刻为8n。旧A输出来自a_hold[n-1]，新B来自SYS n前的B输入。CLKDIV在SYS n−4.5ns加载a_hold与直接b_now，此时二者分别等于原A旧样本与原B在SYS n将采的值；SDR2的一CLK=4ns延迟后，A/B分别在n−.5/n+3.5输出，与早采样基准同拍。WRT DDR4常量0101延迟两CLK=8ns，模式每4ns重复，稳定后上升仍在n+1.5/5.5，与基准ODDR等波形。CLK同理用相位早1ns的CLK源。SEL SDR2常量01与data同边沿，实际SEL低窗和所有CQ/OBUF/PVT仍须另查，不能以相位公式预报PASS。

实际启动须同时复位SERDES内部计数器并在对应CLKDIV同步释放。外部DAC RESET在两个DIV域复位释放后，再经SYS两级释放，先建立稳定模式。检查多次复位和参考停钟/显式恢复。最小探针的SYS来自同一125MHz输入而非整机PLL级联，因此只比较原语差异，整机绝对抖动/偏斜不能直接复用。

零新增整拍方案是上述半拍提前装载；备选是显式一SYS帧预装(+8ns)或两帧(+16ns)。若有新增8/16ns，纯延迟在100kHz额外相位损失.288°/.576°、1MHz为2.88°/5.76°，必须记录误差样本/积分更新/输出队列对应关系。当前只试零新增整拍，不改PID环路递推。

依据UG471表3-9/3-11与图3-16：SDR2可用，输入在CLKDIV采入后1CLK到OQ；DDR4为2CLK。还要以Vivado2020.1实际UNISIM和实际route核验，不靠手算或仿真完成宣称物理通过。来源：https://docs.amd.com/v/u/en-US/ug471_7Series_SelectIO

本轮先全14位独立样本oracle、两结构逐输出对照、启动/复位/时钟失锁，再独立新综合/route，读取OQ真实CQ、OBUF、setup/hold、CLK/WRT/SEL与DRC。不得通过false_path/multicycle/放宽8ns或IO2/−1.5预算掩盖失败。所有实验输入/源码/日志/SHA独立保留，若无物理收益不接入整机。

板级依据按用户最新指示自行查官方STEMlab125-14PRO Z7020Gen2资料及V2r0RevA原理图；公开资料缺失的板内布线时延要明确缺失，不能伪装成测量值。官方产品明确LTC2145-14/AD9767/SG3225VAN；参考PCB不是用户实物验证。完整签核仍需核对适用电气模式、波形和不确定度。

# R84 独立I/O原语表征完成 / 2026-11-12

父版R83 55c5190e保持；R80仍最佳整机候选。本轮只新增独立14位探针/测试/物理脚本，原Root/PS7/CRG/ADC/算法/CSR/接口约束无改。探针SYS直接由125MHz输入驱动，与整机PLL级联不同，不可把绝对结果当作整机签核。

实际UNISIM原语native04 PASS：73663次WRT，A36833/B36830，2357215逐时刻新旧输出比较，两个通道全16384取值，3次复位epoch，73663次CLK检查。SDR2数据半帧预装与独立SYS旧A/新B oracle一致，零新增整拍只在探针成立，整机集成/完整回归NOT RUN。native01因缺secureip库ELAB FAIL，02/03停钟期间仍检查稳定相位/波形导致FAIL，全部保留；04在停钟时撤销稳定相位oracle资格，仍必须在2us内进入DAC复位，参考恢复后显式复位重锁。不是不停钟恢复或板级失锁性能证明。

新综合与实际route两结构均COMPLETE；参考FDRE/ODDR DAC setup最差-.346ns，hold+.072；其最小计数器/选择器还存在内部负setup，不能借此评价R80内部时序。候选SDR2数据+DDR4固定0101时钟，global WNS/TNS=-.311/-3.532ns、14setup，WHS+.072/THS0、0hold，WPWS+2ns（FPGA自身要求，不代表外部DAC脉宽）；no_clock0、内部未约束0、独立异步reset_i无输入预算1、输出未预算4含2 forwarded-clock。候选数据最差来自OSERDESE2/CLK到dac_data[1]，Fast角CQ.204+OBUF1.635+net.001=1.840ns；不得把它与参考Slow角3.726ns简单相减当作全角收益。相同约束下只改善.035ns，仍FAIL，不接整机、不生成bitstream。

两个DCP SHA详见experiments/r84_standalone_serdes_20261112/manifest.json。实际OSERDES转发clock的非单调时序弧须继续核对边沿sense，当前负slack不可改名为PASS；SEL/CLK/WRT低窗、3.3V适用脉宽、PCB/SI、整机CDC/DRC全部仍OPEN。

用户追加授权由工程师自行定义官方未公开PCB/时钟信息的验收口径。将建立明确的设计假设/裕量与证据级别，不伪造PCB实测，不删除负STA。官方板卡页明确LTC2145-14/AD9767；V2r0 RevA只公开开发原理图，不公开完整硬件布线。ADI官方答复确认交织每路125MS/s并澄清tH不等同tH*，但未给替代3.5ns脉宽的数值。来源：https://redpitaya.readthedocs.io/en/latest/developerGuide/hardware/GEN2/125-14_Gen2_Z7020_Pro/top.html 和 https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/164567/ad9763-ad9765-ad9767-interleaved-mode-with-125-msps-update-rate-possible/380408 。后续R85优先独立比较SDR2输出WRT的同类原语映射，保持双125MS/s/14位/同样本/零新增整数反馈级，不放宽时钟和2/-1.5ns预算。
