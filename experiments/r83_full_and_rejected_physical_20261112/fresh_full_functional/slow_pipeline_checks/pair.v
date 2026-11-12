/* Machine-generated using Migen */
module slow_pipeline_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] x,
	input running,
	input ce,
	input use_divider,
	input [4:0] divider,
	input signed [13:0] sweep,
	input signed [13:0] offset,
	input [1:0] sweep_channel,
	input [1:0] slow_channel,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	input seed_enable,
	input signed [31:0] seed_value,
	output [237:0] ref_fields,
	output [237:0] cand_fields,
	output [53:0] ref_limit,
	output [53:0] cand_limit,
	output [16:0] ref_analog,
	output [16:0] cand_analog,
	output [7:0] ref_read,
	output [84:0] csr_config,
	output accept_ce,
	output execute_ce,
	output [13:0] ref_contrib0,
	output [13:0] cand_contrib0,
	output [13:0] ref_contrib1,
	output [13:0] cand_contrib1
);

wire signed [13:0] pair_candidate_input;
wire signed [13:0] pair_candidate_output;
wire pair_candidate_update_en;
wire signed [24:0] pair_candidate_out;
reg signed [14:0] pair_candidate_pid_error_s1 = 15'sd0;
reg signed [13:0] pair_candidate_pid_kp_s1 = 14'sd0;
reg signed [13:0] pair_candidate_pid_ki_s1 = 14'sd0;
reg signed [13:0] pair_candidate_pid_kd_s1 = 14'sd0;
reg pair_candidate_pid_reset_s1 = 1'd0;
reg pair_candidate_pid_reset_s2 = 1'd0;
reg pair_candidate_pid_valid_s1 = 1'd0;
reg pair_candidate_pid_valid_s2 = 1'd0;
wire signed [13:0] pair_candidate_pid_input;
wire pair_candidate_pid_running;
wire pair_candidate_pid_update_en0;
reg [13:0] pair_candidate_pid_pipelinedpid_setpoint_storage_full = 14'd0;
wire [13:0] pair_candidate_pid_pipelinedpid_setpoint_storage;
reg pair_candidate_pid_pipelinedpid_setpoint_re = 1'd0;
wire signed [13:0] pair_candidate_pid_pipelinedpid_setpoint_signed;
reg signed [14:0] pair_candidate_pid_pipelinedpid_error;
reg [13:0] pair_candidate_pid_pipelinedpid_kp_storage_full = 14'd0;
wire [13:0] pair_candidate_pid_pipelinedpid_kp_storage;
reg pair_candidate_pid_pipelinedpid_kp_re = 1'd0;
reg signed [27:0] pair_candidate_pid_pipelinedpid_kp_mult = 28'sd0;
wire signed [13:0] pair_candidate_pid_pipelinedpid_output_p;
reg [13:0] pair_candidate_pid_pipelinedpid_ki_storage_full = 14'd0;
wire [13:0] pair_candidate_pid_pipelinedpid_ki_storage;
reg pair_candidate_pid_pipelinedpid_ki_re = 1'd0;
reg pair_candidate_pid_pipelinedpid_reset_storage_full = 1'd0;
wire pair_candidate_pid_pipelinedpid_reset_storage;
reg pair_candidate_pid_pipelinedpid_reset_re = 1'd0;
reg signed [28:0] pair_candidate_pid_pipelinedpid_ki_mult = 29'sd0;
reg signed [31:0] pair_candidate_pid_pipelinedpid_int_reg = 32'sd0;
wire signed [32:0] pair_candidate_pid_pipelinedpid_int_sum;
wire signed [13:0] pair_candidate_pid_pipelinedpid_int_out;
wire pair_candidate_pid_pipelinedpid0;
wire pair_candidate_pid_pipelinedpid1;
reg [13:0] pair_candidate_pid_pipelinedpid_kd_storage_full = 14'd0;
wire [13:0] pair_candidate_pid_pipelinedpid_kd_storage;
reg pair_candidate_pid_pipelinedpid_kd_re = 1'd0;
reg signed [29:0] pair_candidate_pid_pipelinedpid_kd_mult = 30'sd0;
reg signed [22:0] pair_candidate_pid_pipelinedpid_kd_reg = 23'sd0;
reg signed [22:0] pair_candidate_pid_pipelinedpid_kd_reg_r = 23'sd0;
reg signed [22:0] pair_candidate_pid_pipelinedpid_output_d = 23'sd0;
reg signed [50:0] pair_candidate_pid_pipelinedpid_pid_sum = 51'sd0;
reg signed [13:0] pair_candidate_pid_pipelinedpid_pid_out;
wire pair_candidate_pid_update_en1;
reg signed [13:0] pair_candidate_limit_alignedslowlimitcsr_y = 14'sd0;
reg pair_candidate_limit_alignedslowlimitcsr_error = 1'd0;
wire pair_candidate_limit_update_en;
reg [13:0] pair_candidate_limit_min_storage_full = 14'd8192;
wire [13:0] pair_candidate_limit_min_storage;
reg pair_candidate_limit_min_re = 1'd0;
reg [13:0] pair_candidate_limit_max_storage_full = 14'd8191;
wire [13:0] pair_candidate_limit_max_storage;
reg pair_candidate_limit_max_re = 1'd0;
wire signed [18:0] pair_candidate_limit_x;
wire signed [18:0] pair_candidate_limit_limit_x;
reg signed [18:0] pair_candidate_limit_limit_y;
reg signed [18:0] pair_candidate_limit_limit_max = 19'sd0;
reg signed [18:0] pair_candidate_limit_limit_min = 19'sd0;
reg pair_candidate_limit_limit_railed;
reg [13:0] pair_candidate_limit_minimum_s1 = 14'd8192;
reg [13:0] pair_candidate_limit_minimum_s2 = 14'd8192;
reg [13:0] pair_candidate_limit_maximum_s1 = 14'd8191;
reg [13:0] pair_candidate_limit_maximum_s2 = 14'd8191;
wire signed [13:0] pair_reference_input;
wire signed [13:0] pair_reference_output;
wire pair_reference_update_en;
wire signed [24:0] pair_reference_out;
wire signed [13:0] pair_reference_pid_input;
wire pair_reference_pid_running;
wire pair_reference_pid_update_en;
wire [13:0] pair_reference_pid_setpoint_storage;
wire signed [13:0] pair_reference_pid_setpoint_signed;
reg signed [14:0] pair_reference_pid_error;
wire [13:0] pair_reference_pid_kp_storage;
wire signed [13:0] pair_reference_pid_kp_signed;
wire signed [27:0] pair_reference_pid_kp_mult;
wire signed [13:0] pair_reference_pid_output_p;
wire [13:0] pair_reference_pid_ki_storage;
wire pair_reference_pid_reset_storage;
wire signed [13:0] pair_reference_pid_ki_signed;
wire signed [28:0] pair_reference_pid_ki_mult;
reg signed [31:0] pair_reference_pid_int_reg = 32'sd0;
wire signed [32:0] pair_reference_pid_int_sum;
wire signed [13:0] pair_reference_pid_int_out;
wire pair_reference_pid_overflow_pos;
wire pair_reference_pid_overflow_neg;
wire [13:0] pair_reference_pid_kd_storage;
wire signed [13:0] pair_reference_pid_kd_signed;
wire signed [29:0] pair_reference_pid_kd_mult;
reg signed [22:0] pair_reference_pid_kd_reg = 23'sd0;
reg signed [22:0] pair_reference_pid_kd_reg_r = 23'sd0;
reg signed [22:0] pair_reference_pid_output_d = 23'sd0;
reg signed [50:0] pair_reference_pid_pid_sum = 51'sd0;
reg signed [13:0] pair_reference_pid_pid_out;
reg signed [13:0] pair_reference_limit_limitcsr_y = 14'sd0;
reg pair_reference_limit_limitcsr_error = 1'd0;
wire pair_reference_limit_update_en;
wire signed [18:0] pair_reference_limit_x;
wire [13:0] pair_reference_limit_min_storage;
wire [13:0] pair_reference_limit_max_storage;
wire signed [18:0] pair_reference_limit_limit_x;
reg signed [18:0] pair_reference_limit_limit_y;
reg signed [18:0] pair_reference_limit_limit_max = 19'sd0;
reg signed [18:0] pair_reference_limit_limit_min = 19'sd0;
reg pair_reference_limit_limit_railed;
wire [1:0] pair_slowoutputtransport_slow_channel;
wire [1:0] pair_slowoutputtransport_sweep_channel;
wire signed [13:0] pair_slowoutputtransport_sweep;
wire signed [13:0] pair_slowoutputtransport_offset;
wire signed [13:0] pair_slowoutputtransport_slow_pid;
reg [1:0] pair_slowoutputtransport_aligned_slow_channel = 2'd0;
wire signed [16:0] pair_slowoutputtransport_analog_out;
reg [1:0] pair_slowoutputtransport_channel_s1 = 2'd0;
reg signed [16:0] pair_slowoutputtransport0 = 17'sd0;
reg signed [16:0] pair_slowoutputtransport1 = 17'sd0;
wire signed [16:0] pair_slowoutputtransport_contribution;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_pid_setpoint1_re;
wire [5:0] pair_pid_setpoint1_r;
wire [5:0] pair_pid_setpoint1_w;
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
wire pair_limit_min1_re;
wire [5:0] pair_limit_min1_r;
wire [5:0] pair_limit_min1_w;
wire pair_limit_min0_re;
wire [7:0] pair_limit_min0_r;
wire [7:0] pair_limit_min0_w;
wire pair_limit_max1_re;
wire [5:0] pair_limit_max1_r;
wire [5:0] pair_limit_max1_w;
wire pair_limit_max0_re;
wire [7:0] pair_limit_max0_r;
wire [7:0] pair_limit_max0_w;
wire pair_sel;
wire [4:0] pair_decimation;
reg [14:0] pair_decimation_counter = 15'd0;
reg pair_started = 1'd0;
wire pair_enable;
wire pair_accept;
reg signed [13:0] pair_s10 = 14'sd0;
reg signed [13:0] pair_s20 = 14'sd0;
reg pair_s11 = 1'd0;
reg pair_s21 = 1'd0;
reg pair_s12 = 1'd0;
reg pair_s22 = 1'd0;
reg [13:0] pair_s13 = 14'd0;
reg [13:0] pair_s23 = 14'd0;
reg [13:0] pair_s14 = 14'd0;
reg [13:0] pair_s24 = 14'd0;
reg [13:0] pair_s15 = 14'd0;
reg [13:0] pair_s25 = 14'd0;
reg [13:0] pair_s16 = 14'd0;
reg [13:0] pair_s26 = 14'd0;
reg pair_s17 = 1'd0;
reg pair_s27 = 1'd0;
reg [13:0] pair_s18 = 14'd8192;
reg [13:0] pair_s28 = 14'd8192;
reg [13:0] pair_s19 = 14'd8191;
reg [13:0] pair_s29 = 14'd8191;
reg signed [13:0] pair_s110 = 14'sd0;
reg signed [13:0] pair_s210 = 14'sd0;
reg signed [13:0] pair_s111 = 14'sd0;
reg signed [13:0] pair_s211 = 14'sd0;
reg [1:0] pair_s112 = 2'd0;
reg [1:0] pair_s212 = 2'd0;
reg [1:0] pair_s113 = 2'd0;
reg [1:0] pair_s213 = 2'd0;
wire signed [16:0] pair_ref_analog;
reg array_muxed;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_decimation = divider;
assign pair_accept = (use_divider ? pair_enable : ce);
assign pair_candidate_input = x;
assign pair_candidate_pid_running = running;
assign pair_candidate_update_en = pair_accept;
assign pair_slowoutputtransport_sweep = sweep;
assign pair_slowoutputtransport_offset = offset;
assign pair_slowoutputtransport_sweep_channel = sweep_channel;
assign pair_slowoutputtransport_slow_channel = slow_channel;
assign pair_slowoutputtransport_slow_pid = pair_candidate_output;
assign pair_candidate_limit_x = pair_slowoutputtransport_analog_out;
assign pair_reference_input = pair_s20;
assign pair_reference_pid_running = pair_s21;
assign pair_reference_update_en = pair_s22;
assign pair_reference_pid_setpoint_storage = pair_s23;
assign pair_reference_pid_kp_storage = pair_s24;
assign pair_reference_pid_ki_storage = pair_s25;
assign pair_reference_pid_kd_storage = pair_s26;
assign pair_reference_pid_reset_storage = pair_s27;
assign pair_reference_limit_min_storage = pair_s28;
assign pair_reference_limit_max_storage = pair_s29;
assign pair_ref_analog = ((((pair_s212 == 2'd2) ? pair_s210 : $signed({1'd0, 1'd0})) + ((pair_s212 == 2'd2) ? pair_s211 : $signed({1'd0, 1'd0}))) + ((pair_s213 == 2'd2) ? pair_reference_output : $signed({1'd0, 1'd0})));
assign pair_reference_limit_x = pair_ref_analog;
assign ref_fields = {pair_reference_pid_pid_out, pair_reference_pid_pid_sum, pair_reference_pid_output_d, pair_reference_pid_int_out, pair_reference_pid_int_reg, pair_reference_pid_int_sum, pair_reference_pid_ki_mult, pair_reference_pid_output_p, pair_reference_pid_kp_mult};
assign cand_fields = {pair_candidate_pid_pipelinedpid_pid_out, pair_candidate_pid_pipelinedpid_pid_sum, pair_candidate_pid_pipelinedpid_output_d, pair_candidate_pid_pipelinedpid_int_out, pair_candidate_pid_pipelinedpid_int_reg, pair_candidate_pid_pipelinedpid_int_sum, pair_candidate_pid_pipelinedpid_ki_mult, pair_candidate_pid_pipelinedpid_output_p, pair_candidate_pid_pipelinedpid_kp_mult};
assign ref_limit = {pair_reference_limit_update_en, pair_reference_limit_limit_max, pair_reference_limit_limit_min, pair_reference_limit_limitcsr_error, pair_reference_limit_limitcsr_y};
assign cand_limit = {pair_candidate_limit_update_en, pair_candidate_limit_limit_max, pair_candidate_limit_limit_min, pair_candidate_limit_alignedslowlimitcsr_error, pair_candidate_limit_alignedslowlimitcsr_y};
assign ref_analog = pair_ref_analog;
assign cand_analog = pair_slowoutputtransport_analog_out;
assign ref_read = pair_bus_dat_r;
assign csr_config = {pair_candidate_limit_max_storage, pair_candidate_limit_min_storage, pair_candidate_pid_pipelinedpid_reset_storage, pair_candidate_pid_pipelinedpid_kd_storage, pair_candidate_pid_pipelinedpid_ki_storage, pair_candidate_pid_pipelinedpid_kp_storage, pair_candidate_pid_pipelinedpid_setpoint_storage};
assign accept_ce = pair_accept;
assign execute_ce = pair_candidate_pid_update_en0;
assign ref_contrib0 = ((pair_s213 == 1'd0) ? pair_reference_output : $signed({1'd0, 1'd0}));
assign cand_contrib0 = ((pair_slowoutputtransport_aligned_slow_channel == 1'd0) ? pair_candidate_output : $signed({1'd0, 1'd0}));
assign ref_contrib1 = ((pair_s213 == 1'd1) ? pair_reference_output : $signed({1'd0, 1'd0}));
assign cand_contrib1 = ((pair_slowoutputtransport_aligned_slow_channel == 1'd1) ? pair_candidate_output : $signed({1'd0, 1'd0}));
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign pair_candidate_pid_update_en1 = pair_candidate_update_en;
assign pair_candidate_limit_update_en = pair_candidate_pid_update_en0;
assign pair_candidate_pid_input = pair_candidate_input;
assign pair_candidate_output = pair_candidate_pid_pipelinedpid_pid_out;
assign pair_candidate_out = (pair_candidate_limit_alignedslowlimitcsr_y <<< 4'd11);
assign pair_candidate_pid_pipelinedpid_setpoint_signed = pair_candidate_pid_pipelinedpid_setpoint_storage;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_candidate_pid_pipelinedpid_error <= 15'sd0;
	if (pair_candidate_pid_running) begin
		pair_candidate_pid_pipelinedpid_error <= (pair_candidate_pid_input - $signed({1'd0, pair_candidate_pid_pipelinedpid_setpoint_storage}));
	end else begin
		pair_candidate_pid_pipelinedpid_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pid_pipelinedpid_output_p = (pair_candidate_pid_pipelinedpid_kp_mult >>> 4'd12);
assign pair_candidate_pid_pipelinedpid_int_sum = (pair_candidate_pid_pipelinedpid_ki_mult + pair_candidate_pid_pipelinedpid_int_reg);
assign pair_candidate_pid_pipelinedpid_int_out = (pair_candidate_pid_pipelinedpid_int_reg >>> 5'd18);
assign pair_candidate_pid_pipelinedpid0 = ((~pair_candidate_pid_pipelinedpid_int_sum[32]) & (pair_candidate_pid_pipelinedpid_int_sum[31] | ((pair_candidate_pid_pipelinedpid_int_sum[30:18] == $signed({1'd0, 13'd8191})) & (pair_candidate_pid_pipelinedpid_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_candidate_pid_pipelinedpid1 = (pair_candidate_pid_pipelinedpid_int_sum[32] & ((~pair_candidate_pid_pipelinedpid_int_sum[31]) | ((pair_candidate_pid_pipelinedpid_int_sum[30:18] == $signed({1'd0, 1'd0})) & (pair_candidate_pid_pipelinedpid_int_sum[17:0] != $signed({1'd0, 18'd262143})))));

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_candidate_pid_pipelinedpid_pid_out <= 14'sd0;
	if (((~pair_candidate_pid_pipelinedpid_pid_sum[50]) & (pair_candidate_pid_pipelinedpid_pid_sum[50:13] != $signed({1'd0, 1'd0})))) begin
		pair_candidate_pid_pipelinedpid_pid_out <= 13'd8191;
	end else begin
		if ((pair_candidate_pid_pipelinedpid_pid_sum[50] & (pair_candidate_pid_pipelinedpid_pid_sum[50:13] != $signed({1'd0, 38'd274877906943})))) begin
			pair_candidate_pid_pipelinedpid_pid_out <= 14'sd8192;
		end else begin
			pair_candidate_pid_pipelinedpid_pid_out <= pair_candidate_pid_pipelinedpid_pid_sum[13:0];
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pid_update_en0 = pair_candidate_pid_valid_s2;
assign pair_candidate_limit_limit_x = pair_candidate_limit_x;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_candidate_limit_limit_y <= 19'sd0;
	pair_candidate_limit_limit_railed <= 1'd0;
	if ((pair_candidate_limit_limit_x >= pair_candidate_limit_limit_max)) begin
		pair_candidate_limit_limit_y <= pair_candidate_limit_limit_max;
		pair_candidate_limit_limit_railed <= 1'd1;
	end else begin
		if ((pair_candidate_limit_limit_x <= pair_candidate_limit_limit_min)) begin
			pair_candidate_limit_limit_y <= pair_candidate_limit_limit_min;
			pair_candidate_limit_limit_railed <= 1'd1;
		end else begin
			pair_candidate_limit_limit_y <= pair_candidate_limit_limit_x;
			pair_candidate_limit_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_pid_update_en = pair_reference_update_en;
assign pair_reference_limit_update_en = pair_reference_update_en;
assign pair_reference_pid_input = pair_reference_input;
assign pair_reference_output = pair_reference_pid_pid_out;
assign pair_reference_out = (pair_reference_limit_limitcsr_y <<< 4'd11);
assign pair_reference_pid_setpoint_signed = pair_reference_pid_setpoint_storage;

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_reference_pid_error <= 15'sd0;
	if (pair_reference_pid_running) begin
		pair_reference_pid_error <= (pair_reference_pid_input - $signed({1'd0, pair_reference_pid_setpoint_storage}));
	end else begin
		pair_reference_pid_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_pid_kp_signed = pair_reference_pid_kp_storage;
assign pair_reference_pid_kp_mult = (pair_reference_pid_error * pair_reference_pid_kp_signed);
assign pair_reference_pid_output_p = (pair_reference_pid_kp_mult >>> 4'd12);
assign pair_reference_pid_ki_signed = pair_reference_pid_ki_storage;
assign pair_reference_pid_ki_mult = ((pair_reference_pid_error * pair_reference_pid_ki_signed) >>> 3'd4);
assign pair_reference_pid_int_sum = (pair_reference_pid_ki_mult + pair_reference_pid_int_reg);
assign pair_reference_pid_int_out = (pair_reference_pid_int_reg >>> 5'd18);
assign pair_reference_pid_overflow_pos = ((~pair_reference_pid_int_sum[32]) & (pair_reference_pid_int_sum[31] | ((pair_reference_pid_int_sum[30:18] == $signed({1'd0, 13'd8191})) & (pair_reference_pid_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_reference_pid_overflow_neg = (pair_reference_pid_int_sum[32] & ((~pair_reference_pid_int_sum[31]) | ((pair_reference_pid_int_sum[30:18] == $signed({1'd0, 1'd0})) & (pair_reference_pid_int_sum[17:0] != $signed({1'd0, 18'd262143})))));
assign pair_reference_pid_kd_signed = pair_reference_pid_kd_storage;
assign pair_reference_pid_kd_mult = (pair_reference_pid_error * pair_reference_pid_kd_signed);

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_reference_pid_pid_out <= 14'sd0;
	if ((pair_reference_pid_pid_sum > $signed({1'd0, 13'd8191}))) begin
		pair_reference_pid_pid_out <= 13'd8191;
	end else begin
		if ((pair_reference_pid_pid_sum < 14'sd8192)) begin
			pair_reference_pid_pid_out <= 14'sd8192;
		end else begin
			pair_reference_pid_pid_out <= pair_reference_pid_pid_sum[13:0];
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_limit_limit_x = pair_reference_limit_x;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_reference_limit_limit_y <= 19'sd0;
	pair_reference_limit_limit_railed <= 1'd0;
	if ((pair_reference_limit_limit_x >= pair_reference_limit_limit_max)) begin
		pair_reference_limit_limit_y <= pair_reference_limit_limit_max;
		pair_reference_limit_limit_railed <= 1'd1;
	end else begin
		if ((pair_reference_limit_limit_x <= pair_reference_limit_limit_min)) begin
			pair_reference_limit_limit_y <= pair_reference_limit_limit_min;
			pair_reference_limit_limit_railed <= 1'd1;
		end else begin
			pair_reference_limit_limit_y <= pair_reference_limit_limit_x;
			pair_reference_limit_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_slowoutputtransport_contribution = ((pair_slowoutputtransport_sweep_channel == 2'd2) ? (pair_slowoutputtransport_sweep + pair_slowoutputtransport_offset) : $signed({1'd0, 1'd0}));
assign pair_slowoutputtransport_analog_out = (pair_slowoutputtransport1 + ((pair_slowoutputtransport_aligned_slow_channel == 2'd2) ? pair_slowoutputtransport_slow_pid : $signed({1'd0, 1'd0})));
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_pid_setpoint1_r = pair_bus_dat_w[5:0];
assign pair_pid_setpoint1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 1'd0));
assign pair_pid_setpoint0_r = pair_bus_dat_w[7:0];
assign pair_pid_setpoint0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 1'd1));
assign pair_pid_kp1_r = pair_bus_dat_w[5:0];
assign pair_pid_kp1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 2'd2));
assign pair_pid_kp0_r = pair_bus_dat_w[7:0];
assign pair_pid_kp0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 2'd3));
assign pair_pid_ki1_r = pair_bus_dat_w[5:0];
assign pair_pid_ki1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd4));
assign pair_pid_ki0_r = pair_bus_dat_w[7:0];
assign pair_pid_ki0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd5));
assign pair_pid_reset0_r = pair_bus_dat_w[0];
assign pair_pid_reset0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd6));
assign pair_pid_kd1_r = pair_bus_dat_w[5:0];
assign pair_pid_kd1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 3'd7));
assign pair_pid_kd0_r = pair_bus_dat_w[7:0];
assign pair_pid_kd0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd8));
assign pair_limit_min1_r = pair_bus_dat_w[5:0];
assign pair_limit_min1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd9));
assign pair_limit_min0_r = pair_bus_dat_w[7:0];
assign pair_limit_min0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd10));
assign pair_limit_max1_r = pair_bus_dat_w[5:0];
assign pair_limit_max1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd11));
assign pair_limit_max0_r = pair_bus_dat_w[7:0];
assign pair_limit_max0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[3:0] == 4'd12));
assign pair_candidate_pid_pipelinedpid_setpoint_storage = pair_candidate_pid_pipelinedpid_setpoint_storage_full[13:0];
assign pair_pid_setpoint1_w = pair_candidate_pid_pipelinedpid_setpoint_storage_full[13:8];
assign pair_pid_setpoint0_w = pair_candidate_pid_pipelinedpid_setpoint_storage_full[7:0];
assign pair_candidate_pid_pipelinedpid_kp_storage = pair_candidate_pid_pipelinedpid_kp_storage_full[13:0];
assign pair_pid_kp1_w = pair_candidate_pid_pipelinedpid_kp_storage_full[13:8];
assign pair_pid_kp0_w = pair_candidate_pid_pipelinedpid_kp_storage_full[7:0];
assign pair_candidate_pid_pipelinedpid_ki_storage = pair_candidate_pid_pipelinedpid_ki_storage_full[13:0];
assign pair_pid_ki1_w = pair_candidate_pid_pipelinedpid_ki_storage_full[13:8];
assign pair_pid_ki0_w = pair_candidate_pid_pipelinedpid_ki_storage_full[7:0];
assign pair_candidate_pid_pipelinedpid_reset_storage = pair_candidate_pid_pipelinedpid_reset_storage_full;
assign pair_pid_reset0_w = pair_candidate_pid_pipelinedpid_reset_storage_full;
assign pair_candidate_pid_pipelinedpid_kd_storage = pair_candidate_pid_pipelinedpid_kd_storage_full[13:0];
assign pair_pid_kd1_w = pair_candidate_pid_pipelinedpid_kd_storage_full[13:8];
assign pair_pid_kd0_w = pair_candidate_pid_pipelinedpid_kd_storage_full[7:0];
assign pair_candidate_limit_min_storage = pair_candidate_limit_min_storage_full[13:0];
assign pair_limit_min1_w = pair_candidate_limit_min_storage_full[13:8];
assign pair_limit_min0_w = pair_candidate_limit_min_storage_full[7:0];
assign pair_candidate_limit_max_storage = pair_candidate_limit_max_storage_full[13:0];
assign pair_limit_max1_w = pair_candidate_limit_max_storage_full[13:8];
assign pair_limit_max0_w = pair_candidate_limit_max_storage_full[7:0];
assign pair_enable = (pair_started & array_muxed);

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	array_muxed <= 1'd0;
	case (pair_decimation)
		1'd0: begin
			array_muxed <= 1'd1;
		end
		1'd1: begin
			array_muxed <= (pair_decimation_counter[0] == 1'd1);
		end
		2'd2: begin
			array_muxed <= (pair_decimation_counter[1:0] == 2'd2);
		end
		2'd3: begin
			array_muxed <= (pair_decimation_counter[2:0] == 3'd4);
		end
		3'd4: begin
			array_muxed <= (pair_decimation_counter[3:0] == 4'd8);
		end
		3'd5: begin
			array_muxed <= (pair_decimation_counter[4:0] == 5'd16);
		end
		3'd6: begin
			array_muxed <= (pair_decimation_counter[5:0] == 6'd32);
		end
		3'd7: begin
			array_muxed <= (pair_decimation_counter[6:0] == 7'd64);
		end
		4'd8: begin
			array_muxed <= (pair_decimation_counter[7:0] == 8'd128);
		end
		4'd9: begin
			array_muxed <= (pair_decimation_counter[8:0] == 9'd256);
		end
		4'd10: begin
			array_muxed <= (pair_decimation_counter[9:0] == 10'd512);
		end
		4'd11: begin
			array_muxed <= (pair_decimation_counter[10:0] == 11'd1024);
		end
		4'd12: begin
			array_muxed <= (pair_decimation_counter[11:0] == 12'd2048);
		end
		4'd13: begin
			array_muxed <= (pair_decimation_counter[12:0] == 13'd4096);
		end
		4'd14: begin
			array_muxed <= (pair_decimation_counter[13:0] == 14'd8192);
		end
		default: begin
			array_muxed <= (pair_decimation_counter[14:0] == 15'd16384);
		end
	endcase
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	pair_s10 <= x;
	pair_s20 <= pair_s10;
	pair_s11 <= running;
	pair_s21 <= pair_s11;
	pair_s12 <= pair_accept;
	pair_s22 <= pair_s12;
	pair_s13 <= pair_candidate_pid_pipelinedpid_setpoint_storage;
	pair_s23 <= pair_s13;
	pair_s14 <= pair_candidate_pid_pipelinedpid_kp_storage;
	pair_s24 <= pair_s14;
	pair_s15 <= pair_candidate_pid_pipelinedpid_ki_storage;
	pair_s25 <= pair_s15;
	pair_s16 <= pair_candidate_pid_pipelinedpid_kd_storage;
	pair_s26 <= pair_s16;
	pair_s17 <= pair_candidate_pid_pipelinedpid_reset_storage;
	pair_s27 <= pair_s17;
	pair_s18 <= pair_candidate_limit_min_storage;
	pair_s28 <= pair_s18;
	pair_s19 <= pair_candidate_limit_max_storage;
	pair_s29 <= pair_s19;
	pair_s110 <= sweep;
	pair_s210 <= pair_s110;
	pair_s111 <= offset;
	pair_s211 <= pair_s111;
	pair_s112 <= sweep_channel;
	pair_s212 <= pair_s112;
	pair_s113 <= slow_channel;
	pair_s213 <= pair_s113;
	if ((seed_enable & (~pair_candidate_pid_update_en0))) begin
		pair_reference_pid_int_reg <= seed_value;
		pair_candidate_pid_pipelinedpid_int_reg <= seed_value;
	end
	pair_candidate_pid_pipelinedpid_kp_mult <= (pair_candidate_pid_error_s1 * pair_candidate_pid_kp_s1);
	pair_candidate_pid_pipelinedpid_ki_mult <= ((pair_candidate_pid_error_s1 * pair_candidate_pid_ki_s1) >>> 3'd4);
	if (pair_candidate_pid_update_en0) begin
		if (pair_candidate_pid_reset_s2) begin
			pair_candidate_pid_pipelinedpid_int_reg <= 1'd0;
		end else begin
			if (pair_candidate_pid_pipelinedpid0) begin
				pair_candidate_pid_pipelinedpid_int_reg <= 31'd2147221504;
			end else begin
				if (pair_candidate_pid_pipelinedpid1) begin
					pair_candidate_pid_pipelinedpid_int_reg <= 32'sd2147745791;
				end else begin
					pair_candidate_pid_pipelinedpid_int_reg <= pair_candidate_pid_pipelinedpid_int_sum;
				end
			end
		end
	end
	pair_candidate_pid_pipelinedpid_kd_mult <= (pair_candidate_pid_error_s1 * pair_candidate_pid_kd_s1);
	if (pair_candidate_pid_update_en0) begin
		pair_candidate_pid_pipelinedpid_kd_reg <= (pair_candidate_pid_pipelinedpid_kd_mult >>> 4'd8);
		pair_candidate_pid_pipelinedpid_kd_reg_r <= pair_candidate_pid_pipelinedpid_kd_reg;
		pair_candidate_pid_pipelinedpid_output_d <= (pair_candidate_pid_pipelinedpid_kd_reg - pair_candidate_pid_pipelinedpid_kd_reg_r);
	end
	if (pair_candidate_pid_update_en0) begin
		pair_candidate_pid_pipelinedpid_pid_sum <= ((pair_candidate_pid_pipelinedpid_output_p + pair_candidate_pid_pipelinedpid_int_out) + pair_candidate_pid_pipelinedpid_output_d);
	end
	pair_candidate_pid_valid_s1 <= pair_candidate_pid_update_en1;
	pair_candidate_pid_valid_s2 <= pair_candidate_pid_valid_s1;
	pair_candidate_pid_error_s1 <= pair_candidate_pid_pipelinedpid_error;
	pair_candidate_pid_kp_s1 <= pair_candidate_pid_pipelinedpid_kp_storage;
	pair_candidate_pid_ki_s1 <= pair_candidate_pid_pipelinedpid_ki_storage;
	pair_candidate_pid_kd_s1 <= pair_candidate_pid_pipelinedpid_kd_storage;
	pair_candidate_pid_reset_s1 <= pair_candidate_pid_pipelinedpid_reset_storage;
	pair_candidate_pid_reset_s2 <= pair_candidate_pid_reset_s1;
	pair_candidate_limit_minimum_s1 <= pair_candidate_limit_min_storage;
	pair_candidate_limit_minimum_s2 <= pair_candidate_limit_minimum_s1;
	pair_candidate_limit_maximum_s1 <= pair_candidate_limit_max_storage;
	pair_candidate_limit_maximum_s2 <= pair_candidate_limit_maximum_s1;
	if (pair_candidate_limit_update_en) begin
		pair_candidate_limit_limit_min <= {{5{pair_candidate_limit_minimum_s2[13]}}, pair_candidate_limit_minimum_s2};
		pair_candidate_limit_limit_max <= {{5{pair_candidate_limit_maximum_s2[13]}}, pair_candidate_limit_maximum_s2};
		pair_candidate_limit_alignedslowlimitcsr_y <= pair_candidate_limit_limit_y;
		pair_candidate_limit_alignedslowlimitcsr_error <= pair_candidate_limit_limit_railed;
	end
	if (pair_reference_pid_update_en) begin
		if (pair_reference_pid_reset_storage) begin
			pair_reference_pid_int_reg <= 1'd0;
		end else begin
			if (pair_reference_pid_overflow_pos) begin
				pair_reference_pid_int_reg <= 31'd2147221504;
			end else begin
				if (pair_reference_pid_overflow_neg) begin
					pair_reference_pid_int_reg <= 32'sd2147745791;
				end else begin
					pair_reference_pid_int_reg <= pair_reference_pid_int_sum;
				end
			end
		end
	end
	if (pair_reference_pid_update_en) begin
		pair_reference_pid_kd_reg <= (pair_reference_pid_kd_mult >>> 4'd8);
		pair_reference_pid_kd_reg_r <= pair_reference_pid_kd_reg;
		pair_reference_pid_output_d <= (pair_reference_pid_kd_reg - pair_reference_pid_kd_reg_r);
	end
	if (pair_reference_pid_update_en) begin
		pair_reference_pid_pid_sum <= ((pair_reference_pid_output_p + pair_reference_pid_int_out) + pair_reference_pid_output_d);
	end
	if (pair_reference_limit_update_en) begin
		pair_reference_limit_limit_min <= {{5{pair_reference_limit_min_storage[13]}}, pair_reference_limit_min_storage};
		pair_reference_limit_limit_max <= {{5{pair_reference_limit_max_storage[13]}}, pair_reference_limit_max_storage};
		pair_reference_limit_limitcsr_y <= pair_reference_limit_limit_y;
		pair_reference_limit_limitcsr_error <= pair_reference_limit_limit_railed;
	end
	pair_slowoutputtransport_channel_s1 <= pair_slowoutputtransport_slow_channel;
	pair_slowoutputtransport_aligned_slow_channel <= pair_slowoutputtransport_channel_s1;
	pair_slowoutputtransport0 <= pair_slowoutputtransport_contribution;
	pair_slowoutputtransport1 <= pair_slowoutputtransport0;
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[3:0])
			1'd0: begin
				pair_bus_dat_r <= pair_pid_setpoint1_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_pid_setpoint0_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_pid_kp1_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_pid_kp0_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_pid_ki1_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_pid_ki0_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_pid_reset0_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_pid_kd1_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_pid_kd0_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_limit_min1_w;
			end
			4'd10: begin
				pair_bus_dat_r <= pair_limit_min0_w;
			end
			4'd11: begin
				pair_bus_dat_r <= pair_limit_max1_w;
			end
			4'd12: begin
				pair_bus_dat_r <= pair_limit_max0_w;
			end
		endcase
	end
	if (pair_pid_setpoint1_re) begin
		pair_candidate_pid_pipelinedpid_setpoint_storage_full[13:8] <= pair_pid_setpoint1_r;
	end
	if (pair_pid_setpoint0_re) begin
		pair_candidate_pid_pipelinedpid_setpoint_storage_full[7:0] <= pair_pid_setpoint0_r;
	end
	pair_candidate_pid_pipelinedpid_setpoint_re <= pair_pid_setpoint0_re;
	if (pair_pid_kp1_re) begin
		pair_candidate_pid_pipelinedpid_kp_storage_full[13:8] <= pair_pid_kp1_r;
	end
	if (pair_pid_kp0_re) begin
		pair_candidate_pid_pipelinedpid_kp_storage_full[7:0] <= pair_pid_kp0_r;
	end
	pair_candidate_pid_pipelinedpid_kp_re <= pair_pid_kp0_re;
	if (pair_pid_ki1_re) begin
		pair_candidate_pid_pipelinedpid_ki_storage_full[13:8] <= pair_pid_ki1_r;
	end
	if (pair_pid_ki0_re) begin
		pair_candidate_pid_pipelinedpid_ki_storage_full[7:0] <= pair_pid_ki0_r;
	end
	pair_candidate_pid_pipelinedpid_ki_re <= pair_pid_ki0_re;
	if (pair_pid_reset0_re) begin
		pair_candidate_pid_pipelinedpid_reset_storage_full <= pair_pid_reset0_r;
	end
	pair_candidate_pid_pipelinedpid_reset_re <= pair_pid_reset0_re;
	if (pair_pid_kd1_re) begin
		pair_candidate_pid_pipelinedpid_kd_storage_full[13:8] <= pair_pid_kd1_r;
	end
	if (pair_pid_kd0_re) begin
		pair_candidate_pid_pipelinedpid_kd_storage_full[7:0] <= pair_pid_kd0_r;
	end
	pair_candidate_pid_pipelinedpid_kd_re <= pair_pid_kd0_re;
	if (pair_limit_min1_re) begin
		pair_candidate_limit_min_storage_full[13:8] <= pair_limit_min1_r;
	end
	if (pair_limit_min0_re) begin
		pair_candidate_limit_min_storage_full[7:0] <= pair_limit_min0_r;
	end
	pair_candidate_limit_min_re <= pair_limit_min0_re;
	if (pair_limit_max1_re) begin
		pair_candidate_limit_max_storage_full[13:8] <= pair_limit_max1_r;
	end
	if (pair_limit_max0_re) begin
		pair_candidate_limit_max_storage_full[7:0] <= pair_limit_max0_r;
	end
	pair_candidate_limit_max_re <= pair_limit_max0_re;
	pair_decimation_counter <= (pair_decimation_counter + 1'd1);
	pair_started <= 1'd1;
	if (sys_rst) begin
		pair_candidate_pid_error_s1 <= 15'sd0;
		pair_candidate_pid_kp_s1 <= 14'sd0;
		pair_candidate_pid_ki_s1 <= 14'sd0;
		pair_candidate_pid_kd_s1 <= 14'sd0;
		pair_candidate_pid_reset_s1 <= 1'd0;
		pair_candidate_pid_reset_s2 <= 1'd0;
		pair_candidate_pid_valid_s1 <= 1'd0;
		pair_candidate_pid_valid_s2 <= 1'd0;
		pair_candidate_pid_pipelinedpid_setpoint_storage_full <= 14'd0;
		pair_candidate_pid_pipelinedpid_setpoint_re <= 1'd0;
		pair_candidate_pid_pipelinedpid_kp_storage_full <= 14'd0;
		pair_candidate_pid_pipelinedpid_kp_re <= 1'd0;
		pair_candidate_pid_pipelinedpid_kp_mult <= 28'sd0;
		pair_candidate_pid_pipelinedpid_ki_storage_full <= 14'd0;
		pair_candidate_pid_pipelinedpid_ki_re <= 1'd0;
		pair_candidate_pid_pipelinedpid_reset_storage_full <= 1'd0;
		pair_candidate_pid_pipelinedpid_reset_re <= 1'd0;
		pair_candidate_pid_pipelinedpid_ki_mult <= 29'sd0;
		pair_candidate_pid_pipelinedpid_int_reg <= 32'sd0;
		pair_candidate_pid_pipelinedpid_kd_storage_full <= 14'd0;
		pair_candidate_pid_pipelinedpid_kd_re <= 1'd0;
		pair_candidate_pid_pipelinedpid_kd_mult <= 30'sd0;
		pair_candidate_pid_pipelinedpid_kd_reg <= 23'sd0;
		pair_candidate_pid_pipelinedpid_kd_reg_r <= 23'sd0;
		pair_candidate_pid_pipelinedpid_output_d <= 23'sd0;
		pair_candidate_pid_pipelinedpid_pid_sum <= 51'sd0;
		pair_candidate_limit_alignedslowlimitcsr_y <= 14'sd0;
		pair_candidate_limit_alignedslowlimitcsr_error <= 1'd0;
		pair_candidate_limit_min_storage_full <= 14'd8192;
		pair_candidate_limit_min_re <= 1'd0;
		pair_candidate_limit_max_storage_full <= 14'd8191;
		pair_candidate_limit_max_re <= 1'd0;
		pair_candidate_limit_limit_max <= 19'sd0;
		pair_candidate_limit_limit_min <= 19'sd0;
		pair_candidate_limit_minimum_s1 <= 14'd8192;
		pair_candidate_limit_minimum_s2 <= 14'd8192;
		pair_candidate_limit_maximum_s1 <= 14'd8191;
		pair_candidate_limit_maximum_s2 <= 14'd8191;
		pair_reference_pid_int_reg <= 32'sd0;
		pair_reference_pid_kd_reg <= 23'sd0;
		pair_reference_pid_kd_reg_r <= 23'sd0;
		pair_reference_pid_output_d <= 23'sd0;
		pair_reference_pid_pid_sum <= 51'sd0;
		pair_reference_limit_limitcsr_y <= 14'sd0;
		pair_reference_limit_limitcsr_error <= 1'd0;
		pair_reference_limit_limit_max <= 19'sd0;
		pair_reference_limit_limit_min <= 19'sd0;
		pair_slowoutputtransport_aligned_slow_channel <= 2'd0;
		pair_slowoutputtransport_channel_s1 <= 2'd0;
		pair_slowoutputtransport0 <= 17'sd0;
		pair_slowoutputtransport1 <= 17'sd0;
		pair_bus_dat_r <= 8'd0;
		pair_decimation_counter <= 15'd0;
		pair_started <= 1'd0;
		pair_s10 <= 14'sd0;
		pair_s20 <= 14'sd0;
		pair_s11 <= 1'd0;
		pair_s21 <= 1'd0;
		pair_s12 <= 1'd0;
		pair_s22 <= 1'd0;
		pair_s13 <= 14'd0;
		pair_s23 <= 14'd0;
		pair_s14 <= 14'd0;
		pair_s24 <= 14'd0;
		pair_s15 <= 14'd0;
		pair_s25 <= 14'd0;
		pair_s16 <= 14'd0;
		pair_s26 <= 14'd0;
		pair_s17 <= 1'd0;
		pair_s27 <= 1'd0;
		pair_s18 <= 14'd8192;
		pair_s28 <= 14'd8192;
		pair_s19 <= 14'd8191;
		pair_s29 <= 14'd8191;
		pair_s110 <= 14'sd0;
		pair_s210 <= 14'sd0;
		pair_s111 <= 14'sd0;
		pair_s211 <= 14'sd0;
		pair_s112 <= 2'd0;
		pair_s212 <= 2'd0;
		pair_s113 <= 2'd0;
		pair_s213 <= 2'd0;
	end
end

endmodule
