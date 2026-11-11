# Z7020 前端与IIR优化：R17起的实际结果

2026-11-11。目标始终是STEMlab125-14 PRO Z7020 Gen2。所有版本均未最终签核，不能当作已验证可上板或激光闭环版本。R2b/R4a/原用户工程及R16源码、提交和原工作树状态已逐文件核验未改变。各轮独立Git工作树；未直接合并保护基线；没有生成/部署bitstream。


## 最新归档与当前最好候选

最新归档为R55，不代表已采用该轮。当前保留候选中按WNS/TNS/端点综合最好的为 **R53：WNS=-0.014ns、TNS=-0.052ns、违规端点=6**；受约束setup=FAIL，最终STA仍FAIL（覆盖/物理CDC/I/O/DRC未关闭）。功能和综合是否重跑逐轮分开记录。代码提交 `e25e8f0c6af4f694533e3d25f5626ae9e3ec7b18`。原用户工程与保护基线没有被替换。

## 进度与轮数估计

已经找到有效的分解方法：混合器DSP乘积寄存器与事务对齐显著缩短前端路径，精确C48乘加消除部分宽进位链，保留完整50位结果、阶数与每拍吞吐。仍有多个独立瓶颈，所以不能给出有依据的最晚完成轮数，也不能把WNS改善比例当成项目完成百分比。

本次开始时估计乐观3–4轮解决主要内部125MHz时序、约5–6轮连同CDC/I/O等签核；这只是乐观估计，R23暴露真实顶层CSR类型验证缺口后，不能继续当作排期承诺。8–12轮同样只是预算，并非最晚保证。物理跨域安全、外部I/O时序和板端实测可能需要额外资料；激光闭环调试不包含在这些轮数中。不得把功能无效版本的WNS改善计为有效成果。

## 综合与布线

| 版本 | 综合 WNS/TNS ns | 实际布线 WNS/TNS ns | Setup违规端点 | 判定 |
|---|---:|---:|---:|---|
| R2b | −6.094 / −4563.029 | −5.605 / −10473.525 | 6813 | 基线，STA FAIL |
| R16 | −3.911 / −3598.924 | −4.068 / −5780.718 | 5437 | 隔离候选，STA FAIL |
| R17 | -2.836 / -3068.768 | -2.8 / -4213.79 | 4523 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R18 | -1.818 / -592.081 | -2.326 / -1448.239 | 1955 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R19 | -1.8 / -421.523 | -1.852 / -799.692 | 1205 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R20 | -1.811 / -391.486 | -1.838 / -600.003 | 1287 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R21 | -2.412 / -414.722 | -2.104 / -670.303 | 1198 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R22 | -1.732 / -386.595 | -1.5 / -211.865 | 586 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R23 | -1.376 / -261.485 | -0.706 / -297.767 | 1874 | REJECTED_NOT_MERGED，生产功能FAIL，诊断数据不可作成果 |
| R24 | 已调用后中止，无WNS | NOT RUN | — | 继承生产功能缺陷，拒绝采用 |
| R25 | -1.528 / -273.525 | -0.981 / -174.051 | 643 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R26 | -1.908 / -316.14 | -0.91 / -190.722 | 751 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R27 | -1.908 / -301.989 | -1.042 / -229.718 | 795 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R28 | -1.908 / -307.63 | -0.788 / -99.471 | 566 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R29 | -1.908 / -307.63（复用R28） | -0.617 / -91.147 | 545 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R30 | -1.908 / -327.676 | -1.204 / -229.464 | 986 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R31 | -1.908 / -313.517 | -1.407 / -275.553 | 987 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R32 | -1.908 / -307.63（复用R28） | -0.691 / -67.215 | 456 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R33 | -1.908 / -315.903 | -1.297 / -244.445 | 1022 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R34 | -1.908 / -297.382 | -0.845 / -146.894 | 575 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R35 | -1.908 / -297.382（复用R34） | -0.702 / -159.35 | 724 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R36 | -1.908 / -303.52 | -0.656 / -59.314 | 371 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R37 | -1.908 / -277.354 | -0.874 / -157.785 | 836 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R38 | -1.908 / -263.098 | -0.619 / -83.023 | 451 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R39 | -1.908 / -263.098（复用R38） | -0.655 / -133.656 | 587 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R40 | -1.908 / -263.098（复用R38） | -0.582 / -24.707 | 234 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R41 | -1.908 / -250.466 | -0.791 / -90.059 | 522 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R42 | -1.966 / -668.12 | -1.161 / -454.743 | 1164 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R43 | -1.908 / -250.466（复用R41） | -0.578 / -43.286 | 366 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R44 | -1.376 / -207.877 | -0.691 / -136.392 | 707 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R46 | -1.376 / -180.925 | -0.539 / -18.344 | 131 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R47 | -1.376 / -180.925（复用R46） | -0.282 / -5.173 | 70 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R48 | -1.376 / -180.925（经R47复用R46） | -0.179 / -4.904 | 70 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R49 | -1.376 / -180.925（经R47/R48复用R46） | -0.179 / -4.904 | 70 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R50 | -0.528 / -674.697 | -0.931 / -706.938 | 1663 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R51 | -0.528 / -674.697（复用R50） | -0.794 / -679.44 | 1614 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R52 | -0.773 / -60.316 | -0.222 / -6.177 | 73 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R53 | -0.773 / -60.316（复用R52） | -0.014 / -0.052 | 6 | CANDIDATE_NOT_SIGNED_OFF，setup FAIL；最终STA FAIL |
| R54 | -0.773 / -60.316（经R53复用R52） | -0.014 / -0.052 | 6 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |
| R55 | -0.773 / -60.316（经R53复用R52） | -1.349 / -19.09 | 32 | REJECTED_NOT_MERGED，setup FAIL；最终STA FAIL |

功能PASS、综合COMPLETE、布局布线COMPLETE与最终STA FAIL是四个不同结论。综合中的负hold不与route后hold混用；完整WHS/THS/WPWS和覆盖数据见逐轮索引。

## 修改和数学依据

