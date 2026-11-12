// R86 characterization ONLY. No PS, ADC or PID source is changed.
// BBAA overlap frames: direct pre-register A/B capture, exact old-A/new-B schedule.
// Actual aligned SDR4 latency is 4 CLK=8ns; DIV at SYS-4.5 -> B at +3.5, A at +7.5.
`timescale 1ns/1ps
module dac_common_sdr4_probe #(parameter USE_SERDES=1)(
 input clk125_p,input clk125_n,input reset_i,
 output [13:0]dac_data,output dac_wrt,output dac_clk,
 output dac_sel,output dac_rst
);
 wire clk_in,sys_clk;
 IBUFDS input_clock(.I(clk125_p),.IB(clk125_n),.O(clk_in));
 BUFG system_clock(.I(clk_in),.O(sys_clk));
 wire feedback,locked,c0,c1,c2,c3,c4;
 wire io_clk,io_div,sample_clk,sample_div,fabric_double;
 MMCME2_BASE #(.BANDWIDTH("OPTIMIZED"),.CLKIN1_PERIOD(8.0),
  .DIVCLK_DIVIDE(1),.CLKFBOUT_MULT_F(8.0),
  .CLKOUT0_DIVIDE_F(2.0),.CLKOUT0_PHASE(-90.0),
  .CLKOUT1_DIVIDE(8),.CLKOUT1_PHASE(-202.5),
  .CLKOUT2_DIVIDE(4),.CLKOUT2_PHASE(-135.0),
  .CLKOUT3_DIVIDE(8),.CLKOUT3_PHASE(-247.5),
  .CLKOUT4_DIVIDE(4),.CLKOUT4_PHASE(0.0),.STARTUP_WAIT("FALSE"))
 clock_manager(.CLKIN1(sys_clk),.CLKFBIN(feedback),.CLKFBOUT(feedback),
  .CLKOUT0(c0),.CLKOUT1(c1),.CLKOUT2(c2),.CLKOUT3(c3),.CLKOUT4(c4),
  .LOCKED(locked),.PWRDWN(1'b0),.RST(reset_i));
 BUFIO data_clock(.I(c0),.O(io_clk));
 BUFR #(.BUFR_DIVIDE("BYPASS"),.SIM_DEVICE("7SERIES"))
 data_divider(.I(c1),.O(io_div),.CE(1'b1),.CLR(1'b0));
 BUFIO sample_clock(.I(c2),.O(sample_clk));
 BUFR #(.BUFR_DIVIDE("BYPASS"),.SIM_DEVICE("7SERIES"))
 sample_divider(.I(c3),.O(sample_div),.CE(1'b1),.CLR(1'b0));
 BUFG reference_double(.I(c4),.O(fabric_double));
 wire bad_clock=reset_i|~locked;
 wire sys_rst,data_rst,sample_rst;
 r86_reset_sync sys_reset(.clk(sys_clk),.arst(bad_clock),.rst(sys_rst));
 r86_reset_sync data_reset(.clk(io_div),.arst(bad_clock),.rst(data_rst));
 r86_reset_sync sample_reset(.clk(sample_div),.arst(bad_clock),.rst(sample_rst));
 wire lock_reset;
 r86_reset_sync dac_reset(.clk(sys_clk),.arst(bad_clock),.rst(lock_reset));
 // Clock-domain startup wait, no CLKDIV-reset->SYS asynchronous PRE fan-in.
 // Minimum 16 stable SYS clocks is longer than both serializer reset releases.
 reg[4:0]startup_count=0;reg startup_busy=1;
 always@(posedge sys_clk)begin
  if(sys_rst)begin startup_count<=0;startup_busy<=1;end
  else if(startup_count<16)startup_count<=startup_count+1'b1;
  else startup_busy<=0;
 end
 assign dac_rst=lock_reset|startup_busy;
 reg[13:0]counter=0,a_hold=0,b_hold=0;
 always@(posedge sys_clk)begin
  if(sys_rst)begin counter<=0;a_hold<=0;b_hold<=0;end
  else begin counter<=counter+1'b1;a_hold<=counter;b_hold<=~counter;end
 end
 wire[13:0]b_now=~counter;
 generate if(USE_SERDES)begin:serdes
  genvar bit_index;
  for(bit_index=0;bit_index<14;bit_index=bit_index+1)begin:bits
   r86_sdr4 output_data(.clk(io_clk),.div(io_div),.rst(data_rst),
     .a(counter[bit_index]),.b(b_now[bit_index]),.q(dac_data[bit_index]));
  end
  r86_sdr4 output_select(.clk(io_clk),.div(io_div),.rst(data_rst),
    .a(1'b0),.b(1'b1),.q(dac_sel));
  r86_sdr4 #(.CLOCK_PATTERN(1)) output_write(.clk(io_clk),.div(io_div),.rst(data_rst),
    .a(1'b0),.b(1'b1),.q(dac_wrt));
  ODDR output_sample(.C(sample_clk),.D1(1'b0),.D2(1'b1),.CE(1'b1),.R(1'b0),.S(1'b0),.Q(dac_clk));
 end else begin:reference
  reg frame=0;always@(posedge sys_clk)frame<=~frame;
  wire frame_seen;wire select_b=frame^frame_seen;
  FDRE #(.INIT(1'b0)) frame_copy(.C(fabric_double),.CE(1'b1),.R(1'b0),.D(frame),.Q(frame_seen));
  wire[13:0]word_value=select_b?b_hold:a_hold;
  genvar bit_index;
  for(bit_index=0;bit_index<14;bit_index=bit_index+1)begin:bits
   (* IOB="TRUE" *)FDRE #(.INIT(1'b0)) output_data(
     .C(io_clk),.CE(1'b1),.R(1'b0),.D(word_value[bit_index]),.Q(dac_data[bit_index]));
  end
  (* IOB="TRUE" *)FDRE #(.INIT(1'b0)) output_select(
    .C(io_clk),.CE(1'b1),.R(1'b0),.D(select_b),.Q(dac_sel));
  ODDR output_write(.C(io_clk),.D1(1'b0),.D2(1'b1),.CE(1'b1),.R(1'b0),.S(1'b0),.Q(dac_wrt));
  ODDR output_sample(.C(sample_clk),.D1(1'b0),.D2(1'b1),.CE(1'b1),.R(1'b0),.S(1'b0),.Q(dac_clk));
 end endgenerate
endmodule

module r86_reset_sync(input clk,input arst,output rst);
 (* ASYNC_REG="TRUE",SHREG_EXTRACT="NO" *)wire meta;
 (* ASYNC_REG="TRUE",SHREG_EXTRACT="NO" *)
 FDPE #(.INIT(1'b1)) first(.C(clk),.CE(1'b1),.PRE(arst),.D(1'b0),.Q(meta));
 (* ASYNC_REG="TRUE",SHREG_EXTRACT="NO" *)
 FDPE #(.INIT(1'b1)) second(.C(clk),.CE(1'b1),.PRE(arst),.D(meta),.Q(rst));
endmodule

module r86_sdr4 #(parameter CLOCK_PATTERN=0)(input clk,input div,input rst,input a,input b,output q);
 OSERDESE2 #(.DATA_RATE_OQ("SDR"),.DATA_WIDTH(4),.DATA_RATE_TQ("BUF"),
  .TRISTATE_WIDTH(1),.SERDES_MODE("MASTER"),.INIT_OQ(1'b0),.SRVAL_OQ(1'b0))
 serializer(.CLK(clk),.CLKDIV(div),.RST(rst),.OCE(1'b1),
  .D1(CLOCK_PATTERN?a:b),.D2(b),.D3(a),.D4(CLOCK_PATTERN?b:a),.D5(1'b0),.D6(1'b0),.D7(1'b0),.D8(1'b0),
  .T1(1'b0),.T2(1'b0),.T3(1'b0),.T4(1'b0),.TCE(1'b0),.TBYTEIN(1'b0),
  .SHIFTIN1(1'b0),.SHIFTIN2(1'b0),.OQ(q));
endmodule
