# R5 REJECTED / 2026-11-09

代码b5441cac571d6807564621f63effe43789e3a89f，不合并R4a。新比较器零新增周期，但全局route WNS/TNS恶化；原代码与候选单独存储。

- autolock_reference.py：冻结R4a源码，逐拍参考。
- autolock_rejected.py/magnitude_compare_rejected.py：实测失败候选源码，SHA与成功完整trial输入一致。
- metrics.json：全部输入SHA、命令/退出码/PASS、综合/route、快慢PID/DSP/robust路径和CDC原始/规范化/目标差集；元数据含ZIP SHA。
- r5_logs_reports.zip：完整功能、生成、综合、route、只读报告；含初次包元数据失败与真实安装日志。
- scope_cdc_fanin.zip：R4a/R5三个Scope CE完整起点集合比较，样本一致不等于物理CDC签核。
- final_verification.json：冻结工作树/168源/输入字节/新增延迟/FAIL与NOT RUN标记。

功能PASS（13pytest、48952比较向量、4200完整robust周期及全部既有套件）；综合/route COMPLETE；最终STA FAIL；物理CDC/I/O/DRC未签核；形式/板上/激光NOT RUN。DCP仅留本机。
