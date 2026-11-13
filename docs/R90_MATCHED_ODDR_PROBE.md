# R90 同类ODDR输出探针 / 2026-11-13

父版本R89 e7c11e4330ee5f19b4e8c23216cb79974323aa0a，独立工作树；R80保持最佳未改。新增探针与工具，不集成Root/PS7/ADC/PID/IIR/CSR。

数学依据：令IO时钟正沿t=4k-.5ns，u[k]为此时原FDRE的输入字。SAME_EDGE的D1=D2=u[k]在同一正沿采入，Q正沿输出u[k]、负沿重复同一个u[k]。下一有效字仍在t+4ns，新增正常反馈整拍0，双125MS/s和14bit保持。WRT仍同一250MHz BUFIO的ODDR固定01，正沿t+2ns，采样序列同旧A/新B。整个启动/停钟恢复受DACreset限定，需实际原语复核。

该结构匹配data/WRT的ODDR类型，测试是否改善实际C-Q相对范围；不以手算预报收益。仅14个特定数据ODDR使用DONT_TOUCH防止优化折回FDRE；不是全局保留或时序豁免。综合后必须14个ODDR SAME_EDGE且每个D1/D2同一net。原默认setup/hold保留，若负沿同值引起多余hold路径，只有结构/原语证明后的必要诊断可独立计算，不能直接加例外刷PASS。

先全码值/逐时刻/样本oracle/复位/显式停钟恢复，再新综合、place、route和I/O实际路径。若无必要窗口，不集成整机。参考SYS为直接输入125MHz的小设计，并非整机原PLL级联；小试验PASS不代表整机签核。

依据：AMD UG471 OLOGIC SAME_EDGE及UG953 ODDR。https://docs.amd.com/r/2023.2-English/ug953-vivado-7series-libraries/ODDR

# R90 ODDR SAME_EDGE探针：功能PASS，物理FAIL / 2026-11-13

独立父R89 e7c11e43，R80不变。新增14数据ODDR SAME_EDGE，D1=D2同字正沿采样、负沿重复，不改输出旧A/新B、14bit/双125MS/s；正常反馈新增0整拍。DAC启动用既有16SYS guard。14个特定ODDR DONT_TOUCH防止折回FDRE；综合确认14个SAME_EDGE且每个D1/D2同一net。

native01实际原语PASS：73573writes、A36788/B36785、2354335逐时刻比较、32768通道码值、3epochs，停钟2us内reset及显式恢复PASS。RTL SHA=b7391519ae80e2b6d5085876c2f2c8b798bf3d547257fe529d48762810997298。

新综合COMPLETE、新place/route COMPLETE，DCP SHA=2069b6da10f71c2d9bb2414f3a67998345cdf4459bb7544c07b0dcd51b21e4a2。global WNS/TNS=-1.090/-30.540ns、43setup，rawWHS/THS=-1.899/-26.084ns、14hold，WPWS+1.500ns。只读按源clock正/负沿分开查询、无例外：真实上升沿DACsetup-.346/hold+.038；下降沿重复值的rawhold不能直接视为新的有效数据变化，但真实上升沿setup也未通过，故不添加例外签核。

实际最差报告中data ODDR C-Q=.472ns、WRT ODDR C-Q=.411ns。SAME_EDGE与OPPOSITE_EDGE虽然同名原语，时序模式不同并未获得匹配CQ；不可只凭“都用ODDR”宣称改善。数据路径3.726ns=logic3.725+net.001，与FDRE参考几乎一致。最小探针counter/mux另有内部负路径，不能把该global WNS当作R80内部结果。完整Linien集成/回归NOT RUN；正式基线未改，拒绝此候选，不生成bitstream。

下一独立R91评估半拍预装：在每个IO负沿把下一字寄存在fabric FF，ODDR OPPOSITE_EDGE的D1/D2同接该history。正沿读取上个负沿值、负沿D2读取history更新前值，保持每4ns一字；A在SYS前2.5ns预装、B在SYS后1.5ns预装，目标输出仍SYS前.5/后3.5。预装时钟使用同MMCM输出经BUFR250，不让BUFIO非法驱动fabric；必须新验证history→D2同边沿hold及SYS→history较早捕获setup，不用名义相位掩盖BUFIO/BUFR实际偏斜。只在实际序列及物理路径成立时才认为零新增反馈延迟。
