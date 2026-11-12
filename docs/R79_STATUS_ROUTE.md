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
