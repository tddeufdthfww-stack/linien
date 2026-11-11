# R57：同拍副本网表的布线后物理收敛试验

直接输入R56 7e177b1/886e3af，4→21 FDRE、+17平行副本的D/C/CE/R/INIT/属性及完整负载分配审计PASS，资源增量精确匹配，94DSP同R53；实际route-.205/-.942ns、16端点，WHS.014/THS0/WPWS1.5，整体未胜R53-.014/-.052ns、6端点，仍拒绝，不视为基线。本轮只测试该等价新网表是否能经同类R53成功post-route优化获得净收益，不携入R55坏走线。

1. 原始92硬件测试/工具SHA同R56，源功能/综合REUSED_R52_NOT_RERUN，FF同状态归纳与负载连接证据继承R56；不重新复制、不改Migen/RTL/CSR/输入输出/时钟/8ns要求，新增反馈采样周期0。
2. 读取实际R56 routed DCP，只做兼容post-route placement/routing/rewire/critical-cell四项，再真实TNS cleanup；不retime/clock/DSP或BRAM寄存器优化、新pblock、false/multicycle/clockgroup或降低频率。
3. 从已核验R56最终CSV重建安全Tcl字面量签名数据，拒绝括号/转义/换行注入；不直接执行外部旧Tcl文件。实际输入/物理后/最终导出全部副本家族，逐组控态和完整聚合负载审计；94DSP对输入R56、额外FF数与家族增量核对，原DCP及输入CSV SHA冻结。
4. 比较直接R56与全局最好R53，分别保存postopt/final数据。源native PASS不等于fullRoot postroute/SDF/形式或物理CDC/板端安全证明；即使受约束setup满足也需独立关闭DNA/I/O/CDC/DRC才可最终签核。不合并保护基线、不部署。
