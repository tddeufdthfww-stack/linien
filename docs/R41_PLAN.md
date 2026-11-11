# R41：Scope请求源域同沿地址预译码

基线R38 291fbec/3fef5e4，route WNS/TNS−.619/−83.023ns，451端点、最终STA FAIL；不用R39显式CE→D，不携入R40物理复制。

1. bus_clk_bridge.v只增加输出src_capture_o，暴露原FCLK请求接收条件，不改变原任何状态同步语句、2FF、数据快照或ACK逻辑；所有原具名端口实例兼容。
2. red_pitaya_scope.v在原请求接收同一FCLK沿捕获17个地址相等谓词，与addr_o/wdata_o/sys_do严格同cohort；源域复位时像原addr_o一样保持，忙时保持。只替换写配置/ARM/复位/触发处地址比较，读回译码仍用原addr。
3. 数学：若旧addr[t+1]=A[t]，新match_j[t+1]=(A[t][19:0]==j)；两者同accept、同保持，故有效wen时match_j[t]=(addr[t][19:0]==j)。不把旧addr多延一拍，不改wen、ADC数据通路、CSR生效、触发优先级或字节语义；新增串行周期0。合法复位/控制下未知地址比较也严格四态保留。
4. 冻结R38完整Scope/bridge独立原生对照，扩充全部配置/控制寄存器逐拍检查，四种sys/ADC相位、地址高位别名/非法/未知、热写/读回、源忙时载荷变动与协调复位。原全套功能、14/25位、AXI/CDC/CSR回归另完整再跑。
5. 实际网表确认源FCLK译码FF存在、输入建立/输出保持及ADC CE路径；相同XDC/8ns完整综合/布局/route，报告输入SHA/CDC/DRC/覆盖。预译码不是2FF同步器或物理CDC证明；新路径预算仍须签核。
6. 若WNS/TNS恶化保留源码和诊断不合并；不false/multicycle/降频、不降低阶数或吞吐、不增反馈流水级，不部署/不操作激光。
