/* Machine-generated using Migen */
module actual_pll_analog_pair(
	input adc_p,
	input adc_n,
	input ps_clk,
	input ps_reset,
	input [15:0] adc_data_a,
	input [15:0] adc_data_b,
	input signed [13:0] dac_a,
	input signed [13:0] dac_b,
	output old_sys_clk,
	output old_sys_rst,
	output old_locked,
	output [48:0] old_outputs,
	output new_sys_clk,
	output new_sys_rst,
	output new_locked,
	output [48:0] new_outputs
);

wire old_sys_double_clk;
wire old_dac_2p_clk;
wire old_sys_slow_clk;
wire old_sys_ps_clk;
wire old_sys_ps_rst;
wire crg0_clk_adci;
wire crg0_clk_adcb;
wire [5:0] crg0_clk;
wire crg0_clk_fb;
wire crg0_clk_fbb;
wire [15:0] record0_adc_data_a;
wire [15:0] record0_adc_data_b;
wire [1:0] record0_adc_clk;
wire record0_adc_cdcs;
wire [13:0] record0_dac_data;
wire record0_dac_rst;
wire record0_dac_sel;
wire record0_dac_clk;
wire record0_dac_wrt;
wire signed [13:0] pitayaanalog0_adc_a;
wire signed [13:0] pitayaanalog0_adc_b;
wire signed [13:0] pitayaanalog0_dac_a;
wire signed [13:0] pitayaanalog0_dac_b;
reg [15:0] pitayaanalog0_adca = 16'd0;
reg [15:0] pitayaanalog0_adcb = 16'd0;
reg [13:0] pitayaanalog0_daca = 14'd0;
reg [13:0] pitayaanalog0_dacb = 14'd0;
wire sys_double_clk;
wire dac_2p_clk;
wire dac_wrt_clk;
wire sys_slow_clk;
wire sys_ps_clk;
wire sys_ps_rst;
wire crg1_clk_adci;
wire crg1_clk_adcb;
wire [5:0] crg1_clk;
wire crg1_clk_fb;
wire crg1_clk_fbb;
wire [15:0] record1_adc_data_a;
wire [15:0] record1_adc_data_b;
wire [1:0] record1_adc_clk;
wire record1_adc_cdcs;
wire [13:0] record1_dac_data;
wire record1_dac_rst;
wire record1_dac_sel;
wire record1_dac_clk;
wire record1_dac_wrt;
wire signed [13:0] pitayaanalog1_adc_a;
wire signed [13:0] pitayaanalog1_adc_b;
wire signed [13:0] pitayaanalog1_dac_a;
wire signed [13:0] pitayaanalog1_dac_b;
wire [15:0] pitayaanalog1_adca;
wire [15:0] pitayaanalog1_adcb;
reg [13:0] pitayaanalog1_daca = 14'd0;
reg [13:0] pitayaanalog1_dacb = 14'd0;
reg pitayaanalog1_frame = 1'd0;
wire pitayaanalog1_frame_seen;
wire pitayaanalog1_select_b;
wire [13:0] pitayaanalog1_dac_word;
wire xilinxasyncresetsynchronizerimpl0_rst_meta;
wire xilinxasyncresetsynchronizerimpl1;
wire xilinxasyncresetsynchronizerimpl1_rst_meta;
wire xilinxasyncresetsynchronizerimpl2_rst_meta;
wire xilinxasyncresetsynchronizerimpl3;
wire xilinxasyncresetsynchronizerimpl3_rst_meta;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign record0_adc_data_a = adc_data_a;
assign record0_adc_data_b = adc_data_b;
assign pitayaanalog0_dac_a = dac_a;
assign pitayaanalog0_dac_b = dac_b;
assign old_outputs = {record0_dac_wrt, record0_dac_clk, record0_dac_sel, record0_dac_rst, record0_adc_cdcs, record0_adc_clk, record0_dac_data, pitayaanalog0_adc_b, pitayaanalog0_adc_a};
assign old_sys_ps_clk = ps_clk;
assign record0_adc_cdcs = 1'd1;
assign record0_adc_clk = 2'd2;
assign pitayaanalog0_adc_a = {pitayaanalog0_adca[15], (~pitayaanalog0_adca[14:2])};
assign pitayaanalog0_adc_b = {pitayaanalog0_adcb[15], (~pitayaanalog0_adcb[14:2])};
assign record0_dac_rst = old_sys_rst;
assign record1_adc_data_a = adc_data_a;
assign record1_adc_data_b = adc_data_b;
assign pitayaanalog1_dac_a = dac_a;
assign pitayaanalog1_dac_b = dac_b;
assign new_outputs = {record1_dac_wrt, record1_dac_clk, record1_dac_sel, record1_dac_rst, record1_adc_cdcs, record1_adc_clk, record1_dac_data, pitayaanalog1_adc_b, pitayaanalog1_adc_a};
assign sys_ps_clk = ps_clk;
assign record1_adc_cdcs = 1'd1;
assign record1_adc_clk = 2'd2;
assign pitayaanalog1_adc_a = {pitayaanalog1_adca[15], (~pitayaanalog1_adca[14:2])};
assign pitayaanalog1_adc_b = {pitayaanalog1_adcb[15], (~pitayaanalog1_adcb[14:2])};
assign pitayaanalog1_select_b = (pitayaanalog1_frame ^ pitayaanalog1_frame_seen);
assign pitayaanalog1_dac_word = (pitayaanalog1_select_b ? pitayaanalog1_dacb : pitayaanalog1_daca);
assign record1_dac_rst = new_sys_rst;
assign xilinxasyncresetsynchronizerimpl1 = (ps_reset | (~old_locked));
assign xilinxasyncresetsynchronizerimpl3 = (ps_reset | (~new_locked));