- R17：registered_error_mixer.py启用MREG；bias/offset/single/dual与乘积同拍。feedback_pipeline.py携带同一采样的running/setpoint/gains/reset/CE、直接ADC与模式、limit上下限；iir.py把raw系数/z0跟随数据一拍。混合结果严格等于原37位结果延后1sys，PID积分递推和IIR递推不改变。生产Root显式选择该方案，默认构造保持兼容。
- R18：iir_c48_mac.py精确分解signed25×25+signed50，X=L+H·2^17，L为unsigned17，H为signed8。Q=wrap48(C·L+signed48(Zlow))，以正/负48位溢出修正高2位。结果低17来自Q，高31来自C·H+(Q>>>17)，最高2位加mod4校正。所有50位与旧MAC相等；无新增周期。生产order1/2/5共用。实际DSP映射已有PCOUT→PCIN专用级联，不能误称原版缺少级联。
- R19：registered_error_mixer.py在完整37位求和后增加1sys；feedback_pipeline.py将配置、mode、directADC、CE对齐从1变2；iir.py raw config_delay=2；linien_module.py生产选择2拍。37位表达式及每拍吞吐不变。CSR存储仍常时钟更新，不随数据CE冻结。
- R20（如存在实际结果）：iir_registered_c48.py将已有中间MAC状态的高31位存入high DSP PREG，低17位和校正K在同边沿存储；高2位只做mod4小加法。替换已有状态寄存器，保留首项输入寄存器、末项组合MAC和原y/hold/clear/overflow-hold，新增反馈周期0。初版OPMODE0x65错误被原生测试检出；失败提交e113a81保留，依据本机DSP48E1.v Z-mux实现改为0x55选择PCIN>>>17，修正后全套重跑。没有削弱断言或修改Migen evaluator。
- R21：parallel_tap_limit.py、chains.py、linien_module.py可选并行tap算术/限幅，最后选择tap和符号；原bound/y/error寄存器边沿、CE和CSR保持。原生14/25位42180/42340拍及完整FastChain30000拍通过，但实际route WNS恶化为−2.104ns，TNS−670.303、1198端点；以REJECTED_NOT_MERGED保留，不能因TNS改善就直接合并。
- R22：基于R20并结合R21功能已验证的结构，公共A+B先求和再加tap，wrapN加法结合律保证等价；反相支路以S<=−hi/S>=−lo比较与取负并行，保持upper优先；S=最小N位负数的回绕单独选择lo。原bound相同CE边沿增加负边界副本，新增周期0。额外覆盖该最小负数及邻值；生产组合FastChain（registered_c48+新tap）对旧split_c48+原串行tap逐拍比较，原生UNISIM/glbl。只有真实route结果可证明是否有收益。
- R23：**生产功能FAIL，拒绝采用**。同拍公共项概念需要按signed14解释CSR位模式，实际代码却直接对unsigned CSRStorage.storage加法；生成Root Verilog出现$signed({1'd0,chain_offset_storage})，负偏置被当作正数。旧夹具预输入为signed，30000拍PASS覆盖不足；改用真实unsigned CSRStorage+CSRBank/原signed影子FF，在第45拍复现pre输出不一致。已保留缺陷源码与新失败用例，WNS仅作诊断，不能计作优化成果。
- R24：abs_threshold.py与autolock_pipeline.py，signed N位S、signed M位T且N>M（实际29/28）。精确谓词为Mux(S.sign且S不是minN，S<=−T，S>=T)；S=minN的有限abs回绕沿用原S>=T。−T先扩展到N，和原abs(peak)在同一CSR-cohort边沿捕获，绝非另加一拍。两个比较并行，移除abs(S)取负→比较的串行进位；不改公开五状态和FSM。5位穷举512、14/25/29位各30096已知向量及每种宽度2000未知位严格四态检查，完整父FPGAAutolock/CSR/冻结R4a一拍参考50076拍保持一致（其中RAM未知55拍也严格比较）。新增周期0，新增阈值副本可能改变CSR扇出和布局，必须以route验证。
- R24全工程仍继承R23类型缺陷，已中止综合；**综合未完成、route未运行**。上述自动锁定组件独立PASS不能替代全工程生产等价，后续正确版本重新验证，不追认R23/R24。
- R25：same_edge_common.py先以同宽signed信号重新解释CSR位模式，再在原ya/offset同一边沿形成公共项；Root默认构造与CSR地址保持。先保留测试专用失败提交cba82d1，修复生产代码后同一真实CSR FastChain夹具原样PASS：30000拍、15053拍负偏置；未限幅完整中间值14/25位30106/30134拍与原FF结构/独立整数oracle PASS，覆盖部分写两种顺序、读回、符号极值和复位。实际Root生成Verilog核对signed[13:0]别名参与加法，错误零扩展消失。完整旧回归、R24谓词/父模块、CSR映射及新物理流程独立记录。修正新增周期0。

- R26：Scope平均值与32位抽取因子选择先计算，set_avg_en最后选择。完整双Scope+真实CDC桥/CSR/BRAM逐拍差分PASS、无新增周期；实际控制路径+1.142ns，但全局WNS−.910仅优于R25 .071ns，TNS和端点数恶化，保留局部有效候选而非整体签核。
- R27：Root快速输出五项串行加法改为同位宽CSA压缩和最后一次进位加法；原限幅输入FF/CSR/路由/18位截断保持。数学等价mod2^N，新增周期0。真实unsigned CSRBank、原表达式/生产helper/整数oracle完整位宽14/25位41371/42011拍及原Root输入FF/双LimitCSR/独立限幅状态模型PASS；实际route WNS−1.042/TNS−229.718、795违规端点，整体退步，已拒绝且未携入R28。局部PID outgoing从R26−.910改善到−.341仍不等于整体胜出。

- R28：从R26独立进行快速PipelinedPID输出饱和的高位符号扩展解码。N位signed S输出W位，非负H=S[N−1:W−1]非0等价S>U；负数H非全1等价S<L。只改组合判据，原sum位宽/表达式/FF/CE/复位保持。**实际共用PipelinedPID，因此快25/慢14两处组合钳位均被替换，初始fast-only/慢PID未变说明已更正**；base PID/Root串行求和及慢链递推/CE/流水级不改，新增周期0。原生慢链413022拍再次PASS，实际Root位段和原sum同步语句AST核对一致。原生helper/原比较器/整数oracle14/25位80217/80349组与小位宽224组穷举PASS；完整回归/综合/route状态依本轮证据。

- R29：RTL和74个硬件/测试输入原始SHA与R28一致，功能/综合明确REUSED_R28_NOT_RERUN。R29a因Vivado2020.1不支持post-route fanout_opt被拒绝，无新route/WNS，源码65b4fcb和错误档案保留。R29b移除此项，用placement/routing/rewire/critical-cell和route Explore/tns_cleanup，真实route−.617/−91.147ns、545端点；输入DCP前后SHA不变，0新增周期。仍STA FAIL，不把RTL回归复用当post-route/SDF等价。

- R30：仅把自动锁定32项宽阈值先选择再比较，改成32个既有精确谓词并行后选1位。数学f(S,T[idx])=Array(f(S,T_i))[idx]，保留同cohort、5公开状态、CSR/FSM、0额外周期；风险为sumdiff扇出和资源。真实32CSR银行/旧R28结构/整数oracle14/25/29位46277/46725/47173拍及各2000X/Z、父模块50076拍严格四态PASS。R30新RTL实际默认route−1.204/−229.464ns、986端点，已拒绝不合并；瓶颈转sum_diff_s1[0]→GPIO5，logic1.964+route7.039ns。应同时对照R28默认和R29独立postroute，不能宣称继承R29物理成果。

- R31：仅将R30的32路完全并行精炼成8组×4项早选择+比较+晚选1位。idx=8q+r，每组选四项T[8q+r]后f(S,T)，最后选择组r，数学函数不变；数据比较扇出减至约1/4。完整Case default单独f(S,T31)保持原Array未知索引默认语义。原R30真实32CSR夹具blob不变、相同原生14/25/29位与X/Z专项及全部完整回归PASS；实际route−1.407/−275.553ns、987端点，转高位idx4→GPIO3，logic2.749+route6.440，失败拒绝，不增加任何反馈或robust周期。

- R32：回到R28/R29好RTL，同R28 synth.dcp/74原始硬件测试SHA重新placeExplore/post-placeAggressiveFanoutOpt/routeExplore，功能/综合REUSED_R28_NOT_RERUN。实际route−.691/−67.215ns、456端点；比R29 TNS好23.932ns、少89端点，但WNS差.074ns，不合并，保留TNS比较点。与R30/R31失败结构无关、RTL及串行周期不改、输入DCP不变，仍STA FAIL。

- R33：回到R28/R29保留硬件，新增32位当前指令的一热镜像，与原5位index在同一reset/at_start/advance沿更新（index+1对应OH rotate，保持时均保持）。归纳不变式OH=1<<idx，按位OR掩码查表与原T[idx]等价；原数值index/CSR/5状态/标量比较算法不改，没有串行decode FF、反馈或robust新增周期0。六shape全word72960known/12000unknown及原50076向量SHA原样保留、父模块追加至51628拍/32索引/逐拍OH断言PASS。初次预检查辅助pytest启动漏PYTHONPATH失败、正式锁定环境重跑及完整回归PASS分别留证。实际时序以本轮记录为准，不把功能PASS当布线成功。

## 功能与延迟证据

R17–R19联合37位混合/限幅/完整PID/真实CSR差分14/25位44290/44292拍，覆盖每侧512系数、积分正负饱和、独立producer/limit/PID CE、热写/部分写、mode、running、reset。每轮原有pytest、CE饱和、PID流水、慢链、robust父模块、AXI读写背压、桥snapshot、四相位CDC和integration均重新运行；各命令/退出码/PASS标记在JSON索引。

R18完整50位MAC71760组含正溢出6776、负溢出6995、最终50位回绕4039；order1/2/5完整滤波器对冻结原RTL与独立有限50位整数oracle比较。R20时钟化PREG MAC采用同组向量及周期性复位；原生DSP/UNISIM+glbl，不用替代行为乘法器。初始glbl GSR期间保持24拍reset，后续随机reset/hold/clear断言保留。初版FAIL与修正后PASS单独保存。

| 数字组件模型 | R16 | R17/R18 | R19/R20契约 | 相对R16新增 |
|---|---:|---:|---:|---:|
| ADC→Bare PID→DAC A | 56.1ns | 64.1ns | 72.1ns | 16ns |
| ADC→快PID→慢PID→DAC B | 92.1ns | 100.1ns | 108.1ns | 16ns |

R28另用当前生产PID实现对±123脉冲重新执行指定Bare和快慢串接组件模型，分别72.1ns/108.1ns、R28新增周期0。R17和R19分别对±123脉冲执行原生XSim，含实际Analog/ODDR及顶层fast_outs→limit.x FF。R18/R20继承相同组件周期契约，未把它们写成重新执行上述组件模型；IIR自身周期由完整滤波器差分验证。Bare配置KP4096、KI/KD/setpoint0、running1、全范围limit、其他贡献0、理想CRG相位。不是full-root/SDF/板级、转换器或模拟延迟，也不是测得的闭环带宽。

相对R2b，快速主链累计新增32ns（R4a16+R17/19共16）；特定快→慢串接累计48ns，其中既有慢PID16ns。相对R4a串接额外32ns。robust内核判断额外8ns独立列项，不给所有持续样本盲目加上该值。R19比R18再加8ns；新增16ns纯延迟在100kHz/1MHz分别0.576°/5.76°，尚无实测plant，不能宣称相位裕度或锁频稳定性通过。

## 当前瓶颈与下一阶段


## R37：解除限幅值属性的失败实验

从R36仅删limiter.y和neg_value两条.keep调用。后端将其映射为24个DONT_TOUCH，完整生成top.v除这24个声明属性外与R36相同；common_sum和错误标志保护保留，完整行为AST与原生全套功能PASS，新增周期0。初次完整HDL审计正则只覆盖limit0..2而漏Q路limit3..5，匹配18/24；按实际实例编号修正后仍要求严格24个属性变化且整文件相同，旧checker和错误记录保留，无生产/断言改变。

综合LUT12510/FF13280，比R36少118LUT；实际route−.874/−157.785ns、836端点反而恶化。全局FastA IIR输出→Mixer输入关联FF，12级/6CARRY4，logic3.076+route5.375。解除限制并不保证更好的算术映射或布线，本版本拒绝、不合并，也不作为R38的源基线。

## R38：单独解除公共项别名属性

回到R36，只删除common_sum.keep，正负限幅值/错误标志属性全部保留。R36真实网表确认关键common_sum_inst__10是LUT1 INIT2'h2（恒等BUF），旧路径额外LUT.124ns和net.888ns；去掉别名DONT_TOUCH为工具合并等价网提供机会。源行为AST相同、完整top.v除4处精确DONT_TOUCH声明外与R36相同，新增ADC/robust/GPIO周期0。仍须从实际映射确认BUF消除和源驱动扇出，不能按源属性减少预先判定收益；功能/综合/route/STA见表格和索引。

## R39：Scope配置CE移到D的失败候选

冻结R38综合DCP及78个原始硬件测试SHA。新postopt原生FDRE/FDSE14/25叶子43031拍PASS，366个Root Scope FF实际CE改常1、D=CE?D:Q，C/R/S/INIT边界保留，新增周期0。完整RTL和综合是明确REUSED_R38_NOT_RERUN，不是本轮重测。route−.655/−133.656ns、587端点，整体恶化；Scope FCLK−.527ns略改善，同ADC配置−.387ns恶化，拒绝不合并。CDC-15数量从374降到64只是CE→D分类变化，不证明跨域安全。

## R40：CSR写数据物理分发改善

从R38 routed.dcp内存unroute，在clk_2域非ASYNC_REG、CE恒1的CSR写数据2/3/4位高扇出网上force_replication；驱动FF30→57、最大负载517→161。复制前后D/C/CE/R/INIT与聚合负载集合相同，全部94DSP寄存器属性相同、输入DCP不变；78个原始硬件测试SHA一致，功能/综合明确复用R38未重跑。route−.582/−24.707ns、234端点、WHS.032/THS0/WPWS1.5，优于R38和此前最佳WNS R29−.617，保留未签核候选。新增串行周期0，CSR输出本组最差+.050ns，最差移至FastB IIR1的DSP乘加输出→反馈输入寄存器CEB2，5.972logic+2.003route。Scope FCLK配置仍−.320ns，ADC配置+.303ns。CDC-1增加27与新普通数据副本对应，不把复制等价当物理CDC证明；不是新增同步器、不是正式基线或可上板版本。

## R41：Scope源域同沿地址预译码

从R38独立RTL候选，与R40物理策略未自动合并。原桥接收沿同时捕获addr_o与17个地址比较结果，替换19处写配置/ARM/复位/触发地址比较；桥仅暴露原accept条件，原状态/握手/2FF/快照保持逐句不变。与独立冻结R38完整Scope+bridge四相位、每组1652事务、全配置/触发/忙时变更/别名/非法/XZ/协调复位严格逐拍对照PASS，原回归未改、整套原生功能/综合/route重新执行，新增ADC/CSR/触发周期0。物理CDC安全仍须单独预算，不从译码提前或告警计数推断签核。

## R42：IIR反馈fabric属性失败候选

只加一条y KEEP调用，移除它后整份Python行为AST相同，整个生成HDL严格只多9个反馈DONT_TOUCH。原生完整功能重新PASS；实际225个反馈FDRE存在，18个最终MAC DSP输入寄存器映射改变但DSP仍94。route−1.161/−454.743ns、1164端点恶化。最差变为反馈FDRE[4]Q→低DSP乘加→高DSP级联→饱和/选择→反馈FDRE[0]D，logic6.332+route2.691=9.023ns；解除DSP CE setup瓶颈却增加外部FF Q和到DSP B口的路径，拒绝不合并，R43/R44不携入该属性。

## R43：Scope与CSR物理分发

复用R41完整硬件/测试原始SHA与综合，功能/综合明确NOT RERUN；Scope单输出LUT638→675、最大leaf169→69，CSR FD16→70、最大598→193；同拍D/C/CE/R/INIT与负载集合、全部94DSP配置审计PASS。首次查询只数局部segment而漏跨层次负载，复制前主动中止，失败源码/诊断保留；改全segment leaf后新目录实际route−.578/−43.286ns、366端点。WNS比R40仅改善.004ns，但TNS/count更差，保留局部探索，不把它宣称整体胜出；R40仍较好整体对照。最差仍Scope set_dec[17]→adc_a_dat[11]，9级、1.634logic+6.728route。追加串行周期0、最终STA FAIL。

## R44：Scope因子同cohort伴随缓存

在原FCLK请求沿编码shift5/zero1，与原wdata_o同时保存；原ADC写set_dec沿同时提交6位伴随缓存，原32位设置/读回/采样周期不变。生产四路用5位barrel selector替代数据通路32位精确case，零/非法/unknown/default与avgX-Z行为精确保留；旧helper和旧回归源码原样。新增12位平行metadata，ADC/CSR/触发/Scope数据新增串行周期0。新真实decoder+cached helper161872已知/3000X-Z与冻结case及整数oraclePASS；独立冻结完整Scope/bridge四相位每组2036事务、真实未知写数据/avgX-Z与source/target cohort断言PASS；旧全套功能重新跑，新综合/route/缓存各侧路径分别记录。新物理CDC/独立复位/亚稳态安全不是这些功能测试所证明。

## R46：有限负阈值位式化简，整体改善

只改instruction_prefetch.py负阈值组合输入；旧signed abs_N后加宽取负的MIN特殊正值明确保留。low=(p<0?p:-p)modN，high=(p>0)|((p<0)&p!=MIN)，拼成N+1位；原magnitude/positive/wait/choice/FSM/CSR沿不变。数学全N1..16共131070及14/25/28各100006随机边界先PASS；旧真实unsigned CSRBank/整bank/整数oracle14/25/28分别63520/63648/63648拍、各3000X-Z及父模块/全旧功能再次PASS。实际MSB最差+.654、8级4CARRY4，较R44的16级11CARRY4减少；全部预取最差+.171，FastPID outgoing+.367，Scope缓存→data+1.381，CSR data+.168。route−.539/−18.344ns、131端点，优于旧R40/R43三项；仍最终STA FAIL，保留未签核候选。新增反馈/CSR/采样周期0；不携入R45 IIR重定时。

## R47：剩余IIR CE物理分发

复用R46原始83个硬件测试SHA及综合，NOT RERUN。按实际IIR BREG1/BCASCREG1/ADC clock/CEB2 LUT驱动，在unroute后以估算负slack选择8网，不能把该筛选说成输入routed slack；最终评价用真实route。标准物理复制后18个DSP CEB2直接LUT真值函数（含输入置换）同、全部94DSP寄存器参数同输入、CSR组未选择且状态/负载同；新增周期0。route−.282/−5.173ns、70端点，WHS.015/THS0/WPWS1.5；global同FastB IIR0 lowDSPCLK→highDSP CEB2，logic5.972不变、route1.957→1.700ns。三项较R46改善，仍STA FAIL，不合并/不部署，CDC/I/O/DNA/DRC仍未签核。

## R48：兼容 post-route 进一步改善

从 R47 routed.dcp 开始，只执行 placement/routing/rewire/critical-cell 四项，再实际 TNS route cleanup；fully routed 时工具明确忽略 Explore 等其他 route 选项，不能称重新全局布线。实际 WNS/TNS=-0.179/-4.904ns、70端点，WHS=0.015ns、THS=0，最终STA FAIL。逻辑5.972ns不变，关键布线降到1.597ns；94DSP属性与输入一致，0新增采样周期。原始 phys tns_cleanup 不兼容及日志回显阶段误判、一次未修改重试均独立保存和更正，不把入口失败当作已优化。功能/综合经R47复用R46，本轮NOT RERUN。

## R49：关键引脚优化无收益

标准 critical_pin_opt 正常执行，但优化对象0；最终route仍-0.179/-4.904ns、70端点，与R48相同。94DSP参数/寄存器、原始硬件测试SHA和top.v/CSR/XDC保持，新增周期0。功能/综合继承R46经R47/R48，NOT RERUN。失败候选保留，不因中间路由估值-0.177ns就报告改善。

## R50：IIR输出边沿重定位整机验证

仅registered_c48+pipelined模式：末级组合MAC后的输出FF边沿移入精确50位registered MAC，用同沿previous-output/feedback/clear/hold历史重建原溢出保持与控制递推。新增采样周期0、阶数/位宽/吞吐/CSR不变，14/25 native/iterative及split_c48共30组生成RTL逐字节相同。原样config0与新增config2真实CSR/独立有限50位oracle/order1/2/5及每阶3000X/Z、全部旧功能重新PASS；新综合和实际route，具体成败以表格和本轮报告为准。输出/error现在是MAC寄存器后组合选择，必须审查实际IIR→外部消费者和新反馈路径；零采样周期不证明无传播差异或毛刺，也不是fullRoot SDF/物理CDC/板端安全证明。没有沿用R47/R48 DCP布局，不把R45小模块预检当整机成果。

## R51：DSP列局部性仍失败，且发现映射变化

复用R50原87个硬件测试SHA和综合，NOT RERUN。实际220站点分X0/X1各20、X2/X3/X4各60；容量约束选择FastA32→X2、FastB32→X4、raw22→X3的三个硬DSP列pblock，真实route−.794/−679.440ns、1614端点，WHS.023/THS0/WPWS1.5，只较R50局部改善，远差R48，拒绝。IIR86真实成员同列且DSP属性同；94DSP整体不变性审计FAIL，93同、快速PID p_1_out PREG0→1，不能声称全映射不变，postmap周期等价NOT_PROVEN；原生PASS仅源RTL。首次把post-route routing_opt用在post-place被拒，place已成功/phys入口失败/route NOT RUN，日志和纠正说明保留，兼容三选项新目录才实际布线。无时序例外/降频/部署，不携入R52。

## R52：返回R48的组合C48进位化简

仅split_c48_mac把U=Z+正溢出−负溢出改为majority(Z,L,!C)，保持原4位correction与50位结果、乘法/级联/移位、所有输出/反馈/CSR边沿，registered MAC不改。已知8种符号/4种ztop及100320完整50位整数先PASS；独立符号谓词对部分X并非等价，严格完整MAC冻结旧helper320整数+4606部分X/Z PASS，原71760整数及config0滤波器、新config2/order1/2/5/真实CSR/旧冻结IIR+helper/独立oracle/每阶3000X-Z PASS。私有冻结模块导入初版失败发生在功能比较前，源码和诊断保留，修正明确加载旧helper后新目录PASS，旧断言不改。完整旧功能/综合/route新执行，物理收益以本轮表格和实际路径为准；没有继承R48 DCP布局，不携入R50输出重定位/R51物理pblock，新增采样周期0。

## R53：当前物理优化明显改善

复用R52完整功能与综合，89原始硬件测试SHA同，NOT RERUN；R52 routed DCP上兼容post-route四项及真实TNS cleanup，94DSP属性同真实输入R52，无新串行周期/时序例外。route-.014/-.052ns、6端点，WHS.014/THS0/WPWS1.5，超过R48但仍setup FAIL。所有剩余负端点不再属于IIR内部DSP，最差为FastB倍率CSR→CORDIC17的13级/8CARRY4、4.135logic+3.846route；另有限幅/混合器输入。raw IIR内部+.203ns。原始2项R52-vs-R48 PREG差异如实继承，不能把后续物理不变性混写成整个历史94参数全同。

## R54：换脚与重复局部优化无收益

从R53独立尝试critical_pin_opt后再四项局部物理及TNS cleanup，换脚对象0；pin-only/postopt/final三个实际报告均-.014/-.052ns、6端点。中间路由估值曾为0，但最终未改善，不用估算制造成功。90原始硬件测试及94DSP属性同R53，完整功能/综合复用R52，不重跑；失败保留不替换R53。

## R55：两条网络局部auto_delay路由退步

从R53只拆倍率CSR bit1(28负载)与zi[14](43负载)两网，再按2020.1帮助用auto_delay依据原setup/hold重布线，无新路由max/min界限或XDC例外。两个中间阶段分别-.291/-1.719ns(13端点)、-1.349/-19.090ns(32端点)，最终仍后者，拒绝。完整驱动/leaf负载集合与94DSP属性、生成top/CSR/XDC和输入DCP SHA均不变，表明功能连接没变而走线变差；源功能及综合复用R52经R53，NOT RERUN。没有以局部或中间估值替代最终，R53原DCP保持。

## R35与跨域审计

R35复用R34完整功能/综合，硬件测试原始SHA一致，本轮NOT RERUN；只在内存副本unroute到post-place，对17条>=64loads索引网force_replication，index FD18→123、最大loads129→63，随后物理优化/实际route−.702/−159.350ns、724端点。全部94DSP寄存器属性相同、输入DCP不变；WNS虽优于R34，TNS/count变坏且不优于R29，拒绝合并。R34外部GPIO8ns仍继承，不能称整机零延迟。

额外只读审计：Scope ADC同域dst_sync[1]→filt_bb.CE−.507ns（1.541logic+6.602route）；FCLK保持addr[19]→Scope hyst.CE−.702ns（1.465+8.227）；ADC全域索引复制体→另一复制体CE−.621ns（2.162+6.084）。clock interaction对FCLK↔ADC标No Common Clock/Timed unsafe。两级同步与载荷保持存在，理想RTL名义两个目标周期不能直接当作已证明的16ns物理预算；同域CE违例必须真实收敛。未加例外或新约束，CDC仍NOT_PROVEN，证据和推断边界见R35_CDC_DOMAIN_AUDIT。

## R36同cohort指令预取

从R29保留RTL独立构建，不携入R34 GPIO8ns或R35副本。旧bank_i[t]=f(CSR_i[t−1])，旧输出=f(CSR_idx[t][t−1])。原idx下沿只能保持/加1回绕/回零，因此同原cohort沿捕获三项C=f(CSR_idx)、N=f(CSR_wrap(idx+1))、Z=f(CSR_0)，用同沿记录的原FSM动作kind选择，即与旧输出每拍同值。next表完整Case做常量旋转、default仍31，避免硬件加法并保持X/Z索引原默认行为。unsigned CSR先同宽signed解释，有限abs最小负数回绕/精确负阈值照旧；直接读原始CSR.storage，保持部分写同cohort，原FSM/采样元数据同步AST不变。RTL配置影子位2304→218，实际物理FF依报告，不预先承诺。

14/25/28位原生63520/63648/63648拍，原整bank/生产helper/整数oracle、所有32索引/回绕/连续递增/保持/回零优先/partial热写两顺序/读回/reset/各3000X/Z（含旋转next与原加法索引probe）PASS。父模块51628拍，原50076向量SHA和全部断言原样保留、32自然索引/choice合法/55未知严格四态PASS，原软件5项PASS。完整PID/Slow/IIR/Scope/AXI/CDC/CSR再跑。原FSM/metadata AST、生产3组缓存、CSR/XDC和不相关源文件审计PASS。首个AST审计脚本使用breadth-first ast.walk导致错选旧嵌套bank节点，改按源码行序比较完整FSM，旧checker/FAIL原因保留，生产源码与功能断言未改。综合/route/最终STA以表格实测为准。ADC→DAC/robust/GPIO新增0周期，继承R28指定组件模型，不是本轮重跑组件或板端/SDF证明。

## R34 外部状态接口的有意延迟变更

chains.cross_connect默认0保持旧行为，仅生产Root显式启用GPIO状态快照：V1[t+1]=V[t]、E1[t+1]=E[t]，新GPIO O[t+2]=旧O[t+1]。同时捕获状态与CSR使能可保留部分热写的同cohort关系，global reset取消在途，最终仍为FF输出；新增126位RTL，实际资源以route映射为准。ADC→DAC/PID/robust FSM/内部state_in和signal_in新增0周期，但外部状态GPIO/LED明确增加8ns，直接软件outs/OE不延迟，混合pad波形不能说成整体延后一拍。备选两级分组OR为GPIO16ns，只有评估未实施。若外部GPIO用于触发/回接/调制参考，需要校准8ns；100kHz/1MHz纯延迟相位0.288°/2.88°，不是已测稳定裕度。

真实cross_connect和CSRBank，对冻结R28/默认0同拍、对候选独立原生1sys延迟参考及Python有限整数oracle63366拍（其中3000X/Z）、30256写、17复位PASS；全部14状态位/8输出/部分字节写读/CLR/内部消费者同拍覆盖。实际顶层9组14位快照、CSR/XDC相同、原内部控制语句和PID/IIR/FSM源码未改检查PASS。完整功能/综合/布线及STA判定须查看表格和每轮索引，接口延迟改变不能称整机零延迟。

### R17

代码提交 `78db834e27db93102ff20a3bcfc755de33c0933f`。

- global_worst: -2.8ns，`linienmodule_fast_a_iir0_z20/CLK` → `linienmodule_fast_a_iir0_z50/CEB2`；逻辑/布线=['7.833', '2.239']ns，12  (CARRY4=9 DSP48E1=1 LUT2=1 LUT3=1)。
- raw_internal: -2.623ns，`linienmodule_raw_acquisition_iir_z100/CLK` → `linienmodule_raw_acquisition_iir_z90__0/CEB2`；逻辑/布线=['7.721', '2.253']ns，11  (CARRY4=8 DSP48E1=1 LUT2=1 LUT3=1)。
- raw_entry: -2.144ns，`DSP48E1_1/CLK` → `linienmodule_raw_acquisition_iir_z50__0_i_1_psdsp_1/D`；逻辑/布线=['4.953', '4.924']ns，11  (CARRY4=6 LUT4=2 LUT5=2 LUT6=1)。
- fast_D: -0.397ns，`linienmodule_csr_dat_w_reg[0]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[0]/D`；逻辑/布线=['0.518', '7.725']ns，0。
- fast_S: 0.375ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[10]/S`；逻辑/布线=['2.796', '4.180']ns，14  (CARRY4=9 LUT2=1 LUT4=1 LUT5=1 LUT6=2)。
- fast_R: 3.694ns，`FD_replica_68/C` → `linienmodule_mixeralignedpid8_reg[5]/R`；逻辑/布线=['0.456', '3.339']ns，0。
- fast_CE: -0.336ns，`linienmodule_csr_adr_reg[5]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[0]/CE`；逻辑/布线=['1.314', '6.463']ns，3  (LUT4=3)。
- 资源={'lut': 13941, 'ff': 14065, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 444, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 2, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=376/368，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=220；route WHS/THS/WPWS=0.026/0.0/1.5ns。

### R18

代码提交 `32b813910a6f74572ce180e354608be5333274e9`。

- global_worst: -2.326ns，`DSP48E1_1/CLK` → `linienmodule_iir_low0_i_16_psdsp_5/D`；逻辑/布线=['4.816', '5.178']ns，9  (CARRY4=4 LUT4=1 LUT5=3 LUT6=1)。
- raw_internal: -2.05ns，`linienmodule_iir_low0_i_13_psdsp_2/C` → `linienmodule_iir_zr4[48]_i_1_psdsp_27/D`；逻辑/布线=['5.825', '3.873']ns，2  (DSP48E1=2)。
- raw_entry: -2.326ns，`DSP48E1_1/CLK` → `linienmodule_iir_low0_i_16_psdsp_5/D`；逻辑/布线=['4.816', '5.178']ns，9  (CARRY4=4 LUT4=1 LUT5=3 LUT6=1)。
- fast_D: -0.117ns，`linienmodule_csr_dat_w_reg[7]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[7]/D`；逻辑/布线=['0.456', '7.453']ns，0。
- fast_S: 0.667ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.897', '3.790']ns，14  (CARRY4=9 LUT2=1 LUT4=1 LUT5=1 LUT6=2)。
- fast_R: 2.474ns，`FD_replica_46/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[7]/R`；逻辑/布线=['0.518', '4.059']ns，0。
- fast_CE: 0.028ns，`linienmodule_csr_adr_reg[4]_rep__3/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[13]/CE`；逻辑/布线=['1.069', '6.559']ns，2  (LUT4=1 LUT6=1)。
- 资源={'lut': 12223, 'ff': 12395, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 444, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 2, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=378/370，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=224；route WHS/THS/WPWS=0.051/0.0/1.5ns。

### R19

代码提交 `f73476bacb837afe7f99c12893312831f6c893d3`。

- global_worst: -1.852ns，`linienmodule_fast_a_y_tap_storage_full_reg[0]/C` → `linienmodule_fast_a_limitcsr1_limitcsr1_y1_reg[5]/D`；逻辑/布线=['4.351', '5.385']ns，13  (CARRY4=6 LUT3=2 LUT4=2 LUT5=2 LUT6=1)。
- raw_internal: -1.338ns，`linienmodule_iir_low10/CLK` → `linienmodule_iir_high9/CEB2`；逻辑/布线=['6.186', '2.362']ns，4  (DSP48E1=1 LUT4=1 LUT5=1 MUXF7=1)。
- raw_entry: -1.12ns，`linienmodule_csr_dat_w_reg[0]/C` → `linienmodule_iir_csrstorage8_storage_full_reg[8]/D`；逻辑/布线=['0.456', '8.460']ns，0。
- fast_D: 0.349ns，`linienmodule_csr_dat_w_reg[5]_rep__2/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[13]/D`；逻辑/布线=['0.518', '6.920']ns，0。
- fast_R: 3.761ns，`linienmodule_mixeralignedpid4_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[36]/R`；逻辑/布线=['0.580', '3.150']ns，1  (LUT3=1)。
- fast_CE: 0.538ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[12]/CE`；逻辑/布线=['0.766', '6.403']ns，2  (LUT2=1 LUT6=1)。
- 资源={'lut': 12075, 'ff': 12689, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=380/375，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=200；route WHS/THS/WPWS=0.033/0.0/1.5ns。

### R20

代码提交 `ac35a5beb1860163f0d0658d04a05d77e2ebef01`。

- global_worst: -1.838ns，`linienmodule_fast_a_iir0_y2_reg[15]/C` → `DSP48E1_68_i_18_psdsp/D`；逻辑/布线=['3.805', '5.955']ns，10  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2 LUT6=1)。
- raw_internal: -0.518ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['6.096', '1.815']ns，4  (DSP48E1=1 LUT3=1 LUT5=1 LUT6=1)。
- raw_entry: -0.519ns，`linienmodule_csr_dat_w_reg[2]/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[18]/D`；逻辑/布线=['0.456', '8.004']ns，0。
- fast_D: 0.523ns，`linienmodule_csr_dat_w_reg[5]_rep__1/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[21]/D`；逻辑/布线=['0.456', '6.954']ns，0。
- fast_S: -0.237ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.520', '5.160']ns，10  (CARRY4=5 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- fast_R: 3.05ns，`FD_replica_5/C` → `linienmodule_mixeralignedpid_q2_reg[1]/R`；逻辑/布线=['0.456', '3.999']ns，0。
- fast_CE: 0.652ns，`linienmodule_csr_adr_reg[0]_rep__2/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[8]/CE`；逻辑/布线=['0.704', '6.415']ns，2  (LUT4=1 LUT6=1)。
- 资源={'lut': 12064, 'ff': 14715, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 436, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=381/381，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=411；route WHS/THS/WPWS=0.04/0.0/1.5ns。

### R21

代码提交 `107c2ad61a39b1007c96e5dda8e400500706defb`。

- global_worst: -2.104ns，`linienmodule_fast_b_ya_reg[2]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_16/D`；逻辑/布线=['4.376', '5.338']ns，13  (CARRY4=6 LUT1=1 LUT3=1 LUT4=2 LUT5=2 MUXF7=1)。
- raw_internal: -0.743ns，`linienmodule_iir_low10/CLK` → `linienmodule_iir_high10/B[3]`；逻辑/布线=['5.724', '2.474']ns，1  (DSP48E1=1)。
- raw_entry: -0.777ns，`linienmodule_csr_dat_w_reg[5]_rep__1/C` → `linienmodule_iir_storage_full_reg[13]/D`；逻辑/布线=['0.456', '8.105']ns，0。
- fast_D: -0.232ns，`linienmodule_csr_dat_w_reg[1]_rep__2/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[9]/D`；逻辑/布线=['0.518', '7.529']ns，0。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 3.167ns，`linienmodule_mixeralignedpid4_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[38]/R`；逻辑/布线=['0.580', '3.749']ns，1  (LUT3=1)。
- fast_CE: 0.61ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[13]/CE`；逻辑/布线=['0.994', '6.094']ns，2  (LUT2=1 LUT6=1)。
- 资源={'lut': 13485, 'ff': 12718, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 451, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=379/364，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=201；route WHS/THS/WPWS=0.039/0.0/1.5ns。

### R22

代码提交 `fccfb491bbccc0bcf3b6667ea525a0780c48370a`。

- global_worst: -1.5ns，`linienmodule_fast_a_ya_reg[0]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[7]/D`；逻辑/布线=['3.391', '5.798']ns，13  (CARRY4=6 LUT2=2 LUT3=1 LUT5=1 LUT6=2 MUXF7=1)。
- raw_internal: -0.434ns，`linienmodule_raw_acquisition_iir_y0_reg[24]/C` → `DSP48E1_13/B[10]`；逻辑/布线=['0.419', '4.048']ns，0。
- raw_entry: -0.396ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[23]/C` → `DSP48E1_1/B[6]`；逻辑/布线=['0.456', '4.197']ns，0。
- fast_D: -0.01ns，`linienmodule_csr_dat_w_reg[7]_rep__1/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[7]/D`；逻辑/布线=['0.456', '7.383']ns，0。
- fast_S: 0.738ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.620', '3.938']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 3.522ns，`FD_replica_61/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[3]/R`；逻辑/布线=['0.518', '3.292']ns，0。
- fast_CE: 0.658ns，`linienmodule_csr_adr_reg[2]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/CE`；逻辑/布线=['0.642', '6.569']ns，1  (LUT6=1)。
- 资源={'lut': 14157, 'ff': 14782, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=11/6，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=407；route WHS/THS/WPWS=0.005/0.0/1.5ns。

### R23

代码提交 `9d54b323d2a6b4f161e3880a8656e6e86b88208b`。

- global_worst: -0.706ns，`linienmodule_fast_b_zi0__11/C` → `linienmodule_fast_b_cordic17_reg[16]/D`；逻辑/布线=['4.000', '4.652']ns，14  (CARRY4=9 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- raw_internal: -0.367ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.848', '1.917']ns，2  (DSP48E1=1 LUT6=1)。
- raw_entry: -0.198ns，`linienmodule_csr_dat_w_reg[0]_rep/C` → `linienmodule_raw_acquisition_iir_storage_full_reg[8]/D`；逻辑/布线=['0.456', '7.737']ns，0。
- fast_D: 0.771ns，`linienmodule_csr_dat_w_reg[3]_rep__2/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[19]/D`；逻辑/布线=['0.456', '6.627']ns，0。
- fast_S: 1.093ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[10]/S`；逻辑/布线=['2.948', '3.338']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 0.822ns，`FD/C` → `linienmodule_mixeralignedpid_q6_reg/R`；逻辑/布线=['0.518', '6.028']ns，0。
- fast_CE: 0.86ns，`linienmodule_csr_we_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.828', '5.937']ns，3  (LUT2=1 LUT6=2)。
- 资源={'lut': 14178, 'ff': 14768, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 451, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=53/38，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=409；route WHS/THS/WPWS=0.02/0.0/1.5ns。

### R25

代码提交 `759cba4240c650dd98ee1716776ada750485c14c`。

- global_worst: -0.981ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[0]/D`；逻辑/布线=['1.830', '6.959']ns，9  (LUT2=1 LUT5=1 LUT6=6 MUXF7=1)。
- raw_internal: -0.165ns，`linienmodule_raw_acquisition_iir_a2_reg[17]/C` → `linienmodule_raw_acquisition_iir_z_low_i_5_psdsp_29/D`；逻辑/布线=['6.206', '1.754']ns，2  (DSP48E1=2)。
- raw_entry: -0.338ns，`linienmodule_csr_dat_w_reg[7]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[15]/D`；逻辑/布线=['0.518', '7.546']ns，0。
- fast_D: 0.92ns，`linienmodule_csr_adr_reg[6]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[24]/D`；逻辑/布线=['1.056', '5.766']ns，3  (LUT2=1 LUT5=1 LUT6=1)。
- fast_S: 0.795ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/S`；逻辑/布线=['2.762', '3.879']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 2.346ns，`FD_replica_69/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg[27]_i_3_psdsp/R`；逻辑/布线=['0.518', '4.512']ns，0。
- fast_CE: 0.746ns，`linienmodule_csr_adr_reg[3]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[0]/CE`；逻辑/布线=['0.930', '5.934']ns，2  (LUT2=1 LUT6=1)。
- 资源={'lut': 15312, 'ff': 15677, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 425, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=380/391，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.019/0.0/1.5ns。

### R26

代码提交 `c105b02bc8c156792b36cf64cd615be2315b47dd`。

- global_worst: -0.91ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['4.528', '4.197']ns，20  (CARRY4=14 LUT2=1 LUT3=1 LUT6=4)。
- raw_internal: -0.296ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.716']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_entry: -0.257ns，`linienmodule_csr_dat_w_reg[6]_rep__1/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[6]/D`；逻辑/布线=['0.456', '7.609']ns，0。
- fast_D: 0.998ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[24]/D`；逻辑/布线=['1.114', '5.418']ns，3  (LUT2=1 LUT5=1 LUT6=1)。
- fast_S: 0.459ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[26]/S`；逻辑/布线=['2.325', '4.659']ns，8  (CARRY4=2 LUT2=1 LUT4=2 LUT5=2 LUT6=1)。
- fast_R: 1.69ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['0.580', '4.941']ns，1  (LUT3=1)。
- fast_CE: 0.785ns，`linienmodule_csr_adr_reg[3]_rep__2/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/CE`；逻辑/布线=['0.704', '6.177']ns，2  (LUT2=1 LUT6=1)。
- scope_average_control: 1.142ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_q_dat_reg[3]/D`；逻辑/布线=['0.580', '6.208']ns，1  (LUT6=1)。
- frontend_a_output: -0.659ns，`linienmodule_fast_a_iir0_y0_reg[0]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_23/D`；逻辑/布线=['3.455', '4.809']ns，13  (CARRY4=8 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.509ns，`linienmodule_fast_b_iir0_y2_reg[1]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_30/D`；逻辑/布线=['3.390', '4.672']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- 资源={'lut': 15218, 'ff': 15800, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 439, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=369/366，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=410；route WHS/THS/WPWS=0.02/0.0/1.5ns。

### R27

代码提交 `cffb1f283f0ebd138bea4b932937c02ff846988f`。

- global_worst: -1.042ns，`linienmodule_autolock_pipelinedrobustautolock_magnitude5_reg[8]/C` → `linienmodule_gpio_n_o_reg[7]/D`；逻辑/布线=['2.999', '5.637']ns，11  (CARRY4=3 LUT4=3 LUT5=2 LUT6=2 MUXF7=1)。
- raw_internal: -0.271ns，`linienmodule_raw_acquisition_iir_a2_reg[24]/C` → `linienmodule_raw_acquisition_iir_z_high_i_5_psdsp_29/D`；逻辑/布线=['6.206', '1.875']ns，2  (DSP48E1=2)。
- raw_entry: -0.153ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[17]/C` → `DSP48E1_7/B[0]`；逻辑/布线=['0.456', '4.048']ns，0。
- fast_D: -0.281ns，`linienmodule_csr_dat_w_reg[2]_rep__1/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[10]/D`；逻辑/布线=['0.456', '7.576']ns，0。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 2.285ns，`linienmodule_mixeralignedpid4_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[20]/R`；逻辑/布线=['0.604', '4.429']ns，1  (LUT3=1)。
- fast_CE: 0.546ns，`linienmodule_csr_adr_reg[0]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/CE`；逻辑/布线=['0.704', '6.489']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.341ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.622', '4.548']ns，18  (CARRY4=13 LUT2=1 LUT3=2 LUT5=2)。
- scope_average_control: 1.694ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[12]/D`；逻辑/布线=['0.580', '5.613']ns，1  (LUT3=1)。
- frontend_a_output: -0.623ns，`linienmodule_fast_a_iir0_y2_reg[0]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['2.927', '5.301']ns，8  (CARRY4=3 LUT1=1 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.633ns，`linienmodule_fast_b_iir1_y2_reg[3]/C` → `linienmodule_fast_b_iir1_z_high1_i_5_psdsp_28/D`；逻辑/布线=['6.018', '2.420']ns，2  (DSP48E1=2)。
- 资源={'lut': 15281, 'ff': 15762, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 430, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=374/380，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=410；route WHS/THS/WPWS=0.018/0.0/1.5ns。

### R28

代码提交 `9c5c32a46c53a7eb4cd38e7c9e7acba233cfc119`。

- global_worst: -0.788ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['2.430', '6.172']ns，9  (CARRY4=1 LUT3=1 LUT4=2 LUT5=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.177ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.598']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_entry: -0.212ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[1]/C` → `linienmodule_raw_acquisition_iir_zr_low_q5_reg[2]/D`；逻辑/布线=['4.112', '3.534']ns，1  (DSP48E1=1)。
- fast_D: 0.826ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['2.885', '4.224']ns，13  (CARRY4=7 LUT2=1 LUT3=1 LUT4=1 LUT5=2 LUT6=1)。
- fast_S: 0.217ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/S`；逻辑/布线=['2.885', '4.253']ns，13  (CARRY4=7 LUT2=1 LUT4=2 LUT5=2 LUT6=1)。
- fast_R: 0.979ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/R`；逻辑/布线=['0.609', '5.471']ns，1  (LUT3=1)。
- fast_CE: 0.801ns，`linienmodule_csr_adr_reg[1]_rep__7/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[5]/CE`；逻辑/布线=['0.932', '5.852']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.204ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[30]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.061', '5.146']ns，13  (CARRY4=6 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 2.344ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_dat_reg[6]/D`；逻辑/布线=['0.580', '4.972']ns，1  (LUT3=1)。
- frontend_a_output: -0.637ns，`linienmodule_fast_a_iir0_y0_reg[4]_replica/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[3]/D`；逻辑/布线=['2.886', '5.372']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT5=1 LUT6=2 MUXF7=1)。
- frontend_b_output: -0.442ns，`linienmodule_fast_b_iir0_y2_reg[1]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[22]/D`；逻辑/布线=['3.525', '4.573']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- 资源={'lut': 15139, 'ff': 15857, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=380/375，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=413；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R29

代码提交 `be6a64e596b6db1c910e982444fb2a0422a2a2ec`。

- global_worst: -0.617ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__0/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['2.973', '5.330']ns，12  (CARRY4=4 LUT3=1 LUT4=2 LUT5=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.177ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.598']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_entry: -0.212ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[1]/C` → `linienmodule_raw_acquisition_iir_zr_low_q5_reg[2]/D`；逻辑/布线=['4.112', '3.534']ns，1  (DSP48E1=1)。
- fast_D: 0.826ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['2.885', '4.224']ns，13  (CARRY4=7 LUT2=1 LUT3=1 LUT4=1 LUT5=2 LUT6=1)。
- fast_S: 0.217ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/S`；逻辑/布线=['2.885', '4.253']ns，13  (CARRY4=7 LUT2=1 LUT4=2 LUT5=2 LUT6=1)。
- fast_R: 0.979ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/R`；逻辑/布线=['0.609', '5.471']ns，1  (LUT3=1)。
- fast_CE: 0.801ns，`linienmodule_csr_adr_reg[1]_rep__7/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[5]/CE`；逻辑/布线=['0.932', '5.852']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.204ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[30]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.061', '5.146']ns，13  (CARRY4=6 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 2.344ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_dat_reg[6]/D`；逻辑/布线=['0.580', '4.972']ns，1  (LUT3=1)。
- frontend_a_output: -0.493ns，`linienmodule_fast_a_iir0_y0_reg[4]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_45/D`；逻辑/布线=['2.883', '5.266']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT5=1 LUT6=2 MUXF7=1)。
- frontend_b_output: -0.442ns，`linienmodule_fast_b_iir0_y2_reg[1]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[22]/D`；逻辑/布线=['3.525', '4.573']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- 资源={'lut': 15139, 'ff': 15860, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=380/375，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=413；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R30

代码提交 `bde8f03c0afa02c5dd14c567fb83d90d78e582d6`。

- global_worst: -1.204ns，`linienmodule_autolock_pipelinedrobustautolock_sum_diff_s1_reg[0]/C` → `linienmodule_gpio_n_o_reg[5]_lopt_replica/D`；逻辑/布线=['1.964', '7.039']ns，10  (LUT3=1 LUT4=1 LUT5=2 LUT6=5 MUXF7=1)。
- raw_internal: -0.194ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.613']ns，3  (DSP48E1=1 LUT4=1 LUT5=1)。
- raw_entry: -0.257ns，`linienmodule_csr_dat_w_reg[1]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage1_storage_full_reg[9]/D`；逻辑/布线=['0.456', '7.827']ns，0。
- fast_D: -0.257ns，`linienmodule_csr_dat_w_reg[6]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[14]/D`；逻辑/布线=['0.456', '7.613']ns，0。
- fast_S: 1.089ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_4_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.731', '3.619']ns，12  (CARRY4=8 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 3.255ns，`FD_replica_35/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[24]/R`；逻辑/布线=['0.456', '3.754']ns，0。
- fast_CE: 0.417ns，`linienmodule_csr_adr_reg[6]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[11]/CE`；逻辑/布线=['0.897', '6.363']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.138ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[32]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.088', '4.915']ns，11  (CARRY4=4 LUT3=1 LUT5=1 LUT6=5)。
- scope_average_control: 2.162ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['1.014', '4.766']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -0.645ns，`linienmodule_fast_a_iir0_y0_reg[1]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_21/D`；逻辑/布线=['2.416', '5.744']ns，9  (CARRY4=3 LUT2=1 LUT5=1 LUT6=3 MUXF7=1)。
- frontend_b_output: -0.622ns，`linienmodule_fast_b_iir0_y0_reg[1]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_46/D`；逻辑/布线=['3.568', '4.638']ns，13  (CARRY4=8 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- 资源={'lut': 15678, 'ff': 15903, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 448, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=374/362，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=412；route WHS/THS/WPWS=0.024/0.0/1.5ns。

### R31

代码提交 `b8bc7da16a043544bbe06975687a8bc81c08dc35`。

- global_worst: -1.407ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[4]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.749', '6.440']ns，13  (CARRY4=4 LUT2=1 LUT3=1 LUT4=2 LUT5=3 LUT6=2)。
- raw_internal: -0.379ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_low/CEB2`；逻辑/布线=['5.972', '1.824']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: -0.876ns，`linienmodule_csr_dat_w_reg[7]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage3_storage_full_reg[15]/D`；逻辑/布线=['0.518', '8.091']ns，0。
- fast_D: -0.729ns，`linienmodule_csr_dat_w_reg[7]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[23]/D`；逻辑/布线=['0.518', '7.873']ns，0。
- fast_S: 0.243ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.905', '4.199']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 2.104ns，`FD_replica_55/C` → `linienmodule_mixeralignedpid5_reg/R`；逻辑/布线=['0.518', '4.813']ns，0。
- fast_CE: 0.562ns，`linienmodule_csr_adr_reg[6]_rep__1/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[18]/CE`；逻辑/布线=['0.934', '6.025']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.394ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[28]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['2.838', '5.527']ns，11  (CARRY4=6 LUT3=1 LUT5=1 LUT6=3)。
- scope_average_control: 2.059ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_dat_reg[13]/D`；逻辑/布线=['0.642', '5.211']ns，1  (LUT3=1)。
- frontend_a_output: -0.561ns，`linienmodule_fast_a_iir0_y0_reg[1]_replica/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[22]/D`；逻辑/布线=['3.630', '4.612']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.939ns，`linienmodule_fast_b_iir0_y2_reg[7]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_31/D`；逻辑/布线=['2.555', '5.788']ns，10  (CARRY4=4 LUT2=1 LUT5=1 LUT6=3 MUXF7=1)。
- 资源={'lut': 15738, 'ff': 15696, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 435, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=373/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=407；route WHS/THS/WPWS=0.017/0.0/1.5ns。

### R32

代码提交 `75a983cdcce4955245f2d9e53fb783109c282ca0`。

- global_worst: -0.691ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__0/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['2.975', '5.402']ns，12  (CARRY4=4 LUT3=1 LUT4=2 LUT5=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.177ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.598']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_entry: -0.352ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[1]/C` → `linienmodule_raw_acquisition_iir_zr_low_q5_reg[3]/D`；逻辑/布线=['4.112', '3.680']ns，1  (DSP48E1=1)。
- fast_D: 0.382ns，`linienmodule_csr_dat_w_reg[2]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[2]/D`；逻辑/布线=['0.456', '6.852']ns，0。
- fast_S: 0.225ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_3_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/S`；逻辑/布线=['2.845', '4.286']ns，14  (CARRY4=8 LUT2=1 LUT4=2 LUT5=2 LUT6=1)。
- fast_R: 0.807ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/R`；逻辑/布线=['0.609', '5.639']ns，1  (LUT3=1)。
- fast_CE: 0.61ns，`linienmodule_csr_adr_reg[1]_rep__7/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[5]/CE`；逻辑/布线=['0.930', '6.045']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.198ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[31]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.061', '5.140']ns，13  (CARRY4=6 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 2.34ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.952', '4.603']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -0.492ns，`linienmodule_fast_a_iir0_y0_reg[2]_replica/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[12]/D`；逻辑/布线=['2.710', '5.293']ns，12  (CARRY4=7 LUT3=1 LUT5=1 LUT6=2 MUXF7=1)。
- frontend_b_output: -0.311ns，`linienmodule_fast_b_iir0_y2_reg[3]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[16]/D`；逻辑/布线=['3.455', '4.422']ns，13  (CARRY4=8 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- 资源={'lut': 15133, 'ff': 15857, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 441, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=380/375，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=413；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R33

代码提交 `1706aca938d84becb7bf7370c3b9449f396e217e`。

- global_worst: -1.297ns，`linienmodule_autolock_pipelinedrobustautolock_instruction_onehot_reg[1]/C` → `linienmodule_gpio_n_o_reg[1]_lopt_replica/D`；逻辑/布线=['2.501', '6.582']ns，11  (CARRY4=4 LUT3=1 LUT4=2 LUT5=1 LUT6=3)。
- raw_internal: -0.432ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.854']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: -0.342ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[22]/C` → `DSP48E1_7/B[5]`；逻辑/布线=['0.456', '4.244']ns，0。
- fast_D: 0.831ns，`linienmodule_csr_dat_w_reg[0]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[24]/D`；逻辑/布线=['0.580', '6.412']ns，1  (LUT5=1)。
- fast_S: 1.058ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_4_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/S`；逻辑/布线=['2.564', '3.867']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 1.109ns，`FD_replica_8/C` → `linienmodule_mixeralignedpid6_reg/R`；逻辑/布线=['0.456', '5.797']ns，0。
- fast_CE: 0.241ns，`linienmodule_csr_adr_reg[3]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[3]/CE`；逻辑/布线=['0.940', '6.449']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.48ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.334', '4.977']ns，13  (CARRY4=6 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 2.75ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_dat_reg[0]/D`；逻辑/布线=['0.580', '4.575']ns，1  (LUT3=1)。
- frontend_a_output: -0.442ns，`linienmodule_fast_a_iir0_y2_reg[5]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_9/D`；逻辑/布线=['3.432', '4.573']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.319ns，`linienmodule_fast_b_iir0_y2_reg[4]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_44/D`；逻辑/布线=['2.975', '4.977']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT5=1 LUT6=2 MUXF7=1)。
- 资源={'lut': 15904, 'ff': 15908, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 433, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=379/382，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=413；route WHS/THS/WPWS=0.036/0.0/1.5ns。

### R34

代码提交 `382f02498776e468fbe3a26a9dc4b50f33be55ae`。

- global_worst: -0.845ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_waited_for_reg[6]/R`；逻辑/布线=['2.430', '5.772']ns，8  (CARRY4=2 LUT3=1 LUT4=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.08ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_y0_reg[12]/CE`；逻辑/布线=['5.972', '1.684']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: 0.02ns，`linienmodule_csr_dat_w_reg[2]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[18]/D`；逻辑/布线=['0.518', '7.305']ns，0。
- fast_D: 1.409ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/D`；逻辑/布线=['2.928', '3.372']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT6=2)。
- fast_S: 0.333ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[4]/S`；逻辑/布线=['2.633', '4.190']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 2.61ns，`FD_replica_43/C` → `linienmodule_mixeralignedpid_q6_reg/R`；逻辑/布线=['0.456', '4.284']ns，0。
- fast_CE: 0.774ns，`linienmodule_csr_adr_reg[3]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[1]/CE`；逻辑/布线=['0.932', '5.884']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.388ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[28]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.046', '5.237']ns，12  (CARRY4=5 LUT3=1 LUT5=1 LUT6=5)。
- scope_average_control: 2.514ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[10]/D`；逻辑/布线=['0.642', '4.722']ns，1  (LUT3=1)。
- frontend_a_output: -0.487ns，`linienmodule_fast_a_iir0_y2_reg[5]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[4]/D`；逻辑/布线=['3.413', '4.713']ns，11  (CARRY4=6 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.328ns，`linienmodule_fast_b_iir0_y0_reg[4]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.511', '4.431']ns，11  (CARRY4=6 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- gpio_snapshot_from: 1.999ns，`linienmodule_gpio_status_state_s1_reg[0]/C` → `linienmodule_gpio_n_o_reg[1]_lopt_replica/D`；逻辑/布线=['0.704', '5.117']ns，2  (LUT4=1 LUT5=1)。
- gpio_snapshot_to: -0.044ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_gpio_status_state_s1_reg[12]/D`；逻辑/布线=['2.306', '5.614']ns，7  (CARRY4=2 LUT3=1 LUT4=1 LUT6=2 MUXF7=1)。
- gpio_snapshot_D: -0.044ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_gpio_status_state_s1_reg[12]/D`；逻辑/布线=['2.306', '5.614']ns，7  (CARRY4=2 LUT3=1 LUT4=1 LUT6=2 MUXF7=1)。
- gpio_snapshot_R: 3.398ns，`FD_replica_71/C` → `linienmodule_gpio_status_mask_s1_2_reg[10]/R`；逻辑/布线=['0.518', '3.426']ns，0。
- gpio_outputs_to: 1.999ns，`linienmodule_gpio_status_state_s1_reg[0]/C` → `linienmodule_gpio_n_o_reg[1]_lopt_replica/D`；逻辑/布线=['0.704', '5.117']ns，2  (LUT4=1 LUT5=1)。
- 资源={'lut': 15145, 'ff': 15856, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 431, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=378/383，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.036/0.0/1.5ns。

### R35

代码提交 `1587a1b6380b3f271ac31d7576ab48027d292168`。

- global_worst: -0.702ns，`red_pitaya_scope/i_bridge/addr_o_reg[19]/C` → `red_pitaya_scope/set_a_hyst_reg[0]/CE`；逻辑/布线=['1.465', '8.227']ns，5  (LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- raw_internal: -0.08ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_y0_reg[12]/CE`；逻辑/布线=['5.972', '1.684']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: -0.207ns，`linienmodule_csr_dat_w_reg[7]/C` → `linienmodule_raw_acquisition_iir_csrstorage9_storage_full_reg[7]/D`；逻辑/布线=['0.419', '7.399']ns，0。
- fast_D: -0.281ns，`linienmodule_csr_dat_w_reg[7]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[7]/D`；逻辑/布线=['0.419', '7.381']ns，0。
- fast_S: 0.156ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.613', '4.387']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 3.079ns，`FD_replica_44/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[22]/R`；逻辑/布线=['0.456', '3.729']ns，0。
- fast_CE: 0.768ns，`linienmodule_csr_adr_reg[1]_rep__5/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[10]/CE`；逻辑/布线=['0.842', '5.868']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: -0.163ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[29]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['2.944', '5.115']ns，11  (CARRY4=5 LUT3=1 LUT5=1 LUT6=4)。
- scope_average_control: 2.395ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_q_dat_reg[1]/D`；逻辑/布线=['0.642', '4.810']ns，1  (LUT3=1)。
- frontend_a_output: -0.389ns，`linienmodule_fast_a_iir0_y2_reg[5]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[4]/D`；逻辑/布线=['3.557', '4.471']ns，12  (CARRY4=7 LUT2=1 LUT3=1 LUT5=1 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.296ns，`linienmodule_fast_b_iir0_y0_reg[4]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.511', '4.399']ns，11  (CARRY4=6 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- gpio_snapshot_from: 2.322ns，`linienmodule_gpio_status_state_s1_reg[0]/C` → `linienmodule_gpio_n_o_reg[1]_lopt_replica/D`；逻辑/布线=['0.704', '4.793']ns，2  (LUT4=1 LUT5=1)。
- gpio_snapshot_to: 0.22ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0_replica_1/C` → `linienmodule_gpio_status_state_s1_reg[12]/D`；逻辑/布线=['2.038', '5.472']ns，5  (CARRY4=1 LUT3=1 LUT4=1 LUT6=1 MUXF7=1)。
- gpio_snapshot_D: 0.22ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0_replica_1/C` → `linienmodule_gpio_status_state_s1_reg[12]/D`；逻辑/布线=['2.038', '5.472']ns，5  (CARRY4=1 LUT3=1 LUT4=1 LUT6=1 MUXF7=1)。
- gpio_snapshot_R: 3.473ns，`FD_replica_71/C` → `linienmodule_gpio_status_mask_s1_2_reg[10]/R`；逻辑/布线=['0.518', '3.350']ns，0。
- gpio_outputs_to: 2.322ns，`linienmodule_gpio_status_state_s1_reg[0]/C` → `linienmodule_gpio_n_o_reg[1]_lopt_replica/D`；逻辑/布线=['0.704', '4.793']ns，2  (LUT4=1 LUT5=1)。
- 资源={'lut': 15145, 'ff': 15961, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 431, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=378/383，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.036/0.0/1.5ns。

### R36

代码提交 `52fba6b91be6e7db1e00a7603d77dabb617d7446`。

- global_worst: -0.656ns，`linienmodule_fast_a_common_reg[5]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['2.435', '5.703']ns，9  (CARRY4=2 LUT1=1 LUT2=1 LUT5=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.162ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_y0_reg[11]/CE`；逻辑/布线=['5.972', '1.766']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_entry: 0.018ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[17]/C` → `DSP48E1_5/B[0]`；逻辑/布线=['0.456', '4.085']ns，0。
- fast_D: 0.747ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['2.251', '4.859']ns，7  (CARRY4=2 LUT2=1 LUT3=1 LUT4=1 LUT6=2)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 3.143ns，`FD_replica_15/C` → `linienmodule_mixeralignedpid5_reg/R`；逻辑/布线=['0.518', '3.416']ns，0。
- fast_CE: 0.666ns，`linienmodule_csr_adr_reg[6]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[0]/CE`；逻辑/布线=['0.940', '5.951']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.093ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.089', '4.714']ns，12  (CARRY4=5 LUT4=2 LUT5=3 LUT6=2)。
- scope_average_control: 2.757ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_dat_reg[8]/D`；逻辑/布线=['0.580', '4.538']ns，1  (LUT3=1)。
- frontend_a_output: -0.35ns，`linienmodule_fast_a_iir0_y2_reg[0]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_12/D`；逻辑/布线=['2.370', '5.587']ns，8  (CARRY4=2 LUT2=1 LUT5=1 LUT6=3 MUXF7=1)。
- frontend_b_output: -0.437ns，`linienmodule_fast_b_iir0_y0_reg[1]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[5]/D`；逻辑/布线=['3.380', '4.515']ns，12  (CARRY4=7 LUT2=1 LUT4=1 LUT5=1 LUT6=1 MUXF7=1)。
- same_adc_domain: -0.656ns，`linienmodule_fast_a_common_reg[5]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['2.435', '5.703']ns，9  (CARRY4=2 LUT1=1 LUT2=1 LUT5=1 LUT6=3 MUXF7=1)。
- scope_adc_control: -0.158ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_filt_pp_reg[1]/CE`；逻辑/布线=['1.450', '6.321']ns，5  (LUT3=1 LUT4=1 LUT6=3)。
- scope_fclk_control: 0.02ns，`red_pitaya_scope/i_bridge/addr_o_reg[16]/C` → `red_pitaya_scope/set_a_filt_pp_reg[1]/CE`；逻辑/布线=['1.542', '7.505']ns，5  (LUT2=1 LUT3=1 LUT4=1 LUT6=2)。
- prefetch_to: -0.148ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[0]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.721', '4.365']ns，14  (CARRY4=9 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.198ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]_lopt_replica/D`；逻辑/布线=['2.263', '5.692']ns，9  (CARRY4=3 LUT3=2 LUT5=2 LUT6=2)。
- prefetch_choice_to: 0.599ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.165', '4.841']ns，8  (CARRY4=3 LUT3=3 LUT5=1 LUT6=1)。
- prefetch_choice_from: -0.198ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]_lopt_replica/D`；逻辑/布线=['2.263', '5.692']ns，9  (CARRY4=3 LUT3=2 LUT5=2 LUT6=2)。
- gpio_outputs_to: -0.198ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]_lopt_replica/D`；逻辑/布线=['2.263', '5.692']ns，9  (CARRY4=3 LUT3=2 LUT5=2 LUT6=2)。
- 资源={'lut': 12485, 'ff': 13648, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 432, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=369/373，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.015/0.0/1.5ns。

### R37

代码提交 `e8c1828e434709581662df2995225162933db58a`。

- global_worst: -0.874ns，`linienmodule_fast_a_iir0_y0_reg[5]_replica/C` → `DSP48E1_68_i_18_psdsp/D`；逻辑/布线=['3.076', '5.375']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT6=3 MUXF7=1)。
- raw_internal: -0.225ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_low/CEB2`；逻辑/布线=['5.972', '1.670']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- raw_entry: 0.111ns，`linienmodule_csr_dat_w_reg[5]_rep__2/C` → `linienmodule_raw_acquisition_iir_csrstorage0_storage_full_reg[5]/D`；逻辑/布线=['0.518', '7.302']ns，0。
- fast_D: 0.489ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/D`；逻辑/布线=['3.177', '4.285']ns，13  (CARRY4=7 LUT2=1 LUT3=1 LUT4=1 LUT6=3)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 2.252ns，`FD_replica_6/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[34]/R`；逻辑/布线=['0.573', '4.429']ns，1  (LUT3=1)。
- fast_CE: 0.842ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.932', '5.887']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.293ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[33]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.133', '5.058']ns，12  (CARRY4=5 LUT3=1 LUT5=2 LUT6=4)。
- scope_average_control: 2.427ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.952', '4.520']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -0.874ns，`linienmodule_fast_a_iir0_y0_reg[5]_replica/C` → `DSP48E1_68_i_18_psdsp/D`；逻辑/布线=['3.076', '5.375']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT6=3 MUXF7=1)。
- frontend_b_output: -0.525ns，`linienmodule_fast_b_iir1_y0_reg[0]/C` → `linienmodule_fast_b_paralleltaplimitcsr1_y_reg[5]/D`；逻辑/布线=['2.411', '5.984']ns，9  (CARRY4=4 LUT2=1 LUT6=4)。
- same_adc_domain: -0.874ns，`linienmodule_fast_a_iir0_y0_reg[5]_replica/C` → `DSP48E1_68_i_18_psdsp/D`；逻辑/布线=['3.076', '5.375']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT6=3 MUXF7=1)。
- scope_adc_control: -0.761ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_filt_pp_reg[9]/CE`；逻辑/布线=['1.541', '6.744']ns，6  (LUT3=2 LUT4=2 LUT6=2)。
- scope_fclk_control: -0.47ns，`red_pitaya_scope/i_bridge/addr_o_reg[19]/C` → `red_pitaya_scope/set_a_hyst_reg[0]/CE`；逻辑/布线=['1.441', '7.916']ns，5  (LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- prefetch_to: -0.554ns，`linienmodule_autolock_pipelinedrobustautolock_csrstorage31_storage_full_reg[0]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[21]/D`；逻辑/布线=['3.833', '4.300']ns，15  (CARRY4=10 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.025ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[21]/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['2.077', '5.707']ns，8  (CARRY4=2 LUT3=2 LUT5=2 LUT6=2)。
- prefetch_choice_to: 0.312ns，`linienmodule_autolock_pipelinedrobustautolock_sum_diff_s1_reg[9]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.163', '5.026']ns，8  (CARRY4=3 LUT3=3 LUT5=1 LUT6=1)。
- prefetch_choice_from: -0.015ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['1.971', '5.805']ns，7  (CARRY4=2 LUT4=2 LUT5=2 LUT6=1)。
- gpio_outputs_to: -0.099ns，`linienmodule_autolock_pipelinedrobustautolock_sum_diff_s1_reg[9]/C` → `linienmodule_gpio_n_o_reg[6]_lopt_replica/D`；逻辑/布线=['2.263', '5.608']ns，9  (CARRY4=3 LUT3=2 LUT5=2 LUT6=2)。
- 资源={'lut': 12372, 'ff': 13630, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 439, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=372/369，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.026/0.0/1.5ns。

### R38

代码提交 `291fbec246fe0e7764aee34a03b9b8909c128186`。

- global_worst: -0.619ns，`red_pitaya_scope/i_bridge/addr_o_reg[17]/C` → `red_pitaya_scope/set_a_filt_kk_reg[15]/CE`；逻辑/布线=['1.694', '8.021']ns，5  (LUT2=1 LUT3=1 LUT4=1 LUT6=2)。
- raw_internal: -0.22ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.644']ns，3  (DSP48E1=1 LUT3=1 LUT6=1)。
- raw_entry: -0.125ns，`linienmodule_csr_dat_w_reg[2]/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[18]/D`；逻辑/布线=['0.456', '7.702']ns，0。
- fast_D: 0.284ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['2.565', '4.966']ns，11  (CARRY4=5 LUT2=2 LUT4=1 LUT5=1 LUT6=2)。
- fast_S: 0.253ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/S`；逻辑/布线=['2.801', '4.207']ns，13  (CARRY4=8 LUT2=1 LUT4=1 LUT5=1 LUT6=2)。
- fast_R: 3.257ns，`FD_replica_18/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[12]/R`；逻辑/布线=['0.518', '3.660']ns，0。
- fast_CE: 1.244ns，`linienmodule_csr_adr_reg[6]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[1]/CE`；逻辑/布线=['1.002', '5.551']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.251ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[30]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.172', '4.985']ns，11  (CARRY4=4 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 0.406ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_q_dat_reg[3]/D`；逻辑/布线=['0.642', '6.935']ns，1  (LUT3=1)。
- frontend_a_output: -0.416ns，`linienmodule_fast_a_iir0_y2_reg[14]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[7]/D`；逻辑/布线=['3.183', '4.794']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.189ns，`linienmodule_fast_b_iir0_y2_reg[19]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[15]/D`；逻辑/布线=['3.052', '4.735']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.555ns，`linienmodule_fast_b_iir1_z_low0/CLK` → `linienmodule_fast_b_iir1_z_high0/CEB2`；逻辑/布线=['5.972', '1.976']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- scope_adc_control: -0.131ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_hyst_reg[4]/CE`；逻辑/布线=['1.533', '6.125']ns，4  (LUT3=2 LUT5=1 LUT6=1)。
- scope_fclk_control: -0.619ns，`red_pitaya_scope/i_bridge/addr_o_reg[17]/C` → `red_pitaya_scope/set_a_filt_kk_reg[15]/CE`；逻辑/布线=['1.694', '8.021']ns，5  (LUT2=1 LUT3=1 LUT4=1 LUT6=2)。
- prefetch_to: -0.212ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.673', '4.502']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.2ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[2]/D`；逻辑/布线=['2.464', '5.660']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.539ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.490', '4.605']ns，9  (CARRY4=4 LUT3=3 LUT5=2)。
- prefetch_choice_from: -0.2ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[2]/D`；逻辑/布线=['2.464', '5.660']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- gpio_outputs_to: -0.2ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[2]/D`；逻辑/布线=['2.464', '5.660']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- 资源={'lut': 12168, 'ff': 13573, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 432, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=368/372，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=406；route WHS/THS/WPWS=0.032/0.0/1.5ns。

### R39

代码提交 `de00c4493a4a12d5622a4aa3b86f7388b7dbfd3f`。

- global_worst: -0.655ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_fast_b_iir0_storage_full0_reg[20]/D`；逻辑/布线=['0.456', '8.054']ns，0。
- raw_internal: -0.235ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_y0_reg[14]/CE`；逻辑/布线=['6.096', '1.747']ns，4  (DSP48E1=1 LUT3=1 LUT5=1 LUT6=1)。
- raw_entry: -0.261ns，`linienmodule_csr_dat_w_reg[7]_rep__2/C` → `linienmodule_raw_acquisition_iir_csrstorage4_storage_full_reg[15]/D`；逻辑/布线=['0.456', '7.520']ns，0。
- fast_D: 0.592ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['3.267', '4.004']ns，15  (CARRY4=9 LUT2=2 LUT4=1 LUT5=1 LUT6=2)。
- fast_S: 0.506ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.915', '3.842']ns，14  (CARRY4=9 LUT2=1 LUT4=1 LUT5=1 LUT6=2)。
- fast_R: 2.589ns，`FD_replica_1/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_reg_r_reg[5]/R`；逻辑/布线=['0.518', '4.332']ns，0。
- fast_CE: 0.972ns，`linienmodule_csr_adr_reg[6]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[0]/CE`；逻辑/布线=['1.016', '5.738']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.486ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[29]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.215', '5.217']ns，12  (CARRY4=5 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 1.855ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[13]/D`；逻辑/布线=['0.580', '5.307']ns，1  (LUT3=1)。
- frontend_a_output: -0.581ns，`linienmodule_fast_a_iir0_y0_reg[10]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.226', '4.721']ns，10  (CARRY4=6 LUT2=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.476ns，`linienmodule_fast_b_iir0_y0_reg[11]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[15]/D`；逻辑/布线=['3.281', '4.820']ns，10  (CARRY4=5 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.655ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_fast_b_iir0_storage_full0_reg[20]/D`；逻辑/布线=['0.456', '8.054']ns，0。
- scope_adc_control: -0.387ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_a_filt_bb_reg[15]/D`；逻辑/布线=['1.396', '6.847']ns，6  (LUT3=2 LUT4=1 LUT6=3)。
- scope_fclk_control: -0.527ns，`red_pitaya_scope/i_bridge/addr_o_reg[19]/C` → `red_pitaya_scope/set_a_filt_bb_reg[15]/D`；逻辑/布线=['1.534', '8.290']ns，6  (LUT2=1 LUT3=2 LUT4=1 LUT6=2)。
- prefetch_to: -0.44ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['3.858', '4.515']ns，17  (CARRY4=12 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.351ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.253', '6.053']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.13ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.247', '5.232']ns，9  (CARRY4=4 LUT3=3 LUT5=2)。
- prefetch_choice_from: -0.351ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.253', '6.053']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- csr_data_from: -0.655ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_fast_b_iir0_storage_full0_reg[20]/D`；逻辑/布线=['0.456', '8.054']ns，0。
- csr_data_to: 3.177ns，`bus_clk_bridge/wdata_o_reg[1]/C` → `linienmodule_csr_dat_w_reg[1]/D`；逻辑/布线=['0.456', '5.850']ns，0。
- gpio_outputs_to: -0.351ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.253', '6.053']ns，9  (CARRY4=4 LUT3=2 LUT5=2 LUT6=1)。
- 资源={'lut': 12530, 'ff': 13540, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 432, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 64}，相对R4a严格名称差集新增/移除=386/700，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.026/0.0/1.5ns。

### R40

代码提交 `079667f63d250d138dfc1d3fa8b0000655a5d214`。

- global_worst: -0.582ns，`linienmodule_fast_b_iir1_z_low0/CLK` → `linienmodule_fast_b_iir1_z_high0/CEB2`；逻辑/布线=['5.972', '2.003']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- raw_internal: -0.141ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.565']ns，3  (DSP48E1=1 LUT3=1 LUT6=1)。
- raw_entry: 0.475ns，`linienmodule_csr_dat_w_reg[4]_replica_1/C` → `linienmodule_raw_acquisition_iir_csrstorage3_storage_full_reg[20]/D`；逻辑/布线=['0.456', '6.962']ns，0。
- fast_D: 0.395ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['2.679', '4.740']ns，12  (CARRY4=6 LUT2=2 LUT4=1 LUT5=1 LUT6=2)。
- fast_S: 0.354ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/S`；逻辑/布线=['2.915', '3.991']ns，14  (CARRY4=9 LUT2=1 LUT4=1 LUT5=1 LUT6=2)。
- fast_R: 2.517ns，`FD_replica_18/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_reg_r_reg[10]/R`；逻辑/布线=['0.518', '4.443']ns，0。
- fast_CE: 1.342ns，`linienmodule_csr_adr_reg[5]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[16]/CE`；逻辑/布线=['0.642', '5.812']ns，1  (LUT6=1)。
- fast_outgoing: -0.217ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[32]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.186', '4.935']ns，11  (CARRY4=4 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 0.704ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_dat_reg[2]/D`；逻辑/布线=['0.642', '6.637']ns，1  (LUT3=1)。
- frontend_a_output: -0.117ns，`linienmodule_fast_a_iir0_y2_reg[10]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_35/D`；逻辑/布线=['3.419', '4.172']ns，9  (CARRY4=5 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.093ns，`linienmodule_fast_b_iir0_y2_reg[20]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[13]/D`；逻辑/布线=['2.900', '4.788']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.582ns，`linienmodule_fast_b_iir1_z_low0/CLK` → `linienmodule_fast_b_iir1_z_high0/CEB2`；逻辑/布线=['5.972', '2.003']ns，3  (DSP48E1=1 LUT5=1 LUT6=1)。
- scope_adc_control: 0.303ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_a_filt_pp_reg[16]/CE`；逻辑/布线=['1.293', '6.195']ns，5  (LUT3=1 LUT4=1 LUT6=3)。
- scope_fclk_control: -0.32ns，`red_pitaya_scope/i_bridge/addr_o_reg[17]/C` → `red_pitaya_scope/set_a_filt_pp_reg[15]/CE`；逻辑/布线=['1.583', '7.837']ns，5  (LUT2=1 LUT3=1 LUT4=1 LUT6=2)。
- prefetch_to: -0.161ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['3.843', '4.248']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.058ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[7]_lopt_replica/D`；逻辑/布线=['2.423', '5.611']ns，9  (CARRY4=4 LUT3=1 LUT4=1 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.578ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.449', '4.607']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.058ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[7]_lopt_replica/D`；逻辑/布线=['2.423', '5.611']ns，9  (CARRY4=4 LUT3=1 LUT4=1 LUT5=2 LUT6=1)。
- csr_data_from: 0.05ns，`linienmodule_csr_dat_w_reg[0]_rep__0/C` → `linienmodule_fast_b_iir0_csrstorage2_storage_full0_reg[24]/D`；逻辑/布线=['0.580', '7.042']ns，1  (LUT3=1)。
- csr_data_to: 0.5ns，`FD_replica_6/C` → `linienmodule_csr_dat_w_reg[4]_replica_4/R`；逻辑/布线=['0.456', '6.609']ns，0。
- gpio_outputs_to: -0.058ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[7]_lopt_replica/D`；逻辑/布线=['2.423', '5.611']ns，9  (CARRY4=4 LUT3=1 LUT4=1 LUT5=2 LUT6=1)。
- 资源={'lut': 12169, 'ff': 13601, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 459, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=395/372，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=406；route WHS/THS/WPWS=0.032/0.0/1.5ns。

### R41

代码提交 `9479e4e72e84a0b5464bf6492544eb0a1ad6d1e6`。

- global_worst: -0.791ns，`red_pitaya_scope/set_dec_reg[23]/C` → `red_pitaya_scope/adc_a_dat_reg[7]/D`；逻辑/布线=['1.634', '6.943']ns，9  (LUT3=1 LUT5=3 LUT6=5)。
- raw_internal: -0.114ns，`linienmodule_raw_acquisition_iir_y0_reg[6]/C` → `DSP48E1_13/PCIN[0]`；逻辑/布线=['4.503', '2.200']ns，1  (DSP48E1=1)。
- raw_entry: 0.17ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[17]/C` → `DSP48E1_11/B[0]`；逻辑/布线=['0.518', '3.728']ns，0。
- fast_D: 0.759ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[14]/D`；逻辑/布线=['3.028', '4.027']ns，15  (CARRY4=10 LUT2=1 LUT3=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 1.937ns，`FD_replica_6/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/R`；逻辑/布线=['0.606', '4.701']ns，1  (LUT3=1)。
- fast_CE: 0.696ns，`linienmodule_csr_adr_reg[4]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[1]/CE`；逻辑/布线=['0.934', '5.934']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: 0.028ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[26]/C` → `linienmodule_limit_fast1_x_reg[9]/D`；逻辑/布线=['2.874', '4.990']ns，11  (CARRY4=4 LUT4=2 LUT5=3 LUT6=2)。
- scope_average_control: 2.071ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.952', '4.830']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -0.103ns，`linienmodule_fast_a_iir0_y0_reg[11]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_36/D`；逻辑/布线=['3.435', '4.320']ns，10  (CARRY4=5 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.397ns，`linienmodule_fast_b_iir0_y0_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_24/D`；逻辑/布线=['3.394', '4.518']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.791ns，`red_pitaya_scope/set_dec_reg[23]/C` → `red_pitaya_scope/adc_a_dat_reg[7]/D`；逻辑/布线=['1.634', '6.943']ns，9  (LUT3=1 LUT5=3 LUT6=5)。
- scope_adc_control: 1.529ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_filt_bb_reg[0]/CE`；逻辑/布线=['0.743', '5.120']ns，1  (LUT4=1)。
- scope_fclk_control: 1.46ns，`red_pitaya_scope/i_bridge/wdata_o_reg[7]/C` → `red_pitaya_scope/set_dec_reg[7]/D`；逻辑/布线=['0.456', '7.248']ns，0。
- prefetch_to: -0.612ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['3.691', '4.860']ns，14  (CARRY4=9 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.439ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[15]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.172', '6.163']ns，9  (CARRY4=3 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- prefetch_choice_to: 0.375ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[15]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.040', '5.216']ns，8  (CARRY4=3 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.38ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.110', '6.165']ns，9  (CARRY4=3 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- csr_data_from: -0.4ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_fast_a_iir0_csrstorage3_storage_full_reg[4]/D`；逻辑/布线=['0.518', '7.651']ns，0。
- csr_data_to: 2.848ns，`bus_clk_bridge/wdata_o_reg[7]/C` → `linienmodule_csr_dat_w_reg[7]_rep__0/D`；逻辑/布线=['0.478', '5.981']ns，0。
- scope_predecode_to: 1.336ns，`axi_slave/rd_araddr_reg[9]/C` → `red_pitaya_scope/scope_addr_match_reg[7]/R`；逻辑/布线=['1.594', '4.356']ns，5  (LUT3=1 LUT5=1 LUT6=3)。
- scope_predecode_from: 2.437ns，`red_pitaya_scope/scope_addr_match_reg[12]/C` → `red_pitaya_scope/set_a_filt_pp_reg[5]/CE`；逻辑/布线=['0.671', '5.839']ns，1  (LUT4=1)。
- scope_predecode_to_config: 2.437ns，`red_pitaya_scope/scope_addr_match_reg[12]/C` → `red_pitaya_scope/set_a_filt_pp_reg[5]/CE`；逻辑/布线=['0.671', '5.839']ns，1  (LUT4=1)。
- gpio_outputs_to: -0.439ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[15]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.172', '6.163']ns，9  (CARRY4=3 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- 资源={'lut': 12108, 'ff': 13548, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 422, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=398/412，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=406；route WHS/THS/WPWS=0.05/0.0/1.5ns。

### R42

代码提交 `1765fc66d26e397676d1c2e94925901b0334de55`。

- global_worst: -1.161ns，`linienmodule_fast_b_iir1_y1_reg[4]/C` → `linienmodule_fast_b_iir1_y1_reg[0]/D`；逻辑/布线=['6.332', '2.691']ns，5  (DSP48E1=2 LUT5=1 LUT6=2)。
- raw_internal: -0.931ns，`linienmodule_raw_acquisition_iir_y1_reg[3]/C` → `linienmodule_raw_acquisition_iir_y0_reg[17]/CE`；逻辑/布线=['6.073', '2.596']ns，4  (DSP48E1=2 LUT3=1 LUT6=1)。
- raw_entry: -0.044ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[17]/C` → `DSP48E1_11/B[0]`；逻辑/布线=['0.518', '3.951']ns，0。
- fast_D: 0.567ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[4]/D`；逻辑/布线=['3.187', '4.159']ns，15  (CARRY4=10 LUT2=1 LUT3=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 2.345ns，`FD_replica_6/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_reg_reg[15]/R`；逻辑/布线=['0.456', '4.641']ns，0。
- fast_CE: 0.756ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kp_storage_full_reg[5]/CE`；逻辑/布线=['1.072', '5.833']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.059ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[27]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.066', '5.039']ns，12  (CARRY4=5 LUT3=1 LUT5=3 LUT6=3)。
- scope_average_control: 1.877ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.952', '4.820']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -1.148ns，`linienmodule_fast_a_iir1_y1_reg[11]/C` → `linienmodule_fast_a_iir1_y1_reg[1]/D`；逻辑/布线=['6.197', '2.829']ns，5  (DSP48E1=2 LUT5=1 LUT6=2)。
- frontend_b_output: -1.161ns，`linienmodule_fast_b_iir1_y1_reg[4]/C` → `linienmodule_fast_b_iir1_y1_reg[0]/D`；逻辑/布线=['6.332', '2.691']ns，5  (DSP48E1=2 LUT5=1 LUT6=2)。
- same_adc_domain: -1.161ns，`linienmodule_fast_b_iir1_y1_reg[4]/C` → `linienmodule_fast_b_iir1_y1_reg[0]/D`；逻辑/布线=['6.332', '2.691']ns，5  (DSP48E1=2 LUT5=1 LUT6=2)。
- scope_adc_control: -0.498ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_filt_pp_reg[12]/CE`；逻辑/布线=['1.973', '6.238']ns，6  (LUT3=2 LUT4=1 LUT5=1 LUT6=2)。
- scope_fclk_control: -0.842ns，`red_pitaya_scope/i_bridge/addr_o_reg[18]/C` → `red_pitaya_scope/set_a_filt_pp_reg[12]/CE`；逻辑/布线=['1.599', '8.354']ns，6  (LUT2=1 LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- prefetch_to: -0.693ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.787', '4.871']ns，17  (CARRY4=12 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.471ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[17]/C` → `linienmodule_gpio_n_o_reg[4]/D`；逻辑/布线=['2.190', '6.138']ns，8  (CARRY4=2 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- prefetch_choice_to: 0.256ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[17]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.062', '5.235']ns，7  (CARRY4=2 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.466ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[4]/D`；逻辑/布线=['2.128', '6.305']ns，8  (CARRY4=2 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- csr_data_from: -0.557ns，`linienmodule_csr_dat_w_reg[5]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_csrstorage58_storage_full_reg[13]/D`；逻辑/布线=['0.518', '7.838']ns，0。
- csr_data_to: 2.508ns，`FD_replica_6/C` → `linienmodule_csr_dat_w_reg[5]_rep__2/R`；逻辑/布线=['0.456', '4.377']ns，0。
- gpio_outputs_to: -0.471ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[17]/C` → `linienmodule_gpio_n_o_reg[4]/D`；逻辑/布线=['2.190', '6.138']ns，8  (CARRY4=2 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- 资源={'lut': 12326, 'ff': 13794, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 442, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 374}，相对R4a严格名称差集新增/移除=378/372，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=426；route WHS/THS/WPWS=0.027/0.0/1.5ns。

### R43

代码提交 `4038738b7ca622dba2b7a741f4b8c496e2bf7790`。

- global_worst: -0.578ns，`red_pitaya_scope/set_dec_reg[17]_replica/C` → `red_pitaya_scope/adc_a_dat_reg[11]/D`；逻辑/布线=['1.634', '6.728']ns，9  (LUT3=1 LUT4=1 LUT5=1 LUT6=6)。
- raw_internal: -0.124ns，`linienmodule_raw_acquisition_iir_y0_reg[9]/C` → `DSP48E1_13/PCIN[0]`；逻辑/布线=['4.369', '2.343']ns，1  (DSP48E1=1)。
- raw_entry: 0.552ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[1]/C` → `linienmodule_raw_acquisition_iir_zr_correction_q5_reg[0]/D`；逻辑/布线=['4.298', '3.088']ns，2  (DSP48E1=1 LUT5=1)。
- fast_D: 0.647ns，`p_1_out/CLK` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/D`；逻辑/布线=['3.028', '4.136']ns，15  (CARRY4=10 LUT2=1 LUT3=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 2.333ns，`FD_replica_6/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[30]/R`；逻辑/布线=['0.606', '4.305']ns，1  (LUT3=1)。
- fast_CE: 0.434ns，`linienmodule_csr_adr_reg[4]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[9]/CE`；逻辑/布线=['0.704', '6.426']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: 0.04ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[30]/C` → `linienmodule_limit_fast2_x_reg[13]/D`；逻辑/布线=['2.991', '4.864']ns，12  (CARRY4=5 LUT4=2 LUT5=3 LUT6=2)。
- scope_average_control: 1.751ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.952', '5.149']ns，4  (LUT5=1 LUT6=3)。
- frontend_a_output: -0.096ns，`linienmodule_fast_a_iir0_y0_reg[11]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_36/D`；逻辑/布线=['3.403', '4.345']ns，11  (CARRY4=6 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.212ns，`linienmodule_fast_b_iir0_y0_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_2/D`；逻辑/布线=['3.206', '4.515']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.578ns，`red_pitaya_scope/set_dec_reg[17]_replica/C` → `red_pitaya_scope/adc_a_dat_reg[11]/D`；逻辑/布线=['1.634', '6.728']ns，9  (LUT3=1 LUT4=1 LUT5=1 LUT6=6)。
- scope_adc_control: 0.937ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_a_filt_bb_reg[1]/CE`；逻辑/布线=['0.711', '5.818']ns，1  (LUT4=1)。
- scope_fclk_control: 1.255ns，`red_pitaya_scope/i_bridge/sys_wr_reg/C` → `red_pitaya_scope/set_a_filt_bb_reg[1]/CE`；逻辑/布线=['0.667', '6.979']ns，1  (LUT4=1)。
- prefetch_to: -0.344ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['3.850', '4.344']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.17ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.018', '6.047']ns，8  (CARRY4=2 LUT3=2 LUT5=1 LUT6=3)。
- prefetch_choice_to: 0.572ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['1.886', '5.171']ns，7  (CARRY4=2 LUT3=3 LUT5=2)。
- prefetch_choice_from: -0.17ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.018', '6.047']ns，8  (CARRY4=2 LUT3=2 LUT5=1 LUT6=3)。
- csr_data_from: 0.053ns，`linienmodule_csr_dat_w_reg[7]/C` → `linienmodule_fast_a_iir0_storage_full0_reg[15]/D`；逻辑/布线=['0.478', '7.062']ns，0。
- csr_data_to: 0.925ns，`bus_clk_bridge/wdata_o_reg[5]/C` → `linienmodule_csr_dat_w_reg[5]_replica_7/D`；逻辑/布线=['0.419', '7.835']ns，0。
- scope_predecode_to: 1.626ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[7]/R`；逻辑/布线=['1.500', '4.159']ns，5  (LUT3=1 LUT5=1 LUT6=3)。
- scope_predecode_from: 2.289ns，`red_pitaya_scope/scope_addr_match_reg[12]/C` → `red_pitaya_scope/set_a_filt_pp_reg[9]/CE`；逻辑/布线=['0.671', '6.022']ns，1  (LUT4=1)。
- scope_predecode_to_config: 2.289ns，`red_pitaya_scope/scope_addr_match_reg[12]/C` → `red_pitaya_scope/set_a_filt_pp_reg[9]/CE`；逻辑/布线=['0.671', '6.022']ns，1  (LUT4=1)。
- gpio_outputs_to: -0.17ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[3]/D`；逻辑/布线=['2.018', '6.047']ns，8  (CARRY4=2 LUT3=2 LUT5=1 LUT6=3)。
- 资源={'lut': 12146, 'ff': 13620, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 494, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 392}，相对R4a严格名称差集新增/移除=488/412，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=406；route WHS/THS/WPWS=0.019/0.0/1.5ns。

### R44

代码提交 `408d899de3235f582d6b5722ff4a7dbe4eb08dd4`。

- global_worst: -0.691ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__1/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.727', '4.805']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- raw_internal: -0.505ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_y0_reg[12]/CE`；逻辑/布线=['5.972', '2.108']ns，3  (DSP48E1=1 LUT3=1 LUT6=1)。
- raw_entry: 0.015ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[20]/C` → `DSP48E1_11/B[3]`；逻辑/布线=['0.456', '3.779']ns，0。
- fast_D: 0.221ns，`linienmodule_csr_dat_w_reg[5]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[5]/D`；逻辑/布线=['0.456', '7.091']ns，0。
- fast_S: 1.012ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[11]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.483', '3.940']ns，13  (CARRY4=9 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 2.959ns，`FD_replica_73/C` → `linienmodule_mixeralignedpid9_reg[1]/R`；逻辑/布线=['0.456', '4.086']ns，0。
- fast_CE: 1.472ns，`linienmodule_csr_adr_reg[5]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[0]/CE`；逻辑/布线=['0.932', '5.216']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: 0.071ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[29]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.087', '4.769']ns，13  (CARRY4=6 LUT3=1 LUT5=2 LUT6=4)。
- scope_average_control: 3.959ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_q_dat_reg[8]/D`；逻辑/布线=['0.580', '3.355']ns，1  (LUT6=1)。
- frontend_a_output: -0.36ns，`linienmodule_fast_a_iir0_y0_reg[10]_replica/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['3.454', '4.394']ns，11  (CARRY4=6 LUT3=1 LUT5=2 LUT6=1 MUXF7=1)。
- frontend_b_output: -0.508ns，`linienmodule_fast_b_iir0_y0_reg[11]_replica/C` → `linienmodule_registerederrormixer_y[36]_i_18_psdsp_39/D`；逻辑/布线=['3.401', '4.778']ns，11  (CARRY4=5 LUT2=1 LUT4=1 LUT5=2 LUT6=1 MUXF7=1)。
- same_adc_domain: -0.691ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__1/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.727', '4.805']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- scope_adc_control: 0.498ns，`red_pitaya_scope/adc_dly_cnt_reg[28]/C` → `red_pitaya_scope/set_trig_src_reg[1]/CE`；逻辑/布线=['1.341', '5.581']ns，5  (LUT4=3 LUT5=2)。
- scope_fclk_control: 2.318ns，`red_pitaya_scope/i_bridge/wdata_o_reg[10]/C` → `red_pitaya_scope/set_a_filt_kk_reg[10]/D`；逻辑/布线=['0.456', '6.437']ns，0。
- prefetch_to: -0.691ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__1/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['3.727', '4.805']ns，16  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.665ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/C` → `linienmodule_gpio_n_o_reg[2]_lopt_replica/D`；逻辑/布线=['2.304', '6.327']ns，9  (CARRY4=3 LUT3=1 LUT4=2 LUT5=3)。
- prefetch_choice_to: 0.609ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.056', '5.236']ns，7  (CARRY4=3 LUT3=1 LUT4=1 LUT5=1 LUT6=1)。
- prefetch_choice_from: -0.665ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/C` → `linienmodule_gpio_n_o_reg[2]_lopt_replica/D`；逻辑/布线=['2.304', '6.327']ns，9  (CARRY4=3 LUT3=1 LUT4=2 LUT5=3)。
- csr_data_from: -0.18ns，`linienmodule_csr_dat_w_reg[4]_rep/C` → `linienmodule_autolock_pipelinedrobustautolock_csrstorage63_storage_full_reg[12]/D`；逻辑/布线=['0.456', '7.451']ns，0。
- csr_data_to: 4.144ns，`FD_replica_36/C` → `linienmodule_csr_dat_w_reg[5]_rep__2/R`；逻辑/布线=['0.456', '2.747']ns，0。
- scope_predecode_to: 1.805ns，`axi_slave/rd_araddr_reg[8]/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.332', '3.956']ns，5  (LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- scope_predecode_from: 3.855ns，`red_pitaya_scope/scope_addr_match_reg[15]/C` → `red_pitaya_scope/set_b_filt_kk_reg[6]/CE`；逻辑/布线=['0.802', '4.220']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.855ns，`red_pitaya_scope/scope_addr_match_reg[15]/C` → `red_pitaya_scope/set_b_filt_kk_reg[6]/CE`；逻辑/布线=['0.802', '4.220']ns，1  (LUT4=1)。
- scope_factor_source_to: 2.799ns，`axi_slave/wr_wdata_reg[29]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.755', '3.003']ns，5  (LUT5=2 LUT6=3)。
- scope_factor_source_from: 5.294ns，`red_pitaya_scope/scope_dec_shift_source_reg[4]/C` → `red_pitaya_scope/set_dec_shift_reg[4]/D`；逻辑/布线=['0.456', '3.458']ns，0。
- scope_factor_target_to: 2.572ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_zero_reg/CE`；逻辑/布线=['0.803', '4.124']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.451ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_b_q_dat_reg[1]/D`；逻辑/布线=['1.182', '4.925']ns，4  (LUT3=1 LUT5=1 LUT6=2)。
- scope_factor_to_data: 1.451ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_b_q_dat_reg[1]/D`；逻辑/布线=['1.182', '4.925']ns，4  (LUT3=1 LUT5=1 LUT6=2)。
- gpio_outputs_to: -0.665ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/C` → `linienmodule_gpio_n_o_reg[2]_lopt_replica/D`；逻辑/布线=['2.304', '6.327']ns，9  (CARRY4=3 LUT3=1 LUT4=2 LUT5=3)。
- 资源={'lut': 12234, 'ff': 13642, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 435, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=379/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=408；route WHS/THS/WPWS=0.03/0.0/1.5ns。

### R46

代码提交 `827dfeca13acd2ccc6640e6ac7217800bf3d4e12`。

- global_worst: -0.539ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.957']ns，3  (DSP48E1=1 LUT6=2)。
- raw_internal: -0.162ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_low/CEB2`；逻辑/布线=['5.972', '1.607']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: 0.278ns，`linienmodule_csr_dat_w_reg[1]/C` → `linienmodule_raw_acquisition_iir_storage_full_reg[9]/D`；逻辑/布线=['0.478', '7.048']ns，0。
- fast_D: 1.159ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/D`；逻辑/布线=['3.085', '3.363']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT6=2)。
- fast_S: 0.389ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[0]/S`；逻辑/布线=['2.780', '3.980']ns，15  (CARRY4=11 LUT2=1 LUT3=1 LUT6=2)。
- fast_R: 4.278ns，`FD_replica_59/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_reg_r_reg[33]/R`；逻辑/布线=['0.456', '2.710']ns，0。
- fast_CE: 1.667ns，`linienmodule_csr_adr_reg[6]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[8]/CE`；逻辑/布线=['1.002', '5.174']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.367ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[33]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.005', '4.668']ns，11  (CARRY4=4 LUT3=1 LUT5=2 LUT6=4)。
- scope_average_control: 3.002ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[1]/D`；逻辑/布线=['0.580', '4.278']ns，1  (LUT6=1)。
- frontend_a_output: -0.203ns，`linienmodule_fast_a_iir0_y2_reg[11]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[18]/D`；逻辑/布线=['3.368', '4.479']ns，11  (CARRY4=6 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.205ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.351', '4.513']ns，10  (CARRY4=5 LUT2=2 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.539ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.957']ns，3  (DSP48E1=1 LUT6=2)。
- scope_adc_control: 1.171ns，`FD_replica/C` → `red_pitaya_scope/set_a_treshm_reg[10]/CE`；逻辑/布线=['0.580', '5.789']ns，1  (LUT1=1)。
- scope_fclk_control: 2.513ns，`red_pitaya_scope/i_bridge/sys_wr_reg/C` → `red_pitaya_scope/set_b_filt_kk_reg[14]/CE`；逻辑/布线=['0.670', '5.748']ns，1  (LUT4=1)。
- prefetch_to: 0.171ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[26]/D`；逻辑/布线=['3.127', '4.602']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_from: 0.146ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]/D`；逻辑/布线=['2.229', '5.493']ns，8  (CARRY4=2 LUT3=2 LUT4=1 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.719ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.099', '4.785']ns，7  (CARRY4=2 LUT3=3 LUT5=2)。
- prefetch_choice_from: 0.146ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]/D`；逻辑/布线=['2.229', '5.493']ns，8  (CARRY4=2 LUT3=2 LUT4=1 LUT5=2 LUT6=1)。
- prefetch_negative_to_all: 0.186ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.602']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_D: 0.186ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.602']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_R: 2.67ns，`FD_replica_19/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[7]/R`；逻辑/布线=['0.518', '4.287']ns，0。
- prefetch_negative_MSB: 0.654ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.655', '4.530']ns，8  (CARRY4=4 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- csr_data_from: 0.168ns，`linienmodule_csr_dat_w_reg[1]_rep__1/C` → `linienmodule_fast_b_iir0_csrstorage2_storage_full1_reg[9]/D`；逻辑/布线=['0.419', '7.003']ns，0。
- csr_data_to: 2.797ns，`FD_replica_12/C` → `linienmodule_csr_dat_w_reg[5]_rep__1/R`；逻辑/布线=['0.456', '4.088']ns，0。
- scope_predecode_to: 1.079ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.501', '4.464']ns，5  (LUT4=1 LUT5=2 LUT6=2)。
- scope_predecode_from: 3.304ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.811', '4.794']ns，1  (LUT5=1)。
- scope_predecode_to_config: 3.304ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.811', '4.794']ns，1  (LUT5=1)。
- scope_factor_source_to: 2.995ns，`axi_slave/wr_wdata_reg[6]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[4]/D`；逻辑/布线=['0.964', '3.888']ns，3  (LUT6=3)。
- scope_factor_source_from: 4.91ns，`red_pitaya_scope/scope_dec_zero_source_reg/C` → `red_pitaya_scope/set_dec_zero_reg/D`；逻辑/布线=['0.518', '3.678']ns，0。
- scope_factor_target_to: 3.711ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_dec_shift_reg[1]/CE`；逻辑/布线=['0.773', '3.231']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.381ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_b_q_dat_reg[0]/D`；逻辑/布线=['1.182', '5.295']ns，4  (LUT3=1 LUT6=3)。
- scope_factor_to_data: 1.381ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_b_q_dat_reg[0]/D`；逻辑/布线=['1.182', '5.295']ns，4  (LUT3=1 LUT6=3)。
- gpio_outputs_to: 0.146ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]/D`；逻辑/布线=['2.229', '5.493']ns，8  (CARRY4=2 LUT3=2 LUT4=1 LUT5=2 LUT6=1)。
- 资源={'lut': 11679, 'ff': 13502, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=382/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.049/0.0/1.5ns。

### R47

代码提交 `d839e67c7977772cc2113a8d70cc91db2fa41020`。

- global_worst: -0.282ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.700']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- raw_internal: -0.202ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.626']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: 0.259ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[23]/C` → `DSP48E1_3/B[6]`；逻辑/布线=['0.518', '3.696']ns，0。
- fast_D: 1.128ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/D`；逻辑/布线=['3.085', '3.394']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT6=2)。
- fast_S: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 3.8ns，`FD_replica_27/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/R`；逻辑/布线=['0.456', '3.261']ns，0。
- fast_CE: 1.339ns，`linienmodule_csr_adr_reg[2]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[17]/CE`；逻辑/布线=['0.903', '5.594']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- scope_average_control: 3.545ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[13]/D`；逻辑/布线=['0.580', '3.784']ns，1  (LUT6=1)。
- frontend_a_output: 0.161ns，`linienmodule_fast_a_iir0_y2_reg[11]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['3.305', '4.129']ns，11  (CARRY4=6 LUT2=2 LUT5=2 MUXF7=1)。
- frontend_b_output: 0.058ns，`linienmodule_fast_b_iir0_y0_reg[15]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[7]/D`；逻辑/布线=['3.366', '4.251']ns，10  (CARRY4=5 LUT2=2 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.282ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.700']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- scope_adc_control: 0.514ns，`FD_replica/C` → `red_pitaya_scope/set_a_treshm_reg[4]/CE`；逻辑/布线=['0.580', '6.446']ns，1  (LUT1=1)。
- scope_fclk_control: 2.185ns，`red_pitaya_scope/i_bridge/sys_wr_reg/C` → `red_pitaya_scope/set_a_filt_kk_reg[22]/CE`；逻辑/布线=['0.642', '6.313']ns，1  (LUT4=1)。
- prefetch_to: 0.385ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[26]/D`；逻辑/布线=['3.127', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.418ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.286', '4.899']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_negative_to_all: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_D: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_R: 4.565ns，`FD_replica_19/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[27]/R`；逻辑/布线=['0.518', '2.354']ns，0。
- prefetch_negative_MSB: 0.741ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.655', '4.443']ns，8  (CARRY4=4 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- csr_data_from: 0.227ns，`linienmodule_csr_dat_w_reg[0]/C` → `linienmodule_autolock_request_lock_storage_full_reg/D`；逻辑/布线=['0.642', '7.157']ns，1  (LUT6=1)。
- csr_data_to: 3.26ns，`FD_replica_18/C` → `linienmodule_csr_dat_w_reg[6]/R`；逻辑/布线=['0.456', '3.737']ns，0。
- scope_predecode_to: 1.314ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.501', '4.230']ns，5  (LUT4=1 LUT5=2 LUT6=2)。
- scope_predecode_from: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_factor_source_to: 3.109ns，`axi_slave/wr_wdata_reg[23]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.689', '3.003']ns，5  (LUT5=2 LUT6=3)。
- scope_factor_source_from: 5.009ns，`red_pitaya_scope/scope_dec_shift_source_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[1]/D`；逻辑/布线=['0.518', '3.715']ns，0。
- scope_factor_target_to: 2.632ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_dec_shift_reg[0]/CE`；逻辑/布线=['0.773', '4.263']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- scope_factor_to_data: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- gpio_outputs_to: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- 资源={'lut': 11692, 'ff': 13504, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=382/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.015/0.0/1.5ns。

### R48

代码提交 `b0824e307ae5b0f1ce64a64f5aaef5820f9075ab`。

- global_worst: -0.179ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.597']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- raw_internal: -0.162ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.586']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: 0.259ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[23]/C` → `DSP48E1_3/B[6]`；逻辑/布线=['0.518', '3.696']ns，0。
- fast_D: 1.128ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/D`；逻辑/布线=['3.085', '3.394']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT6=2)。
- fast_S: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 3.8ns，`FD_replica_27/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/R`；逻辑/布线=['0.456', '3.261']ns，0。
- fast_CE: 1.339ns，`linienmodule_csr_adr_reg[2]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[17]/CE`；逻辑/布线=['0.903', '5.594']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- scope_average_control: 3.545ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[13]/D`；逻辑/布线=['0.580', '3.784']ns，1  (LUT6=1)。
- frontend_a_output: 0.161ns，`linienmodule_fast_a_iir0_y2_reg[11]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['3.305', '4.129']ns，11  (CARRY4=6 LUT2=2 LUT5=2 MUXF7=1)。
- frontend_b_output: 0.058ns，`linienmodule_fast_b_iir0_y0_reg[15]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[7]/D`；逻辑/布线=['3.366', '4.251']ns，10  (CARRY4=5 LUT2=2 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.179ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.597']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- scope_adc_control: 0.514ns，`FD_replica/C` → `red_pitaya_scope/set_a_treshm_reg[4]/CE`；逻辑/布线=['0.580', '6.446']ns，1  (LUT1=1)。
- scope_fclk_control: 2.185ns，`red_pitaya_scope/i_bridge/sys_wr_reg/C` → `red_pitaya_scope/set_a_filt_kk_reg[22]/CE`；逻辑/布线=['0.642', '6.313']ns，1  (LUT4=1)。
- prefetch_to: 0.385ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[26]/D`；逻辑/布线=['3.127', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.418ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.286', '4.899']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_negative_to_all: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_D: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_R: 4.565ns，`FD_replica_19/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[27]/R`；逻辑/布线=['0.518', '2.354']ns，0。
- prefetch_negative_MSB: 0.741ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.655', '4.443']ns，8  (CARRY4=4 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- csr_data_from: 0.227ns，`linienmodule_csr_dat_w_reg[0]/C` → `linienmodule_autolock_request_lock_storage_full_reg/D`；逻辑/布线=['0.642', '7.157']ns，1  (LUT6=1)。
- csr_data_to: 3.26ns，`FD_replica_18/C` → `linienmodule_csr_dat_w_reg[6]/R`；逻辑/布线=['0.456', '3.737']ns，0。
- scope_predecode_to: 1.314ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.501', '4.230']ns，5  (LUT4=1 LUT5=2 LUT6=2)。
- scope_predecode_from: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_factor_source_to: 3.109ns，`axi_slave/wr_wdata_reg[23]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.689', '3.003']ns，5  (LUT5=2 LUT6=3)。
- scope_factor_source_from: 5.009ns，`red_pitaya_scope/scope_dec_shift_source_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[1]/D`；逻辑/布线=['0.518', '3.715']ns，0。
- scope_factor_target_to: 2.632ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_dec_shift_reg[0]/CE`；逻辑/布线=['0.773', '4.263']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- scope_factor_to_data: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- gpio_outputs_to: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- 资源={'lut': 11693, 'ff': 13504, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=382/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.015/0.0/1.5ns。

### R49

代码提交 `2f990f8e19903538d4bc46a9478bc740ea596e73`。

- global_worst: -0.179ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.597']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- raw_internal: -0.162ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.972', '1.586']ns，3  (DSP48E1=1 LUT6=2)。
- raw_entry: 0.259ns，`linienmodule_limit_error_signal_alignedinputlimitcsr_y_reg[23]/C` → `DSP48E1_3/B[6]`；逻辑/布线=['0.518', '3.696']ns，0。
- fast_D: 1.128ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[1]/D`；逻辑/布线=['3.085', '3.394']ns，13  (CARRY4=9 LUT2=1 LUT4=1 LUT6=2)。
- fast_S: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_R: 3.8ns，`FD_replica_27/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[10]/R`；逻辑/布线=['0.456', '3.261']ns，0。
- fast_CE: 1.339ns，`linienmodule_csr_adr_reg[2]_rep__0/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[17]/CE`；逻辑/布线=['0.903', '5.594']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.463ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[5]/S`；逻辑/布线=['2.969', '3.717']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- scope_average_control: 3.545ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_b_q_dat_reg[13]/D`；逻辑/布线=['0.580', '3.784']ns，1  (LUT6=1)。
- frontend_a_output: 0.161ns，`linienmodule_fast_a_iir0_y2_reg[11]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[17]/D`；逻辑/布线=['3.305', '4.129']ns，11  (CARRY4=6 LUT2=2 LUT5=2 MUXF7=1)。
- frontend_b_output: 0.058ns，`linienmodule_fast_b_iir0_y0_reg[15]_replica/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[7]/D`；逻辑/布线=['3.366', '4.251']ns，10  (CARRY4=5 LUT2=2 LUT5=2 MUXF7=1)。
- same_adc_domain: -0.179ns，`linienmodule_fast_b_iir0_z_low0/CLK` → `linienmodule_fast_b_iir0_z_high0/CEB2`；逻辑/布线=['5.972', '1.597']ns，3  (DSP48E1=1 LUT2=1 LUT6=1)。
- scope_adc_control: 0.514ns，`FD_replica/C` → `red_pitaya_scope/set_a_treshm_reg[4]/CE`；逻辑/布线=['0.580', '6.446']ns，1  (LUT1=1)。
- scope_fclk_control: 2.185ns，`red_pitaya_scope/i_bridge/sys_wr_reg/C` → `red_pitaya_scope/set_a_filt_kk_reg[22]/CE`；逻辑/布线=['0.642', '6.313']ns，1  (LUT4=1)。
- prefetch_to: 0.385ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[26]/D`；逻辑/布线=['3.127', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_choice_to: 0.418ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.286', '4.899']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- prefetch_negative_to_all: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_D: 0.4ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.156', '4.388']ns，10  (CARRY4=7 LUT3=1 LUT6=1 MUXF7=1)。
- prefetch_negative_R: 4.565ns，`FD_replica_19/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[27]/R`；逻辑/布线=['0.518', '2.354']ns，0。
- prefetch_negative_MSB: 0.741ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep__0/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.655', '4.443']ns，8  (CARRY4=4 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- csr_data_from: 0.227ns，`linienmodule_csr_dat_w_reg[0]/C` → `linienmodule_autolock_request_lock_storage_full_reg/D`；逻辑/布线=['0.642', '7.157']ns，1  (LUT6=1)。
- csr_data_to: 3.26ns，`FD_replica_18/C` → `linienmodule_csr_dat_w_reg[6]/R`；逻辑/布线=['0.456', '3.737']ns，0。
- scope_predecode_to: 1.314ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.501', '4.230']ns，5  (LUT4=1 LUT5=2 LUT6=2)。
- scope_predecode_from: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.445ns，`red_pitaya_scope/scope_addr_match_reg[14]/C` → `red_pitaya_scope/set_b_filt_bb_reg[14]/CE`；逻辑/布线=['0.675', '4.753']ns，1  (LUT4=1)。
- scope_factor_source_to: 3.109ns，`axi_slave/wr_wdata_reg[23]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.689', '3.003']ns，5  (LUT5=2 LUT6=3)。
- scope_factor_source_from: 5.009ns，`red_pitaya_scope/scope_dec_shift_source_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[1]/D`；逻辑/布线=['0.518', '3.715']ns，0。
- scope_factor_target_to: 2.632ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_dec_shift_reg[0]/CE`；逻辑/布线=['0.773', '4.263']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- scope_factor_to_data: 1.411ns，`red_pitaya_scope/set_dec_shift_reg[4]/C` → `red_pitaya_scope/adc_a_q_dat_reg[9]/D`；逻辑/布线=['0.828', '5.709']ns，3  (LUT6=3)。
- gpio_outputs_to: -0.049ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.416', '5.487']ns，10  (CARRY4=4 LUT3=1 LUT4=2 LUT5=2 LUT6=1)。
- 资源={'lut': 11693, 'ff': 13504, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 438, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=382/374，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.015/0.0/1.5ns。

### R50

代码提交 `ba8871438e4a321f99e74c1334ebed0299e70e02`。

- global_worst: -0.931ns，`DSP48E1_27/CLK` → `DSP48E1_29/PCIN[0]`；逻辑/布线=['4.533', '2.787']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- raw_internal: -0.348ns，`DSP48E1_21/CLK` → `DSP48E1_15/PCIN[0]`；逻辑/布线=['4.533', '2.331']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- raw_entry: 0.092ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_iir_csrstorage10_storage_full_reg[22]/D`；逻辑/布线=['0.456', '7.396']ns，0。
- fast_D: 0.541ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[7]_i_5_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[18]/D`；逻辑/布线=['3.073', '4.223']ns，14  (CARRY4=9 LUT2=1 LUT3=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 1.996ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[36]/R`；逻辑/布线=['0.668', '4.539']ns，1  (LUT3=1)。
- fast_CE: 1.064ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[6]/CE`；逻辑/布线=['0.903', '5.836']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: 0.293ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[30]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.300', '4.338']ns，12  (CARRY4=5 LUT3=1 LUT5=3 LUT6=3)。
- slow_D: 0.594ns，`linienmodule_csr_dat_w_reg[0]_rep__2/C` → `linienmodule_slow_chain_pid_pipelinedpid_reset_storage_full_reg/D`；逻辑/布线=['0.580', '6.918']ns，1  (LUT4=1)。
- slow_R: 2.427ns，`FD_replica_23/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[21]/R`；逻辑/布线=['0.642', '4.452']ns，1  (LUT3=1)。
- slow_CE: 1.818ns，`linienmodule_csr_adr_reg[11]/C` → `linienmodule_slow_chain_pid_pipelinedpid_kp_storage_full_reg[12]/CE`；逻辑/布线=['0.704', '5.214']ns，2  (LUT6=2)。
- slow_all_sequential: 0.594ns，`linienmodule_csr_dat_w_reg[0]_rep__2/C` → `linienmodule_slow_chain_pid_pipelinedpid_reset_storage_full_reg/D`；逻辑/布线=['0.580', '6.918']ns，1  (LUT4=1)。
- slow_outgoing: -0.048ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[20]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['3.103', '4.916']ns，12  (CARRY4=4 LUT3=2 LUT4=1 LUT5=3 LUT6=2)。
- scope_average_control: 3.119ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.704', '4.123']ns，2  (LUT6=2)。
- all_iir_outgoing: -0.931ns，`DSP48E1_27/CLK` → `DSP48E1_29/PCIN[0]`；逻辑/布线=['4.533', '2.787']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_incoming: -0.931ns，`DSP48E1_27/CLK` → `DSP48E1_29/PCIN[0]`；逻辑/布线=['4.533', '2.787']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_PREG_outgoing: -0.931ns，`DSP48E1_27/CLK` → `DSP48E1_29/PCIN[0]`；逻辑/布线=['4.533', '2.787']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_to_external_consumers: -0.921ns，`DSP48E1_37/CLK` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[1]/D`；逻辑/布线=['3.327', '5.166']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT5=3 MUXF7=1)。
- all_iir_D: -0.817ns，`DSP48E1_27/CLK` → `linienmodule_fast_a_iir0_zr_low_q4_reg[0]/D`；逻辑/布线=['4.338', '4.162']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_R: 2.272ns，`FD_replica_35/C` → `linienmodule_fast_a_iir0_csrstorage1_storage_full1_reg[0]/R`；逻辑/布线=['0.518', '4.580']ns，0。
- all_iir_CE: 0.714ns，`linienmodule_csr_adr_reg[2]_rep__2/C` → `linienmodule_fast_a_iir0_csrstorage2_storage_full0_reg[20]/CE`；逻辑/布线=['1.133', '5.741']ns，2  (LUT2=1 LUT6=1)。
- all_iir_RSTP: 2.878ns，`FD_replica/C` → `DSP48E1_13/RSTP`；逻辑/布线=['0.456', '4.250']ns，0。
- same_adc_domain: -0.931ns，`DSP48E1_27/CLK` → `DSP48E1_29/PCIN[0]`；逻辑/布线=['4.533', '2.787']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- scope_adc_control: 1.332ns，`red_pitaya_scope/adc_dly_cnt_reg[29]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.279', '5.059']ns，5  (LUT4=3 LUT5=2)。
- scope_fclk_control: 2.365ns，`red_pitaya_scope/i_bridge/wdata_o_reg[1]/C` → `red_pitaya_scope/set_a_filt_aa_reg[1]/D`；逻辑/布线=['0.456', '6.455']ns，0。
- prefetch_to: 0.298ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_magnitude_reg[27]/D`；逻辑/布线=['2.911', '4.596']ns，12  (CARRY4=7 LUT1=1 LUT2=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.035ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[5]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.363', '5.552']ns，10  (CARRY4=4 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- prefetch_choice_to: 0.673ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[5]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.234', '4.696']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.015ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.395', '5.496']ns，10  (CARRY4=4 LUT3=2 LUT5=1 LUT6=3)。
- prefetch_negative_to_all: 0.349ns，`linienmodule_autolock_pipelinedrobustautolock_csrstorage0_storage_full_reg[0]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[22]/D`；逻辑/布线=['2.915', '4.593']ns，11  (CARRY4=6 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.349ns，`linienmodule_autolock_pipelinedrobustautolock_csrstorage0_storage_full_reg[0]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[22]/D`；逻辑/布线=['2.915', '4.593']ns，11  (CARRY4=6 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 4.436ns，`FD_replica_42/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[7]/R`；逻辑/布线=['0.456', '2.451']ns，0。
- prefetch_negative_MSB: 1.028ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]_rep/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.215', '4.494']ns，6  (CARRY4=2 LUT2=1 LUT5=1 LUT6=1 MUXF7=1)。
- csr_data_from: -0.377ns，`linienmodule_csr_dat_w_reg[3]_rep/C` → `linienmodule_fast_a_iir0_csrstorage2_storage_full0_reg[3]/D`；逻辑/布线=['0.419', '7.416']ns，0。
- csr_data_to: 3.432ns，`FD_replica/C` → `linienmodule_csr_dat_w_reg[2]/R`；逻辑/布线=['0.456', '3.522']ns，0。
- scope_predecode_to: 1.103ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.561', '4.498']ns，5  (LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- scope_predecode_from: 3.69ns，`red_pitaya_scope/scope_addr_match_reg[9]/C` → `red_pitaya_scope/set_a_filt_aa_reg[7]/CE`；逻辑/布线=['0.801', '4.423']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.69ns，`red_pitaya_scope/scope_addr_match_reg[9]/C` → `red_pitaya_scope/set_a_filt_aa_reg[7]/CE`；逻辑/布线=['0.801', '4.423']ns，1  (LUT4=1)。
- scope_factor_source_to: 2.962ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[4]/D`；逻辑/布线=['1.523', '3.363']ns，4  (LUT4=2 LUT5=1 LUT6=1)。
- scope_factor_source_from: 4.821ns，`red_pitaya_scope/scope_dec_zero_source_reg/C` → `red_pitaya_scope/set_dec_zero_reg/D`；逻辑/布线=['0.518', '3.918']ns，0。
- scope_factor_target_to: 3.258ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[0]/CE`；逻辑/布线=['0.744', '3.487']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.777ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_a_q_dat_reg[10]/D`；逻辑/布线=['0.828', '5.253']ns，3  (LUT6=3)。
- scope_factor_to_data: 1.777ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_a_q_dat_reg[10]/D`；逻辑/布线=['0.828', '5.253']ns，3  (LUT6=3)。
- gpio_outputs_to: -0.035ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[5]/C` → `linienmodule_gpio_n_o_reg[0]_lopt_replica/D`；逻辑/布线=['2.363', '5.552']ns，10  (CARRY4=4 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- 资源={'lut': 12078, 'ff': 13731, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 442, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=380/368，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=449；route WHS/THS/WPWS=0.023/0.0/1.5ns。

### R51

代码提交 `b6054bb9f4641eebd6631c13a88f5111cc0b6986`。

- global_worst: -0.794ns，`linienmodule_fast_a_iir1_zr_correction_q2_reg[0]/C` → `DSP48E1_47/PCIN[0]`；逻辑/布线=['4.617', '2.769']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- raw_internal: -0.72ns，`DSP48E1_21/CLK` → `DSP48E1_17/PCIN[0]`；逻辑/布线=['4.533', '2.641']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- raw_entry: 0.046ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_iir_csrstorage2_storage_full_reg[6]/D`；逻辑/布线=['0.456', '7.467']ns，0。
- fast_D: 0.232ns，`linienmodule_csr_dat_w_reg[2]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_ki_storage_full_reg[10]/D`；逻辑/布线=['0.456', '7.043']ns，0。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 2.259ns，`linienmodule_mixeralignedpid6_reg/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[12]/R`；逻辑/布线=['0.608', '4.215']ns，1  (LUT3=1)。
- fast_CE: 0.965ns，`linienmodule_csr_adr_reg[1]_rep/C` → `linienmodule_mixeralignedpid_mixeralignedpid_kd_storage_full_reg[2]/CE`；逻辑/布线=['0.934', '5.706']ns，2  (LUT4=1 LUT6=1)。
- fast_outgoing: 0.388ns，`linienmodule_mixeralignedpid_mixeralignedpid_pid_sum_reg[27]/C` → `linienmodule_limit_fast1_x_reg[17]/D`；逻辑/布线=['2.953', '4.531']ns，11  (CARRY4=4 LUT3=1 LUT5=3 LUT6=3)。
- slow_D: 0.104ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[12]/D`；逻辑/布线=['0.456', '7.249']ns，0。
- slow_R: 2.629ns，`linienmodule_slow_chain_pid_valid_s2_reg/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[15]/R`；逻辑/布线=['0.746', '3.918']ns，1  (LUT3=1)。
- slow_CE: 1.047ns，`linienmodule_csr_adr_reg[13]/C` → `linienmodule_slow_chain_pid_pipelinedpid_setpoint_storage_full_reg[11]/CE`；逻辑/布线=['0.766', '5.919']ns，2  (LUT6=2)。
- slow_all_sequential: 0.104ns，`linienmodule_csr_dat_w_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[12]/D`；逻辑/布线=['0.456', '7.249']ns，0。
- slow_outgoing: 0.304ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[19]/C` → `linienmodule_slow_chain_limit_alignedslowlimitcsr_y_reg[3]/D`；逻辑/布线=['3.053', '4.537']ns，11  (CARRY4=5 LUT3=2 LUT4=2 LUT5=2)。
- scope_average_control: 3.2ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/adc_a_q_dat_reg[10]/D`；逻辑/布线=['0.580', '3.983']ns，1  (LUT6=1)。
- all_iir_outgoing: -0.794ns，`linienmodule_fast_a_iir1_zr_correction_q2_reg[0]/C` → `DSP48E1_47/PCIN[0]`；逻辑/布线=['4.617', '2.769']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_incoming: -0.794ns，`linienmodule_fast_a_iir1_zr_correction_q2_reg[0]/C` → `DSP48E1_47/PCIN[0]`；逻辑/布线=['4.617', '2.769']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_PREG_outgoing: -0.728ns，`DSP48E1_43/CLK` → `DSP48E1_47/PCIN[0]`；逻辑/布线=['4.533', '2.695']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_to_external_consumers: -0.727ns，`DSP48E1_27/CLK` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_7/D`；逻辑/布线=['3.329', '4.672']ns，12  (CARRY4=6 LUT2=1 LUT3=1 LUT5=3 MUXF7=1)。
- all_iir_D: -0.694ns，`DSP48E1_27/CLK` → `linienmodule_fast_a_iir0_zr_low_q4_reg[2]/D`；逻辑/布线=['4.338', '3.790']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- all_iir_R: 3.042ns，`FD_replica_9/C` → `linienmodule_fast_a_iir1_a2_reg[8]/R`；逻辑/布线=['0.518', '3.792']ns，0。
- all_iir_CE: 0.539ns，`linienmodule_csr_adr_reg[3]/C` → `linienmodule_fast_b_iir0_csrstorage3_storage_full_reg[2]/CE`；逻辑/布线=['0.930', '6.343']ns，2  (LUT4=1 LUT6=1)。
- all_iir_RSTP: 2.308ns，`FD_replica_33/C` → `DSP48E1_23/RSTP`；逻辑/布线=['0.518', '4.745']ns，0。
- same_adc_domain: -0.794ns，`linienmodule_fast_a_iir1_zr_correction_q2_reg[0]/C` → `DSP48E1_47/PCIN[0]`；逻辑/布线=['4.617', '2.769']ns，3  (DSP48E1=1 LUT3=1 LUT5=1)。
- scope_adc_control: 1.455ns，`red_pitaya_scope/adc_dly_cnt_reg[28]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.319', '4.674']ns，5  (LUT4=3 LUT5=2)。
- scope_fclk_control: 2.241ns，`red_pitaya_scope/i_bridge/wdata_o_reg[0]/C` → `red_pitaya_scope/set_b_filt_bb_reg[0]/D`；逻辑/布线=['0.456', '6.606']ns，0。
- prefetch_to: 0.28ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[0]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[26]/D`；逻辑/布线=['3.007', '4.648']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: -0.168ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]_lopt_replica/D`；逻辑/布线=['2.346', '5.497']ns，10  (CARRY4=4 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- prefetch_choice_to: 0.929ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['2.248', '4.463']ns，9  (CARRY4=4 LUT3=2 LUT4=1 LUT5=2)。
- prefetch_choice_from: -0.168ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]_lopt_replica/D`；逻辑/布线=['2.346', '5.497']ns，10  (CARRY4=4 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- prefetch_negative_to_all: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[0]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.001', '4.648']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[0]_rep__2/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['3.001', '4.648']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 3.649ns，`FD_replica_32/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/R`；逻辑/布线=['0.456', '3.337']ns，0。
- prefetch_negative_MSB: 0.891ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[2]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_current_negative_reg[28]/D`；逻辑/布线=['1.541', '5.467']ns，5  (LUT5=1 LUT6=3 MUXF7=1)。
- csr_data_from: 0.046ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_iir_csrstorage2_storage_full_reg[6]/D`；逻辑/布线=['0.456', '7.467']ns，0。
- csr_data_to: 2.932ns，`bus_clk_bridge/wdata_o_reg[6]/C` → `linienmodule_csr_dat_w_reg[6]_rep__2/D`；逻辑/布线=['0.456', '5.970']ns，0。
- scope_predecode_to: 0.471ns，`axi_slave/rd_do_reg/C` → `red_pitaya_scope/scope_addr_match_reg[0]/R`；逻辑/布线=['1.584', '5.032']ns，5  (LUT3=1 LUT4=1 LUT5=1 LUT6=2)。
- scope_predecode_from: 3.605ns，`red_pitaya_scope/scope_addr_match_reg[16]/C` → `red_pitaya_scope/set_b_filt_pp_reg[7]/CE`；逻辑/布线=['0.774', '4.778']ns，1  (LUT4=1)。
- scope_predecode_to_config: 3.605ns，`red_pitaya_scope/scope_addr_match_reg[16]/C` → `red_pitaya_scope/set_b_filt_pp_reg[7]/CE`；逻辑/布线=['0.774', '4.778']ns，1  (LUT4=1)。
- scope_factor_source_to: 2.819ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[3]/D`；逻辑/布线=['1.320', '3.702']ns，4  (LUT4=1 LUT5=2 LUT6=1)。
- scope_factor_source_from: 5.29ns，`red_pitaya_scope/scope_dec_zero_source_reg/C` → `red_pitaya_scope/set_dec_zero_reg/D`；逻辑/布线=['0.456', '3.561']ns，0。
- scope_factor_target_to: 3.282ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_dec_shift_reg[1]/CE`；逻辑/布线=['0.718', '3.664']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.234ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_a_q_dat_reg[11]/D`；逻辑/布线=['0.828', '5.706']ns，3  (LUT6=3)。
- scope_factor_to_data: 1.234ns，`red_pitaya_scope/set_dec_shift_reg[3]/C` → `red_pitaya_scope/adc_a_q_dat_reg[11]/D`；逻辑/布线=['0.828', '5.706']ns，3  (LUT6=3)。
- gpio_outputs_to: -0.168ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]_lopt_replica/D`；逻辑/布线=['2.346', '5.497']ns，10  (CARRY4=4 LUT3=1 LUT4=1 LUT5=1 LUT6=3)。
- 资源={'lut': 12088, 'ff': 13701, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 442, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=380/368，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=447；route WHS/THS/WPWS=0.023/0.0/1.5ns。

### R52

代码提交 `7eb4ed96c9155075b14d88b9e0de2e8d9fcdf61d`。

- global_worst: -0.222ns，`linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`；逻辑/布线=['3.180', '4.579']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- raw_internal: 0.203ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.848', '1.345']ns，2  (DSP48E1=1 LUT6=1)。
- raw_entry: 0.299ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage10_storage_full_reg[14]/D`；逻辑/布线=['0.518', '6.955']ns，0。
- fast_D: 0.538ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[4]/D`；逻辑/布线=['3.087', '3.853']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: -0.071ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[13]/R`；逻辑/布线=['3.320', '3.807']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- fast_CE: 1.436ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[2]/CE`；逻辑/布线=['0.842', '5.464']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: -0.071ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[13]/R`；逻辑/布线=['3.320', '3.807']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- slow_D: 1.227ns，`linienmodule_csr_dat_w_reg[5]_rep__0/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[5]/D`；逻辑/布线=['0.456', '6.045']ns，0。
- slow_R: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- slow_CE: 1.576ns，`linienmodule_csr_adr_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.766', '5.348']ns，2  (LUT2=1 LUT6=1)。
- slow_all_sequential: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_outgoing: 0.213ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[14]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.056', '4.663']ns，13  (CARRY4=6 LUT5=1 LUT6=6)。
- scope_average_control: 3.59ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.704', '3.689']ns，2  (LUT6=2)。
- frontend_a_output: -0.222ns，`linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`；逻辑/布线=['3.180', '4.579']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.107ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_fast_b_paralleltaplimitcsr0_y_reg[16]/D`；逻辑/布线=['3.309', '4.443']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_outgoing: -0.222ns，`linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`；逻辑/布线=['3.180', '4.579']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_incoming: -0.1ns，`linienmodule_fast_b_iir0_y0_reg[8]/C` → `DSP48E1_49/PCIN[0]`；逻辑/布线=['4.369', '2.057']ns，1  (DSP48E1=1)。
- all_iir_PREG_outgoing: 0.508ns，`DSP48E1_35/CLK` → `linienmodule_fast_a_iir1_z_high0/CEB2`；逻辑/布线=['4.092', '2.655']ns，3  (DSP48E1=2 LUT6=1)。
- all_iir_to_external_consumers: -0.222ns，`linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`；逻辑/布线=['3.180', '4.579']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_D: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- all_iir_R: 2.345ns，`FD_replica_26/C` → `linienmodule_fast_b_iir0_zr_low_q2_reg[4]/R`；逻辑/布线=['0.456', '4.468']ns，0。
- all_iir_CE: 0.159ns，`linienmodule_fast_a_iir0_z_low0/CLK` → `linienmodule_fast_a_iir0_y0_reg[6]/CE`；逻辑/布线=['5.848', '1.606']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_CEB2: 0.097ns，`linienmodule_fast_a_iir0_z_low1/CLK` → `linienmodule_fast_a_iir0_z_high1/CEB2`；逻辑/布线=['5.848', '1.446']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_RSTP: 3.102ns，`FD_replica_64/C` → `DSP48E1_25/RSTP`；逻辑/布线=['0.518', '4.023']ns，0。
- same_adc_domain: -0.222ns，`linienmodule_fast_a_iir0_y0_reg[19]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp/D`；逻辑/布线=['3.180', '4.579']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- scope_adc_control: 1.583ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.023', '5.094']ns，2  (LUT3=1 LUT6=1)。
- scope_fclk_control: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- prefetch_to: 0.256ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[13]/D`；逻辑/布线=['2.544', '4.971']ns，9  (CARRY4=4 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_choice_to: 1.451ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['1.756', '4.597']ns，5  (CARRY4=2 LUT3=1 LUT5=1 LUT6=1)。
- prefetch_choice_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_negative_to_all: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 3.694ns，`FD_replica_28/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[13]/R`；逻辑/布线=['0.518', '3.142']ns，0。
- prefetch_negative_MSB: 1.136ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.444', '4.243']ns，9  (CARRY4=4 LUT5=1 LUT6=2 MUXF7=1 MUXF8=1)。
- csr_data_from: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- csr_data_to: 3.91ns，`bus_clk_bridge/wdata_o_reg[2]/C` → `linienmodule_csr_dat_w_reg[2]_rep/D`；逻辑/布线=['0.518', '4.976']ns，0。
- scope_predecode_to: 0.96ns，`axi_slave/wr_awaddr_reg[18]/C` → `red_pitaya_scope/scope_addr_match_reg[1]/R`；逻辑/布线=['1.495', '4.663']ns，5  (LUT3=2 LUT4=1 LUT6=2)。
- scope_predecode_from: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_predecode_to_config: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_factor_source_to: 2.833ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.266', '3.505']ns，4  (LUT4=2 LUT5=1 LUT6=1)。
- scope_factor_source_from: 5.168ns，`red_pitaya_scope/scope_dec_shift_source_reg[2]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/D`；逻辑/布线=['0.456', '3.792']ns，0。
- scope_factor_target_to: 3.216ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/CE`；逻辑/布线=['0.743', '3.577']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- scope_factor_to_data: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- gpio_outputs_to: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- 资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=379/360，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R53

代码提交 `e25e8f0c6af4f694533e3d25f5626ae9e3ec7b18`。

- global_worst: -0.014ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic17_reg[16]/D`；逻辑/布线=['4.135', '3.846']ns，13  (CARRY4=8 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- raw_internal: 0.203ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.848', '1.345']ns，2  (DSP48E1=1 LUT6=1)。
- raw_entry: 0.299ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage10_storage_full_reg[14]/D`；逻辑/布线=['0.518', '6.955']ns，0。
- fast_D: 0.205ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[13]/D`；逻辑/布线=['3.087', '4.188']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- fast_CE: 1.436ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[2]/CE`；逻辑/布线=['0.842', '5.464']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- slow_D: 1.227ns，`linienmodule_csr_dat_w_reg[5]_rep__0/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[5]/D`；逻辑/布线=['0.456', '6.045']ns，0。
- slow_R: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- slow_CE: 1.576ns，`linienmodule_csr_adr_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.766', '5.348']ns，2  (LUT2=1 LUT6=1)。
- slow_all_sequential: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_outgoing: 0.213ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[14]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.056', '4.663']ns，13  (CARRY4=6 LUT5=1 LUT6=6)。
- scope_average_control: 3.59ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.704', '3.689']ns，2  (LUT6=2)。
- frontend_a_output: 0.001ns，`linienmodule_fast_a_iir0_y2_reg[14]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.156', '4.477']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_outgoing: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_incoming: 0.001ns，`linienmodule_fast_b_iir0_y0_reg[14]/C` → `DSP48E1_49/PCIN[0]`；逻辑/布线=['4.369', '1.956']ns，1  (DSP48E1=1)。
- all_iir_PREG_outgoing: 0.508ns，`DSP48E1_35/CLK` → `linienmodule_fast_a_iir1_z_high0/CEB2`；逻辑/布线=['4.092', '2.655']ns，3  (DSP48E1=2 LUT6=1)。
- all_iir_to_external_consumers: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_D: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- all_iir_R: 2.345ns，`FD_replica_26/C` → `linienmodule_fast_b_iir0_zr_low_q2_reg[4]/R`；逻辑/布线=['0.456', '4.468']ns，0。
- all_iir_CE: 0.147ns，`linienmodule_fast_a_iir0_z_low0/CLK` → `linienmodule_fast_a_iir0_y0_reg[6]/CE`；逻辑/布线=['5.848', '1.618']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_CEB2: 0.097ns，`linienmodule_fast_a_iir0_z_low1/CLK` → `linienmodule_fast_a_iir0_z_high1/CEB2`；逻辑/布线=['5.848', '1.446']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_RSTP: 3.102ns，`FD_replica_64/C` → `DSP48E1_25/RSTP`；逻辑/布线=['0.518', '4.023']ns，0。
- same_adc_domain: -0.014ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic17_reg[16]/D`；逻辑/布线=['4.135', '3.846']ns，13  (CARRY4=8 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- scope_adc_control: 1.583ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.023', '5.094']ns，2  (LUT3=1 LUT6=1)。
- scope_fclk_control: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- prefetch_to: 0.256ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[13]/D`；逻辑/布线=['2.544', '4.971']ns，9  (CARRY4=4 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_choice_to: 1.451ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['1.756', '4.597']ns，5  (CARRY4=2 LUT3=1 LUT5=1 LUT6=1)。
- prefetch_choice_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_negative_to_all: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 3.694ns，`FD_replica_28/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[13]/R`；逻辑/布线=['0.518', '3.142']ns，0。
- prefetch_negative_MSB: 1.136ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.444', '4.243']ns，9  (CARRY4=4 LUT5=1 LUT6=2 MUXF7=1 MUXF8=1)。
- csr_data_from: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- csr_data_to: 3.91ns，`bus_clk_bridge/wdata_o_reg[2]/C` → `linienmodule_csr_dat_w_reg[2]_rep/D`；逻辑/布线=['0.518', '4.976']ns，0。
- scope_predecode_to: 0.96ns，`axi_slave/wr_awaddr_reg[18]/C` → `red_pitaya_scope/scope_addr_match_reg[1]/R`；逻辑/布线=['1.495', '4.663']ns，5  (LUT3=2 LUT4=1 LUT6=2)。
- scope_predecode_from: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_predecode_to_config: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_factor_source_to: 2.833ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.266', '3.505']ns，4  (LUT4=2 LUT5=1 LUT6=1)。
- scope_factor_source_from: 5.168ns，`red_pitaya_scope/scope_dec_shift_source_reg[2]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/D`；逻辑/布线=['0.456', '3.792']ns，0。
- scope_factor_target_to: 3.216ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/CE`；逻辑/布线=['0.743', '3.577']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- scope_factor_to_data: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- gpio_outputs_to: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- 资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=379/360，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R54

代码提交 `34717f912bfd1f4e80db443a2256cbe21671c172`。

- global_worst: -0.014ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic17_reg[16]/D`；逻辑/布线=['4.135', '3.846']ns，13  (CARRY4=8 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- raw_internal: 0.203ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.848', '1.345']ns，2  (DSP48E1=1 LUT6=1)。
- raw_entry: 0.299ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage10_storage_full_reg[14]/D`；逻辑/布线=['0.518', '6.955']ns，0。
- fast_D: 0.205ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[13]/D`；逻辑/布线=['3.087', '4.188']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- fast_CE: 1.436ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[2]/CE`；逻辑/布线=['0.842', '5.464']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- slow_D: 1.227ns，`linienmodule_csr_dat_w_reg[5]_rep__0/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[5]/D`；逻辑/布线=['0.456', '6.045']ns，0。
- slow_R: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- slow_CE: 1.576ns，`linienmodule_csr_adr_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.766', '5.348']ns，2  (LUT2=1 LUT6=1)。
- slow_all_sequential: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_outgoing: 0.213ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[14]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.056', '4.663']ns，13  (CARRY4=6 LUT5=1 LUT6=6)。
- scope_average_control: 3.59ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.704', '3.689']ns，2  (LUT6=2)。
- frontend_a_output: 0.001ns，`linienmodule_fast_a_iir0_y2_reg[14]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.156', '4.477']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_outgoing: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_incoming: 0.001ns，`linienmodule_fast_b_iir0_y0_reg[14]/C` → `DSP48E1_49/PCIN[0]`；逻辑/布线=['4.369', '1.956']ns，1  (DSP48E1=1)。
- all_iir_PREG_outgoing: 0.508ns，`DSP48E1_35/CLK` → `linienmodule_fast_a_iir1_z_high0/CEB2`；逻辑/布线=['4.092', '2.655']ns，3  (DSP48E1=2 LUT6=1)。
- all_iir_to_external_consumers: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_D: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- all_iir_R: 2.345ns，`FD_replica_26/C` → `linienmodule_fast_b_iir0_zr_low_q2_reg[4]/R`；逻辑/布线=['0.456', '4.468']ns，0。
- all_iir_CE: 0.147ns，`linienmodule_fast_a_iir0_z_low0/CLK` → `linienmodule_fast_a_iir0_y0_reg[6]/CE`；逻辑/布线=['5.848', '1.618']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_CEB2: 0.097ns，`linienmodule_fast_a_iir0_z_low1/CLK` → `linienmodule_fast_a_iir0_z_high1/CEB2`；逻辑/布线=['5.848', '1.446']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_RSTP: 3.102ns，`FD_replica_64/C` → `DSP48E1_25/RSTP`；逻辑/布线=['0.518', '4.023']ns，0。
- same_adc_domain: -0.014ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic17_reg[16]/D`；逻辑/布线=['4.135', '3.846']ns，13  (CARRY4=8 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- scope_adc_control: 1.583ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.023', '5.094']ns，2  (LUT3=1 LUT6=1)。
- scope_fclk_control: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- prefetch_to: 0.256ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[13]/D`；逻辑/布线=['2.544', '4.971']ns，9  (CARRY4=4 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_choice_to: 1.451ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['1.756', '4.597']ns，5  (CARRY4=2 LUT3=1 LUT5=1 LUT6=1)。
- prefetch_choice_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_negative_to_all: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 3.694ns，`FD_replica_28/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[13]/R`；逻辑/布线=['0.518', '3.142']ns，0。
- prefetch_negative_MSB: 1.136ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.444', '4.243']ns，9  (CARRY4=4 LUT5=1 LUT6=2 MUXF7=1 MUXF8=1)。
- csr_data_from: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- csr_data_to: 3.91ns，`bus_clk_bridge/wdata_o_reg[2]/C` → `linienmodule_csr_dat_w_reg[2]_rep/D`；逻辑/布线=['0.518', '4.976']ns，0。
- scope_predecode_to: 0.96ns，`axi_slave/wr_awaddr_reg[18]/C` → `red_pitaya_scope/scope_addr_match_reg[1]/R`；逻辑/布线=['1.495', '4.663']ns，5  (LUT3=2 LUT4=1 LUT6=2)。
- scope_predecode_from: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_predecode_to_config: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_factor_source_to: 2.833ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.266', '3.505']ns，4  (LUT4=2 LUT5=1 LUT6=1)。
- scope_factor_source_from: 5.168ns，`red_pitaya_scope/scope_dec_shift_source_reg[2]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/D`；逻辑/布线=['0.456', '3.792']ns，0。
- scope_factor_target_to: 3.216ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/CE`；逻辑/布线=['0.743', '3.577']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- scope_factor_to_data: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- gpio_outputs_to: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- 资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=379/360，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.014/0.0/1.5ns。

### R55

代码提交 `8e523ca9c17e9e33780509436d079eb768839ae9`。

- global_worst: -1.349ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic1_reg[15]/D`；逻辑/布线=['3.820', '5.436']ns，10  (CARRY4=5 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- raw_internal: 0.203ns，`linienmodule_raw_acquisition_iir_z_low/CLK` → `linienmodule_raw_acquisition_iir_z_high/CEB2`；逻辑/布线=['5.848', '1.345']ns，2  (DSP48E1=1 LUT6=1)。
- raw_entry: 0.299ns，`linienmodule_csr_dat_w_reg[6]_rep__0/C` → `linienmodule_raw_acquisition_iir_csrstorage10_storage_full_reg[14]/D`；逻辑/布线=['0.518', '6.955']ns，0。
- fast_D: 0.205ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[13]/D`；逻辑/布线=['3.087', '4.188']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT5=1 LUT6=1)。
- fast_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- fast_R: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- fast_CE: 1.436ns，`linienmodule_csr_adr_reg[8]/C` → `linienmodule_mixeralignedpid_mixeralignedpid_setpoint_storage_full_reg[2]/CE`；逻辑/布线=['0.842', '5.464']ns，2  (LUT2=1 LUT6=1)。
- fast_outgoing: 0.032ns，`linienmodule_mixeralignedpid_mixeralignedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_mixeralignedpid_mixeralignedpid_int_reg_reg[16]/R`；逻辑/布线=['3.320', '3.799']ns，14  (CARRY4=10 LUT2=1 LUT4=1 LUT6=2)。
- slow_D: 1.227ns，`linienmodule_csr_dat_w_reg[5]_rep__0/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[5]/D`；逻辑/布线=['0.456', '6.045']ns，0。
- slow_R: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_S: NO_MAPPED_PIN；本次映射没有该独立引脚，不能写成此项时序PASS。
- slow_CE: 1.576ns，`linienmodule_csr_adr_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_kp_storage_full_reg[0]/CE`；逻辑/布线=['0.766', '5.348']ns，2  (LUT2=1 LUT6=1)。
- slow_all_sequential: 0.701ns，`linienmodule_slow_chain_pid_pipelinedpid_int_reg[3]_i_6_psdsp/C` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[27]/R`；逻辑/布线=['2.533', '4.148']ns，11  (CARRY4=7 LUT2=1 LUT5=1 LUT6=2)。
- slow_outgoing: 0.213ns，`linienmodule_slow_chain_pid_pipelinedpid_pid_sum_reg[14]/C` → `linienmodule_limit_fast2_x_reg[17]/D`；逻辑/布线=['3.056', '4.663']ns，13  (CARRY4=6 LUT5=1 LUT6=6)。
- scope_average_control: 3.59ns，`red_pitaya_scope/set_avg_en_reg/C` → `red_pitaya_scope/i_bridge/dst_rdata_hold_reg[0]/D`；逻辑/布线=['0.704', '3.689']ns，2  (LUT6=2)。
- frontend_a_output: 0.001ns，`linienmodule_fast_a_iir0_y2_reg[14]/C` → `linienmodule_fast_a_paralleltaplimitcsr0_y_reg[6]/D`；逻辑/布线=['3.156', '4.477']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- frontend_b_output: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_outgoing: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_incoming: 0.001ns，`linienmodule_fast_b_iir0_y0_reg[14]/C` → `DSP48E1_49/PCIN[0]`；逻辑/布线=['4.369', '1.956']ns，1  (DSP48E1=1)。
- all_iir_PREG_outgoing: 0.508ns，`DSP48E1_35/CLK` → `linienmodule_fast_a_iir1_z_high0/CEB2`；逻辑/布线=['4.092', '2.655']ns，3  (DSP48E1=2 LUT6=1)。
- all_iir_to_external_consumers: -0.008ns，`linienmodule_fast_b_iir0_y2_reg[15]/C` → `linienmodule_registerederrormixer_y[36]_i_14_psdsp_41/D`；逻辑/布线=['3.312', '4.287']ns，9  (CARRY4=4 LUT2=1 LUT4=1 LUT5=2 MUXF7=1)。
- all_iir_D: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- all_iir_R: 2.345ns，`FD_replica_26/C` → `linienmodule_fast_b_iir0_zr_low_q2_reg[4]/R`；逻辑/布线=['0.456', '4.468']ns，0。
- all_iir_CE: 0.147ns，`linienmodule_fast_a_iir0_z_low0/CLK` → `linienmodule_fast_a_iir0_y0_reg[6]/CE`；逻辑/布线=['5.848', '1.618']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_CEB2: 0.097ns，`linienmodule_fast_a_iir0_z_low1/CLK` → `linienmodule_fast_a_iir0_z_high1/CEB2`；逻辑/布线=['5.848', '1.446']ns，2  (DSP48E1=1 LUT6=1)。
- all_iir_RSTP: 3.102ns，`FD_replica_64/C` → `DSP48E1_25/RSTP`；逻辑/布线=['0.518', '4.023']ns，0。
- same_adc_domain: -1.349ns，`linienmodule_fast_b_multiplier_storage_full_reg[1]/C` → `linienmodule_fast_b_cordic1_reg[15]/D`；逻辑/布线=['3.820', '5.436']ns，10  (CARRY4=5 LUT2=1 LUT4=2 LUT5=1 LUT6=1)。
- scope_adc_control: 1.583ns，`red_pitaya_scope/i_bridge/dst_do_reg/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['1.023', '5.094']ns，2  (LUT3=1 LUT6=1)。
- scope_fclk_control: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- prefetch_to: 0.256ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_magnitude_reg[13]/D`；逻辑/布线=['2.544', '4.971']ns，9  (CARRY4=4 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_choice_to: 1.451ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[0]/D`；逻辑/布线=['1.756', '4.597']ns，5  (CARRY4=2 LUT3=1 LUT5=1 LUT6=1)。
- prefetch_choice_from: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- prefetch_negative_to_all: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_D: 0.574ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[26]/D`；逻辑/布线=['2.996', '4.297']ns，12  (CARRY4=7 LUT1=1 LUT3=1 LUT6=2 MUXF7=1)。
- prefetch_negative_R: 3.694ns，`FD_replica_28/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_zero_negative_reg[13]/R`；逻辑/布线=['0.518', '3.142']ns，0。
- prefetch_negative_MSB: 1.136ns，`linienmodule_autolock_pipelinedrobustautolock_current_instruction_idx_reg[1]_rep__3/C` → `linienmodule_autolock_pipelinedrobustautolock_prefetch_next_negative_reg[28]/D`；逻辑/布线=['2.444', '4.243']ns，9  (CARRY4=4 LUT5=1 LUT6=2 MUXF7=1 MUXF8=1)。
- csr_data_from: 0.115ns，`linienmodule_csr_dat_w_reg[6]_rep__2/C` → `linienmodule_fast_b_iir1_csrstorage9_storage_full_reg[6]/D`；逻辑/布线=['0.419', '7.126']ns，0。
- csr_data_to: 3.91ns，`bus_clk_bridge/wdata_o_reg[2]/C` → `linienmodule_csr_dat_w_reg[2]_rep/D`；逻辑/布线=['0.518', '4.976']ns，0。
- scope_predecode_to: 0.96ns，`axi_slave/wr_awaddr_reg[18]/C` → `red_pitaya_scope/scope_addr_match_reg[1]/R`；逻辑/布线=['1.495', '4.663']ns，5  (LUT3=2 LUT4=1 LUT6=2)。
- scope_predecode_from: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_predecode_to_config: 2.256ns，`red_pitaya_scope/scope_addr_match_reg[1]/C` → `red_pitaya_scope/set_trig_src_reg[0]/CE`；逻辑/布线=['0.580', '6.303']ns，1  (LUT6=1)。
- scope_factor_source_to: 2.833ns，`axi_slave/wr_wdata_reg[31]/C` → `red_pitaya_scope/scope_dec_shift_source_reg[0]/D`；逻辑/布线=['1.266', '3.505']ns，4  (LUT4=2 LUT5=1 LUT6=1)。
- scope_factor_source_from: 5.168ns，`red_pitaya_scope/scope_dec_shift_source_reg[2]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/D`；逻辑/布线=['0.456', '3.792']ns，0。
- scope_factor_target_to: 3.216ns，`red_pitaya_scope/i_bridge/dst_sync_reg[1]/C` → `red_pitaya_scope/set_dec_shift_reg[2]/CE`；逻辑/布线=['0.743', '3.577']ns，1  (LUT4=1)。
- scope_factor_target_from: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- scope_factor_to_data: 1.583ns，`red_pitaya_scope/set_dec_shift_reg[1]/C` → `red_pitaya_scope/adc_b_q_dat_reg[7]/D`；逻辑/布线=['0.766', '5.301']ns，2  (LUT6=2)。
- gpio_outputs_to: 0.332ns，`linienmodule_autolock_pipelinedrobustautolock_prefetch_choice_reg[1]/C` → `linienmodule_gpio_n_o_reg[5]/D`；逻辑/布线=['2.004', '5.511']ns，7  (CARRY4=2 LUT4=1 LUT5=2 LUT6=2)。
- 资源={'lut': 11782, 'ff': 13512, 'dsp': 94, 'bram': 35, 'bufg': 6}；CDC={'CDC-1': 449, 'CDC-2': 14, 'CDC-3': 4, 'CDC-4': 1, 'CDC-10': 1, 'CDC-13': 1, 'CDC-15': 380}，相对R4a严格名称差集新增/移除=379/360，物理安全NOT_PROVEN。
- 覆盖={'no_clock': 1, 'unconstrained_internal_endpoints': 2, 'no_input_delay': 44, 'no_output_delay': 46}；DRC=405；route WHS/THS/WPWS=0.014/0.0/1.5ns。

## 小模块预验证单独记录

R45：小模块原生PASS，尚不是本轮整机功能/综合/route/STA通过。config0与config2 order1/2/5分别17940/17964/18036拍，config2每阶额外3000X/Z；未启用重定时的30份生成Verilog与冻结原版逐字节相同。详见JSON独立small_module_prechecks键；未把该预验证WNS/TNS填入时序表。


优先处理**功能有效候选**的实际最差路径，分别审查IIR内部DSP寄存器位置、FastChain/CORDIC算术、autolock控制、CSR译码与扇出。R23/R24不可用于选择有效最佳版本。当前总反馈延迟已使用用户0–16ns优选范围，不继续无评估叠加流水线。任何候选需先数学等价、真实Root CSR位宽/有符号类型、独立冻结参考与整数oracle，再同一8ns约束下实际route；失败版本保留而不合并。

CDC计数减少不证明安全；需对bundled-data握手逐项核查数据保持窗口、复位、同步控制、最大延迟/最小延迟与物理布线。DNA no_clock/内部覆盖、44输入/46输出外部时序与DRC仍需单独关闭。没有新增false path/multicycle/clock group或放宽周期掩盖问题。

R19/R20出现CDC-13=1：scope bridge sys_wr→SRL16E adc_rval[1]_srl2___iir_z0_cohort1_reg_r/D，实际SRL D由LUT4(sys_rd,dst_do,dst_sync[1],sys_wr)驱动，后接FDRE。属于需要审查的综合共享/重构路径，不能从包含IIR名字推断来源，也不能默认豁免。R19快速PID/S物理引脚不存在，原报告单独备注NO_MAPPED_PIN；R20重新出现/S=-.237ns，不能引用R19的局部正裕量替代当前结果。

## 可重复运行与保护

在对应候选工作树使用锁定Python3.10/Migen0.9.2/MiSoC0.13/Vivado2020.1环境，执行tools/run_gateware_trial.py --label 唯一名称 --stages functional,generate,synth,route。每次创建全新目录；PS项目副本、CSR map、生成RTL/XDC、输入SHA、stdout/stderr/退出码都隔离保存；构建前后逐文件SHA一致。只读audit打开routed.dcp，并核对分析前后DCP SHA不变；审计按实际P/PCOUT网确认DSP归属，避免Migen重命名漏掉内部路径。没有清理或重置原用户工作树。

输入SHA256与全部命令/标记见配套JSON；各轮小体积源码/报告/向量/原生日志ZIP经testzip与SHA核验。DCP保留本机独立trial中，不混入源码Git大档。回退选择对应原分支/工作树，无需反向覆盖用户工程。

## GitHub已核验备份

- R21: `e4f6f0dcd9cd3e0342e8ecca1630774d27787a26`，[opt/r21-parallel-tap-limit-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r21-parallel-tap-limit-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R22: `ec028e3404aaf7915b7a0ff7b8159bc67f49c042`，[opt/r22-balanced-tap-preg-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r22-balanced-tap-preg-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R23: `4e64a0cad46c3ea898a5aa5e13616539fb6c178b`，[opt/r23-same-edge-common-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r23-same-edge-common-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R25: `de7acf4637594b7b63817f3140459c11913a77fa`，[opt/r25-unsigned-preoffset-fix-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r25-unsigned-preoffset-fix-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R26: `5d9af0a3065d13f531966ffa901cd0b286975a29`，[opt/r26-scope-late-average-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r26-scope-late-average-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R27: `e9c9fd52c9e7b9b29452a9c7af68e46b22be681a`，[opt/r27-fast-output-csa-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r27-fast-output-csa-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R28: `3f369c694dff08e5c017bea3dc33835fb6c20a76`，[opt/r28-pid-output-bitdecode-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r28-pid-output-bitdecode-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R29: `59030891e59c58082af2907aec9408219e5f0b5d`，[opt/r29-postroute-fanout-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r29-postroute-fanout-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R30: `8773ff8ef4cc53cb8a484223fcb3a3571c000b7a`，[opt/r30-autolock-late-threshold-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r30-autolock-late-threshold-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R31: `f5fee91c620c9bd14e339ad7c89d17f8bbd79f9a`，[opt/r31-autolock-grouped-threshold-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r31-autolock-grouped-threshold-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R32: `cb3eea923c78364280667d7bd4d41da43d7523d4`，[opt/r32-place-explore-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r32-place-explore-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R33: `f31297fd869f4c63a9557af1ac4d9e4d757f9cd5`，[opt/r33-autolock-onehot-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r33-autolock-onehot-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R34: `7d0c84cfb8ddaeb5e0ed150e42676a178d4fc937`，[opt/r34-gpio-status-pipeline-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r34-gpio-status-pipeline-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R35: `69af487af3f57b897576e3756e3ae59086ea8ea0`，[opt/r35-index-driver-replication-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r35-index-driver-replication-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R36: `d7e570323f4b911ff5bda71f61acd6bfdb56fae0`，[opt/r36-instruction-prefetch-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r36-instruction-prefetch-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R37: `0065135bc3abd45c6a3ba53198e49a1796f6b504`，[opt/r37-tap-value-optimization-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r37-tap-value-optimization-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R38: `3fef5e4d774a6ba406c3c550025a1fddba5df6b9`，[opt/r38-common-alias-buffer-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r38-common-alias-buffer-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R39: `fd5cc77048d12fe2d469869ca88a847bf133528f`，[opt/r39-scope-enable-remap-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r39-scope-enable-remap-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R40: `ed6de0dce7bc348eb6f6edbc84de277541c0f9c8`，[opt/r40-csr-data-distribution-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r40-csr-data-distribution-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R41: `a8f93bd4e97a66c899e020833afbcf82f7bdadb6`，[opt/r41-scope-source-predecode-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r41-scope-source-predecode-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R42: `758f828fa6de355ddf099e61668d158e5f3e7673`，[opt/r42-iir-feedback-fabric-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r42-iir-feedback-fabric-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R43: `2dd47c82012b2e4809ee873b1cf26e7738aa890c`，[opt/r43-scope-csr-distribution-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r43-scope-csr-distribution-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R44: `5227695b6c9972384982a73a980e67c219359e1f`，[opt/r44-scope-factor-cache-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r44-scope-factor-cache-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R46: `b7b94f3a7d6fefcdf6688941229790688a20a8e2`，[opt/r46-prefetch-negative-fold-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r46-prefetch-negative-fold-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R47: `47bcaf30d14542c3668c22277aed77d23259b3e7`，[opt/r47-iir-enable-placement-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r47-iir-enable-placement-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R48: `76dd4527c922695d42632dc1dd2789f3e5fe2d61`，[opt/r48-routed-pin-refine-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r48-routed-pin-refine-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R49: `7e46d4401f88cd7967add74b1a2e764b270a149b`，[opt/r49-critical-pin-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r49-critical-pin-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R50: `4023a3004093900a1e0c099018cc052986d144c9`，[opt/r50-iir-output-edge-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r50-iir-output-edge-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R51: `813c327c8046c01efbf9062527161fce716e7c0a`，[opt/r51-iir-column-placement-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r51-iir-column-placement-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R52: `e5cdf3315c486100c23c67b150c8469b45b8b4bf`，[opt/r52-c48-carry-fold-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r52-c48-carry-fold-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R53: `5886146b6d2edf19f4a817a876ad939620585e2d`，[opt/r53-carry-fold-postroute-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r53-carry-fold-postroute-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R54: `8df83e372622ee1192fde6c26ef54455c29397b3`，[opt/r54-carry-fold-pin-refine-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r54-carry-fold-pin-refine-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
- R55: `1679d3f53486aa36acf4b0cfb205703bb6e86fac`，[opt/r55-cordic-local-route-20261111](https://github.com/tddeufdthfww-stack/linien/tree/opt/r55-cordic-local-route-20261111)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
