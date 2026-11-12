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

wire signed [13:0] pair_iir_x;
wire signed [13:0] pair_iir_y0;
wire pair_iir_hold;
wire pair_iir_clear;
wire pair_iir_error;
reg [15:0] pair_iir_storage_full = 16'd0;
wire [15:0] pair_iir_storage;
reg pair_iir_re = 1'd0;
reg signed [13:0] pair_iir_a1 = 14'sd0;
reg [13:0] pair_iir_csrstorage0_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage0_storage;
reg pair_iir_csrstorage0_re = 1'd0;
reg signed [13:0] pair_iir_a2 = 14'sd0;
reg [13:0] pair_iir_csrstorage1_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage1_storage;
reg pair_iir_csrstorage1_re = 1'd0;
reg signed [13:0] pair_iir_a3 = 14'sd0;
reg [13:0] pair_iir_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage2_storage;
reg pair_iir_csrstorage2_re = 1'd0;
reg signed [13:0] pair_iir_a4 = 14'sd0;
reg [13:0] pair_iir_csrstorage3_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage3_storage;
reg pair_iir_csrstorage3_re = 1'd0;
reg signed [13:0] pair_iir_a5 = 14'sd0;
reg [13:0] pair_iir_csrstorage4_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage4_storage;
reg pair_iir_csrstorage4_re = 1'd0;
reg signed [13:0] pair_iir_b0 = 14'sd0;
reg [13:0] pair_iir_csrstorage5_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage5_storage;
reg pair_iir_csrstorage5_re = 1'd0;
reg signed [13:0] pair_iir_b1 = 14'sd0;
reg [13:0] pair_iir_csrstorage6_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage6_storage;
reg pair_iir_csrstorage6_re = 1'd0;
reg signed [13:0] pair_iir_b2 = 14'sd0;
reg [13:0] pair_iir_csrstorage7_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage7_storage;
reg pair_iir_csrstorage7_re = 1'd0;
reg signed [13:0] pair_iir_b3 = 14'sd0;
reg [13:0] pair_iir_csrstorage8_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage8_storage;
reg pair_iir_csrstorage8_re = 1'd0;
reg signed [13:0] pair_iir_b4 = 14'sd0;
reg [13:0] pair_iir_csrstorage9_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage9_storage;
reg pair_iir_csrstorage9_re = 1'd0;
reg signed [13:0] pair_iir_b5 = 14'sd0;
reg [13:0] pair_iir_csrstorage10_storage_full = 14'd0;
wire [13:0] pair_iir_csrstorage10_storage;
reg pair_iir_csrstorage10_re = 1'd0;
reg signed [27:0] pair_iir_z0r = 28'sd0;
reg signed [13:0] pair_iir_y_lim;
wire signed [27:0] pair_iir_y_next;
reg [2:0] pair_iir_y_pat = 3'd7;
reg signed [13:0] pair_iir_y1;
wire pair_iir_railed;
reg signed [13:0] pair_iir0 = 14'sd0;
reg signed [13:0] pair_iir_previous_feedback = 14'sd0;
reg pair_iir1 = 1'd0;
reg pair_iir2 = 1'd0;
reg signed [27:0] pair_iir_zr0 = 28'sd0;
wire signed [27:0] pair_iir_z0;
reg signed [27:0] pair_iir_zr1 = 28'sd0;
wire signed [27:0] pair_iir_z1;
reg signed [27:0] pair_iir_zr2 = 28'sd0;
wire signed [27:0] pair_iir_z2;
reg signed [27:0] pair_iir_zr3 = 28'sd0;
wire signed [27:0] pair_iir_z3;
reg signed [27:0] pair_iir_zr4 = 28'sd0;
wire signed [27:0] pair_iir_z4;
reg signed [27:0] pair_iir_zr5 = 28'sd0;
wire signed [27:0] pair_iir_z5;
reg signed [27:0] pair_iir_zr6 = 28'sd0;
wire signed [27:0] pair_iir_z6;
reg signed [27:0] pair_iir_zr7 = 28'sd0;
wire signed [27:0] pair_iir_z7;
reg signed [27:0] pair_iir_zr8 = 28'sd0;
wire signed [27:0] pair_iir_z8;
reg signed [27:0] pair_iir_zr9 = 28'sd0;
wire signed [27:0] pair_iir_z9;
reg signed [27:0] pair_iir_zr10 = 28'sd0;
wire signed [27:0] pair_iir_z10;
reg signed [27:0] pair_iir_raw_q = 28'sd0;
wire signed [13:0] pair_x;
reg signed [13:0] pair_y0 = 14'sd0;
wire pair_hold;
wire pair_clear;
reg pair_error = 1'd0;
reg [15:0] pair_storage_full = 16'd0;
wire [15:0] pair_storage;
reg pair_re = 1'd0;
reg signed [13:0] pair_a1 = 14'sd0;
reg [13:0] pair_csrstorage0_storage_full = 14'd0;
wire [13:0] pair_csrstorage0_storage;
reg pair_csrstorage0_re = 1'd0;
reg signed [13:0] pair_a2 = 14'sd0;
reg [13:0] pair_csrstorage1_storage_full = 14'd0;
wire [13:0] pair_csrstorage1_storage;
reg pair_csrstorage1_re = 1'd0;
reg signed [13:0] pair_a3 = 14'sd0;
reg [13:0] pair_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_csrstorage2_storage;
reg pair_csrstorage2_re = 1'd0;
reg signed [13:0] pair_a4 = 14'sd0;
reg [13:0] pair_csrstorage3_storage_full = 14'd0;
wire [13:0] pair_csrstorage3_storage;
reg pair_csrstorage3_re = 1'd0;
reg signed [13:0] pair_a5 = 14'sd0;
reg [13:0] pair_csrstorage4_storage_full = 14'd0;
wire [13:0] pair_csrstorage4_storage;
reg pair_csrstorage4_re = 1'd0;
reg signed [13:0] pair_b0 = 14'sd0;
reg [13:0] pair_csrstorage5_storage_full = 14'd0;
wire [13:0] pair_csrstorage5_storage;
reg pair_csrstorage5_re = 1'd0;
reg signed [13:0] pair_b1 = 14'sd0;
reg [13:0] pair_csrstorage6_storage_full = 14'd0;
wire [13:0] pair_csrstorage6_storage;
reg pair_csrstorage6_re = 1'd0;
reg signed [13:0] pair_b2 = 14'sd0;
reg [13:0] pair_csrstorage7_storage_full = 14'd0;
wire [13:0] pair_csrstorage7_storage;
reg pair_csrstorage7_re = 1'd0;
reg signed [13:0] pair_b3 = 14'sd0;
reg [13:0] pair_csrstorage8_storage_full = 14'd0;
wire [13:0] pair_csrstorage8_storage;
reg pair_csrstorage8_re = 1'd0;
reg signed [13:0] pair_b4 = 14'sd0;
reg [13:0] pair_csrstorage9_storage_full = 14'd0;
wire [13:0] pair_csrstorage9_storage;
reg pair_csrstorage9_re = 1'd0;
reg signed [13:0] pair_b5 = 14'sd0;
reg [13:0] pair_csrstorage10_storage_full = 14'd0;
wire [13:0] pair_csrstorage10_storage;
reg pair_csrstorage10_re = 1'd0;
reg signed [27:0] pair_z0r = 28'sd0;
reg signed [13:0] pair_y_lim;
wire signed [27:0] pair_y_next;
reg [2:0] pair_y_pat = 3'd7;
reg signed [13:0] pair_y1 = 14'sd0;
wire pair_railed;
reg signed [27:0] pair_zr0 = 28'sd0;
wire signed [27:0] pair_z0;
reg signed [27:0] pair_zr1 = 28'sd0;
wire signed [27:0] pair_z1;
reg signed [27:0] pair_zr2 = 28'sd0;
wire signed [27:0] pair_z2;
reg signed [27:0] pair_zr3 = 28'sd0;
wire signed [27:0] pair_z3;
reg signed [27:0] pair_zr4 = 28'sd0;
wire signed [27:0] pair_z4;
reg signed [27:0] pair_zr5 = 28'sd0;
wire signed [27:0] pair_z5;
reg signed [27:0] pair_zr6 = 28'sd0;
wire signed [27:0] pair_z6;
reg signed [27:0] pair_zr7 = 28'sd0;
wire signed [27:0] pair_z7;
reg signed [27:0] pair_zr8 = 28'sd0;
wire signed [27:0] pair_z8;
reg signed [27:0] pair_zr9 = 28'sd0;
wire signed [27:0] pair_z9;
reg signed [27:0] pair_zr10 = 28'sd0;
wire signed [27:0] pair_z10;
wire [13:0] pair_bank_bus_adr;
wire pair_bank_bus_we;
wire [7:0] pair_bank_bus_dat_w;
reg [7:0] pair_bank_bus_dat_r = 8'd0;
wire pair_bank_z01_re;
wire [7:0] pair_bank_z01_r;
wire [7:0] pair_bank_z01_w;
wire pair_bank_z00_re;
wire [7:0] pair_bank_z00_r;
wire [7:0] pair_bank_z00_w;
wire pair_bank_a11_re;
wire [5:0] pair_bank_a11_r;
wire [5:0] pair_bank_a11_w;
wire pair_bank_a10_re;
wire [7:0] pair_bank_a10_r;
wire [7:0] pair_bank_a10_w;
wire pair_bank_a21_re;
wire [5:0] pair_bank_a21_r;
wire [5:0] pair_bank_a21_w;
wire pair_bank_a20_re;
wire [7:0] pair_bank_a20_r;
wire [7:0] pair_bank_a20_w;
wire pair_bank_a31_re;
wire [5:0] pair_bank_a31_r;
wire [5:0] pair_bank_a31_w;
wire pair_bank_a30_re;
wire [7:0] pair_bank_a30_r;
wire [7:0] pair_bank_a30_w;
wire pair_bank_a41_re;
wire [5:0] pair_bank_a41_r;
wire [5:0] pair_bank_a41_w;
wire pair_bank_a40_re;
wire [7:0] pair_bank_a40_r;
wire [7:0] pair_bank_a40_w;
wire pair_bank_a51_re;
wire [5:0] pair_bank_a51_r;
wire [5:0] pair_bank_a51_w;
wire pair_bank_a50_re;
wire [7:0] pair_bank_a50_r;
wire [7:0] pair_bank_a50_w;
wire pair_bank_b01_re;
wire [5:0] pair_bank_b01_r;
wire [5:0] pair_bank_b01_w;
wire pair_bank_b00_re;
wire [7:0] pair_bank_b00_r;
wire [7:0] pair_bank_b00_w;
wire pair_bank_b11_re;
wire [5:0] pair_bank_b11_r;
wire [5:0] pair_bank_b11_w;
wire pair_bank_b10_re;
wire [7:0] pair_bank_b10_r;
wire [7:0] pair_bank_b10_w;
wire pair_bank_b21_re;
wire [5:0] pair_bank_b21_r;
wire [5:0] pair_bank_b21_w;
wire pair_bank_b20_re;
wire [7:0] pair_bank_b20_r;
wire [7:0] pair_bank_b20_w;
wire pair_bank_b31_re;
wire [5:0] pair_bank_b31_r;
wire [5:0] pair_bank_b31_w;
wire pair_bank_b30_re;
wire [7:0] pair_bank_b30_r;
wire [7:0] pair_bank_b30_w;
wire pair_bank_b41_re;
wire [5:0] pair_bank_b41_r;
wire [5:0] pair_bank_b41_w;
wire pair_bank_b40_re;
wire [7:0] pair_bank_b40_r;
wire [7:0] pair_bank_b40_w;
wire pair_bank_b51_re;
wire [5:0] pair_bank_b51_r;
wire [5:0] pair_bank_b51_w;
wire pair_bank_b50_re;
wire [7:0] pair_bank_b50_r;
wire [7:0] pair_bank_b50_w;
wire pair_bank_sel;
wire [13:0] pair_reference_bank_bus_adr;
wire pair_reference_bank_bus_we;
wire [7:0] pair_reference_bank_bus_dat_w;
reg [7:0] pair_reference_bank_bus_dat_r = 8'd0;
wire pair_reference_bank_z01_re;
wire [7:0] pair_reference_bank_z01_r;
wire [7:0] pair_reference_bank_z01_w;
wire pair_reference_bank_z00_re;
wire [7:0] pair_reference_bank_z00_r;
wire [7:0] pair_reference_bank_z00_w;
wire pair_reference_bank_a11_re;
wire [5:0] pair_reference_bank_a11_r;
wire [5:0] pair_reference_bank_a11_w;
wire pair_reference_bank_a10_re;
wire [7:0] pair_reference_bank_a10_r;
wire [7:0] pair_reference_bank_a10_w;
wire pair_reference_bank_a21_re;
wire [5:0] pair_reference_bank_a21_r;
wire [5:0] pair_reference_bank_a21_w;
wire pair_reference_bank_a20_re;
wire [7:0] pair_reference_bank_a20_r;
wire [7:0] pair_reference_bank_a20_w;
wire pair_reference_bank_a31_re;
wire [5:0] pair_reference_bank_a31_r;
wire [5:0] pair_reference_bank_a31_w;
wire pair_reference_bank_a30_re;
wire [7:0] pair_reference_bank_a30_r;
wire [7:0] pair_reference_bank_a30_w;
wire pair_reference_bank_a41_re;
wire [5:0] pair_reference_bank_a41_r;
wire [5:0] pair_reference_bank_a41_w;
wire pair_reference_bank_a40_re;
wire [7:0] pair_reference_bank_a40_r;
wire [7:0] pair_reference_bank_a40_w;
wire pair_reference_bank_a51_re;
wire [5:0] pair_reference_bank_a51_r;
wire [5:0] pair_reference_bank_a51_w;
wire pair_reference_bank_a50_re;
wire [7:0] pair_reference_bank_a50_r;
wire [7:0] pair_reference_bank_a50_w;
wire pair_reference_bank_b01_re;
wire [5:0] pair_reference_bank_b01_r;
wire [5:0] pair_reference_bank_b01_w;
wire pair_reference_bank_b00_re;
wire [7:0] pair_reference_bank_b00_r;
wire [7:0] pair_reference_bank_b00_w;
wire pair_reference_bank_b11_re;
wire [5:0] pair_reference_bank_b11_r;
wire [5:0] pair_reference_bank_b11_w;
wire pair_reference_bank_b10_re;
wire [7:0] pair_reference_bank_b10_r;
wire [7:0] pair_reference_bank_b10_w;
wire pair_reference_bank_b21_re;
wire [5:0] pair_reference_bank_b21_r;
wire [5:0] pair_reference_bank_b21_w;
wire pair_reference_bank_b20_re;
wire [7:0] pair_reference_bank_b20_r;
wire [7:0] pair_reference_bank_b20_w;
wire pair_reference_bank_b31_re;
wire [5:0] pair_reference_bank_b31_r;
wire [5:0] pair_reference_bank_b31_w;
wire pair_reference_bank_b30_re;
wire [7:0] pair_reference_bank_b30_r;
wire [7:0] pair_reference_bank_b30_w;
wire pair_reference_bank_b41_re;
wire [5:0] pair_reference_bank_b41_r;
wire [5:0] pair_reference_bank_b41_w;
wire pair_reference_bank_b40_re;
wire [7:0] pair_reference_bank_b40_r;
wire [7:0] pair_reference_bank_b40_w;
wire pair_reference_bank_b51_re;
wire [5:0] pair_reference_bank_b51_r;
wire [5:0] pair_reference_bank_b51_w;
wire pair_reference_bank_b50_re;
wire [7:0] pair_reference_bank_b50_r;
wire [7:0] pair_reference_bank_b50_w;
wire pair_reference_bank_sel;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_iir_x = x;
assign pair_x = x;
assign pair_iir_hold = hold;
assign pair_hold = hold;
assign pair_iir_clear = clear;
assign pair_clear = clear;
assign pair_reference_bank_bus_adr = csr_adr;
assign pair_reference_bank_bus_we = csr_we;
assign pair_reference_bank_bus_dat_w = csr_dat_w;
assign pair_bank_bus_adr = csr_adr;
assign pair_bank_bus_we = csr_we;
assign pair_bank_bus_dat_w = csr_dat_w;
assign ref_y = pair_y0;
assign cand_y = pair_iir_y0;
assign ref_error = pair_error;
assign cand_error = pair_iir_error;
assign read_value = pair_bank_bus_dat_r;
assign ref_coeff = {pair_b5, pair_b4, pair_b3, pair_b2, pair_b1, pair_b0, pair_a5, pair_a4, pair_a3, pair_a2, pair_a1};
assign cand_coeff = {pair_iir_b5, pair_iir_b4, pair_iir_b3, pair_iir_b2, pair_iir_b1, pair_iir_b0, pair_iir_a5, pair_iir_a4, pair_iir_a3, pair_iir_a2, pair_iir_a1};
assign cfg = {pair_iir_csrstorage10_storage, pair_iir_csrstorage9_storage, pair_iir_csrstorage8_storage, pair_iir_csrstorage7_storage, pair_iir_csrstorage6_storage, pair_iir_csrstorage5_storage, pair_iir_csrstorage4_storage, pair_iir_csrstorage3_storage, pair_iir_csrstorage2_storage, pair_iir_csrstorage1_storage, pair_iir_csrstorage0_storage, pair_iir_storage};
assign pair_iir_railed = (~((pair_iir_y_next[27:25] == $signed({1'd0, pair_iir_y_pat})) | (pair_iir_y_next[27:25] == $signed({1'd0, (~pair_iir_y_pat)}))));

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_iir_y_lim <= 14'sd0;
	if (pair_iir_railed) begin
		pair_iir_y_lim <= pair_iir0;
	end else begin
		pair_iir_y_lim <= pair_iir_y_next[27:12];
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_iir_error = pair_iir_railed;
assign pair_iir_y0 = pair_iir_y_lim;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_iir_y1 <= 14'sd0;
	if (pair_iir2) begin
		pair_iir_y1 <= 1'd0;
	end else begin
		if (pair_iir1) begin
			pair_iir_y1 <= pair_iir_previous_feedback;
		end else begin
			pair_iir_y1 <= pair_iir_y_lim;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_iir_z0 = (pair_iir_zr0 + (pair_iir_x * pair_iir_b5));
