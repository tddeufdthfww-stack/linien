/* Machine-generated using Migen */
module iir_frame_pair(
	input sys_clk,
	input sys_rst,
	input signed [24:0] x,
	input hold,
	input clear,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [24:0] ref_y,
	output [24:0] cand_y,
	output ref_error,
	output cand_error,
	output [7:0] read_value,
	output [124:0] ref_coeff,
	output [124:0] cand_coeff,
	output [151:0] cfg
);

wire signed [24:0] pair_candidate_x;
reg signed [24:0] pair_candidate_y0 = 25'sd0;
wire pair_candidate_hold;
wire pair_candidate_clear;
reg pair_candidate_error = 1'd0;
reg [26:0] pair_candidate_storage_full = 27'd0;
wire [26:0] pair_candidate_storage;
reg pair_candidate_re = 1'd0;
reg signed [24:0] pair_candidate_a1 = 25'sd0;
reg [24:0] pair_candidate_csrstorage0_storage_full = 25'd0;
wire [24:0] pair_candidate_csrstorage0_storage;
reg pair_candidate_csrstorage0_re = 1'd0;
reg signed [24:0] pair_candidate_a2 = 25'sd0;
reg [24:0] pair_candidate_csrstorage1_storage_full = 25'd0;
wire [24:0] pair_candidate_csrstorage1_storage;
reg pair_candidate_csrstorage1_re = 1'd0;
reg signed [24:0] pair_candidate_b0 = 25'sd0;
reg [24:0] pair_candidate_csrstorage2_storage_full = 25'd0;
wire [24:0] pair_candidate_csrstorage2_storage;
reg pair_candidate_csrstorage2_re = 1'd0;
reg signed [24:0] pair_candidate_b1 = 25'sd0;
reg [24:0] pair_candidate_csrstorage3_storage_full = 25'd0;
wire [24:0] pair_candidate_csrstorage3_storage;
reg pair_candidate_csrstorage3_re = 1'd0;
reg signed [24:0] pair_candidate_b2 = 25'sd0;
reg [24:0] pair_candidate_csrstorage4_storage_full = 25'd0;
wire [24:0] pair_candidate_csrstorage4_storage;
reg pair_candidate_csrstorage4_re = 1'd0;
reg signed [49:0] pair_candidate_z0r = 50'sd0;
reg signed [24:0] pair_candidate_y_lim;
wire signed [49:0] pair_candidate_y_next;
reg [2:0] pair_candidate_y_pat = 3'd7;
reg signed [24:0] pair_candidate_y1 = 25'sd0;
wire pair_candidate_railed;
reg signed [49:0] pair_candidate_zr0 = 50'sd0;
wire signed [47:0] pair_candidate_zr_low0;
wire [47:0] pair_candidate_zr_cascade0;
wire signed [47:0] pair_candidate_zr_high_q0;
wire pair_candidate_zr1;
wire pair_candidate_zr2;
wire signed [3:0] pair_candidate_zr_correction0;
reg signed [3:0] pair_candidate_zr_correction_q0 = 4'sd0;
reg [16:0] pair_candidate_zr_low_q0 = 17'd0;
wire [1:0] pair_candidate_zr_top0;
wire signed [49:0] pair_candidate_zr_result0;
wire signed [47:0] pair_candidate_zr_zlo0;
wire signed [1:0] pair_candidate_zr_ztop0;
wire signed [47:0] pair_candidate_zr_low1;
wire [47:0] pair_candidate_zr_cascade1;
wire signed [47:0] pair_candidate_zr_high_q1;
wire pair_candidate_zr3;
wire pair_candidate_zr4;
wire signed [3:0] pair_candidate_zr_correction1;
reg signed [3:0] pair_candidate_zr_correction_q1 = 4'sd0;
reg [16:0] pair_candidate_zr_low_q1 = 17'd0;
wire [1:0] pair_candidate_zr_top1;
wire signed [49:0] pair_candidate_zr_result1;
wire signed [47:0] pair_candidate_zr_zlo1;
wire signed [1:0] pair_candidate_zr_ztop1;
wire signed [47:0] pair_candidate_zr_low2;
wire [47:0] pair_candidate_zr_cascade2;
wire signed [47:0] pair_candidate_zr_high_q2;
wire pair_candidate_zr5;
wire pair_candidate_zr6;
wire signed [3:0] pair_candidate_zr_correction2;
reg signed [3:0] pair_candidate_zr_correction_q2 = 4'sd0;
reg [16:0] pair_candidate_zr_low_q2 = 17'd0;
wire [1:0] pair_candidate_zr_top2;
wire signed [49:0] pair_candidate_zr_result2;
wire signed [47:0] pair_candidate_zr_zlo2;
wire signed [1:0] pair_candidate_zr_ztop2;
wire signed [47:0] pair_candidate_zr_low3;
wire [47:0] pair_candidate_zr_cascade3;
wire signed [47:0] pair_candidate_zr_high_q3;
wire pair_candidate_zr7;
wire pair_candidate_zr8;
wire signed [3:0] pair_candidate_zr_correction3;
reg signed [3:0] pair_candidate_zr_correction_q3 = 4'sd0;
reg [16:0] pair_candidate_zr_low_q3 = 17'd0;
wire [1:0] pair_candidate_zr_top3;
wire signed [49:0] pair_candidate_zr_result3;
wire signed [47:0] pair_candidate_zr_zlo3;
wire signed [1:0] pair_candidate_zr_ztop3;
wire signed [17:0] pair_candidate_z_xlo;
wire signed [7:0] pair_candidate_z_xhi;
wire signed [47:0] pair_candidate_z_zlo;
wire signed [1:0] pair_candidate_z_ztop;
(* use_dsp = "yes" *) wire signed [47:0] pair_candidate_z_low;
(* use_dsp = "yes" *) wire signed [47:0] pair_candidate_z_high;
wire pair_candidate_z_carry;
wire signed [3:0] pair_candidate_z_correction;
wire [1:0] pair_candidate_z_top;
wire signed [49:0] pair_candidate_z_result;
wire signed [24:0] pair_reference_x;
reg signed [24:0] pair_reference_y0 = 25'sd0;
wire pair_reference_hold;
wire pair_reference_clear;
reg pair_reference_error = 1'd0;
wire [26:0] pair_reference_z0_storage;
reg signed [24:0] pair_reference_a1 = 25'sd0;
wire [24:0] pair_reference_rci_storage0;
reg signed [24:0] pair_reference_a2 = 25'sd0;
wire [24:0] pair_reference_rci_storage1;
reg signed [24:0] pair_reference_b0 = 25'sd0;
wire [24:0] pair_reference_rci_storage2;
reg signed [24:0] pair_reference_b1 = 25'sd0;
wire [24:0] pair_reference_rci_storage3;
reg signed [24:0] pair_reference_b2 = 25'sd0;
wire [24:0] pair_reference_rci_storage4;
reg signed [49:0] pair_reference_z0r = 50'sd0;
reg signed [24:0] pair_reference_y_lim;
wire signed [49:0] pair_reference_y_next;
reg [2:0] pair_reference_y_pat = 3'd7;
reg signed [24:0] pair_reference_y1 = 25'sd0;
wire pair_reference_railed;
reg signed [49:0] pair_reference_zr0 = 50'sd0;
wire signed [49:0] pair_reference_z0;
reg signed [49:0] pair_reference_zr1 = 50'sd0;
wire signed [49:0] pair_reference_z1;
reg signed [49:0] pair_reference_zr2 = 50'sd0;
wire signed [49:0] pair_reference_z2;
reg signed [49:0] pair_reference_zr3 = 50'sd0;
wire signed [49:0] pair_reference_z3;
reg signed [49:0] pair_reference_zr4 = 50'sd0;
wire signed [49:0] pair_reference_z4;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_z03_re;
wire [2:0] pair_z03_r;
wire [2:0] pair_z03_w;
wire pair_z02_re;
wire [7:0] pair_z02_r;
wire [7:0] pair_z02_w;
wire pair_z01_re;
wire [7:0] pair_z01_r;
wire [7:0] pair_z01_w;
wire pair_z00_re;
wire [7:0] pair_z00_r;
wire [7:0] pair_z00_w;
wire pair_a13_re;
wire pair_a13_r;
wire pair_a13_w;
wire pair_a12_re;
wire [7:0] pair_a12_r;
wire [7:0] pair_a12_w;
wire pair_a11_re;
wire [7:0] pair_a11_r;
wire [7:0] pair_a11_w;
wire pair_a10_re;
wire [7:0] pair_a10_r;
wire [7:0] pair_a10_w;
wire pair_a23_re;
wire pair_a23_r;
wire pair_a23_w;
wire pair_a22_re;
wire [7:0] pair_a22_r;
wire [7:0] pair_a22_w;
wire pair_a21_re;
wire [7:0] pair_a21_r;
wire [7:0] pair_a21_w;
wire pair_a20_re;
wire [7:0] pair_a20_r;
wire [7:0] pair_a20_w;
wire pair_b03_re;
wire pair_b03_r;
wire pair_b03_w;
wire pair_b02_re;
wire [7:0] pair_b02_r;
wire [7:0] pair_b02_w;
wire pair_b01_re;
wire [7:0] pair_b01_r;
wire [7:0] pair_b01_w;
wire pair_b00_re;
wire [7:0] pair_b00_r;
wire [7:0] pair_b00_w;
wire pair_b13_re;
wire pair_b13_r;
wire pair_b13_w;
wire pair_b12_re;
wire [7:0] pair_b12_r;
wire [7:0] pair_b12_w;
wire pair_b11_re;
wire [7:0] pair_b11_r;
wire [7:0] pair_b11_w;
wire pair_b10_re;
wire [7:0] pair_b10_r;
wire [7:0] pair_b10_w;
wire pair_b23_re;
wire pair_b23_r;
wire pair_b23_w;
wire pair_b22_re;
wire [7:0] pair_b22_r;
wire [7:0] pair_b22_w;
wire pair_b21_re;
wire [7:0] pair_b21_r;
wire [7:0] pair_b21_w;
wire pair_b20_re;
wire [7:0] pair_b20_r;
wire [7:0] pair_b20_w;
wire pair_sel;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_candidate_x = x;
assign pair_reference_x = x;
assign pair_candidate_hold = hold;
assign pair_reference_hold = hold;
assign pair_candidate_clear = clear;
assign pair_reference_clear = clear;
assign pair_reference_z0_storage = pair_candidate_storage;
assign pair_reference_rci_storage0 = pair_candidate_csrstorage0_storage;
assign pair_reference_rci_storage1 = pair_candidate_csrstorage1_storage;
assign pair_reference_rci_storage2 = pair_candidate_csrstorage2_storage;
assign pair_reference_rci_storage3 = pair_candidate_csrstorage3_storage;
assign pair_reference_rci_storage4 = pair_candidate_csrstorage4_storage;
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign ref_y = pair_reference_y0;
assign cand_y = pair_candidate_y0;
assign ref_error = pair_reference_error;
assign cand_error = pair_candidate_error;
assign read_value = pair_bus_dat_r;
assign ref_coeff = {pair_reference_b2, pair_reference_b1, pair_reference_b0, pair_reference_a2, pair_reference_a1};
assign cand_coeff = {pair_candidate_b2, pair_candidate_b1, pair_candidate_b0, pair_candidate_a2, pair_candidate_a1};
assign cfg = {pair_candidate_csrstorage4_storage, pair_candidate_csrstorage3_storage, pair_candidate_csrstorage2_storage, pair_candidate_csrstorage1_storage, pair_candidate_csrstorage0_storage, pair_candidate_storage};
assign pair_candidate_railed = (~((pair_candidate_y_next[49:47] == $signed({1'd0, pair_candidate_y_pat})) | (pair_candidate_y_next[49:47] == $signed({1'd0, (~pair_candidate_y_pat)}))));

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_candidate_y_lim <= 25'sd0;
	if (pair_candidate_railed) begin
		pair_candidate_y_lim <= pair_candidate_y0;
	end else begin
		pair_candidate_y_lim <= pair_candidate_y_next[49:23];
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_zr_zlo0 = pair_candidate_zr0[47:0];
assign pair_candidate_zr_ztop0 = pair_candidate_zr0[49:48];
assign pair_candidate_zr1 = (((~pair_candidate_zr_zlo0[47]) & (~pair_candidate_b2[24])) & pair_candidate_zr_low0[47]);
assign pair_candidate_zr2 = ((pair_candidate_zr_zlo0[47] & pair_candidate_b2[24]) & (~pair_candidate_zr_low0[47]));
assign pair_candidate_zr_correction0 = (((pair_candidate_zr_ztop0 + pair_candidate_zr_zlo0[47]) + $signed({1'd0, pair_candidate_zr1})) - $signed({1'd0, pair_candidate_zr2}));
assign pair_candidate_zr_top0 = (pair_candidate_zr_high_q0[32:31] + pair_candidate_zr_correction_q0);
assign pair_candidate_zr_result0 = {pair_candidate_zr_top0, pair_candidate_zr_high_q0[30:0], pair_candidate_zr_low_q0};
assign pair_candidate_zr_zlo1 = pair_candidate_zr_result0[47:0];
assign pair_candidate_zr_ztop1 = pair_candidate_zr_result0[49:48];
assign pair_candidate_zr3 = (((~pair_candidate_zr_zlo1[47]) & (~pair_candidate_b1[24])) & pair_candidate_zr_low1[47]);
assign pair_candidate_zr4 = ((pair_candidate_zr_zlo1[47] & pair_candidate_b1[24]) & (~pair_candidate_zr_low1[47]));
assign pair_candidate_zr_correction1 = (((pair_candidate_zr_ztop1 + pair_candidate_zr_zlo1[47]) + $signed({1'd0, pair_candidate_zr3})) - $signed({1'd0, pair_candidate_zr4}));
assign pair_candidate_zr_top1 = (pair_candidate_zr_high_q1[32:31] + pair_candidate_zr_correction_q1);
assign pair_candidate_zr_result1 = {pair_candidate_zr_top1, pair_candidate_zr_high_q1[30:0], pair_candidate_zr_low_q1};
assign pair_candidate_zr_zlo2 = pair_candidate_zr_result1[47:0];
assign pair_candidate_zr_ztop2 = pair_candidate_zr_result1[49:48];
assign pair_candidate_zr5 = (((~pair_candidate_zr_zlo2[47]) & (~pair_candidate_b0[24])) & pair_candidate_zr_low2[47]);
assign pair_candidate_zr6 = ((pair_candidate_zr_zlo2[47] & pair_candidate_b0[24]) & (~pair_candidate_zr_low2[47]));
assign pair_candidate_zr_correction2 = (((pair_candidate_zr_ztop2 + pair_candidate_zr_zlo2[47]) + $signed({1'd0, pair_candidate_zr5})) - $signed({1'd0, pair_candidate_zr6}));
assign pair_candidate_zr_top2 = (pair_candidate_zr_high_q2[32:31] + pair_candidate_zr_correction_q2);
assign pair_candidate_zr_result2 = {pair_candidate_zr_top2, pair_candidate_zr_high_q2[30:0], pair_candidate_zr_low_q2};
assign pair_candidate_zr_zlo3 = pair_candidate_zr_result2[47:0];
assign pair_candidate_zr_ztop3 = pair_candidate_zr_result2[49:48];
assign pair_candidate_zr7 = (((~pair_candidate_zr_zlo3[47]) & (~pair_candidate_a2[24])) & pair_candidate_zr_low3[47]);
assign pair_candidate_zr8 = ((pair_candidate_zr_zlo3[47] & pair_candidate_a2[24]) & (~pair_candidate_zr_low3[47]));
assign pair_candidate_zr_correction3 = (((pair_candidate_zr_ztop3 + pair_candidate_zr_zlo3[47]) + $signed({1'd0, pair_candidate_zr7})) - $signed({1'd0, pair_candidate_zr8}));
assign pair_candidate_zr_top3 = (pair_candidate_zr_high_q3[32:31] + pair_candidate_zr_correction_q3);
assign pair_candidate_zr_result3 = {pair_candidate_zr_top3, pair_candidate_zr_high_q3[30:0], pair_candidate_zr_low_q3};
assign pair_candidate_z_xlo = {1'd0, pair_candidate_y1[16:0]};
assign pair_candidate_z_xhi = pair_candidate_y1[24:17];
assign pair_candidate_z_zlo = pair_candidate_zr_result3[47:0];
assign pair_candidate_z_ztop = pair_candidate_zr_result3[49:48];
assign pair_candidate_z_low = ((pair_candidate_a1 * pair_candidate_z_xlo) + pair_candidate_z_zlo);
assign pair_candidate_z_high = ((pair_candidate_a1 * pair_candidate_z_xhi) + (pair_candidate_z_low >>> 5'd17));
assign pair_candidate_z_carry = ((pair_candidate_z_zlo[47] & pair_candidate_z_low[47]) | ((~pair_candidate_a1[24]) & (pair_candidate_z_zlo[47] | pair_candidate_z_low[47])));
assign pair_candidate_z_correction = (pair_candidate_z_ztop + $signed({1'd0, pair_candidate_z_carry}));
assign pair_candidate_z_top = (pair_candidate_z_high[32:31] + pair_candidate_z_correction);
assign pair_candidate_z_result = {pair_candidate_z_top, pair_candidate_z_high[30:0], pair_candidate_z_low[16:0]};
assign pair_candidate_y_next = pair_candidate_z_result;
assign pair_reference_railed = (~((pair_reference_y_next[49:47] == $signed({1'd0, pair_reference_y_pat})) | (pair_reference_y_next[49:47] == $signed({1'd0, (~pair_reference_y_pat)}))));

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_reference_y_lim <= 25'sd0;
	if (pair_reference_railed) begin
		pair_reference_y_lim <= pair_reference_y0;
	end else begin
		pair_reference_y_lim <= pair_reference_y_next[49:23];
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_z0 = (pair_reference_zr0 + (pair_reference_x * pair_reference_b2));
assign pair_reference_z1 = (pair_reference_zr1 + (pair_reference_x * pair_reference_b1));
assign pair_reference_z2 = (pair_reference_zr2 + (pair_reference_x * pair_reference_b0));
assign pair_reference_z3 = (pair_reference_zr3 + (pair_reference_y1 * pair_reference_a2));
assign pair_reference_z4 = (pair_reference_zr4 + (pair_reference_y1 * pair_reference_a1));
assign pair_reference_y_next = pair_reference_z4;
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_z03_r = pair_bus_dat_w[2:0];
assign pair_z03_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd0));
assign pair_z02_r = pair_bus_dat_w[7:0];
assign pair_z02_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 1'd1));
assign pair_z01_r = pair_bus_dat_w[7:0];
assign pair_z01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd2));
assign pair_z00_r = pair_bus_dat_w[7:0];
assign pair_z00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 2'd3));
assign pair_a13_r = pair_bus_dat_w[0];
assign pair_a13_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd4));
assign pair_a12_r = pair_bus_dat_w[7:0];
assign pair_a12_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd5));
assign pair_a11_r = pair_bus_dat_w[7:0];
assign pair_a11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd6));
assign pair_a10_r = pair_bus_dat_w[7:0];
assign pair_a10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 3'd7));
assign pair_a23_r = pair_bus_dat_w[0];
assign pair_a23_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd8));
assign pair_a22_r = pair_bus_dat_w[7:0];
assign pair_a22_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd9));
assign pair_a21_r = pair_bus_dat_w[7:0];
assign pair_a21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd10));
assign pair_a20_r = pair_bus_dat_w[7:0];
assign pair_a20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd11));
assign pair_b03_r = pair_bus_dat_w[0];
assign pair_b03_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd12));
assign pair_b02_r = pair_bus_dat_w[7:0];
assign pair_b02_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd13));
assign pair_b01_r = pair_bus_dat_w[7:0];
assign pair_b01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd14));
assign pair_b00_r = pair_bus_dat_w[7:0];
assign pair_b00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 4'd15));
assign pair_b13_r = pair_bus_dat_w[0];
assign pair_b13_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd16));
assign pair_b12_r = pair_bus_dat_w[7:0];
assign pair_b12_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd17));
assign pair_b11_r = pair_bus_dat_w[7:0];
assign pair_b11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd18));
assign pair_b10_r = pair_bus_dat_w[7:0];
assign pair_b10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd19));
assign pair_b23_r = pair_bus_dat_w[0];
assign pair_b23_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd20));
assign pair_b22_r = pair_bus_dat_w[7:0];
assign pair_b22_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd21));
assign pair_b21_r = pair_bus_dat_w[7:0];
assign pair_b21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd22));
assign pair_b20_r = pair_bus_dat_w[7:0];
assign pair_b20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[4:0] == 5'd23));
assign pair_candidate_storage = pair_candidate_storage_full[26:0];
assign pair_z03_w = pair_candidate_storage_full[26:24];
assign pair_z02_w = pair_candidate_storage_full[23:16];
assign pair_z01_w = pair_candidate_storage_full[15:8];
assign pair_z00_w = pair_candidate_storage_full[7:0];
assign pair_candidate_csrstorage0_storage = pair_candidate_csrstorage0_storage_full[24:0];
assign pair_a13_w = pair_candidate_csrstorage0_storage_full[24];
assign pair_a12_w = pair_candidate_csrstorage0_storage_full[23:16];
assign pair_a11_w = pair_candidate_csrstorage0_storage_full[15:8];
assign pair_a10_w = pair_candidate_csrstorage0_storage_full[7:0];
assign pair_candidate_csrstorage1_storage = pair_candidate_csrstorage1_storage_full[24:0];
assign pair_a23_w = pair_candidate_csrstorage1_storage_full[24];
assign pair_a22_w = pair_candidate_csrstorage1_storage_full[23:16];
assign pair_a21_w = pair_candidate_csrstorage1_storage_full[15:8];
assign pair_a20_w = pair_candidate_csrstorage1_storage_full[7:0];
assign pair_candidate_csrstorage2_storage = pair_candidate_csrstorage2_storage_full[24:0];
assign pair_b03_w = pair_candidate_csrstorage2_storage_full[24];
assign pair_b02_w = pair_candidate_csrstorage2_storage_full[23:16];
assign pair_b01_w = pair_candidate_csrstorage2_storage_full[15:8];
assign pair_b00_w = pair_candidate_csrstorage2_storage_full[7:0];
assign pair_candidate_csrstorage3_storage = pair_candidate_csrstorage3_storage_full[24:0];
assign pair_b13_w = pair_candidate_csrstorage3_storage_full[24];
assign pair_b12_w = pair_candidate_csrstorage3_storage_full[23:16];
assign pair_b11_w = pair_candidate_csrstorage3_storage_full[15:8];
assign pair_b10_w = pair_candidate_csrstorage3_storage_full[7:0];
assign pair_candidate_csrstorage4_storage = pair_candidate_csrstorage4_storage_full[24:0];
assign pair_b23_w = pair_candidate_csrstorage4_storage_full[24];
assign pair_b22_w = pair_candidate_csrstorage4_storage_full[23:16];
assign pair_b21_w = pair_candidate_csrstorage4_storage_full[15:8];
assign pair_b20_w = pair_candidate_csrstorage4_storage_full[7:0];

