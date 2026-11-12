/* Machine-generated using Migen */
module dna_pair(
	input sys_clk,
	input sys_rst,
	output [63:0] old0_status,
	output old0_read,
	output [63:0] new0_status,
	output new0_read,
	output [7:0] new0_count,
	output [63:0] old1_status,
	output old1_read,
	output [63:0] new1_status,
	output new1_read,
	output [7:0] new1_count,
	output [63:0] old2_status,
	output old2_read,
	output [63:0] new2_status,
	output new2_read,
	output [7:0] new2_count,
	output [63:0] old3_status,
	output old3_read,
	output [63:0] new3_status,
	output new3_read,
	output [7:0] new3_count
);

reg [63:0] dna0_status0 = 64'd9367487224930631680;
wire dna0_do0;
reg [7:0] dna0_cnt0 = 8'd0;
reg [63:0] dna0_status1 = 64'd9367487224930631680;
wire dna0_do1;
reg [7:0] dna0_cnt1 = 8'd0;
reg r61_dna_read = 1'd1;
reg [63:0] dna1_status0 = 64'd9367487224930631680;
wire dna1_do0;
reg [7:0] dna1_cnt0 = 8'd0;
reg [63:0] dna1_status1 = 64'd9367487224930631680;
wire dna1_do1;
reg [7:0] dna1_cnt1 = 8'd0;
reg r61_dna_read_1 = 1'd1;
reg [63:0] dna2_status0 = 64'd9367487224930631680;
wire dna2_do0;
reg [7:0] dna2_cnt0 = 8'd0;
reg [63:0] dna2_status1 = 64'd9367487224930631680;
wire dna2_do1;
reg [7:0] dna2_cnt1 = 8'd0;
reg r61_dna_read_2 = 1'd1;
reg [63:0] dna3_status0 = 64'd9367487224930631680;
wire dna3_do0;
reg [7:0] dna3_cnt0 = 8'd0;
reg [63:0] dna3_status1 = 64'd9367487224930631680;
wire dna3_do1;
reg [7:0] dna3_cnt1 = 8'd0;
reg r61_dna_read_3 = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign old0_status = dna0_status0;
assign old0_read = (dna0_cnt0 < 2'd2);
assign new0_status = dna0_status1;
assign new0_read = r61_dna_read;
assign new0_count = dna0_cnt1;
assign old1_status = dna1_status0;
assign old1_read = (dna1_cnt0 < 2'd2);
assign new1_status = dna1_status1;
assign new1_read = r61_dna_read_1;
assign new1_count = dna1_cnt1;
assign old2_status = dna2_status0;
assign old2_read = (dna2_cnt0 < 2'd2);
assign new2_status = dna2_status1;
assign new2_read = r61_dna_read_2;
assign new2_count = dna2_cnt1;
assign old3_status = dna3_status0;
assign old3_read = (dna3_cnt0 < 2'd2);
assign new3_status = dna3_status1;
assign new3_read = r61_dna_read_3;
assign new3_count = dna3_cnt1;

always @(posedge sys_clk) begin
	if ((dna0_cnt0 < 8'd128)) begin
		dna0_cnt0 <= (dna0_cnt0 + 1'd1);
		if (dna0_cnt0[0]) begin
			dna0_status0 <= {dna0_status0, dna0_do0};
		end
	end
	if (dna0_cnt1[0]) begin
		r61_dna_read <= 1'd0;
	end
	if ((dna0_cnt1 < 8'd128)) begin
		dna0_cnt1 <= (dna0_cnt1 + 1'd1);
		if (dna0_cnt1[0]) begin
			dna0_status1 <= {dna0_status1, dna0_do1};
		end
	end
	if ((dna1_cnt0 < 8'd128)) begin
		dna1_cnt0 <= (dna1_cnt0 + 1'd1);
		if (dna1_cnt0[0]) begin
			dna1_status0 <= {dna1_status0, dna1_do0};
		end
	end
	if (dna1_cnt1[0]) begin
		r61_dna_read_1 <= 1'd0;
	end
	if ((dna1_cnt1 < 8'd128)) begin
		dna1_cnt1 <= (dna1_cnt1 + 1'd1);
		if (dna1_cnt1[0]) begin
			dna1_status1 <= {dna1_status1, dna1_do1};
		end
	end
	if ((dna2_cnt0 < 8'd128)) begin
		dna2_cnt0 <= (dna2_cnt0 + 1'd1);
		if (dna2_cnt0[0]) begin
			dna2_status0 <= {dna2_status0, dna2_do0};
		end
	end
	if (dna2_cnt1[0]) begin
		r61_dna_read_2 <= 1'd0;
	end
	if ((dna2_cnt1 < 8'd128)) begin
		dna2_cnt1 <= (dna2_cnt1 + 1'd1);
		if (dna2_cnt1[0]) begin
			dna2_status1 <= {dna2_status1, dna2_do1};
		end
	end
	if ((dna3_cnt0 < 8'd128)) begin
		dna3_cnt0 <= (dna3_cnt0 + 1'd1);
		if (dna3_cnt0[0]) begin
			dna3_status0 <= {dna3_status0, dna3_do0};
		end
	end
	if (dna3_cnt1[0]) begin
		r61_dna_read_3 <= 1'd0;
	end
	if ((dna3_cnt1 < 8'd128)) begin
		dna3_cnt1 <= (dna3_cnt1 + 1'd1);
		if (dna3_cnt1[0]) begin
			dna3_status1 <= {dna3_status1, dna3_do1};
		end
	end
	if (sys_rst) begin
		dna0_status0 <= 64'd9367487224930631680;
		dna0_cnt0 <= 8'd0;
		dna0_status1 <= 64'd9367487224930631680;
		dna0_cnt1 <= 8'd0;
		r61_dna_read <= 1'd1;
		dna1_status0 <= 64'd9367487224930631680;
		dna1_cnt0 <= 8'd0;
		dna1_status1 <= 64'd9367487224930631680;
		dna1_cnt1 <= 8'd0;
		r61_dna_read_1 <= 1'd1;
		dna2_status0 <= 64'd9367487224930631680;
		dna2_cnt0 <= 8'd0;
		dna2_status1 <= 64'd9367487224930631680;
		dna2_cnt1 <= 8'd0;
		r61_dna_read_2 <= 1'd1;
		dna3_status0 <= 64'd9367487224930631680;
		dna3_cnt0 <= 8'd0;
		dna3_status1 <= 64'd9367487224930631680;
		dna3_cnt1 <= 8'd0;
		r61_dna_read_3 <= 1'd1;
	end
end

DNA_PORT #(
	.SIM_DNA_VALUE(57'd0)
) DNA_PORT (
	.CLK(dna0_cnt0[0]),
	.DIN(dna0_status0[63]),
	.READ((dna0_cnt0 < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(dna0_do0)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd0)
) DNA_PORT_1 (
	.CLK(dna0_cnt1[0]),
	.DIN(dna0_status1[63]),
	.READ(r61_dna_read),
	.SHIFT(1'd1),
	.DOUT(dna0_do1)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd144115188075855871)
) DNA_PORT_2 (
	.CLK(dna1_cnt0[0]),
	.DIN(dna1_status0[63]),
	.READ((dna1_cnt0 < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(dna1_do0)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd144115188075855871)
) DNA_PORT_3 (
	.CLK(dna1_cnt1[0]),
	.DIN(dna1_status1[63]),
	.READ(r61_dna_read_1),
	.SHIFT(1'd1),
	.DOUT(dna1_do1)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd77181689613958366)
) DNA_PORT_4 (
	.CLK(dna2_cnt0[0]),
	.DIN(dna2_status0[63]),
	.READ((dna2_cnt0 < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(dna2_do0)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd77181689613958366)
) DNA_PORT_5 (
	.CLK(dna2_cnt1[0]),
	.DIN(dna2_status1[63]),
	.READ(r61_dna_read_2),
	.SHIFT(1'd1),
	.DOUT(dna2_do1)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd66933498461897505)
) DNA_PORT_6 (
	.CLK(dna3_cnt0[0]),
	.DIN(dna3_status0[63]),
	.READ((dna3_cnt0 < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(dna3_do0)
);

DNA_PORT #(
	.SIM_DNA_VALUE(57'd66933498461897505)
) DNA_PORT_7 (
	.CLK(dna3_cnt1[0]),
	.DIN(dna3_status1[63]),
	.READ(r61_dna_read_3),
	.SHIFT(1'd1),
	.DOUT(dna3_do1)
);

endmodule
