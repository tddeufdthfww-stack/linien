# Z7020 前端与IIR优化：R17起的实际结果

2026-11-10。目标始终是STEMlab125-14 PRO Z7020 Gen2。所有版本均未最终签核，不能当作已验证可上板或激光闭环版本。R2b/R4a/原用户工程及R16源码、提交和原工作树状态已逐文件核验未改变。各轮独立Git工作树；未直接合并保护基线；没有生成/部署bitstream。

## 进度与轮数估计

已经找到有效的分解方法：混合器DSP乘积寄存器与事务对齐显著缩短前端路径，精确C48乘加消除部分宽进位链，保留完整50位结果、阶数与每拍吞吐。仍有多个独立瓶颈，所以不能给出有依据的最晚完成轮数，也不能把WNS改善比例当成项目完成百分比。

本次开始时估计乐观3–4轮解决主要内部125MHz时序、约5–6轮连同CDC/I/O等签核；这只是乐观估计，R23暴露真实顶层CSR类型验证缺口后，不能继续当作排期承诺。8–12轮同样只是预算，并非最晚保证。物理跨域安全、外部I/O时序和板端实测可能需要额外资料；激光闭环调试不包含在这些轮数中。不得把功能无效版本的WNS改善计为有效成果。

## 综合与布线

| 版本 | 综合 WNS/TNS ns | 实际布线 WNS/TNS ns | Setup违规端点 | 判定 |
|---|---:|---:|---:|---|
| R2b | −6.094 / −4563.029 | −5.605 / −10473.525 | 6813 | 基线，STA FAIL |
| R16 | −3.911 / −3598.924 | −4.068 / −5780.718 | 5437 | 隔离候选，STA FAIL |
| R17 | -2.836 / -3068.768 | -2.8 / -4213.79 | 4523 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R18 | -1.818 / -592.081 | -2.326 / -1448.239 | 1955 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R19 | -1.8 / -421.523 | -1.852 / -799.692 | 1205 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R20 | -1.811 / -391.486 | -1.838 / -600.003 | 1287 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R21 | -2.412 / -414.722 | -2.104 / -670.303 | 1198 | REJECTED_NOT_MERGED，STA FAIL |
| R22 | -1.732 / -386.595 | -1.5 / -211.865 | 586 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R23 | -1.376 / -261.485 | -0.706 / -297.767 | 1874 | REJECTED_NOT_MERGED，生产功能FAIL，诊断数据不可作成果 |
| R24 | 已调用后中止，无WNS | NOT RUN | — | 继承生产功能缺陷，拒绝采用 |
| R25 | -1.528 / -273.525 | -0.981 / -174.051 | 643 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R26 | -1.908 / -316.14 | -0.91 / -190.722 | 751 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R27 | -1.908 / -301.989 | -1.042 / -229.718 | 795 | REJECTED_NOT_MERGED，STA FAIL |
| R28 | -1.908 / -307.63 | -0.788 / -99.471 | 566 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R29 | -1.908 / -307.63（复用R28） | -0.617 / -91.147 | 545 | CANDIDATE_NOT_SIGNED_OFF，STA FAIL |
| R30 | -1.908 / -327.676 | -1.204 / -229.464 | 986 | REJECTED_NOT_MERGED，STA FAIL |

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

- R31：仅将R30的32路完全并行精炼成8组×4项早选择+比较+晚选1位。idx=8q+r，每组选四项T[8q+r]后f(S,T)，最后选择组r，数学函数不变；数据比较扇出减至约1/4。完整Case default单独f(S,T31)保持原Array未知索引默认语义。原R30真实32CSR夹具blob不变、相同原生14/25/29位与X/Z专项PASS；完整流程以本轮命令/指标为准，不增加任何反馈或robust周期。

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
- R30: `76338b5c98ba90853bd4cea90e3167875158a165`，[opt/r30-autolock-late-threshold-20261110](https://github.com/tddeufdthfww-stack/linien/tree/opt/r30-autolock-late-threshold-20261110)。这是当次推送后核验的提交，不承诺包含后续未推送文档。