always @(posedge old_sys_clk) begin
	pitayaanalog0_adca <= record0_adc_data_a;
	pitayaanalog0_adcb <= record0_adc_data_b;
	pitayaanalog0_daca <= {pitayaanalog0_dac_a[13], (~pitayaanalog0_dac_a[12:0])};
	pitayaanalog0_dacb <= {pitayaanalog0_dac_b[13], (~pitayaanalog0_dac_b[12:0])};
	if (old_sys_rst) begin
		pitayaanalog0_adca <= 16'd0;
		pitayaanalog0_adcb <= 16'd0;
		pitayaanalog0_daca <= 14'd0;
		pitayaanalog0_dacb <= 14'd0;
	end
end

always @(posedge new_sys_clk) begin
	pitayaanalog1_daca <= {pitayaanalog1_dac_a[13], (~pitayaanalog1_dac_a[12:0])};
	pitayaanalog1_dacb <= {pitayaanalog1_dac_b[13], (~pitayaanalog1_dac_b[12:0])};
	pitayaanalog1_frame <= (~pitayaanalog1_frame);
	if (new_sys_rst) begin
		pitayaanalog1_daca <= 14'd0;
		pitayaanalog1_dacb <= 14'd0;
	end
end

IBUFGDS IBUFGDS(
	.I(adc_p),
	.IB(adc_n),
	.O(crg0_clk_adci)
);

BUFG BUFG(
	.I(crg0_clk_adci),
	.O(crg0_clk_adcb)
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
	.CLKFBIN(crg0_clk_fbb),
	.CLKIN1(crg0_clk_adcb),
	.PWRDWN(1'd0),
	.RST(ps_reset),
	.CLKFBOUT(crg0_clk_fb),
	.CLKOUT0(crg0_clk[0]),
	.CLKOUT1(crg0_clk[1]),
	.CLKOUT2(crg0_clk[2]),
	.CLKOUT3(crg0_clk[3]),
	.CLKOUT4(crg0_clk[4]),
	.CLKOUT5(crg0_clk[5]),
	.LOCKED(old_locked)
);

BUFG BUFG_1(
	.I(crg0_clk_fb),
	.O(crg0_clk_fbb)
);

BUFG BUFG_2(
	.I(crg0_clk[1]),
	.O(old_sys_double_clk)
);

BUFG BUFG_3(
	.I(crg0_clk[2]),
	.O(old_sys_clk)
);

BUFG BUFG_4(
	.I(crg0_clk[3]),
	.O(old_sys_slow_clk)
);

BUFG BUFG_5(
	.I(crg0_clk[4]),
	.O(old_dac_2p_clk)
);

ODDR ODDR(
	.C(old_dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_clk)
);

ODDR ODDR_1(
	.C(old_sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_wrt)
);

ODDR ODDR_2(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_sel)
);

ODDR ODDR_3(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[0]),
	.D2(pitayaanalog0_dacb[0]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[0])
);

ODDR ODDR_4(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[1]),
	.D2(pitayaanalog0_dacb[1]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[1])
);

ODDR ODDR_5(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[2]),
	.D2(pitayaanalog0_dacb[2]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[2])
);

ODDR ODDR_6(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[3]),
	.D2(pitayaanalog0_dacb[3]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[3])
);

ODDR ODDR_7(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[4]),
	.D2(pitayaanalog0_dacb[4]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[4])
);

ODDR ODDR_8(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[5]),
	.D2(pitayaanalog0_dacb[5]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[5])
);

ODDR ODDR_9(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[6]),
	.D2(pitayaanalog0_dacb[6]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[6])
);

ODDR ODDR_10(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[7]),
	.D2(pitayaanalog0_dacb[7]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[7])
);

ODDR ODDR_11(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[8]),
	.D2(pitayaanalog0_dacb[8]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[8])
);

ODDR ODDR_12(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[9]),
	.D2(pitayaanalog0_dacb[9]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[9])
);

ODDR ODDR_13(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[10]),
	.D2(pitayaanalog0_dacb[10]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[10])
);

ODDR ODDR_14(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[11]),
	.D2(pitayaanalog0_dacb[11]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[11])
);

ODDR ODDR_15(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[12]),
	.D2(pitayaanalog0_dacb[12]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[12])
);

