# R42：IIR既有反馈状态保留在fabric的零周期候选

基线R40代码/记录079667f/b018d47，实际route−.582/−24.707ns、234端点、最终STA FAIL；硬件RTL与R38 291fbec相同。R40真实最差FastB IIR1 low-DSP CLK→high-DSP CEB2：7.975ns=5.972logic+2.003route、DSP48E1+LUT5+LUT6；不是PID乘法本体已坏。R38同路径DSP内部A/B寄存器1、M/P0，CE setup .514ns，现有IIR y反馈状态被吸入DSP输入寄存器。

1. 只在gateware/logic/iir.py的既有内部y=Signal.like(self.y)后增加y.attr.add("keep")，后端映射为DONT_TOUCH，尝试保留同一反馈FF在fabric，不增加任何sync语句或状态边沿。
2. 数学依据：仅元数据变更，删去唯一新增attr调用后整份Python AST与R38相同；50位有限MAC/溢出保持/clear/hold/CSR/采样次序和所有同步赋值相同，预期ADC/滤波反馈/CSR新增周期0。实际DSP寄存器配置改变是有意的映射调整，不能要求或宣称全部DSP寄存器属性不变。
3. 重新完整原生14/25位/IIR order1/2/5/真实CSR/50位oracle/溢出hold/clear/reset/CE/PID/Scope/AXI/CDC回归；生成HDL仅精确9个IIR反馈y元数据声明变化，若实际数量不同先核实，不改算术求值器或弱化测试。
4. 新综合与实际route；检查y的真实FDRE及其C/CE/R/INIT、DSP BREG/CE路径和新的全局/组内关键路径。fabric FF CE/D setup通常较DSP CEB低，可能回收部分裕度，但放置/额外布线可能抵消，不能预先承诺收益。
5. 本轮先新RTL默认流程独立对照R38；R40对输入DCP的物理分发并不会自动继承。后续如需同一物理策略，必须另独立记录实际执行与route，不拿旧R40时序贴新RTL。
6. 不携入R41 Scope源域译码，不增加反馈周期/时序例外，不改时钟/PS7/引脚/AXI/CDC/软件接口。失败源码报告保留、不合并保护基线；最终STA/CDC/I/O仍未签核前不部署。
