/* Machine-generated using Migen */
module r77_demod_pair(
	input sys_clk,
	input sys_rst,
	input signed [13:0] x,
	input [13:0] phase,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [13:0] ref_i,
	output [13:0] ref_q,
	output [14:0] ref_phase,
	output [31:0] ref_delay,
	output [3:0] ref_mult,
	output [7:0] ref_read,
	output [13:0] cand_i,
	output [13:0] cand_q,
	output [14:0] cand_phase,
	output [31:0] cand_delay,
	output [3:0] cand_mult,
	output [7:0] cand_read
);

wire signed [13:0] pair_reference_x;
wire signed [13:0] pair_reference_i;
wire signed [13:0] pair_reference_q0;
reg [31:0] pair_reference_delay_storage_full = 32'd0;
wire [31:0] pair_reference_delay_storage;
reg pair_reference_delay_re = 1'd0;
reg [3:0] pair_reference_multiplier_storage_full = 4'd1;
wire [3:0] pair_reference_multiplier_storage;
reg pair_reference_multiplier_re = 1'd0;
wire [13:0] pair_reference_phase;
reg signed [14:0] pair_reference_cordic_xi;
reg signed [14:0] pair_reference_cordic_yi;
reg signed [14:0] pair_reference_cordic_zi;
wire signed [14:0] pair_reference_cordic_xo;
wire signed [14:0] pair_reference_cordic_yo;
wire signed [14:0] pair_reference_cordic_zo;
wire pair_reference_cordic_new_in;
wire pair_reference_cordic_new_out;
wire signed [16:0] pair_reference_cordic0;
reg signed [16:0] pair_reference_cordic1 = 17'sd0;
reg signed [16:0] pair_reference_cordic2 = 17'sd0;
reg signed [16:0] pair_reference_cordic3 = 17'sd0;
reg signed [16:0] pair_reference_cordic4 = 17'sd0;
reg signed [16:0] pair_reference_cordic5 = 17'sd0;
reg signed [16:0] pair_reference_cordic6 = 17'sd0;
reg signed [16:0] pair_reference_cordic7 = 17'sd0;
reg signed [16:0] pair_reference_cordic8 = 17'sd0;
reg signed [16:0] pair_reference_cordic9 = 17'sd0;
reg signed [16:0] pair_reference_cordic10 = 17'sd0;
reg signed [16:0] pair_reference_cordic11 = 17'sd0;
reg signed [16:0] pair_reference_cordic12 = 17'sd0;
reg signed [16:0] pair_reference_cordic13 = 17'sd0;
reg signed [16:0] pair_reference_cordic14 = 17'sd0;
reg signed [16:0] pair_reference_cordic15 = 17'sd0;
wire signed [16:0] pair_reference_cordic16;
reg signed [16:0] pair_reference_cordic17 = 17'sd0;
reg signed [16:0] pair_reference_cordic18 = 17'sd0;
reg signed [16:0] pair_reference_cordic19 = 17'sd0;
reg signed [16:0] pair_reference_cordic20 = 17'sd0;
reg signed [16:0] pair_reference_cordic21 = 17'sd0;
reg signed [16:0] pair_reference_cordic22 = 17'sd0;
reg signed [16:0] pair_reference_cordic23 = 17'sd0;
reg signed [16:0] pair_reference_cordic24 = 17'sd0;
reg signed [16:0] pair_reference_cordic25 = 17'sd0;
reg signed [16:0] pair_reference_cordic26 = 17'sd0;
reg signed [16:0] pair_reference_cordic27 = 17'sd0;
reg signed [16:0] pair_reference_cordic28 = 17'sd0;
reg signed [16:0] pair_reference_cordic29 = 17'sd0;
reg signed [16:0] pair_reference_cordic30 = 17'sd0;
reg signed [16:0] pair_reference_cordic31 = 17'sd0;
wire signed [16:0] pair_reference_cordic32;
reg signed [16:0] pair_reference_cordic33 = 17'sd0;
reg signed [16:0] pair_reference_cordic34 = 17'sd0;
reg signed [16:0] pair_reference_cordic35 = 17'sd0;
reg signed [16:0] pair_reference_cordic36 = 17'sd0;
reg signed [16:0] pair_reference_cordic37 = 17'sd0;
reg signed [16:0] pair_reference_cordic38 = 17'sd0;
reg signed [16:0] pair_reference_cordic39 = 17'sd0;
reg signed [16:0] pair_reference_cordic40 = 17'sd0;
reg signed [16:0] pair_reference_cordic41 = 17'sd0;
reg signed [16:0] pair_reference_cordic42 = 17'sd0;
reg signed [16:0] pair_reference_cordic43 = 17'sd0;
reg signed [16:0] pair_reference_cordic44 = 17'sd0;
reg signed [16:0] pair_reference_cordic45 = 17'sd0;
reg signed [16:0] pair_reference_cordic46 = 17'sd0;
reg signed [16:0] pair_reference_cordic47 = 17'sd0;
wire pair_reference_cordic_dir0;
wire pair_reference_cordic_dir1;
wire pair_reference_cordic_dir2;
wire pair_reference_cordic_dir3;
wire pair_reference_cordic_dir4;
wire pair_reference_cordic_dir5;
wire pair_reference_cordic_dir6;
wire pair_reference_cordic_dir7;
wire pair_reference_cordic_dir8;
wire pair_reference_cordic_dir9;
wire pair_reference_cordic_dir10;
wire pair_reference_cordic_dir11;
wire pair_reference_cordic_dir12;
wire pair_reference_cordic_dir13;
wire pair_reference_cordic_dir14;
wire signed [14:0] pair_reference_xi;
reg signed [14:0] pair_reference_yi = 15'sd0;
wire signed [14:0] pair_reference_zi;
wire pair_reference_q1;
wire signed [13:0] pair_candidate_x;
wire signed [13:0] pair_candidate_i;
wire signed [13:0] pair_candidate_q0;
reg [31:0] pair_candidate_delay_storage_full = 32'd0;
wire [31:0] pair_candidate_delay_storage;
reg pair_candidate_delay_re = 1'd0;
reg [3:0] pair_candidate_multiplier_storage_full = 4'd1;
wire [3:0] pair_candidate_multiplier_storage;
reg pair_candidate_multiplier_re = 1'd0;
wire [13:0] pair_candidate_phase;
wire signed [14:0] pair_candidate_phase_value;
reg signed [14:0] pair_candidate_speculativedemodcordic_xi;
reg signed [14:0] pair_candidate_speculativedemodcordic_yi;
reg signed [14:0] pair_candidate_speculativedemodcordic_zi;
wire signed [14:0] pair_candidate_speculativedemodcordic_xo;
wire signed [14:0] pair_candidate_speculativedemodcordic_yo;
wire signed [14:0] pair_candidate_speculativedemodcordic_zo;
wire pair_candidate_speculativedemodcordic_new_in;
wire pair_candidate_speculativedemodcordic_new_out;
wire signed [16:0] pair_candidate_speculativedemodcordic0;
reg signed [16:0] pair_candidate_speculativedemodcordic1 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic2 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic3 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic4 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic5 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic6 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic7 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic8 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic9 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic10 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic11 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic12 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic13 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic14 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic15 = 17'sd0;
wire signed [16:0] pair_candidate_speculativedemodcordic16;
reg signed [16:0] pair_candidate_speculativedemodcordic17 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic18 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic19 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic20 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic21 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic22 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic23 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic24 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic25 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic26 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic27 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic28 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic29 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic30 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic31 = 17'sd0;
wire signed [16:0] pair_candidate_speculativedemodcordic32;
reg signed [16:0] pair_candidate_speculativedemodcordic33 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic34 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic35 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic36 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic37 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic38 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic39 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic40 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic41 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic42 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic43 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic44 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic45 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic46 = 17'sd0;
reg signed [16:0] pair_candidate_speculativedemodcordic47 = 17'sd0;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0;
wire signed [16:0] pair_candidate_speculativedemodcordic_speculativedemodcordic0;
wire signed [16:0] pair_candidate_speculativedemodcordic_speculativedemodcordic1;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14;
wire signed [14:0] pair_candidate_xi;
wire signed [14:0] pair_candidate_yi;
wire signed [14:0] pair_candidate_zi;
wire pair_candidate_q1;
wire [13:0] pair_reference_bank_bus_adr;
wire pair_reference_bank_bus_we;
wire [7:0] pair_reference_bank_bus_dat_w;
reg [7:0] pair_reference_bank_bus_dat_r = 8'd0;
wire pair_reference_bank_delay3_re;
wire [7:0] pair_reference_bank_delay3_r;
wire [7:0] pair_reference_bank_delay3_w;
wire pair_reference_bank_delay2_re;
wire [7:0] pair_reference_bank_delay2_r;
wire [7:0] pair_reference_bank_delay2_w;
wire pair_reference_bank_delay1_re;
wire [7:0] pair_reference_bank_delay1_r;
wire [7:0] pair_reference_bank_delay1_w;
wire pair_reference_bank_delay0_re;
wire [7:0] pair_reference_bank_delay0_r;
wire [7:0] pair_reference_bank_delay0_w;
wire pair_reference_bank_multiplier0_re;
wire [3:0] pair_reference_bank_multiplier0_r;
wire [3:0] pair_reference_bank_multiplier0_w;
wire pair_reference_bank_sel;
wire [13:0] pair_candidate_bank_bus_adr;
wire pair_candidate_bank_bus_we;
wire [7:0] pair_candidate_bank_bus_dat_w;
reg [7:0] pair_candidate_bank_bus_dat_r = 8'd0;
wire pair_candidate_bank_delay3_re;
wire [7:0] pair_candidate_bank_delay3_r;
wire [7:0] pair_candidate_bank_delay3_w;
wire pair_candidate_bank_delay2_re;
wire [7:0] pair_candidate_bank_delay2_r;
wire [7:0] pair_candidate_bank_delay2_w;
wire pair_candidate_bank_delay1_re;
wire [7:0] pair_candidate_bank_delay1_r;
wire [7:0] pair_candidate_bank_delay1_w;
wire pair_candidate_bank_delay0_re;
wire [7:0] pair_candidate_bank_delay0_r;
wire [7:0] pair_candidate_bank_delay0_w;
wire pair_candidate_bank_multiplier0_re;
wire [3:0] pair_candidate_bank_multiplier0_r;
wire [3:0] pair_candidate_bank_multiplier0_w;
wire pair_candidate_bank_sel;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_reference_x = x;
assign pair_reference_phase = phase;
assign pair_reference_bank_bus_adr = csr_adr;
assign pair_reference_bank_bus_we = csr_we;
assign pair_reference_bank_bus_dat_w = csr_dat_w;
assign pair_candidate_x = x;
assign pair_candidate_phase = phase;
assign pair_candidate_bank_bus_adr = csr_adr;
assign pair_candidate_bank_bus_we = csr_we;
assign pair_candidate_bank_bus_dat_w = csr_dat_w;
assign ref_i = pair_reference_i;
assign ref_q = pair_reference_q0;
assign ref_phase = pair_reference_zi;
assign ref_delay = pair_reference_delay_storage;
assign ref_mult = pair_reference_multiplier_storage;
assign ref_read = pair_reference_bank_bus_dat_r;
assign cand_i = pair_candidate_i;
assign cand_q = pair_candidate_q0;
assign cand_phase = pair_candidate_zi;
assign cand_delay = pair_candidate_delay_storage;
assign cand_mult = pair_candidate_multiplier_storage;
assign cand_read = pair_candidate_bank_bus_dat_r;
assign pair_reference_xi = pair_reference_x;
assign pair_reference_zi = (((pair_reference_phase * pair_reference_multiplier_storage) + pair_reference_delay_storage) <<< 1'd1);
assign pair_reference_i = (pair_reference_cordic_xo >>> 1'd1);
assign pair_reference_q0 = (pair_reference_cordic_yo >>> 1'd1);
assign pair_reference_cordic0 = (pair_reference_cordic_xi <<< 2'd2);
assign pair_reference_cordic16 = (pair_reference_cordic_yi <<< 2'd2);
assign pair_reference_cordic32 = (pair_reference_cordic_zi <<< 2'd2);
assign pair_reference_cordic_xo = (pair_reference_cordic15 >>> 2'd2);
assign pair_reference_cordic_yo = (pair_reference_cordic31 >>> 2'd2);
assign pair_reference_cordic_zo = (pair_reference_cordic47 >>> 2'd2);
assign pair_reference_cordic_new_out = 1'd1;
assign pair_reference_cordic_new_in = 1'd1;
assign pair_reference_cordic_dir0 = (pair_reference_cordic32 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir1 = (pair_reference_cordic33 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir2 = (pair_reference_cordic34 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir3 = (pair_reference_cordic35 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir4 = (pair_reference_cordic36 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir5 = (pair_reference_cordic37 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir6 = (pair_reference_cordic38 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir7 = (pair_reference_cordic39 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir8 = (pair_reference_cordic40 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir9 = (pair_reference_cordic41 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir10 = (pair_reference_cordic42 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir11 = (pair_reference_cordic43 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir12 = (pair_reference_cordic44 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir13 = (pair_reference_cordic45 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir14 = (pair_reference_cordic46 < $signed({1'd0, 1'd0}));
assign pair_reference_q1 = (pair_reference_zi[13] ^ pair_reference_zi[14]);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_reference_cordic_xi <= 15'sd0;
	pair_reference_cordic_yi <= 15'sd0;
	pair_reference_cordic_zi <= 15'sd0;
	if (pair_reference_q1) begin
		{pair_reference_cordic_zi, pair_reference_cordic_yi, pair_reference_cordic_xi} <= {(pair_reference_zi + $signed({1'd0, 15'd16384})), (-pair_reference_yi), (-pair_reference_xi)};
	end else begin
		{pair_reference_cordic_zi, pair_reference_cordic_yi, pair_reference_cordic_xi} <= {pair_reference_zi, pair_reference_yi, pair_reference_xi};
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_candidate_phase_value = (((pair_candidate_phase * pair_candidate_multiplier_storage) + pair_candidate_delay_storage) <<< 1'd1);
assign pair_candidate_xi = pair_candidate_x;
assign pair_candidate_zi = pair_candidate_phase_value;
assign pair_candidate_yi = 1'd0;
assign pair_candidate_i = (pair_candidate_speculativedemodcordic_xo >>> 1'd1);
assign pair_candidate_q0 = (pair_candidate_speculativedemodcordic_yo >>> 1'd1);
assign pair_candidate_speculativedemodcordic0 = (pair_candidate_speculativedemodcordic_xi <<< 2'd2);
assign pair_candidate_speculativedemodcordic16 = (pair_candidate_speculativedemodcordic_yi <<< 2'd2);
assign pair_candidate_speculativedemodcordic32 = (pair_candidate_speculativedemodcordic_zi <<< 2'd2);
assign pair_candidate_speculativedemodcordic_xo = (pair_candidate_speculativedemodcordic15 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_yo = (pair_candidate_speculativedemodcordic31 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_zo = (pair_candidate_speculativedemodcordic47 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_new_out = 1'd1;
assign pair_candidate_speculativedemodcordic_new_in = 1'd1;
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0 = (pair_candidate_speculativedemodcordic32 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic0 = (pair_candidate_x <<< 2'd2);
assign pair_candidate_speculativedemodcordic_speculativedemodcordic1 = (-pair_candidate_speculativedemodcordic_speculativedemodcordic0);
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 = (pair_candidate_speculativedemodcordic33 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 = (pair_candidate_speculativedemodcordic34 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 = (pair_candidate_speculativedemodcordic35 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 = (pair_candidate_speculativedemodcordic36 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 = (pair_candidate_speculativedemodcordic37 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 = (pair_candidate_speculativedemodcordic38 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 = (pair_candidate_speculativedemodcordic39 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 = (pair_candidate_speculativedemodcordic40 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 = (pair_candidate_speculativedemodcordic41 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 = (pair_candidate_speculativedemodcordic42 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 = (pair_candidate_speculativedemodcordic43 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 = (pair_candidate_speculativedemodcordic44 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 = (pair_candidate_speculativedemodcordic45 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 = (pair_candidate_speculativedemodcordic46 < $signed({1'd0, 1'd0}));
assign pair_candidate_q1 = (pair_candidate_zi[13] ^ pair_candidate_zi[14]);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_candidate_speculativedemodcordic_xi <= 15'sd0;
	pair_candidate_speculativedemodcordic_yi <= 15'sd0;
	pair_candidate_speculativedemodcordic_zi <= 15'sd0;
	if (pair_candidate_q1) begin
		{pair_candidate_speculativedemodcordic_zi, pair_candidate_speculativedemodcordic_yi, pair_candidate_speculativedemodcordic_xi} <= {(pair_candidate_zi + $signed({1'd0, 15'd16384})), (-pair_candidate_yi), (-pair_candidate_xi)};
	end else begin
		{pair_candidate_speculativedemodcordic_zi, pair_candidate_speculativedemodcordic_yi, pair_candidate_speculativedemodcordic_xi} <= {pair_candidate_zi, pair_candidate_yi, pair_candidate_xi};
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_reference_bank_sel = (pair_reference_bank_bus_adr[13:9] == 1'd0);
assign pair_reference_bank_delay3_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_delay3_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 1'd0));
assign pair_reference_bank_delay2_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_delay2_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 1'd1));
assign pair_reference_bank_delay1_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_delay1_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 2'd2));
assign pair_reference_bank_delay0_r = pair_reference_bank_bus_dat_w[7:0];
assign pair_reference_bank_delay0_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 2'd3));
assign pair_reference_bank_multiplier0_r = pair_reference_bank_bus_dat_w[3:0];
assign pair_reference_bank_multiplier0_re = ((pair_reference_bank_sel & pair_reference_bank_bus_we) & (pair_reference_bank_bus_adr[2:0] == 3'd4));
assign pair_reference_delay_storage = pair_reference_delay_storage_full[31:0];
assign pair_reference_bank_delay3_w = pair_reference_delay_storage_full[31:24];
assign pair_reference_bank_delay2_w = pair_reference_delay_storage_full[23:16];
assign pair_reference_bank_delay1_w = pair_reference_delay_storage_full[15:8];
assign pair_reference_bank_delay0_w = pair_reference_delay_storage_full[7:0];
assign pair_reference_multiplier_storage = pair_reference_multiplier_storage_full[3:0];
assign pair_reference_bank_multiplier0_w = pair_reference_multiplier_storage_full[3:0];
assign pair_candidate_bank_sel = (pair_candidate_bank_bus_adr[13:9] == 1'd0);
assign pair_candidate_bank_delay3_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_delay3_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 1'd0));
assign pair_candidate_bank_delay2_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_delay2_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 1'd1));
assign pair_candidate_bank_delay1_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_delay1_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 2'd2));
assign pair_candidate_bank_delay0_r = pair_candidate_bank_bus_dat_w[7:0];
assign pair_candidate_bank_delay0_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 2'd3));
assign pair_candidate_bank_multiplier0_r = pair_candidate_bank_bus_dat_w[3:0];
assign pair_candidate_bank_multiplier0_re = ((pair_candidate_bank_sel & pair_candidate_bank_bus_we) & (pair_candidate_bank_bus_adr[2:0] == 3'd4));
assign pair_candidate_delay_storage = pair_candidate_delay_storage_full[31:0];
assign pair_candidate_bank_delay3_w = pair_candidate_delay_storage_full[31:24];
assign pair_candidate_bank_delay2_w = pair_candidate_delay_storage_full[23:16];
assign pair_candidate_bank_delay1_w = pair_candidate_delay_storage_full[15:8];
assign pair_candidate_bank_delay0_w = pair_candidate_delay_storage_full[7:0];
assign pair_candidate_multiplier_storage = pair_candidate_multiplier_storage_full[3:0];
assign pair_candidate_bank_multiplier0_w = pair_candidate_multiplier_storage_full[3:0];

always @(posedge sys_clk) begin
	pair_reference_cordic1 <= (pair_reference_cordic0 + (pair_reference_cordic_dir0 ? (pair_reference_cordic16 >>> 1'd0) : (-(pair_reference_cordic16 >>> 1'd0))));
	pair_reference_cordic17 <= (pair_reference_cordic16 + (pair_reference_cordic_dir0 ? (-(pair_reference_cordic0 >>> 1'd0)) : (pair_reference_cordic0 >>> 1'd0)));
	pair_reference_cordic33 <= (pair_reference_cordic32 + (pair_reference_cordic_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	pair_reference_cordic2 <= (pair_reference_cordic1 + (pair_reference_cordic_dir1 ? (pair_reference_cordic17 >>> 1'd1) : (-(pair_reference_cordic17 >>> 1'd1))));
	pair_reference_cordic18 <= (pair_reference_cordic17 + (pair_reference_cordic_dir1 ? (-(pair_reference_cordic1 >>> 1'd1)) : (pair_reference_cordic1 >>> 1'd1)));
	pair_reference_cordic34 <= (pair_reference_cordic33 + (pair_reference_cordic_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	pair_reference_cordic3 <= (pair_reference_cordic2 + (pair_reference_cordic_dir2 ? (pair_reference_cordic18 >>> 2'd2) : (-(pair_reference_cordic18 >>> 2'd2))));
	pair_reference_cordic19 <= (pair_reference_cordic18 + (pair_reference_cordic_dir2 ? (-(pair_reference_cordic2 >>> 2'd2)) : (pair_reference_cordic2 >>> 2'd2)));
	pair_reference_cordic35 <= (pair_reference_cordic34 + (pair_reference_cordic_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	pair_reference_cordic4 <= (pair_reference_cordic3 + (pair_reference_cordic_dir3 ? (pair_reference_cordic19 >>> 2'd3) : (-(pair_reference_cordic19 >>> 2'd3))));
	pair_reference_cordic20 <= (pair_reference_cordic19 + (pair_reference_cordic_dir3 ? (-(pair_reference_cordic3 >>> 2'd3)) : (pair_reference_cordic3 >>> 2'd3)));
	pair_reference_cordic36 <= (pair_reference_cordic35 + (pair_reference_cordic_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	pair_reference_cordic5 <= (pair_reference_cordic4 + (pair_reference_cordic_dir4 ? (pair_reference_cordic20 >>> 3'd4) : (-(pair_reference_cordic20 >>> 3'd4))));
	pair_reference_cordic21 <= (pair_reference_cordic20 + (pair_reference_cordic_dir4 ? (-(pair_reference_cordic4 >>> 3'd4)) : (pair_reference_cordic4 >>> 3'd4)));
	pair_reference_cordic37 <= (pair_reference_cordic36 + (pair_reference_cordic_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	pair_reference_cordic6 <= (pair_reference_cordic5 + (pair_reference_cordic_dir5 ? (pair_reference_cordic21 >>> 3'd5) : (-(pair_reference_cordic21 >>> 3'd5))));
	pair_reference_cordic22 <= (pair_reference_cordic21 + (pair_reference_cordic_dir5 ? (-(pair_reference_cordic5 >>> 3'd5)) : (pair_reference_cordic5 >>> 3'd5)));
	pair_reference_cordic38 <= (pair_reference_cordic37 + (pair_reference_cordic_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_reference_cordic7 <= (pair_reference_cordic6 + (pair_reference_cordic_dir6 ? (pair_reference_cordic22 >>> 3'd6) : (-(pair_reference_cordic22 >>> 3'd6))));
	pair_reference_cordic23 <= (pair_reference_cordic22 + (pair_reference_cordic_dir6 ? (-(pair_reference_cordic6 >>> 3'd6)) : (pair_reference_cordic6 >>> 3'd6)));
	pair_reference_cordic39 <= (pair_reference_cordic38 + (pair_reference_cordic_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_reference_cordic8 <= (pair_reference_cordic7 + (pair_reference_cordic_dir7 ? (pair_reference_cordic23 >>> 3'd7) : (-(pair_reference_cordic23 >>> 3'd7))));
	pair_reference_cordic24 <= (pair_reference_cordic23 + (pair_reference_cordic_dir7 ? (-(pair_reference_cordic7 >>> 3'd7)) : (pair_reference_cordic7 >>> 3'd7)));
	pair_reference_cordic40 <= (pair_reference_cordic39 + (pair_reference_cordic_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_reference_cordic9 <= (pair_reference_cordic8 + (pair_reference_cordic_dir8 ? (pair_reference_cordic24 >>> 4'd8) : (-(pair_reference_cordic24 >>> 4'd8))));
	pair_reference_cordic25 <= (pair_reference_cordic24 + (pair_reference_cordic_dir8 ? (-(pair_reference_cordic8 >>> 4'd8)) : (pair_reference_cordic8 >>> 4'd8)));
	pair_reference_cordic41 <= (pair_reference_cordic40 + (pair_reference_cordic_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_reference_cordic10 <= (pair_reference_cordic9 + (pair_reference_cordic_dir9 ? (pair_reference_cordic25 >>> 4'd9) : (-(pair_reference_cordic25 >>> 4'd9))));
	pair_reference_cordic26 <= (pair_reference_cordic25 + (pair_reference_cordic_dir9 ? (-(pair_reference_cordic9 >>> 4'd9)) : (pair_reference_cordic9 >>> 4'd9)));
	pair_reference_cordic42 <= (pair_reference_cordic41 + (pair_reference_cordic_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_reference_cordic11 <= (pair_reference_cordic10 + (pair_reference_cordic_dir10 ? (pair_reference_cordic26 >>> 4'd10) : (-(pair_reference_cordic26 >>> 4'd10))));
	pair_reference_cordic27 <= (pair_reference_cordic26 + (pair_reference_cordic_dir10 ? (-(pair_reference_cordic10 >>> 4'd10)) : (pair_reference_cordic10 >>> 4'd10)));
	pair_reference_cordic43 <= (pair_reference_cordic42 + (pair_reference_cordic_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_reference_cordic12 <= (pair_reference_cordic11 + (pair_reference_cordic_dir11 ? (pair_reference_cordic27 >>> 4'd11) : (-(pair_reference_cordic27 >>> 4'd11))));
	pair_reference_cordic28 <= (pair_reference_cordic27 + (pair_reference_cordic_dir11 ? (-(pair_reference_cordic11 >>> 4'd11)) : (pair_reference_cordic11 >>> 4'd11)));
	pair_reference_cordic44 <= (pair_reference_cordic43 + (pair_reference_cordic_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_reference_cordic13 <= (pair_reference_cordic12 + (pair_reference_cordic_dir12 ? (pair_reference_cordic28 >>> 4'd12) : (-(pair_reference_cordic28 >>> 4'd12))));
	pair_reference_cordic29 <= (pair_reference_cordic28 + (pair_reference_cordic_dir12 ? (-(pair_reference_cordic12 >>> 4'd12)) : (pair_reference_cordic12 >>> 4'd12)));
	pair_reference_cordic45 <= (pair_reference_cordic44 + (pair_reference_cordic_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_reference_cordic14 <= (pair_reference_cordic13 + (pair_reference_cordic_dir13 ? (pair_reference_cordic29 >>> 4'd13) : (-(pair_reference_cordic29 >>> 4'd13))));
	pair_reference_cordic30 <= (pair_reference_cordic29 + (pair_reference_cordic_dir13 ? (-(pair_reference_cordic13 >>> 4'd13)) : (pair_reference_cordic13 >>> 4'd13)));
	pair_reference_cordic46 <= (pair_reference_cordic45 + (pair_reference_cordic_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_reference_cordic15 <= (pair_reference_cordic14 + (pair_reference_cordic_dir14 ? (pair_reference_cordic30 >>> 4'd14) : (-(pair_reference_cordic30 >>> 4'd14))));
	pair_reference_cordic31 <= (pair_reference_cordic30 + (pair_reference_cordic_dir14 ? (-(pair_reference_cordic14 >>> 4'd14)) : (pair_reference_cordic14 >>> 4'd14)));
	pair_reference_cordic47 <= (pair_reference_cordic46 + (pair_reference_cordic_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	pair_candidate_speculativedemodcordic1 <= ((pair_candidate_phase_value[13] ^ pair_candidate_phase_value[14]) ? pair_candidate_speculativedemodcordic_speculativedemodcordic1 : pair_candidate_speculativedemodcordic_speculativedemodcordic0);
	pair_candidate_speculativedemodcordic17 <= (pair_candidate_phase_value[14] ? pair_candidate_speculativedemodcordic_speculativedemodcordic1 : pair_candidate_speculativedemodcordic_speculativedemodcordic0);
	pair_candidate_speculativedemodcordic33 <= (pair_candidate_speculativedemodcordic32 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	pair_candidate_speculativedemodcordic2 <= (pair_candidate_speculativedemodcordic1 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? (pair_candidate_speculativedemodcordic17 >>> 1'd1) : (-(pair_candidate_speculativedemodcordic17 >>> 1'd1))));
	pair_candidate_speculativedemodcordic18 <= (pair_candidate_speculativedemodcordic17 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? (-(pair_candidate_speculativedemodcordic1 >>> 1'd1)) : (pair_candidate_speculativedemodcordic1 >>> 1'd1)));
	pair_candidate_speculativedemodcordic34 <= (pair_candidate_speculativedemodcordic33 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	pair_candidate_speculativedemodcordic3 <= (pair_candidate_speculativedemodcordic2 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? (pair_candidate_speculativedemodcordic18 >>> 2'd2) : (-(pair_candidate_speculativedemodcordic18 >>> 2'd2))));
	pair_candidate_speculativedemodcordic19 <= (pair_candidate_speculativedemodcordic18 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? (-(pair_candidate_speculativedemodcordic2 >>> 2'd2)) : (pair_candidate_speculativedemodcordic2 >>> 2'd2)));
	pair_candidate_speculativedemodcordic35 <= (pair_candidate_speculativedemodcordic34 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	pair_candidate_speculativedemodcordic4 <= (pair_candidate_speculativedemodcordic3 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? (pair_candidate_speculativedemodcordic19 >>> 2'd3) : (-(pair_candidate_speculativedemodcordic19 >>> 2'd3))));
	pair_candidate_speculativedemodcordic20 <= (pair_candidate_speculativedemodcordic19 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? (-(pair_candidate_speculativedemodcordic3 >>> 2'd3)) : (pair_candidate_speculativedemodcordic3 >>> 2'd3)));
	pair_candidate_speculativedemodcordic36 <= (pair_candidate_speculativedemodcordic35 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	pair_candidate_speculativedemodcordic5 <= (pair_candidate_speculativedemodcordic4 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? (pair_candidate_speculativedemodcordic20 >>> 3'd4) : (-(pair_candidate_speculativedemodcordic20 >>> 3'd4))));
	pair_candidate_speculativedemodcordic21 <= (pair_candidate_speculativedemodcordic20 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? (-(pair_candidate_speculativedemodcordic4 >>> 3'd4)) : (pair_candidate_speculativedemodcordic4 >>> 3'd4)));
	pair_candidate_speculativedemodcordic37 <= (pair_candidate_speculativedemodcordic36 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	pair_candidate_speculativedemodcordic6 <= (pair_candidate_speculativedemodcordic5 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? (pair_candidate_speculativedemodcordic21 >>> 3'd5) : (-(pair_candidate_speculativedemodcordic21 >>> 3'd5))));
	pair_candidate_speculativedemodcordic22 <= (pair_candidate_speculativedemodcordic21 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? (-(pair_candidate_speculativedemodcordic5 >>> 3'd5)) : (pair_candidate_speculativedemodcordic5 >>> 3'd5)));
	pair_candidate_speculativedemodcordic38 <= (pair_candidate_speculativedemodcordic37 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_candidate_speculativedemodcordic7 <= (pair_candidate_speculativedemodcordic6 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? (pair_candidate_speculativedemodcordic22 >>> 3'd6) : (-(pair_candidate_speculativedemodcordic22 >>> 3'd6))));
	pair_candidate_speculativedemodcordic23 <= (pair_candidate_speculativedemodcordic22 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? (-(pair_candidate_speculativedemodcordic6 >>> 3'd6)) : (pair_candidate_speculativedemodcordic6 >>> 3'd6)));
	pair_candidate_speculativedemodcordic39 <= (pair_candidate_speculativedemodcordic38 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_candidate_speculativedemodcordic8 <= (pair_candidate_speculativedemodcordic7 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? (pair_candidate_speculativedemodcordic23 >>> 3'd7) : (-(pair_candidate_speculativedemodcordic23 >>> 3'd7))));
	pair_candidate_speculativedemodcordic24 <= (pair_candidate_speculativedemodcordic23 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? (-(pair_candidate_speculativedemodcordic7 >>> 3'd7)) : (pair_candidate_speculativedemodcordic7 >>> 3'd7)));
	pair_candidate_speculativedemodcordic40 <= (pair_candidate_speculativedemodcordic39 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_candidate_speculativedemodcordic9 <= (pair_candidate_speculativedemodcordic8 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? (pair_candidate_speculativedemodcordic24 >>> 4'd8) : (-(pair_candidate_speculativedemodcordic24 >>> 4'd8))));
	pair_candidate_speculativedemodcordic25 <= (pair_candidate_speculativedemodcordic24 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? (-(pair_candidate_speculativedemodcordic8 >>> 4'd8)) : (pair_candidate_speculativedemodcordic8 >>> 4'd8)));
	pair_candidate_speculativedemodcordic41 <= (pair_candidate_speculativedemodcordic40 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_candidate_speculativedemodcordic10 <= (pair_candidate_speculativedemodcordic9 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? (pair_candidate_speculativedemodcordic25 >>> 4'd9) : (-(pair_candidate_speculativedemodcordic25 >>> 4'd9))));
	pair_candidate_speculativedemodcordic26 <= (pair_candidate_speculativedemodcordic25 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? (-(pair_candidate_speculativedemodcordic9 >>> 4'd9)) : (pair_candidate_speculativedemodcordic9 >>> 4'd9)));
	pair_candidate_speculativedemodcordic42 <= (pair_candidate_speculativedemodcordic41 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_candidate_speculativedemodcordic11 <= (pair_candidate_speculativedemodcordic10 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? (pair_candidate_speculativedemodcordic26 >>> 4'd10) : (-(pair_candidate_speculativedemodcordic26 >>> 4'd10))));
	pair_candidate_speculativedemodcordic27 <= (pair_candidate_speculativedemodcordic26 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? (-(pair_candidate_speculativedemodcordic10 >>> 4'd10)) : (pair_candidate_speculativedemodcordic10 >>> 4'd10)));
	pair_candidate_speculativedemodcordic43 <= (pair_candidate_speculativedemodcordic42 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_candidate_speculativedemodcordic12 <= (pair_candidate_speculativedemodcordic11 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? (pair_candidate_speculativedemodcordic27 >>> 4'd11) : (-(pair_candidate_speculativedemodcordic27 >>> 4'd11))));
	pair_candidate_speculativedemodcordic28 <= (pair_candidate_speculativedemodcordic27 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? (-(pair_candidate_speculativedemodcordic11 >>> 4'd11)) : (pair_candidate_speculativedemodcordic11 >>> 4'd11)));
	pair_candidate_speculativedemodcordic44 <= (pair_candidate_speculativedemodcordic43 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_candidate_speculativedemodcordic13 <= (pair_candidate_speculativedemodcordic12 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? (pair_candidate_speculativedemodcordic28 >>> 4'd12) : (-(pair_candidate_speculativedemodcordic28 >>> 4'd12))));
	pair_candidate_speculativedemodcordic29 <= (pair_candidate_speculativedemodcordic28 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? (-(pair_candidate_speculativedemodcordic12 >>> 4'd12)) : (pair_candidate_speculativedemodcordic12 >>> 4'd12)));
	pair_candidate_speculativedemodcordic45 <= (pair_candidate_speculativedemodcordic44 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_candidate_speculativedemodcordic14 <= (pair_candidate_speculativedemodcordic13 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? (pair_candidate_speculativedemodcordic29 >>> 4'd13) : (-(pair_candidate_speculativedemodcordic29 >>> 4'd13))));
	pair_candidate_speculativedemodcordic30 <= (pair_candidate_speculativedemodcordic29 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? (-(pair_candidate_speculativedemodcordic13 >>> 4'd13)) : (pair_candidate_speculativedemodcordic13 >>> 4'd13)));
	pair_candidate_speculativedemodcordic46 <= (pair_candidate_speculativedemodcordic45 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_candidate_speculativedemodcordic15 <= (pair_candidate_speculativedemodcordic14 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? (pair_candidate_speculativedemodcordic30 >>> 4'd14) : (-(pair_candidate_speculativedemodcordic30 >>> 4'd14))));
	pair_candidate_speculativedemodcordic31 <= (pair_candidate_speculativedemodcordic30 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? (-(pair_candidate_speculativedemodcordic14 >>> 4'd14)) : (pair_candidate_speculativedemodcordic14 >>> 4'd14)));
	pair_candidate_speculativedemodcordic47 <= (pair_candidate_speculativedemodcordic46 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	pair_reference_bank_bus_dat_r <= 1'd0;
	if (pair_reference_bank_sel) begin
		case (pair_reference_bank_bus_adr[2:0])
			1'd0: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_delay3_w;
			end
			1'd1: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_delay2_w;
			end
			2'd2: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_delay1_w;
			end
			2'd3: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_delay0_w;
			end
			3'd4: begin
				pair_reference_bank_bus_dat_r <= pair_reference_bank_multiplier0_w;
			end
		endcase
	end
	if (pair_reference_bank_delay3_re) begin
		pair_reference_delay_storage_full[31:24] <= pair_reference_bank_delay3_r;
	end
	if (pair_reference_bank_delay2_re) begin
		pair_reference_delay_storage_full[23:16] <= pair_reference_bank_delay2_r;
	end
	if (pair_reference_bank_delay1_re) begin
		pair_reference_delay_storage_full[15:8] <= pair_reference_bank_delay1_r;
	end
	if (pair_reference_bank_delay0_re) begin
		pair_reference_delay_storage_full[7:0] <= pair_reference_bank_delay0_r;
	end
	pair_reference_delay_re <= pair_reference_bank_delay0_re;
	if (pair_reference_bank_multiplier0_re) begin
		pair_reference_multiplier_storage_full[3:0] <= pair_reference_bank_multiplier0_r;
	end
	pair_reference_multiplier_re <= pair_reference_bank_multiplier0_re;
	pair_candidate_bank_bus_dat_r <= 1'd0;
	if (pair_candidate_bank_sel) begin
		case (pair_candidate_bank_bus_adr[2:0])
			1'd0: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_delay3_w;
			end
			1'd1: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_delay2_w;
			end
			2'd2: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_delay1_w;
			end
			2'd3: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_delay0_w;
			end
			3'd4: begin
				pair_candidate_bank_bus_dat_r <= pair_candidate_bank_multiplier0_w;
			end
		endcase
	end
	if (pair_candidate_bank_delay3_re) begin
		pair_candidate_delay_storage_full[31:24] <= pair_candidate_bank_delay3_r;
	end
	if (pair_candidate_bank_delay2_re) begin
		pair_candidate_delay_storage_full[23:16] <= pair_candidate_bank_delay2_r;
	end
	if (pair_candidate_bank_delay1_re) begin
		pair_candidate_delay_storage_full[15:8] <= pair_candidate_bank_delay1_r;
	end
	if (pair_candidate_bank_delay0_re) begin
		pair_candidate_delay_storage_full[7:0] <= pair_candidate_bank_delay0_r;
	end
	pair_candidate_delay_re <= pair_candidate_bank_delay0_re;
	if (pair_candidate_bank_multiplier0_re) begin
		pair_candidate_multiplier_storage_full[3:0] <= pair_candidate_bank_multiplier0_r;
	end
	pair_candidate_multiplier_re <= pair_candidate_bank_multiplier0_re;
	if (sys_rst) begin
		pair_reference_delay_storage_full <= 32'd0;
		pair_reference_delay_re <= 1'd0;
		pair_reference_multiplier_storage_full <= 4'd1;
		pair_reference_multiplier_re <= 1'd0;
		pair_reference_cordic1 <= 17'sd0;
		pair_reference_cordic2 <= 17'sd0;
		pair_reference_cordic3 <= 17'sd0;
		pair_reference_cordic4 <= 17'sd0;
		pair_reference_cordic5 <= 17'sd0;
		pair_reference_cordic6 <= 17'sd0;
		pair_reference_cordic7 <= 17'sd0;
		pair_reference_cordic8 <= 17'sd0;
		pair_reference_cordic9 <= 17'sd0;
		pair_reference_cordic10 <= 17'sd0;
		pair_reference_cordic11 <= 17'sd0;
		pair_reference_cordic12 <= 17'sd0;
		pair_reference_cordic13 <= 17'sd0;
		pair_reference_cordic14 <= 17'sd0;
		pair_reference_cordic15 <= 17'sd0;
		pair_reference_cordic17 <= 17'sd0;
		pair_reference_cordic18 <= 17'sd0;
		pair_reference_cordic19 <= 17'sd0;
		pair_reference_cordic20 <= 17'sd0;
		pair_reference_cordic21 <= 17'sd0;
		pair_reference_cordic22 <= 17'sd0;
		pair_reference_cordic23 <= 17'sd0;
		pair_reference_cordic24 <= 17'sd0;
		pair_reference_cordic25 <= 17'sd0;
		pair_reference_cordic26 <= 17'sd0;
		pair_reference_cordic27 <= 17'sd0;
		pair_reference_cordic28 <= 17'sd0;
		pair_reference_cordic29 <= 17'sd0;
		pair_reference_cordic30 <= 17'sd0;
		pair_reference_cordic31 <= 17'sd0;
		pair_reference_cordic33 <= 17'sd0;
		pair_reference_cordic34 <= 17'sd0;
		pair_reference_cordic35 <= 17'sd0;
		pair_reference_cordic36 <= 17'sd0;
		pair_reference_cordic37 <= 17'sd0;
		pair_reference_cordic38 <= 17'sd0;
		pair_reference_cordic39 <= 17'sd0;
		pair_reference_cordic40 <= 17'sd0;
		pair_reference_cordic41 <= 17'sd0;
		pair_reference_cordic42 <= 17'sd0;
		pair_reference_cordic43 <= 17'sd0;
		pair_reference_cordic44 <= 17'sd0;
		pair_reference_cordic45 <= 17'sd0;
		pair_reference_cordic46 <= 17'sd0;
		pair_reference_cordic47 <= 17'sd0;
		pair_candidate_delay_storage_full <= 32'd0;
		pair_candidate_delay_re <= 1'd0;
		pair_candidate_multiplier_storage_full <= 4'd1;
		pair_candidate_multiplier_re <= 1'd0;
		pair_candidate_speculativedemodcordic1 <= 17'sd0;
		pair_candidate_speculativedemodcordic2 <= 17'sd0;
		pair_candidate_speculativedemodcordic3 <= 17'sd0;
		pair_candidate_speculativedemodcordic4 <= 17'sd0;
		pair_candidate_speculativedemodcordic5 <= 17'sd0;
		pair_candidate_speculativedemodcordic6 <= 17'sd0;
		pair_candidate_speculativedemodcordic7 <= 17'sd0;
		pair_candidate_speculativedemodcordic8 <= 17'sd0;
		pair_candidate_speculativedemodcordic9 <= 17'sd0;
		pair_candidate_speculativedemodcordic10 <= 17'sd0;
		pair_candidate_speculativedemodcordic11 <= 17'sd0;
		pair_candidate_speculativedemodcordic12 <= 17'sd0;
		pair_candidate_speculativedemodcordic13 <= 17'sd0;
		pair_candidate_speculativedemodcordic14 <= 17'sd0;
		pair_candidate_speculativedemodcordic15 <= 17'sd0;
		pair_candidate_speculativedemodcordic17 <= 17'sd0;
		pair_candidate_speculativedemodcordic18 <= 17'sd0;
		pair_candidate_speculativedemodcordic19 <= 17'sd0;
		pair_candidate_speculativedemodcordic20 <= 17'sd0;
		pair_candidate_speculativedemodcordic21 <= 17'sd0;
		pair_candidate_speculativedemodcordic22 <= 17'sd0;
		pair_candidate_speculativedemodcordic23 <= 17'sd0;
		pair_candidate_speculativedemodcordic24 <= 17'sd0;
		pair_candidate_speculativedemodcordic25 <= 17'sd0;
		pair_candidate_speculativedemodcordic26 <= 17'sd0;
		pair_candidate_speculativedemodcordic27 <= 17'sd0;
		pair_candidate_speculativedemodcordic28 <= 17'sd0;
		pair_candidate_speculativedemodcordic29 <= 17'sd0;
		pair_candidate_speculativedemodcordic30 <= 17'sd0;
		pair_candidate_speculativedemodcordic31 <= 17'sd0;
		pair_candidate_speculativedemodcordic33 <= 17'sd0;
		pair_candidate_speculativedemodcordic34 <= 17'sd0;
		pair_candidate_speculativedemodcordic35 <= 17'sd0;
		pair_candidate_speculativedemodcordic36 <= 17'sd0;
		pair_candidate_speculativedemodcordic37 <= 17'sd0;
		pair_candidate_speculativedemodcordic38 <= 17'sd0;
		pair_candidate_speculativedemodcordic39 <= 17'sd0;
		pair_candidate_speculativedemodcordic40 <= 17'sd0;
		pair_candidate_speculativedemodcordic41 <= 17'sd0;
		pair_candidate_speculativedemodcordic42 <= 17'sd0;
		pair_candidate_speculativedemodcordic43 <= 17'sd0;
		pair_candidate_speculativedemodcordic44 <= 17'sd0;
		pair_candidate_speculativedemodcordic45 <= 17'sd0;
		pair_candidate_speculativedemodcordic46 <= 17'sd0;
		pair_candidate_speculativedemodcordic47 <= 17'sd0;
		pair_reference_bank_bus_dat_r <= 8'd0;
		pair_candidate_bank_bus_dat_r <= 8'd0;
	end
end

endmodule
