# R38 / 2026-11-11：仅解除common_sum别名保留，删除恒等缓冲机会

独立分支从R36保留实验代码52fba6b/文档d7e5703出发；R36仍WNS−.656/TNS−59.314/371端点，未合并正式基线。R29最佳WNS−.617不动。**不携入R37删除限幅值属性**（R37功能PASS但route−.874/−157.785/836失败），正负限幅值和两类railed属性全部保留。

1. 只删parallel_tap_limit.py的common_sum.attr.add('keep')一条元数据调用；完整行为AST应与R36一致。
2. 真实R36网表critical common_sum_inst__10为LUT1 INIT2'h2，即Y=I0恒等缓冲；其输出只保留另一个I/Q公共项别名，关键路径消耗LUT.124ns及额外net.888ns。解除4个生成common_sum的DONT_TOUCH，给工具合并等价网的机会。
3. 原14/25 tap/整数oracle/真实CSR、FastChain30000、PID/Slow/IIR/robust51628/Scope/AXI/CDC全套重新运行；完整顶层必须除精确4个属性外与R36相同，然后独立综合与route。
4. 核查该BUF是否消除以及driver扇出/路由/端点变化，WNS/TNS/count/hold/pulse/CDC/覆盖/DRC共同评估。失败保留、不合并，不预先认定删BUF一定改善。

## 数学、结构证据和风险

源码common_sum=common_a+common_b没有变化；删除仅是综合元数据，全部表达式/比较/位宽/饱和优先级/最小负数/CE/reset/CSR/sync相同。实际Migen/Xilinx后端把.keep变成dont_touch=true。BUF证据来自R36实际routed_netlist.v：

```verilog
LUT1 #(.INIT(2'h2))
  linienmodule_fast_a_paralleltaplimitcsr0_common_sum_inst__10
  (.I0(linienmodule_fast_a_paralleltaplimitcsr1_common_sum[16]),
   .O(linienmodule_fast_a_paralleltaplimitcsr0_common_sum[16]));
```

R36该完整路径common_reg5/C→tap y17/D为9级/2CARRY4/1MUXF7、logic2.435+route5.703ns。FF Q扇出4，不做R35式高扇出强制复制；该BUF本身I/O真值恒等，不是算术取反。去掉别名保护可能把两个网络合并，降低一级和布线；也可能增加原FF扇出、改变全局布局，使其他路径恶化。保持限幅值的DONT_TOUCH，避免R37那类数据结构重新合并风险。本轮不删除原railed保护，也不添加pipeline。

ADC→DAC/robust/GPIO新增周期0，原R36同cohort三路预取保持；旧R28指定数字组件Bare72.1ns/快慢108.1ns继承，非本轮重测/fullRoot/SDF/板端。不携入R34 GPIO8ns或R35索引副本。约束仍8ns，无false/multicycle/clock_groups新例外；Scope同域/跨域分开审计，CDC物理安全NOT_PROVEN。无bitstream/板卡/激光/PZT操作。
