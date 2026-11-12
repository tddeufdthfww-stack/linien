/* Machine-generated using Migen */
module parallel_tap_pair(
	input sys_clk,
	input sys_rst,
	input signed [24:0] t0,
	input signed [24:0] t1,
	input signed [24:0] t2,
	input signed [27:0] ca,
	input signed [27:0] cb,
	input ce,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [24:0] ref_y,
	output [24:0] cand_y,
	output ref_error,
	output cand_error,
	output [27:0] ref_pre,
	output [27:0] cand_pre,
	output ref_rail,
	output cand_rail,
	output [27:0] ref_lo,
	output [27:0] ref_hi,
	output [27:0] cand_lo,
	output [27:0] cand_hi,
	output [1:0] tap_current,
	output invert_current,
	output [52:0] cfg,
	output [7:0] csr_read
);

reg [1:0] pair_tap_storage_full = 2'd0;
wire [1:0] pair_tap_storage;
reg pair_tap_re = 1'd0;
reg pair_invert_storage_full = 1'd0;
wire pair_invert_storage;
reg pair_invert_re = 1'd0;
reg signed [24:0] pair_paralleltaplimitcsr_y = 25'sd0;
reg pair_paralleltaplimitcsr_error = 1'd0;
wire pair_paralleltaplimitcsr_update_en;
wire signed [24:0] pair_paralleltaplimitcsr0;
wire signed [24:0] pair_paralleltaplimitcsr1;
wire signed [24:0] pair_paralleltaplimitcsr2;
wire signed [27:0] pair_paralleltaplimitcsr_common_a;
wire signed [27:0] pair_paralleltaplimitcsr_common_b;
wire [1:0] pair_paralleltaplimitcsr3;
wire pair_paralleltaplimitcsr4;
reg [24:0] pair_paralleltaplimitcsr_min_storage_full = 25'd16777216;
wire [24:0] pair_paralleltaplimitcsr_min_storage;
reg pair_paralleltaplimitcsr_min_re = 1'd0;
reg [24:0] pair_paralleltaplimitcsr_max_storage_full = 25'd16777215;
wire [24:0] pair_paralleltaplimitcsr_max_storage;
reg pair_paralleltaplimitcsr_max_re = 1'd0;
reg signed [27:0] pair_paralleltaplimitcsr_bound_min = 28'sd0;
reg signed [27:0] pair_paralleltaplimitcsr_bound_max = 28'sd0;
reg signed [27:0] pair_paralleltaplimitcsr_neg_bound_min = 28'sd0;
reg signed [27:0] pair_paralleltaplimitcsr_neg_bound_max = 28'sd0;
wire signed [27:0] pair_paralleltaplimitcsr_common_sum;
wire signed [27:0] pair_paralleltaplimitcsr_total0;
wire signed [27:0] pair_paralleltaplimitcsr_limit0_x;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_limit0_y;
wire signed [27:0] pair_paralleltaplimitcsr_limit0_max;
wire signed [27:0] pair_paralleltaplimitcsr_limit0_min;
(* keep = "true" *) reg pair_paralleltaplimitcsr_limit0_railed;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_neg_value0;
(* keep = "true" *) reg pair_paralleltaplimitcsr_neg_rail_value0;
wire signed [27:0] pair_paralleltaplimitcsr_total1;
wire signed [27:0] pair_paralleltaplimitcsr_limit1_x;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_limit1_y;
wire signed [27:0] pair_paralleltaplimitcsr_limit1_max;
wire signed [27:0] pair_paralleltaplimitcsr_limit1_min;
(* keep = "true" *) reg pair_paralleltaplimitcsr_limit1_railed;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_neg_value1;
(* keep = "true" *) reg pair_paralleltaplimitcsr_neg_rail_value1;
wire signed [27:0] pair_paralleltaplimitcsr_total2;
wire signed [27:0] pair_paralleltaplimitcsr_limit2_x;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_limit2_y;
wire signed [27:0] pair_paralleltaplimitcsr_limit2_max;
wire signed [27:0] pair_paralleltaplimitcsr_limit2_min;
(* keep = "true" *) reg pair_paralleltaplimitcsr_limit2_railed;
(* keep = "true" *) reg signed [27:0] pair_paralleltaplimitcsr_neg_value2;
(* keep = "true" *) reg pair_paralleltaplimitcsr_neg_rail_value2;
wire signed [27:0] pair_paralleltaplimitcsr_pre_y;
wire pair_paralleltaplimitcsr_pre_rail;
reg signed [24:0] pair_limitcsr_y = 25'sd0;
reg pair_limitcsr_error = 1'd0;
wire pair_update_en;
wire signed [27:0] pair_x;
wire [24:0] pair_min_storage;
wire [24:0] pair_max_storage;
wire signed [27:0] pair_limit_x;
reg signed [27:0] pair_limit_y;
reg signed [27:0] pair_limit_max = 28'sd0;
reg signed [27:0] pair_limit_min = 28'sd0;
reg pair_limit_railed;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_tap0_re;
wire [1:0] pair_tap0_r;
wire [1:0] pair_tap0_w;
wire pair_invert0_re;
wire pair_invert0_r;
wire pair_invert0_w;
wire pair_limit_min3_re;
wire pair_limit_min3_r;
wire pair_limit_min3_w;
wire pair_limit_min2_re;
wire [7:0] pair_limit_min2_r;
wire [7:0] pair_limit_min2_w;
wire pair_limit_min1_re;
wire [7:0] pair_limit_min1_r;
wire [7:0] pair_limit_min1_w;
wire pair_limit_min0_re;
wire [7:0] pair_limit_min0_r;
wire [7:0] pair_limit_min0_w;
wire pair_limit_max3_re;
wire pair_limit_max3_r;
wire pair_limit_max3_w;
wire pair_limit_max2_re;
wire [7:0] pair_limit_max2_r;
wire [7:0] pair_limit_max2_w;
wire pair_limit_max1_re;
wire [7:0] pair_limit_max1_r;
wire [7:0] pair_limit_max1_w;
wire pair_limit_max0_re;
wire [7:0] pair_limit_max0_r;
wire [7:0] pair_limit_max0_w;
wire pair_sel;
reg signed [24:0] array_muxed0;
reg signed [27:0] array_muxed1;
reg signed [27:0] array_muxed2;
reg array_muxed3;
reg array_muxed4;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_x = ((pair_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((array_muxed0 + ca) + cb));
assign pair_update_en = ce;
assign pair_paralleltaplimitcsr_update_en = ce;
assign pair_min_storage = pair_paralleltaplimitcsr_min_storage;
assign pair_max_storage = pair_paralleltaplimitcsr_max_storage;
assign pair_paralleltaplimitcsr_common_a = ca;
assign pair_paralleltaplimitcsr_common_b = cb;
assign pair_paralleltaplimitcsr3 = pair_tap_storage;
assign pair_paralleltaplimitcsr4 = pair_invert_storage;
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign pair_paralleltaplimitcsr0 = t0;
assign pair_paralleltaplimitcsr1 = t1;
assign pair_paralleltaplimitcsr2 = t2;
assign ref_y = pair_limitcsr_y;
assign cand_y = pair_paralleltaplimitcsr_y;
assign ref_error = pair_limitcsr_error;
assign cand_error = pair_paralleltaplimitcsr_error;
assign ref_pre = pair_limit_y;
assign cand_pre = pair_paralleltaplimitcsr_pre_y;
assign ref_rail = pair_limit_railed;
assign cand_rail = pair_paralleltaplimitcsr_pre_rail;
assign ref_lo = pair_limit_min;
assign ref_hi = pair_limit_max;
assign cand_lo = pair_paralleltaplimitcsr_bound_min;
assign cand_hi = pair_paralleltaplimitcsr_bound_max;
assign tap_current = pair_tap_storage;
assign invert_current = pair_invert_storage;
assign cfg = {pair_paralleltaplimitcsr_max_storage, pair_paralleltaplimitcsr_min_storage, pair_invert_storage, pair_tap_storage};
assign csr_read = pair_bus_dat_r;
assign pair_paralleltaplimitcsr_common_sum = (pair_paralleltaplimitcsr_common_a + pair_paralleltaplimitcsr_common_b);
assign pair_paralleltaplimitcsr_total0 = (pair_paralleltaplimitcsr0 + pair_paralleltaplimitcsr_common_sum);
assign pair_paralleltaplimitcsr_limit0_x = pair_paralleltaplimitcsr_total0;
assign pair_paralleltaplimitcsr_limit0_min = pair_paralleltaplimitcsr_bound_min;
assign pair_paralleltaplimitcsr_limit0_max = pair_paralleltaplimitcsr_bound_max;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_neg_value0 <= 28'sd0;
	pair_paralleltaplimitcsr_neg_rail_value0 <= 1'd0;
	if ((pair_paralleltaplimitcsr_total0 == 28'sd134217728)) begin
		pair_paralleltaplimitcsr_neg_value0 <= pair_paralleltaplimitcsr_bound_min;
		pair_paralleltaplimitcsr_neg_rail_value0 <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_total0 <= pair_paralleltaplimitcsr_neg_bound_max)) begin
			pair_paralleltaplimitcsr_neg_value0 <= pair_paralleltaplimitcsr_bound_max;
			pair_paralleltaplimitcsr_neg_rail_value0 <= 1'd1;
		end else begin
			if ((pair_paralleltaplimitcsr_total0 >= pair_paralleltaplimitcsr_neg_bound_min)) begin
				pair_paralleltaplimitcsr_neg_value0 <= pair_paralleltaplimitcsr_bound_min;
				pair_paralleltaplimitcsr_neg_rail_value0 <= 1'd1;
			end else begin
				pair_paralleltaplimitcsr_neg_value0 <= (-pair_paralleltaplimitcsr_total0);
				pair_paralleltaplimitcsr_neg_rail_value0 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_paralleltaplimitcsr_total1 = (pair_paralleltaplimitcsr1 + pair_paralleltaplimitcsr_common_sum);
assign pair_paralleltaplimitcsr_limit1_x = pair_paralleltaplimitcsr_total1;
assign pair_paralleltaplimitcsr_limit1_min = pair_paralleltaplimitcsr_bound_min;
assign pair_paralleltaplimitcsr_limit1_max = pair_paralleltaplimitcsr_bound_max;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_neg_value1 <= 28'sd0;
	pair_paralleltaplimitcsr_neg_rail_value1 <= 1'd0;
	if ((pair_paralleltaplimitcsr_total1 == 28'sd134217728)) begin
		pair_paralleltaplimitcsr_neg_value1 <= pair_paralleltaplimitcsr_bound_min;
		pair_paralleltaplimitcsr_neg_rail_value1 <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_total1 <= pair_paralleltaplimitcsr_neg_bound_max)) begin
			pair_paralleltaplimitcsr_neg_value1 <= pair_paralleltaplimitcsr_bound_max;
			pair_paralleltaplimitcsr_neg_rail_value1 <= 1'd1;
		end else begin
			if ((pair_paralleltaplimitcsr_total1 >= pair_paralleltaplimitcsr_neg_bound_min)) begin
				pair_paralleltaplimitcsr_neg_value1 <= pair_paralleltaplimitcsr_bound_min;
				pair_paralleltaplimitcsr_neg_rail_value1 <= 1'd1;
			end else begin
				pair_paralleltaplimitcsr_neg_value1 <= (-pair_paralleltaplimitcsr_total1);
				pair_paralleltaplimitcsr_neg_rail_value1 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_paralleltaplimitcsr_total2 = (pair_paralleltaplimitcsr2 + pair_paralleltaplimitcsr_common_sum);
assign pair_paralleltaplimitcsr_limit2_x = pair_paralleltaplimitcsr_total2;
assign pair_paralleltaplimitcsr_limit2_min = pair_paralleltaplimitcsr_bound_min;
assign pair_paralleltaplimitcsr_limit2_max = pair_paralleltaplimitcsr_bound_max;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_neg_value2 <= 28'sd0;
	pair_paralleltaplimitcsr_neg_rail_value2 <= 1'd0;
	if ((pair_paralleltaplimitcsr_total2 == 28'sd134217728)) begin
		pair_paralleltaplimitcsr_neg_value2 <= pair_paralleltaplimitcsr_bound_min;
		pair_paralleltaplimitcsr_neg_rail_value2 <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_total2 <= pair_paralleltaplimitcsr_neg_bound_max)) begin
			pair_paralleltaplimitcsr_neg_value2 <= pair_paralleltaplimitcsr_bound_max;
			pair_paralleltaplimitcsr_neg_rail_value2 <= 1'd1;
		end else begin
			if ((pair_paralleltaplimitcsr_total2 >= pair_paralleltaplimitcsr_neg_bound_min)) begin
				pair_paralleltaplimitcsr_neg_value2 <= pair_paralleltaplimitcsr_bound_min;
				pair_paralleltaplimitcsr_neg_rail_value2 <= 1'd1;
			end else begin
				pair_paralleltaplimitcsr_neg_value2 <= (-pair_paralleltaplimitcsr_total2);
				pair_paralleltaplimitcsr_neg_rail_value2 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_paralleltaplimitcsr_pre_y = (pair_paralleltaplimitcsr4 ? array_muxed1 : array_muxed2);
assign pair_paralleltaplimitcsr_pre_rail = (pair_paralleltaplimitcsr4 ? array_muxed3 : array_muxed4);

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_limit0_y <= 28'sd0;
	pair_paralleltaplimitcsr_limit0_railed <= 1'd0;
	if ((pair_paralleltaplimitcsr_limit0_x >= pair_paralleltaplimitcsr_limit0_max)) begin
		pair_paralleltaplimitcsr_limit0_y <= pair_paralleltaplimitcsr_limit0_max;
		pair_paralleltaplimitcsr_limit0_railed <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_limit0_x <= pair_paralleltaplimitcsr_limit0_min)) begin
			pair_paralleltaplimitcsr_limit0_y <= pair_paralleltaplimitcsr_limit0_min;
			pair_paralleltaplimitcsr_limit0_railed <= 1'd1;
		end else begin
			pair_paralleltaplimitcsr_limit0_y <= pair_paralleltaplimitcsr_limit0_x;
			pair_paralleltaplimitcsr_limit0_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_limit1_y <= 28'sd0;
	pair_paralleltaplimitcsr_limit1_railed <= 1'd0;
	if ((pair_paralleltaplimitcsr_limit1_x >= pair_paralleltaplimitcsr_limit1_max)) begin
		pair_paralleltaplimitcsr_limit1_y <= pair_paralleltaplimitcsr_limit1_max;
		pair_paralleltaplimitcsr_limit1_railed <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_limit1_x <= pair_paralleltaplimitcsr_limit1_min)) begin
			pair_paralleltaplimitcsr_limit1_y <= pair_paralleltaplimitcsr_limit1_min;
			pair_paralleltaplimitcsr_limit1_railed <= 1'd1;
		end else begin
			pair_paralleltaplimitcsr_limit1_y <= pair_paralleltaplimitcsr_limit1_x;
			pair_paralleltaplimitcsr_limit1_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_paralleltaplimitcsr_limit2_y <= 28'sd0;
	pair_paralleltaplimitcsr_limit2_railed <= 1'd0;
	if ((pair_paralleltaplimitcsr_limit2_x >= pair_paralleltaplimitcsr_limit2_max)) begin
		pair_paralleltaplimitcsr_limit2_y <= pair_paralleltaplimitcsr_limit2_max;
		pair_paralleltaplimitcsr_limit2_railed <= 1'd1;
	end else begin
		if ((pair_paralleltaplimitcsr_limit2_x <= pair_paralleltaplimitcsr_limit2_min)) begin
			pair_paralleltaplimitcsr_limit2_y <= pair_paralleltaplimitcsr_limit2_min;
			pair_paralleltaplimitcsr_limit2_railed <= 1'd1;
		end else begin
			pair_paralleltaplimitcsr_limit2_y <= pair_paralleltaplimitcsr_limit2_x;
			pair_paralleltaplimitcsr_limit2_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_limit_x = pair_x;

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_limit_y <= 28'sd0;
	pair_limit_railed <= 1'd0;
	if ((pair_limit_x >= pair_limit_max)) begin
		pair_limit_y <= pair_limit_max;
		pair_limit_railed <= 1'd1;
	end else begin
		if ((pair_limit_x <= pair_limit_min)) begin
			pair_limit_y <= pair_limit_min;
			pair_limit_railed <= 1'd1;
		end else begin
			pair_limit_y <= pair_limit_x;
			pair_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_tap0_r = pair_bus_dat_w[1:0];
