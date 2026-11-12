/* Machine-generated using Migen */
module common_csr_pair(
	input sys_clk,
	input sys_rst,
	input signed [24:0] dy,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [17:0] old_word,
	output [17:0] new_word,
	output [13:0] cfg,
	output [7:0] csr_read
);

reg [13:0] pair_storage_full = 14'd0;
wire [13:0] pair_storage;
reg pair_re = 1'd0;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_offset1_re;
wire [5:0] pair_offset1_r;
wire [5:0] pair_offset1_w;
wire pair_offset0_re;
wire [7:0] pair_offset0_r;
wire [7:0] pair_offset0_w;
wire pair_sel;
reg signed [16:0] pair_ya = 17'sd0;
reg signed [13:0] pair_old_offset = 14'sd0;
wire signed [13:0] pair_signed_offset;
reg signed [17:0] pair_common = 18'sd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_signed_offset = pair_storage;
assign old_word = (pair_ya + pair_old_offset);
assign new_word = pair_common;
assign cfg = pair_storage;
assign csr_read = pair_bus_dat_r;
assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_offset1_r = pair_bus_dat_w[5:0];
assign pair_offset1_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[0] == 1'd0));
assign pair_offset0_r = pair_bus_dat_w[7:0];
assign pair_offset0_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[0] == 1'd1));
assign pair_storage = pair_storage_full[13:0];
assign pair_offset1_w = pair_storage_full[13:8];
assign pair_offset0_w = pair_storage_full[7:0];

always @(posedge sys_clk) begin
	pair_ya <= (dy >>> 4'd11);
	pair_old_offset <= pair_storage;
	pair_common <= ((dy >>> 4'd11) + pair_signed_offset);
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[0])
			1'd0: begin
				pair_bus_dat_r <= pair_offset1_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_offset0_w;
			end
		endcase
	end
	if (pair_offset1_re) begin
		pair_storage_full[13:8] <= pair_offset1_r;
	end
	if (pair_offset0_re) begin
		pair_storage_full[7:0] <= pair_offset0_r;
	end
	pair_re <= pair_offset0_re;
	if (sys_rst) begin
		pair_storage_full <= 14'd0;
		pair_re <= 1'd0;
		pair_bus_dat_r <= 8'd0;
		pair_ya <= 17'sd0;
		pair_old_offset <= 14'sd0;
		pair_common <= 18'sd0;
	end
end

endmodule
