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
