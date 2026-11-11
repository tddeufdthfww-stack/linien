# R46：预取负阈值双重取负化简，保留有限位宽MIN特殊值

基线R44 408d899/5227695，功能全PASS/综合及route COMPLETE、最终STA FAIL；route−.691/−136.392ns、707端点，global idx[1]→prefetch_current_negative[28]/D 16级/11CARRY4、3.727logic+4.805route。R44 Scope因子→数据已+1.451ns/4级，源/目标缓存各6FF；不把R44当正式版本。R45仅小模块PASS，未携入其IIR边沿重定时。

1. instruction_prefetch.py只化简negative的组合输入，magnitude/positive/wait/choice/FSM/CSR与所有采样沿不变；current/next/zero三组同样应用，新增串行周期0。
2. 旧：A=abs_N(p)作为signed N；negative=-signextend(A,N+1)。普通负p可消去双重取负，但MIN_N的abs仍MIN，旧negative为正+2^(N-1)，必须保留，不能直接写signextend(p)。
3. 等价位式：lowN=(p<0?p:-p) mod2^N；high=(p>0)|((p<0)&(p!=MIN_N))。拼接high/lowN：p0得0，MIN得正2^(N-1)，其他得-abs(p)。共享N位一次取负，最高位比较路径不经过abs加宽再取负的进位链。未知raw使relational谓词X，If落到-raw产生全X、high亦X，按原四态行为验证。
4. 修改前Python全穷举N1..16共131070例、14/25/28各100006随机边界先PASS；再原样真实unsigned CSRBank/冻结旧整bank/整数oracle14/25/28、MIN/全32索引/两序部分热写/回绕/reset/各3000X-Z与父模块/AXI/CDC等完整回归。
5. 新综合/实际route，检查negative D/S/R/CE、MSB及低位真实路径/CARRY4/逻辑与布线，和magnitude/选择/其他IIR/Scope是否成为新瓶颈；CSR/XDC/输入SHA/CDC/DRC覆盖另查。没有把R43物理结果直接用于此新RTL。
6. 不动R40/R43/R44或保护基线，不加时序例外/放宽周期/改阶数精度吞吐；失败保留，不合并。整体WNS/TNS/端点与功能共同决定，不因一条路径正裕度就宣称整机或CDC/板端签核。
