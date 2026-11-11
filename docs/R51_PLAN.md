# R51：IIR DSP列局部性物理试验

输入R50 ba88714/4023a30，完整原生功能PASS，新综合-.528/-674.697ns、1462端点；实际route-.931/-706.938ns、1663端点，WHS.023/THS0/WPWS1.5，已拒绝，不视为新的基线。最佳R48仍-.179/-4.904ns、70端点。R50关键DSP27CLK→LUT5溢出→LUT3保持→DSP28低乘法→DSP29PCIN，4.533logic+2.787route，PCIN setup1.400ns；A链32DSP跨X0/X1/X2，B链32跨X3/X4，raw22在X2。因此测试同列局部性，不能先断言必然解决。

1. 原始硬件及所有既有测试SHA同R50，完整功能和综合明确REUSED_R50_NOT_RERUN；R50已知有限50位/CSR/控制等价与30个非目标模式证据继承，不是本轮新仿真或postroute形式证明。
2. 只读R50 routed DCP取得真实组成员和列坐标、实际DSP site容量。枚举满足32/32/22容量的三个互异列，最小化水平移动距离，记录选择及220站点实际库存；不假定器件只有四列。
3. 新读R50 synth DCP，opt后逐组验证名称/32/32/22数量；创建仅含DSP资源、IS_SOFT=false的三列pblock，未约束LUT/FF/BRAM、没有CONTAIN_ROUTING/时序例外。不改原top.xdc，但这些pblock是本轮新增物理放置限制，必须记录，不能声称所有物理约束未变。
4. 新place Explore、显式placement/routing/rewire/critical-cell、真实route Explore/tns_cleanup；不retime/clock_opt/DSP或BRAM寄存器优化，数据/反馈/CSR/控制新增采样周期0。检查全部94DSP属性、每个86组成员最终所在列、输入两个DCP SHA和源冻结；功能/综合不重复计为本轮重跑。
5. 记录实际WNS/TNS/端点/hold/pulse/CDC/DRC/覆盖，既比较直接R50也比较最佳R48。若局部改善但整体不胜R48则保留失败诊断，不合并/不部署。PS7/PLL/器件/引脚/ADC/DAC/CSR/AXI/CDC源码保持，无false/multicycle/clock-group或降频。