always @(posedge sys_clk) begin
	pair_candidate_a1 <= pair_candidate_csrstorage0_storage;
	pair_candidate_a2 <= pair_candidate_csrstorage1_storage;
	pair_candidate_b0 <= pair_candidate_csrstorage2_storage;
	pair_candidate_b1 <= pair_candidate_csrstorage3_storage;
	pair_candidate_b2 <= pair_candidate_csrstorage4_storage;
	pair_candidate_z0r <= (pair_candidate_storage <<< 5'd23);
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
	pair_candidate_zr_low_q0 <= pair_candidate_zr_low0[16:0];
	pair_candidate_zr_correction_q0 <= pair_candidate_zr_correction0;
	pair_candidate_zr_low_q1 <= pair_candidate_zr_low1[16:0];
	pair_candidate_zr_correction_q1 <= pair_candidate_zr_correction1;
	pair_candidate_zr_low_q2 <= pair_candidate_zr_low2[16:0];
	pair_candidate_zr_correction_q2 <= pair_candidate_zr_correction2;
	pair_candidate_zr_low_q3 <= pair_candidate_zr_low3[16:0];
	pair_candidate_zr_correction_q3 <= pair_candidate_zr_correction3;
	pair_reference_a1 <= pair_reference_rci_storage0;
	pair_reference_a2 <= pair_reference_rci_storage1;
	pair_reference_b0 <= pair_reference_rci_storage2;
	pair_reference_b1 <= pair_reference_rci_storage3;
	pair_reference_b2 <= pair_reference_rci_storage4;
	pair_reference_z0r <= (pair_reference_z0_storage <<< 5'd23);
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
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[4:0])
			1'd0: begin
				pair_bus_dat_r <= pair_z03_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_z02_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_z01_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_z00_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_a13_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_a12_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_a11_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_a10_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_a23_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_a22_w;
			end
			4'd10: begin
				pair_bus_dat_r <= pair_a21_w;
			end
			4'd11: begin
				pair_bus_dat_r <= pair_a20_w;
			end
			4'd12: begin
				pair_bus_dat_r <= pair_b03_w;
			end
			4'd13: begin
				pair_bus_dat_r <= pair_b02_w;
			end
			4'd14: begin
				pair_bus_dat_r <= pair_b01_w;
			end
			4'd15: begin
				pair_bus_dat_r <= pair_b00_w;
			end
			5'd16: begin
				pair_bus_dat_r <= pair_b13_w;
			end
			5'd17: begin
				pair_bus_dat_r <= pair_b12_w;
			end
			5'd18: begin
				pair_bus_dat_r <= pair_b11_w;
			end
			5'd19: begin
				pair_bus_dat_r <= pair_b10_w;
			end
			5'd20: begin
				pair_bus_dat_r <= pair_b23_w;
			end
			5'd21: begin
				pair_bus_dat_r <= pair_b22_w;
			end
			5'd22: begin
				pair_bus_dat_r <= pair_b21_w;
			end
			5'd23: begin
				pair_bus_dat_r <= pair_b20_w;
			end
		endcase
	end
	if (pair_z03_re) begin
		pair_candidate_storage_full[26:24] <= pair_z03_r;
	end
	if (pair_z02_re) begin
		pair_candidate_storage_full[23:16] <= pair_z02_r;
	end
	if (pair_z01_re) begin
		pair_candidate_storage_full[15:8] <= pair_z01_r;
	end
	if (pair_z00_re) begin
		pair_candidate_storage_full[7:0] <= pair_z00_r;
	end
	pair_candidate_re <= pair_z00_re;
	if (pair_a13_re) begin
		pair_candidate_csrstorage0_storage_full[24] <= pair_a13_r;
	end
	if (pair_a12_re) begin
		pair_candidate_csrstorage0_storage_full[23:16] <= pair_a12_r;
	end
	if (pair_a11_re) begin
		pair_candidate_csrstorage0_storage_full[15:8] <= pair_a11_r;
	end
	if (pair_a10_re) begin
		pair_candidate_csrstorage0_storage_full[7:0] <= pair_a10_r;
	end
	pair_candidate_csrstorage0_re <= pair_a10_re;
	if (pair_a23_re) begin
		pair_candidate_csrstorage1_storage_full[24] <= pair_a23_r;
	end
	if (pair_a22_re) begin
		pair_candidate_csrstorage1_storage_full[23:16] <= pair_a22_r;
	end
	if (pair_a21_re) begin
		pair_candidate_csrstorage1_storage_full[15:8] <= pair_a21_r;
	end
	if (pair_a20_re) begin
		pair_candidate_csrstorage1_storage_full[7:0] <= pair_a20_r;
	end
	pair_candidate_csrstorage1_re <= pair_a20_re;
	if (pair_b03_re) begin
		pair_candidate_csrstorage2_storage_full[24] <= pair_b03_r;
	end
	if (pair_b02_re) begin
		pair_candidate_csrstorage2_storage_full[23:16] <= pair_b02_r;
	end
	if (pair_b01_re) begin
		pair_candidate_csrstorage2_storage_full[15:8] <= pair_b01_r;
	end
	if (pair_b00_re) begin
		pair_candidate_csrstorage2_storage_full[7:0] <= pair_b00_r;
	end
	pair_candidate_csrstorage2_re <= pair_b00_re;
	if (pair_b13_re) begin
		pair_candidate_csrstorage3_storage_full[24] <= pair_b13_r;
	end
	if (pair_b12_re) begin
		pair_candidate_csrstorage3_storage_full[23:16] <= pair_b12_r;
	end
	if (pair_b11_re) begin
		pair_candidate_csrstorage3_storage_full[15:8] <= pair_b11_r;
	end
	if (pair_b10_re) begin
		pair_candidate_csrstorage3_storage_full[7:0] <= pair_b10_r;
	end
	pair_candidate_csrstorage3_re <= pair_b10_re;
	if (pair_b23_re) begin
		pair_candidate_csrstorage4_storage_full[24] <= pair_b23_r;
	end
	if (pair_b22_re) begin
		pair_candidate_csrstorage4_storage_full[23:16] <= pair_b22_r;
	end
	if (pair_b21_re) begin
		pair_candidate_csrstorage4_storage_full[15:8] <= pair_b21_r;
	end
	if (pair_b20_re) begin
		pair_candidate_csrstorage4_storage_full[7:0] <= pair_b20_r;
	end
	pair_candidate_csrstorage4_re <= pair_b20_re;
	if (sys_rst) begin
		pair_candidate_y0 <= 25'sd0;
		pair_candidate_error <= 1'd0;
		pair_candidate_storage_full <= 27'd0;
		pair_candidate_re <= 1'd0;
		pair_candidate_a1 <= 25'sd0;
		pair_candidate_csrstorage0_storage_full <= 25'd0;
		pair_candidate_csrstorage0_re <= 1'd0;
		pair_candidate_a2 <= 25'sd0;
		pair_candidate_csrstorage1_storage_full <= 25'd0;
		pair_candidate_csrstorage1_re <= 1'd0;
		pair_candidate_b0 <= 25'sd0;
		pair_candidate_csrstorage2_storage_full <= 25'd0;
		pair_candidate_csrstorage2_re <= 1'd0;
		pair_candidate_b1 <= 25'sd0;
		pair_candidate_csrstorage3_storage_full <= 25'd0;
		pair_candidate_csrstorage3_re <= 1'd0;
		pair_candidate_b2 <= 25'sd0;
		pair_candidate_csrstorage4_storage_full <= 25'd0;
		pair_candidate_csrstorage4_re <= 1'd0;
		pair_candidate_z0r <= 50'sd0;
		pair_candidate_y1 <= 25'sd0;
		pair_candidate_zr0 <= 50'sd0;
		pair_candidate_zr_correction_q0 <= 4'sd0;
		pair_candidate_zr_low_q0 <= 17'd0;
		pair_candidate_zr_correction_q1 <= 4'sd0;
		pair_candidate_zr_low_q1 <= 17'd0;
		pair_candidate_zr_correction_q2 <= 4'sd0;
		pair_candidate_zr_low_q2 <= 17'd0;
		pair_candidate_zr_correction_q3 <= 4'sd0;
		pair_candidate_zr_low_q3 <= 17'd0;
		pair_reference_y0 <= 25'sd0;
		pair_reference_error <= 1'd0;
		pair_reference_a1 <= 25'sd0;
		pair_reference_a2 <= 25'sd0;
		pair_reference_b0 <= 25'sd0;
		pair_reference_b1 <= 25'sd0;
		pair_reference_b2 <= 25'sd0;
		pair_reference_z0r <= 50'sd0;
		pair_reference_y1 <= 25'sd0;
		pair_reference_zr0 <= 50'sd0;
		pair_reference_zr1 <= 50'sd0;
		pair_reference_zr2 <= 50'sd0;
		pair_reference_zr3 <= 50'sd0;
		pair_reference_zr4 <= 50'sd0;
		pair_bus_dat_r <= 8'd0;
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
	.A({{5{pair_candidate_b2[24]}}, pair_candidate_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_candidate_x[16:0]}),
	.BCIN(18'd0),
	.C(pair_candidate_zr0[47:0]),
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
	.P(pair_candidate_zr_low0),
	.PCOUT(pair_candidate_zr_cascade0)
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
	.A({{5{pair_candidate_b2[24]}}, pair_candidate_b2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_candidate_x[24]}}, pair_candidate_x[24:17]}),
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
	.PCIN(pair_candidate_zr_cascade0),
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
	.P(pair_candidate_zr_high_q0)
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
	.A({{5{pair_candidate_b1[24]}}, pair_candidate_b1}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_candidate_x[16:0]}),
	.BCIN(18'd0),
	.C(pair_candidate_zr_result0[47:0]),
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
	.P(pair_candidate_zr_low1),
	.PCOUT(pair_candidate_zr_cascade1)
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
	.A({{5{pair_candidate_b1[24]}}, pair_candidate_b1}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_candidate_x[24]}}, pair_candidate_x[24:17]}),
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
	.PCIN(pair_candidate_zr_cascade1),
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
	.P(pair_candidate_zr_high_q1)
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
	.A({{5{pair_candidate_b0[24]}}, pair_candidate_b0}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_candidate_x[16:0]}),
	.BCIN(18'd0),
	.C(pair_candidate_zr_result1[47:0]),
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
	.P(pair_candidate_zr_low2),
	.PCOUT(pair_candidate_zr_cascade2)
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
	.A({{5{pair_candidate_b0[24]}}, pair_candidate_b0}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_candidate_x[24]}}, pair_candidate_x[24:17]}),
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
	.PCIN(pair_candidate_zr_cascade2),
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
	.P(pair_candidate_zr_high_q2)
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
	.A({{5{pair_candidate_a2[24]}}, pair_candidate_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({1'd0, pair_candidate_y1[16:0]}),
	.BCIN(18'd0),
	.C(pair_candidate_zr_result2[47:0]),
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
	.P(pair_candidate_zr_low3),
	.PCOUT(pair_candidate_zr_cascade3)
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
	.A({{5{pair_candidate_a2[24]}}, pair_candidate_a2}),
	.ACIN(30'd0),
	.ALUMODE(4'd0),
	.B({{10{pair_candidate_y1[24]}}, pair_candidate_y1[24:17]}),
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
	.PCIN(pair_candidate_zr_cascade3),
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
	.P(pair_candidate_zr_high_q3)
);

endmodule