ODDR ODDR_16(
	.C(old_sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[13]),
	.D2(pitayaanalog0_dacb[13]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[13])
);

IBUFGDS IBUFGDS_1(
	.I(adc_p),
	.IB(adc_n),
	.O(crg1_clk_adci)
);

BUFG BUFG_6(
	.I(crg1_clk_adci),
	.O(crg1_clk_adcb)
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
	.CLKOUT4_PHASE(135.0),
	.CLKOUT5_DIVIDE(3'd4),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT5_PHASE(180.0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_BASE_1 (
	.CLKFBIN(crg1_clk_fbb),
	.CLKIN1(crg1_clk_adcb),
	.PWRDWN(1'd0),
	.RST(ps_reset),
	.CLKFBOUT(crg1_clk_fb),
	.CLKOUT0(crg1_clk[0]),
	.CLKOUT1(crg1_clk[1]),
	.CLKOUT2(crg1_clk[2]),
	.CLKOUT3(crg1_clk[3]),
	.CLKOUT4(crg1_clk[4]),
	.CLKOUT5(crg1_clk[5]),
	.LOCKED(new_locked)
);

BUFG BUFG_7(
	.I(crg1_clk_fb),
	.O(crg1_clk_fbb)
);

BUFG BUFG_8(
	.I(crg1_clk[1]),
	.O(sys_double_clk)
);

BUFG BUFG_9(
	.I(crg1_clk[2]),
	.O(new_sys_clk)
);

BUFG BUFG_10(
	.I(crg1_clk[3]),
	.O(sys_slow_clk)
);

BUFG BUFG_11(
	.I(crg1_clk[4]),
	.O(dac_2p_clk)
);

BUFG BUFG_12(
	.I(crg1_clk[5]),
	.O(dac_wrt_clk)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[0]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_1 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[1]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_2 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[2]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_3 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[3]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_4 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[4]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_5 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[5]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_6 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[6]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_7 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[7]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_8 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[8]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_9 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[9]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_10 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[10]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_11 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[11]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_12 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[12]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_13 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[13]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_14 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[14]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_15 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[15]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_16 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[0]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_17 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[1]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_18 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[2]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_19 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[3]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_20 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[4]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_21 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[5]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_22 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[6]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_23 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[7]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_24 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[8]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_25 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[9]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_26 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[10]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_27 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[11]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_28 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[12]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_29 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[13]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_30 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[14]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_31 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[15]),
	.R(new_sys_rst),
	.Q(pitayaanalog1_adcb[15])
);

FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_32 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_frame),
	.R(1'd0),
	.Q(pitayaanalog1_frame_seen)
);

ODDR ODDR_17(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd1),
	.D2(1'd0),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_clk)
);

ODDR ODDR_18(
	.C(dac_wrt_clk),
	.CE(1'd1),
	.D1(1'd1),
	.D2(1'd0),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_wrt)
);

ODDR ODDR_19(
	.C(new_sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_sel)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_33 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[0]),
	.R(1'd0),
	.Q(record1_dac_data[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_34 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[1]),
	.R(1'd0),
	.Q(record1_dac_data[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_35 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[2]),
	.R(1'd0),
	.Q(record1_dac_data[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_36 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[3]),
	.R(1'd0),
	.Q(record1_dac_data[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_37 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[4]),
	.R(1'd0),
	.Q(record1_dac_data[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_38 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[5]),
	.R(1'd0),
	.Q(record1_dac_data[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_39 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[6]),
	.R(1'd0),
	.Q(record1_dac_data[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_40 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[7]),
	.R(1'd0),
	.Q(record1_dac_data[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_41 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[8]),
	.R(1'd0),
	.Q(record1_dac_data[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_42 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[9]),
	.R(1'd0),
	.Q(record1_dac_data[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_43 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[10]),
	.R(1'd0),
	.Q(record1_dac_data[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_44 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[11]),
	.R(1'd0),
	.Q(record1_dac_data[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_45 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[12]),
	.R(1'd0),
	.Q(record1_dac_data[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_46 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pitayaanalog1_dac_word[13]),
	.R(1'd0),
	.Q(record1_dac_data[13])
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE (
	.C(old_sys_ps_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(ps_reset),
	.Q(xilinxasyncresetsynchronizerimpl0_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_1 (
	.C(old_sys_ps_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl0_rst_meta),
	.PRE(ps_reset),
	.Q(old_sys_ps_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_2 (
	.C(old_sys_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(xilinxasyncresetsynchronizerimpl1_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_3 (
	.C(old_sys_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl1_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(old_sys_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_4 (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(ps_reset),
	.Q(xilinxasyncresetsynchronizerimpl2_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_5 (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl2_rst_meta),
	.PRE(ps_reset),
	.Q(sys_ps_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_6 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl3),
	.Q(xilinxasyncresetsynchronizerimpl3_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_7 (
	.C(new_sys_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl3_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl3),
	.Q(new_sys_rst)
);

endmodule
