/* Machine-generated using Migen */
module regional_dac_pair(
	input adc_p,
	input adc_n,
	input ps_clk,
	input ps_reset,
	input [15:0] adc_data_a,
	input [15:0] adc_data_b,
	input signed [13:0] dac_a,
	input signed [13:0] dac_b,
	output sys_clk,
	output sys_rst,
	output [13:0] old_data,
	output old_rst,
	output old_sel,
	output old_clk,
	output old_wrt,
	output signed [13:0] old_adc_a,
	output signed [13:0] old_adc_b,
	output [13:0] new_data,
	output new_rst,
	output new_sel,
	output new_clk,
	output new_wrt,
	output new_data_clock,
	output new_locked,
	output signed [13:0] new_adc_a,
	output signed [13:0] new_adc_b
);

wire sys_double_clk;
wire dac_2p_clk;
wire sys_slow_clk;
wire sys_ps_clk;
wire sys_ps_rst;
wire __main___clk_adci;
wire __main___clk_adcb;
wire [5:0] __main___clk;
wire __main___clk_fb;
wire __main___clk_fbb;
wire __main___locked;
wire [15:0] __main___record0_adc_data_a;
wire [15:0] __main___record0_adc_data_b;
wire [1:0] __main___record0_adc_clk;
wire __main___record0_adc_cdcs;
wire signed [13:0] __main___dac_a;
wire signed [13:0] __main___dac_b;
wire [15:0] __main___adca;
wire [15:0] __main___adcb;
reg [13:0] __main___daca = 14'd0;
reg [13:0] __main___dacb = 14'd0;
reg __main___frame = 1'd0;
wire __main___frame_seen;
wire __main___select_b;
wire [13:0] __main___dac_word;
wire [15:0] __main___record1_adc_data_a;
wire [15:0] __main___record1_adc_data_b;
wire [1:0] __main___record1_adc_clk;
wire __main___record1_adc_cdcs;
wire dac_write_io_clk;
wire dac_sample_io_clk;
wire dac_select_io_clk;
wire dac_ready_clk;
wire dac_ready_rst;
wire pitayaanalog_dacregionalclock0;
wire pitayaanalog_dacregionalclock1;
wire pitayaanalog_dacregionalclock2;
wire pitayaanalog_dacregionalclock3;
wire pitayaanalog_dacregionalclock_feedback;
wire signed [13:0] pitayaanalog_dac_a;
wire signed [13:0] pitayaanalog_dac_b;
wire [15:0] pitayaanalog_adca;
wire [15:0] pitayaanalog_adcb;
reg [13:0] pitayaanalog_daca = 14'd0;
reg [13:0] pitayaanalog_dacb = 14'd0;
reg pitayaanalog_frame = 1'd0;
wire pitayaanalog_frame_seen;
wire pitayaanalog_select_b;
wire [13:0] pitayaanalog_dac_word;
wire xilinxasyncresetsynchronizerimpl0_rst_meta;
wire xilinxasyncresetsynchronizerimpl1;
wire xilinxasyncresetsynchronizerimpl1_rst_meta;
wire xilinxasyncresetsynchronizerimpl2;
wire xilinxasyncresetsynchronizerimpl2_rst_meta;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign __main___record0_adc_data_a = adc_data_a;
assign __main___record0_adc_data_b = adc_data_b;
assign __main___dac_a = dac_a;
assign __main___dac_b = dac_b;
assign __main___record1_adc_data_a = adc_data_a;
assign __main___record1_adc_data_b = adc_data_b;
assign pitayaanalog_dac_a = dac_a;
assign pitayaanalog_dac_b = dac_b;
assign sys_ps_clk = ps_clk;
assign __main___record0_adc_cdcs = 1'd1;
assign __main___record0_adc_clk = 2'd2;
assign old_adc_a = {__main___adca[15], (~__main___adca[14:2])};
assign old_adc_b = {__main___adcb[15], (~__main___adcb[14:2])};
assign __main___select_b = (__main___frame ^ __main___frame_seen);
assign __main___dac_word = (__main___select_b ? __main___dacb : __main___daca);
assign old_rst = sys_rst;
assign __main___record1_adc_cdcs = 1'd1;
assign __main___record1_adc_clk = 2'd2;
assign new_adc_a = {pitayaanalog_adca[15], (~pitayaanalog_adca[14:2])};
assign new_adc_b = {pitayaanalog_adcb[15], (~pitayaanalog_adcb[14:2])};
assign pitayaanalog_select_b = (pitayaanalog_frame ^ pitayaanalog_frame_seen);
assign pitayaanalog_dac_word = (pitayaanalog_select_b ? pitayaanalog_dacb : pitayaanalog_daca);
assign new_rst = dac_ready_rst;
assign dac_ready_clk = sys_clk;
assign xilinxasyncresetsynchronizerimpl1 = (ps_reset | (~__main___locked));
assign xilinxasyncresetsynchronizerimpl2 = (sys_rst | (~new_locked));

