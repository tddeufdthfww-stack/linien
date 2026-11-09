# R3 / 快速 PID 误差前端 / 修改前论证

基线：4efa38fda4b4c315b744443a537e9d398843cbad（R2b），功能通过、综合/route完成、STA失败。独立目录20261109-r3-fast-front，分支opt/r3-fast-front-20261109；原工程和R2b不修改。

## 实际路径与选择依据

R2b快速积分/D最差路径中，setpoint[1]经过5个CARRY4产生error[18]，再进入DSP48_X2Y25的A[17]→P[4]，然后11个CARRY4作积分加法，最后经过饱和LUT到int_reg[3]/D。数据13.547ns=logic8.317+route5.230，WNS=-5.605ns。该DSP的AREG/BREG/MREG/PREG全部为0。不是仅凭寄存器名称推断。

慢速control_channel CSR选择limit_fast1/2的14位输出，经控制信号左移11位再右移11位进入SlowChain，经过15位误差、Ki乘法、33位积分和与饱和，故/S同样承载算术建立时间。R2b/D=-5.242、/S=-5.414ns。CE路径是counter→分频选择→使能逻辑，route5.783ns，不能由减法重写直接解决。

## 数学等价依据（先于候选源码修改）

原error是signed(w+1)目的寄存器样式的组合变量，输入为signed(w)，setpoint.storage为unsigned(w)。保留E=signed_(w+1)((sign_extend(input)-zero_extend(setpoint)) mod 2^(w+1))；running=0时E=0。不能将setpoint改为signed，不能删去error的最高位：w=25时input=-2^24、setpoint=2^25-1，完整差为-50331647，原26位输出发生模截断。

令A为input符号扩展后的w+1位无符号比特向量，B为setpoint零扩展比特向量，按低位到高位分成最多6位的块a_i,b_i。块借位生成G_i=[a_i<b_i]、传递P_i=[a_i=b_i]。进入第i块的借位为b_in(i)=OR_(j<i)(G_j AND AND_(j<k<i)P_k)，第0块借位0。预计算d0_i=(a_i-b_i) mod2^n_i及d1_i=(a_i-b_i-1) mod2^n_i，按b_in选出d_i。逐块减法定理保证Cat(d_i)=(A-B)mod2^(w+1)，与原逻辑对全部比特输入等价；running门控不移动。选择前并行计算避免26位串行进位进入DSP。

只在顶层快速PID开启参数，慢速默认关闭。目标是缩短DSP前的进位依赖；可能因LUT/扇出及布局增长抵消收益，必须用route判断。预期逻辑改善约0.3～1ns只是估计，整个设计仍可能受慢速路径限制；不预先承诺WNS/TNS收益。误差/乘法/饱和位宽不变，积分反馈递推不变，P/I/D寄存器数不变，新增反馈/采样延迟0周期/0ns，CSR/CE/reset优先级不变。

## 验收与回退

先运行独立整数模型分块证明用例和实际Migen14/25位误差边界/随机差分，再运行既有PID逐状态差分、U/L边界、全局及CSR reset、CE、真实CSR读写、所有动态分频、7项pytest、AXI/CDC/XSim四相位、CSR map语义比对。功能PASS仅为这些有限回归，不是形式等价或物理CDC证明。

在全新trial目录生成、综合、route，用同一8ns时钟/原XDC和实现directive；记录原始stdout/stderr/exit/标记、源码/PS/约束/DCP SHA256。分别比较全局WNS/TNS/违规端点、快慢/D/S/R/CE、hold/pulse、资源、CDC差集及未约束端点。若恶化，保留失败源码和报告，不合并R2b；不通过增加false/multicycle/放宽周期掩盖。新增流水线NOT IMPLEMENTED。
