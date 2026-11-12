# R80：原状态端点的局部放置

## R80四单元定向物理候选 / 2026-11-12

从较好R78原DCP697b393c...开始，不采用R79 -.343/-4.453ns、23端点的整体恶化结果。
R78只剩14DAC及1条status -.122ns。实际链末级_i2 LUT6在X81Y112、_i1 LUT5在X84Y112，
两个同数据FDRE原均X85Y112，C=sys_clk/R=dac_rst_OBUF/CE1；关键状态计算在X53-58Y121-130。
只读查询确认SLICE_X67Y118完全空闲，所有BEL空；实际place_cell 2020帮助明确平铺cell/site配对。
本轮仅移动4个既有单元：_i2到A6LUT、_i1到B6LUT、原FF到BFF、同数据副本到CFF，固定LOC/BEL后route Explore。
不增删/复制/retime寄存器，不改逻辑、采样周期、RESET、CSR、时钟、IO预算或例外。
输入SHA必须精确匹配，目标slice非空则报错。保存前后LOC/BEL，完整funcsim严格逻辑比较并保留所有INIT/DSP/实际端口。
如出现不同逻辑、全局STA/hold恶化或其它新违例，保留结果不采用；不以局部改善冒称最终签核。
源hardware RAW同R78；综合REUSED_R78，R78fresh全功能仍运行待结果。新增正常反馈周期0，继承R2b+32ns。
全部原只读几何/命令帮助在experiments/r80_readonly_geometry_20261112；无bitstream/板卡/激光/PZT操作。

## R80 实际：内部时序闭合；外部DAC仍FAIL / 2026-11-12

输入c106507ef3710868774e6fc8e7a80aff6b584179，仅移动两个末级LUT和两个既有FDRE到已核实空闲SLICE_X67Y118，再route。整体WNS/TNS=-.343/-3.974ns、14 setup端点，全部14 DAC；WHS/THS+.038/0、0 hold端点，WPWS+1.500ns。内部clk_2建立WNS+.055/TNS0、0端点；最差IIR DSP低段到y2[10]/CE，logic5.848+route1.670ns。GPIO原问题转为+.163ns。内部无时钟0、内部未约束0；所有已约束时钟仍完整检查。

综合REUSED_R78（新综合来源-.773/-76.419ns、285端点），不是本轮新综合。R78输入cbdbc736119c699c9022598afa7a6442b9783845 fresh完整功能全部PASS；R80硬件RAW逐文件一致，导出逻辑逐token严格一致，引用完整功能不冒称重跑。R79整体恶化结果70a3c151已归档，不采用。R78最终完整记录b0ddee2a已归档。原始strict空闲RDATA差分FAIL及后续有效响应契约区分保留。

ADC28 setup+.429/hold+3.304ns，同字0/-8ns逐条PASS；52ASYNC/26同SLICE配对，首Q只到次D，GPIO16对级间setup+7.193/hold+.122ns。新增v4只读分类器核查Scope address0 arm、28 average和30 filter-aa的确切wen守卫，当前导出剩余未分类0；原v3 FAIL保留。这不是整体物理CDC或数值MTBF签核。

DAC必要零PCB模型setup-.343/hold+.070ns。独立额外协议检查：SEL在两个时钟上升之前+.673ns；SEL在前一个下降之后-.883ns FAIL；CLK提前WRT至少.5ns的模型-.829ns FAIL；CLK在前一WRT之后2ns keepout模型+.644ns。诊断仅在内存加真实协议必要检查，原DCP/XDC/SHA未变。2021 ADI官方答复明确Table3的1.5ns tH是DATA相对WRT上升，不等于图64 SEL的tH*；SEL必须在CLK/WRT均低时变化，因此不能擅自对SEL加1.5ns，也不能删去实际低电平窗口检查。AD9767外部3.5ns高脉宽与250MHz/50%名义2ns仍未取得适用模式的数值澄清；真实PCB/SI、DIO用途未签核。

bitstream DRC405项=184 DPIP-1、56 DPOP-1、91 DPOP-2、1 DPREG-4、1 RTSTAT-10警告，加70 AVAL-4、2 REQP-20建议。实际p_1_out的OPMODE={0,q,q,0,1,0,1}，稳定q=0/1只会选Z=000/011(0/C)，不会选P；该稳定二态结论不是选择脚瞬态/四态上电证明，不做全局waiver。没有新增反馈级：本轮0周期，累计R2b+4周期/+32ns，实际全链路与闭环带宽尚未实测。

原件/输入SHA/逻辑证明/实际DCP及额外协议检查在experiments/r80_actual_internal_closure_20261112；DCP SHA256=82adfcf0187ddf27c15c5cc54f8cfcbf9a9279faa3fe3443886e752b65f13273。保留R80内部改善候选，最终STA/IO/物理CDC/DRC仍FAIL或OPEN，不合并为正式上板版，不生成/发布bit/bin，不操作板卡/激光/PZT。

后续最有意义的是独立DAC区域MMCM/HPC->BUFIO分配实验，SYS/PS7/ADC原PLL不动；同时核对WRT数据窗口、SEL低窗、CLK先后、锁定复位与A/B字序。不能继续只优化PID或通过放宽约束消除DAC违例。时钟结构改善也不能替代外部脉宽数值规格及真实PCB依据。

一手澄清：https://ez.analog.com/data_converters/high-speed_dacs/f/q-a/164567/ad9763-ad9765-ad9767-interleaved-mode-with-125-msps-update-rate-possible/380408
DSP模式表：https://docs.amd.com/v/u/en-US/ug479_7Series_DSP48E1
