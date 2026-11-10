# Z7020 优化进展、关键路径和延迟核验

日期：2026-11-10。目标仅为 STEMlab 125-14 PRO Z7020 Gen 2，器件 xc7z020clg400-1，Vivado 2020.1 build2902540。保留既有PS7、时钟、ADC/DAC、AXI/CDC与CSR适配；没有重新移植平台。

**当前较优源码候选为R16，功能回归PASS、综合完成、实际布局布线完成，最终STA FAIL。不能作为已可上板或已实现Cs锁频的正式版本。** 用户的100kHz初期交越、未来约1MHz Bare PID能力及额外0–16ns目标/必要时评估32ns以内均已记录为设计目标；完整模拟链尚未测量，不写成已验证性能。

## 本轮实际完成与保留关系

R11先算谓词后选择的零延迟试验完成并拒绝。R12配置编码与DSP寄存器位置调整通过数值验证，但单独全局恶化，拒绝。R13对慢链增加两sys拍并完整对齐限幅/路由，通过功能但全局恶化，拒绝。R14在独立组合分支加入一级robust判定传输，改善全局。R15复用R14相同RTL与功能/综合证据，仅新做布线后物理优化，取得微小全局收益。R16在R14上组合R12已验证的混合器局部结构，再次完整回归、重新综合及route，成为当前较优源码候选。

R14基于R13局部修改形成新的组合候选；R16基于R14源码，**没有继承R15布线后DCP**。这些均未合并R4a/R2b，也未覆盖原工程。局部或一次route通过不能当作长期布局裕量保证。

| 实现 | 综合WNS/TNS ns | Routed WNS/TNS ns | Setup违规端点 | 结论 |
|---|---:|---:|---:|---|
| R2b保留基线 | −6.094 / −4563.029 | −5.605 / −10473.525 | 6813 | 历史功能PASS，STA FAIL |
| R4a保留基线 | −6.516 / −4242.386 | −4.822 / −7902.165 | 6288 | 历史功能PASS，STA FAIL |
| R11 | -6.288 / -4104.573 | -5.440 / -9593.289 | 6791 | 拒绝，不合并 |
| R12 | -6.288 / -4017.906 | -5.156 / -9847.520 | 6976 | 拒绝，不合并 |
| R13 | -5.867 / -3863.443 | -5.137 / -9054.302 | 6842 | 拒绝，不合并 |
| R14 | -4.046 / -3681.924 | -4.093 / -6274.995 | 5991 | 实验候选，未签核 |
| R15 | -4.046 / -3681.924（复用R14） | -4.086 / -6175.701 | 5821 | 实验候选，未签核 |
| R16 | -3.911 / -3598.924 | -4.068 / -5780.718 | 5437 | 实验候选，未签核 |

R16相对R4a：WNS改善0.754ns、TNS减少2121.447ns负裕量、违规端点减少851；相对R2b分别为1.537ns、4692.807ns和1376个端点。它仍有5437个setup违规端点，不能把改善量当作项目完成百分比。

## 当前瓶颈：经实际网表和路径节点核实

全局最差：`DSP48E1_1/CLK` → `linienmodule_logic_limit_error_signal_limitcsr_y_reg[8]/D`，WNS −4.068ns，数据11.684ns=logic6.876+route4.808，12级（CARRY4×7、LUT4×1、LUT5×1、LUT6×3）。源DSP的CLK→P[7]本身4.009ns；之后经过压缩/进位求和、限幅比较和输出选择。该路径不是仅由CSR名字推测出的乘法问题。

混合器两个DSP均AREG=1/BREG=1、MREG=0/PREG=0，系数已不再直接走原无BREG的乘法入口。当前长链是寄存器到乘法输出再到求和/限幅的同周期组合链。单纯布线后优化R15只改善WNS7ps，尚不能据此证明所有零延迟优化都已耗尽，但不能指望重复布局消除约4ns违例。

raw IIR入口−4.059ns，logic6.876+route4.877；内部−2.834ns，logic7.717+route2.508，11级（CARRY4×8、DSP×1、LUT2×1、LUT3×1），实际从z100/CLK到z100__0/CEB2，仍需继续处理。FastChain A/B IIR组分别−2.972/−3.089ns。

robust旧time_scale→GPIO的跨完整组合路径已被一级寄存器切开，报告无直接组合路径；没有加false path。time_scale→sum_diff_s1最差+0.730ns；sum_diff_s1→GPIO仍−2.046ns（logic3.485+route6.435），不能宣布整个自动锁定模块通过。

慢PID组最差+0.936ns，当前完整负端点清单中慢PID含CSR也为0条；慢链其他逻辑仍有14条、最差−1.058ns。快速PID最差−0.105ns，真实终点是积分寄存器同步置位/S，仍不能称快速PID全部通过。R13无非CSR慢PID违例，R14布局下又出现10条，R16再次归零，说明必须逐轮检查，不能把单次结论永久沿用。

