# R30：自动锁定32阈值的比较前移/一位结果后选择

独立于受保护基线，从R29记录6b29c3f分支；硬件父代码R28 9c5c32a，R29是同网表物理候选。R29 route WNS/TNS−.617/−91.147ns、545端点，STA仍FAIL。禁止上板。

## 真实路径和最小修改

R29 global：instruction_idx[1]rep0/C→gpio_n_o[6]replica/D，12级（4CARRY4），logic2.973+route5.330ns。沿实际路径comb_array_muxed5[2]→比较进位→state[12]，csrmap states[12]明确为robustover_threshold，而非凭端点名字猜测。

仅autolock_pipeline.py中over_threshold生成改调late_threshold_select.py：原32选1宽threshold/negative数组后比较，改32个原signed_abs_over_threshold并行、最后Array选1位。保留现有signed_abs helper、sum_diff/系数同cohort寄存器、instruction_idx/FSM/wait/sign/公开5状态/CSR地址。无寄存器或新时钟、无ADC→DAC/robust新增周期；PID/IIR/平台不改。

数学：任意固定有限S、有效idx∈[0,31]和同cohort表T，纯函数f(S,T[idx])=Array(f(S,T_i))[idx]。有限abs最小负数回绕和负threshold的行为沿用已验证R24/R25标量helper，不改数值边界。Migen Array默认项语义保留；未知位的RTL四态一致性由新bank差分/既有父模块测试检验，不由二值数学证明代替。

风险：32×两极性比较增加LUT/CARRY和sum_diff扇出，可能把瓶颈从index移动到sum_diff；KEEP仅固定1位并行结果边界，不加路径例外。若WNS/TNS/端点恶化，保留失败而不合并。原单通道/自动重锁/锁频功能不变，仍需完整实际测试。

## 验证和比较口径

新增原生bank：真实32×CSRStorage+CSRBank/部分写读回/同cohortabs和更宽负值，14/25/29位S、全部32索引、边界/有限minabs/随机、严格X/Z对照旧R28标量先选择结构及独立整数oracle。既有父FPGAAutolock/冻结R4a一拍参考50076拍、5公开状态严格四态、完整PID/IIR/AXI/CDC/Scope回归，CSR/XDC核对。

先记录新RTL默认综合/route，与R28默认流程比较；R29的post-route改善不能自动继承到新网表。如有必要，再用相同合法post-route流程单独留证。全部输入SHA/命令/失败/CDC及覆盖原样归档，不以综合或route完成宣称签核。
