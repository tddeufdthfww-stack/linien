# R64 DAC数据与IQWRT共享250MHz时钟：零新增数据级候选

2026-11-12，独立opt/r64-dac-shared-clock-20261112，冻结R63 43438021、R62/R61b/R60。
R63 ADC必要零PCB预算+.429/+3.304ns，整机仍FAIL，DAC setup-.835/hold-.456ns；
内部clk_2 -.389ns/18端点。不能部署。

## 方案与等价依据（实现前）

保留原125MHz daca/dacb寄存器及编码/复位。14个data ODDR改为250MHz SAME_EDGE，
D1=D2=选中的同一个字；因此falling C边沿不改变数据，只有每4ns的rising C更新字。
该C与现有IQWRT ODDR共用sys_double，相比原data sys125 / WRT sys_double250，有望
减少不同PLL输出/时钟网之间的相位误差及不共享路径悲观性；不能预报实际裕量。

控制相位不用自由翻转的250MHz分频器：它在复位/锁定后可能与125MHz字相位反向。
也不把sys clock当普通D数据采样。新增F在每个sys rising翻转，reset_less/INIT0；
在每个sys_double falling处同时S'=F，B'=F XOR S。S/B均INIT0、无sys复位。
时钟来自同PLL、125/250均phase0；F在每个sys边沿后改变，到随后250 falling约2ns：

- sys rising前的fast falling（nT-2ns），F已被S观察，故B=0；fast rising nT输出A；
- nT+2ns，观察F的新翻转，B=1；fast rising nT+4ns输出B；
- nT+6ns，F未再变，B=0；下个nT+8ns恢复A。

ODDR SAME_EDGE的D1/D2都在fast rising采样，因此中间falling仍输出相同字。
nT时daca自身也更新，但ODDR采样其旧值；nT+4ns读取已更新的dacb，保留原版
OPPOSITE_EDGE125的A[n-1]/B[n]时隙，不静默改成同一帧或多加一拍。
F/S/B不随sys_rst中断时隙递推；原data寄存器仍按sys_rst清零。配置/GSR或PLL重启后
复位保持的零数据允许相位在第一个完整sys周期内建立；须实际native启动/复位对照。
新增3个控制FF，串行数据FF级数目标0；它不是增加8ns/16ns反馈流水线。

## 验证与风险

先实际Migen+UNISIM与冻结R61b完整analog的49位settled输出逐边沿严格比较，保留
R63四组clock/data包络和样本号负向控制，并增加启动时settled比较。所有ADC编码、
DAC A/B数据/复位/SEL/CLK/WRT逐拍对照不放宽。若不等立即FAIL，源码和日志保留。
通过后新综合/route：检查F→S/B的2ns控制路径、B→ODDR的2ns路径、data125→250
4ns路径、全部IO/ADC/内部/DNA/CDC/DRC；无set_false_path或计算通路多周期放宽。
物理控制路径是否满足2ns完全待实验，不能仅凭时钟同源判安全。

PLL频率/相位/引脚/CSR/数值算法/采样吞吐率保持，DRIVE8/FAST暂继承R63。即使
setup/hold改善，AD9767外部脉宽、IQSEL均低窗口、CLK/WRT先后、实际PCB/SI仍须另签核。
失败不合并；最终输入必须完整回归后才能考虑签发bit/bin，禁止烧录或激光/PZT操作。

## 物理实现前原生结果

实际Migen+厂商FDRE/ODDR原生对照已PASS。四组R63功能包络下，除完整ADC字编号/消费者/
全部14位/复位检查外，新工具check_r64_analog.py把49位全输出对照提前到仿真2ns以后，
覆盖配置/GSR启动及复位保持期间。原freeze R61b的A/B/SEL/CLK/WRT和全部ADC稳定输出
逐边沿相同；14个SAME_EDGE data ODDR及2个负边沿控制FF在生成RTL中检查匹配。
独立0延迟负向控制仍按预期ADC_WORD_INDEX_FAIL，不能当作正常包络PASS。
新源码/fixture/命令/日志及SHA归档experiments/r64_shared_dac_native_20261112。
该数字对照支持零新增串行采样级，但不替代实际2ns控制路径、输出PVT或PCB/SI签核。
