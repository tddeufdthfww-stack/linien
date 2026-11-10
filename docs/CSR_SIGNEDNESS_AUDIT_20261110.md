# CSR算术边界与R23类型缺陷审计

2026-11-10。以下检查针对本机生成RTL和对应源代码；不是整机形式等价或CDC物理安全证明。

R23把Root的unsigned14 CSRStorage预偏置直接参与有符号公共项加法。生成RTL明确零扩展；旧夹具输入却为signed14，产生错误的生产等价结论。R24继承该缺陷，已中止综合。测试专用提交cba82d1只改为真实CSRStorage/CSRBank及原Root signed14影子寄存器，在第45拍复现失败；不删除该失败或追认旧版本。

R25修复提交759cba4使用同宽signed信号重新解释原位模式，再进行宽加法，没有增加寄存器边沿。原失败夹具未改变期望，修复后30000拍PASS（15053拍负偏置）。新增未经过限幅的完整公共项中间值检查14/25位30106/30134拍PASS，比较原ya/offset FF、生产helper和独立整数oracle，覆盖真实CSR部分写两种顺序、读回、符号极值和复位，避免饱和掩盖差异。

| 边界 | 实际类型与处理 | 验证证据 |
|---|---|---|
| chain_a/b offset预源 | CSRStorage unsigned14；same_edge_common先复制同宽signed14，再与signed dy>>>11相加 | 新真实CSR失败→修复PASS、完整中间值14/25位、实际Root signed[13:0]声明与RHS核对 |
| fast PID setpoint | 保持原unsigned W编码；错误差值目标W+1 signed，不擅自改为signed setpoint | 冻结PID、14/25位联合帧/真实CSR/饱和/复位/CE |
| PID Kp/Ki/Kd | CSR位模式在原有阶段复制到signed coeff_width信号后乘法；cohort为位传输 | 原生完整PID9状态/14、25位/真实部分CSR写 |
| mixer因子 | unsigned9原ABI；低字节XOR128编码后在DSP B端符号扩展，高位单独形成bias | 实际UNISIM DSP、每侧512因子、完整37位原表达式及整数oracle |
| mixer offset | 原signed14 Root影子FF进入signed14端口，移位后signed37；与乘积同拍运输 | 真实CSR offset影子、37位三方比较及模式/CE热写 |
| limit min/max | unsigned W存储原位模式，显式复制符号位到W+guard signed边界 | 原LimitCSR差分、独立clamp整数oracle、相等/非法lo>hi优先级 |
| 反相limit边界 | 在原边界同一CE边沿对扩展到N位的边界取负；N>W，取负无N位溢出 | 14/25位及N位最小负数/邻值专门覆盖 |
| IIR系数 | unsigned25 CSR/cohort仅复制位模式，最终同宽signed25系数FF参与MAC | 50位完整MAC及order1/2/5、部分写/hold/clear/reset/overflow-hold |
| IIR z0 | 原27位存储左移23后恰为50位位模式；新cohort不改变截断和时序 | 28/50位有限整数oracle、真实CSR z0边界及配置帧 |
| C48 MAC分片 | x_low补0成为signed18，x_high为signed8，z_low显式signed48；高2位按mod4校正 | 71760组含正/负48位溢出与50位回绕，全滤波器递推对照 |
| robust peak/阈值 | unsigned CSR先同宽signed28解释、有限abs28；负阈值先扩展signed29再取负，与旧abs共用一拍CSR边沿 | 90800已知+8000未知位、父模块50076拍（55未知严格四态） |

实际R25顶层核对结果保存在r25_generated_types.json：两路均有signed[13:0]别名，common寄存器RHS使用别名，错误的zero-extend CSR表达式已消失。生成top.v SHA256及源码输入哈希随本轮证据归档。

各PASS只对应所列验证范围；没有把组件夹具等同于完整PS7/板级Root仿真。综合成功、route完成、内部setup/hold和CDC/I/O/DRC最终签核分别判断。所有保护基线保持原样，R23/R24仅作为失败或中止记录，后续版本重新全套验证。
