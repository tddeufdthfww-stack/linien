/* Machine-generated using Migen */
module registered_mixer_pair(
	input sys_clk,
	input sys_rst,
	input signed [27:0] ax,
	input signed [27:0] bx,
	input ce_a,
	input ce_b,
	input signed [13:0] offset,
	input dual,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [36:0] ref_mix,
	output [36:0] cand_mix,
	output [7:0] ref_read,
	output [7:0] cand_read,
	output [17:0] ref_cfg,
	output [17:0] cand_cfg,
	output [24:0] a_value,
	output [24:0] b_value
);

wire signed [24:0] pair_registerederrormixer0;
wire signed [24:0] pair_registerederrormixer1;
wire signed [24:0] pair_registerederrormixer2;
wire signed [24:0] pair_registerederrormixer3;
wire pair_registerederrormixer4;
wire pair_registerederrormixer5;
wire pair_registerederrormixer6;
wire pair_registerederrormixer7;
wire [7:0] pair_registerederrormixer8;
wire [7:0] pair_registerederrormixer9;
wire pair_registerederrormixer10;
wire pair_registerederrormixer11;
wire signed [13:0] pair_registerederrormixer_offset;
wire pair_registerederrormixer_dual;
wire signed [36:0] pair_registerederrormixer_y;
wire signed [47:0] pair_registerederrormixer_p0;
wire signed [36:0] pair_registerederrormixer_product0;
wire signed [26:0] pair_registerederrormixer_triple0;
reg signed [36:0] pair_registerederrormixer_bias0;
wire signed [47:0] pair_registerederrormixer_p1;
wire signed [36:0] pair_registerederrormixer_product1;
wire signed [26:0] pair_registerederrormixer_triple1;
reg signed [36:0] pair_registerederrormixer_bias1;
wire signed [36:0] pair_registerederrormixer_off;
wire [36:0] pair_registerederrormixer12;
wire [36:0] pair_registerederrormixer13;
wire [36:0] pair_registerederrormixer14;
wire [36:0] pair_registerederrormixer15;
wire [36:0] pair_registerederrormixer16;
wire [36:0] pair_registerederrormixer17;
wire signed [36:0] pair_registerederrormixer_merged;
reg signed [36:0] pair_registerederrormixer_summed;
reg signed [24:0] pair_a_limit_limitcsr_y = 25'sd0;
reg pair_a_limit_limitcsr_error = 1'd0;
wire pair_a_limit_update_en;
wire signed [27:0] pair_a_limit_x;
wire [24:0] pair_a_limit_min_storage;
wire [24:0] pair_a_limit_max_storage;
wire signed [27:0] pair_a_limit_limit_x;
reg signed [27:0] pair_a_limit_limit_y;
reg signed [27:0] pair_a_limit_limit_max = 28'sd0;
reg signed [27:0] pair_a_limit_limit_min = 28'sd0;
reg pair_a_limit_limit_railed;
reg signed [24:0] pair_b_limit_limitcsr_y = 25'sd0;
reg pair_b_limit_limitcsr_error = 1'd0;
wire pair_b_limit_update_en;
wire signed [27:0] pair_b_limit_x;
wire [24:0] pair_b_limit_min_storage;
wire [24:0] pair_b_limit_max_storage;
wire signed [27:0] pair_b_limit_limit_x;
reg signed [27:0] pair_b_limit_limit_y;
reg signed [27:0] pair_b_limit_limit_max = 28'sd0;
reg signed [27:0] pair_b_limit_limit_min = 28'sd0;
reg pair_b_limit_limit_railed;
reg [8:0] pair_mixerfactorcsr0_storage_full = 9'd128;
wire [8:0] pair_mixerfactorcsr0_storage;
reg pair_mixerfactorcsr0_re = 1'd0;
wire [7:0] pair_mixerfactorcsr0_encoded_low_data;
wire pair_mixerfactorcsr0_encoded_low_write;
reg [8:0] pair_mixerfactorcsr1_storage_full = 9'd128;
wire [8:0] pair_mixerfactorcsr1_storage;
reg pair_mixerfactorcsr1_re = 1'd0;
wire [7:0] pair_mixerfactorcsr1_encoded_low_data;
wire pair_mixerfactorcsr1_encoded_low_write;
reg [8:0] pair_csrstorage0_storage_full = 9'd128;
wire [8:0] pair_csrstorage0_storage;
reg pair_csrstorage0_re = 1'd0;
reg [8:0] pair_csrstorage1_storage_full = 9'd128;
wire [8:0] pair_csrstorage1_storage;
reg pair_csrstorage1_re = 1'd0;
wire [13:0] pair_cbank_bus_adr;
wire pair_cbank_bus_we;
wire [7:0] pair_cbank_bus_dat_w;
reg [7:0] pair_cbank_bus_dat_r = 8'd0;
wire pair_cbank_factor_a1_re;
wire pair_cbank_factor_a1_r;
wire pair_cbank_factor_a1_w;
wire pair_cbank_factor_a0_re;
wire [7:0] pair_cbank_factor_a0_r;
wire [7:0] pair_cbank_factor_a0_w;
wire pair_cbank_factor_b1_re;
wire pair_cbank_factor_b1_r;
wire pair_cbank_factor_b1_w;
wire pair_cbank_factor_b0_re;
wire [7:0] pair_cbank_factor_b0_r;
wire [7:0] pair_cbank_factor_b0_w;
wire pair_cbank_sel;
wire [13:0] pair_rbank_bus_adr;
wire pair_rbank_bus_we;
wire [7:0] pair_rbank_bus_dat_w;
reg [7:0] pair_rbank_bus_dat_r = 8'd0;
wire pair_rbank_factor_a1_re;
wire pair_rbank_factor_a1_r;
wire pair_rbank_factor_a1_w;
wire pair_rbank_factor_a0_re;
wire [7:0] pair_rbank_factor_a0_r;
wire [7:0] pair_rbank_factor_a0_w;
wire pair_rbank_factor_b1_re;
wire pair_rbank_factor_b1_r;
wire pair_rbank_factor_b1_w;
wire pair_rbank_factor_b0_re;
wire [7:0] pair_rbank_factor_b0_r;
wire [7:0] pair_rbank_factor_b0_w;
wire pair_rbank_sel;
reg signed [36:0] pair_old;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_a_limit_x = ax;
assign pair_b_limit_x = bx;
assign pair_a_limit_update_en = ce_a;
assign pair_b_limit_update_en = ce_b;
assign pair_registerederrormixer0 = pair_a_limit_limitcsr_y;
assign pair_registerederrormixer1 = pair_b_limit_limitcsr_y;
assign pair_registerederrormixer2 = pair_a_limit_limit_y;
assign pair_registerederrormixer3 = pair_b_limit_limit_y;
assign pair_registerederrormixer4 = pair_a_limit_update_en;
assign pair_registerederrormixer5 = pair_b_limit_update_en;
assign pair_registerederrormixer6 = pair_mixerfactorcsr0_storage[8];
assign pair_registerederrormixer7 = pair_mixerfactorcsr1_storage[8];
assign pair_registerederrormixer8 = pair_mixerfactorcsr0_encoded_low_data;
assign pair_registerederrormixer9 = pair_mixerfactorcsr1_encoded_low_data;
assign pair_registerederrormixer10 = pair_mixerfactorcsr0_encoded_low_write;
assign pair_registerederrormixer11 = pair_mixerfactorcsr1_encoded_low_write;
assign pair_registerederrormixer_offset = offset;
assign pair_registerederrormixer_dual = dual;
assign pair_a_limit_min_storage = 25'd16777216;
assign pair_b_limit_min_storage = 25'd16777216;
assign pair_a_limit_max_storage = 24'd16777215;
assign pair_b_limit_max_storage = 24'd16777215;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_old <= 37'sd0;
	if (dual) begin
		pair_old <= ((($signed({1'd0, pair_csrstorage0_storage}) * pair_a_limit_limitcsr_y) + ($signed({1'd0, pair_csrstorage1_storage}) * pair_b_limit_limitcsr_y)) + (offset <<< 5'd19));
	end else begin
		pair_old <= ((pair_a_limit_limitcsr_y <<< 4'd8) + (offset <<< 5'd19));
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_cbank_bus_adr = csr_adr;
assign pair_cbank_bus_we = csr_we;
assign pair_cbank_bus_dat_w = csr_dat_w;
assign pair_rbank_bus_adr = csr_adr;
assign pair_rbank_bus_we = csr_we;
assign pair_rbank_bus_dat_w = csr_dat_w;
assign ref_mix = pair_old;
assign cand_mix = pair_registerederrormixer_y;
assign ref_read = pair_rbank_bus_dat_r;
assign cand_read = pair_cbank_bus_dat_r;
assign ref_cfg = {pair_csrstorage1_storage, pair_csrstorage0_storage};
assign cand_cfg = {pair_mixerfactorcsr1_storage, pair_mixerfactorcsr0_storage};
assign a_value = pair_a_limit_limitcsr_y;
assign b_value = pair_b_limit_limitcsr_y;
assign pair_registerederrormixer_product0 = pair_registerederrormixer_p0;
assign pair_registerederrormixer_triple0 = (pair_registerederrormixer0 + (pair_registerederrormixer0 <<< 1'd1));

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_bias0 <= 37'sd0;
	if (pair_registerederrormixer6) begin
		pair_registerederrormixer_bias0 <= (pair_registerederrormixer_triple0 <<< 3'd7);
	end else begin
		pair_registerederrormixer_bias0 <= (pair_registerederrormixer0 <<< 3'd7);
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_registerederrormixer_product1 = pair_registerederrormixer_p1;
assign pair_registerederrormixer_triple1 = (pair_registerederrormixer1 + (pair_registerederrormixer1 <<< 1'd1));

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_bias1 <= 37'sd0;
	if (pair_registerederrormixer7) begin
		pair_registerederrormixer_bias1 <= (pair_registerederrormixer_triple1 <<< 3'd7);
	end else begin
		pair_registerederrormixer_bias1 <= (pair_registerederrormixer1 <<< 3'd7);
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_registerederrormixer_off = (pair_registerederrormixer_offset <<< 5'd19);
assign pair_registerederrormixer12 = ((pair_registerederrormixer_product0 ^ pair_registerederrormixer_bias0) ^ pair_registerederrormixer_product1);
assign pair_registerederrormixer13 = ((((pair_registerederrormixer_product0 & pair_registerederrormixer_bias0) | (pair_registerederrormixer_product0 & pair_registerederrormixer_product1)) | (pair_registerederrormixer_bias0 & pair_registerederrormixer_product1)) <<< 1'd1);
assign pair_registerederrormixer14 = ((pair_registerederrormixer_bias1 ^ pair_registerederrormixer_off) ^ $signed({1'd0, pair_registerederrormixer12}));
assign pair_registerederrormixer15 = ((((pair_registerederrormixer_bias1 & pair_registerederrormixer_off) | (pair_registerederrormixer_bias1 & $signed({1'd0, pair_registerederrormixer12}))) | (pair_registerederrormixer_off & $signed({1'd0, pair_registerederrormixer12}))) <<< 1'd1);
assign pair_registerederrormixer16 = ((pair_registerederrormixer13 ^ pair_registerederrormixer14) ^ pair_registerederrormixer15);
assign pair_registerederrormixer17 = ((((pair_registerederrormixer13 & pair_registerederrormixer14) | (pair_registerederrormixer13 & pair_registerederrormixer15)) | (pair_registerederrormixer14 & pair_registerederrormixer15)) <<< 1'd1);
assign pair_registerederrormixer_y = pair_registerederrormixer_summed;
assign pair_registerederrormixer_merged = (pair_registerederrormixer16 + pair_registerederrormixer17);

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_summed <= 37'sd0;
	if (pair_registerederrormixer_dual) begin
		pair_registerederrormixer_summed <= pair_registerederrormixer_merged;
	end else begin
		pair_registerederrormixer_summed <= ((pair_registerederrormixer0 <<< 4'd8) + pair_registerederrormixer_off);
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_a_limit_limit_x = pair_a_limit_x;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_a_limit_limit_y <= 28'sd0;
	pair_a_limit_limit_railed <= 1'd0;
	if ((pair_a_limit_limit_x >= pair_a_limit_limit_max)) begin
		pair_a_limit_limit_y <= pair_a_limit_limit_max;
		pair_a_limit_limit_railed <= 1'd1;
	end else begin
		if ((pair_a_limit_limit_x <= pair_a_limit_limit_min)) begin
			pair_a_limit_limit_y <= pair_a_limit_limit_min;
			pair_a_limit_limit_railed <= 1'd1;
		end else begin
			pair_a_limit_limit_y <= pair_a_limit_limit_x;
			pair_a_limit_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_b_limit_limit_x = pair_b_limit_x;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_b_limit_limit_y <= 28'sd0;
	pair_b_limit_limit_railed <= 1'd0;
	if ((pair_b_limit_limit_x >= pair_b_limit_limit_max)) begin
		pair_b_limit_limit_y <= pair_b_limit_limit_max;
		pair_b_limit_limit_railed <= 1'd1;
	end else begin
		if ((pair_b_limit_limit_x <= pair_b_limit_limit_min)) begin
			pair_b_limit_limit_y <= pair_b_limit_limit_min;
			pair_b_limit_limit_railed <= 1'd1;
		end else begin
			pair_b_limit_limit_y <= pair_b_limit_limit_x;
			pair_b_limit_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_cbank_sel = (pair_cbank_bus_adr[13:9] == 1'd0);
assign pair_cbank_factor_a1_r = pair_cbank_bus_dat_w[0];
assign pair_cbank_factor_a1_re = ((pair_cbank_sel & pair_cbank_bus_we) & (pair_cbank_bus_adr[1:0] == 1'd0));
assign pair_cbank_factor_a0_r = pair_cbank_bus_dat_w[7:0];
assign pair_cbank_factor_a0_re = ((pair_cbank_sel & pair_cbank_bus_we) & (pair_cbank_bus_adr[1:0] == 1'd1));
assign pair_cbank_factor_b1_r = pair_cbank_bus_dat_w[0];
assign pair_cbank_factor_b1_re = ((pair_cbank_sel & pair_cbank_bus_we) & (pair_cbank_bus_adr[1:0] == 2'd2));
assign pair_cbank_factor_b0_r = pair_cbank_bus_dat_w[7:0];
assign pair_cbank_factor_b0_re = ((pair_cbank_sel & pair_cbank_bus_we) & (pair_cbank_bus_adr[1:0] == 2'd3));
assign pair_mixerfactorcsr0_storage = pair_mixerfactorcsr0_storage_full[8:0];
assign pair_cbank_factor_a1_w = pair_mixerfactorcsr0_storage_full[8];
assign pair_cbank_factor_a0_w = pair_mixerfactorcsr0_storage_full[7:0];
assign pair_mixerfactorcsr0_encoded_low_data = (pair_cbank_factor_a0_r ^ 8'd128);
assign pair_mixerfactorcsr0_encoded_low_write = pair_cbank_factor_a0_re;
assign pair_mixerfactorcsr1_storage = pair_mixerfactorcsr1_storage_full[8:0];
assign pair_cbank_factor_b1_w = pair_mixerfactorcsr1_storage_full[8];
assign pair_cbank_factor_b0_w = pair_mixerfactorcsr1_storage_full[7:0];
assign pair_mixerfactorcsr1_encoded_low_data = (pair_cbank_factor_b0_r ^ 8'd128);
assign pair_mixerfactorcsr1_encoded_low_write = pair_cbank_factor_b0_re;
assign pair_rbank_sel = (pair_rbank_bus_adr[13:9] == 1'd0);
assign pair_rbank_factor_a1_r = pair_rbank_bus_dat_w[0];
assign pair_rbank_factor_a1_re = ((pair_rbank_sel & pair_rbank_bus_we) & (pair_rbank_bus_adr[1:0] == 1'd0));
assign pair_rbank_factor_a0_r = pair_rbank_bus_dat_w[7:0];
assign pair_rbank_factor_a0_re = ((pair_rbank_sel & pair_rbank_bus_we) & (pair_rbank_bus_adr[1:0] == 1'd1));
assign pair_rbank_factor_b1_r = pair_rbank_bus_dat_w[0];
assign pair_rbank_factor_b1_re = ((pair_rbank_sel & pair_rbank_bus_we) & (pair_rbank_bus_adr[1:0] == 2'd2));
assign pair_rbank_factor_b0_r = pair_rbank_bus_dat_w[7:0];
assign pair_rbank_factor_b0_re = ((pair_rbank_sel & pair_rbank_bus_we) & (pair_rbank_bus_adr[1:0] == 2'd3));
assign pair_csrstorage0_storage = pair_csrstorage0_storage_full[8:0];
assign pair_rbank_factor_a1_w = pair_csrstorage0_storage_full[8];
assign pair_rbank_factor_a0_w = pair_csrstorage0_storage_full[7:0];
assign pair_csrstorage1_storage = pair_csrstorage1_storage_full[8:0];
assign pair_rbank_factor_b1_w = pair_csrstorage1_storage_full[8];
assign pair_rbank_factor_b0_w = pair_csrstorage1_storage_full[7:0];

always @(posedge sys_clk) begin
	if (pair_a_limit_update_en) begin
		pair_a_limit_limit_min <= {{3{pair_a_limit_min_storage[24]}}, pair_a_limit_min_storage};
		pair_a_limit_limit_max <= {{3{pair_a_limit_max_storage[24]}}, pair_a_limit_max_storage};
		pair_a_limit_limitcsr_y <= pair_a_limit_limit_y;
		pair_a_limit_limitcsr_error <= pair_a_limit_limit_railed;
	end
	if (pair_b_limit_update_en) begin
		pair_b_limit_limit_min <= {{3{pair_b_limit_min_storage[24]}}, pair_b_limit_min_storage};
		pair_b_limit_limit_max <= {{3{pair_b_limit_max_storage[24]}}, pair_b_limit_max_storage};
		pair_b_limit_limitcsr_y <= pair_b_limit_limit_y;
		pair_b_limit_limitcsr_error <= pair_b_limit_limit_railed;
	end
	pair_cbank_bus_dat_r <= 1'd0;
	if (pair_cbank_sel) begin
		case (pair_cbank_bus_adr[1:0])
			1'd0: begin
				pair_cbank_bus_dat_r <= pair_cbank_factor_a1_w;
			end
			1'd1: begin
				pair_cbank_bus_dat_r <= pair_cbank_factor_a0_w;
			end
			2'd2: begin
				pair_cbank_bus_dat_r <= pair_cbank_factor_b1_w;
			end
			2'd3: begin
				pair_cbank_bus_dat_r <= pair_cbank_factor_b0_w;
			end
		endcase
	end
	if (pair_cbank_factor_a1_re) begin
		pair_mixerfactorcsr0_storage_full[8] <= pair_cbank_factor_a1_r;
	end
	if (pair_cbank_factor_a0_re) begin
		pair_mixerfactorcsr0_storage_full[7:0] <= pair_cbank_factor_a0_r;
	end
	pair_mixerfactorcsr0_re <= pair_cbank_factor_a0_re;
	if (pair_cbank_factor_b1_re) begin
		pair_mixerfactorcsr1_storage_full[8] <= pair_cbank_factor_b1_r;
	end
	if (pair_cbank_factor_b0_re) begin
		pair_mixerfactorcsr1_storage_full[7:0] <= pair_cbank_factor_b0_r;
	end
	pair_mixerfactorcsr1_re <= pair_cbank_factor_b0_re;
	pair_rbank_bus_dat_r <= 1'd0;
	if (pair_rbank_sel) begin
		case (pair_rbank_bus_adr[1:0])
			1'd0: begin
				pair_rbank_bus_dat_r <= pair_rbank_factor_a1_w;
			end
			1'd1: begin
				pair_rbank_bus_dat_r <= pair_rbank_factor_a0_w;
			end
			2'd2: begin
				pair_rbank_bus_dat_r <= pair_rbank_factor_b1_w;
			end
			2'd3: begin
				pair_rbank_bus_dat_r <= pair_rbank_factor_b0_w;
			end
		endcase
	end
	if (pair_rbank_factor_a1_re) begin
		pair_csrstorage0_storage_full[8] <= pair_rbank_factor_a1_r;
	end
	if (pair_rbank_factor_a0_re) begin
		pair_csrstorage0_storage_full[7:0] <= pair_rbank_factor_a0_r;
	end
	pair_csrstorage0_re <= pair_rbank_factor_a0_re;
	if (pair_rbank_factor_b1_re) begin
		pair_csrstorage1_storage_full[8] <= pair_rbank_factor_b1_r;
	end
	if (pair_rbank_factor_b0_re) begin
		pair_csrstorage1_storage_full[7:0] <= pair_rbank_factor_b0_r;
	end
	pair_csrstorage1_re <= pair_rbank_factor_b0_re;
	if (sys_rst) begin
		pair_a_limit_limitcsr_y <= 25'sd0;
		pair_a_limit_limitcsr_error <= 1'd0;
		pair_a_limit_limit_max <= 28'sd0;
		pair_a_limit_limit_min <= 28'sd0;
		pair_b_limit_limitcsr_y <= 25'sd0;
		pair_b_limit_limitcsr_error <= 1'd0;
		pair_b_limit_limit_max <= 28'sd0;
		pair_b_limit_limit_min <= 28'sd0;
		pair_mixerfactorcsr0_storage_full <= 9'd128;
		pair_mixerfactorcsr0_re <= 1'd0;
		pair_mixerfactorcsr1_storage_full <= 9'd128;
		pair_mixerfactorcsr1_re <= 1'd0;
		pair_csrstorage0_storage_full <= 9'd128;
		pair_csrstorage0_re <= 1'd0;
		pair_csrstorage1_storage_full <= 9'd128;
		pair_csrstorage1_re <= 1'd0;
		pair_cbank_bus_dat_r <= 8'd0;
		pair_rbank_bus_dat_r <= 8'd0;
	end
end

DSP48E1 #(
	.ACASCREG(1'd1),
	.ADREG(1'd0),
	.ALUMODEREG(1'd0),
	.AREG(1'd1),
	.A_INPUT("DIRECT"),
	.BCASCREG(1'd1),
	.BREG(1'd1),
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
	.A({{5{pair_registerederrormixer2[24]}}, pair_registerederrormixer2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_registerederrormixer8[7]}}, pair_registerederrormixer8}),
	.BCIN(18'd0),
	.C(48'd0),
	.CARRYCASCIN(1'd0),
	.CARRYIN(1'd0),
	.CARRYINSEL(3'd0),
	.CEA1(1'd0),
	.CEA2(pair_registerederrormixer4),
	.CEAD(1'd0),
	.CEALUMODE(1'd0),
	.CEB1(1'd0),
	.CEB2(pair_registerederrormixer10),
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
	.OPMODE(7'd5),
	.PCIN(48'd0),
	.RSTA(sys_rst),
	.RSTALLCARRYIN(1'd0),
	.RSTALUMODE(1'd0),
	.RSTB(sys_rst),
	.RSTC(1'd0),
	.RSTCTRL(1'd0),
	.RSTD(1'd0),
	.RSTINMODE(1'd0),
	.RSTM(1'd0),
	.RSTP(1'd0),
	.P(pair_registerederrormixer_p0)
);

DSP48E1 #(
	.ACASCREG(1'd1),
	.ADREG(1'd0),
	.ALUMODEREG(1'd0),
	.AREG(1'd1),
	.A_INPUT("DIRECT"),
	.BCASCREG(1'd1),
	.BREG(1'd1),
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
) DSP48E1_1 (
	.A({{5{pair_registerederrormixer3[24]}}, pair_registerederrormixer3}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_registerederrormixer9[7]}}, pair_registerederrormixer9}),
	.BCIN(18'd0),
	.C(48'd0),
	.CARRYCASCIN(1'd0),
	.CARRYIN(1'd0),
	.CARRYINSEL(3'd0),
	.CEA1(1'd0),
	.CEA2(pair_registerederrormixer5),
	.CEAD(1'd0),
	.CEALUMODE(1'd0),
	.CEB1(1'd0),
	.CEB2(pair_registerederrormixer11),
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
	.OPMODE(7'd5),
	.PCIN(48'd0),
	.RSTA(sys_rst),
	.RSTALLCARRYIN(1'd0),
	.RSTALUMODE(1'd0),
	.RSTB(sys_rst),
	.RSTC(1'd0),
	.RSTCTRL(1'd0),
	.RSTD(1'd0),
	.RSTINMODE(1'd0),
	.RSTM(1'd0),
	.RSTP(1'd0),
	.P(pair_registerederrormixer_p1)
);

endmodule
