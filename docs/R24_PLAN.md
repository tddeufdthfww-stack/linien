# R24：自动锁定绝对值/阈值串行链改为并行带符号比较，新增周期0

基于R23 9d54b32独立工作树，R23物理结果待完成；R22实际-1.500/-211.865、586端点、WHS.005，STA FAIL。R20既有残余sum_diff_s1[0]/C→waited_for/R=-1.075ns，R22 autolock分组仍-.511、GPIO-.700。只改自动锁定算术谓词，不改ADC→DAC数据和原robust一拍控制输送。

原谓词A=absN(S)>=T，其中S为signed N，T为signed M且N>M（生产29/28），T是原有限M位abs(peak)，允许min peak取abs仍为负数。设NT为精确signed N的-T：当S>=0，A=(S>=T)；当S<0且S不是minN，A=(S<=NT)，即使T<0仍成立（非最小S的abs非负）；S=minN时absN(S)=S，必须用原S>=T。故A=Mux(S.sign && S!=minN,S<=NT,S>=T)。保留比较而非强制常数，也保持未知位的原四态传播。两个比较并行，移除S取负→比较的串行进位链。

negative_threshold必须和原magnitude在同一CSR-cohort边沿由组合abs_next计算，先显式符号扩展到N再取负，不可从已注册magnitude再加一拍。新增每条指令的NT副本，不新增数据或反馈周期；CSR地址、clock/CE/reset、N_instructions/peak/wait配置热写、指令推进、全部五个state_out保持。

新增logic/abs_threshold.py、修改autolock_pipeline.py、增加tools/check_abs_threshold.py及全流程hook。先5位穷举512组、14/25/29位各30096组和每种宽度2000未知位严格case比较，再原生完整FPGAAutolock父模块/真实CSR对冻结R4a独立一拍参考50076拍（含RAM未知55严格四态）及旧robust套件。之后完整PID/CE/CSR/AXI/CDC回归、CSR/XDC一致、新目录综合route/路径/CDC/资源。额外FF和配置阵列可能影响布局与CSR扇出，必须实测。零约束放宽、无bitstream或上板。
