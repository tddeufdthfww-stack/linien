# R91 半拍预装与OPPOSITE_EDGE输出探针 / 2026-11-13

父R90 5a519c5e，原R80/生产硬件保持。只新增独立probe/test/physical工具。
设io正沿4k-.5、负沿4k+1.5；负沿fabric FF预装下一正沿的word，ODDR正沿D1读history、负沿D2读history更新前的值，所以当前UI重复同一字。A在SYS-2.5ns预装旧a_hold，B在SYS+1.5ns预装新b_hold；目标仍SYS-.5/3.5输出旧A/新B，零新增正常反馈整拍。输入更早采样，须实际原语严格字序/全码/复位比较；不能对真实任意控制输入默认为无时序要求。

history时钟由同MMCM CLKOUT0经BUFR BYPASS250产生，数据/WRT ODDR仍用BUFIO250；不让BUFIO驱动fabric。明确风险：BUFIO/BUFR相位插入差可能使history→D2同边沿hold失败，SYS→history也比旧输出早2ns。两者必须新STA全角真实核对，不加例外掩盖。D1/D2同history net、14个OPPOSITE_EDGE数据ODDR和特定预装FF保留以评估CQ，不做全局DONT_TOUCH。

R90实报SAME_EDGE数据CQ.472/WRT.411，所以本轮改变真正的ODDR模式并配合半拍预装，而非只改名称。125MHz、14bit、双125MS/s、CSR/ADC/算法均不改，初始16SYS等待只影响启动。完成原语验证和新综合/place/route后再评估是否有必要数据眼。无bitstream。

# R91半拍预装失败与R90解释更正 / 2026-11-13

独立父R90 5a519c5e，新增BUFR250负沿fabric history FF及OPPOSITE_EDGE ODDR，D1/D2同history。native01全序列PASS：73573writes、A36788/B36785、2354335pairs、32768码值、3epochs；正常输出仍旧A/新B，新增反馈整拍0。

新综合/place/route COMPLETE，global WNS/TNS=-1.911/-36.007ns、40setup，rawhold=-1.899/-26.084ns、14，WPWS+.826ns。DAC有效上升沿setup仍-.346；history→D2同边沿hold最差+.324ns，确实由真实路径满足，而较早history捕获setup最差-1.911，起点frame_copy/C→preload/D，1.110ns逻辑布线、clockskew-2.153、名义1.5ns预算。未豁免hold或reset，不接整机。RTL SHA2d4d19d26621e9dfcfdbd39ce509511f80cfca367be202f049ad77e658684495，DCP50e3adc3aa27854c414727824a44e2325de782b037454a7a753b50d33f46c696。

更正R90的根因解释：先前把data CQ.472与WRT CQ.411的差归于SAME_EDGE/OPPOSITE_EDGE模式，依据不足。这两个数分别是setup最晚数据和最早捕获时钟；R90 hold报告中data CQ=.411、WRT=.472，早晚条件交换，R91改成OPPOSITE_EDGE后data max CQ仍=.472。不能把跨早晚条件的数值差直接归为模式开销。原报告与实验结果不改写；R90功能PASS/物理FAIL结论仍成立。后续必须同工艺角、同早晚及同转换条件比较。

下一R92仅独立最小试验：IDELAYE2 DATAIN→DATAOUT回到fabric，经特定保留LUT后才驱动OBUF，不直接IDELAY→IOB；先由Vivado判定合法路由。源为同一250MHz BUFG时钟，data仍正沿采样，WRT为该同一事件经校准延迟后的波形，不依赖另一周期VCO边沿；固定tap、IDELAYCTRL200MHz参考与RDY启动guard。实际拓扑成立后输出setup必须收紧为同事件0周期、hold核对下一字，不通过放宽4ns周期或删除路径制造PASS。0周期检查是更严格的事件建模，需原语波形/实际报告证明。正常反馈整数级不变，启动等待可能增加，先不改生产Root/PS/ADC/原PLL/CSR。
