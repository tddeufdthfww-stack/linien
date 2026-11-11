# R52：R48 末级 C48 符号进位化简

输入R48 b0824e3/76dd452，最佳实际route-.179/-4.904ns、70端点，最终STA FAIL。R50输出边沿重定位虽然全功能PASS但route-.931/-706.938ns、1663端点，拒绝；R51仅物理列试验在独立树运行，结果不混用。本轮明确回到R48输出FF结构，不携入R50重定位或R51列pblock；新综合和route，不继承R47/R48的布局收益。

1. 只改gateware/logic/iir_c48_mac.py组合修正：Z=zlo.sign，C=coeff.sign，L=low.sign，原U=Z+(!Z & !C & L)-(Z & C & !L)，已知位真值等于(Z&L)|(!C&(Z|L))，即majority(Z,L,!C)。原correction=ztop+U、4位signed、最终50位拼接/模4高2位、乘法/级联/系数/右移/饱和/FF边沿均保持。已知8种符号×4种ztop、100320完整50位整数向量修改前PASS。
2. 不声称独立符号谓词对任意X组合等价（Z=X/C=0/L=1存在差异）。完整MAC中若zlo/coeff/xlo含X/Z，原低乘加全字未知并使高乘加及top未知，两种修正不改变完整输出；仅xhi未知则低17位保持、高31/top未知，修正输入相同；仅ztop未知则低48保持、top两位未知。该传播论证仍需原生完整50位严格四态验证，不能借此弱化断言。
3. 新增冻结原R48 helper与完整MAC320边界整数+4606部分X/Z逐位case-equality；原样71760完整50位乘加整数oracle及原config0完整IIR；新增config2/order1/2/5/真实CSR/冻结R48(明确引用旧split helper)/独立整数oracle/各3000X-Z。先小模块PASS，失败拒绝，不开始整机。原旧测试均不改。
4. 全旧14/25位PID/饱和/复位/CE/真实CSR/FastChain/Scope/阈值/AXI/CDC功能，再新生成/synth/place/route和readonly完整路径/实际DSP/CDC/DRC/覆盖；注册MAC helper不改，新增ADC/反馈/CSR周期0。不预言LUT级数或时序收益，只有实际route可判优劣。
5. 原用户工程/R2b/R4a/R48冻结保护；新输入SHA/代码/结果/失败日志分别归档。PS7/PLL/器件/引脚/ADC/DAC/CSR/总线源码和时序约束不改，不加false/multicycle/clock-group，不降阶/精度/吞吐，不部署。


## 冻结参考加载修正

首次IIR预检在加载阶段因缺少gateware.logic.r48_iir_c48_mac私有模块注册而中止，功能比较NOT RUN，非数值失败。原命令/源码/诊断见experiments/r52_reference_setup_failure_20261111。修正为先从冻结文件显式加载该私有模块，再加载冻结IIR；不引用当前候选helper，也不改任何旧测试断言/生产代码，在新目录重跑。
