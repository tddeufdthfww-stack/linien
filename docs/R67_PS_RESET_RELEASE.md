# R67 PS-domain reset release

2026-11-12 独立opt/r67-ps-reset-release-20261112；以R66输入decd142为父，R66物理/完整回归仍在独立运行，其结果未假定通过。保留所有旧基线。

## 已证事实与修改依据

实际CRG+Migen原生UNISIM诊断已复现：PS reset在FCLK停止时释放，会立即释放原sys_ps.rst，未经过FCLK有效边沿。这是复位释放协议缺口，不是给跨域数量作标记可以消除的告警。AMD UG1046 UltraFast Embedded Design Methodology确认FCLK_RESET异步于PL，需按实际时钟域同步。
https://docs.amd.com/api/khub/documents/7KECH4F2hgvQrFavb20mVg/content

CRG中sys_ps.clk继续直连原FCLK0；sys_ps.rst由原PS raw reset经过标准Migen AsyncResetSynchronizer异步置位、两拍同步释放。PitayaPS的AXI arstn改接~ResetSignal('sys_ps')，使AXI/DummyHK/源总线在同一FCLK复位契约下。RootModule给CRG的输入仍是原始~ps.frstn[0]，没有同步reset反馈到自己的组合环。

## 延迟、范围和验证

只多2个控制FF，新增PS复位释放等待2个FCLK周期（125MHz时16ns），可能影响复位后首次AXI事务等待；正常事务/CSR地址/数据/背压/ADC→DAC反馈数据流水级全部不变。SYS域PLL失锁异步置位+两边沿释放、PLL/PS7/器件/引脚/时钟频率相位保持原样。

实际CRG UNISIM：停止SYS时失锁异步置位，恢复LOCKED且SYS停钟不提前释放，两个SYS有效边沿后释放；停止FCLK时PS复位异步置位，解除PS原始reset不能提前释放，两个FCLK有效边沿后释放。此模型强制LOCKED/sysclock，只证明数字reset逻辑，不是假装验证PLL物理失锁检测或模拟亚稳态。另从实际RootModule Migen对象检查PS raw reset→CRG async_reset、正确时钟域、AXI instance reset wiring，不能只看两行源码。

原生检查后完整功能回归、顶层CSR映射、新综合/route，检查新增同步器物理配对与reset恢复/去除路径。源桥自身ready仍有两拍，故源reset释放后还需要既有ready等待；不改变故障语义。本轮不修改bridge/axi_slave的错误数据处理，也不宣布其异常复位期间的数据保持已完成物理CDC证明。

R66继承的ADC/DAC与内部物理时序待实际结果，其他外部I/O协议、PCB、DAC脉宽解释和物理CDC签核仍OPEN。不生成正式上板镜像。

实际CRG原生compile/elaborate/simulate全PASS，SYS及PS两域停钟/异步置位/两有效边沿释放PASS；实际RootModule对象身份和axi_slave instance reset端口连线PASS。归档experiments/r67_ps_reset_native_20261112。下一步新生成/综合；独立R67 route尚未运行，不虚报物理CDC签核。
