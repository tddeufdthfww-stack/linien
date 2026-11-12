# R69b qualified SYS response regression contract

2026-11-12。只改测试/记录；硬件源码逐raw保持R69 afdfa183，无新综合/route，物理数据明确复用R69（-.411/-30.808ns，STA FAIL）。

R69原始严格full在Scope复位79926ns FAIL：reset0/0、ACK0/0、ERR0/0，数据0/1。R69刻意让return payload跨epoch无效化时保持，而有效fault ACK本地置0；ACK0时数据不构成事务响应。原件和FAIL全保留，不将其改成PASS。

数学/接口依据：SYS总线数据由AXI在rd_do && ack时锁存；Scope母模块同样以ACK资格返回事务。ACK为0时payload/ERR不构成有效响应。R69新fault/timeout/invalid读在AXI端明确置零并已有32独立故障例覆盖。正常qualified ACK包括下游ERR时payload仍与原来相同，必须继续证明。

新wrapper保留冻结R38 Scope+bridge参考和原3测试脚本SHA；不替换成候选bridge、不改DUT、不改原脚本。原生生成fixture仅保留R61既有reset三SYS等待，并把原“无ACK周期也相同”监视器拆为：ACK始终严格四态比较；任一ACK非确知0（包括X/Z）时payload+ERR严格比较；两ACK均0的差分计数并报告。Scope数值/所有内部状态/CSR/cohort/BRAM/触发/时序脉冲断言逐字保留。原runner旧scope声明另外归档，新的结果明确写实际契约，不能伪称全周期raw bus相同。

这一步并非提前宣布有效响应PASS。先运行新Scope suite，通过后才完整回归；任何有效ACK/数值/状态失败必须修源码，不可继续放宽断言。该branch不做新的时序例外、不改clock/反馈延迟/CSR接口。run_gateware_trial功能阶段新增RUNNING/FAIL状态，修复异常中断时manifest残留NOT RUN的记录问题；旧manifest原件不改。

R69b目标factor-cache回归四相位全部PASS：161872 scalar固定点及3000 X/Z案例、四整Scope原生数值/状态/内存/CSR/cohort/无条件ACK/有资格payload检查。无ACK周期差分计数保留。初版wrapper变量遮蔽了simulate的字符串marker，工具TypeError导致未完成；原fixture/日志/source归档并修正变量名，未改任何DUT或仿真断言。56个实际gateware/hardware/common文件逐RAW与冻结R69一致，物理结果仅REUSED_R69。完整契约回归尚待运行，原严格空闲payload差分FAIL保持。
