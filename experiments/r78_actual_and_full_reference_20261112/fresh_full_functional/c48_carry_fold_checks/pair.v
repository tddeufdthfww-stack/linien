/* Machine-generated using Migen */
module carry_fold_pair(
	input signed [24:0] x,
	input signed [24:0] c,
	input signed [49:0] z,
	output signed [49:0] ref_y,
	output signed [49:0] new_y
);

wire signed [17:0] pair_xlo0;
wire signed [7:0] pair_xhi0;
wire signed [47:0] pair_zlo0;
wire signed [1:0] pair_ztop0;
(* use_dsp = "yes" *) wire signed [47:0] pair_low0;
(* use_dsp = "yes" *) wire signed [47:0] pair_high0;
wire pair0;
wire pair1;
wire signed [3:0] pair_correction0;
wire [1:0] pair_top0;
wire signed [49:0] pair_result0;
wire signed [17:0] pair_xlo1;
wire signed [7:0] pair_xhi1;
wire signed [47:0] pair_zlo1;
wire signed [1:0] pair_ztop1;
(* use_dsp = "yes" *) wire signed [47:0] pair_low1;
(* use_dsp = "yes" *) wire signed [47:0] pair_high1;
wire pair_carry;
wire signed [3:0] pair_correction1;
wire [1:0] pair_top1;
wire signed [49:0] pair_result1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_xlo0 = {1'd0, x[16:0]};
assign pair_xhi0 = x[24:17];
assign pair_zlo0 = z[47:0];
assign pair_ztop0 = z[49:48];
assign pair_low0 = ((c * pair_xlo0) + pair_zlo0);
assign pair_high0 = ((c * pair_xhi0) + (pair_low0 >>> 5'd17));
assign pair0 = (((~pair_zlo0[47]) & (~c[24])) & pair_low0[47]);
assign pair1 = ((pair_zlo0[47] & c[24]) & (~pair_low0[47]));
assign pair_correction0 = (((pair_ztop0 + pair_zlo0[47]) + $signed({1'd0, pair0})) - $signed({1'd0, pair1}));
assign pair_top0 = (pair_high0[32:31] + pair_correction0);
assign pair_result0 = {pair_top0, pair_high0[30:0], pair_low0[16:0]};
assign pair_xlo1 = {1'd0, x[16:0]};
assign pair_xhi1 = x[24:17];
assign pair_zlo1 = z[47:0];
assign pair_ztop1 = z[49:48];
assign pair_low1 = ((c * pair_xlo1) + pair_zlo1);
assign pair_high1 = ((c * pair_xhi1) + (pair_low1 >>> 5'd17));
assign pair_carry = ((pair_zlo1[47] & pair_low1[47]) | ((~c[24]) & (pair_zlo1[47] | pair_low1[47])));
assign pair_correction1 = (pair_ztop1 + $signed({1'd0, pair_carry}));
assign pair_top1 = (pair_high1[32:31] + pair_correction1);
assign pair_result1 = {pair_top1, pair_high1[30:0], pair_low1[16:0]};
assign ref_y = pair_result0;
assign new_y = pair_result1;

endmodule