assign pair_iir_z1 = (pair_iir_zr1 + (pair_iir_x * pair_iir_b4));
assign pair_iir_z2 = (pair_iir_zr2 + (pair_iir_x * pair_iir_b3));
assign pair_iir_z3 = (pair_iir_zr3 + (pair_iir_x * pair_iir_b2));
assign pair_iir_z4 = (pair_iir_zr4 + (pair_iir_x * pair_iir_b1));
assign pair_iir_z5 = (pair_iir_zr5 + (pair_iir_x * pair_iir_b0));
assign pair_iir_z6 = (pair_iir_zr6 + (pair_iir_y1 * pair_iir_a5));
assign pair_iir_z7 = (pair_iir_zr7 + (pair_iir_y1 * pair_iir_a4));
assign pair_iir_z8 = (pair_iir_zr8 + (pair_iir_y1 * pair_iir_a3));
assign pair_iir_z9 = (pair_iir_zr9 + (pair_iir_y1 * pair_iir_a2));
assign pair_iir_z10 = (pair_iir_zr10 + (pair_iir_y1 * pair_iir_a1));
assign pair_iir_y_next = pair_iir_raw_q;
assign pair_railed = (~((pair_y_next[27:25] == $signed({1'd0, pair_y_pat})) | (pair_y_next[27:25] == $signed({1'd0, (~pair_y_pat)}))));

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_y_lim <= 14'sd0;
	if (pair_railed) begin
		pair_y_lim <= pair_y0;
	end else begin
		pair_y_lim <= pair_y_next[27:12];
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_z0 = (pair_zr0 + (pair_x * pair_b5));
assign pair_z1 = (pair_zr1 + (pair_x * pair_b4));
assign pair_z2 = (pair_zr2 + (pair_x * pair_b3));
assign pair_z3 = (pair_zr3 + (pair_x * pair_b2));
assign pair_z4 = (pair_zr4 + (pair_x * pair_b1));
assign pair_z5 = (pair_zr5 + (pair_x * pair_b0));
assign pair_z6 = (pair_zr6 + (pair_y1 * pair_a5));
assign pair_z7 = (pair_zr7 + (pair_y1 * pair_a4));
assign pair_z8 = (pair_zr8 + (pair_y1 * pair_a3));
assign pair_z9 = (pair_zr9 + (pair_y1 * pair_a2));
assign pair_z10 = (pair_zr10 + (pair_y1 * pair_a1));
assign pair_y_next = pair_z10;
assign pair_bank_sel = (pair_bank_bus_adr[13:9] == 1'd0);
assign pair_bank_z01_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_z01_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 1'd0));
assign pair_bank_z00_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_z00_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 1'd1));
assign pair_bank_a11_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a11_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 2'd2));
assign pair_bank_a10_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a10_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 2'd3));
assign pair_bank_a21_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a21_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 3'd4));
assign pair_bank_a20_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a20_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 3'd5));
assign pair_bank_a31_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a31_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 3'd6));
assign pair_bank_a30_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a30_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 3'd7));
assign pair_bank_a41_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a41_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd8));
assign pair_bank_a40_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a40_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd9));
assign pair_bank_a51_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a51_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd10));
assign pair_bank_a50_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a50_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd11));
assign pair_bank_b01_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b01_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd12));
assign pair_bank_b00_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b00_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd13));
assign pair_bank_b11_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b11_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd14));
assign pair_bank_b10_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b10_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 4'd15));
assign pair_bank_b21_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b21_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd16));
assign pair_bank_b20_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b20_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd17));
assign pair_bank_b31_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b31_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd18));
assign pair_bank_b30_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b30_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd19));
assign pair_bank_b41_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b41_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd20));
assign pair_bank_b40_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b40_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd21));
assign pair_bank_b51_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b51_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd22));
assign pair_bank_b50_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b50_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[4:0] == 5'd23));
assign pair_iir_storage = pair_iir_storage_full[15:0];
assign pair_bank_z01_w = pair_iir_storage_full[15:8];
assign pair_bank_z00_w = pair_iir_storage_full[7:0];
assign pair_iir_csrstorage0_storage = pair_iir_csrstorage0_storage_full[13:0];
assign pair_bank_a11_w = pair_iir_csrstorage0_storage_full[13:8];
assign pair_bank_a10_w = pair_iir_csrstorage0_storage_full[7:0];
assign pair_iir_csrstorage1_storage = pair_iir_csrstorage1_storage_full[13:0];
assign pair_bank_a21_w = pair_iir_csrstorage1_storage_full[13:8];
assign pair_bank_a20_w = pair_iir_csrstorage1_storage_full[7:0];
assign pair_iir_csrstorage2_storage = pair_iir_csrstorage2_storage_full[13:0];
assign pair_bank_a31_w = pair_iir_csrstorage2_storage_full[13:8];
assign pair_bank_a30_w = pair_iir_csrstorage2_storage_full[7:0];
assign pair_iir_csrstorage3_storage = pair_iir_csrstorage3_storage_full[13:0];
assign pair_bank_a41_w = pair_iir_csrstorage3_storage_full[13:8];
assign pair_bank_a40_w = pair_iir_csrstorage3_storage_full[7:0];
assign pair_iir_csrstorage4_storage = pair_iir_csrstorage4_storage_full[13:0];
assign pair_bank_a51_w = pair_iir_csrstorage4_storage_full[13:8];
assign pair_bank_a50_w = pair_iir_csrstorage4_storage_full[7:0];
assign pair_iir_csrstorage5_storage = pair_iir_csrstorage5_storage_full[13:0];
assign pair_bank_b01_w = pair_iir_csrstorage5_storage_full[13:8];
assign pair_bank_b00_w = pair_iir_csrstorage5_storage_full[7:0];
assign pair_iir_csrstorage6_storage = pair_iir_csrstorage6_storage_full[13:0];
assign pair_bank_b11_w = pair_iir_csrstorage6_storage_full[13:8];
assign pair_bank_b10_w = pair_iir_csrstorage6_storage_full[7:0];
assign pair_iir_csrstorage7_storage = pair_iir_csrstorage7_storage_full[13:0];
assign pair_bank_b21_w = pair_iir_csrstorage7_storage_full[13:8];
assign pair_bank_b20_w = pair_iir_csrstorage7_storage_full[7:0];
assign pair_iir_csrstorage8_storage = pair_iir_csrstorage8_storage_full[13:0];
assign pair_bank_b31_w = pair_iir_csrstorage8_storage_full[13:8];
assign pair_bank_b30_w = pair_iir_csrstorage8_storage_full[7:0];
assign pair_iir_csrstorage9_storage = pair_iir_csrstorage9_storage_full[13:0];
assign pair_bank_b41_w = pair_iir_csrstorage9_storage_full[13:8];
assign pair_bank_b40_w = pair_iir_csrstorage9_storage_full[7:0];
assign pair_iir_csrstorage10_storage = pair_iir_csrstorage10_storage_full[13:0];
assign pair_bank_b51_w = pair_iir_csrstorage10_storage_full[13:8];
assign pair_bank_b50_w = pair_iir_csrstorage10_storage_full[7:0];
assign pair_reference_bank_sel = (pair_reference_bank_bus_adr[13:9] == 1'd0);
assign pair_reference_bank_z01_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_z01_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 1'd0));
assign pair_reference_bank_z00_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_z00_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 1'd1));
assign pair_reference_bank_a11_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a11_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 2'd2));
assign pair_reference_bank_a10_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a10_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 2'd3));
assign pair_reference_bank_a21_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a21_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 3'd4));
assign pair_reference_bank_a20_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a20_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 3'd5));
assign pair_reference_bank_a31_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a31_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 3'd6));
assign pair_reference_bank_a30_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a30_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 3'd7));
assign pair_reference_bank_a41_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a41_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd8));
assign pair_reference_bank_a40_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a40_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd9));
assign pair_reference_bank_a51_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a51_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd10));
assign pair_reference_bank_a50_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a50_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd11));
assign pair_reference_bank_b01_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b01_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd12));
assign pair_reference_bank_b00_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b00_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd13));
assign pair_reference_bank_b11_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b11_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd14));
assign pair_reference_bank_b10_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b10_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 4'd15));
assign pair_reference_bank_b21_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b21_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd16));
assign pair_reference_bank_b20_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b20_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd17));
assign pair_reference_bank_b31_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b31_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd18));
assign pair_reference_bank_b30_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b30_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd19));
assign pair_reference_bank_b41_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b41_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd20));
assign pair_reference_bank_b40_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b40_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd21));
assign pair_reference_bank_b51_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b51_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd22));
assign pair_reference_bank_b50_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b50_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[4:0] == 5'd23));
assign pair_storage = pair_storage_full[15:0];
assign pair_reference_bank_z01_w = pair_storage_full[15:8];
assign pair_reference_bank_z00_w = pair_storage_full[7:0];
assign pair_csrstorage0_storage = pair_csrstorage0_storage_full[13:0];
assign pair_reference_bank_a11_w = pair_csrstorage0_storage_full[13:8];
assign pair_reference_bank_a10_w = pair_csrstorage0_storage_full[7:0];
assign pair_csrstorage1_storage = pair_csrstorage1_storage_full[13:0];
assign pair_reference_bank_a21_w = pair_csrstorage1_storage_full[13:8];
assign pair_reference_bank_a20_w = pair_csrstorage1_storage_full[7:0];
assign pair_csrstorage2_storage = pair_csrstorage2_storage_full[13:0];
assign pair_reference_bank_a31_w = pair_csrstorage2_storage_full[13:8];
assign pair_reference_bank_a30_w = pair_csrstorage2_storage_full[7:0];
assign pair_csrstorage3_storage = pair_csrstorage3_storage_full[13:0];
assign pair_reference_bank_a41_w = pair_csrstorage3_storage_full[13:8];
assign pair_reference_bank_a40_w = pair_csrstorage3_storage_full[7:0];
assign pair_csrstorage4_storage = pair_csrstorage4_storage_full[13:0];
assign pair_reference_bank_a51_w = pair_csrstorage4_storage_full[13:8];
assign pair_reference_bank_a50_w = pair_csrstorage4_storage_full[7:0];
assign pair_csrstorage5_storage = pair_csrstorage5_storage_full[13:0];
assign pair_reference_bank_b01_w = pair_csrstorage5_storage_full[13:8];
assign pair_reference_bank_b00_w = pair_csrstorage5_storage_full[7:0];
assign pair_csrstorage6_storage = pair_csrstorage6_storage_full[13:0];
assign pair_reference_bank_b11_w = pair_csrstorage6_storage_full[13:8];
assign pair_reference_bank_b10_w = pair_csrstorage6_storage_full[7:0];
assign pair_csrstorage7_storage = pair_csrstorage7_storage_full[13:0];
assign pair_reference_bank_b21_w = pair_csrstorage7_storage_full[13:8];
assign pair_reference_bank_b20_w = pair_csrstorage7_storage_full[7:0];
assign pair_csrstorage8_storage = pair_csrstorage8_storage_full[13:0];
assign pair_reference_bank_b31_w = pair_csrstorage8_storage_full[13:8];
assign pair_reference_bank_b30_w = pair_csrstorage8_storage_full[7:0];
assign pair_csrstorage9_storage = pair_csrstorage9_storage_full[13:0];
assign pair_reference_bank_b41_w = pair_csrstorage9_storage_full[13:8];
assign pair_reference_bank_b40_w = pair_csrstorage9_storage_full[7:0];
assign pair_csrstorage10_storage = pair_csrstorage10_storage_full[13:0];
assign pair_reference_bank_b51_w = pair_csrstorage10_storage_full[13:8];
assign pair_reference_bank_b50_w = pair_csrstorage10_storage_full[7:0];

