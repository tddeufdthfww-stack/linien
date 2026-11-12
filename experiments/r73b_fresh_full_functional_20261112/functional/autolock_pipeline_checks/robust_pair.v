/* Machine-generated using Migen */
module robust_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] data,
	input request,
	input at_start,
	input writing,
	input sweep_up,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [93:0] ref_obs,
	output [1393:0] ref_cfg,
	output [7:0] ref_read,
	output [4:0] ref_idx,
	output ref_watch,
	output ref_turn,
	output [93:0] cand_obs,
	output [1393:0] cand_cfg,
	output [7:0] cand_read,
	output [4:0] cand_idx,
	output cand_watch,
	output cand_turn,
	output [1:0] cand_prefetch_choice
);

wire pair_reference_robust_restart0;
wire pair_reference_robust_writing_data_now0;
wire signed [13:0] pair_reference_robust_input0;
wire [13:0] pair_reference_robust_delay_value;
reg signed [27:0] pair_reference_robust_sum_value = 28'sd0;
wire signed [27:0] pair_reference_robust_delayed_sum;
wire signed [28:0] pair_reference_robust_current_sum_diff;
wire signed [28:0] pair_reference_robust_output0;
wire [12:0] pair_reference_robust_delay;
wire pair_reference_robust_restart1;
wire pair_reference_robust_writing_data_now1;
wire signed [27:0] pair_reference_robust_input1;
reg signed [27:0] pair_reference_robust_output1;
reg [12:0] pair_reference_robust_rdport_adr;
wire [27:0] pair_reference_robust_rdport_dat_r;
wire [12:0] pair_reference_robust_wrport_adr;
wire [27:0] pair_reference_robust_wrport_dat_r;
wire pair_reference_robust_wrport_we;
wire [27:0] pair_reference_robust_wrport_dat_w;
reg [12:0] pair_reference_robust_counter = 13'd0;
wire [12:0] pair_reference_robust_counter_delayed;
wire [13:0] pair_reference_robust_time_scale_storage;
wire [4:0] pair_reference_robust_N_instructions_storage;
wire [13:0] pair_reference_robust_final_wait_time_storage;
wire [27:0] pair_reference_robust_csrstorage_storage0;
wire [27:0] pair_reference_robust_csrstorage_storage1;
wire [27:0] pair_reference_robust_csrstorage_storage2;
wire [27:0] pair_reference_robust_csrstorage_storage3;
wire [27:0] pair_reference_robust_csrstorage_storage4;
wire [27:0] pair_reference_robust_csrstorage_storage5;
wire [27:0] pair_reference_robust_csrstorage_storage6;
wire [27:0] pair_reference_robust_csrstorage_storage7;
wire [27:0] pair_reference_robust_csrstorage_storage8;
wire [27:0] pair_reference_robust_csrstorage_storage9;
wire [27:0] pair_reference_robust_csrstorage_storage10;
wire [27:0] pair_reference_robust_csrstorage_storage11;
wire [27:0] pair_reference_robust_csrstorage_storage12;
wire [27:0] pair_reference_robust_csrstorage_storage13;
wire [27:0] pair_reference_robust_csrstorage_storage14;
wire [27:0] pair_reference_robust_csrstorage_storage15;
wire [27:0] pair_reference_robust_csrstorage_storage16;
wire [27:0] pair_reference_robust_csrstorage_storage17;
wire [27:0] pair_reference_robust_csrstorage_storage18;
wire [27:0] pair_reference_robust_csrstorage_storage19;
wire [27:0] pair_reference_robust_csrstorage_storage20;
wire [27:0] pair_reference_robust_csrstorage_storage21;
wire [27:0] pair_reference_robust_csrstorage_storage22;
wire [27:0] pair_reference_robust_csrstorage_storage23;
wire [27:0] pair_reference_robust_csrstorage_storage24;
wire [27:0] pair_reference_robust_csrstorage_storage25;
wire [27:0] pair_reference_robust_csrstorage_storage26;
wire [27:0] pair_reference_robust_csrstorage_storage27;
wire [27:0] pair_reference_robust_csrstorage_storage28;
wire [27:0] pair_reference_robust_csrstorage_storage29;
wire [27:0] pair_reference_robust_csrstorage_storage30;
wire [27:0] pair_reference_robust_csrstorage_storage31;
wire [13:0] pair_reference_robust_csrstorage_storage32;
wire [13:0] pair_reference_robust_csrstorage_storage33;
wire [13:0] pair_reference_robust_csrstorage_storage34;
wire [13:0] pair_reference_robust_csrstorage_storage35;
wire [13:0] pair_reference_robust_csrstorage_storage36;
wire [13:0] pair_reference_robust_csrstorage_storage37;
wire [13:0] pair_reference_robust_csrstorage_storage38;
wire [13:0] pair_reference_robust_csrstorage_storage39;
wire [13:0] pair_reference_robust_csrstorage_storage40;
wire [13:0] pair_reference_robust_csrstorage_storage41;
wire [13:0] pair_reference_robust_csrstorage_storage42;
wire [13:0] pair_reference_robust_csrstorage_storage43;
wire [13:0] pair_reference_robust_csrstorage_storage44;
wire [13:0] pair_reference_robust_csrstorage_storage45;
wire [13:0] pair_reference_robust_csrstorage_storage46;
wire [13:0] pair_reference_robust_csrstorage_storage47;
wire [13:0] pair_reference_robust_csrstorage_storage48;
wire [13:0] pair_reference_robust_csrstorage_storage49;
wire [13:0] pair_reference_robust_csrstorage_storage50;
wire [13:0] pair_reference_robust_csrstorage_storage51;
wire [13:0] pair_reference_robust_csrstorage_storage52;
wire [13:0] pair_reference_robust_csrstorage_storage53;
wire [13:0] pair_reference_robust_csrstorage_storage54;
wire [13:0] pair_reference_robust_csrstorage_storage55;
wire [13:0] pair_reference_robust_csrstorage_storage56;
wire [13:0] pair_reference_robust_csrstorage_storage57;
wire [13:0] pair_reference_robust_csrstorage_storage58;
wire [13:0] pair_reference_robust_csrstorage_storage59;
wire [13:0] pair_reference_robust_csrstorage_storage60;
wire [13:0] pair_reference_robust_csrstorage_storage61;
wire [13:0] pair_reference_robust_csrstorage_storage62;
wire [13:0] pair_reference_robust_csrstorage_storage63;
wire signed [13:0] pair_reference_robust_input2;
wire pair_reference_robust_request_lock;
wire pair_reference_robust_at_start;
wire pair_reference_robust_writing_data_now2;
wire pair_reference_robust_sweep_up;
wire pair_reference_robust_turn_on_lock;
reg pair_reference_robust_watching = 1'd0;
reg [4:0] pair_reference_robust_current_instruction_idx = 5'd0;
wire signed [27:0] pair_reference_robust_current_peak_height;
reg signed [27:0] pair_reference_robust_abs_current_peak_height;
wire [13:0] pair_reference_robust_current_wait_for;
reg [13:0] pair_reference_robust_waited_for = 14'd0;
reg [13:0] pair_reference_robust_final_waited_for = 14'd0;
wire signed [28:0] pair_reference_robust_sum_diff;
reg signed [28:0] pair_reference_robust_abs_sum_diff;
wire pair_reference_robust_sign_equal;
wire pair_reference_robust_over_threshold;
wire pair_reference_robust_waited_long_enough;
wire pair_reference_robust_all_instructions_triggered;
wire signed [13:0] pair_reference_robust_public0;
reg signed [13:0] pair_reference_robust_q0 = 14'sd0;
wire pair_reference_robust_public1;
reg pair_reference_robust_q1 = 1'd0;
wire pair_reference_robust_public2;
reg pair_reference_robust_q2 = 1'd0;
wire pair_reference_robust_public3;
reg pair_reference_robust_q3 = 1'd0;
wire pair_reference_robust_public4;
reg pair_reference_robust_q4 = 1'd0;
reg [13:0] pair_reference_robust_csrstorage0_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage0_storage;
reg pair_reference_robust_csrstorage0_re = 1'd0;
reg [13:0] pair_reference_robust_q5 = 14'd0;
reg [4:0] pair_reference_robust_csrstorage1_storage_full = 5'd0;
wire [4:0] pair_reference_robust_csrstorage1_storage;
reg pair_reference_robust_csrstorage1_re = 1'd0;
reg [4:0] pair_reference_robust_q6 = 5'd0;
reg [13:0] pair_reference_robust_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage2_storage;
reg pair_reference_robust_csrstorage2_re = 1'd0;
reg [13:0] pair_reference_robust_q7 = 14'd0;
reg [27:0] pair_reference_robust_csrstorage3_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage3_storage;
reg pair_reference_robust_csrstorage3_re = 1'd0;
reg [27:0] pair_reference_robust_q8 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage4_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage4_storage;
reg pair_reference_robust_csrstorage4_re = 1'd0;
reg [27:0] pair_reference_robust_q9 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage5_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage5_storage;
reg pair_reference_robust_csrstorage5_re = 1'd0;
reg [27:0] pair_reference_robust_q10 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage6_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage6_storage;
reg pair_reference_robust_csrstorage6_re = 1'd0;
reg [27:0] pair_reference_robust_q11 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage7_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage7_storage;
reg pair_reference_robust_csrstorage7_re = 1'd0;
reg [27:0] pair_reference_robust_q12 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage8_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage8_storage;
reg pair_reference_robust_csrstorage8_re = 1'd0;
reg [27:0] pair_reference_robust_q13 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage9_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage9_storage;
reg pair_reference_robust_csrstorage9_re = 1'd0;
reg [27:0] pair_reference_robust_q14 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage10_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage10_storage;
reg pair_reference_robust_csrstorage10_re = 1'd0;
reg [27:0] pair_reference_robust_q15 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage11_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage11_storage;
reg pair_reference_robust_csrstorage11_re = 1'd0;
reg [27:0] pair_reference_robust_q16 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage12_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage12_storage;
reg pair_reference_robust_csrstorage12_re = 1'd0;
reg [27:0] pair_reference_robust_q17 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage13_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage13_storage;
reg pair_reference_robust_csrstorage13_re = 1'd0;
reg [27:0] pair_reference_robust_q18 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage14_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage14_storage;
reg pair_reference_robust_csrstorage14_re = 1'd0;
reg [27:0] pair_reference_robust_q19 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage15_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage15_storage;
reg pair_reference_robust_csrstorage15_re = 1'd0;
reg [27:0] pair_reference_robust_q20 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage16_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage16_storage;
reg pair_reference_robust_csrstorage16_re = 1'd0;
reg [27:0] pair_reference_robust_q21 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage17_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage17_storage;
reg pair_reference_robust_csrstorage17_re = 1'd0;
reg [27:0] pair_reference_robust_q22 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage18_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage18_storage;
reg pair_reference_robust_csrstorage18_re = 1'd0;
reg [27:0] pair_reference_robust_q23 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage19_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage19_storage;
reg pair_reference_robust_csrstorage19_re = 1'd0;
reg [27:0] pair_reference_robust_q24 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage20_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage20_storage;
reg pair_reference_robust_csrstorage20_re = 1'd0;
reg [27:0] pair_reference_robust_q25 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage21_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage21_storage;
reg pair_reference_robust_csrstorage21_re = 1'd0;
reg [27:0] pair_reference_robust_q26 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage22_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage22_storage;
reg pair_reference_robust_csrstorage22_re = 1'd0;
reg [27:0] pair_reference_robust_q27 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage23_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage23_storage;
reg pair_reference_robust_csrstorage23_re = 1'd0;
reg [27:0] pair_reference_robust_q28 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage24_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage24_storage;
reg pair_reference_robust_csrstorage24_re = 1'd0;
reg [27:0] pair_reference_robust_q29 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage25_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage25_storage;
reg pair_reference_robust_csrstorage25_re = 1'd0;
reg [27:0] pair_reference_robust_q30 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage26_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage26_storage;
reg pair_reference_robust_csrstorage26_re = 1'd0;
reg [27:0] pair_reference_robust_q31 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage27_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage27_storage;
reg pair_reference_robust_csrstorage27_re = 1'd0;
reg [27:0] pair_reference_robust_q32 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage28_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage28_storage;
reg pair_reference_robust_csrstorage28_re = 1'd0;
reg [27:0] pair_reference_robust_q33 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage29_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage29_storage;
reg pair_reference_robust_csrstorage29_re = 1'd0;
reg [27:0] pair_reference_robust_q34 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage30_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage30_storage;
reg pair_reference_robust_csrstorage30_re = 1'd0;
reg [27:0] pair_reference_robust_q35 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage31_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage31_storage;
reg pair_reference_robust_csrstorage31_re = 1'd0;
reg [27:0] pair_reference_robust_q36 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage32_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage32_storage;
reg pair_reference_robust_csrstorage32_re = 1'd0;
reg [27:0] pair_reference_robust_q37 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage33_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage33_storage;
reg pair_reference_robust_csrstorage33_re = 1'd0;
reg [27:0] pair_reference_robust_q38 = 28'd0;
reg [27:0] pair_reference_robust_csrstorage34_storage_full = 28'd0;
wire [27:0] pair_reference_robust_csrstorage34_storage;
reg pair_reference_robust_csrstorage34_re = 1'd0;
reg [27:0] pair_reference_robust_q39 = 28'd0;
reg [13:0] pair_reference_robust_csrstorage35_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage35_storage;
reg pair_reference_robust_csrstorage35_re = 1'd0;
reg [13:0] pair_reference_robust_q40 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage36_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage36_storage;
reg pair_reference_robust_csrstorage36_re = 1'd0;
reg [13:0] pair_reference_robust_q41 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage37_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage37_storage;
reg pair_reference_robust_csrstorage37_re = 1'd0;
reg [13:0] pair_reference_robust_q42 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage38_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage38_storage;
reg pair_reference_robust_csrstorage38_re = 1'd0;
reg [13:0] pair_reference_robust_q43 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage39_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage39_storage;
reg pair_reference_robust_csrstorage39_re = 1'd0;
reg [13:0] pair_reference_robust_q44 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage40_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage40_storage;
reg pair_reference_robust_csrstorage40_re = 1'd0;
reg [13:0] pair_reference_robust_q45 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage41_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage41_storage;
reg pair_reference_robust_csrstorage41_re = 1'd0;
reg [13:0] pair_reference_robust_q46 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage42_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage42_storage;
reg pair_reference_robust_csrstorage42_re = 1'd0;
reg [13:0] pair_reference_robust_q47 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage43_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage43_storage;
reg pair_reference_robust_csrstorage43_re = 1'd0;
reg [13:0] pair_reference_robust_q48 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage44_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage44_storage;
reg pair_reference_robust_csrstorage44_re = 1'd0;
reg [13:0] pair_reference_robust_q49 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage45_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage45_storage;
reg pair_reference_robust_csrstorage45_re = 1'd0;
reg [13:0] pair_reference_robust_q50 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage46_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage46_storage;
reg pair_reference_robust_csrstorage46_re = 1'd0;
reg [13:0] pair_reference_robust_q51 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage47_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage47_storage;
reg pair_reference_robust_csrstorage47_re = 1'd0;
reg [13:0] pair_reference_robust_q52 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage48_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage48_storage;
reg pair_reference_robust_csrstorage48_re = 1'd0;
reg [13:0] pair_reference_robust_q53 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage49_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage49_storage;
reg pair_reference_robust_csrstorage49_re = 1'd0;
reg [13:0] pair_reference_robust_q54 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage50_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage50_storage;
reg pair_reference_robust_csrstorage50_re = 1'd0;
reg [13:0] pair_reference_robust_q55 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage51_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage51_storage;
reg pair_reference_robust_csrstorage51_re = 1'd0;
reg [13:0] pair_reference_robust_q56 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage52_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage52_storage;
reg pair_reference_robust_csrstorage52_re = 1'd0;
reg [13:0] pair_reference_robust_q57 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage53_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage53_storage;
reg pair_reference_robust_csrstorage53_re = 1'd0;
reg [13:0] pair_reference_robust_q58 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage54_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage54_storage;
reg pair_reference_robust_csrstorage54_re = 1'd0;
reg [13:0] pair_reference_robust_q59 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage55_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage55_storage;
reg pair_reference_robust_csrstorage55_re = 1'd0;
reg [13:0] pair_reference_robust_q60 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage56_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage56_storage;
reg pair_reference_robust_csrstorage56_re = 1'd0;
reg [13:0] pair_reference_robust_q61 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage57_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage57_storage;
reg pair_reference_robust_csrstorage57_re = 1'd0;
reg [13:0] pair_reference_robust_q62 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage58_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage58_storage;
reg pair_reference_robust_csrstorage58_re = 1'd0;
reg [13:0] pair_reference_robust_q63 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage59_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage59_storage;
reg pair_reference_robust_csrstorage59_re = 1'd0;
reg [13:0] pair_reference_robust_q64 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage60_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage60_storage;
reg pair_reference_robust_csrstorage60_re = 1'd0;
reg [13:0] pair_reference_robust_q65 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage61_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage61_storage;
reg pair_reference_robust_csrstorage61_re = 1'd0;
reg [13:0] pair_reference_robust_q66 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage62_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage62_storage;
reg pair_reference_robust_csrstorage62_re = 1'd0;
reg [13:0] pair_reference_robust_q67 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage63_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage63_storage;
reg pair_reference_robust_csrstorage63_re = 1'd0;
reg [13:0] pair_reference_robust_q68 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage64_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage64_storage;
reg pair_reference_robust_csrstorage64_re = 1'd0;
reg [13:0] pair_reference_robust_q69 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage65_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage65_storage;
reg pair_reference_robust_csrstorage65_re = 1'd0;
reg [13:0] pair_reference_robust_q70 = 14'd0;
reg [13:0] pair_reference_robust_csrstorage66_storage_full = 14'd0;
wire [13:0] pair_reference_robust_csrstorage66_storage;
reg pair_reference_robust_csrstorage66_re = 1'd0;
reg [13:0] pair_reference_robust_q71 = 14'd0;
wire pair_reference_fast_request_lock;
reg pair_reference_fast_turn_on_lock = 1'd0;
wire signed [13:0] pair_reference_fast_sweep_value;
wire [13:0] pair_reference_fast_sweep_step;
wire pair_reference_fast_sweep_up;
reg [13:0] pair_reference_fast_storage_full = 14'd0;
wire [13:0] pair_reference_fast_storage;
reg pair_reference_fast_re = 1'd0;
wire signed [13:0] pair_reference_fast_target_position_signed;
reg pair_reference_request_lock_storage_full = 1'd0;
wire pair_reference_request_lock_storage;
reg pair_reference_request_lock_re = 1'd0;
reg [1:0] pair_reference_autolock_mode_storage_full = 2'd0;
wire [1:0] pair_reference_autolock_mode_storage;
reg pair_reference_autolock_mode_re = 1'd0;
reg pair_reference_status = 1'd0;
wire pair_candidate_pipelinedrobustautolock_restart0;
wire pair_candidate_pipelinedrobustautolock_writing_data_now0;
wire signed [13:0] pair_candidate_pipelinedrobustautolock_input0;
wire [13:0] pair_candidate_pipelinedrobustautolock_delay_value;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_sum_value = 28'sd0;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_delayed_sum;
wire signed [28:0] pair_candidate_pipelinedrobustautolock_current_sum_diff;
wire signed [28:0] pair_candidate_pipelinedrobustautolock_output0;
wire [12:0] pair_candidate_pipelinedrobustautolock_delay;
wire pair_candidate_pipelinedrobustautolock_restart1;
wire pair_candidate_pipelinedrobustautolock_writing_data_now1;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_input1;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_output1;
reg [12:0] pair_candidate_pipelinedrobustautolock_rdport_adr;
wire [27:0] pair_candidate_pipelinedrobustautolock_rdport_dat_r;
wire [12:0] pair_candidate_pipelinedrobustautolock_wrport_adr;
wire [27:0] pair_candidate_pipelinedrobustautolock_wrport_dat_r;
wire pair_candidate_pipelinedrobustautolock_wrport_we;
wire [27:0] pair_candidate_pipelinedrobustautolock_wrport_dat_w;
reg [12:0] pair_candidate_pipelinedrobustautolock_counter = 13'd0;
wire [12:0] pair_candidate_pipelinedrobustautolock_counter_delayed;
reg [13:0] pair_candidate_pipelinedrobustautolock_time_scale_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_time_scale_storage;
reg pair_candidate_pipelinedrobustautolock_time_scale_re = 1'd0;
reg [4:0] pair_candidate_pipelinedrobustautolock_N_instructions_storage_full = 5'd0;
wire [4:0] pair_candidate_pipelinedrobustautolock_N_instructions_storage;
reg pair_candidate_pipelinedrobustautolock_N_instructions_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_final_wait_time_storage;
reg pair_candidate_pipelinedrobustautolock_final_wait_time_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage0_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage0_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage1_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage1_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage2_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage2_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage3_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage3_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage4_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage4_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage5_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage5_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage6_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage6_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage7_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage7_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage8_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage8_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage9_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage9_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage10_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage10_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage11_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage11_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage12_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage12_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage13_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage13_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage14_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage14_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage15_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage15_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage16_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage16_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage17_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage17_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage18_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage18_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage19_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage19_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage20_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage20_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage21_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage21_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage22_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage22_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage23_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage23_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage24_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage24_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage25_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage25_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage26_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage26_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage27_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage27_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage28_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage28_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage29_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage29_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage30_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage30_re = 1'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full = 28'd0;
wire [27:0] pair_candidate_pipelinedrobustautolock_csrstorage31_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage31_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage32_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage32_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage33_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage33_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage34_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage34_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage35_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage35_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage36_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage36_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage37_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage37_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage38_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage38_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage39_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage39_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage40_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage40_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage41_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage41_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage42_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage42_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage43_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage43_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage44_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage44_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage45_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage45_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage46_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage46_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage47_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage47_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage48_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage48_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage49_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage49_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage50_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage50_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage51_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage51_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage52_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage52_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage53_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage53_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage54_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage54_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage55_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage55_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage56_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage56_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage57_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage57_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage58_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage58_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage59_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage59_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage60_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage60_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage61_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage61_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage62_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage62_re = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full = 14'd0;
wire [13:0] pair_candidate_pipelinedrobustautolock_csrstorage63_storage;
reg pair_candidate_pipelinedrobustautolock_csrstorage63_re = 1'd0;
wire signed [13:0] pair_candidate_pipelinedrobustautolock_input2;
wire pair_candidate_pipelinedrobustautolock_request_lock;
wire pair_candidate_pipelinedrobustautolock_at_start;
wire pair_candidate_pipelinedrobustautolock_writing_data_now2;
wire pair_candidate_pipelinedrobustautolock_sweep_up;
wire pair_candidate_pipelinedrobustautolock_turn_on_lock;
reg pair_candidate_pipelinedrobustautolock0 = 1'd0;
reg pair_candidate_pipelinedrobustautolock1 = 1'd0;
reg pair_candidate_pipelinedrobustautolock2 = 1'd0;
reg pair_candidate_pipelinedrobustautolock3 = 1'd0;
reg signed [28:0] pair_candidate_pipelinedrobustautolock_sum_diff_s1 = 29'sd0;
reg [4:0] pair_candidate_pipelinedrobustautolock_n_instructions_s1 = 5'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_final_wait_s1 = 14'd0;
wire pair_candidate_pipelinedrobustautolock_current_peak_positive;
reg [4:0] pair_candidate_pipelinedrobustautolock_current_instruction_idx = 5'd0;
wire pair_candidate_pipelinedrobustautolock_prefetch_advance;
reg [1:0] pair_candidate_pipelinedrobustautolock_prefetch_choice = 2'd0;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_current_signed;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_absolute0;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_negative_low0;
wire pair_candidate_pipelinedrobustautolock_negative_sign0;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_current_magnitude = 28'sd0;
reg signed [28:0] pair_candidate_pipelinedrobustautolock_prefetch_current_negative = 29'sd0;
reg pair_candidate_pipelinedrobustautolock_prefetch_current_positive = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_prefetch_current_wait = 14'd0;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_next_signed;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_absolute1;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_negative_low1;
wire pair_candidate_pipelinedrobustautolock_negative_sign1;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_next_magnitude = 28'sd0;
reg signed [28:0] pair_candidate_pipelinedrobustautolock_prefetch_next_negative = 29'sd0;
reg pair_candidate_pipelinedrobustautolock_prefetch_next_positive = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_prefetch_next_wait = 14'd0;
reg [27:0] pair_candidate_pipelinedrobustautolock_result0;
reg [13:0] pair_candidate_pipelinedrobustautolock_result1;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_zero_signed;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_absolute2;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_negative_low2;
wire pair_candidate_pipelinedrobustautolock_negative_sign2;
reg signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_zero_magnitude = 28'sd0;
reg signed [28:0] pair_candidate_pipelinedrobustautolock_prefetch_zero_negative = 29'sd0;
reg pair_candidate_pipelinedrobustautolock_prefetch_zero_positive = 1'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_prefetch_zero_wait = 14'd0;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_prefetch_selected_magnitude;
wire signed [28:0] pair_candidate_pipelinedrobustautolock_prefetch_selected_negative;
wire pair_candidate_pipelinedrobustautolock_prefetch_selected_positive;
wire [13:0] pair_candidate_pipelinedrobustautolock_prefetch_selected_wait;
reg pair_candidate_pipelinedrobustautolock_watching = 1'd0;
wire signed [27:0] pair_candidate_pipelinedrobustautolock_abs_current_peak_height;
wire signed [28:0] pair_candidate_pipelinedrobustautolock_negative_current_peak_height;
wire [13:0] pair_candidate_pipelinedrobustautolock_current_wait_for;
reg [13:0] pair_candidate_pipelinedrobustautolock_waited_for = 14'd0;
reg [13:0] pair_candidate_pipelinedrobustautolock_final_waited_for = 14'd0;
wire signed [28:0] pair_candidate_pipelinedrobustautolock_sum_diff;
reg signed [28:0] pair_candidate_pipelinedrobustautolock_abs_sum_diff;
wire pair_candidate_pipelinedrobustautolock_sign_equal;
wire pair_candidate_pipelinedrobustautolock_over_threshold;
wire pair_candidate_pipelinedrobustautolock_waited_long_enough;
wire pair_candidate_pipelinedrobustautolock_all_instructions_triggered;
wire pair_candidate_fast_request_lock;
reg pair_candidate_fast_turn_on_lock = 1'd0;
wire signed [13:0] pair_candidate_fast_sweep_value;
wire [13:0] pair_candidate_fast_sweep_step;
wire pair_candidate_fast_sweep_up;
reg [13:0] pair_candidate_fast_storage_full = 14'd0;
wire [13:0] pair_candidate_fast_storage;
reg pair_candidate_fast_re = 1'd0;
wire signed [13:0] pair_candidate_fast_target_position_signed;
reg pair_candidate_request_lock_storage_full = 1'd0;
wire pair_candidate_request_lock_storage;
reg pair_candidate_request_lock_re = 1'd0;
reg [1:0] pair_candidate_autolock_mode_storage_full = 2'd0;
wire [1:0] pair_candidate_autolock_mode_storage;
reg pair_candidate_autolock_mode_re = 1'd0;
reg pair_candidate_status = 1'd0;
wire [13:0] pair_rb_bus_adr;
wire pair_rb_bus_we;
wire [7:0] pair_rb_bus_dat_w;
reg [7:0] pair_rb_bus_dat_r = 8'd0;
wire pair_rb_robust_time_scale1_re;
wire [5:0] pair_rb_robust_time_scale1_r;
wire [5:0] pair_rb_robust_time_scale1_w;
wire pair_rb_robust_time_scale0_re;
wire [7:0] pair_rb_robust_time_scale0_r;
wire [7:0] pair_rb_robust_time_scale0_w;
wire pair_rb_robust_N_instructions0_re;
wire [4:0] pair_rb_robust_N_instructions0_r;
wire [4:0] pair_rb_robust_N_instructions0_w;
wire pair_rb_robust_final_wait_time1_re;
wire [5:0] pair_rb_robust_final_wait_time1_r;
wire [5:0] pair_rb_robust_final_wait_time1_w;
wire pair_rb_robust_final_wait_time0_re;
wire [7:0] pair_rb_robust_final_wait_time0_r;
wire [7:0] pair_rb_robust_final_wait_time0_w;
wire pair_rb_robust_peak_height_03_re;
wire [3:0] pair_rb_robust_peak_height_03_r;
wire [3:0] pair_rb_robust_peak_height_03_w;
wire pair_rb_robust_peak_height_02_re;
wire [7:0] pair_rb_robust_peak_height_02_r;
wire [7:0] pair_rb_robust_peak_height_02_w;
wire pair_rb_robust_peak_height_01_re;
wire [7:0] pair_rb_robust_peak_height_01_r;
wire [7:0] pair_rb_robust_peak_height_01_w;
wire pair_rb_robust_peak_height_00_re;
wire [7:0] pair_rb_robust_peak_height_00_r;
wire [7:0] pair_rb_robust_peak_height_00_w;
wire pair_rb_robust_peak_height_13_re;
wire [3:0] pair_rb_robust_peak_height_13_r;
wire [3:0] pair_rb_robust_peak_height_13_w;
wire pair_rb_robust_peak_height_12_re;
wire [7:0] pair_rb_robust_peak_height_12_r;
wire [7:0] pair_rb_robust_peak_height_12_w;
wire pair_rb_robust_peak_height_11_re;
wire [7:0] pair_rb_robust_peak_height_11_r;
wire [7:0] pair_rb_robust_peak_height_11_w;
wire pair_rb_robust_peak_height_10_re;
wire [7:0] pair_rb_robust_peak_height_10_r;
wire [7:0] pair_rb_robust_peak_height_10_w;
wire pair_rb_robust_peak_height_23_re;
wire [3:0] pair_rb_robust_peak_height_23_r;
wire [3:0] pair_rb_robust_peak_height_23_w;
wire pair_rb_robust_peak_height_22_re;
wire [7:0] pair_rb_robust_peak_height_22_r;
wire [7:0] pair_rb_robust_peak_height_22_w;
wire pair_rb_robust_peak_height_21_re;
wire [7:0] pair_rb_robust_peak_height_21_r;
wire [7:0] pair_rb_robust_peak_height_21_w;
wire pair_rb_robust_peak_height_20_re;
wire [7:0] pair_rb_robust_peak_height_20_r;
wire [7:0] pair_rb_robust_peak_height_20_w;
wire pair_rb_robust_peak_height_33_re;
wire [3:0] pair_rb_robust_peak_height_33_r;
wire [3:0] pair_rb_robust_peak_height_33_w;
wire pair_rb_robust_peak_height_32_re;
wire [7:0] pair_rb_robust_peak_height_32_r;
wire [7:0] pair_rb_robust_peak_height_32_w;
wire pair_rb_robust_peak_height_31_re;
wire [7:0] pair_rb_robust_peak_height_31_r;
wire [7:0] pair_rb_robust_peak_height_31_w;
wire pair_rb_robust_peak_height_30_re;
wire [7:0] pair_rb_robust_peak_height_30_r;
wire [7:0] pair_rb_robust_peak_height_30_w;
wire pair_rb_robust_peak_height_43_re;
wire [3:0] pair_rb_robust_peak_height_43_r;
wire [3:0] pair_rb_robust_peak_height_43_w;
wire pair_rb_robust_peak_height_42_re;
wire [7:0] pair_rb_robust_peak_height_42_r;
wire [7:0] pair_rb_robust_peak_height_42_w;
wire pair_rb_robust_peak_height_41_re;
wire [7:0] pair_rb_robust_peak_height_41_r;
wire [7:0] pair_rb_robust_peak_height_41_w;
wire pair_rb_robust_peak_height_40_re;
wire [7:0] pair_rb_robust_peak_height_40_r;
wire [7:0] pair_rb_robust_peak_height_40_w;
wire pair_rb_robust_peak_height_53_re;
wire [3:0] pair_rb_robust_peak_height_53_r;
wire [3:0] pair_rb_robust_peak_height_53_w;
wire pair_rb_robust_peak_height_52_re;
wire [7:0] pair_rb_robust_peak_height_52_r;
wire [7:0] pair_rb_robust_peak_height_52_w;
wire pair_rb_robust_peak_height_51_re;
wire [7:0] pair_rb_robust_peak_height_51_r;
wire [7:0] pair_rb_robust_peak_height_51_w;
wire pair_rb_robust_peak_height_50_re;
wire [7:0] pair_rb_robust_peak_height_50_r;
wire [7:0] pair_rb_robust_peak_height_50_w;
wire pair_rb_robust_peak_height_63_re;
wire [3:0] pair_rb_robust_peak_height_63_r;
wire [3:0] pair_rb_robust_peak_height_63_w;
wire pair_rb_robust_peak_height_62_re;
wire [7:0] pair_rb_robust_peak_height_62_r;
wire [7:0] pair_rb_robust_peak_height_62_w;
wire pair_rb_robust_peak_height_61_re;
wire [7:0] pair_rb_robust_peak_height_61_r;
wire [7:0] pair_rb_robust_peak_height_61_w;
wire pair_rb_robust_peak_height_60_re;
wire [7:0] pair_rb_robust_peak_height_60_r;
wire [7:0] pair_rb_robust_peak_height_60_w;
wire pair_rb_robust_peak_height_73_re;
wire [3:0] pair_rb_robust_peak_height_73_r;
wire [3:0] pair_rb_robust_peak_height_73_w;
wire pair_rb_robust_peak_height_72_re;
wire [7:0] pair_rb_robust_peak_height_72_r;
wire [7:0] pair_rb_robust_peak_height_72_w;
wire pair_rb_robust_peak_height_71_re;
wire [7:0] pair_rb_robust_peak_height_71_r;
wire [7:0] pair_rb_robust_peak_height_71_w;
wire pair_rb_robust_peak_height_70_re;
wire [7:0] pair_rb_robust_peak_height_70_r;
wire [7:0] pair_rb_robust_peak_height_70_w;
wire pair_rb_robust_peak_height_83_re;
wire [3:0] pair_rb_robust_peak_height_83_r;
wire [3:0] pair_rb_robust_peak_height_83_w;
wire pair_rb_robust_peak_height_82_re;
wire [7:0] pair_rb_robust_peak_height_82_r;
wire [7:0] pair_rb_robust_peak_height_82_w;
wire pair_rb_robust_peak_height_81_re;
wire [7:0] pair_rb_robust_peak_height_81_r;
wire [7:0] pair_rb_robust_peak_height_81_w;
wire pair_rb_robust_peak_height_80_re;
wire [7:0] pair_rb_robust_peak_height_80_r;
wire [7:0] pair_rb_robust_peak_height_80_w;
wire pair_rb_robust_peak_height_93_re;
wire [3:0] pair_rb_robust_peak_height_93_r;
wire [3:0] pair_rb_robust_peak_height_93_w;
wire pair_rb_robust_peak_height_92_re;
wire [7:0] pair_rb_robust_peak_height_92_r;
wire [7:0] pair_rb_robust_peak_height_92_w;
wire pair_rb_robust_peak_height_91_re;
wire [7:0] pair_rb_robust_peak_height_91_r;
wire [7:0] pair_rb_robust_peak_height_91_w;
wire pair_rb_robust_peak_height_90_re;
wire [7:0] pair_rb_robust_peak_height_90_r;
wire [7:0] pair_rb_robust_peak_height_90_w;
wire pair_rb_robust_peak_height_103_re;
wire [3:0] pair_rb_robust_peak_height_103_r;
wire [3:0] pair_rb_robust_peak_height_103_w;
wire pair_rb_robust_peak_height_102_re;
wire [7:0] pair_rb_robust_peak_height_102_r;
wire [7:0] pair_rb_robust_peak_height_102_w;
wire pair_rb_robust_peak_height_101_re;
wire [7:0] pair_rb_robust_peak_height_101_r;
wire [7:0] pair_rb_robust_peak_height_101_w;
wire pair_rb_robust_peak_height_100_re;
wire [7:0] pair_rb_robust_peak_height_100_r;
wire [7:0] pair_rb_robust_peak_height_100_w;
wire pair_rb_robust_peak_height_113_re;
wire [3:0] pair_rb_robust_peak_height_113_r;
wire [3:0] pair_rb_robust_peak_height_113_w;
wire pair_rb_robust_peak_height_112_re;
wire [7:0] pair_rb_robust_peak_height_112_r;
wire [7:0] pair_rb_robust_peak_height_112_w;
wire pair_rb_robust_peak_height_111_re;
wire [7:0] pair_rb_robust_peak_height_111_r;
wire [7:0] pair_rb_robust_peak_height_111_w;
wire pair_rb_robust_peak_height_110_re;
wire [7:0] pair_rb_robust_peak_height_110_r;
wire [7:0] pair_rb_robust_peak_height_110_w;
wire pair_rb_robust_peak_height_123_re;
wire [3:0] pair_rb_robust_peak_height_123_r;
wire [3:0] pair_rb_robust_peak_height_123_w;
wire pair_rb_robust_peak_height_122_re;
wire [7:0] pair_rb_robust_peak_height_122_r;
wire [7:0] pair_rb_robust_peak_height_122_w;
wire pair_rb_robust_peak_height_121_re;
wire [7:0] pair_rb_robust_peak_height_121_r;
wire [7:0] pair_rb_robust_peak_height_121_w;
wire pair_rb_robust_peak_height_120_re;
wire [7:0] pair_rb_robust_peak_height_120_r;
wire [7:0] pair_rb_robust_peak_height_120_w;
wire pair_rb_robust_peak_height_133_re;
wire [3:0] pair_rb_robust_peak_height_133_r;
wire [3:0] pair_rb_robust_peak_height_133_w;
wire pair_rb_robust_peak_height_132_re;
wire [7:0] pair_rb_robust_peak_height_132_r;
wire [7:0] pair_rb_robust_peak_height_132_w;
wire pair_rb_robust_peak_height_131_re;
wire [7:0] pair_rb_robust_peak_height_131_r;
wire [7:0] pair_rb_robust_peak_height_131_w;
wire pair_rb_robust_peak_height_130_re;
wire [7:0] pair_rb_robust_peak_height_130_r;
wire [7:0] pair_rb_robust_peak_height_130_w;
wire pair_rb_robust_peak_height_143_re;
wire [3:0] pair_rb_robust_peak_height_143_r;
wire [3:0] pair_rb_robust_peak_height_143_w;
wire pair_rb_robust_peak_height_142_re;
wire [7:0] pair_rb_robust_peak_height_142_r;
wire [7:0] pair_rb_robust_peak_height_142_w;
wire pair_rb_robust_peak_height_141_re;
wire [7:0] pair_rb_robust_peak_height_141_r;
wire [7:0] pair_rb_robust_peak_height_141_w;
wire pair_rb_robust_peak_height_140_re;
wire [7:0] pair_rb_robust_peak_height_140_r;
wire [7:0] pair_rb_robust_peak_height_140_w;
wire pair_rb_robust_peak_height_153_re;
wire [3:0] pair_rb_robust_peak_height_153_r;
wire [3:0] pair_rb_robust_peak_height_153_w;
wire pair_rb_robust_peak_height_152_re;
wire [7:0] pair_rb_robust_peak_height_152_r;
wire [7:0] pair_rb_robust_peak_height_152_w;
wire pair_rb_robust_peak_height_151_re;
wire [7:0] pair_rb_robust_peak_height_151_r;
wire [7:0] pair_rb_robust_peak_height_151_w;
wire pair_rb_robust_peak_height_150_re;
wire [7:0] pair_rb_robust_peak_height_150_r;
wire [7:0] pair_rb_robust_peak_height_150_w;
wire pair_rb_robust_peak_height_163_re;
wire [3:0] pair_rb_robust_peak_height_163_r;
wire [3:0] pair_rb_robust_peak_height_163_w;
wire pair_rb_robust_peak_height_162_re;
wire [7:0] pair_rb_robust_peak_height_162_r;
wire [7:0] pair_rb_robust_peak_height_162_w;
wire pair_rb_robust_peak_height_161_re;
wire [7:0] pair_rb_robust_peak_height_161_r;
wire [7:0] pair_rb_robust_peak_height_161_w;
wire pair_rb_robust_peak_height_160_re;
wire [7:0] pair_rb_robust_peak_height_160_r;
wire [7:0] pair_rb_robust_peak_height_160_w;
wire pair_rb_robust_peak_height_173_re;
wire [3:0] pair_rb_robust_peak_height_173_r;
wire [3:0] pair_rb_robust_peak_height_173_w;
wire pair_rb_robust_peak_height_172_re;
wire [7:0] pair_rb_robust_peak_height_172_r;
wire [7:0] pair_rb_robust_peak_height_172_w;
wire pair_rb_robust_peak_height_171_re;
wire [7:0] pair_rb_robust_peak_height_171_r;
wire [7:0] pair_rb_robust_peak_height_171_w;
wire pair_rb_robust_peak_height_170_re;
wire [7:0] pair_rb_robust_peak_height_170_r;
wire [7:0] pair_rb_robust_peak_height_170_w;
wire pair_rb_robust_peak_height_183_re;
wire [3:0] pair_rb_robust_peak_height_183_r;
wire [3:0] pair_rb_robust_peak_height_183_w;
wire pair_rb_robust_peak_height_182_re;
wire [7:0] pair_rb_robust_peak_height_182_r;
wire [7:0] pair_rb_robust_peak_height_182_w;
wire pair_rb_robust_peak_height_181_re;
wire [7:0] pair_rb_robust_peak_height_181_r;
wire [7:0] pair_rb_robust_peak_height_181_w;
wire pair_rb_robust_peak_height_180_re;
wire [7:0] pair_rb_robust_peak_height_180_r;
wire [7:0] pair_rb_robust_peak_height_180_w;
wire pair_rb_robust_peak_height_193_re;
wire [3:0] pair_rb_robust_peak_height_193_r;
wire [3:0] pair_rb_robust_peak_height_193_w;
wire pair_rb_robust_peak_height_192_re;
wire [7:0] pair_rb_robust_peak_height_192_r;
wire [7:0] pair_rb_robust_peak_height_192_w;
wire pair_rb_robust_peak_height_191_re;
wire [7:0] pair_rb_robust_peak_height_191_r;
wire [7:0] pair_rb_robust_peak_height_191_w;
wire pair_rb_robust_peak_height_190_re;
wire [7:0] pair_rb_robust_peak_height_190_r;
wire [7:0] pair_rb_robust_peak_height_190_w;
wire pair_rb_robust_peak_height_203_re;
wire [3:0] pair_rb_robust_peak_height_203_r;
wire [3:0] pair_rb_robust_peak_height_203_w;
wire pair_rb_robust_peak_height_202_re;
wire [7:0] pair_rb_robust_peak_height_202_r;
wire [7:0] pair_rb_robust_peak_height_202_w;
wire pair_rb_robust_peak_height_201_re;
wire [7:0] pair_rb_robust_peak_height_201_r;
wire [7:0] pair_rb_robust_peak_height_201_w;
wire pair_rb_robust_peak_height_200_re;
wire [7:0] pair_rb_robust_peak_height_200_r;
wire [7:0] pair_rb_robust_peak_height_200_w;
wire pair_rb_robust_peak_height_213_re;
wire [3:0] pair_rb_robust_peak_height_213_r;
wire [3:0] pair_rb_robust_peak_height_213_w;
wire pair_rb_robust_peak_height_212_re;
wire [7:0] pair_rb_robust_peak_height_212_r;
wire [7:0] pair_rb_robust_peak_height_212_w;
wire pair_rb_robust_peak_height_211_re;
wire [7:0] pair_rb_robust_peak_height_211_r;
wire [7:0] pair_rb_robust_peak_height_211_w;
wire pair_rb_robust_peak_height_210_re;
wire [7:0] pair_rb_robust_peak_height_210_r;
wire [7:0] pair_rb_robust_peak_height_210_w;
wire pair_rb_robust_peak_height_223_re;
wire [3:0] pair_rb_robust_peak_height_223_r;
wire [3:0] pair_rb_robust_peak_height_223_w;
wire pair_rb_robust_peak_height_222_re;
wire [7:0] pair_rb_robust_peak_height_222_r;
wire [7:0] pair_rb_robust_peak_height_222_w;
wire pair_rb_robust_peak_height_221_re;
wire [7:0] pair_rb_robust_peak_height_221_r;
wire [7:0] pair_rb_robust_peak_height_221_w;
wire pair_rb_robust_peak_height_220_re;
wire [7:0] pair_rb_robust_peak_height_220_r;
wire [7:0] pair_rb_robust_peak_height_220_w;
wire pair_rb_robust_peak_height_233_re;
wire [3:0] pair_rb_robust_peak_height_233_r;
wire [3:0] pair_rb_robust_peak_height_233_w;
wire pair_rb_robust_peak_height_232_re;
wire [7:0] pair_rb_robust_peak_height_232_r;
wire [7:0] pair_rb_robust_peak_height_232_w;
wire pair_rb_robust_peak_height_231_re;
wire [7:0] pair_rb_robust_peak_height_231_r;
wire [7:0] pair_rb_robust_peak_height_231_w;
wire pair_rb_robust_peak_height_230_re;
wire [7:0] pair_rb_robust_peak_height_230_r;
wire [7:0] pair_rb_robust_peak_height_230_w;
wire pair_rb_robust_peak_height_243_re;
wire [3:0] pair_rb_robust_peak_height_243_r;
wire [3:0] pair_rb_robust_peak_height_243_w;
wire pair_rb_robust_peak_height_242_re;
wire [7:0] pair_rb_robust_peak_height_242_r;
wire [7:0] pair_rb_robust_peak_height_242_w;
wire pair_rb_robust_peak_height_241_re;
wire [7:0] pair_rb_robust_peak_height_241_r;
wire [7:0] pair_rb_robust_peak_height_241_w;
wire pair_rb_robust_peak_height_240_re;
wire [7:0] pair_rb_robust_peak_height_240_r;
wire [7:0] pair_rb_robust_peak_height_240_w;
wire pair_rb_robust_peak_height_253_re;
wire [3:0] pair_rb_robust_peak_height_253_r;
wire [3:0] pair_rb_robust_peak_height_253_w;
wire pair_rb_robust_peak_height_252_re;
wire [7:0] pair_rb_robust_peak_height_252_r;
wire [7:0] pair_rb_robust_peak_height_252_w;
wire pair_rb_robust_peak_height_251_re;
wire [7:0] pair_rb_robust_peak_height_251_r;
wire [7:0] pair_rb_robust_peak_height_251_w;
wire pair_rb_robust_peak_height_250_re;
wire [7:0] pair_rb_robust_peak_height_250_r;
wire [7:0] pair_rb_robust_peak_height_250_w;
wire pair_rb_robust_peak_height_263_re;
wire [3:0] pair_rb_robust_peak_height_263_r;
wire [3:0] pair_rb_robust_peak_height_263_w;
wire pair_rb_robust_peak_height_262_re;
wire [7:0] pair_rb_robust_peak_height_262_r;
wire [7:0] pair_rb_robust_peak_height_262_w;
wire pair_rb_robust_peak_height_261_re;
wire [7:0] pair_rb_robust_peak_height_261_r;
wire [7:0] pair_rb_robust_peak_height_261_w;
wire pair_rb_robust_peak_height_260_re;
wire [7:0] pair_rb_robust_peak_height_260_r;
wire [7:0] pair_rb_robust_peak_height_260_w;
wire pair_rb_robust_peak_height_273_re;
wire [3:0] pair_rb_robust_peak_height_273_r;
wire [3:0] pair_rb_robust_peak_height_273_w;
wire pair_rb_robust_peak_height_272_re;
wire [7:0] pair_rb_robust_peak_height_272_r;
wire [7:0] pair_rb_robust_peak_height_272_w;
wire pair_rb_robust_peak_height_271_re;
wire [7:0] pair_rb_robust_peak_height_271_r;
wire [7:0] pair_rb_robust_peak_height_271_w;
wire pair_rb_robust_peak_height_270_re;
wire [7:0] pair_rb_robust_peak_height_270_r;
wire [7:0] pair_rb_robust_peak_height_270_w;
wire pair_rb_robust_peak_height_283_re;
wire [3:0] pair_rb_robust_peak_height_283_r;
wire [3:0] pair_rb_robust_peak_height_283_w;
wire pair_rb_robust_peak_height_282_re;
wire [7:0] pair_rb_robust_peak_height_282_r;
wire [7:0] pair_rb_robust_peak_height_282_w;
wire pair_rb_robust_peak_height_281_re;
wire [7:0] pair_rb_robust_peak_height_281_r;
wire [7:0] pair_rb_robust_peak_height_281_w;
wire pair_rb_robust_peak_height_280_re;
wire [7:0] pair_rb_robust_peak_height_280_r;
wire [7:0] pair_rb_robust_peak_height_280_w;
wire pair_rb_robust_peak_height_293_re;
wire [3:0] pair_rb_robust_peak_height_293_r;
wire [3:0] pair_rb_robust_peak_height_293_w;
wire pair_rb_robust_peak_height_292_re;
wire [7:0] pair_rb_robust_peak_height_292_r;
wire [7:0] pair_rb_robust_peak_height_292_w;
wire pair_rb_robust_peak_height_291_re;
wire [7:0] pair_rb_robust_peak_height_291_r;
wire [7:0] pair_rb_robust_peak_height_291_w;
wire pair_rb_robust_peak_height_290_re;
wire [7:0] pair_rb_robust_peak_height_290_r;
wire [7:0] pair_rb_robust_peak_height_290_w;
wire pair_rb_robust_peak_height_303_re;
wire [3:0] pair_rb_robust_peak_height_303_r;
wire [3:0] pair_rb_robust_peak_height_303_w;
wire pair_rb_robust_peak_height_302_re;
wire [7:0] pair_rb_robust_peak_height_302_r;
wire [7:0] pair_rb_robust_peak_height_302_w;
wire pair_rb_robust_peak_height_301_re;
wire [7:0] pair_rb_robust_peak_height_301_r;
wire [7:0] pair_rb_robust_peak_height_301_w;
wire pair_rb_robust_peak_height_300_re;
wire [7:0] pair_rb_robust_peak_height_300_r;
wire [7:0] pair_rb_robust_peak_height_300_w;
wire pair_rb_robust_peak_height_313_re;
wire [3:0] pair_rb_robust_peak_height_313_r;
wire [3:0] pair_rb_robust_peak_height_313_w;
wire pair_rb_robust_peak_height_312_re;
wire [7:0] pair_rb_robust_peak_height_312_r;
wire [7:0] pair_rb_robust_peak_height_312_w;
wire pair_rb_robust_peak_height_311_re;
wire [7:0] pair_rb_robust_peak_height_311_r;
wire [7:0] pair_rb_robust_peak_height_311_w;
wire pair_rb_robust_peak_height_310_re;
wire [7:0] pair_rb_robust_peak_height_310_r;
wire [7:0] pair_rb_robust_peak_height_310_w;
wire pair_rb_robust_wait_for_01_re;
wire [5:0] pair_rb_robust_wait_for_01_r;
wire [5:0] pair_rb_robust_wait_for_01_w;
wire pair_rb_robust_wait_for_00_re;
wire [7:0] pair_rb_robust_wait_for_00_r;
wire [7:0] pair_rb_robust_wait_for_00_w;
wire pair_rb_robust_wait_for_11_re;
wire [5:0] pair_rb_robust_wait_for_11_r;
wire [5:0] pair_rb_robust_wait_for_11_w;
wire pair_rb_robust_wait_for_10_re;
wire [7:0] pair_rb_robust_wait_for_10_r;
wire [7:0] pair_rb_robust_wait_for_10_w;
wire pair_rb_robust_wait_for_21_re;
wire [5:0] pair_rb_robust_wait_for_21_r;
wire [5:0] pair_rb_robust_wait_for_21_w;
wire pair_rb_robust_wait_for_20_re;
wire [7:0] pair_rb_robust_wait_for_20_r;
wire [7:0] pair_rb_robust_wait_for_20_w;
wire pair_rb_robust_wait_for_31_re;
wire [5:0] pair_rb_robust_wait_for_31_r;
wire [5:0] pair_rb_robust_wait_for_31_w;
wire pair_rb_robust_wait_for_30_re;
wire [7:0] pair_rb_robust_wait_for_30_r;
wire [7:0] pair_rb_robust_wait_for_30_w;
wire pair_rb_robust_wait_for_41_re;
wire [5:0] pair_rb_robust_wait_for_41_r;
wire [5:0] pair_rb_robust_wait_for_41_w;
wire pair_rb_robust_wait_for_40_re;
wire [7:0] pair_rb_robust_wait_for_40_r;
wire [7:0] pair_rb_robust_wait_for_40_w;
wire pair_rb_robust_wait_for_51_re;
wire [5:0] pair_rb_robust_wait_for_51_r;
wire [5:0] pair_rb_robust_wait_for_51_w;
wire pair_rb_robust_wait_for_50_re;
wire [7:0] pair_rb_robust_wait_for_50_r;
wire [7:0] pair_rb_robust_wait_for_50_w;
wire pair_rb_robust_wait_for_61_re;
wire [5:0] pair_rb_robust_wait_for_61_r;
wire [5:0] pair_rb_robust_wait_for_61_w;
wire pair_rb_robust_wait_for_60_re;
wire [7:0] pair_rb_robust_wait_for_60_r;
wire [7:0] pair_rb_robust_wait_for_60_w;
wire pair_rb_robust_wait_for_71_re;
wire [5:0] pair_rb_robust_wait_for_71_r;
wire [5:0] pair_rb_robust_wait_for_71_w;
wire pair_rb_robust_wait_for_70_re;
wire [7:0] pair_rb_robust_wait_for_70_r;
wire [7:0] pair_rb_robust_wait_for_70_w;
wire pair_rb_robust_wait_for_81_re;
wire [5:0] pair_rb_robust_wait_for_81_r;
wire [5:0] pair_rb_robust_wait_for_81_w;
wire pair_rb_robust_wait_for_80_re;
wire [7:0] pair_rb_robust_wait_for_80_r;
wire [7:0] pair_rb_robust_wait_for_80_w;
wire pair_rb_robust_wait_for_91_re;
wire [5:0] pair_rb_robust_wait_for_91_r;
wire [5:0] pair_rb_robust_wait_for_91_w;
wire pair_rb_robust_wait_for_90_re;
wire [7:0] pair_rb_robust_wait_for_90_r;
wire [7:0] pair_rb_robust_wait_for_90_w;
wire pair_rb_robust_wait_for_101_re;
wire [5:0] pair_rb_robust_wait_for_101_r;
wire [5:0] pair_rb_robust_wait_for_101_w;
wire pair_rb_robust_wait_for_100_re;
wire [7:0] pair_rb_robust_wait_for_100_r;
wire [7:0] pair_rb_robust_wait_for_100_w;
wire pair_rb_robust_wait_for_111_re;
wire [5:0] pair_rb_robust_wait_for_111_r;
wire [5:0] pair_rb_robust_wait_for_111_w;
wire pair_rb_robust_wait_for_110_re;
wire [7:0] pair_rb_robust_wait_for_110_r;
wire [7:0] pair_rb_robust_wait_for_110_w;
wire pair_rb_robust_wait_for_121_re;
wire [5:0] pair_rb_robust_wait_for_121_r;
wire [5:0] pair_rb_robust_wait_for_121_w;
wire pair_rb_robust_wait_for_120_re;
wire [7:0] pair_rb_robust_wait_for_120_r;
wire [7:0] pair_rb_robust_wait_for_120_w;
wire pair_rb_robust_wait_for_131_re;
wire [5:0] pair_rb_robust_wait_for_131_r;
wire [5:0] pair_rb_robust_wait_for_131_w;
wire pair_rb_robust_wait_for_130_re;
wire [7:0] pair_rb_robust_wait_for_130_r;
wire [7:0] pair_rb_robust_wait_for_130_w;
wire pair_rb_robust_wait_for_141_re;
wire [5:0] pair_rb_robust_wait_for_141_r;
wire [5:0] pair_rb_robust_wait_for_141_w;
wire pair_rb_robust_wait_for_140_re;
wire [7:0] pair_rb_robust_wait_for_140_r;
wire [7:0] pair_rb_robust_wait_for_140_w;
wire pair_rb_robust_wait_for_151_re;
wire [5:0] pair_rb_robust_wait_for_151_r;
wire [5:0] pair_rb_robust_wait_for_151_w;
wire pair_rb_robust_wait_for_150_re;
wire [7:0] pair_rb_robust_wait_for_150_r;
wire [7:0] pair_rb_robust_wait_for_150_w;
wire pair_rb_robust_wait_for_161_re;
wire [5:0] pair_rb_robust_wait_for_161_r;
wire [5:0] pair_rb_robust_wait_for_161_w;
wire pair_rb_robust_wait_for_160_re;
wire [7:0] pair_rb_robust_wait_for_160_r;
wire [7:0] pair_rb_robust_wait_for_160_w;
wire pair_rb_robust_wait_for_171_re;
wire [5:0] pair_rb_robust_wait_for_171_r;
wire [5:0] pair_rb_robust_wait_for_171_w;
wire pair_rb_robust_wait_for_170_re;
wire [7:0] pair_rb_robust_wait_for_170_r;
wire [7:0] pair_rb_robust_wait_for_170_w;
wire pair_rb_robust_wait_for_181_re;
wire [5:0] pair_rb_robust_wait_for_181_r;
wire [5:0] pair_rb_robust_wait_for_181_w;
wire pair_rb_robust_wait_for_180_re;
wire [7:0] pair_rb_robust_wait_for_180_r;
wire [7:0] pair_rb_robust_wait_for_180_w;
wire pair_rb_robust_wait_for_191_re;
wire [5:0] pair_rb_robust_wait_for_191_r;
wire [5:0] pair_rb_robust_wait_for_191_w;
wire pair_rb_robust_wait_for_190_re;
wire [7:0] pair_rb_robust_wait_for_190_r;
wire [7:0] pair_rb_robust_wait_for_190_w;
wire pair_rb_robust_wait_for_201_re;
wire [5:0] pair_rb_robust_wait_for_201_r;
wire [5:0] pair_rb_robust_wait_for_201_w;
wire pair_rb_robust_wait_for_200_re;
wire [7:0] pair_rb_robust_wait_for_200_r;
wire [7:0] pair_rb_robust_wait_for_200_w;
wire pair_rb_robust_wait_for_211_re;
wire [5:0] pair_rb_robust_wait_for_211_r;
wire [5:0] pair_rb_robust_wait_for_211_w;
wire pair_rb_robust_wait_for_210_re;
wire [7:0] pair_rb_robust_wait_for_210_r;
wire [7:0] pair_rb_robust_wait_for_210_w;
wire pair_rb_robust_wait_for_221_re;
wire [5:0] pair_rb_robust_wait_for_221_r;
wire [5:0] pair_rb_robust_wait_for_221_w;
wire pair_rb_robust_wait_for_220_re;
wire [7:0] pair_rb_robust_wait_for_220_r;
wire [7:0] pair_rb_robust_wait_for_220_w;
wire pair_rb_robust_wait_for_231_re;
wire [5:0] pair_rb_robust_wait_for_231_r;
wire [5:0] pair_rb_robust_wait_for_231_w;
wire pair_rb_robust_wait_for_230_re;
wire [7:0] pair_rb_robust_wait_for_230_r;
wire [7:0] pair_rb_robust_wait_for_230_w;
wire pair_rb_robust_wait_for_241_re;
wire [5:0] pair_rb_robust_wait_for_241_r;
wire [5:0] pair_rb_robust_wait_for_241_w;
wire pair_rb_robust_wait_for_240_re;
wire [7:0] pair_rb_robust_wait_for_240_r;
wire [7:0] pair_rb_robust_wait_for_240_w;
wire pair_rb_robust_wait_for_251_re;
wire [5:0] pair_rb_robust_wait_for_251_r;
wire [5:0] pair_rb_robust_wait_for_251_w;
wire pair_rb_robust_wait_for_250_re;
wire [7:0] pair_rb_robust_wait_for_250_r;
wire [7:0] pair_rb_robust_wait_for_250_w;
wire pair_rb_robust_wait_for_261_re;
wire [5:0] pair_rb_robust_wait_for_261_r;
wire [5:0] pair_rb_robust_wait_for_261_w;
wire pair_rb_robust_wait_for_260_re;
wire [7:0] pair_rb_robust_wait_for_260_r;
wire [7:0] pair_rb_robust_wait_for_260_w;
wire pair_rb_robust_wait_for_271_re;
wire [5:0] pair_rb_robust_wait_for_271_r;
wire [5:0] pair_rb_robust_wait_for_271_w;
wire pair_rb_robust_wait_for_270_re;
wire [7:0] pair_rb_robust_wait_for_270_r;
wire [7:0] pair_rb_robust_wait_for_270_w;
wire pair_rb_robust_wait_for_281_re;
wire [5:0] pair_rb_robust_wait_for_281_r;
wire [5:0] pair_rb_robust_wait_for_281_w;
wire pair_rb_robust_wait_for_280_re;
wire [7:0] pair_rb_robust_wait_for_280_r;
wire [7:0] pair_rb_robust_wait_for_280_w;
wire pair_rb_robust_wait_for_291_re;
wire [5:0] pair_rb_robust_wait_for_291_r;
wire [5:0] pair_rb_robust_wait_for_291_w;
wire pair_rb_robust_wait_for_290_re;
wire [7:0] pair_rb_robust_wait_for_290_r;
wire [7:0] pair_rb_robust_wait_for_290_w;
wire pair_rb_robust_wait_for_301_re;
wire [5:0] pair_rb_robust_wait_for_301_r;
wire [5:0] pair_rb_robust_wait_for_301_w;
wire pair_rb_robust_wait_for_300_re;
wire [7:0] pair_rb_robust_wait_for_300_r;
wire [7:0] pair_rb_robust_wait_for_300_w;
wire pair_rb_robust_wait_for_311_re;
wire [5:0] pair_rb_robust_wait_for_311_r;
wire [5:0] pair_rb_robust_wait_for_311_w;
wire pair_rb_robust_wait_for_310_re;
wire [7:0] pair_rb_robust_wait_for_310_r;
wire [7:0] pair_rb_robust_wait_for_310_w;
wire pair_rb_fast_target_position1_re;
wire [5:0] pair_rb_fast_target_position1_r;
wire [5:0] pair_rb_fast_target_position1_w;
wire pair_rb_fast_target_position0_re;
wire [7:0] pair_rb_fast_target_position0_r;
wire [7:0] pair_rb_fast_target_position0_w;
wire pair_rb_request_lock0_re;
wire pair_rb_request_lock0_r;
wire pair_rb_request_lock0_w;
wire pair_rb_autolock_mode0_re;
wire [1:0] pair_rb_autolock_mode0_r;
wire [1:0] pair_rb_autolock_mode0_w;
wire pair_rb_lock_running_re;
wire pair_rb_lock_running_r;
wire pair_rb_lock_running_w;
wire pair_rb_sel;
wire [13:0] pair_cb_bus_adr;
wire pair_cb_bus_we;
wire [7:0] pair_cb_bus_dat_w;
reg [7:0] pair_cb_bus_dat_r = 8'd0;
wire pair_cb_robust_time_scale1_re;
wire [5:0] pair_cb_robust_time_scale1_r;
wire [5:0] pair_cb_robust_time_scale1_w;
wire pair_cb_robust_time_scale0_re;
wire [7:0] pair_cb_robust_time_scale0_r;
wire [7:0] pair_cb_robust_time_scale0_w;
wire pair_cb_robust_N_instructions0_re;
wire [4:0] pair_cb_robust_N_instructions0_r;
wire [4:0] pair_cb_robust_N_instructions0_w;
wire pair_cb_robust_final_wait_time1_re;
wire [5:0] pair_cb_robust_final_wait_time1_r;
wire [5:0] pair_cb_robust_final_wait_time1_w;
wire pair_cb_robust_final_wait_time0_re;
wire [7:0] pair_cb_robust_final_wait_time0_r;
wire [7:0] pair_cb_robust_final_wait_time0_w;
wire pair_cb_robust_peak_height_03_re;
wire [3:0] pair_cb_robust_peak_height_03_r;
wire [3:0] pair_cb_robust_peak_height_03_w;
wire pair_cb_robust_peak_height_02_re;
wire [7:0] pair_cb_robust_peak_height_02_r;
wire [7:0] pair_cb_robust_peak_height_02_w;
wire pair_cb_robust_peak_height_01_re;
wire [7:0] pair_cb_robust_peak_height_01_r;
wire [7:0] pair_cb_robust_peak_height_01_w;
wire pair_cb_robust_peak_height_00_re;
wire [7:0] pair_cb_robust_peak_height_00_r;
wire [7:0] pair_cb_robust_peak_height_00_w;
wire pair_cb_robust_peak_height_13_re;
wire [3:0] pair_cb_robust_peak_height_13_r;
wire [3:0] pair_cb_robust_peak_height_13_w;
wire pair_cb_robust_peak_height_12_re;
wire [7:0] pair_cb_robust_peak_height_12_r;
wire [7:0] pair_cb_robust_peak_height_12_w;
wire pair_cb_robust_peak_height_11_re;
wire [7:0] pair_cb_robust_peak_height_11_r;
wire [7:0] pair_cb_robust_peak_height_11_w;
wire pair_cb_robust_peak_height_10_re;
wire [7:0] pair_cb_robust_peak_height_10_r;
wire [7:0] pair_cb_robust_peak_height_10_w;
wire pair_cb_robust_peak_height_23_re;
wire [3:0] pair_cb_robust_peak_height_23_r;
wire [3:0] pair_cb_robust_peak_height_23_w;
wire pair_cb_robust_peak_height_22_re;
wire [7:0] pair_cb_robust_peak_height_22_r;
wire [7:0] pair_cb_robust_peak_height_22_w;
wire pair_cb_robust_peak_height_21_re;
wire [7:0] pair_cb_robust_peak_height_21_r;
wire [7:0] pair_cb_robust_peak_height_21_w;
wire pair_cb_robust_peak_height_20_re;
wire [7:0] pair_cb_robust_peak_height_20_r;
wire [7:0] pair_cb_robust_peak_height_20_w;
wire pair_cb_robust_peak_height_33_re;
wire [3:0] pair_cb_robust_peak_height_33_r;
wire [3:0] pair_cb_robust_peak_height_33_w;
wire pair_cb_robust_peak_height_32_re;
wire [7:0] pair_cb_robust_peak_height_32_r;
wire [7:0] pair_cb_robust_peak_height_32_w;
wire pair_cb_robust_peak_height_31_re;
wire [7:0] pair_cb_robust_peak_height_31_r;
wire [7:0] pair_cb_robust_peak_height_31_w;
wire pair_cb_robust_peak_height_30_re;
wire [7:0] pair_cb_robust_peak_height_30_r;
wire [7:0] pair_cb_robust_peak_height_30_w;
wire pair_cb_robust_peak_height_43_re;
wire [3:0] pair_cb_robust_peak_height_43_r;
wire [3:0] pair_cb_robust_peak_height_43_w;
wire pair_cb_robust_peak_height_42_re;
wire [7:0] pair_cb_robust_peak_height_42_r;
wire [7:0] pair_cb_robust_peak_height_42_w;
wire pair_cb_robust_peak_height_41_re;
wire [7:0] pair_cb_robust_peak_height_41_r;
wire [7:0] pair_cb_robust_peak_height_41_w;
wire pair_cb_robust_peak_height_40_re;
wire [7:0] pair_cb_robust_peak_height_40_r;
wire [7:0] pair_cb_robust_peak_height_40_w;
wire pair_cb_robust_peak_height_53_re;
wire [3:0] pair_cb_robust_peak_height_53_r;
wire [3:0] pair_cb_robust_peak_height_53_w;
wire pair_cb_robust_peak_height_52_re;
wire [7:0] pair_cb_robust_peak_height_52_r;
wire [7:0] pair_cb_robust_peak_height_52_w;
wire pair_cb_robust_peak_height_51_re;
wire [7:0] pair_cb_robust_peak_height_51_r;
wire [7:0] pair_cb_robust_peak_height_51_w;
wire pair_cb_robust_peak_height_50_re;
wire [7:0] pair_cb_robust_peak_height_50_r;
wire [7:0] pair_cb_robust_peak_height_50_w;
wire pair_cb_robust_peak_height_63_re;
wire [3:0] pair_cb_robust_peak_height_63_r;
wire [3:0] pair_cb_robust_peak_height_63_w;
wire pair_cb_robust_peak_height_62_re;
wire [7:0] pair_cb_robust_peak_height_62_r;
wire [7:0] pair_cb_robust_peak_height_62_w;
wire pair_cb_robust_peak_height_61_re;
wire [7:0] pair_cb_robust_peak_height_61_r;
wire [7:0] pair_cb_robust_peak_height_61_w;
wire pair_cb_robust_peak_height_60_re;
wire [7:0] pair_cb_robust_peak_height_60_r;
wire [7:0] pair_cb_robust_peak_height_60_w;
wire pair_cb_robust_peak_height_73_re;
wire [3:0] pair_cb_robust_peak_height_73_r;
wire [3:0] pair_cb_robust_peak_height_73_w;
wire pair_cb_robust_peak_height_72_re;
wire [7:0] pair_cb_robust_peak_height_72_r;
wire [7:0] pair_cb_robust_peak_height_72_w;
wire pair_cb_robust_peak_height_71_re;
wire [7:0] pair_cb_robust_peak_height_71_r;
wire [7:0] pair_cb_robust_peak_height_71_w;
wire pair_cb_robust_peak_height_70_re;
wire [7:0] pair_cb_robust_peak_height_70_r;
wire [7:0] pair_cb_robust_peak_height_70_w;
wire pair_cb_robust_peak_height_83_re;
wire [3:0] pair_cb_robust_peak_height_83_r;
wire [3:0] pair_cb_robust_peak_height_83_w;
wire pair_cb_robust_peak_height_82_re;
wire [7:0] pair_cb_robust_peak_height_82_r;
wire [7:0] pair_cb_robust_peak_height_82_w;
wire pair_cb_robust_peak_height_81_re;
wire [7:0] pair_cb_robust_peak_height_81_r;
wire [7:0] pair_cb_robust_peak_height_81_w;
wire pair_cb_robust_peak_height_80_re;
wire [7:0] pair_cb_robust_peak_height_80_r;
wire [7:0] pair_cb_robust_peak_height_80_w;
wire pair_cb_robust_peak_height_93_re;
wire [3:0] pair_cb_robust_peak_height_93_r;
wire [3:0] pair_cb_robust_peak_height_93_w;
wire pair_cb_robust_peak_height_92_re;
wire [7:0] pair_cb_robust_peak_height_92_r;
wire [7:0] pair_cb_robust_peak_height_92_w;
wire pair_cb_robust_peak_height_91_re;
wire [7:0] pair_cb_robust_peak_height_91_r;
wire [7:0] pair_cb_robust_peak_height_91_w;
wire pair_cb_robust_peak_height_90_re;
wire [7:0] pair_cb_robust_peak_height_90_r;
wire [7:0] pair_cb_robust_peak_height_90_w;
wire pair_cb_robust_peak_height_103_re;
wire [3:0] pair_cb_robust_peak_height_103_r;
wire [3:0] pair_cb_robust_peak_height_103_w;
wire pair_cb_robust_peak_height_102_re;
wire [7:0] pair_cb_robust_peak_height_102_r;
wire [7:0] pair_cb_robust_peak_height_102_w;
wire pair_cb_robust_peak_height_101_re;
wire [7:0] pair_cb_robust_peak_height_101_r;
wire [7:0] pair_cb_robust_peak_height_101_w;
wire pair_cb_robust_peak_height_100_re;
wire [7:0] pair_cb_robust_peak_height_100_r;
wire [7:0] pair_cb_robust_peak_height_100_w;
wire pair_cb_robust_peak_height_113_re;
wire [3:0] pair_cb_robust_peak_height_113_r;
wire [3:0] pair_cb_robust_peak_height_113_w;
wire pair_cb_robust_peak_height_112_re;
wire [7:0] pair_cb_robust_peak_height_112_r;
wire [7:0] pair_cb_robust_peak_height_112_w;
wire pair_cb_robust_peak_height_111_re;
wire [7:0] pair_cb_robust_peak_height_111_r;
wire [7:0] pair_cb_robust_peak_height_111_w;
wire pair_cb_robust_peak_height_110_re;
wire [7:0] pair_cb_robust_peak_height_110_r;
wire [7:0] pair_cb_robust_peak_height_110_w;
wire pair_cb_robust_peak_height_123_re;
wire [3:0] pair_cb_robust_peak_height_123_r;
wire [3:0] pair_cb_robust_peak_height_123_w;
wire pair_cb_robust_peak_height_122_re;
wire [7:0] pair_cb_robust_peak_height_122_r;
wire [7:0] pair_cb_robust_peak_height_122_w;
wire pair_cb_robust_peak_height_121_re;
wire [7:0] pair_cb_robust_peak_height_121_r;
wire [7:0] pair_cb_robust_peak_height_121_w;
wire pair_cb_robust_peak_height_120_re;
wire [7:0] pair_cb_robust_peak_height_120_r;
wire [7:0] pair_cb_robust_peak_height_120_w;
wire pair_cb_robust_peak_height_133_re;
wire [3:0] pair_cb_robust_peak_height_133_r;
wire [3:0] pair_cb_robust_peak_height_133_w;
wire pair_cb_robust_peak_height_132_re;
wire [7:0] pair_cb_robust_peak_height_132_r;
wire [7:0] pair_cb_robust_peak_height_132_w;
wire pair_cb_robust_peak_height_131_re;
wire [7:0] pair_cb_robust_peak_height_131_r;
wire [7:0] pair_cb_robust_peak_height_131_w;
wire pair_cb_robust_peak_height_130_re;
wire [7:0] pair_cb_robust_peak_height_130_r;
wire [7:0] pair_cb_robust_peak_height_130_w;
wire pair_cb_robust_peak_height_143_re;
wire [3:0] pair_cb_robust_peak_height_143_r;
wire [3:0] pair_cb_robust_peak_height_143_w;
wire pair_cb_robust_peak_height_142_re;
wire [7:0] pair_cb_robust_peak_height_142_r;
wire [7:0] pair_cb_robust_peak_height_142_w;
wire pair_cb_robust_peak_height_141_re;
wire [7:0] pair_cb_robust_peak_height_141_r;
wire [7:0] pair_cb_robust_peak_height_141_w;
wire pair_cb_robust_peak_height_140_re;
wire [7:0] pair_cb_robust_peak_height_140_r;
wire [7:0] pair_cb_robust_peak_height_140_w;
wire pair_cb_robust_peak_height_153_re;
wire [3:0] pair_cb_robust_peak_height_153_r;
wire [3:0] pair_cb_robust_peak_height_153_w;
wire pair_cb_robust_peak_height_152_re;
wire [7:0] pair_cb_robust_peak_height_152_r;
wire [7:0] pair_cb_robust_peak_height_152_w;
wire pair_cb_robust_peak_height_151_re;
wire [7:0] pair_cb_robust_peak_height_151_r;
wire [7:0] pair_cb_robust_peak_height_151_w;
wire pair_cb_robust_peak_height_150_re;
wire [7:0] pair_cb_robust_peak_height_150_r;
wire [7:0] pair_cb_robust_peak_height_150_w;
wire pair_cb_robust_peak_height_163_re;
wire [3:0] pair_cb_robust_peak_height_163_r;
wire [3:0] pair_cb_robust_peak_height_163_w;
wire pair_cb_robust_peak_height_162_re;
wire [7:0] pair_cb_robust_peak_height_162_r;
wire [7:0] pair_cb_robust_peak_height_162_w;
wire pair_cb_robust_peak_height_161_re;
wire [7:0] pair_cb_robust_peak_height_161_r;
wire [7:0] pair_cb_robust_peak_height_161_w;
wire pair_cb_robust_peak_height_160_re;
wire [7:0] pair_cb_robust_peak_height_160_r;
wire [7:0] pair_cb_robust_peak_height_160_w;
wire pair_cb_robust_peak_height_173_re;
wire [3:0] pair_cb_robust_peak_height_173_r;
wire [3:0] pair_cb_robust_peak_height_173_w;
wire pair_cb_robust_peak_height_172_re;
wire [7:0] pair_cb_robust_peak_height_172_r;
wire [7:0] pair_cb_robust_peak_height_172_w;
wire pair_cb_robust_peak_height_171_re;
wire [7:0] pair_cb_robust_peak_height_171_r;
wire [7:0] pair_cb_robust_peak_height_171_w;
wire pair_cb_robust_peak_height_170_re;
wire [7:0] pair_cb_robust_peak_height_170_r;
wire [7:0] pair_cb_robust_peak_height_170_w;
wire pair_cb_robust_peak_height_183_re;
wire [3:0] pair_cb_robust_peak_height_183_r;
wire [3:0] pair_cb_robust_peak_height_183_w;
wire pair_cb_robust_peak_height_182_re;
wire [7:0] pair_cb_robust_peak_height_182_r;
wire [7:0] pair_cb_robust_peak_height_182_w;
wire pair_cb_robust_peak_height_181_re;
wire [7:0] pair_cb_robust_peak_height_181_r;
wire [7:0] pair_cb_robust_peak_height_181_w;
wire pair_cb_robust_peak_height_180_re;
wire [7:0] pair_cb_robust_peak_height_180_r;
wire [7:0] pair_cb_robust_peak_height_180_w;
wire pair_cb_robust_peak_height_193_re;
wire [3:0] pair_cb_robust_peak_height_193_r;
wire [3:0] pair_cb_robust_peak_height_193_w;
wire pair_cb_robust_peak_height_192_re;
wire [7:0] pair_cb_robust_peak_height_192_r;
wire [7:0] pair_cb_robust_peak_height_192_w;
wire pair_cb_robust_peak_height_191_re;
wire [7:0] pair_cb_robust_peak_height_191_r;
wire [7:0] pair_cb_robust_peak_height_191_w;
wire pair_cb_robust_peak_height_190_re;
wire [7:0] pair_cb_robust_peak_height_190_r;
wire [7:0] pair_cb_robust_peak_height_190_w;
wire pair_cb_robust_peak_height_203_re;
wire [3:0] pair_cb_robust_peak_height_203_r;
wire [3:0] pair_cb_robust_peak_height_203_w;
wire pair_cb_robust_peak_height_202_re;
wire [7:0] pair_cb_robust_peak_height_202_r;
wire [7:0] pair_cb_robust_peak_height_202_w;
wire pair_cb_robust_peak_height_201_re;
wire [7:0] pair_cb_robust_peak_height_201_r;
wire [7:0] pair_cb_robust_peak_height_201_w;
wire pair_cb_robust_peak_height_200_re;
wire [7:0] pair_cb_robust_peak_height_200_r;
wire [7:0] pair_cb_robust_peak_height_200_w;
wire pair_cb_robust_peak_height_213_re;
wire [3:0] pair_cb_robust_peak_height_213_r;
wire [3:0] pair_cb_robust_peak_height_213_w;
wire pair_cb_robust_peak_height_212_re;
wire [7:0] pair_cb_robust_peak_height_212_r;
wire [7:0] pair_cb_robust_peak_height_212_w;
wire pair_cb_robust_peak_height_211_re;
wire [7:0] pair_cb_robust_peak_height_211_r;
wire [7:0] pair_cb_robust_peak_height_211_w;
wire pair_cb_robust_peak_height_210_re;
wire [7:0] pair_cb_robust_peak_height_210_r;
wire [7:0] pair_cb_robust_peak_height_210_w;
wire pair_cb_robust_peak_height_223_re;
wire [3:0] pair_cb_robust_peak_height_223_r;
wire [3:0] pair_cb_robust_peak_height_223_w;
wire pair_cb_robust_peak_height_222_re;
wire [7:0] pair_cb_robust_peak_height_222_r;
wire [7:0] pair_cb_robust_peak_height_222_w;
wire pair_cb_robust_peak_height_221_re;
wire [7:0] pair_cb_robust_peak_height_221_r;
wire [7:0] pair_cb_robust_peak_height_221_w;
wire pair_cb_robust_peak_height_220_re;
wire [7:0] pair_cb_robust_peak_height_220_r;
wire [7:0] pair_cb_robust_peak_height_220_w;
wire pair_cb_robust_peak_height_233_re;
wire [3:0] pair_cb_robust_peak_height_233_r;
wire [3:0] pair_cb_robust_peak_height_233_w;
wire pair_cb_robust_peak_height_232_re;
wire [7:0] pair_cb_robust_peak_height_232_r;
wire [7:0] pair_cb_robust_peak_height_232_w;
wire pair_cb_robust_peak_height_231_re;
wire [7:0] pair_cb_robust_peak_height_231_r;
wire [7:0] pair_cb_robust_peak_height_231_w;
wire pair_cb_robust_peak_height_230_re;
wire [7:0] pair_cb_robust_peak_height_230_r;
wire [7:0] pair_cb_robust_peak_height_230_w;
wire pair_cb_robust_peak_height_243_re;
wire [3:0] pair_cb_robust_peak_height_243_r;
wire [3:0] pair_cb_robust_peak_height_243_w;
wire pair_cb_robust_peak_height_242_re;
wire [7:0] pair_cb_robust_peak_height_242_r;
wire [7:0] pair_cb_robust_peak_height_242_w;
wire pair_cb_robust_peak_height_241_re;
wire [7:0] pair_cb_robust_peak_height_241_r;
wire [7:0] pair_cb_robust_peak_height_241_w;
wire pair_cb_robust_peak_height_240_re;
wire [7:0] pair_cb_robust_peak_height_240_r;
wire [7:0] pair_cb_robust_peak_height_240_w;
wire pair_cb_robust_peak_height_253_re;
wire [3:0] pair_cb_robust_peak_height_253_r;
wire [3:0] pair_cb_robust_peak_height_253_w;
wire pair_cb_robust_peak_height_252_re;
wire [7:0] pair_cb_robust_peak_height_252_r;
wire [7:0] pair_cb_robust_peak_height_252_w;
wire pair_cb_robust_peak_height_251_re;
wire [7:0] pair_cb_robust_peak_height_251_r;
wire [7:0] pair_cb_robust_peak_height_251_w;
wire pair_cb_robust_peak_height_250_re;
wire [7:0] pair_cb_robust_peak_height_250_r;
wire [7:0] pair_cb_robust_peak_height_250_w;
wire pair_cb_robust_peak_height_263_re;
wire [3:0] pair_cb_robust_peak_height_263_r;
wire [3:0] pair_cb_robust_peak_height_263_w;
wire pair_cb_robust_peak_height_262_re;
wire [7:0] pair_cb_robust_peak_height_262_r;
wire [7:0] pair_cb_robust_peak_height_262_w;
wire pair_cb_robust_peak_height_261_re;
wire [7:0] pair_cb_robust_peak_height_261_r;
wire [7:0] pair_cb_robust_peak_height_261_w;
wire pair_cb_robust_peak_height_260_re;
wire [7:0] pair_cb_robust_peak_height_260_r;
wire [7:0] pair_cb_robust_peak_height_260_w;
wire pair_cb_robust_peak_height_273_re;
wire [3:0] pair_cb_robust_peak_height_273_r;
wire [3:0] pair_cb_robust_peak_height_273_w;
wire pair_cb_robust_peak_height_272_re;
wire [7:0] pair_cb_robust_peak_height_272_r;
wire [7:0] pair_cb_robust_peak_height_272_w;
wire pair_cb_robust_peak_height_271_re;
wire [7:0] pair_cb_robust_peak_height_271_r;
wire [7:0] pair_cb_robust_peak_height_271_w;
wire pair_cb_robust_peak_height_270_re;
wire [7:0] pair_cb_robust_peak_height_270_r;
wire [7:0] pair_cb_robust_peak_height_270_w;
wire pair_cb_robust_peak_height_283_re;
wire [3:0] pair_cb_robust_peak_height_283_r;
wire [3:0] pair_cb_robust_peak_height_283_w;
wire pair_cb_robust_peak_height_282_re;
wire [7:0] pair_cb_robust_peak_height_282_r;
wire [7:0] pair_cb_robust_peak_height_282_w;
wire pair_cb_robust_peak_height_281_re;
wire [7:0] pair_cb_robust_peak_height_281_r;
wire [7:0] pair_cb_robust_peak_height_281_w;
wire pair_cb_robust_peak_height_280_re;
wire [7:0] pair_cb_robust_peak_height_280_r;
wire [7:0] pair_cb_robust_peak_height_280_w;
wire pair_cb_robust_peak_height_293_re;
wire [3:0] pair_cb_robust_peak_height_293_r;
wire [3:0] pair_cb_robust_peak_height_293_w;
wire pair_cb_robust_peak_height_292_re;
wire [7:0] pair_cb_robust_peak_height_292_r;
wire [7:0] pair_cb_robust_peak_height_292_w;
wire pair_cb_robust_peak_height_291_re;
wire [7:0] pair_cb_robust_peak_height_291_r;
wire [7:0] pair_cb_robust_peak_height_291_w;
wire pair_cb_robust_peak_height_290_re;
wire [7:0] pair_cb_robust_peak_height_290_r;
wire [7:0] pair_cb_robust_peak_height_290_w;
wire pair_cb_robust_peak_height_303_re;
wire [3:0] pair_cb_robust_peak_height_303_r;
wire [3:0] pair_cb_robust_peak_height_303_w;
wire pair_cb_robust_peak_height_302_re;
wire [7:0] pair_cb_robust_peak_height_302_r;
wire [7:0] pair_cb_robust_peak_height_302_w;
wire pair_cb_robust_peak_height_301_re;
wire [7:0] pair_cb_robust_peak_height_301_r;
wire [7:0] pair_cb_robust_peak_height_301_w;
wire pair_cb_robust_peak_height_300_re;
wire [7:0] pair_cb_robust_peak_height_300_r;
wire [7:0] pair_cb_robust_peak_height_300_w;
wire pair_cb_robust_peak_height_313_re;
wire [3:0] pair_cb_robust_peak_height_313_r;
wire [3:0] pair_cb_robust_peak_height_313_w;
wire pair_cb_robust_peak_height_312_re;
wire [7:0] pair_cb_robust_peak_height_312_r;
wire [7:0] pair_cb_robust_peak_height_312_w;
wire pair_cb_robust_peak_height_311_re;
wire [7:0] pair_cb_robust_peak_height_311_r;
wire [7:0] pair_cb_robust_peak_height_311_w;
wire pair_cb_robust_peak_height_310_re;
wire [7:0] pair_cb_robust_peak_height_310_r;
wire [7:0] pair_cb_robust_peak_height_310_w;
wire pair_cb_robust_wait_for_01_re;
wire [5:0] pair_cb_robust_wait_for_01_r;
wire [5:0] pair_cb_robust_wait_for_01_w;
wire pair_cb_robust_wait_for_00_re;
wire [7:0] pair_cb_robust_wait_for_00_r;
wire [7:0] pair_cb_robust_wait_for_00_w;
wire pair_cb_robust_wait_for_11_re;
wire [5:0] pair_cb_robust_wait_for_11_r;
wire [5:0] pair_cb_robust_wait_for_11_w;
wire pair_cb_robust_wait_for_10_re;
wire [7:0] pair_cb_robust_wait_for_10_r;
wire [7:0] pair_cb_robust_wait_for_10_w;
wire pair_cb_robust_wait_for_21_re;
wire [5:0] pair_cb_robust_wait_for_21_r;
wire [5:0] pair_cb_robust_wait_for_21_w;
wire pair_cb_robust_wait_for_20_re;
wire [7:0] pair_cb_robust_wait_for_20_r;
wire [7:0] pair_cb_robust_wait_for_20_w;
wire pair_cb_robust_wait_for_31_re;
wire [5:0] pair_cb_robust_wait_for_31_r;
wire [5:0] pair_cb_robust_wait_for_31_w;
wire pair_cb_robust_wait_for_30_re;
wire [7:0] pair_cb_robust_wait_for_30_r;
wire [7:0] pair_cb_robust_wait_for_30_w;
wire pair_cb_robust_wait_for_41_re;
wire [5:0] pair_cb_robust_wait_for_41_r;
wire [5:0] pair_cb_robust_wait_for_41_w;
wire pair_cb_robust_wait_for_40_re;
wire [7:0] pair_cb_robust_wait_for_40_r;
wire [7:0] pair_cb_robust_wait_for_40_w;
wire pair_cb_robust_wait_for_51_re;
wire [5:0] pair_cb_robust_wait_for_51_r;
wire [5:0] pair_cb_robust_wait_for_51_w;
wire pair_cb_robust_wait_for_50_re;
wire [7:0] pair_cb_robust_wait_for_50_r;
wire [7:0] pair_cb_robust_wait_for_50_w;
wire pair_cb_robust_wait_for_61_re;
wire [5:0] pair_cb_robust_wait_for_61_r;
wire [5:0] pair_cb_robust_wait_for_61_w;
wire pair_cb_robust_wait_for_60_re;
wire [7:0] pair_cb_robust_wait_for_60_r;
wire [7:0] pair_cb_robust_wait_for_60_w;
wire pair_cb_robust_wait_for_71_re;
wire [5:0] pair_cb_robust_wait_for_71_r;
wire [5:0] pair_cb_robust_wait_for_71_w;
wire pair_cb_robust_wait_for_70_re;
wire [7:0] pair_cb_robust_wait_for_70_r;
wire [7:0] pair_cb_robust_wait_for_70_w;
wire pair_cb_robust_wait_for_81_re;
wire [5:0] pair_cb_robust_wait_for_81_r;
wire [5:0] pair_cb_robust_wait_for_81_w;
wire pair_cb_robust_wait_for_80_re;
wire [7:0] pair_cb_robust_wait_for_80_r;
wire [7:0] pair_cb_robust_wait_for_80_w;
wire pair_cb_robust_wait_for_91_re;
wire [5:0] pair_cb_robust_wait_for_91_r;
wire [5:0] pair_cb_robust_wait_for_91_w;
wire pair_cb_robust_wait_for_90_re;
wire [7:0] pair_cb_robust_wait_for_90_r;
wire [7:0] pair_cb_robust_wait_for_90_w;
wire pair_cb_robust_wait_for_101_re;
wire [5:0] pair_cb_robust_wait_for_101_r;
wire [5:0] pair_cb_robust_wait_for_101_w;
wire pair_cb_robust_wait_for_100_re;
wire [7:0] pair_cb_robust_wait_for_100_r;
wire [7:0] pair_cb_robust_wait_for_100_w;
wire pair_cb_robust_wait_for_111_re;
wire [5:0] pair_cb_robust_wait_for_111_r;
wire [5:0] pair_cb_robust_wait_for_111_w;
wire pair_cb_robust_wait_for_110_re;
wire [7:0] pair_cb_robust_wait_for_110_r;
wire [7:0] pair_cb_robust_wait_for_110_w;
wire pair_cb_robust_wait_for_121_re;
wire [5:0] pair_cb_robust_wait_for_121_r;
wire [5:0] pair_cb_robust_wait_for_121_w;
wire pair_cb_robust_wait_for_120_re;
wire [7:0] pair_cb_robust_wait_for_120_r;
wire [7:0] pair_cb_robust_wait_for_120_w;
wire pair_cb_robust_wait_for_131_re;
wire [5:0] pair_cb_robust_wait_for_131_r;
wire [5:0] pair_cb_robust_wait_for_131_w;
wire pair_cb_robust_wait_for_130_re;
wire [7:0] pair_cb_robust_wait_for_130_r;
wire [7:0] pair_cb_robust_wait_for_130_w;
wire pair_cb_robust_wait_for_141_re;
wire [5:0] pair_cb_robust_wait_for_141_r;
wire [5:0] pair_cb_robust_wait_for_141_w;
wire pair_cb_robust_wait_for_140_re;
wire [7:0] pair_cb_robust_wait_for_140_r;
wire [7:0] pair_cb_robust_wait_for_140_w;
wire pair_cb_robust_wait_for_151_re;
wire [5:0] pair_cb_robust_wait_for_151_r;
wire [5:0] pair_cb_robust_wait_for_151_w;
wire pair_cb_robust_wait_for_150_re;
wire [7:0] pair_cb_robust_wait_for_150_r;
wire [7:0] pair_cb_robust_wait_for_150_w;
wire pair_cb_robust_wait_for_161_re;
wire [5:0] pair_cb_robust_wait_for_161_r;
wire [5:0] pair_cb_robust_wait_for_161_w;
wire pair_cb_robust_wait_for_160_re;
wire [7:0] pair_cb_robust_wait_for_160_r;
wire [7:0] pair_cb_robust_wait_for_160_w;
wire pair_cb_robust_wait_for_171_re;
wire [5:0] pair_cb_robust_wait_for_171_r;
wire [5:0] pair_cb_robust_wait_for_171_w;
wire pair_cb_robust_wait_for_170_re;
wire [7:0] pair_cb_robust_wait_for_170_r;
wire [7:0] pair_cb_robust_wait_for_170_w;
wire pair_cb_robust_wait_for_181_re;
wire [5:0] pair_cb_robust_wait_for_181_r;
wire [5:0] pair_cb_robust_wait_for_181_w;
wire pair_cb_robust_wait_for_180_re;
wire [7:0] pair_cb_robust_wait_for_180_r;
wire [7:0] pair_cb_robust_wait_for_180_w;
wire pair_cb_robust_wait_for_191_re;
wire [5:0] pair_cb_robust_wait_for_191_r;
wire [5:0] pair_cb_robust_wait_for_191_w;
wire pair_cb_robust_wait_for_190_re;
wire [7:0] pair_cb_robust_wait_for_190_r;
wire [7:0] pair_cb_robust_wait_for_190_w;
wire pair_cb_robust_wait_for_201_re;
wire [5:0] pair_cb_robust_wait_for_201_r;
wire [5:0] pair_cb_robust_wait_for_201_w;
wire pair_cb_robust_wait_for_200_re;
wire [7:0] pair_cb_robust_wait_for_200_r;
wire [7:0] pair_cb_robust_wait_for_200_w;
wire pair_cb_robust_wait_for_211_re;
wire [5:0] pair_cb_robust_wait_for_211_r;
wire [5:0] pair_cb_robust_wait_for_211_w;
wire pair_cb_robust_wait_for_210_re;
wire [7:0] pair_cb_robust_wait_for_210_r;
wire [7:0] pair_cb_robust_wait_for_210_w;
wire pair_cb_robust_wait_for_221_re;
wire [5:0] pair_cb_robust_wait_for_221_r;
wire [5:0] pair_cb_robust_wait_for_221_w;
wire pair_cb_robust_wait_for_220_re;
wire [7:0] pair_cb_robust_wait_for_220_r;
wire [7:0] pair_cb_robust_wait_for_220_w;
wire pair_cb_robust_wait_for_231_re;
wire [5:0] pair_cb_robust_wait_for_231_r;
wire [5:0] pair_cb_robust_wait_for_231_w;
wire pair_cb_robust_wait_for_230_re;
wire [7:0] pair_cb_robust_wait_for_230_r;
wire [7:0] pair_cb_robust_wait_for_230_w;
wire pair_cb_robust_wait_for_241_re;
wire [5:0] pair_cb_robust_wait_for_241_r;
wire [5:0] pair_cb_robust_wait_for_241_w;
wire pair_cb_robust_wait_for_240_re;
wire [7:0] pair_cb_robust_wait_for_240_r;
wire [7:0] pair_cb_robust_wait_for_240_w;
wire pair_cb_robust_wait_for_251_re;
wire [5:0] pair_cb_robust_wait_for_251_r;
wire [5:0] pair_cb_robust_wait_for_251_w;
wire pair_cb_robust_wait_for_250_re;
wire [7:0] pair_cb_robust_wait_for_250_r;
wire [7:0] pair_cb_robust_wait_for_250_w;
wire pair_cb_robust_wait_for_261_re;
wire [5:0] pair_cb_robust_wait_for_261_r;
wire [5:0] pair_cb_robust_wait_for_261_w;
wire pair_cb_robust_wait_for_260_re;
wire [7:0] pair_cb_robust_wait_for_260_r;
wire [7:0] pair_cb_robust_wait_for_260_w;
wire pair_cb_robust_wait_for_271_re;
wire [5:0] pair_cb_robust_wait_for_271_r;
wire [5:0] pair_cb_robust_wait_for_271_w;
wire pair_cb_robust_wait_for_270_re;
wire [7:0] pair_cb_robust_wait_for_270_r;
wire [7:0] pair_cb_robust_wait_for_270_w;
wire pair_cb_robust_wait_for_281_re;
wire [5:0] pair_cb_robust_wait_for_281_r;
wire [5:0] pair_cb_robust_wait_for_281_w;
wire pair_cb_robust_wait_for_280_re;
wire [7:0] pair_cb_robust_wait_for_280_r;
wire [7:0] pair_cb_robust_wait_for_280_w;
wire pair_cb_robust_wait_for_291_re;
wire [5:0] pair_cb_robust_wait_for_291_r;
wire [5:0] pair_cb_robust_wait_for_291_w;
wire pair_cb_robust_wait_for_290_re;
wire [7:0] pair_cb_robust_wait_for_290_r;
wire [7:0] pair_cb_robust_wait_for_290_w;
wire pair_cb_robust_wait_for_301_re;
wire [5:0] pair_cb_robust_wait_for_301_r;
wire [5:0] pair_cb_robust_wait_for_301_w;
wire pair_cb_robust_wait_for_300_re;
wire [7:0] pair_cb_robust_wait_for_300_r;
wire [7:0] pair_cb_robust_wait_for_300_w;
wire pair_cb_robust_wait_for_311_re;
wire [5:0] pair_cb_robust_wait_for_311_r;
wire [5:0] pair_cb_robust_wait_for_311_w;
wire pair_cb_robust_wait_for_310_re;
wire [7:0] pair_cb_robust_wait_for_310_r;
wire [7:0] pair_cb_robust_wait_for_310_w;
wire pair_cb_fast_target_position1_re;
wire [5:0] pair_cb_fast_target_position1_r;
wire [5:0] pair_cb_fast_target_position1_w;
wire pair_cb_fast_target_position0_re;
wire [7:0] pair_cb_fast_target_position0_r;
wire [7:0] pair_cb_fast_target_position0_w;
wire pair_cb_request_lock0_re;
wire pair_cb_request_lock0_r;
wire pair_cb_request_lock0_w;
wire pair_cb_autolock_mode0_re;
wire [1:0] pair_cb_autolock_mode0_r;
wire [1:0] pair_cb_autolock_mode0_w;
wire pair_cb_lock_running_re;
wire pair_cb_lock_running_r;
wire pair_cb_lock_running_w;
wire pair_cb_sel;
reg signed [27:0] pair_pair0 = 28'sd0;
reg [12:0] pair_pair1 = 13'd0;
reg [12:0] pair_pair_q = 13'd1;
reg signed [28:0] pair_pair2 = 29'sd0;
reg [27:0] comb_array_muxed0;
reg [13:0] comb_array_muxed1;
reg [27:0] comb_array_muxed2;
reg signed [27:0] comb_array_muxed3;
reg signed [28:0] comb_array_muxed4;
reg comb_array_muxed5;
reg [13:0] comb_array_muxed6;
reg [13:0] sync_array_muxed;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_reference_robust_public0 = data;
assign pair_reference_robust_public2 = at_start;
assign pair_reference_robust_public3 = writing;
assign pair_reference_robust_public4 = sweep_up;
assign pair_reference_fast_sweep_value = data;
assign pair_reference_fast_sweep_up = sweep_up;
assign pair_reference_fast_sweep_step = 4'd8;
assign pair_rb_bus_adr = csr_adr;
assign pair_rb_bus_we = csr_we;
assign pair_rb_bus_dat_w = csr_dat_w;
assign ref_obs = {pair_reference_status, pair_reference_robust_output0, pair_reference_robust_counter_delayed, pair_reference_robust_counter, pair_reference_robust_sum_value, pair_reference_robust_waited_long_enough, pair_reference_robust_over_threshold, pair_reference_robust_sign_equal, pair_reference_robust_turn_on_lock, pair_reference_robust_watching, pair_reference_robust_current_instruction_idx};
assign ref_cfg = {pair_reference_fast_storage, pair_reference_autolock_mode_storage, pair_reference_request_lock_storage, pair_reference_robust_csrstorage66_storage, pair_reference_robust_csrstorage65_storage, pair_reference_robust_csrstorage64_storage, pair_reference_robust_csrstorage63_storage, pair_reference_robust_csrstorage62_storage, pair_reference_robust_csrstorage61_storage, pair_reference_robust_csrstorage60_storage, pair_reference_robust_csrstorage59_storage, pair_reference_robust_csrstorage58_storage, pair_reference_robust_csrstorage57_storage, pair_reference_robust_csrstorage56_storage, pair_reference_robust_csrstorage55_storage, pair_reference_robust_csrstorage54_storage, pair_reference_robust_csrstorage53_storage, pair_reference_robust_csrstorage52_storage, pair_reference_robust_csrstorage51_storage, pair_reference_robust_csrstorage50_storage, pair_reference_robust_csrstorage49_storage, pair_reference_robust_csrstorage48_storage, pair_reference_robust_csrstorage47_storage, pair_reference_robust_csrstorage46_storage, pair_reference_robust_csrstorage45_storage, pair_reference_robust_csrstorage44_storage, pair_reference_robust_csrstorage43_storage, pair_reference_robust_csrstorage42_storage, pair_reference_robust_csrstorage41_storage, pair_reference_robust_csrstorage40_storage, pair_reference_robust_csrstorage39_storage, pair_reference_robust_csrstorage38_storage, pair_reference_robust_csrstorage37_storage, pair_reference_robust_csrstorage36_storage, pair_reference_robust_csrstorage35_storage, pair_reference_robust_csrstorage34_storage, pair_reference_robust_csrstorage33_storage, pair_reference_robust_csrstorage32_storage, pair_reference_robust_csrstorage31_storage, pair_reference_robust_csrstorage30_storage, pair_reference_robust_csrstorage29_storage, pair_reference_robust_csrstorage28_storage, pair_reference_robust_csrstorage27_storage, pair_reference_robust_csrstorage26_storage, pair_reference_robust_csrstorage25_storage, pair_reference_robust_csrstorage24_storage, pair_reference_robust_csrstorage23_storage, pair_reference_robust_csrstorage22_storage, pair_reference_robust_csrstorage21_storage, pair_reference_robust_csrstorage20_storage, pair_reference_robust_csrstorage19_storage, pair_reference_robust_csrstorage18_storage, pair_reference_robust_csrstorage17_storage, pair_reference_robust_csrstorage16_storage, pair_reference_robust_csrstorage15_storage, pair_reference_robust_csrstorage14_storage, pair_reference_robust_csrstorage13_storage, pair_reference_robust_csrstorage12_storage, pair_reference_robust_csrstorage11_storage, pair_reference_robust_csrstorage10_storage, pair_reference_robust_csrstorage9_storage, pair_reference_robust_csrstorage8_storage, pair_reference_robust_csrstorage7_storage, pair_reference_robust_csrstorage6_storage, pair_reference_robust_csrstorage5_storage, pair_reference_robust_csrstorage4_storage, pair_reference_robust_csrstorage3_storage, pair_reference_robust_csrstorage2_storage, pair_reference_robust_csrstorage1_storage, pair_reference_robust_csrstorage0_storage};
assign ref_read = pair_rb_bus_dat_r;
assign ref_idx = pair_reference_robust_current_instruction_idx;
assign ref_watch = pair_reference_robust_watching;
assign ref_turn = pair_reference_status;
assign pair_candidate_pipelinedrobustautolock_input2 = data;
assign pair_candidate_pipelinedrobustautolock_at_start = at_start;
assign pair_candidate_pipelinedrobustautolock_writing_data_now2 = writing;
assign pair_candidate_pipelinedrobustautolock_sweep_up = sweep_up;
assign pair_candidate_fast_sweep_value = data;
assign pair_candidate_fast_sweep_up = sweep_up;
assign pair_candidate_fast_sweep_step = 4'd8;
assign pair_cb_bus_adr = csr_adr;
assign pair_cb_bus_we = csr_we;
assign pair_cb_bus_dat_w = csr_dat_w;
assign cand_obs = {pair_candidate_status, pair_pair2, pair_pair_q, pair_pair1, pair_pair0, pair_candidate_pipelinedrobustautolock_waited_long_enough, pair_candidate_pipelinedrobustautolock_over_threshold, pair_candidate_pipelinedrobustautolock_sign_equal, pair_candidate_pipelinedrobustautolock_turn_on_lock, pair_candidate_pipelinedrobustautolock_watching, pair_candidate_pipelinedrobustautolock_current_instruction_idx};
assign cand_cfg = {pair_candidate_fast_storage, pair_candidate_autolock_mode_storage, pair_candidate_request_lock_storage, pair_candidate_pipelinedrobustautolock_csrstorage63_storage, pair_candidate_pipelinedrobustautolock_csrstorage62_storage, pair_candidate_pipelinedrobustautolock_csrstorage61_storage, pair_candidate_pipelinedrobustautolock_csrstorage60_storage, pair_candidate_pipelinedrobustautolock_csrstorage59_storage, pair_candidate_pipelinedrobustautolock_csrstorage58_storage, pair_candidate_pipelinedrobustautolock_csrstorage57_storage, pair_candidate_pipelinedrobustautolock_csrstorage56_storage, pair_candidate_pipelinedrobustautolock_csrstorage55_storage, pair_candidate_pipelinedrobustautolock_csrstorage54_storage, pair_candidate_pipelinedrobustautolock_csrstorage53_storage, pair_candidate_pipelinedrobustautolock_csrstorage52_storage, pair_candidate_pipelinedrobustautolock_csrstorage51_storage, pair_candidate_pipelinedrobustautolock_csrstorage50_storage, pair_candidate_pipelinedrobustautolock_csrstorage49_storage, pair_candidate_pipelinedrobustautolock_csrstorage48_storage, pair_candidate_pipelinedrobustautolock_csrstorage47_storage, pair_candidate_pipelinedrobustautolock_csrstorage46_storage, pair_candidate_pipelinedrobustautolock_csrstorage45_storage, pair_candidate_pipelinedrobustautolock_csrstorage44_storage, pair_candidate_pipelinedrobustautolock_csrstorage43_storage, pair_candidate_pipelinedrobustautolock_csrstorage42_storage, pair_candidate_pipelinedrobustautolock_csrstorage41_storage, pair_candidate_pipelinedrobustautolock_csrstorage40_storage, pair_candidate_pipelinedrobustautolock_csrstorage39_storage, pair_candidate_pipelinedrobustautolock_csrstorage38_storage, pair_candidate_pipelinedrobustautolock_csrstorage37_storage, pair_candidate_pipelinedrobustautolock_csrstorage36_storage, pair_candidate_pipelinedrobustautolock_csrstorage35_storage, pair_candidate_pipelinedrobustautolock_csrstorage34_storage, pair_candidate_pipelinedrobustautolock_csrstorage33_storage, pair_candidate_pipelinedrobustautolock_csrstorage32_storage, pair_candidate_pipelinedrobustautolock_csrstorage31_storage, pair_candidate_pipelinedrobustautolock_csrstorage30_storage, pair_candidate_pipelinedrobustautolock_csrstorage29_storage, pair_candidate_pipelinedrobustautolock_csrstorage28_storage, pair_candidate_pipelinedrobustautolock_csrstorage27_storage, pair_candidate_pipelinedrobustautolock_csrstorage26_storage, pair_candidate_pipelinedrobustautolock_csrstorage25_storage, pair_candidate_pipelinedrobustautolock_csrstorage24_storage, pair_candidate_pipelinedrobustautolock_csrstorage23_storage, pair_candidate_pipelinedrobustautolock_csrstorage22_storage, pair_candidate_pipelinedrobustautolock_csrstorage21_storage, pair_candidate_pipelinedrobustautolock_csrstorage20_storage, pair_candidate_pipelinedrobustautolock_csrstorage19_storage, pair_candidate_pipelinedrobustautolock_csrstorage18_storage, pair_candidate_pipelinedrobustautolock_csrstorage17_storage, pair_candidate_pipelinedrobustautolock_csrstorage16_storage, pair_candidate_pipelinedrobustautolock_csrstorage15_storage, pair_candidate_pipelinedrobustautolock_csrstorage14_storage, pair_candidate_pipelinedrobustautolock_csrstorage13_storage, pair_candidate_pipelinedrobustautolock_csrstorage12_storage, pair_candidate_pipelinedrobustautolock_csrstorage11_storage, pair_candidate_pipelinedrobustautolock_csrstorage10_storage, pair_candidate_pipelinedrobustautolock_csrstorage9_storage, pair_candidate_pipelinedrobustautolock_csrstorage8_storage, pair_candidate_pipelinedrobustautolock_csrstorage7_storage, pair_candidate_pipelinedrobustautolock_csrstorage6_storage, pair_candidate_pipelinedrobustautolock_csrstorage5_storage, pair_candidate_pipelinedrobustautolock_csrstorage4_storage, pair_candidate_pipelinedrobustautolock_csrstorage3_storage, pair_candidate_pipelinedrobustautolock_csrstorage2_storage, pair_candidate_pipelinedrobustautolock_csrstorage1_storage, pair_candidate_pipelinedrobustautolock_csrstorage0_storage, pair_candidate_pipelinedrobustautolock_final_wait_time_storage, pair_candidate_pipelinedrobustautolock_N_instructions_storage, pair_candidate_pipelinedrobustautolock_time_scale_storage};
assign cand_read = pair_cb_bus_dat_r;
assign cand_idx = pair_candidate_pipelinedrobustautolock_current_instruction_idx;
assign cand_watch = pair_candidate_pipelinedrobustautolock_watching;
assign cand_turn = pair_candidate_status;
assign cand_prefetch_choice = pair_candidate_pipelinedrobustautolock_prefetch_choice;
assign pair_reference_fast_request_lock = pair_reference_request_lock_storage;
assign pair_reference_robust_public1 = pair_reference_request_lock_storage;
assign pair_reference_robust_current_peak_height = comb_array_muxed0;
assign pair_reference_robust_current_wait_for = comb_array_muxed1;
assign pair_reference_robust_writing_data_now0 = pair_reference_robust_writing_data_now2;
assign pair_reference_robust_restart0 = pair_reference_robust_at_start;
assign pair_reference_robust_input0 = pair_reference_robust_input2;
assign pair_reference_robust_delay_value = pair_reference_robust_time_scale_storage;
assign pair_reference_robust_sum_diff = pair_reference_robust_output0;
assign pair_reference_robust_sign_equal = ((pair_reference_robust_sum_diff > $signed({1'd0, 1'd0})) == (pair_reference_robust_current_peak_height > $signed({1'd0, 1'd0})));

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_reference_robust_abs_sum_diff <= 29'sd0;
	if ((pair_reference_robust_sum_diff >= $signed({1'd0, 1'd0}))) begin
		pair_reference_robust_abs_sum_diff <= pair_reference_robust_sum_diff;
	end else begin
		pair_reference_robust_abs_sum_diff <= (1'sd1 * pair_reference_robust_sum_diff);
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_reference_robust_abs_current_peak_height <= 28'sd0;
	if ((pair_reference_robust_current_peak_height >= $signed({1'd0, 1'd0}))) begin
		pair_reference_robust_abs_current_peak_height <= pair_reference_robust_current_peak_height;
	end else begin
		pair_reference_robust_abs_current_peak_height <= (1'sd1 * pair_reference_robust_current_peak_height);
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_robust_over_threshold = (pair_reference_robust_abs_sum_diff >= pair_reference_robust_abs_current_peak_height);
assign pair_reference_robust_waited_long_enough = (pair_reference_robust_waited_for > pair_reference_robust_current_wait_for);
assign pair_reference_robust_all_instructions_triggered = (pair_reference_robust_current_instruction_idx >= pair_reference_robust_N_instructions_storage);
assign pair_reference_robust_turn_on_lock = (pair_reference_robust_all_instructions_triggered & (pair_reference_robust_final_waited_for >= pair_reference_robust_final_wait_time_storage));
assign pair_reference_robust_input2 = pair_reference_robust_q0;
assign pair_reference_robust_request_lock = pair_reference_robust_q1;
assign pair_reference_robust_at_start = pair_reference_robust_q2;
assign pair_reference_robust_writing_data_now2 = pair_reference_robust_q3;
assign pair_reference_robust_sweep_up = pair_reference_robust_q4;
assign pair_reference_robust_time_scale_storage = pair_reference_robust_q5;
assign pair_reference_robust_N_instructions_storage = pair_reference_robust_q6;
assign pair_reference_robust_final_wait_time_storage = pair_reference_robust_q7;
assign pair_reference_robust_csrstorage_storage0 = pair_reference_robust_q8;
assign pair_reference_robust_csrstorage_storage1 = pair_reference_robust_q9;
assign pair_reference_robust_csrstorage_storage2 = pair_reference_robust_q10;
assign pair_reference_robust_csrstorage_storage3 = pair_reference_robust_q11;
assign pair_reference_robust_csrstorage_storage4 = pair_reference_robust_q12;
assign pair_reference_robust_csrstorage_storage5 = pair_reference_robust_q13;
assign pair_reference_robust_csrstorage_storage6 = pair_reference_robust_q14;
assign pair_reference_robust_csrstorage_storage7 = pair_reference_robust_q15;
assign pair_reference_robust_csrstorage_storage8 = pair_reference_robust_q16;
assign pair_reference_robust_csrstorage_storage9 = pair_reference_robust_q17;
assign pair_reference_robust_csrstorage_storage10 = pair_reference_robust_q18;
assign pair_reference_robust_csrstorage_storage11 = pair_reference_robust_q19;
assign pair_reference_robust_csrstorage_storage12 = pair_reference_robust_q20;
assign pair_reference_robust_csrstorage_storage13 = pair_reference_robust_q21;
assign pair_reference_robust_csrstorage_storage14 = pair_reference_robust_q22;
assign pair_reference_robust_csrstorage_storage15 = pair_reference_robust_q23;
assign pair_reference_robust_csrstorage_storage16 = pair_reference_robust_q24;
assign pair_reference_robust_csrstorage_storage17 = pair_reference_robust_q25;
assign pair_reference_robust_csrstorage_storage18 = pair_reference_robust_q26;
assign pair_reference_robust_csrstorage_storage19 = pair_reference_robust_q27;
assign pair_reference_robust_csrstorage_storage20 = pair_reference_robust_q28;
assign pair_reference_robust_csrstorage_storage21 = pair_reference_robust_q29;
assign pair_reference_robust_csrstorage_storage22 = pair_reference_robust_q30;
assign pair_reference_robust_csrstorage_storage23 = pair_reference_robust_q31;
assign pair_reference_robust_csrstorage_storage24 = pair_reference_robust_q32;
assign pair_reference_robust_csrstorage_storage25 = pair_reference_robust_q33;
assign pair_reference_robust_csrstorage_storage26 = pair_reference_robust_q34;
assign pair_reference_robust_csrstorage_storage27 = pair_reference_robust_q35;
assign pair_reference_robust_csrstorage_storage28 = pair_reference_robust_q36;
assign pair_reference_robust_csrstorage_storage29 = pair_reference_robust_q37;
assign pair_reference_robust_csrstorage_storage30 = pair_reference_robust_q38;
assign pair_reference_robust_csrstorage_storage31 = pair_reference_robust_q39;
assign pair_reference_robust_csrstorage_storage32 = pair_reference_robust_q40;
assign pair_reference_robust_csrstorage_storage33 = pair_reference_robust_q41;
assign pair_reference_robust_csrstorage_storage34 = pair_reference_robust_q42;
assign pair_reference_robust_csrstorage_storage35 = pair_reference_robust_q43;
assign pair_reference_robust_csrstorage_storage36 = pair_reference_robust_q44;
assign pair_reference_robust_csrstorage_storage37 = pair_reference_robust_q45;
assign pair_reference_robust_csrstorage_storage38 = pair_reference_robust_q46;
assign pair_reference_robust_csrstorage_storage39 = pair_reference_robust_q47;
assign pair_reference_robust_csrstorage_storage40 = pair_reference_robust_q48;
assign pair_reference_robust_csrstorage_storage41 = pair_reference_robust_q49;
assign pair_reference_robust_csrstorage_storage42 = pair_reference_robust_q50;
assign pair_reference_robust_csrstorage_storage43 = pair_reference_robust_q51;
assign pair_reference_robust_csrstorage_storage44 = pair_reference_robust_q52;
assign pair_reference_robust_csrstorage_storage45 = pair_reference_robust_q53;
assign pair_reference_robust_csrstorage_storage46 = pair_reference_robust_q54;
assign pair_reference_robust_csrstorage_storage47 = pair_reference_robust_q55;
assign pair_reference_robust_csrstorage_storage48 = pair_reference_robust_q56;
assign pair_reference_robust_csrstorage_storage49 = pair_reference_robust_q57;
assign pair_reference_robust_csrstorage_storage50 = pair_reference_robust_q58;
assign pair_reference_robust_csrstorage_storage51 = pair_reference_robust_q59;
assign pair_reference_robust_csrstorage_storage52 = pair_reference_robust_q60;
assign pair_reference_robust_csrstorage_storage53 = pair_reference_robust_q61;
assign pair_reference_robust_csrstorage_storage54 = pair_reference_robust_q62;
assign pair_reference_robust_csrstorage_storage55 = pair_reference_robust_q63;
assign pair_reference_robust_csrstorage_storage56 = pair_reference_robust_q64;
assign pair_reference_robust_csrstorage_storage57 = pair_reference_robust_q65;
assign pair_reference_robust_csrstorage_storage58 = pair_reference_robust_q66;
assign pair_reference_robust_csrstorage_storage59 = pair_reference_robust_q67;
assign pair_reference_robust_csrstorage_storage60 = pair_reference_robust_q68;
assign pair_reference_robust_csrstorage_storage61 = pair_reference_robust_q69;
assign pair_reference_robust_csrstorage_storage62 = pair_reference_robust_q70;
assign pair_reference_robust_csrstorage_storage63 = pair_reference_robust_q71;
assign pair_reference_robust_writing_data_now1 = pair_reference_robust_writing_data_now0;
assign pair_reference_robust_restart1 = pair_reference_robust_restart0;
assign pair_reference_robust_delay = pair_reference_robust_delay_value;
assign pair_reference_robust_input1 = pair_reference_robust_sum_value;
assign pair_reference_robust_delayed_sum = pair_reference_robust_output1;
assign pair_reference_robust_current_sum_diff = (pair_reference_robust_sum_value - pair_reference_robust_delayed_sum);
assign pair_reference_robust_output0 = pair_reference_robust_current_sum_diff;
assign pair_reference_robust_wrport_we = pair_reference_robust_writing_data_now1;
assign pair_reference_robust_wrport_adr = pair_reference_robust_counter;
assign pair_reference_robust_wrport_dat_w = pair_reference_robust_input1;
assign pair_reference_robust_counter_delayed = ((pair_reference_robust_counter - pair_reference_robust_delay) + 1'd1);

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_reference_robust_rdport_adr <= 13'd0;
	pair_reference_robust_rdport_adr <= pair_reference_robust_counter_delayed;
	pair_reference_robust_rdport_adr <= pair_reference_robust_counter_delayed;
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_reference_robust_output1 <= 28'sd0;
	if ((pair_reference_robust_counter < (pair_reference_robust_delay - 1'd1))) begin
		pair_reference_robust_output1 <= 1'd0;
	end else begin
		pair_reference_robust_output1 <= pair_reference_robust_rdport_dat_r;
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_fast_target_position_signed = pair_reference_fast_storage;
assign pair_candidate_fast_request_lock = pair_candidate_request_lock_storage;
assign pair_candidate_pipelinedrobustautolock_request_lock = pair_candidate_request_lock_storage;
assign pair_candidate_pipelinedrobustautolock_prefetch_current_signed = comb_array_muxed2;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_absolute0 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_current_signed >= $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_absolute0 <= pair_candidate_pipelinedrobustautolock_prefetch_current_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_absolute0 <= (-pair_candidate_pipelinedrobustautolock_prefetch_current_signed);
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_negative_low0 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_current_signed < $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_negative_low0 <= pair_candidate_pipelinedrobustautolock_prefetch_current_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_negative_low0 <= (-pair_candidate_pipelinedrobustautolock_prefetch_current_signed);
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pipelinedrobustautolock_negative_sign0 = ((pair_candidate_pipelinedrobustautolock_prefetch_current_signed > $signed({1'd0, 1'd0})) | ((pair_candidate_pipelinedrobustautolock_prefetch_current_signed < $signed({1'd0, 1'd0})) & (pair_candidate_pipelinedrobustautolock_prefetch_current_signed != 28'sd134217728)));

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_result0 <= 28'd0;
	case (pair_candidate_pipelinedrobustautolock_current_instruction_idx)
		1'd0: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage1_storage;
		end
		1'd1: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage2_storage;
		end
		2'd2: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage3_storage;
		end
		2'd3: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage4_storage;
		end
		3'd4: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage5_storage;
		end
		3'd5: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage6_storage;
		end
		3'd6: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage7_storage;
		end
		3'd7: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage8_storage;
		end
		4'd8: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage9_storage;
		end
		4'd9: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage10_storage;
		end
		4'd10: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage11_storage;
		end
		4'd11: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage12_storage;
		end
		4'd12: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage13_storage;
		end
		4'd13: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage14_storage;
		end
		4'd14: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage15_storage;
		end
		4'd15: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage16_storage;
		end
		5'd16: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage17_storage;
		end
		5'd17: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage18_storage;
		end
		5'd18: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage19_storage;
		end
		5'd19: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage20_storage;
		end
		5'd20: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage21_storage;
		end
		5'd21: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage22_storage;
		end
		5'd22: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage23_storage;
		end
		5'd23: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage24_storage;
		end
		5'd24: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage25_storage;
		end
		5'd25: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage26_storage;
		end
		5'd26: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage27_storage;
		end
		5'd27: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage28_storage;
		end
		5'd28: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage29_storage;
		end
		5'd29: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage30_storage;
		end
		5'd30: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage31_storage;
		end
		5'd31: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage0_storage;
		end
		default: begin
			pair_candidate_pipelinedrobustautolock_result0 <= pair_candidate_pipelinedrobustautolock_csrstorage31_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_result1 <= 14'd0;
	case (pair_candidate_pipelinedrobustautolock_current_instruction_idx)
		1'd0: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage33_storage;
		end
		1'd1: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage34_storage;
		end
		2'd2: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage35_storage;
		end
		2'd3: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage36_storage;
		end
		3'd4: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage37_storage;
		end
		3'd5: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage38_storage;
		end
		3'd6: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage39_storage;
		end
		3'd7: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage40_storage;
		end
		4'd8: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage41_storage;
		end
		4'd9: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage42_storage;
		end
		4'd10: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage43_storage;
		end
		4'd11: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage44_storage;
		end
		4'd12: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage45_storage;
		end
		4'd13: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage46_storage;
		end
		4'd14: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage47_storage;
		end
		4'd15: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage48_storage;
		end
		5'd16: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage49_storage;
		end
		5'd17: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage50_storage;
		end
		5'd18: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage51_storage;
		end
		5'd19: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage52_storage;
		end
		5'd20: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage53_storage;
		end
		5'd21: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage54_storage;
		end
		5'd22: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage55_storage;
		end
		5'd23: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage56_storage;
		end
		5'd24: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage57_storage;
		end
		5'd25: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage58_storage;
		end
		5'd26: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage59_storage;
		end
		5'd27: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage60_storage;
		end
		5'd28: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage61_storage;
		end
		5'd29: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage62_storage;
		end
		5'd30: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage63_storage;
		end
		5'd31: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage32_storage;
		end
		default: begin
			pair_candidate_pipelinedrobustautolock_result1 <= pair_candidate_pipelinedrobustautolock_csrstorage63_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pipelinedrobustautolock_prefetch_next_signed = pair_candidate_pipelinedrobustautolock_result0;

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_absolute1 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_next_signed >= $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_absolute1 <= pair_candidate_pipelinedrobustautolock_prefetch_next_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_absolute1 <= (-pair_candidate_pipelinedrobustautolock_prefetch_next_signed);
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_negative_low1 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_next_signed < $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_negative_low1 <= pair_candidate_pipelinedrobustautolock_prefetch_next_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_negative_low1 <= (-pair_candidate_pipelinedrobustautolock_prefetch_next_signed);
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pipelinedrobustautolock_negative_sign1 = ((pair_candidate_pipelinedrobustautolock_prefetch_next_signed > $signed({1'd0, 1'd0})) | ((pair_candidate_pipelinedrobustautolock_prefetch_next_signed < $signed({1'd0, 1'd0})) & (pair_candidate_pipelinedrobustautolock_prefetch_next_signed != 28'sd134217728)));
assign pair_candidate_pipelinedrobustautolock_prefetch_zero_signed = pair_candidate_pipelinedrobustautolock_csrstorage0_storage;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_absolute2 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_zero_signed >= $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_absolute2 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_absolute2 <= (-pair_candidate_pipelinedrobustautolock_prefetch_zero_signed);
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_negative_low2 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_prefetch_zero_signed < $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_negative_low2 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_signed;
	end else begin
		pair_candidate_pipelinedrobustautolock_negative_low2 <= (-pair_candidate_pipelinedrobustautolock_prefetch_zero_signed);
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pipelinedrobustautolock_negative_sign2 = ((pair_candidate_pipelinedrobustautolock_prefetch_zero_signed > $signed({1'd0, 1'd0})) | ((pair_candidate_pipelinedrobustautolock_prefetch_zero_signed < $signed({1'd0, 1'd0})) & (pair_candidate_pipelinedrobustautolock_prefetch_zero_signed != 28'sd134217728)));
assign pair_candidate_pipelinedrobustautolock_prefetch_selected_magnitude = comb_array_muxed3;
assign pair_candidate_pipelinedrobustautolock_prefetch_selected_negative = comb_array_muxed4;
assign pair_candidate_pipelinedrobustautolock_prefetch_selected_positive = comb_array_muxed5;
assign pair_candidate_pipelinedrobustautolock_prefetch_selected_wait = comb_array_muxed6;
assign pair_candidate_pipelinedrobustautolock_current_wait_for = pair_candidate_pipelinedrobustautolock_prefetch_selected_wait;
assign pair_candidate_pipelinedrobustautolock_writing_data_now0 = pair_candidate_pipelinedrobustautolock_writing_data_now2;
assign pair_candidate_pipelinedrobustautolock_restart0 = pair_candidate_pipelinedrobustautolock_at_start;
assign pair_candidate_pipelinedrobustautolock_input0 = pair_candidate_pipelinedrobustautolock_input2;
assign pair_candidate_pipelinedrobustautolock_delay_value = pair_candidate_pipelinedrobustautolock_time_scale_storage;
assign pair_candidate_pipelinedrobustautolock_sum_diff = pair_candidate_pipelinedrobustautolock_sum_diff_s1;
assign pair_candidate_pipelinedrobustautolock_prefetch_advance = ((((((pair_candidate_pipelinedrobustautolock2 & (~pair_candidate_pipelinedrobustautolock_all_instructions_triggered)) & pair_candidate_pipelinedrobustautolock3) & pair_candidate_pipelinedrobustautolock_watching) & pair_candidate_pipelinedrobustautolock_sign_equal) & pair_candidate_pipelinedrobustautolock_over_threshold) & pair_candidate_pipelinedrobustautolock_waited_long_enough);
assign pair_candidate_pipelinedrobustautolock_sign_equal = ((pair_candidate_pipelinedrobustautolock_sum_diff > $signed({1'd0, 1'd0})) == $signed({1'd0, pair_candidate_pipelinedrobustautolock_current_peak_positive}));

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_abs_sum_diff <= 29'sd0;
	if ((pair_candidate_pipelinedrobustautolock_sum_diff >= $signed({1'd0, 1'd0}))) begin
		pair_candidate_pipelinedrobustautolock_abs_sum_diff <= pair_candidate_pipelinedrobustautolock_sum_diff;
	end else begin
		pair_candidate_pipelinedrobustautolock_abs_sum_diff <= (1'sd1 * pair_candidate_pipelinedrobustautolock_sum_diff);
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_pipelinedrobustautolock_abs_current_peak_height = pair_candidate_pipelinedrobustautolock_prefetch_selected_magnitude;
assign pair_candidate_pipelinedrobustautolock_current_peak_positive = pair_candidate_pipelinedrobustautolock_prefetch_selected_positive;
assign pair_candidate_pipelinedrobustautolock_negative_current_peak_height = pair_candidate_pipelinedrobustautolock_prefetch_selected_negative;
assign pair_candidate_pipelinedrobustautolock_waited_long_enough = (pair_candidate_pipelinedrobustautolock_waited_for > pair_candidate_pipelinedrobustautolock_current_wait_for);
assign pair_candidate_pipelinedrobustautolock_all_instructions_triggered = (pair_candidate_pipelinedrobustautolock_current_instruction_idx >= pair_candidate_pipelinedrobustautolock_n_instructions_s1);
assign pair_candidate_pipelinedrobustautolock_turn_on_lock = (pair_candidate_pipelinedrobustautolock_all_instructions_triggered & (pair_candidate_pipelinedrobustautolock_final_waited_for >= pair_candidate_pipelinedrobustautolock_final_wait_s1));
assign pair_candidate_pipelinedrobustautolock_over_threshold = ((pair_candidate_pipelinedrobustautolock_sum_diff[28] & (pair_candidate_pipelinedrobustautolock_sum_diff != 29'sd268435456)) ? (pair_candidate_pipelinedrobustautolock_sum_diff <= pair_candidate_pipelinedrobustautolock_negative_current_peak_height) : (pair_candidate_pipelinedrobustautolock_sum_diff >= pair_candidate_pipelinedrobustautolock_abs_current_peak_height));
assign pair_candidate_pipelinedrobustautolock_writing_data_now1 = pair_candidate_pipelinedrobustautolock_writing_data_now0;
assign pair_candidate_pipelinedrobustautolock_restart1 = pair_candidate_pipelinedrobustautolock_restart0;
assign pair_candidate_pipelinedrobustautolock_delay = pair_candidate_pipelinedrobustautolock_delay_value;
assign pair_candidate_pipelinedrobustautolock_input1 = pair_candidate_pipelinedrobustautolock_sum_value;
assign pair_candidate_pipelinedrobustautolock_delayed_sum = pair_candidate_pipelinedrobustautolock_output1;
assign pair_candidate_pipelinedrobustautolock_current_sum_diff = (pair_candidate_pipelinedrobustautolock_sum_value - pair_candidate_pipelinedrobustautolock_delayed_sum);
assign pair_candidate_pipelinedrobustautolock_output0 = pair_candidate_pipelinedrobustautolock_current_sum_diff;
assign pair_candidate_pipelinedrobustautolock_wrport_we = pair_candidate_pipelinedrobustautolock_writing_data_now1;
assign pair_candidate_pipelinedrobustautolock_wrport_adr = pair_candidate_pipelinedrobustautolock_counter;
assign pair_candidate_pipelinedrobustautolock_wrport_dat_w = pair_candidate_pipelinedrobustautolock_input1;
assign pair_candidate_pipelinedrobustautolock_counter_delayed = ((pair_candidate_pipelinedrobustautolock_counter - pair_candidate_pipelinedrobustautolock_delay) + 1'd1);

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_rdport_adr <= 13'd0;
	pair_candidate_pipelinedrobustautolock_rdport_adr <= pair_candidate_pipelinedrobustautolock_counter_delayed;
	pair_candidate_pipelinedrobustautolock_rdport_adr <= pair_candidate_pipelinedrobustautolock_counter_delayed;
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	pair_candidate_pipelinedrobustautolock_output1 <= 28'sd0;
	if ((pair_candidate_pipelinedrobustautolock_counter < (pair_candidate_pipelinedrobustautolock_delay - 1'd1))) begin
		pair_candidate_pipelinedrobustautolock_output1 <= 1'd0;
	end else begin
		pair_candidate_pipelinedrobustautolock_output1 <= pair_candidate_pipelinedrobustautolock_rdport_dat_r;
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_fast_target_position_signed = pair_candidate_fast_storage;
assign pair_rb_sel = (pair_rb_bus_adr[13:9] == 1'd0);
assign pair_rb_robust_time_scale1_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_time_scale1_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 1'd0));
assign pair_rb_robust_time_scale0_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_time_scale0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 1'd1));
assign pair_rb_robust_N_instructions0_r = pair_rb_bus_dat_w[4:0];
assign pair_rb_robust_N_instructions0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 2'd2));
assign pair_rb_robust_final_wait_time1_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_final_wait_time1_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 2'd3));
assign pair_rb_robust_final_wait_time0_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_final_wait_time0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 3'd4));
assign pair_rb_robust_peak_height_03_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_03_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 3'd5));
assign pair_rb_robust_peak_height_02_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_02_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 3'd6));
assign pair_rb_robust_peak_height_01_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_01_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 3'd7));
assign pair_rb_robust_peak_height_00_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_00_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd8));
assign pair_rb_robust_peak_height_13_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_13_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd9));
assign pair_rb_robust_peak_height_12_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_12_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd10));
assign pair_rb_robust_peak_height_11_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_11_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd11));
assign pair_rb_robust_peak_height_10_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_10_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd12));
assign pair_rb_robust_peak_height_23_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_23_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd13));
assign pair_rb_robust_peak_height_22_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_22_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd14));
assign pair_rb_robust_peak_height_21_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_21_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 4'd15));
assign pair_rb_robust_peak_height_20_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_20_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd16));
assign pair_rb_robust_peak_height_33_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_33_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd17));
assign pair_rb_robust_peak_height_32_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_32_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd18));
assign pair_rb_robust_peak_height_31_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_31_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd19));
assign pair_rb_robust_peak_height_30_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_30_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd20));
assign pair_rb_robust_peak_height_43_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_43_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd21));
assign pair_rb_robust_peak_height_42_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_42_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd22));
assign pair_rb_robust_peak_height_41_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_41_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd23));
assign pair_rb_robust_peak_height_40_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_40_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd24));
assign pair_rb_robust_peak_height_53_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_53_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd25));
assign pair_rb_robust_peak_height_52_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_52_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd26));
assign pair_rb_robust_peak_height_51_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_51_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd27));
assign pair_rb_robust_peak_height_50_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_50_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd28));
assign pair_rb_robust_peak_height_63_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_63_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd29));
assign pair_rb_robust_peak_height_62_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_62_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd30));
assign pair_rb_robust_peak_height_61_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_61_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 5'd31));
assign pair_rb_robust_peak_height_60_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_60_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd32));
assign pair_rb_robust_peak_height_73_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_73_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd33));
assign pair_rb_robust_peak_height_72_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_72_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd34));
assign pair_rb_robust_peak_height_71_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_71_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd35));
assign pair_rb_robust_peak_height_70_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_70_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd36));
assign pair_rb_robust_peak_height_83_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_83_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd37));
assign pair_rb_robust_peak_height_82_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_82_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd38));
assign pair_rb_robust_peak_height_81_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_81_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd39));
assign pair_rb_robust_peak_height_80_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_80_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd40));
assign pair_rb_robust_peak_height_93_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_93_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd41));
assign pair_rb_robust_peak_height_92_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_92_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd42));
assign pair_rb_robust_peak_height_91_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_91_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd43));
assign pair_rb_robust_peak_height_90_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_90_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd44));
assign pair_rb_robust_peak_height_103_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_103_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd45));
assign pair_rb_robust_peak_height_102_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_102_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd46));
assign pair_rb_robust_peak_height_101_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_101_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd47));
assign pair_rb_robust_peak_height_100_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_100_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd48));
assign pair_rb_robust_peak_height_113_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_113_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd49));
assign pair_rb_robust_peak_height_112_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_112_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd50));
assign pair_rb_robust_peak_height_111_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_111_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd51));
assign pair_rb_robust_peak_height_110_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_110_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd52));
assign pair_rb_robust_peak_height_123_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_123_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd53));
assign pair_rb_robust_peak_height_122_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_122_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd54));
assign pair_rb_robust_peak_height_121_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_121_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd55));
assign pair_rb_robust_peak_height_120_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_120_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd56));
assign pair_rb_robust_peak_height_133_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_133_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd57));
assign pair_rb_robust_peak_height_132_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_132_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd58));
assign pair_rb_robust_peak_height_131_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_131_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd59));
assign pair_rb_robust_peak_height_130_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_130_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd60));
assign pair_rb_robust_peak_height_143_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_143_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd61));
assign pair_rb_robust_peak_height_142_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_142_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd62));
assign pair_rb_robust_peak_height_141_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_141_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 6'd63));
assign pair_rb_robust_peak_height_140_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_140_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd64));
assign pair_rb_robust_peak_height_153_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_153_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd65));
assign pair_rb_robust_peak_height_152_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_152_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd66));
assign pair_rb_robust_peak_height_151_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_151_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd67));
assign pair_rb_robust_peak_height_150_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_150_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd68));
assign pair_rb_robust_peak_height_163_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_163_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd69));
assign pair_rb_robust_peak_height_162_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_162_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd70));
assign pair_rb_robust_peak_height_161_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_161_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd71));
assign pair_rb_robust_peak_height_160_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_160_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd72));
assign pair_rb_robust_peak_height_173_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_173_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd73));
assign pair_rb_robust_peak_height_172_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_172_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd74));
assign pair_rb_robust_peak_height_171_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_171_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd75));
assign pair_rb_robust_peak_height_170_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_170_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd76));
assign pair_rb_robust_peak_height_183_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_183_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd77));
assign pair_rb_robust_peak_height_182_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_182_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd78));
assign pair_rb_robust_peak_height_181_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_181_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd79));
assign pair_rb_robust_peak_height_180_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_180_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd80));
assign pair_rb_robust_peak_height_193_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_193_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd81));
assign pair_rb_robust_peak_height_192_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_192_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd82));
assign pair_rb_robust_peak_height_191_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_191_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd83));
assign pair_rb_robust_peak_height_190_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_190_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd84));
assign pair_rb_robust_peak_height_203_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_203_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd85));
assign pair_rb_robust_peak_height_202_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_202_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd86));
assign pair_rb_robust_peak_height_201_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_201_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd87));
assign pair_rb_robust_peak_height_200_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_200_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd88));
assign pair_rb_robust_peak_height_213_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_213_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd89));
assign pair_rb_robust_peak_height_212_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_212_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd90));
assign pair_rb_robust_peak_height_211_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_211_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd91));
assign pair_rb_robust_peak_height_210_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_210_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd92));
assign pair_rb_robust_peak_height_223_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_223_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd93));
assign pair_rb_robust_peak_height_222_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_222_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd94));
assign pair_rb_robust_peak_height_221_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_221_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd95));
assign pair_rb_robust_peak_height_220_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_220_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd96));
assign pair_rb_robust_peak_height_233_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_233_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd97));
assign pair_rb_robust_peak_height_232_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_232_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd98));
assign pair_rb_robust_peak_height_231_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_231_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd99));
assign pair_rb_robust_peak_height_230_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_230_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd100));
assign pair_rb_robust_peak_height_243_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_243_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd101));
assign pair_rb_robust_peak_height_242_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_242_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd102));
assign pair_rb_robust_peak_height_241_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_241_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd103));
assign pair_rb_robust_peak_height_240_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_240_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd104));
assign pair_rb_robust_peak_height_253_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_253_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd105));
assign pair_rb_robust_peak_height_252_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_252_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd106));
assign pair_rb_robust_peak_height_251_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_251_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd107));
assign pair_rb_robust_peak_height_250_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_250_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd108));
assign pair_rb_robust_peak_height_263_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_263_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd109));
assign pair_rb_robust_peak_height_262_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_262_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd110));
assign pair_rb_robust_peak_height_261_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_261_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd111));
assign pair_rb_robust_peak_height_260_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_260_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd112));
assign pair_rb_robust_peak_height_273_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_273_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd113));
assign pair_rb_robust_peak_height_272_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_272_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd114));
assign pair_rb_robust_peak_height_271_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_271_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd115));
assign pair_rb_robust_peak_height_270_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_270_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd116));
assign pair_rb_robust_peak_height_283_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_283_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd117));
assign pair_rb_robust_peak_height_282_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_282_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd118));
assign pair_rb_robust_peak_height_281_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_281_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd119));
assign pair_rb_robust_peak_height_280_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_280_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd120));
assign pair_rb_robust_peak_height_293_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_293_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd121));
assign pair_rb_robust_peak_height_292_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_292_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd122));
assign pair_rb_robust_peak_height_291_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_291_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd123));
assign pair_rb_robust_peak_height_290_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_290_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd124));
assign pair_rb_robust_peak_height_303_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_303_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd125));
assign pair_rb_robust_peak_height_302_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_302_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd126));
assign pair_rb_robust_peak_height_301_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_301_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 7'd127));
assign pair_rb_robust_peak_height_300_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_300_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd128));
assign pair_rb_robust_peak_height_313_r = pair_rb_bus_dat_w[3:0];
assign pair_rb_robust_peak_height_313_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd129));
assign pair_rb_robust_peak_height_312_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_312_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd130));
assign pair_rb_robust_peak_height_311_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_311_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd131));
assign pair_rb_robust_peak_height_310_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_peak_height_310_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd132));
assign pair_rb_robust_wait_for_01_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_01_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd133));
assign pair_rb_robust_wait_for_00_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_00_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd134));
assign pair_rb_robust_wait_for_11_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_11_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd135));
assign pair_rb_robust_wait_for_10_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_10_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd136));
assign pair_rb_robust_wait_for_21_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_21_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd137));
assign pair_rb_robust_wait_for_20_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_20_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd138));
assign pair_rb_robust_wait_for_31_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_31_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd139));
assign pair_rb_robust_wait_for_30_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_30_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd140));
assign pair_rb_robust_wait_for_41_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_41_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd141));
assign pair_rb_robust_wait_for_40_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_40_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd142));
assign pair_rb_robust_wait_for_51_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_51_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd143));
assign pair_rb_robust_wait_for_50_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_50_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd144));
assign pair_rb_robust_wait_for_61_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_61_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd145));
assign pair_rb_robust_wait_for_60_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_60_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd146));
assign pair_rb_robust_wait_for_71_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_71_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd147));
assign pair_rb_robust_wait_for_70_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_70_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd148));
assign pair_rb_robust_wait_for_81_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_81_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd149));
assign pair_rb_robust_wait_for_80_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_80_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd150));
assign pair_rb_robust_wait_for_91_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_91_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd151));
assign pair_rb_robust_wait_for_90_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_90_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd152));
assign pair_rb_robust_wait_for_101_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_101_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd153));
assign pair_rb_robust_wait_for_100_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_100_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd154));
assign pair_rb_robust_wait_for_111_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_111_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd155));
assign pair_rb_robust_wait_for_110_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_110_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd156));
assign pair_rb_robust_wait_for_121_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_121_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd157));
assign pair_rb_robust_wait_for_120_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_120_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd158));
assign pair_rb_robust_wait_for_131_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_131_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd159));
assign pair_rb_robust_wait_for_130_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_130_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd160));
assign pair_rb_robust_wait_for_141_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_141_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd161));
assign pair_rb_robust_wait_for_140_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_140_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd162));
assign pair_rb_robust_wait_for_151_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_151_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd163));
assign pair_rb_robust_wait_for_150_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_150_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd164));
assign pair_rb_robust_wait_for_161_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_161_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd165));
assign pair_rb_robust_wait_for_160_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_160_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd166));
assign pair_rb_robust_wait_for_171_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_171_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd167));
assign pair_rb_robust_wait_for_170_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_170_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd168));
assign pair_rb_robust_wait_for_181_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_181_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd169));
assign pair_rb_robust_wait_for_180_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_180_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd170));
assign pair_rb_robust_wait_for_191_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_191_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd171));
assign pair_rb_robust_wait_for_190_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_190_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd172));
assign pair_rb_robust_wait_for_201_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_201_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd173));
assign pair_rb_robust_wait_for_200_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_200_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd174));
assign pair_rb_robust_wait_for_211_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_211_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd175));
assign pair_rb_robust_wait_for_210_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_210_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd176));
assign pair_rb_robust_wait_for_221_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_221_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd177));
assign pair_rb_robust_wait_for_220_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_220_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd178));
assign pair_rb_robust_wait_for_231_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_231_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd179));
assign pair_rb_robust_wait_for_230_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_230_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd180));
assign pair_rb_robust_wait_for_241_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_241_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd181));
assign pair_rb_robust_wait_for_240_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_240_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd182));
assign pair_rb_robust_wait_for_251_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_251_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd183));
assign pair_rb_robust_wait_for_250_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_250_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd184));
assign pair_rb_robust_wait_for_261_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_261_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd185));
assign pair_rb_robust_wait_for_260_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_260_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd186));
assign pair_rb_robust_wait_for_271_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_271_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd187));
assign pair_rb_robust_wait_for_270_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_270_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd188));
assign pair_rb_robust_wait_for_281_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_281_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd189));
assign pair_rb_robust_wait_for_280_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_280_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd190));
assign pair_rb_robust_wait_for_291_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_291_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd191));
assign pair_rb_robust_wait_for_290_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_290_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd192));
assign pair_rb_robust_wait_for_301_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_301_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd193));
assign pair_rb_robust_wait_for_300_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_300_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd194));
assign pair_rb_robust_wait_for_311_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_robust_wait_for_311_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd195));
assign pair_rb_robust_wait_for_310_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_robust_wait_for_310_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd196));
assign pair_rb_fast_target_position1_r = pair_rb_bus_dat_w[5:0];
assign pair_rb_fast_target_position1_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd197));
assign pair_rb_fast_target_position0_r = pair_rb_bus_dat_w[7:0];
assign pair_rb_fast_target_position0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd198));
assign pair_rb_request_lock0_r = pair_rb_bus_dat_w[0];
assign pair_rb_request_lock0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd199));
assign pair_rb_autolock_mode0_r = pair_rb_bus_dat_w[1:0];
assign pair_rb_autolock_mode0_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd200));
assign pair_rb_lock_running_r = pair_rb_bus_dat_w[0];
assign pair_rb_lock_running_re = ((pair_rb_sel & pair_rb_bus_we) & (pair_rb_bus_adr[7:0] == 8'd201));
assign pair_reference_robust_csrstorage0_storage = pair_reference_robust_csrstorage0_storage_full[13:0];
assign pair_rb_robust_time_scale1_w = pair_reference_robust_csrstorage0_storage_full[13:8];
assign pair_rb_robust_time_scale0_w = pair_reference_robust_csrstorage0_storage_full[7:0];
assign pair_reference_robust_csrstorage1_storage = pair_reference_robust_csrstorage1_storage_full[4:0];
assign pair_rb_robust_N_instructions0_w = pair_reference_robust_csrstorage1_storage_full[4:0];
assign pair_reference_robust_csrstorage2_storage = pair_reference_robust_csrstorage2_storage_full[13:0];
assign pair_rb_robust_final_wait_time1_w = pair_reference_robust_csrstorage2_storage_full[13:8];
assign pair_rb_robust_final_wait_time0_w = pair_reference_robust_csrstorage2_storage_full[7:0];
assign pair_reference_robust_csrstorage3_storage = pair_reference_robust_csrstorage3_storage_full[27:0];
assign pair_rb_robust_peak_height_03_w = pair_reference_robust_csrstorage3_storage_full[27:24];
assign pair_rb_robust_peak_height_02_w = pair_reference_robust_csrstorage3_storage_full[23:16];
assign pair_rb_robust_peak_height_01_w = pair_reference_robust_csrstorage3_storage_full[15:8];
assign pair_rb_robust_peak_height_00_w = pair_reference_robust_csrstorage3_storage_full[7:0];
assign pair_reference_robust_csrstorage4_storage = pair_reference_robust_csrstorage4_storage_full[27:0];
assign pair_rb_robust_peak_height_13_w = pair_reference_robust_csrstorage4_storage_full[27:24];
assign pair_rb_robust_peak_height_12_w = pair_reference_robust_csrstorage4_storage_full[23:16];
assign pair_rb_robust_peak_height_11_w = pair_reference_robust_csrstorage4_storage_full[15:8];
assign pair_rb_robust_peak_height_10_w = pair_reference_robust_csrstorage4_storage_full[7:0];
assign pair_reference_robust_csrstorage5_storage = pair_reference_robust_csrstorage5_storage_full[27:0];
assign pair_rb_robust_peak_height_23_w = pair_reference_robust_csrstorage5_storage_full[27:24];
assign pair_rb_robust_peak_height_22_w = pair_reference_robust_csrstorage5_storage_full[23:16];
assign pair_rb_robust_peak_height_21_w = pair_reference_robust_csrstorage5_storage_full[15:8];
assign pair_rb_robust_peak_height_20_w = pair_reference_robust_csrstorage5_storage_full[7:0];
assign pair_reference_robust_csrstorage6_storage = pair_reference_robust_csrstorage6_storage_full[27:0];
assign pair_rb_robust_peak_height_33_w = pair_reference_robust_csrstorage6_storage_full[27:24];
assign pair_rb_robust_peak_height_32_w = pair_reference_robust_csrstorage6_storage_full[23:16];
assign pair_rb_robust_peak_height_31_w = pair_reference_robust_csrstorage6_storage_full[15:8];
assign pair_rb_robust_peak_height_30_w = pair_reference_robust_csrstorage6_storage_full[7:0];
assign pair_reference_robust_csrstorage7_storage = pair_reference_robust_csrstorage7_storage_full[27:0];
assign pair_rb_robust_peak_height_43_w = pair_reference_robust_csrstorage7_storage_full[27:24];
assign pair_rb_robust_peak_height_42_w = pair_reference_robust_csrstorage7_storage_full[23:16];
assign pair_rb_robust_peak_height_41_w = pair_reference_robust_csrstorage7_storage_full[15:8];
assign pair_rb_robust_peak_height_40_w = pair_reference_robust_csrstorage7_storage_full[7:0];
assign pair_reference_robust_csrstorage8_storage = pair_reference_robust_csrstorage8_storage_full[27:0];
assign pair_rb_robust_peak_height_53_w = pair_reference_robust_csrstorage8_storage_full[27:24];
assign pair_rb_robust_peak_height_52_w = pair_reference_robust_csrstorage8_storage_full[23:16];
assign pair_rb_robust_peak_height_51_w = pair_reference_robust_csrstorage8_storage_full[15:8];
assign pair_rb_robust_peak_height_50_w = pair_reference_robust_csrstorage8_storage_full[7:0];
assign pair_reference_robust_csrstorage9_storage = pair_reference_robust_csrstorage9_storage_full[27:0];
assign pair_rb_robust_peak_height_63_w = pair_reference_robust_csrstorage9_storage_full[27:24];
assign pair_rb_robust_peak_height_62_w = pair_reference_robust_csrstorage9_storage_full[23:16];
assign pair_rb_robust_peak_height_61_w = pair_reference_robust_csrstorage9_storage_full[15:8];
assign pair_rb_robust_peak_height_60_w = pair_reference_robust_csrstorage9_storage_full[7:0];
assign pair_reference_robust_csrstorage10_storage = pair_reference_robust_csrstorage10_storage_full[27:0];
assign pair_rb_robust_peak_height_73_w = pair_reference_robust_csrstorage10_storage_full[27:24];
assign pair_rb_robust_peak_height_72_w = pair_reference_robust_csrstorage10_storage_full[23:16];
assign pair_rb_robust_peak_height_71_w = pair_reference_robust_csrstorage10_storage_full[15:8];
assign pair_rb_robust_peak_height_70_w = pair_reference_robust_csrstorage10_storage_full[7:0];
assign pair_reference_robust_csrstorage11_storage = pair_reference_robust_csrstorage11_storage_full[27:0];
assign pair_rb_robust_peak_height_83_w = pair_reference_robust_csrstorage11_storage_full[27:24];
assign pair_rb_robust_peak_height_82_w = pair_reference_robust_csrstorage11_storage_full[23:16];
assign pair_rb_robust_peak_height_81_w = pair_reference_robust_csrstorage11_storage_full[15:8];
assign pair_rb_robust_peak_height_80_w = pair_reference_robust_csrstorage11_storage_full[7:0];
assign pair_reference_robust_csrstorage12_storage = pair_reference_robust_csrstorage12_storage_full[27:0];
assign pair_rb_robust_peak_height_93_w = pair_reference_robust_csrstorage12_storage_full[27:24];
assign pair_rb_robust_peak_height_92_w = pair_reference_robust_csrstorage12_storage_full[23:16];
assign pair_rb_robust_peak_height_91_w = pair_reference_robust_csrstorage12_storage_full[15:8];
assign pair_rb_robust_peak_height_90_w = pair_reference_robust_csrstorage12_storage_full[7:0];
assign pair_reference_robust_csrstorage13_storage = pair_reference_robust_csrstorage13_storage_full[27:0];
assign pair_rb_robust_peak_height_103_w = pair_reference_robust_csrstorage13_storage_full[27:24];
assign pair_rb_robust_peak_height_102_w = pair_reference_robust_csrstorage13_storage_full[23:16];
assign pair_rb_robust_peak_height_101_w = pair_reference_robust_csrstorage13_storage_full[15:8];
assign pair_rb_robust_peak_height_100_w = pair_reference_robust_csrstorage13_storage_full[7:0];
assign pair_reference_robust_csrstorage14_storage = pair_reference_robust_csrstorage14_storage_full[27:0];
assign pair_rb_robust_peak_height_113_w = pair_reference_robust_csrstorage14_storage_full[27:24];
assign pair_rb_robust_peak_height_112_w = pair_reference_robust_csrstorage14_storage_full[23:16];
assign pair_rb_robust_peak_height_111_w = pair_reference_robust_csrstorage14_storage_full[15:8];
assign pair_rb_robust_peak_height_110_w = pair_reference_robust_csrstorage14_storage_full[7:0];
assign pair_reference_robust_csrstorage15_storage = pair_reference_robust_csrstorage15_storage_full[27:0];
assign pair_rb_robust_peak_height_123_w = pair_reference_robust_csrstorage15_storage_full[27:24];
assign pair_rb_robust_peak_height_122_w = pair_reference_robust_csrstorage15_storage_full[23:16];
assign pair_rb_robust_peak_height_121_w = pair_reference_robust_csrstorage15_storage_full[15:8];
assign pair_rb_robust_peak_height_120_w = pair_reference_robust_csrstorage15_storage_full[7:0];
assign pair_reference_robust_csrstorage16_storage = pair_reference_robust_csrstorage16_storage_full[27:0];
assign pair_rb_robust_peak_height_133_w = pair_reference_robust_csrstorage16_storage_full[27:24];
assign pair_rb_robust_peak_height_132_w = pair_reference_robust_csrstorage16_storage_full[23:16];
assign pair_rb_robust_peak_height_131_w = pair_reference_robust_csrstorage16_storage_full[15:8];
assign pair_rb_robust_peak_height_130_w = pair_reference_robust_csrstorage16_storage_full[7:0];
assign pair_reference_robust_csrstorage17_storage = pair_reference_robust_csrstorage17_storage_full[27:0];
assign pair_rb_robust_peak_height_143_w = pair_reference_robust_csrstorage17_storage_full[27:24];
assign pair_rb_robust_peak_height_142_w = pair_reference_robust_csrstorage17_storage_full[23:16];
assign pair_rb_robust_peak_height_141_w = pair_reference_robust_csrstorage17_storage_full[15:8];
assign pair_rb_robust_peak_height_140_w = pair_reference_robust_csrstorage17_storage_full[7:0];
assign pair_reference_robust_csrstorage18_storage = pair_reference_robust_csrstorage18_storage_full[27:0];
assign pair_rb_robust_peak_height_153_w = pair_reference_robust_csrstorage18_storage_full[27:24];
assign pair_rb_robust_peak_height_152_w = pair_reference_robust_csrstorage18_storage_full[23:16];
assign pair_rb_robust_peak_height_151_w = pair_reference_robust_csrstorage18_storage_full[15:8];
assign pair_rb_robust_peak_height_150_w = pair_reference_robust_csrstorage18_storage_full[7:0];
assign pair_reference_robust_csrstorage19_storage = pair_reference_robust_csrstorage19_storage_full[27:0];
assign pair_rb_robust_peak_height_163_w = pair_reference_robust_csrstorage19_storage_full[27:24];
assign pair_rb_robust_peak_height_162_w = pair_reference_robust_csrstorage19_storage_full[23:16];
assign pair_rb_robust_peak_height_161_w = pair_reference_robust_csrstorage19_storage_full[15:8];
assign pair_rb_robust_peak_height_160_w = pair_reference_robust_csrstorage19_storage_full[7:0];
assign pair_reference_robust_csrstorage20_storage = pair_reference_robust_csrstorage20_storage_full[27:0];
assign pair_rb_robust_peak_height_173_w = pair_reference_robust_csrstorage20_storage_full[27:24];
assign pair_rb_robust_peak_height_172_w = pair_reference_robust_csrstorage20_storage_full[23:16];
assign pair_rb_robust_peak_height_171_w = pair_reference_robust_csrstorage20_storage_full[15:8];
assign pair_rb_robust_peak_height_170_w = pair_reference_robust_csrstorage20_storage_full[7:0];
assign pair_reference_robust_csrstorage21_storage = pair_reference_robust_csrstorage21_storage_full[27:0];
assign pair_rb_robust_peak_height_183_w = pair_reference_robust_csrstorage21_storage_full[27:24];
assign pair_rb_robust_peak_height_182_w = pair_reference_robust_csrstorage21_storage_full[23:16];
assign pair_rb_robust_peak_height_181_w = pair_reference_robust_csrstorage21_storage_full[15:8];
assign pair_rb_robust_peak_height_180_w = pair_reference_robust_csrstorage21_storage_full[7:0];
assign pair_reference_robust_csrstorage22_storage = pair_reference_robust_csrstorage22_storage_full[27:0];
assign pair_rb_robust_peak_height_193_w = pair_reference_robust_csrstorage22_storage_full[27:24];
assign pair_rb_robust_peak_height_192_w = pair_reference_robust_csrstorage22_storage_full[23:16];
assign pair_rb_robust_peak_height_191_w = pair_reference_robust_csrstorage22_storage_full[15:8];
assign pair_rb_robust_peak_height_190_w = pair_reference_robust_csrstorage22_storage_full[7:0];
assign pair_reference_robust_csrstorage23_storage = pair_reference_robust_csrstorage23_storage_full[27:0];
assign pair_rb_robust_peak_height_203_w = pair_reference_robust_csrstorage23_storage_full[27:24];
assign pair_rb_robust_peak_height_202_w = pair_reference_robust_csrstorage23_storage_full[23:16];
assign pair_rb_robust_peak_height_201_w = pair_reference_robust_csrstorage23_storage_full[15:8];
assign pair_rb_robust_peak_height_200_w = pair_reference_robust_csrstorage23_storage_full[7:0];
assign pair_reference_robust_csrstorage24_storage = pair_reference_robust_csrstorage24_storage_full[27:0];
assign pair_rb_robust_peak_height_213_w = pair_reference_robust_csrstorage24_storage_full[27:24];
assign pair_rb_robust_peak_height_212_w = pair_reference_robust_csrstorage24_storage_full[23:16];
assign pair_rb_robust_peak_height_211_w = pair_reference_robust_csrstorage24_storage_full[15:8];
assign pair_rb_robust_peak_height_210_w = pair_reference_robust_csrstorage24_storage_full[7:0];
assign pair_reference_robust_csrstorage25_storage = pair_reference_robust_csrstorage25_storage_full[27:0];
assign pair_rb_robust_peak_height_223_w = pair_reference_robust_csrstorage25_storage_full[27:24];
assign pair_rb_robust_peak_height_222_w = pair_reference_robust_csrstorage25_storage_full[23:16];
assign pair_rb_robust_peak_height_221_w = pair_reference_robust_csrstorage25_storage_full[15:8];
assign pair_rb_robust_peak_height_220_w = pair_reference_robust_csrstorage25_storage_full[7:0];
assign pair_reference_robust_csrstorage26_storage = pair_reference_robust_csrstorage26_storage_full[27:0];
assign pair_rb_robust_peak_height_233_w = pair_reference_robust_csrstorage26_storage_full[27:24];
assign pair_rb_robust_peak_height_232_w = pair_reference_robust_csrstorage26_storage_full[23:16];
assign pair_rb_robust_peak_height_231_w = pair_reference_robust_csrstorage26_storage_full[15:8];
assign pair_rb_robust_peak_height_230_w = pair_reference_robust_csrstorage26_storage_full[7:0];
assign pair_reference_robust_csrstorage27_storage = pair_reference_robust_csrstorage27_storage_full[27:0];
assign pair_rb_robust_peak_height_243_w = pair_reference_robust_csrstorage27_storage_full[27:24];
assign pair_rb_robust_peak_height_242_w = pair_reference_robust_csrstorage27_storage_full[23:16];
assign pair_rb_robust_peak_height_241_w = pair_reference_robust_csrstorage27_storage_full[15:8];
assign pair_rb_robust_peak_height_240_w = pair_reference_robust_csrstorage27_storage_full[7:0];
assign pair_reference_robust_csrstorage28_storage = pair_reference_robust_csrstorage28_storage_full[27:0];
assign pair_rb_robust_peak_height_253_w = pair_reference_robust_csrstorage28_storage_full[27:24];
assign pair_rb_robust_peak_height_252_w = pair_reference_robust_csrstorage28_storage_full[23:16];
assign pair_rb_robust_peak_height_251_w = pair_reference_robust_csrstorage28_storage_full[15:8];
assign pair_rb_robust_peak_height_250_w = pair_reference_robust_csrstorage28_storage_full[7:0];
assign pair_reference_robust_csrstorage29_storage = pair_reference_robust_csrstorage29_storage_full[27:0];
assign pair_rb_robust_peak_height_263_w = pair_reference_robust_csrstorage29_storage_full[27:24];
assign pair_rb_robust_peak_height_262_w = pair_reference_robust_csrstorage29_storage_full[23:16];
assign pair_rb_robust_peak_height_261_w = pair_reference_robust_csrstorage29_storage_full[15:8];
assign pair_rb_robust_peak_height_260_w = pair_reference_robust_csrstorage29_storage_full[7:0];
assign pair_reference_robust_csrstorage30_storage = pair_reference_robust_csrstorage30_storage_full[27:0];
assign pair_rb_robust_peak_height_273_w = pair_reference_robust_csrstorage30_storage_full[27:24];
assign pair_rb_robust_peak_height_272_w = pair_reference_robust_csrstorage30_storage_full[23:16];
assign pair_rb_robust_peak_height_271_w = pair_reference_robust_csrstorage30_storage_full[15:8];
assign pair_rb_robust_peak_height_270_w = pair_reference_robust_csrstorage30_storage_full[7:0];
assign pair_reference_robust_csrstorage31_storage = pair_reference_robust_csrstorage31_storage_full[27:0];
assign pair_rb_robust_peak_height_283_w = pair_reference_robust_csrstorage31_storage_full[27:24];
assign pair_rb_robust_peak_height_282_w = pair_reference_robust_csrstorage31_storage_full[23:16];
assign pair_rb_robust_peak_height_281_w = pair_reference_robust_csrstorage31_storage_full[15:8];
assign pair_rb_robust_peak_height_280_w = pair_reference_robust_csrstorage31_storage_full[7:0];
assign pair_reference_robust_csrstorage32_storage = pair_reference_robust_csrstorage32_storage_full[27:0];
assign pair_rb_robust_peak_height_293_w = pair_reference_robust_csrstorage32_storage_full[27:24];
assign pair_rb_robust_peak_height_292_w = pair_reference_robust_csrstorage32_storage_full[23:16];
assign pair_rb_robust_peak_height_291_w = pair_reference_robust_csrstorage32_storage_full[15:8];
assign pair_rb_robust_peak_height_290_w = pair_reference_robust_csrstorage32_storage_full[7:0];
assign pair_reference_robust_csrstorage33_storage = pair_reference_robust_csrstorage33_storage_full[27:0];
assign pair_rb_robust_peak_height_303_w = pair_reference_robust_csrstorage33_storage_full[27:24];
assign pair_rb_robust_peak_height_302_w = pair_reference_robust_csrstorage33_storage_full[23:16];
assign pair_rb_robust_peak_height_301_w = pair_reference_robust_csrstorage33_storage_full[15:8];
assign pair_rb_robust_peak_height_300_w = pair_reference_robust_csrstorage33_storage_full[7:0];
assign pair_reference_robust_csrstorage34_storage = pair_reference_robust_csrstorage34_storage_full[27:0];
assign pair_rb_robust_peak_height_313_w = pair_reference_robust_csrstorage34_storage_full[27:24];
assign pair_rb_robust_peak_height_312_w = pair_reference_robust_csrstorage34_storage_full[23:16];
assign pair_rb_robust_peak_height_311_w = pair_reference_robust_csrstorage34_storage_full[15:8];
assign pair_rb_robust_peak_height_310_w = pair_reference_robust_csrstorage34_storage_full[7:0];
assign pair_reference_robust_csrstorage35_storage = pair_reference_robust_csrstorage35_storage_full[13:0];
assign pair_rb_robust_wait_for_01_w = pair_reference_robust_csrstorage35_storage_full[13:8];
assign pair_rb_robust_wait_for_00_w = pair_reference_robust_csrstorage35_storage_full[7:0];
assign pair_reference_robust_csrstorage36_storage = pair_reference_robust_csrstorage36_storage_full[13:0];
assign pair_rb_robust_wait_for_11_w = pair_reference_robust_csrstorage36_storage_full[13:8];
assign pair_rb_robust_wait_for_10_w = pair_reference_robust_csrstorage36_storage_full[7:0];
assign pair_reference_robust_csrstorage37_storage = pair_reference_robust_csrstorage37_storage_full[13:0];
assign pair_rb_robust_wait_for_21_w = pair_reference_robust_csrstorage37_storage_full[13:8];
assign pair_rb_robust_wait_for_20_w = pair_reference_robust_csrstorage37_storage_full[7:0];
assign pair_reference_robust_csrstorage38_storage = pair_reference_robust_csrstorage38_storage_full[13:0];
assign pair_rb_robust_wait_for_31_w = pair_reference_robust_csrstorage38_storage_full[13:8];
assign pair_rb_robust_wait_for_30_w = pair_reference_robust_csrstorage38_storage_full[7:0];
assign pair_reference_robust_csrstorage39_storage = pair_reference_robust_csrstorage39_storage_full[13:0];
assign pair_rb_robust_wait_for_41_w = pair_reference_robust_csrstorage39_storage_full[13:8];
assign pair_rb_robust_wait_for_40_w = pair_reference_robust_csrstorage39_storage_full[7:0];
assign pair_reference_robust_csrstorage40_storage = pair_reference_robust_csrstorage40_storage_full[13:0];
assign pair_rb_robust_wait_for_51_w = pair_reference_robust_csrstorage40_storage_full[13:8];
assign pair_rb_robust_wait_for_50_w = pair_reference_robust_csrstorage40_storage_full[7:0];
assign pair_reference_robust_csrstorage41_storage = pair_reference_robust_csrstorage41_storage_full[13:0];
assign pair_rb_robust_wait_for_61_w = pair_reference_robust_csrstorage41_storage_full[13:8];
assign pair_rb_robust_wait_for_60_w = pair_reference_robust_csrstorage41_storage_full[7:0];
assign pair_reference_robust_csrstorage42_storage = pair_reference_robust_csrstorage42_storage_full[13:0];
assign pair_rb_robust_wait_for_71_w = pair_reference_robust_csrstorage42_storage_full[13:8];
assign pair_rb_robust_wait_for_70_w = pair_reference_robust_csrstorage42_storage_full[7:0];
assign pair_reference_robust_csrstorage43_storage = pair_reference_robust_csrstorage43_storage_full[13:0];
assign pair_rb_robust_wait_for_81_w = pair_reference_robust_csrstorage43_storage_full[13:8];
assign pair_rb_robust_wait_for_80_w = pair_reference_robust_csrstorage43_storage_full[7:0];
assign pair_reference_robust_csrstorage44_storage = pair_reference_robust_csrstorage44_storage_full[13:0];
assign pair_rb_robust_wait_for_91_w = pair_reference_robust_csrstorage44_storage_full[13:8];
assign pair_rb_robust_wait_for_90_w = pair_reference_robust_csrstorage44_storage_full[7:0];
assign pair_reference_robust_csrstorage45_storage = pair_reference_robust_csrstorage45_storage_full[13:0];
assign pair_rb_robust_wait_for_101_w = pair_reference_robust_csrstorage45_storage_full[13:8];
assign pair_rb_robust_wait_for_100_w = pair_reference_robust_csrstorage45_storage_full[7:0];
assign pair_reference_robust_csrstorage46_storage = pair_reference_robust_csrstorage46_storage_full[13:0];
assign pair_rb_robust_wait_for_111_w = pair_reference_robust_csrstorage46_storage_full[13:8];
assign pair_rb_robust_wait_for_110_w = pair_reference_robust_csrstorage46_storage_full[7:0];
assign pair_reference_robust_csrstorage47_storage = pair_reference_robust_csrstorage47_storage_full[13:0];
assign pair_rb_robust_wait_for_121_w = pair_reference_robust_csrstorage47_storage_full[13:8];
assign pair_rb_robust_wait_for_120_w = pair_reference_robust_csrstorage47_storage_full[7:0];
assign pair_reference_robust_csrstorage48_storage = pair_reference_robust_csrstorage48_storage_full[13:0];
assign pair_rb_robust_wait_for_131_w = pair_reference_robust_csrstorage48_storage_full[13:8];
assign pair_rb_robust_wait_for_130_w = pair_reference_robust_csrstorage48_storage_full[7:0];
assign pair_reference_robust_csrstorage49_storage = pair_reference_robust_csrstorage49_storage_full[13:0];
assign pair_rb_robust_wait_for_141_w = pair_reference_robust_csrstorage49_storage_full[13:8];
assign pair_rb_robust_wait_for_140_w = pair_reference_robust_csrstorage49_storage_full[7:0];
assign pair_reference_robust_csrstorage50_storage = pair_reference_robust_csrstorage50_storage_full[13:0];
assign pair_rb_robust_wait_for_151_w = pair_reference_robust_csrstorage50_storage_full[13:8];
assign pair_rb_robust_wait_for_150_w = pair_reference_robust_csrstorage50_storage_full[7:0];
assign pair_reference_robust_csrstorage51_storage = pair_reference_robust_csrstorage51_storage_full[13:0];
assign pair_rb_robust_wait_for_161_w = pair_reference_robust_csrstorage51_storage_full[13:8];
assign pair_rb_robust_wait_for_160_w = pair_reference_robust_csrstorage51_storage_full[7:0];
assign pair_reference_robust_csrstorage52_storage = pair_reference_robust_csrstorage52_storage_full[13:0];
assign pair_rb_robust_wait_for_171_w = pair_reference_robust_csrstorage52_storage_full[13:8];
assign pair_rb_robust_wait_for_170_w = pair_reference_robust_csrstorage52_storage_full[7:0];
assign pair_reference_robust_csrstorage53_storage = pair_reference_robust_csrstorage53_storage_full[13:0];
assign pair_rb_robust_wait_for_181_w = pair_reference_robust_csrstorage53_storage_full[13:8];
assign pair_rb_robust_wait_for_180_w = pair_reference_robust_csrstorage53_storage_full[7:0];
assign pair_reference_robust_csrstorage54_storage = pair_reference_robust_csrstorage54_storage_full[13:0];
assign pair_rb_robust_wait_for_191_w = pair_reference_robust_csrstorage54_storage_full[13:8];
assign pair_rb_robust_wait_for_190_w = pair_reference_robust_csrstorage54_storage_full[7:0];
assign pair_reference_robust_csrstorage55_storage = pair_reference_robust_csrstorage55_storage_full[13:0];
assign pair_rb_robust_wait_for_201_w = pair_reference_robust_csrstorage55_storage_full[13:8];
assign pair_rb_robust_wait_for_200_w = pair_reference_robust_csrstorage55_storage_full[7:0];
assign pair_reference_robust_csrstorage56_storage = pair_reference_robust_csrstorage56_storage_full[13:0];
assign pair_rb_robust_wait_for_211_w = pair_reference_robust_csrstorage56_storage_full[13:8];
assign pair_rb_robust_wait_for_210_w = pair_reference_robust_csrstorage56_storage_full[7:0];
assign pair_reference_robust_csrstorage57_storage = pair_reference_robust_csrstorage57_storage_full[13:0];
assign pair_rb_robust_wait_for_221_w = pair_reference_robust_csrstorage57_storage_full[13:8];
assign pair_rb_robust_wait_for_220_w = pair_reference_robust_csrstorage57_storage_full[7:0];
assign pair_reference_robust_csrstorage58_storage = pair_reference_robust_csrstorage58_storage_full[13:0];
assign pair_rb_robust_wait_for_231_w = pair_reference_robust_csrstorage58_storage_full[13:8];
assign pair_rb_robust_wait_for_230_w = pair_reference_robust_csrstorage58_storage_full[7:0];
assign pair_reference_robust_csrstorage59_storage = pair_reference_robust_csrstorage59_storage_full[13:0];
assign pair_rb_robust_wait_for_241_w = pair_reference_robust_csrstorage59_storage_full[13:8];
assign pair_rb_robust_wait_for_240_w = pair_reference_robust_csrstorage59_storage_full[7:0];
assign pair_reference_robust_csrstorage60_storage = pair_reference_robust_csrstorage60_storage_full[13:0];
assign pair_rb_robust_wait_for_251_w = pair_reference_robust_csrstorage60_storage_full[13:8];
assign pair_rb_robust_wait_for_250_w = pair_reference_robust_csrstorage60_storage_full[7:0];
assign pair_reference_robust_csrstorage61_storage = pair_reference_robust_csrstorage61_storage_full[13:0];
assign pair_rb_robust_wait_for_261_w = pair_reference_robust_csrstorage61_storage_full[13:8];
assign pair_rb_robust_wait_for_260_w = pair_reference_robust_csrstorage61_storage_full[7:0];
assign pair_reference_robust_csrstorage62_storage = pair_reference_robust_csrstorage62_storage_full[13:0];
assign pair_rb_robust_wait_for_271_w = pair_reference_robust_csrstorage62_storage_full[13:8];
assign pair_rb_robust_wait_for_270_w = pair_reference_robust_csrstorage62_storage_full[7:0];
assign pair_reference_robust_csrstorage63_storage = pair_reference_robust_csrstorage63_storage_full[13:0];
assign pair_rb_robust_wait_for_281_w = pair_reference_robust_csrstorage63_storage_full[13:8];
assign pair_rb_robust_wait_for_280_w = pair_reference_robust_csrstorage63_storage_full[7:0];
assign pair_reference_robust_csrstorage64_storage = pair_reference_robust_csrstorage64_storage_full[13:0];
assign pair_rb_robust_wait_for_291_w = pair_reference_robust_csrstorage64_storage_full[13:8];
assign pair_rb_robust_wait_for_290_w = pair_reference_robust_csrstorage64_storage_full[7:0];
assign pair_reference_robust_csrstorage65_storage = pair_reference_robust_csrstorage65_storage_full[13:0];
assign pair_rb_robust_wait_for_301_w = pair_reference_robust_csrstorage65_storage_full[13:8];
assign pair_rb_robust_wait_for_300_w = pair_reference_robust_csrstorage65_storage_full[7:0];
assign pair_reference_robust_csrstorage66_storage = pair_reference_robust_csrstorage66_storage_full[13:0];
assign pair_rb_robust_wait_for_311_w = pair_reference_robust_csrstorage66_storage_full[13:8];
assign pair_rb_robust_wait_for_310_w = pair_reference_robust_csrstorage66_storage_full[7:0];
assign pair_reference_fast_storage = pair_reference_fast_storage_full[13:0];
assign pair_rb_fast_target_position1_w = pair_reference_fast_storage_full[13:8];
assign pair_rb_fast_target_position0_w = pair_reference_fast_storage_full[7:0];
assign pair_reference_request_lock_storage = pair_reference_request_lock_storage_full;
assign pair_rb_request_lock0_w = pair_reference_request_lock_storage_full;
assign pair_reference_autolock_mode_storage = pair_reference_autolock_mode_storage_full[1:0];
assign pair_rb_autolock_mode0_w = pair_reference_autolock_mode_storage_full[1:0];
assign pair_rb_lock_running_w = pair_reference_status;
assign pair_cb_sel = (pair_cb_bus_adr[13:9] == 1'd0);
assign pair_cb_robust_time_scale1_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_time_scale1_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 1'd0));
assign pair_cb_robust_time_scale0_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_time_scale0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 1'd1));
assign pair_cb_robust_N_instructions0_r = pair_cb_bus_dat_w[4:0];
assign pair_cb_robust_N_instructions0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 2'd2));
assign pair_cb_robust_final_wait_time1_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_final_wait_time1_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 2'd3));
assign pair_cb_robust_final_wait_time0_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_final_wait_time0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 3'd4));
assign pair_cb_robust_peak_height_03_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_03_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 3'd5));
assign pair_cb_robust_peak_height_02_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_02_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 3'd6));
assign pair_cb_robust_peak_height_01_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_01_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 3'd7));
assign pair_cb_robust_peak_height_00_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_00_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd8));
assign pair_cb_robust_peak_height_13_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_13_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd9));
assign pair_cb_robust_peak_height_12_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_12_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd10));
assign pair_cb_robust_peak_height_11_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_11_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd11));
assign pair_cb_robust_peak_height_10_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_10_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd12));
assign pair_cb_robust_peak_height_23_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_23_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd13));
assign pair_cb_robust_peak_height_22_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_22_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd14));
assign pair_cb_robust_peak_height_21_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_21_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 4'd15));
assign pair_cb_robust_peak_height_20_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_20_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd16));
assign pair_cb_robust_peak_height_33_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_33_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd17));
assign pair_cb_robust_peak_height_32_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_32_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd18));
assign pair_cb_robust_peak_height_31_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_31_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd19));
assign pair_cb_robust_peak_height_30_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_30_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd20));
assign pair_cb_robust_peak_height_43_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_43_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd21));
assign pair_cb_robust_peak_height_42_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_42_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd22));
assign pair_cb_robust_peak_height_41_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_41_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd23));
assign pair_cb_robust_peak_height_40_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_40_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd24));
assign pair_cb_robust_peak_height_53_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_53_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd25));
assign pair_cb_robust_peak_height_52_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_52_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd26));
assign pair_cb_robust_peak_height_51_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_51_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd27));
assign pair_cb_robust_peak_height_50_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_50_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd28));
assign pair_cb_robust_peak_height_63_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_63_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd29));
assign pair_cb_robust_peak_height_62_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_62_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd30));
assign pair_cb_robust_peak_height_61_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_61_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 5'd31));
assign pair_cb_robust_peak_height_60_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_60_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd32));
assign pair_cb_robust_peak_height_73_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_73_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd33));
assign pair_cb_robust_peak_height_72_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_72_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd34));
assign pair_cb_robust_peak_height_71_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_71_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd35));
assign pair_cb_robust_peak_height_70_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_70_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd36));
assign pair_cb_robust_peak_height_83_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_83_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd37));
assign pair_cb_robust_peak_height_82_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_82_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd38));
assign pair_cb_robust_peak_height_81_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_81_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd39));
assign pair_cb_robust_peak_height_80_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_80_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd40));
assign pair_cb_robust_peak_height_93_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_93_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd41));
assign pair_cb_robust_peak_height_92_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_92_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd42));
assign pair_cb_robust_peak_height_91_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_91_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd43));
assign pair_cb_robust_peak_height_90_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_90_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd44));
assign pair_cb_robust_peak_height_103_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_103_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd45));
assign pair_cb_robust_peak_height_102_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_102_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd46));
assign pair_cb_robust_peak_height_101_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_101_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd47));
assign pair_cb_robust_peak_height_100_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_100_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd48));
assign pair_cb_robust_peak_height_113_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_113_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd49));
assign pair_cb_robust_peak_height_112_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_112_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd50));
assign pair_cb_robust_peak_height_111_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_111_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd51));
assign pair_cb_robust_peak_height_110_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_110_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd52));
assign pair_cb_robust_peak_height_123_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_123_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd53));
assign pair_cb_robust_peak_height_122_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_122_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd54));
assign pair_cb_robust_peak_height_121_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_121_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd55));
assign pair_cb_robust_peak_height_120_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_120_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd56));
assign pair_cb_robust_peak_height_133_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_133_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd57));
assign pair_cb_robust_peak_height_132_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_132_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd58));
assign pair_cb_robust_peak_height_131_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_131_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd59));
assign pair_cb_robust_peak_height_130_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_130_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd60));
assign pair_cb_robust_peak_height_143_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_143_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd61));
assign pair_cb_robust_peak_height_142_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_142_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd62));
assign pair_cb_robust_peak_height_141_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_141_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 6'd63));
assign pair_cb_robust_peak_height_140_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_140_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd64));
assign pair_cb_robust_peak_height_153_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_153_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd65));
assign pair_cb_robust_peak_height_152_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_152_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd66));
assign pair_cb_robust_peak_height_151_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_151_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd67));
assign pair_cb_robust_peak_height_150_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_150_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd68));
assign pair_cb_robust_peak_height_163_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_163_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd69));
assign pair_cb_robust_peak_height_162_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_162_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd70));
assign pair_cb_robust_peak_height_161_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_161_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd71));
assign pair_cb_robust_peak_height_160_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_160_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd72));
assign pair_cb_robust_peak_height_173_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_173_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd73));
assign pair_cb_robust_peak_height_172_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_172_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd74));
assign pair_cb_robust_peak_height_171_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_171_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd75));
assign pair_cb_robust_peak_height_170_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_170_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd76));
assign pair_cb_robust_peak_height_183_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_183_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd77));
assign pair_cb_robust_peak_height_182_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_182_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd78));
assign pair_cb_robust_peak_height_181_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_181_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd79));
assign pair_cb_robust_peak_height_180_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_180_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd80));
assign pair_cb_robust_peak_height_193_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_193_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd81));
assign pair_cb_robust_peak_height_192_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_192_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd82));
assign pair_cb_robust_peak_height_191_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_191_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd83));
assign pair_cb_robust_peak_height_190_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_190_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd84));
assign pair_cb_robust_peak_height_203_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_203_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd85));
assign pair_cb_robust_peak_height_202_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_202_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd86));
assign pair_cb_robust_peak_height_201_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_201_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd87));
assign pair_cb_robust_peak_height_200_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_200_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd88));
assign pair_cb_robust_peak_height_213_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_213_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd89));
assign pair_cb_robust_peak_height_212_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_212_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd90));
assign pair_cb_robust_peak_height_211_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_211_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd91));
assign pair_cb_robust_peak_height_210_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_210_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd92));
assign pair_cb_robust_peak_height_223_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_223_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd93));
assign pair_cb_robust_peak_height_222_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_222_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd94));
assign pair_cb_robust_peak_height_221_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_221_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd95));
assign pair_cb_robust_peak_height_220_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_220_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd96));
assign pair_cb_robust_peak_height_233_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_233_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd97));
assign pair_cb_robust_peak_height_232_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_232_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd98));
assign pair_cb_robust_peak_height_231_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_231_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd99));
assign pair_cb_robust_peak_height_230_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_230_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd100));
assign pair_cb_robust_peak_height_243_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_243_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd101));
assign pair_cb_robust_peak_height_242_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_242_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd102));
assign pair_cb_robust_peak_height_241_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_241_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd103));
assign pair_cb_robust_peak_height_240_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_240_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd104));
assign pair_cb_robust_peak_height_253_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_253_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd105));
assign pair_cb_robust_peak_height_252_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_252_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd106));
assign pair_cb_robust_peak_height_251_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_251_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd107));
assign pair_cb_robust_peak_height_250_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_250_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd108));
assign pair_cb_robust_peak_height_263_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_263_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd109));
assign pair_cb_robust_peak_height_262_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_262_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd110));
assign pair_cb_robust_peak_height_261_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_261_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd111));
assign pair_cb_robust_peak_height_260_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_260_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd112));
assign pair_cb_robust_peak_height_273_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_273_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd113));
assign pair_cb_robust_peak_height_272_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_272_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd114));
assign pair_cb_robust_peak_height_271_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_271_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd115));
assign pair_cb_robust_peak_height_270_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_270_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd116));
assign pair_cb_robust_peak_height_283_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_283_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd117));
assign pair_cb_robust_peak_height_282_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_282_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd118));
assign pair_cb_robust_peak_height_281_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_281_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd119));
assign pair_cb_robust_peak_height_280_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_280_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd120));
assign pair_cb_robust_peak_height_293_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_293_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd121));
assign pair_cb_robust_peak_height_292_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_292_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd122));
assign pair_cb_robust_peak_height_291_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_291_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd123));
assign pair_cb_robust_peak_height_290_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_290_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd124));
assign pair_cb_robust_peak_height_303_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_303_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd125));
assign pair_cb_robust_peak_height_302_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_302_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd126));
assign pair_cb_robust_peak_height_301_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_301_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 7'd127));
assign pair_cb_robust_peak_height_300_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_300_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd128));
assign pair_cb_robust_peak_height_313_r = pair_cb_bus_dat_w[3:0];
assign pair_cb_robust_peak_height_313_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd129));
assign pair_cb_robust_peak_height_312_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_312_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd130));
assign pair_cb_robust_peak_height_311_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_311_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd131));
assign pair_cb_robust_peak_height_310_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_peak_height_310_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd132));
assign pair_cb_robust_wait_for_01_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_01_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd133));
assign pair_cb_robust_wait_for_00_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_00_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd134));
assign pair_cb_robust_wait_for_11_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_11_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd135));
assign pair_cb_robust_wait_for_10_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_10_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd136));
assign pair_cb_robust_wait_for_21_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_21_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd137));
assign pair_cb_robust_wait_for_20_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_20_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd138));
assign pair_cb_robust_wait_for_31_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_31_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd139));
assign pair_cb_robust_wait_for_30_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_30_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd140));
assign pair_cb_robust_wait_for_41_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_41_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd141));
assign pair_cb_robust_wait_for_40_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_40_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd142));
assign pair_cb_robust_wait_for_51_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_51_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd143));
assign pair_cb_robust_wait_for_50_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_50_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd144));
assign pair_cb_robust_wait_for_61_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_61_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd145));
assign pair_cb_robust_wait_for_60_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_60_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd146));
assign pair_cb_robust_wait_for_71_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_71_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd147));
assign pair_cb_robust_wait_for_70_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_70_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd148));
assign pair_cb_robust_wait_for_81_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_81_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd149));
assign pair_cb_robust_wait_for_80_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_80_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd150));
assign pair_cb_robust_wait_for_91_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_91_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd151));
assign pair_cb_robust_wait_for_90_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_90_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd152));
assign pair_cb_robust_wait_for_101_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_101_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd153));
assign pair_cb_robust_wait_for_100_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_100_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd154));
assign pair_cb_robust_wait_for_111_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_111_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd155));
assign pair_cb_robust_wait_for_110_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_110_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd156));
assign pair_cb_robust_wait_for_121_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_121_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd157));
assign pair_cb_robust_wait_for_120_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_120_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd158));
assign pair_cb_robust_wait_for_131_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_131_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd159));
assign pair_cb_robust_wait_for_130_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_130_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd160));
assign pair_cb_robust_wait_for_141_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_141_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd161));
assign pair_cb_robust_wait_for_140_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_140_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd162));
assign pair_cb_robust_wait_for_151_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_151_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd163));
assign pair_cb_robust_wait_for_150_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_150_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd164));
assign pair_cb_robust_wait_for_161_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_161_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd165));
assign pair_cb_robust_wait_for_160_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_160_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd166));
assign pair_cb_robust_wait_for_171_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_171_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd167));
assign pair_cb_robust_wait_for_170_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_170_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd168));
assign pair_cb_robust_wait_for_181_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_181_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd169));
assign pair_cb_robust_wait_for_180_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_180_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd170));
assign pair_cb_robust_wait_for_191_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_191_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd171));
assign pair_cb_robust_wait_for_190_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_190_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd172));
assign pair_cb_robust_wait_for_201_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_201_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd173));
assign pair_cb_robust_wait_for_200_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_200_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd174));
assign pair_cb_robust_wait_for_211_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_211_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd175));
assign pair_cb_robust_wait_for_210_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_210_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd176));
assign pair_cb_robust_wait_for_221_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_221_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd177));
assign pair_cb_robust_wait_for_220_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_220_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd178));
assign pair_cb_robust_wait_for_231_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_231_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd179));
assign pair_cb_robust_wait_for_230_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_230_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd180));
assign pair_cb_robust_wait_for_241_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_241_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd181));
assign pair_cb_robust_wait_for_240_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_240_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd182));
assign pair_cb_robust_wait_for_251_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_251_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd183));
assign pair_cb_robust_wait_for_250_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_250_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd184));
assign pair_cb_robust_wait_for_261_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_261_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd185));
assign pair_cb_robust_wait_for_260_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_260_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd186));
assign pair_cb_robust_wait_for_271_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_271_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd187));
assign pair_cb_robust_wait_for_270_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_270_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd188));
assign pair_cb_robust_wait_for_281_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_281_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd189));
assign pair_cb_robust_wait_for_280_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_280_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd190));
assign pair_cb_robust_wait_for_291_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_291_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd191));
assign pair_cb_robust_wait_for_290_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_290_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd192));
assign pair_cb_robust_wait_for_301_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_301_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd193));
assign pair_cb_robust_wait_for_300_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_300_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd194));
assign pair_cb_robust_wait_for_311_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_robust_wait_for_311_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd195));
assign pair_cb_robust_wait_for_310_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_robust_wait_for_310_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd196));
assign pair_cb_fast_target_position1_r = pair_cb_bus_dat_w[5:0];
assign pair_cb_fast_target_position1_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd197));
assign pair_cb_fast_target_position0_r = pair_cb_bus_dat_w[7:0];
assign pair_cb_fast_target_position0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd198));
assign pair_cb_request_lock0_r = pair_cb_bus_dat_w[0];
assign pair_cb_request_lock0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd199));
assign pair_cb_autolock_mode0_r = pair_cb_bus_dat_w[1:0];
assign pair_cb_autolock_mode0_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd200));
assign pair_cb_lock_running_r = pair_cb_bus_dat_w[0];
assign pair_cb_lock_running_re = ((pair_cb_sel & pair_cb_bus_we) & (pair_cb_bus_adr[7:0] == 8'd201));
assign pair_candidate_pipelinedrobustautolock_time_scale_storage = pair_candidate_pipelinedrobustautolock_time_scale_storage_full[13:0];
assign pair_cb_robust_time_scale1_w = pair_candidate_pipelinedrobustautolock_time_scale_storage_full[13:8];
assign pair_cb_robust_time_scale0_w = pair_candidate_pipelinedrobustautolock_time_scale_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_N_instructions_storage = pair_candidate_pipelinedrobustautolock_N_instructions_storage_full[4:0];
assign pair_cb_robust_N_instructions0_w = pair_candidate_pipelinedrobustautolock_N_instructions_storage_full[4:0];
assign pair_candidate_pipelinedrobustautolock_final_wait_time_storage = pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full[13:0];
assign pair_cb_robust_final_wait_time1_w = pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full[13:8];
assign pair_cb_robust_final_wait_time0_w = pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage0_storage = pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[27:0];
assign pair_cb_robust_peak_height_03_w = pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[27:24];
assign pair_cb_robust_peak_height_02_w = pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[23:16];
assign pair_cb_robust_peak_height_01_w = pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[15:8];
assign pair_cb_robust_peak_height_00_w = pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage1_storage = pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[27:0];
assign pair_cb_robust_peak_height_13_w = pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[27:24];
assign pair_cb_robust_peak_height_12_w = pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[23:16];
assign pair_cb_robust_peak_height_11_w = pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[15:8];
assign pair_cb_robust_peak_height_10_w = pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage2_storage = pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[27:0];
assign pair_cb_robust_peak_height_23_w = pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[27:24];
assign pair_cb_robust_peak_height_22_w = pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[23:16];
assign pair_cb_robust_peak_height_21_w = pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[15:8];
assign pair_cb_robust_peak_height_20_w = pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage3_storage = pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[27:0];
assign pair_cb_robust_peak_height_33_w = pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[27:24];
assign pair_cb_robust_peak_height_32_w = pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[23:16];
assign pair_cb_robust_peak_height_31_w = pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[15:8];
assign pair_cb_robust_peak_height_30_w = pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage4_storage = pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[27:0];
assign pair_cb_robust_peak_height_43_w = pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[27:24];
assign pair_cb_robust_peak_height_42_w = pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[23:16];
assign pair_cb_robust_peak_height_41_w = pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[15:8];
assign pair_cb_robust_peak_height_40_w = pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage5_storage = pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[27:0];
assign pair_cb_robust_peak_height_53_w = pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[27:24];
assign pair_cb_robust_peak_height_52_w = pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[23:16];
assign pair_cb_robust_peak_height_51_w = pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[15:8];
assign pair_cb_robust_peak_height_50_w = pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage6_storage = pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[27:0];
assign pair_cb_robust_peak_height_63_w = pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[27:24];
assign pair_cb_robust_peak_height_62_w = pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[23:16];
assign pair_cb_robust_peak_height_61_w = pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[15:8];
assign pair_cb_robust_peak_height_60_w = pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage7_storage = pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[27:0];
assign pair_cb_robust_peak_height_73_w = pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[27:24];
assign pair_cb_robust_peak_height_72_w = pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[23:16];
assign pair_cb_robust_peak_height_71_w = pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[15:8];
assign pair_cb_robust_peak_height_70_w = pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage8_storage = pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[27:0];
assign pair_cb_robust_peak_height_83_w = pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[27:24];
assign pair_cb_robust_peak_height_82_w = pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[23:16];
assign pair_cb_robust_peak_height_81_w = pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[15:8];
assign pair_cb_robust_peak_height_80_w = pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage9_storage = pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[27:0];
assign pair_cb_robust_peak_height_93_w = pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[27:24];
assign pair_cb_robust_peak_height_92_w = pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[23:16];
assign pair_cb_robust_peak_height_91_w = pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[15:8];
assign pair_cb_robust_peak_height_90_w = pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage10_storage = pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[27:0];
assign pair_cb_robust_peak_height_103_w = pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[27:24];
assign pair_cb_robust_peak_height_102_w = pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[23:16];
assign pair_cb_robust_peak_height_101_w = pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[15:8];
assign pair_cb_robust_peak_height_100_w = pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage11_storage = pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[27:0];
assign pair_cb_robust_peak_height_113_w = pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[27:24];
assign pair_cb_robust_peak_height_112_w = pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[23:16];
assign pair_cb_robust_peak_height_111_w = pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[15:8];
assign pair_cb_robust_peak_height_110_w = pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage12_storage = pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[27:0];
assign pair_cb_robust_peak_height_123_w = pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[27:24];
assign pair_cb_robust_peak_height_122_w = pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[23:16];
assign pair_cb_robust_peak_height_121_w = pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[15:8];
assign pair_cb_robust_peak_height_120_w = pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage13_storage = pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[27:0];
assign pair_cb_robust_peak_height_133_w = pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[27:24];
assign pair_cb_robust_peak_height_132_w = pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[23:16];
assign pair_cb_robust_peak_height_131_w = pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[15:8];
assign pair_cb_robust_peak_height_130_w = pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage14_storage = pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[27:0];
assign pair_cb_robust_peak_height_143_w = pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[27:24];
assign pair_cb_robust_peak_height_142_w = pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[23:16];
assign pair_cb_robust_peak_height_141_w = pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[15:8];
assign pair_cb_robust_peak_height_140_w = pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage15_storage = pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[27:0];
assign pair_cb_robust_peak_height_153_w = pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[27:24];
assign pair_cb_robust_peak_height_152_w = pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[23:16];
assign pair_cb_robust_peak_height_151_w = pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[15:8];
assign pair_cb_robust_peak_height_150_w = pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage16_storage = pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[27:0];
assign pair_cb_robust_peak_height_163_w = pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[27:24];
assign pair_cb_robust_peak_height_162_w = pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[23:16];
assign pair_cb_robust_peak_height_161_w = pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[15:8];
assign pair_cb_robust_peak_height_160_w = pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage17_storage = pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[27:0];
assign pair_cb_robust_peak_height_173_w = pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[27:24];
assign pair_cb_robust_peak_height_172_w = pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[23:16];
assign pair_cb_robust_peak_height_171_w = pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[15:8];
assign pair_cb_robust_peak_height_170_w = pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage18_storage = pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[27:0];
assign pair_cb_robust_peak_height_183_w = pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[27:24];
assign pair_cb_robust_peak_height_182_w = pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[23:16];
assign pair_cb_robust_peak_height_181_w = pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[15:8];
assign pair_cb_robust_peak_height_180_w = pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage19_storage = pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[27:0];
assign pair_cb_robust_peak_height_193_w = pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[27:24];
assign pair_cb_robust_peak_height_192_w = pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[23:16];
assign pair_cb_robust_peak_height_191_w = pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[15:8];
assign pair_cb_robust_peak_height_190_w = pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage20_storage = pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[27:0];
assign pair_cb_robust_peak_height_203_w = pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[27:24];
assign pair_cb_robust_peak_height_202_w = pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[23:16];
assign pair_cb_robust_peak_height_201_w = pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[15:8];
assign pair_cb_robust_peak_height_200_w = pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage21_storage = pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[27:0];
assign pair_cb_robust_peak_height_213_w = pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[27:24];
assign pair_cb_robust_peak_height_212_w = pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[23:16];
assign pair_cb_robust_peak_height_211_w = pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[15:8];
assign pair_cb_robust_peak_height_210_w = pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage22_storage = pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[27:0];
assign pair_cb_robust_peak_height_223_w = pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[27:24];
assign pair_cb_robust_peak_height_222_w = pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[23:16];
assign pair_cb_robust_peak_height_221_w = pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[15:8];
assign pair_cb_robust_peak_height_220_w = pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage23_storage = pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[27:0];
assign pair_cb_robust_peak_height_233_w = pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[27:24];
assign pair_cb_robust_peak_height_232_w = pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[23:16];
assign pair_cb_robust_peak_height_231_w = pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[15:8];
assign pair_cb_robust_peak_height_230_w = pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage24_storage = pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[27:0];
assign pair_cb_robust_peak_height_243_w = pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[27:24];
assign pair_cb_robust_peak_height_242_w = pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[23:16];
assign pair_cb_robust_peak_height_241_w = pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[15:8];
assign pair_cb_robust_peak_height_240_w = pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage25_storage = pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[27:0];
assign pair_cb_robust_peak_height_253_w = pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[27:24];
assign pair_cb_robust_peak_height_252_w = pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[23:16];
assign pair_cb_robust_peak_height_251_w = pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[15:8];
assign pair_cb_robust_peak_height_250_w = pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage26_storage = pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[27:0];
assign pair_cb_robust_peak_height_263_w = pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[27:24];
assign pair_cb_robust_peak_height_262_w = pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[23:16];
assign pair_cb_robust_peak_height_261_w = pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[15:8];
assign pair_cb_robust_peak_height_260_w = pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage27_storage = pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[27:0];
assign pair_cb_robust_peak_height_273_w = pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[27:24];
assign pair_cb_robust_peak_height_272_w = pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[23:16];
assign pair_cb_robust_peak_height_271_w = pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[15:8];
assign pair_cb_robust_peak_height_270_w = pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage28_storage = pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[27:0];
assign pair_cb_robust_peak_height_283_w = pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[27:24];
assign pair_cb_robust_peak_height_282_w = pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[23:16];
assign pair_cb_robust_peak_height_281_w = pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[15:8];
assign pair_cb_robust_peak_height_280_w = pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage29_storage = pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[27:0];
assign pair_cb_robust_peak_height_293_w = pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[27:24];
assign pair_cb_robust_peak_height_292_w = pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[23:16];
assign pair_cb_robust_peak_height_291_w = pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[15:8];
assign pair_cb_robust_peak_height_290_w = pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage30_storage = pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[27:0];
assign pair_cb_robust_peak_height_303_w = pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[27:24];
assign pair_cb_robust_peak_height_302_w = pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[23:16];
assign pair_cb_robust_peak_height_301_w = pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[15:8];
assign pair_cb_robust_peak_height_300_w = pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage31_storage = pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[27:0];
assign pair_cb_robust_peak_height_313_w = pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[27:24];
assign pair_cb_robust_peak_height_312_w = pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[23:16];
assign pair_cb_robust_peak_height_311_w = pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[15:8];
assign pair_cb_robust_peak_height_310_w = pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage32_storage = pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full[13:0];
assign pair_cb_robust_wait_for_01_w = pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full[13:8];
assign pair_cb_robust_wait_for_00_w = pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage33_storage = pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full[13:0];
assign pair_cb_robust_wait_for_11_w = pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full[13:8];
assign pair_cb_robust_wait_for_10_w = pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage34_storage = pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full[13:0];
assign pair_cb_robust_wait_for_21_w = pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full[13:8];
assign pair_cb_robust_wait_for_20_w = pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage35_storage = pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full[13:0];
assign pair_cb_robust_wait_for_31_w = pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full[13:8];
assign pair_cb_robust_wait_for_30_w = pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage36_storage = pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full[13:0];
assign pair_cb_robust_wait_for_41_w = pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full[13:8];
assign pair_cb_robust_wait_for_40_w = pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage37_storage = pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full[13:0];
assign pair_cb_robust_wait_for_51_w = pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full[13:8];
assign pair_cb_robust_wait_for_50_w = pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage38_storage = pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full[13:0];
assign pair_cb_robust_wait_for_61_w = pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full[13:8];
assign pair_cb_robust_wait_for_60_w = pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage39_storage = pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full[13:0];
assign pair_cb_robust_wait_for_71_w = pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full[13:8];
assign pair_cb_robust_wait_for_70_w = pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage40_storage = pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full[13:0];
assign pair_cb_robust_wait_for_81_w = pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full[13:8];
assign pair_cb_robust_wait_for_80_w = pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage41_storage = pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full[13:0];
assign pair_cb_robust_wait_for_91_w = pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full[13:8];
assign pair_cb_robust_wait_for_90_w = pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage42_storage = pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full[13:0];
assign pair_cb_robust_wait_for_101_w = pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full[13:8];
assign pair_cb_robust_wait_for_100_w = pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage43_storage = pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full[13:0];
assign pair_cb_robust_wait_for_111_w = pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full[13:8];
assign pair_cb_robust_wait_for_110_w = pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage44_storage = pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full[13:0];
assign pair_cb_robust_wait_for_121_w = pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full[13:8];
assign pair_cb_robust_wait_for_120_w = pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage45_storage = pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full[13:0];
assign pair_cb_robust_wait_for_131_w = pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full[13:8];
assign pair_cb_robust_wait_for_130_w = pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage46_storage = pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full[13:0];
assign pair_cb_robust_wait_for_141_w = pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full[13:8];
assign pair_cb_robust_wait_for_140_w = pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage47_storage = pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full[13:0];
assign pair_cb_robust_wait_for_151_w = pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full[13:8];
assign pair_cb_robust_wait_for_150_w = pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage48_storage = pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full[13:0];
assign pair_cb_robust_wait_for_161_w = pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full[13:8];
assign pair_cb_robust_wait_for_160_w = pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage49_storage = pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full[13:0];
assign pair_cb_robust_wait_for_171_w = pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full[13:8];
assign pair_cb_robust_wait_for_170_w = pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage50_storage = pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full[13:0];
assign pair_cb_robust_wait_for_181_w = pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full[13:8];
assign pair_cb_robust_wait_for_180_w = pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage51_storage = pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full[13:0];
assign pair_cb_robust_wait_for_191_w = pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full[13:8];
assign pair_cb_robust_wait_for_190_w = pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage52_storage = pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full[13:0];
assign pair_cb_robust_wait_for_201_w = pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full[13:8];
assign pair_cb_robust_wait_for_200_w = pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage53_storage = pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full[13:0];
assign pair_cb_robust_wait_for_211_w = pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full[13:8];
assign pair_cb_robust_wait_for_210_w = pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage54_storage = pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full[13:0];
assign pair_cb_robust_wait_for_221_w = pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full[13:8];
assign pair_cb_robust_wait_for_220_w = pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage55_storage = pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full[13:0];
assign pair_cb_robust_wait_for_231_w = pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full[13:8];
assign pair_cb_robust_wait_for_230_w = pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage56_storage = pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full[13:0];
assign pair_cb_robust_wait_for_241_w = pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full[13:8];
assign pair_cb_robust_wait_for_240_w = pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage57_storage = pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full[13:0];
assign pair_cb_robust_wait_for_251_w = pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full[13:8];
assign pair_cb_robust_wait_for_250_w = pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage58_storage = pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full[13:0];
assign pair_cb_robust_wait_for_261_w = pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full[13:8];
assign pair_cb_robust_wait_for_260_w = pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage59_storage = pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full[13:0];
assign pair_cb_robust_wait_for_271_w = pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full[13:8];
assign pair_cb_robust_wait_for_270_w = pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage60_storage = pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full[13:0];
assign pair_cb_robust_wait_for_281_w = pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full[13:8];
assign pair_cb_robust_wait_for_280_w = pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage61_storage = pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full[13:0];
assign pair_cb_robust_wait_for_291_w = pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full[13:8];
assign pair_cb_robust_wait_for_290_w = pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage62_storage = pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full[13:0];
assign pair_cb_robust_wait_for_301_w = pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full[13:8];
assign pair_cb_robust_wait_for_300_w = pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full[7:0];
assign pair_candidate_pipelinedrobustautolock_csrstorage63_storage = pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full[13:0];
assign pair_cb_robust_wait_for_311_w = pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full[13:8];
assign pair_cb_robust_wait_for_310_w = pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full[7:0];
assign pair_candidate_fast_storage = pair_candidate_fast_storage_full[13:0];
assign pair_cb_fast_target_position1_w = pair_candidate_fast_storage_full[13:8];
assign pair_cb_fast_target_position0_w = pair_candidate_fast_storage_full[7:0];
assign pair_candidate_request_lock_storage = pair_candidate_request_lock_storage_full;
assign pair_cb_request_lock0_w = pair_candidate_request_lock_storage_full;
assign pair_candidate_autolock_mode_storage = pair_candidate_autolock_mode_storage_full[1:0];
assign pair_cb_autolock_mode0_w = pair_candidate_autolock_mode_storage_full[1:0];
assign pair_cb_lock_running_w = pair_candidate_status;

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	comb_array_muxed0 <= 28'd0;
	case (pair_reference_robust_current_instruction_idx)
		1'd0: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage0;
		end
		1'd1: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage1;
		end
		2'd2: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage2;
		end
		2'd3: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage3;
		end
		3'd4: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage4;
		end
		3'd5: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage5;
		end
		3'd6: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage6;
		end
		3'd7: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage7;
		end
		4'd8: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage8;
		end
		4'd9: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage9;
		end
		4'd10: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage10;
		end
		4'd11: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage11;
		end
		4'd12: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage12;
		end
		4'd13: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage13;
		end
		4'd14: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage14;
		end
		4'd15: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage15;
		end
		5'd16: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage16;
		end
		5'd17: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage17;
		end
		5'd18: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage18;
		end
		5'd19: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage19;
		end
		5'd20: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage20;
		end
		5'd21: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage21;
		end
		5'd22: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage22;
		end
		5'd23: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage23;
		end
		5'd24: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage24;
		end
		5'd25: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage25;
		end
		5'd26: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage26;
		end
		5'd27: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage27;
		end
		5'd28: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage28;
		end
		5'd29: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage29;
		end
		5'd30: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage30;
		end
		default: begin
			comb_array_muxed0 <= pair_reference_robust_csrstorage_storage31;
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
	comb_array_muxed1 <= 14'd0;
	case (pair_reference_robust_current_instruction_idx)
		1'd0: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage32;
		end
		1'd1: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage33;
		end
		2'd2: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage34;
		end
		2'd3: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage35;
		end
		3'd4: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage36;
		end
		3'd5: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage37;
		end
		3'd6: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage38;
		end
		3'd7: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage39;
		end
		4'd8: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage40;
		end
		4'd9: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage41;
		end
		4'd10: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage42;
		end
		4'd11: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage43;
		end
		4'd12: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage44;
		end
		4'd13: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage45;
		end
		4'd14: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage46;
		end
		4'd15: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage47;
		end
		5'd16: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage48;
		end
		5'd17: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage49;
		end
		5'd18: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage50;
		end
		5'd19: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage51;
		end
		5'd20: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage52;
		end
		5'd21: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage53;
		end
		5'd22: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage54;
		end
		5'd23: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage55;
		end
		5'd24: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage56;
		end
		5'd25: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage57;
		end
		5'd26: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage58;
		end
		5'd27: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage59;
		end
		5'd28: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage60;
		end
		5'd29: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage61;
		end
		5'd30: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage62;
		end
		default: begin
			comb_array_muxed1 <= pair_reference_robust_csrstorage_storage63;
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
	comb_array_muxed2 <= 28'd0;
	case (pair_candidate_pipelinedrobustautolock_current_instruction_idx)
		1'd0: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage0_storage;
		end
		1'd1: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage1_storage;
		end
		2'd2: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage2_storage;
		end
		2'd3: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage3_storage;
		end
		3'd4: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage4_storage;
		end
		3'd5: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage5_storage;
		end
		3'd6: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage6_storage;
		end
		3'd7: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage7_storage;
		end
		4'd8: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage8_storage;
		end
		4'd9: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage9_storage;
		end
		4'd10: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage10_storage;
		end
		4'd11: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage11_storage;
		end
		4'd12: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage12_storage;
		end
		4'd13: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage13_storage;
		end
		4'd14: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage14_storage;
		end
		4'd15: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage15_storage;
		end
		5'd16: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage16_storage;
		end
		5'd17: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage17_storage;
		end
		5'd18: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage18_storage;
		end
		5'd19: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage19_storage;
		end
		5'd20: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage20_storage;
		end
		5'd21: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage21_storage;
		end
		5'd22: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage22_storage;
		end
		5'd23: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage23_storage;
		end
		5'd24: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage24_storage;
		end
		5'd25: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage25_storage;
		end
		5'd26: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage26_storage;
		end
		5'd27: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage27_storage;
		end
		5'd28: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage28_storage;
		end
		5'd29: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage29_storage;
		end
		5'd30: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage30_storage;
		end
		default: begin
			comb_array_muxed2 <= pair_candidate_pipelinedrobustautolock_csrstorage31_storage;
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
	comb_array_muxed3 <= 28'sd0;
	case (pair_candidate_pipelinedrobustautolock_prefetch_choice)
		1'd0: begin
			comb_array_muxed3 <= pair_candidate_pipelinedrobustautolock_prefetch_current_magnitude;
		end
		1'd1: begin
			comb_array_muxed3 <= pair_candidate_pipelinedrobustautolock_prefetch_next_magnitude;
		end
		default: begin
			comb_array_muxed3 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_magnitude;
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
	comb_array_muxed4 <= 29'sd0;
	case (pair_candidate_pipelinedrobustautolock_prefetch_choice)
		1'd0: begin
			comb_array_muxed4 <= pair_candidate_pipelinedrobustautolock_prefetch_current_negative;
		end
		1'd1: begin
			comb_array_muxed4 <= pair_candidate_pipelinedrobustautolock_prefetch_next_negative;
		end
		default: begin
			comb_array_muxed4 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_negative;
		end
	endcase
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	comb_array_muxed5 <= 1'd0;
	case (pair_candidate_pipelinedrobustautolock_prefetch_choice)
		1'd0: begin
			comb_array_muxed5 <= pair_candidate_pipelinedrobustautolock_prefetch_current_positive;
		end
		1'd1: begin
			comb_array_muxed5 <= pair_candidate_pipelinedrobustautolock_prefetch_next_positive;
		end
		default: begin
			comb_array_muxed5 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_positive;
		end
	endcase
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	comb_array_muxed6 <= 14'd0;
	case (pair_candidate_pipelinedrobustautolock_prefetch_choice)
		1'd0: begin
			comb_array_muxed6 <= pair_candidate_pipelinedrobustautolock_prefetch_current_wait;
		end
		1'd1: begin
			comb_array_muxed6 <= pair_candidate_pipelinedrobustautolock_prefetch_next_wait;
		end
		default: begin
			comb_array_muxed6 <= pair_candidate_pipelinedrobustautolock_prefetch_zero_wait;
		end
	endcase
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	sync_array_muxed <= 14'd0;
	case (pair_candidate_pipelinedrobustautolock_current_instruction_idx)
		1'd0: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage32_storage;
		end
		1'd1: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage33_storage;
		end
		2'd2: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage34_storage;
		end
		2'd3: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage35_storage;
		end
		3'd4: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage36_storage;
		end
		3'd5: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage37_storage;
		end
		3'd6: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage38_storage;
		end
		3'd7: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage39_storage;
		end
		4'd8: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage40_storage;
		end
		4'd9: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage41_storage;
		end
		4'd10: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage42_storage;
		end
		4'd11: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage43_storage;
		end
		4'd12: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage44_storage;
		end
		4'd13: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage45_storage;
		end
		4'd14: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage46_storage;
		end
		4'd15: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage47_storage;
		end
		5'd16: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage48_storage;
		end
		5'd17: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage49_storage;
		end
		5'd18: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage50_storage;
		end
		5'd19: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage51_storage;
		end
		5'd20: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage52_storage;
		end
		5'd21: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage53_storage;
		end
		5'd22: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage54_storage;
		end
		5'd23: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage55_storage;
		end
		5'd24: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage56_storage;
		end
		5'd25: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage57_storage;
		end
		5'd26: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage58_storage;
		end
		5'd27: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage59_storage;
		end
		5'd28: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage60_storage;
		end
		5'd29: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage61_storage;
		end
		5'd30: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage62_storage;
		end
		default: begin
			sync_array_muxed <= pair_candidate_pipelinedrobustautolock_csrstorage63_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	pair_pair0 <= pair_candidate_pipelinedrobustautolock_sum_value;
	pair_pair1 <= pair_candidate_pipelinedrobustautolock_counter;
	pair_pair_q <= pair_candidate_pipelinedrobustautolock_counter_delayed;
	pair_pair2 <= pair_candidate_pipelinedrobustautolock_output0;
	if ((~pair_reference_request_lock_storage)) begin
		pair_reference_status <= 1'd0;
	end
	if (((pair_reference_request_lock_storage & pair_reference_fast_turn_on_lock) & (pair_reference_autolock_mode_storage == 2'd2))) begin
		pair_reference_status <= 1'd1;
	end
	if (((pair_reference_request_lock_storage & pair_reference_robust_turn_on_lock) & (pair_reference_autolock_mode_storage == 1'd1))) begin
		pair_reference_status <= 1'd1;
	end
	if (pair_reference_robust_at_start) begin
		pair_reference_robust_waited_for <= 1'd0;
		pair_reference_robust_final_waited_for <= 2'd3;
		pair_reference_robust_current_instruction_idx <= 1'd0;
		if (pair_reference_robust_request_lock) begin
			pair_reference_robust_watching <= 1'd1;
		end else begin
			pair_reference_robust_watching <= 1'd0;
		end
	end else begin
		if ((~pair_reference_robust_request_lock)) begin
			pair_reference_robust_watching <= 1'd0;
		end
		if (((pair_reference_robust_writing_data_now2 & (~pair_reference_robust_all_instructions_triggered)) & pair_reference_robust_sweep_up)) begin
			if ((((pair_reference_robust_watching & pair_reference_robust_sign_equal) & pair_reference_robust_over_threshold) & pair_reference_robust_waited_long_enough)) begin
				pair_reference_robust_current_instruction_idx <= (pair_reference_robust_current_instruction_idx + 1'd1);
				pair_reference_robust_waited_for <= 1'd0;
			end else begin
				pair_reference_robust_waited_for <= (pair_reference_robust_waited_for + 1'd1);
			end
		end
		if (((pair_reference_robust_writing_data_now2 & pair_reference_robust_all_instructions_triggered) & pair_reference_robust_sweep_up)) begin
			pair_reference_robust_final_waited_for <= (pair_reference_robust_final_waited_for + 1'd1);
		end
	end
	pair_reference_robust_q0 <= pair_reference_robust_public0;
	pair_reference_robust_q1 <= pair_reference_robust_public1;
	pair_reference_robust_q2 <= pair_reference_robust_public2;
	pair_reference_robust_q3 <= pair_reference_robust_public3;
	pair_reference_robust_q4 <= pair_reference_robust_public4;
	pair_reference_robust_q5 <= pair_reference_robust_csrstorage0_storage;
	pair_reference_robust_q6 <= pair_reference_robust_csrstorage1_storage;
	pair_reference_robust_q7 <= pair_reference_robust_csrstorage2_storage;
	pair_reference_robust_q8 <= pair_reference_robust_csrstorage3_storage;
	pair_reference_robust_q9 <= pair_reference_robust_csrstorage4_storage;
	pair_reference_robust_q10 <= pair_reference_robust_csrstorage5_storage;
	pair_reference_robust_q11 <= pair_reference_robust_csrstorage6_storage;
	pair_reference_robust_q12 <= pair_reference_robust_csrstorage7_storage;
	pair_reference_robust_q13 <= pair_reference_robust_csrstorage8_storage;
	pair_reference_robust_q14 <= pair_reference_robust_csrstorage9_storage;
	pair_reference_robust_q15 <= pair_reference_robust_csrstorage10_storage;
	pair_reference_robust_q16 <= pair_reference_robust_csrstorage11_storage;
	pair_reference_robust_q17 <= pair_reference_robust_csrstorage12_storage;
	pair_reference_robust_q18 <= pair_reference_robust_csrstorage13_storage;
	pair_reference_robust_q19 <= pair_reference_robust_csrstorage14_storage;
	pair_reference_robust_q20 <= pair_reference_robust_csrstorage15_storage;
	pair_reference_robust_q21 <= pair_reference_robust_csrstorage16_storage;
	pair_reference_robust_q22 <= pair_reference_robust_csrstorage17_storage;
	pair_reference_robust_q23 <= pair_reference_robust_csrstorage18_storage;
	pair_reference_robust_q24 <= pair_reference_robust_csrstorage19_storage;
	pair_reference_robust_q25 <= pair_reference_robust_csrstorage20_storage;
	pair_reference_robust_q26 <= pair_reference_robust_csrstorage21_storage;
	pair_reference_robust_q27 <= pair_reference_robust_csrstorage22_storage;
	pair_reference_robust_q28 <= pair_reference_robust_csrstorage23_storage;
	pair_reference_robust_q29 <= pair_reference_robust_csrstorage24_storage;
	pair_reference_robust_q30 <= pair_reference_robust_csrstorage25_storage;
	pair_reference_robust_q31 <= pair_reference_robust_csrstorage26_storage;
	pair_reference_robust_q32 <= pair_reference_robust_csrstorage27_storage;
	pair_reference_robust_q33 <= pair_reference_robust_csrstorage28_storage;
	pair_reference_robust_q34 <= pair_reference_robust_csrstorage29_storage;
	pair_reference_robust_q35 <= pair_reference_robust_csrstorage30_storage;
	pair_reference_robust_q36 <= pair_reference_robust_csrstorage31_storage;
	pair_reference_robust_q37 <= pair_reference_robust_csrstorage32_storage;
	pair_reference_robust_q38 <= pair_reference_robust_csrstorage33_storage;
	pair_reference_robust_q39 <= pair_reference_robust_csrstorage34_storage;
	pair_reference_robust_q40 <= pair_reference_robust_csrstorage35_storage;
	pair_reference_robust_q41 <= pair_reference_robust_csrstorage36_storage;
	pair_reference_robust_q42 <= pair_reference_robust_csrstorage37_storage;
	pair_reference_robust_q43 <= pair_reference_robust_csrstorage38_storage;
	pair_reference_robust_q44 <= pair_reference_robust_csrstorage39_storage;
	pair_reference_robust_q45 <= pair_reference_robust_csrstorage40_storage;
	pair_reference_robust_q46 <= pair_reference_robust_csrstorage41_storage;
	pair_reference_robust_q47 <= pair_reference_robust_csrstorage42_storage;
	pair_reference_robust_q48 <= pair_reference_robust_csrstorage43_storage;
	pair_reference_robust_q49 <= pair_reference_robust_csrstorage44_storage;
	pair_reference_robust_q50 <= pair_reference_robust_csrstorage45_storage;
	pair_reference_robust_q51 <= pair_reference_robust_csrstorage46_storage;
	pair_reference_robust_q52 <= pair_reference_robust_csrstorage47_storage;
	pair_reference_robust_q53 <= pair_reference_robust_csrstorage48_storage;
	pair_reference_robust_q54 <= pair_reference_robust_csrstorage49_storage;
	pair_reference_robust_q55 <= pair_reference_robust_csrstorage50_storage;
	pair_reference_robust_q56 <= pair_reference_robust_csrstorage51_storage;
	pair_reference_robust_q57 <= pair_reference_robust_csrstorage52_storage;
	pair_reference_robust_q58 <= pair_reference_robust_csrstorage53_storage;
	pair_reference_robust_q59 <= pair_reference_robust_csrstorage54_storage;
	pair_reference_robust_q60 <= pair_reference_robust_csrstorage55_storage;
	pair_reference_robust_q61 <= pair_reference_robust_csrstorage56_storage;
	pair_reference_robust_q62 <= pair_reference_robust_csrstorage57_storage;
	pair_reference_robust_q63 <= pair_reference_robust_csrstorage58_storage;
	pair_reference_robust_q64 <= pair_reference_robust_csrstorage59_storage;
	pair_reference_robust_q65 <= pair_reference_robust_csrstorage60_storage;
	pair_reference_robust_q66 <= pair_reference_robust_csrstorage61_storage;
	pair_reference_robust_q67 <= pair_reference_robust_csrstorage62_storage;
	pair_reference_robust_q68 <= pair_reference_robust_csrstorage63_storage;
	pair_reference_robust_q69 <= pair_reference_robust_csrstorage64_storage;
	pair_reference_robust_q70 <= pair_reference_robust_csrstorage65_storage;
	pair_reference_robust_q71 <= pair_reference_robust_csrstorage66_storage;
	if (pair_reference_robust_restart0) begin
		pair_reference_robust_sum_value <= 1'd0;
	end else begin
		if (pair_reference_robust_writing_data_now0) begin
			pair_reference_robust_sum_value <= (pair_reference_robust_sum_value + pair_reference_robust_input0);
		end
	end
	if (pair_reference_robust_restart1) begin
		pair_reference_robust_counter <= 1'd0;
	end else begin
		if (pair_reference_robust_writing_data_now1) begin
			pair_reference_robust_counter <= (pair_reference_robust_counter + 1'd1);
		end
	end
	if ((~pair_reference_fast_request_lock)) begin
		pair_reference_fast_turn_on_lock <= 1'd0;
	end else begin
		pair_reference_fast_turn_on_lock <= (((pair_reference_fast_sweep_value >= (pair_reference_fast_target_position_signed - $signed({1'd0, (pair_reference_fast_sweep_step >>> 1'd1)}))) & (pair_reference_fast_sweep_value <= ((pair_reference_fast_target_position_signed + $signed({1'd0, 1'd1})) + $signed({1'd0, (pair_reference_fast_sweep_step >>> 1'd1)})))) & $signed({1'd0, pair_reference_fast_sweep_up}));
	end
	if ((~pair_candidate_request_lock_storage)) begin
		pair_candidate_status <= 1'd0;
	end
	if (((pair_candidate_request_lock_storage & pair_candidate_fast_turn_on_lock) & (pair_candidate_autolock_mode_storage == 2'd2))) begin
		pair_candidate_status <= 1'd1;
	end
	if (((pair_candidate_request_lock_storage & pair_candidate_pipelinedrobustautolock_turn_on_lock) & (pair_candidate_autolock_mode_storage == 1'd1))) begin
		pair_candidate_status <= 1'd1;
	end
	pair_candidate_pipelinedrobustautolock0 <= pair_candidate_pipelinedrobustautolock_at_start;
	pair_candidate_pipelinedrobustautolock1 <= pair_candidate_pipelinedrobustautolock_request_lock;
	pair_candidate_pipelinedrobustautolock2 <= pair_candidate_pipelinedrobustautolock_writing_data_now2;
	pair_candidate_pipelinedrobustautolock3 <= pair_candidate_pipelinedrobustautolock_sweep_up;
	pair_candidate_pipelinedrobustautolock_sum_diff_s1 <= pair_candidate_pipelinedrobustautolock_output0;
	pair_candidate_pipelinedrobustautolock_n_instructions_s1 <= pair_candidate_pipelinedrobustautolock_N_instructions_storage;
	pair_candidate_pipelinedrobustautolock_final_wait_s1 <= pair_candidate_pipelinedrobustautolock_final_wait_time_storage;
	if (pair_candidate_pipelinedrobustautolock0) begin
		pair_candidate_pipelinedrobustautolock_prefetch_choice <= 2'd2;
	end else begin
		if (pair_candidate_pipelinedrobustautolock_prefetch_advance) begin
			pair_candidate_pipelinedrobustautolock_prefetch_choice <= 1'd1;
		end else begin
			pair_candidate_pipelinedrobustautolock_prefetch_choice <= 1'd0;
		end
	end
	pair_candidate_pipelinedrobustautolock_prefetch_current_magnitude <= pair_candidate_pipelinedrobustautolock_absolute0;
	pair_candidate_pipelinedrobustautolock_prefetch_current_negative <= {pair_candidate_pipelinedrobustautolock_negative_sign0, pair_candidate_pipelinedrobustautolock_negative_low0};
	pair_candidate_pipelinedrobustautolock_prefetch_current_positive <= (pair_candidate_pipelinedrobustautolock_prefetch_current_signed > $signed({1'd0, 1'd0}));
	pair_candidate_pipelinedrobustautolock_prefetch_current_wait <= sync_array_muxed;
	pair_candidate_pipelinedrobustautolock_prefetch_next_magnitude <= pair_candidate_pipelinedrobustautolock_absolute1;
	pair_candidate_pipelinedrobustautolock_prefetch_next_negative <= {pair_candidate_pipelinedrobustautolock_negative_sign1, pair_candidate_pipelinedrobustautolock_negative_low1};
	pair_candidate_pipelinedrobustautolock_prefetch_next_positive <= (pair_candidate_pipelinedrobustautolock_prefetch_next_signed > $signed({1'd0, 1'd0}));
	pair_candidate_pipelinedrobustautolock_prefetch_next_wait <= pair_candidate_pipelinedrobustautolock_result1;
	pair_candidate_pipelinedrobustautolock_prefetch_zero_magnitude <= pair_candidate_pipelinedrobustautolock_absolute2;
	pair_candidate_pipelinedrobustautolock_prefetch_zero_negative <= {pair_candidate_pipelinedrobustautolock_negative_sign2, pair_candidate_pipelinedrobustautolock_negative_low2};
	pair_candidate_pipelinedrobustautolock_prefetch_zero_positive <= (pair_candidate_pipelinedrobustautolock_prefetch_zero_signed > $signed({1'd0, 1'd0}));
	pair_candidate_pipelinedrobustautolock_prefetch_zero_wait <= pair_candidate_pipelinedrobustautolock_csrstorage32_storage;
	if (pair_candidate_pipelinedrobustautolock0) begin
		pair_candidate_pipelinedrobustautolock_waited_for <= 1'd0;
		pair_candidate_pipelinedrobustautolock_final_waited_for <= 2'd3;
		pair_candidate_pipelinedrobustautolock_current_instruction_idx <= 1'd0;
		if (pair_candidate_pipelinedrobustautolock1) begin
			pair_candidate_pipelinedrobustautolock_watching <= 1'd1;
		end else begin
			pair_candidate_pipelinedrobustautolock_watching <= 1'd0;
		end
	end else begin
		if ((~pair_candidate_pipelinedrobustautolock1)) begin
			pair_candidate_pipelinedrobustautolock_watching <= 1'd0;
		end
		if (((pair_candidate_pipelinedrobustautolock2 & (~pair_candidate_pipelinedrobustautolock_all_instructions_triggered)) & pair_candidate_pipelinedrobustautolock3)) begin
			if ((((pair_candidate_pipelinedrobustautolock_watching & pair_candidate_pipelinedrobustautolock_sign_equal) & pair_candidate_pipelinedrobustautolock_over_threshold) & pair_candidate_pipelinedrobustautolock_waited_long_enough)) begin
				pair_candidate_pipelinedrobustautolock_current_instruction_idx <= (pair_candidate_pipelinedrobustautolock_current_instruction_idx + 1'd1);
				pair_candidate_pipelinedrobustautolock_waited_for <= 1'd0;
			end else begin
				pair_candidate_pipelinedrobustautolock_waited_for <= (pair_candidate_pipelinedrobustautolock_waited_for + 1'd1);
			end
		end
		if (((pair_candidate_pipelinedrobustautolock2 & pair_candidate_pipelinedrobustautolock_all_instructions_triggered) & pair_candidate_pipelinedrobustautolock3)) begin
			pair_candidate_pipelinedrobustautolock_final_waited_for <= (pair_candidate_pipelinedrobustautolock_final_waited_for + 1'd1);
		end
	end
	if (pair_candidate_pipelinedrobustautolock_restart0) begin
		pair_candidate_pipelinedrobustautolock_sum_value <= 1'd0;
	end else begin
		if (pair_candidate_pipelinedrobustautolock_writing_data_now0) begin
			pair_candidate_pipelinedrobustautolock_sum_value <= (pair_candidate_pipelinedrobustautolock_sum_value + pair_candidate_pipelinedrobustautolock_input0);
		end
	end
	if (pair_candidate_pipelinedrobustautolock_restart1) begin
		pair_candidate_pipelinedrobustautolock_counter <= 1'd0;
	end else begin
		if (pair_candidate_pipelinedrobustautolock_writing_data_now1) begin
			pair_candidate_pipelinedrobustautolock_counter <= (pair_candidate_pipelinedrobustautolock_counter + 1'd1);
		end
	end
	if ((~pair_candidate_fast_request_lock)) begin
		pair_candidate_fast_turn_on_lock <= 1'd0;
	end else begin
		pair_candidate_fast_turn_on_lock <= (((pair_candidate_fast_sweep_value >= (pair_candidate_fast_target_position_signed - $signed({1'd0, (pair_candidate_fast_sweep_step >>> 1'd1)}))) & (pair_candidate_fast_sweep_value <= ((pair_candidate_fast_target_position_signed + $signed({1'd0, 1'd1})) + $signed({1'd0, (pair_candidate_fast_sweep_step >>> 1'd1)})))) & $signed({1'd0, pair_candidate_fast_sweep_up}));
	end
	pair_rb_bus_dat_r <= 1'd0;
	if (pair_rb_sel) begin
		case (pair_rb_bus_adr[7:0])
			1'd0: begin
				pair_rb_bus_dat_r <= pair_rb_robust_time_scale1_w;
			end
			1'd1: begin
				pair_rb_bus_dat_r <= pair_rb_robust_time_scale0_w;
			end
			2'd2: begin
				pair_rb_bus_dat_r <= pair_rb_robust_N_instructions0_w;
			end
			2'd3: begin
				pair_rb_bus_dat_r <= pair_rb_robust_final_wait_time1_w;
			end
			3'd4: begin
				pair_rb_bus_dat_r <= pair_rb_robust_final_wait_time0_w;
			end
			3'd5: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_03_w;
			end
			3'd6: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_02_w;
			end
			3'd7: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_01_w;
			end
			4'd8: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_00_w;
			end
			4'd9: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_13_w;
			end
			4'd10: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_12_w;
			end
			4'd11: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_11_w;
			end
			4'd12: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_10_w;
			end
			4'd13: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_23_w;
			end
			4'd14: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_22_w;
			end
			4'd15: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_21_w;
			end
			5'd16: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_20_w;
			end
			5'd17: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_33_w;
			end
			5'd18: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_32_w;
			end
			5'd19: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_31_w;
			end
			5'd20: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_30_w;
			end
			5'd21: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_43_w;
			end
			5'd22: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_42_w;
			end
			5'd23: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_41_w;
			end
			5'd24: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_40_w;
			end
			5'd25: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_53_w;
			end
			5'd26: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_52_w;
			end
			5'd27: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_51_w;
			end
			5'd28: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_50_w;
			end
			5'd29: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_63_w;
			end
			5'd30: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_62_w;
			end
			5'd31: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_61_w;
			end
			6'd32: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_60_w;
			end
			6'd33: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_73_w;
			end
			6'd34: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_72_w;
			end
			6'd35: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_71_w;
			end
			6'd36: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_70_w;
			end
			6'd37: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_83_w;
			end
			6'd38: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_82_w;
			end
			6'd39: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_81_w;
			end
			6'd40: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_80_w;
			end
			6'd41: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_93_w;
			end
			6'd42: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_92_w;
			end
			6'd43: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_91_w;
			end
			6'd44: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_90_w;
			end
			6'd45: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_103_w;
			end
			6'd46: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_102_w;
			end
			6'd47: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_101_w;
			end
			6'd48: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_100_w;
			end
			6'd49: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_113_w;
			end
			6'd50: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_112_w;
			end
			6'd51: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_111_w;
			end
			6'd52: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_110_w;
			end
			6'd53: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_123_w;
			end
			6'd54: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_122_w;
			end
			6'd55: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_121_w;
			end
			6'd56: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_120_w;
			end
			6'd57: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_133_w;
			end
			6'd58: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_132_w;
			end
			6'd59: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_131_w;
			end
			6'd60: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_130_w;
			end
			6'd61: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_143_w;
			end
			6'd62: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_142_w;
			end
			6'd63: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_141_w;
			end
			7'd64: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_140_w;
			end
			7'd65: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_153_w;
			end
			7'd66: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_152_w;
			end
			7'd67: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_151_w;
			end
			7'd68: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_150_w;
			end
			7'd69: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_163_w;
			end
			7'd70: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_162_w;
			end
			7'd71: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_161_w;
			end
			7'd72: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_160_w;
			end
			7'd73: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_173_w;
			end
			7'd74: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_172_w;
			end
			7'd75: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_171_w;
			end
			7'd76: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_170_w;
			end
			7'd77: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_183_w;
			end
			7'd78: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_182_w;
			end
			7'd79: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_181_w;
			end
			7'd80: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_180_w;
			end
			7'd81: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_193_w;
			end
			7'd82: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_192_w;
			end
			7'd83: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_191_w;
			end
			7'd84: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_190_w;
			end
			7'd85: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_203_w;
			end
			7'd86: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_202_w;
			end
			7'd87: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_201_w;
			end
			7'd88: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_200_w;
			end
			7'd89: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_213_w;
			end
			7'd90: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_212_w;
			end
			7'd91: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_211_w;
			end
			7'd92: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_210_w;
			end
			7'd93: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_223_w;
			end
			7'd94: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_222_w;
			end
			7'd95: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_221_w;
			end
			7'd96: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_220_w;
			end
			7'd97: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_233_w;
			end
			7'd98: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_232_w;
			end
			7'd99: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_231_w;
			end
			7'd100: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_230_w;
			end
			7'd101: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_243_w;
			end
			7'd102: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_242_w;
			end
			7'd103: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_241_w;
			end
			7'd104: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_240_w;
			end
			7'd105: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_253_w;
			end
			7'd106: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_252_w;
			end
			7'd107: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_251_w;
			end
			7'd108: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_250_w;
			end
			7'd109: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_263_w;
			end
			7'd110: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_262_w;
			end
			7'd111: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_261_w;
			end
			7'd112: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_260_w;
			end
			7'd113: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_273_w;
			end
			7'd114: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_272_w;
			end
			7'd115: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_271_w;
			end
			7'd116: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_270_w;
			end
			7'd117: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_283_w;
			end
			7'd118: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_282_w;
			end
			7'd119: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_281_w;
			end
			7'd120: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_280_w;
			end
			7'd121: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_293_w;
			end
			7'd122: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_292_w;
			end
			7'd123: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_291_w;
			end
			7'd124: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_290_w;
			end
			7'd125: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_303_w;
			end
			7'd126: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_302_w;
			end
			7'd127: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_301_w;
			end
			8'd128: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_300_w;
			end
			8'd129: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_313_w;
			end
			8'd130: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_312_w;
			end
			8'd131: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_311_w;
			end
			8'd132: begin
				pair_rb_bus_dat_r <= pair_rb_robust_peak_height_310_w;
			end
			8'd133: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_01_w;
			end
			8'd134: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_00_w;
			end
			8'd135: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_11_w;
			end
			8'd136: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_10_w;
			end
			8'd137: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_21_w;
			end
			8'd138: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_20_w;
			end
			8'd139: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_31_w;
			end
			8'd140: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_30_w;
			end
			8'd141: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_41_w;
			end
			8'd142: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_40_w;
			end
			8'd143: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_51_w;
			end
			8'd144: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_50_w;
			end
			8'd145: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_61_w;
			end
			8'd146: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_60_w;
			end
			8'd147: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_71_w;
			end
			8'd148: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_70_w;
			end
			8'd149: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_81_w;
			end
			8'd150: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_80_w;
			end
			8'd151: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_91_w;
			end
			8'd152: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_90_w;
			end
			8'd153: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_101_w;
			end
			8'd154: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_100_w;
			end
			8'd155: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_111_w;
			end
			8'd156: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_110_w;
			end
			8'd157: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_121_w;
			end
			8'd158: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_120_w;
			end
			8'd159: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_131_w;
			end
			8'd160: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_130_w;
			end
			8'd161: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_141_w;
			end
			8'd162: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_140_w;
			end
			8'd163: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_151_w;
			end
			8'd164: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_150_w;
			end
			8'd165: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_161_w;
			end
			8'd166: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_160_w;
			end
			8'd167: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_171_w;
			end
			8'd168: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_170_w;
			end
			8'd169: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_181_w;
			end
			8'd170: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_180_w;
			end
			8'd171: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_191_w;
			end
			8'd172: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_190_w;
			end
			8'd173: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_201_w;
			end
			8'd174: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_200_w;
			end
			8'd175: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_211_w;
			end
			8'd176: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_210_w;
			end
			8'd177: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_221_w;
			end
			8'd178: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_220_w;
			end
			8'd179: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_231_w;
			end
			8'd180: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_230_w;
			end
			8'd181: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_241_w;
			end
			8'd182: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_240_w;
			end
			8'd183: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_251_w;
			end
			8'd184: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_250_w;
			end
			8'd185: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_261_w;
			end
			8'd186: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_260_w;
			end
			8'd187: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_271_w;
			end
			8'd188: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_270_w;
			end
			8'd189: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_281_w;
			end
			8'd190: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_280_w;
			end
			8'd191: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_291_w;
			end
			8'd192: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_290_w;
			end
			8'd193: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_301_w;
			end
			8'd194: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_300_w;
			end
			8'd195: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_311_w;
			end
			8'd196: begin
				pair_rb_bus_dat_r <= pair_rb_robust_wait_for_310_w;
			end
			8'd197: begin
				pair_rb_bus_dat_r <= pair_rb_fast_target_position1_w;
			end
			8'd198: begin
				pair_rb_bus_dat_r <= pair_rb_fast_target_position0_w;
			end
			8'd199: begin
				pair_rb_bus_dat_r <= pair_rb_request_lock0_w;
			end
			8'd200: begin
				pair_rb_bus_dat_r <= pair_rb_autolock_mode0_w;
			end
			8'd201: begin
				pair_rb_bus_dat_r <= pair_rb_lock_running_w;
			end
		endcase
	end
	if (pair_rb_robust_time_scale1_re) begin
		pair_reference_robust_csrstorage0_storage_full[13:8] <= pair_rb_robust_time_scale1_r;
	end
	if (pair_rb_robust_time_scale0_re) begin
		pair_reference_robust_csrstorage0_storage_full[7:0] <= pair_rb_robust_time_scale0_r;
	end
	pair_reference_robust_csrstorage0_re <= pair_rb_robust_time_scale0_re;
	if (pair_rb_robust_N_instructions0_re) begin
		pair_reference_robust_csrstorage1_storage_full[4:0] <= pair_rb_robust_N_instructions0_r;
	end
	pair_reference_robust_csrstorage1_re <= pair_rb_robust_N_instructions0_re;
	if (pair_rb_robust_final_wait_time1_re) begin
		pair_reference_robust_csrstorage2_storage_full[13:8] <= pair_rb_robust_final_wait_time1_r;
	end
	if (pair_rb_robust_final_wait_time0_re) begin
		pair_reference_robust_csrstorage2_storage_full[7:0] <= pair_rb_robust_final_wait_time0_r;
	end
	pair_reference_robust_csrstorage2_re <= pair_rb_robust_final_wait_time0_re;
	if (pair_rb_robust_peak_height_03_re) begin
		pair_reference_robust_csrstorage3_storage_full[27:24] <= pair_rb_robust_peak_height_03_r;
	end
	if (pair_rb_robust_peak_height_02_re) begin
		pair_reference_robust_csrstorage3_storage_full[23:16] <= pair_rb_robust_peak_height_02_r;
	end
	if (pair_rb_robust_peak_height_01_re) begin
		pair_reference_robust_csrstorage3_storage_full[15:8] <= pair_rb_robust_peak_height_01_r;
	end
	if (pair_rb_robust_peak_height_00_re) begin
		pair_reference_robust_csrstorage3_storage_full[7:0] <= pair_rb_robust_peak_height_00_r;
	end
	pair_reference_robust_csrstorage3_re <= pair_rb_robust_peak_height_00_re;
	if (pair_rb_robust_peak_height_13_re) begin
		pair_reference_robust_csrstorage4_storage_full[27:24] <= pair_rb_robust_peak_height_13_r;
	end
	if (pair_rb_robust_peak_height_12_re) begin
		pair_reference_robust_csrstorage4_storage_full[23:16] <= pair_rb_robust_peak_height_12_r;
	end
	if (pair_rb_robust_peak_height_11_re) begin
		pair_reference_robust_csrstorage4_storage_full[15:8] <= pair_rb_robust_peak_height_11_r;
	end
	if (pair_rb_robust_peak_height_10_re) begin
		pair_reference_robust_csrstorage4_storage_full[7:0] <= pair_rb_robust_peak_height_10_r;
	end
	pair_reference_robust_csrstorage4_re <= pair_rb_robust_peak_height_10_re;
	if (pair_rb_robust_peak_height_23_re) begin
		pair_reference_robust_csrstorage5_storage_full[27:24] <= pair_rb_robust_peak_height_23_r;
	end
	if (pair_rb_robust_peak_height_22_re) begin
		pair_reference_robust_csrstorage5_storage_full[23:16] <= pair_rb_robust_peak_height_22_r;
	end
	if (pair_rb_robust_peak_height_21_re) begin
		pair_reference_robust_csrstorage5_storage_full[15:8] <= pair_rb_robust_peak_height_21_r;
	end
	if (pair_rb_robust_peak_height_20_re) begin
		pair_reference_robust_csrstorage5_storage_full[7:0] <= pair_rb_robust_peak_height_20_r;
	end
	pair_reference_robust_csrstorage5_re <= pair_rb_robust_peak_height_20_re;
	if (pair_rb_robust_peak_height_33_re) begin
		pair_reference_robust_csrstorage6_storage_full[27:24] <= pair_rb_robust_peak_height_33_r;
	end
	if (pair_rb_robust_peak_height_32_re) begin
		pair_reference_robust_csrstorage6_storage_full[23:16] <= pair_rb_robust_peak_height_32_r;
	end
	if (pair_rb_robust_peak_height_31_re) begin
		pair_reference_robust_csrstorage6_storage_full[15:8] <= pair_rb_robust_peak_height_31_r;
	end
	if (pair_rb_robust_peak_height_30_re) begin
		pair_reference_robust_csrstorage6_storage_full[7:0] <= pair_rb_robust_peak_height_30_r;
	end
	pair_reference_robust_csrstorage6_re <= pair_rb_robust_peak_height_30_re;
	if (pair_rb_robust_peak_height_43_re) begin
		pair_reference_robust_csrstorage7_storage_full[27:24] <= pair_rb_robust_peak_height_43_r;
	end
	if (pair_rb_robust_peak_height_42_re) begin
		pair_reference_robust_csrstorage7_storage_full[23:16] <= pair_rb_robust_peak_height_42_r;
	end
	if (pair_rb_robust_peak_height_41_re) begin
		pair_reference_robust_csrstorage7_storage_full[15:8] <= pair_rb_robust_peak_height_41_r;
	end
	if (pair_rb_robust_peak_height_40_re) begin
		pair_reference_robust_csrstorage7_storage_full[7:0] <= pair_rb_robust_peak_height_40_r;
	end
	pair_reference_robust_csrstorage7_re <= pair_rb_robust_peak_height_40_re;
	if (pair_rb_robust_peak_height_53_re) begin
		pair_reference_robust_csrstorage8_storage_full[27:24] <= pair_rb_robust_peak_height_53_r;
	end
	if (pair_rb_robust_peak_height_52_re) begin
		pair_reference_robust_csrstorage8_storage_full[23:16] <= pair_rb_robust_peak_height_52_r;
	end
	if (pair_rb_robust_peak_height_51_re) begin
		pair_reference_robust_csrstorage8_storage_full[15:8] <= pair_rb_robust_peak_height_51_r;
	end
	if (pair_rb_robust_peak_height_50_re) begin
		pair_reference_robust_csrstorage8_storage_full[7:0] <= pair_rb_robust_peak_height_50_r;
	end
	pair_reference_robust_csrstorage8_re <= pair_rb_robust_peak_height_50_re;
	if (pair_rb_robust_peak_height_63_re) begin
		pair_reference_robust_csrstorage9_storage_full[27:24] <= pair_rb_robust_peak_height_63_r;
	end
	if (pair_rb_robust_peak_height_62_re) begin
		pair_reference_robust_csrstorage9_storage_full[23:16] <= pair_rb_robust_peak_height_62_r;
	end
	if (pair_rb_robust_peak_height_61_re) begin
		pair_reference_robust_csrstorage9_storage_full[15:8] <= pair_rb_robust_peak_height_61_r;
	end
	if (pair_rb_robust_peak_height_60_re) begin
		pair_reference_robust_csrstorage9_storage_full[7:0] <= pair_rb_robust_peak_height_60_r;
	end
	pair_reference_robust_csrstorage9_re <= pair_rb_robust_peak_height_60_re;
	if (pair_rb_robust_peak_height_73_re) begin
		pair_reference_robust_csrstorage10_storage_full[27:24] <= pair_rb_robust_peak_height_73_r;
	end
	if (pair_rb_robust_peak_height_72_re) begin
		pair_reference_robust_csrstorage10_storage_full[23:16] <= pair_rb_robust_peak_height_72_r;
	end
	if (pair_rb_robust_peak_height_71_re) begin
		pair_reference_robust_csrstorage10_storage_full[15:8] <= pair_rb_robust_peak_height_71_r;
	end
	if (pair_rb_robust_peak_height_70_re) begin
		pair_reference_robust_csrstorage10_storage_full[7:0] <= pair_rb_robust_peak_height_70_r;
	end
	pair_reference_robust_csrstorage10_re <= pair_rb_robust_peak_height_70_re;
	if (pair_rb_robust_peak_height_83_re) begin
		pair_reference_robust_csrstorage11_storage_full[27:24] <= pair_rb_robust_peak_height_83_r;
	end
	if (pair_rb_robust_peak_height_82_re) begin
		pair_reference_robust_csrstorage11_storage_full[23:16] <= pair_rb_robust_peak_height_82_r;
	end
	if (pair_rb_robust_peak_height_81_re) begin
		pair_reference_robust_csrstorage11_storage_full[15:8] <= pair_rb_robust_peak_height_81_r;
	end
	if (pair_rb_robust_peak_height_80_re) begin
		pair_reference_robust_csrstorage11_storage_full[7:0] <= pair_rb_robust_peak_height_80_r;
	end
	pair_reference_robust_csrstorage11_re <= pair_rb_robust_peak_height_80_re;
	if (pair_rb_robust_peak_height_93_re) begin
		pair_reference_robust_csrstorage12_storage_full[27:24] <= pair_rb_robust_peak_height_93_r;
	end
	if (pair_rb_robust_peak_height_92_re) begin
		pair_reference_robust_csrstorage12_storage_full[23:16] <= pair_rb_robust_peak_height_92_r;
	end
	if (pair_rb_robust_peak_height_91_re) begin
		pair_reference_robust_csrstorage12_storage_full[15:8] <= pair_rb_robust_peak_height_91_r;
	end
	if (pair_rb_robust_peak_height_90_re) begin
		pair_reference_robust_csrstorage12_storage_full[7:0] <= pair_rb_robust_peak_height_90_r;
	end
	pair_reference_robust_csrstorage12_re <= pair_rb_robust_peak_height_90_re;
	if (pair_rb_robust_peak_height_103_re) begin
		pair_reference_robust_csrstorage13_storage_full[27:24] <= pair_rb_robust_peak_height_103_r;
	end
	if (pair_rb_robust_peak_height_102_re) begin
		pair_reference_robust_csrstorage13_storage_full[23:16] <= pair_rb_robust_peak_height_102_r;
	end
	if (pair_rb_robust_peak_height_101_re) begin
		pair_reference_robust_csrstorage13_storage_full[15:8] <= pair_rb_robust_peak_height_101_r;
	end
	if (pair_rb_robust_peak_height_100_re) begin
		pair_reference_robust_csrstorage13_storage_full[7:0] <= pair_rb_robust_peak_height_100_r;
	end
	pair_reference_robust_csrstorage13_re <= pair_rb_robust_peak_height_100_re;
	if (pair_rb_robust_peak_height_113_re) begin
		pair_reference_robust_csrstorage14_storage_full[27:24] <= pair_rb_robust_peak_height_113_r;
	end
	if (pair_rb_robust_peak_height_112_re) begin
		pair_reference_robust_csrstorage14_storage_full[23:16] <= pair_rb_robust_peak_height_112_r;
	end
	if (pair_rb_robust_peak_height_111_re) begin
		pair_reference_robust_csrstorage14_storage_full[15:8] <= pair_rb_robust_peak_height_111_r;
	end
	if (pair_rb_robust_peak_height_110_re) begin
		pair_reference_robust_csrstorage14_storage_full[7:0] <= pair_rb_robust_peak_height_110_r;
	end
	pair_reference_robust_csrstorage14_re <= pair_rb_robust_peak_height_110_re;
	if (pair_rb_robust_peak_height_123_re) begin
		pair_reference_robust_csrstorage15_storage_full[27:24] <= pair_rb_robust_peak_height_123_r;
	end
	if (pair_rb_robust_peak_height_122_re) begin
		pair_reference_robust_csrstorage15_storage_full[23:16] <= pair_rb_robust_peak_height_122_r;
	end
	if (pair_rb_robust_peak_height_121_re) begin
		pair_reference_robust_csrstorage15_storage_full[15:8] <= pair_rb_robust_peak_height_121_r;
	end
	if (pair_rb_robust_peak_height_120_re) begin
		pair_reference_robust_csrstorage15_storage_full[7:0] <= pair_rb_robust_peak_height_120_r;
	end
	pair_reference_robust_csrstorage15_re <= pair_rb_robust_peak_height_120_re;
	if (pair_rb_robust_peak_height_133_re) begin
		pair_reference_robust_csrstorage16_storage_full[27:24] <= pair_rb_robust_peak_height_133_r;
	end
	if (pair_rb_robust_peak_height_132_re) begin
		pair_reference_robust_csrstorage16_storage_full[23:16] <= pair_rb_robust_peak_height_132_r;
	end
	if (pair_rb_robust_peak_height_131_re) begin
		pair_reference_robust_csrstorage16_storage_full[15:8] <= pair_rb_robust_peak_height_131_r;
	end
	if (pair_rb_robust_peak_height_130_re) begin
		pair_reference_robust_csrstorage16_storage_full[7:0] <= pair_rb_robust_peak_height_130_r;
	end
	pair_reference_robust_csrstorage16_re <= pair_rb_robust_peak_height_130_re;
	if (pair_rb_robust_peak_height_143_re) begin
		pair_reference_robust_csrstorage17_storage_full[27:24] <= pair_rb_robust_peak_height_143_r;
	end
	if (pair_rb_robust_peak_height_142_re) begin
		pair_reference_robust_csrstorage17_storage_full[23:16] <= pair_rb_robust_peak_height_142_r;
	end
	if (pair_rb_robust_peak_height_141_re) begin
		pair_reference_robust_csrstorage17_storage_full[15:8] <= pair_rb_robust_peak_height_141_r;
	end
	if (pair_rb_robust_peak_height_140_re) begin
		pair_reference_robust_csrstorage17_storage_full[7:0] <= pair_rb_robust_peak_height_140_r;
	end
	pair_reference_robust_csrstorage17_re <= pair_rb_robust_peak_height_140_re;
	if (pair_rb_robust_peak_height_153_re) begin
		pair_reference_robust_csrstorage18_storage_full[27:24] <= pair_rb_robust_peak_height_153_r;
	end
	if (pair_rb_robust_peak_height_152_re) begin
		pair_reference_robust_csrstorage18_storage_full[23:16] <= pair_rb_robust_peak_height_152_r;
	end
	if (pair_rb_robust_peak_height_151_re) begin
		pair_reference_robust_csrstorage18_storage_full[15:8] <= pair_rb_robust_peak_height_151_r;
	end
	if (pair_rb_robust_peak_height_150_re) begin
		pair_reference_robust_csrstorage18_storage_full[7:0] <= pair_rb_robust_peak_height_150_r;
	end
	pair_reference_robust_csrstorage18_re <= pair_rb_robust_peak_height_150_re;
	if (pair_rb_robust_peak_height_163_re) begin
		pair_reference_robust_csrstorage19_storage_full[27:24] <= pair_rb_robust_peak_height_163_r;
	end
	if (pair_rb_robust_peak_height_162_re) begin
		pair_reference_robust_csrstorage19_storage_full[23:16] <= pair_rb_robust_peak_height_162_r;
	end
	if (pair_rb_robust_peak_height_161_re) begin
		pair_reference_robust_csrstorage19_storage_full[15:8] <= pair_rb_robust_peak_height_161_r;
	end
	if (pair_rb_robust_peak_height_160_re) begin
		pair_reference_robust_csrstorage19_storage_full[7:0] <= pair_rb_robust_peak_height_160_r;
	end
	pair_reference_robust_csrstorage19_re <= pair_rb_robust_peak_height_160_re;
	if (pair_rb_robust_peak_height_173_re) begin
		pair_reference_robust_csrstorage20_storage_full[27:24] <= pair_rb_robust_peak_height_173_r;
	end
	if (pair_rb_robust_peak_height_172_re) begin
		pair_reference_robust_csrstorage20_storage_full[23:16] <= pair_rb_robust_peak_height_172_r;
	end
	if (pair_rb_robust_peak_height_171_re) begin
		pair_reference_robust_csrstorage20_storage_full[15:8] <= pair_rb_robust_peak_height_171_r;
	end
	if (pair_rb_robust_peak_height_170_re) begin
		pair_reference_robust_csrstorage20_storage_full[7:0] <= pair_rb_robust_peak_height_170_r;
	end
	pair_reference_robust_csrstorage20_re <= pair_rb_robust_peak_height_170_re;
	if (pair_rb_robust_peak_height_183_re) begin
		pair_reference_robust_csrstorage21_storage_full[27:24] <= pair_rb_robust_peak_height_183_r;
	end
	if (pair_rb_robust_peak_height_182_re) begin
		pair_reference_robust_csrstorage21_storage_full[23:16] <= pair_rb_robust_peak_height_182_r;
	end
	if (pair_rb_robust_peak_height_181_re) begin
		pair_reference_robust_csrstorage21_storage_full[15:8] <= pair_rb_robust_peak_height_181_r;
	end
	if (pair_rb_robust_peak_height_180_re) begin
		pair_reference_robust_csrstorage21_storage_full[7:0] <= pair_rb_robust_peak_height_180_r;
	end
	pair_reference_robust_csrstorage21_re <= pair_rb_robust_peak_height_180_re;
	if (pair_rb_robust_peak_height_193_re) begin
		pair_reference_robust_csrstorage22_storage_full[27:24] <= pair_rb_robust_peak_height_193_r;
	end
	if (pair_rb_robust_peak_height_192_re) begin
		pair_reference_robust_csrstorage22_storage_full[23:16] <= pair_rb_robust_peak_height_192_r;
	end
	if (pair_rb_robust_peak_height_191_re) begin
		pair_reference_robust_csrstorage22_storage_full[15:8] <= pair_rb_robust_peak_height_191_r;
	end
	if (pair_rb_robust_peak_height_190_re) begin
		pair_reference_robust_csrstorage22_storage_full[7:0] <= pair_rb_robust_peak_height_190_r;
	end
	pair_reference_robust_csrstorage22_re <= pair_rb_robust_peak_height_190_re;
	if (pair_rb_robust_peak_height_203_re) begin
		pair_reference_robust_csrstorage23_storage_full[27:24] <= pair_rb_robust_peak_height_203_r;
	end
	if (pair_rb_robust_peak_height_202_re) begin
		pair_reference_robust_csrstorage23_storage_full[23:16] <= pair_rb_robust_peak_height_202_r;
	end
	if (pair_rb_robust_peak_height_201_re) begin
		pair_reference_robust_csrstorage23_storage_full[15:8] <= pair_rb_robust_peak_height_201_r;
	end
	if (pair_rb_robust_peak_height_200_re) begin
		pair_reference_robust_csrstorage23_storage_full[7:0] <= pair_rb_robust_peak_height_200_r;
	end
	pair_reference_robust_csrstorage23_re <= pair_rb_robust_peak_height_200_re;
	if (pair_rb_robust_peak_height_213_re) begin
		pair_reference_robust_csrstorage24_storage_full[27:24] <= pair_rb_robust_peak_height_213_r;
	end
	if (pair_rb_robust_peak_height_212_re) begin
		pair_reference_robust_csrstorage24_storage_full[23:16] <= pair_rb_robust_peak_height_212_r;
	end
	if (pair_rb_robust_peak_height_211_re) begin
		pair_reference_robust_csrstorage24_storage_full[15:8] <= pair_rb_robust_peak_height_211_r;
	end
	if (pair_rb_robust_peak_height_210_re) begin
		pair_reference_robust_csrstorage24_storage_full[7:0] <= pair_rb_robust_peak_height_210_r;
	end
	pair_reference_robust_csrstorage24_re <= pair_rb_robust_peak_height_210_re;
	if (pair_rb_robust_peak_height_223_re) begin
		pair_reference_robust_csrstorage25_storage_full[27:24] <= pair_rb_robust_peak_height_223_r;
	end
	if (pair_rb_robust_peak_height_222_re) begin
		pair_reference_robust_csrstorage25_storage_full[23:16] <= pair_rb_robust_peak_height_222_r;
	end
	if (pair_rb_robust_peak_height_221_re) begin
		pair_reference_robust_csrstorage25_storage_full[15:8] <= pair_rb_robust_peak_height_221_r;
	end
	if (pair_rb_robust_peak_height_220_re) begin
		pair_reference_robust_csrstorage25_storage_full[7:0] <= pair_rb_robust_peak_height_220_r;
	end
	pair_reference_robust_csrstorage25_re <= pair_rb_robust_peak_height_220_re;
	if (pair_rb_robust_peak_height_233_re) begin
		pair_reference_robust_csrstorage26_storage_full[27:24] <= pair_rb_robust_peak_height_233_r;
	end
	if (pair_rb_robust_peak_height_232_re) begin
		pair_reference_robust_csrstorage26_storage_full[23:16] <= pair_rb_robust_peak_height_232_r;
	end
	if (pair_rb_robust_peak_height_231_re) begin
		pair_reference_robust_csrstorage26_storage_full[15:8] <= pair_rb_robust_peak_height_231_r;
	end
	if (pair_rb_robust_peak_height_230_re) begin
		pair_reference_robust_csrstorage26_storage_full[7:0] <= pair_rb_robust_peak_height_230_r;
	end
	pair_reference_robust_csrstorage26_re <= pair_rb_robust_peak_height_230_re;
	if (pair_rb_robust_peak_height_243_re) begin
		pair_reference_robust_csrstorage27_storage_full[27:24] <= pair_rb_robust_peak_height_243_r;
	end
	if (pair_rb_robust_peak_height_242_re) begin
		pair_reference_robust_csrstorage27_storage_full[23:16] <= pair_rb_robust_peak_height_242_r;
	end
	if (pair_rb_robust_peak_height_241_re) begin
		pair_reference_robust_csrstorage27_storage_full[15:8] <= pair_rb_robust_peak_height_241_r;
	end
	if (pair_rb_robust_peak_height_240_re) begin
		pair_reference_robust_csrstorage27_storage_full[7:0] <= pair_rb_robust_peak_height_240_r;
	end
	pair_reference_robust_csrstorage27_re <= pair_rb_robust_peak_height_240_re;
	if (pair_rb_robust_peak_height_253_re) begin
		pair_reference_robust_csrstorage28_storage_full[27:24] <= pair_rb_robust_peak_height_253_r;
	end
	if (pair_rb_robust_peak_height_252_re) begin
		pair_reference_robust_csrstorage28_storage_full[23:16] <= pair_rb_robust_peak_height_252_r;
	end
	if (pair_rb_robust_peak_height_251_re) begin
		pair_reference_robust_csrstorage28_storage_full[15:8] <= pair_rb_robust_peak_height_251_r;
	end
	if (pair_rb_robust_peak_height_250_re) begin
		pair_reference_robust_csrstorage28_storage_full[7:0] <= pair_rb_robust_peak_height_250_r;
	end
	pair_reference_robust_csrstorage28_re <= pair_rb_robust_peak_height_250_re;
	if (pair_rb_robust_peak_height_263_re) begin
		pair_reference_robust_csrstorage29_storage_full[27:24] <= pair_rb_robust_peak_height_263_r;
	end
	if (pair_rb_robust_peak_height_262_re) begin
		pair_reference_robust_csrstorage29_storage_full[23:16] <= pair_rb_robust_peak_height_262_r;
	end
	if (pair_rb_robust_peak_height_261_re) begin
		pair_reference_robust_csrstorage29_storage_full[15:8] <= pair_rb_robust_peak_height_261_r;
	end
	if (pair_rb_robust_peak_height_260_re) begin
		pair_reference_robust_csrstorage29_storage_full[7:0] <= pair_rb_robust_peak_height_260_r;
	end
	pair_reference_robust_csrstorage29_re <= pair_rb_robust_peak_height_260_re;
	if (pair_rb_robust_peak_height_273_re) begin
		pair_reference_robust_csrstorage30_storage_full[27:24] <= pair_rb_robust_peak_height_273_r;
	end
	if (pair_rb_robust_peak_height_272_re) begin
		pair_reference_robust_csrstorage30_storage_full[23:16] <= pair_rb_robust_peak_height_272_r;
	end
	if (pair_rb_robust_peak_height_271_re) begin
		pair_reference_robust_csrstorage30_storage_full[15:8] <= pair_rb_robust_peak_height_271_r;
	end
	if (pair_rb_robust_peak_height_270_re) begin
		pair_reference_robust_csrstorage30_storage_full[7:0] <= pair_rb_robust_peak_height_270_r;
	end
	pair_reference_robust_csrstorage30_re <= pair_rb_robust_peak_height_270_re;
	if (pair_rb_robust_peak_height_283_re) begin
		pair_reference_robust_csrstorage31_storage_full[27:24] <= pair_rb_robust_peak_height_283_r;
	end
	if (pair_rb_robust_peak_height_282_re) begin
		pair_reference_robust_csrstorage31_storage_full[23:16] <= pair_rb_robust_peak_height_282_r;
	end
	if (pair_rb_robust_peak_height_281_re) begin
		pair_reference_robust_csrstorage31_storage_full[15:8] <= pair_rb_robust_peak_height_281_r;
	end
	if (pair_rb_robust_peak_height_280_re) begin
		pair_reference_robust_csrstorage31_storage_full[7:0] <= pair_rb_robust_peak_height_280_r;
	end
	pair_reference_robust_csrstorage31_re <= pair_rb_robust_peak_height_280_re;
	if (pair_rb_robust_peak_height_293_re) begin
		pair_reference_robust_csrstorage32_storage_full[27:24] <= pair_rb_robust_peak_height_293_r;
	end
	if (pair_rb_robust_peak_height_292_re) begin
		pair_reference_robust_csrstorage32_storage_full[23:16] <= pair_rb_robust_peak_height_292_r;
	end
	if (pair_rb_robust_peak_height_291_re) begin
		pair_reference_robust_csrstorage32_storage_full[15:8] <= pair_rb_robust_peak_height_291_r;
	end
	if (pair_rb_robust_peak_height_290_re) begin
		pair_reference_robust_csrstorage32_storage_full[7:0] <= pair_rb_robust_peak_height_290_r;
	end
	pair_reference_robust_csrstorage32_re <= pair_rb_robust_peak_height_290_re;
	if (pair_rb_robust_peak_height_303_re) begin
		pair_reference_robust_csrstorage33_storage_full[27:24] <= pair_rb_robust_peak_height_303_r;
	end
	if (pair_rb_robust_peak_height_302_re) begin
		pair_reference_robust_csrstorage33_storage_full[23:16] <= pair_rb_robust_peak_height_302_r;
	end
	if (pair_rb_robust_peak_height_301_re) begin
		pair_reference_robust_csrstorage33_storage_full[15:8] <= pair_rb_robust_peak_height_301_r;
	end
	if (pair_rb_robust_peak_height_300_re) begin
		pair_reference_robust_csrstorage33_storage_full[7:0] <= pair_rb_robust_peak_height_300_r;
	end
	pair_reference_robust_csrstorage33_re <= pair_rb_robust_peak_height_300_re;
	if (pair_rb_robust_peak_height_313_re) begin
		pair_reference_robust_csrstorage34_storage_full[27:24] <= pair_rb_robust_peak_height_313_r;
	end
	if (pair_rb_robust_peak_height_312_re) begin
		pair_reference_robust_csrstorage34_storage_full[23:16] <= pair_rb_robust_peak_height_312_r;
	end
	if (pair_rb_robust_peak_height_311_re) begin
		pair_reference_robust_csrstorage34_storage_full[15:8] <= pair_rb_robust_peak_height_311_r;
	end
	if (pair_rb_robust_peak_height_310_re) begin
		pair_reference_robust_csrstorage34_storage_full[7:0] <= pair_rb_robust_peak_height_310_r;
	end
	pair_reference_robust_csrstorage34_re <= pair_rb_robust_peak_height_310_re;
	if (pair_rb_robust_wait_for_01_re) begin
		pair_reference_robust_csrstorage35_storage_full[13:8] <= pair_rb_robust_wait_for_01_r;
	end
	if (pair_rb_robust_wait_for_00_re) begin
		pair_reference_robust_csrstorage35_storage_full[7:0] <= pair_rb_robust_wait_for_00_r;
	end
	pair_reference_robust_csrstorage35_re <= pair_rb_robust_wait_for_00_re;
	if (pair_rb_robust_wait_for_11_re) begin
		pair_reference_robust_csrstorage36_storage_full[13:8] <= pair_rb_robust_wait_for_11_r;
	end
	if (pair_rb_robust_wait_for_10_re) begin
		pair_reference_robust_csrstorage36_storage_full[7:0] <= pair_rb_robust_wait_for_10_r;
	end
	pair_reference_robust_csrstorage36_re <= pair_rb_robust_wait_for_10_re;
	if (pair_rb_robust_wait_for_21_re) begin
		pair_reference_robust_csrstorage37_storage_full[13:8] <= pair_rb_robust_wait_for_21_r;
	end
	if (pair_rb_robust_wait_for_20_re) begin
		pair_reference_robust_csrstorage37_storage_full[7:0] <= pair_rb_robust_wait_for_20_r;
	end
	pair_reference_robust_csrstorage37_re <= pair_rb_robust_wait_for_20_re;
	if (pair_rb_robust_wait_for_31_re) begin
		pair_reference_robust_csrstorage38_storage_full[13:8] <= pair_rb_robust_wait_for_31_r;
	end
	if (pair_rb_robust_wait_for_30_re) begin
		pair_reference_robust_csrstorage38_storage_full[7:0] <= pair_rb_robust_wait_for_30_r;
	end
	pair_reference_robust_csrstorage38_re <= pair_rb_robust_wait_for_30_re;
	if (pair_rb_robust_wait_for_41_re) begin
		pair_reference_robust_csrstorage39_storage_full[13:8] <= pair_rb_robust_wait_for_41_r;
	end
	if (pair_rb_robust_wait_for_40_re) begin
		pair_reference_robust_csrstorage39_storage_full[7:0] <= pair_rb_robust_wait_for_40_r;
	end
	pair_reference_robust_csrstorage39_re <= pair_rb_robust_wait_for_40_re;
	if (pair_rb_robust_wait_for_51_re) begin
		pair_reference_robust_csrstorage40_storage_full[13:8] <= pair_rb_robust_wait_for_51_r;
	end
	if (pair_rb_robust_wait_for_50_re) begin
		pair_reference_robust_csrstorage40_storage_full[7:0] <= pair_rb_robust_wait_for_50_r;
	end
	pair_reference_robust_csrstorage40_re <= pair_rb_robust_wait_for_50_re;
	if (pair_rb_robust_wait_for_61_re) begin
		pair_reference_robust_csrstorage41_storage_full[13:8] <= pair_rb_robust_wait_for_61_r;
	end
	if (pair_rb_robust_wait_for_60_re) begin
		pair_reference_robust_csrstorage41_storage_full[7:0] <= pair_rb_robust_wait_for_60_r;
	end
	pair_reference_robust_csrstorage41_re <= pair_rb_robust_wait_for_60_re;
	if (pair_rb_robust_wait_for_71_re) begin
		pair_reference_robust_csrstorage42_storage_full[13:8] <= pair_rb_robust_wait_for_71_r;
	end
	if (pair_rb_robust_wait_for_70_re) begin
		pair_reference_robust_csrstorage42_storage_full[7:0] <= pair_rb_robust_wait_for_70_r;
	end
	pair_reference_robust_csrstorage42_re <= pair_rb_robust_wait_for_70_re;
	if (pair_rb_robust_wait_for_81_re) begin
		pair_reference_robust_csrstorage43_storage_full[13:8] <= pair_rb_robust_wait_for_81_r;
	end
	if (pair_rb_robust_wait_for_80_re) begin
		pair_reference_robust_csrstorage43_storage_full[7:0] <= pair_rb_robust_wait_for_80_r;
	end
	pair_reference_robust_csrstorage43_re <= pair_rb_robust_wait_for_80_re;
	if (pair_rb_robust_wait_for_91_re) begin
		pair_reference_robust_csrstorage44_storage_full[13:8] <= pair_rb_robust_wait_for_91_r;
	end
	if (pair_rb_robust_wait_for_90_re) begin
		pair_reference_robust_csrstorage44_storage_full[7:0] <= pair_rb_robust_wait_for_90_r;
	end
	pair_reference_robust_csrstorage44_re <= pair_rb_robust_wait_for_90_re;
	if (pair_rb_robust_wait_for_101_re) begin
		pair_reference_robust_csrstorage45_storage_full[13:8] <= pair_rb_robust_wait_for_101_r;
	end
	if (pair_rb_robust_wait_for_100_re) begin
		pair_reference_robust_csrstorage45_storage_full[7:0] <= pair_rb_robust_wait_for_100_r;
	end
	pair_reference_robust_csrstorage45_re <= pair_rb_robust_wait_for_100_re;
	if (pair_rb_robust_wait_for_111_re) begin
		pair_reference_robust_csrstorage46_storage_full[13:8] <= pair_rb_robust_wait_for_111_r;
	end
	if (pair_rb_robust_wait_for_110_re) begin
		pair_reference_robust_csrstorage46_storage_full[7:0] <= pair_rb_robust_wait_for_110_r;
	end
	pair_reference_robust_csrstorage46_re <= pair_rb_robust_wait_for_110_re;
	if (pair_rb_robust_wait_for_121_re) begin
		pair_reference_robust_csrstorage47_storage_full[13:8] <= pair_rb_robust_wait_for_121_r;
	end
	if (pair_rb_robust_wait_for_120_re) begin
		pair_reference_robust_csrstorage47_storage_full[7:0] <= pair_rb_robust_wait_for_120_r;
	end
	pair_reference_robust_csrstorage47_re <= pair_rb_robust_wait_for_120_re;
	if (pair_rb_robust_wait_for_131_re) begin
		pair_reference_robust_csrstorage48_storage_full[13:8] <= pair_rb_robust_wait_for_131_r;
	end
	if (pair_rb_robust_wait_for_130_re) begin
		pair_reference_robust_csrstorage48_storage_full[7:0] <= pair_rb_robust_wait_for_130_r;
	end
	pair_reference_robust_csrstorage48_re <= pair_rb_robust_wait_for_130_re;
	if (pair_rb_robust_wait_for_141_re) begin
		pair_reference_robust_csrstorage49_storage_full[13:8] <= pair_rb_robust_wait_for_141_r;
	end
	if (pair_rb_robust_wait_for_140_re) begin
		pair_reference_robust_csrstorage49_storage_full[7:0] <= pair_rb_robust_wait_for_140_r;
	end
	pair_reference_robust_csrstorage49_re <= pair_rb_robust_wait_for_140_re;
	if (pair_rb_robust_wait_for_151_re) begin
		pair_reference_robust_csrstorage50_storage_full[13:8] <= pair_rb_robust_wait_for_151_r;
	end
	if (pair_rb_robust_wait_for_150_re) begin
		pair_reference_robust_csrstorage50_storage_full[7:0] <= pair_rb_robust_wait_for_150_r;
	end
	pair_reference_robust_csrstorage50_re <= pair_rb_robust_wait_for_150_re;
	if (pair_rb_robust_wait_for_161_re) begin
		pair_reference_robust_csrstorage51_storage_full[13:8] <= pair_rb_robust_wait_for_161_r;
	end
	if (pair_rb_robust_wait_for_160_re) begin
		pair_reference_robust_csrstorage51_storage_full[7:0] <= pair_rb_robust_wait_for_160_r;
	end
	pair_reference_robust_csrstorage51_re <= pair_rb_robust_wait_for_160_re;
	if (pair_rb_robust_wait_for_171_re) begin
		pair_reference_robust_csrstorage52_storage_full[13:8] <= pair_rb_robust_wait_for_171_r;
	end
	if (pair_rb_robust_wait_for_170_re) begin
		pair_reference_robust_csrstorage52_storage_full[7:0] <= pair_rb_robust_wait_for_170_r;
	end
	pair_reference_robust_csrstorage52_re <= pair_rb_robust_wait_for_170_re;
	if (pair_rb_robust_wait_for_181_re) begin
		pair_reference_robust_csrstorage53_storage_full[13:8] <= pair_rb_robust_wait_for_181_r;
	end
	if (pair_rb_robust_wait_for_180_re) begin
		pair_reference_robust_csrstorage53_storage_full[7:0] <= pair_rb_robust_wait_for_180_r;
	end
	pair_reference_robust_csrstorage53_re <= pair_rb_robust_wait_for_180_re;
	if (pair_rb_robust_wait_for_191_re) begin
		pair_reference_robust_csrstorage54_storage_full[13:8] <= pair_rb_robust_wait_for_191_r;
	end
	if (pair_rb_robust_wait_for_190_re) begin
		pair_reference_robust_csrstorage54_storage_full[7:0] <= pair_rb_robust_wait_for_190_r;
	end
	pair_reference_robust_csrstorage54_re <= pair_rb_robust_wait_for_190_re;
	if (pair_rb_robust_wait_for_201_re) begin
		pair_reference_robust_csrstorage55_storage_full[13:8] <= pair_rb_robust_wait_for_201_r;
	end
	if (pair_rb_robust_wait_for_200_re) begin
		pair_reference_robust_csrstorage55_storage_full[7:0] <= pair_rb_robust_wait_for_200_r;
	end
	pair_reference_robust_csrstorage55_re <= pair_rb_robust_wait_for_200_re;
	if (pair_rb_robust_wait_for_211_re) begin
		pair_reference_robust_csrstorage56_storage_full[13:8] <= pair_rb_robust_wait_for_211_r;
	end
	if (pair_rb_robust_wait_for_210_re) begin
		pair_reference_robust_csrstorage56_storage_full[7:0] <= pair_rb_robust_wait_for_210_r;
	end
	pair_reference_robust_csrstorage56_re <= pair_rb_robust_wait_for_210_re;
	if (pair_rb_robust_wait_for_221_re) begin
		pair_reference_robust_csrstorage57_storage_full[13:8] <= pair_rb_robust_wait_for_221_r;
	end
	if (pair_rb_robust_wait_for_220_re) begin
		pair_reference_robust_csrstorage57_storage_full[7:0] <= pair_rb_robust_wait_for_220_r;
	end
	pair_reference_robust_csrstorage57_re <= pair_rb_robust_wait_for_220_re;
	if (pair_rb_robust_wait_for_231_re) begin
		pair_reference_robust_csrstorage58_storage_full[13:8] <= pair_rb_robust_wait_for_231_r;
	end
	if (pair_rb_robust_wait_for_230_re) begin
		pair_reference_robust_csrstorage58_storage_full[7:0] <= pair_rb_robust_wait_for_230_r;
	end
	pair_reference_robust_csrstorage58_re <= pair_rb_robust_wait_for_230_re;
	if (pair_rb_robust_wait_for_241_re) begin
		pair_reference_robust_csrstorage59_storage_full[13:8] <= pair_rb_robust_wait_for_241_r;
	end
	if (pair_rb_robust_wait_for_240_re) begin
		pair_reference_robust_csrstorage59_storage_full[7:0] <= pair_rb_robust_wait_for_240_r;
	end
	pair_reference_robust_csrstorage59_re <= pair_rb_robust_wait_for_240_re;
	if (pair_rb_robust_wait_for_251_re) begin
		pair_reference_robust_csrstorage60_storage_full[13:8] <= pair_rb_robust_wait_for_251_r;
	end
	if (pair_rb_robust_wait_for_250_re) begin
		pair_reference_robust_csrstorage60_storage_full[7:0] <= pair_rb_robust_wait_for_250_r;
	end
	pair_reference_robust_csrstorage60_re <= pair_rb_robust_wait_for_250_re;
	if (pair_rb_robust_wait_for_261_re) begin
		pair_reference_robust_csrstorage61_storage_full[13:8] <= pair_rb_robust_wait_for_261_r;
	end
	if (pair_rb_robust_wait_for_260_re) begin
		pair_reference_robust_csrstorage61_storage_full[7:0] <= pair_rb_robust_wait_for_260_r;
	end
	pair_reference_robust_csrstorage61_re <= pair_rb_robust_wait_for_260_re;
	if (pair_rb_robust_wait_for_271_re) begin
		pair_reference_robust_csrstorage62_storage_full[13:8] <= pair_rb_robust_wait_for_271_r;
	end
	if (pair_rb_robust_wait_for_270_re) begin
		pair_reference_robust_csrstorage62_storage_full[7:0] <= pair_rb_robust_wait_for_270_r;
	end
	pair_reference_robust_csrstorage62_re <= pair_rb_robust_wait_for_270_re;
	if (pair_rb_robust_wait_for_281_re) begin
		pair_reference_robust_csrstorage63_storage_full[13:8] <= pair_rb_robust_wait_for_281_r;
	end
	if (pair_rb_robust_wait_for_280_re) begin
		pair_reference_robust_csrstorage63_storage_full[7:0] <= pair_rb_robust_wait_for_280_r;
	end
	pair_reference_robust_csrstorage63_re <= pair_rb_robust_wait_for_280_re;
	if (pair_rb_robust_wait_for_291_re) begin
		pair_reference_robust_csrstorage64_storage_full[13:8] <= pair_rb_robust_wait_for_291_r;
	end
	if (pair_rb_robust_wait_for_290_re) begin
		pair_reference_robust_csrstorage64_storage_full[7:0] <= pair_rb_robust_wait_for_290_r;
	end
	pair_reference_robust_csrstorage64_re <= pair_rb_robust_wait_for_290_re;
	if (pair_rb_robust_wait_for_301_re) begin
		pair_reference_robust_csrstorage65_storage_full[13:8] <= pair_rb_robust_wait_for_301_r;
	end
	if (pair_rb_robust_wait_for_300_re) begin
		pair_reference_robust_csrstorage65_storage_full[7:0] <= pair_rb_robust_wait_for_300_r;
	end
	pair_reference_robust_csrstorage65_re <= pair_rb_robust_wait_for_300_re;
	if (pair_rb_robust_wait_for_311_re) begin
		pair_reference_robust_csrstorage66_storage_full[13:8] <= pair_rb_robust_wait_for_311_r;
	end
	if (pair_rb_robust_wait_for_310_re) begin
		pair_reference_robust_csrstorage66_storage_full[7:0] <= pair_rb_robust_wait_for_310_r;
	end
	pair_reference_robust_csrstorage66_re <= pair_rb_robust_wait_for_310_re;
	if (pair_rb_fast_target_position1_re) begin
		pair_reference_fast_storage_full[13:8] <= pair_rb_fast_target_position1_r;
	end
	if (pair_rb_fast_target_position0_re) begin
		pair_reference_fast_storage_full[7:0] <= pair_rb_fast_target_position0_r;
	end
	pair_reference_fast_re <= pair_rb_fast_target_position0_re;
	if (pair_rb_request_lock0_re) begin
		pair_reference_request_lock_storage_full <= pair_rb_request_lock0_r;
	end
	pair_reference_request_lock_re <= pair_rb_request_lock0_re;
	if (pair_rb_autolock_mode0_re) begin
		pair_reference_autolock_mode_storage_full[1:0] <= pair_rb_autolock_mode0_r;
	end
	pair_reference_autolock_mode_re <= pair_rb_autolock_mode0_re;
	pair_cb_bus_dat_r <= 1'd0;
	if (pair_cb_sel) begin
		case (pair_cb_bus_adr[7:0])
			1'd0: begin
				pair_cb_bus_dat_r <= pair_cb_robust_time_scale1_w;
			end
			1'd1: begin
				pair_cb_bus_dat_r <= pair_cb_robust_time_scale0_w;
			end
			2'd2: begin
				pair_cb_bus_dat_r <= pair_cb_robust_N_instructions0_w;
			end
			2'd3: begin
				pair_cb_bus_dat_r <= pair_cb_robust_final_wait_time1_w;
			end
			3'd4: begin
				pair_cb_bus_dat_r <= pair_cb_robust_final_wait_time0_w;
			end
			3'd5: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_03_w;
			end
			3'd6: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_02_w;
			end
			3'd7: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_01_w;
			end
			4'd8: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_00_w;
			end
			4'd9: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_13_w;
			end
			4'd10: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_12_w;
			end
			4'd11: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_11_w;
			end
			4'd12: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_10_w;
			end
			4'd13: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_23_w;
			end
			4'd14: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_22_w;
			end
			4'd15: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_21_w;
			end
			5'd16: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_20_w;
			end
			5'd17: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_33_w;
			end
			5'd18: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_32_w;
			end
			5'd19: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_31_w;
			end
			5'd20: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_30_w;
			end
			5'd21: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_43_w;
			end
			5'd22: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_42_w;
			end
			5'd23: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_41_w;
			end
			5'd24: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_40_w;
			end
			5'd25: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_53_w;
			end
			5'd26: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_52_w;
			end
			5'd27: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_51_w;
			end
			5'd28: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_50_w;
			end
			5'd29: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_63_w;
			end
			5'd30: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_62_w;
			end
			5'd31: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_61_w;
			end
			6'd32: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_60_w;
			end
			6'd33: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_73_w;
			end
			6'd34: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_72_w;
			end
			6'd35: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_71_w;
			end
			6'd36: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_70_w;
			end
			6'd37: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_83_w;
			end
			6'd38: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_82_w;
			end
			6'd39: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_81_w;
			end
			6'd40: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_80_w;
			end
			6'd41: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_93_w;
			end
			6'd42: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_92_w;
			end
			6'd43: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_91_w;
			end
			6'd44: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_90_w;
			end
			6'd45: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_103_w;
			end
			6'd46: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_102_w;
			end
			6'd47: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_101_w;
			end
			6'd48: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_100_w;
			end
			6'd49: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_113_w;
			end
			6'd50: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_112_w;
			end
			6'd51: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_111_w;
			end
			6'd52: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_110_w;
			end
			6'd53: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_123_w;
			end
			6'd54: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_122_w;
			end
			6'd55: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_121_w;
			end
			6'd56: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_120_w;
			end
			6'd57: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_133_w;
			end
			6'd58: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_132_w;
			end
			6'd59: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_131_w;
			end
			6'd60: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_130_w;
			end
			6'd61: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_143_w;
			end
			6'd62: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_142_w;
			end
			6'd63: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_141_w;
			end
			7'd64: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_140_w;
			end
			7'd65: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_153_w;
			end
			7'd66: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_152_w;
			end
			7'd67: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_151_w;
			end
			7'd68: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_150_w;
			end
			7'd69: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_163_w;
			end
			7'd70: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_162_w;
			end
			7'd71: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_161_w;
			end
			7'd72: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_160_w;
			end
			7'd73: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_173_w;
			end
			7'd74: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_172_w;
			end
			7'd75: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_171_w;
			end
			7'd76: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_170_w;
			end
			7'd77: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_183_w;
			end
			7'd78: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_182_w;
			end
			7'd79: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_181_w;
			end
			7'd80: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_180_w;
			end
			7'd81: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_193_w;
			end
			7'd82: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_192_w;
			end
			7'd83: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_191_w;
			end
			7'd84: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_190_w;
			end
			7'd85: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_203_w;
			end
			7'd86: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_202_w;
			end
			7'd87: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_201_w;
			end
			7'd88: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_200_w;
			end
			7'd89: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_213_w;
			end
			7'd90: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_212_w;
			end
			7'd91: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_211_w;
			end
			7'd92: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_210_w;
			end
			7'd93: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_223_w;
			end
			7'd94: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_222_w;
			end
			7'd95: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_221_w;
			end
			7'd96: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_220_w;
			end
			7'd97: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_233_w;
			end
			7'd98: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_232_w;
			end
			7'd99: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_231_w;
			end
			7'd100: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_230_w;
			end
			7'd101: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_243_w;
			end
			7'd102: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_242_w;
			end
			7'd103: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_241_w;
			end
			7'd104: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_240_w;
			end
			7'd105: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_253_w;
			end
			7'd106: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_252_w;
			end
			7'd107: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_251_w;
			end
			7'd108: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_250_w;
			end
			7'd109: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_263_w;
			end
			7'd110: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_262_w;
			end
			7'd111: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_261_w;
			end
			7'd112: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_260_w;
			end
			7'd113: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_273_w;
			end
			7'd114: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_272_w;
			end
			7'd115: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_271_w;
			end
			7'd116: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_270_w;
			end
			7'd117: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_283_w;
			end
			7'd118: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_282_w;
			end
			7'd119: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_281_w;
			end
			7'd120: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_280_w;
			end
			7'd121: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_293_w;
			end
			7'd122: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_292_w;
			end
			7'd123: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_291_w;
			end
			7'd124: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_290_w;
			end
			7'd125: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_303_w;
			end
			7'd126: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_302_w;
			end
			7'd127: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_301_w;
			end
			8'd128: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_300_w;
			end
			8'd129: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_313_w;
			end
			8'd130: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_312_w;
			end
			8'd131: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_311_w;
			end
			8'd132: begin
				pair_cb_bus_dat_r <= pair_cb_robust_peak_height_310_w;
			end
			8'd133: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_01_w;
			end
			8'd134: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_00_w;
			end
			8'd135: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_11_w;
			end
			8'd136: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_10_w;
			end
			8'd137: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_21_w;
			end
			8'd138: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_20_w;
			end
			8'd139: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_31_w;
			end
			8'd140: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_30_w;
			end
			8'd141: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_41_w;
			end
			8'd142: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_40_w;
			end
			8'd143: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_51_w;
			end
			8'd144: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_50_w;
			end
			8'd145: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_61_w;
			end
			8'd146: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_60_w;
			end
			8'd147: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_71_w;
			end
			8'd148: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_70_w;
			end
			8'd149: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_81_w;
			end
			8'd150: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_80_w;
			end
			8'd151: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_91_w;
			end
			8'd152: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_90_w;
			end
			8'd153: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_101_w;
			end
			8'd154: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_100_w;
			end
			8'd155: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_111_w;
			end
			8'd156: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_110_w;
			end
			8'd157: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_121_w;
			end
			8'd158: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_120_w;
			end
			8'd159: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_131_w;
			end
			8'd160: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_130_w;
			end
			8'd161: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_141_w;
			end
			8'd162: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_140_w;
			end
			8'd163: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_151_w;
			end
			8'd164: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_150_w;
			end
			8'd165: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_161_w;
			end
			8'd166: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_160_w;
			end
			8'd167: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_171_w;
			end
			8'd168: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_170_w;
			end
			8'd169: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_181_w;
			end
			8'd170: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_180_w;
			end
			8'd171: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_191_w;
			end
			8'd172: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_190_w;
			end
			8'd173: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_201_w;
			end
			8'd174: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_200_w;
			end
			8'd175: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_211_w;
			end
			8'd176: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_210_w;
			end
			8'd177: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_221_w;
			end
			8'd178: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_220_w;
			end
			8'd179: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_231_w;
			end
			8'd180: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_230_w;
			end
			8'd181: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_241_w;
			end
			8'd182: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_240_w;
			end
			8'd183: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_251_w;
			end
			8'd184: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_250_w;
			end
			8'd185: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_261_w;
			end
			8'd186: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_260_w;
			end
			8'd187: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_271_w;
			end
			8'd188: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_270_w;
			end
			8'd189: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_281_w;
			end
			8'd190: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_280_w;
			end
			8'd191: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_291_w;
			end
			8'd192: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_290_w;
			end
			8'd193: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_301_w;
			end
			8'd194: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_300_w;
			end
			8'd195: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_311_w;
			end
			8'd196: begin
				pair_cb_bus_dat_r <= pair_cb_robust_wait_for_310_w;
			end
			8'd197: begin
				pair_cb_bus_dat_r <= pair_cb_fast_target_position1_w;
			end
			8'd198: begin
				pair_cb_bus_dat_r <= pair_cb_fast_target_position0_w;
			end
			8'd199: begin
				pair_cb_bus_dat_r <= pair_cb_request_lock0_w;
			end
			8'd200: begin
				pair_cb_bus_dat_r <= pair_cb_autolock_mode0_w;
			end
			8'd201: begin
				pair_cb_bus_dat_r <= pair_cb_lock_running_w;
			end
		endcase
	end
	if (pair_cb_robust_time_scale1_re) begin
		pair_candidate_pipelinedrobustautolock_time_scale_storage_full[13:8] <= pair_cb_robust_time_scale1_r;
	end
	if (pair_cb_robust_time_scale0_re) begin
		pair_candidate_pipelinedrobustautolock_time_scale_storage_full[7:0] <= pair_cb_robust_time_scale0_r;
	end
	pair_candidate_pipelinedrobustautolock_time_scale_re <= pair_cb_robust_time_scale0_re;
	if (pair_cb_robust_N_instructions0_re) begin
		pair_candidate_pipelinedrobustautolock_N_instructions_storage_full[4:0] <= pair_cb_robust_N_instructions0_r;
	end
	pair_candidate_pipelinedrobustautolock_N_instructions_re <= pair_cb_robust_N_instructions0_re;
	if (pair_cb_robust_final_wait_time1_re) begin
		pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full[13:8] <= pair_cb_robust_final_wait_time1_r;
	end
	if (pair_cb_robust_final_wait_time0_re) begin
		pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full[7:0] <= pair_cb_robust_final_wait_time0_r;
	end
	pair_candidate_pipelinedrobustautolock_final_wait_time_re <= pair_cb_robust_final_wait_time0_re;
	if (pair_cb_robust_peak_height_03_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[27:24] <= pair_cb_robust_peak_height_03_r;
	end
	if (pair_cb_robust_peak_height_02_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[23:16] <= pair_cb_robust_peak_height_02_r;
	end
	if (pair_cb_robust_peak_height_01_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[15:8] <= pair_cb_robust_peak_height_01_r;
	end
	if (pair_cb_robust_peak_height_00_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full[7:0] <= pair_cb_robust_peak_height_00_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage0_re <= pair_cb_robust_peak_height_00_re;
	if (pair_cb_robust_peak_height_13_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[27:24] <= pair_cb_robust_peak_height_13_r;
	end
	if (pair_cb_robust_peak_height_12_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[23:16] <= pair_cb_robust_peak_height_12_r;
	end
	if (pair_cb_robust_peak_height_11_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[15:8] <= pair_cb_robust_peak_height_11_r;
	end
	if (pair_cb_robust_peak_height_10_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full[7:0] <= pair_cb_robust_peak_height_10_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage1_re <= pair_cb_robust_peak_height_10_re;
	if (pair_cb_robust_peak_height_23_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[27:24] <= pair_cb_robust_peak_height_23_r;
	end
	if (pair_cb_robust_peak_height_22_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[23:16] <= pair_cb_robust_peak_height_22_r;
	end
	if (pair_cb_robust_peak_height_21_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[15:8] <= pair_cb_robust_peak_height_21_r;
	end
	if (pair_cb_robust_peak_height_20_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full[7:0] <= pair_cb_robust_peak_height_20_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage2_re <= pair_cb_robust_peak_height_20_re;
	if (pair_cb_robust_peak_height_33_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[27:24] <= pair_cb_robust_peak_height_33_r;
	end
	if (pair_cb_robust_peak_height_32_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[23:16] <= pair_cb_robust_peak_height_32_r;
	end
	if (pair_cb_robust_peak_height_31_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[15:8] <= pair_cb_robust_peak_height_31_r;
	end
	if (pair_cb_robust_peak_height_30_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full[7:0] <= pair_cb_robust_peak_height_30_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage3_re <= pair_cb_robust_peak_height_30_re;
	if (pair_cb_robust_peak_height_43_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[27:24] <= pair_cb_robust_peak_height_43_r;
	end
	if (pair_cb_robust_peak_height_42_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[23:16] <= pair_cb_robust_peak_height_42_r;
	end
	if (pair_cb_robust_peak_height_41_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[15:8] <= pair_cb_robust_peak_height_41_r;
	end
	if (pair_cb_robust_peak_height_40_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full[7:0] <= pair_cb_robust_peak_height_40_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage4_re <= pair_cb_robust_peak_height_40_re;
	if (pair_cb_robust_peak_height_53_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[27:24] <= pair_cb_robust_peak_height_53_r;
	end
	if (pair_cb_robust_peak_height_52_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[23:16] <= pair_cb_robust_peak_height_52_r;
	end
	if (pair_cb_robust_peak_height_51_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[15:8] <= pair_cb_robust_peak_height_51_r;
	end
	if (pair_cb_robust_peak_height_50_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full[7:0] <= pair_cb_robust_peak_height_50_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage5_re <= pair_cb_robust_peak_height_50_re;
	if (pair_cb_robust_peak_height_63_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[27:24] <= pair_cb_robust_peak_height_63_r;
	end
	if (pair_cb_robust_peak_height_62_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[23:16] <= pair_cb_robust_peak_height_62_r;
	end
	if (pair_cb_robust_peak_height_61_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[15:8] <= pair_cb_robust_peak_height_61_r;
	end
	if (pair_cb_robust_peak_height_60_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full[7:0] <= pair_cb_robust_peak_height_60_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage6_re <= pair_cb_robust_peak_height_60_re;
	if (pair_cb_robust_peak_height_73_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[27:24] <= pair_cb_robust_peak_height_73_r;
	end
	if (pair_cb_robust_peak_height_72_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[23:16] <= pair_cb_robust_peak_height_72_r;
	end
	if (pair_cb_robust_peak_height_71_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[15:8] <= pair_cb_robust_peak_height_71_r;
	end
	if (pair_cb_robust_peak_height_70_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full[7:0] <= pair_cb_robust_peak_height_70_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage7_re <= pair_cb_robust_peak_height_70_re;
	if (pair_cb_robust_peak_height_83_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[27:24] <= pair_cb_robust_peak_height_83_r;
	end
	if (pair_cb_robust_peak_height_82_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[23:16] <= pair_cb_robust_peak_height_82_r;
	end
	if (pair_cb_robust_peak_height_81_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[15:8] <= pair_cb_robust_peak_height_81_r;
	end
	if (pair_cb_robust_peak_height_80_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full[7:0] <= pair_cb_robust_peak_height_80_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage8_re <= pair_cb_robust_peak_height_80_re;
	if (pair_cb_robust_peak_height_93_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[27:24] <= pair_cb_robust_peak_height_93_r;
	end
	if (pair_cb_robust_peak_height_92_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[23:16] <= pair_cb_robust_peak_height_92_r;
	end
	if (pair_cb_robust_peak_height_91_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[15:8] <= pair_cb_robust_peak_height_91_r;
	end
	if (pair_cb_robust_peak_height_90_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full[7:0] <= pair_cb_robust_peak_height_90_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage9_re <= pair_cb_robust_peak_height_90_re;
	if (pair_cb_robust_peak_height_103_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[27:24] <= pair_cb_robust_peak_height_103_r;
	end
	if (pair_cb_robust_peak_height_102_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[23:16] <= pair_cb_robust_peak_height_102_r;
	end
	if (pair_cb_robust_peak_height_101_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[15:8] <= pair_cb_robust_peak_height_101_r;
	end
	if (pair_cb_robust_peak_height_100_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full[7:0] <= pair_cb_robust_peak_height_100_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage10_re <= pair_cb_robust_peak_height_100_re;
	if (pair_cb_robust_peak_height_113_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[27:24] <= pair_cb_robust_peak_height_113_r;
	end
	if (pair_cb_robust_peak_height_112_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[23:16] <= pair_cb_robust_peak_height_112_r;
	end
	if (pair_cb_robust_peak_height_111_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[15:8] <= pair_cb_robust_peak_height_111_r;
	end
	if (pair_cb_robust_peak_height_110_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full[7:0] <= pair_cb_robust_peak_height_110_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage11_re <= pair_cb_robust_peak_height_110_re;
	if (pair_cb_robust_peak_height_123_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[27:24] <= pair_cb_robust_peak_height_123_r;
	end
	if (pair_cb_robust_peak_height_122_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[23:16] <= pair_cb_robust_peak_height_122_r;
	end
	if (pair_cb_robust_peak_height_121_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[15:8] <= pair_cb_robust_peak_height_121_r;
	end
	if (pair_cb_robust_peak_height_120_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full[7:0] <= pair_cb_robust_peak_height_120_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage12_re <= pair_cb_robust_peak_height_120_re;
	if (pair_cb_robust_peak_height_133_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[27:24] <= pair_cb_robust_peak_height_133_r;
	end
	if (pair_cb_robust_peak_height_132_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[23:16] <= pair_cb_robust_peak_height_132_r;
	end
	if (pair_cb_robust_peak_height_131_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[15:8] <= pair_cb_robust_peak_height_131_r;
	end
	if (pair_cb_robust_peak_height_130_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full[7:0] <= pair_cb_robust_peak_height_130_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage13_re <= pair_cb_robust_peak_height_130_re;
	if (pair_cb_robust_peak_height_143_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[27:24] <= pair_cb_robust_peak_height_143_r;
	end
	if (pair_cb_robust_peak_height_142_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[23:16] <= pair_cb_robust_peak_height_142_r;
	end
	if (pair_cb_robust_peak_height_141_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[15:8] <= pair_cb_robust_peak_height_141_r;
	end
	if (pair_cb_robust_peak_height_140_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full[7:0] <= pair_cb_robust_peak_height_140_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage14_re <= pair_cb_robust_peak_height_140_re;
	if (pair_cb_robust_peak_height_153_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[27:24] <= pair_cb_robust_peak_height_153_r;
	end
	if (pair_cb_robust_peak_height_152_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[23:16] <= pair_cb_robust_peak_height_152_r;
	end
	if (pair_cb_robust_peak_height_151_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[15:8] <= pair_cb_robust_peak_height_151_r;
	end
	if (pair_cb_robust_peak_height_150_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full[7:0] <= pair_cb_robust_peak_height_150_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage15_re <= pair_cb_robust_peak_height_150_re;
	if (pair_cb_robust_peak_height_163_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[27:24] <= pair_cb_robust_peak_height_163_r;
	end
	if (pair_cb_robust_peak_height_162_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[23:16] <= pair_cb_robust_peak_height_162_r;
	end
	if (pair_cb_robust_peak_height_161_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[15:8] <= pair_cb_robust_peak_height_161_r;
	end
	if (pair_cb_robust_peak_height_160_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full[7:0] <= pair_cb_robust_peak_height_160_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage16_re <= pair_cb_robust_peak_height_160_re;
	if (pair_cb_robust_peak_height_173_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[27:24] <= pair_cb_robust_peak_height_173_r;
	end
	if (pair_cb_robust_peak_height_172_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[23:16] <= pair_cb_robust_peak_height_172_r;
	end
	if (pair_cb_robust_peak_height_171_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[15:8] <= pair_cb_robust_peak_height_171_r;
	end
	if (pair_cb_robust_peak_height_170_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full[7:0] <= pair_cb_robust_peak_height_170_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage17_re <= pair_cb_robust_peak_height_170_re;
	if (pair_cb_robust_peak_height_183_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[27:24] <= pair_cb_robust_peak_height_183_r;
	end
	if (pair_cb_robust_peak_height_182_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[23:16] <= pair_cb_robust_peak_height_182_r;
	end
	if (pair_cb_robust_peak_height_181_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[15:8] <= pair_cb_robust_peak_height_181_r;
	end
	if (pair_cb_robust_peak_height_180_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full[7:0] <= pair_cb_robust_peak_height_180_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage18_re <= pair_cb_robust_peak_height_180_re;
	if (pair_cb_robust_peak_height_193_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[27:24] <= pair_cb_robust_peak_height_193_r;
	end
	if (pair_cb_robust_peak_height_192_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[23:16] <= pair_cb_robust_peak_height_192_r;
	end
	if (pair_cb_robust_peak_height_191_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[15:8] <= pair_cb_robust_peak_height_191_r;
	end
	if (pair_cb_robust_peak_height_190_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full[7:0] <= pair_cb_robust_peak_height_190_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage19_re <= pair_cb_robust_peak_height_190_re;
	if (pair_cb_robust_peak_height_203_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[27:24] <= pair_cb_robust_peak_height_203_r;
	end
	if (pair_cb_robust_peak_height_202_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[23:16] <= pair_cb_robust_peak_height_202_r;
	end
	if (pair_cb_robust_peak_height_201_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[15:8] <= pair_cb_robust_peak_height_201_r;
	end
	if (pair_cb_robust_peak_height_200_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full[7:0] <= pair_cb_robust_peak_height_200_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage20_re <= pair_cb_robust_peak_height_200_re;
	if (pair_cb_robust_peak_height_213_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[27:24] <= pair_cb_robust_peak_height_213_r;
	end
	if (pair_cb_robust_peak_height_212_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[23:16] <= pair_cb_robust_peak_height_212_r;
	end
	if (pair_cb_robust_peak_height_211_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[15:8] <= pair_cb_robust_peak_height_211_r;
	end
	if (pair_cb_robust_peak_height_210_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full[7:0] <= pair_cb_robust_peak_height_210_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage21_re <= pair_cb_robust_peak_height_210_re;
	if (pair_cb_robust_peak_height_223_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[27:24] <= pair_cb_robust_peak_height_223_r;
	end
	if (pair_cb_robust_peak_height_222_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[23:16] <= pair_cb_robust_peak_height_222_r;
	end
	if (pair_cb_robust_peak_height_221_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[15:8] <= pair_cb_robust_peak_height_221_r;
	end
	if (pair_cb_robust_peak_height_220_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full[7:0] <= pair_cb_robust_peak_height_220_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage22_re <= pair_cb_robust_peak_height_220_re;
	if (pair_cb_robust_peak_height_233_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[27:24] <= pair_cb_robust_peak_height_233_r;
	end
	if (pair_cb_robust_peak_height_232_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[23:16] <= pair_cb_robust_peak_height_232_r;
	end
	if (pair_cb_robust_peak_height_231_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[15:8] <= pair_cb_robust_peak_height_231_r;
	end
	if (pair_cb_robust_peak_height_230_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full[7:0] <= pair_cb_robust_peak_height_230_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage23_re <= pair_cb_robust_peak_height_230_re;
	if (pair_cb_robust_peak_height_243_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[27:24] <= pair_cb_robust_peak_height_243_r;
	end
	if (pair_cb_robust_peak_height_242_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[23:16] <= pair_cb_robust_peak_height_242_r;
	end
	if (pair_cb_robust_peak_height_241_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[15:8] <= pair_cb_robust_peak_height_241_r;
	end
	if (pair_cb_robust_peak_height_240_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full[7:0] <= pair_cb_robust_peak_height_240_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage24_re <= pair_cb_robust_peak_height_240_re;
	if (pair_cb_robust_peak_height_253_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[27:24] <= pair_cb_robust_peak_height_253_r;
	end
	if (pair_cb_robust_peak_height_252_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[23:16] <= pair_cb_robust_peak_height_252_r;
	end
	if (pair_cb_robust_peak_height_251_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[15:8] <= pair_cb_robust_peak_height_251_r;
	end
	if (pair_cb_robust_peak_height_250_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full[7:0] <= pair_cb_robust_peak_height_250_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage25_re <= pair_cb_robust_peak_height_250_re;
	if (pair_cb_robust_peak_height_263_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[27:24] <= pair_cb_robust_peak_height_263_r;
	end
	if (pair_cb_robust_peak_height_262_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[23:16] <= pair_cb_robust_peak_height_262_r;
	end
	if (pair_cb_robust_peak_height_261_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[15:8] <= pair_cb_robust_peak_height_261_r;
	end
	if (pair_cb_robust_peak_height_260_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full[7:0] <= pair_cb_robust_peak_height_260_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage26_re <= pair_cb_robust_peak_height_260_re;
	if (pair_cb_robust_peak_height_273_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[27:24] <= pair_cb_robust_peak_height_273_r;
	end
	if (pair_cb_robust_peak_height_272_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[23:16] <= pair_cb_robust_peak_height_272_r;
	end
	if (pair_cb_robust_peak_height_271_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[15:8] <= pair_cb_robust_peak_height_271_r;
	end
	if (pair_cb_robust_peak_height_270_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full[7:0] <= pair_cb_robust_peak_height_270_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage27_re <= pair_cb_robust_peak_height_270_re;
	if (pair_cb_robust_peak_height_283_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[27:24] <= pair_cb_robust_peak_height_283_r;
	end
	if (pair_cb_robust_peak_height_282_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[23:16] <= pair_cb_robust_peak_height_282_r;
	end
	if (pair_cb_robust_peak_height_281_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[15:8] <= pair_cb_robust_peak_height_281_r;
	end
	if (pair_cb_robust_peak_height_280_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full[7:0] <= pair_cb_robust_peak_height_280_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage28_re <= pair_cb_robust_peak_height_280_re;
	if (pair_cb_robust_peak_height_293_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[27:24] <= pair_cb_robust_peak_height_293_r;
	end
	if (pair_cb_robust_peak_height_292_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[23:16] <= pair_cb_robust_peak_height_292_r;
	end
	if (pair_cb_robust_peak_height_291_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[15:8] <= pair_cb_robust_peak_height_291_r;
	end
	if (pair_cb_robust_peak_height_290_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full[7:0] <= pair_cb_robust_peak_height_290_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage29_re <= pair_cb_robust_peak_height_290_re;
	if (pair_cb_robust_peak_height_303_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[27:24] <= pair_cb_robust_peak_height_303_r;
	end
	if (pair_cb_robust_peak_height_302_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[23:16] <= pair_cb_robust_peak_height_302_r;
	end
	if (pair_cb_robust_peak_height_301_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[15:8] <= pair_cb_robust_peak_height_301_r;
	end
	if (pair_cb_robust_peak_height_300_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full[7:0] <= pair_cb_robust_peak_height_300_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage30_re <= pair_cb_robust_peak_height_300_re;
	if (pair_cb_robust_peak_height_313_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[27:24] <= pair_cb_robust_peak_height_313_r;
	end
	if (pair_cb_robust_peak_height_312_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[23:16] <= pair_cb_robust_peak_height_312_r;
	end
	if (pair_cb_robust_peak_height_311_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[15:8] <= pair_cb_robust_peak_height_311_r;
	end
	if (pair_cb_robust_peak_height_310_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full[7:0] <= pair_cb_robust_peak_height_310_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage31_re <= pair_cb_robust_peak_height_310_re;
	if (pair_cb_robust_wait_for_01_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full[13:8] <= pair_cb_robust_wait_for_01_r;
	end
	if (pair_cb_robust_wait_for_00_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full[7:0] <= pair_cb_robust_wait_for_00_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage32_re <= pair_cb_robust_wait_for_00_re;
	if (pair_cb_robust_wait_for_11_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full[13:8] <= pair_cb_robust_wait_for_11_r;
	end
	if (pair_cb_robust_wait_for_10_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full[7:0] <= pair_cb_robust_wait_for_10_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage33_re <= pair_cb_robust_wait_for_10_re;
	if (pair_cb_robust_wait_for_21_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full[13:8] <= pair_cb_robust_wait_for_21_r;
	end
	if (pair_cb_robust_wait_for_20_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full[7:0] <= pair_cb_robust_wait_for_20_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage34_re <= pair_cb_robust_wait_for_20_re;
	if (pair_cb_robust_wait_for_31_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full[13:8] <= pair_cb_robust_wait_for_31_r;
	end
	if (pair_cb_robust_wait_for_30_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full[7:0] <= pair_cb_robust_wait_for_30_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage35_re <= pair_cb_robust_wait_for_30_re;
	if (pair_cb_robust_wait_for_41_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full[13:8] <= pair_cb_robust_wait_for_41_r;
	end
	if (pair_cb_robust_wait_for_40_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full[7:0] <= pair_cb_robust_wait_for_40_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage36_re <= pair_cb_robust_wait_for_40_re;
	if (pair_cb_robust_wait_for_51_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full[13:8] <= pair_cb_robust_wait_for_51_r;
	end
	if (pair_cb_robust_wait_for_50_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full[7:0] <= pair_cb_robust_wait_for_50_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage37_re <= pair_cb_robust_wait_for_50_re;
	if (pair_cb_robust_wait_for_61_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full[13:8] <= pair_cb_robust_wait_for_61_r;
	end
	if (pair_cb_robust_wait_for_60_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full[7:0] <= pair_cb_robust_wait_for_60_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage38_re <= pair_cb_robust_wait_for_60_re;
	if (pair_cb_robust_wait_for_71_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full[13:8] <= pair_cb_robust_wait_for_71_r;
	end
	if (pair_cb_robust_wait_for_70_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full[7:0] <= pair_cb_robust_wait_for_70_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage39_re <= pair_cb_robust_wait_for_70_re;
	if (pair_cb_robust_wait_for_81_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full[13:8] <= pair_cb_robust_wait_for_81_r;
	end
	if (pair_cb_robust_wait_for_80_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full[7:0] <= pair_cb_robust_wait_for_80_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage40_re <= pair_cb_robust_wait_for_80_re;
	if (pair_cb_robust_wait_for_91_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full[13:8] <= pair_cb_robust_wait_for_91_r;
	end
	if (pair_cb_robust_wait_for_90_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full[7:0] <= pair_cb_robust_wait_for_90_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage41_re <= pair_cb_robust_wait_for_90_re;
	if (pair_cb_robust_wait_for_101_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full[13:8] <= pair_cb_robust_wait_for_101_r;
	end
	if (pair_cb_robust_wait_for_100_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full[7:0] <= pair_cb_robust_wait_for_100_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage42_re <= pair_cb_robust_wait_for_100_re;
	if (pair_cb_robust_wait_for_111_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full[13:8] <= pair_cb_robust_wait_for_111_r;
	end
	if (pair_cb_robust_wait_for_110_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full[7:0] <= pair_cb_robust_wait_for_110_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage43_re <= pair_cb_robust_wait_for_110_re;
	if (pair_cb_robust_wait_for_121_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full[13:8] <= pair_cb_robust_wait_for_121_r;
	end
	if (pair_cb_robust_wait_for_120_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full[7:0] <= pair_cb_robust_wait_for_120_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage44_re <= pair_cb_robust_wait_for_120_re;
	if (pair_cb_robust_wait_for_131_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full[13:8] <= pair_cb_robust_wait_for_131_r;
	end
	if (pair_cb_robust_wait_for_130_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full[7:0] <= pair_cb_robust_wait_for_130_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage45_re <= pair_cb_robust_wait_for_130_re;
	if (pair_cb_robust_wait_for_141_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full[13:8] <= pair_cb_robust_wait_for_141_r;
	end
	if (pair_cb_robust_wait_for_140_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full[7:0] <= pair_cb_robust_wait_for_140_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage46_re <= pair_cb_robust_wait_for_140_re;
	if (pair_cb_robust_wait_for_151_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full[13:8] <= pair_cb_robust_wait_for_151_r;
	end
	if (pair_cb_robust_wait_for_150_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full[7:0] <= pair_cb_robust_wait_for_150_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage47_re <= pair_cb_robust_wait_for_150_re;
	if (pair_cb_robust_wait_for_161_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full[13:8] <= pair_cb_robust_wait_for_161_r;
	end
	if (pair_cb_robust_wait_for_160_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full[7:0] <= pair_cb_robust_wait_for_160_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage48_re <= pair_cb_robust_wait_for_160_re;
	if (pair_cb_robust_wait_for_171_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full[13:8] <= pair_cb_robust_wait_for_171_r;
	end
	if (pair_cb_robust_wait_for_170_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full[7:0] <= pair_cb_robust_wait_for_170_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage49_re <= pair_cb_robust_wait_for_170_re;
	if (pair_cb_robust_wait_for_181_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full[13:8] <= pair_cb_robust_wait_for_181_r;
	end
	if (pair_cb_robust_wait_for_180_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full[7:0] <= pair_cb_robust_wait_for_180_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage50_re <= pair_cb_robust_wait_for_180_re;
	if (pair_cb_robust_wait_for_191_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full[13:8] <= pair_cb_robust_wait_for_191_r;
	end
	if (pair_cb_robust_wait_for_190_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full[7:0] <= pair_cb_robust_wait_for_190_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage51_re <= pair_cb_robust_wait_for_190_re;
	if (pair_cb_robust_wait_for_201_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full[13:8] <= pair_cb_robust_wait_for_201_r;
	end
	if (pair_cb_robust_wait_for_200_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full[7:0] <= pair_cb_robust_wait_for_200_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage52_re <= pair_cb_robust_wait_for_200_re;
	if (pair_cb_robust_wait_for_211_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full[13:8] <= pair_cb_robust_wait_for_211_r;
	end
	if (pair_cb_robust_wait_for_210_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full[7:0] <= pair_cb_robust_wait_for_210_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage53_re <= pair_cb_robust_wait_for_210_re;
	if (pair_cb_robust_wait_for_221_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full[13:8] <= pair_cb_robust_wait_for_221_r;
	end
	if (pair_cb_robust_wait_for_220_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full[7:0] <= pair_cb_robust_wait_for_220_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage54_re <= pair_cb_robust_wait_for_220_re;
	if (pair_cb_robust_wait_for_231_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full[13:8] <= pair_cb_robust_wait_for_231_r;
	end
	if (pair_cb_robust_wait_for_230_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full[7:0] <= pair_cb_robust_wait_for_230_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage55_re <= pair_cb_robust_wait_for_230_re;
	if (pair_cb_robust_wait_for_241_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full[13:8] <= pair_cb_robust_wait_for_241_r;
	end
	if (pair_cb_robust_wait_for_240_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full[7:0] <= pair_cb_robust_wait_for_240_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage56_re <= pair_cb_robust_wait_for_240_re;
	if (pair_cb_robust_wait_for_251_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full[13:8] <= pair_cb_robust_wait_for_251_r;
	end
	if (pair_cb_robust_wait_for_250_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full[7:0] <= pair_cb_robust_wait_for_250_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage57_re <= pair_cb_robust_wait_for_250_re;
	if (pair_cb_robust_wait_for_261_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full[13:8] <= pair_cb_robust_wait_for_261_r;
	end
	if (pair_cb_robust_wait_for_260_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full[7:0] <= pair_cb_robust_wait_for_260_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage58_re <= pair_cb_robust_wait_for_260_re;
	if (pair_cb_robust_wait_for_271_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full[13:8] <= pair_cb_robust_wait_for_271_r;
	end
	if (pair_cb_robust_wait_for_270_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full[7:0] <= pair_cb_robust_wait_for_270_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage59_re <= pair_cb_robust_wait_for_270_re;
	if (pair_cb_robust_wait_for_281_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full[13:8] <= pair_cb_robust_wait_for_281_r;
	end
	if (pair_cb_robust_wait_for_280_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full[7:0] <= pair_cb_robust_wait_for_280_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage60_re <= pair_cb_robust_wait_for_280_re;
	if (pair_cb_robust_wait_for_291_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full[13:8] <= pair_cb_robust_wait_for_291_r;
	end
	if (pair_cb_robust_wait_for_290_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full[7:0] <= pair_cb_robust_wait_for_290_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage61_re <= pair_cb_robust_wait_for_290_re;
	if (pair_cb_robust_wait_for_301_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full[13:8] <= pair_cb_robust_wait_for_301_r;
	end
	if (pair_cb_robust_wait_for_300_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full[7:0] <= pair_cb_robust_wait_for_300_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage62_re <= pair_cb_robust_wait_for_300_re;
	if (pair_cb_robust_wait_for_311_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full[13:8] <= pair_cb_robust_wait_for_311_r;
	end
	if (pair_cb_robust_wait_for_310_re) begin
		pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full[7:0] <= pair_cb_robust_wait_for_310_r;
	end
	pair_candidate_pipelinedrobustautolock_csrstorage63_re <= pair_cb_robust_wait_for_310_re;
	if (pair_cb_fast_target_position1_re) begin
		pair_candidate_fast_storage_full[13:8] <= pair_cb_fast_target_position1_r;
	end
	if (pair_cb_fast_target_position0_re) begin
		pair_candidate_fast_storage_full[7:0] <= pair_cb_fast_target_position0_r;
	end
	pair_candidate_fast_re <= pair_cb_fast_target_position0_re;
	if (pair_cb_request_lock0_re) begin
		pair_candidate_request_lock_storage_full <= pair_cb_request_lock0_r;
	end
	pair_candidate_request_lock_re <= pair_cb_request_lock0_re;
	if (pair_cb_autolock_mode0_re) begin
		pair_candidate_autolock_mode_storage_full[1:0] <= pair_cb_autolock_mode0_r;
	end
	pair_candidate_autolock_mode_re <= pair_cb_autolock_mode0_re;
	if (sys_rst) begin
		pair_reference_robust_sum_value <= 28'sd0;
		pair_reference_robust_counter <= 13'd0;
		pair_reference_robust_watching <= 1'd0;
		pair_reference_robust_current_instruction_idx <= 5'd0;
		pair_reference_robust_waited_for <= 14'd0;
		pair_reference_robust_final_waited_for <= 14'd0;
		pair_reference_robust_q0 <= 14'sd0;
		pair_reference_robust_q1 <= 1'd0;
		pair_reference_robust_q2 <= 1'd0;
		pair_reference_robust_q3 <= 1'd0;
		pair_reference_robust_q4 <= 1'd0;
		pair_reference_robust_csrstorage0_storage_full <= 14'd0;
		pair_reference_robust_csrstorage0_re <= 1'd0;
		pair_reference_robust_q5 <= 14'd0;
		pair_reference_robust_csrstorage1_storage_full <= 5'd0;
		pair_reference_robust_csrstorage1_re <= 1'd0;
		pair_reference_robust_q6 <= 5'd0;
		pair_reference_robust_csrstorage2_storage_full <= 14'd0;
		pair_reference_robust_csrstorage2_re <= 1'd0;
		pair_reference_robust_q7 <= 14'd0;
		pair_reference_robust_csrstorage3_storage_full <= 28'd0;
		pair_reference_robust_csrstorage3_re <= 1'd0;
		pair_reference_robust_q8 <= 28'd0;
		pair_reference_robust_csrstorage4_storage_full <= 28'd0;
		pair_reference_robust_csrstorage4_re <= 1'd0;
		pair_reference_robust_q9 <= 28'd0;
		pair_reference_robust_csrstorage5_storage_full <= 28'd0;
		pair_reference_robust_csrstorage5_re <= 1'd0;
		pair_reference_robust_q10 <= 28'd0;
		pair_reference_robust_csrstorage6_storage_full <= 28'd0;
		pair_reference_robust_csrstorage6_re <= 1'd0;
		pair_reference_robust_q11 <= 28'd0;
		pair_reference_robust_csrstorage7_storage_full <= 28'd0;
		pair_reference_robust_csrstorage7_re <= 1'd0;
		pair_reference_robust_q12 <= 28'd0;
		pair_reference_robust_csrstorage8_storage_full <= 28'd0;
		pair_reference_robust_csrstorage8_re <= 1'd0;
		pair_reference_robust_q13 <= 28'd0;
		pair_reference_robust_csrstorage9_storage_full <= 28'd0;
		pair_reference_robust_csrstorage9_re <= 1'd0;
		pair_reference_robust_q14 <= 28'd0;
		pair_reference_robust_csrstorage10_storage_full <= 28'd0;
		pair_reference_robust_csrstorage10_re <= 1'd0;
		pair_reference_robust_q15 <= 28'd0;
		pair_reference_robust_csrstorage11_storage_full <= 28'd0;
		pair_reference_robust_csrstorage11_re <= 1'd0;
		pair_reference_robust_q16 <= 28'd0;
		pair_reference_robust_csrstorage12_storage_full <= 28'd0;
		pair_reference_robust_csrstorage12_re <= 1'd0;
		pair_reference_robust_q17 <= 28'd0;
		pair_reference_robust_csrstorage13_storage_full <= 28'd0;
		pair_reference_robust_csrstorage13_re <= 1'd0;
		pair_reference_robust_q18 <= 28'd0;
		pair_reference_robust_csrstorage14_storage_full <= 28'd0;
		pair_reference_robust_csrstorage14_re <= 1'd0;
		pair_reference_robust_q19 <= 28'd0;
		pair_reference_robust_csrstorage15_storage_full <= 28'd0;
		pair_reference_robust_csrstorage15_re <= 1'd0;
		pair_reference_robust_q20 <= 28'd0;
		pair_reference_robust_csrstorage16_storage_full <= 28'd0;
		pair_reference_robust_csrstorage16_re <= 1'd0;
		pair_reference_robust_q21 <= 28'd0;
		pair_reference_robust_csrstorage17_storage_full <= 28'd0;
		pair_reference_robust_csrstorage17_re <= 1'd0;
		pair_reference_robust_q22 <= 28'd0;
		pair_reference_robust_csrstorage18_storage_full <= 28'd0;
		pair_reference_robust_csrstorage18_re <= 1'd0;
		pair_reference_robust_q23 <= 28'd0;
		pair_reference_robust_csrstorage19_storage_full <= 28'd0;
		pair_reference_robust_csrstorage19_re <= 1'd0;
		pair_reference_robust_q24 <= 28'd0;
		pair_reference_robust_csrstorage20_storage_full <= 28'd0;
		pair_reference_robust_csrstorage20_re <= 1'd0;
		pair_reference_robust_q25 <= 28'd0;
		pair_reference_robust_csrstorage21_storage_full <= 28'd0;
		pair_reference_robust_csrstorage21_re <= 1'd0;
		pair_reference_robust_q26 <= 28'd0;
		pair_reference_robust_csrstorage22_storage_full <= 28'd0;
		pair_reference_robust_csrstorage22_re <= 1'd0;
		pair_reference_robust_q27 <= 28'd0;
		pair_reference_robust_csrstorage23_storage_full <= 28'd0;
		pair_reference_robust_csrstorage23_re <= 1'd0;
		pair_reference_robust_q28 <= 28'd0;
		pair_reference_robust_csrstorage24_storage_full <= 28'd0;
		pair_reference_robust_csrstorage24_re <= 1'd0;
		pair_reference_robust_q29 <= 28'd0;
		pair_reference_robust_csrstorage25_storage_full <= 28'd0;
		pair_reference_robust_csrstorage25_re <= 1'd0;
		pair_reference_robust_q30 <= 28'd0;
		pair_reference_robust_csrstorage26_storage_full <= 28'd0;
		pair_reference_robust_csrstorage26_re <= 1'd0;
		pair_reference_robust_q31 <= 28'd0;
		pair_reference_robust_csrstorage27_storage_full <= 28'd0;
		pair_reference_robust_csrstorage27_re <= 1'd0;
		pair_reference_robust_q32 <= 28'd0;
		pair_reference_robust_csrstorage28_storage_full <= 28'd0;
		pair_reference_robust_csrstorage28_re <= 1'd0;
		pair_reference_robust_q33 <= 28'd0;
		pair_reference_robust_csrstorage29_storage_full <= 28'd0;
		pair_reference_robust_csrstorage29_re <= 1'd0;
		pair_reference_robust_q34 <= 28'd0;
		pair_reference_robust_csrstorage30_storage_full <= 28'd0;
		pair_reference_robust_csrstorage30_re <= 1'd0;
		pair_reference_robust_q35 <= 28'd0;
		pair_reference_robust_csrstorage31_storage_full <= 28'd0;
		pair_reference_robust_csrstorage31_re <= 1'd0;
		pair_reference_robust_q36 <= 28'd0;
		pair_reference_robust_csrstorage32_storage_full <= 28'd0;
		pair_reference_robust_csrstorage32_re <= 1'd0;
		pair_reference_robust_q37 <= 28'd0;
		pair_reference_robust_csrstorage33_storage_full <= 28'd0;
		pair_reference_robust_csrstorage33_re <= 1'd0;
		pair_reference_robust_q38 <= 28'd0;
		pair_reference_robust_csrstorage34_storage_full <= 28'd0;
		pair_reference_robust_csrstorage34_re <= 1'd0;
		pair_reference_robust_q39 <= 28'd0;
		pair_reference_robust_csrstorage35_storage_full <= 14'd0;
		pair_reference_robust_csrstorage35_re <= 1'd0;
		pair_reference_robust_q40 <= 14'd0;
		pair_reference_robust_csrstorage36_storage_full <= 14'd0;
		pair_reference_robust_csrstorage36_re <= 1'd0;
		pair_reference_robust_q41 <= 14'd0;
		pair_reference_robust_csrstorage37_storage_full <= 14'd0;
		pair_reference_robust_csrstorage37_re <= 1'd0;
		pair_reference_robust_q42 <= 14'd0;
		pair_reference_robust_csrstorage38_storage_full <= 14'd0;
		pair_reference_robust_csrstorage38_re <= 1'd0;
		pair_reference_robust_q43 <= 14'd0;
		pair_reference_robust_csrstorage39_storage_full <= 14'd0;
		pair_reference_robust_csrstorage39_re <= 1'd0;
		pair_reference_robust_q44 <= 14'd0;
		pair_reference_robust_csrstorage40_storage_full <= 14'd0;
		pair_reference_robust_csrstorage40_re <= 1'd0;
		pair_reference_robust_q45 <= 14'd0;
		pair_reference_robust_csrstorage41_storage_full <= 14'd0;
		pair_reference_robust_csrstorage41_re <= 1'd0;
		pair_reference_robust_q46 <= 14'd0;
		pair_reference_robust_csrstorage42_storage_full <= 14'd0;
		pair_reference_robust_csrstorage42_re <= 1'd0;
		pair_reference_robust_q47 <= 14'd0;
		pair_reference_robust_csrstorage43_storage_full <= 14'd0;
		pair_reference_robust_csrstorage43_re <= 1'd0;
		pair_reference_robust_q48 <= 14'd0;
		pair_reference_robust_csrstorage44_storage_full <= 14'd0;
		pair_reference_robust_csrstorage44_re <= 1'd0;
		pair_reference_robust_q49 <= 14'd0;
		pair_reference_robust_csrstorage45_storage_full <= 14'd0;
		pair_reference_robust_csrstorage45_re <= 1'd0;
		pair_reference_robust_q50 <= 14'd0;
		pair_reference_robust_csrstorage46_storage_full <= 14'd0;
		pair_reference_robust_csrstorage46_re <= 1'd0;
		pair_reference_robust_q51 <= 14'd0;
		pair_reference_robust_csrstorage47_storage_full <= 14'd0;
		pair_reference_robust_csrstorage47_re <= 1'd0;
		pair_reference_robust_q52 <= 14'd0;
		pair_reference_robust_csrstorage48_storage_full <= 14'd0;
		pair_reference_robust_csrstorage48_re <= 1'd0;
		pair_reference_robust_q53 <= 14'd0;
		pair_reference_robust_csrstorage49_storage_full <= 14'd0;
		pair_reference_robust_csrstorage49_re <= 1'd0;
		pair_reference_robust_q54 <= 14'd0;
		pair_reference_robust_csrstorage50_storage_full <= 14'd0;
		pair_reference_robust_csrstorage50_re <= 1'd0;
		pair_reference_robust_q55 <= 14'd0;
		pair_reference_robust_csrstorage51_storage_full <= 14'd0;
		pair_reference_robust_csrstorage51_re <= 1'd0;
		pair_reference_robust_q56 <= 14'd0;
		pair_reference_robust_csrstorage52_storage_full <= 14'd0;
		pair_reference_robust_csrstorage52_re <= 1'd0;
		pair_reference_robust_q57 <= 14'd0;
		pair_reference_robust_csrstorage53_storage_full <= 14'd0;
		pair_reference_robust_csrstorage53_re <= 1'd0;
		pair_reference_robust_q58 <= 14'd0;
		pair_reference_robust_csrstorage54_storage_full <= 14'd0;
		pair_reference_robust_csrstorage54_re <= 1'd0;
		pair_reference_robust_q59 <= 14'd0;
		pair_reference_robust_csrstorage55_storage_full <= 14'd0;
		pair_reference_robust_csrstorage55_re <= 1'd0;
		pair_reference_robust_q60 <= 14'd0;
		pair_reference_robust_csrstorage56_storage_full <= 14'd0;
		pair_reference_robust_csrstorage56_re <= 1'd0;
		pair_reference_robust_q61 <= 14'd0;
		pair_reference_robust_csrstorage57_storage_full <= 14'd0;
		pair_reference_robust_csrstorage57_re <= 1'd0;
		pair_reference_robust_q62 <= 14'd0;
		pair_reference_robust_csrstorage58_storage_full <= 14'd0;
		pair_reference_robust_csrstorage58_re <= 1'd0;
		pair_reference_robust_q63 <= 14'd0;
		pair_reference_robust_csrstorage59_storage_full <= 14'd0;
		pair_reference_robust_csrstorage59_re <= 1'd0;
		pair_reference_robust_q64 <= 14'd0;
		pair_reference_robust_csrstorage60_storage_full <= 14'd0;
		pair_reference_robust_csrstorage60_re <= 1'd0;
		pair_reference_robust_q65 <= 14'd0;
		pair_reference_robust_csrstorage61_storage_full <= 14'd0;
		pair_reference_robust_csrstorage61_re <= 1'd0;
		pair_reference_robust_q66 <= 14'd0;
		pair_reference_robust_csrstorage62_storage_full <= 14'd0;
		pair_reference_robust_csrstorage62_re <= 1'd0;
		pair_reference_robust_q67 <= 14'd0;
		pair_reference_robust_csrstorage63_storage_full <= 14'd0;
		pair_reference_robust_csrstorage63_re <= 1'd0;
		pair_reference_robust_q68 <= 14'd0;
		pair_reference_robust_csrstorage64_storage_full <= 14'd0;
		pair_reference_robust_csrstorage64_re <= 1'd0;
		pair_reference_robust_q69 <= 14'd0;
		pair_reference_robust_csrstorage65_storage_full <= 14'd0;
		pair_reference_robust_csrstorage65_re <= 1'd0;
		pair_reference_robust_q70 <= 14'd0;
		pair_reference_robust_csrstorage66_storage_full <= 14'd0;
		pair_reference_robust_csrstorage66_re <= 1'd0;
		pair_reference_robust_q71 <= 14'd0;
		pair_reference_fast_turn_on_lock <= 1'd0;
		pair_reference_fast_storage_full <= 14'd0;
		pair_reference_fast_re <= 1'd0;
		pair_reference_request_lock_storage_full <= 1'd0;
		pair_reference_request_lock_re <= 1'd0;
		pair_reference_autolock_mode_storage_full <= 2'd0;
		pair_reference_autolock_mode_re <= 1'd0;
		pair_reference_status <= 1'd0;
		pair_candidate_pipelinedrobustautolock_sum_value <= 28'sd0;
		pair_candidate_pipelinedrobustautolock_counter <= 13'd0;
		pair_candidate_pipelinedrobustautolock_time_scale_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_time_scale_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_N_instructions_storage_full <= 5'd0;
		pair_candidate_pipelinedrobustautolock_N_instructions_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_final_wait_time_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_final_wait_time_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage0_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage0_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage1_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage1_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage2_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage2_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage3_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage3_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage4_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage4_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage5_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage5_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage6_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage6_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage7_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage7_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage8_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage8_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage9_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage9_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage10_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage10_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage11_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage11_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage12_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage12_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage13_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage13_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage14_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage14_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage15_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage15_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage16_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage16_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage17_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage17_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage18_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage18_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage19_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage19_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage20_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage20_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage21_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage21_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage22_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage22_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage23_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage23_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage24_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage24_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage25_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage25_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage26_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage26_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage27_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage27_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage28_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage28_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage29_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage29_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage30_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage30_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage31_storage_full <= 28'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage31_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage32_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage32_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage33_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage33_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage34_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage34_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage35_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage35_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage36_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage36_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage37_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage37_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage38_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage38_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage39_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage39_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage40_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage40_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage41_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage41_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage42_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage42_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage43_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage43_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage44_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage44_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage45_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage45_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage46_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage46_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage47_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage47_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage48_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage48_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage49_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage49_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage50_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage50_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage51_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage51_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage52_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage52_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage53_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage53_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage54_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage54_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage55_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage55_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage56_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage56_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage57_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage57_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage58_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage58_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage59_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage59_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage60_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage60_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage61_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage61_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage62_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage62_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage63_storage_full <= 14'd0;
		pair_candidate_pipelinedrobustautolock_csrstorage63_re <= 1'd0;
		pair_candidate_pipelinedrobustautolock0 <= 1'd0;
		pair_candidate_pipelinedrobustautolock1 <= 1'd0;
		pair_candidate_pipelinedrobustautolock2 <= 1'd0;
		pair_candidate_pipelinedrobustautolock3 <= 1'd0;
		pair_candidate_pipelinedrobustautolock_sum_diff_s1 <= 29'sd0;
		pair_candidate_pipelinedrobustautolock_n_instructions_s1 <= 5'd0;
		pair_candidate_pipelinedrobustautolock_final_wait_s1 <= 14'd0;
		pair_candidate_pipelinedrobustautolock_current_instruction_idx <= 5'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_choice <= 2'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_current_magnitude <= 28'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_current_negative <= 29'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_current_positive <= 1'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_current_wait <= 14'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_next_magnitude <= 28'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_next_negative <= 29'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_next_positive <= 1'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_next_wait <= 14'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_zero_magnitude <= 28'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_zero_negative <= 29'sd0;
		pair_candidate_pipelinedrobustautolock_prefetch_zero_positive <= 1'd0;
		pair_candidate_pipelinedrobustautolock_prefetch_zero_wait <= 14'd0;
		pair_candidate_pipelinedrobustautolock_watching <= 1'd0;
		pair_candidate_pipelinedrobustautolock_waited_for <= 14'd0;
		pair_candidate_pipelinedrobustautolock_final_waited_for <= 14'd0;
		pair_candidate_fast_turn_on_lock <= 1'd0;
		pair_candidate_fast_storage_full <= 14'd0;
		pair_candidate_fast_re <= 1'd0;
		pair_candidate_request_lock_storage_full <= 1'd0;
		pair_candidate_request_lock_re <= 1'd0;
		pair_candidate_autolock_mode_storage_full <= 2'd0;
		pair_candidate_autolock_mode_re <= 1'd0;
		pair_candidate_status <= 1'd0;
		pair_rb_bus_dat_r <= 8'd0;
		pair_cb_bus_dat_r <= 8'd0;
		pair_pair0 <= 28'sd0;
		pair_pair1 <= 13'd0;
		pair_pair_q <= 13'd1;
		pair_pair2 <= 29'sd0;
	end
end

reg [27:0] dynamic_delay_mem[0:8190];
reg [12:0] memadr;
reg [12:0] memadr_1;
always @(posedge sys_clk) begin
	memadr <= pair_reference_robust_rdport_adr;
end

always @(posedge sys_clk) begin
	if (pair_reference_robust_wrport_we)
		dynamic_delay_mem[pair_reference_robust_wrport_adr] <= pair_reference_robust_wrport_dat_w;
	memadr_1 <= pair_reference_robust_wrport_adr;
end

assign pair_reference_robust_rdport_dat_r = dynamic_delay_mem[memadr];
assign pair_reference_robust_wrport_dat_r = dynamic_delay_mem[memadr_1];

reg [27:0] dynamic_delay_mem_1[0:8190];
reg [12:0] memadr_2;
reg [12:0] memadr_3;
always @(posedge sys_clk) begin
	memadr_2 <= pair_candidate_pipelinedrobustautolock_rdport_adr;
end

always @(posedge sys_clk) begin
	if (pair_candidate_pipelinedrobustautolock_wrport_we)
		dynamic_delay_mem_1[pair_candidate_pipelinedrobustautolock_wrport_adr] <= pair_candidate_pipelinedrobustautolock_wrport_dat_w;
	memadr_3 <= pair_candidate_pipelinedrobustautolock_wrport_adr;
end

assign pair_candidate_pipelinedrobustautolock_rdport_dat_r = dynamic_delay_mem_1[memadr_2];
assign pair_candidate_pipelinedrobustautolock_wrport_dat_r = dynamic_delay_mem_1[memadr_3];

endmodule