| 分组 | WNS ns | 起点→终点 | 逻辑级数/器件 | 逻辑/布线 ns |
|---|---:|---|---|---:|
| 快PID /D | +0.514 | `linienmodule_csr_adr_reg[5]_rep__0/C` → `linienmodule_logic_pid_pipelinedpid_reset_storage_full_reg/D` | 2  (LUT2=1 LUT6=1) | 0.766 / 6.586 |
| 快PID /S | -0.105 | `p_1_out/CLK` → `linienmodule_logic_pid_pipelinedpid_int_reg_reg[12]/S` | 15  (CARRY4=11 LUT2=1 LUT4=1 LUT5=1 LUT6=1) | 3.021 / 4.432 |
| 快PID /R | +2.452 | `FD_replica_13/C` → `linienmodule_logic_pid_pipelinedpid_pid_sum_reg[32]/R` | 0 | 0.456 / 4.514 |
| 快PID /CE | +0.373 | `linienmodule_csr_adr_reg[0]_rep__1/C` → `linienmodule_logic_pid_pipelinedpid_setpoint_storage_full_reg[17]/CE` | 2  (LUT2=1 LUT6=1) | 1.002 / 6.245 |
| 慢PID /D | +1.272 | `linienmodule_csr_adr_reg[4]/C` → `linienmodule_slow_chain_pid_pipelinedpid_reset_storage_full_reg/D` | 2  (LUT4=1 LUT5=1) | 0.932 / 5.719 |
| 慢PID /S | +0.936 | `linienmodule_slow_chain_pid_pipelinedpid_ki_mult1/CLK` → `linienmodule_slow_chain_pid_pipelinedpid_int_reg_reg[0]/S` | 10  (CARRY4=6 LUT2=1 LUT4=1 LUT5=1 LUT6=1) | 2.409 / 4.046 |
| 慢PID /R | +3.082 | `FD_replica_13/C` → `linienmodule_slow_chain_pid_valid_s2_reg/R` | 0 | 0.456 / 3.914 |
| 慢PID /CE | +1.262 | `linienmodule_csr_adr_reg[11]/C` → `linienmodule_slow_chain_pid_pipelinedpid_ki_storage_full_reg[11]/CE` | 2  (LUT6=2) | 0.704 / 5.755 |

源/终点/DSP内部引脚完整报告在各轮归档内。N/A表示没有该类有效引脚路径，不能填一个伪造PASS裕量。

## 修改文件与数学依据

- `gateware/logic/registered_error_mixer.py`：9位无符号系数F按 `G=signed8(F_low XOR128)`、`H=F[8]` 分解，`F=G+128+256H`，所以`F*X=G*X+128*(H?3X:X)`。G在原低字节CSR写边沿进入DSP BREG，Freset128对应Greset0；高字节独立更新、读回与原ABI相同。三倍X先扩展27位，所有求和按原37位模运算，原右移及限幅入口不改。
- `gateware/logic/chains.py`：FastChain只导出原in-phase输出寄存器的D与CE，供DSP AREG在同一原有边沿复制；原out_i、signal_out、CSR不改。新增数据级0。
- `gateware/logic/slow_pipeline.py`：复用已验证PipelinedPID，接受样本到执行固定延后2个sys时钟；积分状态递推不新增反馈寄存器，吞吐保持。慢限幅CE和min/max快照、慢路由选择以及analog0扫频贡献整体对齐；CSR写不随数据CE冻结。
- `gateware/logic/autolock_pipeline.py`：SumDiff结果、request/start/writing/sweep元数据及所有峰/等待/N/final配置快照一级传输；每条峰abs/sign在Mux前寄存，保留28位abs最小负数回绕。当前指令索引递推不另延迟，ROBUST_AUTOLOCK_FPGA_DELAY仍3个采集事件。
- `gateware/logic/autolock.py`：新增可选robust_factory，默认行为保留；生产选择新候选，父模块原始request取消与模式门控不延迟。
- `gateware/linien_module.py`：只选择上述候选并连接上下文/混合器；快慢PID、限幅与状态监视的CSR map逐字节一致。
- `tools/check_registered_mixer.py`、`check_slow_pipeline.py`、`check_autolock_pipeline.py`与冻结参考：真实生成RTL/CSRBank/UNISIM回归；`tools/run_gateware_trial.py`在每轮新目录运行，不覆盖已有结果。

R16实际源码位置、diff统计和完整源码副本另存证据索引；没有修改原pid.py、IIR方程、PS7、时钟、板级引脚及通信RTL。

## PASS / FAIL / NOT RUN

