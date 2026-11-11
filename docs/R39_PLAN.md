# R39 / 2026-11-11：Scope配置CE重映射到D，全部数据周期0新增

从R38代码291fbec/记录3fef5e4独立分支。R38已去掉common_sum别名DONT_TOUCH且实际alias LUT1列表为空，但route−.619/−83.023/451仍失败，未合并；最佳WNS仍R29−.617。当前全局FCLK保持addr17→Scope set_a_filt_kk15/CE为logic1.694+route8.021ns；同ADC域Scope CE−.131ns，另有FastB IIR DSPCE−.555ns，不能只豁免跨域路径。

1. 在独立14/25位叶子上真实synth/opt验证显式CE→D变换（属性版未生效记录保留），确认FDRE/FDSE寄存器数不增加、CE成为常1，并与原生UNISIM时钟使能FF逐拍比较。
2. 叶子通过后，复用SHA一致R38功能与综合DCP（明确REUSED_R38_NOT_RERUN），仅对Scope配置set_*中使能非恒定的fabric FD显式连接D反馈mux/常1 CE，执行新opt/place/phys/route。原RTL、AXI/CDC握手、CSR地址、频率和例外不改。
3. 保存属性目标清单、CE前后网络/INIT及优化后利用率/时序；检查真实/D和/CE、同域/跨域、其余IIR/PID路径和全部资源/CDC/覆盖/DRC，不因端点换名而称问题解决。
4. WNS/TNS/count/hold/pulse一起选择；失败保存不合并。Scope以外寄存器不设置该属性，不能复制ASYNC_REG同步级来伪造改善。

## 状态方程和验证边界

实现更正（整机尚未执行）：属性版叶子opt_design完成但CE仍接原端口，结构断言FAIL，因此不能称重映射成功。改用显式网表LUT3 INIT8'hAC，I2=旧CE、I1=旧Q、I0=旧D，O接FF.D，FF.CE接常1，C/R/S/INIT不动；保护原FF避免重新提取CE/移动状态边沿，组合驱动仍可优化。原属性版与首个日志查询空对象错误的源码/Tcl/日志保留。只有新方法的实际门级与结构都PASS才用于完整工程。此更正不修改gateware RTL，也不改变状态方程。

原FDRE：Q_next=R?0:(CE?D:Q)。原FDSE：Q_next=S?1:(CE?D:Q)。ENABLE重映射后CE'=1，D'=CE?D:Q，原R/S与INIT保留，故任意合法0/1控制、任意数据序列每沿恒等，没有新增寄存器、反馈或CSR事务周期。异步未知控制/亚稳态不由这个布尔等价证明；叶子测试包括已知CE/reset及X/Z数据，完整R38源码四态/CSR/AXI/CDC回归证据原样复用，不声称全Root/SDF门级形式等价。

仅依据属性移到D不保证更快：D反馈mux可能增加数据逻辑与路由；收益可能来自更短数据setup、局部LUT合并和控制集减少。需确认实际实现，不把CE端点消失当成时序PASS。

官方机制：AMD/Xilinx UG912(2019.2) CONTROL_SET_REMAP，https://docs.amd.com/api/khub/documents/rk0Uzk92HN6YiZcSJ3RgaA/content ，适用于fabric寄存器，逻辑优化时把EN或同步S/R合并到D，ENABLE只处理EN。本轮不设置RESET/ALL、不加流水线、不改时钟、不添加false/multicycle/clock_groups或束数据预算豁免。

ADC→DAC/robust/GPIO本轮0周期，R28指定组件Bare72.1ns/快慢108.1ns只继承，非本轮重测或板端总延迟。PS/ADC No Common Clock关系与bundled-data保持/复位epoch仍需独立签核，CDC NOT_PROVEN。无bitstream/板卡/激光/PZT操作。
