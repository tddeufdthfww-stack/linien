/* Machine-generated using Migen */
module iir_frame_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] x,
	input hold,
	input clear,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [13:0] ref_y,
	output [13:0] cand_y,
	output ref_error,
	output cand_error,
	output [7:0] read_value,
	output [153:0] ref_coeff,
	output [153:0] cand_coeff,
	output [169:0] cfg
);

wire signed [13:0] pair_candidate_x;
reg signed [13:0] pair_candidate_y0 = 14'sd0;
wire pair_candidate_hold;
wire pair_candidate_clear;
reg pair_candidate_error = 1'd0;
reg [15:0] pair_candidate_storage_full = 16'd0;
wire [15:0] pair_candidate_storage;
reg pair_candidate_re = 1'd0;
reg signed [13:0] pair_candidate_a1 = 14'sd0;
reg [13:0] pair_candidate_csrstorage0_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage0_storage;
reg pair_candidate_csrstorage0_re = 1'd0;
reg [13:0] pair_candidate_cohort0 = 14'd0;
reg [13:0] pair_candidate_cohort1 = 14'd0;
reg signed [13:0] pair_candidate_a2 = 14'sd0;
reg [13:0] pair_candidate_csrstorage1_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage1_storage;
reg pair_candidate_csrstorage1_re = 1'd0;
reg [13:0] pair_candidate_cohort2 = 14'd0;
reg [13:0] pair_candidate_cohort3 = 14'd0;
reg signed [13:0] pair_candidate_a3 = 14'sd0;
reg [13:0] pair_candidate_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage2_storage;
reg pair_candidate_csrstorage2_re = 1'd0;
reg [13:0] pair_candidate_cohort4 = 14'd0;
reg [13:0] pair_candidate_cohort5 = 14'd0;
reg signed [13:0] pair_candidate_a4 = 14'sd0;
reg [13:0] pair_candidate_csrstorage3_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage3_storage;
reg pair_candidate_csrstorage3_re = 1'd0;
reg [13:0] pair_candidate_cohort6 = 14'd0;
reg [13:0] pair_candidate_cohort7 = 14'd0;
reg signed [13:0] pair_candidate_a5 = 14'sd0;
reg [13:0] pair_candidate_csrstorage4_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage4_storage;
reg pair_candidate_csrstorage4_re = 1'd0;
reg [13:0] pair_candidate_cohort8 = 14'd0;
reg [13:0] pair_candidate_cohort9 = 14'd0;
reg signed [13:0] pair_candidate_b0 = 14'sd0;
reg [13:0] pair_candidate_csrstorage5_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage5_storage;
reg pair_candidate_csrstorage5_re = 1'd0;
reg [13:0] pair_candidate_cohort10 = 14'd0;
reg [13:0] pair_candidate_cohort11 = 14'd0;
reg signed [13:0] pair_candidate_b1 = 14'sd0;
reg [13:0] pair_candidate_csrstorage6_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage6_storage;
reg pair_candidate_csrstorage6_re = 1'd0;
reg [13:0] pair_candidate_cohort12 = 14'd0;
reg [13:0] pair_candidate_cohort13 = 14'd0;
reg signed [13:0] pair_candidate_b2 = 14'sd0;
reg [13:0] pair_candidate_csrstorage7_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage7_storage;
reg pair_candidate_csrstorage7_re = 1'd0;
reg [13:0] pair_candidate_cohort14 = 14'd0;
reg [13:0] pair_candidate_cohort15 = 14'd0;
reg signed [13:0] pair_candidate_b3 = 14'sd0;
reg [13:0] pair_candidate_csrstorage8_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage8_storage;
reg pair_candidate_csrstorage8_re = 1'd0;
reg [13:0] pair_candidate_cohort16 = 14'd0;
reg [13:0] pair_candidate_cohort17 = 14'd0;
reg signed [13:0] pair_candidate_b4 = 14'sd0;
reg [13:0] pair_candidate_csrstorage9_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage9_storage;
reg pair_candidate_csrstorage9_re = 1'd0;
reg [13:0] pair_candidate_cohort18 = 14'd0;
reg [13:0] pair_candidate_cohort19 = 14'd0;
reg signed [13:0] pair_candidate_b5 = 14'sd0;
reg [13:0] pair_candidate_csrstorage10_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage10_storage;
reg pair_candidate_csrstorage10_re = 1'd0;
reg [13:0] pair_candidate_cohort20 = 14'd0;
reg [13:0] pair_candidate_cohort21 = 14'd0;
reg signed [27:0] pair_candidate_z0r = 28'sd0;
reg [15:0] pair_candidate_z0_cohort0 = 16'd0;
reg [15:0] pair_candidate_z0_cohort1 = 16'd0;
reg signed [13:0] pair_candidate_y_lim;
wire signed [27:0] pair_candidate_y_next;
reg [2:0] pair_candidate_y_pat = 3'd7;
reg signed [13:0] pair_candidate_y1 = 14'sd0;
wire pair_candidate_railed;
reg signed [27:0] pair_candidate_zr0 = 28'sd0;
wire signed [27:0] pair_candidate_z0;
reg signed [27:0] pair_candidate_zr1 = 28'sd0;
wire signed [27:0] pair_candidate_z1;
reg signed [27:0] pair_candidate_zr2 = 28'sd0;
wire signed [27:0] pair_candidate_z2;
reg signed [27:0] pair_candidate_zr3 = 28'sd0;
wire signed [27:0] pair_candidate_z3;
reg signed [27:0] pair_candidate_zr4 = 28'sd0;
wire signed [27:0] pair_candidate_z4;
reg signed [27:0] pair_candidate_zr5 = 28'sd0;
wire signed [27:0] pair_candidate_z5;
reg signed [27:0] pair_candidate_zr6 = 28'sd0;
wire signed [27:0] pair_candidate_z6;
reg signed [27:0] pair_candidate_zr7 = 28'sd0;
wire signed [27:0] pair_candidate_z7;
reg signed [27:0] pair_candidate_zr8 = 28'sd0;
wire signed [27:0] pair_candidate_z8;
reg signed [27:0] pair_candidate_zr9 = 28'sd0;
wire signed [27:0] pair_candidate_z9;
reg signed [27:0] pair_candidate_zr10 = 28'sd0;
wire signed [27:0] pair_candidate_z10;
wire signed [13:0] pair_reference_x;
reg signed [13:0] pair_reference_y0 = 14'sd0;
wire pair_reference_hold;
wire pair_reference_clear;
reg pair_reference_error = 1'd0;
wire [15:0] pair_reference_z0_storage;
reg signed [13:0] pair_reference_a1 = 14'sd0;
wire [13:0] pair_reference_rci_storage0;
reg signed [13:0] pair_reference_a2 = 14'sd0;
wire [13:0] pair_reference_rci_storage1;
reg signed [13:0] pair_reference_a3 = 14'sd0;
wire [13:0] pair_reference_rci_storage2;
reg signed [13:0] pair_reference_a4 = 14'sd0;
wire [13:0] pair_reference_rci_storage3;
reg signed [13:0] pair_reference_a5 = 14'sd0;
wire [13:0] pair_reference_rci_storage4;
reg signed [13:0] pair_reference_b0 = 14'sd0;
wire [13:0] pair_reference_rci_storage5;
reg signed [13:0] pair_reference_b1 = 14'sd0;
wire [13:0] pair_reference_rci_storage6;
reg signed [13:0] pair_reference_b2 = 14'sd0;
wire [13:0] pair_reference_rci_storage7;
reg signed [13:0] pair_reference_b3 = 14'sd0;
wire [13:0] pair_reference_rci_storage8;
reg signed [13:0] pair_reference_b4 = 14'sd0;
wire [13:0] pair_reference_rci_storage9;
reg signed [13:0] pair_reference_b5 = 14'sd0;
wire [13:0] pair_reference_rci_storage10;
reg signed [27:0] pair_reference_z0r = 28'sd0;
reg signed [13:0] pair_reference_y_lim;
wire signed [27:0] pair_reference_y_next;
reg [2:0] pair_reference_y_pat = 3'd7;
reg signed [13:0] pair_reference_y1 = 14'sd0;
wire pair_reference_railed;
reg signed [27:0] pair_reference_zr0 = 28'sd0;
wire signed [27:0] pair_reference_z0;
reg signed [27:0] pair_reference_zr1 = 28'sd0;
wire signed [27:0] pair_reference_z1;
reg signed [27:0] pair_reference_zr2 = 28'sd0;
wire signed [27:0] pair_reference_z2;
reg signed [27:0] pair_reference_zr3 = 28'sd0;
wire signed [27:0] pair_reference_z3;
reg signed [27:0] pair_reference_zr4 = 28'sd0;
wire signed [27:0] pair_reference_z4;
reg signed [27:0] pair_reference_zr5 = 28'sd0;
wire signed [27:0] pair_reference_z5;
reg signed [27:0] pair_reference_zr6 = 28'sd0;
wire signed [27:0] pair_reference_z6;
reg signed [27:0] pair_reference_zr7 = 28'sd0;
wire signed [27:0] pair_reference_z7;
reg signed [27:0] pair_reference_zr8 = 28'sd0;
wire signed [27:0] pair_reference_z8;
reg signed [27:0] pair_reference_zr9 = 28'sd0;
wire signed [27:0] pair_reference_z9;
reg signed [27:0] pair_reference_zr10 = 28'sd0;
wire signed [27:0] pair_reference_z10;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_z01_re;
wire [7:0] pair_z01_r;
wire [7:0] pair_z01_w;
wire pair_z00_re;
wire [7:0] pair_z00_r;
wire [7:0] pair_z00_w;
wire pair_a11_re;
wire [5:0] pair_a11_r;
wire [5:0] pair_a11_w;
wire pair_a10_re;
wire [7:0] pair_a10_r;
wire [7:0] pair_a10_w;
wire pair_a21_re;
wire [5:0] pair_a21_r;
wire [5:0] pair_a21_w;
wire pair_a20_re;
wire [7:0] pair_a20_r;
wire [7:0] pair_a20_w;
wire pair_a31_re;
wire [5:0] pair_a31_r;
wire [5:0] pair_a31_w;
wire pair_a30_re;
wire [7:0] pair_a30_r;
wire [7:0] pair_a30_w;
wire pair_a41_re;
wire [5:0] pair_a41_r;
wire [5:0] pair_a41_w;
wire pair_a40_re;
wire [7:0] pair_a40_r;
wire [7:0] pair_a40_w;
wire pair_a51_re;
wire [5:0] pair_a51_r;
wire [5:0] pair_a51_w;
wire pair_a50_re;
wire [7:0] pair_a50_r;
wire [7:0] pair_a50_w;
wire pair_b01_re;
wire [5:0] pair_b01_r;
wire [5:0] pair_b01_w;
wire pair_b00_re;
wire [7:0] pair_b00_r;
wire [7:0] pair_b00_w;
wire pair_b11_re;
wire [5:0] pair_b11_r;
wire [5:0] pair_b11_w;
wire pair_b10_re;
wire [7:0] pair_b10_r;
wire [7:0] pair_b10_w;
wire pair_b21_re;
wire [5:0] pair_b21_r;
wire [5:0] pair_b21_w;
wire pair_b20_re;
wire [7:0] pair_b20_r;
wire [7:0] pair_b20_w;
wire pair_b31_re;
wire [5:0] pair_b31_r;
wire [5:0] pair_b31_w;
wire pair_b30_re;
wire [7:0] pair_b30_r;
wire [7:0] pair_b30_w;
wire pair_b41_re;
wire [5:0] pair_b41_r;
wire [5:0] pair_b41_w;
wire pair_b40_re;
wire [7:0] pair_b40_r;
wire [7:0] pair_b40_w;
wire pair_b51_re;
wire [5:0] pair_b51_r;
wire [5:0] pair_b51_w;
wire pair_b50_re;
wire [7:0] pair_b50_r;
wire [7:0] pair_b50_w;
wire pair_sel;
reg signed [13:0] pair_q0 = 14'sd0;
reg signed [13:0] pair_q1 = 14'sd0;
reg signed [13:0] pair_q2 = 14'sd0;
reg signed [13:0] pair_q3 = 14'sd0;
reg pair_q4 = 1'd0;
reg pair_q5 = 1'd0;
reg pair_q6 = 1'd0;
reg pair_q7 = 1'd0;
reg pair_q8 = 1'd0;
reg pair_q9 = 1'd0;
reg pair_q10 = 1'd0;
reg pair_q11 = 1'd0;
reg [15:0] pair_q12 = 16'd0;
reg [15:0] pair_q13 = 16'd0;
reg [13:0] pair_q14 = 14'd0;
reg [13:0] pair_q15 = 14'd0;
reg [13:0] pair_q16 = 14'd0;
reg [13:0] pair_q17 = 14'd0;
reg [13:0] pair_q18 = 14'd0;
reg [13:0] pair_q19 = 14'd0;
reg [13:0] pair_q20 = 14'd0;
reg [13:0] pair_q21 = 14'd0;
reg [13:0] pair_q22 = 14'd0;
reg [13:0] pair_q23 = 14'd0;
reg [13:0] pair_q24 = 14'd0;
reg [13:0] pair_q25 = 14'd0;
reg [13:0] pair_q26 = 14'd0;
reg [13:0] pair_q27 = 14'd0;
reg [13:0] pair_q28 = 14'd0;
reg [13:0] pair_q29 = 14'd0;
reg [13:0] pair_q30 = 14'd0;
reg [13:0] pair_q31 = 14'd0;
reg [13:0] pair_q32 = 14'd0;
reg [13:0] pair_q33 = 14'd0;
reg [13:0] pair_q34 = 14'd0;
reg [13:0] pair_q35 = 14'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_candidate_x = pair_q1;
assign pair_reference_x = pair_q3;
assign pair_candidate_hold = pair_q5;
assign pair_reference_hold = pair_q7;
assign pair_candidate_clear = pair_q9;
assign pair_reference_clear = pair_q11;
assign pair_reference_z0_storage = pair_q13;
assign pair_reference_rci_storage0 = pair_q15;
assign pair_reference_rci_storage1 = pair_q17;
assign pair_reference_rci_storage2 = pair_q19;
assign pair_reference_rci_storage3 = pair_q21;
assign pair_reference_rci_storage4 = pair_q23;
assign pair_reference_rci_storage5 = pair_q25;
assign pair_reference_rci_storage6 = pair_q27;
assign pair_reference_rci_storage7 = pair_q29;
assign pair_reference_rci_storage8 = pair_q31;
assign pair_reference_rci_storage9 = pair_q33;
assign pair_reference_rci_storage10 = pair_q35;
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign ref_y = pair_reference_y0;
assign cand_y = pair_candidate_y0;
assign ref_error = pair_reference_error;
assign cand_error = pair_candidate_error;
assign read_value = pair_bus_dat_r;
assign ref_coeff = {pair_reference_b5, pair_reference_b4, pair_reference_b3, pair_reference_b2, pair_reference_b1, pair_reference_b0, pair_reference_a5, pair_reference_a4, pair_reference_a3, pair_reference_a2, pair_reference_a1};
assign cand_coeff = {pair_candidate_b5, pair_candidate_b4, pair_candidate_b3, pair_candidate_b2, pair_candidate_b1, pair_candidate_b0, pair_candidate_a5, pair_candidate_a4, pair_candidate_a3, pair_candidate_a2, pair_candidate_a1};
assign cfg = {pair_candidate_csrstorage10_storage, pair_candidate_csrstorage9_storage, pair_candidate_csrstorage8_storage, pair_candidate_csrstorage7_storage, pair_candidate_csrstorage6_storage, pair_candidate_csrstorage5_storage, pair_candidate_csrstorage4_storage, pair_candidate_csrstorage3_storage, pair_candidate_csrstorage2_storage, pair_candidate_csrstorage1_storage, pair_candidate_csrstorage0_storage, pair_candidate_storage};
assign pair_candidate_railed = (~((pair_candidate_y_next[27:25] == $signed({1'd0, pair_candidate_y_pat})) | (pair_candidate_y_next[27:25] == $signed({1'd0, (~pair_candidate_y_pat)}))));

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_candidate_y_lim <= 14'sd0;
	if (pair_candidate_railed) begin
		pair_candidate_y_lim <= pair_candidate_y0;
	end else begin
		pair_candidate_y_lim <= pair_candidate_y_next[27:12];
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_z0 = (pair_candidate_zr0 + (pair_candidate_x * pair_candidate_b5));
assign pair_candidate_z1 = (pair_candidate_zr1 + (pair_candidate_x * pair_candidate_b4));
assign pair_candidate_z2 = (pair_candidate_zr2 + (pair_candidate_x * pair_candidate_b3));
assign pair_candidate_z3 = (pair_candidate_zr3 + (pair_candidate_x * pair_candidate_b2));
assign pair_candidate_z4 = (pair_candidate_zr4 + (pair_candidate_x * pair_candidate_b1));
assign pair_candidate_z5 = (pair_candidate_zr5 + (pair_candidate_x * pair_candidate_b0));
assign pair_candidate_z6 = (pair_candidate_zr6 + (pair_candidate_y1 * pair_candidate_a5));
assign pair_candidate_z7 = (pair_candidate_zr7 + (pair_candidate_y1 * pair_candidate_a4));
assign pair_candidate_z8 = (pair_candidate_zr8 + (pair_candidate_y1 * pair_candidate_a3));
assign pair_candidate_z9 = (pair_candidate_zr9 + (pair_candidate_y1 * pair_candidate_a2));
assign pair_candidate_z10 = (pair_candidate_zr10 + (pair_candidate_y1 * pair_candidate_a1));
assign pair_candidate_y_next = pair_candidate_z10;
assign pair_reference_railed = (~((pair_reference_y_next[27:25] == $signed({1'd0, pair_reference_y_pat})) | (pair_reference_y_next[27:25] == $signed({1'd0, (~pair_reference_y_pat)}))));

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_reference_y_lim <= 14'sd0;
	if (pair_reference_railed) begin
		pair_reference_y_lim <= pair_reference_y0;
	end else begin
		pair_reference_y_lim <= pair_reference_y_next[27:12];
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_z0 = (pair_reference_zr0 + (pair_reference_x * pair_reference_b5));
assign pair_reference_z1 = (pair_reference_zr1 + (pair_reference_x * pair_reference_b4));
assign pair_reference_z2 = (pair_reference_zr2 + (pair_reference_x * pair_reference_b3));
assign pair_reference_z3 = (pair_reference_zr3 + (pair_reference_x * pair_reference_b2));
assign pair_reference_z4 = (pair_reference_zr4 + (pair_reference_x * pair_reference_b1));
assign pair_reference_z5 = (pair_reference_zr5 + (pair_reference_x * pair_reference_b0));
assign pair_reference_z6 = (pair_reference_zr6 + (pair_reference_y1 * pair_reference_a5));
assign pair_reference_z7 = (pair_reference_zr7 + (pair_reference_y1 * pair_reference_a4));
assign pair_reference_z8 = (pair_reference_zr8 + (pair_reference_y1 * pair_reference_a3));
assign pair_reference_z9 = (pair_reference_zr9 + (pair_reference_y1 * pair_reference_a2));
assign pair_reference_z10 = (pair_reference_zr10 + (pair_reference_y1 * pair_reference_a1));
assign pair_reference_y_next = pair_reference_z10;
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_z01_r = pair_bus_dat_w[7:0];
assign pair_z01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd0));
assign pair_z00_r = pair_bus_dat_w[7:0];
assign pair_z00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd1));
assign pair_a11_r = pair_bus_dat_w[5:0];
assign pair_a11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd2));
assign pair_a10_r = pair_bus_dat_w[7:0];
assign pair_a10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd3));
assign pair_a21_r = pair_bus_dat_w[5:0];
assign pair_a21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd4));
assign pair_a20_r = pair_bus_dat_w[7:0];
assign pair_a20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd5));
assign pair_a31_r = pair_bus_dat_w[5:0];
assign pair_a31_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd6));
assign pair_a30_r = pair_bus_dat_w[7:0];
assign pair_a30_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd7));
assign pair_a41_r = pair_bus_dat_w[5:0];
assign pair_a41_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd8));
assign pair_a40_r = pair_bus_dat_w[7:0];
assign pair_a40_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd9));
assign pair_a51_r = pair_bus_dat_w[5:0];
assign pair_a51_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd10));
assign pair_a50_r = pair_bus_dat_w[7:0];
assign pair_a50_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd11));
assign pair_b01_r = pair_bus_dat_w[5:0];
assign pair_b01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd12));
assign pair_b00_r = pair_bus_dat_w[7:0];
assign pair_b00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd13));
assign pair_b11_r = pair_bus_dat_w[5:0];
assign pair_b11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd14));
assign pair_b10_r = pair_bus_dat_w[7:0];
assign pair_b10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd15));
assign pair_b21_r = pair_bus_dat_w[5:0];
assign pair_b21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd16));
assign pair_b20_r = pair_bus_dat_w[7:0];
assign pair_b20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd17));
assign pair_b31_r = pair_bus_dat_w[5:0];
assign pair_b31_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd18));
assign pair_b30_r = pair_bus_dat_w[7:0];
assign pair_b30_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd19));
assign pair_b41_r = pair_bus_dat_w[5:0];
assign pair_b41_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd20));
assign pair_b40_r = pair_bus_dat_w[7:0];
assign pair_b40_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd21));
assign pair_b51_r = pair_bus_dat_w[5:0];
assign pair_b51_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd22));
assign pair_b50_r = pair_bus_dat_w[7:0];
assign pair_b50_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd23));
assign pair_candidate_storage = pair_candidate_storage_full[15:0];
assign pair_z01_w = pair_candidate_storage_full[15:8];
assign pair_z00_w = pair_candidate_storage_full[7:0];
assign pair_candidate_csrstorage0_storage = pair_candidate_csrstorage0_storage_full[13:0];
assign pair_a11_w = pair_candidate_csrstorage0_storage_full[13:8];
assign pair_a10_w = pair_candidate_csrstorage0_storage_full[7:0];
assign pair_candidate_csrstorage1_storage = pair_candidate_csrstorage1_storage_full[13:0];
assign pair_a21_w = pair_candidate_csrstorage1_storage_full[13:8];
assign pair_a20_w = pair_candidate_csrstorage1_storage_full[7:0];
assign pair_candidate_csrstorage2_storage = pair_candidate_csrstorage2_storage_full[13:0];
assign pair_a31_w = pair_candidate_csrstorage2_storage_full[13:8];
assign pair_a30_w = pair_candidate_csrstorage2_storage_full[7:0];
assign pair_candidate_csrstorage3_storage = pair_candidate_csrstorage3_storage_full[13:0];
assign pair_a41_w = pair_candidate_csrstorage3_storage_full[13:8];
assign pair_a40_w = pair_candidate_csrstorage3_storage_full[7:0];
assign pair_candidate_csrstorage4_storage = pair_candidate_csrstorage4_storage_full[13:0];
assign pair_a51_w = pair_candidate_csrstorage4_storage_full[13:8];
assign pair_a50_w = pair_candidate_csrstorage4_storage_full[7:0];
assign pair_candidate_csrstorage5_storage = pair_candidate_csrstorage5_storage_full[13:0];
assign pair_b01_w = pair_candidate_csrstorage5_storage_full[13:8];
assign pair_b00_w = pair_candidate_csrstorage5_storage_full[7:0];
assign pair_candidate_csrstorage6_storage = pair_candidate_csrstorage6_storage_full[13:0];
assign pair_b11_w = pair_candidate_csrstorage6_storage_full[13:8];
assign pair_b10_w = pair_candidate_csrstorage6_storage_full[7:0];
assign pair_candidate_csrstorage7_storage = pair_candidate_csrstorage7_storage_full[13:0];
assign pair_b21_w = pair_candidate_csrstorage7_storage_full[13:8];
assign pair_b20_w = pair_candidate_csrstorage7_storage_full[7:0];
assign pair_candidate_csrstorage8_storage = pair_candidate_csrstorage8_storage_full[13:0];
assign pair_b31_w = pair_candidate_csrstorage8_storage_full[13:8];
assign pair_b30_w = pair_candidate_csrstorage8_storage_full[7:0];
assign pair_candidate_csrstorage9_storage = pair_candidate_csrstorage9_storage_full[13:0];
assign pair_b41_w = pair_candidate_csrstorage9_storage_full[13:8];
assign pair_b40_w = pair_candidate_csrstorage9_storage_full[7:0];
assign pair_candidate_csrstorage10_storage = pair_candidate_csrstorage10_storage_full[13:0];
assign pair_b51_w = pair_candidate_csrstorage10_storage_full[13:8];
assign pair_b50_w = pair_candidate_csrstorage10_storage_full[7:0];

