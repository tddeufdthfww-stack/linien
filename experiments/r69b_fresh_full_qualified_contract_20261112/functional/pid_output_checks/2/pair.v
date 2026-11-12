/* Machine-generated using Migen */
module pid_output_pair(
	input signed [4:0] x,
	output reg signed [1:0] old_y,
	output reg signed [1:0] new_y
);


// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on


// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	old_y <= 2'sd0;
	if ((x > $signed({1'd0, 1'd1}))) begin
		old_y <= 1'd1;
	end else begin
		if ((x < 2'sd2)) begin
			old_y <= 2'sd2;
		end else begin
			old_y <= x[1:0];
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
	new_y <= 2'sd0;
	if (((~x[4]) & (x[4:1] != $signed({1'd0, 1'd0})))) begin
		new_y <= 1'd1;
	end else begin
		if ((x[4] & (x[4:1] != $signed({1'd0, 4'd15})))) begin
			new_y <= 2'sd2;
		end else begin
			new_y <= x[1:0];
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end

endmodule
