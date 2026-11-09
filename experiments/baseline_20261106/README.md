# 优化前基线归档

此目录是历史证据与候选副本，原工程有效源码已保存到 GitHub
`backup/20261106-pre-optimization`，提交 `a39000a802c27e0b6a904491ced4adaaceadfa35`。

- `source_manifest.json` 记录原目录有效源码逐文件 SHA256。
- `top.v`、`top.xdc`、Tcl 和 ZIP 为当时生成产物/报告，不代表当前分支已时序签核。
- `ce_candidate/` 是旧的实验候选，其中非法分频停更策略不同于本优化分支。
- `pid_reference.py`、`limit_reference.py` 是从基线提交复制的差分参考，不参与生产RTL生成。
- **不要直接执行本目录历史 PowerShell/Tcl 脚本**：部分脚本写死原目录并临时覆盖源码，归档仅供审查。

新的隔离流程使用仓库根的 `tools/run_gateware_trial.py`；它复制 PS 输入到每轮目录、记录日志、校验 CSR map 和源码哈希，并分别报告功能、综合、实现与签核状态。环境版本见根目录 `requirements-gateware.lock.txt`。
