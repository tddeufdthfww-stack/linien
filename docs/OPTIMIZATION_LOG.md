# 优化记录

## 2026-11-06 / 基线归档

- 原工程：`D:\RP_Dev\linien-v2.1.0`，保持原工作树不动。
- GitHub 备份：`backup/20261106-pre-optimization`，提交 `a39000a802c27e0b6a904491ced4adaaceadfa35`。
- 包含当前有效源码、测试、移植文档、CE 候选、历史关键报告、PS BD/wrapper 与源码 SHA256 清单。
- 优化分支：`opt/ce-saturation-20261106`；全部候选均在独立副本进行。
- 基线状态：有历史功能/综合/route 证据，最终 STA 未签核。

## 2026-11-09 / R0 隔离构建与回归准备

- 状态：RUNNING，未宣称测试或时序通过。
- `gateware/fpga_image_helper.py`：PS BD 默认使用仓库快照输入，并支持 `LINIEN_PS_BD`、`LINIEN_FPGA_BUILD_DIR`、`LINIEN_CSRMAP_OUTPUT`；试验可将所有生成文件写入新目录。
- `tools/run_gateware_trial.py`：独立输出与 PS 副本、源码哈希、stdout/stderr/退出码、功能标记、综合与 route 分阶段记录；不生成 bitstream。
- 后续候选：CE 数据寄存器使能（不冻结 CSR）、零新增延迟的积分饱和判定化简。
- 反馈延迟：R0 不改算法时序；CE 的 k=0 +4 ns 采样差异单独记录；本轮不插入反馈流水线。
- 环境：新建 Python 3.10.21 虚拟环境；uv 安装因 SciPy TLS 下载错误失败，改用 pip 和本机缓存，完整日志保留。
