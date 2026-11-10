# R14：自动锁定一级决策流水线 + R13已验证慢支路候选

2026-11-10。独立分支，以R13代码f98d0d8为组合试验输入，不合并R13到R4a。R13全局WNS=-5.137劣于R4a，仍REJECTED；但完整负裕量清单中慢PID非CSR算术/数据端点0条，最差慢CSR为数据写路由9.766ns。保留其局部改动，独立研究全局autolock关键链。

## 架构比较与决定

A：SumDiff输出、请求/start/写事件/sweep方向和全部配置快照一起延后1sys=8ns；每条峰的abs/sign在输入侧算完寄存，以避免配置→Mux→abs→比较再形成长链。状态机的当前指令索引不加流水，以保留逐事件递推。B：再给比较/门控增加一级，决策+16ns；需要防止连续写事件用到上一条指令旧索引，不能简单寄存当前谓词。先实现A，B暂不实施。

数学参考是未改RobustAutolock作用于所有原始输入和CSR配置统一延迟1sys的系统。SumDiff内部仍使用原始流；其输出在边界寄存一次，等价于原SumDiff系统整体延迟一拍。当前指令索引递推按延迟后的同一事件序列执行，每拍吞吐不变，无额外反馈状态。abs28最小负数回绕、29位sumdiff、严格>0和waited_for>wait条件保持。

所有峰abs/sign与wait、N、final_wait每拍快照，CSR写保持活跃。全局reset清空在途令牌；CSR复位与部分字节热写都需差分验证。ROBUST_AUTOLOCK_FPGA_DELAY仍为3（采集事件单位），不把sys多一拍直接加到采集计数。FPGAAutolock的原始request关闭/模式选择门控不延迟，简单锁定路径不改。

持续反馈ADC→DAC路径相对R13新增0；robust锁定判定+8ns；R13慢反馈/analog0扫频已有额外16ns不再增加。初始锁定时机的8ns改变必须单列，不能宣称所有输出都原周期等价。全局reset取消在途事务，跨reset的波形平移不作承诺。

验证：冻结R4a Robust及utils，在真实CSRBank中同时测试生产FPGAAutolock父模块的请求取消/模式切换/lock_running，以及robust状态、阈值、监视输出。参考采用独立延迟原始输入/CSR的旧Robust，并非复制候选abs/register实现。生产RAM深度8191，未知RAM周期显式披露；持续/稀疏写、扫频方向/start、所有峰参数边界、复位和配置热写。然后重复R13/14全系统回归，CSR map/XDC，综合和实际route及CDC差集。STA/CDC/I/O未通过不部署。
