/* Machine-generated using Migen */
module pid_output_pair(
	input signed [83:0] x,
	output reg signed [24:0] old_y,
	output reg signed [24:0] new_y
);


// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on


// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	old_y <= 25'sd0;
	if ((x > $signed({1'd0, 24'd16777215}))) begin
		old_y <= 24'd16777215;
	end else begin
		if ((x < 25'sd16777216)) begin
			old_y <= 25'sd16777216;
		end else begin
			old_y <= x[24:0];
		end
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	new_y <= 25'sd0;
	if (((~x[83]) & (x[83:24] != $signed({1'd0, 1'd0})))) begin
		new_y <= 24'd16777215;
	end else begin
		if ((x[83] & (x[83:24] != $signed({1'd0, 60'd1152921504606846975})))) begin
			new_y <= 25'sd16777216;
		end else begin
			new_y <= x[24:0];
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end

endmodule
