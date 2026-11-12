/* Machine-generated using Migen */
module latency_pair(
	input sys_clk,
	input sys_rst,
	input sys_double_clk,
	input dac_2p_clk,
	input [15:0] adc_word,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [13:0] ref_data,
	output ref_wrt,
	output ref_sel,
	output [13:0] ref_kp,
	output [13:0] cand_data,
	output cand_wrt,
	output cand_sel,
	output [13:0] cand_kp
);

wire [15:0] pair_record0_adc_data_a;
wire [15:0] pair_record0_adc_data_b;
wire pair_record0_adc_cdcs;
wire [1:0] pair_record0_adc_clk;
wire [13:0] pair_record0_dac_data;
wire pair_record0_dac_clk;
wire pair_record0_dac_wrt;
wire pair_record0_dac_sel;
wire pair_record0_dac_rst;
wire signed [13:0] pair_pitayaanalog_adc_a;
wire signed [13:0] pair_pitayaanalog_adc_b;
wire signed [13:0] pair_pitayaanalog_dac_a;
wire signed [13:0] pair_pitayaanalog_dac_b;
wire [15:0] pair_pitayaanalog_adca;
wire [15:0] pair_pitayaanalog_adcb;
reg [13:0] pair_pitayaanalog_daca = 14'd0;
reg [13:0] pair_pitayaanalog_dacb = 14'd0;
reg pair_pitayaanalog_frame = 1'd0;
wire pair_pitayaanalog_frame_seen;
wire pair_pitayaanalog_select_b;
wire [13:0] pair_pitayaanalog_dac_word;
reg signed [25:0] pair_mixeralignedpid0_error_s1 = 26'sd0;
reg signed [13:0] pair_mixeralignedpid00 = 14'sd0;
reg signed [13:0] pair_mixeralignedpid01 = 14'sd0;
reg signed [13:0] pair_mixeralignedpid02 = 14'sd0;
reg pair_mixeralignedpid03 = 1'd0;
reg pair_mixeralignedpid04 = 1'd0;
reg pair_mixeralignedpid05 = 1'd0;
reg pair_mixeralignedpid06 = 1'd0;
reg [24:0] pair_mixeralignedpid0_setpoint_cohort = 25'd0;
reg pair_mixeralignedpid0_running_cohort = 1'd0;
reg [13:0] pair_mixeralignedpid07 = 14'd0;
reg [13:0] pair_mixeralignedpid08 = 14'd0;
reg [13:0] pair_mixeralignedpid09 = 14'd0;
reg pair_mixeralignedpid010 = 1'd0;
reg pair_mixeralignedpid011 = 1'd0;
wire signed [24:0] pair_mixeralignedpid0_input;
wire pair_mixeralignedpid0_running;
wire pair_mixeralignedpid0_update_en0;
reg [24:0] pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full = 25'd0;
wire [24:0] pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage;
reg pair_mixeralignedpid0_mixeralignedpid0_setpoint_re = 1'd0;
reg signed [25:0] pair_mixeralignedpid0_mixeralignedpid0_error;
reg [13:0] pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid0_mixeralignedpid0_kp_storage;
reg pair_mixeralignedpid0_mixeralignedpid0_kp_re = 1'd0;
reg signed [38:0] pair_mixeralignedpid0_mixeralignedpid0_kp_mult = 39'sd0;
wire signed [24:0] pair_mixeralignedpid0_mixeralignedpid0_output_p;
reg [13:0] pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid0_mixeralignedpid0_ki_storage;
reg pair_mixeralignedpid0_mixeralignedpid0_ki_re = 1'd0;
reg pair_mixeralignedpid0_mixeralignedpid0_reset_storage_full = 1'd0;
wire pair_mixeralignedpid0_mixeralignedpid0_reset_storage;
reg pair_mixeralignedpid0_mixeralignedpid0_reset_re = 1'd0;
reg signed [39:0] pair_mixeralignedpid0_mixeralignedpid0_ki_mult = 40'sd0;
reg signed [42:0] pair_mixeralignedpid0_mixeralignedpid0_int_reg = 43'sd0;
wire signed [43:0] pair_mixeralignedpid0_mixeralignedpid0_int_sum;
wire signed [24:0] pair_mixeralignedpid0_mixeralignedpid0_int_out;
wire pair_mixeralignedpid0_mixeralignedpid00;
wire pair_mixeralignedpid0_mixeralignedpid01;
reg [13:0] pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid0_mixeralignedpid0_kd_storage;
reg pair_mixeralignedpid0_mixeralignedpid0_kd_re = 1'd0;
reg signed [40:0] pair_mixeralignedpid0_mixeralignedpid0_kd_mult = 41'sd0;
reg signed [33:0] pair_mixeralignedpid0_mixeralignedpid0_kd_reg = 34'sd0;
reg signed [33:0] pair_mixeralignedpid0_mixeralignedpid0_kd_reg_r = 34'sd0;
reg signed [33:0] pair_mixeralignedpid0_mixeralignedpid0_output_d = 34'sd0;
reg signed [83:0] pair_mixeralignedpid0_mixeralignedpid0_pid_sum = 84'sd0;
reg signed [24:0] pair_mixeralignedpid0_mixeralignedpid0_pid_out;
wire pair_mixeralignedpid0_update_en1;
reg [24:0] pair_mixeralignedpid0_q0 = 25'd0;
reg pair_mixeralignedpid0_q1 = 1'd0;
reg [13:0] pair_mixeralignedpid0_q2 = 14'd0;
reg [13:0] pair_mixeralignedpid0_q3 = 14'd0;
reg [13:0] pair_mixeralignedpid0_q4 = 14'd0;
reg pair_mixeralignedpid0_q5 = 1'd0;
reg pair_mixeralignedpid0_q6 = 1'd0;
reg signed [13:0] pair_limitcsr0_limitcsr0_y = 14'sd0;
reg pair_limitcsr0_limitcsr0_error = 1'd0;
reg pair_limitcsr0_update_en = 1'd1;
reg signed [18:0] pair_limitcsr0_x = 19'sd0;
reg [13:0] pair_limitcsr0_min_storage = 14'd8192;
reg [13:0] pair_limitcsr0_max_storage = 14'd8191;
wire signed [18:0] pair_limitcsr0_limit_x;
reg signed [18:0] pair_limitcsr0_limit_y;
reg signed [18:0] pair_limitcsr0_limit_max = 19'sd0;
reg signed [18:0] pair_limitcsr0_limit_min = 19'sd0;
reg pair_limitcsr0_limit_railed;
wire [13:0] pair_csrbank0_bus_adr;
wire pair_csrbank0_bus_we;
wire [7:0] pair_csrbank0_bus_dat_w;
reg [7:0] pair_csrbank0_bus_dat_r = 8'd0;
wire pair_csrbank0_setpoint3_re;
wire pair_csrbank0_setpoint3_r;
wire pair_csrbank0_setpoint3_w;
wire pair_csrbank0_setpoint2_re;
wire [7:0] pair_csrbank0_setpoint2_r;
wire [7:0] pair_csrbank0_setpoint2_w;
wire pair_csrbank0_setpoint1_re;
wire [7:0] pair_csrbank0_setpoint1_r;
wire [7:0] pair_csrbank0_setpoint1_w;
wire pair_csrbank0_setpoint0_re;
wire [7:0] pair_csrbank0_setpoint0_r;
wire [7:0] pair_csrbank0_setpoint0_w;
wire pair_csrbank0_kp1_re;
wire [5:0] pair_csrbank0_kp1_r;
wire [5:0] pair_csrbank0_kp1_w;
wire pair_csrbank0_kp0_re;
wire [7:0] pair_csrbank0_kp0_r;
wire [7:0] pair_csrbank0_kp0_w;
wire pair_csrbank0_ki1_re;
wire [5:0] pair_csrbank0_ki1_r;
wire [5:0] pair_csrbank0_ki1_w;
wire pair_csrbank0_ki0_re;
wire [7:0] pair_csrbank0_ki0_r;
wire [7:0] pair_csrbank0_ki0_w;
wire pair_csrbank0_reset0_re;
wire pair_csrbank0_reset0_r;
wire pair_csrbank0_reset0_w;
wire pair_csrbank0_kd1_re;
wire [5:0] pair_csrbank0_kd1_r;
wire [5:0] pair_csrbank0_kd1_w;
wire pair_csrbank0_kd0_re;
wire [7:0] pair_csrbank0_kd0_r;
wire [7:0] pair_csrbank0_kd0_w;
wire pair_csrbank0_sel;
wire signed [13:0] pair_feedbackinputalignment0_direct_adc;
wire signed [24:0] pair_feedbackinputalignment0_mixed_error;
wire pair_feedbackinputalignment0_pid_only;
reg pair_feedbackinputalignment0_limit_accept_en = 1'd1;
reg pair_feedbackinputalignment0_limit_execute_en = 1'd0;
wire signed [24:0] pair_feedbackinputalignment0_output;
reg signed [13:0] pair_feedbackinputalignment0_adc_cohort = 14'sd0;
reg pair_feedbackinputalignment0_mode_cohort = 1'd0;
reg signed [13:0] pair_feedbackinputalignment0_q0 = 14'sd0;
reg pair_feedbackinputalignment0_q1 = 1'd0;
reg pair_feedbackinputalignment0_q2 = 1'd0;
wire [15:0] pair_record1_adc_data_a;
wire [15:0] pair_record1_adc_data_b;
wire pair_record1_adc_cdcs;
wire [1:0] pair_record1_adc_clk;
wire [13:0] pair_record1_dac_data;
wire pair_record1_dac_clk;
wire pair_record1_dac_wrt;
wire pair_record1_dac_sel;
wire pair_record1_dac_rst;
wire dac_io_clk;
wire dac_write_io_clk;
wire dac_sample_io_clk;
wire dac_select_io_clk;
wire dac_ready_clk;
wire dac_ready_rst;
wire pair_analog_dacregionalclock0;
wire pair_analog_dacregionalclock1;
wire pair_analog_dacregionalclock2;
wire pair_analog_dacregionalclock3;
wire pair_analog_dacregionalclock_feedback;
wire pair_analog_dacregionalclock_locked;
wire signed [13:0] pair_analog_adc_a;
wire signed [13:0] pair_analog_adc_b;
wire signed [13:0] pair_analog_dac_a;
wire signed [13:0] pair_analog_dac_b;
wire [15:0] pair_analog_adca;
wire [15:0] pair_analog_adcb;
reg [13:0] pair_analog_daca = 14'd0;
reg [13:0] pair_analog_dacb = 14'd0;
reg pair_analog_frame = 1'd0;
wire pair_analog_frame_seen;
wire pair_analog_select_b;
wire [13:0] pair_analog_dac_word;
reg signed [25:0] pair_mixeralignedpid1_error_s1 = 26'sd0;
reg signed [13:0] pair_mixeralignedpid10 = 14'sd0;
reg signed [13:0] pair_mixeralignedpid11 = 14'sd0;
reg signed [13:0] pair_mixeralignedpid12 = 14'sd0;
reg pair_mixeralignedpid13 = 1'd0;
reg pair_mixeralignedpid14 = 1'd0;
reg pair_mixeralignedpid15 = 1'd0;
reg pair_mixeralignedpid16 = 1'd0;
reg [24:0] pair_mixeralignedpid1_setpoint_cohort = 25'd0;
reg pair_mixeralignedpid1_running_cohort = 1'd0;
reg [13:0] pair_mixeralignedpid17 = 14'd0;
reg [13:0] pair_mixeralignedpid18 = 14'd0;
reg [13:0] pair_mixeralignedpid19 = 14'd0;
reg pair_mixeralignedpid110 = 1'd0;
reg pair_mixeralignedpid111 = 1'd0;
wire signed [24:0] pair_mixeralignedpid1_input;
wire pair_mixeralignedpid1_running;
wire pair_mixeralignedpid1_update_en0;
reg [24:0] pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full = 25'd0;
wire [24:0] pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage;
reg pair_mixeralignedpid1_mixeralignedpid1_setpoint_re = 1'd0;
reg signed [25:0] pair_mixeralignedpid1_mixeralignedpid1_error;
reg [13:0] pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid1_mixeralignedpid1_kp_storage;
reg pair_mixeralignedpid1_mixeralignedpid1_kp_re = 1'd0;
reg signed [38:0] pair_mixeralignedpid1_mixeralignedpid1_kp_mult = 39'sd0;
wire signed [24:0] pair_mixeralignedpid1_mixeralignedpid1_output_p;
reg [13:0] pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid1_mixeralignedpid1_ki_storage;
reg pair_mixeralignedpid1_mixeralignedpid1_ki_re = 1'd0;
reg pair_mixeralignedpid1_mixeralignedpid1_reset_storage_full = 1'd0;
wire pair_mixeralignedpid1_mixeralignedpid1_reset_storage;
reg pair_mixeralignedpid1_mixeralignedpid1_reset_re = 1'd0;
reg signed [39:0] pair_mixeralignedpid1_mixeralignedpid1_ki_mult = 40'sd0;
reg signed [42:0] pair_mixeralignedpid1_mixeralignedpid1_int_reg = 43'sd0;
wire signed [43:0] pair_mixeralignedpid1_mixeralignedpid1_int_sum;
wire signed [24:0] pair_mixeralignedpid1_mixeralignedpid1_int_out;
wire pair_mixeralignedpid1_mixeralignedpid10;
wire pair_mixeralignedpid1_mixeralignedpid11;
reg [13:0] pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full = 14'd0;
wire [13:0] pair_mixeralignedpid1_mixeralignedpid1_kd_storage;
reg pair_mixeralignedpid1_mixeralignedpid1_kd_re = 1'd0;
reg signed [40:0] pair_mixeralignedpid1_mixeralignedpid1_kd_mult = 41'sd0;
reg signed [33:0] pair_mixeralignedpid1_mixeralignedpid1_kd_reg = 34'sd0;
reg signed [33:0] pair_mixeralignedpid1_mixeralignedpid1_kd_reg_r = 34'sd0;
reg signed [33:0] pair_mixeralignedpid1_mixeralignedpid1_output_d = 34'sd0;
reg signed [83:0] pair_mixeralignedpid1_mixeralignedpid1_pid_sum = 84'sd0;
reg signed [24:0] pair_mixeralignedpid1_mixeralignedpid1_pid_out;
wire pair_mixeralignedpid1_update_en1;
reg [24:0] pair_mixeralignedpid1_q0 = 25'd0;
reg pair_mixeralignedpid1_q1 = 1'd0;
reg [13:0] pair_mixeralignedpid1_q2 = 14'd0;
reg [13:0] pair_mixeralignedpid1_q3 = 14'd0;
reg [13:0] pair_mixeralignedpid1_q4 = 14'd0;
reg pair_mixeralignedpid1_q5 = 1'd0;
reg pair_mixeralignedpid1_q6 = 1'd0;
reg signed [13:0] pair_limitcsr1_limitcsr1_y = 14'sd0;
reg pair_limitcsr1_limitcsr1_error = 1'd0;
reg pair_limitcsr1_update_en = 1'd1;
reg signed [18:0] pair_limitcsr1_x = 19'sd0;
reg [13:0] pair_limitcsr1_min_storage = 14'd8192;
reg [13:0] pair_limitcsr1_max_storage = 14'd8191;
wire signed [18:0] pair_limitcsr1_limit_x;
reg signed [18:0] pair_limitcsr1_limit_y;
reg signed [18:0] pair_limitcsr1_limit_max = 19'sd0;
reg signed [18:0] pair_limitcsr1_limit_min = 19'sd0;
reg pair_limitcsr1_limit_railed;
wire [13:0] pair_csrbank1_bus_adr;
wire pair_csrbank1_bus_we;
wire [7:0] pair_csrbank1_bus_dat_w;
reg [7:0] pair_csrbank1_bus_dat_r = 8'd0;
wire pair_csrbank1_setpoint3_re;
wire pair_csrbank1_setpoint3_r;
wire pair_csrbank1_setpoint3_w;
wire pair_csrbank1_setpoint2_re;
wire [7:0] pair_csrbank1_setpoint2_r;
wire [7:0] pair_csrbank1_setpoint2_w;
wire pair_csrbank1_setpoint1_re;
wire [7:0] pair_csrbank1_setpoint1_r;
wire [7:0] pair_csrbank1_setpoint1_w;
wire pair_csrbank1_setpoint0_re;
wire [7:0] pair_csrbank1_setpoint0_r;
wire [7:0] pair_csrbank1_setpoint0_w;
wire pair_csrbank1_kp1_re;
wire [5:0] pair_csrbank1_kp1_r;
wire [5:0] pair_csrbank1_kp1_w;
wire pair_csrbank1_kp0_re;
wire [7:0] pair_csrbank1_kp0_r;
wire [7:0] pair_csrbank1_kp0_w;
wire pair_csrbank1_ki1_re;
wire [5:0] pair_csrbank1_ki1_r;
wire [5:0] pair_csrbank1_ki1_w;
wire pair_csrbank1_ki0_re;
wire [7:0] pair_csrbank1_ki0_r;
wire [7:0] pair_csrbank1_ki0_w;
wire pair_csrbank1_reset0_re;
wire pair_csrbank1_reset0_r;
wire pair_csrbank1_reset0_w;
wire pair_csrbank1_kd1_re;
wire [5:0] pair_csrbank1_kd1_r;
wire [5:0] pair_csrbank1_kd1_w;
wire pair_csrbank1_kd0_re;
wire [7:0] pair_csrbank1_kd0_r;
wire [7:0] pair_csrbank1_kd0_w;
wire pair_csrbank1_sel;
wire signed [13:0] pair_feedbackinputalignment1_direct_adc;
wire signed [24:0] pair_feedbackinputalignment1_mixed_error;
wire pair_feedbackinputalignment1_pid_only;
reg pair_feedbackinputalignment1_limit_accept_en = 1'd1;
reg pair_feedbackinputalignment1_limit_execute_en = 1'd0;
wire signed [24:0] pair_feedbackinputalignment1_output;
reg signed [13:0] pair_feedbackinputalignment1_adc_cohort = 14'sd0;
reg pair_feedbackinputalignment1_mode_cohort = 1'd0;
reg signed [13:0] pair_feedbackinputalignment1_q0 = 14'sd0;
reg pair_feedbackinputalignment1_q1 = 1'd0;
reg pair_feedbackinputalignment1_q2 = 1'd0;
wire xilinxasyncresetsynchronizerimpl;
wire xilinxasyncresetsynchronizerimpl_rst_meta;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_record0_adc_data_a = adc_word;
assign pair_record0_adc_data_b = 15'd32764;
assign pair_mixeralignedpid0_running = 1'd1;
assign pair_mixeralignedpid0_update_en1 = 1'd1;
assign pair_pitayaanalog_dac_a = pair_limitcsr0_limitcsr0_y;
assign pair_pitayaanalog_dac_b = 1'd0;
assign pair_csrbank0_bus_adr = csr_adr;
assign pair_csrbank0_bus_we = csr_we;
assign pair_csrbank0_bus_dat_w = csr_dat_w;
assign pair_feedbackinputalignment0_direct_adc = pair_pitayaanalog_adc_a;
assign pair_feedbackinputalignment0_pid_only = 1'd1;
assign pair_feedbackinputalignment0_mixed_error = 1'd0;
assign pair_mixeralignedpid0_input = pair_feedbackinputalignment0_output;
assign ref_data = pair_record0_dac_data;
assign ref_wrt = pair_record0_dac_wrt;
assign ref_sel = pair_record0_dac_sel;
assign ref_kp = pair_mixeralignedpid0_mixeralignedpid0_kp_storage;
assign pair_record1_adc_data_a = adc_word;
assign pair_record1_adc_data_b = 15'd32764;
assign pair_mixeralignedpid1_running = 1'd1;
assign pair_mixeralignedpid1_update_en1 = 1'd1;
assign pair_analog_dac_a = pair_limitcsr1_limitcsr1_y;
assign pair_analog_dac_b = 1'd0;
assign pair_csrbank1_bus_adr = csr_adr;
assign pair_csrbank1_bus_we = csr_we;
assign pair_csrbank1_bus_dat_w = csr_dat_w;
assign pair_feedbackinputalignment1_direct_adc = pair_analog_adc_a;
assign pair_feedbackinputalignment1_pid_only = 1'd1;
assign pair_feedbackinputalignment1_mixed_error = 1'd0;
assign pair_mixeralignedpid1_input = pair_feedbackinputalignment1_output;
assign cand_data = pair_record1_dac_data;
assign cand_wrt = pair_record1_dac_wrt;
assign cand_sel = pair_record1_dac_sel;
assign cand_kp = pair_mixeralignedpid1_mixeralignedpid1_kp_storage;
assign pair_record0_adc_cdcs = 1'd1;
assign pair_record0_adc_clk = 2'd2;
assign pair_pitayaanalog_adc_a = {pair_pitayaanalog_adca[15], (~pair_pitayaanalog_adca[14:2])};
assign pair_pitayaanalog_adc_b = {pair_pitayaanalog_adcb[15], (~pair_pitayaanalog_adcb[14:2])};
assign pair_pitayaanalog_select_b = (pair_pitayaanalog_frame ^ pair_pitayaanalog_frame_seen);
assign pair_pitayaanalog_dac_word = (pair_pitayaanalog_select_b ? pair_pitayaanalog_dacb : pair_pitayaanalog_daca);
assign pair_record0_dac_rst = sys_rst;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_mixeralignedpid0_mixeralignedpid0_error <= 26'sd0;
	if (pair_mixeralignedpid0_running_cohort) begin
		pair_mixeralignedpid0_mixeralignedpid0_error <= (pair_mixeralignedpid0_input - $signed({1'd0, pair_mixeralignedpid0_setpoint_cohort}));
	end else begin
		pair_mixeralignedpid0_mixeralignedpid0_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_mixeralignedpid0_mixeralignedpid0_output_p = (pair_mixeralignedpid0_mixeralignedpid0_kp_mult >>> 4'd12);
assign pair_mixeralignedpid0_mixeralignedpid0_int_sum = (pair_mixeralignedpid0_mixeralignedpid0_ki_mult + pair_mixeralignedpid0_mixeralignedpid0_int_reg);
assign pair_mixeralignedpid0_mixeralignedpid0_int_out = (pair_mixeralignedpid0_mixeralignedpid0_int_reg >>> 5'd18);
assign pair_mixeralignedpid0_mixeralignedpid00 = ((~pair_mixeralignedpid0_mixeralignedpid0_int_sum[43]) & (pair_mixeralignedpid0_mixeralignedpid0_int_sum[42] | ((pair_mixeralignedpid0_mixeralignedpid0_int_sum[41:18] == $signed({1'd0, 24'd16777215})) & (pair_mixeralignedpid0_mixeralignedpid0_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_mixeralignedpid0_mixeralignedpid01 = (pair_mixeralignedpid0_mixeralignedpid0_int_sum[43] & ((~pair_mixeralignedpid0_mixeralignedpid0_int_sum[42]) | ((pair_mixeralignedpid0_mixeralignedpid0_int_sum[41:18] == $signed({1'd0, 1'd0})) & (pair_mixeralignedpid0_mixeralignedpid0_int_sum[17:0] != $signed({1'd0, 18'd262143})))));

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_mixeralignedpid0_mixeralignedpid0_pid_out <= 25'sd0;
	if (((~pair_mixeralignedpid0_mixeralignedpid0_pid_sum[83]) & (pair_mixeralignedpid0_mixeralignedpid0_pid_sum[83:24] != $signed({1'd0, 1'd0})))) begin
		pair_mixeralignedpid0_mixeralignedpid0_pid_out <= 24'd16777215;
	end else begin
		if ((pair_mixeralignedpid0_mixeralignedpid0_pid_sum[83] & (pair_mixeralignedpid0_mixeralignedpid0_pid_sum[83:24] != $signed({1'd0, 60'd1152921504606846975})))) begin
			pair_mixeralignedpid0_mixeralignedpid0_pid_out <= 25'sd16777216;
		end else begin
			pair_mixeralignedpid0_mixeralignedpid0_pid_out <= pair_mixeralignedpid0_mixeralignedpid0_pid_sum[24:0];
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_mixeralignedpid0_update_en0 = pair_mixeralignedpid06;
assign pair_limitcsr0_limit_x = pair_limitcsr0_x;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_limitcsr0_limit_y <= 19'sd0;
	pair_limitcsr0_limit_railed <= 1'd0;
	if ((pair_limitcsr0_limit_x >= pair_limitcsr0_limit_max)) begin
		pair_limitcsr0_limit_y <= pair_limitcsr0_limit_max;
		pair_limitcsr0_limit_railed <= 1'd1;
	end else begin
		if ((pair_limitcsr0_limit_x <= pair_limitcsr0_limit_min)) begin
			pair_limitcsr0_limit_y <= pair_limitcsr0_limit_min;
			pair_limitcsr0_limit_railed <= 1'd1;
		end else begin
			pair_limitcsr0_limit_y <= pair_limitcsr0_limit_x;
			pair_limitcsr0_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_csrbank0_sel = (pair_csrbank0_bus_adr[13:9] == 1'd0);
assign pair_csrbank0_setpoint3_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_setpoint3_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 1'd0));
assign pair_csrbank0_setpoint2_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_setpoint2_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 1'd1));
assign pair_csrbank0_setpoint1_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_setpoint1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 2'd2));
assign pair_csrbank0_setpoint0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_setpoint0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 2'd3));
assign pair_csrbank0_kp1_r = pair_csrbank0_bus_dat_w[5:0];
assign pair_csrbank0_kp1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 3'd4));
assign pair_csrbank0_kp0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_kp0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 3'd5));
assign pair_csrbank0_ki1_r = pair_csrbank0_bus_dat_w[5:0];
assign pair_csrbank0_ki1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 3'd6));
assign pair_csrbank0_ki0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_ki0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 3'd7));
assign pair_csrbank0_reset0_r = pair_csrbank0_bus_dat_w[0];
assign pair_csrbank0_reset0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 4'd8));
assign pair_csrbank0_kd1_r = pair_csrbank0_bus_dat_w[5:0];
assign pair_csrbank0_kd1_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 4'd9));
assign pair_csrbank0_kd0_r = pair_csrbank0_bus_dat_w[7:0];
assign pair_csrbank0_kd0_re = ((pair_csrbank0_sel & pair_csrbank0_bus_we) & (pair_csrbank0_bus_adr[3:0] == 4'd10));
assign pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage = pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[24:0];
assign pair_csrbank0_setpoint3_w = pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[24];
assign pair_csrbank0_setpoint2_w = pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[23:16];
assign pair_csrbank0_setpoint1_w = pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[15:8];
assign pair_csrbank0_setpoint0_w = pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[7:0];
assign pair_mixeralignedpid0_mixeralignedpid0_kp_storage = pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full[13:0];
assign pair_csrbank0_kp1_w = pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full[13:8];
assign pair_csrbank0_kp0_w = pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full[7:0];
assign pair_mixeralignedpid0_mixeralignedpid0_ki_storage = pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full[13:0];
assign pair_csrbank0_ki1_w = pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full[13:8];
assign pair_csrbank0_ki0_w = pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full[7:0];
assign pair_mixeralignedpid0_mixeralignedpid0_reset_storage = pair_mixeralignedpid0_mixeralignedpid0_reset_storage_full;
assign pair_csrbank0_reset0_w = pair_mixeralignedpid0_mixeralignedpid0_reset_storage_full;
assign pair_mixeralignedpid0_mixeralignedpid0_kd_storage = pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full[13:0];
assign pair_csrbank0_kd1_w = pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full[13:8];
assign pair_csrbank0_kd0_w = pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full[7:0];
assign pair_feedbackinputalignment0_output = (pair_feedbackinputalignment0_mode_cohort ? (pair_feedbackinputalignment0_adc_cohort <<< 4'd11) : pair_feedbackinputalignment0_mixed_error);
assign pair_record1_adc_cdcs = 1'd1;
assign pair_record1_adc_clk = 2'd2;
assign pair_analog_adc_a = {pair_analog_adca[15], (~pair_analog_adca[14:2])};
assign pair_analog_adc_b = {pair_analog_adcb[15], (~pair_analog_adcb[14:2])};
assign pair_analog_select_b = (pair_analog_frame ^ pair_analog_frame_seen);
assign pair_analog_dac_word = (pair_analog_select_b ? pair_analog_dacb : pair_analog_daca);
assign pair_record1_dac_rst = dac_ready_rst;
assign dac_ready_clk = sys_clk;

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_mixeralignedpid1_mixeralignedpid1_error <= 26'sd0;
	if (pair_mixeralignedpid1_running_cohort) begin
		pair_mixeralignedpid1_mixeralignedpid1_error <= (pair_mixeralignedpid1_input - $signed({1'd0, pair_mixeralignedpid1_setpoint_cohort}));
	end else begin
		pair_mixeralignedpid1_mixeralignedpid1_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_mixeralignedpid1_mixeralignedpid1_output_p = (pair_mixeralignedpid1_mixeralignedpid1_kp_mult >>> 4'd12);
assign pair_mixeralignedpid1_mixeralignedpid1_int_sum = (pair_mixeralignedpid1_mixeralignedpid1_ki_mult + pair_mixeralignedpid1_mixeralignedpid1_int_reg);
assign pair_mixeralignedpid1_mixeralignedpid1_int_out = (pair_mixeralignedpid1_mixeralignedpid1_int_reg >>> 5'd18);
assign pair_mixeralignedpid1_mixeralignedpid10 = ((~pair_mixeralignedpid1_mixeralignedpid1_int_sum[43]) & (pair_mixeralignedpid1_mixeralignedpid1_int_sum[42] | ((pair_mixeralignedpid1_mixeralignedpid1_int_sum[41:18] == $signed({1'd0, 24'd16777215})) & (pair_mixeralignedpid1_mixeralignedpid1_int_sum[17:0] != $signed({1'd0, 1'd0})))));
assign pair_mixeralignedpid1_mixeralignedpid11 = (pair_mixeralignedpid1_mixeralignedpid1_int_sum[43] & ((~pair_mixeralignedpid1_mixeralignedpid1_int_sum[42]) | ((pair_mixeralignedpid1_mixeralignedpid1_int_sum[41:18] == $signed({1'd0, 1'd0})) & (pair_mixeralignedpid1_mixeralignedpid1_int_sum[17:0] != $signed({1'd0, 18'd262143})))));

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_mixeralignedpid1_mixeralignedpid1_pid_out <= 25'sd0;
	if (((~pair_mixeralignedpid1_mixeralignedpid1_pid_sum[83]) & (pair_mixeralignedpid1_mixeralignedpid1_pid_sum[83:24] != $signed({1'd0, 1'd0})))) begin
		pair_mixeralignedpid1_mixeralignedpid1_pid_out <= 24'd16777215;
	end else begin
		if ((pair_mixeralignedpid1_mixeralignedpid1_pid_sum[83] & (pair_mixeralignedpid1_mixeralignedpid1_pid_sum[83:24] != $signed({1'd0, 60'd1152921504606846975})))) begin
			pair_mixeralignedpid1_mixeralignedpid1_pid_out <= 25'sd16777216;
		end else begin
			pair_mixeralignedpid1_mixeralignedpid1_pid_out <= pair_mixeralignedpid1_mixeralignedpid1_pid_sum[24:0];
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_mixeralignedpid1_update_en0 = pair_mixeralignedpid16;
assign pair_limitcsr1_limit_x = pair_limitcsr1_x;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_limitcsr1_limit_y <= 19'sd0;
	pair_limitcsr1_limit_railed <= 1'd0;
	if ((pair_limitcsr1_limit_x >= pair_limitcsr1_limit_max)) begin
		pair_limitcsr1_limit_y <= pair_limitcsr1_limit_max;
		pair_limitcsr1_limit_railed <= 1'd1;
	end else begin
		if ((pair_limitcsr1_limit_x <= pair_limitcsr1_limit_min)) begin
			pair_limitcsr1_limit_y <= pair_limitcsr1_limit_min;
			pair_limitcsr1_limit_railed <= 1'd1;
		end else begin
			pair_limitcsr1_limit_y <= pair_limitcsr1_limit_x;
			pair_limitcsr1_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_csrbank1_sel = (pair_csrbank1_bus_adr[13:9] == 1'd0);
assign pair_csrbank1_setpoint3_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_setpoint3_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 1'd0));
assign pair_csrbank1_setpoint2_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_setpoint2_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 1'd1));
assign pair_csrbank1_setpoint1_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_setpoint1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 2'd2));
assign pair_csrbank1_setpoint0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_setpoint0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 2'd3));
assign pair_csrbank1_kp1_r = pair_csrbank1_bus_dat_w[5:0];
assign pair_csrbank1_kp1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 3'd4));
assign pair_csrbank1_kp0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_kp0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 3'd5));
assign pair_csrbank1_ki1_r = pair_csrbank1_bus_dat_w[5:0];
assign pair_csrbank1_ki1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 3'd6));
assign pair_csrbank1_ki0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_ki0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 3'd7));
assign pair_csrbank1_reset0_r = pair_csrbank1_bus_dat_w[0];
assign pair_csrbank1_reset0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 4'd8));
assign pair_csrbank1_kd1_r = pair_csrbank1_bus_dat_w[5:0];
assign pair_csrbank1_kd1_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 4'd9));
assign pair_csrbank1_kd0_r = pair_csrbank1_bus_dat_w[7:0];
assign pair_csrbank1_kd0_re = ((pair_csrbank1_sel & pair_csrbank1_bus_we) & (pair_csrbank1_bus_adr[3:0] == 4'd10));
assign pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage = pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[24:0];
assign pair_csrbank1_setpoint3_w = pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[24];
assign pair_csrbank1_setpoint2_w = pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[23:16];
assign pair_csrbank1_setpoint1_w = pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[15:8];
assign pair_csrbank1_setpoint0_w = pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[7:0];
assign pair_mixeralignedpid1_mixeralignedpid1_kp_storage = pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full[13:0];
assign pair_csrbank1_kp1_w = pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full[13:8];
assign pair_csrbank1_kp0_w = pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full[7:0];
assign pair_mixeralignedpid1_mixeralignedpid1_ki_storage = pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full[13:0];
assign pair_csrbank1_ki1_w = pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full[13:8];
assign pair_csrbank1_ki0_w = pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full[7:0];
assign pair_mixeralignedpid1_mixeralignedpid1_reset_storage = pair_mixeralignedpid1_mixeralignedpid1_reset_storage_full;
assign pair_csrbank1_reset0_w = pair_mixeralignedpid1_mixeralignedpid1_reset_storage_full;
assign pair_mixeralignedpid1_mixeralignedpid1_kd_storage = pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full[13:0];
assign pair_csrbank1_kd1_w = pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full[13:8];
assign pair_csrbank1_kd0_w = pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full[7:0];
assign pair_feedbackinputalignment1_output = (pair_feedbackinputalignment1_mode_cohort ? (pair_feedbackinputalignment1_adc_cohort <<< 4'd11) : pair_feedbackinputalignment1_mixed_error);
assign xilinxasyncresetsynchronizerimpl = (sys_rst | (~pair_analog_dacregionalclock_locked));

always @(posedge sys_clk) begin
	pair_limitcsr0_x <= (pair_mixeralignedpid0_mixeralignedpid0_pid_out >>> 4'd11);
	pair_limitcsr1_x <= (pair_mixeralignedpid1_mixeralignedpid1_pid_out >>> 4'd11);
	pair_pitayaanalog_daca <= {pair_pitayaanalog_dac_a[13], (~pair_pitayaanalog_dac_a[12:0])};
	pair_pitayaanalog_dacb <= {pair_pitayaanalog_dac_b[13], (~pair_pitayaanalog_dac_b[12:0])};
	pair_pitayaanalog_frame <= (~pair_pitayaanalog_frame);
	pair_mixeralignedpid0_mixeralignedpid0_kp_mult <= (pair_mixeralignedpid0_error_s1 * pair_mixeralignedpid00);
	pair_mixeralignedpid0_mixeralignedpid0_ki_mult <= ((pair_mixeralignedpid0_error_s1 * pair_mixeralignedpid01) >>> 3'd4);
	if (pair_mixeralignedpid0_update_en0) begin
		if (pair_mixeralignedpid04) begin
			pair_mixeralignedpid0_mixeralignedpid0_int_reg <= 1'd0;
		end else begin
			if (pair_mixeralignedpid0_mixeralignedpid00) begin
				pair_mixeralignedpid0_mixeralignedpid0_int_reg <= 42'd4398046248960;
			end else begin
				if (pair_mixeralignedpid0_mixeralignedpid01) begin
					pair_mixeralignedpid0_mixeralignedpid0_int_reg <= 43'sd4398046773247;
				end else begin
					pair_mixeralignedpid0_mixeralignedpid0_int_reg <= pair_mixeralignedpid0_mixeralignedpid0_int_sum;
				end
			end
		end
	end
	pair_mixeralignedpid0_mixeralignedpid0_kd_mult <= (pair_mixeralignedpid0_error_s1 * pair_mixeralignedpid02);
	if (pair_mixeralignedpid0_update_en0) begin
		pair_mixeralignedpid0_mixeralignedpid0_kd_reg <= (pair_mixeralignedpid0_mixeralignedpid0_kd_mult >>> 4'd8);
		pair_mixeralignedpid0_mixeralignedpid0_kd_reg_r <= pair_mixeralignedpid0_mixeralignedpid0_kd_reg;
		pair_mixeralignedpid0_mixeralignedpid0_output_d <= (pair_mixeralignedpid0_mixeralignedpid0_kd_reg - pair_mixeralignedpid0_mixeralignedpid0_kd_reg_r);
	end
	if (pair_mixeralignedpid0_update_en0) begin
		pair_mixeralignedpid0_mixeralignedpid0_pid_sum <= ((pair_mixeralignedpid0_mixeralignedpid0_output_p + pair_mixeralignedpid0_mixeralignedpid0_int_out) + pair_mixeralignedpid0_mixeralignedpid0_output_d);
	end
	pair_mixeralignedpid0_q0 <= pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage;
	pair_mixeralignedpid0_setpoint_cohort <= pair_mixeralignedpid0_q0;
	pair_mixeralignedpid0_q1 <= pair_mixeralignedpid0_running;
	pair_mixeralignedpid0_running_cohort <= pair_mixeralignedpid0_q1;
	pair_mixeralignedpid0_q2 <= pair_mixeralignedpid0_mixeralignedpid0_kp_storage;
	pair_mixeralignedpid07 <= pair_mixeralignedpid0_q2;
	pair_mixeralignedpid0_q3 <= pair_mixeralignedpid0_mixeralignedpid0_ki_storage;
	pair_mixeralignedpid08 <= pair_mixeralignedpid0_q3;
	pair_mixeralignedpid0_q4 <= pair_mixeralignedpid0_mixeralignedpid0_kd_storage;
	pair_mixeralignedpid09 <= pair_mixeralignedpid0_q4;
	pair_mixeralignedpid0_q5 <= pair_mixeralignedpid0_mixeralignedpid0_reset_storage;
	pair_mixeralignedpid010 <= pair_mixeralignedpid0_q5;
	pair_mixeralignedpid0_q6 <= pair_mixeralignedpid0_update_en1;
	pair_mixeralignedpid011 <= pair_mixeralignedpid0_q6;
	pair_mixeralignedpid05 <= pair_mixeralignedpid011;
	pair_mixeralignedpid06 <= pair_mixeralignedpid05;
	pair_mixeralignedpid0_error_s1 <= pair_mixeralignedpid0_mixeralignedpid0_error;
	pair_mixeralignedpid00 <= pair_mixeralignedpid07;
	pair_mixeralignedpid01 <= pair_mixeralignedpid08;
	pair_mixeralignedpid02 <= pair_mixeralignedpid09;
	pair_mixeralignedpid03 <= pair_mixeralignedpid010;
	pair_mixeralignedpid04 <= pair_mixeralignedpid03;
	if (pair_limitcsr0_update_en) begin
		pair_limitcsr0_limit_min <= {{5{pair_limitcsr0_min_storage[13]}}, pair_limitcsr0_min_storage};
		pair_limitcsr0_limit_max <= {{5{pair_limitcsr0_max_storage[13]}}, pair_limitcsr0_max_storage};
		pair_limitcsr0_limitcsr0_y <= pair_limitcsr0_limit_y;
		pair_limitcsr0_limitcsr0_error <= pair_limitcsr0_limit_railed;
	end
	pair_csrbank0_bus_dat_r <= 1'd0;
	if (pair_csrbank0_sel) begin
		case (pair_csrbank0_bus_adr[3:0])
			1'd0: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_setpoint3_w;
			end
			1'd1: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_setpoint2_w;
			end
			2'd2: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_setpoint1_w;
			end
			2'd3: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_setpoint0_w;
			end
			3'd4: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_kp1_w;
			end
			3'd5: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_kp0_w;
			end
			3'd6: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_ki1_w;
			end
			3'd7: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_ki0_w;
			end
			4'd8: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_reset0_w;
			end
			4'd9: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_kd1_w;
			end
			4'd10: begin
				pair_csrbank0_bus_dat_r <= pair_csrbank0_kd0_w;
			end
		endcase
	end
	if (pair_csrbank0_setpoint3_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[24] <= pair_csrbank0_setpoint3_r;
	end
	if (pair_csrbank0_setpoint2_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[23:16] <= pair_csrbank0_setpoint2_r;
	end
	if (pair_csrbank0_setpoint1_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[15:8] <= pair_csrbank0_setpoint1_r;
	end
	if (pair_csrbank0_setpoint0_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full[7:0] <= pair_csrbank0_setpoint0_r;
	end
	pair_mixeralignedpid0_mixeralignedpid0_setpoint_re <= pair_csrbank0_setpoint0_re;
	if (pair_csrbank0_kp1_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full[13:8] <= pair_csrbank0_kp1_r;
	end
	if (pair_csrbank0_kp0_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full[7:0] <= pair_csrbank0_kp0_r;
	end
	pair_mixeralignedpid0_mixeralignedpid0_kp_re <= pair_csrbank0_kp0_re;
	if (pair_csrbank0_ki1_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full[13:8] <= pair_csrbank0_ki1_r;
	end
	if (pair_csrbank0_ki0_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full[7:0] <= pair_csrbank0_ki0_r;
	end
	pair_mixeralignedpid0_mixeralignedpid0_ki_re <= pair_csrbank0_ki0_re;
	if (pair_csrbank0_reset0_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_reset_storage_full <= pair_csrbank0_reset0_r;
	end
	pair_mixeralignedpid0_mixeralignedpid0_reset_re <= pair_csrbank0_reset0_re;
	if (pair_csrbank0_kd1_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full[13:8] <= pair_csrbank0_kd1_r;
	end
	if (pair_csrbank0_kd0_re) begin
		pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full[7:0] <= pair_csrbank0_kd0_r;
	end
	pair_mixeralignedpid0_mixeralignedpid0_kd_re <= pair_csrbank0_kd0_re;
	pair_feedbackinputalignment0_q0 <= pair_feedbackinputalignment0_direct_adc;
	pair_feedbackinputalignment0_adc_cohort <= pair_feedbackinputalignment0_q0;
	pair_feedbackinputalignment0_q1 <= pair_feedbackinputalignment0_pid_only;
	pair_feedbackinputalignment0_mode_cohort <= pair_feedbackinputalignment0_q1;
	pair_feedbackinputalignment0_q2 <= pair_feedbackinputalignment0_limit_accept_en;
	pair_feedbackinputalignment0_limit_execute_en <= pair_feedbackinputalignment0_q2;
	pair_analog_daca <= {pair_analog_dac_a[13], (~pair_analog_dac_a[12:0])};
	pair_analog_dacb <= {pair_analog_dac_b[13], (~pair_analog_dac_b[12:0])};
	pair_analog_frame <= (~pair_analog_frame);
	pair_mixeralignedpid1_mixeralignedpid1_kp_mult <= (pair_mixeralignedpid1_error_s1 * pair_mixeralignedpid10);
	pair_mixeralignedpid1_mixeralignedpid1_ki_mult <= ((pair_mixeralignedpid1_error_s1 * pair_mixeralignedpid11) >>> 3'd4);
	if (pair_mixeralignedpid1_update_en0) begin
		if (pair_mixeralignedpid14) begin
			pair_mixeralignedpid1_mixeralignedpid1_int_reg <= 1'd0;
		end else begin
			if (pair_mixeralignedpid1_mixeralignedpid10) begin
				pair_mixeralignedpid1_mixeralignedpid1_int_reg <= 42'd4398046248960;
			end else begin
				if (pair_mixeralignedpid1_mixeralignedpid11) begin
					pair_mixeralignedpid1_mixeralignedpid1_int_reg <= 43'sd4398046773247;
				end else begin
					pair_mixeralignedpid1_mixeralignedpid1_int_reg <= pair_mixeralignedpid1_mixeralignedpid1_int_sum;
				end
			end
		end
	end
	pair_mixeralignedpid1_mixeralignedpid1_kd_mult <= (pair_mixeralignedpid1_error_s1 * pair_mixeralignedpid12);
	if (pair_mixeralignedpid1_update_en0) begin
		pair_mixeralignedpid1_mixeralignedpid1_kd_reg <= (pair_mixeralignedpid1_mixeralignedpid1_kd_mult >>> 4'd8);
		pair_mixeralignedpid1_mixeralignedpid1_kd_reg_r <= pair_mixeralignedpid1_mixeralignedpid1_kd_reg;
		pair_mixeralignedpid1_mixeralignedpid1_output_d <= (pair_mixeralignedpid1_mixeralignedpid1_kd_reg - pair_mixeralignedpid1_mixeralignedpid1_kd_reg_r);
	end
	if (pair_mixeralignedpid1_update_en0) begin
		pair_mixeralignedpid1_mixeralignedpid1_pid_sum <= ((pair_mixeralignedpid1_mixeralignedpid1_output_p + pair_mixeralignedpid1_mixeralignedpid1_int_out) + pair_mixeralignedpid1_mixeralignedpid1_output_d);
	end
	pair_mixeralignedpid1_q0 <= pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage;
	pair_mixeralignedpid1_setpoint_cohort <= pair_mixeralignedpid1_q0;
	pair_mixeralignedpid1_q1 <= pair_mixeralignedpid1_running;
	pair_mixeralignedpid1_running_cohort <= pair_mixeralignedpid1_q1;
	pair_mixeralignedpid1_q2 <= pair_mixeralignedpid1_mixeralignedpid1_kp_storage;
	pair_mixeralignedpid17 <= pair_mixeralignedpid1_q2;
	pair_mixeralignedpid1_q3 <= pair_mixeralignedpid1_mixeralignedpid1_ki_storage;
	pair_mixeralignedpid18 <= pair_mixeralignedpid1_q3;
	pair_mixeralignedpid1_q4 <= pair_mixeralignedpid1_mixeralignedpid1_kd_storage;
	pair_mixeralignedpid19 <= pair_mixeralignedpid1_q4;
	pair_mixeralignedpid1_q5 <= pair_mixeralignedpid1_mixeralignedpid1_reset_storage;
	pair_mixeralignedpid110 <= pair_mixeralignedpid1_q5;
	pair_mixeralignedpid1_q6 <= pair_mixeralignedpid1_update_en1;
	pair_mixeralignedpid111 <= pair_mixeralignedpid1_q6;
	pair_mixeralignedpid15 <= pair_mixeralignedpid111;
	pair_mixeralignedpid16 <= pair_mixeralignedpid15;
	pair_mixeralignedpid1_error_s1 <= pair_mixeralignedpid1_mixeralignedpid1_error;
	pair_mixeralignedpid10 <= pair_mixeralignedpid17;
	pair_mixeralignedpid11 <= pair_mixeralignedpid18;
	pair_mixeralignedpid12 <= pair_mixeralignedpid19;
	pair_mixeralignedpid13 <= pair_mixeralignedpid110;
	pair_mixeralignedpid14 <= pair_mixeralignedpid13;
	if (pair_limitcsr1_update_en) begin
		pair_limitcsr1_limit_min <= {{5{pair_limitcsr1_min_storage[13]}}, pair_limitcsr1_min_storage};
		pair_limitcsr1_limit_max <= {{5{pair_limitcsr1_max_storage[13]}}, pair_limitcsr1_max_storage};
		pair_limitcsr1_limitcsr1_y <= pair_limitcsr1_limit_y;
		pair_limitcsr1_limitcsr1_error <= pair_limitcsr1_limit_railed;
	end
	pair_csrbank1_bus_dat_r <= 1'd0;
	if (pair_csrbank1_sel) begin
		case (pair_csrbank1_bus_adr[3:0])
			1'd0: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_setpoint3_w;
			end
			1'd1: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_setpoint2_w;
			end
			2'd2: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_setpoint1_w;
			end
			2'd3: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_setpoint0_w;
			end
			3'd4: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_kp1_w;
			end
			3'd5: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_kp0_w;
			end
			3'd6: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_ki1_w;
			end
			3'd7: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_ki0_w;
			end
			4'd8: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_reset0_w;
			end
			4'd9: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_kd1_w;
			end
			4'd10: begin
				pair_csrbank1_bus_dat_r <= pair_csrbank1_kd0_w;
			end
		endcase
	end
	if (pair_csrbank1_setpoint3_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[24] <= pair_csrbank1_setpoint3_r;
	end
	if (pair_csrbank1_setpoint2_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[23:16] <= pair_csrbank1_setpoint2_r;
	end
	if (pair_csrbank1_setpoint1_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[15:8] <= pair_csrbank1_setpoint1_r;
	end
	if (pair_csrbank1_setpoint0_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full[7:0] <= pair_csrbank1_setpoint0_r;
	end
	pair_mixeralignedpid1_mixeralignedpid1_setpoint_re <= pair_csrbank1_setpoint0_re;
	if (pair_csrbank1_kp1_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full[13:8] <= pair_csrbank1_kp1_r;
	end
	if (pair_csrbank1_kp0_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full[7:0] <= pair_csrbank1_kp0_r;
	end
	pair_mixeralignedpid1_mixeralignedpid1_kp_re <= pair_csrbank1_kp0_re;
	if (pair_csrbank1_ki1_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full[13:8] <= pair_csrbank1_ki1_r;
	end
	if (pair_csrbank1_ki0_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full[7:0] <= pair_csrbank1_ki0_r;
	end
	pair_mixeralignedpid1_mixeralignedpid1_ki_re <= pair_csrbank1_ki0_re;
	if (pair_csrbank1_reset0_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_reset_storage_full <= pair_csrbank1_reset0_r;
	end
	pair_mixeralignedpid1_mixeralignedpid1_reset_re <= pair_csrbank1_reset0_re;
	if (pair_csrbank1_kd1_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full[13:8] <= pair_csrbank1_kd1_r;
	end
	if (pair_csrbank1_kd0_re) begin
		pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full[7:0] <= pair_csrbank1_kd0_r;
	end
	pair_mixeralignedpid1_mixeralignedpid1_kd_re <= pair_csrbank1_kd0_re;
	pair_feedbackinputalignment1_q0 <= pair_feedbackinputalignment1_direct_adc;
	pair_feedbackinputalignment1_adc_cohort <= pair_feedbackinputalignment1_q0;
	pair_feedbackinputalignment1_q1 <= pair_feedbackinputalignment1_pid_only;
	pair_feedbackinputalignment1_mode_cohort <= pair_feedbackinputalignment1_q1;
	pair_feedbackinputalignment1_q2 <= pair_feedbackinputalignment1_limit_accept_en;
	pair_feedbackinputalignment1_limit_execute_en <= pair_feedbackinputalignment1_q2;
	if (sys_rst) begin
		pair_pitayaanalog_daca <= 14'd0;
		pair_pitayaanalog_dacb <= 14'd0;
		pair_mixeralignedpid0_error_s1 <= 26'sd0;
		pair_mixeralignedpid00 <= 14'sd0;
		pair_mixeralignedpid01 <= 14'sd0;
		pair_mixeralignedpid02 <= 14'sd0;
		pair_mixeralignedpid03 <= 1'd0;
		pair_mixeralignedpid04 <= 1'd0;
		pair_mixeralignedpid05 <= 1'd0;
		pair_mixeralignedpid06 <= 1'd0;
		pair_mixeralignedpid0_setpoint_cohort <= 25'd0;
		pair_mixeralignedpid0_running_cohort <= 1'd0;
		pair_mixeralignedpid07 <= 14'd0;
		pair_mixeralignedpid08 <= 14'd0;
		pair_mixeralignedpid09 <= 14'd0;
		pair_mixeralignedpid010 <= 1'd0;
		pair_mixeralignedpid011 <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_storage_full <= 25'd0;
		pair_mixeralignedpid0_mixeralignedpid0_setpoint_re <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_kp_storage_full <= 14'd0;
		pair_mixeralignedpid0_mixeralignedpid0_kp_re <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_kp_mult <= 39'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_ki_storage_full <= 14'd0;
		pair_mixeralignedpid0_mixeralignedpid0_ki_re <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_reset_storage_full <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_reset_re <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_ki_mult <= 40'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_int_reg <= 43'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_kd_storage_full <= 14'd0;
		pair_mixeralignedpid0_mixeralignedpid0_kd_re <= 1'd0;
		pair_mixeralignedpid0_mixeralignedpid0_kd_mult <= 41'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_kd_reg <= 34'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_kd_reg_r <= 34'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_output_d <= 34'sd0;
		pair_mixeralignedpid0_mixeralignedpid0_pid_sum <= 84'sd0;
		pair_mixeralignedpid0_q0 <= 25'd0;
		pair_mixeralignedpid0_q1 <= 1'd0;
		pair_mixeralignedpid0_q2 <= 14'd0;
		pair_mixeralignedpid0_q3 <= 14'd0;
		pair_mixeralignedpid0_q4 <= 14'd0;
		pair_mixeralignedpid0_q5 <= 1'd0;
		pair_mixeralignedpid0_q6 <= 1'd0;
		pair_limitcsr0_limitcsr0_y <= 14'sd0;
		pair_limitcsr0_limitcsr0_error <= 1'd0;
		pair_limitcsr0_x <= 19'sd0;
		pair_limitcsr0_limit_max <= 19'sd0;
		pair_limitcsr0_limit_min <= 19'sd0;
		pair_csrbank0_bus_dat_r <= 8'd0;
		pair_feedbackinputalignment0_limit_execute_en <= 1'd0;
		pair_feedbackinputalignment0_adc_cohort <= 14'sd0;
		pair_feedbackinputalignment0_mode_cohort <= 1'd0;
		pair_feedbackinputalignment0_q0 <= 14'sd0;
		pair_feedbackinputalignment0_q1 <= 1'd0;
		pair_feedbackinputalignment0_q2 <= 1'd0;
		pair_analog_daca <= 14'd0;
		pair_analog_dacb <= 14'd0;
		pair_mixeralignedpid1_error_s1 <= 26'sd0;
		pair_mixeralignedpid10 <= 14'sd0;
		pair_mixeralignedpid11 <= 14'sd0;
		pair_mixeralignedpid12 <= 14'sd0;
		pair_mixeralignedpid13 <= 1'd0;
		pair_mixeralignedpid14 <= 1'd0;
		pair_mixeralignedpid15 <= 1'd0;
		pair_mixeralignedpid16 <= 1'd0;
		pair_mixeralignedpid1_setpoint_cohort <= 25'd0;
		pair_mixeralignedpid1_running_cohort <= 1'd0;
		pair_mixeralignedpid17 <= 14'd0;
		pair_mixeralignedpid18 <= 14'd0;
		pair_mixeralignedpid19 <= 14'd0;
		pair_mixeralignedpid110 <= 1'd0;
		pair_mixeralignedpid111 <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_storage_full <= 25'd0;
		pair_mixeralignedpid1_mixeralignedpid1_setpoint_re <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_kp_storage_full <= 14'd0;
		pair_mixeralignedpid1_mixeralignedpid1_kp_re <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_kp_mult <= 39'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_ki_storage_full <= 14'd0;
		pair_mixeralignedpid1_mixeralignedpid1_ki_re <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_reset_storage_full <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_reset_re <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_ki_mult <= 40'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_int_reg <= 43'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_kd_storage_full <= 14'd0;
		pair_mixeralignedpid1_mixeralignedpid1_kd_re <= 1'd0;
		pair_mixeralignedpid1_mixeralignedpid1_kd_mult <= 41'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_kd_reg <= 34'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_kd_reg_r <= 34'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_output_d <= 34'sd0;
		pair_mixeralignedpid1_mixeralignedpid1_pid_sum <= 84'sd0;
		pair_mixeralignedpid1_q0 <= 25'd0;
		pair_mixeralignedpid1_q1 <= 1'd0;
		pair_mixeralignedpid1_q2 <= 14'd0;
		pair_mixeralignedpid1_q3 <= 14'd0;
		pair_mixeralignedpid1_q4 <= 14'd0;
		pair_mixeralignedpid1_q5 <= 1'd0;
		pair_mixeralignedpid1_q6 <= 1'd0;
		pair_limitcsr1_limitcsr1_y <= 14'sd0;
		pair_limitcsr1_limitcsr1_error <= 1'd0;
		pair_limitcsr1_x <= 19'sd0;
		pair_limitcsr1_limit_max <= 19'sd0;
		pair_limitcsr1_limit_min <= 19'sd0;
		pair_csrbank1_bus_dat_r <= 8'd0;
		pair_feedbackinputalignment1_limit_execute_en <= 1'd0;
		pair_feedbackinputalignment1_adc_cohort <= 14'sd0;
		pair_feedbackinputalignment1_mode_cohort <= 1'd0;
		pair_feedbackinputalignment1_q0 <= 14'sd0;
		pair_feedbackinputalignment1_q1 <= 1'd0;
		pair_feedbackinputalignment1_q2 <= 1'd0;
	end
end

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[0]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_1 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[1]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[2]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[3]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_4 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[4]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_5 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[5]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_6 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[6]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_7 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[7]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_8 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[8]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_9 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[9]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_10 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[10]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_11 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[11]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_12 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[12]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_13 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[13]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_14 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[14]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_15 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_a[15]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_16 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[0]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_17 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[1]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_18 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[2]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_19 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[3]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_20 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[4]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_21 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[5]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_22 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[6]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_23 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[7]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_24 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[8]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_25 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[9]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_26 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[10]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_27 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[11]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_28 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[12]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_29 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[13]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_30 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[14]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_31 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record0_adc_data_b[15]),
	.R(sys_rst),
	.Q(pair_pitayaanalog_adcb[15])
);

FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_32 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_frame),
	.R(1'd0),
	.Q(pair_pitayaanalog_frame_seen)
);

ODDR ODDR(
	.C(dac_2p_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record0_dac_clk)
);

ODDR ODDR_1(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record0_dac_wrt)
);

ODDR ODDR_2(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record0_dac_sel)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_33 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[0]),
	.R(1'd0),
	.Q(pair_record0_dac_data[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_34 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[1]),
	.R(1'd0),
	.Q(pair_record0_dac_data[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_35 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[2]),
	.R(1'd0),
	.Q(pair_record0_dac_data[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_36 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[3]),
	.R(1'd0),
	.Q(pair_record0_dac_data[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_37 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[4]),
	.R(1'd0),
	.Q(pair_record0_dac_data[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_38 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[5]),
	.R(1'd0),
	.Q(pair_record0_dac_data[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_39 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[6]),
	.R(1'd0),
	.Q(pair_record0_dac_data[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_40 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[7]),
	.R(1'd0),
	.Q(pair_record0_dac_data[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_41 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[8]),
	.R(1'd0),
	.Q(pair_record0_dac_data[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_42 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[9]),
	.R(1'd0),
	.Q(pair_record0_dac_data[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_43 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[10]),
	.R(1'd0),
	.Q(pair_record0_dac_data[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_44 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[11]),
	.R(1'd0),
	.Q(pair_record0_dac_data[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_45 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[12]),
	.R(1'd0),
	.Q(pair_record0_dac_data[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_46 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_pitayaanalog_dac_word[13]),
	.R(1'd0),
	.Q(pair_record0_dac_data[13])
);

MMCME2_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKFBOUT_MULT_F(4.0),
	.CLKIN1_PERIOD(4.0),
	.CLKOUT0_DIVIDE_F(4.0),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_DIVIDE(3'd4),
	.CLKOUT1_PHASE(22.5),
	.CLKOUT2_DIVIDE(3'd4),
	.CLKOUT2_PHASE(-90.0),
	.CLKOUT3_DIVIDE(4'd8),
	.CLKOUT3_PHASE(28.125),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) MMCME2_BASE (
	.CLKFBIN(pair_analog_dacregionalclock_feedback),
	.CLKIN1(sys_double_clk),
	.PWRDWN(1'd0),
	.RST(sys_rst),
	.CLKFBOUT(pair_analog_dacregionalclock_feedback),
	.CLKOUT0(pair_analog_dacregionalclock0),
	.CLKOUT1(pair_analog_dacregionalclock1),
	.CLKOUT2(pair_analog_dacregionalclock2),
	.CLKOUT3(pair_analog_dacregionalclock3),
	.LOCKED(pair_analog_dacregionalclock_locked)
);

BUFIO BUFIO(
	.I(pair_analog_dacregionalclock0),
	.O(dac_io_clk)
);

BUFIO BUFIO_1(
	.I(pair_analog_dacregionalclock1),
	.O(dac_write_io_clk)
);

BUFIO BUFIO_2(
	.I(pair_analog_dacregionalclock2),
	.O(dac_sample_io_clk)
);

BUFIO BUFIO_3(
	.I(pair_analog_dacregionalclock3),
	.O(dac_select_io_clk)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_47 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[0]),
	.R(sys_rst),
	.Q(pair_analog_adca[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_48 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[1]),
	.R(sys_rst),
	.Q(pair_analog_adca[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_49 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[2]),
	.R(sys_rst),
	.Q(pair_analog_adca[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_50 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[3]),
	.R(sys_rst),
	.Q(pair_analog_adca[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_51 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[4]),
	.R(sys_rst),
	.Q(pair_analog_adca[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_52 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[5]),
	.R(sys_rst),
	.Q(pair_analog_adca[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_53 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[6]),
	.R(sys_rst),
	.Q(pair_analog_adca[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_54 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[7]),
	.R(sys_rst),
	.Q(pair_analog_adca[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_55 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[8]),
	.R(sys_rst),
	.Q(pair_analog_adca[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_56 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[9]),
	.R(sys_rst),
	.Q(pair_analog_adca[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_57 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[10]),
	.R(sys_rst),
	.Q(pair_analog_adca[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_58 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[11]),
	.R(sys_rst),
	.Q(pair_analog_adca[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_59 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[12]),
	.R(sys_rst),
	.Q(pair_analog_adca[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_60 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[13]),
	.R(sys_rst),
	.Q(pair_analog_adca[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_61 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[14]),
	.R(sys_rst),
	.Q(pair_analog_adca[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_62 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_a[15]),
	.R(sys_rst),
	.Q(pair_analog_adca[15])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_63 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[0]),
	.R(sys_rst),
	.Q(pair_analog_adcb[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_64 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[1]),
	.R(sys_rst),
	.Q(pair_analog_adcb[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_65 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[2]),
	.R(sys_rst),
	.Q(pair_analog_adcb[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_66 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[3]),
	.R(sys_rst),
	.Q(pair_analog_adcb[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_67 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[4]),
	.R(sys_rst),
	.Q(pair_analog_adcb[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_68 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[5]),
	.R(sys_rst),
	.Q(pair_analog_adcb[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_69 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[6]),
	.R(sys_rst),
	.Q(pair_analog_adcb[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_70 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[7]),
	.R(sys_rst),
	.Q(pair_analog_adcb[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_71 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[8]),
	.R(sys_rst),
	.Q(pair_analog_adcb[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_72 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[9]),
	.R(sys_rst),
	.Q(pair_analog_adcb[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_73 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[10]),
	.R(sys_rst),
	.Q(pair_analog_adcb[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_74 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[11]),
	.R(sys_rst),
	.Q(pair_analog_adcb[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_75 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[12]),
	.R(sys_rst),
	.Q(pair_analog_adcb[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_76 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[13]),
	.R(sys_rst),
	.Q(pair_analog_adcb[13])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_77 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[14]),
	.R(sys_rst),
	.Q(pair_analog_adcb[14])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_78 (
	.C(sys_clk),
	.CE(1'd1),
	.D(pair_record1_adc_data_b[15]),
	.R(sys_rst),
	.Q(pair_analog_adcb[15])
);

FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_79 (
	.C(sys_double_clk),
	.CE(1'd1),
	.D(pair_analog_frame),
	.R(1'd0),
	.Q(pair_analog_frame_seen)
);

ODDR ODDR_3(
	.C(dac_sample_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record1_dac_clk)
);

ODDR ODDR_4(
	.C(dac_write_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record1_dac_wrt)
);

ODDR ODDR_5(
	.C(dac_select_io_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(pair_record1_dac_sel)
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_80 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[0]),
	.R(1'd0),
	.Q(pair_record1_dac_data[0])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_81 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[1]),
	.R(1'd0),
	.Q(pair_record1_dac_data[1])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_82 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[2]),
	.R(1'd0),
	.Q(pair_record1_dac_data[2])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_83 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[3]),
	.R(1'd0),
	.Q(pair_record1_dac_data[3])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_84 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[4]),
	.R(1'd0),
	.Q(pair_record1_dac_data[4])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_85 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[5]),
	.R(1'd0),
	.Q(pair_record1_dac_data[5])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_86 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[6]),
	.R(1'd0),
	.Q(pair_record1_dac_data[6])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_87 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[7]),
	.R(1'd0),
	.Q(pair_record1_dac_data[7])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_88 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[8]),
	.R(1'd0),
	.Q(pair_record1_dac_data[8])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_89 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[9]),
	.R(1'd0),
	.Q(pair_record1_dac_data[9])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_90 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[10]),
	.R(1'd0),
	.Q(pair_record1_dac_data[10])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_91 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[11]),
	.R(1'd0),
	.Q(pair_record1_dac_data[11])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_92 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[12]),
	.R(1'd0),
	.Q(pair_record1_dac_data[12])
);

(* IOB = "TRUE" *) FDRE #(
	.INIT(1'd0),
	.IS_C_INVERTED(1'd0)
) FDRE_93 (
	.C(dac_io_clk),
	.CE(1'd1),
	.D(pair_analog_dac_word[13]),
	.R(1'd0),
	.Q(pair_record1_dac_data[13])
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE (
	.C(dac_ready_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl),
	.Q(xilinxasyncresetsynchronizerimpl_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_1 (
	.C(dac_ready_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl),
	.Q(dac_ready_rst)
);

endmodule
