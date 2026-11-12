/* Machine-generated using Migen */
module r78_limit_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] dx,
	input signed [13:0] offset,
	input signed [24:0] t0,
	input signed [24:0] t1,
	input signed [24:0] t2,
	input ce,
	input [1:0] sel,
	input inv,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [24:0] ref_y,
	output ref_error,
	output [27:0] ref_pre,
	output ref_rail,
	output [27:0] ref_lo,
	output [27:0] ref_hi,
	output [27:0] ref_neg_lo,
	output [27:0] ref_neg_hi,
	output [17:0] ref_common,
	output [7:0] ref_read,
	output [49:0] ref_cfg,
	output [24:0] cand_y,
	output cand_error,
	output [27:0] cand_pre,
	output cand_rail,
	output [27:0] cand_lo,
	output [27:0] cand_hi,
	output [27:0] cand_neg_lo,
	output [27:0] cand_neg_hi,
	output [17:0] cand_common,
	output [7:0] cand_read,
	output [49:0] cand_cfg,
	output [27:0] thr_lo,
	output [27:0] thr_hi,
	output [27:0] thr_neg_hi,
	output [27:0] thr_neg_lo
);

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
reg signed [24:0] pair_earlycommontaplimitcsr_y = 25'sd0;
reg pair_earlycommontaplimitcsr_error = 1'd0;
wire pair_earlycommontaplimitcsr_update_en;
wire signed [24:0] pair_earlycommontaplimitcsr0;
wire signed [24:0] pair_earlycommontaplimitcsr1;
wire signed [24:0] pair_earlycommontaplimitcsr2;
wire signed [13:0] pair_earlycommontaplimitcsr_common_x;
wire signed [13:0] pair_earlycommontaplimitcsr_common_offset;
reg signed [14:0] pair_earlycommontaplimitcsr_common_reg = 15'sd0;
wire [1:0] pair_earlycommontaplimitcsr3;
wire pair_earlycommontaplimitcsr4;
reg [24:0] pair_earlycommontaplimitcsr_min_storage_full = 25'd16777216;
wire [24:0] pair_earlycommontaplimitcsr_min_storage;
reg pair_earlycommontaplimitcsr_min_re = 1'd0;
reg [24:0] pair_earlycommontaplimitcsr_max_storage_full = 25'd16777215;
wire [24:0] pair_earlycommontaplimitcsr_max_storage;
reg pair_earlycommontaplimitcsr_max_re = 1'd0;
reg signed [27:0] pair_earlycommontaplimitcsr5 = 28'sd0;
reg signed [27:0] pair_earlycommontaplimitcsr6 = 28'sd0;
reg signed [27:0] pair_earlycommontaplimitcsr7 = 28'sd0;
reg signed [27:0] pair_earlycommontaplimitcsr8 = 28'sd0;
wire signed [24:0] pair_earlycommontaplimitcsr9;
wire signed [24:0] pair_earlycommontaplimitcsr10;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr1;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr2;
wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr3;
wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr4;
wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr5;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr6;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr7;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr8;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr9;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_high;
wire [10:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_low;
reg signed [27:0] pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result = 28'sd0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr1;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr2;
wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr3;
wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr4;
wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr5;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr6;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr7;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr8;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr9;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_high;
wire [10:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_low;
reg signed [27:0] pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result = 28'sd0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr1;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr2;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr3;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr4;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr5;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr6;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr7;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr8;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr9;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_high;
wire [10:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_low;
reg signed [27:0] pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result = 28'sd0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr0;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr1;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr2;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr3;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr4;
wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr5;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr6;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr7;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr8;
(* keep = "true" *) wire [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr9;
wire signed [15:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_high;
wire [10:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_low;
reg signed [27:0] pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result = 28'sd0;
wire signed [27:0] pair_earlycommontaplimitcsr_total0;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr11;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr12;
(* keep = "true" *) reg pair_earlycommontaplimitcsr13;
(* keep = "true" *) reg pair_earlycommontaplimitcsr14;
wire signed [27:0] pair_earlycommontaplimitcsr_total1;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr15;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr16;
(* keep = "true" *) reg pair_earlycommontaplimitcsr17;
(* keep = "true" *) reg pair_earlycommontaplimitcsr18;
wire signed [27:0] pair_earlycommontaplimitcsr_total2;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr19;
(* keep = "true" *) reg signed [27:0] pair_earlycommontaplimitcsr20;
(* keep = "true" *) reg pair_earlycommontaplimitcsr21;
(* keep = "true" *) reg pair_earlycommontaplimitcsr22;
wire signed [27:0] pair_earlycommontaplimitcsr23;
wire pair_earlycommontaplimitcsr24;
wire [13:0] pair_reference_bank_bus_adr;
wire pair_reference_bank_bus_we;
wire [7:0] pair_reference_bank_bus_dat_w;
reg [7:0] pair_reference_bank_bus_dat_r = 8'd0;
wire pair_reference_bank_min3_re;
wire pair_reference_bank_min3_r;
wire pair_reference_bank_min3_w;
wire pair_reference_bank_min2_re;
wire [7:0] pair_reference_bank_min2_r;
wire [7:0] pair_reference_bank_min2_w;
wire pair_reference_bank_min1_re;
wire [7:0] pair_reference_bank_min1_r;
wire [7:0] pair_reference_bank_min1_w;
wire pair_reference_bank_min0_re;
wire [7:0] pair_reference_bank_min0_r;
wire [7:0] pair_reference_bank_min0_w;
wire pair_reference_bank_max3_re;
wire pair_reference_bank_max3_r;
wire pair_reference_bank_max3_w;
wire pair_reference_bank_max2_re;
wire [7:0] pair_reference_bank_max2_r;
wire [7:0] pair_reference_bank_max2_w;
wire pair_reference_bank_max1_re;
wire [7:0] pair_reference_bank_max1_r;
wire [7:0] pair_reference_bank_max1_w;
wire pair_reference_bank_max0_re;
wire [7:0] pair_reference_bank_max0_r;
wire [7:0] pair_reference_bank_max0_w;
wire pair_reference_bank_sel;
wire [13:0] pair_candidate_bank_bus_adr;
wire pair_candidate_bank_bus_we;
wire [7:0] pair_candidate_bank_bus_dat_w;
reg [7:0] pair_candidate_bank_bus_dat_r = 8'd0;
wire pair_candidate_bank_min3_re;
wire pair_candidate_bank_min3_r;
wire pair_candidate_bank_min3_w;
wire pair_candidate_bank_min2_re;
wire [7:0] pair_candidate_bank_min2_r;
wire [7:0] pair_candidate_bank_min2_w;
wire pair_candidate_bank_min1_re;
wire [7:0] pair_candidate_bank_min1_r;
wire [7:0] pair_candidate_bank_min1_w;
wire pair_candidate_bank_min0_re;
wire [7:0] pair_candidate_bank_min0_r;
wire [7:0] pair_candidate_bank_min0_w;
wire pair_candidate_bank_max3_re;
wire pair_candidate_bank_max3_r;
wire pair_candidate_bank_max3_w;
wire pair_candidate_bank_max2_re;
wire [7:0] pair_candidate_bank_max2_r;
wire [7:0] pair_candidate_bank_max2_w;
wire pair_candidate_bank_max1_re;
wire [7:0] pair_candidate_bank_max1_r;
wire [7:0] pair_candidate_bank_max1_w;
wire pair_candidate_bank_max0_re;
wire [7:0] pair_candidate_bank_max0_r;
wire [7:0] pair_candidate_bank_max0_w;
wire pair_candidate_bank_sel;
reg signed [17:0] pair_old_common = 18'sd0;
reg signed [27:0] array_muxed0;
reg signed [27:0] array_muxed1;
reg array_muxed2;
reg array_muxed3;
reg signed [27:0] array_muxed4;
reg signed [27:0] array_muxed5;
reg array_muxed6;
reg array_muxed7;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_paralleltaplimitcsr_common_a = (pair_old_common <<< 4'd11);
assign pair_paralleltaplimitcsr_common_b = 1'd0;
assign pair_earlycommontaplimitcsr_common_x = dx;
assign pair_earlycommontaplimitcsr_common_offset = offset;
assign pair_paralleltaplimitcsr_update_en = ce;
assign pair_paralleltaplimitcsr3 = sel;
assign pair_paralleltaplimitcsr4 = inv;
assign pair_reference_bank_bus_adr = csr_adr;
assign pair_reference_bank_bus_we = csr_we;
assign pair_reference_bank_bus_dat_w = csr_dat_w;
assign pair_paralleltaplimitcsr0 = t0;
assign pair_paralleltaplimitcsr1 = t1;
assign pair_paralleltaplimitcsr2 = t2;
assign pair_earlycommontaplimitcsr_update_en = ce;
assign pair_earlycommontaplimitcsr3 = sel;
assign pair_earlycommontaplimitcsr4 = inv;
assign pair_candidate_bank_bus_adr = csr_adr;
assign pair_candidate_bank_bus_we = csr_we;
assign pair_candidate_bank_bus_dat_w = csr_dat_w;
assign pair_earlycommontaplimitcsr0 = t0;
assign pair_earlycommontaplimitcsr1 = t1;
assign pair_earlycommontaplimitcsr2 = t2;
assign ref_y = pair_paralleltaplimitcsr_y;
assign ref_error = pair_paralleltaplimitcsr_error;
assign ref_pre = pair_paralleltaplimitcsr_pre_y;
assign ref_rail = pair_paralleltaplimitcsr_pre_rail;
assign ref_lo = pair_paralleltaplimitcsr_bound_min;
assign ref_hi = pair_paralleltaplimitcsr_bound_max;
assign ref_neg_lo = pair_paralleltaplimitcsr_neg_bound_min;
assign ref_neg_hi = pair_paralleltaplimitcsr_neg_bound_max;
assign ref_common = pair_old_common;
assign ref_read = pair_reference_bank_bus_dat_r;
assign ref_cfg = {pair_paralleltaplimitcsr_max_storage, pair_paralleltaplimitcsr_min_storage};
assign cand_y = pair_earlycommontaplimitcsr_y;
assign cand_error = pair_earlycommontaplimitcsr_error;
assign cand_pre = pair_earlycommontaplimitcsr23;
assign cand_rail = pair_earlycommontaplimitcsr24;
assign cand_lo = pair_earlycommontaplimitcsr5;
assign cand_hi = pair_earlycommontaplimitcsr6;
assign cand_neg_lo = pair_earlycommontaplimitcsr7;
assign cand_neg_hi = pair_earlycommontaplimitcsr8;
assign cand_common = pair_earlycommontaplimitcsr_common_reg;
assign cand_read = pair_candidate_bank_bus_dat_r;
assign cand_cfg = {pair_earlycommontaplimitcsr_max_storage, pair_earlycommontaplimitcsr_min_storage};
assign thr_lo = pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result;
assign thr_hi = pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result;
assign thr_neg_hi = pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result;
assign thr_neg_lo = pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result;
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
assign pair_paralleltaplimitcsr_pre_y = (pair_paralleltaplimitcsr4 ? array_muxed0 : array_muxed1);
assign pair_paralleltaplimitcsr_pre_rail = (pair_paralleltaplimitcsr4 ? array_muxed2 : array_muxed3);

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
assign pair_earlycommontaplimitcsr9 = (pair_earlycommontaplimitcsr_update_en ? $signed({1'd0, pair_earlycommontaplimitcsr_min_storage}) : pair_earlycommontaplimitcsr5[24:0]);
assign pair_earlycommontaplimitcsr10 = (pair_earlycommontaplimitcsr_update_en ? $signed({1'd0, pair_earlycommontaplimitcsr_max_storage}) : pair_earlycommontaplimitcsr6[24:0]);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr0 = (pair_earlycommontaplimitcsr9 >>> 4'd11);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr1 = pair_earlycommontaplimitcsr_common_x;
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr2 = pair_earlycommontaplimitcsr_common_offset;
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr3 = pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr0;
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr4 = (~pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr1);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr5 = (~pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr2);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr6 = ((pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr3 ^ pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr4) ^ pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr5);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr7 = ((((pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr4) | (pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr5)) | (pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr4 & pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr5)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr8 = ((pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr6 ^ pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr7) ^ 16'd2);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr9 = ((((pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr6 & pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr7) | (pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr6 & 16'd2)) | (pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr7 & 16'd2)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_high = (pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr8 + pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr9);
assign pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_low = pair_earlycommontaplimitcsr9[10:0];
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr0 = (pair_earlycommontaplimitcsr10 >>> 4'd11);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr1 = pair_earlycommontaplimitcsr_common_x;
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr2 = pair_earlycommontaplimitcsr_common_offset;
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr3 = pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr0;
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr4 = (~pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr1);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr5 = (~pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr2);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr6 = ((pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr3 ^ pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr4) ^ pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr5);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr7 = ((((pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr4) | (pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr5)) | (pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr4 & pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr5)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr8 = ((pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr6 ^ pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr7) ^ 16'd2);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr9 = ((((pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr6 & pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr7) | (pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr6 & 16'd2)) | (pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr7 & 16'd2)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_high = (pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr8 + pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr9);
assign pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_low = pair_earlycommontaplimitcsr10[10:0];
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr0 = (pair_earlycommontaplimitcsr10 >>> 4'd11);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr1 = pair_earlycommontaplimitcsr_common_x;
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr2 = pair_earlycommontaplimitcsr_common_offset;
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr3 = (~pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr0);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr4 = (~pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr1);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr5 = (~pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr2);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr6 = ((pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr3 ^ pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr4) ^ pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr5);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr7 = ((((pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr4) | (pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr5)) | (pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr4 & pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr5)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr8 = ((pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr6 ^ pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr7) ^ {14'd0, 1'd1, (pair_earlycommontaplimitcsr10[10:0] == $signed({1'd0, 1'd0}))});
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr9 = ((((pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr6 & pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr7) | (pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr6 & {14'd0, 1'd1, (pair_earlycommontaplimitcsr10[10:0] == $signed({1'd0, 1'd0}))})) | (pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr7 & {14'd0, 1'd1, (pair_earlycommontaplimitcsr10[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_high = (pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr8 + pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr9);
assign pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_low = (-pair_earlycommontaplimitcsr10[10:0]);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr0 = (pair_earlycommontaplimitcsr9 >>> 4'd11);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr1 = pair_earlycommontaplimitcsr_common_x;
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr2 = pair_earlycommontaplimitcsr_common_offset;
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr3 = (~pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr0);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr4 = (~pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr1);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr5 = (~pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr2);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr6 = ((pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr3 ^ pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr4) ^ pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr5);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr7 = ((((pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr4) | (pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr3 & pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr5)) | (pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr4 & pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr5)) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr8 = ((pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr6 ^ pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr7) ^ {14'd0, 1'd1, (pair_earlycommontaplimitcsr9[10:0] == $signed({1'd0, 1'd0}))});
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr9 = ((((pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr6 & pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr7) | (pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr6 & {14'd0, 1'd1, (pair_earlycommontaplimitcsr9[10:0] == $signed({1'd0, 1'd0}))})) | (pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr7 & {14'd0, 1'd1, (pair_earlycommontaplimitcsr9[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_high = (pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr8 + pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr9);
assign pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_low = (-pair_earlycommontaplimitcsr9[10:0]);
assign pair_earlycommontaplimitcsr_total0 = (pair_earlycommontaplimitcsr0 + (pair_earlycommontaplimitcsr_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr11 <= 28'sd0;
	pair_earlycommontaplimitcsr13 <= 1'd0;
	if ((pair_earlycommontaplimitcsr0 >= pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr11 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr13 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr0 <= pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr11 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr13 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr11 <= pair_earlycommontaplimitcsr_total0;
			pair_earlycommontaplimitcsr13 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr12 <= 28'sd0;
	pair_earlycommontaplimitcsr14 <= 1'd0;
	if ((pair_earlycommontaplimitcsr0 <= pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr12 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr14 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr0 >= pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr12 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr14 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr12 <= (-pair_earlycommontaplimitcsr_total0);
			pair_earlycommontaplimitcsr14 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign pair_earlycommontaplimitcsr_total1 = (pair_earlycommontaplimitcsr1 + (pair_earlycommontaplimitcsr_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr15 <= 28'sd0;
	pair_earlycommontaplimitcsr17 <= 1'd0;
	if ((pair_earlycommontaplimitcsr1 >= pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr15 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr17 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr1 <= pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr15 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr17 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr15 <= pair_earlycommontaplimitcsr_total1;
			pair_earlycommontaplimitcsr17 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr16 <= 28'sd0;
	pair_earlycommontaplimitcsr18 <= 1'd0;
	if ((pair_earlycommontaplimitcsr1 <= pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr16 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr18 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr1 >= pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr16 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr18 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr16 <= (-pair_earlycommontaplimitcsr_total1);
			pair_earlycommontaplimitcsr18 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign pair_earlycommontaplimitcsr_total2 = (pair_earlycommontaplimitcsr2 + (pair_earlycommontaplimitcsr_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr19 <= 28'sd0;
	pair_earlycommontaplimitcsr21 <= 1'd0;
	if ((pair_earlycommontaplimitcsr2 >= pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr19 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr21 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr2 <= pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr19 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr21 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr19 <= pair_earlycommontaplimitcsr_total2;
			pair_earlycommontaplimitcsr21 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	pair_earlycommontaplimitcsr20 <= 28'sd0;
	pair_earlycommontaplimitcsr22 <= 1'd0;
	if ((pair_earlycommontaplimitcsr2 <= pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result)) begin
		pair_earlycommontaplimitcsr20 <= pair_earlycommontaplimitcsr6;
		pair_earlycommontaplimitcsr22 <= 1'd1;
	end else begin
		if ((pair_earlycommontaplimitcsr2 >= pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result)) begin
			pair_earlycommontaplimitcsr20 <= pair_earlycommontaplimitcsr5;
			pair_earlycommontaplimitcsr22 <= 1'd1;
		end else begin
			pair_earlycommontaplimitcsr20 <= (-pair_earlycommontaplimitcsr_total2);
			pair_earlycommontaplimitcsr22 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign pair_earlycommontaplimitcsr23 = (pair_earlycommontaplimitcsr4 ? array_muxed4 : array_muxed5);
assign pair_earlycommontaplimitcsr24 = (pair_earlycommontaplimitcsr4 ? array_muxed6 : array_muxed7);
assign pair_reference_bank_sel = (pair_reference_bank_bus_adr[13:9] == 1'd0);
assign pair_reference_bank_min3_r = pair_reference_bank_bus_dat_w[0];
assign pair_reference_bank_min3_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 1'd0));
assign pair_reference_bank_min2_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_min2_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 1'd1));
assign pair_reference_bank_min1_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_min1_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 2'd2));
assign pair_reference_bank_min0_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_min0_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 2'd3));
assign pair_reference_bank_max3_r = pair_reference_bank_bus_dat_w[0];
assign pair_reference_bank_max3_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 3'd4));
assign pair_reference_bank_max2_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_max2_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 3'd5));
assign pair_reference_bank_max1_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_max1_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 3'd6));
assign pair_reference_bank_max0_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_max0_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 3'd7));
assign pair_paralleltaplimitcsr_min_storage = pair_paralleltaplimitcsr_min_storage_full[24:0];
assign pair_reference_bank_min3_w = pair_paralleltaplimitcsr_min_storage_full[24];
assign pair_reference_bank_min2_w = pair_paralleltaplimitcsr_min_storage_full[23:16];
assign pair_reference_bank_min1_w = pair_paralleltaplimitcsr_min_storage_full[15:8];
assign pair_reference_bank_min0_w = pair_paralleltaplimitcsr_min_storage_full[7:0];
assign pair_paralleltaplimitcsr_max_storage = pair_paralleltaplimitcsr_max_storage_full[24:0];
assign pair_reference_bank_max3_w = pair_paralleltaplimitcsr_max_storage_full[24];
assign pair_reference_bank_max2_w = pair_paralleltaplimitcsr_max_storage_full[23:16];
assign pair_reference_bank_max1_w = pair_paralleltaplimitcsr_max_storage_full[15:8];
assign pair_reference_bank_max0_w = pair_paralleltaplimitcsr_max_storage_full[7:0];
assign pair_candidate_bank_sel = (pair_candidate_bank_bus_adr[13:9] == 1'd0);
assign pair_candidate_bank_min3_r = pair_candidate_bank_bus_dat_w[0];
assign pair_candidate_bank_min3_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 1'd0));
assign pair_candidate_bank_min2_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_min2_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 1'd1));
assign pair_candidate_bank_min1_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_min1_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 2'd2));
assign pair_candidate_bank_min0_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_min0_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 2'd3));
assign pair_candidate_bank_max3_r = pair_candidate_bank_bus_dat_w[0];
assign pair_candidate_bank_max3_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 3'd4));
assign pair_candidate_bank_max2_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_max2_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 3'd5));
assign pair_candidate_bank_max1_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_max1_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 3'd6));
assign pair_candidate_bank_max0_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_max0_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 3'd7));
assign pair_earlycommontaplimitcsr_min_storage = pair_earlycommontaplimitcsr_min_storage_full[24:0];
assign pair_candidate_bank_min3_w = pair_earlycommontaplimitcsr_min_storage_full[24];
assign pair_candidate_bank_min2_w = pair_earlycommontaplimitcsr_min_storage_full[23:16];
assign pair_candidate_bank_min1_w = pair_earlycommontaplimitcsr_min_storage_full[15:8];
assign pair_candidate_bank_min0_w = pair_earlycommontaplimitcsr_min_storage_full[7:0];
assign pair_earlycommontaplimitcsr_max_storage = pair_earlycommontaplimitcsr_max_storage_full[24:0];
assign pair_candidate_bank_max3_w = pair_earlycommontaplimitcsr_max_storage_full[24];
assign pair_candidate_bank_max2_w = pair_earlycommontaplimitcsr_max_storage_full[23:16];
assign pair_candidate_bank_max1_w = pair_earlycommontaplimitcsr_max_storage_full[15:8];
assign pair_candidate_bank_max0_w = pair_earlycommontaplimitcsr_max_storage_full[7:0];

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 28'sd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed0 <= pair_paralleltaplimitcsr_neg_value0;
		end
		1'd1: begin
			array_muxed0 <= pair_paralleltaplimitcsr_neg_value1;
		end
		default: begin
			array_muxed0 <= pair_paralleltaplimitcsr_neg_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 28'sd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed1 <= pair_paralleltaplimitcsr_limit0_y;
		end
		1'd1: begin
			array_muxed1 <= pair_paralleltaplimitcsr_limit1_y;
		end
		default: begin
			array_muxed1 <= pair_paralleltaplimitcsr_limit2_y;
		end
	endcase
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 1'd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed2 <= pair_paralleltaplimitcsr_neg_rail_value0;
		end
		1'd1: begin
			array_muxed2 <= pair_paralleltaplimitcsr_neg_rail_value1;
		end
		default: begin
			array_muxed2 <= pair_paralleltaplimitcsr_neg_rail_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (pair_paralleltaplimitcsr3)
		1'd0: begin
			array_muxed3 <= pair_paralleltaplimitcsr_limit0_railed;
		end
		1'd1: begin
			array_muxed3 <= pair_paralleltaplimitcsr_limit1_railed;
		end
		default: begin
			array_muxed3 <= pair_paralleltaplimitcsr_limit2_railed;
		end
	endcase
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 28'sd0;
	case (pair_earlycommontaplimitcsr3)
		1'd0: begin
			array_muxed4 <= pair_earlycommontaplimitcsr12;
		end
		1'd1: begin
			array_muxed4 <= pair_earlycommontaplimitcsr16;
		end
		default: begin
			array_muxed4 <= pair_earlycommontaplimitcsr20;
		end
	endcase
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	array_muxed5 <= 28'sd0;
	case (pair_earlycommontaplimitcsr3)
		1'd0: begin
			array_muxed5 <= pair_earlycommontaplimitcsr11;
		end
		1'd1: begin
			array_muxed5 <= pair_earlycommontaplimitcsr15;
		end
		default: begin
			array_muxed5 <= pair_earlycommontaplimitcsr19;
		end
	endcase
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	array_muxed6 <= 1'd0;
	case (pair_earlycommontaplimitcsr3)
		1'd0: begin
			array_muxed6 <= pair_earlycommontaplimitcsr14;
		end
		1'd1: begin
			array_muxed6 <= pair_earlycommontaplimitcsr18;
		end
		default: begin
			array_muxed6 <= pair_earlycommontaplimitcsr22;
		end
	endcase
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	array_muxed7 <= 1'd0;
	case (pair_earlycommontaplimitcsr3)
		1'd0: begin
			array_muxed7 <= pair_earlycommontaplimitcsr13;
		end
		1'd1: begin
			array_muxed7 <= pair_earlycommontaplimitcsr17;
		end
		default: begin
			array_muxed7 <= pair_earlycommontaplimitcsr21;
		end
	endcase
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	pair_old_common <= (dx + offset);
	if (pair_paralleltaplimitcsr_update_en) begin
		pair_paralleltaplimitcsr_bound_min <= {{3{pair_paralleltaplimitcsr_min_storage[24]}}, pair_paralleltaplimitcsr_min_storage};
		pair_paralleltaplimitcsr_bound_max <= {{3{pair_paralleltaplimitcsr_max_storage[24]}}, pair_paralleltaplimitcsr_max_storage};
		pair_paralleltaplimitcsr_neg_bound_min <= (-$signed({1'd0, {{3{pair_paralleltaplimitcsr_min_storage[24]}}, pair_paralleltaplimitcsr_min_storage}}));
		pair_paralleltaplimitcsr_neg_bound_max <= (-$signed({1'd0, {{3{pair_paralleltaplimitcsr_max_storage[24]}}, pair_paralleltaplimitcsr_max_storage}}));
		pair_paralleltaplimitcsr_y <= pair_paralleltaplimitcsr_pre_y;
		pair_paralleltaplimitcsr_error <= pair_paralleltaplimitcsr_pre_rail;
	end
	pair_earlycommontaplimitcsr_common_reg <= (pair_earlycommontaplimitcsr_common_x + pair_earlycommontaplimitcsr_common_offset);
	pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result <= {{1{pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_high[15]}}, pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_high, pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_low};
	pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result <= {{1{pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_high[15]}}, pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_high, pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_low};
	pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result <= {{1{pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_high[15]}}, pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_high, pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_low};
	pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result <= {{1{pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_high[15]}}, pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_high, pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_low};
	if (pair_earlycommontaplimitcsr_update_en) begin
		pair_earlycommontaplimitcsr5 <= {{3{pair_earlycommontaplimitcsr_min_storage[24]}}, pair_earlycommontaplimitcsr_min_storage};
		pair_earlycommontaplimitcsr6 <= {{3{pair_earlycommontaplimitcsr_max_storage[24]}}, pair_earlycommontaplimitcsr_max_storage};
		pair_earlycommontaplimitcsr7 <= (-$signed({1'd0, {{3{pair_earlycommontaplimitcsr_min_storage[24]}}, pair_earlycommontaplimitcsr_min_storage}}));
		pair_earlycommontaplimitcsr8 <= (-$signed({1'd0, {{3{pair_earlycommontaplimitcsr_max_storage[24]}}, pair_earlycommontaplimitcsr_max_storage}}));
		pair_earlycommontaplimitcsr_y <= pair_earlycommontaplimitcsr23;
		pair_earlycommontaplimitcsr_error <= pair_earlycommontaplimitcsr24;
	end
	pair_reference_bank_bus_dat_r <= 1'd0;
	if (pair_reference_bank_sel) begin
		case (pair_reference_bank_bus_adr[2:0])
			1'd0: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_min3_w;
			end
			1'd1: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_min2_w;
			end
			2'd2: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_min1_w;
			end
			2'd3: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_min0_w;
			end
			3'd4: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_max3_w;
			end
			3'd5: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_max2_w;
			end
			3'd6: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_max1_w;
			end
			3'd7: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_max0_w;
			end
		endcase
	end
	if (pair_reference_bank_min3_re) begin
		pair_paralleltaplimitcsr_min_storage_full[24] <= pair_reference_bank_min3_r;
	end
	if (pair_reference_bank_min2_re) begin
		pair_paralleltaplimitcsr_min_storage_full[23:16] <= pair_reference_bank_min2_r;
	end
	if (pair_reference_bank_min1_re) begin
		pair_paralleltaplimitcsr_min_storage_full[15:8] <= pair_reference_bank_min1_r;
	end
	if (pair_reference_bank_min0_re) begin
		pair_paralleltaplimitcsr_min_storage_full[7:0] <= pair_reference_bank_min0_r;
	end
	pair_paralleltaplimitcsr_min_re <= pair_reference_bank_min0_re;
	if (pair_reference_bank_max3_re) begin
		pair_paralleltaplimitcsr_max_storage_full[24] <= pair_reference_bank_max3_r;
	end
	if (pair_reference_bank_max2_re) begin
		pair_paralleltaplimitcsr_max_storage_full[23:16] <= pair_reference_bank_max2_r;
	end
	if (pair_reference_bank_max1_re) begin
		pair_paralleltaplimitcsr_max_storage_full[15:8] <= pair_reference_bank_max1_r;
	end
	if (pair_reference_bank_max0_re) begin
		pair_paralleltaplimitcsr_max_storage_full[7:0] <= pair_reference_bank_max0_r;
	end
	pair_paralleltaplimitcsr_max_re <= pair_reference_bank_max0_re;
	pair_candidate_bank_bus_dat_r <= 1'd0;
	if (pair_candidate_bank_sel) begin
		case (pair_candidate_bank_bus_adr[2:0])
			1'd0: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_min3_w;
			end
			1'd1: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_min2_w;
			end
			2'd2: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_min1_w;
			end
			2'd3: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_min0_w;
			end
			3'd4: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_max3_w;
			end
			3'd5: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_max2_w;
			end
			3'd6: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_max1_w;
			end
			3'd7: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_max0_w;
			end
		endcase
	end
	if (pair_candidate_bank_min3_re) begin
		pair_earlycommontaplimitcsr_min_storage_full[24] <= pair_candidate_bank_min3_r;
	end
	if (pair_candidate_bank_min2_re) begin
		pair_earlycommontaplimitcsr_min_storage_full[23:16] <= pair_candidate_bank_min2_r;
	end
	if (pair_candidate_bank_min1_re) begin
		pair_earlycommontaplimitcsr_min_storage_full[15:8] <= pair_candidate_bank_min1_r;
	end
	if (pair_candidate_bank_min0_re) begin
		pair_earlycommontaplimitcsr_min_storage_full[7:0] <= pair_candidate_bank_min0_r;
	end
	pair_earlycommontaplimitcsr_min_re <= pair_candidate_bank_min0_re;
	if (pair_candidate_bank_max3_re) begin
		pair_earlycommontaplimitcsr_max_storage_full[24] <= pair_candidate_bank_max3_r;
	end
	if (pair_candidate_bank_max2_re) begin
		pair_earlycommontaplimitcsr_max_storage_full[23:16] <= pair_candidate_bank_max2_r;
	end
	if (pair_candidate_bank_max1_re) begin
		pair_earlycommontaplimitcsr_max_storage_full[15:8] <= pair_candidate_bank_max1_r;
	end
	if (pair_candidate_bank_max0_re) begin
		pair_earlycommontaplimitcsr_max_storage_full[7:0] <= pair_candidate_bank_max0_r;
	end
	pair_earlycommontaplimitcsr_max_re <= pair_candidate_bank_max0_re;
	if (sys_rst) begin
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
		pair_earlycommontaplimitcsr_y <= 25'sd0;
		pair_earlycommontaplimitcsr_error <= 1'd0;
		pair_earlycommontaplimitcsr_common_reg <= 15'sd0;
		pair_earlycommontaplimitcsr_min_storage_full <= 25'd16777216;
		pair_earlycommontaplimitcsr_min_re <= 1'd0;
		pair_earlycommontaplimitcsr_max_storage_full <= 25'd16777215;
		pair_earlycommontaplimitcsr_max_re <= 1'd0;
		pair_earlycommontaplimitcsr5 <= 28'sd0;
		pair_earlycommontaplimitcsr6 <= 28'sd0;
		pair_earlycommontaplimitcsr7 <= 28'sd0;
		pair_earlycommontaplimitcsr8 <= 28'sd0;
		pair_earlycommontaplimitcsr_threshold_min_earlycommontaplimitcsr_result <= 28'sd0;
		pair_earlycommontaplimitcsr_threshold_max_earlycommontaplimitcsr_result <= 28'sd0;
		pair_earlycommontaplimitcsr_threshold_neg_max_earlycommontaplimitcsr_result <= 28'sd0;
		pair_earlycommontaplimitcsr_threshold_neg_min_earlycommontaplimitcsr_result <= 28'sd0;
		pair_reference_bank_bus_dat_r <= 8'd0;
		pair_candidate_bank_bus_dat_r <= 8'd0;
		pair_old_common <= 18'sd0;
	end
end

endmodule
