/* Machine-generated using Migen */
module analog_under_test(
	input sys_clk,
	input sys_rst,
	input sys_double_clk,
	input dac_2p_clk,
	input [15:0] adc_data_a,
	input [15:0] adc_data_b,
	output [1:0] adc_clk,
	output adc_cdcs,
	output [13:0] dac_data,
	output dac_rst,
	output dac_sel,
	output dac_clk,
	output dac_wrt,
	output signed [13:0] adc_a,
	output signed [13:0] adc_b,
	input signed [13:0] dac_a,
	input signed [13:0] dac_b
);

wire [15:0] adca;
wire [15:0] adcb;
reg [13:0] daca = 14'd0;
reg [13:0] dacb = 14'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign adc_cdcs = 1'd1;
assign adc_clk = 2'd2;
assign adc_a = {adca[15], (~adca[14:2])};
assign adc_b = {adcb[15], (~adcb[14:2])};
assign dac_rst = sys_rst;

always @(posedge sys_clk) begin
	daca <= {dac_a[13], (~dac_a[12:0])};
	dacb <= {dac_b[13], (~dac_b[12:0])};
	if (sys_rst) begin
		daca <= 14'd0;
		dacb <= 14'd0;
	end
end

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[0]),
	.R(sys_rst),
	.Q(adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_1 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[1]),
	.R(sys_rst),
	.Q(adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[2]),
	.R(sys_rst),
	.Q(adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[3]),
	.R(sys_rst),
	.Q(adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_4 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[4]),
	.R(sys_rst),
	.Q(adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_5 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[5]),
	.R(sys_rst),
	.Q(adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_6 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[6]),
	.R(sys_rst),
	.Q(adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_7 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[7]),
	.R(sys_rst),
	.Q(adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_8 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[8]),
	.R(sys_rst),
	.Q(adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_9 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[9]),
	.R(sys_rst),
	.Q(adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_10 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[10]),
	.R(sys_rst),
	.Q(adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_11 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[11]),
	.R(sys_rst),
	.Q(adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_12 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[12]),
	.R(sys_rst),
	.Q(adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_13 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[13]),
	.R(sys_rst),
	.Q(adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_14 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[14]),
	.R(sys_rst),
	.Q(adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_15 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_a[15]),
	.R(sys_rst),
	.Q(adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_16 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[0]),
	.R(sys_rst),
	.Q(adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_17 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[1]),
	.R(sys_rst),
	.Q(adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_18 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[2]),
	.R(sys_rst),
	.Q(adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_19 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[3]),
	.R(sys_rst),
	.Q(adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_20 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[4]),
	.R(sys_rst),
	.Q(adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_21 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[5]),
	.R(sys_rst),
	.Q(adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_22 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[6]),
	.R(sys_rst),
	.Q(adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_23 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[7]),
	.R(sys_rst),
	.Q(adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_24 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[8]),
	.R(sys_rst),
	.Q(adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_25 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[9]),
	.R(sys_rst),
	.Q(adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_26 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[10]),
	.R(sys_rst),
	.Q(adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_27 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[11]),
	.R(sys_rst),
	.Q(adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_28 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[12]),
	.R(sys_rst),
	.Q(adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_29 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[13]),
	.R(sys_rst),
	.Q(adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_30 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[14]),
	.R(sys_rst),
	.Q(adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd1)
) FDRE_31 (
	.C(sys_clk),
	.CE(1'd1),
	.D(adc_data_b[15]),
	.R(sys_rst),
	.Q(adcb[15])
);

ODDR ODDR(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_clk)
);

ODDR ODDR_1(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_wrt)
);

ODDR ODDR_2(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_sel)
);

ODDR ODDR_3(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[0]),
	.D2(dacb[0]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[0])
);

ODDR ODDR_4(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[1]),
	.D2(dacb[1]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[1])
);

ODDR ODDR_5(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[2]),
	.D2(dacb[2]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[2])
);

ODDR ODDR_6(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[3]),
	.D2(dacb[3]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[3])
);

ODDR ODDR_7(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[4]),
	.D2(dacb[4]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[4])
);

ODDR ODDR_8(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[5]),
	.D2(dacb[5]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[5])
);

ODDR ODDR_9(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[6]),
	.D2(dacb[6]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[6])
);

ODDR ODDR_10(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[7]),
	.D2(dacb[7]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[7])
);

ODDR ODDR_11(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[8]),
	.D2(dacb[8]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[8])
);

ODDR ODDR_12(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[9]),
	.D2(dacb[9]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[9])
);

ODDR ODDR_13(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[10]),
	.D2(dacb[10]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[10])
);

ODDR ODDR_14(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[11]),
	.D2(dacb[11]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[11])
);

ODDR ODDR_15(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[12]),
	.D2(dacb[12]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[12])
);

ODDR ODDR_16(
	.C(sys_clk),
	.CE(1'd1),
	.D1(daca[13]),
	.D2(dacb[13]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[13])
);

endmodule
