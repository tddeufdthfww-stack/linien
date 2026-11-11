/* Machine-generated using Migen */
module analog_pair(
	input sys_clk,
	input sys_rst,
	input sys_double_clk,
	input dac_2p_clk,
	input [15:0] adc_data_a,
	input [15:0] adc_data_b,
	input signed [13:0] dac_a,
	input signed [13:0] dac_b,
	output signed [13:0] old_adc_a,
	output signed [13:0] old_adc_b,
	output [48:0] old_outputs,
	output signed [13:0] new_adc_a,
	output signed [13:0] new_adc_b,
	output [48:0] new_outputs
);

wire [15:0] record0_adc_data_a;
wire [15:0] record0_adc_data_b;
wire [1:0] record0_adc_clk;
wire record0_adc_cdcs;
wire [13:0] record0_dac_data;
wire record0_dac_rst;
wire record0_dac_sel;
wire record0_dac_clk;
wire record0_dac_wrt;
wire signed [13:0] pitayaanalog0_dac_a;
wire signed [13:0] pitayaanalog0_dac_b;
reg [15:0] pitayaanalog0_adca = 16'd0;
reg [15:0] pitayaanalog0_adcb = 16'd0;
reg [13:0] pitayaanalog0_daca = 14'd0;
reg [13:0] pitayaanalog0_dacb = 14'd0;
wire [15:0] record1_adc_data_a;
wire [15:0] record1_adc_data_b;
wire [1:0] record1_adc_clk;
wire record1_adc_cdcs;
wire [13:0] record1_dac_data;
wire record1_dac_rst;
wire record1_dac_sel;
wire record1_dac_clk;
wire record1_dac_wrt;
wire signed [13:0] pitayaanalog1_dac_a;
wire signed [13:0] pitayaanalog1_dac_b;
wire [15:0] pitayaanalog1_adca;
wire [15:0] pitayaanalog1_adcb;
reg [13:0] pitayaanalog1_daca = 14'd0;
reg [13:0] pitayaanalog1_dacb = 14'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign record0_adc_data_a = adc_data_a;
assign record0_adc_data_b = adc_data_b;
assign pitayaanalog0_dac_a = dac_a;
assign pitayaanalog0_dac_b = dac_b;
assign old_outputs = {record0_dac_wrt, record0_dac_clk, record0_dac_sel, record0_dac_rst, record0_adc_cdcs, record0_adc_clk, record0_dac_data, old_adc_b, old_adc_a};
assign record1_adc_data_a = adc_data_a;
assign record1_adc_data_b = adc_data_b;
assign pitayaanalog1_dac_a = dac_a;
assign pitayaanalog1_dac_b = dac_b;
assign new_outputs = {record1_dac_wrt, record1_dac_clk, record1_dac_sel, record1_dac_rst, record1_adc_cdcs, record1_adc_clk, record1_dac_data, new_adc_b, new_adc_a};
assign record0_adc_cdcs = 1'd1;
assign record0_adc_clk = 2'd2;
assign old_adc_a = {pitayaanalog0_adca[15], (~pitayaanalog0_adca[14:2])};
assign old_adc_b = {pitayaanalog0_adcb[15], (~pitayaanalog0_adcb[14:2])};
assign record0_dac_rst = sys_rst;
assign record1_adc_cdcs = 1'd1;
assign record1_adc_clk = 2'd2;
assign new_adc_a = {pitayaanalog1_adca[15], (~pitayaanalog1_adca[14:2])};
assign new_adc_b = {pitayaanalog1_adcb[15], (~pitayaanalog1_adcb[14:2])};
assign record1_dac_rst = sys_rst;

always @(posedge sys_clk) begin
	pitayaanalog0_adca <= record0_adc_data_a;
	pitayaanalog0_adcb <= record0_adc_data_b;
	pitayaanalog0_daca <= {pitayaanalog0_dac_a[13], (~pitayaanalog0_dac_a[12:0])};
	pitayaanalog0_dacb <= {pitayaanalog0_dac_b[13], (~pitayaanalog0_dac_b[12:0])};
	pitayaanalog1_daca <= {pitayaanalog1_dac_a[13], (~pitayaanalog1_dac_a[12:0])};
	pitayaanalog1_dacb <= {pitayaanalog1_dac_b[13], (~pitayaanalog1_dac_b[12:0])};
	if (sys_rst) begin
		pitayaanalog0_adca <= 16'd0;
		pitayaanalog0_adcb <= 16'd0;
		pitayaanalog0_daca <= 14'd0;
		pitayaanalog0_dacb <= 14'd0;
		pitayaanalog1_daca <= 14'd0;
		pitayaanalog1_dacb <= 14'd0;
	end
