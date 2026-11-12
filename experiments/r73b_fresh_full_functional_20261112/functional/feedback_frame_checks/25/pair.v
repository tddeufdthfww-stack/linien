/* Machine-generated using Migen */
module feedback_frame_pair(
	input sys_clk,
	input sys_rst,
	input signed [27:0] ax,
	input signed [27:0] bx,
	input signed [13:0] adc,
	input ce_a,
	input ce_b,
	input limit_ce,
	input pid_ce,
	input running,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	input seed,
	input signed [42:0] seed_value,
	output [36:0] ref_mix,
	output [36:0] cand_mix,
	output [24:0] ref_input,
	output [24:0] cand_input,
	output [24:0] ref_y,
	output [24:0] cand_y,
	output ref_rail,
	output cand_rail,
	output [28:0] ref_lo,
	output [28:0] ref_hi,
	output [28:0] ref_lx,
	output ref_lce,
	output [358:0] ref_fields,
	output [358:0] cand_fields,
	output [42:0] ref_ir,
	output [42:0] cand_ir,
	output ref_execute,
	output cand_execute,
	output [151:0] config_value,
	output [7:0] csr_read,
	output [24:0] ref_a,
	output [24:0] ref_b,
	output [8:0] ref_fa,
	output [8:0] ref_fb,
	output [13:0] ref_offset,
	output ref_dual
);

