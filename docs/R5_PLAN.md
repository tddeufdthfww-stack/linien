# R5 / 修改前论证 / 2026-11-09

基线为R4a，代码4e98ddb、记录fc1b424，route WNS/TNS=-4.822/-7902.165ns。R4a已增加快速PID16ns，本轮不再增加任何延迟，生产慢PID也不改。R4b KEEP版全局恶化已拒绝，不能继承。独立分支opt/r5-autolock-compare-20261109；原工程/R2b/R3/R4a不覆盖。

## 根因与单一候选

R4a全局最差robust time_scale[0]/C→gpio_n_o[0]/D经过动态延迟启动屏蔽、sum_value-delayed_sum、abs_sum_diff与阈值比较及状态选择，12.704ns=logic6.799+route5.905，24级/16 CARRY4。只改绝对值阈值比较，目标去掉绝对值补码与比较串联的carry；不改DynamicDelay/BRAM、计数器、ROBUST_AUTOLOCK_FPGA_DELAY、锁定状态转换、CSR、监视采样周期或GPIO寄存器。

## 数学等价（先于修改）

原代码将x写入signed n位abs_x，将h写入signed m位abs_h，n=m+1（生产n=29,m=28）；负数使用取负后截断。因而最小负数取绝对值仍是负数，不能用无限精度abs或普通无符号幅值“修正”原语义。

令Xmin=-2^(n-1)，Hmin=-2^(m-1)。原P=[abs_n(x)>=abs_m(h)]满足：
1. x=Xmin时，abs_n(x)=Xmin<Hmin<=abs_m(h)，所以P=0。
2. x!=Xmin且h=Hmin时，abs_n(x)>=0>Hmin，所以P=1。
3. 其余情况均为非溢出的普通幅值比较。并行计算精确n+1位signed D=x-h、S=x+h，选择一位谓词：x,h同号且非负→D>=0；同号且为负→D<=0；异号且x非负→S>=0；异号且x为负→S<=0。

最终P=(x!=Xmin) AND ((h==Hmin) OR 分情况谓词)。S/D位宽n+1，保证不会溢出；零与等幅值包含在>=/<=中。两个加减并行，后续只按符号/零/边界选择单bit，而非先形成宽位abs_x再比较。sign_equal原来的>0语义（含零）完全不动。没有新寄存器，峰检测/状态/锁定/CSR效果与R4a逐拍一致。

## 实施与验证计划

1. 新建组合比较模块，在autolock.py中替换仅用于over_threshold的abs构造/比较，冻结原autolock.py作为参考。
2. 用明确截断的整数oracle和原始Migen abs硬件三方比对：缩小位宽穷举、生产29/28位极值/零/等幅/随机。
3. 完整RobustAutolock双实例逐拍比较状态/触发/积分/动态延迟、配置突变、request/sweep/writing/reset；生产算术位宽，独立注明存储深度。
4. 加跑既有robust非slow用例及R4a全部8项/流水线/CE/CSR/AXI/CDC四相位回归、顶层生成/CSR map/XDC。
5. 同8ns约束及directive综合、实际route、普通/DSP PID端点/robust路径/CDC分类，源码SHA与stdout/stderr/退出码/标记分阶段保存。
6. 全局WNS恶化则保留源码/报告但不并入R4a；TNS/端点/功能同样比较。STA/CDC/I/O未签核前不生成或部署bitstream。不以单次失败断言125MHz不可能。
