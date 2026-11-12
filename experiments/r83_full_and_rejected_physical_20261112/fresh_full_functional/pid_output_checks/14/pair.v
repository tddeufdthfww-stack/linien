/* Machine-generated using Migen */
module pid_output_pair(
	input signed [50:0] x,
	output reg signed [13:0] old_y,
	output reg signed [13:0] new_y
);


// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on


// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	old_y <= 14'sd0;
	if ((x > $signed({1'd0, 13'd8191}))) begin
		old_y <= 13'd8191;
	end else begin
		if ((x < 14'sd8192)) begin
			old_y <= 14'sd8192;
		end else begin
			old_y <= x[13:0];
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
	new_y <= 14'sd0;
	if (((~x[50]) & (x[50:13] != $signed({1'd0, 1'd0})))) begin
		new_y <= 13'd8191;
	end else begin
		if ((x[50] & (x[50:13] != $signed({1'd0, 38'd274877906943})))) begin
			new_y <= 14'sd8192;
		end else begin
			new_y <= x[13:0];
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end

endmodule