reg [8:0] pair_controls_factor_a_storage_full = 9'd128;
wire [8:0] pair_controls_factor_a_storage;
reg pair_controls_factor_a_re = 1'd0;
wire [7:0] pair_controls_factor_a_encoded_low_data;
wire pair_controls_factor_a_encoded_low_write;
reg [8:0] pair_controls_factor_b_storage_full = 9'd128;
wire [8:0] pair_controls_factor_b_storage;
reg pair_controls_factor_b_re = 1'd0;
wire [7:0] pair_controls_factor_b_encoded_low_data;
wire pair_controls_factor_b_encoded_low_write;
reg [13:0] pair_controls_offset_storage_full = 14'd0;
wire [13:0] pair_controls_offset_storage;
reg pair_controls_offset_re = 1'd0;
reg pair_controls_dual_storage_full = 1'd0;
wire pair_controls_dual_storage;
reg pair_controls_dual_re = 1'd0;
reg pair_controls_mode_storage_full = 1'd0;
wire pair_controls_mode_storage;
reg pair_controls_mode_re = 1'd0;
reg signed [24:0] pair_controls_alignedinputlimitcsr_y = 25'sd0;
reg pair_controls_alignedinputlimitcsr_error = 1'd0;
wire pair_controls_update_en;
reg [24:0] pair_controls_min_storage_full = 25'd16777216;
wire [24:0] pair_controls_min_storage;
reg pair_controls_min_re = 1'd0;
reg [24:0] pair_controls_max_storage_full = 25'd16777215;
wire [24:0] pair_controls_max_storage;
reg pair_controls_max_re = 1'd0;
wire signed [28:0] pair_controls_x;
wire signed [28:0] pair_controls_limit_x;
reg signed [28:0] pair_controls_limit_y;
reg signed [28:0] pair_controls_limit_max = 29'sd0;
reg signed [28:0] pair_controls_limit_min = 29'sd0;
reg pair_controls_limit_railed;
reg [24:0] pair_controls_lo = 25'd16777216;
reg [24:0] pair_controls_hi = 25'd16777215;
reg [24:0] pair_controls_lq = 25'd16777216;
reg [24:0] pair_controls_hq = 25'd16777215;
reg signed [25:0] pair_controls_mixeralignedpid_error_s1 = 26'sd0;
reg signed [13:0] pair_controls_mixeralignedpid0 = 14'sd0;
reg signed [13:0] pair_controls_mixeralignedpid1 = 14'sd0;
reg signed [13:0] pair_controls_mixeralignedpid2 = 14'sd0;
reg pair_controls_mixeralignedpid3 = 1'd0;
reg pair_controls_mixeralignedpid4 = 1'd0;
reg pair_controls_mixeralignedpid5 = 1'd0;
reg pair_controls_mixeralignedpid6 = 1'd0;
reg [24:0] pair_controls_mixeralignedpid_setpoint_cohort = 25'd0;
reg pair_controls_mixeralignedpid_running_cohort = 1'd0;
reg [13:0] pair_controls_mixeralignedpid7 = 14'd0;
reg [13:0] pair_controls_mixeralignedpid8 = 14'd0;
reg [13:0] pair_controls_mixeralignedpid9 = 14'd0;
reg pair_controls_mixeralignedpid10 = 1'd0;
reg pair_controls_mixeralignedpid11 = 1'd0;
wire signed [24:0] pair_controls_mixeralignedpid_input;
wire pair_controls_mixeralignedpid_running;
wire pair_controls_mixeralignedpid_update_en0;
reg [24:0] pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full = 25'd0;
wire [24:0] pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage;
reg pair_controls_mixeralignedpid_mixeralignedpid_setpoint_re = 1'd0;
reg signed [25:0] pair_controls_mixeralignedpid_mixeralignedpid_error;
reg [13:0] pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full = 14'd0;
wire [13:0] pair_controls_mixeralignedpid_mixeralignedpid_kp_storage;
reg pair_controls_mixeralignedpid_mixeralignedpid_kp_re = 1'd0;
reg signed [38:0] pair_controls_mixeralignedpid_mixeralignedpid_kp_mult = 39'sd0;
wire signed [24:0] pair_controls_mixeralignedpid_mixeralignedpid_output_p;
reg [13:0] pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full = 14'd0;
wire [13:0] pair_controls_mixeralignedpid_mixeralignedpid_ki_storage;
reg pair_controls_mixeralignedpid_mixeralignedpid_ki_re = 1'd0;
reg pair_controls_mixeralignedpid_mixeralignedpid_reset_storage_full = 1'd0;
wire pair_controls_mixeralignedpid_mixeralignedpid_reset_storage;
reg pair_controls_mixeralignedpid_mixeralignedpid_reset_re = 1'd0;
reg signed [39:0] pair_controls_mixeralignedpid_mixeralignedpid_ki_mult = 40'sd0;
reg signed [42:0] pair_controls_mixeralignedpid_mixeralignedpid_int_reg = 43'sd0;
wire signed [43:0] pair_controls_mixeralignedpid_mixeralignedpid_int_sum;
wire signed [24:0] pair_controls_mixeralignedpid_mixeralignedpid_int_out;
wire pair_controls_mixeralignedpid_mixeralignedpid0;
wire pair_controls_mixeralignedpid_mixeralignedpid1;
reg [13:0] pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full = 14'd0;
wire [13:0] pair_controls_mixeralignedpid_mixeralignedpid_kd_storage;
reg pair_controls_mixeralignedpid_mixeralignedpid_kd_re = 1'd0;
reg signed [40:0] pair_controls_mixeralignedpid_mixeralignedpid_kd_mult = 41'sd0;
reg signed [33:0] pair_controls_mixeralignedpid_mixeralignedpid_kd_reg = 34'sd0;
reg signed [33:0] pair_controls_mixeralignedpid_mixeralignedpid_kd_reg_r = 34'sd0;
reg signed [33:0] pair_controls_mixeralignedpid_mixeralignedpid_output_d = 34'sd0;
reg signed [83:0] pair_controls_mixeralignedpid_mixeralignedpid_pid_sum = 84'sd0;
reg signed [24:0] pair_controls_mixeralignedpid_mixeralignedpid_pid_out;
wire pair_controls_mixeralignedpid_update_en1;
reg [24:0] pair_controls_mixeralignedpid_q0 = 25'd0;
reg pair_controls_mixeralignedpid_q1 = 1'd0;
reg [13:0] pair_controls_mixeralignedpid_q2 = 14'd0;
reg [13:0] pair_controls_mixeralignedpid_q3 = 14'd0;
reg [13:0] pair_controls_mixeralignedpid_q4 = 14'd0;
reg pair_controls_mixeralignedpid_q5 = 1'd0;
reg pair_controls_mixeralignedpid_q6 = 1'd0;
reg signed [13:0] pair_controls_offset_signed = 14'sd0;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_factor_a1_re;
wire pair_factor_a1_r;
wire pair_factor_a1_w;
wire pair_factor_a0_re;
wire [7:0] pair_factor_a0_r;
wire [7:0] pair_factor_a0_w;
wire pair_factor_b1_re;
wire pair_factor_b1_r;
wire pair_factor_b1_w;
wire pair_factor_b0_re;
wire [7:0] pair_factor_b0_r;
wire [7:0] pair_factor_b0_w;
wire pair_offset1_re;
wire [5:0] pair_offset1_r;
wire [5:0] pair_offset1_w;
wire pair_offset0_re;
wire [7:0] pair_offset0_r;
wire [7:0] pair_offset0_w;
wire pair_dual0_re;
wire pair_dual0_r;
wire pair_dual0_w;
wire pair_mode0_re;
wire pair_mode0_r;
wire pair_mode0_w;
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
wire pair_pid_setpoint3_re;
wire pair_pid_setpoint3_r;
wire pair_pid_setpoint3_w;
wire pair_pid_setpoint2_re;
wire [7:0] pair_pid_setpoint2_r;
wire [7:0] pair_pid_setpoint2_w;
wire pair_pid_setpoint1_re;
wire [7:0] pair_pid_setpoint1_r;
wire [7:0] pair_pid_setpoint1_w;
wire pair_pid_setpoint0_re;
wire [7:0] pair_pid_setpoint0_r;
wire [7:0] pair_pid_setpoint0_w;
wire pair_pid_kp1_re;
wire [5:0] pair_pid_kp1_r;
wire [5:0] pair_pid_kp1_w;
wire pair_pid_kp0_re;
wire [7:0] pair_pid_kp0_r;
wire [7:0] pair_pid_kp0_w;
wire pair_pid_ki1_re;
wire [5:0] pair_pid_ki1_r;
wire [5:0] pair_pid_ki1_w;
wire pair_pid_ki0_re;
wire [7:0] pair_pid_ki0_r;
wire [7:0] pair_pid_ki0_w;
wire pair_pid_reset0_re;
wire pair_pid_reset0_r;
wire pair_pid_reset0_w;
wire pair_pid_kd1_re;
wire [5:0] pair_pid_kd1_r;
wire [5:0] pair_pid_kd1_w;
wire pair_pid_kd0_re;
wire [7:0] pair_pid_kd0_r;
wire [7:0] pair_pid_kd0_w;
wire pair_sel;
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
reg signed [36:0] pair_registerederrormixer_y = 37'sd0;
wire signed [47:0] pair_registerederrormixer_p0;
wire signed [36:0] pair_registerederrormixer_product0;
wire signed [26:0] pair_registerederrormixer_triple0;
reg signed [36:0] pair_registerederrormixer_bias0;
reg signed [36:0] pair_registerederrormixer_bias_cohort0 = 37'sd0;
wire signed [47:0] pair_registerederrormixer_p1;
wire signed [36:0] pair_registerederrormixer_product1;
wire signed [26:0] pair_registerederrormixer_triple1;
reg signed [36:0] pair_registerederrormixer_bias1;
reg signed [36:0] pair_registerederrormixer_bias_cohort1 = 37'sd0;
wire signed [36:0] pair_registerederrormixer_off;
reg signed [36:0] pair_registerederrormixer_off_cohort = 37'sd0;
reg signed [24:0] pair_registerederrormixer_a_cohort = 25'sd0;
reg pair_registerederrormixer_dual_cohort = 1'd0;
wire [36:0] pair_registerederrormixer12;
wire [36:0] pair_registerederrormixer13;
wire [36:0] pair_registerederrormixer14;
wire [36:0] pair_registerederrormixer15;
wire [36:0] pair_registerederrormixer16;
wire [36:0] pair_registerederrormixer17;
wire signed [36:0] pair_registerederrormixer_merged;
reg signed [36:0] pair_registerederrormixer_summed;
wire signed [13:0] pair_alignment_direct_adc;
wire signed [24:0] pair_alignment_mixed_error;
wire pair_alignment_pid_only;
wire pair_alignment_limit_accept_en;
reg pair_alignment_limit_execute_en = 1'd0;
wire signed [24:0] pair_alignment_output;
reg signed [13:0] pair_alignment_adc_cohort = 14'sd0;
reg pair_alignment_mode_cohort = 1'd0;
reg signed [13:0] pair_alignment_q0 = 14'sd0;
reg pair_alignment_q1 = 1'd0;
reg pair_alignment_q2 = 1'd0;
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
reg signed [24:0] pair_ref_limit_limitcsr_y = 25'sd0;
reg pair_ref_limit_limitcsr_error = 1'd0;
wire pair_ref_limit_update_en;
wire signed [28:0] pair_ref_limit_x;
wire [24:0] pair_ref_limit_min_storage;
wire [24:0] pair_ref_limit_max_storage;
wire signed [28:0] pair_ref_limit_limit_x;
reg signed [28:0] pair_ref_limit_limit_y;
reg signed [28:0] pair_ref_limit_limit_max = 29'sd0;
reg signed [28:0] pair_ref_limit_limit_min = 29'sd0;
reg pair_ref_limit_limit_railed;
reg signed [25:0] pair_ref_pid_error_s1 = 26'sd0;
reg signed [13:0] pair_ref_pid_kp_s1 = 14'sd0;
reg signed [13:0] pair_ref_pid_ki_s1 = 14'sd0;
reg signed [13:0] pair_ref_pid_kd_s1 = 14'sd0;
reg pair_ref_pid_reset_s1 = 1'd0;
reg pair_ref_pid_reset_s2 = 1'd0;
reg pair_ref_pid_valid_s1 = 1'd0;
reg pair_ref_pid_valid_s2 = 1'd0;
wire signed [24:0] pair_ref_pid_input;
wire pair_ref_pid_running;
wire pair_ref_pid_update_en0;
wire [24:0] pair_ref_pid_pipelinedpid_setpoint_storage;
wire signed [24:0] pair_ref_pid_pipelinedpid_setpoint_signed;
reg signed [25:0] pair_ref_pid_pipelinedpid_error;
wire [13:0] pair_ref_pid_pipelinedpid_kp_storage;
reg signed [38:0] pair_ref_pid_pipelinedpid_kp_mult = 39'sd0;
wire signed [24:0] pair_ref_pid_pipelinedpid_output_p;
wire [13:0] pair_ref_pid_pipelinedpid_ki_storage;
wire pair_ref_pid_pipelinedpid_reset_storage;
reg signed [39:0] pair_ref_pid_pipelinedpid_ki_mult = 40'sd0;
reg signed [42:0] pair_ref_pid_pipelinedpid_int_reg = 43'sd0;
wire signed [43:0] pair_ref_pid_pipelinedpid_int_sum;
wire signed [24:0] pair_ref_pid_pipelinedpid_int_out;
wire pair_ref_pid_pipelinedpid0;
wire pair_ref_pid_pipelinedpid1;
wire [13:0] pair_ref_pid_pipelinedpid_kd_storage;
reg signed [40:0] pair_ref_pid_pipelinedpid_kd_mult = 41'sd0;
reg signed [33:0] pair_ref_pid_pipelinedpid_kd_reg = 34'sd0;
reg signed [33:0] pair_ref_pid_pipelinedpid_kd_reg_r = 34'sd0;
reg signed [33:0] pair_ref_pid_pipelinedpid_output_d = 34'sd0;
reg signed [83:0] pair_ref_pid_pipelinedpid_pid_sum = 84'sd0;
reg signed [24:0] pair_ref_pid_pipelinedpid_pid_out;
wire pair_ref_pid_update_en1;
reg signed [24:0] pair_pair_q0 = 25'sd0;
reg signed [24:0] pair_pair_q1 = 25'sd0;
reg signed [24:0] pair_pair_q2 = 25'sd0;
reg signed [24:0] pair_pair_q3 = 25'sd0;
reg [8:0] pair_pair_q4 = 9'd128;
reg [8:0] pair_pair_q5 = 9'd128;
reg [8:0] pair_pair_q6 = 9'd128;
reg [8:0] pair_pair_q7 = 9'd128;
reg signed [13:0] pair_pair_q8 = 14'sd0;
reg signed [13:0] pair_pair_q9 = 14'sd0;
reg pair_pair_q10 = 1'd0;
reg pair_pair_q11 = 1'd0;
reg pair_pair_q12 = 1'd0;
reg pair_pair_q13 = 1'd0;
reg signed [13:0] pair_pair_q14 = 14'sd0;
reg signed [13:0] pair_pair_q15 = 14'sd0;
reg signed [36:0] pair_refmix;
wire signed [24:0] pair_refinput;
reg [24:0] pair_pair_q16 = 25'd16777216;
reg [24:0] pair_pair_q17 = 25'd16777216;
reg [24:0] pair_pair_q18 = 25'd16777215;
reg [24:0] pair_pair_q19 = 25'd16777215;
reg pair_pair_q20 = 1'd0;
reg pair_pair_q21 = 1'd0;
reg pair_pair_q22 = 1'd0;
reg pair_pair_q23 = 1'd0;
reg pair_pair_q24 = 1'd0;
reg pair_pair_q25 = 1'd0;
reg [24:0] pair_pair_q26 = 25'd0;
reg [24:0] pair_pair_q27 = 25'd0;
reg [13:0] pair_pair_q28 = 14'd0;
reg [13:0] pair_pair_q29 = 14'd0;
reg [13:0] pair_pair_q30 = 14'd0;
reg [13:0] pair_pair_q31 = 14'd0;
reg [13:0] pair_pair_q32 = 14'd0;
reg [13:0] pair_pair_q33 = 14'd0;
reg pair_pair_q34 = 1'd0;
reg pair_pair_q35 = 1'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_a_limit_x = ax;
assign pair_b_limit_x = bx;
assign pair_a_limit_update_en = ce_a;
assign pair_b_limit_update_en = ce_b;
assign pair_a_limit_min_storage = 25'd16777216;
assign pair_b_limit_min_storage = 25'd16777216;
assign pair_a_limit_max_storage = 24'd16777215;
assign pair_b_limit_max_storage = 24'd16777215;
assign pair_registerederrormixer0 = pair_a_limit_limitcsr_y;
assign pair_registerederrormixer1 = pair_b_limit_limitcsr_y;
assign pair_registerederrormixer2 = pair_a_limit_limit_y;
assign pair_registerederrormixer3 = pair_b_limit_limit_y;
assign pair_registerederrormixer4 = pair_a_limit_update_en;
assign pair_registerederrormixer5 = pair_b_limit_update_en;
assign pair_registerederrormixer6 = pair_controls_factor_a_storage[8];
assign pair_registerederrormixer7 = pair_controls_factor_b_storage[8];
assign pair_registerederrormixer8 = pair_controls_factor_a_encoded_low_data;
assign pair_registerederrormixer9 = pair_controls_factor_b_encoded_low_data;
assign pair_registerederrormixer10 = pair_controls_factor_a_encoded_low_write;
assign pair_registerederrormixer11 = pair_controls_factor_b_encoded_low_write;
assign pair_registerederrormixer_offset = pair_controls_offset_signed;
assign pair_registerederrormixer_dual = pair_controls_dual_storage;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_refmix <= 37'sd0;
	if (pair_pair_q11) begin
		pair_refmix <= ((($signed({1'd0, pair_pair_q5}) * pair_pair_q1) + ($signed({1'd0, pair_pair_q7}) * pair_pair_q3)) + (pair_pair_q9 <<< 5'd19));
	end else begin
		pair_refmix <= ((pair_pair_q1 <<< 4'd8) + (pair_pair_q9 <<< 5'd19));
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_controls_x = (pair_registerederrormixer_y >>> 4'd8);
assign pair_ref_limit_x = (pair_refmix >>> 4'd8);
assign pair_ref_limit_min_storage = pair_pair_q17;
assign pair_ref_limit_max_storage = pair_pair_q19;
assign pair_ref_limit_update_en = pair_pair_q21;
assign pair_alignment_direct_adc = adc;
assign pair_alignment_mixed_error = pair_controls_alignedinputlimitcsr_y;
assign pair_alignment_pid_only = pair_controls_mode_storage;
assign pair_alignment_limit_accept_en = limit_ce;
assign pair_controls_update_en = pair_alignment_limit_execute_en;
assign pair_refinput = (pair_pair_q13 ? (pair_pair_q15 <<< 4'd11) : pair_ref_limit_limitcsr_y);
assign pair_ref_pid_input = (pair_refinput >>> 1'd0);
assign pair_controls_mixeralignedpid_input = (pair_alignment_output >>> 1'd0);
assign pair_ref_pid_running = pair_pair_q23;
assign pair_controls_mixeralignedpid_running = running;
assign pair_ref_pid_update_en1 = pair_pair_q25;
assign pair_controls_mixeralignedpid_update_en1 = pid_ce;
assign pair_ref_pid_pipelinedpid_setpoint_storage = pair_pair_q27;
assign pair_ref_pid_pipelinedpid_kp_storage = pair_pair_q29;
assign pair_ref_pid_pipelinedpid_ki_storage = pair_pair_q31;
assign pair_ref_pid_pipelinedpid_kd_storage = pair_pair_q33;
assign pair_ref_pid_pipelinedpid_reset_storage = pair_pair_q35;
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign ref_mix = pair_refmix;
assign cand_mix = pair_registerederrormixer_y;
assign ref_input = pair_refinput;
assign cand_input = pair_alignment_output;
assign ref_y = pair_ref_limit_limitcsr_y;
assign cand_y = pair_controls_alignedinputlimitcsr_y;
assign ref_rail = pair_ref_limit_limitcsr_error;
assign cand_rail = pair_controls_alignedinputlimitcsr_error;
assign ref_lo = pair_ref_limit_limit_min;
assign ref_hi = pair_ref_limit_limit_max;
assign ref_lx = pair_ref_limit_x;
assign ref_lce = pair_ref_limit_update_en;
assign ref_fields = {pair_ref_pid_pipelinedpid_pid_out, pair_ref_pid_pipelinedpid_pid_sum, pair_ref_pid_pipelinedpid_output_d, pair_ref_pid_pipelinedpid_int_out, pair_ref_pid_pipelinedpid_int_reg, pair_ref_pid_pipelinedpid_int_sum, pair_ref_pid_pipelinedpid_ki_mult, pair_ref_pid_pipelinedpid_output_p, pair_ref_pid_pipelinedpid_kp_mult};
assign cand_fields = {pair_controls_mixeralignedpid_mixeralignedpid_pid_out, pair_controls_mixeralignedpid_mixeralignedpid_pid_sum, pair_controls_mixeralignedpid_mixeralignedpid_output_d, pair_controls_mixeralignedpid_mixeralignedpid_int_out, pair_controls_mixeralignedpid_mixeralignedpid_int_reg, pair_controls_mixeralignedpid_mixeralignedpid_int_sum, pair_controls_mixeralignedpid_mixeralignedpid_ki_mult, pair_controls_mixeralignedpid_mixeralignedpid_output_p, pair_controls_mixeralignedpid_mixeralignedpid_kp_mult};
assign ref_ir = pair_ref_pid_pipelinedpid_int_reg;
assign cand_ir = pair_controls_mixeralignedpid_mixeralignedpid_int_reg;
assign ref_execute = pair_ref_pid_update_en0;
assign cand_execute = pair_controls_mixeralignedpid_update_en0;
assign config_value = {pair_controls_mixeralignedpid_mixeralignedpid_reset_storage, pair_controls_mixeralignedpid_mixeralignedpid_kd_storage, pair_controls_mixeralignedpid_mixeralignedpid_ki_storage, pair_controls_mixeralignedpid_mixeralignedpid_kp_storage, pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage, pair_controls_max_storage, pair_controls_min_storage, pair_controls_mode_storage, pair_controls_dual_storage, pair_controls_offset_storage, pair_controls_factor_b_storage, pair_controls_factor_a_storage};
assign csr_read = pair_bus_dat_r;
assign ref_a = pair_pair_q1;
assign ref_b = pair_pair_q3;
assign ref_fa = pair_pair_q5;
assign ref_fb = pair_pair_q7;
assign ref_offset = pair_pair_q9;
assign ref_dual = pair_pair_q11;
assign pair_controls_limit_x = pair_controls_x;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_controls_limit_y <= 29'sd0;
	pair_controls_limit_railed <= 1'd0;
	if ((pair_controls_limit_x >= pair_controls_limit_max)) begin
		pair_controls_limit_y <= pair_controls_limit_max;
		pair_controls_limit_railed <= 1'd1;
	end else begin
		if ((pair_controls_limit_x <= pair_controls_limit_min)) begin
			pair_controls_limit_y <= pair_controls_limit_min;
			pair_controls_limit_railed <= 1'd1;
		end else begin
			pair_controls_limit_y <= pair_controls_limit_x;
			pair_controls_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_controls_mixeralignedpid_mixeralignedpid_error <= 26'sd0;
	if (pair_controls_mixeralignedpid_running_cohort) begin
		pair_controls_mixeralignedpid_mixeralignedpid_error <= (pair_controls_mixeralignedpid_input - $signed({1'd0, pair_controls_mixeralignedpid_setpoint_cohort}));
	end else begin
		pair_controls_mixeralignedpid_mixeralignedpid_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_controls_mixeralignedpid_mixeralignedpid_output_p = (pair_controls_mixeralignedpid_mixeralignedpid_kp_mult >>> 4'd12);
assign pair_controls_mixeralignedpid_mixeralignedpid_int_sum = (pair_controls_mixeralignedpid_mixeralignedpid_ki_mult + pair_controls_mixeralignedpid_mixeralignedpid_int_reg);
assign pair_controls_mixeralignedpid_mixeralignedpid_int_out = (pair_controls_mixeralignedpid_mixeralignedpid_int_reg >>> 5'd18);
assign pair_controls_mixeralignedpid_mixeralignedpid0 = ((~pair_controls_mixeralignedpid_mixeralignedpid_int_sum[43]) & (pair_controls_mixeralignedpid_mixeralignedpid_int_sum[42] | ((pair_controls_mixeralignedpid_mixeralignedpid_int_sum[41:18] == $signed({1'd0, 24'd16777215})) & (pair_controls_mixeralignedpid_mixeralignedpid_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_controls_mixeralignedpid_mixeralignedpid1 = (pair_controls_mixeralignedpid_mixeralignedpid_int_sum[43] & ((~pair_controls_mixeralignedpid_mixeralignedpid_int_sum[42]) | ((pair_controls_mixeralignedpid_mixeralignedpid_int_sum[41:18] == $signed({1'd0, 1'd0})) & (pair_controls_mixeralignedpid_mixeralignedpid_int_sum[17:0] != $signed({1'd0, 18'd262143})))));

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_controls_mixeralignedpid_mixeralignedpid_pid_out <= 25'sd0;
	if (((~pair_controls_mixeralignedpid_mixeralignedpid_pid_sum[83]) & (pair_controls_mixeralignedpid_mixeralignedpid_pid_sum[83:24] != $signed({1'd0, 1'd0})))) begin
		pair_controls_mixeralignedpid_mixeralignedpid_pid_out <= 24'd16777215;
	end else begin
		if ((pair_controls_mixeralignedpid_mixeralignedpid_pid_sum[83] & (pair_controls_mixeralignedpid_mixeralignedpid_pid_sum[83:24] != $signed({1'd0, 60'd1152921504606846975})))) begin
			pair_controls_mixeralignedpid_mixeralignedpid_pid_out <= 25'sd16777216;
		end else begin
			pair_controls_mixeralignedpid_mixeralignedpid_pid_out <= pair_controls_mixeralignedpid_mixeralignedpid_pid_sum[24:0];
		end
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_controls_mixeralignedpid_update_en0 = pair_controls_mixeralignedpid6;
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_factor_a1_r = pair_bus_dat_w[0];
assign pair_factor_a1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd0));
assign pair_factor_a0_r = pair_bus_dat_w[7:0];
assign pair_factor_a0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd1));
assign pair_factor_b1_r = pair_bus_dat_w[0];
assign pair_factor_b1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd2));
assign pair_factor_b0_r = pair_bus_dat_w[7:0];
assign pair_factor_b0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd3));
assign pair_offset1_r = pair_bus_dat_w[5:0];
assign pair_offset1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd4));
assign pair_offset0_r = pair_bus_dat_w[7:0];
assign pair_offset0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd5));
assign pair_dual0_r = pair_bus_dat_w[0];
assign pair_dual0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd6));
assign pair_mode0_r = pair_bus_dat_w[0];
assign pair_mode0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd7));
assign pair_limit_min3_r = pair_bus_dat_w[0];
assign pair_limit_min3_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd8));
assign pair_limit_min2_r = pair_bus_dat_w[7:0];
assign pair_limit_min2_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd9));
assign pair_limit_min1_r = pair_bus_dat_w[7:0];
assign pair_limit_min1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd10));
assign pair_limit_min0_r = pair_bus_dat_w[7:0];
assign pair_limit_min0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd11));
assign pair_limit_max3_r = pair_bus_dat_w[0];
assign pair_limit_max3_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd12));
assign pair_limit_max2_r = pair_bus_dat_w[7:0];
assign pair_limit_max2_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd13));
assign pair_limit_max1_r = pair_bus_dat_w[7:0];
assign pair_limit_max1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd14));
assign pair_limit_max0_r = pair_bus_dat_w[7:0];
assign pair_limit_max0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd15));
assign pair_pid_setpoint3_r = pair_bus_dat_w[0];
assign pair_pid_setpoint3_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd16));
assign pair_pid_setpoint2_r = pair_bus_dat_w[7:0];
assign pair_pid_setpoint2_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd17));
assign pair_pid_setpoint1_r = pair_bus_dat_w[7:0];
assign pair_pid_setpoint1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd18));
assign pair_pid_setpoint0_r = pair_bus_dat_w[7:0];
assign pair_pid_setpoint0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd19));
assign pair_pid_kp1_r = pair_bus_dat_w[5:0];
assign pair_pid_kp1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd20));
assign pair_pid_kp0_r = pair_bus_dat_w[7:0];
assign pair_pid_kp0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd21));
assign pair_pid_ki1_r = pair_bus_dat_w[5:0];
assign pair_pid_ki1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd22));
assign pair_pid_ki0_r = pair_bus_dat_w[7:0];
assign pair_pid_ki0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd23));
assign pair_pid_reset0_r = pair_bus_dat_w[0];
assign pair_pid_reset0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd24));
assign pair_pid_kd1_r = pair_bus_dat_w[5:0];
assign pair_pid_kd1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd25));
assign pair_pid_kd0_r = pair_bus_dat_w[7:0];
assign pair_pid_kd0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd26));
assign pair_controls_factor_a_storage = pair_controls_factor_a_storage_full[8:0];
assign pair_factor_a1_w = pair_controls_factor_a_storage_full[8];
assign pair_factor_a0_w = pair_controls_factor_a_storage_full[7:0];
assign pair_controls_factor_a_encoded_low_data = (pair_factor_a0_r ^ 8'd128);
assign pair_controls_factor_a_encoded_low_write = pair_factor_a0_re;
assign pair_controls_factor_b_storage = pair_controls_factor_b_storage_full[8:0];
assign pair_factor_b1_w = pair_controls_factor_b_storage_full[8];
assign pair_factor_b0_w = pair_controls_factor_b_storage_full[7:0];
assign pair_controls_factor_b_encoded_low_data = (pair_factor_b0_r ^ 8'd128);
assign pair_controls_factor_b_encoded_low_write = pair_factor_b0_re;
assign pair_controls_offset_storage = pair_controls_offset_storage_full[13:0];
assign pair_offset1_w = pair_controls_offset_storage_full[13:8];
assign pair_offset0_w = pair_controls_offset_storage_full[7:0];
assign pair_controls_dual_storage = pair_controls_dual_storage_full;
assign pair_dual0_w = pair_controls_dual_storage_full;
assign pair_controls_mode_storage = pair_controls_mode_storage_full;
assign pair_mode0_w = pair_controls_mode_storage_full;
assign pair_controls_min_storage = pair_controls_min_storage_full[24:0];
assign pair_limit_min3_w = pair_controls_min_storage_full[24];
assign pair_limit_min2_w = pair_controls_min_storage_full[23:16];
assign pair_limit_min1_w = pair_controls_min_storage_full[15:8];
assign pair_limit_min0_w = pair_controls_min_storage_full[7:0];
assign pair_controls_max_storage = pair_controls_max_storage_full[24:0];
assign pair_limit_max3_w = pair_controls_max_storage_full[24];
assign pair_limit_max2_w = pair_controls_max_storage_full[23:16];
assign pair_limit_max1_w = pair_controls_max_storage_full[15:8];
assign pair_limit_max0_w = pair_controls_max_storage_full[7:0];
assign pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage = pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[24:0];
assign pair_pid_setpoint3_w = pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[24];
assign pair_pid_setpoint2_w = pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[23:16];
assign pair_pid_setpoint1_w = pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[15:8];
assign pair_pid_setpoint0_w = pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[7:0];
assign pair_controls_mixeralignedpid_mixeralignedpid_kp_storage = pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full[13:0];
assign pair_pid_kp1_w = pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full[13:8];
assign pair_pid_kp0_w = pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full[7:0];
assign pair_controls_mixeralignedpid_mixeralignedpid_ki_storage = pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full[13:0];
assign pair_pid_ki1_w = pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full[13:8];
assign pair_pid_ki0_w = pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full[7:0];
assign pair_controls_mixeralignedpid_mixeralignedpid_reset_storage = pair_controls_mixeralignedpid_mixeralignedpid_reset_storage_full;
assign pair_pid_reset0_w = pair_controls_mixeralignedpid_mixeralignedpid_reset_storage_full;
assign pair_controls_mixeralignedpid_mixeralignedpid_kd_storage = pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full[13:0];
assign pair_pid_kd1_w = pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full[13:8];
assign pair_pid_kd0_w = pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full[7:0];
assign pair_registerederrormixer_product0 = pair_registerederrormixer_p0;
assign pair_registerederrormixer_triple0 = (pair_registerederrormixer0 + (pair_registerederrormixer0 <<< 1'd1));

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_bias0 <= 37'sd0;
	if (pair_registerederrormixer6) begin
		pair_registerederrormixer_bias0 <= (pair_registerederrormixer_triple0 <<< 3'd7);
	end else begin
		pair_registerederrormixer_bias0 <= (pair_registerederrormixer0 <<< 3'd7);
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_registerederrormixer_product1 = pair_registerederrormixer_p1;
assign pair_registerederrormixer_triple1 = (pair_registerederrormixer1 + (pair_registerederrormixer1 <<< 1'd1));

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_bias1 <= 37'sd0;
	if (pair_registerederrormixer7) begin
		pair_registerederrormixer_bias1 <= (pair_registerederrormixer_triple1 <<< 3'd7);
	end else begin
		pair_registerederrormixer_bias1 <= (pair_registerederrormixer1 <<< 3'd7);
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_registerederrormixer_off = (pair_registerederrormixer_offset <<< 5'd19);
assign pair_registerederrormixer12 = ((pair_registerederrormixer_product0 ^ pair_registerederrormixer_bias_cohort0) ^ pair_registerederrormixer_product1);
assign pair_registerederrormixer13 = ((((pair_registerederrormixer_product0 & pair_registerederrormixer_bias_cohort0) | (pair_registerederrormixer_product0 & pair_registerederrormixer_product1)) | (pair_registerederrormixer_bias_cohort0 & pair_registerederrormixer_product1)) <<< 1'd1);
assign pair_registerederrormixer14 = ((pair_registerederrormixer_bias_cohort1 ^ pair_registerederrormixer_off_cohort) ^ $signed({1'd0, pair_registerederrormixer12}));
assign pair_registerederrormixer15 = ((((pair_registerederrormixer_bias_cohort1 & pair_registerederrormixer_off_cohort) | (pair_registerederrormixer_bias_cohort1 & $signed({1'd0, pair_registerederrormixer12}))) | (pair_registerederrormixer_off_cohort & $signed({1'd0, pair_registerederrormixer12}))) <<< 1'd1);
assign pair_registerederrormixer16 = ((pair_registerederrormixer13 ^ pair_registerederrormixer14) ^ pair_registerederrormixer15);
assign pair_registerederrormixer17 = ((((pair_registerederrormixer13 & pair_registerederrormixer14) | (pair_registerederrormixer13 & pair_registerederrormixer15)) | (pair_registerederrormixer14 & pair_registerederrormixer15)) <<< 1'd1);
assign pair_registerederrormixer_merged = (pair_registerederrormixer16 + pair_registerederrormixer17);

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_registerederrormixer_summed <= 37'sd0;
	if (pair_registerederrormixer_dual_cohort) begin
		pair_registerederrormixer_summed <= pair_registerederrormixer_merged;
	end else begin
		pair_registerederrormixer_summed <= ((pair_registerederrormixer_a_cohort <<< 4'd8) + pair_registerederrormixer_off_cohort);
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign pair_alignment_output = (pair_alignment_mode_cohort ? (pair_alignment_adc_cohort <<< 4'd11) : pair_alignment_mixed_error);
assign pair_a_limit_limit_x = pair_a_limit_x;

// synthesis translate_off
reg dummy_d_7;
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
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign pair_b_limit_limit_x = pair_b_limit_x;

// synthesis translate_off
reg dummy_d_8;
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
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign pair_ref_limit_limit_x = pair_ref_limit_x;

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	pair_ref_limit_limit_y <= 29'sd0;
	pair_ref_limit_limit_railed <= 1'd0;
	if ((pair_ref_limit_limit_x >= pair_ref_limit_limit_max)) begin
		pair_ref_limit_limit_y <= pair_ref_limit_limit_max;
		pair_ref_limit_limit_railed <= 1'd1;
	end else begin
		if ((pair_ref_limit_limit_x <= pair_ref_limit_limit_min)) begin
			pair_ref_limit_limit_y <= pair_ref_limit_limit_min;
			pair_ref_limit_limit_railed <= 1'd1;
		end else begin
			pair_ref_limit_limit_y <= pair_ref_limit_limit_x;
			pair_ref_limit_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign pair_ref_pid_pipelinedpid_setpoint_signed = pair_ref_pid_pipelinedpid_setpoint_storage;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	pair_ref_pid_pipelinedpid_error <= 26'sd0;
	if (pair_ref_pid_running) begin
		pair_ref_pid_pipelinedpid_error <= (pair_ref_pid_input - $signed({1'd0, pair_ref_pid_pipelinedpid_setpoint_storage}));
	end else begin
		pair_ref_pid_pipelinedpid_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign pair_ref_pid_pipelinedpid_output_p = (pair_ref_pid_pipelinedpid_kp_mult >>> 4'd12);
assign pair_ref_pid_pipelinedpid_int_sum = (pair_ref_pid_pipelinedpid_ki_mult + pair_ref_pid_pipelinedpid_int_reg);
assign pair_ref_pid_pipelinedpid_int_out = (pair_ref_pid_pipelinedpid_int_reg >>> 5'd18);
assign pair_ref_pid_pipelinedpid0 = ((~pair_ref_pid_pipelinedpid_int_sum[43]) & (pair_ref_pid_pipelinedpid_int_sum[42] | ((pair_ref_pid_pipelinedpid_int_sum[41:18] == $signed({1'd0, 24'd16777215})) & (pair_ref_pid_pipelinedpid_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_ref_pid_pipelinedpid1 = (pair_ref_pid_pipelinedpid_int_sum[43] & ((~pair_ref_pid_pipelinedpid_int_sum[42]) | ((pair_ref_pid_pipelinedpid_int_sum[41:18] == $signed({1'd0, 1'd0})) & (pair_ref_pid_pipelinedpid_int_sum[17:0] != $signed({1'd0, 18'd262143})))));

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	pair_ref_pid_pipelinedpid_pid_out <= 25'sd0;
	if ((pair_ref_pid_pipelinedpid_pid_sum > $signed({1'd0, 24'd16777215}))) begin
		pair_ref_pid_pipelinedpid_pid_out <= 24'd16777215;
	end else begin
		if ((pair_ref_pid_pipelinedpid_pid_sum < 25'sd16777216)) begin
			pair_ref_pid_pipelinedpid_pid_out <= 25'sd16777216;
		end else begin
			pair_ref_pid_pipelinedpid_pid_out <= pair_ref_pid_pipelinedpid_pid_sum[24:0];
		end
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign pair_ref_pid_update_en0 = pair_ref_pid_valid_s2;

always @(posedge sys_clk) begin
	pair_pair_q0 <= pair_a_limit_limitcsr_y;
	pair_pair_q1 <= pair_pair_q0;
	pair_pair_q2 <= pair_b_limit_limitcsr_y;
	pair_pair_q3 <= pair_pair_q2;
	pair_pair_q4 <= pair_controls_factor_a_storage;
	pair_pair_q5 <= pair_pair_q4;
	pair_pair_q6 <= pair_controls_factor_b_storage;
	pair_pair_q7 <= pair_pair_q6;
	pair_pair_q8 <= pair_controls_offset_signed;
	pair_pair_q9 <= pair_pair_q8;
	pair_pair_q10 <= pair_controls_dual_storage;
	pair_pair_q11 <= pair_pair_q10;
	pair_pair_q12 <= pair_controls_mode_storage;
	pair_pair_q13 <= pair_pair_q12;
	pair_pair_q14 <= adc;
	pair_pair_q15 <= pair_pair_q14;
	pair_pair_q16 <= pair_controls_min_storage;
	pair_pair_q17 <= pair_pair_q16;
	pair_pair_q18 <= pair_controls_max_storage;
	pair_pair_q19 <= pair_pair_q18;
	pair_pair_q20 <= limit_ce;
	pair_pair_q21 <= pair_pair_q20;
	pair_pair_q22 <= running;
	pair_pair_q23 <= pair_pair_q22;
	pair_pair_q24 <= pid_ce;
	pair_pair_q25 <= pair_pair_q24;
	pair_pair_q26 <= pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage;
	pair_pair_q27 <= pair_pair_q26;
	pair_pair_q28 <= pair_controls_mixeralignedpid_mixeralignedpid_kp_storage;
	pair_pair_q29 <= pair_pair_q28;
	pair_pair_q30 <= pair_controls_mixeralignedpid_mixeralignedpid_ki_storage;
	pair_pair_q31 <= pair_pair_q30;
	pair_pair_q32 <= pair_controls_mixeralignedpid_mixeralignedpid_kd_storage;
	pair_pair_q33 <= pair_pair_q32;
	pair_pair_q34 <= pair_controls_mixeralignedpid_mixeralignedpid_reset_storage;
	pair_pair_q35 <= pair_pair_q34;
	if ((seed & (~pair_controls_mixeralignedpid_update_en0))) begin
		pair_ref_pid_pipelinedpid_int_reg <= seed_value;
		pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= seed_value;
	end
	pair_controls_offset_signed <= pair_controls_offset_storage;
	pair_controls_lq <= pair_controls_min_storage;
	pair_controls_hq <= pair_controls_max_storage;
	pair_controls_lo <= pair_controls_lq;
	pair_controls_hi <= pair_controls_hq;
	if (pair_controls_update_en) begin
		pair_controls_limit_min <= {{4{pair_controls_lo[24]}}, pair_controls_lo};
		pair_controls_limit_max <= {{4{pair_controls_hi[24]}}, pair_controls_hi};
		pair_controls_alignedinputlimitcsr_y <= pair_controls_limit_y;
		pair_controls_alignedinputlimitcsr_error <= pair_controls_limit_railed;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_kp_mult <= (pair_controls_mixeralignedpid_error_s1 * pair_controls_mixeralignedpid0);
	pair_controls_mixeralignedpid_mixeralignedpid_ki_mult <= ((pair_controls_mixeralignedpid_error_s1 * pair_controls_mixeralignedpid1) >>> 3'd4);
	if (pair_controls_mixeralignedpid_update_en0) begin
		if (pair_controls_mixeralignedpid4) begin
			pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= 1'd0;
		end else begin
			if (pair_controls_mixeralignedpid_mixeralignedpid0) begin
				pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= 42'd4398046248960;
			end else begin
				if (pair_controls_mixeralignedpid_mixeralignedpid1) begin
					pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= 43'sd4398046773247;
				end else begin
					pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= pair_controls_mixeralignedpid_mixeralignedpid_int_sum;
				end
			end
		end
	end
	pair_controls_mixeralignedpid_mixeralignedpid_kd_mult <= (pair_controls_mixeralignedpid_error_s1 * pair_controls_mixeralignedpid2);
	if (pair_controls_mixeralignedpid_update_en0) begin
		pair_controls_mixeralignedpid_mixeralignedpid_kd_reg <= (pair_controls_mixeralignedpid_mixeralignedpid_kd_mult >>> 4'd8);
		pair_controls_mixeralignedpid_mixeralignedpid_kd_reg_r <= pair_controls_mixeralignedpid_mixeralignedpid_kd_reg;
		pair_controls_mixeralignedpid_mixeralignedpid_output_d <= (pair_controls_mixeralignedpid_mixeralignedpid_kd_reg - pair_controls_mixeralignedpid_mixeralignedpid_kd_reg_r);
	end
	if (pair_controls_mixeralignedpid_update_en0) begin
		pair_controls_mixeralignedpid_mixeralignedpid_pid_sum <= ((pair_controls_mixeralignedpid_mixeralignedpid_output_p + pair_controls_mixeralignedpid_mixeralignedpid_int_out) + pair_controls_mixeralignedpid_mixeralignedpid_output_d);
	end
	pair_controls_mixeralignedpid_q0 <= pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage;
	pair_controls_mixeralignedpid_setpoint_cohort <= pair_controls_mixeralignedpid_q0;
	pair_controls_mixeralignedpid_q1 <= pair_controls_mixeralignedpid_running;
	pair_controls_mixeralignedpid_running_cohort <= pair_controls_mixeralignedpid_q1;
	pair_controls_mixeralignedpid_q2 <= pair_controls_mixeralignedpid_mixeralignedpid_kp_storage;
	pair_controls_mixeralignedpid7 <= pair_controls_mixeralignedpid_q2;
	pair_controls_mixeralignedpid_q3 <= pair_controls_mixeralignedpid_mixeralignedpid_ki_storage;
	pair_controls_mixeralignedpid8 <= pair_controls_mixeralignedpid_q3;
	pair_controls_mixeralignedpid_q4 <= pair_controls_mixeralignedpid_mixeralignedpid_kd_storage;
	pair_controls_mixeralignedpid9 <= pair_controls_mixeralignedpid_q4;
	pair_controls_mixeralignedpid_q5 <= pair_controls_mixeralignedpid_mixeralignedpid_reset_storage;
	pair_controls_mixeralignedpid10 <= pair_controls_mixeralignedpid_q5;
	pair_controls_mixeralignedpid_q6 <= pair_controls_mixeralignedpid_update_en1;
	pair_controls_mixeralignedpid11 <= pair_controls_mixeralignedpid_q6;
	pair_controls_mixeralignedpid5 <= pair_controls_mixeralignedpid11;
	pair_controls_mixeralignedpid6 <= pair_controls_mixeralignedpid5;
	pair_controls_mixeralignedpid_error_s1 <= pair_controls_mixeralignedpid_mixeralignedpid_error;
	pair_controls_mixeralignedpid0 <= pair_controls_mixeralignedpid7;
	pair_controls_mixeralignedpid1 <= pair_controls_mixeralignedpid8;
	pair_controls_mixeralignedpid2 <= pair_controls_mixeralignedpid9;
	pair_controls_mixeralignedpid3 <= pair_controls_mixeralignedpid10;
	pair_controls_mixeralignedpid4 <= pair_controls_mixeralignedpid3;
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[4:0])
			1'd0: begin
				pair_bus_dat_r <= pair_factor_a1_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_factor_a0_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_factor_b1_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_factor_b0_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_offset1_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_offset0_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_dual0_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_mode0_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_limit_min3_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_limit_min2_w;
			end
			4'd10: begin
				pair_bus_dat_r <= pair_limit_min1_w;
			end
			4'd11: begin
				pair_bus_dat_r <= pair_limit_min0_w;
			end
			4'd12: begin
				pair_bus_dat_r <= pair_limit_max3_w;
			end
			4'd13: begin
				pair_bus_dat_r <= pair_limit_max2_w;
			end
			4'd14: begin
				pair_bus_dat_r <= pair_limit_max1_w;
			end
			4'd15: begin
				pair_bus_dat_r <= pair_limit_max0_w;
			end
			5'd16: begin
				pair_bus_dat_r <= pair_pid_setpoint3_w;
			end
			5'd17: begin
				pair_bus_dat_r <= pair_pid_setpoint2_w;
			end
			5'd18: begin
				pair_bus_dat_r <= pair_pid_setpoint1_w;
			end
			5'd19: begin
				pair_bus_dat_r <= pair_pid_setpoint0_w;
			end
			5'd20: begin
				pair_bus_dat_r <= pair_pid_kp1_w;
			end
			5'd21: begin
				pair_bus_dat_r <= pair_pid_kp0_w;
			end
			5'd22: begin
				pair_bus_dat_r <= pair_pid_ki1_w;
			end
			5'd23: begin
				pair_bus_dat_r <= pair_pid_ki0_w;
			end
			5'd24: begin
				pair_bus_dat_r <= pair_pid_reset0_w;
			end
			5'd25: begin
				pair_bus_dat_r <= pair_pid_kd1_w;
			end
			5'd26: begin
				pair_bus_dat_r <= pair_pid_kd0_w;
			end
		endcase
	end
	if (pair_factor_a1_re) begin
		pair_controls_factor_a_storage_full[8] <= pair_factor_a1_r;
	end
	if (pair_factor_a0_re) begin
		pair_controls_factor_a_storage_full[7:0] <= pair_factor_a0_r;
	end
	pair_controls_factor_a_re <= pair_factor_a0_re;
	if (pair_factor_b1_re) begin
		pair_controls_factor_b_storage_full[8] <= pair_factor_b1_r;
	end
	if (pair_factor_b0_re) begin
		pair_controls_factor_b_storage_full[7:0] <= pair_factor_b0_r;
	end
	pair_controls_factor_b_re <= pair_factor_b0_re;
	if (pair_offset1_re) begin
		pair_controls_offset_storage_full[13:8] <= pair_offset1_r;
	end
	if (pair_offset0_re) begin
		pair_controls_offset_storage_full[7:0] <= pair_offset0_r;
	end
	pair_controls_offset_re <= pair_offset0_re;
	if (pair_dual0_re) begin
		pair_controls_dual_storage_full <= pair_dual0_r;
	end
	pair_controls_dual_re <= pair_dual0_re;
	if (pair_mode0_re) begin
		pair_controls_mode_storage_full <= pair_mode0_r;
	end
	pair_controls_mode_re <= pair_mode0_re;
	if (pair_limit_min3_re) begin
		pair_controls_min_storage_full[24] <= pair_limit_min3_r;
	end
	if (pair_limit_min2_re) begin
		pair_controls_min_storage_full[23:16] <= pair_limit_min2_r;
	end
	if (pair_limit_min1_re) begin
		pair_controls_min_storage_full[15:8] <= pair_limit_min1_r;
	end
	if (pair_limit_min0_re) begin
		pair_controls_min_storage_full[7:0] <= pair_limit_min0_r;
	end
	pair_controls_min_re <= pair_limit_min0_re;
	if (pair_limit_max3_re) begin
		pair_controls_max_storage_full[24] <= pair_limit_max3_r;
	end
	if (pair_limit_max2_re) begin
		pair_controls_max_storage_full[23:16] <= pair_limit_max2_r;
	end
	if (pair_limit_max1_re) begin
		pair_controls_max_storage_full[15:8] <= pair_limit_max1_r;
	end
	if (pair_limit_max0_re) begin
		pair_controls_max_storage_full[7:0] <= pair_limit_max0_r;
	end
	pair_controls_max_re <= pair_limit_max0_re;
	if (pair_pid_setpoint3_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[24] <= pair_pid_setpoint3_r;
	end
	if (pair_pid_setpoint2_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[23:16] <= pair_pid_setpoint2_r;
	end
	if (pair_pid_setpoint1_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[15:8] <= pair_pid_setpoint1_r;
	end
	if (pair_pid_setpoint0_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full[7:0] <= pair_pid_setpoint0_r;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_setpoint_re <= pair_pid_setpoint0_re;
	if (pair_pid_kp1_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full[13:8] <= pair_pid_kp1_r;
	end
	if (pair_pid_kp0_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full[7:0] <= pair_pid_kp0_r;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_kp_re <= pair_pid_kp0_re;
	if (pair_pid_ki1_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full[13:8] <= pair_pid_ki1_r;
	end
	if (pair_pid_ki0_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full[7:0] <= pair_pid_ki0_r;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_ki_re <= pair_pid_ki0_re;
	if (pair_pid_reset0_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_reset_storage_full <= pair_pid_reset0_r;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_reset_re <= pair_pid_reset0_re;
	if (pair_pid_kd1_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full[13:8] <= pair_pid_kd1_r;
	end
	if (pair_pid_kd0_re) begin
		pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full[7:0] <= pair_pid_kd0_r;
	end
	pair_controls_mixeralignedpid_mixeralignedpid_kd_re <= pair_pid_kd0_re;
	pair_registerederrormixer_bias_cohort0 <= pair_registerederrormixer_bias0;
	pair_registerederrormixer_bias_cohort1 <= pair_registerederrormixer_bias1;
	pair_registerederrormixer_off_cohort <= pair_registerederrormixer_off;
	pair_registerederrormixer_a_cohort <= pair_registerederrormixer0;
	pair_registerederrormixer_dual_cohort <= pair_registerederrormixer_dual;
	pair_registerederrormixer_y <= pair_registerederrormixer_summed;
	pair_alignment_q0 <= pair_alignment_direct_adc;
	pair_alignment_adc_cohort <= pair_alignment_q0;
	pair_alignment_q1 <= pair_alignment_pid_only;
	pair_alignment_mode_cohort <= pair_alignment_q1;
	pair_alignment_q2 <= pair_alignment_limit_accept_en;
	pair_alignment_limit_execute_en <= pair_alignment_q2;
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
	if (pair_ref_limit_update_en) begin
		pair_ref_limit_limit_min <= {{4{pair_ref_limit_min_storage[24]}}, pair_ref_limit_min_storage};
		pair_ref_limit_limit_max <= {{4{pair_ref_limit_max_storage[24]}}, pair_ref_limit_max_storage};
		pair_ref_limit_limitcsr_y <= pair_ref_limit_limit_y;
		pair_ref_limit_limitcsr_error <= pair_ref_limit_limit_railed;
	end
	pair_ref_pid_pipelinedpid_kp_mult <= (pair_ref_pid_error_s1 * pair_ref_pid_kp_s1);
	pair_ref_pid_pipelinedpid_ki_mult <= ((pair_ref_pid_error_s1 * pair_ref_pid_ki_s1) >>> 3'd4);
	if (pair_ref_pid_update_en0) begin
		if (pair_ref_pid_reset_s2) begin
			pair_ref_pid_pipelinedpid_int_reg <= 1'd0;
		end else begin
			if (pair_ref_pid_pipelinedpid0) begin
				pair_ref_pid_pipelinedpid_int_reg <= 42'd4398046248960;
			end else begin
				if (pair_ref_pid_pipelinedpid1) begin
					pair_ref_pid_pipelinedpid_int_reg <= 43'sd4398046773247;
				end else begin
					pair_ref_pid_pipelinedpid_int_reg <= pair_ref_pid_pipelinedpid_int_sum;
				end
			end
		end
	end
	pair_ref_pid_pipelinedpid_kd_mult <= (pair_ref_pid_error_s1 * pair_ref_pid_kd_s1);
	if (pair_ref_pid_update_en0) begin
		pair_ref_pid_pipelinedpid_kd_reg <= (pair_ref_pid_pipelinedpid_kd_mult >>> 4'd8);
		pair_ref_pid_pipelinedpid_kd_reg_r <= pair_ref_pid_pipelinedpid_kd_reg;
		pair_ref_pid_pipelinedpid_output_d <= (pair_ref_pid_pipelinedpid_kd_reg - pair_ref_pid_pipelinedpid_kd_reg_r);
	end
	if (pair_ref_pid_update_en0) begin
		pair_ref_pid_pipelinedpid_pid_sum <= ((pair_ref_pid_pipelinedpid_output_p + pair_ref_pid_pipelinedpid_int_out) + pair_ref_pid_pipelinedpid_output_d);
	end
	pair_ref_pid_valid_s1 <= pair_ref_pid_update_en1;
	pair_ref_pid_valid_s2 <= pair_ref_pid_valid_s1;
	pair_ref_pid_error_s1 <= pair_ref_pid_pipelinedpid_error;
	pair_ref_pid_kp_s1 <= pair_ref_pid_pipelinedpid_kp_storage;
	pair_ref_pid_ki_s1 <= pair_ref_pid_pipelinedpid_ki_storage;
	pair_ref_pid_kd_s1 <= pair_ref_pid_pipelinedpid_kd_storage;
	pair_ref_pid_reset_s1 <= pair_ref_pid_pipelinedpid_reset_storage;
	pair_ref_pid_reset_s2 <= pair_ref_pid_reset_s1;
	if (sys_rst) begin
		pair_controls_factor_a_storage_full <= 9'd128;
		pair_controls_factor_a_re <= 1'd0;
		pair_controls_factor_b_storage_full <= 9'd128;
		pair_controls_factor_b_re <= 1'd0;
		pair_controls_offset_storage_full <= 14'd0;
		pair_controls_offset_re <= 1'd0;
		pair_controls_dual_storage_full <= 1'd0;
		pair_controls_dual_re <= 1'd0;
		pair_controls_mode_storage_full <= 1'd0;
		pair_controls_mode_re <= 1'd0;
		pair_controls_alignedinputlimitcsr_y <= 25'sd0;
		pair_controls_alignedinputlimitcsr_error <= 1'd0;
		pair_controls_min_storage_full <= 25'd16777216;
		pair_controls_min_re <= 1'd0;
		pair_controls_max_storage_full <= 25'd16777215;
		pair_controls_max_re <= 1'd0;
		pair_controls_limit_max <= 29'sd0;
		pair_controls_limit_min <= 29'sd0;
		pair_controls_lo <= 25'd16777216;
		pair_controls_hi <= 25'd16777215;
		pair_controls_lq <= 25'd16777216;
		pair_controls_hq <= 25'd16777215;
		pair_controls_mixeralignedpid_error_s1 <= 26'sd0;
		pair_controls_mixeralignedpid0 <= 14'sd0;
		pair_controls_mixeralignedpid1 <= 14'sd0;
		pair_controls_mixeralignedpid2 <= 14'sd0;
		pair_controls_mixeralignedpid3 <= 1'd0;
		pair_controls_mixeralignedpid4 <= 1'd0;
		pair_controls_mixeralignedpid5 <= 1'd0;
		pair_controls_mixeralignedpid6 <= 1'd0;
		pair_controls_mixeralignedpid_setpoint_cohort <= 25'd0;
		pair_controls_mixeralignedpid_running_cohort <= 1'd0;
		pair_controls_mixeralignedpid7 <= 14'd0;
		pair_controls_mixeralignedpid8 <= 14'd0;
		pair_controls_mixeralignedpid9 <= 14'd0;
		pair_controls_mixeralignedpid10 <= 1'd0;
		pair_controls_mixeralignedpid11 <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_storage_full <= 25'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_setpoint_re <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kp_storage_full <= 14'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kp_re <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kp_mult <= 39'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_ki_storage_full <= 14'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_ki_re <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_reset_storage_full <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_reset_re <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_ki_mult <= 40'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_int_reg <= 43'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kd_storage_full <= 14'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kd_re <= 1'd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kd_mult <= 41'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kd_reg <= 34'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_kd_reg_r <= 34'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_output_d <= 34'sd0;
		pair_controls_mixeralignedpid_mixeralignedpid_pid_sum <= 84'sd0;
		pair_controls_mixeralignedpid_q0 <= 25'd0;
		pair_controls_mixeralignedpid_q1 <= 1'd0;
		pair_controls_mixeralignedpid_q2 <= 14'd0;
		pair_controls_mixeralignedpid_q3 <= 14'd0;
		pair_controls_mixeralignedpid_q4 <= 14'd0;
		pair_controls_mixeralignedpid_q5 <= 1'd0;
		pair_controls_mixeralignedpid_q6 <= 1'd0;
		pair_controls_offset_signed <= 14'sd0;
		pair_bus_dat_r <= 8'd0;
		pair_registerederrormixer_y <= 37'sd0;
		pair_registerederrormixer_bias_cohort0 <= 37'sd0;
		pair_registerederrormixer_bias_cohort1 <= 37'sd0;
		pair_registerederrormixer_off_cohort <= 37'sd0;
		pair_registerederrormixer_a_cohort <= 25'sd0;
		pair_registerederrormixer_dual_cohort <= 1'd0;
		pair_alignment_limit_execute_en <= 1'd0;
		pair_alignment_adc_cohort <= 14'sd0;
		pair_alignment_mode_cohort <= 1'd0;
		pair_alignment_q0 <= 14'sd0;
		pair_alignment_q1 <= 1'd0;
		pair_alignment_q2 <= 1'd0;
		pair_a_limit_limitcsr_y <= 25'sd0;
		pair_a_limit_limitcsr_error <= 1'd0;
		pair_a_limit_limit_max <= 28'sd0;
		pair_a_limit_limit_min <= 28'sd0;
		pair_b_limit_limitcsr_y <= 25'sd0;
		pair_b_limit_limitcsr_error <= 1'd0;
		pair_b_limit_limit_max <= 28'sd0;
		pair_b_limit_limit_min <= 28'sd0;
		pair_ref_limit_limitcsr_y <= 25'sd0;
		pair_ref_limit_limitcsr_error <= 1'd0;
		pair_ref_limit_limit_max <= 29'sd0;
		pair_ref_limit_limit_min <= 29'sd0;
		pair_ref_pid_error_s1 <= 26'sd0;
		pair_ref_pid_kp_s1 <= 14'sd0;
		pair_ref_pid_ki_s1 <= 14'sd0;
		pair_ref_pid_kd_s1 <= 14'sd0;
		pair_ref_pid_reset_s1 <= 1'd0;
		pair_ref_pid_reset_s2 <= 1'd0;
		pair_ref_pid_valid_s1 <= 1'd0;
		pair_ref_pid_valid_s2 <= 1'd0;
		pair_ref_pid_pipelinedpid_kp_mult <= 39'sd0;
		pair_ref_pid_pipelinedpid_ki_mult <= 40'sd0;
		pair_ref_pid_pipelinedpid_int_reg <= 43'sd0;
		pair_ref_pid_pipelinedpid_kd_mult <= 41'sd0;
		pair_ref_pid_pipelinedpid_kd_reg <= 34'sd0;
		pair_ref_pid_pipelinedpid_kd_reg_r <= 34'sd0;
		pair_ref_pid_pipelinedpid_output_d <= 34'sd0;
		pair_ref_pid_pipelinedpid_pid_sum <= 84'sd0;
		pair_pair_q0 <= 25'sd0;
		pair_pair_q1 <= 25'sd0;
		pair_pair_q2 <= 25'sd0;
		pair_pair_q3 <= 25'sd0;
		pair_pair_q4 <= 9'd128;
		pair_pair_q5 <= 9'd128;
		pair_pair_q6 <= 9'd128;
		pair_pair_q7 <= 9'd128;
		pair_pair_q8 <= 14'sd0;
		pair_pair_q9 <= 14'sd0;
		pair_pair_q10 <= 1'd0;
		pair_pair_q11 <= 1'd0;
		pair_pair_q12 <= 1'd0;
		pair_pair_q13 <= 1'd0;
		pair_pair_q14 <= 14'sd0;
		pair_pair_q15 <= 14'sd0;
		pair_pair_q16 <= 25'd16777216;
		pair_pair_q17 <= 25'd16777216;
		pair_pair_q18 <= 25'd16777215;
		pair_pair_q19 <= 25'd16777215;
		pair_pair_q20 <= 1'd0;
		pair_pair_q21 <= 1'd0;
		pair_pair_q22 <= 1'd0;
		pair_pair_q23 <= 1'd0;
		pair_pair_q24 <= 1'd0;
		pair_pair_q25 <= 1'd0;
		pair_pair_q26 <= 25'd0;
		pair_pair_q27 <= 25'd0;
		pair_pair_q28 <= 14'd0;
		pair_pair_q29 <= 14'd0;
		pair_pair_q30 <= 14'd0;
		pair_pair_q31 <= 14'd0;
		pair_pair_q32 <= 14'd0;
		pair_pair_q33 <= 14'd0;
		pair_pair_q34 <= 1'd0;
		pair_pair_q35 <= 1'd0;
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
	.MREG(1'd1),
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
	.CEM(1'd1),
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
	.MREG(1'd1),
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
	.CEM(1'd1),
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