| 项目 | 本轮实际状态与范围 |
|---|---|
| R16既有pytest | PASS，8项 |
| 14/25位PID差分、饱和/CE/复位/CSR | PASS；两级PID各4698拍、9字段，原CE/饱和及真实CSR套件PASS |
| 新混合器 | PASS，UNISIM DSP+真实CSR+完整37位整数oracle 33096拍，双方各512系数；FastChain原FF导出10000拍，CE保持6398 |
| 完整慢链 | PASS，413022拍、4171提交、0–31分频配置、正/负饱和51/57、真实CSR读回与独立原始输入/配置/路由参考 |
| robust及父FPGAAutolock | PASS，50076拍，已知50021、原始RAM未知55均严格四态比较；watch31468/advanced32181/lock27427；原robust非slow5项PASS |
| AXI/CDC功能 | PASS，5个bench及bridge 1/1250/3999/7999ps四相位，含读写背压、快照、复位恢复 |
| CSR map/XDC | PASS，与冻结参考一致；125MHz/8ns未放宽，未新增掩盖问题的例外 |
| R16综合 | COMPLETE；WNS/TNS −3.911/−3598.924ns，不能当作STA PASS |
| R16实际布局布线 | COMPLETE；WNS/TNS −4.068/−5780.718ns |
| 现有约束覆盖的Hold/Pulse | 无违规，WHS +0.038ns、THS0、WPWS+1.5ns；不覆盖缺失外部约束 |
| 最终STA | **FAIL** |
| CDC/I/O/DRC最终签核 | **NOT SIGNED OFF** |
| 全项目GUI/服务端软件测试 | NOT RUN；本轮只运行上表列出的gateware相关回归 |
| bitstream/板上/激光闭环 | **NOT RUN**，未部署、未操作激光/PZT |

R15的功能和综合明确是**REUSED R14 / NOT RERUN**，不是该轮重新执行。R12最初glbl缺失、DSP端口常量位宽错误，以及R14最初测试观测寄存器复位值错误的FAIL均已保留；修复后的输入重新回归，通过才送综合。未修改已安装Migen evaluator。上述覆盖不是形式等价证明或板级证据。

## 延迟：增量与指定配置的绝对数字模型分开

相对R4a：R16持续快速主支路新增0拍；慢PID及慢输出贡献新增2sys=16ns，analog0扫频贡献也延后16ns；robust锁定判定新增1sys=8ns。相对R2b：快速PID已有2sys=16ns累计增量，特定快→慢串接支路累计4sys=32ns。锁定判定的8ns不加到所有持续数据样本上。

已用R16实际组件重测正负123脉冲、真实CSR和UNISIM ODDR，包含顶层显式fast_outs→limit_fast.x寄存器：

| 配置 | ADC输入采样边沿→DAC数据 | 至下一对应写选通 |
|---|---:|---:|
| 原PID、Bare P-only、DAC A | 40.100ns / 5sys | 42.100ns |
| R4a/R16快速两级、Bare P-only、DAC A | 56.100ns / 7sys | 58.100ns |
| R4a快A→原慢PID→DAC B，连续CE单位增益 | 76.100ns / 9.5sys | 78.100ns |
| R16快A→两级慢PID→DAC B，同配置 | 92.100ns / 11.5sys | 94.100ns |

DAC B为下降半周期，日志cycle整数标签9/11不能忽略另半周期。0.100ns来自原语模型。**此前4/6sys、32.1/48.1ns的绝对值漏掉顶层寄存器，已更正作废；差值16ns仍正确。** 旧模型和原生日志保留。

这些是对应固定选择、P-only、全范围限幅、running=1、无扫频/调制/偏置配置的组件组合模型；不是完整Root/SDF/板级实测，不覆盖其他滤波/CE/路由配置。ADC转换、DAC芯片建立、驱动/PZT/光电与解调链不在模型中。额外16ns纯传输延迟在100kHz为−0.576°、1MHz为−5.76°，不构成闭环稳定性或带宽证明。

## CDC、约束覆盖及资源

R16 LUT14008、FF13768、DSP94、BRAM35、BUFG6；R4a为11561/12271/95/35/6。资源未耗尽，问题是路径深度和布线。

CDC-1/2/3/4/10/15为453/14/4/1/2/374；严格名称相对R4a新增21/移除4。CSR复制和命名会影响数量；**物理跨域安全仍NOT_PROVEN**。必须继续验证顶层与Scope bundled-data保持窗口、同步链、复位及物理约束，不能由2FF或数量变化直接签核。

no_clock=1、内部未约束端点=2（DNA），no_input_delay=44、no_output_delay=46，默认DRC218项。所有这些与setup违例一起阻止最终签核。时序比较使用相同现有约束，不等于外部I/O预算已补齐。