always @(posedge sys_clk) begin
	pair_iir_a1 <= pair_iir_csrstorage0_storage;
	pair_iir_a2 <= pair_iir_csrstorage1_storage;
	pair_iir_a3 <= pair_iir_csrstorage2_storage;
	pair_iir_a4 <= pair_iir_csrstorage3_storage;
	pair_iir_a5 <= pair_iir_csrstorage4_storage;
	pair_iir_b0 <= pair_iir_csrstorage5_storage;
	pair_iir_b1 <= pair_iir_csrstorage6_storage;
	pair_iir_b2 <= pair_iir_csrstorage7_storage;
	pair_iir_b3 <= pair_iir_csrstorage8_storage;
	pair_iir_b4 <= pair_iir_csrstorage9_storage;
	pair_iir_b5 <= pair_iir_csrstorage10_storage;
	pair_iir_z0r <= (pair_iir_storage <<< 4'd12);
	pair_iir0 <= pair_iir_y0;
	pair_iir_previous_feedback <= pair_iir_y1;
	pair_iir1 <= pair_iir_hold;
	pair_iir2 <= pair_iir_clear;
	pair_iir_zr0 <= pair_iir_z0r;
	pair_iir_zr1 <= pair_iir_z0;
	pair_iir_zr2 <= pair_iir_z1;
	pair_iir_zr3 <= pair_iir_z2;
	pair_iir_zr4 <= pair_iir_z3;
	pair_iir_zr5 <= pair_iir_z4;
	pair_iir_zr6 <= pair_iir_z5;
	pair_iir_zr7 <= pair_iir_z6;
	pair_iir_zr8 <= pair_iir_z7;
	pair_iir_zr9 <= pair_iir_z8;
	pair_iir_zr10 <= pair_iir_z9;
	pair_iir_raw_q <= pair_iir_z10;
	pair_a1 <= pair_csrstorage0_storage;
	pair_a2 <= pair_csrstorage1_storage;
	pair_a3 <= pair_csrstorage2_storage;
	pair_a4 <= pair_csrstorage3_storage;
	pair_a5 <= pair_csrstorage4_storage;
	pair_b0 <= pair_csrstorage5_storage;
	pair_b1 <= pair_csrstorage6_storage;
	pair_b2 <= pair_csrstorage7_storage;
	pair_b3 <= pair_csrstorage8_storage;
	pair_b4 <= pair_csrstorage9_storage;
	pair_b5 <= pair_csrstorage10_storage;
	pair_z0r <= (pair_storage <<< 4'd12);
	pair_error <= pair_railed;
	pair_y0 <= pair_y_lim;
	if (pair_clear) begin
		pair_y1 <= 1'd0;
	end else begin
		if ((~pair_hold)) begin
			pair_y1 <= pair_y_lim;
		end
	end
	pair_zr0 <= pair_z0r;
	pair_zr1 <= pair_z0;
	pair_zr2 <= pair_z1;
	pair_zr3 <= pair_z2;
	pair_zr4 <= pair_z3;
	pair_zr5 <= pair_z4;
	pair_zr6 <= pair_z5;
	pair_zr7 <= pair_z6;
	pair_zr8 <= pair_z7;
	pair_zr9 <= pair_z8;
	pair_zr10 <= pair_z9;
	pair_bank_bus_dat_r <= 1'd0;
	if (pair_bank_sel) begin
		case (pair_bank_bus_adr[4:0])
			1'd0: begin
				pair_bank_bus_dat_r <= pair_bank_z01_w;
			end
			1'd1: begin
				pair_bank_bus_dat_r <= pair_bank_z00_w;
			end
			2'd2: begin
				pair_bank_bus_dat_r <= pair_bank_a11_w;
			end
			2'd3: begin
				pair_bank_bus_dat_r <= pair_bank_a10_w;
			end
			3'd4: begin
				pair_bank_bus_dat_r <= pair_bank_a21_w;
			end
			3'd5: begin
				pair_bank_bus_dat_r <= pair_bank_a20_w;
			end
			3'd6: begin
				pair_bank_bus_dat_r <= pair_bank_a31_w;
			end
			3'd7: begin
				pair_bank_bus_dat_r <= pair_bank_a30_w;
			end
			4'd8: begin
				pair_bank_bus_dat_r <= pair_bank_a41_w;
			end
			4'd9: begin
				pair_bank_bus_dat_r <= pair_bank_a40_w;
			end
			4'd10: begin
				pair_bank_bus_dat_r <= pair_bank_a51_w;
			end
			4'd11: begin
				pair_bank_bus_dat_r <= pair_bank_a50_w;
			end
			4'd12: begin
				pair_bank_bus_dat_r <= pair_bank_b01_w;
			end
			4'd13: begin
				pair_bank_bus_dat_r <= pair_bank_b00_w;
			end
			4'd14: begin
				pair_bank_bus_dat_r <= pair_bank_b11_w;
			end
			4'd15: begin
				pair_bank_bus_dat_r <= pair_bank_b10_w;
			end
			5'd16: begin
				pair_bank_bus_dat_r <= pair_bank_b21_w;
			end
			5'd17: begin
				pair_bank_bus_dat_r <= pair_bank_b20_w;
			end
			5'd18: begin
				pair_bank_bus_dat_r <= pair_bank_b31_w;
			end
			5'd19: begin
				pair_bank_bus_dat_r <= pair_bank_b30_w;
			end
			5'd20: begin
				pair_bank_bus_dat_r <= pair_bank_b41_w;
			end
			5'd21: begin
				pair_bank_bus_dat_r <= pair_bank_b40_w;
			end
			5'd22: begin
				pair_bank_bus_dat_r <= pair_bank_b51_w;
			end
			5'd23: begin
				pair_bank_bus_dat_r <= pair_bank_b50_w;
			end
		endcase
	end
	if (pair_bank_z01_re) begin
		pair_iir_storage_full[15:8] <= pair_bank_z01_r;
	end
	if (pair_bank_z00_re) begin
		pair_iir_storage_full[7:0] <= pair_bank_z00_r;
	end
	pair_iir_re <= pair_bank_z00_re;
	if (pair_bank_a11_re) begin
		pair_iir_csrstorage0_storage_full[13:8] <= pair_bank_a11_r;
	end
	if (pair_bank_a10_re) begin
		pair_iir_csrstorage0_storage_full[7:0] <= pair_bank_a10_r;
	end
	pair_iir_csrstorage0_re <= pair_bank_a10_re;
	if (pair_bank_a21_re) begin
		pair_iir_csrstorage1_storage_full[13:8] <= pair_bank_a21_r;
	end
	if (pair_bank_a20_re) begin
		pair_iir_csrstorage1_storage_full[7:0] <= pair_bank_a20_r;
	end
	pair_iir_csrstorage1_re <= pair_bank_a20_re;
	if (pair_bank_a31_re) begin
		pair_iir_csrstorage2_storage_full[13:8] <= pair_bank_a31_r;
	end
	if (pair_bank_a30_re) begin
		pair_iir_csrstorage2_storage_full[7:0] <= pair_bank_a30_r;
	end
	pair_iir_csrstorage2_re <= pair_bank_a30_re;
	if (pair_bank_a41_re) begin
		pair_iir_csrstorage3_storage_full[13:8] <= pair_bank_a41_r;
	end
	if (pair_bank_a40_re) begin
		pair_iir_csrstorage3_storage_full[7:0] <= pair_bank_a40_r;
	end
	pair_iir_csrstorage3_re <= pair_bank_a40_re;
	if (pair_bank_a51_re) begin
		pair_iir_csrstorage4_storage_full[13:8] <= pair_bank_a51_r;
	end
	if (pair_bank_a50_re) begin
		pair_iir_csrstorage4_storage_full[7:0] <= pair_bank_a50_r;
	end
	pair_iir_csrstorage4_re <= pair_bank_a50_re;
	if (pair_bank_b01_re) begin
		pair_iir_csrstorage5_storage_full[13:8] <= pair_bank_b01_r;
	end
	if (pair_bank_b00_re) begin
		pair_iir_csrstorage5_storage_full[7:0] <= pair_bank_b00_r;
	end
	pair_iir_csrstorage5_re <= pair_bank_b00_re;
	if (pair_bank_b11_re) begin
		pair_iir_csrstorage6_storage_full[13:8] <= pair_bank_b11_r;
	end
	if (pair_bank_b10_re) begin
		pair_iir_csrstorage6_storage_full[7:0] <= pair_bank_b10_r;
	end
	pair_iir_csrstorage6_re <= pair_bank_b10_re;
	if (pair_bank_b21_re) begin
		pair_iir_csrstorage7_storage_full[13:8] <= pair_bank_b21_r;
	end
	if (pair_bank_b20_re) begin
		pair_iir_csrstorage7_storage_full[7:0] <= pair_bank_b20_r;
	end
	pair_iir_csrstorage7_re <= pair_bank_b20_re;
	if (pair_bank_b31_re) begin
		pair_iir_csrstorage8_storage_full[13:8] <= pair_bank_b31_r;
	end
	if (pair_bank_b30_re) begin
		pair_iir_csrstorage8_storage_full[7:0] <= pair_bank_b30_r;
	end
	pair_iir_csrstorage8_re <= pair_bank_b30_re;
	if (pair_bank_b41_re) begin
		pair_iir_csrstorage9_storage_full[13:8] <= pair_bank_b41_r;
	end
	if (pair_bank_b40_re) begin
		pair_iir_csrstorage9_storage_full[7:0] <= pair_bank_b40_r;
	end
	pair_iir_csrstorage9_re <= pair_bank_b40_re;
	if (pair_bank_b51_re) begin
		pair_iir_csrstorage10_storage_full[13:8] <= pair_bank_b51_r;
	end
	if (pair_bank_b50_re) begin
		pair_iir_csrstorage10_storage_full[7:0] <= pair_bank_b50_r;
	end
	pair_iir_csrstorage10_re <= pair_bank_b50_re;
	pair_reference_bank_bus_dat_r <= 1'd0;
	if (pair_reference_bank_sel) begin
		case (pair_reference_bank_bus_adr[4:0])
			1'd0: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_z01_w;
			end
			1'd1: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_z00_w;
			end
			2'd2: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a11_w;
			end
			2'd3: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a10_w;
			end
			3'd4: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a21_w;
			end
			3'd5: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a20_w;
			end
			3'd6: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a31_w;
			end
			3'd7: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a30_w;
			end
			4'd8: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a41_w;
			end
			4'd9: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a40_w;
			end
			4'd10: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a51_w;
			end
			4'd11: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_a50_w;
			end
			4'd12: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b01_w;
			end
			4'd13: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b00_w;
			end
			4'd14: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b11_w;
			end
			4'd15: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b10_w;
			end
			5'd16: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b21_w;
			end
			5'd17: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b20_w;
			end
			5'd18: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b31_w;
			end
			5'd19: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b30_w;
			end
			5'd20: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b41_w;
			end
			5'd21: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b40_w;
			end
			5'd22: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b51_w;
			end
			5'd23: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b50_w;
			end
		endcase
	end
	if (pair_reference_bank_z01_re) begin
		pair_storage_full[15:8] <= pair_reference_bank_z01_r;
	end
	if (pair_reference_bank_z00_re) begin
		pair_storage_full[7:0] <= pair_reference_bank_z00_r;
	end
	pair_re <= pair_reference_bank_z00_re;
	if (pair_reference_bank_a11_re) begin
		pair_csrstorage0_storage_full[13:8] <= pair_reference_bank_a11_r;
	end
	if (pair_reference_bank_a10_re) begin
		pair_csrstorage0_storage_full[7:0] <= pair_reference_bank_a10_r;
	end
	pair_csrstorage0_re <= pair_reference_bank_a10_re;
	if (pair_reference_bank_a21_re) begin
		pair_csrstorage1_storage_full[13:8] <= pair_reference_bank_a21_r;
	end
	if (pair_reference_bank_a20_re) begin
		pair_csrstorage1_storage_full[7:0] <= pair_reference_bank_a20_r;
	end
	pair_csrstorage1_re <= pair_reference_bank_a20_re;
	if (pair_reference_bank_a31_re) begin
		pair_csrstorage2_storage_full[13:8] <= pair_reference_bank_a31_r;
	end
	if (pair_reference_bank_a30_re) begin
		pair_csrstorage2_storage_full[7:0] <= pair_reference_bank_a30_r;
	end
	pair_csrstorage2_re <= pair_reference_bank_a30_re;
	if (pair_reference_bank_a41_re) begin
		pair_csrstorage3_storage_full[13:8] <= pair_reference_bank_a41_r;
	end
	if (pair_reference_bank_a40_re) begin
		pair_csrstorage3_storage_full[7:0] <= pair_reference_bank_a40_r;
	end
	pair_csrstorage3_re <= pair_reference_bank_a40_re;
	if (pair_reference_bank_a51_re) begin
		pair_csrstorage4_storage_full[13:8] <= pair_reference_bank_a51_r;
	end
	if (pair_reference_bank_a50_re) begin
		pair_csrstorage4_storage_full[7:0] <= pair_reference_bank_a50_r;
	end
	pair_csrstorage4_re <= pair_reference_bank_a50_re;
	if (pair_reference_bank_b01_re) begin
		pair_csrstorage5_storage_full[13:8] <= pair_reference_bank_b01_r;
	end
	if (pair_reference_bank_b00_re) begin
		pair_csrstorage5_storage_full[7:0] <= pair_reference_bank_b00_r;
	end
	pair_csrstorage5_re <= pair_reference_bank_b00_re;
	if (pair_reference_bank_b11_re) begin
		pair_csrstorage6_storage_full[13:8] <= pair_reference_bank_b11_r;
	end
	if (pair_reference_bank_b10_re) begin
		pair_csrstorage6_storage_full[7:0] <= pair_reference_bank_b10_r;
	end
	pair_csrstorage6_re <= pair_reference_bank_b10_re;
	if (pair_reference_bank_b21_re) begin
		pair_csrstorage7_storage_full[13:8] <= pair_reference_bank_b21_r;
	end
	if (pair_reference_bank_b20_re) begin
		pair_csrstorage7_storage_full[7:0] <= pair_reference_bank_b20_r;
	end
	pair_csrstorage7_re <= pair_reference_bank_b20_re;
	if (pair_reference_bank_b31_re) begin
		pair_csrstorage8_storage_full[13:8] <= pair_reference_bank_b31_r;
	end
	if (pair_reference_bank_b30_re) begin
		pair_csrstorage8_storage_full[7:0] <= pair_reference_bank_b30_r;
	end
	pair_csrstorage8_re <= pair_reference_bank_b30_re;
	if (pair_reference_bank_b41_re) begin
		pair_csrstorage9_storage_full[13:8] <= pair_reference_bank_b41_r;
	end
	if (pair_reference_bank_b40_re) begin
		pair_csrstorage9_storage_full[7:0] <= pair_reference_bank_b40_r;
	end
	pair_csrstorage9_re <= pair_reference_bank_b40_re;
	if (pair_reference_bank_b51_re) begin
		pair_csrstorage10_storage_full[13:8] <= pair_reference_bank_b51_r;
	end
	if (pair_reference_bank_b50_re) begin
		pair_csrstorage10_storage_full[7:0] <= pair_reference_bank_b50_r;
	end
	pair_csrstorage10_re <= pair_reference_bank_b50_re;
	if (sys_rst) begin
		pair_iir_storage_full <= 16'd0;
		pair_iir_re <= 1'd0;
		pair_iir_a1 <= 14'sd0;
		pair_iir_csrstorage0_storage_full <= 14'd0;
		pair_iir_csrstorage0_re <= 1'd0;
		pair_iir_a2 <= 14'sd0;
		pair_iir_csrstorage1_storage_full <= 14'd0;
		pair_iir_csrstorage1_re <= 1'd0;
		pair_iir_a3 <= 14'sd0;
		pair_iir_csrstorage2_storage_full <= 14'd0;
		pair_iir_csrstorage2_re <= 1'd0;
		pair_iir_a4 <= 14'sd0;
		pair_iir_csrstorage3_storage_full <= 14'd0;
		pair_iir_csrstorage3_re <= 1'd0;
		pair_iir_a5 <= 14'sd0;
		pair_iir_csrstorage4_storage_full <= 14'd0;
		pair_iir_csrstorage4_re <= 1'd0;
		pair_iir_b0 <= 14'sd0;
		pair_iir_csrstorage5_storage_full <= 14'd0;
		pair_iir_csrstorage5_re <= 1'd0;
		pair_iir_b1 <= 14'sd0;
		pair_iir_csrstorage6_storage_full <= 14'd0;
		pair_iir_csrstorage6_re <= 1'd0;
		pair_iir_b2 <= 14'sd0;
		pair_iir_csrstorage7_storage_full <= 14'd0;
		pair_iir_csrstorage7_re <= 1'd0;
		pair_iir_b3 <= 14'sd0;
		pair_iir_csrstorage8_storage_full <= 14'd0;
		pair_iir_csrstorage8_re <= 1'd0;
		pair_iir_b4 <= 14'sd0;
		pair_iir_csrstorage9_storage_full <= 14'd0;
		pair_iir_csrstorage9_re <= 1'd0;
		pair_iir_b5 <= 14'sd0;
		pair_iir_csrstorage10_storage_full <= 14'd0;
		pair_iir_csrstorage10_re <= 1'd0;
		pair_iir_z0r <= 28'sd0;
		pair_iir0 <= 14'sd0;
		pair_iir_previous_feedback <= 14'sd0;
		pair_iir1 <= 1'd0;
		pair_iir2 <= 1'd0;
		pair_iir_zr0 <= 28'sd0;
		pair_iir_zr1 <= 28'sd0;
		pair_iir_zr2 <= 28'sd0;
		pair_iir_zr3 <= 28'sd0;
		pair_iir_zr4 <= 28'sd0;
		pair_iir_zr5 <= 28'sd0;
		pair_iir_zr6 <= 28'sd0;
		pair_iir_zr7 <= 28'sd0;
		pair_iir_zr8 <= 28'sd0;
		pair_iir_zr9 <= 28'sd0;
		pair_iir_zr10 <= 28'sd0;
		pair_iir_raw_q <= 28'sd0;
		pair_y0 <= 14'sd0;
		pair_error <= 1'd0;
		pair_storage_full <= 16'd0;
		pair_re <= 1'd0;
		pair_a1 <= 14'sd0;
		pair_csrstorage0_storage_full <= 14'd0;
		pair_csrstorage0_re <= 1'd0;
		pair_a2 <= 14'sd0;
		pair_csrstorage1_storage_full <= 14'd0;
		pair_csrstorage1_re <= 1'd0;
		pair_a3 <= 14'sd0;
		pair_csrstorage2_storage_full <= 14'd0;
		pair_csrstorage2_re <= 1'd0;
		pair_a4 <= 14'sd0;
		pair_csrstorage3_storage_full <= 14'd0;
		pair_csrstorage3_re <= 1'd0;
		pair_a5 <= 14'sd0;
		pair_csrstorage4_storage_full <= 14'd0;
		pair_csrstorage4_re <= 1'd0;
		pair_b0 <= 14'sd0;
		pair_csrstorage5_storage_full <= 14'd0;
		pair_csrstorage5_re <= 1'd0;
		pair_b1 <= 14'sd0;
		pair_csrstorage6_storage_full <= 14'd0;
		pair_csrstorage6_re <= 1'd0;
		pair_b2 <= 14'sd0;
		pair_csrstorage7_storage_full <= 14'd0;
		pair_csrstorage7_re <= 1'd0;
		pair_b3 <= 14'sd0;
		pair_csrstorage8_storage_full <= 14'd0;
		pair_csrstorage8_re <= 1'd0;
		pair_b4 <= 14'sd0;
		pair_csrstorage9_storage_full <= 14'd0;
		pair_csrstorage9_re <= 1'd0;
		pair_b5 <= 14'sd0;
		pair_csrstorage10_storage_full <= 14'd0;
		pair_csrstorage10_re <= 1'd0;
		pair_z0r <= 28'sd0;
		pair_y1 <= 14'sd0;
		pair_zr0 <= 28'sd0;
		pair_zr1 <= 28'sd0;
		pair_zr2 <= 28'sd0;
		pair_zr3 <= 28'sd0;
		pair_zr4 <= 28'sd0;
		pair_zr5 <= 28'sd0;
		pair_zr6 <= 28'sd0;
		pair_zr7 <= 28'sd0;
		pair_zr8 <= 28'sd0;
		pair_zr9 <= 28'sd0;
		pair_zr10 <= 28'sd0;
		pair_bank_bus_dat_r <= 8'd0;
		pair_reference_bank_bus_dat_r <= 8'd0;
	end
end

endmodule
