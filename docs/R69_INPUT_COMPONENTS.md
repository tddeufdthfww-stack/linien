# 当前输入组件清单（R69，2026-11-12）

本文件覆盖历史计划中的“待运行”字样；不表示候选已签核。

| 组件/轮次 | 实际结果 | 本输入选择 |
|---|---|---|
| R65 SDR DAC | analog PASS；route -.683/-55.023，hold+.024 | SDR表达经R66继承 |
| R66 DAC phase-history | 全功能fresh PASS；route -.343/-6.398，47端点，hold+.024 | 当前analog原件RAW一致，无新增数据级 |
| R67 PS reset | 实际CRG/reset/wiring PASS，新综合COMPLETE；独立route/full NOT RUN | 当前CRG原件RAW一致，AXI仍用sys_ps同步reset |
| R68 positive clock encoding | 原生4包络/实际PLL PASS；route -.829/-16.583，hold-.412 | REJECTED；当前恢复R67 clock/约束原件 |
| R69 timeout cancel | 新8情景×4相位32例及actual Root wiring PASS；full/route待运行 | 候选，不能部署 |

R66输入代码decd142b1f1f98f736efc15ce7861a3bc541d71e，完整证据记录e99b61cfabcdbdae148a744ba0c47d5a1bf6c5ab。
R67输入78cd9df89241e02401733c9ba7b2931390f037a0，组件证据记录f0008c1f26ec5a543edd79260a4829c213ba0977。
R68输入82924f5deaf33d20255def030599c162a264973d，失败原件/完整物理报告在其独立分支experiments/r68_rejected_positive_forward_20261112；不回写覆盖失败现场。

主反馈相对R2b继承+32ns，本R65～R69新增数据串行级0；PS复位释放新增两FCLK等待、取消后源桥ready沿用两边沿恢复，仅影响复位/取消窗口。绝对ADC→DAC板端端到端延迟未实测，不能将相对新增32ns说成总延迟或已验证锁频带宽。

仍需DAC数据/SEL/CLK-WRT/pulse/PCB、内部残余负裕量、接口coverage分类和物理CDC/DRC闭合。未签发正式bit/bin、未上板、未接激光/PZT。

## 本次核心源文件SHA256

- `gateware/lowlevel/crg.py`：`3f0ec1d1728e8bfa969c924614068755e6cc108a344d0294e100066a8ee66e13`
- `gateware/lowlevel/analog.py`：`3475244acc8db791a7842fed98e6ac40284c7f571196ef15de70c053b3b527af`
- `gateware/lowlevel/pitaya_ps.py`：`e6032cdeb92bff655140646f56c3a5fa08d9887b88131ebe553789cf4e8ec7e5`
- `gateware/verilog/axi_slave.v`：`709cd2b9f5c5550c4c7a7a6a515bd4c8a6b021e2b148375b3e9b86ec61c7cc2b`
- `gateware/verilog/bus_clk_bridge.v`：`3030d286eaa1c12871f61b969398e51088489d9e3f80f88007e3a2d4a6675624`
- `gateware/constraints/io_intrinsic_probe.tcl`：`6c4496d69b95264d25d313a2ae47e1945345a7b18894f164d3316583697f78fb`
- `gateware/constraints/adc_same_word_capture.tcl`：`42045346f46b977eb8f453944b1e9b0efff48321377698485b3e1d1fd4c0387b`
