# R31：8组×4阈值的有限并行、零新增周期

R30完整功能/原生32CSR/父FSM/所有回归PASS，但实际route−1.204/−229.464ns、986端点，退步不采用。最差sum_diff_s1[0]/C→GPIO5rep/D，logic1.964+route7.039ns、10级无CARRY，说明瓶颈转为32谓词的数据扇出与布线。R31在独立分支精炼该失败结构，不合并R30。当前有效RTL仍R28 9c5c32a，物理候选R29 −.617/−91.147ns。

只改late_threshold_select.py：32比较lane减至8，每lane先在4项宽阈值中选择，再比较；最后选一位结果。idx=8q+r，q=idx[4:3]、r=idx[2:0]；lane_r选择T[8q+r]，out=f(S,T[8q+r])，数学与原f(S,T[idx])完全相等。signed_abs标量/helper、32CSR同cohort FF、FSM/5状态/流水线/CE/reset都不改，新增ADC反馈和robust周期0。

保持8个1位结果的Migen keep（后端实际DONT_TOUCH）以固定分组，禁止约束到源FF或整模块。低3位索引只晚选1位，高2位只早选四项，sum_diff算术负载降到R30的约1/4；不把这个估计当时序结果。风险是高2位索引扇出/早选宽数据路径重成瓶颈。

未知位语义不能直接使用嵌套Array代替：原完整5位index含X/Z时default最后一项31，而分组高/低选择可能落到别项。因此外层Case显式列出全部32合法index，default独立原谓词f(S,T31)，严格保持旧四态语义；二值硬件default不可达，不改变实际32索引数学函数，不是STA例外。

验证必须使用未改动的R30真实32CSR-bank/旧R28标量与独立有限abs oracle夹具（相同Git blob），N14/25/29与所有32索引/部分写/复位/读回/各2000 XZ；完整父FPGAAutolock50076拍与冻结原5状态、所有功能/CSR/XDC检查、新综合/实际默认route。记录R28默认/R29 postroute/R30失败的不同输入与flow口径；失败保留，不无依据重复大型架构试验。不降阶/吞吐/时钟，不动平台/PS/ADC/DAC/AXI/CDC源码。
