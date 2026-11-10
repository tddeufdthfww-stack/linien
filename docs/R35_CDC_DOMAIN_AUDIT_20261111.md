# R35时钟域和握手审计


## 2026-11-11 / R35时钟域与握手路径只读审计

事实：R35实际clock interaction对clk_fpga_0↔clk_2标为No Common Clock / Timed(unsafe)。PS BD FCLK0=125MHz且来源IO PLL；ADC sys来自外部125MHz与独立PLLE2。不能因名义同频假定相位已锁定。No Common Clock是工具时钟关系分类，不能单凭该词认定握手RTL必然失效，也不能反过来把RTL功能测试当物理跨域签核。

三类真实最差路径分别是：FCLK保持地址addr_o[19]/C→Scope set_a_hyst[0]/CE −.702ns，logic1.465+route8.227ns；ADC同域dst_sync[1]/C→Scope set_a_filt_bb[1]/CE −.507ns，logic1.541+route6.602ns；ADC全域idx[2]副本/C→idx[1]副本/CE −.621ns，logic2.162+route6.084ns。最后一条表明R35将部分压力转到复制体的前驱CE，不能只按原index网扇出下降判定成功。查询打开DCP前后SHA一致，没有新约束或DCP写出。

协议事实：bus_clk_bridge中addr_o/wdata_o/sys_rd/sys_wr在sys_clk_i同一接受沿捕获，同时翻转sys_do；仅当sys_do==sys_done时可接受下一事务，期间保持全部请求载荷。dst_sync为两级目标域同步，wen/ren=sys_wr/sys_rd AND (dst_sync[1] XOR dst_do)；Scope在目标posedge采样写使能。ACK时在目标域捕获dst_rdata_hold/dst_err_hold并翻转dst_done；sys_sync两级返回，sys_ack=sys_done XOR sys_sync[1]，返回载荷保持到下次完成事务。

推断/待验证：在理想零延迟RTL事件模型下，最早写采样在目标第三级边沿，即从首次同步采样再经过两个目标周期，名义约16ns；返回载荷也有同步返回及消费边沿窗口。这不是已经签核的max_delay数值。真实预算还须计入第一同步级的setup/hold窗口、CQ、布线、时钟变化、目标D/CE时序、组合译码及复位epoch，并审查全部地址/数据/读写标志及返回载荷。特别是dst_sync[1]→Scope CE是完整8ns的真实同域路径，当前−.507ns不应豁免。

现有回归覆盖四相位、数据保持/读快照、AXI背压和双域一起复位恢复；代码检索和测试不能证明任意独立域复位/PLL失锁场景已覆盖。需要按真实复位分发审查事务取消或重放、控制同步器级间时序/ASYNC_REG和所有bundle物理最慢/最早路径。这里未新增独立复位测试，也没有据此判定新功能故障；这是约束签核前必须明确的边界。

决策：本轮不添加false_path/multicycle/clock_groups或放宽时钟，也不把“16ns名义握手窗口”直接填成豁免。CDC安全仍NOT_PROVEN。R36先以原约束进行零新增周期指令预取，分开记录同域与跨域残余，再设计有明确协议预算和完整覆盖的物理约束。

证据：experiments/r35_physical_20261111/cdc_domain_audit/，包括精确时钟/寄存器属性、同域与跨域报告、完整Tcl/日志/JSON。原R35归档ZIP保留不改；补充文件和当前metrics由新提交保留。
