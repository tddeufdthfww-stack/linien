/* Machine-generated using Migen */
module c48_pair(
	input signed [24:0] x,
	input signed [24:0] c,
	input signed [49:0] z,
	output signed [49:0] old_y,
	output signed [49:0] new_y
);

wire signed [17:0] xlo;
wire signed [7:0] xhi;
wire signed [47:0] zlo;
wire signed [1:0] ztop;
(* use_dsp = "yes" *) wire signed [47:0] low;
(* use_dsp = "yes" *) wire signed [47:0] high;
wire carry;
wire signed [3:0] correction;
wire [1:0] top;
wire signed [49:0] result;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign xlo = {1'd0, x[16:0]};
assign xhi = x[24:17];
assign zlo = z[47:0];
assign ztop = z[49:48];
assign low = ((c * xlo) + zlo);
assign high = ((c * xhi) + (low >>> 5'd17));
assign carry = ((zlo[47] & low[47]) | ((~c[24]) & (zlo[47] | low[47])));
assign correction = (ztop + $signed({1'd0, carry}));
assign top = (high[32:31] + correction);
assign result = {top, high[30:0], low[16:0]};
assign old_y = (z + (x * c));
assign new_y = result;

endmodule
