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
	output [69:0] ref_coeff,
	output [69:0] cand_coeff,
	output [85:0] cfg
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
reg signed [13:0] pair_candidate_a2 = 14'sd0;
reg [13:0] pair_candidate_csrstorage1_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage1_storage;
reg pair_candidate_csrstorage1_re = 1'd0;
reg signed [13:0] pair_candidate_b0 = 14'sd0;
reg [13:0] pair_candidate_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage2_storage;
reg pair_candidate_csrstorage2_re = 1'd0;
reg signed [13:0] pair_candidate_b1 = 14'sd0;
reg [13:0] pair_candidate_csrstorage3_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage3_storage;
reg pair_candidate_csrstorage3_re = 1'd0;
reg signed [13:0] pair_candidate_b2 = 14'sd0;
reg [13:0] pair_candidate_csrstorage4_storage_full = 14'd0;
wire [13:0] pair_candidate_csrstorage4_storage;
reg pair_candidate_csrstorage4_re = 1'd0;
reg signed [27:0] pair_candidate_z0r = 28'sd0;
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
wire signed [13:0] pair_reference_x;
reg signed [13:0] pair_reference_y0 = 14'sd0;
wire pair_reference_hold;
wire pair_reference_clear;
reg pair_reference_error = 1'd0;
reg [15:0] pair_reference_storage_full = 16'd0;
wire [15:0] pair_reference_storage;
reg pair_reference_re = 1'd0;
reg signed [13:0] pair_reference_a1 = 14'sd0;
reg [13:0] pair_reference_csrstorage0_storage_full = 14'd0;
wire [13:0] pair_reference_csrstorage0_storage;
reg pair_reference_csrstorage0_re = 1'd0;
reg signed [13:0] pair_reference_a2 = 14'sd0;
reg [13:0] pair_reference_csrstorage1_storage_full = 14'd0;
wire [13:0] pair_reference_csrstorage1_storage;
reg pair_reference_csrstorage1_re = 1'd0;
reg signed [13:0] pair_reference_b0 = 14'sd0;
reg [13:0] pair_reference_csrstorage2_storage_full = 14'd0;
wire [13:0] pair_reference_csrstorage2_storage;
reg pair_reference_csrstorage2_re = 1'd0;
reg signed [13:0] pair_reference_b1 = 14'sd0;
reg [13:0] pair_reference_csrstorage3_storage_full = 14'd0;
wire [13:0] pair_reference_csrstorage3_storage;
reg pair_reference_csrstorage3_re = 1'd0;
reg signed [13:0] pair_reference_b2 = 14'sd0;
reg [13:0] pair_reference_csrstorage4_storage_full = 14'd0;
wire [13:0] pair_reference_csrstorage4_storage;
reg pair_reference_csrstorage4_re = 1'd0;
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
wire pair_reference_bank_sel;

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
assign pair_reference_bank_bus_adr = csr_adr;
assign pair_reference_bank_bus_we = csr_we;
assign pair_reference_bank_bus_dat_w = csr_dat_w;
assign pair_bank_bus_adr = csr_adr;
assign pair_bank_bus_we = csr_we;
assign pair_bank_bus_dat_w = csr_dat_w;
assign ref_y = pair_reference_y0;
assign cand_y = pair_candidate_y0;
assign ref_error = pair_reference_error;
assign cand_error = pair_candidate_error;
assign read_value = pair_bank_bus_dat_r;
assign ref_coeff = {pair_reference_b2, pair_reference_b1, pair_reference_b0, pair_reference_a2, pair_reference_a1};
assign cand_coeff = {pair_candidate_b2, pair_candidate_b1, pair_candidate_b0, pair_candidate_a2, pair_candidate_a1};
assign cfg = {pair_candidate_csrstorage4_storage, pair_candidate_csrstorage3_storage, pair_candidate_csrstorage2_storage, pair_candidate_csrstorage1_storage, pair_candidate_csrstorage0_storage, pair_candidate_storage};
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
assign pair_candidate_z0 = (pair_candidate_zr0 + (pair_candidate_x * pair_candidate_b2));
assign pair_candidate_z1 = (pair_candidate_zr1 + (pair_candidate_x * pair_candidate_b1));
assign pair_candidate_z2 = (pair_candidate_zr2 + (pair_candidate_x * pair_candidate_b0));
assign pair_candidate_z3 = (pair_candidate_zr3 + (pair_candidate_y1 * pair_candidate_a2));
assign pair_candidate_z4 = (pair_candidate_zr4 + (pair_candidate_a1 * pair_candidate_y1));
assign pair_candidate_y_next = pair_candidate_z4;
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
assign pair_reference_z0 = (pair_reference_zr0 + (pair_reference_x * pair_reference_b2));
assign pair_reference_z1 = (pair_reference_zr1 + (pair_reference_x * pair_reference_b1));
assign pair_reference_z2 = (pair_reference_zr2 + (pair_reference_x * pair_reference_b0));
assign pair_reference_z3 = (pair_reference_zr3 + (pair_reference_y1 * pair_reference_a2));
assign pair_reference_z4 = (pair_reference_zr4 + (pair_reference_y1 * pair_reference_a1));
assign pair_reference_y_next = pair_reference_z4;
assign pair_bank_sel = (pair_bank_bus_adr[13:9] == 1'd0);
assign pair_bank_z01_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_z01_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 1'd0));
assign pair_bank_z00_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_z00_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 1'd1));
assign pair_bank_a11_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a11_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 2'd2));
assign pair_bank_a10_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a10_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 2'd3));
assign pair_bank_a21_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_a21_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 3'd4));
assign pair_bank_a20_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_a20_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 3'd5));
assign pair_bank_b01_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b01_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 3'd6));
assign pair_bank_b00_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b00_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 3'd7));
assign pair_bank_b11_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b11_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 4'd8));
assign pair_bank_b10_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b10_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 4'd9));
assign pair_bank_b21_r = pair_bank_bus_dat_w[5:0];
assign pair_bank_b21_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 4'd10));
assign pair_bank_b20_r = pair_bank_bus_dat_w[7:0];
assign pair_bank_b20_re = ((pair_bank_sel & pair_bank_bus_we) & (pair_bank_bus_adr[3:0] == 4'd11));
assign pair_candidate_storage = pair_candidate_storage_full[15:0];
assign pair_bank_z01_w = pair_candidate_storage_full[15:8];
assign pair_bank_z00_w = pair_candidate_storage_full[7:0];
assign pair_candidate_csrstorage0_storage = pair_candidate_csrstorage0_storage_full[13:0];
assign pair_bank_a11_w = pair_candidate_csrstorage0_storage_full[13:8];
assign pair_bank_a10_w = pair_candidate_csrstorage0_storage_full[7:0];
assign pair_candidate_csrstorage1_storage = pair_candidate_csrstorage1_storage_full[13:0];
assign pair_bank_a21_w = pair_candidate_csrstorage1_storage_full[13:8];
assign pair_bank_a20_w = pair_candidate_csrstorage1_storage_full[7:0];
assign pair_candidate_csrstorage2_storage = pair_candidate_csrstorage2_storage_full[13:0];
assign pair_bank_b01_w = pair_candidate_csrstorage2_storage_full[13:8];
assign pair_bank_b00_w = pair_candidate_csrstorage2_storage_full[7:0];
assign pair_candidate_csrstorage3_storage = pair_candidate_csrstorage3_storage_full[13:0];
assign pair_bank_b11_w = pair_candidate_csrstorage3_storage_full[13:8];
assign pair_bank_b10_w = pair_candidate_csrstorage3_storage_full[7:0];
assign pair_candidate_csrstorage4_storage = pair_candidate_csrstorage4_storage_full[13:0];
assign pair_bank_b21_w = pair_candidate_csrstorage4_storage_full[13:8];
assign pair_bank_b20_w = pair_candidate_csrstorage4_storage_full[7:0];
assign pair_reference_bank_sel = (pair_reference_bank_bus_adr[13:9] == 1'd0);
assign pair_reference_bank_z01_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_z01_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 1'd0));
assign pair_reference_bank_z00_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_z00_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 1'd1));
assign pair_reference_bank_a11_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a11_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 2'd2));
assign pair_reference_bank_a10_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a10_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 2'd3));
assign pair_reference_bank_a21_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_a21_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 3'd4));
assign pair_reference_bank_a20_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_a20_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 3'd5));
assign pair_reference_bank_b01_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b01_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 3'd6));
assign pair_reference_bank_b00_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b00_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 3'd7));
assign pair_reference_bank_b11_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b11_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 4'd8));
assign pair_reference_bank_b10_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b10_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 4'd9));
assign pair_reference_bank_b21_r = pair_reference_bank_bus_dat_w[5:0];
assign pair_reference_bank_b21_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 4'd10));
assign pair_reference_bank_b20_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_b20_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[3:0] == 4'd11));
assign pair_reference_storage = pair_reference_storage_full[15:0];
assign pair_reference_bank_z01_w = pair_reference_storage_full[15:8];
assign pair_reference_bank_z00_w = pair_reference_storage_full[7:0];
assign pair_reference_csrstorage0_storage = pair_reference_csrstorage0_storage_full[13:0];
assign pair_reference_bank_a11_w = pair_reference_csrstorage0_storage_full[13:8];
assign pair_reference_bank_a10_w = pair_reference_csrstorage0_storage_full[7:0];
assign pair_reference_csrstorage1_storage = pair_reference_csrstorage1_storage_full[13:0];
assign pair_reference_bank_a21_w = pair_reference_csrstorage1_storage_full[13:8];
assign pair_reference_bank_a20_w = pair_reference_csrstorage1_storage_full[7:0];
assign pair_reference_csrstorage2_storage = pair_reference_csrstorage2_storage_full[13:0];
assign pair_reference_bank_b01_w = pair_reference_csrstorage2_storage_full[13:8];
assign pair_reference_bank_b00_w = pair_reference_csrstorage2_storage_full[7:0];
assign pair_reference_csrstorage3_storage = pair_reference_csrstorage3_storage_full[13:0];
assign pair_reference_bank_b11_w = pair_reference_csrstorage3_storage_full[13:8];
assign pair_reference_bank_b10_w = pair_reference_csrstorage3_storage_full[7:0];
assign pair_reference_csrstorage4_storage = pair_reference_csrstorage4_storage_full[13:0];
assign pair_reference_bank_b21_w = pair_reference_csrstorage4_storage_full[13:8];
assign pair_reference_bank_b20_w = pair_reference_csrstorage4_storage_full[7:0];

always @(posedge sys_clk) begin
	pair_candidate_a1 <= pair_candidate_csrstorage0_storage;
	pair_candidate_a2 <= pair_candidate_csrstorage1_storage;
	pair_candidate_b0 <= pair_candidate_csrstorage2_storage;
	pair_candidate_b1 <= pair_candidate_csrstorage3_storage;
	pair_candidate_b2 <= pair_candidate_csrstorage4_storage;
	pair_candidate_z0r <= (pair_candidate_storage <<< 4'd12);
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
	pair_reference_a1 <= pair_reference_csrstorage0_storage;
	pair_reference_a2 <= pair_reference_csrstorage1_storage;
	pair_reference_b0 <= pair_reference_csrstorage2_storage;
	pair_reference_b1 <= pair_reference_csrstorage3_storage;
	pair_reference_b2 <= pair_reference_csrstorage4_storage;
	pair_reference_z0r <= (pair_reference_storage <<< 4'd12);
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
	pair_bank_bus_dat_r <= 1'd0;
	if (pair_bank_sel) begin
		case (pair_bank_bus_adr[3:0])
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
				pair_bank_bus_dat_r <= pair_bank_b01_w;
			end
			3'd7: begin
				pair_bank_bus_dat_r <= pair_bank_b00_w;
			end
			4'd8: begin
				pair_bank_bus_dat_r <= pair_bank_b11_w;
			end
			4'd9: begin
				pair_bank_bus_dat_r <= pair_bank_b10_w;
			end
			4'd10: begin
				pair_bank_bus_dat_r <= pair_bank_b21_w;
			end
			4'd11: begin
				pair_bank_bus_dat_r <= pair_bank_b20_w;
			end
		endcase
	end
	if (pair_bank_z01_re) begin
		pair_candidate_storage_full[15:8] <= pair_bank_z01_r;
	end
	if (pair_bank_z00_re) begin
		pair_candidate_storage_full[7:0] <= pair_bank_z00_r;
	end
	pair_candidate_re <= pair_bank_z00_re;
	if (pair_bank_a11_re) begin
		pair_candidate_csrstorage0_storage_full[13:8] <= pair_bank_a11_r;
	end
	if (pair_bank_a10_re) begin
		pair_candidate_csrstorage0_storage_full[7:0] <= pair_bank_a10_r;
	end
	pair_candidate_csrstorage0_re <= pair_bank_a10_re;
	if (pair_bank_a21_re) begin
		pair_candidate_csrstorage1_storage_full[13:8] <= pair_bank_a21_r;
	end
	if (pair_bank_a20_re) begin
		pair_candidate_csrstorage1_storage_full[7:0] <= pair_bank_a20_r;
	end
	pair_candidate_csrstorage1_re <= pair_bank_a20_re;
	if (pair_bank_b01_re) begin
		pair_candidate_csrstorage2_storage_full[13:8] <= pair_bank_b01_r;
	end
	if (pair_bank_b00_re) begin
		pair_candidate_csrstorage2_storage_full[7:0] <= pair_bank_b00_r;
	end
	pair_candidate_csrstorage2_re <= pair_bank_b00_re;
	if (pair_bank_b11_re) begin
		pair_candidate_csrstorage3_storage_full[13:8] <= pair_bank_b11_r;
	end
	if (pair_bank_b10_re) begin
		pair_candidate_csrstorage3_storage_full[7:0] <= pair_bank_b10_r;
	end
	pair_candidate_csrstorage3_re <= pair_bank_b10_re;
	if (pair_bank_b21_re) begin
		pair_candidate_csrstorage4_storage_full[13:8] <= pair_bank_b21_r;
	end
	if (pair_bank_b20_re) begin
		pair_candidate_csrstorage4_storage_full[7:0] <= pair_bank_b20_r;
	end
	pair_candidate_csrstorage4_re <= pair_bank_b20_re;
	pair_reference_bank_bus_dat_r <= 1'd0;
	if (pair_reference_bank_sel) begin
		case (pair_reference_bank_bus_adr[3:0])
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
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b01_w;
			end
			3'd7: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b00_w;
			end
			4'd8: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b11_w;
			end
			4'd9: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b10_w;
			end
			4'd10: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b21_w;
			end
			4'd11: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_b20_w;
			end
		endcase
	end
	if (pair_reference_bank_z01_re) begin
		pair_reference_storage_full[15:8] <= pair_reference_bank_z01_r;
	end
	if (pair_reference_bank_z00_re) begin
		pair_reference_storage_full[7:0] <= pair_reference_bank_z00_r;
	end
	pair_reference_re <= pair_reference_bank_z00_re;
	if (pair_reference_bank_a11_re) begin
		pair_reference_csrstorage0_storage_full[13:8] <= pair_reference_bank_a11_r;
	end
	if (pair_reference_bank_a10_re) begin
		pair_reference_csrstorage0_storage_full[7:0] <= pair_reference_bank_a10_r;
	end
	pair_reference_csrstorage0_re <= pair_reference_bank_a10_re;
	if (pair_reference_bank_a21_re) begin
		pair_reference_csrstorage1_storage_full[13:8] <= pair_reference_bank_a21_r;
	end
	if (pair_reference_bank_a20_re) begin
		pair_reference_csrstorage1_storage_full[7:0] <= pair_reference_bank_a20_r;
	end
	pair_reference_csrstorage1_re <= pair_reference_bank_a20_re;
	if (pair_reference_bank_b01_re) begin
		pair_reference_csrstorage2_storage_full[13:8] <= pair_reference_bank_b01_r;
	end
	if (pair_reference_bank_b00_re) begin
		pair_reference_csrstorage2_storage_full[7:0] <= pair_reference_bank_b00_r;
	end
	pair_reference_csrstorage2_re <= pair_reference_bank_b00_re;
	if (pair_reference_bank_b11_re) begin
		pair_reference_csrstorage3_storage_full[13:8] <= pair_reference_bank_b11_r;
	end
	if (pair_reference_bank_b10_re) begin
		pair_reference_csrstorage3_storage_full[7:0] <= pair_reference_bank_b10_r;
	end
	pair_reference_csrstorage3_re <= pair_reference_bank_b10_re;
	if (pair_reference_bank_b21_re) begin
		pair_reference_csrstorage4_storage_full[13:8] <= pair_reference_bank_b21_r;
	end
	if (pair_reference_bank_b20_re) begin
		pair_reference_csrstorage4_storage_full[7:0] <= pair_reference_bank_b20_r;
	end
	pair_reference_csrstorage4_re <= pair_reference_bank_b20_re;
	if (sys_rst) begin
		pair_candidate_y0 <= 14'sd0;
		pair_candidate_error <= 1'd0;
		pair_candidate_storage_full <= 16'd0;
		pair_candidate_re <= 1'd0;
		pair_candidate_a1 <= 14'sd0;
		pair_candidate_csrstorage0_storage_full <= 14'd0;
		pair_candidate_csrstorage0_re <= 1'd0;
		pair_candidate_a2 <= 14'sd0;
		pair_candidate_csrstorage1_storage_full <= 14'd0;
		pair_candidate_csrstorage1_re <= 1'd0;
		pair_candidate_b0 <= 14'sd0;
		pair_candidate_csrstorage2_storage_full <= 14'd0;
		pair_candidate_csrstorage2_re <= 1'd0;
		pair_candidate_b1 <= 14'sd0;
		pair_candidate_csrstorage3_storage_full <= 14'd0;
		pair_candidate_csrstorage3_re <= 1'd0;
		pair_candidate_b2 <= 14'sd0;
		pair_candidate_csrstorage4_storage_full <= 14'd0;
		pair_candidate_csrstorage4_re <= 1'd0;
		pair_candidate_z0r <= 28'sd0;
		pair_candidate_y1 <= 14'sd0;
		pair_candidate_zr0 <= 28'sd0;
		pair_candidate_zr1 <= 28'sd0;
		pair_candidate_zr2 <= 28'sd0;
		pair_candidate_zr3 <= 28'sd0;
		pair_candidate_zr4 <= 28'sd0;
		pair_reference_y0 <= 14'sd0;
		pair_reference_error <= 1'd0;
		pair_reference_storage_full <= 16'd0;
		pair_reference_re <= 1'd0;
		pair_reference_a1 <= 14'sd0;
		pair_reference_csrstorage0_storage_full <= 14'd0;
		pair_reference_csrstorage0_re <= 1'd0;
		pair_reference_a2 <= 14'sd0;
		pair_reference_csrstorage1_storage_full <= 14'd0;
		pair_reference_csrstorage1_re <= 1'd0;
		pair_reference_b0 <= 14'sd0;
		pair_reference_csrstorage2_storage_full <= 14'd0;
		pair_reference_csrstorage2_re <= 1'd0;
		pair_reference_b1 <= 14'sd0;
		pair_reference_csrstorage3_storage_full <= 14'd0;
		pair_reference_csrstorage3_re <= 1'd0;
		pair_reference_b2 <= 14'sd0;
		pair_reference_csrstorage4_storage_full <= 14'd0;
		pair_reference_csrstorage4_re <= 1'd0;
		pair_reference_z0r <= 28'sd0;
		pair_reference_y1 <= 14'sd0;
		pair_reference_zr0 <= 28'sd0;
		pair_reference_zr1 <= 28'sd0;
		pair_reference_zr2 <= 28'sd0;
		pair_reference_zr3 <= 28'sd0;
		pair_reference_zr4 <= 28'sd0;
		pair_bank_bus_dat_r <= 8'd0;
		pair_reference_bank_bus_dat_r <= 8'd0;
	end
end

endmodule
