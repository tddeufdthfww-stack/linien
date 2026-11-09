# R3 失败候选证据 / 2026-11-09

状态REJECTED，不合并R2b。代码提交d57c0e2ada0dd57f72d29f1c380a444c323128dd，原工程与R2b保持不变，STA未通过。

- pid_borrow_select_rejected.py是本次测试的原始字节副本，SHA与manifest一致；不要覆盖基线。
- metrics.json包括全部输入source_hashes、工具/命令/退出码/显式PASS、综合与route各指标、快慢PID全组和积分子集的路径、CDC原始/规范化差集。
- r3_candidate_logs_reports.zip包括本轮功能、生成、综合、实际route报告、top.v/XDC、manifest、执行脚本和只读细节；DCP/PS生成缓存不上传。
- r2b_readonly_diagnostics.zip包括基线只读报告、真实DSP端口及同步set/reset映射、两次失败工具API诊断及修正后PASS。
- archive_manifest.json给出ZIP SHA256；所有ZIP已testzip完整性检查通过。
- collect_metrics.py是本机本次审计采集脚本，含明确绝对路径；使用前检查路径，不是构建入口。构建/只读复现命令见docs/R3_RESULT_20261109.md。

功能PASS、综合COMPLETE、route COMPLETE、最终Setup FAIL；CDC/I/O/DRC未签核；形式等价/上板/bitstream/激光闭环NOT RUN。没有新增流水线。
