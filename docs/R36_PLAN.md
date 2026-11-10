# R36 / 2026-11-11：同cohort三路指令预取，新增反馈周期0

从R29保留RTL9c5c32a/HEAD5903089独立工作树出发，不携入R34外部GPIO8ns或R35额外105个索引副本。R29仍STA FAIL（−.617/−91.147ns），R34/R35已失败归档。目标仅重构robust指令配置的原采样边沿，不重做板级移植、PID或AXI/CDC。

1. 冻结旧autolock_pipeline.py和完整原50076向量，先验证三路预取的数学与CSR边界。
2. 在原配置采样沿捕获当前idx、wrap5(idx+1)、0三个候选的幅值/精确宽负值/正号/等待；同沿记录原FSM回零/递增/保持动作，随后只选三项。原FSM和公开五状态边沿不变。
3. 真实32项unsigned CSRBank、14/25/28位差分/整数oracle，min有限abs、所有32索引/31→0、热写/部分写/读回/复位、X/Z；原父模块/Fast/Slow/PID/IIR/Scope/AXI/CDC全套执行。
4. 再核实际顶层CSR/XDC、原FSM AST、预取映射和全部D/S/R/CE，独立综合及route；任何恶化保留不合并，记录输入SHA和命令标记。

## 数学与周期

旧第t拍bank_i[t]=f(CSR_i[t−1])，输出T[t]=bank_idx[t][t]。原idx[t+1]只可能是idx[t]、(idx[t]+1)mod32、0。
新沿捕获C[t+1]=f(CSR_idx[t][t])、N[t+1]=f(CSR_wrap(idx[t]+1)[t])、Z[t+1]=f(CSR_0[t])，并按原FSM同一条件（at_start优先，其次实际advance，否则hold）捕获kind[t+1]。所以选择后Tnew[t+1]=f(CSR_idx[t+1][t])=Told[t+1]，不增加任何数据/状态流水沿，支持每拍递增和连续热写。必须直接采样原始CSR.storage，不能采样已有延迟bank再补一拍；idx+1按5位回绕，不能让Array[32]落入旧默认31。最终用常量旋转的完整Case实现next表，0→1…31→0，显式default仍31，既去掉前端5位加法，又保留原Array[wrap5(idx+1)]在X/Z索引时的默认31；额外原生probe比较原算术索引与该Case，包括部分X/Z。

f包括原N位signed有限abs（最小负数仍回绕为自身）、扩为N+1后取负、原signed>0以及unsigned wait。原CSR.storage为unsigned，先以同位宽signed解释，不能零扩展。global reset令bank/cache/kind/index全部0；CSR与缓存同沿时读取写前storage，保持原非原子字节热写轨迹。无强行更改模式/CSR地址/五状态/数据吞吐。

## 目的、风险与未验证事项

反馈锥由32项宽查表→比较→GPIO/计数器控制，变为三项宽选择→同一比较；idx→32项查表移到原cohort输入沿，且不再需要32套幅值/负值/正号/wait影子FF。实际资源/扇出/延迟不能预先保证：CSR→abs→预取FF可能成为新路径，kind反馈/预取idx+1也需STA检查。kind不是新反馈阶段，而是原index动作的并行记录；若只寄存旧选中阈值会错一条指令，本设计不采用该错误近似。

R35全局最差是FCLK保持地址→ADC Scope CE，clock interaction明确No Common Clock/Timed unsafe；同ADC域也仍−.621ns，不能只改跨域约束宣称通过。本轮不修改任何例外/时钟；bundled-data物理预算与真实同域违例分别审计，CDC计数不是安全证明。

CE/reset到D映射是后备物理手段，尚未实施；参考AMD UG912 CONTROL_SET_REMAP（https://docs.amd.com/api/khub/documents/rk0Uzk92HN6YiZcSJ3RgaA/content）。本轮没有新增ADC→DAC/robust/GPIO周期，继承R28指定组件Bare72.1ns/快慢108.1ns，仅组件功能模型，非full-root/SDF/板端/模拟测量。无bitstream/板卡/激光/PZT操作。
