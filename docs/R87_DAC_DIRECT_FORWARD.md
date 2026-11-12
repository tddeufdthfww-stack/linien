# R87 直接区域时钟转发WRT探针

父R86保持，仅独立探针，不改生产Root/PS/ADC/CRG/算法/CSR。采用USE_SERDES=0：MMCM输出250MHz相位+135°，BUFH区域时钟直接输出WRT（正沿SYS1.5/5.5），14数据IOB FDRE反相时钟、负沿SYS-.5/3.5采旧A/新B。SEL同FDRE负沿；CLK仍相位-135°的250MHz ODDR。WRT没有ODDR/OSERDES输出级，考察取消其CQ差是否有真实物理收益。

实际原语WRT不含ODDR specify100ps，故WRT理想模型比基准早.1ns，独立phase断言相应1.5/5.5；数据/SEL/CLK仍逐125ps完整对照，WRT每个正沿仍严格按原SYS独立样本检查。新增整拍0，14位双125MS/s不变。启动16SYS guard保留，只增加启动等待。先证明合法路由，不设置CLOCK_DEDICATED_ROUTE FALSE或时序例外，不放宽8ns、setup2/hold1.5。FPGA全角与外部SEL/脉宽/PCB/CDC/DRC须另审，不生成bitstream。

# R87直接区域WRT失败，R80物理DRC/正常CDC边界补充 / 2026-11-12

R87只有独立probe：BUFH250直接转发WRT、IOB FDRE负沿发送数据，保持旧A/新B和14位每路125MS/s，零新增正常反馈级；WRT原语模型早.1ns，独立phase和逐WRT样本oracle验证，data/SEL/CLK仍完整逐125ps比较。native01 PASS；其结果scope字段误继承R84通用OSERDES描述，metadata02仅纠正说明字段后原测试完整重跑PASS，未改HDL/激励/断言。两次均73573writes、双通道32768码值、2354335pairs、3epochs。source01916350b0ce49fb97cfb97390c7fa21ba6deefe369acc0f87dd7c9f1bda68dd。

新综合COMPLETE、实际route合法COMPLETE，无CLOCK_DEDICATED_ROUTE绕行或例外。global WNS/TNS=-1.592/-21.201ns，29setup，WHS/THS=-.795/-10.627ns、14hold，WPWS+1.5ns；14DAC setup最差-.349ns，hold-.795ns。取消WRT输出寄存器未改善窗口，不选用、不接整机。DCP2492da637b2fac602f1d6388db76a1dfbf50ab683b9a2dc9247010fb037689e4。完整Linien新回归NOT RUN、没有bitstream。

独立重查不可变R80 DCP82adfcf0：bitstream DRC405项，Error/Critical0；84 no-load nets通过DRC对象逐个列出，叶级IN=0、外部OUT=0；26182可路由net全部已路由，errors0。403项为流水线性能/功耗建议，不为消除建议而加反馈级。DPREG-4实际OPMODE4/5同接error_s1_reg[0]/Q，常量位形成0000101或0110101，稳定Z仅0/C不选P；原告警保留，稳定二态审查不是模拟引脚偏斜/毛刺认证。第一次审查脚本误以报告包含全部84而实际只列前15，第二次get_nets API参数错误，失败原日志保留，03从真实DRC对象导出84项完成，没有据脚本失败修改硬件。

R80正常CDC：v6分类重新运行，导出未分类0，844个正常事务端点；核实Sys2CSR同拍寄存adr/dat_w/we后由CSR消费，不能只根据跨域路径名称断言早一拍采错。正常双级握手的16ns窗口，明确选择1ns保护量后15ns，最坏正常数据8.025ns、最小库存路径余量6.975ns。52ASYNC组成26对，全同SLICE、首Q仅次D；全26对最差setup6.542ns/hold.122ns（先前7.193仅GPIO子集）。这为正常交易提供源协议+物理路径+布局证据，不将数量减少等同安全。1ns是工程假设，不是测量的最大抖动证书；导出库存不是所有路径符号形式化证明；复位/取消/超时功能回归和任意模拟亚稳态/定量MTBF须分开。报告没有升格为整体CDC发布证书。

原用户工程、R2b/R4a/R16/R60/R80/R83/R84/R85/R86逐文件SHA/HEAD/工作树再核对全部PASS。生产硬件文件仍未改，候选均只新增独立probe。R80最佳整机内部WNS+.055/TNS0，global-.343仍14DAC；已知负路径不能因用户授权自行决定未知PCB/clock验收口径就改写为通过。工程验收配置见docs/ENGINEERING_ACCEPTANCE_20261112.md。

下一步R88补充此前未覆盖的3.3V LVTTL输出合法24mA档诊断：DS187保证VOH>=2.4/VOL<=.4，对AD9767 DVDD3.3V输入VIH2.1/VIL.9有DC余量；UG471 LVTTL在HR bank合法4/8/12/16/24，而LVCMOS33只有4/8/12/16。此为替代输出标准候选，不声称改变电压兼容性已完成板测，绝不向LVCMOS33强设非法24mA。先不可变R80 DCP内存100配置/1400bit记录的必要窗口扫描，恢复全部IOSTANDARD/DRIVE/SLEW后核对SHA，再决定是否值得独立实现。没有修改正式platform或对真实板卡施加电气变化。