always @(posedge sys_clk) begin
	__main___daca <= {__main___dac_a[13], (~__main___dac_a[12:0])};
	__main___dacb <= {__main___dac_b[13], (~__main___dac_b[12:0])};
	__main___frame <= (~__main___frame);
	pitayaanalog_daca <= {pitayaanalog_dac_a[13], (~pitayaanalog_dac_a[12:0])};
	pitayaanalog_dacb <= {pitayaanalog_dac_b[13], (~pitayaanalog_dac_b[12:0])};
	pitayaanalog_frame <= (~pitayaanalog_frame);
	if (sys_rst) begin
		__main___daca <= 14'd0;
		__main___dacb <= 14'd0;
		pitayaanalog_daca <= 14'd0;
		pitayaanalog_dacb <= 14'd0;
	end
end

IBUFGDS IBUFGDS(
	.I(adc_p),
	.IB(adc_n),
	.O(__main___clk_adci)
);

BUFG BUFG(
	.I(__main___clk_adci),
	.O(__main___clk_adcb)
);

PLLE2_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKFBOUT_MULT(4'd8),
	.CLKFBOUT_PHASE(0.0),
	.CLKIN1_PERIOD(8.0),
	.CLKOUT0_DIVIDE(2'd2),
	.CLKOUT0_DUTY_CYCLE(0.5),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_DIVIDE(3'd4),
	.CLKOUT1_DUTY_CYCLE(0.5),
	.CLKOUT1_PHASE(0.0),
	.CLKOUT2_DIVIDE(4'd8),
	.CLKOUT2_DUTY_CYCLE(0.5),
	.CLKOUT2_PHASE(0.0),
	.CLKOUT3_DIVIDE(7'd120),
	.CLKOUT3_DUTY_CYCLE(0.5),
	.CLKOUT3_PHASE(0.0),
	.CLKOUT4_DIVIDE(3'd4),
	.CLKOUT4_DUTY_CYCLE(0.5),
	.CLKOUT4_PHASE(-45.0),
	.CLKOUT5_DIVIDE(3'd4),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT5_PHASE(0.0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_BASE (
	.CLKFBIN(__main___clk_fbb),
	.CLKIN1(__main___clk_adcb),
	.PWRDWN(1'd0),
	.RST(ps_reset),
	.CLKFBOUT(__main___clk_fb),
	.CLKOUT0(__main___clk[0]),
	.CLKOUT1(__main___clk[1]),
	.CLKOUT2(__main___clk[2]),
	.CLKOUT3(__main___clk[3]),
	.CLKOUT4(__main___clk[4]),
	.CLKOUT5(__main___clk[5]),
	.LOCKED(__main___locked)
);

BUFG BUFG_1(
	.I(__main___clk_fb),
	.O(__main___clk_fbb)
);

BUFG BUFG_2(
	.I(__main___clk[1]),
	.O(sys_double_clk)
);

BUFG BUFG_3(
	.I(__main___clk[2]),
	.O(sys_clk)
);

BUFG BUFG_4(
	.I(__main___clk[3]),
	.O(sys_slow_clk)
);

BUFG BUFG_5(
	.I(__main___clk[4]),
	.O(dac_2p_clk)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[0]),
	.R(sys_rst),
	.Q(__main___adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_1 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[1]),
	.R(sys_rst),
	.Q(__main___adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[2]),
	.R(sys_rst),
	.Q(__main___adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[3]),
	.R(sys_rst),
	.Q(__main___adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_4 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[4]),
	.R(sys_rst),
	.Q(__main___adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_5 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[5]),
	.R(sys_rst),
	.Q(__main___adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_6 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[6]),
	.R(sys_rst),
	.Q(__main___adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_7 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[7]),
	.R(sys_rst),
	.Q(__main___adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_8 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[8]),
	.R(sys_rst),
	.Q(__main___adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_9 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[9]),
	.R(sys_rst),
	.Q(__main___adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_10 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[10]),
	.R(sys_rst),
	.Q(__main___adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_11 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[11]),
	.R(sys_rst),
	.Q(__main___adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_12 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[12]),
	.R(sys_rst),
	.Q(__main___adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_13 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[13]),
	.R(sys_rst),
	.Q(__main___adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_14 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[14]),
	.R(sys_rst),
	.Q(__main___adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_15 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_a[15]),
	.R(sys_rst),
	.Q(__main___adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_16 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[0]),
	.R(sys_rst),
	.Q(__main___adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_17 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[1]),
	.R(sys_rst),
	.Q(__main___adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_18 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[2]),
	.R(sys_rst),
	.Q(__main___adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_19 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[3]),
	.R(sys_rst),
	.Q(__main___adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_20 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[4]),
	.R(sys_rst),
	.Q(__main___adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_21 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[5]),
	.R(sys_rst),
	.Q(__main___adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_22 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[6]),
	.R(sys_rst),
	.Q(__main___adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_23 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[7]),
	.R(sys_rst),
	.Q(__main___adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_24 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[8]),
	.R(sys_rst),
	.Q(__main___adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_25 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[9]),
	.R(sys_rst),
	.Q(__main___adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_26 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[10]),
	.R(sys_rst),
	.Q(__main___adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_27 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[11]),
	.R(sys_rst),
	.Q(__main___adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_28 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[12]),
	.R(sys_rst),
	.Q(__main___adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_29 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[13]),
	.R(sys_rst),
	.Q(__main___adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_30 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[14]),
	.R(sys_rst),
	.Q(__main___adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_31 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record0_adc_data_b[15]),
	.R(sys_rst),
	.Q(__main___adcb[15])
);

FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_32 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___frame),
	.R(1'd0),
	.Q(__main___frame_seen)
);

ODDR ODDR(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(old_clk)
);

ODDR ODDR_1(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(old_wrt)
);

ODDR ODDR_2(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(old_sel)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_33 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[0]),
	.R(1'd0),
	.Q(old_data[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_34 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[1]),
	.R(1'd0),
	.Q(old_data[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_35 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[2]),
	.R(1'd0),
	.Q(old_data[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_36 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[3]),
	.R(1'd0),
	.Q(old_data[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_37 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[4]),
	.R(1'd0),
	.Q(old_data[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_38 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[5]),
	.R(1'd0),
	.Q(old_data[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_39 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[6]),
	.R(1'd0),
	.Q(old_data[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_40 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[7]),
	.R(1'd0),
	.Q(old_data[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_41 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[8]),
	.R(1'd0),
	.Q(old_data[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_42 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[9]),
	.R(1'd0),
	.Q(old_data[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_43 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[10]),
	.R(1'd0),
	.Q(old_data[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_44 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[11]),
	.R(1'd0),
	.Q(old_data[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_45 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[12]),
	.R(1'd0),
	.Q(old_data[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_46 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(__main___dac_word[13]),
	.R(1'd0),
	.Q(old_data[13])
);

MMCME2_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKFBOUT_MULT_F(8.0),
	.CLKIN1_PERIOD(8.0),
	.CLKOUT0_DIVIDE_F(4.0),
	.CLKOUT0_PHASE(-45.0),
	.CLKOUT1_DIVIDE(3'd4),
	.CLKOUT1_PHASE(-22.5),
	.CLKOUT2_DIVIDE(3'd4),
	.CLKOUT2_PHASE(-135.0),
	.CLKOUT3_DIVIDE(4'd8),
	.CLKOUT3_PHASE(5.625),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) MMCME2_BASE (
	.CLKFBIN(pitayaanalog_dacregionalclock_feedback),
	.CLKIN1(sys_clk),
	.PWRDWN(1'd0),
	.RST(sys_rst),
	.CLKFBOUT(pitayaanalog_dacregionalclock_feedback),
	.CLKOUT0(pitayaanalog_dacregionalclock0),
	.CLKOUT1(pitayaanalog_dacregionalclock1),
	.CLKOUT2(pitayaanalog_dacregionalclock2),
	.CLKOUT3(pitayaanalog_dacregionalclock3),
	.LOCKED(new_locked)
);

BUFIO BUFIO(
	.I(pitayaanalog_dacregionalclock0),
	.O(new_data_clock)
);

BUFIO BUFIO_1(
	.I(pitayaanalog_dacregionalclock1),
	.O(dac_write_io_clk)
);

BUFIO BUFIO_2(
	.I(pitayaanalog_dacregionalclock2),
	.O(dac_sample_io_clk)
);

BUFIO BUFIO_3(
	.I(pitayaanalog_dacregionalclock3),
	.O(dac_select_io_clk)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_47 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[0]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_48 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[1]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_49 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[2]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_50 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[3]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_51 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[4]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_52 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[5]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_53 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[6]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_54 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[7]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_55 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[8]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_56 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[9]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_57 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[10]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_58 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[11]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_59 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[12]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_60 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[13]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_61 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[14]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_62 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_a[15]),
	.R(sys_rst),
	.Q(pitayaanalog_adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_63 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[0]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_64 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[1]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_65 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[2]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_66 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[3]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_67 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[4]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_68 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[5]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_69 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[6]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_70 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[7]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_71 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[8]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_72 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[9]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_73 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[10]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_74 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[11]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_75 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[12]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_76 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[13]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_77 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[14]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_78 (
	.C(sys_clk),
	.CE(1'd1),
	.D(__main___record1_adc_data_b[15]),
	.R(sys_rst),
	.Q(pitayaanalog_adcb[15])
);

FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_79 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog_frame),
	.R(1'd0),
	.Q(pitayaanalog_frame_seen)
);

ODDR ODDR_3(
	.C(dac_sample_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(new_clk)
);

ODDR ODDR_4(
	.C(dac_write_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(new_wrt)
);

ODDR ODDR_5(
	.C(dac_select_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(new_sel)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_80 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[0]),
	.R(1'd0),
	.Q(new_data[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_81 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[1]),
	.R(1'd0),
	.Q(new_data[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_82 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[2]),
	.R(1'd0),
	.Q(new_data[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_83 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[3]),
	.R(1'd0),
	.Q(new_data[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_84 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[4]),
	.R(1'd0),
	.Q(new_data[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_85 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[5]),
	.R(1'd0),
	.Q(new_data[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_86 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[6]),
	.R(1'd0),
	.Q(new_data[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_87 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[7]),
	.R(1'd0),
	.Q(new_data[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_88 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[8]),
	.R(1'd0),
	.Q(new_data[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_89 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[9]),
	.R(1'd0),
	.Q(new_data[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_90 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[10]),
	.R(1'd0),
	.Q(new_data[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_91 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[11]),
	.R(1'd0),
	.Q(new_data[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_92 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[12]),
	.R(1'd0),
	.Q(new_data[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_93 (
	.C(new_data_clock),
	.CE(1'd1),
	.D(pitayaanalog_dac_word[13]),
	.R(1'd0),
	.Q(new_data[13])
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(ps_reset),
	.Q(xilinxasyncresetsynchronizerimpl0_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_1 (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl0_rst_meta),
	.PRE(ps_reset),
	.Q(sys_ps_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(xilinxasyncresetsynchronizerimpl1_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl1_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(sys_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_4 (
	.C(dac_ready_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl2),
	.Q(xilinxasyncresetsynchronizerimpl2_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_5 (
	.C(dac_ready_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl2_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl2),
	.Q(dac_ready_rst)
);

endmodule
