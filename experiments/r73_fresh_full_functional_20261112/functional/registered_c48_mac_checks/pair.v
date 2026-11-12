/* Machine-generated using Migen */
module c48_pair(
	input sys_clk,
	input sys_rst,
	input signed [24:0] x,
	input signed [24:0] c,
	input signed [49:0] z,
	output reg signed [49:0] old_y,
	output signed [49:0] new_y
);

wire signed [47:0] pair_low;
wire [47:0] pair_cascade;
wire signed [47:0] pair_high_q;
wire pair0;
wire pair1;
wire signed [3:0] pair_correction;
reg signed [3:0] pair_correction_q = 4'sd0;
reg [16:0] pair_low_q = 17'd0;
wire [1:0] pair_top;
wire signed [49:0] pair_result;
wire signed [47:0] pair_zlo;
wire signed [1:0] pair_ztop;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_zlo = z[47:0];
assign pair_ztop = z[49:48];
assign pair0 = (((~pair_zlo[47]) & (~c[24])) & pair_low[47]);
assign pair1 = ((pair_zlo[47] & c[24]) & (~pair_low[47]));
assign pair_correction = (((pair_ztop + pair_zlo[47]) + $signed({1'd0, pair0})) - $signed({1'd0, pair1}));
assign pair_top = (pair_high_q[32:31] + pair_correction_q);
assign pair_result = {pair_top, pair_high_q[30:0], pair_low_q};
assign new_y = pair_result;

always @(posedge sys_clk) begin
	old_y <= (z + (x * c));
	pair_low_q <= pair_low[16:0];
	pair_correction_q <= pair_correction;
	if (sys_rst) begin
		old_y <= 50'sd0;
		pair_correction_q <= 4'sd0;
		pair_low_q <= 17'd0;
	end
end

DSP48E1 #(
	.ACASCREG(1'd0),
	.ADREG(1'd0),
	.ALUMODEREG(1'd0),
	.AREG(1'd0),
	.A_INPUT("DIRECT"),
	.BCASCREG(1'd0),
	.BREG(1'd0),
	.B_INPUT("DIRECT"),
	.CARRYINREG(1'd0),
	.CARRYINSELREG(1'd0),
	.CREG(1'd0),
	.DREG(1'd0),
	.INMODEREG(1'd0),
	.MREG(1'd0),
	.OPMODEREG(1'd0),
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1 (
	.A({{5{c[24]}}, c}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, x[16:0]}),
	.BCIN(18'd0),
	.C(z[47:0]),
	.CARRYCASCIN(1'd0),
	.CARRYIN(1'd0),
	.CARRYINSEL(3'd0),
	.CEA1(1'd0),
	.CEA2(1'd0),
	.CEAD(1'd0),
	.CEALUMODE(1'd0),
	.CEB1(1'd0),
	.CEB2(1'd0),
	.CEC(1'd0),
	.CECARRYIN(1'd0),
	.CECTRL(1'd0),
	.CED(1'd0),
	.CEINMODE(1'd0),
	.CEM(1'd0),
	.CEP(1'd0),
	.CLK(sys_clk),
	.D(25'd0),
	.INMODE(5'd0),
	.MULTSIGNIN(1'd0),
	.OPMODE(7'd53),
	.PCIN(48'd0),
	.RSTA(1'd0),
	.RSTALLCARRYIN(1'd0),
	.RSTALUMODE(1'd0),
	.RSTB(1'd0),
	.RSTC(1'd0),
	.RSTCTRL(1'd0),
	.RSTD(1'd0),
	.RSTINMODE(1'd0),
	.RSTM(1'd0),
	.RSTP(1'd0),
	.P(pair_low),
	.PCOUT(pair_cascade)
);

DSP48E1 #(
	.ACASCREG(1'd0),
	.ADREG(1'd0),
	.ALUMODEREG(1'd0),
	.AREG(1'd0),
	.A_INPUT("DIRECT"),
	.BCASCREG(1'd0),
	.BREG(1'd0),
	.B_INPUT("DIRECT"),
	.CARRYINREG(1'd0),
	.CARRYINSELREG(1'd0),
	.CREG(1'd0),
	.DREG(1'd0),
	.INMODEREG(1'd0),
	.MREG(1'd0),
	.OPMODEREG(1'd0),
	.PREG(1'd1),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_1 (
	.A({{5{c[24]}}, c}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{x[24]}}, x[24:17]}),
	.BCIN(18'd0),
	.C(48'd0),
	.CARRYCASCIN(1'd0),
	.CARRYIN(1'd0),
	.CARRYINSEL(3'd0),
	.CEA1(1'd0),
	.CEA2(1'd0),
	.CEAD(1'd0),
	.CEALUMODE(1'd0),
	.CEB1(1'd0),
	.CEB2(1'd0),
	.CEC(1'd0),
	.CECARRYIN(1'd0),
	.CECTRL(1'd0),
	.CED(1'd0),
	.CEINMODE(1'd0),
	.CEM(1'd0),
	.CEP(1'd1),
	.CLK(sys_clk),
	.D(25'd0),
	.INMODE(5'd0),
	.MULTSIGNIN(1'd0),
	.OPMODE(7'd85),
	.PCIN(pair_cascade),
	.RSTA(1'd0),
	.RSTALLCARRYIN(1'd0),
	.RSTALUMODE(1'd0),
	.RSTB(1'd0),
	.RSTC(1'd0),
	.RSTCTRL(1'd0),
	.RSTD(1'd0),
	.RSTINMODE(1'd0),
	.RSTM(1'd0),
	.RSTP(sys_rst),
	.P(pair_high_q)
);

endmodule