assign pair_tap0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 1'd0));
assign pair_invert0_r = pair_bus_dat_w[0];
assign pair_invert0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 1'd1));
assign pair_limit_min3_r = pair_bus_dat_w[0];
assign pair_limit_min3_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 2'd2));
assign pair_limit_min2_r = pair_bus_dat_w[7:0];
assign pair_limit_min2_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 2'd3));
assign pair_limit_min1_r = pair_bus_dat_w[7:0];
assign pair_limit_min1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd4));
assign pair_limit_min0_r = pair_bus_dat_w[7:0];
assign pair_limit_min0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd5));
assign pair_limit_max3_r = pair_bus_dat_w[0];
assign pair_limit_max3_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd6));
assign pair_limit_max2_r = pair_bus_dat_w[7:0];
assign pair_limit_max2_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd7));
assign pair_limit_max1_r = pair_bus_dat_w[7:0];
assign pair_limit_max1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd8));
assign pair_limit_max0_r = pair_bus_dat_w[7:0];
assign pair_limit_max0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd9));
assign pair_tap_storage = pair_tap_storage_full[1:0];
assign pair_tap0_w = pair_tap_storage_full[1:0];
assign pair_invert_storage = pair_invert_storage_full;
assign pair_invert0_w = pair_invert_storage_full;
assign pair_paralleltaplimitcsr_min_storage = pair_paralleltaplimitcsr_min_storage_full[24:0];
assign pair_limit_min3_w = pair_paralleltaplimitcsr_min_storage_full[24];
assign pair_limit_min2_w = pair_paralleltaplimitcsr_min_storage_full[23:16];
assign pair_limit_min1_w = pair_paralleltaplimitcsr_min_storage_full[15:8];
assign pair_limit_min0_w = pair_paralleltaplimitcsr_min_storage_full[7:0];
assign pair_paralleltaplimitcsr_max_storage = pair_paralleltaplimitcsr_max_storage_full[24:0];
assign pair_limit_max3_w = pair_paralleltaplimitcsr_max_storage_full[24];
assign pair_limit_max2_w = pair_paralleltaplimitcsr_max_storage_full[23:16];
assign pair_limit_max1_w = pair_paralleltaplimitcsr_max_storage_full[15:8];
assign pair_limit_max0_w = pair_paralleltaplimitcsr_max_storage_full[7:0];

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 25'sd0;
	case (pair_tap_storage)
		1'd0: begin
			array_muxed0 <= t0;
		end
		1'd1: begin
			array_muxed0 <= t1;
		end
		default: begin
			array_muxed0 <= t2;
		end
	endcase
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 28'sd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed1 <= pair_paralleltaplimitcsr_neg_value0;
		end
		1'd1: begin
			array_muxed1 <= pair_paralleltaplimitcsr_neg_value1;
		end
		default: begin
			array_muxed1 <= pair_paralleltaplimitcsr_neg_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 28'sd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed2 <= pair_paralleltaplimitcsr_limit0_y;
		end
		1'd1: begin
			array_muxed2 <= pair_paralleltaplimitcsr_limit1_y;
		end
		default: begin
			array_muxed2 <= pair_paralleltaplimitcsr_limit2_y;
		end
	endcase
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed3 <= pair_paralleltaplimitcsr_neg_rail_value0;
		end
		1'd1: begin
			array_muxed3 <= pair_paralleltaplimitcsr_neg_rail_value1;
		end
		default: begin
			array_muxed3 <= pair_paralleltaplimitcsr_neg_rail_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 1'd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed4 <= pair_paralleltaplimitcsr_limit0_railed;
		end
		1'd1: begin
			array_muxed4 <= pair_paralleltaplimitcsr_limit1_railed;
		end
		default: begin
			array_muxed4 <= pair_paralleltaplimitcsr_limit2_railed;
		end
	endcase
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	if (pair_paralleltaplimitcsr_update_en) begin
		pair_paralleltaplimitcsr_bound_min <= {{3{pair_paralleltaplimitcsr_min_storage[24]}}, pair_paralleltaplimitcsr_min_storage};
		pair_paralleltaplimitcsr_bound_max <= {{3{pair_paralleltaplimitcsr_max_storage[24]}}, pair_paralleltaplimitcsr_max_storage};
		pair_paralleltaplimitcsr_neg_bound_min <= (-$signed({1'd0, {{3{pair_paralleltaplimitcsr_min_storage[24]}}, pair_paralleltaplimitcsr_min_storage}}));
		pair_paralleltaplimitcsr_neg_bound_max <= (-$signed({1'd0, {{3{pair_paralleltaplimitcsr_max_storage[24]}}, pair_paralleltaplimitcsr_max_storage}}));
		pair_paralleltaplimitcsr_y <= pair_paralleltaplimitcsr_pre_y;
		pair_paralleltaplimitcsr_error <= pair_paralleltaplimitcsr_pre_rail;
	end
	if (pair_update_en) begin
		pair_limit_min <= {{3{pair_min_storage[24]}}, pair_min_storage};
		pair_limit_max <= {{3{pair_max_storage[24]}}, pair_max_storage};
		pair_limitcsr_y <= pair_limit_y;
		pair_limitcsr_error <= pair_limit_railed;
	end
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[3:0])
			1'd0: begin
				pair_bus_dat_r <= pair_tap0_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_invert0_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_limit_min3_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_limit_min2_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_limit_min1_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_limit_min0_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_limit_max3_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_limit_max2_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_limit_max1_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_limit_max0_w;
			end
		endcase
	end
	if (pair_tap0_re) begin
		pair_tap_storage_full[1:0] <= pair_tap0_r;
	end
	pair_tap_re <= pair_tap0_re;
	if (pair_invert0_re) begin
		pair_invert_storage_full <= pair_invert0_r;
	end
	pair_invert_re <= pair_invert0_re;
	if (pair_limit_min3_re) begin
		pair_paralleltaplimitcsr_min_storage_full[24] <= pair_limit_min3_r;
	end
	if (pair_limit_min2_re) begin
		pair_paralleltaplimitcsr_min_storage_full[23:16] <= pair_limit_min2_r;
	end
	if (pair_limit_min1_re) begin
		pair_paralleltaplimitcsr_min_storage_full[15:8] <= pair_limit_min1_r;
	end
	if (pair_limit_min0_re) begin
		pair_paralleltaplimitcsr_min_storage_full[7:0] <= pair_limit_min0_r;
	end
	pair_paralleltaplimitcsr_min_re <= pair_limit_min0_re;
	if (pair_limit_max3_re) begin
		pair_paralleltaplimitcsr_max_storage_full[24] <= pair_limit_max3_r;
	end
	if (pair_limit_max2_re) begin
		pair_paralleltaplimitcsr_max_storage_full[23:16] <= pair_limit_max2_r;
	end
	if (pair_limit_max1_re) begin
		pair_paralleltaplimitcsr_max_storage_full[15:8] <= pair_limit_max1_r;
	end
	if (pair_limit_max0_re) begin
		pair_paralleltaplimitcsr_max_storage_full[7:0] <= pair_limit_max0_r;
	end
	pair_paralleltaplimitcsr_max_re <= pair_limit_max0_re;
	if (sys_rst) begin
		pair_tap_storage_full <= 2'd0;
		pair_tap_re <= 1'd0;
		pair_invert_storage_full <= 1'd0;
		pair_invert_re <= 1'd0;
		pair_paralleltaplimitcsr_y <= 25'sd0;
		pair_paralleltaplimitcsr_error <= 1'd0;
		pair_paralleltaplimitcsr_min_storage_full <= 25'd16777216;
		pair_paralleltaplimitcsr_min_re <= 1'd0;
		pair_paralleltaplimitcsr_max_storage_full <= 25'd16777215;
		pair_paralleltaplimitcsr_max_re <= 1'd0;
		pair_paralleltaplimitcsr_bound_min <= 28'sd0;
		pair_paralleltaplimitcsr_bound_max <= 28'sd0;
		pair_paralleltaplimitcsr_neg_bound_min <= 28'sd0;
		pair_paralleltaplimitcsr_neg_bound_max <= 28'sd0;
		pair_limitcsr_y <= 25'sd0;
		pair_limitcsr_error <= 1'd0;
		pair_limit_max <= 28'sd0;
		pair_limit_min <= 28'sd0;
		pair_bus_dat_r <= 8'd0;
	end
end

endmodule
