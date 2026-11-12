/* Machine-generated using Migen */
module abs_predicate_pair(
	input signed [28:0] value,
	input signed [27:0] threshold,
	output old_result,
	output new_result
);

reg signed [28:0] magnitude;
wire signed [28:0] extended;
wire signed [28:0] negative;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on


// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	magnitude <= 29'sd0;
	if ((value >= $signed({1'd0, 1'd0}))) begin
		magnitude <= value;
	end else begin
		magnitude <= (1'sd1 * value);
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign old_result = (magnitude >= threshold);
assign extended = threshold;
assign negative = (-extended);
assign new_result = ((value[28] & (value != 29'sd268435456)) ? (value <= negative) : (value >= threshold));

endmodule
