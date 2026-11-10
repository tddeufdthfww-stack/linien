# R25：修正R23真实CSR预偏置源的signedness，先复现后修复

基于R24 a495d8e独立分支。R23 9d54b32已完成物理实现，但生产功能存在类型错误，不可采用；R24继承该问题，已停止完整流程（不修改运行中的源码）。保护基线及最佳已验证R22 ec028e3保持原样；没有上板/部署。

真实Root pre_offset_signal来自CSRStorage.storage（unsigned14），原offset_signal是同拍注册的signed14。R23直接(dy>>>11)+pre_offset_signal，生成Verilog明确零扩展$signed({1'd0,chain_a_offset_storage})，负偏置变为正值。原完整FastChain夹具使用signed14输入，遗漏真实生产类型，旧PASS不能证明R23/R24生产等价。

先只修改测试夹具：使用真实14位CSRStorage+CSRBank部分写，offset_signed按原Root同拍从storage复制；参考旧链使用signed寄存器，候选pre输入使用真正unsigned storage。冻结生产缺陷源码，执行原生FastChain pair并保存FAIL。然后生产代码显式将同宽位模式重新解释成signed再参与加法，不改变旧ya/offset采样边沿。h=storagebits，signed(h)=h-2^W当sign=1，否则h，和原Root offset_signed完全一致；同拍公共和及所有后级有限位宽运算保留，新加数据周期0。

修正后同一失败夹具必须原样PASS，并补充14/25位真实CSR部分写/读回/负数/边界/复位/CE保持下CSR仍更新的完整common中间值整数oracle。完整FastChain当前Root类型输入/热CSR/独立CE/复位、R24标量90800已知+8000未知/父模块50076、所有PID/IIR/AXI/CDC回归再次运行。新目录生成后检查Root Verilog符号扩展、CSR/XDC一致、输入SHA，重新综合/route/D-S-R-CE/CDC/资源。R23的时序只能作为功能无效的诊断数据，R24未完成阶段标ABORTED/NOT RUN，不用估计结果。
