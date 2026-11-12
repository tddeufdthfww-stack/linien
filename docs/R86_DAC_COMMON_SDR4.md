# R86 同一500MHz/SDR4匹配输出探针

父R85保持，生产Root/算法/CSR/原PLL与ADC均不改。数据与WRT同一MMCM CLKOUT0/BUFIO500MHz(-.5/1.5/3.5/5.5)，SDR4、同CLKDIV125MHz(SYS-6.5)，输入AABB与0101；UG471 SDR4 latency3CLK=6ns，因此实际data在SYS-.5/+3.5变化、WRT在1.5/5.5上升，仍旧A/新B、14bit/每路125MS/s、零新增整数反馈级。需要真实UNISIM严格全波形/全码/oracle证明，不靠手算。SDR4每组相邻两位同源，串行化中间UI是重复值；默认严格STA先保留，任何有效边沿约束须单独证明与审查且只作用DAC输出。

复位变化：DAC外部reset由SYS两级异步置位同步释放加16SYS周期启动等待组合保持。撤销两个CLKDIV reset到SYS同步器PRE的直接扇入，仍异步响应LOCKED丢失；只增加启动等待，不改变正常数据反馈级。所有被比较原语在DAC复位有效时不宣称稳定相位；仍检查2us内复位，停钟返回按原要求显式复位。

先默认新综合/真实route，不增加multicycle/falsepath或放宽2/-1.5预算。外部SEL低窗/CLK-WRT/pulse/PCB、完整物理CDC与DRC均OPEN，探针无PS、不是可烧录整机。

# R86b实际BBAA功能通过，必要物理窗口仍不成立 / 2026-11-12

最初R86a手算SDR4 3CLK延迟漏了CLK/DIV对齐时多1CLK，native FAIL。实际trace证明aligned延迟4CLK=8ns，旧源码/所有日志/两DCP均保留experiments/r86a_failed_alignment_20261112，未放宽断言。

R86b精确修正：DIV改SYS-4.5、串行BBAA，A取原DAC寄存器前的输入，probe为counter，B为~counter。DIV捕获SYS n将写入A/B寄存器的同一帧；D1/D2在n+3.5/5.5输出B_n，D3/D4在n+7.5/9.5输出A_n，因此SYS n-.5仍是前帧旧A、n+3.5是本帧新B。整数反馈新增0；实际整机捕获路径预算与集成尚待，不能从计数器预测替代真实通路证明。WRT同一500MHz BUFIO/SDR4/DIV，常量0101，正沿1.5/5.5；CLK仍250MHz ODDR。启动等16SYS后解除DACreset，去掉异域reset到SYS PRE直接扇入。零数据级，启动时间增加，不声称无缝停钟恢复。

native02 PASS：73573 WRT/A36788/B36785/2354335逐时刻比较/32768通道码值/3epochs/73573 CLK。源SHAa9bb116b7265dbc074646f073512fbf741f44a8db9bb16c4802c9ef6cc7069b7；新综合和route COMPLETE，DCPc3a441afd3bd574d4c973d69a2ef1bd7759a506b1a8eb3366cff53730b2978bc。默认严格STA WNS/TNS=-.306/-3.459ns、14setup，WHS/THS=-1.865/-25.616ns、14hold，WPWS+.333ns。最差setup仍CLK→dac_data[1]，Fast角CQ.204+OBUF1.635+net.001。startup改动使非DAC内部setup/hold无负（须以完整报告为准），但这不是整机R80结果。

默认hold把BBAA同值中间边沿作为潜在值变化。只有BBAA被证明后，诊断数学模型才给raw hold +2ns，代表下一次真实变化；没有应用multicycle或改动任何STA约束。64合法drive/slew共896行，允许逐bit drive/slew并假设固定路径整体移相，所有8种WRT配置的14位公共区间仍空；不移相最好最小必要裕量-.115ns。即使剔除不可能的重复边沿仍无必要窗口，所以不增加hold例外来刷PASS。扫描恢复原电气属性，DCP SHA不变；固定路径假设移相不是实际可实现时钟证明。

本候选不集成、不生成bitstream；完整Linien回归NOT RUN，外部SEL/CLK-WRT/pulse/PCB、整机CDC/DRC未完成。R80仍最佳且尚不正式可烧录。新增docs/ENGINEERING_ACCEPTANCE_20261112.md响应用户授权：官方未知项建立工程假设与限定接口配置，数据手册已知负路径不能用自行验收口径消除。ADC ±.2ns预留；DAC只从真实全角窗口反推可容PCB预算，未证明为正前不批准。

下一独立R87最小探针将比较250MHz区域时钟直接转发WRT，取消WRT输出串行寄存器级、让数据在相反边沿发出。先核对合法路由/有效clock关系及实际输出数据顺序，再判断是否有物理窗口，失败不合并。原Root/PS/ADC/CRG/算法/CSR保持不变。
