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
