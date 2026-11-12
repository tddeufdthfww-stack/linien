# R79：唯一内部状态路径的物理收敛候选

## R79冻结物理候选输入 / 2026-11-12

R78输入cbdbc736119c699c9022598afa7a6442b9783845 actual DCP SHA256=697b393c087361d7c8356967a2a4fcff35d9243f1a724b3ee79bf03e9b7f6f12。
R78生成/CSR语义PASS、新综合-.773/-76.419ns、285setup；actual route -.343/-4.097ns，15setup，hold+.038/0，pulse1.5。
仅剩14DAC必要模型端点及1条autolock prefetch_choice_reg[1]/C→gpio_n_o_reg[7]/D -.122ns，8.022ns（logic2.395/net5.627），10级4CARRY4+2LUT3+3LUT5+LUT6。
全部负端点无PID/IIR/Demod/limit，当前整体仍FAIL，不能当作可上板。GPIO终点为同步FF/D，不能当作外部异步端口免检。
本轮仅placement/routing/critical_pin、再route Explore，保持全部时钟域/IO/例外预算；综合明确REUSED_R78。
不改RTL、不增加寄存器、retime、FF插入、DSP寄存器搬移、复制、rewire或clock_opt。
前后funcsim导出在保留INIT/所有逻辑参数和实际端口条件下严格比较，仅去已明确物理注释；失败则保留，不认可等价。
功能引用新R78限幅14/25位72000拍+FastChain32000拍定向PASS；R78同RAW源fresh完整回归正在独立trial运行，尚不称PASS。
新增正常反馈周期0，继承R2b+32ns，真实总ADC-DAC延迟未测。实际新route/STA/CDC/DRC/IO待结果，无bitstream/板卡操作。

## R79 实际结论 / 2026-11-12

输入 a30b10b22cf4df04ae3187b4e2208ab7a1261ca7。综合REUSED_R78，不是新综合；实际route COMPLETE：WNS/TNS=-0.343/-4.453ns，23 setup端点，WHS/THS=0.038/0.0ns、0 hold端点，WPWS=1.5ns。最终STA FAIL。

R78 fresh完整功能全部PASS，含pytest/慢CE/快慢PID/Scope/AXI背压/CDC故障与集成，以及R75乘数交换、R77 Demod和R78限幅/FastChain；完整manifest input=cbdbc736119c699c9022598afa7a6442b9783845、source_changes=[]。R79硬件RAW相同，仅引用这次全功能和严格导出逻辑一致PASS，不冒称重新跑过。

R79 status最差改善至-.090ns，但全局TNS/端点相对R78恶化，REJECTED_NOT_SELECTED；保留全部失败源与诊断，不合并。

ADC全部28条setup+.429/hold+3.304ns、同字0/-8ns关系逐条PASS；52ASYNC/26同SLICE双级结构PASS、GPIO16对级间setup+7.193/hold+.122ns。这些不等于整体CDC/板级IO安全。DAC必要零PCB模型setup-.343/hold+.070ns；完整CLK/WRT/SEL、外部脉宽、真实PCB/SI及接口用途仍待签核，DRC405警告/建议须分类。全部原件见experiments/r79_actual_and_full_reference_20261112，DCP SHA256=78386d8af91735764ea9c8f9a7ea3189ebddb0b442253ec1998e05e6c6c693e0。

本轮新增反馈整数周期0，继承相对R2b+32ns；实际端到端与真实锁频带宽NOT MEASURED。无bitstream发布/烧录/激光/PZT操作。