always @(posedge sys_clk) begin
	pair_q0 <= x;
	pair_q1 <= pair_q0;
	pair_q2 <= x;
	pair_q3 <= pair_q2;
	pair_q4 <= hold;
	pair_q5 <= pair_q4;
	pair_q6 <= hold;
	pair_q7 <= pair_q6;
	pair_q8 <= clear;
	pair_q9 <= pair_q8;
	pair_q10 <= clear;
	pair_q11 <= pair_q10;
	pair_q12 <= pair_candidate_storage;
	pair_q13 <= pair_q12;
	pair_q14 <= pair_candidate_csrstorage0_storage;
	pair_q15 <= pair_q14;
	pair_q16 <= pair_candidate_csrstorage1_storage;
	pair_q17 <= pair_q16;
	pair_q18 <= pair_candidate_csrstorage2_storage;
	pair_q19 <= pair_q18;
	pair_q20 <= pair_candidate_csrstorage3_storage;
	pair_q21 <= pair_q20;
	pair_q22 <= pair_candidate_csrstorage4_storage;
	pair_q23 <= pair_q22;
	pair_q24 <= pair_candidate_csrstorage5_storage;
	pair_q25 <= pair_q24;
	pair_q26 <= pair_candidate_csrstorage6_storage;
	pair_q27 <= pair_q26;
	pair_q28 <= pair_candidate_csrstorage7_storage;
	pair_q29 <= pair_q28;
	pair_q30 <= pair_candidate_csrstorage8_storage;
	pair_q31 <= pair_q30;
	pair_q32 <= pair_candidate_csrstorage9_storage;
	pair_q33 <= pair_q32;
	pair_q34 <= pair_candidate_csrstorage10_storage;
	pair_q35 <= pair_q34;
	pair_candidate_cohort0 <= pair_candidate_csrstorage0_storage;
	pair_candidate_cohort1 <= pair_candidate_cohort0;
	pair_candidate_a1 <= pair_candidate_cohort1;
	pair_candidate_cohort2 <= pair_candidate_csrstorage1_storage;
	pair_candidate_cohort3 <= pair_candidate_cohort2;
	pair_candidate_a2 <= pair_candidate_cohort3;
	pair_candidate_cohort4 <= pair_candidate_csrstorage2_storage;
	pair_candidate_cohort5 <= pair_candidate_cohort4;
	pair_candidate_a3 <= pair_candidate_cohort5;
	pair_candidate_cohort6 <= pair_candidate_csrstorage3_storage;
	pair_candidate_cohort7 <= pair_candidate_cohort6;
	pair_candidate_a4 <= pair_candidate_cohort7;
	pair_candidate_cohort8 <= pair_candidate_csrstorage4_storage;
	pair_candidate_cohort9 <= pair_candidate_cohort8;
	pair_candidate_a5 <= pair_candidate_cohort9;
	pair_candidate_cohort10 <= pair_candidate_csrstorage5_storage;
	pair_candidate_cohort11 <= pair_candidate_cohort10;
	pair_candidate_b0 <= pair_candidate_cohort11;
	pair_candidate_cohort12 <= pair_candidate_csrstorage6_storage;
	pair_candidate_cohort13 <= pair_candidate_cohort12;
	pair_candidate_b1 <= pair_candidate_cohort13;
	pair_candidate_cohort14 <= pair_candidate_csrstorage7_storage;
	pair_candidate_cohort15 <= pair_candidate_cohort14;
	pair_candidate_b2 <= pair_candidate_cohort15;
	pair_candidate_cohort16 <= pair_candidate_csrstorage8_storage;
	pair_candidate_cohort17 <= pair_candidate_cohort16;
	pair_candidate_b3 <= pair_candidate_cohort17;
	pair_candidate_cohort18 <= pair_candidate_csrstorage9_storage;
	pair_candidate_cohort19 <= pair_candidate_cohort18;
	pair_candidate_b4 <= pair_candidate_cohort19;
	pair_candidate_cohort20 <= pair_candidate_csrstorage10_storage;
	pair_candidate_cohort21 <= pair_candidate_cohort20;
	pair_candidate_b5 <= pair_candidate_cohort21;
	pair_candidate_z0_cohort0 <= pair_candidate_storage;
	pair_candidate_z0_cohort1 <= pair_candidate_z0_cohort0;
	pair_candidate_z0r <= (pair_candidate_z0_cohort1 <<< 4'd12);
	pair_candidate_error <= pair_candidate_railed;
	pair_candidate_y0 <= pair_candidate_y_lim;
	if (pair_candidate_clear) begin
		pair_candidate_y1 <= 1'd0;
	end else begin
		if ((~pair_candidate_hold)) begin
			pair_candidate_y1 <= pair_candidate_y_lim;
		end
	end
	pair_candidate_zr0 <= pair_candidate_z0r;
	pair_candidate_zr1 <= pair_candidate_z0;
	pair_candidate_zr2 <= pair_candidate_z1;
	pair_candidate_zr3 <= pair_candidate_z2;
	pair_candidate_zr4 <= pair_candidate_z3;
	pair_candidate_zr5 <= pair_candidate_z4;
	pair_candidate_zr6 <= pair_candidate_z5;
	pair_candidate_zr7 <= pair_candidate_z6;
	pair_candidate_zr8 <= pair_candidate_z7;
	pair_candidate_zr9 <= pair_candidate_z8;
	pair_candidate_zr10 <= pair_candidate_z9;
	pair_reference_a1 <= pair_reference_rci_storage0;
	pair_reference_a2 <= pair_reference_rci_storage1;
	pair_reference_a3 <= pair_reference_rci_storage2;
	pair_reference_a4 <= pair_reference_rci_storage3;
	pair_reference_a5 <= pair_reference_rci_storage4;
	pair_reference_b0 <= pair_reference_rci_storage5;
	pair_reference_b1 <= pair_reference_rci_storage6;
	pair_reference_b2 <= pair_reference_rci_storage7;
	pair_reference_b3 <= pair_reference_rci_storage8;
	pair_reference_b4 <= pair_reference_rci_storage9;
	pair_reference_b5 <= pair_reference_rci_storage10;
	pair_reference_z0r <= (pair_reference_z0_storage <<< 4'd12);
	pair_reference_error <= pair_reference_railed;
	pair_reference_y0 <= pair_reference_y_lim;
	if (pair_reference_clear) begin
		pair_reference_y1 <= 1'd0;
	end else begin
		if ((~pair_reference_hold)) begin
			pair_reference_y1 <= pair_reference_y_lim;
		end
	end
	pair_reference_zr0 <= pair_reference_z0r;
	pair_reference_zr1 <= pair_reference_z0;
	pair_reference_zr2 <= pair_reference_z1;
	pair_reference_zr3 <= pair_reference_z2;
	pair_reference_zr4 <= pair_reference_z3;
	pair_reference_zr5 <= pair_reference_z4;
	pair_reference_zr6 <= pair_reference_z5;
	pair_reference_zr7 <= pair_reference_z6;
	pair_reference_zr8 <= pair_reference_z7;
	pair_reference_zr9 <= pair_reference_z8;
	pair_reference_zr10 <= pair_reference_z9;
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[4:0])
			1'd0: begin
				pair_bus_dat_r <= pair_z01_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_z00_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_a11_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_a10_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_a21_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_a20_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_a31_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_a30_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_a41_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_a40_w;
			end
			4'd10: begin
				pair_bus_dat_r <= pair_a51_w;
			end
			4'd11: begin
				pair_bus_dat_r <= pair_a50_w;
			end
			4'd12: begin
				pair_bus_dat_r <= pair_b01_w;
			end
			4'd13: begin
				pair_bus_dat_r <= pair_b00_w;
			end
			4'd14: begin
				pair_bus_dat_r <= pair_b11_w;
			end
			4'd15: begin
				pair_bus_dat_r <= pair_b10_w;
			end
			5'd16: begin
				pair_bus_dat_r <= pair_b21_w;
			end
			5'd17: begin
				pair_bus_dat_r <= pair_b20_w;
			end
			5'd18: begin
				pair_bus_dat_r <= pair_b31_w;
			end
			5'd19: begin
				pair_bus_dat_r <= pair_b30_w;
			end
			5'd20: begin
				pair_bus_dat_r <= pair_b41_w;
			end
			5'd21: begin
				pair_bus_dat_r <= pair_b40_w;
			end
			5'd22: begin
				pair_bus_dat_r <= pair_b51_w;
			end
			5'd23: begin
				pair_bus_dat_r <= pair_b50_w;
			end
		endcase
	end
	if (pair_z01_re) begin
		pair_candidate_storage_full[15:8] <= pair_z01_r;
	end
	if (pair_z00_re) begin
		pair_candidate_storage_full[7:0] <= pair_z00_r;
	end
	pair_candidate_re <= pair_z00_re;
	if (pair_a11_re) begin
		pair_candidate_csrstorage0_storage_full[13:8] <= pair_a11_r;
	end
	if (pair_a10_re) begin
		pair_candidate_csrstorage0_storage_full[7:0] <= pair_a10_r;
	end
	pair_candidate_csrstorage0_re <= pair_a10_re;
	if (pair_a21_re) begin
		pair_candidate_csrstorage1_storage_full[13:8] <= pair_a21_r;
	end
	if (pair_a20_re) begin
		pair_candidate_csrstorage1_storage_full[7:0] <= pair_a20_r;
	end
	pair_candidate_csrstorage1_re <= pair_a20_re;
	if (pair_a31_re) begin
		pair_candidate_csrstorage2_storage_full[13:8] <= pair_a31_r;
	end
	if (pair_a30_re) begin
		pair_candidate_csrstorage2_storage_full[7:0] <= pair_a30_r;
	end
	pair_candidate_csrstorage2_re <= pair_a30_re;
	if (pair_a41_re) begin
		pair_candidate_csrstorage3_storage_full[13:8] <= pair_a41_r;
	end
	if (pair_a40_re) begin
		pair_candidate_csrstorage3_storage_full[7:0] <= pair_a40_r;
	end
	pair_candidate_csrstorage3_re <= pair_a40_re;
	if (pair_a51_re) begin
		pair_candidate_csrstorage4_storage_full[13:8] <= pair_a51_r;
	end
	if (pair_a50_re) begin
		pair_candidate_csrstorage4_storage_full[7:0] <= pair_a50_r;
	end
	pair_candidate_csrstorage4_re <= pair_a50_re;
	if (pair_b01_re) begin
		pair_candidate_csrstorage5_storage_full[13:8] <= pair_b01_r;
	end
	if (pair_b00_re) begin
		pair_candidate_csrstorage5_storage_full[7:0] <= pair_b00_r;
	end
	pair_candidate_csrstorage5_re <= pair_b00_re;
	if (pair_b11_re) begin
		pair_candidate_csrstorage6_storage_full[13:8] <= pair_b11_r;
	end
	if (pair_b10_re) begin
		pair_candidate_csrstorage6_storage_full[7:0] <= pair_b10_r;
	end
	pair_candidate_csrstorage6_re <= pair_b10_re;
	if (pair_b21_re) begin
		pair_candidate_csrstorage7_storage_full[13:8] <= pair_b21_r;
	end
	if (pair_b20_re) begin
		pair_candidate_csrstorage7_storage_full[7:0] <= pair_b20_r;
	end
	pair_candidate_csrstorage7_re <= pair_b20_re;
	if (pair_b31_re) begin
		pair_candidate_csrstorage8_storage_full[13:8] <= pair_b31_r;
	end
	if (pair_b30_re) begin
		pair_candidate_csrstorage8_storage_full[7:0] <= pair_b30_r;
	end
	pair_candidate_csrstorage8_re <= pair_b30_re;
	if (pair_b41_re) begin
		pair_candidate_csrstorage9_storage_full[13:8] <= pair_b41_r;
	end
	if (pair_b40_re) begin
		pair_candidate_csrstorage9_storage_full[7:0] <= pair_b40_r;
	end
	pair_candidate_csrstorage9_re <= pair_b40_re;
	if (pair_b51_re) begin
		pair_candidate_csrstorage10_storage_full[13:8] <= pair_b51_r;
	end
	if (pair_b50_re) begin
		pair_candidate_csrstorage10_storage_full[7:0] <= pair_b50_r;
	end
	pair_candidate_csrstorage10_re <= pair_b50_re;
	if (sys_rst) begin
		pair_candidate_y0 <= 14'sd0;
		pair_candidate_error <= 1'd0;
		pair_candidate_storage_full <= 16'd0;
		pair_candidate_re <= 1'd0;
		pair_candidate_a1 <= 14'sd0;
		pair_candidate_csrstorage0_storage_full <= 14'd0;
		pair_candidate_csrstorage0_re <= 1'd0;
		pair_candidate_cohort0 <= 14'd0;
		pair_candidate_cohort1 <= 14'd0;
		pair_candidate_a2 <= 14'sd0;
		pair_candidate_csrstorage1_storage_full <= 14'd0;
		pair_candidate_csrstorage1_re <= 1'd0;
		pair_candidate_cohort2 <= 14'd0;
		pair_candidate_cohort3 <= 14'd0;
		pair_candidate_a3 <= 14'sd0;
		pair_candidate_csrstorage2_storage_full <= 14'd0;
		pair_candidate_csrstorage2_re <= 1'd0;
		pair_candidate_cohort4 <= 14'd0;
		pair_candidate_cohort5 <= 14'd0;
		pair_candidate_a4 <= 14'sd0;
		pair_candidate_csrstorage3_storage_full <= 14'd0;
		pair_candidate_csrstorage3_re <= 1'd0;
		pair_candidate_cohort6 <= 14'd0;
		pair_candidate_cohort7 <= 14'd0;
		pair_candidate_a5 <= 14'sd0;
		pair_candidate_csrstorage4_storage_full <= 14'd0;
		pair_candidate_csrstorage4_re <= 1'd0;
		pair_candidate_cohort8 <= 14'd0;
		pair_candidate_cohort9 <= 14'd0;
		pair_candidate_b0 <= 14'sd0;
		pair_candidate_csrstorage5_storage_full <= 14'd0;
		pair_candidate_csrstorage5_re <= 1'd0;
		pair_candidate_cohort10 <= 14'd0;
		pair_candidate_cohort11 <= 14'd0;
		pair_candidate_b1 <= 14'sd0;
		pair_candidate_csrstorage6_storage_full <= 14'd0;
		pair_candidate_csrstorage6_re <= 1'd0;
		pair_candidate_cohort12 <= 14'd0;
		pair_candidate_cohort13 <= 14'd0;
		pair_candidate_b2 <= 14'sd0;
		pair_candidate_csrstorage7_storage_full <= 14'd0;
		pair_candidate_csrstorage7_re <= 1'd0;
		pair_candidate_cohort14 <= 14'd0;
		pair_candidate_cohort15 <= 14'd0;
		pair_candidate_b3 <= 14'sd0;
		pair_candidate_csrstorage8_storage_full <= 14'd0;
		pair_candidate_csrstorage8_re <= 1'd0;
		pair_candidate_cohort16 <= 14'd0;
		pair_candidate_cohort17 <= 14'd0;
		pair_candidate_b4 <= 14'sd0;
		pair_candidate_csrstorage9_storage_full <= 14'd0;
		pair_candidate_csrstorage9_re <= 1'd0;
		pair_candidate_cohort18 <= 14'd0;
		pair_candidate_cohort19 <= 14'd0;
		pair_candidate_b5 <= 14'sd0;
		pair_candidate_csrstorage10_storage_full <= 14'd0;
		pair_candidate_csrstorage10_re <= 1'd0;
		pair_candidate_cohort20 <= 14'd0;
		pair_candidate_cohort21 <= 14'd0;
		pair_candidate_z0r <= 28'sd0;
		pair_candidate_z0_cohort0 <= 16'd0;
		pair_candidate_z0_cohort1 <= 16'd0;
		pair_candidate_y1 <= 14'sd0;
		pair_candidate_zr0 <= 28'sd0;
		pair_candidate_zr1 <= 28'sd0;
		pair_candidate_zr2 <= 28'sd0;
		pair_candidate_zr3 <= 28'sd0;
		pair_candidate_zr4 <= 28'sd0;
		pair_candidate_zr5 <= 28'sd0;
		pair_candidate_zr6 <= 28'sd0;
		pair_candidate_zr7 <= 28'sd0;
		pair_candidate_zr8 <= 28'sd0;
		pair_candidate_zr9 <= 28'sd0;
		pair_candidate_zr10 <= 28'sd0;
		pair_reference_y0 <= 14'sd0;
		pair_reference_error <= 1'd0;
		pair_reference_a1 <= 14'sd0;
		pair_reference_a2 <= 14'sd0;
		pair_reference_a3 <= 14'sd0;
		pair_reference_a4 <= 14'sd0;
		pair_reference_a5 <= 14'sd0;
		pair_reference_b0 <= 14'sd0;
		pair_reference_b1 <= 14'sd0;
		pair_reference_b2 <= 14'sd0;
		pair_reference_b3 <= 14'sd0;
		pair_reference_b4 <= 14'sd0;
		pair_reference_b5 <= 14'sd0;
		pair_reference_z0r <= 28'sd0;
		pair_reference_y1 <= 14'sd0;
		pair_reference_zr0 <= 28'sd0;
		pair_reference_zr1 <= 28'sd0;
		pair_reference_zr2 <= 28'sd0;
		pair_reference_zr3 <= 28'sd0;
		pair_reference_zr4 <= 28'sd0;
		pair_reference_zr5 <= 28'sd0;
		pair_reference_zr6 <= 28'sd0;
		pair_reference_zr7 <= 28'sd0;
		pair_reference_zr8 <= 28'sd0;
		pair_reference_zr9 <= 28'sd0;
		pair_reference_zr10 <= 28'sd0;
		pair_bus_dat_r <= 8'd0;
		pair_q0 <= 14'sd0;
		pair_q1 <= 14'sd0;
		pair_q2 <= 14'sd0;
		pair_q3 <= 14'sd0;
		pair_q4 <= 1'd0;
		pair_q5 <= 1'd0;
		pair_q6 <= 1'd0;
		pair_q7 <= 1'd0;
		pair_q8 <= 1'd0;
		pair_q9 <= 1'd0;
		pair_q10 <= 1'd0;
		pair_q11 <= 1'd0;
		pair_q12 <= 16'd0;
		pair_q13 <= 16'd0;
		pair_q14 <= 14'd0;
		pair_q15 <= 14'd0;
		pair_q16 <= 14'd0;
		pair_q17 <= 14'd0;
		pair_q18 <= 14'd0;
		pair_q19 <= 14'd0;
		pair_q20 <= 14'd0;
		pair_q21 <= 14'd0;
		pair_q22 <= 14'd0;
		pair_q23 <= 14'd0;
		pair_q24 <= 14'd0;
		pair_q25 <= 14'd0;
		pair_q26 <= 14'd0;
		pair_q27 <= 14'd0;
		pair_q28 <= 14'd0;
		pair_q29 <= 14'd0;
		pair_q30 <= 14'd0;
		pair_q31 <= 14'd0;
		pair_q32 <= 14'd0;
		pair_q33 <= 14'd0;
		pair_q34 <= 14'd0;
		pair_q35 <= 14'd0;
	end
end

endmodule