## 下一阶段具体建议（尚未实施）

优先修改`registered_error_mixer.py`的DSP乘积到后级求和/限幅边界，不能继续只改表达式顺序追求几皮秒。候选A：启用MREG并给bias、offset、dual等同拍元数据加一级，乘法与后续求和/限幅分开，正常/裸PID输入选择、running、setpoint、Kp/Ki/Kd/reset与限幅min/max必须按同一新增8ns队列对齐。候选B：再给37位求和加一级，共16ns，代价更高但能单独约束饱和链。仅改MREG而不对齐其余量是错误做法。

新增8/16ns分别在100kHz引入0.288/0.576°、1MHz引入2.88/5.76°纯延迟相位；若在现有慢支路16ns上叠加，特定串接支路相对R4a额外24/32ns，需按用户32ns内评估目标单列。不得将这些数值视为实测可稳定带宽。先建立冻结R16与独立延迟全部输入/配置参考的原生RTL回归，再综合/route；R16保持不变。也可继续研究零延迟求和/饱和结构，但目前尚无证明其能消除约4ns的候选。

同时继续raw/fast IIR的DSP级联、50位进位和溢出反馈CE分析；不改阶数、精度、采样吞吐，不在IIR反馈中随意插寄存器。修复最差路径不代表其他模块自动满足8ns。

重复流程：新worktree/分支 → 提交数学依据和延迟契约 → 真实CSR及边界/复位/CE/AXI回归 → 冻结输入SHA → 新目录生成CSR map/XDC/top → synth → opt/place/phys_opt/route → 分组/D/R/S/CE及DSP内部端点/CDC/覆盖/DRC报告 → 保留或拒绝并记录。任何失败保留输入和日志，禁止覆盖R4a/R2b/原用户工程。

## 重复运行的PowerShell入口

以下命令只在R16独立工作树新建带时间戳的trial输出目录，不覆盖已有有效代码或报告，不生成bitstream。仍需要安装本机既有工具与环境。

```powershell
$TrialRoot = "D:/RP_Dev/linien_trials/20261110-r16-combined-mixer-pipelines"
$GatewarePython = "D:/RP_Dev/linien_trials/20261109-r5-autolock-compare/.venv-gateware/Scripts/python.exe"
$env:PYTHONDONTWRITEBYTECODE = "1"
$env:PYTHONPATH = "$TrialRoot;$TrialRoot/linien-common"
$env:MPLBACKEND = "Agg"
Set-Location -LiteralPath $TrialRoot
$TrialLabel = "r16_verify_" + (Get-Date -Format "yyyyMMdd_HHmmssfff")
& $GatewarePython "$TrialRoot/tools/run_gateware_trial.py" --label $TrialLabel --stages "functional,generate,synth,route"
if ($LASTEXITCODE -ne 0) { throw "试验流程失败，请查看新trial目录中的原生日志。" }
```

退出0只代表流程完成。必须继续核对新routed_timing/checks/CDC/DRC报告；当前R16仍为STA FAIL。

## 提交、输入SHA256与复核

| 轮次 | 硬件/试验代码提交（完整SHA） | 独立分支 |
|---|---|---|
| R11 | `4f76dce8cde938c83bd4fdc4f4381708a0869e57` | `opt/r11-autolock-late-predicate-20261110` |
| R12 | `1157c8ed1af23130e5e2ec24eca45919c149d4e6` | `opt/r12-mixer-csr-dsp-20261110` |
| R13 | `f98d0d8dde0b695a92a7b69df8d977fb2ce21f87` | `opt/r13-slow-transaction-pipeline-20261110` |
| R14 | `e6906dc9bbbdae144383444e25ec647b36324e26` | `opt/r14-autolock-decision-pipeline-20261110` |
| R15 | `7641bb483ed2d113b0e2c09902ff6d7d72bf9029` | `opt/r15-postroute-physical-20261110` |
| R16 | `e7abddf066877c27ee1fde34c69d6af50fde0cb3` | `opt/r16-combined-mixer-pipelines-20261110` |

R16工作目录：`D:\RP_Dev\linien_trials\20261110-r16-combined-mixer-pipelines`。结果归档提交364419b；逐文件输入SHA256、原始工具命令/退出码/PASS标记、生成top/约束/DCP哈希和每轮归档哈希见随附`Z7020_输入SHA256与验证索引_20261110.json`。DCP留在各trial本地，不放入交付ZIP；源码、生成RTL、输入manifest、原生测试向量与日志/报告已归档。

R4a222文件、R2b207文件及原用户工程168文件SHA256/HEAD/工作树状态最终核对全部不变。所有构建期间source_changes_during_run及归档前输入哈希差异为空。没有清理用户未提交内容。
