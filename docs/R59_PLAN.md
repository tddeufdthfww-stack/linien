# R59：R57剩余phase9和IIR输出15的同拍状态分发

R57 f64fad2为输入；R58实际保留route未改善，仍-.006/-.016ns、5端点，不携入R58路线。剩余路径来自phase9（17负载、两CORDIC端点-.006/-.004ns）、IIRy15（3负载，tap限幅-.003ns）及已复制过的Acommon3（另两个tap端点-.002/-.001ns）。R56之前Q>=4筛选从未处理本轮IIRy15。

1. 93原始硬件测试工具SHA同R57，源native与综合REUSED_R52经R57_NOT_RERUN，R57状态/LUT局部穷举审计继承。只选上述2个精确单元，核对真实routed负路径、ADC clk_2、FDRE/非ASYNC/非保护/Q>=3，不根据名字泛选其他来源。
2. 独立工作树中全unroute兼容本机force复制（只拆局部网会被判postroute拒绝）；phys_opt只force这2条Q网，导出复制前后与最终每家族D/C/CE/R/INIT/属性及完整聚合负载。q_next=R?0:(CE?D:q)，相同输入和INIT副本由归纳逐拍相同，不新增任何采样沿。
3. 使用已验证可执行的Explore+tns_cleanup，不加preserve，不重复不兼容入口；保存replicated.dcp、最终routed.dcp和全STA/CDC/DRC。原全部路线可能变化，不承诺只改2条物理走线。
4. 资源FF增加与实际副本数匹配，94DSP对输入R57保持；原RTL/top/CSR/XDC与输入DCP SHA冻结。以final WNS/TNS/端点/hold/功能综合判断，不因副本生成成功声称时序过。新增串行延迟0，原快速对R2b+32ns保持，未降低时钟或添加例外。坏结果保留不合并，原R57/R53/保护基线不变，无板端/激光操作。
