# R33：与二进制指令索引同沿更新的一热镜像

独立分支基于R29已保留硬件（R28 9c5c32a），不携带R30/R31失败并行谓词方案。R29最佳WNS−.617/TNS−91.147；R32同综合DCP重新布局得到−.691/−67.215，TNS更好但WNS更差，均未STA签核。真实最差仍二进制idx[1]→宽表选择→over_threshold→GPIO6，12级/4CARRY，R32logic2.975+route5.402ns。

## 数学与时序依据（修改前选定）

保留原5位index及全部计数/FSM/CSR，新增32位**并行状态编码**OH。初始/全局复位/at_start：index=0,OH=1。原advance分支同一时钟沿执行index=(index+1)mod32、OH=rotate_left(OH,1)；其他情况两者保持。由归纳法，所有有效时钟状态OH=1<<index恒成立，不能写成OH[n+1]=1<<index[n]（那才会多延迟一拍）。新增物理32个状态FF，串行反馈/robust/ADC数据深度新增0拍。

对任意同宽位向量表T，若OH为对应index的一热字，则OR_i(T_i AND replicate(OH_i))=T[index]。所有表的signed/unsigned宽度保留，先同宽按位选择后赋Signal.like，避免R23那样的signed扩展错误。替换阈值两极性、符号、等待时间及原始peak查询；原signed_abs标量谓词完全不改，避免R30的sum_diff比较扇出增加。软件数字索引/地址、5个公开状态与所有原cohort寄存器保留。

目标减少二进制索引跨32项宽表的全局译码/扇出，镜像位可靠各自表项放置。风险为advance/clear使能增加32个FF负载、一热OR归并路由或编码不变式出错；不以估计作为时序结果。没有DONT_TOUCH/新路径例外/新时钟/新流水线。相比原状态追加32FF属于并行存储，不是index FF→decode FF的串行链。

## 验证

按位选择14/25/28/29位、bool与unsigned wait，全部32项及符号/极值/随机和X索引默认模型；真实父FPGAAutolock/CSR与冻结R4a一拍参考保留原50076向量及全部断言，追加自然FSM走遍32索引、部分写/读回、复位/at_start，逐拍断言OH==(1<<index)，不force状态。原完整PID/慢链/IIR/AXI/CDC/Scope/CSRmap/XDC回归；新独立综合/route，统计真实OH寄存器与查表映射、worst各分组/CDC/DRC/覆盖、sourceSHA前后。若失败归档不合并，不牺牲吞吐/阶数/精度。

原R28组件Bare72.1ns、快慢108.1ns为继承同源PID/Analog/ODDR周期契约，本轮未重新测fullRoot/板端；必须以新增0周期和完整控制等价证明区分实际物理签核。无板上/激光操作。
