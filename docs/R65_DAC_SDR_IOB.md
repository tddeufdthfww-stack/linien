# R65 用SDR IOB输出FF精确表达D1=D2的同边沿波形

2026-11-12。独立opt/r65-dac-sdr-iob-20261112，冻结R64 9d773b1及所有已留基线。
R64 fresh全功能PASS，route仍FAIL：setup-.748/hold-1.901ns。最差控制→ODDR D1
只有2ns，ODDR输入setup要求高；外部hold报告还假设data在C falling也可翻转。

## 修改前等价推导

R64 data ODDR使用SAME_EDGE且D1=D2=V。在每个250MHz rising k，D1和D2锁存同一V[k]，
输出更新V[k]；中间falling只再输出同一个已锁存V[k]，无新字。INIT0/R0/CE1下，
可用相同250MHz rising、INIT0/R0/CE1的单个FDRE输出V[k]。无需为falling输出路径
写false path，也无需放宽时钟或取消真实hold。对已知可达二进制数字状态波形相同，
具体厂商原语的启动/复位/稳定采样输出还须由实际UNISIM新旧对照验证。

本轮只把14个data SAME_EDGE/D1=D2 ODDR换为14个SDR FDRE/IOB TRUE，保留R64原3个
时隙控制FF、原125MHz数据FF/编码/复位。新增数据串行级0；原A旧字/B新字时隙目标保持。
不改PLL/相位/引脚/电平/DRIVE8/FAST/CSR/算法/吞吐率，R63 ADC same-word约束照旧。
相对R2b已有快速数据+32ns继承，不把本轮原语简化写成新增一拍。

## 验证和风险

先新工具check_r65_analog.py检查实际生成RTL有32 ADC+14 DAC正边沿FDRE和2个负边沿
控制FF，data SAME_EDGE ODDR已无；再执行R64全部启动/四包络/14位/复位/时隙/样本号
严格对照，冻结R61b完整analog参考保持。不声明任意非法X/Z驱动或SDF物理等价。
通过后新综合/实际route，核对14个OLOGIC输出FF、2ns控制路径、外部DAC source仅
rising250边沿、真实setup/hold和全部ADC/内部/DNA/CDC/DRC。任何失败保留源码报告，
不合并。若DAC电气裕量仍不足，只能用合法4/8/12/16mA与真实模型另评估，不能采用
R64被工具拒绝的24mA，也不能靠降低吞吐率、虚构时序参数或切路径达标。

ADC/DAC预算仍是零PCB差分偏斜的必要诊断；IQSEL均低窗口、CLK/WRT先后、手册脉宽
解释/实际板级SI均未自动解决。最终冻结输入还必须全功能回归和完整签核后才能签发
bit/bin；本轮不烧录、不操作激光/PZT。

实际原生结果：check_r65_analog.py四组功能包络/完整14位/逐稳定边沿49位全输出（2ns
起含GSR与复位）与冻结R61b对照PASS，样本号负向控制按预期失败。生成RTL中46个正边沿
FDRE（32ADC含未用低位+14DAC）、2个负边沿控制FF及0个SAME_EDGE data ODDR检查PASS。
证明范围为声明数字状态/时钟契约，不是SDF或真实PCB。原件、源码和SHA见
experiments/r65_sdr_dac_native_20261112。新综合/route尚待结果，其他组件本轮先不重复
R64完整同源回归，最终发布前仍须对最终候选完整重跑。

## 2026-11-12 R65 实际结果：REJECTED_NOT_MERGED

输入代码82699d8960817ab2d08517eb8705aed0835c667f；新综合/实际route均COMPLETE，CSR映射PASS。原生analog新旧同波形/启动/复位/四包络/完整14位/样本负例PASS，本轮完整功能NOT RERUN，未改组件参考R64同源fresh全功能PASS，不能当成本轮全功能重跑。

实际route WNS/TNS=-.683/-55.023ns，312 setup端点；WHS/THS=+.024/0、0 hold端点，WPWS=+1.500ns。SDR表达消除了R64负hold；最差FDRE_33/C负边沿到FDRE_40/D正边沿，2ns路径仍FAIL。DAC必要零PCB预算setup/hold=-.343/+.070ns；ADC全28端点+.429/+3.304ns、0/-8ns边沿关系逐条PASS。内部clk_2 WNS=-.345ns。no_clock=0、内部未约束=0，16输入/32输出尚须接口分类/真实约束。物理CDC25对50FF同SLICE且一级Q只到二级D，仍不足以宣布跨域整体安全；PS原始异步reset释放已被独立实际CRG仿真确认为待修复项。

源码、完整阶段日志、DCP、物理诊断及SHA归档experiments/r65_rejected_control_20261112，DCP SHA256=5e7c3b93c8a3e02d91b25586981e483a11e70d17319175f3d22cfba97d335aee。失败候选不合并/不部署。R65相对R64新增数据串行级0，继承相对R2b主反馈+32ns；最终STA/板级I/O/CDC/DRC仍未签核，没有生成发布bit/bin。
