# R60：R59同拍分发拓扑的一次postroute精修

R59代码4d74ae3，final route-.204/-5.183ns、59端点，已差于R57-.006/-.016ns、5端点，R59拒绝不合并。R59实际2→6 FDRE/+4同拍副本，完整负载/状态/全部已解析实例与94DSP审计通过；本轮仅探索该等价拓扑在一次标准postroute下是否有净收益，不能把输入当作胜出版本。

1. 94原始硬件测试工具SHA同R59，完整原生源功能和综合REUSED_R52经R59_NOT_RERUN；继承R59的FDRE已知数字状态归纳，不增加ADC/反馈/CSR采样沿，原快速相对R2b+32ns保持。
2. 从R59真实routed DCP与6行/2家族最终CSV重建安全字面量签名（拒绝括号/反斜线/换行），不执行任意外部旧Tcl；导出before/after/final，执行兼容placement/routing/rewire/critical-cell四项，再实际TNS cleanup，fullyrouted时Explore被忽略，不称从零全局route。
3. 新增FF或重接LUT若实际发生，须独立核对同状态输入、完整连接变化与组合函数；不能沿用“所有负载同”的旧断言掩盖rewire。全部94DSP对真实R59、源/top/CSR/XDC/DCP/CSV SHA冻结。
4. 比较R59及最好R57，最终setup/hold/CDC/DRC与功能范围分开报告。坏结果保留不合并，不改RTL/时钟/位宽/CSR/约束、不做retime/clock/DSP或BRAM寄存器优化、无bitstream/板端/激光操作。