end

ODDR ODDR(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_clk)
);

ODDR ODDR_1(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_wrt)
);

ODDR ODDR_2(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_sel)
);

ODDR ODDR_3(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[0]),
	.D2(pitayaanalog0_dacb[0]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[0])
);

ODDR ODDR_4(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[1]),
	.D2(pitayaanalog0_dacb[1]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[1])
);

ODDR ODDR_5(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[2]),
	.D2(pitayaanalog0_dacb[2]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[2])
);

ODDR ODDR_6(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[3]),
	.D2(pitayaanalog0_dacb[3]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[3])
);

ODDR ODDR_7(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[4]),
	.D2(pitayaanalog0_dacb[4]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[4])
);

ODDR ODDR_8(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[5]),
	.D2(pitayaanalog0_dacb[5]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[5])
);

ODDR ODDR_9(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[6]),
	.D2(pitayaanalog0_dacb[6]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[6])
);

ODDR ODDR_10(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[7]),
	.D2(pitayaanalog0_dacb[7]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[7])
);

ODDR ODDR_11(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[8]),
	.D2(pitayaanalog0_dacb[8]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[8])
);

ODDR ODDR_12(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[9]),
	.D2(pitayaanalog0_dacb[9]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[9])
);

ODDR ODDR_13(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[10]),
	.D2(pitayaanalog0_dacb[10]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[10])
);

ODDR ODDR_14(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[11]),
	.D2(pitayaanalog0_dacb[11]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[11])
);

ODDR ODDR_15(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[12]),
	.D2(pitayaanalog0_dacb[12]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[12])
);

ODDR ODDR_16(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog0_daca[13]),
	.D2(pitayaanalog0_dacb[13]),
	.R(1'd0),
	.S(1'd0),
	.Q(record0_dac_data[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[0]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_1 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[1]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[2]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[3]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_4 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[4]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_5 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[5]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_6 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[6]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_7 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[7]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_8 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[8]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_9 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[9]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_10 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[10]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_11 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[11]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_12 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[12]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_13 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[13]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_14 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[14]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_15 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_a[15]),
	.R(sys_rst),
	.Q(pitayaanalog1_adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_16 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[0]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_17 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[1]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_18 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[2]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_19 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[3]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_20 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[4]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_21 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[5]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_22 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[6]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_23 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[7]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_24 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[8]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_25 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[9]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_26 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[10]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_27 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[11]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_28 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[12]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_29 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[13]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_30 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[14]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_31 (
	.C(sys_clk),
	.CE(1'd1),
	.D(record1_adc_data_b[15]),
	.R(sys_rst),
	.Q(pitayaanalog1_adcb[15])
);

ODDR ODDR_17(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_clk)
);

ODDR ODDR_18(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_wrt)
);

ODDR ODDR_19(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_sel)
);

ODDR ODDR_20(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[0]),
	.D2(pitayaanalog1_dacb[0]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[0])
);

ODDR ODDR_21(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[1]),
	.D2(pitayaanalog1_dacb[1]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[1])
);

ODDR ODDR_22(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[2]),
	.D2(pitayaanalog1_dacb[2]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[2])
);

ODDR ODDR_23(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[3]),
	.D2(pitayaanalog1_dacb[3]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[3])
);

ODDR ODDR_24(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[4]),
	.D2(pitayaanalog1_dacb[4]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[4])
);

ODDR ODDR_25(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[5]),
	.D2(pitayaanalog1_dacb[5]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[5])
);

ODDR ODDR_26(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[6]),
	.D2(pitayaanalog1_dacb[6]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[6])
);

ODDR ODDR_27(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[7]),
	.D2(pitayaanalog1_dacb[7]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[7])
);

ODDR ODDR_28(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[8]),
	.D2(pitayaanalog1_dacb[8]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[8])
);

ODDR ODDR_29(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[9]),
	.D2(pitayaanalog1_dacb[9]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[9])
);

ODDR ODDR_30(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[10]),
	.D2(pitayaanalog1_dacb[10]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[10])
);

ODDR ODDR_31(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[11]),
	.D2(pitayaanalog1_dacb[11]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[11])
);

ODDR ODDR_32(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[12]),
	.D2(pitayaanalog1_dacb[12]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[12])
);

ODDR ODDR_33(
	.C(sys_clk),
	.CE(1'd1),
	.D1(pitayaanalog1_daca[13]),
	.D2(pitayaanalog1_dacb[13]),
	.R(1'd0),
	.S(1'd0),
	.Q(record1_dac_data[13])
);

endmodule
