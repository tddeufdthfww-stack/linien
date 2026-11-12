/* Machine-generated using Migen */
module r78_chain_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] adc,
	input signed [13:0] offset,
	input signed [24:0] dy,
	input signed [24:0] dx,
	input [31:0] phase,
	input ce,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [87:0] reference_result,
	output [87:0] candidate_result
);

wire signed [13:0] pair_fastchain0_adc;
wire signed [24:0] pair_fastchain0_out_i;
wire signed [24:0] pair_fastchain0_pre_out_i;
wire pair_fastchain0_out_i_update_en;
wire signed [24:0] pair_fastchain0_out_q;
reg [1:0] pair_fastchain0_y_tap_storage_full = 2'd0;
wire [1:0] pair_fastchain0_y_tap_storage;
reg pair_fastchain0_y_tap_re = 1'd0;
reg pair_fastchain0_invert_storage_full = 1'd0;
wire pair_fastchain0_invert_storage;
reg pair_fastchain0_invert_re = 1'd0;
wire signed [24:0] pair_fastchain0_x0;
wire signed [24:0] pair_fastchain0_dx;
wire signed [24:0] pair_fastchain0_dy;
wire signed [13:0] pair_fastchain0_x1;
wire signed [13:0] pair_fastchain0_i;
wire signed [13:0] pair_fastchain0_q0;
reg [31:0] pair_fastchain0_delay_storage_full = 32'd0;
wire [31:0] pair_fastchain0_delay_storage;
reg pair_fastchain0_delay_re = 1'd0;
reg [3:0] pair_fastchain0_multiplier_storage_full = 4'd1;
wire [3:0] pair_fastchain0_multiplier_storage;
reg pair_fastchain0_multiplier_re = 1'd0;
wire [13:0] pair_fastchain0_phase;
wire signed [14:0] pair_fastchain0_phase_value;
reg signed [14:0] pair_fastchain0_speculativedemodcordic0_xi;
reg signed [14:0] pair_fastchain0_speculativedemodcordic0_yi;
reg signed [14:0] pair_fastchain0_speculativedemodcordic0_zi;
wire signed [14:0] pair_fastchain0_speculativedemodcordic0_xo;
wire signed [14:0] pair_fastchain0_speculativedemodcordic0_yo;
wire signed [14:0] pair_fastchain0_speculativedemodcordic0_zo;
wire pair_fastchain0_speculativedemodcordic0_new_in;
wire pair_fastchain0_speculativedemodcordic0_new_out;
wire signed [16:0] pair_fastchain0_speculativedemodcordic00;
reg signed [16:0] pair_fastchain0_speculativedemodcordic01 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic02 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic03 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic04 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic05 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic06 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic07 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic08 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic09 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic010 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic011 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic012 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic013 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic014 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic015 = 17'sd0;
wire signed [16:0] pair_fastchain0_speculativedemodcordic016;
reg signed [16:0] pair_fastchain0_speculativedemodcordic017 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic018 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic019 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic020 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic021 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic022 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic023 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic024 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic025 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic026 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic027 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic028 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic029 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic030 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic031 = 17'sd0;
wire signed [16:0] pair_fastchain0_speculativedemodcordic032;
reg signed [16:0] pair_fastchain0_speculativedemodcordic033 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic034 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic035 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic036 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic037 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic038 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic039 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic040 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic041 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic042 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic043 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic044 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic045 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic046 = 17'sd0;
reg signed [16:0] pair_fastchain0_speculativedemodcordic047 = 17'sd0;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir0;
wire signed [16:0] pair_fastchain0_speculativedemodcordic0_speculativedemodcordic00;
wire signed [16:0] pair_fastchain0_speculativedemodcordic0_speculativedemodcordic01;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir1;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir2;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir3;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir4;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir5;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir6;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir7;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir8;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir9;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir10;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir11;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir12;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir13;
wire pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir14;
wire signed [14:0] pair_fastchain0_xi;
wire signed [14:0] pair_fastchain0_yi;
wire signed [14:0] pair_fastchain0_zi;
wire pair_fastchain0_q1;
reg signed [16:0] pair_fastchain0_ya = 17'sd0;
wire signed [13:0] pair_fastchain0_signed_offset;
reg signed [17:0] pair_fastchain0_common = 18'sd0;
reg signed [24:0] pair_fastchain0_limitcsr0_limitcsr0_y = 25'sd0;
reg pair_fastchain0_limitcsr0_limitcsr0_error = 1'd0;
reg pair_fastchain0_limitcsr0_update_en = 1'd1;
wire signed [25:0] pair_fastchain0_limitcsr0_x;
reg [24:0] pair_fastchain0_limitcsr0_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain0_limitcsr0_min_storage;
reg pair_fastchain0_limitcsr0_min_re = 1'd0;
reg [24:0] pair_fastchain0_limitcsr0_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain0_limitcsr0_max_storage;
reg pair_fastchain0_limitcsr0_max_re = 1'd0;
wire signed [25:0] pair_fastchain0_limitcsr0_limit_x;
reg signed [25:0] pair_fastchain0_limitcsr0_limit_y;
reg signed [25:0] pair_fastchain0_limitcsr0_limit_max = 26'sd0;
reg signed [25:0] pair_fastchain0_limitcsr0_limit_min = 26'sd0;
reg pair_fastchain0_limitcsr0_limit_railed;
wire signed [24:0] pair_fastchain0_iir0_x0;
reg signed [24:0] pair_fastchain0_iir0_y0 = 25'sd0;
wire pair_fastchain0_iir0_hold0;
wire pair_fastchain0_iir0_clear0;
reg pair_fastchain0_iir0_error0 = 1'd0;
reg [26:0] pair_fastchain0_iir0_storage_full0 = 27'd0;
wire [26:0] pair_fastchain0_iir0_storage0;
reg pair_fastchain0_iir0_re0 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_a10 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage0_storage_full0 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage0_storage0;
reg pair_fastchain0_iir0_csrstorage0_re0 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_b00 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage1_storage_full0 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage1_storage0;
reg pair_fastchain0_iir0_csrstorage1_re0 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_b10 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage2_storage_full0 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage2_storage0;
reg pair_fastchain0_iir0_csrstorage2_re0 = 1'd0;
reg signed [49:0] pair_fastchain0_iir0_z0r0 = 50'sd0;
reg signed [24:0] pair_fastchain0_iir0_y_lim0;
wire signed [49:0] pair_fastchain0_iir0_y_next0;
reg [2:0] pair_fastchain0_iir0_y_pat0 = 3'd7;
reg signed [24:0] pair_fastchain0_iir0_y1 = 25'sd0;
wire pair_fastchain0_iir0_railed0;
reg signed [49:0] pair_fastchain0_iir0_zr0 = 50'sd0;
wire signed [47:0] pair_fastchain0_iir0_zr_low0;
wire [47:0] pair_fastchain0_iir0_zr_cascade0;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q0;
wire pair_fastchain0_iir0_zr1;
wire pair_fastchain0_iir0_zr2;
wire signed [3:0] pair_fastchain0_iir0_zr_correction0;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q0 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q0 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top0;
wire signed [49:0] pair_fastchain0_iir0_zr_result0;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo0;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop0;
wire signed [47:0] pair_fastchain0_iir0_zr_low1;
wire [47:0] pair_fastchain0_iir0_zr_cascade1;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q1;
wire pair_fastchain0_iir0_zr3;
wire pair_fastchain0_iir0_zr4;
wire signed [3:0] pair_fastchain0_iir0_zr_correction1;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q1 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q1 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top1;
wire signed [49:0] pair_fastchain0_iir0_zr_result1;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo1;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop1;
wire signed [17:0] pair_fastchain0_iir0_z_xlo0;
wire signed [7:0] pair_fastchain0_iir0_z_xhi0;
wire signed [47:0] pair_fastchain0_iir0_z_zlo0;
wire signed [1:0] pair_fastchain0_iir0_z_ztop0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir0_z_low0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir0_z_high0;
wire pair_fastchain0_iir0_z_carry0;
wire signed [3:0] pair_fastchain0_iir0_z_correction0;
wire [1:0] pair_fastchain0_iir0_z_top0;
wire signed [49:0] pair_fastchain0_iir0_z_result0;
wire signed [24:0] pair_fastchain0_iir0_x1;
reg signed [24:0] pair_fastchain0_iir0_y2 = 25'sd0;
wire pair_fastchain0_iir0_hold1;
wire pair_fastchain0_iir0_clear1;
reg pair_fastchain0_iir0_error1 = 1'd0;
reg [26:0] pair_fastchain0_iir0_storage_full1 = 27'd0;
wire [26:0] pair_fastchain0_iir0_storage1;
reg pair_fastchain0_iir0_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_a11 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage0_storage_full1 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage0_storage1;
reg pair_fastchain0_iir0_csrstorage0_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_a2 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage1_storage_full1 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage1_storage1;
reg pair_fastchain0_iir0_csrstorage1_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_b01 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage2_storage_full1 = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage2_storage1;
reg pair_fastchain0_iir0_csrstorage2_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_b11 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage3_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage3_storage;
reg pair_fastchain0_iir0_csrstorage3_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir0_b2 = 25'sd0;
reg [24:0] pair_fastchain0_iir0_csrstorage4_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir0_csrstorage4_storage;
reg pair_fastchain0_iir0_csrstorage4_re = 1'd0;
reg signed [49:0] pair_fastchain0_iir0_z0r1 = 50'sd0;
reg signed [24:0] pair_fastchain0_iir0_y_lim1;
wire signed [49:0] pair_fastchain0_iir0_y_next1;
reg [2:0] pair_fastchain0_iir0_y_pat1 = 3'd7;
reg signed [24:0] pair_fastchain0_iir0_y3 = 25'sd0;
wire pair_fastchain0_iir0_railed1;
reg signed [49:0] pair_fastchain0_iir0_zr5 = 50'sd0;
wire signed [47:0] pair_fastchain0_iir0_zr_low2;
wire [47:0] pair_fastchain0_iir0_zr_cascade2;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q2;
wire pair_fastchain0_iir0_zr6;
wire pair_fastchain0_iir0_zr7;
wire signed [3:0] pair_fastchain0_iir0_zr_correction2;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q2 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q2 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top2;
wire signed [49:0] pair_fastchain0_iir0_zr_result2;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo2;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop2;
wire signed [47:0] pair_fastchain0_iir0_zr_low3;
wire [47:0] pair_fastchain0_iir0_zr_cascade3;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q3;
wire pair_fastchain0_iir0_zr8;
wire pair_fastchain0_iir0_zr9;
wire signed [3:0] pair_fastchain0_iir0_zr_correction3;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q3 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q3 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top3;
wire signed [49:0] pair_fastchain0_iir0_zr_result3;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo3;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop3;
wire signed [47:0] pair_fastchain0_iir0_zr_low4;
wire [47:0] pair_fastchain0_iir0_zr_cascade4;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q4;
wire pair_fastchain0_iir0_zr10;
wire pair_fastchain0_iir0_zr11;
wire signed [3:0] pair_fastchain0_iir0_zr_correction4;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q4 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q4 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top4;
wire signed [49:0] pair_fastchain0_iir0_zr_result4;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo4;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop4;
wire signed [47:0] pair_fastchain0_iir0_zr_low5;
wire [47:0] pair_fastchain0_iir0_zr_cascade5;
wire signed [47:0] pair_fastchain0_iir0_zr_high_q5;
wire pair_fastchain0_iir0_zr12;
wire pair_fastchain0_iir0_zr13;
wire signed [3:0] pair_fastchain0_iir0_zr_correction5;
reg signed [3:0] pair_fastchain0_iir0_zr_correction_q5 = 4'sd0;
reg [16:0] pair_fastchain0_iir0_zr_low_q5 = 17'd0;
wire [1:0] pair_fastchain0_iir0_zr_top5;
wire signed [49:0] pair_fastchain0_iir0_zr_result5;
wire signed [47:0] pair_fastchain0_iir0_zr_zlo5;
wire signed [1:0] pair_fastchain0_iir0_zr_ztop5;
wire signed [17:0] pair_fastchain0_iir0_z_xlo1;
wire signed [7:0] pair_fastchain0_iir0_z_xhi1;
wire signed [47:0] pair_fastchain0_iir0_z_zlo1;
wire signed [1:0] pair_fastchain0_iir0_z_ztop1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir0_z_low1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir0_z_high1;
wire pair_fastchain0_iir0_z_carry1;
wire signed [3:0] pair_fastchain0_iir0_z_correction1;
wire [1:0] pair_fastchain0_iir0_z_top1;
wire signed [49:0] pair_fastchain0_iir0_z_result1;
reg signed [24:0] pair_fastchain0_paralleltaplimitcsr0_y = 25'sd0;
reg pair_fastchain0_paralleltaplimitcsr0_error = 1'd0;
wire pair_fastchain0_paralleltaplimitcsr0_update_en;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr00;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr01;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr02;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_common_a;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_common_b;
wire [1:0] pair_fastchain0_paralleltaplimitcsr03;
wire pair_fastchain0_paralleltaplimitcsr04;
reg [24:0] pair_fastchain0_paralleltaplimitcsr0_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain0_paralleltaplimitcsr0_min_storage;
reg pair_fastchain0_paralleltaplimitcsr0_min_re = 1'd0;
reg [24:0] pair_fastchain0_paralleltaplimitcsr0_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain0_paralleltaplimitcsr0_max_storage;
reg pair_fastchain0_paralleltaplimitcsr0_max_re = 1'd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_bound_min = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_bound_max = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_neg_bound_min = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_neg_bound_max = 28'sd0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_common_sum;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_total0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit0_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit0_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit0_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit0_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_limit0_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_neg_value0;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_total1;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit1_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit1_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit1_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit1_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_limit1_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_neg_value1;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_total2;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit2_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit2_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit2_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_limit2_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_limit2_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr0_neg_value2;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr0_pre_y;
wire pair_fastchain0_paralleltaplimitcsr0_pre_rail;
reg signed [24:0] pair_fastchain0_limitcsr1_limitcsr1_y = 25'sd0;
reg pair_fastchain0_limitcsr1_limitcsr1_error = 1'd0;
reg pair_fastchain0_limitcsr1_update_en = 1'd1;
wire signed [25:0] pair_fastchain0_limitcsr1_x;
reg [24:0] pair_fastchain0_limitcsr1_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain0_limitcsr1_min_storage;
reg pair_fastchain0_limitcsr1_min_re = 1'd0;
reg [24:0] pair_fastchain0_limitcsr1_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain0_limitcsr1_max_storage;
reg pair_fastchain0_limitcsr1_max_re = 1'd0;
wire signed [25:0] pair_fastchain0_limitcsr1_limit_x;
reg signed [25:0] pair_fastchain0_limitcsr1_limit_y;
reg signed [25:0] pair_fastchain0_limitcsr1_limit_max = 26'sd0;
reg signed [25:0] pair_fastchain0_limitcsr1_limit_min = 26'sd0;
reg pair_fastchain0_limitcsr1_limit_railed;
wire signed [24:0] pair_fastchain0_iir1_x0;
reg signed [24:0] pair_fastchain0_iir1_y0 = 25'sd0;
wire pair_fastchain0_iir1_hold0;
wire pair_fastchain0_iir1_clear0;
reg pair_fastchain0_iir1_error0 = 1'd0;
reg [26:0] pair_fastchain0_iir1_storage_full0 = 27'd0;
wire [26:0] pair_fastchain0_iir1_storage0;
reg pair_fastchain0_iir1_re0 = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_a10 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage3_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage3_storage;
reg pair_fastchain0_iir1_csrstorage3_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_b00 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage4_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage4_storage;
reg pair_fastchain0_iir1_csrstorage4_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_b10 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage5_storage_full0 = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage5_storage0;
reg pair_fastchain0_iir1_csrstorage5_re0 = 1'd0;
reg signed [49:0] pair_fastchain0_iir1_z0r0 = 50'sd0;
reg signed [24:0] pair_fastchain0_iir1_y_lim0;
wire signed [49:0] pair_fastchain0_iir1_y_next0;
reg [2:0] pair_fastchain0_iir1_y_pat0 = 3'd7;
reg signed [24:0] pair_fastchain0_iir1_y1 = 25'sd0;
wire pair_fastchain0_iir1_railed0;
reg signed [49:0] pair_fastchain0_iir1_zr0 = 50'sd0;
wire signed [47:0] pair_fastchain0_iir1_zr_low0;
wire [47:0] pair_fastchain0_iir1_zr_cascade0;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q0;
wire pair_fastchain0_iir1_zr1;
wire pair_fastchain0_iir1_zr2;
wire signed [3:0] pair_fastchain0_iir1_zr_correction0;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q0 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q0 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top0;
wire signed [49:0] pair_fastchain0_iir1_zr_result0;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo0;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop0;
wire signed [47:0] pair_fastchain0_iir1_zr_low1;
wire [47:0] pair_fastchain0_iir1_zr_cascade1;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q1;
wire pair_fastchain0_iir1_zr3;
wire pair_fastchain0_iir1_zr4;
wire signed [3:0] pair_fastchain0_iir1_zr_correction1;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q1 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q1 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top1;
wire signed [49:0] pair_fastchain0_iir1_zr_result1;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo1;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop1;
wire signed [17:0] pair_fastchain0_iir1_z_xlo0;
wire signed [7:0] pair_fastchain0_iir1_z_xhi0;
wire signed [47:0] pair_fastchain0_iir1_z_zlo0;
wire signed [1:0] pair_fastchain0_iir1_z_ztop0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir1_z_low0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir1_z_high0;
wire pair_fastchain0_iir1_z_carry0;
wire signed [3:0] pair_fastchain0_iir1_z_correction0;
wire [1:0] pair_fastchain0_iir1_z_top0;
wire signed [49:0] pair_fastchain0_iir1_z_result0;
wire signed [24:0] pair_fastchain0_iir1_x1;
reg signed [24:0] pair_fastchain0_iir1_y2 = 25'sd0;
wire pair_fastchain0_iir1_hold1;
wire pair_fastchain0_iir1_clear1;
reg pair_fastchain0_iir1_error1 = 1'd0;
reg [26:0] pair_fastchain0_iir1_storage_full1 = 27'd0;
wire [26:0] pair_fastchain0_iir1_storage1;
reg pair_fastchain0_iir1_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_a11 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage5_storage_full1 = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage5_storage1;
reg pair_fastchain0_iir1_csrstorage5_re1 = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_a2 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage6_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage6_storage;
reg pair_fastchain0_iir1_csrstorage6_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_b01 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage7_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage7_storage;
reg pair_fastchain0_iir1_csrstorage7_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_b11 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage8_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage8_storage;
reg pair_fastchain0_iir1_csrstorage8_re = 1'd0;
reg signed [24:0] pair_fastchain0_iir1_b2 = 25'sd0;
reg [24:0] pair_fastchain0_iir1_csrstorage9_storage_full = 25'd0;
wire [24:0] pair_fastchain0_iir1_csrstorage9_storage;
reg pair_fastchain0_iir1_csrstorage9_re = 1'd0;
reg signed [49:0] pair_fastchain0_iir1_z0r1 = 50'sd0;
reg signed [24:0] pair_fastchain0_iir1_y_lim1;
wire signed [49:0] pair_fastchain0_iir1_y_next1;
reg [2:0] pair_fastchain0_iir1_y_pat1 = 3'd7;
reg signed [24:0] pair_fastchain0_iir1_y3 = 25'sd0;
wire pair_fastchain0_iir1_railed1;
reg signed [49:0] pair_fastchain0_iir1_zr5 = 50'sd0;
wire signed [47:0] pair_fastchain0_iir1_zr_low2;
wire [47:0] pair_fastchain0_iir1_zr_cascade2;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q2;
wire pair_fastchain0_iir1_zr6;
wire pair_fastchain0_iir1_zr7;
wire signed [3:0] pair_fastchain0_iir1_zr_correction2;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q2 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q2 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top2;
wire signed [49:0] pair_fastchain0_iir1_zr_result2;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo2;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop2;
wire signed [47:0] pair_fastchain0_iir1_zr_low3;
wire [47:0] pair_fastchain0_iir1_zr_cascade3;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q3;
wire pair_fastchain0_iir1_zr8;
wire pair_fastchain0_iir1_zr9;
wire signed [3:0] pair_fastchain0_iir1_zr_correction3;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q3 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q3 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top3;
wire signed [49:0] pair_fastchain0_iir1_zr_result3;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo3;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop3;
wire signed [47:0] pair_fastchain0_iir1_zr_low4;
wire [47:0] pair_fastchain0_iir1_zr_cascade4;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q4;
wire pair_fastchain0_iir1_zr10;
wire pair_fastchain0_iir1_zr11;
wire signed [3:0] pair_fastchain0_iir1_zr_correction4;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q4 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q4 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top4;
wire signed [49:0] pair_fastchain0_iir1_zr_result4;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo4;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop4;
wire signed [47:0] pair_fastchain0_iir1_zr_low5;
wire [47:0] pair_fastchain0_iir1_zr_cascade5;
wire signed [47:0] pair_fastchain0_iir1_zr_high_q5;
wire pair_fastchain0_iir1_zr12;
wire pair_fastchain0_iir1_zr13;
wire signed [3:0] pair_fastchain0_iir1_zr_correction5;
reg signed [3:0] pair_fastchain0_iir1_zr_correction_q5 = 4'sd0;
reg [16:0] pair_fastchain0_iir1_zr_low_q5 = 17'd0;
wire [1:0] pair_fastchain0_iir1_zr_top5;
wire signed [49:0] pair_fastchain0_iir1_zr_result5;
wire signed [47:0] pair_fastchain0_iir1_zr_zlo5;
wire signed [1:0] pair_fastchain0_iir1_zr_ztop5;
wire signed [17:0] pair_fastchain0_iir1_z_xlo1;
wire signed [7:0] pair_fastchain0_iir1_z_xhi1;
wire signed [47:0] pair_fastchain0_iir1_z_zlo1;
wire signed [1:0] pair_fastchain0_iir1_z_ztop1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir1_z_low1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain0_iir1_z_high1;
wire pair_fastchain0_iir1_z_carry1;
wire signed [3:0] pair_fastchain0_iir1_z_correction1;
wire [1:0] pair_fastchain0_iir1_z_top1;
wire signed [49:0] pair_fastchain0_iir1_z_result1;
reg signed [24:0] pair_fastchain0_paralleltaplimitcsr1_y = 25'sd0;
reg pair_fastchain0_paralleltaplimitcsr1_error = 1'd0;
wire pair_fastchain0_paralleltaplimitcsr1_update_en;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr10;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr11;
wire signed [24:0] pair_fastchain0_paralleltaplimitcsr12;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_common_a;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_common_b;
wire [1:0] pair_fastchain0_paralleltaplimitcsr13;
wire pair_fastchain0_paralleltaplimitcsr14;
reg [24:0] pair_fastchain0_paralleltaplimitcsr1_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain0_paralleltaplimitcsr1_min_storage;
reg pair_fastchain0_paralleltaplimitcsr1_min_re = 1'd0;
reg [24:0] pair_fastchain0_paralleltaplimitcsr1_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain0_paralleltaplimitcsr1_max_storage;
reg pair_fastchain0_paralleltaplimitcsr1_max_re = 1'd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_bound_min = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_bound_max = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_neg_bound_min = 28'sd0;
reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_neg_bound_max = 28'sd0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_common_sum;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_total0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit3_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit3_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit3_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit3_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_limit3_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_neg_value0;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_total1;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit4_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit4_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit4_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit4_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_limit4_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_neg_value1;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_total2;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit5_x;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit5_y;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit5_max;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_limit5_min;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_limit5_railed;
(* keep = "true" *) reg signed [27:0] pair_fastchain0_paralleltaplimitcsr1_neg_value2;
(* keep = "true" *) reg pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2;
wire signed [27:0] pair_fastchain0_paralleltaplimitcsr1_pre_y;
wire pair_fastchain0_paralleltaplimitcsr1_pre_rail;
wire [13:0] pair_csrbank0_bus_adr;
wire pair_csrbank0_bus_we;
wire [7:0] pair_csrbank0_bus_dat_w;
reg [7:0] pair_csrbank0_bus_dat_r = 8'd0;
wire pair_csrbank0_y_tap0_re;
wire [1:0] pair_csrbank0_y_tap0_r;
wire [1:0] pair_csrbank0_y_tap0_w;
wire pair_csrbank0_invert0_re;
wire pair_csrbank0_invert0_r;
wire pair_csrbank0_invert0_w;
wire pair_csrbank0_demod_delay3_re;
wire [7:0] pair_csrbank0_demod_delay3_r;
wire [7:0] pair_csrbank0_demod_delay3_w;
wire pair_csrbank0_demod_delay2_re;
wire [7:0] pair_csrbank0_demod_delay2_r;
wire [7:0] pair_csrbank0_demod_delay2_w;
wire pair_csrbank0_demod_delay1_re;
wire [7:0] pair_csrbank0_demod_delay1_r;
wire [7:0] pair_csrbank0_demod_delay1_w;
wire pair_csrbank0_demod_delay0_re;
wire [7:0] pair_csrbank0_demod_delay0_r;
wire [7:0] pair_csrbank0_demod_delay0_w;
wire pair_csrbank0_demod_multiplier0_re;
wire [3:0] pair_csrbank0_demod_multiplier0_r;
wire [3:0] pair_csrbank0_demod_multiplier0_w;
wire pair_csrbank0_x_limit_1_min3_re;
wire pair_csrbank0_x_limit_1_min3_r;
wire pair_csrbank0_x_limit_1_min3_w;
wire pair_csrbank0_x_limit_1_min2_re;
wire [7:0] pair_csrbank0_x_limit_1_min2_r;
wire [7:0] pair_csrbank0_x_limit_1_min2_w;
wire pair_csrbank0_x_limit_1_min1_re;
wire [7:0] pair_csrbank0_x_limit_1_min1_r;
wire [7:0] pair_csrbank0_x_limit_1_min1_w;
wire pair_csrbank0_x_limit_1_min0_re;
wire [7:0] pair_csrbank0_x_limit_1_min0_r;
wire [7:0] pair_csrbank0_x_limit_1_min0_w;
wire pair_csrbank0_x_limit_1_max3_re;
wire pair_csrbank0_x_limit_1_max3_r;
wire pair_csrbank0_x_limit_1_max3_w;
wire pair_csrbank0_x_limit_1_max2_re;
wire [7:0] pair_csrbank0_x_limit_1_max2_r;
wire [7:0] pair_csrbank0_x_limit_1_max2_w;
wire pair_csrbank0_x_limit_1_max1_re;
wire [7:0] pair_csrbank0_x_limit_1_max1_r;
wire [7:0] pair_csrbank0_x_limit_1_max1_w;
wire pair_csrbank0_x_limit_1_max0_re;
wire [7:0] pair_csrbank0_x_limit_1_max0_r;
wire [7:0] pair_csrbank0_x_limit_1_max0_w;
wire pair_csrbank0_iir_c_1_z03_re;
wire [2:0] pair_csrbank0_iir_c_1_z03_r;
wire [2:0] pair_csrbank0_iir_c_1_z03_w;
wire pair_csrbank0_iir_c_1_z02_re;
wire [7:0] pair_csrbank0_iir_c_1_z02_r;
wire [7:0] pair_csrbank0_iir_c_1_z02_w;
wire pair_csrbank0_iir_c_1_z01_re;
wire [7:0] pair_csrbank0_iir_c_1_z01_r;
wire [7:0] pair_csrbank0_iir_c_1_z01_w;
wire pair_csrbank0_iir_c_1_z00_re;
wire [7:0] pair_csrbank0_iir_c_1_z00_r;
wire [7:0] pair_csrbank0_iir_c_1_z00_w;
wire pair_csrbank0_iir_c_1_a13_re;
wire pair_csrbank0_iir_c_1_a13_r;
wire pair_csrbank0_iir_c_1_a13_w;
wire pair_csrbank0_iir_c_1_a12_re;
wire [7:0] pair_csrbank0_iir_c_1_a12_r;
wire [7:0] pair_csrbank0_iir_c_1_a12_w;
wire pair_csrbank0_iir_c_1_a11_re;
wire [7:0] pair_csrbank0_iir_c_1_a11_r;
wire [7:0] pair_csrbank0_iir_c_1_a11_w;
wire pair_csrbank0_iir_c_1_a10_re;
wire [7:0] pair_csrbank0_iir_c_1_a10_r;
wire [7:0] pair_csrbank0_iir_c_1_a10_w;
wire pair_csrbank0_iir_c_1_b03_re;
wire pair_csrbank0_iir_c_1_b03_r;
wire pair_csrbank0_iir_c_1_b03_w;
wire pair_csrbank0_iir_c_1_b02_re;
wire [7:0] pair_csrbank0_iir_c_1_b02_r;
wire [7:0] pair_csrbank0_iir_c_1_b02_w;
wire pair_csrbank0_iir_c_1_b01_re;
wire [7:0] pair_csrbank0_iir_c_1_b01_r;
wire [7:0] pair_csrbank0_iir_c_1_b01_w;
wire pair_csrbank0_iir_c_1_b00_re;
wire [7:0] pair_csrbank0_iir_c_1_b00_r;
wire [7:0] pair_csrbank0_iir_c_1_b00_w;
wire pair_csrbank0_iir_c_1_b13_re;
wire pair_csrbank0_iir_c_1_b13_r;
wire pair_csrbank0_iir_c_1_b13_w;
wire pair_csrbank0_iir_c_1_b12_re;
wire [7:0] pair_csrbank0_iir_c_1_b12_r;
wire [7:0] pair_csrbank0_iir_c_1_b12_w;
wire pair_csrbank0_iir_c_1_b11_re;
wire [7:0] pair_csrbank0_iir_c_1_b11_r;
wire [7:0] pair_csrbank0_iir_c_1_b11_w;
wire pair_csrbank0_iir_c_1_b10_re;
wire [7:0] pair_csrbank0_iir_c_1_b10_r;
wire [7:0] pair_csrbank0_iir_c_1_b10_w;
wire pair_csrbank0_iir_d_1_z03_re;
wire [2:0] pair_csrbank0_iir_d_1_z03_r;
wire [2:0] pair_csrbank0_iir_d_1_z03_w;
wire pair_csrbank0_iir_d_1_z02_re;
wire [7:0] pair_csrbank0_iir_d_1_z02_r;
wire [7:0] pair_csrbank0_iir_d_1_z02_w;
wire pair_csrbank0_iir_d_1_z01_re;
wire [7:0] pair_csrbank0_iir_d_1_z01_r;
wire [7:0] pair_csrbank0_iir_d_1_z01_w;
wire pair_csrbank0_iir_d_1_z00_re;
wire [7:0] pair_csrbank0_iir_d_1_z00_r;
wire [7:0] pair_csrbank0_iir_d_1_z00_w;
wire pair_csrbank0_iir_d_1_a13_re;
wire pair_csrbank0_iir_d_1_a13_r;
wire pair_csrbank0_iir_d_1_a13_w;
wire pair_csrbank0_iir_d_1_a12_re;
wire [7:0] pair_csrbank0_iir_d_1_a12_r;
wire [7:0] pair_csrbank0_iir_d_1_a12_w;
wire pair_csrbank0_iir_d_1_a11_re;
wire [7:0] pair_csrbank0_iir_d_1_a11_r;
wire [7:0] pair_csrbank0_iir_d_1_a11_w;
wire pair_csrbank0_iir_d_1_a10_re;
wire [7:0] pair_csrbank0_iir_d_1_a10_r;
wire [7:0] pair_csrbank0_iir_d_1_a10_w;
wire pair_csrbank0_iir_d_1_a23_re;
wire pair_csrbank0_iir_d_1_a23_r;
wire pair_csrbank0_iir_d_1_a23_w;
wire pair_csrbank0_iir_d_1_a22_re;
wire [7:0] pair_csrbank0_iir_d_1_a22_r;
wire [7:0] pair_csrbank0_iir_d_1_a22_w;
wire pair_csrbank0_iir_d_1_a21_re;
wire [7:0] pair_csrbank0_iir_d_1_a21_r;
wire [7:0] pair_csrbank0_iir_d_1_a21_w;
wire pair_csrbank0_iir_d_1_a20_re;
wire [7:0] pair_csrbank0_iir_d_1_a20_r;
wire [7:0] pair_csrbank0_iir_d_1_a20_w;
wire pair_csrbank0_iir_d_1_b03_re;
wire pair_csrbank0_iir_d_1_b03_r;
wire pair_csrbank0_iir_d_1_b03_w;
wire pair_csrbank0_iir_d_1_b02_re;
wire [7:0] pair_csrbank0_iir_d_1_b02_r;
wire [7:0] pair_csrbank0_iir_d_1_b02_w;
wire pair_csrbank0_iir_d_1_b01_re;
wire [7:0] pair_csrbank0_iir_d_1_b01_r;
wire [7:0] pair_csrbank0_iir_d_1_b01_w;
wire pair_csrbank0_iir_d_1_b00_re;
wire [7:0] pair_csrbank0_iir_d_1_b00_r;
wire [7:0] pair_csrbank0_iir_d_1_b00_w;
wire pair_csrbank0_iir_d_1_b13_re;
wire pair_csrbank0_iir_d_1_b13_r;
wire pair_csrbank0_iir_d_1_b13_w;
wire pair_csrbank0_iir_d_1_b12_re;
wire [7:0] pair_csrbank0_iir_d_1_b12_r;
wire [7:0] pair_csrbank0_iir_d_1_b12_w;
wire pair_csrbank0_iir_d_1_b11_re;
wire [7:0] pair_csrbank0_iir_d_1_b11_r;
wire [7:0] pair_csrbank0_iir_d_1_b11_w;
wire pair_csrbank0_iir_d_1_b10_re;
wire [7:0] pair_csrbank0_iir_d_1_b10_r;
wire [7:0] pair_csrbank0_iir_d_1_b10_w;
wire pair_csrbank0_iir_d_1_b23_re;
wire pair_csrbank0_iir_d_1_b23_r;
wire pair_csrbank0_iir_d_1_b23_w;
wire pair_csrbank0_iir_d_1_b22_re;
wire [7:0] pair_csrbank0_iir_d_1_b22_r;
wire [7:0] pair_csrbank0_iir_d_1_b22_w;
wire pair_csrbank0_iir_d_1_b21_re;
wire [7:0] pair_csrbank0_iir_d_1_b21_r;
wire [7:0] pair_csrbank0_iir_d_1_b21_w;
wire pair_csrbank0_iir_d_1_b20_re;
wire [7:0] pair_csrbank0_iir_d_1_b20_r;
wire [7:0] pair_csrbank0_iir_d_1_b20_w;
wire pair_csrbank0_y_limit_1_min3_re;
wire pair_csrbank0_y_limit_1_min3_r;
wire pair_csrbank0_y_limit_1_min3_w;
wire pair_csrbank0_y_limit_1_min2_re;
wire [7:0] pair_csrbank0_y_limit_1_min2_r;
wire [7:0] pair_csrbank0_y_limit_1_min2_w;
wire pair_csrbank0_y_limit_1_min1_re;
wire [7:0] pair_csrbank0_y_limit_1_min1_r;
wire [7:0] pair_csrbank0_y_limit_1_min1_w;
wire pair_csrbank0_y_limit_1_min0_re;
wire [7:0] pair_csrbank0_y_limit_1_min0_r;
wire [7:0] pair_csrbank0_y_limit_1_min0_w;
wire pair_csrbank0_y_limit_1_max3_re;
wire pair_csrbank0_y_limit_1_max3_r;
wire pair_csrbank0_y_limit_1_max3_w;
wire pair_csrbank0_y_limit_1_max2_re;
wire [7:0] pair_csrbank0_y_limit_1_max2_r;
wire [7:0] pair_csrbank0_y_limit_1_max2_w;
wire pair_csrbank0_y_limit_1_max1_re;
wire [7:0] pair_csrbank0_y_limit_1_max1_r;
wire [7:0] pair_csrbank0_y_limit_1_max1_w;
wire pair_csrbank0_y_limit_1_max0_re;
wire [7:0] pair_csrbank0_y_limit_1_max0_r;
wire [7:0] pair_csrbank0_y_limit_1_max0_w;
wire pair_csrbank0_x_limit_2_min3_re;
wire pair_csrbank0_x_limit_2_min3_r;
wire pair_csrbank0_x_limit_2_min3_w;
wire pair_csrbank0_x_limit_2_min2_re;
wire [7:0] pair_csrbank0_x_limit_2_min2_r;
wire [7:0] pair_csrbank0_x_limit_2_min2_w;
wire pair_csrbank0_x_limit_2_min1_re;
wire [7:0] pair_csrbank0_x_limit_2_min1_r;
wire [7:0] pair_csrbank0_x_limit_2_min1_w;
wire pair_csrbank0_x_limit_2_min0_re;
wire [7:0] pair_csrbank0_x_limit_2_min0_r;
wire [7:0] pair_csrbank0_x_limit_2_min0_w;
wire pair_csrbank0_x_limit_2_max3_re;
wire pair_csrbank0_x_limit_2_max3_r;
wire pair_csrbank0_x_limit_2_max3_w;
wire pair_csrbank0_x_limit_2_max2_re;
wire [7:0] pair_csrbank0_x_limit_2_max2_r;
wire [7:0] pair_csrbank0_x_limit_2_max2_w;
wire pair_csrbank0_x_limit_2_max1_re;
wire [7:0] pair_csrbank0_x_limit_2_max1_r;
wire [7:0] pair_csrbank0_x_limit_2_max1_w;
wire pair_csrbank0_x_limit_2_max0_re;
wire [7:0] pair_csrbank0_x_limit_2_max0_r;
wire [7:0] pair_csrbank0_x_limit_2_max0_w;
wire pair_csrbank0_iir_c_2_z03_re;
wire [2:0] pair_csrbank0_iir_c_2_z03_r;
wire [2:0] pair_csrbank0_iir_c_2_z03_w;
wire pair_csrbank0_iir_c_2_z02_re;
wire [7:0] pair_csrbank0_iir_c_2_z02_r;
wire [7:0] pair_csrbank0_iir_c_2_z02_w;
wire pair_csrbank0_iir_c_2_z01_re;
wire [7:0] pair_csrbank0_iir_c_2_z01_r;
wire [7:0] pair_csrbank0_iir_c_2_z01_w;
wire pair_csrbank0_iir_c_2_z00_re;
wire [7:0] pair_csrbank0_iir_c_2_z00_r;
wire [7:0] pair_csrbank0_iir_c_2_z00_w;
wire pair_csrbank0_iir_c_2_a13_re;
wire pair_csrbank0_iir_c_2_a13_r;
wire pair_csrbank0_iir_c_2_a13_w;
wire pair_csrbank0_iir_c_2_a12_re;
wire [7:0] pair_csrbank0_iir_c_2_a12_r;
wire [7:0] pair_csrbank0_iir_c_2_a12_w;
wire pair_csrbank0_iir_c_2_a11_re;
wire [7:0] pair_csrbank0_iir_c_2_a11_r;
wire [7:0] pair_csrbank0_iir_c_2_a11_w;
wire pair_csrbank0_iir_c_2_a10_re;
wire [7:0] pair_csrbank0_iir_c_2_a10_r;
wire [7:0] pair_csrbank0_iir_c_2_a10_w;
wire pair_csrbank0_iir_c_2_b03_re;
wire pair_csrbank0_iir_c_2_b03_r;
wire pair_csrbank0_iir_c_2_b03_w;
wire pair_csrbank0_iir_c_2_b02_re;
wire [7:0] pair_csrbank0_iir_c_2_b02_r;
wire [7:0] pair_csrbank0_iir_c_2_b02_w;
wire pair_csrbank0_iir_c_2_b01_re;
wire [7:0] pair_csrbank0_iir_c_2_b01_r;
wire [7:0] pair_csrbank0_iir_c_2_b01_w;
wire pair_csrbank0_iir_c_2_b00_re;
wire [7:0] pair_csrbank0_iir_c_2_b00_r;
wire [7:0] pair_csrbank0_iir_c_2_b00_w;
wire pair_csrbank0_iir_c_2_b13_re;
wire pair_csrbank0_iir_c_2_b13_r;
wire pair_csrbank0_iir_c_2_b13_w;
wire pair_csrbank0_iir_c_2_b12_re;
wire [7:0] pair_csrbank0_iir_c_2_b12_r;
wire [7:0] pair_csrbank0_iir_c_2_b12_w;
wire pair_csrbank0_iir_c_2_b11_re;
wire [7:0] pair_csrbank0_iir_c_2_b11_r;
wire [7:0] pair_csrbank0_iir_c_2_b11_w;
wire pair_csrbank0_iir_c_2_b10_re;
wire [7:0] pair_csrbank0_iir_c_2_b10_r;
wire [7:0] pair_csrbank0_iir_c_2_b10_w;
wire pair_csrbank0_iir_d_2_z03_re;
wire [2:0] pair_csrbank0_iir_d_2_z03_r;
wire [2:0] pair_csrbank0_iir_d_2_z03_w;
wire pair_csrbank0_iir_d_2_z02_re;
wire [7:0] pair_csrbank0_iir_d_2_z02_r;
wire [7:0] pair_csrbank0_iir_d_2_z02_w;
wire pair_csrbank0_iir_d_2_z01_re;
wire [7:0] pair_csrbank0_iir_d_2_z01_r;
wire [7:0] pair_csrbank0_iir_d_2_z01_w;
wire pair_csrbank0_iir_d_2_z00_re;
wire [7:0] pair_csrbank0_iir_d_2_z00_r;
wire [7:0] pair_csrbank0_iir_d_2_z00_w;
wire pair_csrbank0_iir_d_2_a13_re;
wire pair_csrbank0_iir_d_2_a13_r;
wire pair_csrbank0_iir_d_2_a13_w;
wire pair_csrbank0_iir_d_2_a12_re;
wire [7:0] pair_csrbank0_iir_d_2_a12_r;
wire [7:0] pair_csrbank0_iir_d_2_a12_w;
wire pair_csrbank0_iir_d_2_a11_re;
wire [7:0] pair_csrbank0_iir_d_2_a11_r;
wire [7:0] pair_csrbank0_iir_d_2_a11_w;
wire pair_csrbank0_iir_d_2_a10_re;
wire [7:0] pair_csrbank0_iir_d_2_a10_r;
wire [7:0] pair_csrbank0_iir_d_2_a10_w;
wire pair_csrbank0_iir_d_2_a23_re;
wire pair_csrbank0_iir_d_2_a23_r;
wire pair_csrbank0_iir_d_2_a23_w;
wire pair_csrbank0_iir_d_2_a22_re;
wire [7:0] pair_csrbank0_iir_d_2_a22_r;
wire [7:0] pair_csrbank0_iir_d_2_a22_w;
wire pair_csrbank0_iir_d_2_a21_re;
wire [7:0] pair_csrbank0_iir_d_2_a21_r;
wire [7:0] pair_csrbank0_iir_d_2_a21_w;
wire pair_csrbank0_iir_d_2_a20_re;
wire [7:0] pair_csrbank0_iir_d_2_a20_r;
wire [7:0] pair_csrbank0_iir_d_2_a20_w;
wire pair_csrbank0_iir_d_2_b03_re;
wire pair_csrbank0_iir_d_2_b03_r;
wire pair_csrbank0_iir_d_2_b03_w;
wire pair_csrbank0_iir_d_2_b02_re;
wire [7:0] pair_csrbank0_iir_d_2_b02_r;
wire [7:0] pair_csrbank0_iir_d_2_b02_w;
wire pair_csrbank0_iir_d_2_b01_re;
wire [7:0] pair_csrbank0_iir_d_2_b01_r;
wire [7:0] pair_csrbank0_iir_d_2_b01_w;
wire pair_csrbank0_iir_d_2_b00_re;
wire [7:0] pair_csrbank0_iir_d_2_b00_r;
wire [7:0] pair_csrbank0_iir_d_2_b00_w;
wire pair_csrbank0_iir_d_2_b13_re;
wire pair_csrbank0_iir_d_2_b13_r;
wire pair_csrbank0_iir_d_2_b13_w;
wire pair_csrbank0_iir_d_2_b12_re;
wire [7:0] pair_csrbank0_iir_d_2_b12_r;
wire [7:0] pair_csrbank0_iir_d_2_b12_w;
wire pair_csrbank0_iir_d_2_b11_re;
wire [7:0] pair_csrbank0_iir_d_2_b11_r;
wire [7:0] pair_csrbank0_iir_d_2_b11_w;
wire pair_csrbank0_iir_d_2_b10_re;
wire [7:0] pair_csrbank0_iir_d_2_b10_r;
wire [7:0] pair_csrbank0_iir_d_2_b10_w;
wire pair_csrbank0_iir_d_2_b23_re;
wire pair_csrbank0_iir_d_2_b23_r;
wire pair_csrbank0_iir_d_2_b23_w;
wire pair_csrbank0_iir_d_2_b22_re;
wire [7:0] pair_csrbank0_iir_d_2_b22_r;
wire [7:0] pair_csrbank0_iir_d_2_b22_w;
wire pair_csrbank0_iir_d_2_b21_re;
wire [7:0] pair_csrbank0_iir_d_2_b21_r;
wire [7:0] pair_csrbank0_iir_d_2_b21_w;
wire pair_csrbank0_iir_d_2_b20_re;
wire [7:0] pair_csrbank0_iir_d_2_b20_r;
wire [7:0] pair_csrbank0_iir_d_2_b20_w;
wire pair_csrbank0_y_limit_2_min3_re;
wire pair_csrbank0_y_limit_2_min3_r;
wire pair_csrbank0_y_limit_2_min3_w;
wire pair_csrbank0_y_limit_2_min2_re;
wire [7:0] pair_csrbank0_y_limit_2_min2_r;
wire [7:0] pair_csrbank0_y_limit_2_min2_w;
wire pair_csrbank0_y_limit_2_min1_re;
wire [7:0] pair_csrbank0_y_limit_2_min1_r;
wire [7:0] pair_csrbank0_y_limit_2_min1_w;
wire pair_csrbank0_y_limit_2_min0_re;
wire [7:0] pair_csrbank0_y_limit_2_min0_r;
wire [7:0] pair_csrbank0_y_limit_2_min0_w;
wire pair_csrbank0_y_limit_2_max3_re;
wire pair_csrbank0_y_limit_2_max3_r;
wire pair_csrbank0_y_limit_2_max3_w;
wire pair_csrbank0_y_limit_2_max2_re;
wire [7:0] pair_csrbank0_y_limit_2_max2_r;
wire [7:0] pair_csrbank0_y_limit_2_max2_w;
wire pair_csrbank0_y_limit_2_max1_re;
wire [7:0] pair_csrbank0_y_limit_2_max1_r;
wire [7:0] pair_csrbank0_y_limit_2_max1_w;
wire pair_csrbank0_y_limit_2_max0_re;
wire [7:0] pair_csrbank0_y_limit_2_max0_r;
wire [7:0] pair_csrbank0_y_limit_2_max0_w;
wire pair_csrbank0_sel;
wire signed [13:0] pair_fastchain1_adc;
wire signed [24:0] pair_fastchain1_out_i;
wire signed [24:0] pair_fastchain1_pre_out_i;
wire pair_fastchain1_out_i_update_en;
wire signed [24:0] pair_fastchain1_out_q;
reg [1:0] pair_fastchain1_y_tap_storage_full = 2'd0;
wire [1:0] pair_fastchain1_y_tap_storage;
reg pair_fastchain1_y_tap_re = 1'd0;
reg pair_fastchain1_invert_storage_full = 1'd0;
wire pair_fastchain1_invert_storage;
reg pair_fastchain1_invert_re = 1'd0;
wire signed [24:0] pair_fastchain1_x0;
wire signed [24:0] pair_fastchain1_dx;
wire signed [24:0] pair_fastchain1_dy;
wire signed [13:0] pair_fastchain1_x1;
wire signed [13:0] pair_fastchain1_i;
wire signed [13:0] pair_fastchain1_q0;
reg [31:0] pair_fastchain1_delay_storage_full = 32'd0;
wire [31:0] pair_fastchain1_delay_storage;
reg pair_fastchain1_delay_re = 1'd0;
reg [3:0] pair_fastchain1_multiplier_storage_full = 4'd1;
wire [3:0] pair_fastchain1_multiplier_storage;
reg pair_fastchain1_multiplier_re = 1'd0;
wire [13:0] pair_fastchain1_phase;
wire signed [14:0] pair_fastchain1_phase_value;
reg signed [14:0] pair_fastchain1_speculativedemodcordic1_xi;
reg signed [14:0] pair_fastchain1_speculativedemodcordic1_yi;
reg signed [14:0] pair_fastchain1_speculativedemodcordic1_zi;
wire signed [14:0] pair_fastchain1_speculativedemodcordic1_xo;
wire signed [14:0] pair_fastchain1_speculativedemodcordic1_yo;
wire signed [14:0] pair_fastchain1_speculativedemodcordic1_zo;
wire pair_fastchain1_speculativedemodcordic1_new_in;
wire pair_fastchain1_speculativedemodcordic1_new_out;
wire signed [16:0] pair_fastchain1_speculativedemodcordic10;
reg signed [16:0] pair_fastchain1_speculativedemodcordic11 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic12 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic13 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic14 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic15 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic16 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic17 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic18 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic19 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic110 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic111 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic112 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic113 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic114 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic115 = 17'sd0;
wire signed [16:0] pair_fastchain1_speculativedemodcordic116;
reg signed [16:0] pair_fastchain1_speculativedemodcordic117 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic118 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic119 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic120 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic121 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic122 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic123 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic124 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic125 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic126 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic127 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic128 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic129 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic130 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic131 = 17'sd0;
wire signed [16:0] pair_fastchain1_speculativedemodcordic132;
reg signed [16:0] pair_fastchain1_speculativedemodcordic133 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic134 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic135 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic136 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic137 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic138 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic139 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic140 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic141 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic142 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic143 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic144 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic145 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic146 = 17'sd0;
reg signed [16:0] pair_fastchain1_speculativedemodcordic147 = 17'sd0;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir0;
wire signed [16:0] pair_fastchain1_speculativedemodcordic1_speculativedemodcordic10;
wire signed [16:0] pair_fastchain1_speculativedemodcordic1_speculativedemodcordic11;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir1;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir2;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir3;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir4;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir5;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir6;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir7;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir8;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir9;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir10;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir11;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir12;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir13;
wire pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir14;
wire signed [14:0] pair_fastchain1_xi;
wire signed [14:0] pair_fastchain1_yi;
wire signed [14:0] pair_fastchain1_zi;
wire pair_fastchain1_q1;
reg signed [16:0] pair_fastchain1_ya = 17'sd0;
reg signed [24:0] pair_fastchain1_limitcsr2_limitcsr2_y = 25'sd0;
reg pair_fastchain1_limitcsr2_limitcsr2_error = 1'd0;
reg pair_fastchain1_limitcsr2_update_en = 1'd1;
wire signed [25:0] pair_fastchain1_limitcsr2_x;
reg [24:0] pair_fastchain1_limitcsr2_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain1_limitcsr2_min_storage;
reg pair_fastchain1_limitcsr2_min_re = 1'd0;
reg [24:0] pair_fastchain1_limitcsr2_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain1_limitcsr2_max_storage;
reg pair_fastchain1_limitcsr2_max_re = 1'd0;
wire signed [25:0] pair_fastchain1_limitcsr2_limit_x;
reg signed [25:0] pair_fastchain1_limitcsr2_limit_y;
reg signed [25:0] pair_fastchain1_limitcsr2_limit_max = 26'sd0;
reg signed [25:0] pair_fastchain1_limitcsr2_limit_min = 26'sd0;
reg pair_fastchain1_limitcsr2_limit_railed;
wire signed [24:0] pair_fastchain1_iir2_x0;
reg signed [24:0] pair_fastchain1_iir2_y0 = 25'sd0;
wire pair_fastchain1_iir2_hold0;
wire pair_fastchain1_iir2_clear0;
reg pair_fastchain1_iir2_error0 = 1'd0;
reg [26:0] pair_fastchain1_iir2_storage_full0 = 27'd0;
wire [26:0] pair_fastchain1_iir2_storage0;
reg pair_fastchain1_iir2_re0 = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_a10 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage6_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage6_storage;
reg pair_fastchain1_iir2_csrstorage6_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_b00 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage7_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage7_storage;
reg pair_fastchain1_iir2_csrstorage7_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_b10 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage8_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage8_storage;
reg pair_fastchain1_iir2_csrstorage8_re = 1'd0;
reg signed [49:0] pair_fastchain1_iir2_z0r0 = 50'sd0;
reg signed [24:0] pair_fastchain1_iir2_y_lim0;
wire signed [49:0] pair_fastchain1_iir2_y_next0;
reg [2:0] pair_fastchain1_iir2_y_pat0 = 3'd7;
reg signed [24:0] pair_fastchain1_iir2_y1 = 25'sd0;
wire pair_fastchain1_iir2_railed0;
reg signed [49:0] pair_fastchain1_iir2_zr0 = 50'sd0;
wire signed [47:0] pair_fastchain1_iir2_zr_low0;
wire [47:0] pair_fastchain1_iir2_zr_cascade0;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q0;
wire pair_fastchain1_iir2_zr1;
wire pair_fastchain1_iir2_zr2;
wire signed [3:0] pair_fastchain1_iir2_zr_correction0;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q0 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q0 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top0;
wire signed [49:0] pair_fastchain1_iir2_zr_result0;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo0;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop0;
wire signed [47:0] pair_fastchain1_iir2_zr_low1;
wire [47:0] pair_fastchain1_iir2_zr_cascade1;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q1;
wire pair_fastchain1_iir2_zr3;
wire pair_fastchain1_iir2_zr4;
wire signed [3:0] pair_fastchain1_iir2_zr_correction1;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q1 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q1 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top1;
wire signed [49:0] pair_fastchain1_iir2_zr_result1;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo1;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop1;
wire signed [17:0] pair_fastchain1_iir2_z_xlo0;
wire signed [7:0] pair_fastchain1_iir2_z_xhi0;
wire signed [47:0] pair_fastchain1_iir2_z_zlo0;
wire signed [1:0] pair_fastchain1_iir2_z_ztop0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir2_z_low0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir2_z_high0;
wire pair_fastchain1_iir2_z_carry0;
wire signed [3:0] pair_fastchain1_iir2_z_correction0;
wire [1:0] pair_fastchain1_iir2_z_top0;
wire signed [49:0] pair_fastchain1_iir2_z_result0;
wire signed [24:0] pair_fastchain1_iir2_x1;
reg signed [24:0] pair_fastchain1_iir2_y2 = 25'sd0;
wire pair_fastchain1_iir2_hold1;
wire pair_fastchain1_iir2_clear1;
reg pair_fastchain1_iir2_error1 = 1'd0;
reg [26:0] pair_fastchain1_iir2_storage_full1 = 27'd0;
wire [26:0] pair_fastchain1_iir2_storage1;
reg pair_fastchain1_iir2_re1 = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_a11 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage10_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage10_storage;
reg pair_fastchain1_iir2_csrstorage10_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_a2 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage11_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage11_storage;
reg pair_fastchain1_iir2_csrstorage11_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_b01 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage12_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage12_storage;
reg pair_fastchain1_iir2_csrstorage12_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_b11 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage13_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage13_storage;
reg pair_fastchain1_iir2_csrstorage13_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir2_b2 = 25'sd0;
reg [24:0] pair_fastchain1_iir2_csrstorage14_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir2_csrstorage14_storage;
reg pair_fastchain1_iir2_csrstorage14_re = 1'd0;
reg signed [49:0] pair_fastchain1_iir2_z0r1 = 50'sd0;
reg signed [24:0] pair_fastchain1_iir2_y_lim1;
wire signed [49:0] pair_fastchain1_iir2_y_next1;
reg [2:0] pair_fastchain1_iir2_y_pat1 = 3'd7;
reg signed [24:0] pair_fastchain1_iir2_y3 = 25'sd0;
wire pair_fastchain1_iir2_railed1;
reg signed [49:0] pair_fastchain1_iir2_zr5 = 50'sd0;
wire signed [47:0] pair_fastchain1_iir2_zr_low2;
wire [47:0] pair_fastchain1_iir2_zr_cascade2;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q2;
wire pair_fastchain1_iir2_zr6;
wire pair_fastchain1_iir2_zr7;
wire signed [3:0] pair_fastchain1_iir2_zr_correction2;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q2 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q2 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top2;
wire signed [49:0] pair_fastchain1_iir2_zr_result2;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo2;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop2;
wire signed [47:0] pair_fastchain1_iir2_zr_low3;
wire [47:0] pair_fastchain1_iir2_zr_cascade3;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q3;
wire pair_fastchain1_iir2_zr8;
wire pair_fastchain1_iir2_zr9;
wire signed [3:0] pair_fastchain1_iir2_zr_correction3;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q3 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q3 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top3;
wire signed [49:0] pair_fastchain1_iir2_zr_result3;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo3;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop3;
wire signed [47:0] pair_fastchain1_iir2_zr_low4;
wire [47:0] pair_fastchain1_iir2_zr_cascade4;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q4;
wire pair_fastchain1_iir2_zr10;
wire pair_fastchain1_iir2_zr11;
wire signed [3:0] pair_fastchain1_iir2_zr_correction4;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q4 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q4 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top4;
wire signed [49:0] pair_fastchain1_iir2_zr_result4;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo4;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop4;
wire signed [47:0] pair_fastchain1_iir2_zr_low5;
wire [47:0] pair_fastchain1_iir2_zr_cascade5;
wire signed [47:0] pair_fastchain1_iir2_zr_high_q5;
wire pair_fastchain1_iir2_zr12;
wire pair_fastchain1_iir2_zr13;
wire signed [3:0] pair_fastchain1_iir2_zr_correction5;
reg signed [3:0] pair_fastchain1_iir2_zr_correction_q5 = 4'sd0;
reg [16:0] pair_fastchain1_iir2_zr_low_q5 = 17'd0;
wire [1:0] pair_fastchain1_iir2_zr_top5;
wire signed [49:0] pair_fastchain1_iir2_zr_result5;
wire signed [47:0] pair_fastchain1_iir2_zr_zlo5;
wire signed [1:0] pair_fastchain1_iir2_zr_ztop5;
wire signed [17:0] pair_fastchain1_iir2_z_xlo1;
wire signed [7:0] pair_fastchain1_iir2_z_xhi1;
wire signed [47:0] pair_fastchain1_iir2_z_zlo1;
wire signed [1:0] pair_fastchain1_iir2_z_ztop1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir2_z_low1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir2_z_high1;
wire pair_fastchain1_iir2_z_carry1;
wire signed [3:0] pair_fastchain1_iir2_z_correction1;
wire [1:0] pair_fastchain1_iir2_z_top1;
wire signed [49:0] pair_fastchain1_iir2_z_result1;
reg signed [24:0] pair_fastchain1_earlycommontaplimitcsr0_y = 25'sd0;
reg pair_fastchain1_earlycommontaplimitcsr0_error = 1'd0;
wire pair_fastchain1_earlycommontaplimitcsr0_update_en;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr00;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr01;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr02;
wire signed [13:0] pair_fastchain1_earlycommontaplimitcsr0_common_x;
wire signed [13:0] pair_fastchain1_earlycommontaplimitcsr0_common_offset;
reg signed [14:0] pair_fastchain1_earlycommontaplimitcsr0_common_reg = 15'sd0;
wire [1:0] pair_fastchain1_earlycommontaplimitcsr03;
wire pair_fastchain1_earlycommontaplimitcsr04;
reg [24:0] pair_fastchain1_earlycommontaplimitcsr0_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain1_earlycommontaplimitcsr0_min_storage;
reg pair_fastchain1_earlycommontaplimitcsr0_min_re = 1'd0;
reg [24:0] pair_fastchain1_earlycommontaplimitcsr0_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain1_earlycommontaplimitcsr0_max_storage;
reg pair_fastchain1_earlycommontaplimitcsr0_max_re = 1'd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr05 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr06 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr07 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr08 = 28'sd0;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr09;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr010;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr00;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr01;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr02;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr03;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr04;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr05;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr06;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr07;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr08;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr09;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr00;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr01;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr02;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr03;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr04;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr05;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr06;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr07;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr08;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr09;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr00;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr01;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr02;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr03;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr04;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr05;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr06;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr07;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr08;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr09;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr00;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr01;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr02;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr03;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr04;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr05;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr06;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr07;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr08;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr09;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result = 28'sd0;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_total0;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr011;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr012;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr013;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr014;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_total1;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr015;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr016;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr017;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr018;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr0_total2;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr019;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr020;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr021;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr022;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr023;
wire pair_fastchain1_earlycommontaplimitcsr024;
reg signed [24:0] pair_fastchain1_limitcsr3_limitcsr3_y = 25'sd0;
reg pair_fastchain1_limitcsr3_limitcsr3_error = 1'd0;
reg pair_fastchain1_limitcsr3_update_en = 1'd1;
wire signed [25:0] pair_fastchain1_limitcsr3_x;
reg [24:0] pair_fastchain1_limitcsr3_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain1_limitcsr3_min_storage;
reg pair_fastchain1_limitcsr3_min_re = 1'd0;
reg [24:0] pair_fastchain1_limitcsr3_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain1_limitcsr3_max_storage;
reg pair_fastchain1_limitcsr3_max_re = 1'd0;
wire signed [25:0] pair_fastchain1_limitcsr3_limit_x;
reg signed [25:0] pair_fastchain1_limitcsr3_limit_y;
reg signed [25:0] pair_fastchain1_limitcsr3_limit_max = 26'sd0;
reg signed [25:0] pair_fastchain1_limitcsr3_limit_min = 26'sd0;
reg pair_fastchain1_limitcsr3_limit_railed;
wire signed [24:0] pair_fastchain1_iir3_x0;
reg signed [24:0] pair_fastchain1_iir3_y0 = 25'sd0;
wire pair_fastchain1_iir3_hold0;
wire pair_fastchain1_iir3_clear0;
reg pair_fastchain1_iir3_error0 = 1'd0;
reg [26:0] pair_fastchain1_iir3_storage_full0 = 27'd0;
wire [26:0] pair_fastchain1_iir3_storage0;
reg pair_fastchain1_iir3_re0 = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_a10 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage9_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage9_storage;
reg pair_fastchain1_iir3_csrstorage9_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_b00 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage10_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage10_storage;
reg pair_fastchain1_iir3_csrstorage10_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_b10 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage11_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage11_storage;
reg pair_fastchain1_iir3_csrstorage11_re = 1'd0;
reg signed [49:0] pair_fastchain1_iir3_z0r0 = 50'sd0;
reg signed [24:0] pair_fastchain1_iir3_y_lim0;
wire signed [49:0] pair_fastchain1_iir3_y_next0;
reg [2:0] pair_fastchain1_iir3_y_pat0 = 3'd7;
reg signed [24:0] pair_fastchain1_iir3_y1 = 25'sd0;
wire pair_fastchain1_iir3_railed0;
reg signed [49:0] pair_fastchain1_iir3_zr0 = 50'sd0;
wire signed [47:0] pair_fastchain1_iir3_zr_low0;
wire [47:0] pair_fastchain1_iir3_zr_cascade0;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q0;
wire pair_fastchain1_iir3_zr1;
wire pair_fastchain1_iir3_zr2;
wire signed [3:0] pair_fastchain1_iir3_zr_correction0;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q0 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q0 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top0;
wire signed [49:0] pair_fastchain1_iir3_zr_result0;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo0;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop0;
wire signed [47:0] pair_fastchain1_iir3_zr_low1;
wire [47:0] pair_fastchain1_iir3_zr_cascade1;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q1;
wire pair_fastchain1_iir3_zr3;
wire pair_fastchain1_iir3_zr4;
wire signed [3:0] pair_fastchain1_iir3_zr_correction1;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q1 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q1 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top1;
wire signed [49:0] pair_fastchain1_iir3_zr_result1;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo1;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop1;
wire signed [17:0] pair_fastchain1_iir3_z_xlo0;
wire signed [7:0] pair_fastchain1_iir3_z_xhi0;
wire signed [47:0] pair_fastchain1_iir3_z_zlo0;
wire signed [1:0] pair_fastchain1_iir3_z_ztop0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir3_z_low0;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir3_z_high0;
wire pair_fastchain1_iir3_z_carry0;
wire signed [3:0] pair_fastchain1_iir3_z_correction0;
wire [1:0] pair_fastchain1_iir3_z_top0;
wire signed [49:0] pair_fastchain1_iir3_z_result0;
wire signed [24:0] pair_fastchain1_iir3_x1;
reg signed [24:0] pair_fastchain1_iir3_y2 = 25'sd0;
wire pair_fastchain1_iir3_hold1;
wire pair_fastchain1_iir3_clear1;
reg pair_fastchain1_iir3_error1 = 1'd0;
reg [26:0] pair_fastchain1_iir3_storage_full1 = 27'd0;
wire [26:0] pair_fastchain1_iir3_storage1;
reg pair_fastchain1_iir3_re1 = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_a11 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage15_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage15_storage;
reg pair_fastchain1_iir3_csrstorage15_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_a2 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage16_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage16_storage;
reg pair_fastchain1_iir3_csrstorage16_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_b01 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage17_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage17_storage;
reg pair_fastchain1_iir3_csrstorage17_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_b11 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage18_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage18_storage;
reg pair_fastchain1_iir3_csrstorage18_re = 1'd0;
reg signed [24:0] pair_fastchain1_iir3_b2 = 25'sd0;
reg [24:0] pair_fastchain1_iir3_csrstorage19_storage_full = 25'd0;
wire [24:0] pair_fastchain1_iir3_csrstorage19_storage;
reg pair_fastchain1_iir3_csrstorage19_re = 1'd0;
reg signed [49:0] pair_fastchain1_iir3_z0r1 = 50'sd0;
reg signed [24:0] pair_fastchain1_iir3_y_lim1;
wire signed [49:0] pair_fastchain1_iir3_y_next1;
reg [2:0] pair_fastchain1_iir3_y_pat1 = 3'd7;
reg signed [24:0] pair_fastchain1_iir3_y3 = 25'sd0;
wire pair_fastchain1_iir3_railed1;
reg signed [49:0] pair_fastchain1_iir3_zr5 = 50'sd0;
wire signed [47:0] pair_fastchain1_iir3_zr_low2;
wire [47:0] pair_fastchain1_iir3_zr_cascade2;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q2;
wire pair_fastchain1_iir3_zr6;
wire pair_fastchain1_iir3_zr7;
wire signed [3:0] pair_fastchain1_iir3_zr_correction2;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q2 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q2 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top2;
wire signed [49:0] pair_fastchain1_iir3_zr_result2;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo2;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop2;
wire signed [47:0] pair_fastchain1_iir3_zr_low3;
wire [47:0] pair_fastchain1_iir3_zr_cascade3;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q3;
wire pair_fastchain1_iir3_zr8;
wire pair_fastchain1_iir3_zr9;
wire signed [3:0] pair_fastchain1_iir3_zr_correction3;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q3 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q3 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top3;
wire signed [49:0] pair_fastchain1_iir3_zr_result3;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo3;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop3;
wire signed [47:0] pair_fastchain1_iir3_zr_low4;
wire [47:0] pair_fastchain1_iir3_zr_cascade4;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q4;
wire pair_fastchain1_iir3_zr10;
wire pair_fastchain1_iir3_zr11;
wire signed [3:0] pair_fastchain1_iir3_zr_correction4;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q4 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q4 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top4;
wire signed [49:0] pair_fastchain1_iir3_zr_result4;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo4;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop4;
wire signed [47:0] pair_fastchain1_iir3_zr_low5;
wire [47:0] pair_fastchain1_iir3_zr_cascade5;
wire signed [47:0] pair_fastchain1_iir3_zr_high_q5;
wire pair_fastchain1_iir3_zr12;
wire pair_fastchain1_iir3_zr13;
wire signed [3:0] pair_fastchain1_iir3_zr_correction5;
reg signed [3:0] pair_fastchain1_iir3_zr_correction_q5 = 4'sd0;
reg [16:0] pair_fastchain1_iir3_zr_low_q5 = 17'd0;
wire [1:0] pair_fastchain1_iir3_zr_top5;
wire signed [49:0] pair_fastchain1_iir3_zr_result5;
wire signed [47:0] pair_fastchain1_iir3_zr_zlo5;
wire signed [1:0] pair_fastchain1_iir3_zr_ztop5;
wire signed [17:0] pair_fastchain1_iir3_z_xlo1;
wire signed [7:0] pair_fastchain1_iir3_z_xhi1;
wire signed [47:0] pair_fastchain1_iir3_z_zlo1;
wire signed [1:0] pair_fastchain1_iir3_z_ztop1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir3_z_low1;
(* use_dsp = "yes" *) wire signed [47:0] pair_fastchain1_iir3_z_high1;
wire pair_fastchain1_iir3_z_carry1;
wire signed [3:0] pair_fastchain1_iir3_z_correction1;
wire [1:0] pair_fastchain1_iir3_z_top1;
wire signed [49:0] pair_fastchain1_iir3_z_result1;
reg signed [24:0] pair_fastchain1_earlycommontaplimitcsr1_y = 25'sd0;
reg pair_fastchain1_earlycommontaplimitcsr1_error = 1'd0;
wire pair_fastchain1_earlycommontaplimitcsr1_update_en;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr10;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr11;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr12;
wire signed [13:0] pair_fastchain1_earlycommontaplimitcsr1_common_x;
wire signed [13:0] pair_fastchain1_earlycommontaplimitcsr1_common_offset;
reg signed [14:0] pair_fastchain1_earlycommontaplimitcsr1_common_reg = 15'sd0;
wire [1:0] pair_fastchain1_earlycommontaplimitcsr13;
wire pair_fastchain1_earlycommontaplimitcsr14;
reg [24:0] pair_fastchain1_earlycommontaplimitcsr1_min_storage_full = 25'd16777216;
wire [24:0] pair_fastchain1_earlycommontaplimitcsr1_min_storage;
reg pair_fastchain1_earlycommontaplimitcsr1_min_re = 1'd0;
reg [24:0] pair_fastchain1_earlycommontaplimitcsr1_max_storage_full = 25'd16777215;
wire [24:0] pair_fastchain1_earlycommontaplimitcsr1_max_storage;
reg pair_fastchain1_earlycommontaplimitcsr1_max_re = 1'd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr15 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr16 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr17 = 28'sd0;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr18 = 28'sd0;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr19;
wire signed [24:0] pair_fastchain1_earlycommontaplimitcsr110;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr10;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr11;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr12;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr13;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr14;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr15;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr16;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr17;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr18;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr19;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr10;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr11;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr12;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr13;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr14;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr15;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr16;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr17;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr18;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr19;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr10;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr11;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr12;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr13;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr14;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr15;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr16;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr17;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr18;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr19;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result = 28'sd0;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr10;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr11;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr12;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr13;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr14;
wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr15;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr16;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr17;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr18;
(* keep = "true" *) wire [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr19;
wire signed [15:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_high;
wire [10:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_low;
reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result = 28'sd0;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_total0;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr111;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr112;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr113;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr114;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_total1;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr115;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr116;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr117;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr118;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr1_total2;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr119;
(* keep = "true" *) reg signed [27:0] pair_fastchain1_earlycommontaplimitcsr120;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr121;
(* keep = "true" *) reg pair_fastchain1_earlycommontaplimitcsr122;
wire signed [27:0] pair_fastchain1_earlycommontaplimitcsr123;
wire pair_fastchain1_earlycommontaplimitcsr124;
wire [13:0] pair_csrbank1_bus_adr;
wire pair_csrbank1_bus_we;
wire [7:0] pair_csrbank1_bus_dat_w;
reg [7:0] pair_csrbank1_bus_dat_r = 8'd0;
wire pair_csrbank1_y_tap0_re;
wire [1:0] pair_csrbank1_y_tap0_r;
wire [1:0] pair_csrbank1_y_tap0_w;
wire pair_csrbank1_invert0_re;
wire pair_csrbank1_invert0_r;
wire pair_csrbank1_invert0_w;
wire pair_csrbank1_demod_delay3_re;
wire [7:0] pair_csrbank1_demod_delay3_r;
wire [7:0] pair_csrbank1_demod_delay3_w;
wire pair_csrbank1_demod_delay2_re;
wire [7:0] pair_csrbank1_demod_delay2_r;
wire [7:0] pair_csrbank1_demod_delay2_w;
wire pair_csrbank1_demod_delay1_re;
wire [7:0] pair_csrbank1_demod_delay1_r;
wire [7:0] pair_csrbank1_demod_delay1_w;
wire pair_csrbank1_demod_delay0_re;
wire [7:0] pair_csrbank1_demod_delay0_r;
wire [7:0] pair_csrbank1_demod_delay0_w;
wire pair_csrbank1_demod_multiplier0_re;
wire [3:0] pair_csrbank1_demod_multiplier0_r;
wire [3:0] pair_csrbank1_demod_multiplier0_w;
wire pair_csrbank1_x_limit_1_min3_re;
wire pair_csrbank1_x_limit_1_min3_r;
wire pair_csrbank1_x_limit_1_min3_w;
wire pair_csrbank1_x_limit_1_min2_re;
wire [7:0] pair_csrbank1_x_limit_1_min2_r;
wire [7:0] pair_csrbank1_x_limit_1_min2_w;
wire pair_csrbank1_x_limit_1_min1_re;
wire [7:0] pair_csrbank1_x_limit_1_min1_r;
wire [7:0] pair_csrbank1_x_limit_1_min1_w;
wire pair_csrbank1_x_limit_1_min0_re;
wire [7:0] pair_csrbank1_x_limit_1_min0_r;
wire [7:0] pair_csrbank1_x_limit_1_min0_w;
wire pair_csrbank1_x_limit_1_max3_re;
wire pair_csrbank1_x_limit_1_max3_r;
wire pair_csrbank1_x_limit_1_max3_w;
wire pair_csrbank1_x_limit_1_max2_re;
wire [7:0] pair_csrbank1_x_limit_1_max2_r;
wire [7:0] pair_csrbank1_x_limit_1_max2_w;
wire pair_csrbank1_x_limit_1_max1_re;
wire [7:0] pair_csrbank1_x_limit_1_max1_r;
wire [7:0] pair_csrbank1_x_limit_1_max1_w;
wire pair_csrbank1_x_limit_1_max0_re;
wire [7:0] pair_csrbank1_x_limit_1_max0_r;
wire [7:0] pair_csrbank1_x_limit_1_max0_w;
wire pair_csrbank1_iir_c_1_z03_re;
wire [2:0] pair_csrbank1_iir_c_1_z03_r;
wire [2:0] pair_csrbank1_iir_c_1_z03_w;
wire pair_csrbank1_iir_c_1_z02_re;
wire [7:0] pair_csrbank1_iir_c_1_z02_r;
wire [7:0] pair_csrbank1_iir_c_1_z02_w;
wire pair_csrbank1_iir_c_1_z01_re;
wire [7:0] pair_csrbank1_iir_c_1_z01_r;
wire [7:0] pair_csrbank1_iir_c_1_z01_w;
wire pair_csrbank1_iir_c_1_z00_re;
wire [7:0] pair_csrbank1_iir_c_1_z00_r;
wire [7:0] pair_csrbank1_iir_c_1_z00_w;
wire pair_csrbank1_iir_c_1_a13_re;
wire pair_csrbank1_iir_c_1_a13_r;
wire pair_csrbank1_iir_c_1_a13_w;
wire pair_csrbank1_iir_c_1_a12_re;
wire [7:0] pair_csrbank1_iir_c_1_a12_r;
wire [7:0] pair_csrbank1_iir_c_1_a12_w;
wire pair_csrbank1_iir_c_1_a11_re;
wire [7:0] pair_csrbank1_iir_c_1_a11_r;
wire [7:0] pair_csrbank1_iir_c_1_a11_w;
wire pair_csrbank1_iir_c_1_a10_re;
wire [7:0] pair_csrbank1_iir_c_1_a10_r;
wire [7:0] pair_csrbank1_iir_c_1_a10_w;
wire pair_csrbank1_iir_c_1_b03_re;
wire pair_csrbank1_iir_c_1_b03_r;
wire pair_csrbank1_iir_c_1_b03_w;
wire pair_csrbank1_iir_c_1_b02_re;
wire [7:0] pair_csrbank1_iir_c_1_b02_r;
wire [7:0] pair_csrbank1_iir_c_1_b02_w;
wire pair_csrbank1_iir_c_1_b01_re;
wire [7:0] pair_csrbank1_iir_c_1_b01_r;
wire [7:0] pair_csrbank1_iir_c_1_b01_w;
wire pair_csrbank1_iir_c_1_b00_re;
wire [7:0] pair_csrbank1_iir_c_1_b00_r;
wire [7:0] pair_csrbank1_iir_c_1_b00_w;
wire pair_csrbank1_iir_c_1_b13_re;
wire pair_csrbank1_iir_c_1_b13_r;
wire pair_csrbank1_iir_c_1_b13_w;
wire pair_csrbank1_iir_c_1_b12_re;
wire [7:0] pair_csrbank1_iir_c_1_b12_r;
wire [7:0] pair_csrbank1_iir_c_1_b12_w;
wire pair_csrbank1_iir_c_1_b11_re;
wire [7:0] pair_csrbank1_iir_c_1_b11_r;
wire [7:0] pair_csrbank1_iir_c_1_b11_w;
wire pair_csrbank1_iir_c_1_b10_re;
wire [7:0] pair_csrbank1_iir_c_1_b10_r;
wire [7:0] pair_csrbank1_iir_c_1_b10_w;
wire pair_csrbank1_iir_d_1_z03_re;
wire [2:0] pair_csrbank1_iir_d_1_z03_r;
wire [2:0] pair_csrbank1_iir_d_1_z03_w;
wire pair_csrbank1_iir_d_1_z02_re;
wire [7:0] pair_csrbank1_iir_d_1_z02_r;
wire [7:0] pair_csrbank1_iir_d_1_z02_w;
wire pair_csrbank1_iir_d_1_z01_re;
wire [7:0] pair_csrbank1_iir_d_1_z01_r;
wire [7:0] pair_csrbank1_iir_d_1_z01_w;
wire pair_csrbank1_iir_d_1_z00_re;
wire [7:0] pair_csrbank1_iir_d_1_z00_r;
wire [7:0] pair_csrbank1_iir_d_1_z00_w;
wire pair_csrbank1_iir_d_1_a13_re;
wire pair_csrbank1_iir_d_1_a13_r;
wire pair_csrbank1_iir_d_1_a13_w;
wire pair_csrbank1_iir_d_1_a12_re;
wire [7:0] pair_csrbank1_iir_d_1_a12_r;
wire [7:0] pair_csrbank1_iir_d_1_a12_w;
wire pair_csrbank1_iir_d_1_a11_re;
wire [7:0] pair_csrbank1_iir_d_1_a11_r;
wire [7:0] pair_csrbank1_iir_d_1_a11_w;
wire pair_csrbank1_iir_d_1_a10_re;
wire [7:0] pair_csrbank1_iir_d_1_a10_r;
wire [7:0] pair_csrbank1_iir_d_1_a10_w;
wire pair_csrbank1_iir_d_1_a23_re;
wire pair_csrbank1_iir_d_1_a23_r;
wire pair_csrbank1_iir_d_1_a23_w;
wire pair_csrbank1_iir_d_1_a22_re;
wire [7:0] pair_csrbank1_iir_d_1_a22_r;
wire [7:0] pair_csrbank1_iir_d_1_a22_w;
wire pair_csrbank1_iir_d_1_a21_re;
wire [7:0] pair_csrbank1_iir_d_1_a21_r;
wire [7:0] pair_csrbank1_iir_d_1_a21_w;
wire pair_csrbank1_iir_d_1_a20_re;
wire [7:0] pair_csrbank1_iir_d_1_a20_r;
wire [7:0] pair_csrbank1_iir_d_1_a20_w;
wire pair_csrbank1_iir_d_1_b03_re;
wire pair_csrbank1_iir_d_1_b03_r;
wire pair_csrbank1_iir_d_1_b03_w;
wire pair_csrbank1_iir_d_1_b02_re;
wire [7:0] pair_csrbank1_iir_d_1_b02_r;
wire [7:0] pair_csrbank1_iir_d_1_b02_w;
wire pair_csrbank1_iir_d_1_b01_re;
wire [7:0] pair_csrbank1_iir_d_1_b01_r;
wire [7:0] pair_csrbank1_iir_d_1_b01_w;
wire pair_csrbank1_iir_d_1_b00_re;
wire [7:0] pair_csrbank1_iir_d_1_b00_r;
wire [7:0] pair_csrbank1_iir_d_1_b00_w;
wire pair_csrbank1_iir_d_1_b13_re;
wire pair_csrbank1_iir_d_1_b13_r;
wire pair_csrbank1_iir_d_1_b13_w;
wire pair_csrbank1_iir_d_1_b12_re;
wire [7:0] pair_csrbank1_iir_d_1_b12_r;
wire [7:0] pair_csrbank1_iir_d_1_b12_w;
wire pair_csrbank1_iir_d_1_b11_re;
wire [7:0] pair_csrbank1_iir_d_1_b11_r;
wire [7:0] pair_csrbank1_iir_d_1_b11_w;
wire pair_csrbank1_iir_d_1_b10_re;
wire [7:0] pair_csrbank1_iir_d_1_b10_r;
wire [7:0] pair_csrbank1_iir_d_1_b10_w;
wire pair_csrbank1_iir_d_1_b23_re;
wire pair_csrbank1_iir_d_1_b23_r;
wire pair_csrbank1_iir_d_1_b23_w;
wire pair_csrbank1_iir_d_1_b22_re;
wire [7:0] pair_csrbank1_iir_d_1_b22_r;
wire [7:0] pair_csrbank1_iir_d_1_b22_w;
wire pair_csrbank1_iir_d_1_b21_re;
wire [7:0] pair_csrbank1_iir_d_1_b21_r;
wire [7:0] pair_csrbank1_iir_d_1_b21_w;
wire pair_csrbank1_iir_d_1_b20_re;
wire [7:0] pair_csrbank1_iir_d_1_b20_r;
wire [7:0] pair_csrbank1_iir_d_1_b20_w;
wire pair_csrbank1_y_limit_1_min3_re;
wire pair_csrbank1_y_limit_1_min3_r;
wire pair_csrbank1_y_limit_1_min3_w;
wire pair_csrbank1_y_limit_1_min2_re;
wire [7:0] pair_csrbank1_y_limit_1_min2_r;
wire [7:0] pair_csrbank1_y_limit_1_min2_w;
wire pair_csrbank1_y_limit_1_min1_re;
wire [7:0] pair_csrbank1_y_limit_1_min1_r;
wire [7:0] pair_csrbank1_y_limit_1_min1_w;
wire pair_csrbank1_y_limit_1_min0_re;
wire [7:0] pair_csrbank1_y_limit_1_min0_r;
wire [7:0] pair_csrbank1_y_limit_1_min0_w;
wire pair_csrbank1_y_limit_1_max3_re;
wire pair_csrbank1_y_limit_1_max3_r;
wire pair_csrbank1_y_limit_1_max3_w;
wire pair_csrbank1_y_limit_1_max2_re;
wire [7:0] pair_csrbank1_y_limit_1_max2_r;
wire [7:0] pair_csrbank1_y_limit_1_max2_w;
wire pair_csrbank1_y_limit_1_max1_re;
wire [7:0] pair_csrbank1_y_limit_1_max1_r;
wire [7:0] pair_csrbank1_y_limit_1_max1_w;
wire pair_csrbank1_y_limit_1_max0_re;
wire [7:0] pair_csrbank1_y_limit_1_max0_r;
wire [7:0] pair_csrbank1_y_limit_1_max0_w;
wire pair_csrbank1_x_limit_2_min3_re;
wire pair_csrbank1_x_limit_2_min3_r;
wire pair_csrbank1_x_limit_2_min3_w;
wire pair_csrbank1_x_limit_2_min2_re;
wire [7:0] pair_csrbank1_x_limit_2_min2_r;
wire [7:0] pair_csrbank1_x_limit_2_min2_w;
wire pair_csrbank1_x_limit_2_min1_re;
wire [7:0] pair_csrbank1_x_limit_2_min1_r;
wire [7:0] pair_csrbank1_x_limit_2_min1_w;
wire pair_csrbank1_x_limit_2_min0_re;
wire [7:0] pair_csrbank1_x_limit_2_min0_r;
wire [7:0] pair_csrbank1_x_limit_2_min0_w;
wire pair_csrbank1_x_limit_2_max3_re;
wire pair_csrbank1_x_limit_2_max3_r;
wire pair_csrbank1_x_limit_2_max3_w;
wire pair_csrbank1_x_limit_2_max2_re;
wire [7:0] pair_csrbank1_x_limit_2_max2_r;
wire [7:0] pair_csrbank1_x_limit_2_max2_w;
wire pair_csrbank1_x_limit_2_max1_re;
wire [7:0] pair_csrbank1_x_limit_2_max1_r;
wire [7:0] pair_csrbank1_x_limit_2_max1_w;
wire pair_csrbank1_x_limit_2_max0_re;
wire [7:0] pair_csrbank1_x_limit_2_max0_r;
wire [7:0] pair_csrbank1_x_limit_2_max0_w;
wire pair_csrbank1_iir_c_2_z03_re;
wire [2:0] pair_csrbank1_iir_c_2_z03_r;
wire [2:0] pair_csrbank1_iir_c_2_z03_w;
wire pair_csrbank1_iir_c_2_z02_re;
wire [7:0] pair_csrbank1_iir_c_2_z02_r;
wire [7:0] pair_csrbank1_iir_c_2_z02_w;
wire pair_csrbank1_iir_c_2_z01_re;
wire [7:0] pair_csrbank1_iir_c_2_z01_r;
wire [7:0] pair_csrbank1_iir_c_2_z01_w;
wire pair_csrbank1_iir_c_2_z00_re;
wire [7:0] pair_csrbank1_iir_c_2_z00_r;
wire [7:0] pair_csrbank1_iir_c_2_z00_w;
wire pair_csrbank1_iir_c_2_a13_re;
wire pair_csrbank1_iir_c_2_a13_r;
wire pair_csrbank1_iir_c_2_a13_w;
wire pair_csrbank1_iir_c_2_a12_re;
wire [7:0] pair_csrbank1_iir_c_2_a12_r;
wire [7:0] pair_csrbank1_iir_c_2_a12_w;
wire pair_csrbank1_iir_c_2_a11_re;
wire [7:0] pair_csrbank1_iir_c_2_a11_r;
wire [7:0] pair_csrbank1_iir_c_2_a11_w;
wire pair_csrbank1_iir_c_2_a10_re;
wire [7:0] pair_csrbank1_iir_c_2_a10_r;
wire [7:0] pair_csrbank1_iir_c_2_a10_w;
wire pair_csrbank1_iir_c_2_b03_re;
wire pair_csrbank1_iir_c_2_b03_r;
wire pair_csrbank1_iir_c_2_b03_w;
wire pair_csrbank1_iir_c_2_b02_re;
wire [7:0] pair_csrbank1_iir_c_2_b02_r;
wire [7:0] pair_csrbank1_iir_c_2_b02_w;
wire pair_csrbank1_iir_c_2_b01_re;
wire [7:0] pair_csrbank1_iir_c_2_b01_r;
wire [7:0] pair_csrbank1_iir_c_2_b01_w;
wire pair_csrbank1_iir_c_2_b00_re;
wire [7:0] pair_csrbank1_iir_c_2_b00_r;
wire [7:0] pair_csrbank1_iir_c_2_b00_w;
wire pair_csrbank1_iir_c_2_b13_re;
wire pair_csrbank1_iir_c_2_b13_r;
wire pair_csrbank1_iir_c_2_b13_w;
wire pair_csrbank1_iir_c_2_b12_re;
wire [7:0] pair_csrbank1_iir_c_2_b12_r;
wire [7:0] pair_csrbank1_iir_c_2_b12_w;
wire pair_csrbank1_iir_c_2_b11_re;
wire [7:0] pair_csrbank1_iir_c_2_b11_r;
wire [7:0] pair_csrbank1_iir_c_2_b11_w;
wire pair_csrbank1_iir_c_2_b10_re;
wire [7:0] pair_csrbank1_iir_c_2_b10_r;
wire [7:0] pair_csrbank1_iir_c_2_b10_w;
wire pair_csrbank1_iir_d_2_z03_re;
wire [2:0] pair_csrbank1_iir_d_2_z03_r;
wire [2:0] pair_csrbank1_iir_d_2_z03_w;
wire pair_csrbank1_iir_d_2_z02_re;
wire [7:0] pair_csrbank1_iir_d_2_z02_r;
wire [7:0] pair_csrbank1_iir_d_2_z02_w;
wire pair_csrbank1_iir_d_2_z01_re;
wire [7:0] pair_csrbank1_iir_d_2_z01_r;
wire [7:0] pair_csrbank1_iir_d_2_z01_w;
wire pair_csrbank1_iir_d_2_z00_re;
wire [7:0] pair_csrbank1_iir_d_2_z00_r;
wire [7:0] pair_csrbank1_iir_d_2_z00_w;
wire pair_csrbank1_iir_d_2_a13_re;
wire pair_csrbank1_iir_d_2_a13_r;
wire pair_csrbank1_iir_d_2_a13_w;
wire pair_csrbank1_iir_d_2_a12_re;
wire [7:0] pair_csrbank1_iir_d_2_a12_r;
wire [7:0] pair_csrbank1_iir_d_2_a12_w;
wire pair_csrbank1_iir_d_2_a11_re;
wire [7:0] pair_csrbank1_iir_d_2_a11_r;
wire [7:0] pair_csrbank1_iir_d_2_a11_w;
wire pair_csrbank1_iir_d_2_a10_re;
wire [7:0] pair_csrbank1_iir_d_2_a10_r;
wire [7:0] pair_csrbank1_iir_d_2_a10_w;
wire pair_csrbank1_iir_d_2_a23_re;
wire pair_csrbank1_iir_d_2_a23_r;
wire pair_csrbank1_iir_d_2_a23_w;
wire pair_csrbank1_iir_d_2_a22_re;
wire [7:0] pair_csrbank1_iir_d_2_a22_r;
wire [7:0] pair_csrbank1_iir_d_2_a22_w;
wire pair_csrbank1_iir_d_2_a21_re;
wire [7:0] pair_csrbank1_iir_d_2_a21_r;
wire [7:0] pair_csrbank1_iir_d_2_a21_w;
wire pair_csrbank1_iir_d_2_a20_re;
wire [7:0] pair_csrbank1_iir_d_2_a20_r;
wire [7:0] pair_csrbank1_iir_d_2_a20_w;
wire pair_csrbank1_iir_d_2_b03_re;
wire pair_csrbank1_iir_d_2_b03_r;
wire pair_csrbank1_iir_d_2_b03_w;
wire pair_csrbank1_iir_d_2_b02_re;
wire [7:0] pair_csrbank1_iir_d_2_b02_r;
wire [7:0] pair_csrbank1_iir_d_2_b02_w;
wire pair_csrbank1_iir_d_2_b01_re;
wire [7:0] pair_csrbank1_iir_d_2_b01_r;
wire [7:0] pair_csrbank1_iir_d_2_b01_w;
wire pair_csrbank1_iir_d_2_b00_re;
wire [7:0] pair_csrbank1_iir_d_2_b00_r;
wire [7:0] pair_csrbank1_iir_d_2_b00_w;
wire pair_csrbank1_iir_d_2_b13_re;
wire pair_csrbank1_iir_d_2_b13_r;
wire pair_csrbank1_iir_d_2_b13_w;
wire pair_csrbank1_iir_d_2_b12_re;
wire [7:0] pair_csrbank1_iir_d_2_b12_r;
wire [7:0] pair_csrbank1_iir_d_2_b12_w;
wire pair_csrbank1_iir_d_2_b11_re;
wire [7:0] pair_csrbank1_iir_d_2_b11_r;
wire [7:0] pair_csrbank1_iir_d_2_b11_w;
wire pair_csrbank1_iir_d_2_b10_re;
wire [7:0] pair_csrbank1_iir_d_2_b10_r;
wire [7:0] pair_csrbank1_iir_d_2_b10_w;
wire pair_csrbank1_iir_d_2_b23_re;
wire pair_csrbank1_iir_d_2_b23_r;
wire pair_csrbank1_iir_d_2_b23_w;
wire pair_csrbank1_iir_d_2_b22_re;
wire [7:0] pair_csrbank1_iir_d_2_b22_r;
wire [7:0] pair_csrbank1_iir_d_2_b22_w;
wire pair_csrbank1_iir_d_2_b21_re;
wire [7:0] pair_csrbank1_iir_d_2_b21_r;
wire [7:0] pair_csrbank1_iir_d_2_b21_w;
wire pair_csrbank1_iir_d_2_b20_re;
wire [7:0] pair_csrbank1_iir_d_2_b20_r;
wire [7:0] pair_csrbank1_iir_d_2_b20_w;
wire pair_csrbank1_y_limit_2_min3_re;
wire pair_csrbank1_y_limit_2_min3_r;
wire pair_csrbank1_y_limit_2_min3_w;
wire pair_csrbank1_y_limit_2_min2_re;
wire [7:0] pair_csrbank1_y_limit_2_min2_r;
wire [7:0] pair_csrbank1_y_limit_2_min2_w;
wire pair_csrbank1_y_limit_2_min1_re;
wire [7:0] pair_csrbank1_y_limit_2_min1_r;
wire [7:0] pair_csrbank1_y_limit_2_min1_w;
wire pair_csrbank1_y_limit_2_min0_re;
wire [7:0] pair_csrbank1_y_limit_2_min0_r;
wire [7:0] pair_csrbank1_y_limit_2_min0_w;
wire pair_csrbank1_y_limit_2_max3_re;
wire pair_csrbank1_y_limit_2_max3_r;
wire pair_csrbank1_y_limit_2_max3_w;
wire pair_csrbank1_y_limit_2_max2_re;
wire [7:0] pair_csrbank1_y_limit_2_max2_r;
wire [7:0] pair_csrbank1_y_limit_2_max2_w;
wire pair_csrbank1_y_limit_2_max1_re;
wire [7:0] pair_csrbank1_y_limit_2_max1_r;
wire [7:0] pair_csrbank1_y_limit_2_max1_w;
wire pair_csrbank1_y_limit_2_max0_re;
wire [7:0] pair_csrbank1_y_limit_2_max0_r;
wire [7:0] pair_csrbank1_y_limit_2_max0_w;
wire pair_csrbank1_sel;
reg signed [27:0] array_muxed0;
reg signed [27:0] array_muxed1;
reg array_muxed2;
reg array_muxed3;
reg signed [27:0] array_muxed4;
reg signed [27:0] array_muxed5;
reg array_muxed6;
reg array_muxed7;
reg signed [27:0] array_muxed8;
reg signed [27:0] array_muxed9;
reg array_muxed10;
reg array_muxed11;
reg signed [27:0] array_muxed12;
reg signed [27:0] array_muxed13;
reg array_muxed14;
reg array_muxed15;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_fastchain0_adc = adc;
assign pair_fastchain0_dx = dx;
assign pair_fastchain0_dy = dy;
assign pair_fastchain0_paralleltaplimitcsr0_update_en = ce;
assign pair_fastchain0_paralleltaplimitcsr1_update_en = ce;
assign pair_csrbank0_bus_adr = csr_adr;
assign pair_csrbank0_bus_we = csr_we;
assign pair_csrbank0_bus_dat_w = csr_dat_w;
assign reference_result = {pair_fastchain0_iir1_error1, pair_fastchain0_iir1_error0, pair_fastchain0_iir0_error1, pair_fastchain0_iir0_error0, pair_csrbank0_bus_dat_r, pair_fastchain0_out_i_update_en, pair_fastchain0_pre_out_i, pair_fastchain0_out_q, pair_fastchain0_out_i};
assign pair_fastchain1_adc = adc;
assign pair_fastchain1_dx = dx;
assign pair_fastchain1_dy = dy;
assign pair_fastchain1_earlycommontaplimitcsr0_update_en = ce;
assign pair_fastchain1_earlycommontaplimitcsr1_update_en = ce;
assign pair_csrbank1_bus_adr = csr_adr;
assign pair_csrbank1_bus_we = csr_we;
assign pair_csrbank1_bus_dat_w = csr_dat_w;
assign candidate_result = {pair_fastchain1_iir3_error1, pair_fastchain1_iir3_error0, pair_fastchain1_iir2_error1, pair_fastchain1_iir2_error0, pair_csrbank1_bus_dat_r, pair_fastchain1_out_i_update_en, pair_fastchain1_pre_out_i, pair_fastchain1_out_q, pair_fastchain1_out_i};
assign pair_fastchain0_x0 = (pair_fastchain0_adc <<< 4'd11);
assign pair_fastchain0_x1 = pair_fastchain0_adc;
assign pair_fastchain0_phase = phase;
assign pair_fastchain0_signed_offset = offset;
assign pair_fastchain0_pre_out_i = pair_fastchain0_paralleltaplimitcsr0_pre_y;
assign pair_fastchain0_out_i_update_en = pair_fastchain0_paralleltaplimitcsr0_update_en;
assign pair_fastchain0_limitcsr0_x = ((pair_fastchain0_i <<< 4'd11) + pair_fastchain0_dx);
assign pair_fastchain0_iir0_x0 = pair_fastchain0_limitcsr0_limitcsr0_y;
assign pair_fastchain0_iir0_hold0 = 1'd0;
assign pair_fastchain0_iir0_clear0 = 1'd0;
assign pair_fastchain0_iir0_x1 = pair_fastchain0_iir0_y0;
assign pair_fastchain0_iir0_hold1 = 1'd0;
assign pair_fastchain0_iir0_clear1 = 1'd0;
assign pair_fastchain0_paralleltaplimitcsr0_common_a = (pair_fastchain0_common <<< 4'd11);
assign pair_fastchain0_paralleltaplimitcsr0_common_b = 1'd0;
assign pair_fastchain0_paralleltaplimitcsr03 = pair_fastchain0_y_tap_storage;
assign pair_fastchain0_paralleltaplimitcsr04 = pair_fastchain0_invert_storage;
assign pair_fastchain0_paralleltaplimitcsr00 = pair_fastchain0_iir0_x0;
assign pair_fastchain0_paralleltaplimitcsr01 = pair_fastchain0_iir0_y0;
assign pair_fastchain0_paralleltaplimitcsr02 = pair_fastchain0_iir0_y2;
assign pair_fastchain0_out_i = pair_fastchain0_paralleltaplimitcsr0_y;
assign pair_fastchain0_limitcsr1_x = ((pair_fastchain0_q0 <<< 4'd11) + pair_fastchain0_dx);
assign pair_fastchain0_iir1_x0 = pair_fastchain0_limitcsr1_limitcsr1_y;
assign pair_fastchain0_iir1_hold0 = 1'd0;
assign pair_fastchain0_iir1_clear0 = 1'd0;
assign pair_fastchain0_iir1_x1 = pair_fastchain0_iir1_y0;
assign pair_fastchain0_iir1_hold1 = 1'd0;
assign pair_fastchain0_iir1_clear1 = 1'd0;
assign pair_fastchain0_paralleltaplimitcsr1_common_a = (pair_fastchain0_common <<< 4'd11);
assign pair_fastchain0_paralleltaplimitcsr1_common_b = 1'd0;
assign pair_fastchain0_paralleltaplimitcsr13 = pair_fastchain0_y_tap_storage;
assign pair_fastchain0_paralleltaplimitcsr14 = pair_fastchain0_invert_storage;
assign pair_fastchain0_paralleltaplimitcsr10 = pair_fastchain0_iir1_x0;
assign pair_fastchain0_paralleltaplimitcsr11 = pair_fastchain0_iir1_y0;
assign pair_fastchain0_paralleltaplimitcsr12 = pair_fastchain0_iir1_y2;
assign pair_fastchain0_out_q = pair_fastchain0_paralleltaplimitcsr1_y;
assign pair_fastchain0_phase_value = (((pair_fastchain0_phase * pair_fastchain0_multiplier_storage) + pair_fastchain0_delay_storage) <<< 1'd1);
assign pair_fastchain0_xi = pair_fastchain0_x1;
assign pair_fastchain0_zi = pair_fastchain0_phase_value;
assign pair_fastchain0_yi = 1'd0;
assign pair_fastchain0_i = (pair_fastchain0_speculativedemodcordic0_xo >>> 1'd1);
assign pair_fastchain0_q0 = (pair_fastchain0_speculativedemodcordic0_yo >>> 1'd1);
assign pair_fastchain0_speculativedemodcordic00 = (pair_fastchain0_speculativedemodcordic0_xi <<< 2'd2);
assign pair_fastchain0_speculativedemodcordic016 = (pair_fastchain0_speculativedemodcordic0_yi <<< 2'd2);
assign pair_fastchain0_speculativedemodcordic032 = (pair_fastchain0_speculativedemodcordic0_zi <<< 2'd2);
assign pair_fastchain0_speculativedemodcordic0_xo = (pair_fastchain0_speculativedemodcordic015 >>> 2'd2);
assign pair_fastchain0_speculativedemodcordic0_yo = (pair_fastchain0_speculativedemodcordic031 >>> 2'd2);
assign pair_fastchain0_speculativedemodcordic0_zo = (pair_fastchain0_speculativedemodcordic047 >>> 2'd2);
assign pair_fastchain0_speculativedemodcordic0_new_out = 1'd1;
assign pair_fastchain0_speculativedemodcordic0_new_in = 1'd1;
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir0 = (pair_fastchain0_speculativedemodcordic032 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic00 = (pair_fastchain0_x1 <<< 2'd2);
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic01 = (-pair_fastchain0_speculativedemodcordic0_speculativedemodcordic00);
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir1 = (pair_fastchain0_speculativedemodcordic033 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir2 = (pair_fastchain0_speculativedemodcordic034 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir3 = (pair_fastchain0_speculativedemodcordic035 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir4 = (pair_fastchain0_speculativedemodcordic036 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir5 = (pair_fastchain0_speculativedemodcordic037 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir6 = (pair_fastchain0_speculativedemodcordic038 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir7 = (pair_fastchain0_speculativedemodcordic039 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir8 = (pair_fastchain0_speculativedemodcordic040 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir9 = (pair_fastchain0_speculativedemodcordic041 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir10 = (pair_fastchain0_speculativedemodcordic042 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir11 = (pair_fastchain0_speculativedemodcordic043 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir12 = (pair_fastchain0_speculativedemodcordic044 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir13 = (pair_fastchain0_speculativedemodcordic045 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir14 = (pair_fastchain0_speculativedemodcordic046 < $signed({1'd0, 1'd0}));
assign pair_fastchain0_q1 = (pair_fastchain0_zi[13] ^ pair_fastchain0_zi[14]);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_speculativedemodcordic0_xi <= 15'sd0;
	pair_fastchain0_speculativedemodcordic0_yi <= 15'sd0;
	pair_fastchain0_speculativedemodcordic0_zi <= 15'sd0;
	if (pair_fastchain0_q1) begin
		{pair_fastchain0_speculativedemodcordic0_zi, pair_fastchain0_speculativedemodcordic0_yi, pair_fastchain0_speculativedemodcordic0_xi} <= {(pair_fastchain0_zi + $signed({1'd0, 15'd16384})), (-pair_fastchain0_yi), (-pair_fastchain0_xi)};
	end else begin
		{pair_fastchain0_speculativedemodcordic0_zi, pair_fastchain0_speculativedemodcordic0_yi, pair_fastchain0_speculativedemodcordic0_xi} <= {pair_fastchain0_zi, pair_fastchain0_yi, pair_fastchain0_xi};
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_limitcsr0_limit_x = pair_fastchain0_limitcsr0_x;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_limitcsr0_limit_y <= 26'sd0;
	pair_fastchain0_limitcsr0_limit_railed <= 1'd0;
	if ((pair_fastchain0_limitcsr0_limit_x >= pair_fastchain0_limitcsr0_limit_max)) begin
		pair_fastchain0_limitcsr0_limit_y <= pair_fastchain0_limitcsr0_limit_max;
		pair_fastchain0_limitcsr0_limit_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_limitcsr0_limit_x <= pair_fastchain0_limitcsr0_limit_min)) begin
			pair_fastchain0_limitcsr0_limit_y <= pair_fastchain0_limitcsr0_limit_min;
			pair_fastchain0_limitcsr0_limit_railed <= 1'd1;
		end else begin
			pair_fastchain0_limitcsr0_limit_y <= pair_fastchain0_limitcsr0_limit_x;
			pair_fastchain0_limitcsr0_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir0_railed0 = (~((pair_fastchain0_iir0_y_next0[49:47] == $signed({1'd0, pair_fastchain0_iir0_y_pat0})) | (pair_fastchain0_iir0_y_next0[49:47] == $signed({1'd0, (~pair_fastchain0_iir0_y_pat0)}))));

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_iir0_y_lim0 <= 25'sd0;
	if (pair_fastchain0_iir0_railed0) begin
		pair_fastchain0_iir0_y_lim0 <= pair_fastchain0_iir0_y0;
	end else begin
		pair_fastchain0_iir0_y_lim0 <= pair_fastchain0_iir0_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir0_zr_zlo0 = pair_fastchain0_iir0_zr0[47:0];
assign pair_fastchain0_iir0_zr_ztop0 = pair_fastchain0_iir0_zr0[49:48];
assign pair_fastchain0_iir0_zr1 = (((~pair_fastchain0_iir0_zr_zlo0[47]) & (~pair_fastchain0_iir0_b10[24])) & pair_fastchain0_iir0_zr_low0[47]);
assign pair_fastchain0_iir0_zr2 = ((pair_fastchain0_iir0_zr_zlo0[47] & pair_fastchain0_iir0_b10[24]) & (~pair_fastchain0_iir0_zr_low0[47]));
assign pair_fastchain0_iir0_zr_correction0 = (((pair_fastchain0_iir0_zr_ztop0 + pair_fastchain0_iir0_zr_zlo0[47]) + $signed({1'd0, pair_fastchain0_iir0_zr1})) - $signed({1'd0, pair_fastchain0_iir0_zr2}));
assign pair_fastchain0_iir0_zr_top0 = (pair_fastchain0_iir0_zr_high_q0[32:31] + pair_fastchain0_iir0_zr_correction_q0);
assign pair_fastchain0_iir0_zr_result0 = {pair_fastchain0_iir0_zr_top0, pair_fastchain0_iir0_zr_high_q0[30:0], pair_fastchain0_iir0_zr_low_q0};
assign pair_fastchain0_iir0_zr_zlo1 = pair_fastchain0_iir0_zr_result0[47:0];
assign pair_fastchain0_iir0_zr_ztop1 = pair_fastchain0_iir0_zr_result0[49:48];
assign pair_fastchain0_iir0_zr3 = (((~pair_fastchain0_iir0_zr_zlo1[47]) & (~pair_fastchain0_iir0_b00[24])) & pair_fastchain0_iir0_zr_low1[47]);
assign pair_fastchain0_iir0_zr4 = ((pair_fastchain0_iir0_zr_zlo1[47] & pair_fastchain0_iir0_b00[24]) & (~pair_fastchain0_iir0_zr_low1[47]));
assign pair_fastchain0_iir0_zr_correction1 = (((pair_fastchain0_iir0_zr_ztop1 + pair_fastchain0_iir0_zr_zlo1[47]) + $signed({1'd0, pair_fastchain0_iir0_zr3})) - $signed({1'd0, pair_fastchain0_iir0_zr4}));
assign pair_fastchain0_iir0_zr_top1 = (pair_fastchain0_iir0_zr_high_q1[32:31] + pair_fastchain0_iir0_zr_correction_q1);
assign pair_fastchain0_iir0_zr_result1 = {pair_fastchain0_iir0_zr_top1, pair_fastchain0_iir0_zr_high_q1[30:0], pair_fastchain0_iir0_zr_low_q1};
assign pair_fastchain0_iir0_z_xlo0 = {1'd0, pair_fastchain0_iir0_a10[16:0]};
assign pair_fastchain0_iir0_z_xhi0 = pair_fastchain0_iir0_a10[24:17];
assign pair_fastchain0_iir0_z_zlo0 = pair_fastchain0_iir0_zr_result1[47:0];
assign pair_fastchain0_iir0_z_ztop0 = pair_fastchain0_iir0_zr_result1[49:48];
assign pair_fastchain0_iir0_z_low0 = ((pair_fastchain0_iir0_y1 * pair_fastchain0_iir0_z_xlo0) + pair_fastchain0_iir0_z_zlo0);
assign pair_fastchain0_iir0_z_high0 = ((pair_fastchain0_iir0_y1 * pair_fastchain0_iir0_z_xhi0) + (pair_fastchain0_iir0_z_low0 >>> 5'd17));
assign pair_fastchain0_iir0_z_carry0 = ((pair_fastchain0_iir0_z_zlo0[47] & pair_fastchain0_iir0_z_low0[47]) | ((~pair_fastchain0_iir0_y1[24]) & (pair_fastchain0_iir0_z_zlo0[47] | pair_fastchain0_iir0_z_low0[47])));
assign pair_fastchain0_iir0_z_correction0 = (pair_fastchain0_iir0_z_ztop0 + $signed({1'd0, pair_fastchain0_iir0_z_carry0}));
assign pair_fastchain0_iir0_z_top0 = (pair_fastchain0_iir0_z_high0[32:31] + pair_fastchain0_iir0_z_correction0);
assign pair_fastchain0_iir0_z_result0 = {pair_fastchain0_iir0_z_top0, pair_fastchain0_iir0_z_high0[30:0], pair_fastchain0_iir0_z_low0[16:0]};
assign pair_fastchain0_iir0_y_next0 = pair_fastchain0_iir0_z_result0;
assign pair_fastchain0_iir0_railed1 = (~((pair_fastchain0_iir0_y_next1[49:47] == $signed({1'd0, pair_fastchain0_iir0_y_pat1})) | (pair_fastchain0_iir0_y_next1[49:47] == $signed({1'd0, (~pair_fastchain0_iir0_y_pat1)}))));

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_iir0_y_lim1 <= 25'sd0;
	if (pair_fastchain0_iir0_railed1) begin
		pair_fastchain0_iir0_y_lim1 <= pair_fastchain0_iir0_y2;
	end else begin
		pair_fastchain0_iir0_y_lim1 <= pair_fastchain0_iir0_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir0_zr_zlo2 = pair_fastchain0_iir0_zr5[47:0];
assign pair_fastchain0_iir0_zr_ztop2 = pair_fastchain0_iir0_zr5[49:48];
assign pair_fastchain0_iir0_zr6 = (((~pair_fastchain0_iir0_zr_zlo2[47]) & (~pair_fastchain0_iir0_b2[24])) & pair_fastchain0_iir0_zr_low2[47]);
assign pair_fastchain0_iir0_zr7 = ((pair_fastchain0_iir0_zr_zlo2[47] & pair_fastchain0_iir0_b2[24]) & (~pair_fastchain0_iir0_zr_low2[47]));
assign pair_fastchain0_iir0_zr_correction2 = (((pair_fastchain0_iir0_zr_ztop2 + pair_fastchain0_iir0_zr_zlo2[47]) + $signed({1'd0, pair_fastchain0_iir0_zr6})) - $signed({1'd0, pair_fastchain0_iir0_zr7}));
assign pair_fastchain0_iir0_zr_top2 = (pair_fastchain0_iir0_zr_high_q2[32:31] + pair_fastchain0_iir0_zr_correction_q2);
assign pair_fastchain0_iir0_zr_result2 = {pair_fastchain0_iir0_zr_top2, pair_fastchain0_iir0_zr_high_q2[30:0], pair_fastchain0_iir0_zr_low_q2};
assign pair_fastchain0_iir0_zr_zlo3 = pair_fastchain0_iir0_zr_result2[47:0];
assign pair_fastchain0_iir0_zr_ztop3 = pair_fastchain0_iir0_zr_result2[49:48];
assign pair_fastchain0_iir0_zr8 = (((~pair_fastchain0_iir0_zr_zlo3[47]) & (~pair_fastchain0_iir0_b11[24])) & pair_fastchain0_iir0_zr_low3[47]);
assign pair_fastchain0_iir0_zr9 = ((pair_fastchain0_iir0_zr_zlo3[47] & pair_fastchain0_iir0_b11[24]) & (~pair_fastchain0_iir0_zr_low3[47]));
assign pair_fastchain0_iir0_zr_correction3 = (((pair_fastchain0_iir0_zr_ztop3 + pair_fastchain0_iir0_zr_zlo3[47]) + $signed({1'd0, pair_fastchain0_iir0_zr8})) - $signed({1'd0, pair_fastchain0_iir0_zr9}));
assign pair_fastchain0_iir0_zr_top3 = (pair_fastchain0_iir0_zr_high_q3[32:31] + pair_fastchain0_iir0_zr_correction_q3);
assign pair_fastchain0_iir0_zr_result3 = {pair_fastchain0_iir0_zr_top3, pair_fastchain0_iir0_zr_high_q3[30:0], pair_fastchain0_iir0_zr_low_q3};
assign pair_fastchain0_iir0_zr_zlo4 = pair_fastchain0_iir0_zr_result3[47:0];
assign pair_fastchain0_iir0_zr_ztop4 = pair_fastchain0_iir0_zr_result3[49:48];
assign pair_fastchain0_iir0_zr10 = (((~pair_fastchain0_iir0_zr_zlo4[47]) & (~pair_fastchain0_iir0_b01[24])) & pair_fastchain0_iir0_zr_low4[47]);
assign pair_fastchain0_iir0_zr11 = ((pair_fastchain0_iir0_zr_zlo4[47] & pair_fastchain0_iir0_b01[24]) & (~pair_fastchain0_iir0_zr_low4[47]));
assign pair_fastchain0_iir0_zr_correction4 = (((pair_fastchain0_iir0_zr_ztop4 + pair_fastchain0_iir0_zr_zlo4[47]) + $signed({1'd0, pair_fastchain0_iir0_zr10})) - $signed({1'd0, pair_fastchain0_iir0_zr11}));
assign pair_fastchain0_iir0_zr_top4 = (pair_fastchain0_iir0_zr_high_q4[32:31] + pair_fastchain0_iir0_zr_correction_q4);
assign pair_fastchain0_iir0_zr_result4 = {pair_fastchain0_iir0_zr_top4, pair_fastchain0_iir0_zr_high_q4[30:0], pair_fastchain0_iir0_zr_low_q4};
assign pair_fastchain0_iir0_zr_zlo5 = pair_fastchain0_iir0_zr_result4[47:0];
assign pair_fastchain0_iir0_zr_ztop5 = pair_fastchain0_iir0_zr_result4[49:48];
assign pair_fastchain0_iir0_zr12 = (((~pair_fastchain0_iir0_zr_zlo5[47]) & (~pair_fastchain0_iir0_a2[24])) & pair_fastchain0_iir0_zr_low5[47]);
assign pair_fastchain0_iir0_zr13 = ((pair_fastchain0_iir0_zr_zlo5[47] & pair_fastchain0_iir0_a2[24]) & (~pair_fastchain0_iir0_zr_low5[47]));
assign pair_fastchain0_iir0_zr_correction5 = (((pair_fastchain0_iir0_zr_ztop5 + pair_fastchain0_iir0_zr_zlo5[47]) + $signed({1'd0, pair_fastchain0_iir0_zr12})) - $signed({1'd0, pair_fastchain0_iir0_zr13}));
assign pair_fastchain0_iir0_zr_top5 = (pair_fastchain0_iir0_zr_high_q5[32:31] + pair_fastchain0_iir0_zr_correction_q5);
assign pair_fastchain0_iir0_zr_result5 = {pair_fastchain0_iir0_zr_top5, pair_fastchain0_iir0_zr_high_q5[30:0], pair_fastchain0_iir0_zr_low_q5};
assign pair_fastchain0_iir0_z_xlo1 = {1'd0, pair_fastchain0_iir0_a11[16:0]};
assign pair_fastchain0_iir0_z_xhi1 = pair_fastchain0_iir0_a11[24:17];
assign pair_fastchain0_iir0_z_zlo1 = pair_fastchain0_iir0_zr_result5[47:0];
assign pair_fastchain0_iir0_z_ztop1 = pair_fastchain0_iir0_zr_result5[49:48];
assign pair_fastchain0_iir0_z_low1 = ((pair_fastchain0_iir0_y3 * pair_fastchain0_iir0_z_xlo1) + pair_fastchain0_iir0_z_zlo1);
assign pair_fastchain0_iir0_z_high1 = ((pair_fastchain0_iir0_y3 * pair_fastchain0_iir0_z_xhi1) + (pair_fastchain0_iir0_z_low1 >>> 5'd17));
assign pair_fastchain0_iir0_z_carry1 = ((pair_fastchain0_iir0_z_zlo1[47] & pair_fastchain0_iir0_z_low1[47]) | ((~pair_fastchain0_iir0_y3[24]) & (pair_fastchain0_iir0_z_zlo1[47] | pair_fastchain0_iir0_z_low1[47])));
assign pair_fastchain0_iir0_z_correction1 = (pair_fastchain0_iir0_z_ztop1 + $signed({1'd0, pair_fastchain0_iir0_z_carry1}));
assign pair_fastchain0_iir0_z_top1 = (pair_fastchain0_iir0_z_high1[32:31] + pair_fastchain0_iir0_z_correction1);
assign pair_fastchain0_iir0_z_result1 = {pair_fastchain0_iir0_z_top1, pair_fastchain0_iir0_z_high1[30:0], pair_fastchain0_iir0_z_low1[16:0]};
assign pair_fastchain0_iir0_y_next1 = pair_fastchain0_iir0_z_result1;
assign pair_fastchain0_paralleltaplimitcsr0_common_sum = (pair_fastchain0_paralleltaplimitcsr0_common_a + pair_fastchain0_paralleltaplimitcsr0_common_b);
assign pair_fastchain0_paralleltaplimitcsr0_total0 = (pair_fastchain0_paralleltaplimitcsr00 + pair_fastchain0_paralleltaplimitcsr0_common_sum);
assign pair_fastchain0_paralleltaplimitcsr0_limit0_x = pair_fastchain0_paralleltaplimitcsr0_total0;
assign pair_fastchain0_paralleltaplimitcsr0_limit0_min = pair_fastchain0_paralleltaplimitcsr0_bound_min;
assign pair_fastchain0_paralleltaplimitcsr0_limit0_max = pair_fastchain0_paralleltaplimitcsr0_bound_max;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr0_neg_value0 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_total0 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr0_neg_value0 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
		pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_total0 <= pair_fastchain0_paralleltaplimitcsr0_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr0_neg_value0 <= pair_fastchain0_paralleltaplimitcsr0_bound_max;
			pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr0_total0 >= pair_fastchain0_paralleltaplimitcsr0_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value0 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value0 <= (-pair_fastchain0_paralleltaplimitcsr0_total0);
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr0_total1 = (pair_fastchain0_paralleltaplimitcsr01 + pair_fastchain0_paralleltaplimitcsr0_common_sum);
assign pair_fastchain0_paralleltaplimitcsr0_limit1_x = pair_fastchain0_paralleltaplimitcsr0_total1;
assign pair_fastchain0_paralleltaplimitcsr0_limit1_min = pair_fastchain0_paralleltaplimitcsr0_bound_min;
assign pair_fastchain0_paralleltaplimitcsr0_limit1_max = pair_fastchain0_paralleltaplimitcsr0_bound_max;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr0_neg_value1 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_total1 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr0_neg_value1 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
		pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_total1 <= pair_fastchain0_paralleltaplimitcsr0_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr0_neg_value1 <= pair_fastchain0_paralleltaplimitcsr0_bound_max;
			pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr0_total1 >= pair_fastchain0_paralleltaplimitcsr0_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value1 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value1 <= (-pair_fastchain0_paralleltaplimitcsr0_total1);
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr0_total2 = (pair_fastchain0_paralleltaplimitcsr02 + pair_fastchain0_paralleltaplimitcsr0_common_sum);
assign pair_fastchain0_paralleltaplimitcsr0_limit2_x = pair_fastchain0_paralleltaplimitcsr0_total2;
assign pair_fastchain0_paralleltaplimitcsr0_limit2_min = pair_fastchain0_paralleltaplimitcsr0_bound_min;
assign pair_fastchain0_paralleltaplimitcsr0_limit2_max = pair_fastchain0_paralleltaplimitcsr0_bound_max;

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr0_neg_value2 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_total2 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr0_neg_value2 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
		pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_total2 <= pair_fastchain0_paralleltaplimitcsr0_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr0_neg_value2 <= pair_fastchain0_paralleltaplimitcsr0_bound_max;
			pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr0_total2 >= pair_fastchain0_paralleltaplimitcsr0_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value2 <= pair_fastchain0_paralleltaplimitcsr0_bound_min;
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr0_neg_value2 <= (-pair_fastchain0_paralleltaplimitcsr0_total2);
				pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr0_pre_y = (pair_fastchain0_paralleltaplimitcsr04 ? array_muxed0 : array_muxed1);
assign pair_fastchain0_paralleltaplimitcsr0_pre_rail = (pair_fastchain0_paralleltaplimitcsr04 ? array_muxed2 : array_muxed3);

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr0_limit0_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_limit0_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_limit0_x >= pair_fastchain0_paralleltaplimitcsr0_limit0_max)) begin
		pair_fastchain0_paralleltaplimitcsr0_limit0_y <= pair_fastchain0_paralleltaplimitcsr0_limit0_max;
		pair_fastchain0_paralleltaplimitcsr0_limit0_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_limit0_x <= pair_fastchain0_paralleltaplimitcsr0_limit0_min)) begin
			pair_fastchain0_paralleltaplimitcsr0_limit0_y <= pair_fastchain0_paralleltaplimitcsr0_limit0_min;
			pair_fastchain0_paralleltaplimitcsr0_limit0_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr0_limit0_y <= pair_fastchain0_paralleltaplimitcsr0_limit0_x;
			pair_fastchain0_paralleltaplimitcsr0_limit0_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr0_limit1_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_limit1_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_limit1_x >= pair_fastchain0_paralleltaplimitcsr0_limit1_max)) begin
		pair_fastchain0_paralleltaplimitcsr0_limit1_y <= pair_fastchain0_paralleltaplimitcsr0_limit1_max;
		pair_fastchain0_paralleltaplimitcsr0_limit1_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_limit1_x <= pair_fastchain0_paralleltaplimitcsr0_limit1_min)) begin
			pair_fastchain0_paralleltaplimitcsr0_limit1_y <= pair_fastchain0_paralleltaplimitcsr0_limit1_min;
			pair_fastchain0_paralleltaplimitcsr0_limit1_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr0_limit1_y <= pair_fastchain0_paralleltaplimitcsr0_limit1_x;
			pair_fastchain0_paralleltaplimitcsr0_limit1_railed <= 1'd0;
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
	pair_fastchain0_paralleltaplimitcsr0_limit2_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr0_limit2_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr0_limit2_x >= pair_fastchain0_paralleltaplimitcsr0_limit2_max)) begin
		pair_fastchain0_paralleltaplimitcsr0_limit2_y <= pair_fastchain0_paralleltaplimitcsr0_limit2_max;
		pair_fastchain0_paralleltaplimitcsr0_limit2_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr0_limit2_x <= pair_fastchain0_paralleltaplimitcsr0_limit2_min)) begin
			pair_fastchain0_paralleltaplimitcsr0_limit2_y <= pair_fastchain0_paralleltaplimitcsr0_limit2_min;
			pair_fastchain0_paralleltaplimitcsr0_limit2_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr0_limit2_y <= pair_fastchain0_paralleltaplimitcsr0_limit2_x;
			pair_fastchain0_paralleltaplimitcsr0_limit2_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_limitcsr1_limit_x = pair_fastchain0_limitcsr1_x;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_limitcsr1_limit_y <= 26'sd0;
	pair_fastchain0_limitcsr1_limit_railed <= 1'd0;
	if ((pair_fastchain0_limitcsr1_limit_x >= pair_fastchain0_limitcsr1_limit_max)) begin
		pair_fastchain0_limitcsr1_limit_y <= pair_fastchain0_limitcsr1_limit_max;
		pair_fastchain0_limitcsr1_limit_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_limitcsr1_limit_x <= pair_fastchain0_limitcsr1_limit_min)) begin
			pair_fastchain0_limitcsr1_limit_y <= pair_fastchain0_limitcsr1_limit_min;
			pair_fastchain0_limitcsr1_limit_railed <= 1'd1;
		end else begin
			pair_fastchain0_limitcsr1_limit_y <= pair_fastchain0_limitcsr1_limit_x;
			pair_fastchain0_limitcsr1_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir1_railed0 = (~((pair_fastchain0_iir1_y_next0[49:47] == $signed({1'd0, pair_fastchain0_iir1_y_pat0})) | (pair_fastchain0_iir1_y_next0[49:47] == $signed({1'd0, (~pair_fastchain0_iir1_y_pat0)}))));

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_iir1_y_lim0 <= 25'sd0;
	if (pair_fastchain0_iir1_railed0) begin
		pair_fastchain0_iir1_y_lim0 <= pair_fastchain0_iir1_y0;
	end else begin
		pair_fastchain0_iir1_y_lim0 <= pair_fastchain0_iir1_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir1_zr_zlo0 = pair_fastchain0_iir1_zr0[47:0];
assign pair_fastchain0_iir1_zr_ztop0 = pair_fastchain0_iir1_zr0[49:48];
assign pair_fastchain0_iir1_zr1 = (((~pair_fastchain0_iir1_zr_zlo0[47]) & (~pair_fastchain0_iir1_b10[24])) & pair_fastchain0_iir1_zr_low0[47]);
assign pair_fastchain0_iir1_zr2 = ((pair_fastchain0_iir1_zr_zlo0[47] & pair_fastchain0_iir1_b10[24]) & (~pair_fastchain0_iir1_zr_low0[47]));
assign pair_fastchain0_iir1_zr_correction0 = (((pair_fastchain0_iir1_zr_ztop0 + pair_fastchain0_iir1_zr_zlo0[47]) + $signed({1'd0, pair_fastchain0_iir1_zr1})) - $signed({1'd0, pair_fastchain0_iir1_zr2}));
assign pair_fastchain0_iir1_zr_top0 = (pair_fastchain0_iir1_zr_high_q0[32:31] + pair_fastchain0_iir1_zr_correction_q0);
assign pair_fastchain0_iir1_zr_result0 = {pair_fastchain0_iir1_zr_top0, pair_fastchain0_iir1_zr_high_q0[30:0], pair_fastchain0_iir1_zr_low_q0};
assign pair_fastchain0_iir1_zr_zlo1 = pair_fastchain0_iir1_zr_result0[47:0];
assign pair_fastchain0_iir1_zr_ztop1 = pair_fastchain0_iir1_zr_result0[49:48];
assign pair_fastchain0_iir1_zr3 = (((~pair_fastchain0_iir1_zr_zlo1[47]) & (~pair_fastchain0_iir1_b00[24])) & pair_fastchain0_iir1_zr_low1[47]);
assign pair_fastchain0_iir1_zr4 = ((pair_fastchain0_iir1_zr_zlo1[47] & pair_fastchain0_iir1_b00[24]) & (~pair_fastchain0_iir1_zr_low1[47]));
assign pair_fastchain0_iir1_zr_correction1 = (((pair_fastchain0_iir1_zr_ztop1 + pair_fastchain0_iir1_zr_zlo1[47]) + $signed({1'd0, pair_fastchain0_iir1_zr3})) - $signed({1'd0, pair_fastchain0_iir1_zr4}));
assign pair_fastchain0_iir1_zr_top1 = (pair_fastchain0_iir1_zr_high_q1[32:31] + pair_fastchain0_iir1_zr_correction_q1);
assign pair_fastchain0_iir1_zr_result1 = {pair_fastchain0_iir1_zr_top1, pair_fastchain0_iir1_zr_high_q1[30:0], pair_fastchain0_iir1_zr_low_q1};
assign pair_fastchain0_iir1_z_xlo0 = {1'd0, pair_fastchain0_iir1_a10[16:0]};
assign pair_fastchain0_iir1_z_xhi0 = pair_fastchain0_iir1_a10[24:17];
assign pair_fastchain0_iir1_z_zlo0 = pair_fastchain0_iir1_zr_result1[47:0];
assign pair_fastchain0_iir1_z_ztop0 = pair_fastchain0_iir1_zr_result1[49:48];
assign pair_fastchain0_iir1_z_low0 = ((pair_fastchain0_iir1_y1 * pair_fastchain0_iir1_z_xlo0) + pair_fastchain0_iir1_z_zlo0);
assign pair_fastchain0_iir1_z_high0 = ((pair_fastchain0_iir1_y1 * pair_fastchain0_iir1_z_xhi0) + (pair_fastchain0_iir1_z_low0 >>> 5'd17));
assign pair_fastchain0_iir1_z_carry0 = ((pair_fastchain0_iir1_z_zlo0[47] & pair_fastchain0_iir1_z_low0[47]) | ((~pair_fastchain0_iir1_y1[24]) & (pair_fastchain0_iir1_z_zlo0[47] | pair_fastchain0_iir1_z_low0[47])));
assign pair_fastchain0_iir1_z_correction0 = (pair_fastchain0_iir1_z_ztop0 + $signed({1'd0, pair_fastchain0_iir1_z_carry0}));
assign pair_fastchain0_iir1_z_top0 = (pair_fastchain0_iir1_z_high0[32:31] + pair_fastchain0_iir1_z_correction0);
assign pair_fastchain0_iir1_z_result0 = {pair_fastchain0_iir1_z_top0, pair_fastchain0_iir1_z_high0[30:0], pair_fastchain0_iir1_z_low0[16:0]};
assign pair_fastchain0_iir1_y_next0 = pair_fastchain0_iir1_z_result0;
assign pair_fastchain0_iir1_railed1 = (~((pair_fastchain0_iir1_y_next1[49:47] == $signed({1'd0, pair_fastchain0_iir1_y_pat1})) | (pair_fastchain0_iir1_y_next1[49:47] == $signed({1'd0, (~pair_fastchain0_iir1_y_pat1)}))));

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_iir1_y_lim1 <= 25'sd0;
	if (pair_fastchain0_iir1_railed1) begin
		pair_fastchain0_iir1_y_lim1 <= pair_fastchain0_iir1_y2;
	end else begin
		pair_fastchain0_iir1_y_lim1 <= pair_fastchain0_iir1_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_iir1_zr_zlo2 = pair_fastchain0_iir1_zr5[47:0];
assign pair_fastchain0_iir1_zr_ztop2 = pair_fastchain0_iir1_zr5[49:48];
assign pair_fastchain0_iir1_zr6 = (((~pair_fastchain0_iir1_zr_zlo2[47]) & (~pair_fastchain0_iir1_b2[24])) & pair_fastchain0_iir1_zr_low2[47]);
assign pair_fastchain0_iir1_zr7 = ((pair_fastchain0_iir1_zr_zlo2[47] & pair_fastchain0_iir1_b2[24]) & (~pair_fastchain0_iir1_zr_low2[47]));
assign pair_fastchain0_iir1_zr_correction2 = (((pair_fastchain0_iir1_zr_ztop2 + pair_fastchain0_iir1_zr_zlo2[47]) + $signed({1'd0, pair_fastchain0_iir1_zr6})) - $signed({1'd0, pair_fastchain0_iir1_zr7}));
assign pair_fastchain0_iir1_zr_top2 = (pair_fastchain0_iir1_zr_high_q2[32:31] + pair_fastchain0_iir1_zr_correction_q2);
assign pair_fastchain0_iir1_zr_result2 = {pair_fastchain0_iir1_zr_top2, pair_fastchain0_iir1_zr_high_q2[30:0], pair_fastchain0_iir1_zr_low_q2};
assign pair_fastchain0_iir1_zr_zlo3 = pair_fastchain0_iir1_zr_result2[47:0];
assign pair_fastchain0_iir1_zr_ztop3 = pair_fastchain0_iir1_zr_result2[49:48];
assign pair_fastchain0_iir1_zr8 = (((~pair_fastchain0_iir1_zr_zlo3[47]) & (~pair_fastchain0_iir1_b11[24])) & pair_fastchain0_iir1_zr_low3[47]);
assign pair_fastchain0_iir1_zr9 = ((pair_fastchain0_iir1_zr_zlo3[47] & pair_fastchain0_iir1_b11[24]) & (~pair_fastchain0_iir1_zr_low3[47]));
assign pair_fastchain0_iir1_zr_correction3 = (((pair_fastchain0_iir1_zr_ztop3 + pair_fastchain0_iir1_zr_zlo3[47]) + $signed({1'd0, pair_fastchain0_iir1_zr8})) - $signed({1'd0, pair_fastchain0_iir1_zr9}));
assign pair_fastchain0_iir1_zr_top3 = (pair_fastchain0_iir1_zr_high_q3[32:31] + pair_fastchain0_iir1_zr_correction_q3);
assign pair_fastchain0_iir1_zr_result3 = {pair_fastchain0_iir1_zr_top3, pair_fastchain0_iir1_zr_high_q3[30:0], pair_fastchain0_iir1_zr_low_q3};
assign pair_fastchain0_iir1_zr_zlo4 = pair_fastchain0_iir1_zr_result3[47:0];
assign pair_fastchain0_iir1_zr_ztop4 = pair_fastchain0_iir1_zr_result3[49:48];
assign pair_fastchain0_iir1_zr10 = (((~pair_fastchain0_iir1_zr_zlo4[47]) & (~pair_fastchain0_iir1_b01[24])) & pair_fastchain0_iir1_zr_low4[47]);
assign pair_fastchain0_iir1_zr11 = ((pair_fastchain0_iir1_zr_zlo4[47] & pair_fastchain0_iir1_b01[24]) & (~pair_fastchain0_iir1_zr_low4[47]));
assign pair_fastchain0_iir1_zr_correction4 = (((pair_fastchain0_iir1_zr_ztop4 + pair_fastchain0_iir1_zr_zlo4[47]) + $signed({1'd0, pair_fastchain0_iir1_zr10})) - $signed({1'd0, pair_fastchain0_iir1_zr11}));
assign pair_fastchain0_iir1_zr_top4 = (pair_fastchain0_iir1_zr_high_q4[32:31] + pair_fastchain0_iir1_zr_correction_q4);
assign pair_fastchain0_iir1_zr_result4 = {pair_fastchain0_iir1_zr_top4, pair_fastchain0_iir1_zr_high_q4[30:0], pair_fastchain0_iir1_zr_low_q4};
assign pair_fastchain0_iir1_zr_zlo5 = pair_fastchain0_iir1_zr_result4[47:0];
assign pair_fastchain0_iir1_zr_ztop5 = pair_fastchain0_iir1_zr_result4[49:48];
assign pair_fastchain0_iir1_zr12 = (((~pair_fastchain0_iir1_zr_zlo5[47]) & (~pair_fastchain0_iir1_a2[24])) & pair_fastchain0_iir1_zr_low5[47]);
assign pair_fastchain0_iir1_zr13 = ((pair_fastchain0_iir1_zr_zlo5[47] & pair_fastchain0_iir1_a2[24]) & (~pair_fastchain0_iir1_zr_low5[47]));
assign pair_fastchain0_iir1_zr_correction5 = (((pair_fastchain0_iir1_zr_ztop5 + pair_fastchain0_iir1_zr_zlo5[47]) + $signed({1'd0, pair_fastchain0_iir1_zr12})) - $signed({1'd0, pair_fastchain0_iir1_zr13}));
assign pair_fastchain0_iir1_zr_top5 = (pair_fastchain0_iir1_zr_high_q5[32:31] + pair_fastchain0_iir1_zr_correction_q5);
assign pair_fastchain0_iir1_zr_result5 = {pair_fastchain0_iir1_zr_top5, pair_fastchain0_iir1_zr_high_q5[30:0], pair_fastchain0_iir1_zr_low_q5};
assign pair_fastchain0_iir1_z_xlo1 = {1'd0, pair_fastchain0_iir1_a11[16:0]};
assign pair_fastchain0_iir1_z_xhi1 = pair_fastchain0_iir1_a11[24:17];
assign pair_fastchain0_iir1_z_zlo1 = pair_fastchain0_iir1_zr_result5[47:0];
assign pair_fastchain0_iir1_z_ztop1 = pair_fastchain0_iir1_zr_result5[49:48];
assign pair_fastchain0_iir1_z_low1 = ((pair_fastchain0_iir1_y3 * pair_fastchain0_iir1_z_xlo1) + pair_fastchain0_iir1_z_zlo1);
assign pair_fastchain0_iir1_z_high1 = ((pair_fastchain0_iir1_y3 * pair_fastchain0_iir1_z_xhi1) + (pair_fastchain0_iir1_z_low1 >>> 5'd17));
assign pair_fastchain0_iir1_z_carry1 = ((pair_fastchain0_iir1_z_zlo1[47] & pair_fastchain0_iir1_z_low1[47]) | ((~pair_fastchain0_iir1_y3[24]) & (pair_fastchain0_iir1_z_zlo1[47] | pair_fastchain0_iir1_z_low1[47])));
assign pair_fastchain0_iir1_z_correction1 = (pair_fastchain0_iir1_z_ztop1 + $signed({1'd0, pair_fastchain0_iir1_z_carry1}));
assign pair_fastchain0_iir1_z_top1 = (pair_fastchain0_iir1_z_high1[32:31] + pair_fastchain0_iir1_z_correction1);
assign pair_fastchain0_iir1_z_result1 = {pair_fastchain0_iir1_z_top1, pair_fastchain0_iir1_z_high1[30:0], pair_fastchain0_iir1_z_low1[16:0]};
assign pair_fastchain0_iir1_y_next1 = pair_fastchain0_iir1_z_result1;
assign pair_fastchain0_paralleltaplimitcsr1_common_sum = (pair_fastchain0_paralleltaplimitcsr1_common_a + pair_fastchain0_paralleltaplimitcsr1_common_b);
assign pair_fastchain0_paralleltaplimitcsr1_total0 = (pair_fastchain0_paralleltaplimitcsr10 + pair_fastchain0_paralleltaplimitcsr1_common_sum);
assign pair_fastchain0_paralleltaplimitcsr1_limit3_x = pair_fastchain0_paralleltaplimitcsr1_total0;
assign pair_fastchain0_paralleltaplimitcsr1_limit3_min = pair_fastchain0_paralleltaplimitcsr1_bound_min;
assign pair_fastchain0_paralleltaplimitcsr1_limit3_max = pair_fastchain0_paralleltaplimitcsr1_bound_max;

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_neg_value0 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_total0 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr1_neg_value0 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
		pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_total0 <= pair_fastchain0_paralleltaplimitcsr1_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr1_neg_value0 <= pair_fastchain0_paralleltaplimitcsr1_bound_max;
			pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr1_total0 >= pair_fastchain0_paralleltaplimitcsr1_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value0 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value0 <= (-pair_fastchain0_paralleltaplimitcsr1_total0);
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr1_total1 = (pair_fastchain0_paralleltaplimitcsr11 + pair_fastchain0_paralleltaplimitcsr1_common_sum);
assign pair_fastchain0_paralleltaplimitcsr1_limit4_x = pair_fastchain0_paralleltaplimitcsr1_total1;
assign pair_fastchain0_paralleltaplimitcsr1_limit4_min = pair_fastchain0_paralleltaplimitcsr1_bound_min;
assign pair_fastchain0_paralleltaplimitcsr1_limit4_max = pair_fastchain0_paralleltaplimitcsr1_bound_max;

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_neg_value1 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_total1 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr1_neg_value1 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
		pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_total1 <= pair_fastchain0_paralleltaplimitcsr1_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr1_neg_value1 <= pair_fastchain0_paralleltaplimitcsr1_bound_max;
			pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr1_total1 >= pair_fastchain0_paralleltaplimitcsr1_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value1 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value1 <= (-pair_fastchain0_paralleltaplimitcsr1_total1);
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr1_total2 = (pair_fastchain0_paralleltaplimitcsr12 + pair_fastchain0_paralleltaplimitcsr1_common_sum);
assign pair_fastchain0_paralleltaplimitcsr1_limit5_x = pair_fastchain0_paralleltaplimitcsr1_total2;
assign pair_fastchain0_paralleltaplimitcsr1_limit5_min = pair_fastchain0_paralleltaplimitcsr1_bound_min;
assign pair_fastchain0_paralleltaplimitcsr1_limit5_max = pair_fastchain0_paralleltaplimitcsr1_bound_max;

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_neg_value2 <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2 <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_total2 == 28'sd134217728)) begin
		pair_fastchain0_paralleltaplimitcsr1_neg_value2 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
		pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2 <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_total2 <= pair_fastchain0_paralleltaplimitcsr1_neg_bound_max)) begin
			pair_fastchain0_paralleltaplimitcsr1_neg_value2 <= pair_fastchain0_paralleltaplimitcsr1_bound_max;
			pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2 <= 1'd1;
		end else begin
			if ((pair_fastchain0_paralleltaplimitcsr1_total2 >= pair_fastchain0_paralleltaplimitcsr1_neg_bound_min)) begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value2 <= pair_fastchain0_paralleltaplimitcsr1_bound_min;
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2 <= 1'd1;
			end else begin
				pair_fastchain0_paralleltaplimitcsr1_neg_value2 <= (-pair_fastchain0_paralleltaplimitcsr1_total2);
				pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2 <= 1'd0;
			end
		end
	end
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain0_paralleltaplimitcsr1_pre_y = (pair_fastchain0_paralleltaplimitcsr14 ? array_muxed4 : array_muxed5);
assign pair_fastchain0_paralleltaplimitcsr1_pre_rail = (pair_fastchain0_paralleltaplimitcsr14 ? array_muxed6 : array_muxed7);

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_limit3_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_limit3_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_limit3_x >= pair_fastchain0_paralleltaplimitcsr1_limit3_max)) begin
		pair_fastchain0_paralleltaplimitcsr1_limit3_y <= pair_fastchain0_paralleltaplimitcsr1_limit3_max;
		pair_fastchain0_paralleltaplimitcsr1_limit3_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_limit3_x <= pair_fastchain0_paralleltaplimitcsr1_limit3_min)) begin
			pair_fastchain0_paralleltaplimitcsr1_limit3_y <= pair_fastchain0_paralleltaplimitcsr1_limit3_min;
			pair_fastchain0_paralleltaplimitcsr1_limit3_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr1_limit3_y <= pair_fastchain0_paralleltaplimitcsr1_limit3_x;
			pair_fastchain0_paralleltaplimitcsr1_limit3_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_limit4_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_limit4_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_limit4_x >= pair_fastchain0_paralleltaplimitcsr1_limit4_max)) begin
		pair_fastchain0_paralleltaplimitcsr1_limit4_y <= pair_fastchain0_paralleltaplimitcsr1_limit4_max;
		pair_fastchain0_paralleltaplimitcsr1_limit4_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_limit4_x <= pair_fastchain0_paralleltaplimitcsr1_limit4_min)) begin
			pair_fastchain0_paralleltaplimitcsr1_limit4_y <= pair_fastchain0_paralleltaplimitcsr1_limit4_min;
			pair_fastchain0_paralleltaplimitcsr1_limit4_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr1_limit4_y <= pair_fastchain0_paralleltaplimitcsr1_limit4_x;
			pair_fastchain0_paralleltaplimitcsr1_limit4_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	pair_fastchain0_paralleltaplimitcsr1_limit5_y <= 28'sd0;
	pair_fastchain0_paralleltaplimitcsr1_limit5_railed <= 1'd0;
	if ((pair_fastchain0_paralleltaplimitcsr1_limit5_x >= pair_fastchain0_paralleltaplimitcsr1_limit5_max)) begin
		pair_fastchain0_paralleltaplimitcsr1_limit5_y <= pair_fastchain0_paralleltaplimitcsr1_limit5_max;
		pair_fastchain0_paralleltaplimitcsr1_limit5_railed <= 1'd1;
	end else begin
		if ((pair_fastchain0_paralleltaplimitcsr1_limit5_x <= pair_fastchain0_paralleltaplimitcsr1_limit5_min)) begin
			pair_fastchain0_paralleltaplimitcsr1_limit5_y <= pair_fastchain0_paralleltaplimitcsr1_limit5_min;
			pair_fastchain0_paralleltaplimitcsr1_limit5_railed <= 1'd1;
		end else begin
			pair_fastchain0_paralleltaplimitcsr1_limit5_y <= pair_fastchain0_paralleltaplimitcsr1_limit5_x;
			pair_fastchain0_paralleltaplimitcsr1_limit5_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign pair_csrbank0_sel = (pair_csrbank0_bus_adr[13:9] == 1'd0);
assign pair_csrbank0_y_tap0_r = pair_csrbank0_bus_dat_w[1:0];
assign pair_csrbank0_y_tap0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 1'd0));
assign pair_csrbank0_invert0_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_invert0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 1'd1));
assign pair_csrbank0_demod_delay3_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_demod_delay3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 2'd2));
assign pair_csrbank0_demod_delay2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_demod_delay2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 2'd3));
assign pair_csrbank0_demod_delay1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_demod_delay1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 3'd4));
assign pair_csrbank0_demod_delay0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_demod_delay0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 3'd5));
assign pair_csrbank0_demod_multiplier0_r = pair_csrbank0_bus_dat_w[3:0];
assign pair_csrbank0_demod_multiplier0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 3'd6));
assign pair_csrbank0_x_limit_1_min3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_x_limit_1_min3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 3'd7));
assign pair_csrbank0_x_limit_1_min2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_min2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd8));
assign pair_csrbank0_x_limit_1_min1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_min1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd9));
assign pair_csrbank0_x_limit_1_min0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_min0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd10));
assign pair_csrbank0_x_limit_1_max3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_x_limit_1_max3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd11));
assign pair_csrbank0_x_limit_1_max2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_max2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd12));
assign pair_csrbank0_x_limit_1_max1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_max1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd13));
assign pair_csrbank0_x_limit_1_max0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_1_max0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd14));
assign pair_csrbank0_iir_c_1_z03_r = pair_csrbank0_bus_dat_w[2:0];
assign pair_csrbank0_iir_c_1_z03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 4'd15));
assign pair_csrbank0_iir_c_1_z02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_z02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd16));
assign pair_csrbank0_iir_c_1_z01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_z01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd17));
assign pair_csrbank0_iir_c_1_z00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_z00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd18));
assign pair_csrbank0_iir_c_1_a13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_1_a13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd19));
assign pair_csrbank0_iir_c_1_a12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_a12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd20));
assign pair_csrbank0_iir_c_1_a11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_a11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd21));
assign pair_csrbank0_iir_c_1_a10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_a10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd22));
assign pair_csrbank0_iir_c_1_b03_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_1_b03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd23));
assign pair_csrbank0_iir_c_1_b02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd24));
assign pair_csrbank0_iir_c_1_b01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd25));
assign pair_csrbank0_iir_c_1_b00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd26));
assign pair_csrbank0_iir_c_1_b13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_1_b13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd27));
assign pair_csrbank0_iir_c_1_b12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd28));
assign pair_csrbank0_iir_c_1_b11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd29));
assign pair_csrbank0_iir_c_1_b10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_1_b10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd30));
assign pair_csrbank0_iir_d_1_z03_r = pair_csrbank0_bus_dat_w[2:0];
assign pair_csrbank0_iir_d_1_z03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 5'd31));
assign pair_csrbank0_iir_d_1_z02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_z02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd32));
assign pair_csrbank0_iir_d_1_z01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_z01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd33));
assign pair_csrbank0_iir_d_1_z00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_z00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd34));
assign pair_csrbank0_iir_d_1_a13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_1_a13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd35));
assign pair_csrbank0_iir_d_1_a12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd36));
assign pair_csrbank0_iir_d_1_a11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd37));
assign pair_csrbank0_iir_d_1_a10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd38));
assign pair_csrbank0_iir_d_1_a23_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_1_a23_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd39));
assign pair_csrbank0_iir_d_1_a22_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a22_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd40));
assign pair_csrbank0_iir_d_1_a21_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a21_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd41));
assign pair_csrbank0_iir_d_1_a20_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_a20_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd42));
assign pair_csrbank0_iir_d_1_b03_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_1_b03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd43));
assign pair_csrbank0_iir_d_1_b02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd44));
assign pair_csrbank0_iir_d_1_b01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd45));
assign pair_csrbank0_iir_d_1_b00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd46));
assign pair_csrbank0_iir_d_1_b13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_1_b13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd47));
assign pair_csrbank0_iir_d_1_b12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd48));
assign pair_csrbank0_iir_d_1_b11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd49));
assign pair_csrbank0_iir_d_1_b10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd50));
assign pair_csrbank0_iir_d_1_b23_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_1_b23_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd51));
assign pair_csrbank0_iir_d_1_b22_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b22_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd52));
assign pair_csrbank0_iir_d_1_b21_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b21_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd53));
assign pair_csrbank0_iir_d_1_b20_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_1_b20_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd54));
assign pair_csrbank0_y_limit_1_min3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_y_limit_1_min3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd55));
assign pair_csrbank0_y_limit_1_min2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_min2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd56));
assign pair_csrbank0_y_limit_1_min1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_min1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd57));
assign pair_csrbank0_y_limit_1_min0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_min0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd58));
assign pair_csrbank0_y_limit_1_max3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_y_limit_1_max3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd59));
assign pair_csrbank0_y_limit_1_max2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_max2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd60));
assign pair_csrbank0_y_limit_1_max1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_max1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd61));
assign pair_csrbank0_y_limit_1_max0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_1_max0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd62));
assign pair_csrbank0_x_limit_2_min3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_x_limit_2_min3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 6'd63));
assign pair_csrbank0_x_limit_2_min2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_min2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd64));
assign pair_csrbank0_x_limit_2_min1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_min1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd65));
assign pair_csrbank0_x_limit_2_min0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_min0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd66));
assign pair_csrbank0_x_limit_2_max3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_x_limit_2_max3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd67));
assign pair_csrbank0_x_limit_2_max2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_max2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd68));
assign pair_csrbank0_x_limit_2_max1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_max1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd69));
assign pair_csrbank0_x_limit_2_max0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_x_limit_2_max0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd70));
assign pair_csrbank0_iir_c_2_z03_r = pair_csrbank0_bus_dat_w[2:0];
assign pair_csrbank0_iir_c_2_z03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd71));
assign pair_csrbank0_iir_c_2_z02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_z02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd72));
assign pair_csrbank0_iir_c_2_z01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_z01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd73));
assign pair_csrbank0_iir_c_2_z00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_z00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd74));
assign pair_csrbank0_iir_c_2_a13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_2_a13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd75));
assign pair_csrbank0_iir_c_2_a12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_a12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd76));
assign pair_csrbank0_iir_c_2_a11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_a11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd77));
assign pair_csrbank0_iir_c_2_a10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_a10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd78));
assign pair_csrbank0_iir_c_2_b03_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_2_b03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd79));
assign pair_csrbank0_iir_c_2_b02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd80));
assign pair_csrbank0_iir_c_2_b01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd81));
assign pair_csrbank0_iir_c_2_b00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd82));
assign pair_csrbank0_iir_c_2_b13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_c_2_b13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd83));
assign pair_csrbank0_iir_c_2_b12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd84));
assign pair_csrbank0_iir_c_2_b11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd85));
assign pair_csrbank0_iir_c_2_b10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_c_2_b10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd86));
assign pair_csrbank0_iir_d_2_z03_r = pair_csrbank0_bus_dat_w[2:0];
assign pair_csrbank0_iir_d_2_z03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd87));
assign pair_csrbank0_iir_d_2_z02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_z02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd88));
assign pair_csrbank0_iir_d_2_z01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_z01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd89));
assign pair_csrbank0_iir_d_2_z00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_z00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd90));
assign pair_csrbank0_iir_d_2_a13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_2_a13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd91));
assign pair_csrbank0_iir_d_2_a12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd92));
assign pair_csrbank0_iir_d_2_a11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd93));
assign pair_csrbank0_iir_d_2_a10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd94));
assign pair_csrbank0_iir_d_2_a23_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_2_a23_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd95));
assign pair_csrbank0_iir_d_2_a22_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a22_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd96));
assign pair_csrbank0_iir_d_2_a21_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a21_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd97));
assign pair_csrbank0_iir_d_2_a20_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_a20_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd98));
assign pair_csrbank0_iir_d_2_b03_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_2_b03_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd99));
assign pair_csrbank0_iir_d_2_b02_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b02_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd100));
assign pair_csrbank0_iir_d_2_b01_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b01_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd101));
assign pair_csrbank0_iir_d_2_b00_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b00_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd102));
assign pair_csrbank0_iir_d_2_b13_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_2_b13_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd103));
assign pair_csrbank0_iir_d_2_b12_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b12_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd104));
assign pair_csrbank0_iir_d_2_b11_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b11_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd105));
assign pair_csrbank0_iir_d_2_b10_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b10_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd106));
assign pair_csrbank0_iir_d_2_b23_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_iir_d_2_b23_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd107));
assign pair_csrbank0_iir_d_2_b22_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b22_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd108));
assign pair_csrbank0_iir_d_2_b21_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b21_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd109));
assign pair_csrbank0_iir_d_2_b20_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_iir_d_2_b20_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd110));
assign pair_csrbank0_y_limit_2_min3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_y_limit_2_min3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd111));
assign pair_csrbank0_y_limit_2_min2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_min2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd112));
assign pair_csrbank0_y_limit_2_min1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_min1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd113));
assign pair_csrbank0_y_limit_2_min0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_min0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd114));
assign pair_csrbank0_y_limit_2_max3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_y_limit_2_max3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd115));
assign pair_csrbank0_y_limit_2_max2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_max2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd116));
assign pair_csrbank0_y_limit_2_max1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_max1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd117));
assign pair_csrbank0_y_limit_2_max0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_y_limit_2_max0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[6:0] == 7'd118));
assign pair_fastchain0_y_tap_storage = pair_fastchain0_y_tap_storage_full[1:0];
assign pair_csrbank0_y_tap0_w = pair_fastchain0_y_tap_storage_full[1:0];
assign pair_fastchain0_invert_storage = pair_fastchain0_invert_storage_full;
assign pair_csrbank0_invert0_w = pair_fastchain0_invert_storage_full;
assign pair_fastchain0_delay_storage = pair_fastchain0_delay_storage_full[31:0];
assign pair_csrbank0_demod_delay3_w = pair_fastchain0_delay_storage_full[31:24];
assign pair_csrbank0_demod_delay2_w = pair_fastchain0_delay_storage_full[23:16];
assign pair_csrbank0_demod_delay1_w = pair_fastchain0_delay_storage_full[15:8];
assign pair_csrbank0_demod_delay0_w = pair_fastchain0_delay_storage_full[7:0];
assign pair_fastchain0_multiplier_storage = pair_fastchain0_multiplier_storage_full[3:0];
assign pair_csrbank0_demod_multiplier0_w = pair_fastchain0_multiplier_storage_full[3:0];
assign pair_fastchain0_limitcsr0_min_storage = pair_fastchain0_limitcsr0_min_storage_full[24:0];
assign pair_csrbank0_x_limit_1_min3_w = pair_fastchain0_limitcsr0_min_storage_full[24];
assign pair_csrbank0_x_limit_1_min2_w = pair_fastchain0_limitcsr0_min_storage_full[23:16];
assign pair_csrbank0_x_limit_1_min1_w = pair_fastchain0_limitcsr0_min_storage_full[15:8];
assign pair_csrbank0_x_limit_1_min0_w = pair_fastchain0_limitcsr0_min_storage_full[7:0];
assign pair_fastchain0_limitcsr0_max_storage = pair_fastchain0_limitcsr0_max_storage_full[24:0];
assign pair_csrbank0_x_limit_1_max3_w = pair_fastchain0_limitcsr0_max_storage_full[24];
assign pair_csrbank0_x_limit_1_max2_w = pair_fastchain0_limitcsr0_max_storage_full[23:16];
assign pair_csrbank0_x_limit_1_max1_w = pair_fastchain0_limitcsr0_max_storage_full[15:8];
assign pair_csrbank0_x_limit_1_max0_w = pair_fastchain0_limitcsr0_max_storage_full[7:0];
assign pair_fastchain0_iir0_storage0 = pair_fastchain0_iir0_storage_full0[26:0];
assign pair_csrbank0_iir_c_1_z03_w = pair_fastchain0_iir0_storage_full0[26:24];
assign pair_csrbank0_iir_c_1_z02_w = pair_fastchain0_iir0_storage_full0[23:16];
assign pair_csrbank0_iir_c_1_z01_w = pair_fastchain0_iir0_storage_full0[15:8];
assign pair_csrbank0_iir_c_1_z00_w = pair_fastchain0_iir0_storage_full0[7:0];
assign pair_fastchain0_iir0_csrstorage0_storage0 = pair_fastchain0_iir0_csrstorage0_storage_full0[24:0];
assign pair_csrbank0_iir_c_1_a13_w = pair_fastchain0_iir0_csrstorage0_storage_full0[24];
assign pair_csrbank0_iir_c_1_a12_w = pair_fastchain0_iir0_csrstorage0_storage_full0[23:16];
assign pair_csrbank0_iir_c_1_a11_w = pair_fastchain0_iir0_csrstorage0_storage_full0[15:8];
assign pair_csrbank0_iir_c_1_a10_w = pair_fastchain0_iir0_csrstorage0_storage_full0[7:0];
assign pair_fastchain0_iir0_csrstorage1_storage0 = pair_fastchain0_iir0_csrstorage1_storage_full0[24:0];
assign pair_csrbank0_iir_c_1_b03_w = pair_fastchain0_iir0_csrstorage1_storage_full0[24];
assign pair_csrbank0_iir_c_1_b02_w = pair_fastchain0_iir0_csrstorage1_storage_full0[23:16];
assign pair_csrbank0_iir_c_1_b01_w = pair_fastchain0_iir0_csrstorage1_storage_full0[15:8];
assign pair_csrbank0_iir_c_1_b00_w = pair_fastchain0_iir0_csrstorage1_storage_full0[7:0];
assign pair_fastchain0_iir0_csrstorage2_storage0 = pair_fastchain0_iir0_csrstorage2_storage_full0[24:0];
assign pair_csrbank0_iir_c_1_b13_w = pair_fastchain0_iir0_csrstorage2_storage_full0[24];
assign pair_csrbank0_iir_c_1_b12_w = pair_fastchain0_iir0_csrstorage2_storage_full0[23:16];
assign pair_csrbank0_iir_c_1_b11_w = pair_fastchain0_iir0_csrstorage2_storage_full0[15:8];
assign pair_csrbank0_iir_c_1_b10_w = pair_fastchain0_iir0_csrstorage2_storage_full0[7:0];
assign pair_fastchain0_iir0_storage1 = pair_fastchain0_iir0_storage_full1[26:0];
assign pair_csrbank0_iir_d_1_z03_w = pair_fastchain0_iir0_storage_full1[26:24];
assign pair_csrbank0_iir_d_1_z02_w = pair_fastchain0_iir0_storage_full1[23:16];
assign pair_csrbank0_iir_d_1_z01_w = pair_fastchain0_iir0_storage_full1[15:8];
assign pair_csrbank0_iir_d_1_z00_w = pair_fastchain0_iir0_storage_full1[7:0];
assign pair_fastchain0_iir0_csrstorage0_storage1 = pair_fastchain0_iir0_csrstorage0_storage_full1[24:0];
assign pair_csrbank0_iir_d_1_a13_w = pair_fastchain0_iir0_csrstorage0_storage_full1[24];
assign pair_csrbank0_iir_d_1_a12_w = pair_fastchain0_iir0_csrstorage0_storage_full1[23:16];
assign pair_csrbank0_iir_d_1_a11_w = pair_fastchain0_iir0_csrstorage0_storage_full1[15:8];
assign pair_csrbank0_iir_d_1_a10_w = pair_fastchain0_iir0_csrstorage0_storage_full1[7:0];
assign pair_fastchain0_iir0_csrstorage1_storage1 = pair_fastchain0_iir0_csrstorage1_storage_full1[24:0];
assign pair_csrbank0_iir_d_1_a23_w = pair_fastchain0_iir0_csrstorage1_storage_full1[24];
assign pair_csrbank0_iir_d_1_a22_w = pair_fastchain0_iir0_csrstorage1_storage_full1[23:16];
assign pair_csrbank0_iir_d_1_a21_w = pair_fastchain0_iir0_csrstorage1_storage_full1[15:8];
assign pair_csrbank0_iir_d_1_a20_w = pair_fastchain0_iir0_csrstorage1_storage_full1[7:0];
assign pair_fastchain0_iir0_csrstorage2_storage1 = pair_fastchain0_iir0_csrstorage2_storage_full1[24:0];
assign pair_csrbank0_iir_d_1_b03_w = pair_fastchain0_iir0_csrstorage2_storage_full1[24];
assign pair_csrbank0_iir_d_1_b02_w = pair_fastchain0_iir0_csrstorage2_storage_full1[23:16];
assign pair_csrbank0_iir_d_1_b01_w = pair_fastchain0_iir0_csrstorage2_storage_full1[15:8];
assign pair_csrbank0_iir_d_1_b00_w = pair_fastchain0_iir0_csrstorage2_storage_full1[7:0];
assign pair_fastchain0_iir0_csrstorage3_storage = pair_fastchain0_iir0_csrstorage3_storage_full[24:0];
assign pair_csrbank0_iir_d_1_b13_w = pair_fastchain0_iir0_csrstorage3_storage_full[24];
assign pair_csrbank0_iir_d_1_b12_w = pair_fastchain0_iir0_csrstorage3_storage_full[23:16];
assign pair_csrbank0_iir_d_1_b11_w = pair_fastchain0_iir0_csrstorage3_storage_full[15:8];
assign pair_csrbank0_iir_d_1_b10_w = pair_fastchain0_iir0_csrstorage3_storage_full[7:0];
assign pair_fastchain0_iir0_csrstorage4_storage = pair_fastchain0_iir0_csrstorage4_storage_full[24:0];
assign pair_csrbank0_iir_d_1_b23_w = pair_fastchain0_iir0_csrstorage4_storage_full[24];
assign pair_csrbank0_iir_d_1_b22_w = pair_fastchain0_iir0_csrstorage4_storage_full[23:16];
assign pair_csrbank0_iir_d_1_b21_w = pair_fastchain0_iir0_csrstorage4_storage_full[15:8];
assign pair_csrbank0_iir_d_1_b20_w = pair_fastchain0_iir0_csrstorage4_storage_full[7:0];
assign pair_fastchain0_paralleltaplimitcsr0_min_storage = pair_fastchain0_paralleltaplimitcsr0_min_storage_full[24:0];
assign pair_csrbank0_y_limit_1_min3_w = pair_fastchain0_paralleltaplimitcsr0_min_storage_full[24];
assign pair_csrbank0_y_limit_1_min2_w = pair_fastchain0_paralleltaplimitcsr0_min_storage_full[23:16];
assign pair_csrbank0_y_limit_1_min1_w = pair_fastchain0_paralleltaplimitcsr0_min_storage_full[15:8];
assign pair_csrbank0_y_limit_1_min0_w = pair_fastchain0_paralleltaplimitcsr0_min_storage_full[7:0];
assign pair_fastchain0_paralleltaplimitcsr0_max_storage = pair_fastchain0_paralleltaplimitcsr0_max_storage_full[24:0];
assign pair_csrbank0_y_limit_1_max3_w = pair_fastchain0_paralleltaplimitcsr0_max_storage_full[24];
assign pair_csrbank0_y_limit_1_max2_w = pair_fastchain0_paralleltaplimitcsr0_max_storage_full[23:16];
assign pair_csrbank0_y_limit_1_max1_w = pair_fastchain0_paralleltaplimitcsr0_max_storage_full[15:8];
assign pair_csrbank0_y_limit_1_max0_w = pair_fastchain0_paralleltaplimitcsr0_max_storage_full[7:0];
assign pair_fastchain0_limitcsr1_min_storage = pair_fastchain0_limitcsr1_min_storage_full[24:0];
assign pair_csrbank0_x_limit_2_min3_w = pair_fastchain0_limitcsr1_min_storage_full[24];
assign pair_csrbank0_x_limit_2_min2_w = pair_fastchain0_limitcsr1_min_storage_full[23:16];
assign pair_csrbank0_x_limit_2_min1_w = pair_fastchain0_limitcsr1_min_storage_full[15:8];
assign pair_csrbank0_x_limit_2_min0_w = pair_fastchain0_limitcsr1_min_storage_full[7:0];
assign pair_fastchain0_limitcsr1_max_storage = pair_fastchain0_limitcsr1_max_storage_full[24:0];
assign pair_csrbank0_x_limit_2_max3_w = pair_fastchain0_limitcsr1_max_storage_full[24];
assign pair_csrbank0_x_limit_2_max2_w = pair_fastchain0_limitcsr1_max_storage_full[23:16];
assign pair_csrbank0_x_limit_2_max1_w = pair_fastchain0_limitcsr1_max_storage_full[15:8];
assign pair_csrbank0_x_limit_2_max0_w = pair_fastchain0_limitcsr1_max_storage_full[7:0];
assign pair_fastchain0_iir1_storage0 = pair_fastchain0_iir1_storage_full0[26:0];
assign pair_csrbank0_iir_c_2_z03_w = pair_fastchain0_iir1_storage_full0[26:24];
assign pair_csrbank0_iir_c_2_z02_w = pair_fastchain0_iir1_storage_full0[23:16];
assign pair_csrbank0_iir_c_2_z01_w = pair_fastchain0_iir1_storage_full0[15:8];
assign pair_csrbank0_iir_c_2_z00_w = pair_fastchain0_iir1_storage_full0[7:0];
assign pair_fastchain0_iir1_csrstorage3_storage = pair_fastchain0_iir1_csrstorage3_storage_full[24:0];
assign pair_csrbank0_iir_c_2_a13_w = pair_fastchain0_iir1_csrstorage3_storage_full[24];
assign pair_csrbank0_iir_c_2_a12_w = pair_fastchain0_iir1_csrstorage3_storage_full[23:16];
assign pair_csrbank0_iir_c_2_a11_w = pair_fastchain0_iir1_csrstorage3_storage_full[15:8];
assign pair_csrbank0_iir_c_2_a10_w = pair_fastchain0_iir1_csrstorage3_storage_full[7:0];
assign pair_fastchain0_iir1_csrstorage4_storage = pair_fastchain0_iir1_csrstorage4_storage_full[24:0];
assign pair_csrbank0_iir_c_2_b03_w = pair_fastchain0_iir1_csrstorage4_storage_full[24];
assign pair_csrbank0_iir_c_2_b02_w = pair_fastchain0_iir1_csrstorage4_storage_full[23:16];
assign pair_csrbank0_iir_c_2_b01_w = pair_fastchain0_iir1_csrstorage4_storage_full[15:8];
assign pair_csrbank0_iir_c_2_b00_w = pair_fastchain0_iir1_csrstorage4_storage_full[7:0];
assign pair_fastchain0_iir1_csrstorage5_storage0 = pair_fastchain0_iir1_csrstorage5_storage_full0[24:0];
assign pair_csrbank0_iir_c_2_b13_w = pair_fastchain0_iir1_csrstorage5_storage_full0[24];
assign pair_csrbank0_iir_c_2_b12_w = pair_fastchain0_iir1_csrstorage5_storage_full0[23:16];
assign pair_csrbank0_iir_c_2_b11_w = pair_fastchain0_iir1_csrstorage5_storage_full0[15:8];
assign pair_csrbank0_iir_c_2_b10_w = pair_fastchain0_iir1_csrstorage5_storage_full0[7:0];
assign pair_fastchain0_iir1_storage1 = pair_fastchain0_iir1_storage_full1[26:0];
assign pair_csrbank0_iir_d_2_z03_w = pair_fastchain0_iir1_storage_full1[26:24];
assign pair_csrbank0_iir_d_2_z02_w = pair_fastchain0_iir1_storage_full1[23:16];
assign pair_csrbank0_iir_d_2_z01_w = pair_fastchain0_iir1_storage_full1[15:8];
assign pair_csrbank0_iir_d_2_z00_w = pair_fastchain0_iir1_storage_full1[7:0];
assign pair_fastchain0_iir1_csrstorage5_storage1 = pair_fastchain0_iir1_csrstorage5_storage_full1[24:0];
assign pair_csrbank0_iir_d_2_a13_w = pair_fastchain0_iir1_csrstorage5_storage_full1[24];
assign pair_csrbank0_iir_d_2_a12_w = pair_fastchain0_iir1_csrstorage5_storage_full1[23:16];
assign pair_csrbank0_iir_d_2_a11_w = pair_fastchain0_iir1_csrstorage5_storage_full1[15:8];
assign pair_csrbank0_iir_d_2_a10_w = pair_fastchain0_iir1_csrstorage5_storage_full1[7:0];
assign pair_fastchain0_iir1_csrstorage6_storage = pair_fastchain0_iir1_csrstorage6_storage_full[24:0];
assign pair_csrbank0_iir_d_2_a23_w = pair_fastchain0_iir1_csrstorage6_storage_full[24];
assign pair_csrbank0_iir_d_2_a22_w = pair_fastchain0_iir1_csrstorage6_storage_full[23:16];
assign pair_csrbank0_iir_d_2_a21_w = pair_fastchain0_iir1_csrstorage6_storage_full[15:8];
assign pair_csrbank0_iir_d_2_a20_w = pair_fastchain0_iir1_csrstorage6_storage_full[7:0];
assign pair_fastchain0_iir1_csrstorage7_storage = pair_fastchain0_iir1_csrstorage7_storage_full[24:0];
assign pair_csrbank0_iir_d_2_b03_w = pair_fastchain0_iir1_csrstorage7_storage_full[24];
assign pair_csrbank0_iir_d_2_b02_w = pair_fastchain0_iir1_csrstorage7_storage_full[23:16];
assign pair_csrbank0_iir_d_2_b01_w = pair_fastchain0_iir1_csrstorage7_storage_full[15:8];
assign pair_csrbank0_iir_d_2_b00_w = pair_fastchain0_iir1_csrstorage7_storage_full[7:0];
assign pair_fastchain0_iir1_csrstorage8_storage = pair_fastchain0_iir1_csrstorage8_storage_full[24:0];
assign pair_csrbank0_iir_d_2_b13_w = pair_fastchain0_iir1_csrstorage8_storage_full[24];
assign pair_csrbank0_iir_d_2_b12_w = pair_fastchain0_iir1_csrstorage8_storage_full[23:16];
assign pair_csrbank0_iir_d_2_b11_w = pair_fastchain0_iir1_csrstorage8_storage_full[15:8];
assign pair_csrbank0_iir_d_2_b10_w = pair_fastchain0_iir1_csrstorage8_storage_full[7:0];
assign pair_fastchain0_iir1_csrstorage9_storage = pair_fastchain0_iir1_csrstorage9_storage_full[24:0];
assign pair_csrbank0_iir_d_2_b23_w = pair_fastchain0_iir1_csrstorage9_storage_full[24];
assign pair_csrbank0_iir_d_2_b22_w = pair_fastchain0_iir1_csrstorage9_storage_full[23:16];
assign pair_csrbank0_iir_d_2_b21_w = pair_fastchain0_iir1_csrstorage9_storage_full[15:8];
assign pair_csrbank0_iir_d_2_b20_w = pair_fastchain0_iir1_csrstorage9_storage_full[7:0];
assign pair_fastchain0_paralleltaplimitcsr1_min_storage = pair_fastchain0_paralleltaplimitcsr1_min_storage_full[24:0];
assign pair_csrbank0_y_limit_2_min3_w = pair_fastchain0_paralleltaplimitcsr1_min_storage_full[24];
assign pair_csrbank0_y_limit_2_min2_w = pair_fastchain0_paralleltaplimitcsr1_min_storage_full[23:16];
assign pair_csrbank0_y_limit_2_min1_w = pair_fastchain0_paralleltaplimitcsr1_min_storage_full[15:8];
assign pair_csrbank0_y_limit_2_min0_w = pair_fastchain0_paralleltaplimitcsr1_min_storage_full[7:0];
assign pair_fastchain0_paralleltaplimitcsr1_max_storage = pair_fastchain0_paralleltaplimitcsr1_max_storage_full[24:0];
assign pair_csrbank0_y_limit_2_max3_w = pair_fastchain0_paralleltaplimitcsr1_max_storage_full[24];
assign pair_csrbank0_y_limit_2_max2_w = pair_fastchain0_paralleltaplimitcsr1_max_storage_full[23:16];
assign pair_csrbank0_y_limit_2_max1_w = pair_fastchain0_paralleltaplimitcsr1_max_storage_full[15:8];
assign pair_csrbank0_y_limit_2_max0_w = pair_fastchain0_paralleltaplimitcsr1_max_storage_full[7:0];
assign pair_fastchain1_x0 = (pair_fastchain1_adc <<< 4'd11);
assign pair_fastchain1_x1 = pair_fastchain1_adc;
assign pair_fastchain1_phase = phase;
assign pair_fastchain1_pre_out_i = pair_fastchain1_earlycommontaplimitcsr023;
assign pair_fastchain1_out_i_update_en = pair_fastchain1_earlycommontaplimitcsr0_update_en;
assign pair_fastchain1_limitcsr2_x = ((pair_fastchain1_i <<< 4'd11) + pair_fastchain1_dx);
assign pair_fastchain1_iir2_x0 = pair_fastchain1_limitcsr2_limitcsr2_y;
assign pair_fastchain1_iir2_hold0 = 1'd0;
assign pair_fastchain1_iir2_clear0 = 1'd0;
assign pair_fastchain1_iir2_x1 = pair_fastchain1_iir2_y0;
assign pair_fastchain1_iir2_hold1 = 1'd0;
assign pair_fastchain1_iir2_clear1 = 1'd0;
assign pair_fastchain1_earlycommontaplimitcsr0_common_x = (pair_fastchain1_dy >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr0_common_offset = offset;
assign pair_fastchain1_earlycommontaplimitcsr03 = pair_fastchain1_y_tap_storage;
assign pair_fastchain1_earlycommontaplimitcsr04 = pair_fastchain1_invert_storage;
assign pair_fastchain1_earlycommontaplimitcsr00 = pair_fastchain1_iir2_x0;
assign pair_fastchain1_earlycommontaplimitcsr01 = pair_fastchain1_iir2_y0;
assign pair_fastchain1_earlycommontaplimitcsr02 = pair_fastchain1_iir2_y2;
assign pair_fastchain1_out_i = pair_fastchain1_earlycommontaplimitcsr0_y;
assign pair_fastchain1_limitcsr3_x = ((pair_fastchain1_q0 <<< 4'd11) + pair_fastchain1_dx);
assign pair_fastchain1_iir3_x0 = pair_fastchain1_limitcsr3_limitcsr3_y;
assign pair_fastchain1_iir3_hold0 = 1'd0;
assign pair_fastchain1_iir3_clear0 = 1'd0;
assign pair_fastchain1_iir3_x1 = pair_fastchain1_iir3_y0;
assign pair_fastchain1_iir3_hold1 = 1'd0;
assign pair_fastchain1_iir3_clear1 = 1'd0;
assign pair_fastchain1_earlycommontaplimitcsr1_common_x = (pair_fastchain1_dy >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr1_common_offset = offset;
assign pair_fastchain1_earlycommontaplimitcsr13 = pair_fastchain1_y_tap_storage;
assign pair_fastchain1_earlycommontaplimitcsr14 = pair_fastchain1_invert_storage;
assign pair_fastchain1_earlycommontaplimitcsr10 = pair_fastchain1_iir3_x0;
assign pair_fastchain1_earlycommontaplimitcsr11 = pair_fastchain1_iir3_y0;
assign pair_fastchain1_earlycommontaplimitcsr12 = pair_fastchain1_iir3_y2;
assign pair_fastchain1_out_q = pair_fastchain1_earlycommontaplimitcsr1_y;
assign pair_fastchain1_phase_value = (((pair_fastchain1_phase * pair_fastchain1_multiplier_storage) + pair_fastchain1_delay_storage) <<< 1'd1);
assign pair_fastchain1_xi = pair_fastchain1_x1;
assign pair_fastchain1_zi = pair_fastchain1_phase_value;
assign pair_fastchain1_yi = 1'd0;
assign pair_fastchain1_i = (pair_fastchain1_speculativedemodcordic1_xo >>> 1'd1);
assign pair_fastchain1_q0 = (pair_fastchain1_speculativedemodcordic1_yo >>> 1'd1);
assign pair_fastchain1_speculativedemodcordic10 = (pair_fastchain1_speculativedemodcordic1_xi <<< 2'd2);
assign pair_fastchain1_speculativedemodcordic116 = (pair_fastchain1_speculativedemodcordic1_yi <<< 2'd2);
assign pair_fastchain1_speculativedemodcordic132 = (pair_fastchain1_speculativedemodcordic1_zi <<< 2'd2);
assign pair_fastchain1_speculativedemodcordic1_xo = (pair_fastchain1_speculativedemodcordic115 >>> 2'd2);
assign pair_fastchain1_speculativedemodcordic1_yo = (pair_fastchain1_speculativedemodcordic131 >>> 2'd2);
assign pair_fastchain1_speculativedemodcordic1_zo = (pair_fastchain1_speculativedemodcordic147 >>> 2'd2);
assign pair_fastchain1_speculativedemodcordic1_new_out = 1'd1;
assign pair_fastchain1_speculativedemodcordic1_new_in = 1'd1;
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir0 = (pair_fastchain1_speculativedemodcordic132 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic10 = (pair_fastchain1_x1 <<< 2'd2);
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic11 = (-pair_fastchain1_speculativedemodcordic1_speculativedemodcordic10);
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir1 = (pair_fastchain1_speculativedemodcordic133 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir2 = (pair_fastchain1_speculativedemodcordic134 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir3 = (pair_fastchain1_speculativedemodcordic135 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir4 = (pair_fastchain1_speculativedemodcordic136 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir5 = (pair_fastchain1_speculativedemodcordic137 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir6 = (pair_fastchain1_speculativedemodcordic138 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir7 = (pair_fastchain1_speculativedemodcordic139 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir8 = (pair_fastchain1_speculativedemodcordic140 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir9 = (pair_fastchain1_speculativedemodcordic141 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir10 = (pair_fastchain1_speculativedemodcordic142 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir11 = (pair_fastchain1_speculativedemodcordic143 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir12 = (pair_fastchain1_speculativedemodcordic144 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir13 = (pair_fastchain1_speculativedemodcordic145 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir14 = (pair_fastchain1_speculativedemodcordic146 < $signed({1'd0, 1'd0}));
assign pair_fastchain1_q1 = (pair_fastchain1_zi[13] ^ pair_fastchain1_zi[14]);

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_speculativedemodcordic1_xi <= 15'sd0;
	pair_fastchain1_speculativedemodcordic1_yi <= 15'sd0;
	pair_fastchain1_speculativedemodcordic1_zi <= 15'sd0;
	if (pair_fastchain1_q1) begin
		{pair_fastchain1_speculativedemodcordic1_zi, pair_fastchain1_speculativedemodcordic1_yi, pair_fastchain1_speculativedemodcordic1_xi} <= {(pair_fastchain1_zi + $signed({1'd0, 15'd16384})), (-pair_fastchain1_yi), (-pair_fastchain1_xi)};
	end else begin
		{pair_fastchain1_speculativedemodcordic1_zi, pair_fastchain1_speculativedemodcordic1_yi, pair_fastchain1_speculativedemodcordic1_xi} <= {pair_fastchain1_zi, pair_fastchain1_yi, pair_fastchain1_xi};
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_limitcsr2_limit_x = pair_fastchain1_limitcsr2_x;

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_limitcsr2_limit_y <= 26'sd0;
	pair_fastchain1_limitcsr2_limit_railed <= 1'd0;
	if ((pair_fastchain1_limitcsr2_limit_x >= pair_fastchain1_limitcsr2_limit_max)) begin
		pair_fastchain1_limitcsr2_limit_y <= pair_fastchain1_limitcsr2_limit_max;
		pair_fastchain1_limitcsr2_limit_railed <= 1'd1;
	end else begin
		if ((pair_fastchain1_limitcsr2_limit_x <= pair_fastchain1_limitcsr2_limit_min)) begin
			pair_fastchain1_limitcsr2_limit_y <= pair_fastchain1_limitcsr2_limit_min;
			pair_fastchain1_limitcsr2_limit_railed <= 1'd1;
		end else begin
			pair_fastchain1_limitcsr2_limit_y <= pair_fastchain1_limitcsr2_limit_x;
			pair_fastchain1_limitcsr2_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir2_railed0 = (~((pair_fastchain1_iir2_y_next0[49:47] == $signed({1'd0, pair_fastchain1_iir2_y_pat0})) | (pair_fastchain1_iir2_y_next0[49:47] == $signed({1'd0, (~pair_fastchain1_iir2_y_pat0)}))));

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_iir2_y_lim0 <= 25'sd0;
	if (pair_fastchain1_iir2_railed0) begin
		pair_fastchain1_iir2_y_lim0 <= pair_fastchain1_iir2_y0;
	end else begin
		pair_fastchain1_iir2_y_lim0 <= pair_fastchain1_iir2_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir2_zr_zlo0 = pair_fastchain1_iir2_zr0[47:0];
assign pair_fastchain1_iir2_zr_ztop0 = pair_fastchain1_iir2_zr0[49:48];
assign pair_fastchain1_iir2_zr1 = (((~pair_fastchain1_iir2_zr_zlo0[47]) & (~pair_fastchain1_iir2_b10[24])) & pair_fastchain1_iir2_zr_low0[47]);
assign pair_fastchain1_iir2_zr2 = ((pair_fastchain1_iir2_zr_zlo0[47] & pair_fastchain1_iir2_b10[24]) & (~pair_fastchain1_iir2_zr_low0[47]));
assign pair_fastchain1_iir2_zr_correction0 = (((pair_fastchain1_iir2_zr_ztop0 + pair_fastchain1_iir2_zr_zlo0[47]) + $signed({1'd0, pair_fastchain1_iir2_zr1})) - $signed({1'd0, pair_fastchain1_iir2_zr2}));
assign pair_fastchain1_iir2_zr_top0 = (pair_fastchain1_iir2_zr_high_q0[32:31] + pair_fastchain1_iir2_zr_correction_q0);
assign pair_fastchain1_iir2_zr_result0 = {pair_fastchain1_iir2_zr_top0, pair_fastchain1_iir2_zr_high_q0[30:0], pair_fastchain1_iir2_zr_low_q0};
assign pair_fastchain1_iir2_zr_zlo1 = pair_fastchain1_iir2_zr_result0[47:0];
assign pair_fastchain1_iir2_zr_ztop1 = pair_fastchain1_iir2_zr_result0[49:48];
assign pair_fastchain1_iir2_zr3 = (((~pair_fastchain1_iir2_zr_zlo1[47]) & (~pair_fastchain1_iir2_b00[24])) & pair_fastchain1_iir2_zr_low1[47]);
assign pair_fastchain1_iir2_zr4 = ((pair_fastchain1_iir2_zr_zlo1[47] & pair_fastchain1_iir2_b00[24]) & (~pair_fastchain1_iir2_zr_low1[47]));
assign pair_fastchain1_iir2_zr_correction1 = (((pair_fastchain1_iir2_zr_ztop1 + pair_fastchain1_iir2_zr_zlo1[47]) + $signed({1'd0, pair_fastchain1_iir2_zr3})) - $signed({1'd0, pair_fastchain1_iir2_zr4}));
assign pair_fastchain1_iir2_zr_top1 = (pair_fastchain1_iir2_zr_high_q1[32:31] + pair_fastchain1_iir2_zr_correction_q1);
assign pair_fastchain1_iir2_zr_result1 = {pair_fastchain1_iir2_zr_top1, pair_fastchain1_iir2_zr_high_q1[30:0], pair_fastchain1_iir2_zr_low_q1};
assign pair_fastchain1_iir2_z_xlo0 = {1'd0, pair_fastchain1_iir2_a10[16:0]};
assign pair_fastchain1_iir2_z_xhi0 = pair_fastchain1_iir2_a10[24:17];
assign pair_fastchain1_iir2_z_zlo0 = pair_fastchain1_iir2_zr_result1[47:0];
assign pair_fastchain1_iir2_z_ztop0 = pair_fastchain1_iir2_zr_result1[49:48];
assign pair_fastchain1_iir2_z_low0 = ((pair_fastchain1_iir2_y1 * pair_fastchain1_iir2_z_xlo0) + pair_fastchain1_iir2_z_zlo0);
assign pair_fastchain1_iir2_z_high0 = ((pair_fastchain1_iir2_y1 * pair_fastchain1_iir2_z_xhi0) + (pair_fastchain1_iir2_z_low0 >>> 5'd17));
assign pair_fastchain1_iir2_z_carry0 = ((pair_fastchain1_iir2_z_zlo0[47] & pair_fastchain1_iir2_z_low0[47]) | ((~pair_fastchain1_iir2_y1[24]) & (pair_fastchain1_iir2_z_zlo0[47] | pair_fastchain1_iir2_z_low0[47])));
assign pair_fastchain1_iir2_z_correction0 = (pair_fastchain1_iir2_z_ztop0 + $signed({1'd0, pair_fastchain1_iir2_z_carry0}));
assign pair_fastchain1_iir2_z_top0 = (pair_fastchain1_iir2_z_high0[32:31] + pair_fastchain1_iir2_z_correction0);
assign pair_fastchain1_iir2_z_result0 = {pair_fastchain1_iir2_z_top0, pair_fastchain1_iir2_z_high0[30:0], pair_fastchain1_iir2_z_low0[16:0]};
assign pair_fastchain1_iir2_y_next0 = pair_fastchain1_iir2_z_result0;
assign pair_fastchain1_iir2_railed1 = (~((pair_fastchain1_iir2_y_next1[49:47] == $signed({1'd0, pair_fastchain1_iir2_y_pat1})) | (pair_fastchain1_iir2_y_next1[49:47] == $signed({1'd0, (~pair_fastchain1_iir2_y_pat1)}))));

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_iir2_y_lim1 <= 25'sd0;
	if (pair_fastchain1_iir2_railed1) begin
		pair_fastchain1_iir2_y_lim1 <= pair_fastchain1_iir2_y2;
	end else begin
		pair_fastchain1_iir2_y_lim1 <= pair_fastchain1_iir2_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir2_zr_zlo2 = pair_fastchain1_iir2_zr5[47:0];
assign pair_fastchain1_iir2_zr_ztop2 = pair_fastchain1_iir2_zr5[49:48];
assign pair_fastchain1_iir2_zr6 = (((~pair_fastchain1_iir2_zr_zlo2[47]) & (~pair_fastchain1_iir2_b2[24])) & pair_fastchain1_iir2_zr_low2[47]);
assign pair_fastchain1_iir2_zr7 = ((pair_fastchain1_iir2_zr_zlo2[47] & pair_fastchain1_iir2_b2[24]) & (~pair_fastchain1_iir2_zr_low2[47]));
assign pair_fastchain1_iir2_zr_correction2 = (((pair_fastchain1_iir2_zr_ztop2 + pair_fastchain1_iir2_zr_zlo2[47]) + $signed({1'd0, pair_fastchain1_iir2_zr6})) - $signed({1'd0, pair_fastchain1_iir2_zr7}));
assign pair_fastchain1_iir2_zr_top2 = (pair_fastchain1_iir2_zr_high_q2[32:31] + pair_fastchain1_iir2_zr_correction_q2);
assign pair_fastchain1_iir2_zr_result2 = {pair_fastchain1_iir2_zr_top2, pair_fastchain1_iir2_zr_high_q2[30:0], pair_fastchain1_iir2_zr_low_q2};
assign pair_fastchain1_iir2_zr_zlo3 = pair_fastchain1_iir2_zr_result2[47:0];
assign pair_fastchain1_iir2_zr_ztop3 = pair_fastchain1_iir2_zr_result2[49:48];
assign pair_fastchain1_iir2_zr8 = (((~pair_fastchain1_iir2_zr_zlo3[47]) & (~pair_fastchain1_iir2_b11[24])) & pair_fastchain1_iir2_zr_low3[47]);
assign pair_fastchain1_iir2_zr9 = ((pair_fastchain1_iir2_zr_zlo3[47] & pair_fastchain1_iir2_b11[24]) & (~pair_fastchain1_iir2_zr_low3[47]));
assign pair_fastchain1_iir2_zr_correction3 = (((pair_fastchain1_iir2_zr_ztop3 + pair_fastchain1_iir2_zr_zlo3[47]) + $signed({1'd0, pair_fastchain1_iir2_zr8})) - $signed({1'd0, pair_fastchain1_iir2_zr9}));
assign pair_fastchain1_iir2_zr_top3 = (pair_fastchain1_iir2_zr_high_q3[32:31] + pair_fastchain1_iir2_zr_correction_q3);
assign pair_fastchain1_iir2_zr_result3 = {pair_fastchain1_iir2_zr_top3, pair_fastchain1_iir2_zr_high_q3[30:0], pair_fastchain1_iir2_zr_low_q3};
assign pair_fastchain1_iir2_zr_zlo4 = pair_fastchain1_iir2_zr_result3[47:0];
assign pair_fastchain1_iir2_zr_ztop4 = pair_fastchain1_iir2_zr_result3[49:48];
assign pair_fastchain1_iir2_zr10 = (((~pair_fastchain1_iir2_zr_zlo4[47]) & (~pair_fastchain1_iir2_b01[24])) & pair_fastchain1_iir2_zr_low4[47]);
assign pair_fastchain1_iir2_zr11 = ((pair_fastchain1_iir2_zr_zlo4[47] & pair_fastchain1_iir2_b01[24]) & (~pair_fastchain1_iir2_zr_low4[47]));
assign pair_fastchain1_iir2_zr_correction4 = (((pair_fastchain1_iir2_zr_ztop4 + pair_fastchain1_iir2_zr_zlo4[47]) + $signed({1'd0, pair_fastchain1_iir2_zr10})) - $signed({1'd0, pair_fastchain1_iir2_zr11}));
assign pair_fastchain1_iir2_zr_top4 = (pair_fastchain1_iir2_zr_high_q4[32:31] + pair_fastchain1_iir2_zr_correction_q4);
assign pair_fastchain1_iir2_zr_result4 = {pair_fastchain1_iir2_zr_top4, pair_fastchain1_iir2_zr_high_q4[30:0], pair_fastchain1_iir2_zr_low_q4};
assign pair_fastchain1_iir2_zr_zlo5 = pair_fastchain1_iir2_zr_result4[47:0];
assign pair_fastchain1_iir2_zr_ztop5 = pair_fastchain1_iir2_zr_result4[49:48];
assign pair_fastchain1_iir2_zr12 = (((~pair_fastchain1_iir2_zr_zlo5[47]) & (~pair_fastchain1_iir2_a2[24])) & pair_fastchain1_iir2_zr_low5[47]);
assign pair_fastchain1_iir2_zr13 = ((pair_fastchain1_iir2_zr_zlo5[47] & pair_fastchain1_iir2_a2[24]) & (~pair_fastchain1_iir2_zr_low5[47]));
assign pair_fastchain1_iir2_zr_correction5 = (((pair_fastchain1_iir2_zr_ztop5 + pair_fastchain1_iir2_zr_zlo5[47]) + $signed({1'd0, pair_fastchain1_iir2_zr12})) - $signed({1'd0, pair_fastchain1_iir2_zr13}));
assign pair_fastchain1_iir2_zr_top5 = (pair_fastchain1_iir2_zr_high_q5[32:31] + pair_fastchain1_iir2_zr_correction_q5);
assign pair_fastchain1_iir2_zr_result5 = {pair_fastchain1_iir2_zr_top5, pair_fastchain1_iir2_zr_high_q5[30:0], pair_fastchain1_iir2_zr_low_q5};
assign pair_fastchain1_iir2_z_xlo1 = {1'd0, pair_fastchain1_iir2_a11[16:0]};
assign pair_fastchain1_iir2_z_xhi1 = pair_fastchain1_iir2_a11[24:17];
assign pair_fastchain1_iir2_z_zlo1 = pair_fastchain1_iir2_zr_result5[47:0];
assign pair_fastchain1_iir2_z_ztop1 = pair_fastchain1_iir2_zr_result5[49:48];
assign pair_fastchain1_iir2_z_low1 = ((pair_fastchain1_iir2_y3 * pair_fastchain1_iir2_z_xlo1) + pair_fastchain1_iir2_z_zlo1);
assign pair_fastchain1_iir2_z_high1 = ((pair_fastchain1_iir2_y3 * pair_fastchain1_iir2_z_xhi1) + (pair_fastchain1_iir2_z_low1 >>> 5'd17));
assign pair_fastchain1_iir2_z_carry1 = ((pair_fastchain1_iir2_z_zlo1[47] & pair_fastchain1_iir2_z_low1[47]) | ((~pair_fastchain1_iir2_y3[24]) & (pair_fastchain1_iir2_z_zlo1[47] | pair_fastchain1_iir2_z_low1[47])));
assign pair_fastchain1_iir2_z_correction1 = (pair_fastchain1_iir2_z_ztop1 + $signed({1'd0, pair_fastchain1_iir2_z_carry1}));
assign pair_fastchain1_iir2_z_top1 = (pair_fastchain1_iir2_z_high1[32:31] + pair_fastchain1_iir2_z_correction1);
assign pair_fastchain1_iir2_z_result1 = {pair_fastchain1_iir2_z_top1, pair_fastchain1_iir2_z_high1[30:0], pair_fastchain1_iir2_z_low1[16:0]};
assign pair_fastchain1_iir2_y_next1 = pair_fastchain1_iir2_z_result1;
assign pair_fastchain1_earlycommontaplimitcsr09 = (pair_fastchain1_earlycommontaplimitcsr0_update_en ? $signed({1'd0, pair_fastchain1_earlycommontaplimitcsr0_min_storage}) : pair_fastchain1_earlycommontaplimitcsr05[24:0]);
assign pair_fastchain1_earlycommontaplimitcsr010 = (pair_fastchain1_earlycommontaplimitcsr0_update_en ? $signed({1'd0, pair_fastchain1_earlycommontaplimitcsr0_max_storage}) : pair_fastchain1_earlycommontaplimitcsr06[24:0]);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr00 = (pair_fastchain1_earlycommontaplimitcsr09 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr01 = pair_fastchain1_earlycommontaplimitcsr0_common_x;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr02 = pair_fastchain1_earlycommontaplimitcsr0_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr03 = pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr00;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr04 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr01);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr05 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr02);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr06 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr03 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr04) ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr05);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr07 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr04) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr05)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr04 & pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr05)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr08 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr06 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr07) ^ 16'd2);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr09 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr06 & pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr07) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr06 & 16'd2)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr07 & 16'd2)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_high = (pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr08 + pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr09);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_low = pair_fastchain1_earlycommontaplimitcsr09[10:0];
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr00 = (pair_fastchain1_earlycommontaplimitcsr010 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr01 = pair_fastchain1_earlycommontaplimitcsr0_common_x;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr02 = pair_fastchain1_earlycommontaplimitcsr0_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr03 = pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr00;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr04 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr01);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr05 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr02);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr06 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr03 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr04) ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr05);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr07 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr04) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr05)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr04 & pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr05)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr08 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr06 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr07) ^ 16'd2);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr09 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr06 & pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr07) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr06 & 16'd2)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr07 & 16'd2)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_high = (pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr08 + pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr09);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_low = pair_fastchain1_earlycommontaplimitcsr010[10:0];
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr00 = (pair_fastchain1_earlycommontaplimitcsr010 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr01 = pair_fastchain1_earlycommontaplimitcsr0_common_x;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr02 = pair_fastchain1_earlycommontaplimitcsr0_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr03 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr00);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr04 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr01);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr05 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr02);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr06 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr03 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr04) ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr05);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr07 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr04) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr05)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr04 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr05)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr08 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr06 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr07) ^ {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr010[10:0] == $signed({1'd0, 1'd0}))});
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr09 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr06 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr07) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr06 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr010[10:0] == $signed({1'd0, 1'd0}))})) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr07 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr010[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_high = (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr08 + pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr09);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_low = (-pair_fastchain1_earlycommontaplimitcsr010[10:0]);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr00 = (pair_fastchain1_earlycommontaplimitcsr09 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr01 = pair_fastchain1_earlycommontaplimitcsr0_common_x;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr02 = pair_fastchain1_earlycommontaplimitcsr0_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr03 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr00);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr04 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr01);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr05 = (~pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr02);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr06 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr03 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr04) ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr05);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr07 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr04) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr03 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr05)) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr04 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr05)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr08 = ((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr06 ^ pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr07) ^ {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr09[10:0] == $signed({1'd0, 1'd0}))});
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr09 = ((((pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr06 & pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr07) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr06 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr09[10:0] == $signed({1'd0, 1'd0}))})) | (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr07 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr09[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_high = (pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr08 + pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr09);
assign pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_low = (-pair_fastchain1_earlycommontaplimitcsr09[10:0]);
assign pair_fastchain1_earlycommontaplimitcsr0_total0 = (pair_fastchain1_earlycommontaplimitcsr00 + (pair_fastchain1_earlycommontaplimitcsr0_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr011 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr013 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr00 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr011 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr013 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr00 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr011 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr013 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr011 <= pair_fastchain1_earlycommontaplimitcsr0_total0;
			pair_fastchain1_earlycommontaplimitcsr013 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr012 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr014 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr00 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr012 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr014 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr00 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr012 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr014 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr012 <= (-pair_fastchain1_earlycommontaplimitcsr0_total0);
			pair_fastchain1_earlycommontaplimitcsr014 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr0_total1 = (pair_fastchain1_earlycommontaplimitcsr01 + (pair_fastchain1_earlycommontaplimitcsr0_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr015 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr017 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr01 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr015 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr017 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr01 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr015 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr017 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr015 <= pair_fastchain1_earlycommontaplimitcsr0_total1;
			pair_fastchain1_earlycommontaplimitcsr017 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr016 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr018 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr01 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr016 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr018 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr01 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr016 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr018 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr016 <= (-pair_fastchain1_earlycommontaplimitcsr0_total1);
			pair_fastchain1_earlycommontaplimitcsr018 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr0_total2 = (pair_fastchain1_earlycommontaplimitcsr02 + (pair_fastchain1_earlycommontaplimitcsr0_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr019 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr021 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr02 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr019 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr021 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr02 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr019 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr021 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr019 <= pair_fastchain1_earlycommontaplimitcsr0_total2;
			pair_fastchain1_earlycommontaplimitcsr021 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_28;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr020 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr022 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr02 <= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result)) begin
		pair_fastchain1_earlycommontaplimitcsr020 <= pair_fastchain1_earlycommontaplimitcsr06;
		pair_fastchain1_earlycommontaplimitcsr022 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr02 >= pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result)) begin
			pair_fastchain1_earlycommontaplimitcsr020 <= pair_fastchain1_earlycommontaplimitcsr05;
			pair_fastchain1_earlycommontaplimitcsr022 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr020 <= (-pair_fastchain1_earlycommontaplimitcsr0_total2);
			pair_fastchain1_earlycommontaplimitcsr022 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_28 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr023 = (pair_fastchain1_earlycommontaplimitcsr04 ? array_muxed8 : array_muxed9);
assign pair_fastchain1_earlycommontaplimitcsr024 = (pair_fastchain1_earlycommontaplimitcsr04 ? array_muxed10 : array_muxed11);
assign pair_fastchain1_limitcsr3_limit_x = pair_fastchain1_limitcsr3_x;

// synthesis translate_off
reg dummy_d_29;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_limitcsr3_limit_y <= 26'sd0;
	pair_fastchain1_limitcsr3_limit_railed <= 1'd0;
	if ((pair_fastchain1_limitcsr3_limit_x >= pair_fastchain1_limitcsr3_limit_max)) begin
		pair_fastchain1_limitcsr3_limit_y <= pair_fastchain1_limitcsr3_limit_max;
		pair_fastchain1_limitcsr3_limit_railed <= 1'd1;
	end else begin
		if ((pair_fastchain1_limitcsr3_limit_x <= pair_fastchain1_limitcsr3_limit_min)) begin
			pair_fastchain1_limitcsr3_limit_y <= pair_fastchain1_limitcsr3_limit_min;
			pair_fastchain1_limitcsr3_limit_railed <= 1'd1;
		end else begin
			pair_fastchain1_limitcsr3_limit_y <= pair_fastchain1_limitcsr3_limit_x;
			pair_fastchain1_limitcsr3_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_29 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir3_railed0 = (~((pair_fastchain1_iir3_y_next0[49:47] == $signed({1'd0, pair_fastchain1_iir3_y_pat0})) | (pair_fastchain1_iir3_y_next0[49:47] == $signed({1'd0, (~pair_fastchain1_iir3_y_pat0)}))));

// synthesis translate_off
reg dummy_d_30;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_iir3_y_lim0 <= 25'sd0;
	if (pair_fastchain1_iir3_railed0) begin
		pair_fastchain1_iir3_y_lim0 <= pair_fastchain1_iir3_y0;
	end else begin
		pair_fastchain1_iir3_y_lim0 <= pair_fastchain1_iir3_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_30 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir3_zr_zlo0 = pair_fastchain1_iir3_zr0[47:0];
assign pair_fastchain1_iir3_zr_ztop0 = pair_fastchain1_iir3_zr0[49:48];
assign pair_fastchain1_iir3_zr1 = (((~pair_fastchain1_iir3_zr_zlo0[47]) & (~pair_fastchain1_iir3_b10[24])) & pair_fastchain1_iir3_zr_low0[47]);
assign pair_fastchain1_iir3_zr2 = ((pair_fastchain1_iir3_zr_zlo0[47] & pair_fastchain1_iir3_b10[24]) & (~pair_fastchain1_iir3_zr_low0[47]));
assign pair_fastchain1_iir3_zr_correction0 = (((pair_fastchain1_iir3_zr_ztop0 + pair_fastchain1_iir3_zr_zlo0[47]) + $signed({1'd0, pair_fastchain1_iir3_zr1})) - $signed({1'd0, pair_fastchain1_iir3_zr2}));
assign pair_fastchain1_iir3_zr_top0 = (pair_fastchain1_iir3_zr_high_q0[32:31] + pair_fastchain1_iir3_zr_correction_q0);
assign pair_fastchain1_iir3_zr_result0 = {pair_fastchain1_iir3_zr_top0, pair_fastchain1_iir3_zr_high_q0[30:0], pair_fastchain1_iir3_zr_low_q0};
assign pair_fastchain1_iir3_zr_zlo1 = pair_fastchain1_iir3_zr_result0[47:0];
assign pair_fastchain1_iir3_zr_ztop1 = pair_fastchain1_iir3_zr_result0[49:48];
assign pair_fastchain1_iir3_zr3 = (((~pair_fastchain1_iir3_zr_zlo1[47]) & (~pair_fastchain1_iir3_b00[24])) & pair_fastchain1_iir3_zr_low1[47]);
assign pair_fastchain1_iir3_zr4 = ((pair_fastchain1_iir3_zr_zlo1[47] & pair_fastchain1_iir3_b00[24]) & (~pair_fastchain1_iir3_zr_low1[47]));
assign pair_fastchain1_iir3_zr_correction1 = (((pair_fastchain1_iir3_zr_ztop1 + pair_fastchain1_iir3_zr_zlo1[47]) + $signed({1'd0, pair_fastchain1_iir3_zr3})) - $signed({1'd0, pair_fastchain1_iir3_zr4}));
assign pair_fastchain1_iir3_zr_top1 = (pair_fastchain1_iir3_zr_high_q1[32:31] + pair_fastchain1_iir3_zr_correction_q1);
assign pair_fastchain1_iir3_zr_result1 = {pair_fastchain1_iir3_zr_top1, pair_fastchain1_iir3_zr_high_q1[30:0], pair_fastchain1_iir3_zr_low_q1};
assign pair_fastchain1_iir3_z_xlo0 = {1'd0, pair_fastchain1_iir3_a10[16:0]};
assign pair_fastchain1_iir3_z_xhi0 = pair_fastchain1_iir3_a10[24:17];
assign pair_fastchain1_iir3_z_zlo0 = pair_fastchain1_iir3_zr_result1[47:0];
assign pair_fastchain1_iir3_z_ztop0 = pair_fastchain1_iir3_zr_result1[49:48];
assign pair_fastchain1_iir3_z_low0 = ((pair_fastchain1_iir3_y1 * pair_fastchain1_iir3_z_xlo0) + pair_fastchain1_iir3_z_zlo0);
assign pair_fastchain1_iir3_z_high0 = ((pair_fastchain1_iir3_y1 * pair_fastchain1_iir3_z_xhi0) + (pair_fastchain1_iir3_z_low0 >>> 5'd17));
assign pair_fastchain1_iir3_z_carry0 = ((pair_fastchain1_iir3_z_zlo0[47] & pair_fastchain1_iir3_z_low0[47]) | ((~pair_fastchain1_iir3_y1[24]) & (pair_fastchain1_iir3_z_zlo0[47] | pair_fastchain1_iir3_z_low0[47])));
assign pair_fastchain1_iir3_z_correction0 = (pair_fastchain1_iir3_z_ztop0 + $signed({1'd0, pair_fastchain1_iir3_z_carry0}));
assign pair_fastchain1_iir3_z_top0 = (pair_fastchain1_iir3_z_high0[32:31] + pair_fastchain1_iir3_z_correction0);
assign pair_fastchain1_iir3_z_result0 = {pair_fastchain1_iir3_z_top0, pair_fastchain1_iir3_z_high0[30:0], pair_fastchain1_iir3_z_low0[16:0]};
assign pair_fastchain1_iir3_y_next0 = pair_fastchain1_iir3_z_result0;
assign pair_fastchain1_iir3_railed1 = (~((pair_fastchain1_iir3_y_next1[49:47] == $signed({1'd0, pair_fastchain1_iir3_y_pat1})) | (pair_fastchain1_iir3_y_next1[49:47] == $signed({1'd0, (~pair_fastchain1_iir3_y_pat1)}))));

// synthesis translate_off
reg dummy_d_31;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_iir3_y_lim1 <= 25'sd0;
	if (pair_fastchain1_iir3_railed1) begin
		pair_fastchain1_iir3_y_lim1 <= pair_fastchain1_iir3_y2;
	end else begin
		pair_fastchain1_iir3_y_lim1 <= pair_fastchain1_iir3_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_31 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_iir3_zr_zlo2 = pair_fastchain1_iir3_zr5[47:0];
assign pair_fastchain1_iir3_zr_ztop2 = pair_fastchain1_iir3_zr5[49:48];
assign pair_fastchain1_iir3_zr6 = (((~pair_fastchain1_iir3_zr_zlo2[47]) & (~pair_fastchain1_iir3_b2[24])) & pair_fastchain1_iir3_zr_low2[47]);
assign pair_fastchain1_iir3_zr7 = ((pair_fastchain1_iir3_zr_zlo2[47] & pair_fastchain1_iir3_b2[24]) & (~pair_fastchain1_iir3_zr_low2[47]));
assign pair_fastchain1_iir3_zr_correction2 = (((pair_fastchain1_iir3_zr_ztop2 + pair_fastchain1_iir3_zr_zlo2[47]) + $signed({1'd0, pair_fastchain1_iir3_zr6})) - $signed({1'd0, pair_fastchain1_iir3_zr7}));
assign pair_fastchain1_iir3_zr_top2 = (pair_fastchain1_iir3_zr_high_q2[32:31] + pair_fastchain1_iir3_zr_correction_q2);
assign pair_fastchain1_iir3_zr_result2 = {pair_fastchain1_iir3_zr_top2, pair_fastchain1_iir3_zr_high_q2[30:0], pair_fastchain1_iir3_zr_low_q2};
assign pair_fastchain1_iir3_zr_zlo3 = pair_fastchain1_iir3_zr_result2[47:0];
assign pair_fastchain1_iir3_zr_ztop3 = pair_fastchain1_iir3_zr_result2[49:48];
assign pair_fastchain1_iir3_zr8 = (((~pair_fastchain1_iir3_zr_zlo3[47]) & (~pair_fastchain1_iir3_b11[24])) & pair_fastchain1_iir3_zr_low3[47]);
assign pair_fastchain1_iir3_zr9 = ((pair_fastchain1_iir3_zr_zlo3[47] & pair_fastchain1_iir3_b11[24]) & (~pair_fastchain1_iir3_zr_low3[47]));
assign pair_fastchain1_iir3_zr_correction3 = (((pair_fastchain1_iir3_zr_ztop3 + pair_fastchain1_iir3_zr_zlo3[47]) + $signed({1'd0, pair_fastchain1_iir3_zr8})) - $signed({1'd0, pair_fastchain1_iir3_zr9}));
assign pair_fastchain1_iir3_zr_top3 = (pair_fastchain1_iir3_zr_high_q3[32:31] + pair_fastchain1_iir3_zr_correction_q3);
assign pair_fastchain1_iir3_zr_result3 = {pair_fastchain1_iir3_zr_top3, pair_fastchain1_iir3_zr_high_q3[30:0], pair_fastchain1_iir3_zr_low_q3};
assign pair_fastchain1_iir3_zr_zlo4 = pair_fastchain1_iir3_zr_result3[47:0];
assign pair_fastchain1_iir3_zr_ztop4 = pair_fastchain1_iir3_zr_result3[49:48];
assign pair_fastchain1_iir3_zr10 = (((~pair_fastchain1_iir3_zr_zlo4[47]) & (~pair_fastchain1_iir3_b01[24])) & pair_fastchain1_iir3_zr_low4[47]);
assign pair_fastchain1_iir3_zr11 = ((pair_fastchain1_iir3_zr_zlo4[47] & pair_fastchain1_iir3_b01[24]) & (~pair_fastchain1_iir3_zr_low4[47]));
assign pair_fastchain1_iir3_zr_correction4 = (((pair_fastchain1_iir3_zr_ztop4 + pair_fastchain1_iir3_zr_zlo4[47]) + $signed({1'd0, pair_fastchain1_iir3_zr10})) - $signed({1'd0, pair_fastchain1_iir3_zr11}));
assign pair_fastchain1_iir3_zr_top4 = (pair_fastchain1_iir3_zr_high_q4[32:31] + pair_fastchain1_iir3_zr_correction_q4);
assign pair_fastchain1_iir3_zr_result4 = {pair_fastchain1_iir3_zr_top4, pair_fastchain1_iir3_zr_high_q4[30:0], pair_fastchain1_iir3_zr_low_q4};
assign pair_fastchain1_iir3_zr_zlo5 = pair_fastchain1_iir3_zr_result4[47:0];
assign pair_fastchain1_iir3_zr_ztop5 = pair_fastchain1_iir3_zr_result4[49:48];
assign pair_fastchain1_iir3_zr12 = (((~pair_fastchain1_iir3_zr_zlo5[47]) & (~pair_fastchain1_iir3_a2[24])) & pair_fastchain1_iir3_zr_low5[47]);
assign pair_fastchain1_iir3_zr13 = ((pair_fastchain1_iir3_zr_zlo5[47] & pair_fastchain1_iir3_a2[24]) & (~pair_fastchain1_iir3_zr_low5[47]));
assign pair_fastchain1_iir3_zr_correction5 = (((pair_fastchain1_iir3_zr_ztop5 + pair_fastchain1_iir3_zr_zlo5[47]) + $signed({1'd0, pair_fastchain1_iir3_zr12})) - $signed({1'd0, pair_fastchain1_iir3_zr13}));
assign pair_fastchain1_iir3_zr_top5 = (pair_fastchain1_iir3_zr_high_q5[32:31] + pair_fastchain1_iir3_zr_correction_q5);
assign pair_fastchain1_iir3_zr_result5 = {pair_fastchain1_iir3_zr_top5, pair_fastchain1_iir3_zr_high_q5[30:0], pair_fastchain1_iir3_zr_low_q5};
assign pair_fastchain1_iir3_z_xlo1 = {1'd0, pair_fastchain1_iir3_a11[16:0]};
assign pair_fastchain1_iir3_z_xhi1 = pair_fastchain1_iir3_a11[24:17];
assign pair_fastchain1_iir3_z_zlo1 = pair_fastchain1_iir3_zr_result5[47:0];
assign pair_fastchain1_iir3_z_ztop1 = pair_fastchain1_iir3_zr_result5[49:48];
assign pair_fastchain1_iir3_z_low1 = ((pair_fastchain1_iir3_y3 * pair_fastchain1_iir3_z_xlo1) + pair_fastchain1_iir3_z_zlo1);
assign pair_fastchain1_iir3_z_high1 = ((pair_fastchain1_iir3_y3 * pair_fastchain1_iir3_z_xhi1) + (pair_fastchain1_iir3_z_low1 >>> 5'd17));
assign pair_fastchain1_iir3_z_carry1 = ((pair_fastchain1_iir3_z_zlo1[47] & pair_fastchain1_iir3_z_low1[47]) | ((~pair_fastchain1_iir3_y3[24]) & (pair_fastchain1_iir3_z_zlo1[47] | pair_fastchain1_iir3_z_low1[47])));
assign pair_fastchain1_iir3_z_correction1 = (pair_fastchain1_iir3_z_ztop1 + $signed({1'd0, pair_fastchain1_iir3_z_carry1}));
assign pair_fastchain1_iir3_z_top1 = (pair_fastchain1_iir3_z_high1[32:31] + pair_fastchain1_iir3_z_correction1);
assign pair_fastchain1_iir3_z_result1 = {pair_fastchain1_iir3_z_top1, pair_fastchain1_iir3_z_high1[30:0], pair_fastchain1_iir3_z_low1[16:0]};
assign pair_fastchain1_iir3_y_next1 = pair_fastchain1_iir3_z_result1;
assign pair_fastchain1_earlycommontaplimitcsr19 = (pair_fastchain1_earlycommontaplimitcsr1_update_en ? $signed({1'd0, pair_fastchain1_earlycommontaplimitcsr1_min_storage}) : pair_fastchain1_earlycommontaplimitcsr15[24:0]);
assign pair_fastchain1_earlycommontaplimitcsr110 = (pair_fastchain1_earlycommontaplimitcsr1_update_en ? $signed({1'd0, pair_fastchain1_earlycommontaplimitcsr1_max_storage}) : pair_fastchain1_earlycommontaplimitcsr16[24:0]);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr10 = (pair_fastchain1_earlycommontaplimitcsr19 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr11 = pair_fastchain1_earlycommontaplimitcsr1_common_x;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr12 = pair_fastchain1_earlycommontaplimitcsr1_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr13 = pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr10;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr14 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr15 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr12);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr16 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr13 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr14) ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr15);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr17 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr14) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr15)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr14 & pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr15)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr18 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr16 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr17) ^ 16'd2);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr19 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr16 & pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr17) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr16 & 16'd2)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr17 & 16'd2)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_high = (pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr18 + pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr19);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_low = pair_fastchain1_earlycommontaplimitcsr19[10:0];
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr10 = (pair_fastchain1_earlycommontaplimitcsr110 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr11 = pair_fastchain1_earlycommontaplimitcsr1_common_x;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr12 = pair_fastchain1_earlycommontaplimitcsr1_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr13 = pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr10;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr14 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr15 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr12);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr16 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr13 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr14) ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr15);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr17 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr14) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr15)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr14 & pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr15)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr18 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr16 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr17) ^ 16'd2);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr19 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr16 & pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr17) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr16 & 16'd2)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr17 & 16'd2)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_high = (pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr18 + pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr19);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_low = pair_fastchain1_earlycommontaplimitcsr110[10:0];
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr10 = (pair_fastchain1_earlycommontaplimitcsr110 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr11 = pair_fastchain1_earlycommontaplimitcsr1_common_x;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr12 = pair_fastchain1_earlycommontaplimitcsr1_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr13 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr10);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr14 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr15 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr12);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr16 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr13 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr14) ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr15);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr17 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr14) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr15)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr14 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr15)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr18 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr16 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr17) ^ {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr110[10:0] == $signed({1'd0, 1'd0}))});
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr19 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr16 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr17) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr16 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr110[10:0] == $signed({1'd0, 1'd0}))})) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr17 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr110[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_high = (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr18 + pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr19);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_low = (-pair_fastchain1_earlycommontaplimitcsr110[10:0]);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr10 = (pair_fastchain1_earlycommontaplimitcsr19 >>> 4'd11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr11 = pair_fastchain1_earlycommontaplimitcsr1_common_x;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr12 = pair_fastchain1_earlycommontaplimitcsr1_common_offset;
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr13 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr10);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr14 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr11);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr15 = (~pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr12);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr16 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr13 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr14) ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr15);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr17 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr14) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr13 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr15)) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr14 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr15)) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr18 = ((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr16 ^ pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr17) ^ {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr19[10:0] == $signed({1'd0, 1'd0}))});
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr19 = ((((pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr16 & pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr17) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr16 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr19[10:0] == $signed({1'd0, 1'd0}))})) | (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr17 & {14'd0, 1'd1, (pair_fastchain1_earlycommontaplimitcsr19[10:0] == $signed({1'd0, 1'd0}))})) <<< 1'd1);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_high = (pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr18 + pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr19);
assign pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_low = (-pair_fastchain1_earlycommontaplimitcsr19[10:0]);
assign pair_fastchain1_earlycommontaplimitcsr1_total0 = (pair_fastchain1_earlycommontaplimitcsr10 + (pair_fastchain1_earlycommontaplimitcsr1_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_32;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr111 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr113 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr10 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr111 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr113 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr10 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr111 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr113 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr111 <= pair_fastchain1_earlycommontaplimitcsr1_total0;
			pair_fastchain1_earlycommontaplimitcsr113 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_32 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_33;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr112 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr114 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr10 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr112 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr114 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr10 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr112 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr114 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr112 <= (-pair_fastchain1_earlycommontaplimitcsr1_total0);
			pair_fastchain1_earlycommontaplimitcsr114 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_33 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr1_total1 = (pair_fastchain1_earlycommontaplimitcsr11 + (pair_fastchain1_earlycommontaplimitcsr1_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_34;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr115 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr117 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr11 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr115 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr117 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr11 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr115 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr117 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr115 <= pair_fastchain1_earlycommontaplimitcsr1_total1;
			pair_fastchain1_earlycommontaplimitcsr117 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_34 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_35;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr116 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr118 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr11 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr116 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr118 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr11 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr116 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr118 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr116 <= (-pair_fastchain1_earlycommontaplimitcsr1_total1);
			pair_fastchain1_earlycommontaplimitcsr118 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_35 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr1_total2 = (pair_fastchain1_earlycommontaplimitcsr12 + (pair_fastchain1_earlycommontaplimitcsr1_common_reg <<< 4'd11));

// synthesis translate_off
reg dummy_d_36;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr119 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr121 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr12 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr119 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr121 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr12 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr119 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr121 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr119 <= pair_fastchain1_earlycommontaplimitcsr1_total2;
			pair_fastchain1_earlycommontaplimitcsr121 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_36 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_37;
// synthesis translate_on
always @(*) begin
	pair_fastchain1_earlycommontaplimitcsr120 <= 28'sd0;
	pair_fastchain1_earlycommontaplimitcsr122 <= 1'd0;
	if ((pair_fastchain1_earlycommontaplimitcsr12 <= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result)) begin
		pair_fastchain1_earlycommontaplimitcsr120 <= pair_fastchain1_earlycommontaplimitcsr16;
		pair_fastchain1_earlycommontaplimitcsr122 <= 1'd1;
	end else begin
		if ((pair_fastchain1_earlycommontaplimitcsr12 >= pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result)) begin
			pair_fastchain1_earlycommontaplimitcsr120 <= pair_fastchain1_earlycommontaplimitcsr15;
			pair_fastchain1_earlycommontaplimitcsr122 <= 1'd1;
		end else begin
			pair_fastchain1_earlycommontaplimitcsr120 <= (-pair_fastchain1_earlycommontaplimitcsr1_total2);
			pair_fastchain1_earlycommontaplimitcsr122 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_37 <= dummy_s;
// synthesis translate_on
end
assign pair_fastchain1_earlycommontaplimitcsr123 = (pair_fastchain1_earlycommontaplimitcsr14 ? array_muxed12 : array_muxed13);
assign pair_fastchain1_earlycommontaplimitcsr124 = (pair_fastchain1_earlycommontaplimitcsr14 ? array_muxed14 : array_muxed15);
assign pair_csrbank1_sel = (pair_csrbank1_bus_adr[13:9] == 1'd0);
assign pair_csrbank1_y_tap0_r = pair_csrbank1_bus_dat_w[1:0];
assign pair_csrbank1_y_tap0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 1'd0));
assign pair_csrbank1_invert0_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_invert0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 1'd1));
assign pair_csrbank1_demod_delay3_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_demod_delay3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 2'd2));
assign pair_csrbank1_demod_delay2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_demod_delay2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 2'd3));
assign pair_csrbank1_demod_delay1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_demod_delay1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 3'd4));
assign pair_csrbank1_demod_delay0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_demod_delay0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 3'd5));
assign pair_csrbank1_demod_multiplier0_r = pair_csrbank1_bus_dat_w[3:0];
assign pair_csrbank1_demod_multiplier0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 3'd6));
assign pair_csrbank1_x_limit_1_min3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_x_limit_1_min3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 3'd7));
assign pair_csrbank1_x_limit_1_min2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_min2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd8));
assign pair_csrbank1_x_limit_1_min1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_min1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd9));
assign pair_csrbank1_x_limit_1_min0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_min0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd10));
assign pair_csrbank1_x_limit_1_max3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_x_limit_1_max3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd11));
assign pair_csrbank1_x_limit_1_max2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_max2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd12));
assign pair_csrbank1_x_limit_1_max1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_max1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd13));
assign pair_csrbank1_x_limit_1_max0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_1_max0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd14));
assign pair_csrbank1_iir_c_1_z03_r = pair_csrbank1_bus_dat_w[2:0];
assign pair_csrbank1_iir_c_1_z03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 4'd15));
assign pair_csrbank1_iir_c_1_z02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_z02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd16));
assign pair_csrbank1_iir_c_1_z01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_z01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd17));
assign pair_csrbank1_iir_c_1_z00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_z00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd18));
assign pair_csrbank1_iir_c_1_a13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_1_a13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd19));
assign pair_csrbank1_iir_c_1_a12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_a12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd20));
assign pair_csrbank1_iir_c_1_a11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_a11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd21));
assign pair_csrbank1_iir_c_1_a10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_a10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd22));
assign pair_csrbank1_iir_c_1_b03_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_1_b03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd23));
assign pair_csrbank1_iir_c_1_b02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd24));
assign pair_csrbank1_iir_c_1_b01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd25));
assign pair_csrbank1_iir_c_1_b00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd26));
assign pair_csrbank1_iir_c_1_b13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_1_b13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd27));
assign pair_csrbank1_iir_c_1_b12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd28));
assign pair_csrbank1_iir_c_1_b11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd29));
assign pair_csrbank1_iir_c_1_b10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_1_b10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd30));
assign pair_csrbank1_iir_d_1_z03_r = pair_csrbank1_bus_dat_w[2:0];
assign pair_csrbank1_iir_d_1_z03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 5'd31));
assign pair_csrbank1_iir_d_1_z02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_z02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd32));
assign pair_csrbank1_iir_d_1_z01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_z01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd33));
assign pair_csrbank1_iir_d_1_z00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_z00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd34));
assign pair_csrbank1_iir_d_1_a13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_1_a13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd35));
assign pair_csrbank1_iir_d_1_a12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd36));
assign pair_csrbank1_iir_d_1_a11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd37));
assign pair_csrbank1_iir_d_1_a10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd38));
assign pair_csrbank1_iir_d_1_a23_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_1_a23_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd39));
assign pair_csrbank1_iir_d_1_a22_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a22_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd40));
assign pair_csrbank1_iir_d_1_a21_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a21_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd41));
assign pair_csrbank1_iir_d_1_a20_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_a20_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd42));
assign pair_csrbank1_iir_d_1_b03_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_1_b03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd43));
assign pair_csrbank1_iir_d_1_b02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd44));
assign pair_csrbank1_iir_d_1_b01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd45));
assign pair_csrbank1_iir_d_1_b00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd46));
assign pair_csrbank1_iir_d_1_b13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_1_b13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd47));
assign pair_csrbank1_iir_d_1_b12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd48));
assign pair_csrbank1_iir_d_1_b11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd49));
assign pair_csrbank1_iir_d_1_b10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd50));
assign pair_csrbank1_iir_d_1_b23_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_1_b23_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd51));
assign pair_csrbank1_iir_d_1_b22_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b22_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd52));
assign pair_csrbank1_iir_d_1_b21_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b21_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd53));
assign pair_csrbank1_iir_d_1_b20_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_1_b20_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd54));
assign pair_csrbank1_y_limit_1_min3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_y_limit_1_min3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd55));
assign pair_csrbank1_y_limit_1_min2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_min2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd56));
assign pair_csrbank1_y_limit_1_min1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_min1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd57));
assign pair_csrbank1_y_limit_1_min0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_min0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd58));
assign pair_csrbank1_y_limit_1_max3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_y_limit_1_max3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd59));
assign pair_csrbank1_y_limit_1_max2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_max2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd60));
assign pair_csrbank1_y_limit_1_max1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_max1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd61));
assign pair_csrbank1_y_limit_1_max0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_1_max0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd62));
assign pair_csrbank1_x_limit_2_min3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_x_limit_2_min3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 6'd63));
assign pair_csrbank1_x_limit_2_min2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_min2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd64));
assign pair_csrbank1_x_limit_2_min1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_min1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd65));
assign pair_csrbank1_x_limit_2_min0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_min0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd66));
assign pair_csrbank1_x_limit_2_max3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_x_limit_2_max3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd67));
assign pair_csrbank1_x_limit_2_max2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_max2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd68));
assign pair_csrbank1_x_limit_2_max1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_max1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd69));
assign pair_csrbank1_x_limit_2_max0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_x_limit_2_max0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd70));
assign pair_csrbank1_iir_c_2_z03_r = pair_csrbank1_bus_dat_w[2:0];
assign pair_csrbank1_iir_c_2_z03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd71));
assign pair_csrbank1_iir_c_2_z02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_z02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd72));
assign pair_csrbank1_iir_c_2_z01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_z01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd73));
assign pair_csrbank1_iir_c_2_z00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_z00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd74));
assign pair_csrbank1_iir_c_2_a13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_2_a13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd75));
assign pair_csrbank1_iir_c_2_a12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_a12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd76));
assign pair_csrbank1_iir_c_2_a11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_a11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd77));
assign pair_csrbank1_iir_c_2_a10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_a10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd78));
assign pair_csrbank1_iir_c_2_b03_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_2_b03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd79));
assign pair_csrbank1_iir_c_2_b02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd80));
assign pair_csrbank1_iir_c_2_b01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd81));
assign pair_csrbank1_iir_c_2_b00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd82));
assign pair_csrbank1_iir_c_2_b13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_c_2_b13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd83));
assign pair_csrbank1_iir_c_2_b12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd84));
assign pair_csrbank1_iir_c_2_b11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd85));
assign pair_csrbank1_iir_c_2_b10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_c_2_b10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd86));
assign pair_csrbank1_iir_d_2_z03_r = pair_csrbank1_bus_dat_w[2:0];
assign pair_csrbank1_iir_d_2_z03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd87));
assign pair_csrbank1_iir_d_2_z02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_z02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd88));
assign pair_csrbank1_iir_d_2_z01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_z01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd89));
assign pair_csrbank1_iir_d_2_z00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_z00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd90));
assign pair_csrbank1_iir_d_2_a13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_2_a13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd91));
assign pair_csrbank1_iir_d_2_a12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd92));
assign pair_csrbank1_iir_d_2_a11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd93));
assign pair_csrbank1_iir_d_2_a10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd94));
assign pair_csrbank1_iir_d_2_a23_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_2_a23_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd95));
assign pair_csrbank1_iir_d_2_a22_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a22_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd96));
assign pair_csrbank1_iir_d_2_a21_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a21_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd97));
assign pair_csrbank1_iir_d_2_a20_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_a20_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd98));
assign pair_csrbank1_iir_d_2_b03_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_2_b03_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd99));
assign pair_csrbank1_iir_d_2_b02_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b02_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd100));
assign pair_csrbank1_iir_d_2_b01_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b01_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd101));
assign pair_csrbank1_iir_d_2_b00_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b00_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd102));
assign pair_csrbank1_iir_d_2_b13_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_2_b13_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd103));
assign pair_csrbank1_iir_d_2_b12_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b12_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd104));
assign pair_csrbank1_iir_d_2_b11_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b11_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd105));
assign pair_csrbank1_iir_d_2_b10_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b10_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd106));
assign pair_csrbank1_iir_d_2_b23_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_iir_d_2_b23_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd107));
assign pair_csrbank1_iir_d_2_b22_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b22_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd108));
assign pair_csrbank1_iir_d_2_b21_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b21_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd109));
assign pair_csrbank1_iir_d_2_b20_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_iir_d_2_b20_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd110));
assign pair_csrbank1_y_limit_2_min3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_y_limit_2_min3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd111));
assign pair_csrbank1_y_limit_2_min2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_min2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd112));
assign pair_csrbank1_y_limit_2_min1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_min1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd113));
assign pair_csrbank1_y_limit_2_min0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_min0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd114));
assign pair_csrbank1_y_limit_2_max3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_y_limit_2_max3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd115));
assign pair_csrbank1_y_limit_2_max2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_max2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd116));
assign pair_csrbank1_y_limit_2_max1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_max1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd117));
assign pair_csrbank1_y_limit_2_max0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_y_limit_2_max0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[6:0] == 7'd118));
assign pair_fastchain1_y_tap_storage = pair_fastchain1_y_tap_storage_full[1:0];
assign pair_csrbank1_y_tap0_w = pair_fastchain1_y_tap_storage_full[1:0];
assign pair_fastchain1_invert_storage = pair_fastchain1_invert_storage_full;
assign pair_csrbank1_invert0_w = pair_fastchain1_invert_storage_full;
assign pair_fastchain1_delay_storage = pair_fastchain1_delay_storage_full[31:0];
assign pair_csrbank1_demod_delay3_w = pair_fastchain1_delay_storage_full[31:24];
assign pair_csrbank1_demod_delay2_w = pair_fastchain1_delay_storage_full[23:16];
assign pair_csrbank1_demod_delay1_w = pair_fastchain1_delay_storage_full[15:8];
assign pair_csrbank1_demod_delay0_w = pair_fastchain1_delay_storage_full[7:0];
assign pair_fastchain1_multiplier_storage = pair_fastchain1_multiplier_storage_full[3:0];
assign pair_csrbank1_demod_multiplier0_w = pair_fastchain1_multiplier_storage_full[3:0];
assign pair_fastchain1_limitcsr2_min_storage = pair_fastchain1_limitcsr2_min_storage_full[24:0];
assign pair_csrbank1_x_limit_1_min3_w = pair_fastchain1_limitcsr2_min_storage_full[24];
assign pair_csrbank1_x_limit_1_min2_w = pair_fastchain1_limitcsr2_min_storage_full[23:16];
assign pair_csrbank1_x_limit_1_min1_w = pair_fastchain1_limitcsr2_min_storage_full[15:8];
assign pair_csrbank1_x_limit_1_min0_w = pair_fastchain1_limitcsr2_min_storage_full[7:0];
assign pair_fastchain1_limitcsr2_max_storage = pair_fastchain1_limitcsr2_max_storage_full[24:0];
assign pair_csrbank1_x_limit_1_max3_w = pair_fastchain1_limitcsr2_max_storage_full[24];
assign pair_csrbank1_x_limit_1_max2_w = pair_fastchain1_limitcsr2_max_storage_full[23:16];
assign pair_csrbank1_x_limit_1_max1_w = pair_fastchain1_limitcsr2_max_storage_full[15:8];
assign pair_csrbank1_x_limit_1_max0_w = pair_fastchain1_limitcsr2_max_storage_full[7:0];
assign pair_fastchain1_iir2_storage0 = pair_fastchain1_iir2_storage_full0[26:0];
assign pair_csrbank1_iir_c_1_z03_w = pair_fastchain1_iir2_storage_full0[26:24];
assign pair_csrbank1_iir_c_1_z02_w = pair_fastchain1_iir2_storage_full0[23:16];
assign pair_csrbank1_iir_c_1_z01_w = pair_fastchain1_iir2_storage_full0[15:8];
assign pair_csrbank1_iir_c_1_z00_w = pair_fastchain1_iir2_storage_full0[7:0];
assign pair_fastchain1_iir2_csrstorage6_storage = pair_fastchain1_iir2_csrstorage6_storage_full[24:0];
assign pair_csrbank1_iir_c_1_a13_w = pair_fastchain1_iir2_csrstorage6_storage_full[24];
assign pair_csrbank1_iir_c_1_a12_w = pair_fastchain1_iir2_csrstorage6_storage_full[23:16];
assign pair_csrbank1_iir_c_1_a11_w = pair_fastchain1_iir2_csrstorage6_storage_full[15:8];
assign pair_csrbank1_iir_c_1_a10_w = pair_fastchain1_iir2_csrstorage6_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage7_storage = pair_fastchain1_iir2_csrstorage7_storage_full[24:0];
assign pair_csrbank1_iir_c_1_b03_w = pair_fastchain1_iir2_csrstorage7_storage_full[24];
assign pair_csrbank1_iir_c_1_b02_w = pair_fastchain1_iir2_csrstorage7_storage_full[23:16];
assign pair_csrbank1_iir_c_1_b01_w = pair_fastchain1_iir2_csrstorage7_storage_full[15:8];
assign pair_csrbank1_iir_c_1_b00_w = pair_fastchain1_iir2_csrstorage7_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage8_storage = pair_fastchain1_iir2_csrstorage8_storage_full[24:0];
assign pair_csrbank1_iir_c_1_b13_w = pair_fastchain1_iir2_csrstorage8_storage_full[24];
assign pair_csrbank1_iir_c_1_b12_w = pair_fastchain1_iir2_csrstorage8_storage_full[23:16];
assign pair_csrbank1_iir_c_1_b11_w = pair_fastchain1_iir2_csrstorage8_storage_full[15:8];
assign pair_csrbank1_iir_c_1_b10_w = pair_fastchain1_iir2_csrstorage8_storage_full[7:0];
assign pair_fastchain1_iir2_storage1 = pair_fastchain1_iir2_storage_full1[26:0];
assign pair_csrbank1_iir_d_1_z03_w = pair_fastchain1_iir2_storage_full1[26:24];
assign pair_csrbank1_iir_d_1_z02_w = pair_fastchain1_iir2_storage_full1[23:16];
assign pair_csrbank1_iir_d_1_z01_w = pair_fastchain1_iir2_storage_full1[15:8];
assign pair_csrbank1_iir_d_1_z00_w = pair_fastchain1_iir2_storage_full1[7:0];
assign pair_fastchain1_iir2_csrstorage10_storage = pair_fastchain1_iir2_csrstorage10_storage_full[24:0];
assign pair_csrbank1_iir_d_1_a13_w = pair_fastchain1_iir2_csrstorage10_storage_full[24];
assign pair_csrbank1_iir_d_1_a12_w = pair_fastchain1_iir2_csrstorage10_storage_full[23:16];
assign pair_csrbank1_iir_d_1_a11_w = pair_fastchain1_iir2_csrstorage10_storage_full[15:8];
assign pair_csrbank1_iir_d_1_a10_w = pair_fastchain1_iir2_csrstorage10_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage11_storage = pair_fastchain1_iir2_csrstorage11_storage_full[24:0];
assign pair_csrbank1_iir_d_1_a23_w = pair_fastchain1_iir2_csrstorage11_storage_full[24];
assign pair_csrbank1_iir_d_1_a22_w = pair_fastchain1_iir2_csrstorage11_storage_full[23:16];
assign pair_csrbank1_iir_d_1_a21_w = pair_fastchain1_iir2_csrstorage11_storage_full[15:8];
assign pair_csrbank1_iir_d_1_a20_w = pair_fastchain1_iir2_csrstorage11_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage12_storage = pair_fastchain1_iir2_csrstorage12_storage_full[24:0];
assign pair_csrbank1_iir_d_1_b03_w = pair_fastchain1_iir2_csrstorage12_storage_full[24];
assign pair_csrbank1_iir_d_1_b02_w = pair_fastchain1_iir2_csrstorage12_storage_full[23:16];
assign pair_csrbank1_iir_d_1_b01_w = pair_fastchain1_iir2_csrstorage12_storage_full[15:8];
assign pair_csrbank1_iir_d_1_b00_w = pair_fastchain1_iir2_csrstorage12_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage13_storage = pair_fastchain1_iir2_csrstorage13_storage_full[24:0];
assign pair_csrbank1_iir_d_1_b13_w = pair_fastchain1_iir2_csrstorage13_storage_full[24];
assign pair_csrbank1_iir_d_1_b12_w = pair_fastchain1_iir2_csrstorage13_storage_full[23:16];
assign pair_csrbank1_iir_d_1_b11_w = pair_fastchain1_iir2_csrstorage13_storage_full[15:8];
assign pair_csrbank1_iir_d_1_b10_w = pair_fastchain1_iir2_csrstorage13_storage_full[7:0];
assign pair_fastchain1_iir2_csrstorage14_storage = pair_fastchain1_iir2_csrstorage14_storage_full[24:0];
assign pair_csrbank1_iir_d_1_b23_w = pair_fastchain1_iir2_csrstorage14_storage_full[24];
assign pair_csrbank1_iir_d_1_b22_w = pair_fastchain1_iir2_csrstorage14_storage_full[23:16];
assign pair_csrbank1_iir_d_1_b21_w = pair_fastchain1_iir2_csrstorage14_storage_full[15:8];
assign pair_csrbank1_iir_d_1_b20_w = pair_fastchain1_iir2_csrstorage14_storage_full[7:0];
assign pair_fastchain1_earlycommontaplimitcsr0_min_storage = pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[24:0];
assign pair_csrbank1_y_limit_1_min3_w = pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[24];
assign pair_csrbank1_y_limit_1_min2_w = pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[23:16];
assign pair_csrbank1_y_limit_1_min1_w = pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[15:8];
assign pair_csrbank1_y_limit_1_min0_w = pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[7:0];
assign pair_fastchain1_earlycommontaplimitcsr0_max_storage = pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[24:0];
assign pair_csrbank1_y_limit_1_max3_w = pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[24];
assign pair_csrbank1_y_limit_1_max2_w = pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[23:16];
assign pair_csrbank1_y_limit_1_max1_w = pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[15:8];
assign pair_csrbank1_y_limit_1_max0_w = pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[7:0];
assign pair_fastchain1_limitcsr3_min_storage = pair_fastchain1_limitcsr3_min_storage_full[24:0];
assign pair_csrbank1_x_limit_2_min3_w = pair_fastchain1_limitcsr3_min_storage_full[24];
assign pair_csrbank1_x_limit_2_min2_w = pair_fastchain1_limitcsr3_min_storage_full[23:16];
assign pair_csrbank1_x_limit_2_min1_w = pair_fastchain1_limitcsr3_min_storage_full[15:8];
assign pair_csrbank1_x_limit_2_min0_w = pair_fastchain1_limitcsr3_min_storage_full[7:0];
assign pair_fastchain1_limitcsr3_max_storage = pair_fastchain1_limitcsr3_max_storage_full[24:0];
assign pair_csrbank1_x_limit_2_max3_w = pair_fastchain1_limitcsr3_max_storage_full[24];
assign pair_csrbank1_x_limit_2_max2_w = pair_fastchain1_limitcsr3_max_storage_full[23:16];
assign pair_csrbank1_x_limit_2_max1_w = pair_fastchain1_limitcsr3_max_storage_full[15:8];
assign pair_csrbank1_x_limit_2_max0_w = pair_fastchain1_limitcsr3_max_storage_full[7:0];
assign pair_fastchain1_iir3_storage0 = pair_fastchain1_iir3_storage_full0[26:0];
assign pair_csrbank1_iir_c_2_z03_w = pair_fastchain1_iir3_storage_full0[26:24];
assign pair_csrbank1_iir_c_2_z02_w = pair_fastchain1_iir3_storage_full0[23:16];
assign pair_csrbank1_iir_c_2_z01_w = pair_fastchain1_iir3_storage_full0[15:8];
assign pair_csrbank1_iir_c_2_z00_w = pair_fastchain1_iir3_storage_full0[7:0];
assign pair_fastchain1_iir3_csrstorage9_storage = pair_fastchain1_iir3_csrstorage9_storage_full[24:0];
assign pair_csrbank1_iir_c_2_a13_w = pair_fastchain1_iir3_csrstorage9_storage_full[24];
assign pair_csrbank1_iir_c_2_a12_w = pair_fastchain1_iir3_csrstorage9_storage_full[23:16];
assign pair_csrbank1_iir_c_2_a11_w = pair_fastchain1_iir3_csrstorage9_storage_full[15:8];
assign pair_csrbank1_iir_c_2_a10_w = pair_fastchain1_iir3_csrstorage9_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage10_storage = pair_fastchain1_iir3_csrstorage10_storage_full[24:0];
assign pair_csrbank1_iir_c_2_b03_w = pair_fastchain1_iir3_csrstorage10_storage_full[24];
assign pair_csrbank1_iir_c_2_b02_w = pair_fastchain1_iir3_csrstorage10_storage_full[23:16];
assign pair_csrbank1_iir_c_2_b01_w = pair_fastchain1_iir3_csrstorage10_storage_full[15:8];
assign pair_csrbank1_iir_c_2_b00_w = pair_fastchain1_iir3_csrstorage10_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage11_storage = pair_fastchain1_iir3_csrstorage11_storage_full[24:0];
assign pair_csrbank1_iir_c_2_b13_w = pair_fastchain1_iir3_csrstorage11_storage_full[24];
assign pair_csrbank1_iir_c_2_b12_w = pair_fastchain1_iir3_csrstorage11_storage_full[23:16];
assign pair_csrbank1_iir_c_2_b11_w = pair_fastchain1_iir3_csrstorage11_storage_full[15:8];
assign pair_csrbank1_iir_c_2_b10_w = pair_fastchain1_iir3_csrstorage11_storage_full[7:0];
assign pair_fastchain1_iir3_storage1 = pair_fastchain1_iir3_storage_full1[26:0];
assign pair_csrbank1_iir_d_2_z03_w = pair_fastchain1_iir3_storage_full1[26:24];
assign pair_csrbank1_iir_d_2_z02_w = pair_fastchain1_iir3_storage_full1[23:16];
assign pair_csrbank1_iir_d_2_z01_w = pair_fastchain1_iir3_storage_full1[15:8];
assign pair_csrbank1_iir_d_2_z00_w = pair_fastchain1_iir3_storage_full1[7:0];
assign pair_fastchain1_iir3_csrstorage15_storage = pair_fastchain1_iir3_csrstorage15_storage_full[24:0];
assign pair_csrbank1_iir_d_2_a13_w = pair_fastchain1_iir3_csrstorage15_storage_full[24];
assign pair_csrbank1_iir_d_2_a12_w = pair_fastchain1_iir3_csrstorage15_storage_full[23:16];
assign pair_csrbank1_iir_d_2_a11_w = pair_fastchain1_iir3_csrstorage15_storage_full[15:8];
assign pair_csrbank1_iir_d_2_a10_w = pair_fastchain1_iir3_csrstorage15_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage16_storage = pair_fastchain1_iir3_csrstorage16_storage_full[24:0];
assign pair_csrbank1_iir_d_2_a23_w = pair_fastchain1_iir3_csrstorage16_storage_full[24];
assign pair_csrbank1_iir_d_2_a22_w = pair_fastchain1_iir3_csrstorage16_storage_full[23:16];
assign pair_csrbank1_iir_d_2_a21_w = pair_fastchain1_iir3_csrstorage16_storage_full[15:8];
assign pair_csrbank1_iir_d_2_a20_w = pair_fastchain1_iir3_csrstorage16_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage17_storage = pair_fastchain1_iir3_csrstorage17_storage_full[24:0];
assign pair_csrbank1_iir_d_2_b03_w = pair_fastchain1_iir3_csrstorage17_storage_full[24];
assign pair_csrbank1_iir_d_2_b02_w = pair_fastchain1_iir3_csrstorage17_storage_full[23:16];
assign pair_csrbank1_iir_d_2_b01_w = pair_fastchain1_iir3_csrstorage17_storage_full[15:8];
assign pair_csrbank1_iir_d_2_b00_w = pair_fastchain1_iir3_csrstorage17_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage18_storage = pair_fastchain1_iir3_csrstorage18_storage_full[24:0];
assign pair_csrbank1_iir_d_2_b13_w = pair_fastchain1_iir3_csrstorage18_storage_full[24];
assign pair_csrbank1_iir_d_2_b12_w = pair_fastchain1_iir3_csrstorage18_storage_full[23:16];
assign pair_csrbank1_iir_d_2_b11_w = pair_fastchain1_iir3_csrstorage18_storage_full[15:8];
assign pair_csrbank1_iir_d_2_b10_w = pair_fastchain1_iir3_csrstorage18_storage_full[7:0];
assign pair_fastchain1_iir3_csrstorage19_storage = pair_fastchain1_iir3_csrstorage19_storage_full[24:0];
assign pair_csrbank1_iir_d_2_b23_w = pair_fastchain1_iir3_csrstorage19_storage_full[24];
assign pair_csrbank1_iir_d_2_b22_w = pair_fastchain1_iir3_csrstorage19_storage_full[23:16];
assign pair_csrbank1_iir_d_2_b21_w = pair_fastchain1_iir3_csrstorage19_storage_full[15:8];
assign pair_csrbank1_iir_d_2_b20_w = pair_fastchain1_iir3_csrstorage19_storage_full[7:0];
assign pair_fastchain1_earlycommontaplimitcsr1_min_storage = pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[24:0];
assign pair_csrbank1_y_limit_2_min3_w = pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[24];
assign pair_csrbank1_y_limit_2_min2_w = pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[23:16];
assign pair_csrbank1_y_limit_2_min1_w = pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[15:8];
assign pair_csrbank1_y_limit_2_min0_w = pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[7:0];
assign pair_fastchain1_earlycommontaplimitcsr1_max_storage = pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[24:0];
assign pair_csrbank1_y_limit_2_max3_w = pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[24];
assign pair_csrbank1_y_limit_2_max2_w = pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[23:16];
assign pair_csrbank1_y_limit_2_max1_w = pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[15:8];
assign pair_csrbank1_y_limit_2_max0_w = pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[7:0];

// synthesis translate_off
reg dummy_d_38;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 28'sd0;
	case (pair_fastchain0_paralleltaplimitcsr03)
		1'd0: begin
			array_muxed0 <= pair_fastchain0_paralleltaplimitcsr0_neg_value0;
		end
		1'd1: begin
			array_muxed0 <= pair_fastchain0_paralleltaplimitcsr0_neg_value1;
		end
		default: begin
			array_muxed0 <= pair_fastchain0_paralleltaplimitcsr0_neg_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_38 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_39;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 28'sd0;
	case (pair_fastchain0_paralleltaplimitcsr03)
		1'd0: begin
			array_muxed1 <= pair_fastchain0_paralleltaplimitcsr0_limit0_y;
		end
		1'd1: begin
			array_muxed1 <= pair_fastchain0_paralleltaplimitcsr0_limit1_y;
		end
		default: begin
			array_muxed1 <= pair_fastchain0_paralleltaplimitcsr0_limit2_y;
		end
	endcase
// synthesis translate_off
	dummy_d_39 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_40;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 1'd0;
	case (pair_fastchain0_paralleltaplimitcsr03)
		1'd0: begin
			array_muxed2 <= pair_fastchain0_paralleltaplimitcsr0_neg_rail_value0;
		end
		1'd1: begin
			array_muxed2 <= pair_fastchain0_paralleltaplimitcsr0_neg_rail_value1;
		end
		default: begin
			array_muxed2 <= pair_fastchain0_paralleltaplimitcsr0_neg_rail_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_40 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_41;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (pair_fastchain0_paralleltaplimitcsr03)
		1'd0: begin
			array_muxed3 <= pair_fastchain0_paralleltaplimitcsr0_limit0_railed;
		end
		1'd1: begin
			array_muxed3 <= pair_fastchain0_paralleltaplimitcsr0_limit1_railed;
		end
		default: begin
			array_muxed3 <= pair_fastchain0_paralleltaplimitcsr0_limit2_railed;
		end
	endcase
// synthesis translate_off
	dummy_d_41 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_42;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 28'sd0;
	case (pair_fastchain0_paralleltaplimitcsr13)
		1'd0: begin
			array_muxed4 <= pair_fastchain0_paralleltaplimitcsr1_neg_value0;
		end
		1'd1: begin
			array_muxed4 <= pair_fastchain0_paralleltaplimitcsr1_neg_value1;
		end
		default: begin
			array_muxed4 <= pair_fastchain0_paralleltaplimitcsr1_neg_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_42 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_43;
// synthesis translate_on
always @(*) begin
	array_muxed5 <= 28'sd0;
	case (pair_fastchain0_paralleltaplimitcsr13)
		1'd0: begin
			array_muxed5 <= pair_fastchain0_paralleltaplimitcsr1_limit3_y;
		end
		1'd1: begin
			array_muxed5 <= pair_fastchain0_paralleltaplimitcsr1_limit4_y;
		end
		default: begin
			array_muxed5 <= pair_fastchain0_paralleltaplimitcsr1_limit5_y;
		end
	endcase
// synthesis translate_off
	dummy_d_43 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_44;
// synthesis translate_on
always @(*) begin
	array_muxed6 <= 1'd0;
	case (pair_fastchain0_paralleltaplimitcsr13)
		1'd0: begin
			array_muxed6 <= pair_fastchain0_paralleltaplimitcsr1_neg_rail_value0;
		end
		1'd1: begin
			array_muxed6 <= pair_fastchain0_paralleltaplimitcsr1_neg_rail_value1;
		end
		default: begin
			array_muxed6 <= pair_fastchain0_paralleltaplimitcsr1_neg_rail_value2;
		end
	endcase
// synthesis translate_off
	dummy_d_44 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_45;
// synthesis translate_on
always @(*) begin
	array_muxed7 <= 1'd0;
	case (pair_fastchain0_paralleltaplimitcsr13)
		1'd0: begin
			array_muxed7 <= pair_fastchain0_paralleltaplimitcsr1_limit3_railed;
		end
		1'd1: begin
			array_muxed7 <= pair_fastchain0_paralleltaplimitcsr1_limit4_railed;
		end
		default: begin
			array_muxed7 <= pair_fastchain0_paralleltaplimitcsr1_limit5_railed;
		end
	endcase
// synthesis translate_off
	dummy_d_45 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_46;
// synthesis translate_on
always @(*) begin
	array_muxed8 <= 28'sd0;
	case (pair_fastchain1_earlycommontaplimitcsr03)
		1'd0: begin
			array_muxed8 <= pair_fastchain1_earlycommontaplimitcsr012;
		end
		1'd1: begin
			array_muxed8 <= pair_fastchain1_earlycommontaplimitcsr016;
		end
		default: begin
			array_muxed8 <= pair_fastchain1_earlycommontaplimitcsr020;
		end
	endcase
// synthesis translate_off
	dummy_d_46 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_47;
// synthesis translate_on
always @(*) begin
	array_muxed9 <= 28'sd0;
	case (pair_fastchain1_earlycommontaplimitcsr03)
		1'd0: begin
			array_muxed9 <= pair_fastchain1_earlycommontaplimitcsr011;
		end
		1'd1: begin
			array_muxed9 <= pair_fastchain1_earlycommontaplimitcsr015;
		end
		default: begin
			array_muxed9 <= pair_fastchain1_earlycommontaplimitcsr019;
		end
	endcase
// synthesis translate_off
	dummy_d_47 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_48;
// synthesis translate_on
always @(*) begin
	array_muxed10 <= 1'd0;
	case (pair_fastchain1_earlycommontaplimitcsr03)
		1'd0: begin
			array_muxed10 <= pair_fastchain1_earlycommontaplimitcsr014;
		end
		1'd1: begin
			array_muxed10 <= pair_fastchain1_earlycommontaplimitcsr018;
		end
		default: begin
			array_muxed10 <= pair_fastchain1_earlycommontaplimitcsr022;
		end
	endcase
// synthesis translate_off
	dummy_d_48 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_49;
// synthesis translate_on
always @(*) begin
	array_muxed11 <= 1'd0;
	case (pair_fastchain1_earlycommontaplimitcsr03)
		1'd0: begin
			array_muxed11 <= pair_fastchain1_earlycommontaplimitcsr013;
		end
		1'd1: begin
			array_muxed11 <= pair_fastchain1_earlycommontaplimitcsr017;
		end
		default: begin
			array_muxed11 <= pair_fastchain1_earlycommontaplimitcsr021;
		end
	endcase
// synthesis translate_off
	dummy_d_49 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_50;
// synthesis translate_on
always @(*) begin
	array_muxed12 <= 28'sd0;
	case (pair_fastchain1_earlycommontaplimitcsr13)
		1'd0: begin
			array_muxed12 <= pair_fastchain1_earlycommontaplimitcsr112;
		end
		1'd1: begin
			array_muxed12 <= pair_fastchain1_earlycommontaplimitcsr116;
		end
		default: begin
			array_muxed12 <= pair_fastchain1_earlycommontaplimitcsr120;
		end
	endcase
// synthesis translate_off
	dummy_d_50 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_51;
// synthesis translate_on
always @(*) begin
	array_muxed13 <= 28'sd0;
	case (pair_fastchain1_earlycommontaplimitcsr13)
		1'd0: begin
			array_muxed13 <= pair_fastchain1_earlycommontaplimitcsr111;
		end
		1'd1: begin
			array_muxed13 <= pair_fastchain1_earlycommontaplimitcsr115;
		end
		default: begin
			array_muxed13 <= pair_fastchain1_earlycommontaplimitcsr119;
		end
	endcase
// synthesis translate_off
	dummy_d_51 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_52;
// synthesis translate_on
always @(*) begin
	array_muxed14 <= 1'd0;
	case (pair_fastchain1_earlycommontaplimitcsr13)
		1'd0: begin
			array_muxed14 <= pair_fastchain1_earlycommontaplimitcsr114;
		end
		1'd1: begin
			array_muxed14 <= pair_fastchain1_earlycommontaplimitcsr118;
		end
		default: begin
			array_muxed14 <= pair_fastchain1_earlycommontaplimitcsr122;
		end
	endcase
// synthesis translate_off
	dummy_d_52 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_53;
// synthesis translate_on
always @(*) begin
	array_muxed15 <= 1'd0;
	case (pair_fastchain1_earlycommontaplimitcsr13)
		1'd0: begin
			array_muxed15 <= pair_fastchain1_earlycommontaplimitcsr113;
		end
		1'd1: begin
			array_muxed15 <= pair_fastchain1_earlycommontaplimitcsr117;
		end
		default: begin
			array_muxed15 <= pair_fastchain1_earlycommontaplimitcsr121;
		end
	endcase
// synthesis translate_off
	dummy_d_53 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	pair_fastchain0_ya <= (pair_fastchain0_dy >>> 4'd11);
	pair_fastchain0_common <= ((pair_fastchain0_dy >>> 4'd11) + pair_fastchain0_signed_offset);
	pair_fastchain0_speculativedemodcordic01 <= ((pair_fastchain0_phase_value[13] ^ pair_fastchain0_phase_value[14]) ? pair_fastchain0_speculativedemodcordic0_speculativedemodcordic01 : pair_fastchain0_speculativedemodcordic0_speculativedemodcordic00);
	pair_fastchain0_speculativedemodcordic017 <= (pair_fastchain0_phase_value[14] ? pair_fastchain0_speculativedemodcordic0_speculativedemodcordic01 : pair_fastchain0_speculativedemodcordic0_speculativedemodcordic00);
	pair_fastchain0_speculativedemodcordic033 <= (pair_fastchain0_speculativedemodcordic032 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	pair_fastchain0_speculativedemodcordic02 <= (pair_fastchain0_speculativedemodcordic01 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir1 ? (pair_fastchain0_speculativedemodcordic017 >>> 1'd1) : (-(pair_fastchain0_speculativedemodcordic017 >>> 1'd1))));
	pair_fastchain0_speculativedemodcordic018 <= (pair_fastchain0_speculativedemodcordic017 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir1 ? (-(pair_fastchain0_speculativedemodcordic01 >>> 1'd1)) : (pair_fastchain0_speculativedemodcordic01 >>> 1'd1)));
	pair_fastchain0_speculativedemodcordic034 <= (pair_fastchain0_speculativedemodcordic033 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	pair_fastchain0_speculativedemodcordic03 <= (pair_fastchain0_speculativedemodcordic02 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir2 ? (pair_fastchain0_speculativedemodcordic018 >>> 2'd2) : (-(pair_fastchain0_speculativedemodcordic018 >>> 2'd2))));
	pair_fastchain0_speculativedemodcordic019 <= (pair_fastchain0_speculativedemodcordic018 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir2 ? (-(pair_fastchain0_speculativedemodcordic02 >>> 2'd2)) : (pair_fastchain0_speculativedemodcordic02 >>> 2'd2)));
	pair_fastchain0_speculativedemodcordic035 <= (pair_fastchain0_speculativedemodcordic034 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	pair_fastchain0_speculativedemodcordic04 <= (pair_fastchain0_speculativedemodcordic03 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir3 ? (pair_fastchain0_speculativedemodcordic019 >>> 2'd3) : (-(pair_fastchain0_speculativedemodcordic019 >>> 2'd3))));
	pair_fastchain0_speculativedemodcordic020 <= (pair_fastchain0_speculativedemodcordic019 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir3 ? (-(pair_fastchain0_speculativedemodcordic03 >>> 2'd3)) : (pair_fastchain0_speculativedemodcordic03 >>> 2'd3)));
	pair_fastchain0_speculativedemodcordic036 <= (pair_fastchain0_speculativedemodcordic035 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	pair_fastchain0_speculativedemodcordic05 <= (pair_fastchain0_speculativedemodcordic04 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir4 ? (pair_fastchain0_speculativedemodcordic020 >>> 3'd4) : (-(pair_fastchain0_speculativedemodcordic020 >>> 3'd4))));
	pair_fastchain0_speculativedemodcordic021 <= (pair_fastchain0_speculativedemodcordic020 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir4 ? (-(pair_fastchain0_speculativedemodcordic04 >>> 3'd4)) : (pair_fastchain0_speculativedemodcordic04 >>> 3'd4)));
	pair_fastchain0_speculativedemodcordic037 <= (pair_fastchain0_speculativedemodcordic036 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	pair_fastchain0_speculativedemodcordic06 <= (pair_fastchain0_speculativedemodcordic05 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir5 ? (pair_fastchain0_speculativedemodcordic021 >>> 3'd5) : (-(pair_fastchain0_speculativedemodcordic021 >>> 3'd5))));
	pair_fastchain0_speculativedemodcordic022 <= (pair_fastchain0_speculativedemodcordic021 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir5 ? (-(pair_fastchain0_speculativedemodcordic05 >>> 3'd5)) : (pair_fastchain0_speculativedemodcordic05 >>> 3'd5)));
	pair_fastchain0_speculativedemodcordic038 <= (pair_fastchain0_speculativedemodcordic037 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_fastchain0_speculativedemodcordic07 <= (pair_fastchain0_speculativedemodcordic06 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir6 ? (pair_fastchain0_speculativedemodcordic022 >>> 3'd6) : (-(pair_fastchain0_speculativedemodcordic022 >>> 3'd6))));
	pair_fastchain0_speculativedemodcordic023 <= (pair_fastchain0_speculativedemodcordic022 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir6 ? (-(pair_fastchain0_speculativedemodcordic06 >>> 3'd6)) : (pair_fastchain0_speculativedemodcordic06 >>> 3'd6)));
	pair_fastchain0_speculativedemodcordic039 <= (pair_fastchain0_speculativedemodcordic038 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_fastchain0_speculativedemodcordic08 <= (pair_fastchain0_speculativedemodcordic07 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir7 ? (pair_fastchain0_speculativedemodcordic023 >>> 3'd7) : (-(pair_fastchain0_speculativedemodcordic023 >>> 3'd7))));
	pair_fastchain0_speculativedemodcordic024 <= (pair_fastchain0_speculativedemodcordic023 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir7 ? (-(pair_fastchain0_speculativedemodcordic07 >>> 3'd7)) : (pair_fastchain0_speculativedemodcordic07 >>> 3'd7)));
	pair_fastchain0_speculativedemodcordic040 <= (pair_fastchain0_speculativedemodcordic039 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_fastchain0_speculativedemodcordic09 <= (pair_fastchain0_speculativedemodcordic08 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir8 ? (pair_fastchain0_speculativedemodcordic024 >>> 4'd8) : (-(pair_fastchain0_speculativedemodcordic024 >>> 4'd8))));
	pair_fastchain0_speculativedemodcordic025 <= (pair_fastchain0_speculativedemodcordic024 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir8 ? (-(pair_fastchain0_speculativedemodcordic08 >>> 4'd8)) : (pair_fastchain0_speculativedemodcordic08 >>> 4'd8)));
	pair_fastchain0_speculativedemodcordic041 <= (pair_fastchain0_speculativedemodcordic040 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_fastchain0_speculativedemodcordic010 <= (pair_fastchain0_speculativedemodcordic09 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir9 ? (pair_fastchain0_speculativedemodcordic025 >>> 4'd9) : (-(pair_fastchain0_speculativedemodcordic025 >>> 4'd9))));
	pair_fastchain0_speculativedemodcordic026 <= (pair_fastchain0_speculativedemodcordic025 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir9 ? (-(pair_fastchain0_speculativedemodcordic09 >>> 4'd9)) : (pair_fastchain0_speculativedemodcordic09 >>> 4'd9)));
	pair_fastchain0_speculativedemodcordic042 <= (pair_fastchain0_speculativedemodcordic041 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_fastchain0_speculativedemodcordic011 <= (pair_fastchain0_speculativedemodcordic010 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir10 ? (pair_fastchain0_speculativedemodcordic026 >>> 4'd10) : (-(pair_fastchain0_speculativedemodcordic026 >>> 4'd10))));
	pair_fastchain0_speculativedemodcordic027 <= (pair_fastchain0_speculativedemodcordic026 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir10 ? (-(pair_fastchain0_speculativedemodcordic010 >>> 4'd10)) : (pair_fastchain0_speculativedemodcordic010 >>> 4'd10)));
	pair_fastchain0_speculativedemodcordic043 <= (pair_fastchain0_speculativedemodcordic042 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_fastchain0_speculativedemodcordic012 <= (pair_fastchain0_speculativedemodcordic011 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir11 ? (pair_fastchain0_speculativedemodcordic027 >>> 4'd11) : (-(pair_fastchain0_speculativedemodcordic027 >>> 4'd11))));
	pair_fastchain0_speculativedemodcordic028 <= (pair_fastchain0_speculativedemodcordic027 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir11 ? (-(pair_fastchain0_speculativedemodcordic011 >>> 4'd11)) : (pair_fastchain0_speculativedemodcordic011 >>> 4'd11)));
	pair_fastchain0_speculativedemodcordic044 <= (pair_fastchain0_speculativedemodcordic043 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_fastchain0_speculativedemodcordic013 <= (pair_fastchain0_speculativedemodcordic012 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir12 ? (pair_fastchain0_speculativedemodcordic028 >>> 4'd12) : (-(pair_fastchain0_speculativedemodcordic028 >>> 4'd12))));
	pair_fastchain0_speculativedemodcordic029 <= (pair_fastchain0_speculativedemodcordic028 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir12 ? (-(pair_fastchain0_speculativedemodcordic012 >>> 4'd12)) : (pair_fastchain0_speculativedemodcordic012 >>> 4'd12)));
	pair_fastchain0_speculativedemodcordic045 <= (pair_fastchain0_speculativedemodcordic044 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_fastchain0_speculativedemodcordic014 <= (pair_fastchain0_speculativedemodcordic013 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir13 ? (pair_fastchain0_speculativedemodcordic029 >>> 4'd13) : (-(pair_fastchain0_speculativedemodcordic029 >>> 4'd13))));
	pair_fastchain0_speculativedemodcordic030 <= (pair_fastchain0_speculativedemodcordic029 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir13 ? (-(pair_fastchain0_speculativedemodcordic013 >>> 4'd13)) : (pair_fastchain0_speculativedemodcordic013 >>> 4'd13)));
	pair_fastchain0_speculativedemodcordic046 <= (pair_fastchain0_speculativedemodcordic045 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_fastchain0_speculativedemodcordic015 <= (pair_fastchain0_speculativedemodcordic014 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir14 ? (pair_fastchain0_speculativedemodcordic030 >>> 4'd14) : (-(pair_fastchain0_speculativedemodcordic030 >>> 4'd14))));
	pair_fastchain0_speculativedemodcordic031 <= (pair_fastchain0_speculativedemodcordic030 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir14 ? (-(pair_fastchain0_speculativedemodcordic014 >>> 4'd14)) : (pair_fastchain0_speculativedemodcordic014 >>> 4'd14)));
	pair_fastchain0_speculativedemodcordic047 <= (pair_fastchain0_speculativedemodcordic046 + (pair_fastchain0_speculativedemodcordic0_speculativedemodcordic0_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	if (pair_fastchain0_limitcsr0_update_en) begin
		pair_fastchain0_limitcsr0_limit_min <= {{1{pair_fastchain0_limitcsr0_min_storage[24]}}, pair_fastchain0_limitcsr0_min_storage};
		pair_fastchain0_limitcsr0_limit_max <= {{1{pair_fastchain0_limitcsr0_max_storage[24]}}, pair_fastchain0_limitcsr0_max_storage};
		pair_fastchain0_limitcsr0_limitcsr0_y <= pair_fastchain0_limitcsr0_limit_y;
		pair_fastchain0_limitcsr0_limitcsr0_error <= pair_fastchain0_limitcsr0_limit_railed;
	end
	pair_fastchain0_iir0_a10 <= pair_fastchain0_iir0_csrstorage0_storage0;
	pair_fastchain0_iir0_b00 <= pair_fastchain0_iir0_csrstorage1_storage0;
	pair_fastchain0_iir0_b10 <= pair_fastchain0_iir0_csrstorage2_storage0;
	pair_fastchain0_iir0_z0r0 <= (pair_fastchain0_iir0_storage0 <<< 5'd23);
	pair_fastchain0_iir0_error0 <= pair_fastchain0_iir0_railed0;
	pair_fastchain0_iir0_y0 <= pair_fastchain0_iir0_y_lim0;
	if (pair_fastchain0_iir0_clear0) begin
		pair_fastchain0_iir0_y1 <= 1'd0;
	end else begin
		if ((~pair_fastchain0_iir0_hold0)) begin
			pair_fastchain0_iir0_y1 <= pair_fastchain0_iir0_y_lim0;
		end
	end
	pair_fastchain0_iir0_zr0 <= pair_fastchain0_iir0_z0r0;
	pair_fastchain0_iir0_zr_low_q0 <= pair_fastchain0_iir0_zr_low0[16:0];
	pair_fastchain0_iir0_zr_correction_q0 <= pair_fastchain0_iir0_zr_correction0;
	pair_fastchain0_iir0_zr_low_q1 <= pair_fastchain0_iir0_zr_low1[16:0];
	pair_fastchain0_iir0_zr_correction_q1 <= pair_fastchain0_iir0_zr_correction1;
	pair_fastchain0_iir0_a11 <= pair_fastchain0_iir0_csrstorage0_storage1;
	pair_fastchain0_iir0_a2 <= pair_fastchain0_iir0_csrstorage1_storage1;
	pair_fastchain0_iir0_b01 <= pair_fastchain0_iir0_csrstorage2_storage1;
	pair_fastchain0_iir0_b11 <= pair_fastchain0_iir0_csrstorage3_storage;
	pair_fastchain0_iir0_b2 <= pair_fastchain0_iir0_csrstorage4_storage;
	pair_fastchain0_iir0_z0r1 <= (pair_fastchain0_iir0_storage1 <<< 5'd23);
	pair_fastchain0_iir0_error1 <= pair_fastchain0_iir0_railed1;
	pair_fastchain0_iir0_y2 <= pair_fastchain0_iir0_y_lim1;
	if (pair_fastchain0_iir0_clear1) begin
		pair_fastchain0_iir0_y3 <= 1'd0;
	end else begin
		if ((~pair_fastchain0_iir0_hold1)) begin
			pair_fastchain0_iir0_y3 <= pair_fastchain0_iir0_y_lim1;
		end
	end
	pair_fastchain0_iir0_zr5 <= pair_fastchain0_iir0_z0r1;
	pair_fastchain0_iir0_zr_low_q2 <= pair_fastchain0_iir0_zr_low2[16:0];
	pair_fastchain0_iir0_zr_correction_q2 <= pair_fastchain0_iir0_zr_correction2;
	pair_fastchain0_iir0_zr_low_q3 <= pair_fastchain0_iir0_zr_low3[16:0];
	pair_fastchain0_iir0_zr_correction_q3 <= pair_fastchain0_iir0_zr_correction3;
	pair_fastchain0_iir0_zr_low_q4 <= pair_fastchain0_iir0_zr_low4[16:0];
	pair_fastchain0_iir0_zr_correction_q4 <= pair_fastchain0_iir0_zr_correction4;
	pair_fastchain0_iir0_zr_low_q5 <= pair_fastchain0_iir0_zr_low5[16:0];
	pair_fastchain0_iir0_zr_correction_q5 <= pair_fastchain0_iir0_zr_correction5;
	if (pair_fastchain0_paralleltaplimitcsr0_update_en) begin
		pair_fastchain0_paralleltaplimitcsr0_bound_min <= {{3{pair_fastchain0_paralleltaplimitcsr0_min_storage[24]}}, pair_fastchain0_paralleltaplimitcsr0_min_storage};
		pair_fastchain0_paralleltaplimitcsr0_bound_max <= {{3{pair_fastchain0_paralleltaplimitcsr0_max_storage[24]}}, pair_fastchain0_paralleltaplimitcsr0_max_storage};
		pair_fastchain0_paralleltaplimitcsr0_neg_bound_min <= (-$signed({1'd0, {{3{pair_fastchain0_paralleltaplimitcsr0_min_storage[24]}}, pair_fastchain0_paralleltaplimitcsr0_min_storage}}));
		pair_fastchain0_paralleltaplimitcsr0_neg_bound_max <= (-$signed({1'd0, {{3{pair_fastchain0_paralleltaplimitcsr0_max_storage[24]}}, pair_fastchain0_paralleltaplimitcsr0_max_storage}}));
		pair_fastchain0_paralleltaplimitcsr0_y <= pair_fastchain0_paralleltaplimitcsr0_pre_y;
		pair_fastchain0_paralleltaplimitcsr0_error <= pair_fastchain0_paralleltaplimitcsr0_pre_rail;
	end
	if (pair_fastchain0_limitcsr1_update_en) begin
		pair_fastchain0_limitcsr1_limit_min <= {{1{pair_fastchain0_limitcsr1_min_storage[24]}}, pair_fastchain0_limitcsr1_min_storage};
		pair_fastchain0_limitcsr1_limit_max <= {{1{pair_fastchain0_limitcsr1_max_storage[24]}}, pair_fastchain0_limitcsr1_max_storage};
		pair_fastchain0_limitcsr1_limitcsr1_y <= pair_fastchain0_limitcsr1_limit_y;
		pair_fastchain0_limitcsr1_limitcsr1_error <= pair_fastchain0_limitcsr1_limit_railed;
	end
	pair_fastchain0_iir1_a10 <= pair_fastchain0_iir1_csrstorage3_storage;
	pair_fastchain0_iir1_b00 <= pair_fastchain0_iir1_csrstorage4_storage;
	pair_fastchain0_iir1_b10 <= pair_fastchain0_iir1_csrstorage5_storage0;
	pair_fastchain0_iir1_z0r0 <= (pair_fastchain0_iir1_storage0 <<< 5'd23);
	pair_fastchain0_iir1_error0 <= pair_fastchain0_iir1_railed0;
	pair_fastchain0_iir1_y0 <= pair_fastchain0_iir1_y_lim0;
	if (pair_fastchain0_iir1_clear0) begin
		pair_fastchain0_iir1_y1 <= 1'd0;
	end else begin
		if ((~pair_fastchain0_iir1_hold0)) begin
			pair_fastchain0_iir1_y1 <= pair_fastchain0_iir1_y_lim0;
		end
	end
	pair_fastchain0_iir1_zr0 <= pair_fastchain0_iir1_z0r0;
	pair_fastchain0_iir1_zr_low_q0 <= pair_fastchain0_iir1_zr_low0[16:0];
	pair_fastchain0_iir1_zr_correction_q0 <= pair_fastchain0_iir1_zr_correction0;
	pair_fastchain0_iir1_zr_low_q1 <= pair_fastchain0_iir1_zr_low1[16:0];
	pair_fastchain0_iir1_zr_correction_q1 <= pair_fastchain0_iir1_zr_correction1;
	pair_fastchain0_iir1_a11 <= pair_fastchain0_iir1_csrstorage5_storage1;
	pair_fastchain0_iir1_a2 <= pair_fastchain0_iir1_csrstorage6_storage;
	pair_fastchain0_iir1_b01 <= pair_fastchain0_iir1_csrstorage7_storage;
	pair_fastchain0_iir1_b11 <= pair_fastchain0_iir1_csrstorage8_storage;
	pair_fastchain0_iir1_b2 <= pair_fastchain0_iir1_csrstorage9_storage;
	pair_fastchain0_iir1_z0r1 <= (pair_fastchain0_iir1_storage1 <<< 5'd23);
	pair_fastchain0_iir1_error1 <= pair_fastchain0_iir1_railed1;
	pair_fastchain0_iir1_y2 <= pair_fastchain0_iir1_y_lim1;
	if (pair_fastchain0_iir1_clear1) begin
		pair_fastchain0_iir1_y3 <= 1'd0;
	end else begin
		if ((~pair_fastchain0_iir1_hold1)) begin
			pair_fastchain0_iir1_y3 <= pair_fastchain0_iir1_y_lim1;
		end
	end
	pair_fastchain0_iir1_zr5 <= pair_fastchain0_iir1_z0r1;
	pair_fastchain0_iir1_zr_low_q2 <= pair_fastchain0_iir1_zr_low2[16:0];
	pair_fastchain0_iir1_zr_correction_q2 <= pair_fastchain0_iir1_zr_correction2;
	pair_fastchain0_iir1_zr_low_q3 <= pair_fastchain0_iir1_zr_low3[16:0];
	pair_fastchain0_iir1_zr_correction_q3 <= pair_fastchain0_iir1_zr_correction3;
	pair_fastchain0_iir1_zr_low_q4 <= pair_fastchain0_iir1_zr_low4[16:0];
	pair_fastchain0_iir1_zr_correction_q4 <= pair_fastchain0_iir1_zr_correction4;
	pair_fastchain0_iir1_zr_low_q5 <= pair_fastchain0_iir1_zr_low5[16:0];
	pair_fastchain0_iir1_zr_correction_q5 <= pair_fastchain0_iir1_zr_correction5;
	if (pair_fastchain0_paralleltaplimitcsr1_update_en) begin
		pair_fastchain0_paralleltaplimitcsr1_bound_min <= {{3{pair_fastchain0_paralleltaplimitcsr1_min_storage[24]}}, pair_fastchain0_paralleltaplimitcsr1_min_storage};
		pair_fastchain0_paralleltaplimitcsr1_bound_max <= {{3{pair_fastchain0_paralleltaplimitcsr1_max_storage[24]}}, pair_fastchain0_paralleltaplimitcsr1_max_storage};
		pair_fastchain0_paralleltaplimitcsr1_neg_bound_min <= (-$signed({1'd0, {{3{pair_fastchain0_paralleltaplimitcsr1_min_storage[24]}}, pair_fastchain0_paralleltaplimitcsr1_min_storage}}));
		pair_fastchain0_paralleltaplimitcsr1_neg_bound_max <= (-$signed({1'd0, {{3{pair_fastchain0_paralleltaplimitcsr1_max_storage[24]}}, pair_fastchain0_paralleltaplimitcsr1_max_storage}}));
		pair_fastchain0_paralleltaplimitcsr1_y <= pair_fastchain0_paralleltaplimitcsr1_pre_y;
		pair_fastchain0_paralleltaplimitcsr1_error <= pair_fastchain0_paralleltaplimitcsr1_pre_rail;
	end
	pair_csrbank0_bus_dat_r <= 1'd0;
	if (pair_csrbank0_sel) begin
		case (pair_csrbank0_bus_adr[6:0])
			1'd0: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_tap0_w;
			end
			1'd1: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_invert0_w;
			end
			2'd2: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_demod_delay3_w;
			end
			2'd3: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_demod_delay2_w;
			end
			3'd4: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_demod_delay1_w;
			end
			3'd5: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_demod_delay0_w;
			end
			3'd6: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_demod_multiplier0_w;
			end
			3'd7: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_min3_w;
			end
			4'd8: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_min2_w;
			end
			4'd9: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_min1_w;
			end
			4'd10: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_min0_w;
			end
			4'd11: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_max3_w;
			end
			4'd12: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_max2_w;
			end
			4'd13: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_max1_w;
			end
			4'd14: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_1_max0_w;
			end
			4'd15: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_z03_w;
			end
			5'd16: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_z02_w;
			end
			5'd17: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_z01_w;
			end
			5'd18: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_z00_w;
			end
			5'd19: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_a13_w;
			end
			5'd20: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_a12_w;
			end
			5'd21: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_a11_w;
			end
			5'd22: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_a10_w;
			end
			5'd23: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b03_w;
			end
			5'd24: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b02_w;
			end
			5'd25: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b01_w;
			end
			5'd26: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b00_w;
			end
			5'd27: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b13_w;
			end
			5'd28: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b12_w;
			end
			5'd29: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b11_w;
			end
			5'd30: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_1_b10_w;
			end
			5'd31: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_z03_w;
			end
			6'd32: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_z02_w;
			end
			6'd33: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_z01_w;
			end
			6'd34: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_z00_w;
			end
			6'd35: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a13_w;
			end
			6'd36: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a12_w;
			end
			6'd37: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a11_w;
			end
			6'd38: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a10_w;
			end
			6'd39: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a23_w;
			end
			6'd40: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a22_w;
			end
			6'd41: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a21_w;
			end
			6'd42: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_a20_w;
			end
			6'd43: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b03_w;
			end
			6'd44: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b02_w;
			end
			6'd45: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b01_w;
			end
			6'd46: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b00_w;
			end
			6'd47: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b13_w;
			end
			6'd48: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b12_w;
			end
			6'd49: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b11_w;
			end
			6'd50: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b10_w;
			end
			6'd51: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b23_w;
			end
			6'd52: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b22_w;
			end
			6'd53: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b21_w;
			end
			6'd54: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_1_b20_w;
			end
			6'd55: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_min3_w;
			end
			6'd56: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_min2_w;
			end
			6'd57: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_min1_w;
			end
			6'd58: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_min0_w;
			end
			6'd59: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_max3_w;
			end
			6'd60: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_max2_w;
			end
			6'd61: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_max1_w;
			end
			6'd62: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_1_max0_w;
			end
			6'd63: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_min3_w;
			end
			7'd64: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_min2_w;
			end
			7'd65: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_min1_w;
			end
			7'd66: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_min0_w;
			end
			7'd67: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_max3_w;
			end
			7'd68: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_max2_w;
			end
			7'd69: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_max1_w;
			end
			7'd70: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_x_limit_2_max0_w;
			end
			7'd71: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_z03_w;
			end
			7'd72: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_z02_w;
			end
			7'd73: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_z01_w;
			end
			7'd74: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_z00_w;
			end
			7'd75: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_a13_w;
			end
			7'd76: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_a12_w;
			end
			7'd77: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_a11_w;
			end
			7'd78: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_a10_w;
			end
			7'd79: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b03_w;
			end
			7'd80: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b02_w;
			end
			7'd81: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b01_w;
			end
			7'd82: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b00_w;
			end
			7'd83: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b13_w;
			end
			7'd84: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b12_w;
			end
			7'd85: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b11_w;
			end
			7'd86: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_c_2_b10_w;
			end
			7'd87: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_z03_w;
			end
			7'd88: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_z02_w;
			end
			7'd89: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_z01_w;
			end
			7'd90: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_z00_w;
			end
			7'd91: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a13_w;
			end
			7'd92: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a12_w;
			end
			7'd93: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a11_w;
			end
			7'd94: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a10_w;
			end
			7'd95: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a23_w;
			end
			7'd96: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a22_w;
			end
			7'd97: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a21_w;
			end
			7'd98: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_a20_w;
			end
			7'd99: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b03_w;
			end
			7'd100: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b02_w;
			end
			7'd101: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b01_w;
			end
			7'd102: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b00_w;
			end
			7'd103: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b13_w;
			end
			7'd104: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b12_w;
			end
			7'd105: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b11_w;
			end
			7'd106: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b10_w;
			end
			7'd107: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b23_w;
			end
			7'd108: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b22_w;
			end
			7'd109: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b21_w;
			end
			7'd110: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_iir_d_2_b20_w;
			end
			7'd111: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_min3_w;
			end
			7'd112: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_min2_w;
			end
			7'd113: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_min1_w;
			end
			7'd114: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_min0_w;
			end
			7'd115: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_max3_w;
			end
			7'd116: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_max2_w;
			end
			7'd117: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_max1_w;
			end
			7'd118: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_y_limit_2_max0_w;
			end
		endcase
	end
	if (pair_csrbank0_y_tap0_re) begin
		pair_fastchain0_y_tap_storage_full[1:0] <= pair_csrbank0_y_tap0_r;
	end
	pair_fastchain0_y_tap_re <= pair_csrbank0_y_tap0_re;
	if (pair_csrbank0_invert0_re) begin
		pair_fastchain0_invert_storage_full <= pair_csrbank0_invert0_r;
	end
	pair_fastchain0_invert_re <= pair_csrbank0_invert0_re;
	if (pair_csrbank0_demod_delay3_re) begin
		pair_fastchain0_delay_storage_full[31:24] <= pair_csrbank0_demod_delay3_r;
	end
	if (pair_csrbank0_demod_delay2_re) begin
		pair_fastchain0_delay_storage_full[23:16] <= pair_csrbank0_demod_delay2_r;
	end
	if (pair_csrbank0_demod_delay1_re) begin
		pair_fastchain0_delay_storage_full[15:8] <= pair_csrbank0_demod_delay1_r;
	end
	if (pair_csrbank0_demod_delay0_re) begin
		pair_fastchain0_delay_storage_full[7:0] <= pair_csrbank0_demod_delay0_r;
	end
	pair_fastchain0_delay_re <= pair_csrbank0_demod_delay0_re;
	if (pair_csrbank0_demod_multiplier0_re) begin
		pair_fastchain0_multiplier_storage_full[3:0] <= pair_csrbank0_demod_multiplier0_r;
	end
	pair_fastchain0_multiplier_re <= pair_csrbank0_demod_multiplier0_re;
	if (pair_csrbank0_x_limit_1_min3_re) begin
		pair_fastchain0_limitcsr0_min_storage_full[24] <= pair_csrbank0_x_limit_1_min3_r;
	end
	if (pair_csrbank0_x_limit_1_min2_re) begin
		pair_fastchain0_limitcsr0_min_storage_full[23:16] <= pair_csrbank0_x_limit_1_min2_r;
	end
	if (pair_csrbank0_x_limit_1_min1_re) begin
		pair_fastchain0_limitcsr0_min_storage_full[15:8] <= pair_csrbank0_x_limit_1_min1_r;
	end
	if (pair_csrbank0_x_limit_1_min0_re) begin
		pair_fastchain0_limitcsr0_min_storage_full[7:0] <= pair_csrbank0_x_limit_1_min0_r;
	end
	pair_fastchain0_limitcsr0_min_re <= pair_csrbank0_x_limit_1_min0_re;
	if (pair_csrbank0_x_limit_1_max3_re) begin
		pair_fastchain0_limitcsr0_max_storage_full[24] <= pair_csrbank0_x_limit_1_max3_r;
	end
	if (pair_csrbank0_x_limit_1_max2_re) begin
		pair_fastchain0_limitcsr0_max_storage_full[23:16] <= pair_csrbank0_x_limit_1_max2_r;
	end
	if (pair_csrbank0_x_limit_1_max1_re) begin
		pair_fastchain0_limitcsr0_max_storage_full[15:8] <= pair_csrbank0_x_limit_1_max1_r;
	end
	if (pair_csrbank0_x_limit_1_max0_re) begin
		pair_fastchain0_limitcsr0_max_storage_full[7:0] <= pair_csrbank0_x_limit_1_max0_r;
	end
	pair_fastchain0_limitcsr0_max_re <= pair_csrbank0_x_limit_1_max0_re;
	if (pair_csrbank0_iir_c_1_z03_re) begin
		pair_fastchain0_iir0_storage_full0[26:24] <= pair_csrbank0_iir_c_1_z03_r;
	end
	if (pair_csrbank0_iir_c_1_z02_re) begin
		pair_fastchain0_iir0_storage_full0[23:16] <= pair_csrbank0_iir_c_1_z02_r;
	end
	if (pair_csrbank0_iir_c_1_z01_re) begin
		pair_fastchain0_iir0_storage_full0[15:8] <= pair_csrbank0_iir_c_1_z01_r;
	end
	if (pair_csrbank0_iir_c_1_z00_re) begin
		pair_fastchain0_iir0_storage_full0[7:0] <= pair_csrbank0_iir_c_1_z00_r;
	end
	pair_fastchain0_iir0_re0 <= pair_csrbank0_iir_c_1_z00_re;
	if (pair_csrbank0_iir_c_1_a13_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full0[24] <= pair_csrbank0_iir_c_1_a13_r;
	end
	if (pair_csrbank0_iir_c_1_a12_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full0[23:16] <= pair_csrbank0_iir_c_1_a12_r;
	end
	if (pair_csrbank0_iir_c_1_a11_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full0[15:8] <= pair_csrbank0_iir_c_1_a11_r;
	end
	if (pair_csrbank0_iir_c_1_a10_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full0[7:0] <= pair_csrbank0_iir_c_1_a10_r;
	end
	pair_fastchain0_iir0_csrstorage0_re0 <= pair_csrbank0_iir_c_1_a10_re;
	if (pair_csrbank0_iir_c_1_b03_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full0[24] <= pair_csrbank0_iir_c_1_b03_r;
	end
	if (pair_csrbank0_iir_c_1_b02_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full0[23:16] <= pair_csrbank0_iir_c_1_b02_r;
	end
	if (pair_csrbank0_iir_c_1_b01_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full0[15:8] <= pair_csrbank0_iir_c_1_b01_r;
	end
	if (pair_csrbank0_iir_c_1_b00_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full0[7:0] <= pair_csrbank0_iir_c_1_b00_r;
	end
	pair_fastchain0_iir0_csrstorage1_re0 <= pair_csrbank0_iir_c_1_b00_re;
	if (pair_csrbank0_iir_c_1_b13_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full0[24] <= pair_csrbank0_iir_c_1_b13_r;
	end
	if (pair_csrbank0_iir_c_1_b12_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full0[23:16] <= pair_csrbank0_iir_c_1_b12_r;
	end
	if (pair_csrbank0_iir_c_1_b11_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full0[15:8] <= pair_csrbank0_iir_c_1_b11_r;
	end
	if (pair_csrbank0_iir_c_1_b10_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full0[7:0] <= pair_csrbank0_iir_c_1_b10_r;
	end
	pair_fastchain0_iir0_csrstorage2_re0 <= pair_csrbank0_iir_c_1_b10_re;
	if (pair_csrbank0_iir_d_1_z03_re) begin
		pair_fastchain0_iir0_storage_full1[26:24] <= pair_csrbank0_iir_d_1_z03_r;
	end
	if (pair_csrbank0_iir_d_1_z02_re) begin
		pair_fastchain0_iir0_storage_full1[23:16] <= pair_csrbank0_iir_d_1_z02_r;
	end
	if (pair_csrbank0_iir_d_1_z01_re) begin
		pair_fastchain0_iir0_storage_full1[15:8] <= pair_csrbank0_iir_d_1_z01_r;
	end
	if (pair_csrbank0_iir_d_1_z00_re) begin
		pair_fastchain0_iir0_storage_full1[7:0] <= pair_csrbank0_iir_d_1_z00_r;
	end
	pair_fastchain0_iir0_re1 <= pair_csrbank0_iir_d_1_z00_re;
	if (pair_csrbank0_iir_d_1_a13_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full1[24] <= pair_csrbank0_iir_d_1_a13_r;
	end
	if (pair_csrbank0_iir_d_1_a12_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full1[23:16] <= pair_csrbank0_iir_d_1_a12_r;
	end
	if (pair_csrbank0_iir_d_1_a11_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full1[15:8] <= pair_csrbank0_iir_d_1_a11_r;
	end
	if (pair_csrbank0_iir_d_1_a10_re) begin
		pair_fastchain0_iir0_csrstorage0_storage_full1[7:0] <= pair_csrbank0_iir_d_1_a10_r;
	end
	pair_fastchain0_iir0_csrstorage0_re1 <= pair_csrbank0_iir_d_1_a10_re;
	if (pair_csrbank0_iir_d_1_a23_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full1[24] <= pair_csrbank0_iir_d_1_a23_r;
	end
	if (pair_csrbank0_iir_d_1_a22_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full1[23:16] <= pair_csrbank0_iir_d_1_a22_r;
	end
	if (pair_csrbank0_iir_d_1_a21_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full1[15:8] <= pair_csrbank0_iir_d_1_a21_r;
	end
	if (pair_csrbank0_iir_d_1_a20_re) begin
		pair_fastchain0_iir0_csrstorage1_storage_full1[7:0] <= pair_csrbank0_iir_d_1_a20_r;
	end
	pair_fastchain0_iir0_csrstorage1_re1 <= pair_csrbank0_iir_d_1_a20_re;
	if (pair_csrbank0_iir_d_1_b03_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full1[24] <= pair_csrbank0_iir_d_1_b03_r;
	end
	if (pair_csrbank0_iir_d_1_b02_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full1[23:16] <= pair_csrbank0_iir_d_1_b02_r;
	end
	if (pair_csrbank0_iir_d_1_b01_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full1[15:8] <= pair_csrbank0_iir_d_1_b01_r;
	end
	if (pair_csrbank0_iir_d_1_b00_re) begin
		pair_fastchain0_iir0_csrstorage2_storage_full1[7:0] <= pair_csrbank0_iir_d_1_b00_r;
	end
	pair_fastchain0_iir0_csrstorage2_re1 <= pair_csrbank0_iir_d_1_b00_re;
	if (pair_csrbank0_iir_d_1_b13_re) begin
		pair_fastchain0_iir0_csrstorage3_storage_full[24] <= pair_csrbank0_iir_d_1_b13_r;
	end
	if (pair_csrbank0_iir_d_1_b12_re) begin
		pair_fastchain0_iir0_csrstorage3_storage_full[23:16] <= pair_csrbank0_iir_d_1_b12_r;
	end
	if (pair_csrbank0_iir_d_1_b11_re) begin
		pair_fastchain0_iir0_csrstorage3_storage_full[15:8] <= pair_csrbank0_iir_d_1_b11_r;
	end
	if (pair_csrbank0_iir_d_1_b10_re) begin
		pair_fastchain0_iir0_csrstorage3_storage_full[7:0] <= pair_csrbank0_iir_d_1_b10_r;
	end
	pair_fastchain0_iir0_csrstorage3_re <= pair_csrbank0_iir_d_1_b10_re;
	if (pair_csrbank0_iir_d_1_b23_re) begin
		pair_fastchain0_iir0_csrstorage4_storage_full[24] <= pair_csrbank0_iir_d_1_b23_r;
	end
	if (pair_csrbank0_iir_d_1_b22_re) begin
		pair_fastchain0_iir0_csrstorage4_storage_full[23:16] <= pair_csrbank0_iir_d_1_b22_r;
	end
	if (pair_csrbank0_iir_d_1_b21_re) begin
		pair_fastchain0_iir0_csrstorage4_storage_full[15:8] <= pair_csrbank0_iir_d_1_b21_r;
	end
	if (pair_csrbank0_iir_d_1_b20_re) begin
		pair_fastchain0_iir0_csrstorage4_storage_full[7:0] <= pair_csrbank0_iir_d_1_b20_r;
	end
	pair_fastchain0_iir0_csrstorage4_re <= pair_csrbank0_iir_d_1_b20_re;
	if (pair_csrbank0_y_limit_1_min3_re) begin
		pair_fastchain0_paralleltaplimitcsr0_min_storage_full[24] <= pair_csrbank0_y_limit_1_min3_r;
	end
	if (pair_csrbank0_y_limit_1_min2_re) begin
		pair_fastchain0_paralleltaplimitcsr0_min_storage_full[23:16] <= pair_csrbank0_y_limit_1_min2_r;
	end
	if (pair_csrbank0_y_limit_1_min1_re) begin
		pair_fastchain0_paralleltaplimitcsr0_min_storage_full[15:8] <= pair_csrbank0_y_limit_1_min1_r;
	end
	if (pair_csrbank0_y_limit_1_min0_re) begin
		pair_fastchain0_paralleltaplimitcsr0_min_storage_full[7:0] <= pair_csrbank0_y_limit_1_min0_r;
	end
	pair_fastchain0_paralleltaplimitcsr0_min_re <= pair_csrbank0_y_limit_1_min0_re;
	if (pair_csrbank0_y_limit_1_max3_re) begin
		pair_fastchain0_paralleltaplimitcsr0_max_storage_full[24] <= pair_csrbank0_y_limit_1_max3_r;
	end
	if (pair_csrbank0_y_limit_1_max2_re) begin
		pair_fastchain0_paralleltaplimitcsr0_max_storage_full[23:16] <= pair_csrbank0_y_limit_1_max2_r;
	end
	if (pair_csrbank0_y_limit_1_max1_re) begin
		pair_fastchain0_paralleltaplimitcsr0_max_storage_full[15:8] <= pair_csrbank0_y_limit_1_max1_r;
	end
	if (pair_csrbank0_y_limit_1_max0_re) begin
		pair_fastchain0_paralleltaplimitcsr0_max_storage_full[7:0] <= pair_csrbank0_y_limit_1_max0_r;
	end
	pair_fastchain0_paralleltaplimitcsr0_max_re <= pair_csrbank0_y_limit_1_max0_re;
	if (pair_csrbank0_x_limit_2_min3_re) begin
		pair_fastchain0_limitcsr1_min_storage_full[24] <= pair_csrbank0_x_limit_2_min3_r;
	end
	if (pair_csrbank0_x_limit_2_min2_re) begin
		pair_fastchain0_limitcsr1_min_storage_full[23:16] <= pair_csrbank0_x_limit_2_min2_r;
	end
	if (pair_csrbank0_x_limit_2_min1_re) begin
		pair_fastchain0_limitcsr1_min_storage_full[15:8] <= pair_csrbank0_x_limit_2_min1_r;
	end
	if (pair_csrbank0_x_limit_2_min0_re) begin
		pair_fastchain0_limitcsr1_min_storage_full[7:0] <= pair_csrbank0_x_limit_2_min0_r;
	end
	pair_fastchain0_limitcsr1_min_re <= pair_csrbank0_x_limit_2_min0_re;
	if (pair_csrbank0_x_limit_2_max3_re) begin
		pair_fastchain0_limitcsr1_max_storage_full[24] <= pair_csrbank0_x_limit_2_max3_r;
	end
	if (pair_csrbank0_x_limit_2_max2_re) begin
		pair_fastchain0_limitcsr1_max_storage_full[23:16] <= pair_csrbank0_x_limit_2_max2_r;
	end
	if (pair_csrbank0_x_limit_2_max1_re) begin
		pair_fastchain0_limitcsr1_max_storage_full[15:8] <= pair_csrbank0_x_limit_2_max1_r;
	end
	if (pair_csrbank0_x_limit_2_max0_re) begin
		pair_fastchain0_limitcsr1_max_storage_full[7:0] <= pair_csrbank0_x_limit_2_max0_r;
	end
	pair_fastchain0_limitcsr1_max_re <= pair_csrbank0_x_limit_2_max0_re;
	if (pair_csrbank0_iir_c_2_z03_re) begin
		pair_fastchain0_iir1_storage_full0[26:24] <= pair_csrbank0_iir_c_2_z03_r;
	end
	if (pair_csrbank0_iir_c_2_z02_re) begin
		pair_fastchain0_iir1_storage_full0[23:16] <= pair_csrbank0_iir_c_2_z02_r;
	end
	if (pair_csrbank0_iir_c_2_z01_re) begin
		pair_fastchain0_iir1_storage_full0[15:8] <= pair_csrbank0_iir_c_2_z01_r;
	end
	if (pair_csrbank0_iir_c_2_z00_re) begin
		pair_fastchain0_iir1_storage_full0[7:0] <= pair_csrbank0_iir_c_2_z00_r;
	end
	pair_fastchain0_iir1_re0 <= pair_csrbank0_iir_c_2_z00_re;
	if (pair_csrbank0_iir_c_2_a13_re) begin
		pair_fastchain0_iir1_csrstorage3_storage_full[24] <= pair_csrbank0_iir_c_2_a13_r;
	end
	if (pair_csrbank0_iir_c_2_a12_re) begin
		pair_fastchain0_iir1_csrstorage3_storage_full[23:16] <= pair_csrbank0_iir_c_2_a12_r;
	end
	if (pair_csrbank0_iir_c_2_a11_re) begin
		pair_fastchain0_iir1_csrstorage3_storage_full[15:8] <= pair_csrbank0_iir_c_2_a11_r;
	end
	if (pair_csrbank0_iir_c_2_a10_re) begin
		pair_fastchain0_iir1_csrstorage3_storage_full[7:0] <= pair_csrbank0_iir_c_2_a10_r;
	end
	pair_fastchain0_iir1_csrstorage3_re <= pair_csrbank0_iir_c_2_a10_re;
	if (pair_csrbank0_iir_c_2_b03_re) begin
		pair_fastchain0_iir1_csrstorage4_storage_full[24] <= pair_csrbank0_iir_c_2_b03_r;
	end
	if (pair_csrbank0_iir_c_2_b02_re) begin
		pair_fastchain0_iir1_csrstorage4_storage_full[23:16] <= pair_csrbank0_iir_c_2_b02_r;
	end
	if (pair_csrbank0_iir_c_2_b01_re) begin
		pair_fastchain0_iir1_csrstorage4_storage_full[15:8] <= pair_csrbank0_iir_c_2_b01_r;
	end
	if (pair_csrbank0_iir_c_2_b00_re) begin
		pair_fastchain0_iir1_csrstorage4_storage_full[7:0] <= pair_csrbank0_iir_c_2_b00_r;
	end
	pair_fastchain0_iir1_csrstorage4_re <= pair_csrbank0_iir_c_2_b00_re;
	if (pair_csrbank0_iir_c_2_b13_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full0[24] <= pair_csrbank0_iir_c_2_b13_r;
	end
	if (pair_csrbank0_iir_c_2_b12_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full0[23:16] <= pair_csrbank0_iir_c_2_b12_r;
	end
	if (pair_csrbank0_iir_c_2_b11_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full0[15:8] <= pair_csrbank0_iir_c_2_b11_r;
	end
	if (pair_csrbank0_iir_c_2_b10_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full0[7:0] <= pair_csrbank0_iir_c_2_b10_r;
	end
	pair_fastchain0_iir1_csrstorage5_re0 <= pair_csrbank0_iir_c_2_b10_re;
	if (pair_csrbank0_iir_d_2_z03_re) begin
		pair_fastchain0_iir1_storage_full1[26:24] <= pair_csrbank0_iir_d_2_z03_r;
	end
	if (pair_csrbank0_iir_d_2_z02_re) begin
		pair_fastchain0_iir1_storage_full1[23:16] <= pair_csrbank0_iir_d_2_z02_r;
	end
	if (pair_csrbank0_iir_d_2_z01_re) begin
		pair_fastchain0_iir1_storage_full1[15:8] <= pair_csrbank0_iir_d_2_z01_r;
	end
	if (pair_csrbank0_iir_d_2_z00_re) begin
		pair_fastchain0_iir1_storage_full1[7:0] <= pair_csrbank0_iir_d_2_z00_r;
	end
	pair_fastchain0_iir1_re1 <= pair_csrbank0_iir_d_2_z00_re;
	if (pair_csrbank0_iir_d_2_a13_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full1[24] <= pair_csrbank0_iir_d_2_a13_r;
	end
	if (pair_csrbank0_iir_d_2_a12_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full1[23:16] <= pair_csrbank0_iir_d_2_a12_r;
	end
	if (pair_csrbank0_iir_d_2_a11_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full1[15:8] <= pair_csrbank0_iir_d_2_a11_r;
	end
	if (pair_csrbank0_iir_d_2_a10_re) begin
		pair_fastchain0_iir1_csrstorage5_storage_full1[7:0] <= pair_csrbank0_iir_d_2_a10_r;
	end
	pair_fastchain0_iir1_csrstorage5_re1 <= pair_csrbank0_iir_d_2_a10_re;
	if (pair_csrbank0_iir_d_2_a23_re) begin
		pair_fastchain0_iir1_csrstorage6_storage_full[24] <= pair_csrbank0_iir_d_2_a23_r;
	end
	if (pair_csrbank0_iir_d_2_a22_re) begin
		pair_fastchain0_iir1_csrstorage6_storage_full[23:16] <= pair_csrbank0_iir_d_2_a22_r;
	end
	if (pair_csrbank0_iir_d_2_a21_re) begin
		pair_fastchain0_iir1_csrstorage6_storage_full[15:8] <= pair_csrbank0_iir_d_2_a21_r;
	end
	if (pair_csrbank0_iir_d_2_a20_re) begin
		pair_fastchain0_iir1_csrstorage6_storage_full[7:0] <= pair_csrbank0_iir_d_2_a20_r;
	end
	pair_fastchain0_iir1_csrstorage6_re <= pair_csrbank0_iir_d_2_a20_re;
	if (pair_csrbank0_iir_d_2_b03_re) begin
		pair_fastchain0_iir1_csrstorage7_storage_full[24] <= pair_csrbank0_iir_d_2_b03_r;
	end
	if (pair_csrbank0_iir_d_2_b02_re) begin
		pair_fastchain0_iir1_csrstorage7_storage_full[23:16] <= pair_csrbank0_iir_d_2_b02_r;
	end
	if (pair_csrbank0_iir_d_2_b01_re) begin
		pair_fastchain0_iir1_csrstorage7_storage_full[15:8] <= pair_csrbank0_iir_d_2_b01_r;
	end
	if (pair_csrbank0_iir_d_2_b00_re) begin
		pair_fastchain0_iir1_csrstorage7_storage_full[7:0] <= pair_csrbank0_iir_d_2_b00_r;
	end
	pair_fastchain0_iir1_csrstorage7_re <= pair_csrbank0_iir_d_2_b00_re;
	if (pair_csrbank0_iir_d_2_b13_re) begin
		pair_fastchain0_iir1_csrstorage8_storage_full[24] <= pair_csrbank0_iir_d_2_b13_r;
	end
	if (pair_csrbank0_iir_d_2_b12_re) begin
		pair_fastchain0_iir1_csrstorage8_storage_full[23:16] <= pair_csrbank0_iir_d_2_b12_r;
	end
	if (pair_csrbank0_iir_d_2_b11_re) begin
		pair_fastchain0_iir1_csrstorage8_storage_full[15:8] <= pair_csrbank0_iir_d_2_b11_r;
	end
	if (pair_csrbank0_iir_d_2_b10_re) begin
		pair_fastchain0_iir1_csrstorage8_storage_full[7:0] <= pair_csrbank0_iir_d_2_b10_r;
	end
	pair_fastchain0_iir1_csrstorage8_re <= pair_csrbank0_iir_d_2_b10_re;
	if (pair_csrbank0_iir_d_2_b23_re) begin
		pair_fastchain0_iir1_csrstorage9_storage_full[24] <= pair_csrbank0_iir_d_2_b23_r;
	end
	if (pair_csrbank0_iir_d_2_b22_re) begin
		pair_fastchain0_iir1_csrstorage9_storage_full[23:16] <= pair_csrbank0_iir_d_2_b22_r;
	end
	if (pair_csrbank0_iir_d_2_b21_re) begin
		pair_fastchain0_iir1_csrstorage9_storage_full[15:8] <= pair_csrbank0_iir_d_2_b21_r;
	end
	if (pair_csrbank0_iir_d_2_b20_re) begin
		pair_fastchain0_iir1_csrstorage9_storage_full[7:0] <= pair_csrbank0_iir_d_2_b20_r;
	end
	pair_fastchain0_iir1_csrstorage9_re <= pair_csrbank0_iir_d_2_b20_re;
	if (pair_csrbank0_y_limit_2_min3_re) begin
		pair_fastchain0_paralleltaplimitcsr1_min_storage_full[24] <= pair_csrbank0_y_limit_2_min3_r;
	end
	if (pair_csrbank0_y_limit_2_min2_re) begin
		pair_fastchain0_paralleltaplimitcsr1_min_storage_full[23:16] <= pair_csrbank0_y_limit_2_min2_r;
	end
	if (pair_csrbank0_y_limit_2_min1_re) begin
		pair_fastchain0_paralleltaplimitcsr1_min_storage_full[15:8] <= pair_csrbank0_y_limit_2_min1_r;
	end
	if (pair_csrbank0_y_limit_2_min0_re) begin
		pair_fastchain0_paralleltaplimitcsr1_min_storage_full[7:0] <= pair_csrbank0_y_limit_2_min0_r;
	end
	pair_fastchain0_paralleltaplimitcsr1_min_re <= pair_csrbank0_y_limit_2_min0_re;
	if (pair_csrbank0_y_limit_2_max3_re) begin
		pair_fastchain0_paralleltaplimitcsr1_max_storage_full[24] <= pair_csrbank0_y_limit_2_max3_r;
	end
	if (pair_csrbank0_y_limit_2_max2_re) begin
		pair_fastchain0_paralleltaplimitcsr1_max_storage_full[23:16] <= pair_csrbank0_y_limit_2_max2_r;
	end
	if (pair_csrbank0_y_limit_2_max1_re) begin
		pair_fastchain0_paralleltaplimitcsr1_max_storage_full[15:8] <= pair_csrbank0_y_limit_2_max1_r;
	end
	if (pair_csrbank0_y_limit_2_max0_re) begin
		pair_fastchain0_paralleltaplimitcsr1_max_storage_full[7:0] <= pair_csrbank0_y_limit_2_max0_r;
	end
	pair_fastchain0_paralleltaplimitcsr1_max_re <= pair_csrbank0_y_limit_2_max0_re;
	pair_fastchain1_ya <= (pair_fastchain1_dy >>> 4'd11);
	pair_fastchain1_speculativedemodcordic11 <= ((pair_fastchain1_phase_value[13] ^ pair_fastchain1_phase_value[14]) ? pair_fastchain1_speculativedemodcordic1_speculativedemodcordic11 : pair_fastchain1_speculativedemodcordic1_speculativedemodcordic10);
	pair_fastchain1_speculativedemodcordic117 <= (pair_fastchain1_phase_value[14] ? pair_fastchain1_speculativedemodcordic1_speculativedemodcordic11 : pair_fastchain1_speculativedemodcordic1_speculativedemodcordic10);
	pair_fastchain1_speculativedemodcordic133 <= (pair_fastchain1_speculativedemodcordic132 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	pair_fastchain1_speculativedemodcordic12 <= (pair_fastchain1_speculativedemodcordic11 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir1 ? (pair_fastchain1_speculativedemodcordic117 >>> 1'd1) : (-(pair_fastchain1_speculativedemodcordic117 >>> 1'd1))));
	pair_fastchain1_speculativedemodcordic118 <= (pair_fastchain1_speculativedemodcordic117 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir1 ? (-(pair_fastchain1_speculativedemodcordic11 >>> 1'd1)) : (pair_fastchain1_speculativedemodcordic11 >>> 1'd1)));
	pair_fastchain1_speculativedemodcordic134 <= (pair_fastchain1_speculativedemodcordic133 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	pair_fastchain1_speculativedemodcordic13 <= (pair_fastchain1_speculativedemodcordic12 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir2 ? (pair_fastchain1_speculativedemodcordic118 >>> 2'd2) : (-(pair_fastchain1_speculativedemodcordic118 >>> 2'd2))));
	pair_fastchain1_speculativedemodcordic119 <= (pair_fastchain1_speculativedemodcordic118 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir2 ? (-(pair_fastchain1_speculativedemodcordic12 >>> 2'd2)) : (pair_fastchain1_speculativedemodcordic12 >>> 2'd2)));
	pair_fastchain1_speculativedemodcordic135 <= (pair_fastchain1_speculativedemodcordic134 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	pair_fastchain1_speculativedemodcordic14 <= (pair_fastchain1_speculativedemodcordic13 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir3 ? (pair_fastchain1_speculativedemodcordic119 >>> 2'd3) : (-(pair_fastchain1_speculativedemodcordic119 >>> 2'd3))));
	pair_fastchain1_speculativedemodcordic120 <= (pair_fastchain1_speculativedemodcordic119 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir3 ? (-(pair_fastchain1_speculativedemodcordic13 >>> 2'd3)) : (pair_fastchain1_speculativedemodcordic13 >>> 2'd3)));
	pair_fastchain1_speculativedemodcordic136 <= (pair_fastchain1_speculativedemodcordic135 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	pair_fastchain1_speculativedemodcordic15 <= (pair_fastchain1_speculativedemodcordic14 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir4 ? (pair_fastchain1_speculativedemodcordic120 >>> 3'd4) : (-(pair_fastchain1_speculativedemodcordic120 >>> 3'd4))));
	pair_fastchain1_speculativedemodcordic121 <= (pair_fastchain1_speculativedemodcordic120 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir4 ? (-(pair_fastchain1_speculativedemodcordic14 >>> 3'd4)) : (pair_fastchain1_speculativedemodcordic14 >>> 3'd4)));
	pair_fastchain1_speculativedemodcordic137 <= (pair_fastchain1_speculativedemodcordic136 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	pair_fastchain1_speculativedemodcordic16 <= (pair_fastchain1_speculativedemodcordic15 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir5 ? (pair_fastchain1_speculativedemodcordic121 >>> 3'd5) : (-(pair_fastchain1_speculativedemodcordic121 >>> 3'd5))));
	pair_fastchain1_speculativedemodcordic122 <= (pair_fastchain1_speculativedemodcordic121 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir5 ? (-(pair_fastchain1_speculativedemodcordic15 >>> 3'd5)) : (pair_fastchain1_speculativedemodcordic15 >>> 3'd5)));
	pair_fastchain1_speculativedemodcordic138 <= (pair_fastchain1_speculativedemodcordic137 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_fastchain1_speculativedemodcordic17 <= (pair_fastchain1_speculativedemodcordic16 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir6 ? (pair_fastchain1_speculativedemodcordic122 >>> 3'd6) : (-(pair_fastchain1_speculativedemodcordic122 >>> 3'd6))));
	pair_fastchain1_speculativedemodcordic123 <= (pair_fastchain1_speculativedemodcordic122 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir6 ? (-(pair_fastchain1_speculativedemodcordic16 >>> 3'd6)) : (pair_fastchain1_speculativedemodcordic16 >>> 3'd6)));
	pair_fastchain1_speculativedemodcordic139 <= (pair_fastchain1_speculativedemodcordic138 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_fastchain1_speculativedemodcordic18 <= (pair_fastchain1_speculativedemodcordic17 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir7 ? (pair_fastchain1_speculativedemodcordic123 >>> 3'd7) : (-(pair_fastchain1_speculativedemodcordic123 >>> 3'd7))));
	pair_fastchain1_speculativedemodcordic124 <= (pair_fastchain1_speculativedemodcordic123 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir7 ? (-(pair_fastchain1_speculativedemodcordic17 >>> 3'd7)) : (pair_fastchain1_speculativedemodcordic17 >>> 3'd7)));
	pair_fastchain1_speculativedemodcordic140 <= (pair_fastchain1_speculativedemodcordic139 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_fastchain1_speculativedemodcordic19 <= (pair_fastchain1_speculativedemodcordic18 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir8 ? (pair_fastchain1_speculativedemodcordic124 >>> 4'd8) : (-(pair_fastchain1_speculativedemodcordic124 >>> 4'd8))));
	pair_fastchain1_speculativedemodcordic125 <= (pair_fastchain1_speculativedemodcordic124 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir8 ? (-(pair_fastchain1_speculativedemodcordic18 >>> 4'd8)) : (pair_fastchain1_speculativedemodcordic18 >>> 4'd8)));
	pair_fastchain1_speculativedemodcordic141 <= (pair_fastchain1_speculativedemodcordic140 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_fastchain1_speculativedemodcordic110 <= (pair_fastchain1_speculativedemodcordic19 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir9 ? (pair_fastchain1_speculativedemodcordic125 >>> 4'd9) : (-(pair_fastchain1_speculativedemodcordic125 >>> 4'd9))));
	pair_fastchain1_speculativedemodcordic126 <= (pair_fastchain1_speculativedemodcordic125 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir9 ? (-(pair_fastchain1_speculativedemodcordic19 >>> 4'd9)) : (pair_fastchain1_speculativedemodcordic19 >>> 4'd9)));
	pair_fastchain1_speculativedemodcordic142 <= (pair_fastchain1_speculativedemodcordic141 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_fastchain1_speculativedemodcordic111 <= (pair_fastchain1_speculativedemodcordic110 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir10 ? (pair_fastchain1_speculativedemodcordic126 >>> 4'd10) : (-(pair_fastchain1_speculativedemodcordic126 >>> 4'd10))));
	pair_fastchain1_speculativedemodcordic127 <= (pair_fastchain1_speculativedemodcordic126 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir10 ? (-(pair_fastchain1_speculativedemodcordic110 >>> 4'd10)) : (pair_fastchain1_speculativedemodcordic110 >>> 4'd10)));
	pair_fastchain1_speculativedemodcordic143 <= (pair_fastchain1_speculativedemodcordic142 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_fastchain1_speculativedemodcordic112 <= (pair_fastchain1_speculativedemodcordic111 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir11 ? (pair_fastchain1_speculativedemodcordic127 >>> 4'd11) : (-(pair_fastchain1_speculativedemodcordic127 >>> 4'd11))));
	pair_fastchain1_speculativedemodcordic128 <= (pair_fastchain1_speculativedemodcordic127 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir11 ? (-(pair_fastchain1_speculativedemodcordic111 >>> 4'd11)) : (pair_fastchain1_speculativedemodcordic111 >>> 4'd11)));
	pair_fastchain1_speculativedemodcordic144 <= (pair_fastchain1_speculativedemodcordic143 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_fastchain1_speculativedemodcordic113 <= (pair_fastchain1_speculativedemodcordic112 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir12 ? (pair_fastchain1_speculativedemodcordic128 >>> 4'd12) : (-(pair_fastchain1_speculativedemodcordic128 >>> 4'd12))));
	pair_fastchain1_speculativedemodcordic129 <= (pair_fastchain1_speculativedemodcordic128 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir12 ? (-(pair_fastchain1_speculativedemodcordic112 >>> 4'd12)) : (pair_fastchain1_speculativedemodcordic112 >>> 4'd12)));
	pair_fastchain1_speculativedemodcordic145 <= (pair_fastchain1_speculativedemodcordic144 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_fastchain1_speculativedemodcordic114 <= (pair_fastchain1_speculativedemodcordic113 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir13 ? (pair_fastchain1_speculativedemodcordic129 >>> 4'd13) : (-(pair_fastchain1_speculativedemodcordic129 >>> 4'd13))));
	pair_fastchain1_speculativedemodcordic130 <= (pair_fastchain1_speculativedemodcordic129 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir13 ? (-(pair_fastchain1_speculativedemodcordic113 >>> 4'd13)) : (pair_fastchain1_speculativedemodcordic113 >>> 4'd13)));
	pair_fastchain1_speculativedemodcordic146 <= (pair_fastchain1_speculativedemodcordic145 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_fastchain1_speculativedemodcordic115 <= (pair_fastchain1_speculativedemodcordic114 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir14 ? (pair_fastchain1_speculativedemodcordic130 >>> 4'd14) : (-(pair_fastchain1_speculativedemodcordic130 >>> 4'd14))));
	pair_fastchain1_speculativedemodcordic131 <= (pair_fastchain1_speculativedemodcordic130 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir14 ? (-(pair_fastchain1_speculativedemodcordic114 >>> 4'd14)) : (pair_fastchain1_speculativedemodcordic114 >>> 4'd14)));
	pair_fastchain1_speculativedemodcordic147 <= (pair_fastchain1_speculativedemodcordic146 + (pair_fastchain1_speculativedemodcordic1_speculativedemodcordic1_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	if (pair_fastchain1_limitcsr2_update_en) begin
		pair_fastchain1_limitcsr2_limit_min <= {{1{pair_fastchain1_limitcsr2_min_storage[24]}}, pair_fastchain1_limitcsr2_min_storage};
		pair_fastchain1_limitcsr2_limit_max <= {{1{pair_fastchain1_limitcsr2_max_storage[24]}}, pair_fastchain1_limitcsr2_max_storage};
		pair_fastchain1_limitcsr2_limitcsr2_y <= pair_fastchain1_limitcsr2_limit_y;
		pair_fastchain1_limitcsr2_limitcsr2_error <= pair_fastchain1_limitcsr2_limit_railed;
	end
	pair_fastchain1_iir2_a10 <= pair_fastchain1_iir2_csrstorage6_storage;
	pair_fastchain1_iir2_b00 <= pair_fastchain1_iir2_csrstorage7_storage;
	pair_fastchain1_iir2_b10 <= pair_fastchain1_iir2_csrstorage8_storage;
	pair_fastchain1_iir2_z0r0 <= (pair_fastchain1_iir2_storage0 <<< 5'd23);
	pair_fastchain1_iir2_error0 <= pair_fastchain1_iir2_railed0;
	pair_fastchain1_iir2_y0 <= pair_fastchain1_iir2_y_lim0;
	if (pair_fastchain1_iir2_clear0) begin
		pair_fastchain1_iir2_y1 <= 1'd0;
	end else begin
		if ((~pair_fastchain1_iir2_hold0)) begin
			pair_fastchain1_iir2_y1 <= pair_fastchain1_iir2_y_lim0;
		end
	end
	pair_fastchain1_iir2_zr0 <= pair_fastchain1_iir2_z0r0;
	pair_fastchain1_iir2_zr_low_q0 <= pair_fastchain1_iir2_zr_low0[16:0];
	pair_fastchain1_iir2_zr_correction_q0 <= pair_fastchain1_iir2_zr_correction0;
	pair_fastchain1_iir2_zr_low_q1 <= pair_fastchain1_iir2_zr_low1[16:0];
	pair_fastchain1_iir2_zr_correction_q1 <= pair_fastchain1_iir2_zr_correction1;
	pair_fastchain1_iir2_a11 <= pair_fastchain1_iir2_csrstorage10_storage;
	pair_fastchain1_iir2_a2 <= pair_fastchain1_iir2_csrstorage11_storage;
	pair_fastchain1_iir2_b01 <= pair_fastchain1_iir2_csrstorage12_storage;
	pair_fastchain1_iir2_b11 <= pair_fastchain1_iir2_csrstorage13_storage;
	pair_fastchain1_iir2_b2 <= pair_fastchain1_iir2_csrstorage14_storage;
	pair_fastchain1_iir2_z0r1 <= (pair_fastchain1_iir2_storage1 <<< 5'd23);
	pair_fastchain1_iir2_error1 <= pair_fastchain1_iir2_railed1;
	pair_fastchain1_iir2_y2 <= pair_fastchain1_iir2_y_lim1;
	if (pair_fastchain1_iir2_clear1) begin
		pair_fastchain1_iir2_y3 <= 1'd0;
	end else begin
		if ((~pair_fastchain1_iir2_hold1)) begin
			pair_fastchain1_iir2_y3 <= pair_fastchain1_iir2_y_lim1;
		end
	end
	pair_fastchain1_iir2_zr5 <= pair_fastchain1_iir2_z0r1;
	pair_fastchain1_iir2_zr_low_q2 <= pair_fastchain1_iir2_zr_low2[16:0];
	pair_fastchain1_iir2_zr_correction_q2 <= pair_fastchain1_iir2_zr_correction2;
	pair_fastchain1_iir2_zr_low_q3 <= pair_fastchain1_iir2_zr_low3[16:0];
	pair_fastchain1_iir2_zr_correction_q3 <= pair_fastchain1_iir2_zr_correction3;
	pair_fastchain1_iir2_zr_low_q4 <= pair_fastchain1_iir2_zr_low4[16:0];
	pair_fastchain1_iir2_zr_correction_q4 <= pair_fastchain1_iir2_zr_correction4;
	pair_fastchain1_iir2_zr_low_q5 <= pair_fastchain1_iir2_zr_low5[16:0];
	pair_fastchain1_iir2_zr_correction_q5 <= pair_fastchain1_iir2_zr_correction5;
	pair_fastchain1_earlycommontaplimitcsr0_common_reg <= (pair_fastchain1_earlycommontaplimitcsr0_common_x + pair_fastchain1_earlycommontaplimitcsr0_common_offset);
	pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result <= {{1{pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_high[15]}}, pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_high, pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_low};
	pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result <= {{1{pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_high[15]}}, pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_high, pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_low};
	pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result <= {{1{pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_high[15]}}, pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_high, pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_low};
	pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result <= {{1{pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_high[15]}}, pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_high, pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_low};
	if (pair_fastchain1_earlycommontaplimitcsr0_update_en) begin
		pair_fastchain1_earlycommontaplimitcsr05 <= {{3{pair_fastchain1_earlycommontaplimitcsr0_min_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr0_min_storage};
		pair_fastchain1_earlycommontaplimitcsr06 <= {{3{pair_fastchain1_earlycommontaplimitcsr0_max_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr0_max_storage};
		pair_fastchain1_earlycommontaplimitcsr07 <= (-$signed({1'd0, {{3{pair_fastchain1_earlycommontaplimitcsr0_min_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr0_min_storage}}));
		pair_fastchain1_earlycommontaplimitcsr08 <= (-$signed({1'd0, {{3{pair_fastchain1_earlycommontaplimitcsr0_max_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr0_max_storage}}));
		pair_fastchain1_earlycommontaplimitcsr0_y <= pair_fastchain1_earlycommontaplimitcsr023;
		pair_fastchain1_earlycommontaplimitcsr0_error <= pair_fastchain1_earlycommontaplimitcsr024;
	end
	if (pair_fastchain1_limitcsr3_update_en) begin
		pair_fastchain1_limitcsr3_limit_min <= {{1{pair_fastchain1_limitcsr3_min_storage[24]}}, pair_fastchain1_limitcsr3_min_storage};
		pair_fastchain1_limitcsr3_limit_max <= {{1{pair_fastchain1_limitcsr3_max_storage[24]}}, pair_fastchain1_limitcsr3_max_storage};
		pair_fastchain1_limitcsr3_limitcsr3_y <= pair_fastchain1_limitcsr3_limit_y;
		pair_fastchain1_limitcsr3_limitcsr3_error <= pair_fastchain1_limitcsr3_limit_railed;
	end
	pair_fastchain1_iir3_a10 <= pair_fastchain1_iir3_csrstorage9_storage;
	pair_fastchain1_iir3_b00 <= pair_fastchain1_iir3_csrstorage10_storage;
	pair_fastchain1_iir3_b10 <= pair_fastchain1_iir3_csrstorage11_storage;
	pair_fastchain1_iir3_z0r0 <= (pair_fastchain1_iir3_storage0 <<< 5'd23);
	pair_fastchain1_iir3_error0 <= pair_fastchain1_iir3_railed0;
	pair_fastchain1_iir3_y0 <= pair_fastchain1_iir3_y_lim0;
	if (pair_fastchain1_iir3_clear0) begin
		pair_fastchain1_iir3_y1 <= 1'd0;
	end else begin
		if ((~pair_fastchain1_iir3_hold0)) begin
			pair_fastchain1_iir3_y1 <= pair_fastchain1_iir3_y_lim0;
		end
	end
	pair_fastchain1_iir3_zr0 <= pair_fastchain1_iir3_z0r0;
	pair_fastchain1_iir3_zr_low_q0 <= pair_fastchain1_iir3_zr_low0[16:0];
	pair_fastchain1_iir3_zr_correction_q0 <= pair_fastchain1_iir3_zr_correction0;
	pair_fastchain1_iir3_zr_low_q1 <= pair_fastchain1_iir3_zr_low1[16:0];
	pair_fastchain1_iir3_zr_correction_q1 <= pair_fastchain1_iir3_zr_correction1;
	pair_fastchain1_iir3_a11 <= pair_fastchain1_iir3_csrstorage15_storage;
	pair_fastchain1_iir3_a2 <= pair_fastchain1_iir3_csrstorage16_storage;
	pair_fastchain1_iir3_b01 <= pair_fastchain1_iir3_csrstorage17_storage;
	pair_fastchain1_iir3_b11 <= pair_fastchain1_iir3_csrstorage18_storage;
	pair_fastchain1_iir3_b2 <= pair_fastchain1_iir3_csrstorage19_storage;
	pair_fastchain1_iir3_z0r1 <= (pair_fastchain1_iir3_storage1 <<< 5'd23);
	pair_fastchain1_iir3_error1 <= pair_fastchain1_iir3_railed1;
	pair_fastchain1_iir3_y2 <= pair_fastchain1_iir3_y_lim1;
	if (pair_fastchain1_iir3_clear1) begin
		pair_fastchain1_iir3_y3 <= 1'd0;
	end else begin
		if ((~pair_fastchain1_iir3_hold1)) begin
			pair_fastchain1_iir3_y3 <= pair_fastchain1_iir3_y_lim1;
		end
	end
	pair_fastchain1_iir3_zr5 <= pair_fastchain1_iir3_z0r1;
	pair_fastchain1_iir3_zr_low_q2 <= pair_fastchain1_iir3_zr_low2[16:0];
	pair_fastchain1_iir3_zr_correction_q2 <= pair_fastchain1_iir3_zr_correction2;
	pair_fastchain1_iir3_zr_low_q3 <= pair_fastchain1_iir3_zr_low3[16:0];
	pair_fastchain1_iir3_zr_correction_q3 <= pair_fastchain1_iir3_zr_correction3;
	pair_fastchain1_iir3_zr_low_q4 <= pair_fastchain1_iir3_zr_low4[16:0];
	pair_fastchain1_iir3_zr_correction_q4 <= pair_fastchain1_iir3_zr_correction4;
	pair_fastchain1_iir3_zr_low_q5 <= pair_fastchain1_iir3_zr_low5[16:0];
	pair_fastchain1_iir3_zr_correction_q5 <= pair_fastchain1_iir3_zr_correction5;
	pair_fastchain1_earlycommontaplimitcsr1_common_reg <= (pair_fastchain1_earlycommontaplimitcsr1_common_x + pair_fastchain1_earlycommontaplimitcsr1_common_offset);
	pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result <= {{1{pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_high[15]}}, pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_high, pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_low};
	pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result <= {{1{pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_high[15]}}, pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_high, pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_low};
	pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result <= {{1{pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_high[15]}}, pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_high, pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_low};
	pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result <= {{1{pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_high[15]}}, pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_high, pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_low};
	if (pair_fastchain1_earlycommontaplimitcsr1_update_en) begin
		pair_fastchain1_earlycommontaplimitcsr15 <= {{3{pair_fastchain1_earlycommontaplimitcsr1_min_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr1_min_storage};
		pair_fastchain1_earlycommontaplimitcsr16 <= {{3{pair_fastchain1_earlycommontaplimitcsr1_max_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr1_max_storage};
		pair_fastchain1_earlycommontaplimitcsr17 <= (-$signed({1'd0, {{3{pair_fastchain1_earlycommontaplimitcsr1_min_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr1_min_storage}}));
		pair_fastchain1_earlycommontaplimitcsr18 <= (-$signed({1'd0, {{3{pair_fastchain1_earlycommontaplimitcsr1_max_storage[24]}}, pair_fastchain1_earlycommontaplimitcsr1_max_storage}}));
		pair_fastchain1_earlycommontaplimitcsr1_y <= pair_fastchain1_earlycommontaplimitcsr123;
		pair_fastchain1_earlycommontaplimitcsr1_error <= pair_fastchain1_earlycommontaplimitcsr124;
	end
	pair_csrbank1_bus_dat_r <= 1'd0;
	if (pair_csrbank1_sel) begin
		case (pair_csrbank1_bus_adr[6:0])
			1'd0: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_tap0_w;
			end
			1'd1: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_invert0_w;
			end
			2'd2: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_demod_delay3_w;
			end
			2'd3: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_demod_delay2_w;
			end
			3'd4: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_demod_delay1_w;
			end
			3'd5: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_demod_delay0_w;
			end
			3'd6: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_demod_multiplier0_w;
			end
			3'd7: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_min3_w;
			end
			4'd8: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_min2_w;
			end
			4'd9: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_min1_w;
			end
			4'd10: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_min0_w;
			end
			4'd11: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_max3_w;
			end
			4'd12: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_max2_w;
			end
			4'd13: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_max1_w;
			end
			4'd14: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_1_max0_w;
			end
			4'd15: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_z03_w;
			end
			5'd16: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_z02_w;
			end
			5'd17: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_z01_w;
			end
			5'd18: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_z00_w;
			end
			5'd19: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_a13_w;
			end
			5'd20: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_a12_w;
			end
			5'd21: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_a11_w;
			end
			5'd22: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_a10_w;
			end
			5'd23: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b03_w;
			end
			5'd24: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b02_w;
			end
			5'd25: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b01_w;
			end
			5'd26: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b00_w;
			end
			5'd27: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b13_w;
			end
			5'd28: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b12_w;
			end
			5'd29: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b11_w;
			end
			5'd30: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_1_b10_w;
			end
			5'd31: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_z03_w;
			end
			6'd32: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_z02_w;
			end
			6'd33: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_z01_w;
			end
			6'd34: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_z00_w;
			end
			6'd35: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a13_w;
			end
			6'd36: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a12_w;
			end
			6'd37: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a11_w;
			end
			6'd38: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a10_w;
			end
			6'd39: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a23_w;
			end
			6'd40: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a22_w;
			end
			6'd41: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a21_w;
			end
			6'd42: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_a20_w;
			end
			6'd43: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b03_w;
			end
			6'd44: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b02_w;
			end
			6'd45: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b01_w;
			end
			6'd46: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b00_w;
			end
			6'd47: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b13_w;
			end
			6'd48: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b12_w;
			end
			6'd49: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b11_w;
			end
			6'd50: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b10_w;
			end
			6'd51: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b23_w;
			end
			6'd52: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b22_w;
			end
			6'd53: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b21_w;
			end
			6'd54: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_1_b20_w;
			end
			6'd55: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_min3_w;
			end
			6'd56: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_min2_w;
			end
			6'd57: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_min1_w;
			end
			6'd58: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_min0_w;
			end
			6'd59: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_max3_w;
			end
			6'd60: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_max2_w;
			end
			6'd61: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_max1_w;
			end
			6'd62: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_1_max0_w;
			end
			6'd63: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_min3_w;
			end
			7'd64: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_min2_w;
			end
			7'd65: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_min1_w;
			end
			7'd66: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_min0_w;
			end
			7'd67: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_max3_w;
			end
			7'd68: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_max2_w;
			end
			7'd69: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_max1_w;
			end
			7'd70: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_x_limit_2_max0_w;
			end
			7'd71: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_z03_w;
			end
			7'd72: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_z02_w;
			end
			7'd73: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_z01_w;
			end
			7'd74: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_z00_w;
			end
			7'd75: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_a13_w;
			end
			7'd76: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_a12_w;
			end
			7'd77: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_a11_w;
			end
			7'd78: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_a10_w;
			end
			7'd79: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b03_w;
			end
			7'd80: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b02_w;
			end
			7'd81: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b01_w;
			end
			7'd82: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b00_w;
			end
			7'd83: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b13_w;
			end
			7'd84: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b12_w;
			end
			7'd85: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b11_w;
			end
			7'd86: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_c_2_b10_w;
			end
			7'd87: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_z03_w;
			end
			7'd88: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_z02_w;
			end
			7'd89: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_z01_w;
			end
			7'd90: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_z00_w;
			end
			7'd91: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a13_w;
			end
			7'd92: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a12_w;
			end
			7'd93: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a11_w;
			end
			7'd94: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a10_w;
			end
			7'd95: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a23_w;
			end
			7'd96: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a22_w;
			end
			7'd97: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a21_w;
			end
			7'd98: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_a20_w;
			end
			7'd99: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b03_w;
			end
			7'd100: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b02_w;
			end
			7'd101: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b01_w;
			end
			7'd102: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b00_w;
			end
			7'd103: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b13_w;
			end
			7'd104: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b12_w;
			end
			7'd105: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b11_w;
			end
			7'd106: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b10_w;
			end
			7'd107: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b23_w;
			end
			7'd108: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b22_w;
			end
			7'd109: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b21_w;
			end
			7'd110: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_iir_d_2_b20_w;
			end
			7'd111: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_min3_w;
			end
			7'd112: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_min2_w;
			end
			7'd113: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_min1_w;
			end
			7'd114: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_min0_w;
			end
			7'd115: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_max3_w;
			end
			7'd116: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_max2_w;
			end
			7'd117: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_max1_w;
			end
			7'd118: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_y_limit_2_max0_w;
			end
		endcase
	end
	if (pair_csrbank1_y_tap0_re) begin
		pair_fastchain1_y_tap_storage_full[1:0] <= pair_csrbank1_y_tap0_r;
	end
	pair_fastchain1_y_tap_re <= pair_csrbank1_y_tap0_re;
	if (pair_csrbank1_invert0_re) begin
		pair_fastchain1_invert_storage_full <= pair_csrbank1_invert0_r;
	end
	pair_fastchain1_invert_re <= pair_csrbank1_invert0_re;
	if (pair_csrbank1_demod_delay3_re) begin
		pair_fastchain1_delay_storage_full[31:24] <= pair_csrbank1_demod_delay3_r;
	end
	if (pair_csrbank1_demod_delay2_re) begin
		pair_fastchain1_delay_storage_full[23:16] <= pair_csrbank1_demod_delay2_r;
	end
	if (pair_csrbank1_demod_delay1_re) begin
		pair_fastchain1_delay_storage_full[15:8] <= pair_csrbank1_demod_delay1_r;
	end
	if (pair_csrbank1_demod_delay0_re) begin
		pair_fastchain1_delay_storage_full[7:0] <= pair_csrbank1_demod_delay0_r;
	end
	pair_fastchain1_delay_re <= pair_csrbank1_demod_delay0_re;
	if (pair_csrbank1_demod_multiplier0_re) begin
		pair_fastchain1_multiplier_storage_full[3:0] <= pair_csrbank1_demod_multiplier0_r;
	end
	pair_fastchain1_multiplier_re <= pair_csrbank1_demod_multiplier0_re;
	if (pair_csrbank1_x_limit_1_min3_re) begin
		pair_fastchain1_limitcsr2_min_storage_full[24] <= pair_csrbank1_x_limit_1_min3_r;
	end
	if (pair_csrbank1_x_limit_1_min2_re) begin
		pair_fastchain1_limitcsr2_min_storage_full[23:16] <= pair_csrbank1_x_limit_1_min2_r;
	end
	if (pair_csrbank1_x_limit_1_min1_re) begin
		pair_fastchain1_limitcsr2_min_storage_full[15:8] <= pair_csrbank1_x_limit_1_min1_r;
	end
	if (pair_csrbank1_x_limit_1_min0_re) begin
		pair_fastchain1_limitcsr2_min_storage_full[7:0] <= pair_csrbank1_x_limit_1_min0_r;
	end
	pair_fastchain1_limitcsr2_min_re <= pair_csrbank1_x_limit_1_min0_re;
	if (pair_csrbank1_x_limit_1_max3_re) begin
		pair_fastchain1_limitcsr2_max_storage_full[24] <= pair_csrbank1_x_limit_1_max3_r;
	end
	if (pair_csrbank1_x_limit_1_max2_re) begin
		pair_fastchain1_limitcsr2_max_storage_full[23:16] <= pair_csrbank1_x_limit_1_max2_r;
	end
	if (pair_csrbank1_x_limit_1_max1_re) begin
		pair_fastchain1_limitcsr2_max_storage_full[15:8] <= pair_csrbank1_x_limit_1_max1_r;
	end
	if (pair_csrbank1_x_limit_1_max0_re) begin
		pair_fastchain1_limitcsr2_max_storage_full[7:0] <= pair_csrbank1_x_limit_1_max0_r;
	end
	pair_fastchain1_limitcsr2_max_re <= pair_csrbank1_x_limit_1_max0_re;
	if (pair_csrbank1_iir_c_1_z03_re) begin
		pair_fastchain1_iir2_storage_full0[26:24] <= pair_csrbank1_iir_c_1_z03_r;
	end
	if (pair_csrbank1_iir_c_1_z02_re) begin
		pair_fastchain1_iir2_storage_full0[23:16] <= pair_csrbank1_iir_c_1_z02_r;
	end
	if (pair_csrbank1_iir_c_1_z01_re) begin
		pair_fastchain1_iir2_storage_full0[15:8] <= pair_csrbank1_iir_c_1_z01_r;
	end
	if (pair_csrbank1_iir_c_1_z00_re) begin
		pair_fastchain1_iir2_storage_full0[7:0] <= pair_csrbank1_iir_c_1_z00_r;
	end
	pair_fastchain1_iir2_re0 <= pair_csrbank1_iir_c_1_z00_re;
	if (pair_csrbank1_iir_c_1_a13_re) begin
		pair_fastchain1_iir2_csrstorage6_storage_full[24] <= pair_csrbank1_iir_c_1_a13_r;
	end
	if (pair_csrbank1_iir_c_1_a12_re) begin
		pair_fastchain1_iir2_csrstorage6_storage_full[23:16] <= pair_csrbank1_iir_c_1_a12_r;
	end
	if (pair_csrbank1_iir_c_1_a11_re) begin
		pair_fastchain1_iir2_csrstorage6_storage_full[15:8] <= pair_csrbank1_iir_c_1_a11_r;
	end
	if (pair_csrbank1_iir_c_1_a10_re) begin
		pair_fastchain1_iir2_csrstorage6_storage_full[7:0] <= pair_csrbank1_iir_c_1_a10_r;
	end
	pair_fastchain1_iir2_csrstorage6_re <= pair_csrbank1_iir_c_1_a10_re;
	if (pair_csrbank1_iir_c_1_b03_re) begin
		pair_fastchain1_iir2_csrstorage7_storage_full[24] <= pair_csrbank1_iir_c_1_b03_r;
	end
	if (pair_csrbank1_iir_c_1_b02_re) begin
		pair_fastchain1_iir2_csrstorage7_storage_full[23:16] <= pair_csrbank1_iir_c_1_b02_r;
	end
	if (pair_csrbank1_iir_c_1_b01_re) begin
		pair_fastchain1_iir2_csrstorage7_storage_full[15:8] <= pair_csrbank1_iir_c_1_b01_r;
	end
	if (pair_csrbank1_iir_c_1_b00_re) begin
		pair_fastchain1_iir2_csrstorage7_storage_full[7:0] <= pair_csrbank1_iir_c_1_b00_r;
	end
	pair_fastchain1_iir2_csrstorage7_re <= pair_csrbank1_iir_c_1_b00_re;
	if (pair_csrbank1_iir_c_1_b13_re) begin
		pair_fastchain1_iir2_csrstorage8_storage_full[24] <= pair_csrbank1_iir_c_1_b13_r;
	end
	if (pair_csrbank1_iir_c_1_b12_re) begin
		pair_fastchain1_iir2_csrstorage8_storage_full[23:16] <= pair_csrbank1_iir_c_1_b12_r;
	end
	if (pair_csrbank1_iir_c_1_b11_re) begin
		pair_fastchain1_iir2_csrstorage8_storage_full[15:8] <= pair_csrbank1_iir_c_1_b11_r;
	end
	if (pair_csrbank1_iir_c_1_b10_re) begin
		pair_fastchain1_iir2_csrstorage8_storage_full[7:0] <= pair_csrbank1_iir_c_1_b10_r;
	end
	pair_fastchain1_iir2_csrstorage8_re <= pair_csrbank1_iir_c_1_b10_re;
	if (pair_csrbank1_iir_d_1_z03_re) begin
		pair_fastchain1_iir2_storage_full1[26:24] <= pair_csrbank1_iir_d_1_z03_r;
	end
	if (pair_csrbank1_iir_d_1_z02_re) begin
		pair_fastchain1_iir2_storage_full1[23:16] <= pair_csrbank1_iir_d_1_z02_r;
	end
	if (pair_csrbank1_iir_d_1_z01_re) begin
		pair_fastchain1_iir2_storage_full1[15:8] <= pair_csrbank1_iir_d_1_z01_r;
	end
	if (pair_csrbank1_iir_d_1_z00_re) begin
		pair_fastchain1_iir2_storage_full1[7:0] <= pair_csrbank1_iir_d_1_z00_r;
	end
	pair_fastchain1_iir2_re1 <= pair_csrbank1_iir_d_1_z00_re;
	if (pair_csrbank1_iir_d_1_a13_re) begin
		pair_fastchain1_iir2_csrstorage10_storage_full[24] <= pair_csrbank1_iir_d_1_a13_r;
	end
	if (pair_csrbank1_iir_d_1_a12_re) begin
		pair_fastchain1_iir2_csrstorage10_storage_full[23:16] <= pair_csrbank1_iir_d_1_a12_r;
	end
	if (pair_csrbank1_iir_d_1_a11_re) begin
		pair_fastchain1_iir2_csrstorage10_storage_full[15:8] <= pair_csrbank1_iir_d_1_a11_r;
	end
	if (pair_csrbank1_iir_d_1_a10_re) begin
		pair_fastchain1_iir2_csrstorage10_storage_full[7:0] <= pair_csrbank1_iir_d_1_a10_r;
	end
	pair_fastchain1_iir2_csrstorage10_re <= pair_csrbank1_iir_d_1_a10_re;
	if (pair_csrbank1_iir_d_1_a23_re) begin
		pair_fastchain1_iir2_csrstorage11_storage_full[24] <= pair_csrbank1_iir_d_1_a23_r;
	end
	if (pair_csrbank1_iir_d_1_a22_re) begin
		pair_fastchain1_iir2_csrstorage11_storage_full[23:16] <= pair_csrbank1_iir_d_1_a22_r;
	end
	if (pair_csrbank1_iir_d_1_a21_re) begin
		pair_fastchain1_iir2_csrstorage11_storage_full[15:8] <= pair_csrbank1_iir_d_1_a21_r;
	end
	if (pair_csrbank1_iir_d_1_a20_re) begin
		pair_fastchain1_iir2_csrstorage11_storage_full[7:0] <= pair_csrbank1_iir_d_1_a20_r;
	end
	pair_fastchain1_iir2_csrstorage11_re <= pair_csrbank1_iir_d_1_a20_re;
	if (pair_csrbank1_iir_d_1_b03_re) begin
		pair_fastchain1_iir2_csrstorage12_storage_full[24] <= pair_csrbank1_iir_d_1_b03_r;
	end
	if (pair_csrbank1_iir_d_1_b02_re) begin
		pair_fastchain1_iir2_csrstorage12_storage_full[23:16] <= pair_csrbank1_iir_d_1_b02_r;
	end
	if (pair_csrbank1_iir_d_1_b01_re) begin
		pair_fastchain1_iir2_csrstorage12_storage_full[15:8] <= pair_csrbank1_iir_d_1_b01_r;
	end
	if (pair_csrbank1_iir_d_1_b00_re) begin
		pair_fastchain1_iir2_csrstorage12_storage_full[7:0] <= pair_csrbank1_iir_d_1_b00_r;
	end
	pair_fastchain1_iir2_csrstorage12_re <= pair_csrbank1_iir_d_1_b00_re;
	if (pair_csrbank1_iir_d_1_b13_re) begin
		pair_fastchain1_iir2_csrstorage13_storage_full[24] <= pair_csrbank1_iir_d_1_b13_r;
	end
	if (pair_csrbank1_iir_d_1_b12_re) begin
		pair_fastchain1_iir2_csrstorage13_storage_full[23:16] <= pair_csrbank1_iir_d_1_b12_r;
	end
	if (pair_csrbank1_iir_d_1_b11_re) begin
		pair_fastchain1_iir2_csrstorage13_storage_full[15:8] <= pair_csrbank1_iir_d_1_b11_r;
	end
	if (pair_csrbank1_iir_d_1_b10_re) begin
		pair_fastchain1_iir2_csrstorage13_storage_full[7:0] <= pair_csrbank1_iir_d_1_b10_r;
	end
	pair_fastchain1_iir2_csrstorage13_re <= pair_csrbank1_iir_d_1_b10_re;
	if (pair_csrbank1_iir_d_1_b23_re) begin
		pair_fastchain1_iir2_csrstorage14_storage_full[24] <= pair_csrbank1_iir_d_1_b23_r;
	end
	if (pair_csrbank1_iir_d_1_b22_re) begin
		pair_fastchain1_iir2_csrstorage14_storage_full[23:16] <= pair_csrbank1_iir_d_1_b22_r;
	end
	if (pair_csrbank1_iir_d_1_b21_re) begin
		pair_fastchain1_iir2_csrstorage14_storage_full[15:8] <= pair_csrbank1_iir_d_1_b21_r;
	end
	if (pair_csrbank1_iir_d_1_b20_re) begin
		pair_fastchain1_iir2_csrstorage14_storage_full[7:0] <= pair_csrbank1_iir_d_1_b20_r;
	end
	pair_fastchain1_iir2_csrstorage14_re <= pair_csrbank1_iir_d_1_b20_re;
	if (pair_csrbank1_y_limit_1_min3_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[24] <= pair_csrbank1_y_limit_1_min3_r;
	end
	if (pair_csrbank1_y_limit_1_min2_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[23:16] <= pair_csrbank1_y_limit_1_min2_r;
	end
	if (pair_csrbank1_y_limit_1_min1_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[15:8] <= pair_csrbank1_y_limit_1_min1_r;
	end
	if (pair_csrbank1_y_limit_1_min0_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_min_storage_full[7:0] <= pair_csrbank1_y_limit_1_min0_r;
	end
	pair_fastchain1_earlycommontaplimitcsr0_min_re <= pair_csrbank1_y_limit_1_min0_re;
	if (pair_csrbank1_y_limit_1_max3_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[24] <= pair_csrbank1_y_limit_1_max3_r;
	end
	if (pair_csrbank1_y_limit_1_max2_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[23:16] <= pair_csrbank1_y_limit_1_max2_r;
	end
	if (pair_csrbank1_y_limit_1_max1_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[15:8] <= pair_csrbank1_y_limit_1_max1_r;
	end
	if (pair_csrbank1_y_limit_1_max0_re) begin
		pair_fastchain1_earlycommontaplimitcsr0_max_storage_full[7:0] <= pair_csrbank1_y_limit_1_max0_r;
	end
	pair_fastchain1_earlycommontaplimitcsr0_max_re <= pair_csrbank1_y_limit_1_max0_re;
	if (pair_csrbank1_x_limit_2_min3_re) begin
		pair_fastchain1_limitcsr3_min_storage_full[24] <= pair_csrbank1_x_limit_2_min3_r;
	end
	if (pair_csrbank1_x_limit_2_min2_re) begin
		pair_fastchain1_limitcsr3_min_storage_full[23:16] <= pair_csrbank1_x_limit_2_min2_r;
	end
	if (pair_csrbank1_x_limit_2_min1_re) begin
		pair_fastchain1_limitcsr3_min_storage_full[15:8] <= pair_csrbank1_x_limit_2_min1_r;
	end
	if (pair_csrbank1_x_limit_2_min0_re) begin
		pair_fastchain1_limitcsr3_min_storage_full[7:0] <= pair_csrbank1_x_limit_2_min0_r;
	end
	pair_fastchain1_limitcsr3_min_re <= pair_csrbank1_x_limit_2_min0_re;
	if (pair_csrbank1_x_limit_2_max3_re) begin
		pair_fastchain1_limitcsr3_max_storage_full[24] <= pair_csrbank1_x_limit_2_max3_r;
	end
	if (pair_csrbank1_x_limit_2_max2_re) begin
		pair_fastchain1_limitcsr3_max_storage_full[23:16] <= pair_csrbank1_x_limit_2_max2_r;
	end
	if (pair_csrbank1_x_limit_2_max1_re) begin
		pair_fastchain1_limitcsr3_max_storage_full[15:8] <= pair_csrbank1_x_limit_2_max1_r;
	end
	if (pair_csrbank1_x_limit_2_max0_re) begin
		pair_fastchain1_limitcsr3_max_storage_full[7:0] <= pair_csrbank1_x_limit_2_max0_r;
	end
	pair_fastchain1_limitcsr3_max_re <= pair_csrbank1_x_limit_2_max0_re;
	if (pair_csrbank1_iir_c_2_z03_re) begin
		pair_fastchain1_iir3_storage_full0[26:24] <= pair_csrbank1_iir_c_2_z03_r;
	end
	if (pair_csrbank1_iir_c_2_z02_re) begin
		pair_fastchain1_iir3_storage_full0[23:16] <= pair_csrbank1_iir_c_2_z02_r;
	end
	if (pair_csrbank1_iir_c_2_z01_re) begin
		pair_fastchain1_iir3_storage_full0[15:8] <= pair_csrbank1_iir_c_2_z01_r;
	end
	if (pair_csrbank1_iir_c_2_z00_re) begin
		pair_fastchain1_iir3_storage_full0[7:0] <= pair_csrbank1_iir_c_2_z00_r;
	end
	pair_fastchain1_iir3_re0 <= pair_csrbank1_iir_c_2_z00_re;
	if (pair_csrbank1_iir_c_2_a13_re) begin
		pair_fastchain1_iir3_csrstorage9_storage_full[24] <= pair_csrbank1_iir_c_2_a13_r;
	end
	if (pair_csrbank1_iir_c_2_a12_re) begin
		pair_fastchain1_iir3_csrstorage9_storage_full[23:16] <= pair_csrbank1_iir_c_2_a12_r;
	end
	if (pair_csrbank1_iir_c_2_a11_re) begin
		pair_fastchain1_iir3_csrstorage9_storage_full[15:8] <= pair_csrbank1_iir_c_2_a11_r;
	end
	if (pair_csrbank1_iir_c_2_a10_re) begin
		pair_fastchain1_iir3_csrstorage9_storage_full[7:0] <= pair_csrbank1_iir_c_2_a10_r;
	end
	pair_fastchain1_iir3_csrstorage9_re <= pair_csrbank1_iir_c_2_a10_re;
	if (pair_csrbank1_iir_c_2_b03_re) begin
		pair_fastchain1_iir3_csrstorage10_storage_full[24] <= pair_csrbank1_iir_c_2_b03_r;
	end
	if (pair_csrbank1_iir_c_2_b02_re) begin
		pair_fastchain1_iir3_csrstorage10_storage_full[23:16] <= pair_csrbank1_iir_c_2_b02_r;
	end
	if (pair_csrbank1_iir_c_2_b01_re) begin
		pair_fastchain1_iir3_csrstorage10_storage_full[15:8] <= pair_csrbank1_iir_c_2_b01_r;
	end
	if (pair_csrbank1_iir_c_2_b00_re) begin
		pair_fastchain1_iir3_csrstorage10_storage_full[7:0] <= pair_csrbank1_iir_c_2_b00_r;
	end
	pair_fastchain1_iir3_csrstorage10_re <= pair_csrbank1_iir_c_2_b00_re;
	if (pair_csrbank1_iir_c_2_b13_re) begin
		pair_fastchain1_iir3_csrstorage11_storage_full[24] <= pair_csrbank1_iir_c_2_b13_r;
	end
	if (pair_csrbank1_iir_c_2_b12_re) begin
		pair_fastchain1_iir3_csrstorage11_storage_full[23:16] <= pair_csrbank1_iir_c_2_b12_r;
	end
	if (pair_csrbank1_iir_c_2_b11_re) begin
		pair_fastchain1_iir3_csrstorage11_storage_full[15:8] <= pair_csrbank1_iir_c_2_b11_r;
	end
	if (pair_csrbank1_iir_c_2_b10_re) begin
		pair_fastchain1_iir3_csrstorage11_storage_full[7:0] <= pair_csrbank1_iir_c_2_b10_r;
	end
	pair_fastchain1_iir3_csrstorage11_re <= pair_csrbank1_iir_c_2_b10_re;
	if (pair_csrbank1_iir_d_2_z03_re) begin
		pair_fastchain1_iir3_storage_full1[26:24] <= pair_csrbank1_iir_d_2_z03_r;
	end
	if (pair_csrbank1_iir_d_2_z02_re) begin
		pair_fastchain1_iir3_storage_full1[23:16] <= pair_csrbank1_iir_d_2_z02_r;
	end
	if (pair_csrbank1_iir_d_2_z01_re) begin
		pair_fastchain1_iir3_storage_full1[15:8] <= pair_csrbank1_iir_d_2_z01_r;
	end
	if (pair_csrbank1_iir_d_2_z00_re) begin
		pair_fastchain1_iir3_storage_full1[7:0] <= pair_csrbank1_iir_d_2_z00_r;
	end
	pair_fastchain1_iir3_re1 <= pair_csrbank1_iir_d_2_z00_re;
	if (pair_csrbank1_iir_d_2_a13_re) begin
		pair_fastchain1_iir3_csrstorage15_storage_full[24] <= pair_csrbank1_iir_d_2_a13_r;
	end
	if (pair_csrbank1_iir_d_2_a12_re) begin
		pair_fastchain1_iir3_csrstorage15_storage_full[23:16] <= pair_csrbank1_iir_d_2_a12_r;
	end
	if (pair_csrbank1_iir_d_2_a11_re) begin
		pair_fastchain1_iir3_csrstorage15_storage_full[15:8] <= pair_csrbank1_iir_d_2_a11_r;
	end
	if (pair_csrbank1_iir_d_2_a10_re) begin
		pair_fastchain1_iir3_csrstorage15_storage_full[7:0] <= pair_csrbank1_iir_d_2_a10_r;
	end
	pair_fastchain1_iir3_csrstorage15_re <= pair_csrbank1_iir_d_2_a10_re;
	if (pair_csrbank1_iir_d_2_a23_re) begin
		pair_fastchain1_iir3_csrstorage16_storage_full[24] <= pair_csrbank1_iir_d_2_a23_r;
	end
	if (pair_csrbank1_iir_d_2_a22_re) begin
		pair_fastchain1_iir3_csrstorage16_storage_full[23:16] <= pair_csrbank1_iir_d_2_a22_r;
	end
	if (pair_csrbank1_iir_d_2_a21_re) begin
		pair_fastchain1_iir3_csrstorage16_storage_full[15:8] <= pair_csrbank1_iir_d_2_a21_r;
	end
	if (pair_csrbank1_iir_d_2_a20_re) begin
		pair_fastchain1_iir3_csrstorage16_storage_full[7:0] <= pair_csrbank1_iir_d_2_a20_r;
	end
	pair_fastchain1_iir3_csrstorage16_re <= pair_csrbank1_iir_d_2_a20_re;
	if (pair_csrbank1_iir_d_2_b03_re) begin
		pair_fastchain1_iir3_csrstorage17_storage_full[24] <= pair_csrbank1_iir_d_2_b03_r;
	end
	if (pair_csrbank1_iir_d_2_b02_re) begin
		pair_fastchain1_iir3_csrstorage17_storage_full[23:16] <= pair_csrbank1_iir_d_2_b02_r;
	end
	if (pair_csrbank1_iir_d_2_b01_re) begin
		pair_fastchain1_iir3_csrstorage17_storage_full[15:8] <= pair_csrbank1_iir_d_2_b01_r;
	end
	if (pair_csrbank1_iir_d_2_b00_re) begin
		pair_fastchain1_iir3_csrstorage17_storage_full[7:0] <= pair_csrbank1_iir_d_2_b00_r;
	end
	pair_fastchain1_iir3_csrstorage17_re <= pair_csrbank1_iir_d_2_b00_re;
	if (pair_csrbank1_iir_d_2_b13_re) begin
		pair_fastchain1_iir3_csrstorage18_storage_full[24] <= pair_csrbank1_iir_d_2_b13_r;
	end
	if (pair_csrbank1_iir_d_2_b12_re) begin
		pair_fastchain1_iir3_csrstorage18_storage_full[23:16] <= pair_csrbank1_iir_d_2_b12_r;
	end
	if (pair_csrbank1_iir_d_2_b11_re) begin
		pair_fastchain1_iir3_csrstorage18_storage_full[15:8] <= pair_csrbank1_iir_d_2_b11_r;
	end
	if (pair_csrbank1_iir_d_2_b10_re) begin
		pair_fastchain1_iir3_csrstorage18_storage_full[7:0] <= pair_csrbank1_iir_d_2_b10_r;
	end
	pair_fastchain1_iir3_csrstorage18_re <= pair_csrbank1_iir_d_2_b10_re;
	if (pair_csrbank1_iir_d_2_b23_re) begin
		pair_fastchain1_iir3_csrstorage19_storage_full[24] <= pair_csrbank1_iir_d_2_b23_r;
	end
	if (pair_csrbank1_iir_d_2_b22_re) begin
		pair_fastchain1_iir3_csrstorage19_storage_full[23:16] <= pair_csrbank1_iir_d_2_b22_r;
	end
	if (pair_csrbank1_iir_d_2_b21_re) begin
		pair_fastchain1_iir3_csrstorage19_storage_full[15:8] <= pair_csrbank1_iir_d_2_b21_r;
	end
	if (pair_csrbank1_iir_d_2_b20_re) begin
		pair_fastchain1_iir3_csrstorage19_storage_full[7:0] <= pair_csrbank1_iir_d_2_b20_r;
	end
	pair_fastchain1_iir3_csrstorage19_re <= pair_csrbank1_iir_d_2_b20_re;
	if (pair_csrbank1_y_limit_2_min3_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[24] <= pair_csrbank1_y_limit_2_min3_r;
	end
	if (pair_csrbank1_y_limit_2_min2_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[23:16] <= pair_csrbank1_y_limit_2_min2_r;
	end
	if (pair_csrbank1_y_limit_2_min1_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[15:8] <= pair_csrbank1_y_limit_2_min1_r;
	end
	if (pair_csrbank1_y_limit_2_min0_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_min_storage_full[7:0] <= pair_csrbank1_y_limit_2_min0_r;
	end
	pair_fastchain1_earlycommontaplimitcsr1_min_re <= pair_csrbank1_y_limit_2_min0_re;
	if (pair_csrbank1_y_limit_2_max3_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[24] <= pair_csrbank1_y_limit_2_max3_r;
	end
	if (pair_csrbank1_y_limit_2_max2_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[23:16] <= pair_csrbank1_y_limit_2_max2_r;
	end
	if (pair_csrbank1_y_limit_2_max1_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[15:8] <= pair_csrbank1_y_limit_2_max1_r;
	end
	if (pair_csrbank1_y_limit_2_max0_re) begin
		pair_fastchain1_earlycommontaplimitcsr1_max_storage_full[7:0] <= pair_csrbank1_y_limit_2_max0_r;
	end
	pair_fastchain1_earlycommontaplimitcsr1_max_re <= pair_csrbank1_y_limit_2_max0_re;
	if (sys_rst) begin
		pair_fastchain0_y_tap_storage_full <= 2'd0;
		pair_fastchain0_y_tap_re <= 1'd0;
		pair_fastchain0_invert_storage_full <= 1'd0;
		pair_fastchain0_invert_re <= 1'd0;
		pair_fastchain0_delay_storage_full <= 32'd0;
		pair_fastchain0_delay_re <= 1'd0;
		pair_fastchain0_multiplier_storage_full <= 4'd1;
		pair_fastchain0_multiplier_re <= 1'd0;
		pair_fastchain0_speculativedemodcordic01 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic02 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic03 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic04 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic05 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic06 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic07 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic08 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic09 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic010 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic011 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic012 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic013 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic014 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic015 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic017 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic018 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic019 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic020 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic021 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic022 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic023 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic024 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic025 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic026 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic027 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic028 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic029 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic030 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic031 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic033 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic034 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic035 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic036 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic037 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic038 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic039 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic040 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic041 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic042 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic043 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic044 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic045 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic046 <= 17'sd0;
		pair_fastchain0_speculativedemodcordic047 <= 17'sd0;
		pair_fastchain0_ya <= 17'sd0;
		pair_fastchain0_common <= 18'sd0;
		pair_fastchain0_limitcsr0_limitcsr0_y <= 25'sd0;
		pair_fastchain0_limitcsr0_limitcsr0_error <= 1'd0;
		pair_fastchain0_limitcsr0_min_storage_full <= 25'd16777216;
		pair_fastchain0_limitcsr0_min_re <= 1'd0;
		pair_fastchain0_limitcsr0_max_storage_full <= 25'd16777215;
		pair_fastchain0_limitcsr0_max_re <= 1'd0;
		pair_fastchain0_limitcsr0_limit_max <= 26'sd0;
		pair_fastchain0_limitcsr0_limit_min <= 26'sd0;
		pair_fastchain0_iir0_y0 <= 25'sd0;
		pair_fastchain0_iir0_error0 <= 1'd0;
		pair_fastchain0_iir0_storage_full0 <= 27'd0;
		pair_fastchain0_iir0_re0 <= 1'd0;
		pair_fastchain0_iir0_a10 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage0_storage_full0 <= 25'd0;
		pair_fastchain0_iir0_csrstorage0_re0 <= 1'd0;
		pair_fastchain0_iir0_b00 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage1_storage_full0 <= 25'd0;
		pair_fastchain0_iir0_csrstorage1_re0 <= 1'd0;
		pair_fastchain0_iir0_b10 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage2_storage_full0 <= 25'd0;
		pair_fastchain0_iir0_csrstorage2_re0 <= 1'd0;
		pair_fastchain0_iir0_z0r0 <= 50'sd0;
		pair_fastchain0_iir0_y1 <= 25'sd0;
		pair_fastchain0_iir0_zr0 <= 50'sd0;
		pair_fastchain0_iir0_zr_correction_q0 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q0 <= 17'd0;
		pair_fastchain0_iir0_zr_correction_q1 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q1 <= 17'd0;
		pair_fastchain0_iir0_y2 <= 25'sd0;
		pair_fastchain0_iir0_error1 <= 1'd0;
		pair_fastchain0_iir0_storage_full1 <= 27'd0;
		pair_fastchain0_iir0_re1 <= 1'd0;
		pair_fastchain0_iir0_a11 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage0_storage_full1 <= 25'd0;
		pair_fastchain0_iir0_csrstorage0_re1 <= 1'd0;
		pair_fastchain0_iir0_a2 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage1_storage_full1 <= 25'd0;
		pair_fastchain0_iir0_csrstorage1_re1 <= 1'd0;
		pair_fastchain0_iir0_b01 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage2_storage_full1 <= 25'd0;
		pair_fastchain0_iir0_csrstorage2_re1 <= 1'd0;
		pair_fastchain0_iir0_b11 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage3_storage_full <= 25'd0;
		pair_fastchain0_iir0_csrstorage3_re <= 1'd0;
		pair_fastchain0_iir0_b2 <= 25'sd0;
		pair_fastchain0_iir0_csrstorage4_storage_full <= 25'd0;
		pair_fastchain0_iir0_csrstorage4_re <= 1'd0;
		pair_fastchain0_iir0_z0r1 <= 50'sd0;
		pair_fastchain0_iir0_y3 <= 25'sd0;
		pair_fastchain0_iir0_zr5 <= 50'sd0;
		pair_fastchain0_iir0_zr_correction_q2 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q2 <= 17'd0;
		pair_fastchain0_iir0_zr_correction_q3 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q3 <= 17'd0;
		pair_fastchain0_iir0_zr_correction_q4 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q4 <= 17'd0;
		pair_fastchain0_iir0_zr_correction_q5 <= 4'sd0;
		pair_fastchain0_iir0_zr_low_q5 <= 17'd0;
		pair_fastchain0_paralleltaplimitcsr0_y <= 25'sd0;
		pair_fastchain0_paralleltaplimitcsr0_error <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr0_min_storage_full <= 25'd16777216;
		pair_fastchain0_paralleltaplimitcsr0_min_re <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr0_max_storage_full <= 25'd16777215;
		pair_fastchain0_paralleltaplimitcsr0_max_re <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr0_bound_min <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr0_bound_max <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr0_neg_bound_min <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr0_neg_bound_max <= 28'sd0;
		pair_fastchain0_limitcsr1_limitcsr1_y <= 25'sd0;
		pair_fastchain0_limitcsr1_limitcsr1_error <= 1'd0;
		pair_fastchain0_limitcsr1_min_storage_full <= 25'd16777216;
		pair_fastchain0_limitcsr1_min_re <= 1'd0;
		pair_fastchain0_limitcsr1_max_storage_full <= 25'd16777215;
		pair_fastchain0_limitcsr1_max_re <= 1'd0;
		pair_fastchain0_limitcsr1_limit_max <= 26'sd0;
		pair_fastchain0_limitcsr1_limit_min <= 26'sd0;
		pair_fastchain0_iir1_y0 <= 25'sd0;
		pair_fastchain0_iir1_error0 <= 1'd0;
		pair_fastchain0_iir1_storage_full0 <= 27'd0;
		pair_fastchain0_iir1_re0 <= 1'd0;
		pair_fastchain0_iir1_a10 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage3_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage3_re <= 1'd0;
		pair_fastchain0_iir1_b00 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage4_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage4_re <= 1'd0;
		pair_fastchain0_iir1_b10 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage5_storage_full0 <= 25'd0;
		pair_fastchain0_iir1_csrstorage5_re0 <= 1'd0;
		pair_fastchain0_iir1_z0r0 <= 50'sd0;
		pair_fastchain0_iir1_y1 <= 25'sd0;
		pair_fastchain0_iir1_zr0 <= 50'sd0;
		pair_fastchain0_iir1_zr_correction_q0 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q0 <= 17'd0;
		pair_fastchain0_iir1_zr_correction_q1 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q1 <= 17'd0;
		pair_fastchain0_iir1_y2 <= 25'sd0;
		pair_fastchain0_iir1_error1 <= 1'd0;
		pair_fastchain0_iir1_storage_full1 <= 27'd0;
		pair_fastchain0_iir1_re1 <= 1'd0;
		pair_fastchain0_iir1_a11 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage5_storage_full1 <= 25'd0;
		pair_fastchain0_iir1_csrstorage5_re1 <= 1'd0;
		pair_fastchain0_iir1_a2 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage6_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage6_re <= 1'd0;
		pair_fastchain0_iir1_b01 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage7_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage7_re <= 1'd0;
		pair_fastchain0_iir1_b11 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage8_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage8_re <= 1'd0;
		pair_fastchain0_iir1_b2 <= 25'sd0;
		pair_fastchain0_iir1_csrstorage9_storage_full <= 25'd0;
		pair_fastchain0_iir1_csrstorage9_re <= 1'd0;
		pair_fastchain0_iir1_z0r1 <= 50'sd0;
		pair_fastchain0_iir1_y3 <= 25'sd0;
		pair_fastchain0_iir1_zr5 <= 50'sd0;
		pair_fastchain0_iir1_zr_correction_q2 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q2 <= 17'd0;
		pair_fastchain0_iir1_zr_correction_q3 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q3 <= 17'd0;
		pair_fastchain0_iir1_zr_correction_q4 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q4 <= 17'd0;
		pair_fastchain0_iir1_zr_correction_q5 <= 4'sd0;
		pair_fastchain0_iir1_zr_low_q5 <= 17'd0;
		pair_fastchain0_paralleltaplimitcsr1_y <= 25'sd0;
		pair_fastchain0_paralleltaplimitcsr1_error <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr1_min_storage_full <= 25'd16777216;
		pair_fastchain0_paralleltaplimitcsr1_min_re <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr1_max_storage_full <= 25'd16777215;
		pair_fastchain0_paralleltaplimitcsr1_max_re <= 1'd0;
		pair_fastchain0_paralleltaplimitcsr1_bound_min <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr1_bound_max <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr1_neg_bound_min <= 28'sd0;
		pair_fastchain0_paralleltaplimitcsr1_neg_bound_max <= 28'sd0;
		pair_csrbank0_bus_dat_r <= 8'd0;
		pair_fastchain1_y_tap_storage_full <= 2'd0;
		pair_fastchain1_y_tap_re <= 1'd0;
		pair_fastchain1_invert_storage_full <= 1'd0;
		pair_fastchain1_invert_re <= 1'd0;
		pair_fastchain1_delay_storage_full <= 32'd0;
		pair_fastchain1_delay_re <= 1'd0;
		pair_fastchain1_multiplier_storage_full <= 4'd1;
		pair_fastchain1_multiplier_re <= 1'd0;
		pair_fastchain1_speculativedemodcordic11 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic12 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic13 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic14 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic15 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic16 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic17 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic18 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic19 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic110 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic111 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic112 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic113 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic114 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic115 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic117 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic118 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic119 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic120 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic121 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic122 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic123 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic124 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic125 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic126 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic127 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic128 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic129 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic130 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic131 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic133 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic134 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic135 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic136 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic137 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic138 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic139 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic140 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic141 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic142 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic143 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic144 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic145 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic146 <= 17'sd0;
		pair_fastchain1_speculativedemodcordic147 <= 17'sd0;
		pair_fastchain1_ya <= 17'sd0;
		pair_fastchain1_limitcsr2_limitcsr2_y <= 25'sd0;
		pair_fastchain1_limitcsr2_limitcsr2_error <= 1'd0;
		pair_fastchain1_limitcsr2_min_storage_full <= 25'd16777216;
		pair_fastchain1_limitcsr2_min_re <= 1'd0;
		pair_fastchain1_limitcsr2_max_storage_full <= 25'd16777215;
		pair_fastchain1_limitcsr2_max_re <= 1'd0;
		pair_fastchain1_limitcsr2_limit_max <= 26'sd0;
		pair_fastchain1_limitcsr2_limit_min <= 26'sd0;
		pair_fastchain1_iir2_y0 <= 25'sd0;
		pair_fastchain1_iir2_error0 <= 1'd0;
		pair_fastchain1_iir2_storage_full0 <= 27'd0;
		pair_fastchain1_iir2_re0 <= 1'd0;
		pair_fastchain1_iir2_a10 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage6_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage6_re <= 1'd0;
		pair_fastchain1_iir2_b00 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage7_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage7_re <= 1'd0;
		pair_fastchain1_iir2_b10 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage8_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage8_re <= 1'd0;
		pair_fastchain1_iir2_z0r0 <= 50'sd0;
		pair_fastchain1_iir2_y1 <= 25'sd0;
		pair_fastchain1_iir2_zr0 <= 50'sd0;
		pair_fastchain1_iir2_zr_correction_q0 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q0 <= 17'd0;
		pair_fastchain1_iir2_zr_correction_q1 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q1 <= 17'd0;
		pair_fastchain1_iir2_y2 <= 25'sd0;
		pair_fastchain1_iir2_error1 <= 1'd0;
		pair_fastchain1_iir2_storage_full1 <= 27'd0;
		pair_fastchain1_iir2_re1 <= 1'd0;
		pair_fastchain1_iir2_a11 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage10_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage10_re <= 1'd0;
		pair_fastchain1_iir2_a2 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage11_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage11_re <= 1'd0;
		pair_fastchain1_iir2_b01 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage12_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage12_re <= 1'd0;
		pair_fastchain1_iir2_b11 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage13_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage13_re <= 1'd0;
		pair_fastchain1_iir2_b2 <= 25'sd0;
		pair_fastchain1_iir2_csrstorage14_storage_full <= 25'd0;
		pair_fastchain1_iir2_csrstorage14_re <= 1'd0;
		pair_fastchain1_iir2_z0r1 <= 50'sd0;
		pair_fastchain1_iir2_y3 <= 25'sd0;
		pair_fastchain1_iir2_zr5 <= 50'sd0;
		pair_fastchain1_iir2_zr_correction_q2 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q2 <= 17'd0;
		pair_fastchain1_iir2_zr_correction_q3 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q3 <= 17'd0;
		pair_fastchain1_iir2_zr_correction_q4 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q4 <= 17'd0;
		pair_fastchain1_iir2_zr_correction_q5 <= 4'sd0;
		pair_fastchain1_iir2_zr_low_q5 <= 17'd0;
		pair_fastchain1_earlycommontaplimitcsr0_y <= 25'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_error <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr0_common_reg <= 15'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_min_storage_full <= 25'd16777216;
		pair_fastchain1_earlycommontaplimitcsr0_min_re <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr0_max_storage_full <= 25'd16777215;
		pair_fastchain1_earlycommontaplimitcsr0_max_re <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr05 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr06 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr07 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr08 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_threshold_min_earlycommontaplimitcsr0_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_threshold_max_earlycommontaplimitcsr0_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_max_earlycommontaplimitcsr0_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr0_threshold_neg_min_earlycommontaplimitcsr0_result <= 28'sd0;
		pair_fastchain1_limitcsr3_limitcsr3_y <= 25'sd0;
		pair_fastchain1_limitcsr3_limitcsr3_error <= 1'd0;
		pair_fastchain1_limitcsr3_min_storage_full <= 25'd16777216;
		pair_fastchain1_limitcsr3_min_re <= 1'd0;
		pair_fastchain1_limitcsr3_max_storage_full <= 25'd16777215;
		pair_fastchain1_limitcsr3_max_re <= 1'd0;
		pair_fastchain1_limitcsr3_limit_max <= 26'sd0;
		pair_fastchain1_limitcsr3_limit_min <= 26'sd0;
		pair_fastchain1_iir3_y0 <= 25'sd0;
		pair_fastchain1_iir3_error0 <= 1'd0;
		pair_fastchain1_iir3_storage_full0 <= 27'd0;
		pair_fastchain1_iir3_re0 <= 1'd0;
		pair_fastchain1_iir3_a10 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage9_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage9_re <= 1'd0;
		pair_fastchain1_iir3_b00 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage10_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage10_re <= 1'd0;
		pair_fastchain1_iir3_b10 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage11_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage11_re <= 1'd0;
		pair_fastchain1_iir3_z0r0 <= 50'sd0;
		pair_fastchain1_iir3_y1 <= 25'sd0;
		pair_fastchain1_iir3_zr0 <= 50'sd0;
		pair_fastchain1_iir3_zr_correction_q0 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q0 <= 17'd0;
		pair_fastchain1_iir3_zr_correction_q1 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q1 <= 17'd0;
		pair_fastchain1_iir3_y2 <= 25'sd0;
		pair_fastchain1_iir3_error1 <= 1'd0;
		pair_fastchain1_iir3_storage_full1 <= 27'd0;
		pair_fastchain1_iir3_re1 <= 1'd0;
		pair_fastchain1_iir3_a11 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage15_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage15_re <= 1'd0;
		pair_fastchain1_iir3_a2 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage16_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage16_re <= 1'd0;
		pair_fastchain1_iir3_b01 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage17_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage17_re <= 1'd0;
		pair_fastchain1_iir3_b11 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage18_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage18_re <= 1'd0;
		pair_fastchain1_iir3_b2 <= 25'sd0;
		pair_fastchain1_iir3_csrstorage19_storage_full <= 25'd0;
		pair_fastchain1_iir3_csrstorage19_re <= 1'd0;
		pair_fastchain1_iir3_z0r1 <= 50'sd0;
		pair_fastchain1_iir3_y3 <= 25'sd0;
		pair_fastchain1_iir3_zr5 <= 50'sd0;
		pair_fastchain1_iir3_zr_correction_q2 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q2 <= 17'd0;
		pair_fastchain1_iir3_zr_correction_q3 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q3 <= 17'd0;
		pair_fastchain1_iir3_zr_correction_q4 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q4 <= 17'd0;
		pair_fastchain1_iir3_zr_correction_q5 <= 4'sd0;
		pair_fastchain1_iir3_zr_low_q5 <= 17'd0;
		pair_fastchain1_earlycommontaplimitcsr1_y <= 25'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_error <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr1_common_reg <= 15'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_min_storage_full <= 25'd16777216;
		pair_fastchain1_earlycommontaplimitcsr1_min_re <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr1_max_storage_full <= 25'd16777215;
		pair_fastchain1_earlycommontaplimitcsr1_max_re <= 1'd0;
		pair_fastchain1_earlycommontaplimitcsr15 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr16 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr17 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr18 <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_threshold_min_earlycommontaplimitcsr1_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_threshold_max_earlycommontaplimitcsr1_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_max_earlycommontaplimitcsr1_result <= 28'sd0;
		pair_fastchain1_earlycommontaplimitcsr1_threshold_neg_min_earlycommontaplimitcsr1_result <= 28'sd0;
		pair_csrbank1_bus_dat_r <= 8'd0;
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
	.A({{5{pair_fastchain0_iir0_b10[24]}}, pair_fastchain0_iir0_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr0[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low0),
	.PCOUT(pair_fastchain0_iir0_zr_cascade0)
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
	.A({{5{pair_fastchain0_iir0_b10[24]}}, pair_fastchain0_iir0_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_x0[24]}}, pair_fastchain0_iir0_x0[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade0),
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
	.P(pair_fastchain0_iir0_zr_high_q0)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_2 (
	.A({{5{pair_fastchain0_iir0_b00[24]}}, pair_fastchain0_iir0_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr_result0[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low1),
	.PCOUT(pair_fastchain0_iir0_zr_cascade1)
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
) DSP48E1_3 (
	.A({{5{pair_fastchain0_iir0_b00[24]}}, pair_fastchain0_iir0_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_x0[24]}}, pair_fastchain0_iir0_x0[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade1),
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
	.P(pair_fastchain0_iir0_zr_high_q1)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_4 (
	.A({{5{pair_fastchain0_iir0_b2[24]}}, pair_fastchain0_iir0_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr5[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low2),
	.PCOUT(pair_fastchain0_iir0_zr_cascade2)
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
) DSP48E1_5 (
	.A({{5{pair_fastchain0_iir0_b2[24]}}, pair_fastchain0_iir0_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_x1[24]}}, pair_fastchain0_iir0_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade2),
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
	.P(pair_fastchain0_iir0_zr_high_q2)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_6 (
	.A({{5{pair_fastchain0_iir0_b11[24]}}, pair_fastchain0_iir0_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr_result2[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low3),
	.PCOUT(pair_fastchain0_iir0_zr_cascade3)
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
) DSP48E1_7 (
	.A({{5{pair_fastchain0_iir0_b11[24]}}, pair_fastchain0_iir0_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_x1[24]}}, pair_fastchain0_iir0_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade3),
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
	.P(pair_fastchain0_iir0_zr_high_q3)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_8 (
	.A({{5{pair_fastchain0_iir0_b01[24]}}, pair_fastchain0_iir0_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr_result3[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low4),
	.PCOUT(pair_fastchain0_iir0_zr_cascade4)
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
) DSP48E1_9 (
	.A({{5{pair_fastchain0_iir0_b01[24]}}, pair_fastchain0_iir0_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_x1[24]}}, pair_fastchain0_iir0_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade4),
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
	.P(pair_fastchain0_iir0_zr_high_q4)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_10 (
	.A({{5{pair_fastchain0_iir0_a2[24]}}, pair_fastchain0_iir0_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir0_y3[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir0_zr_result4[47:0]),
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
	.P(pair_fastchain0_iir0_zr_low5),
	.PCOUT(pair_fastchain0_iir0_zr_cascade5)
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
) DSP48E1_11 (
	.A({{5{pair_fastchain0_iir0_a2[24]}}, pair_fastchain0_iir0_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir0_y3[24]}}, pair_fastchain0_iir0_y3[24:17]}),
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
	.PCIN(pair_fastchain0_iir0_zr_cascade5),
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
	.P(pair_fastchain0_iir0_zr_high_q5)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_12 (
	.A({{5{pair_fastchain0_iir1_b10[24]}}, pair_fastchain0_iir1_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr0[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low0),
	.PCOUT(pair_fastchain0_iir1_zr_cascade0)
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
) DSP48E1_13 (
	.A({{5{pair_fastchain0_iir1_b10[24]}}, pair_fastchain0_iir1_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_x0[24]}}, pair_fastchain0_iir1_x0[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade0),
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
	.P(pair_fastchain0_iir1_zr_high_q0)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_14 (
	.A({{5{pair_fastchain0_iir1_b00[24]}}, pair_fastchain0_iir1_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr_result0[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low1),
	.PCOUT(pair_fastchain0_iir1_zr_cascade1)
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
) DSP48E1_15 (
	.A({{5{pair_fastchain0_iir1_b00[24]}}, pair_fastchain0_iir1_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_x0[24]}}, pair_fastchain0_iir1_x0[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade1),
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
	.P(pair_fastchain0_iir1_zr_high_q1)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_16 (
	.A({{5{pair_fastchain0_iir1_b2[24]}}, pair_fastchain0_iir1_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr5[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low2),
	.PCOUT(pair_fastchain0_iir1_zr_cascade2)
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
) DSP48E1_17 (
	.A({{5{pair_fastchain0_iir1_b2[24]}}, pair_fastchain0_iir1_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_x1[24]}}, pair_fastchain0_iir1_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade2),
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
	.P(pair_fastchain0_iir1_zr_high_q2)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_18 (
	.A({{5{pair_fastchain0_iir1_b11[24]}}, pair_fastchain0_iir1_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr_result2[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low3),
	.PCOUT(pair_fastchain0_iir1_zr_cascade3)
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
) DSP48E1_19 (
	.A({{5{pair_fastchain0_iir1_b11[24]}}, pair_fastchain0_iir1_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_x1[24]}}, pair_fastchain0_iir1_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade3),
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
	.P(pair_fastchain0_iir1_zr_high_q3)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_20 (
	.A({{5{pair_fastchain0_iir1_b01[24]}}, pair_fastchain0_iir1_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr_result3[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low4),
	.PCOUT(pair_fastchain0_iir1_zr_cascade4)
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
) DSP48E1_21 (
	.A({{5{pair_fastchain0_iir1_b01[24]}}, pair_fastchain0_iir1_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_x1[24]}}, pair_fastchain0_iir1_x1[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade4),
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
	.P(pair_fastchain0_iir1_zr_high_q4)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_22 (
	.A({{5{pair_fastchain0_iir1_a2[24]}}, pair_fastchain0_iir1_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain0_iir1_y3[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain0_iir1_zr_result4[47:0]),
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
	.P(pair_fastchain0_iir1_zr_low5),
	.PCOUT(pair_fastchain0_iir1_zr_cascade5)
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
) DSP48E1_23 (
	.A({{5{pair_fastchain0_iir1_a2[24]}}, pair_fastchain0_iir1_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain0_iir1_y3[24]}}, pair_fastchain0_iir1_y3[24:17]}),
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
	.PCIN(pair_fastchain0_iir1_zr_cascade5),
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
	.P(pair_fastchain0_iir1_zr_high_q5)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_24 (
	.A({{5{pair_fastchain1_iir2_b10[24]}}, pair_fastchain1_iir2_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr0[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low0),
	.PCOUT(pair_fastchain1_iir2_zr_cascade0)
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
) DSP48E1_25 (
	.A({{5{pair_fastchain1_iir2_b10[24]}}, pair_fastchain1_iir2_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_x0[24]}}, pair_fastchain1_iir2_x0[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade0),
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
	.P(pair_fastchain1_iir2_zr_high_q0)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_26 (
	.A({{5{pair_fastchain1_iir2_b00[24]}}, pair_fastchain1_iir2_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr_result0[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low1),
	.PCOUT(pair_fastchain1_iir2_zr_cascade1)
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
) DSP48E1_27 (
	.A({{5{pair_fastchain1_iir2_b00[24]}}, pair_fastchain1_iir2_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_x0[24]}}, pair_fastchain1_iir2_x0[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade1),
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
	.P(pair_fastchain1_iir2_zr_high_q1)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_28 (
	.A({{5{pair_fastchain1_iir2_b2[24]}}, pair_fastchain1_iir2_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr5[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low2),
	.PCOUT(pair_fastchain1_iir2_zr_cascade2)
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
) DSP48E1_29 (
	.A({{5{pair_fastchain1_iir2_b2[24]}}, pair_fastchain1_iir2_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_x1[24]}}, pair_fastchain1_iir2_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade2),
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
	.P(pair_fastchain1_iir2_zr_high_q2)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_30 (
	.A({{5{pair_fastchain1_iir2_b11[24]}}, pair_fastchain1_iir2_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr_result2[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low3),
	.PCOUT(pair_fastchain1_iir2_zr_cascade3)
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
) DSP48E1_31 (
	.A({{5{pair_fastchain1_iir2_b11[24]}}, pair_fastchain1_iir2_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_x1[24]}}, pair_fastchain1_iir2_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade3),
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
	.P(pair_fastchain1_iir2_zr_high_q3)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_32 (
	.A({{5{pair_fastchain1_iir2_b01[24]}}, pair_fastchain1_iir2_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr_result3[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low4),
	.PCOUT(pair_fastchain1_iir2_zr_cascade4)
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
) DSP48E1_33 (
	.A({{5{pair_fastchain1_iir2_b01[24]}}, pair_fastchain1_iir2_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_x1[24]}}, pair_fastchain1_iir2_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade4),
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
	.P(pair_fastchain1_iir2_zr_high_q4)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_34 (
	.A({{5{pair_fastchain1_iir2_a2[24]}}, pair_fastchain1_iir2_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir2_y3[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir2_zr_result4[47:0]),
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
	.P(pair_fastchain1_iir2_zr_low5),
	.PCOUT(pair_fastchain1_iir2_zr_cascade5)
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
) DSP48E1_35 (
	.A({{5{pair_fastchain1_iir2_a2[24]}}, pair_fastchain1_iir2_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir2_y3[24]}}, pair_fastchain1_iir2_y3[24:17]}),
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
	.PCIN(pair_fastchain1_iir2_zr_cascade5),
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
	.P(pair_fastchain1_iir2_zr_high_q5)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_36 (
	.A({{5{pair_fastchain1_iir3_b10[24]}}, pair_fastchain1_iir3_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr0[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low0),
	.PCOUT(pair_fastchain1_iir3_zr_cascade0)
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
) DSP48E1_37 (
	.A({{5{pair_fastchain1_iir3_b10[24]}}, pair_fastchain1_iir3_b10}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_x0[24]}}, pair_fastchain1_iir3_x0[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade0),
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
	.P(pair_fastchain1_iir3_zr_high_q0)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_38 (
	.A({{5{pair_fastchain1_iir3_b00[24]}}, pair_fastchain1_iir3_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_x0[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr_result0[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low1),
	.PCOUT(pair_fastchain1_iir3_zr_cascade1)
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
) DSP48E1_39 (
	.A({{5{pair_fastchain1_iir3_b00[24]}}, pair_fastchain1_iir3_b00}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_x0[24]}}, pair_fastchain1_iir3_x0[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade1),
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
	.P(pair_fastchain1_iir3_zr_high_q1)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_40 (
	.A({{5{pair_fastchain1_iir3_b2[24]}}, pair_fastchain1_iir3_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr5[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low2),
	.PCOUT(pair_fastchain1_iir3_zr_cascade2)
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
) DSP48E1_41 (
	.A({{5{pair_fastchain1_iir3_b2[24]}}, pair_fastchain1_iir3_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_x1[24]}}, pair_fastchain1_iir3_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade2),
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
	.P(pair_fastchain1_iir3_zr_high_q2)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_42 (
	.A({{5{pair_fastchain1_iir3_b11[24]}}, pair_fastchain1_iir3_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr_result2[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low3),
	.PCOUT(pair_fastchain1_iir3_zr_cascade3)
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
) DSP48E1_43 (
	.A({{5{pair_fastchain1_iir3_b11[24]}}, pair_fastchain1_iir3_b11}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_x1[24]}}, pair_fastchain1_iir3_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade3),
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
	.P(pair_fastchain1_iir3_zr_high_q3)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_44 (
	.A({{5{pair_fastchain1_iir3_b01[24]}}, pair_fastchain1_iir3_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_x1[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr_result3[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low4),
	.PCOUT(pair_fastchain1_iir3_zr_cascade4)
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
) DSP48E1_45 (
	.A({{5{pair_fastchain1_iir3_b01[24]}}, pair_fastchain1_iir3_b01}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_x1[24]}}, pair_fastchain1_iir3_x1[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade4),
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
	.P(pair_fastchain1_iir3_zr_high_q4)
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
	.PREG(1'd0),
	.USE_DPORT("FALSE"),
	.USE_MULT("MULTIPLY"),
	.USE_SIMD("ONE48")
) DSP48E1_46 (
	.A({{5{pair_fastchain1_iir3_a2[24]}}, pair_fastchain1_iir3_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_fastchain1_iir3_y3[16:0]}),
	.BCIN(18'd0),
	.C(pair_fastchain1_iir3_zr_result4[47:0]),
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
	.P(pair_fastchain1_iir3_zr_low5),
	.PCOUT(pair_fastchain1_iir3_zr_cascade5)
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
) DSP48E1_47 (
	.A({{5{pair_fastchain1_iir3_a2[24]}}, pair_fastchain1_iir3_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_fastchain1_iir3_y3[24]}}, pair_fastchain1_iir3_y3[24:17]}),
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
	.PCIN(pair_fastchain1_iir3_zr_cascade5),
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
	.P(pair_fastchain1_iir3_zr_high_q5)
);

endmodule
