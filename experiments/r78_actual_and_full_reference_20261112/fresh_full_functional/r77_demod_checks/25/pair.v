/* Machine-generated using Migen */
module r77_demod_pair(
	input sys_clk,
	input sys_rst,
	input signed [24:0] x,
	input [24:0] phase,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output [24:0] ref_i,
	output [24:0] ref_q,
	output [25:0] ref_phase,
	output [31:0] ref_delay,
	output [3:0] ref_mult,
	output [7:0] ref_read,
	output [24:0] cand_i,
	output [24:0] cand_q,
	output [25:0] cand_phase,
	output [31:0] cand_delay,
	output [3:0] cand_mult,
	output [7:0] cand_read
);

wire signed [24:0] pair_reference_x;
wire signed [24:0] pair_reference_i;
wire signed [24:0] pair_reference_q0;
reg [31:0] pair_reference_delay_storage_full = 32'd0;
wire [31:0] pair_reference_delay_storage;
reg pair_reference_delay_re = 1'd0;
reg [3:0] pair_reference_multiplier_storage_full = 4'd1;
wire [3:0] pair_reference_multiplier_storage;
reg pair_reference_multiplier_re = 1'd0;
wire [24:0] pair_reference_phase;
reg signed [25:0] pair_reference_cordic_xi;
reg signed [25:0] pair_reference_cordic_yi;
reg signed [25:0] pair_reference_cordic_zi;
wire signed [25:0] pair_reference_cordic_xo;
wire signed [25:0] pair_reference_cordic_yo;
wire signed [25:0] pair_reference_cordic_zo;
wire pair_reference_cordic_new_in;
wire pair_reference_cordic_new_out;
wire signed [27:0] pair_reference_cordic0;
reg signed [27:0] pair_reference_cordic1 = 28'sd0;
reg signed [27:0] pair_reference_cordic2 = 28'sd0;
reg signed [27:0] pair_reference_cordic3 = 28'sd0;
reg signed [27:0] pair_reference_cordic4 = 28'sd0;
reg signed [27:0] pair_reference_cordic5 = 28'sd0;
reg signed [27:0] pair_reference_cordic6 = 28'sd0;
reg signed [27:0] pair_reference_cordic7 = 28'sd0;
reg signed [27:0] pair_reference_cordic8 = 28'sd0;
reg signed [27:0] pair_reference_cordic9 = 28'sd0;
reg signed [27:0] pair_reference_cordic10 = 28'sd0;
reg signed [27:0] pair_reference_cordic11 = 28'sd0;
reg signed [27:0] pair_reference_cordic12 = 28'sd0;
reg signed [27:0] pair_reference_cordic13 = 28'sd0;
reg signed [27:0] pair_reference_cordic14 = 28'sd0;
reg signed [27:0] pair_reference_cordic15 = 28'sd0;
reg signed [27:0] pair_reference_cordic16 = 28'sd0;
reg signed [27:0] pair_reference_cordic17 = 28'sd0;
reg signed [27:0] pair_reference_cordic18 = 28'sd0;
reg signed [27:0] pair_reference_cordic19 = 28'sd0;
reg signed [27:0] pair_reference_cordic20 = 28'sd0;
reg signed [27:0] pair_reference_cordic21 = 28'sd0;
reg signed [27:0] pair_reference_cordic22 = 28'sd0;
reg signed [27:0] pair_reference_cordic23 = 28'sd0;
reg signed [27:0] pair_reference_cordic24 = 28'sd0;
reg signed [27:0] pair_reference_cordic25 = 28'sd0;
reg signed [27:0] pair_reference_cordic26 = 28'sd0;
wire signed [27:0] pair_reference_cordic27;
reg signed [27:0] pair_reference_cordic28 = 28'sd0;
reg signed [27:0] pair_reference_cordic29 = 28'sd0;
reg signed [27:0] pair_reference_cordic30 = 28'sd0;
reg signed [27:0] pair_reference_cordic31 = 28'sd0;
reg signed [27:0] pair_reference_cordic32 = 28'sd0;
reg signed [27:0] pair_reference_cordic33 = 28'sd0;
reg signed [27:0] pair_reference_cordic34 = 28'sd0;
reg signed [27:0] pair_reference_cordic35 = 28'sd0;
reg signed [27:0] pair_reference_cordic36 = 28'sd0;
reg signed [27:0] pair_reference_cordic37 = 28'sd0;
reg signed [27:0] pair_reference_cordic38 = 28'sd0;
reg signed [27:0] pair_reference_cordic39 = 28'sd0;
reg signed [27:0] pair_reference_cordic40 = 28'sd0;
reg signed [27:0] pair_reference_cordic41 = 28'sd0;
reg signed [27:0] pair_reference_cordic42 = 28'sd0;
reg signed [27:0] pair_reference_cordic43 = 28'sd0;
reg signed [27:0] pair_reference_cordic44 = 28'sd0;
reg signed [27:0] pair_reference_cordic45 = 28'sd0;
reg signed [27:0] pair_reference_cordic46 = 28'sd0;
reg signed [27:0] pair_reference_cordic47 = 28'sd0;
reg signed [27:0] pair_reference_cordic48 = 28'sd0;
reg signed [27:0] pair_reference_cordic49 = 28'sd0;
reg signed [27:0] pair_reference_cordic50 = 28'sd0;
reg signed [27:0] pair_reference_cordic51 = 28'sd0;
reg signed [27:0] pair_reference_cordic52 = 28'sd0;
reg signed [27:0] pair_reference_cordic53 = 28'sd0;
wire signed [27:0] pair_reference_cordic54;
reg signed [27:0] pair_reference_cordic55 = 28'sd0;
reg signed [27:0] pair_reference_cordic56 = 28'sd0;
reg signed [27:0] pair_reference_cordic57 = 28'sd0;
reg signed [27:0] pair_reference_cordic58 = 28'sd0;
reg signed [27:0] pair_reference_cordic59 = 28'sd0;
reg signed [27:0] pair_reference_cordic60 = 28'sd0;
reg signed [27:0] pair_reference_cordic61 = 28'sd0;
reg signed [27:0] pair_reference_cordic62 = 28'sd0;
reg signed [27:0] pair_reference_cordic63 = 28'sd0;
reg signed [27:0] pair_reference_cordic64 = 28'sd0;
reg signed [27:0] pair_reference_cordic65 = 28'sd0;
reg signed [27:0] pair_reference_cordic66 = 28'sd0;
reg signed [27:0] pair_reference_cordic67 = 28'sd0;
reg signed [27:0] pair_reference_cordic68 = 28'sd0;
reg signed [27:0] pair_reference_cordic69 = 28'sd0;
reg signed [27:0] pair_reference_cordic70 = 28'sd0;
reg signed [27:0] pair_reference_cordic71 = 28'sd0;
reg signed [27:0] pair_reference_cordic72 = 28'sd0;
reg signed [27:0] pair_reference_cordic73 = 28'sd0;
reg signed [27:0] pair_reference_cordic74 = 28'sd0;
reg signed [27:0] pair_reference_cordic75 = 28'sd0;
reg signed [27:0] pair_reference_cordic76 = 28'sd0;
reg signed [27:0] pair_reference_cordic77 = 28'sd0;
reg signed [27:0] pair_reference_cordic78 = 28'sd0;
reg signed [27:0] pair_reference_cordic79 = 28'sd0;
reg signed [27:0] pair_reference_cordic80 = 28'sd0;
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
wire pair_reference_cordic_dir15;
wire pair_reference_cordic_dir16;
wire pair_reference_cordic_dir17;
wire pair_reference_cordic_dir18;
wire pair_reference_cordic_dir19;
wire pair_reference_cordic_dir20;
wire pair_reference_cordic_dir21;
wire pair_reference_cordic_dir22;
wire pair_reference_cordic_dir23;
wire pair_reference_cordic_dir24;
wire pair_reference_cordic_dir25;
wire signed [25:0] pair_reference_xi;
reg signed [25:0] pair_reference_yi = 26'sd0;
wire signed [25:0] pair_reference_zi;
wire pair_reference_q1;
wire signed [24:0] pair_candidate_x;
wire signed [24:0] pair_candidate_i;
wire signed [24:0] pair_candidate_q0;
reg [31:0] pair_candidate_delay_storage_full = 32'd0;
wire [31:0] pair_candidate_delay_storage;
reg pair_candidate_delay_re = 1'd0;
reg [3:0] pair_candidate_multiplier_storage_full = 4'd1;
wire [3:0] pair_candidate_multiplier_storage;
reg pair_candidate_multiplier_re = 1'd0;
wire [24:0] pair_candidate_phase;
wire signed [25:0] pair_candidate_phase_value;
reg signed [25:0] pair_candidate_speculativedemodcordic_xi;
reg signed [25:0] pair_candidate_speculativedemodcordic_yi;
reg signed [25:0] pair_candidate_speculativedemodcordic_zi;
wire signed [25:0] pair_candidate_speculativedemodcordic_xo;
wire signed [25:0] pair_candidate_speculativedemodcordic_yo;
wire signed [25:0] pair_candidate_speculativedemodcordic_zo;
wire pair_candidate_speculativedemodcordic_new_in;
wire pair_candidate_speculativedemodcordic_new_out;
wire signed [27:0] pair_candidate_speculativedemodcordic0;
reg signed [27:0] pair_candidate_speculativedemodcordic1 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic2 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic3 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic4 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic5 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic6 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic7 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic8 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic9 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic10 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic11 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic12 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic13 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic14 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic15 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic16 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic17 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic18 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic19 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic20 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic21 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic22 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic23 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic24 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic25 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic26 = 28'sd0;
wire signed [27:0] pair_candidate_speculativedemodcordic27;
reg signed [27:0] pair_candidate_speculativedemodcordic28 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic29 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic30 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic31 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic32 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic33 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic34 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic35 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic36 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic37 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic38 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic39 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic40 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic41 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic42 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic43 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic44 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic45 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic46 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic47 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic48 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic49 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic50 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic51 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic52 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic53 = 28'sd0;
wire signed [27:0] pair_candidate_speculativedemodcordic54;
reg signed [27:0] pair_candidate_speculativedemodcordic55 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic56 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic57 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic58 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic59 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic60 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic61 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic62 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic63 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic64 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic65 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic66 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic67 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic68 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic69 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic70 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic71 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic72 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic73 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic74 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic75 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic76 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic77 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic78 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic79 = 28'sd0;
reg signed [27:0] pair_candidate_speculativedemodcordic80 = 28'sd0;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0;
wire signed [27:0] pair_candidate_speculativedemodcordic_speculativedemodcordic0;
wire signed [27:0] pair_candidate_speculativedemodcordic_speculativedemodcordic1;
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
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir15;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir16;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir17;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir18;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir19;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir20;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir21;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir22;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir23;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir24;
wire pair_candidate_speculativedemodcordic_speculativedemodcordic_dir25;
wire signed [25:0] pair_candidate_xi;
wire signed [25:0] pair_candidate_yi;
wire signed [25:0] pair_candidate_zi;
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
assign pair_reference_cordic27 = (pair_reference_cordic_yi <<< 2'd2);
assign pair_reference_cordic54 = (pair_reference_cordic_zi <<< 2'd2);
assign pair_reference_cordic_xo = (pair_reference_cordic26 >>> 2'd2);
assign pair_reference_cordic_yo = (pair_reference_cordic53 >>> 2'd2);
assign pair_reference_cordic_zo = (pair_reference_cordic80 >>> 2'd2);
assign pair_reference_cordic_new_out = 1'd1;
assign pair_reference_cordic_new_in = 1'd1;
assign pair_reference_cordic_dir0 = (pair_reference_cordic54 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir1 = (pair_reference_cordic55 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir2 = (pair_reference_cordic56 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir3 = (pair_reference_cordic57 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir4 = (pair_reference_cordic58 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir5 = (pair_reference_cordic59 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir6 = (pair_reference_cordic60 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir7 = (pair_reference_cordic61 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir8 = (pair_reference_cordic62 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir9 = (pair_reference_cordic63 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir10 = (pair_reference_cordic64 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir11 = (pair_reference_cordic65 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir12 = (pair_reference_cordic66 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir13 = (pair_reference_cordic67 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir14 = (pair_reference_cordic68 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir15 = (pair_reference_cordic69 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir16 = (pair_reference_cordic70 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir17 = (pair_reference_cordic71 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir18 = (pair_reference_cordic72 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir19 = (pair_reference_cordic73 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir20 = (pair_reference_cordic74 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir21 = (pair_reference_cordic75 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir22 = (pair_reference_cordic76 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir23 = (pair_reference_cordic77 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir24 = (pair_reference_cordic78 < $signed({1'd0, 1'd0}));
assign pair_reference_cordic_dir25 = (pair_reference_cordic79 < $signed({1'd0, 1'd0}));
assign pair_reference_q1 = (pair_reference_zi[24] ^ pair_reference_zi[25]);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_reference_cordic_xi <= 26'sd0;
	pair_reference_cordic_yi <= 26'sd0;
	pair_reference_cordic_zi <= 26'sd0;
	if (pair_reference_q1) begin
		{pair_reference_cordic_zi, pair_reference_cordic_yi, pair_reference_cordic_xi} <= {(pair_reference_zi + $signed({1'd0, 26'd33554432})), (-pair_reference_yi), (-pair_reference_xi)};
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
assign pair_candidate_speculativedemodcordic27 = (pair_candidate_speculativedemodcordic_yi <<< 2'd2);
assign pair_candidate_speculativedemodcordic54 = (pair_candidate_speculativedemodcordic_zi <<< 2'd2);
assign pair_candidate_speculativedemodcordic_xo = (pair_candidate_speculativedemodcordic26 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_yo = (pair_candidate_speculativedemodcordic53 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_zo = (pair_candidate_speculativedemodcordic80 >>> 2'd2);
assign pair_candidate_speculativedemodcordic_new_out = 1'd1;
assign pair_candidate_speculativedemodcordic_new_in = 1'd1;
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0 = (pair_candidate_speculativedemodcordic54 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic0 = (pair_candidate_x <<< 2'd2);
assign pair_candidate_speculativedemodcordic_speculativedemodcordic1 = (-pair_candidate_speculativedemodcordic_speculativedemodcordic0);
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 = (pair_candidate_speculativedemodcordic55 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 = (pair_candidate_speculativedemodcordic56 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 = (pair_candidate_speculativedemodcordic57 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 = (pair_candidate_speculativedemodcordic58 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 = (pair_candidate_speculativedemodcordic59 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 = (pair_candidate_speculativedemodcordic60 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 = (pair_candidate_speculativedemodcordic61 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 = (pair_candidate_speculativedemodcordic62 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 = (pair_candidate_speculativedemodcordic63 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 = (pair_candidate_speculativedemodcordic64 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 = (pair_candidate_speculativedemodcordic65 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 = (pair_candidate_speculativedemodcordic66 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 = (pair_candidate_speculativedemodcordic67 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 = (pair_candidate_speculativedemodcordic68 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir15 = (pair_candidate_speculativedemodcordic69 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir16 = (pair_candidate_speculativedemodcordic70 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir17 = (pair_candidate_speculativedemodcordic71 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir18 = (pair_candidate_speculativedemodcordic72 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir19 = (pair_candidate_speculativedemodcordic73 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir20 = (pair_candidate_speculativedemodcordic74 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir21 = (pair_candidate_speculativedemodcordic75 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir22 = (pair_candidate_speculativedemodcordic76 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir23 = (pair_candidate_speculativedemodcordic77 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir24 = (pair_candidate_speculativedemodcordic78 < $signed({1'd0, 1'd0}));
assign pair_candidate_speculativedemodcordic_speculativedemodcordic_dir25 = (pair_candidate_speculativedemodcordic79 < $signed({1'd0, 1'd0}));
assign pair_candidate_q1 = (pair_candidate_zi[24] ^ pair_candidate_zi[25]);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_candidate_speculativedemodcordic_xi <= 26'sd0;
	pair_candidate_speculativedemodcordic_yi <= 26'sd0;
	pair_candidate_speculativedemodcordic_zi <= 26'sd0;
	if (pair_candidate_q1) begin
		{pair_candidate_speculativedemodcordic_zi, pair_candidate_speculativedemodcordic_yi, pair_candidate_speculativedemodcordic_xi} <= {(pair_candidate_zi + $signed({1'd0, 26'd33554432})), (-pair_candidate_yi), (-pair_candidate_xi)};
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
	pair_reference_cordic1 <= (pair_reference_cordic0 + (pair_reference_cordic_dir0 ? (pair_reference_cordic27 >>> 1'd0) : (-(pair_reference_cordic27 >>> 1'd0))));
	pair_reference_cordic28 <= (pair_reference_cordic27 + (pair_reference_cordic_dir0 ? (-(pair_reference_cordic0 >>> 1'd0)) : (pair_reference_cordic0 >>> 1'd0)));
	pair_reference_cordic55 <= (pair_reference_cordic54 + (pair_reference_cordic_dir0 ? $signed({1'd0, 26'd33554432}) : 26'sd33554432));
	pair_reference_cordic2 <= (pair_reference_cordic1 + (pair_reference_cordic_dir1 ? (pair_reference_cordic28 >>> 1'd1) : (-(pair_reference_cordic28 >>> 1'd1))));
	pair_reference_cordic29 <= (pair_reference_cordic28 + (pair_reference_cordic_dir1 ? (-(pair_reference_cordic1 >>> 1'd1)) : (pair_reference_cordic1 >>> 1'd1)));
	pair_reference_cordic56 <= (pair_reference_cordic55 + (pair_reference_cordic_dir1 ? $signed({1'd0, 25'd19808338}) : 26'sd47300526));
	pair_reference_cordic3 <= (pair_reference_cordic2 + (pair_reference_cordic_dir2 ? (pair_reference_cordic29 >>> 2'd2) : (-(pair_reference_cordic29 >>> 2'd2))));
	pair_reference_cordic30 <= (pair_reference_cordic29 + (pair_reference_cordic_dir2 ? (-(pair_reference_cordic2 >>> 2'd2)) : (pair_reference_cordic2 >>> 2'd2)));
	pair_reference_cordic57 <= (pair_reference_cordic56 + (pair_reference_cordic_dir2 ? $signed({1'd0, 24'd10466182}) : 25'sd23088250));
	pair_reference_cordic4 <= (pair_reference_cordic3 + (pair_reference_cordic_dir3 ? (pair_reference_cordic30 >>> 2'd3) : (-(pair_reference_cordic30 >>> 2'd3))));
	pair_reference_cordic31 <= (pair_reference_cordic30 + (pair_reference_cordic_dir3 ? (-(pair_reference_cordic3 >>> 2'd3)) : (pair_reference_cordic3 >>> 2'd3)));
	pair_reference_cordic58 <= (pair_reference_cordic57 + (pair_reference_cordic_dir3 ? $signed({1'd0, 23'd5312797}) : 24'sd11464419));
	pair_reference_cordic5 <= (pair_reference_cordic4 + (pair_reference_cordic_dir4 ? (pair_reference_cordic31 >>> 3'd4) : (-(pair_reference_cordic31 >>> 3'd4))));
	pair_reference_cordic32 <= (pair_reference_cordic31 + (pair_reference_cordic_dir4 ? (-(pair_reference_cordic4 >>> 3'd4)) : (pair_reference_cordic4 >>> 3'd4)));
	pair_reference_cordic59 <= (pair_reference_cordic58 + (pair_reference_cordic_dir4 ? $signed({1'd0, 22'd2666708}) : 23'sd5721900));
	pair_reference_cordic6 <= (pair_reference_cordic5 + (pair_reference_cordic_dir5 ? (pair_reference_cordic32 >>> 3'd5) : (-(pair_reference_cordic32 >>> 3'd5))));
	pair_reference_cordic33 <= (pair_reference_cordic32 + (pair_reference_cordic_dir5 ? (-(pair_reference_cordic5 >>> 3'd5)) : (pair_reference_cordic5 >>> 3'd5)));
	pair_reference_cordic60 <= (pair_reference_cordic59 + (pair_reference_cordic_dir5 ? $signed({1'd0, 21'd1334654}) : 22'sd2859650));
	pair_reference_cordic7 <= (pair_reference_cordic6 + (pair_reference_cordic_dir6 ? (pair_reference_cordic33 >>> 3'd6) : (-(pair_reference_cordic33 >>> 3'd6))));
	pair_reference_cordic34 <= (pair_reference_cordic33 + (pair_reference_cordic_dir6 ? (-(pair_reference_cordic6 >>> 3'd6)) : (pair_reference_cordic6 >>> 3'd6)));
	pair_reference_cordic61 <= (pair_reference_cordic60 + (pair_reference_cordic_dir6 ? $signed({1'd0, 20'd667490}) : 21'sd1429662));
	pair_reference_cordic8 <= (pair_reference_cordic7 + (pair_reference_cordic_dir7 ? (pair_reference_cordic34 >>> 3'd7) : (-(pair_reference_cordic34 >>> 3'd7))));
	pair_reference_cordic35 <= (pair_reference_cordic34 + (pair_reference_cordic_dir7 ? (-(pair_reference_cordic7 >>> 3'd7)) : (pair_reference_cordic7 >>> 3'd7)));
	pair_reference_cordic62 <= (pair_reference_cordic61 + (pair_reference_cordic_dir7 ? $signed({1'd0, 19'd333765}) : 20'sd714811));
	pair_reference_cordic9 <= (pair_reference_cordic8 + (pair_reference_cordic_dir8 ? (pair_reference_cordic35 >>> 4'd8) : (-(pair_reference_cordic35 >>> 4'd8))));
	pair_reference_cordic36 <= (pair_reference_cordic35 + (pair_reference_cordic_dir8 ? (-(pair_reference_cordic8 >>> 4'd8)) : (pair_reference_cordic8 >>> 4'd8)));
	pair_reference_cordic63 <= (pair_reference_cordic62 + (pair_reference_cordic_dir8 ? $signed({1'd0, 18'd166885}) : 19'sd357403));
	pair_reference_cordic10 <= (pair_reference_cordic9 + (pair_reference_cordic_dir9 ? (pair_reference_cordic36 >>> 4'd9) : (-(pair_reference_cordic36 >>> 4'd9))));
	pair_reference_cordic37 <= (pair_reference_cordic36 + (pair_reference_cordic_dir9 ? (-(pair_reference_cordic9 >>> 4'd9)) : (pair_reference_cordic9 >>> 4'd9)));
	pair_reference_cordic64 <= (pair_reference_cordic63 + (pair_reference_cordic_dir9 ? $signed({1'd0, 17'd83443}) : 18'sd178701));
	pair_reference_cordic11 <= (pair_reference_cordic10 + (pair_reference_cordic_dir10 ? (pair_reference_cordic37 >>> 4'd10) : (-(pair_reference_cordic37 >>> 4'd10))));
	pair_reference_cordic38 <= (pair_reference_cordic37 + (pair_reference_cordic_dir10 ? (-(pair_reference_cordic10 >>> 4'd10)) : (pair_reference_cordic10 >>> 4'd10)));
	pair_reference_cordic65 <= (pair_reference_cordic64 + (pair_reference_cordic_dir10 ? $signed({1'd0, 16'd41722}) : 17'sd89350));
	pair_reference_cordic12 <= (pair_reference_cordic11 + (pair_reference_cordic_dir11 ? (pair_reference_cordic38 >>> 4'd11) : (-(pair_reference_cordic38 >>> 4'd11))));
	pair_reference_cordic39 <= (pair_reference_cordic38 + (pair_reference_cordic_dir11 ? (-(pair_reference_cordic11 >>> 4'd11)) : (pair_reference_cordic11 >>> 4'd11)));
	pair_reference_cordic66 <= (pair_reference_cordic65 + (pair_reference_cordic_dir11 ? $signed({1'd0, 15'd20861}) : 16'sd44675));
	pair_reference_cordic13 <= (pair_reference_cordic12 + (pair_reference_cordic_dir12 ? (pair_reference_cordic39 >>> 4'd12) : (-(pair_reference_cordic39 >>> 4'd12))));
	pair_reference_cordic40 <= (pair_reference_cordic39 + (pair_reference_cordic_dir12 ? (-(pair_reference_cordic12 >>> 4'd12)) : (pair_reference_cordic12 >>> 4'd12)));
	pair_reference_cordic67 <= (pair_reference_cordic66 + (pair_reference_cordic_dir12 ? $signed({1'd0, 14'd10430}) : 15'sd22338));
	pair_reference_cordic14 <= (pair_reference_cordic13 + (pair_reference_cordic_dir13 ? (pair_reference_cordic40 >>> 4'd13) : (-(pair_reference_cordic40 >>> 4'd13))));
	pair_reference_cordic41 <= (pair_reference_cordic40 + (pair_reference_cordic_dir13 ? (-(pair_reference_cordic13 >>> 4'd13)) : (pair_reference_cordic13 >>> 4'd13)));
	pair_reference_cordic68 <= (pair_reference_cordic67 + (pair_reference_cordic_dir13 ? $signed({1'd0, 13'd5215}) : 14'sd11169));
	pair_reference_cordic15 <= (pair_reference_cordic14 + (pair_reference_cordic_dir14 ? (pair_reference_cordic41 >>> 4'd14) : (-(pair_reference_cordic41 >>> 4'd14))));
	pair_reference_cordic42 <= (pair_reference_cordic41 + (pair_reference_cordic_dir14 ? (-(pair_reference_cordic14 >>> 4'd14)) : (pair_reference_cordic14 >>> 4'd14)));
	pair_reference_cordic69 <= (pair_reference_cordic68 + (pair_reference_cordic_dir14 ? $signed({1'd0, 12'd2608}) : 13'sd5584));
	pair_reference_cordic16 <= (pair_reference_cordic15 + (pair_reference_cordic_dir15 ? (pair_reference_cordic42 >>> 4'd15) : (-(pair_reference_cordic42 >>> 4'd15))));
	pair_reference_cordic43 <= (pair_reference_cordic42 + (pair_reference_cordic_dir15 ? (-(pair_reference_cordic15 >>> 4'd15)) : (pair_reference_cordic15 >>> 4'd15)));
	pair_reference_cordic70 <= (pair_reference_cordic69 + (pair_reference_cordic_dir15 ? $signed({1'd0, 11'd1304}) : 12'sd2792));
	pair_reference_cordic17 <= (pair_reference_cordic16 + (pair_reference_cordic_dir16 ? (pair_reference_cordic43 >>> 5'd16) : (-(pair_reference_cordic43 >>> 5'd16))));
	pair_reference_cordic44 <= (pair_reference_cordic43 + (pair_reference_cordic_dir16 ? (-(pair_reference_cordic16 >>> 5'd16)) : (pair_reference_cordic16 >>> 5'd16)));
	pair_reference_cordic71 <= (pair_reference_cordic70 + (pair_reference_cordic_dir16 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_reference_cordic18 <= (pair_reference_cordic17 + (pair_reference_cordic_dir17 ? (pair_reference_cordic44 >>> 5'd17) : (-(pair_reference_cordic44 >>> 5'd17))));
	pair_reference_cordic45 <= (pair_reference_cordic44 + (pair_reference_cordic_dir17 ? (-(pair_reference_cordic17 >>> 5'd17)) : (pair_reference_cordic17 >>> 5'd17)));
	pair_reference_cordic72 <= (pair_reference_cordic71 + (pair_reference_cordic_dir17 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_reference_cordic19 <= (pair_reference_cordic18 + (pair_reference_cordic_dir18 ? (pair_reference_cordic45 >>> 5'd18) : (-(pair_reference_cordic45 >>> 5'd18))));
	pair_reference_cordic46 <= (pair_reference_cordic45 + (pair_reference_cordic_dir18 ? (-(pair_reference_cordic18 >>> 5'd18)) : (pair_reference_cordic18 >>> 5'd18)));
	pair_reference_cordic73 <= (pair_reference_cordic72 + (pair_reference_cordic_dir18 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_reference_cordic20 <= (pair_reference_cordic19 + (pair_reference_cordic_dir19 ? (pair_reference_cordic46 >>> 5'd19) : (-(pair_reference_cordic46 >>> 5'd19))));
	pair_reference_cordic47 <= (pair_reference_cordic46 + (pair_reference_cordic_dir19 ? (-(pair_reference_cordic19 >>> 5'd19)) : (pair_reference_cordic19 >>> 5'd19)));
	pair_reference_cordic74 <= (pair_reference_cordic73 + (pair_reference_cordic_dir19 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_reference_cordic21 <= (pair_reference_cordic20 + (pair_reference_cordic_dir20 ? (pair_reference_cordic47 >>> 5'd20) : (-(pair_reference_cordic47 >>> 5'd20))));
	pair_reference_cordic48 <= (pair_reference_cordic47 + (pair_reference_cordic_dir20 ? (-(pair_reference_cordic20 >>> 5'd20)) : (pair_reference_cordic20 >>> 5'd20)));
	pair_reference_cordic75 <= (pair_reference_cordic74 + (pair_reference_cordic_dir20 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_reference_cordic22 <= (pair_reference_cordic21 + (pair_reference_cordic_dir21 ? (pair_reference_cordic48 >>> 5'd21) : (-(pair_reference_cordic48 >>> 5'd21))));
	pair_reference_cordic49 <= (pair_reference_cordic48 + (pair_reference_cordic_dir21 ? (-(pair_reference_cordic21 >>> 5'd21)) : (pair_reference_cordic21 >>> 5'd21)));
	pair_reference_cordic76 <= (pair_reference_cordic75 + (pair_reference_cordic_dir21 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_reference_cordic23 <= (pair_reference_cordic22 + (pair_reference_cordic_dir22 ? (pair_reference_cordic49 >>> 5'd22) : (-(pair_reference_cordic49 >>> 5'd22))));
	pair_reference_cordic50 <= (pair_reference_cordic49 + (pair_reference_cordic_dir22 ? (-(pair_reference_cordic22 >>> 5'd22)) : (pair_reference_cordic22 >>> 5'd22)));
	pair_reference_cordic77 <= (pair_reference_cordic76 + (pair_reference_cordic_dir22 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_reference_cordic24 <= (pair_reference_cordic23 + (pair_reference_cordic_dir23 ? (pair_reference_cordic50 >>> 5'd23) : (-(pair_reference_cordic50 >>> 5'd23))));
	pair_reference_cordic51 <= (pair_reference_cordic50 + (pair_reference_cordic_dir23 ? (-(pair_reference_cordic23 >>> 5'd23)) : (pair_reference_cordic23 >>> 5'd23)));
	pair_reference_cordic78 <= (pair_reference_cordic77 + (pair_reference_cordic_dir23 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_reference_cordic25 <= (pair_reference_cordic24 + (pair_reference_cordic_dir24 ? (pair_reference_cordic51 >>> 5'd24) : (-(pair_reference_cordic51 >>> 5'd24))));
	pair_reference_cordic52 <= (pair_reference_cordic51 + (pair_reference_cordic_dir24 ? (-(pair_reference_cordic24 >>> 5'd24)) : (pair_reference_cordic24 >>> 5'd24)));
	pair_reference_cordic79 <= (pair_reference_cordic78 + (pair_reference_cordic_dir24 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_reference_cordic26 <= (pair_reference_cordic25 + (pair_reference_cordic_dir25 ? (pair_reference_cordic52 >>> 5'd25) : (-(pair_reference_cordic52 >>> 5'd25))));
	pair_reference_cordic53 <= (pair_reference_cordic52 + (pair_reference_cordic_dir25 ? (-(pair_reference_cordic25 >>> 5'd25)) : (pair_reference_cordic25 >>> 5'd25)));
	pair_reference_cordic80 <= (pair_reference_cordic79 + (pair_reference_cordic_dir25 ? $signed({1'd0, 1'd1}) : 1'sd1));
	pair_candidate_speculativedemodcordic1 <= ((pair_candidate_phase_value[24] ^ pair_candidate_phase_value[25]) ? pair_candidate_speculativedemodcordic_speculativedemodcordic1 : pair_candidate_speculativedemodcordic_speculativedemodcordic0);
	pair_candidate_speculativedemodcordic28 <= (pair_candidate_phase_value[25] ? pair_candidate_speculativedemodcordic_speculativedemodcordic1 : pair_candidate_speculativedemodcordic_speculativedemodcordic0);
	pair_candidate_speculativedemodcordic55 <= (pair_candidate_speculativedemodcordic54 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir0 ? $signed({1'd0, 26'd33554432}) : 26'sd33554432));
	pair_candidate_speculativedemodcordic2 <= (pair_candidate_speculativedemodcordic1 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? (pair_candidate_speculativedemodcordic28 >>> 1'd1) : (-(pair_candidate_speculativedemodcordic28 >>> 1'd1))));
	pair_candidate_speculativedemodcordic29 <= (pair_candidate_speculativedemodcordic28 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? (-(pair_candidate_speculativedemodcordic1 >>> 1'd1)) : (pair_candidate_speculativedemodcordic1 >>> 1'd1)));
	pair_candidate_speculativedemodcordic56 <= (pair_candidate_speculativedemodcordic55 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir1 ? $signed({1'd0, 25'd19808338}) : 26'sd47300526));
	pair_candidate_speculativedemodcordic3 <= (pair_candidate_speculativedemodcordic2 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? (pair_candidate_speculativedemodcordic29 >>> 2'd2) : (-(pair_candidate_speculativedemodcordic29 >>> 2'd2))));
	pair_candidate_speculativedemodcordic30 <= (pair_candidate_speculativedemodcordic29 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? (-(pair_candidate_speculativedemodcordic2 >>> 2'd2)) : (pair_candidate_speculativedemodcordic2 >>> 2'd2)));
	pair_candidate_speculativedemodcordic57 <= (pair_candidate_speculativedemodcordic56 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir2 ? $signed({1'd0, 24'd10466182}) : 25'sd23088250));
	pair_candidate_speculativedemodcordic4 <= (pair_candidate_speculativedemodcordic3 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? (pair_candidate_speculativedemodcordic30 >>> 2'd3) : (-(pair_candidate_speculativedemodcordic30 >>> 2'd3))));
	pair_candidate_speculativedemodcordic31 <= (pair_candidate_speculativedemodcordic30 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? (-(pair_candidate_speculativedemodcordic3 >>> 2'd3)) : (pair_candidate_speculativedemodcordic3 >>> 2'd3)));
	pair_candidate_speculativedemodcordic58 <= (pair_candidate_speculativedemodcordic57 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir3 ? $signed({1'd0, 23'd5312797}) : 24'sd11464419));
	pair_candidate_speculativedemodcordic5 <= (pair_candidate_speculativedemodcordic4 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? (pair_candidate_speculativedemodcordic31 >>> 3'd4) : (-(pair_candidate_speculativedemodcordic31 >>> 3'd4))));
	pair_candidate_speculativedemodcordic32 <= (pair_candidate_speculativedemodcordic31 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? (-(pair_candidate_speculativedemodcordic4 >>> 3'd4)) : (pair_candidate_speculativedemodcordic4 >>> 3'd4)));
	pair_candidate_speculativedemodcordic59 <= (pair_candidate_speculativedemodcordic58 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir4 ? $signed({1'd0, 22'd2666708}) : 23'sd5721900));
	pair_candidate_speculativedemodcordic6 <= (pair_candidate_speculativedemodcordic5 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? (pair_candidate_speculativedemodcordic32 >>> 3'd5) : (-(pair_candidate_speculativedemodcordic32 >>> 3'd5))));
	pair_candidate_speculativedemodcordic33 <= (pair_candidate_speculativedemodcordic32 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? (-(pair_candidate_speculativedemodcordic5 >>> 3'd5)) : (pair_candidate_speculativedemodcordic5 >>> 3'd5)));
	pair_candidate_speculativedemodcordic60 <= (pair_candidate_speculativedemodcordic59 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir5 ? $signed({1'd0, 21'd1334654}) : 22'sd2859650));
	pair_candidate_speculativedemodcordic7 <= (pair_candidate_speculativedemodcordic6 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? (pair_candidate_speculativedemodcordic33 >>> 3'd6) : (-(pair_candidate_speculativedemodcordic33 >>> 3'd6))));
	pair_candidate_speculativedemodcordic34 <= (pair_candidate_speculativedemodcordic33 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? (-(pair_candidate_speculativedemodcordic6 >>> 3'd6)) : (pair_candidate_speculativedemodcordic6 >>> 3'd6)));
	pair_candidate_speculativedemodcordic61 <= (pair_candidate_speculativedemodcordic60 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir6 ? $signed({1'd0, 20'd667490}) : 21'sd1429662));
	pair_candidate_speculativedemodcordic8 <= (pair_candidate_speculativedemodcordic7 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? (pair_candidate_speculativedemodcordic34 >>> 3'd7) : (-(pair_candidate_speculativedemodcordic34 >>> 3'd7))));
	pair_candidate_speculativedemodcordic35 <= (pair_candidate_speculativedemodcordic34 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? (-(pair_candidate_speculativedemodcordic7 >>> 3'd7)) : (pair_candidate_speculativedemodcordic7 >>> 3'd7)));
	pair_candidate_speculativedemodcordic62 <= (pair_candidate_speculativedemodcordic61 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir7 ? $signed({1'd0, 19'd333765}) : 20'sd714811));
	pair_candidate_speculativedemodcordic9 <= (pair_candidate_speculativedemodcordic8 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? (pair_candidate_speculativedemodcordic35 >>> 4'd8) : (-(pair_candidate_speculativedemodcordic35 >>> 4'd8))));
	pair_candidate_speculativedemodcordic36 <= (pair_candidate_speculativedemodcordic35 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? (-(pair_candidate_speculativedemodcordic8 >>> 4'd8)) : (pair_candidate_speculativedemodcordic8 >>> 4'd8)));
	pair_candidate_speculativedemodcordic63 <= (pair_candidate_speculativedemodcordic62 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir8 ? $signed({1'd0, 18'd166885}) : 19'sd357403));
	pair_candidate_speculativedemodcordic10 <= (pair_candidate_speculativedemodcordic9 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? (pair_candidate_speculativedemodcordic36 >>> 4'd9) : (-(pair_candidate_speculativedemodcordic36 >>> 4'd9))));
	pair_candidate_speculativedemodcordic37 <= (pair_candidate_speculativedemodcordic36 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? (-(pair_candidate_speculativedemodcordic9 >>> 4'd9)) : (pair_candidate_speculativedemodcordic9 >>> 4'd9)));
	pair_candidate_speculativedemodcordic64 <= (pair_candidate_speculativedemodcordic63 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir9 ? $signed({1'd0, 17'd83443}) : 18'sd178701));
	pair_candidate_speculativedemodcordic11 <= (pair_candidate_speculativedemodcordic10 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? (pair_candidate_speculativedemodcordic37 >>> 4'd10) : (-(pair_candidate_speculativedemodcordic37 >>> 4'd10))));
	pair_candidate_speculativedemodcordic38 <= (pair_candidate_speculativedemodcordic37 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? (-(pair_candidate_speculativedemodcordic10 >>> 4'd10)) : (pair_candidate_speculativedemodcordic10 >>> 4'd10)));
	pair_candidate_speculativedemodcordic65 <= (pair_candidate_speculativedemodcordic64 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir10 ? $signed({1'd0, 16'd41722}) : 17'sd89350));
	pair_candidate_speculativedemodcordic12 <= (pair_candidate_speculativedemodcordic11 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? (pair_candidate_speculativedemodcordic38 >>> 4'd11) : (-(pair_candidate_speculativedemodcordic38 >>> 4'd11))));
	pair_candidate_speculativedemodcordic39 <= (pair_candidate_speculativedemodcordic38 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? (-(pair_candidate_speculativedemodcordic11 >>> 4'd11)) : (pair_candidate_speculativedemodcordic11 >>> 4'd11)));
	pair_candidate_speculativedemodcordic66 <= (pair_candidate_speculativedemodcordic65 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir11 ? $signed({1'd0, 15'd20861}) : 16'sd44675));
	pair_candidate_speculativedemodcordic13 <= (pair_candidate_speculativedemodcordic12 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? (pair_candidate_speculativedemodcordic39 >>> 4'd12) : (-(pair_candidate_speculativedemodcordic39 >>> 4'd12))));
	pair_candidate_speculativedemodcordic40 <= (pair_candidate_speculativedemodcordic39 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? (-(pair_candidate_speculativedemodcordic12 >>> 4'd12)) : (pair_candidate_speculativedemodcordic12 >>> 4'd12)));
	pair_candidate_speculativedemodcordic67 <= (pair_candidate_speculativedemodcordic66 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir12 ? $signed({1'd0, 14'd10430}) : 15'sd22338));
	pair_candidate_speculativedemodcordic14 <= (pair_candidate_speculativedemodcordic13 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? (pair_candidate_speculativedemodcordic40 >>> 4'd13) : (-(pair_candidate_speculativedemodcordic40 >>> 4'd13))));
	pair_candidate_speculativedemodcordic41 <= (pair_candidate_speculativedemodcordic40 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? (-(pair_candidate_speculativedemodcordic13 >>> 4'd13)) : (pair_candidate_speculativedemodcordic13 >>> 4'd13)));
	pair_candidate_speculativedemodcordic68 <= (pair_candidate_speculativedemodcordic67 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir13 ? $signed({1'd0, 13'd5215}) : 14'sd11169));
	pair_candidate_speculativedemodcordic15 <= (pair_candidate_speculativedemodcordic14 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? (pair_candidate_speculativedemodcordic41 >>> 4'd14) : (-(pair_candidate_speculativedemodcordic41 >>> 4'd14))));
	pair_candidate_speculativedemodcordic42 <= (pair_candidate_speculativedemodcordic41 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? (-(pair_candidate_speculativedemodcordic14 >>> 4'd14)) : (pair_candidate_speculativedemodcordic14 >>> 4'd14)));
	pair_candidate_speculativedemodcordic69 <= (pair_candidate_speculativedemodcordic68 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir14 ? $signed({1'd0, 12'd2608}) : 13'sd5584));
	pair_candidate_speculativedemodcordic16 <= (pair_candidate_speculativedemodcordic15 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir15 ? (pair_candidate_speculativedemodcordic42 >>> 4'd15) : (-(pair_candidate_speculativedemodcordic42 >>> 4'd15))));
	pair_candidate_speculativedemodcordic43 <= (pair_candidate_speculativedemodcordic42 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir15 ? (-(pair_candidate_speculativedemodcordic15 >>> 4'd15)) : (pair_candidate_speculativedemodcordic15 >>> 4'd15)));
	pair_candidate_speculativedemodcordic70 <= (pair_candidate_speculativedemodcordic69 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir15 ? $signed({1'd0, 11'd1304}) : 12'sd2792));
	pair_candidate_speculativedemodcordic17 <= (pair_candidate_speculativedemodcordic16 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir16 ? (pair_candidate_speculativedemodcordic43 >>> 5'd16) : (-(pair_candidate_speculativedemodcordic43 >>> 5'd16))));
	pair_candidate_speculativedemodcordic44 <= (pair_candidate_speculativedemodcordic43 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir16 ? (-(pair_candidate_speculativedemodcordic16 >>> 5'd16)) : (pair_candidate_speculativedemodcordic16 >>> 5'd16)));
	pair_candidate_speculativedemodcordic71 <= (pair_candidate_speculativedemodcordic70 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir16 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	pair_candidate_speculativedemodcordic18 <= (pair_candidate_speculativedemodcordic17 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir17 ? (pair_candidate_speculativedemodcordic44 >>> 5'd17) : (-(pair_candidate_speculativedemodcordic44 >>> 5'd17))));
	pair_candidate_speculativedemodcordic45 <= (pair_candidate_speculativedemodcordic44 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir17 ? (-(pair_candidate_speculativedemodcordic17 >>> 5'd17)) : (pair_candidate_speculativedemodcordic17 >>> 5'd17)));
	pair_candidate_speculativedemodcordic72 <= (pair_candidate_speculativedemodcordic71 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir17 ? $signed({1'd0, 9'd326}) : 10'sd698));
	pair_candidate_speculativedemodcordic19 <= (pair_candidate_speculativedemodcordic18 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir18 ? (pair_candidate_speculativedemodcordic45 >>> 5'd18) : (-(pair_candidate_speculativedemodcordic45 >>> 5'd18))));
	pair_candidate_speculativedemodcordic46 <= (pair_candidate_speculativedemodcordic45 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir18 ? (-(pair_candidate_speculativedemodcordic18 >>> 5'd18)) : (pair_candidate_speculativedemodcordic18 >>> 5'd18)));
	pair_candidate_speculativedemodcordic73 <= (pair_candidate_speculativedemodcordic72 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir18 ? $signed({1'd0, 8'd163}) : 9'sd349));
	pair_candidate_speculativedemodcordic20 <= (pair_candidate_speculativedemodcordic19 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir19 ? (pair_candidate_speculativedemodcordic46 >>> 5'd19) : (-(pair_candidate_speculativedemodcordic46 >>> 5'd19))));
	pair_candidate_speculativedemodcordic47 <= (pair_candidate_speculativedemodcordic46 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir19 ? (-(pair_candidate_speculativedemodcordic19 >>> 5'd19)) : (pair_candidate_speculativedemodcordic19 >>> 5'd19)));
	pair_candidate_speculativedemodcordic74 <= (pair_candidate_speculativedemodcordic73 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir19 ? $signed({1'd0, 7'd81}) : 8'sd175));
	pair_candidate_speculativedemodcordic21 <= (pair_candidate_speculativedemodcordic20 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir20 ? (pair_candidate_speculativedemodcordic47 >>> 5'd20) : (-(pair_candidate_speculativedemodcordic47 >>> 5'd20))));
	pair_candidate_speculativedemodcordic48 <= (pair_candidate_speculativedemodcordic47 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir20 ? (-(pair_candidate_speculativedemodcordic20 >>> 5'd20)) : (pair_candidate_speculativedemodcordic20 >>> 5'd20)));
	pair_candidate_speculativedemodcordic75 <= (pair_candidate_speculativedemodcordic74 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir20 ? $signed({1'd0, 6'd41}) : 7'sd87));
	pair_candidate_speculativedemodcordic22 <= (pair_candidate_speculativedemodcordic21 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir21 ? (pair_candidate_speculativedemodcordic48 >>> 5'd21) : (-(pair_candidate_speculativedemodcordic48 >>> 5'd21))));
	pair_candidate_speculativedemodcordic49 <= (pair_candidate_speculativedemodcordic48 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir21 ? (-(pair_candidate_speculativedemodcordic21 >>> 5'd21)) : (pair_candidate_speculativedemodcordic21 >>> 5'd21)));
	pair_candidate_speculativedemodcordic76 <= (pair_candidate_speculativedemodcordic75 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir21 ? $signed({1'd0, 5'd20}) : 6'sd44));
	pair_candidate_speculativedemodcordic23 <= (pair_candidate_speculativedemodcordic22 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir22 ? (pair_candidate_speculativedemodcordic49 >>> 5'd22) : (-(pair_candidate_speculativedemodcordic49 >>> 5'd22))));
	pair_candidate_speculativedemodcordic50 <= (pair_candidate_speculativedemodcordic49 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir22 ? (-(pair_candidate_speculativedemodcordic22 >>> 5'd22)) : (pair_candidate_speculativedemodcordic22 >>> 5'd22)));
	pair_candidate_speculativedemodcordic77 <= (pair_candidate_speculativedemodcordic76 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir22 ? $signed({1'd0, 4'd10}) : 5'sd22));
	pair_candidate_speculativedemodcordic24 <= (pair_candidate_speculativedemodcordic23 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir23 ? (pair_candidate_speculativedemodcordic50 >>> 5'd23) : (-(pair_candidate_speculativedemodcordic50 >>> 5'd23))));
	pair_candidate_speculativedemodcordic51 <= (pair_candidate_speculativedemodcordic50 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir23 ? (-(pair_candidate_speculativedemodcordic23 >>> 5'd23)) : (pair_candidate_speculativedemodcordic23 >>> 5'd23)));
	pair_candidate_speculativedemodcordic78 <= (pair_candidate_speculativedemodcordic77 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir23 ? $signed({1'd0, 3'd5}) : 4'sd11));
	pair_candidate_speculativedemodcordic25 <= (pair_candidate_speculativedemodcordic24 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir24 ? (pair_candidate_speculativedemodcordic51 >>> 5'd24) : (-(pair_candidate_speculativedemodcordic51 >>> 5'd24))));
	pair_candidate_speculativedemodcordic52 <= (pair_candidate_speculativedemodcordic51 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir24 ? (-(pair_candidate_speculativedemodcordic24 >>> 5'd24)) : (pair_candidate_speculativedemodcordic24 >>> 5'd24)));
	pair_candidate_speculativedemodcordic79 <= (pair_candidate_speculativedemodcordic78 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir24 ? $signed({1'd0, 2'd3}) : 3'sd5));
	pair_candidate_speculativedemodcordic26 <= (pair_candidate_speculativedemodcordic25 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir25 ? (pair_candidate_speculativedemodcordic52 >>> 5'd25) : (-(pair_candidate_speculativedemodcordic52 >>> 5'd25))));
	pair_candidate_speculativedemodcordic53 <= (pair_candidate_speculativedemodcordic52 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir25 ? (-(pair_candidate_speculativedemodcordic25 >>> 5'd25)) : (pair_candidate_speculativedemodcordic25 >>> 5'd25)));
	pair_candidate_speculativedemodcordic80 <= (pair_candidate_speculativedemodcordic79 + (pair_candidate_speculativedemodcordic_speculativedemodcordic_dir25 ? $signed({1'd0, 1'd1}) : 1'sd1));
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
		pair_reference_cordic1 <= 28'sd0;
		pair_reference_cordic2 <= 28'sd0;
		pair_reference_cordic3 <= 28'sd0;
		pair_reference_cordic4 <= 28'sd0;
		pair_reference_cordic5 <= 28'sd0;
		pair_reference_cordic6 <= 28'sd0;
		pair_reference_cordic7 <= 28'sd0;
		pair_reference_cordic8 <= 28'sd0;
		pair_reference_cordic9 <= 28'sd0;
		pair_reference_cordic10 <= 28'sd0;
		pair_reference_cordic11 <= 28'sd0;
		pair_reference_cordic12 <= 28'sd0;
		pair_reference_cordic13 <= 28'sd0;
		pair_reference_cordic14 <= 28'sd0;
		pair_reference_cordic15 <= 28'sd0;
		pair_reference_cordic16 <= 28'sd0;
		pair_reference_cordic17 <= 28'sd0;
		pair_reference_cordic18 <= 28'sd0;
		pair_reference_cordic19 <= 28'sd0;
		pair_reference_cordic20 <= 28'sd0;
		pair_reference_cordic21 <= 28'sd0;
		pair_reference_cordic22 <= 28'sd0;
		pair_reference_cordic23 <= 28'sd0;
		pair_reference_cordic24 <= 28'sd0;
		pair_reference_cordic25 <= 28'sd0;
		pair_reference_cordic26 <= 28'sd0;
		pair_reference_cordic28 <= 28'sd0;
		pair_reference_cordic29 <= 28'sd0;
		pair_reference_cordic30 <= 28'sd0;
		pair_reference_cordic31 <= 28'sd0;
		pair_reference_cordic32 <= 28'sd0;
		pair_reference_cordic33 <= 28'sd0;
		pair_reference_cordic34 <= 28'sd0;
		pair_reference_cordic35 <= 28'sd0;
		pair_reference_cordic36 <= 28'sd0;
		pair_reference_cordic37 <= 28'sd0;
		pair_reference_cordic38 <= 28'sd0;
		pair_reference_cordic39 <= 28'sd0;
		pair_reference_cordic40 <= 28'sd0;
		pair_reference_cordic41 <= 28'sd0;
		pair_reference_cordic42 <= 28'sd0;
		pair_reference_cordic43 <= 28'sd0;
		pair_reference_cordic44 <= 28'sd0;
		pair_reference_cordic45 <= 28'sd0;
		pair_reference_cordic46 <= 28'sd0;
		pair_reference_cordic47 <= 28'sd0;
		pair_reference_cordic48 <= 28'sd0;
		pair_reference_cordic49 <= 28'sd0;
		pair_reference_cordic50 <= 28'sd0;
		pair_reference_cordic51 <= 28'sd0;
		pair_reference_cordic52 <= 28'sd0;
		pair_reference_cordic53 <= 28'sd0;
		pair_reference_cordic55 <= 28'sd0;
		pair_reference_cordic56 <= 28'sd0;
		pair_reference_cordic57 <= 28'sd0;
		pair_reference_cordic58 <= 28'sd0;
		pair_reference_cordic59 <= 28'sd0;
		pair_reference_cordic60 <= 28'sd0;
		pair_reference_cordic61 <= 28'sd0;
		pair_reference_cordic62 <= 28'sd0;
		pair_reference_cordic63 <= 28'sd0;
		pair_reference_cordic64 <= 28'sd0;
		pair_reference_cordic65 <= 28'sd0;
		pair_reference_cordic66 <= 28'sd0;
		pair_reference_cordic67 <= 28'sd0;
		pair_reference_cordic68 <= 28'sd0;
		pair_reference_cordic69 <= 28'sd0;
		pair_reference_cordic70 <= 28'sd0;
		pair_reference_cordic71 <= 28'sd0;
		pair_reference_cordic72 <= 28'sd0;
		pair_reference_cordic73 <= 28'sd0;
		pair_reference_cordic74 <= 28'sd0;
		pair_reference_cordic75 <= 28'sd0;
		pair_reference_cordic76 <= 28'sd0;
		pair_reference_cordic77 <= 28'sd0;
		pair_reference_cordic78 <= 28'sd0;
		pair_reference_cordic79 <= 28'sd0;
		pair_reference_cordic80 <= 28'sd0;
		pair_candidate_delay_storage_full <= 32'd0;
		pair_candidate_delay_re <= 1'd0;
		pair_candidate_multiplier_storage_full <= 4'd1;
		pair_candidate_multiplier_re <= 1'd0;
		pair_candidate_speculativedemodcordic1 <= 28'sd0;
		pair_candidate_speculativedemodcordic2 <= 28'sd0;
		pair_candidate_speculativedemodcordic3 <= 28'sd0;
		pair_candidate_speculativedemodcordic4 <= 28'sd0;
		pair_candidate_speculativedemodcordic5 <= 28'sd0;
		pair_candidate_speculativedemodcordic6 <= 28'sd0;
		pair_candidate_speculativedemodcordic7 <= 28'sd0;
		pair_candidate_speculativedemodcordic8 <= 28'sd0;
		pair_candidate_speculativedemodcordic9 <= 28'sd0;
		pair_candidate_speculativedemodcordic10 <= 28'sd0;
		pair_candidate_speculativedemodcordic11 <= 28'sd0;
		pair_candidate_speculativedemodcordic12 <= 28'sd0;
		pair_candidate_speculativedemodcordic13 <= 28'sd0;
		pair_candidate_speculativedemodcordic14 <= 28'sd0;
		pair_candidate_speculativedemodcordic15 <= 28'sd0;
		pair_candidate_speculativedemodcordic16 <= 28'sd0;
		pair_candidate_speculativedemodcordic17 <= 28'sd0;
		pair_candidate_speculativedemodcordic18 <= 28'sd0;
		pair_candidate_speculativedemodcordic19 <= 28'sd0;
		pair_candidate_speculativedemodcordic20 <= 28'sd0;
		pair_candidate_speculativedemodcordic21 <= 28'sd0;
		pair_candidate_speculativedemodcordic22 <= 28'sd0;
		pair_candidate_speculativedemodcordic23 <= 28'sd0;
		pair_candidate_speculativedemodcordic24 <= 28'sd0;
		pair_candidate_speculativedemodcordic25 <= 28'sd0;
		pair_candidate_speculativedemodcordic26 <= 28'sd0;
		pair_candidate_speculativedemodcordic28 <= 28'sd0;
		pair_candidate_speculativedemodcordic29 <= 28'sd0;
		pair_candidate_speculativedemodcordic30 <= 28'sd0;
		pair_candidate_speculativedemodcordic31 <= 28'sd0;
		pair_candidate_speculativedemodcordic32 <= 28'sd0;
		pair_candidate_speculativedemodcordic33 <= 28'sd0;
		pair_candidate_speculativedemodcordic34 <= 28'sd0;
		pair_candidate_speculativedemodcordic35 <= 28'sd0;
		pair_candidate_speculativedemodcordic36 <= 28'sd0;
		pair_candidate_speculativedemodcordic37 <= 28'sd0;
		pair_candidate_speculativedemodcordic38 <= 28'sd0;
		pair_candidate_speculativedemodcordic39 <= 28'sd0;
		pair_candidate_speculativedemodcordic40 <= 28'sd0;
		pair_candidate_speculativedemodcordic41 <= 28'sd0;
		pair_candidate_speculativedemodcordic42 <= 28'sd0;
		pair_candidate_speculativedemodcordic43 <= 28'sd0;
		pair_candidate_speculativedemodcordic44 <= 28'sd0;
		pair_candidate_speculativedemodcordic45 <= 28'sd0;
		pair_candidate_speculativedemodcordic46 <= 28'sd0;
		pair_candidate_speculativedemodcordic47 <= 28'sd0;
		pair_candidate_speculativedemodcordic48 <= 28'sd0;
		pair_candidate_speculativedemodcordic49 <= 28'sd0;
		pair_candidate_speculativedemodcordic50 <= 28'sd0;
		pair_candidate_speculativedemodcordic51 <= 28'sd0;
		pair_candidate_speculativedemodcordic52 <= 28'sd0;
		pair_candidate_speculativedemodcordic53 <= 28'sd0;
		pair_candidate_speculativedemodcordic55 <= 28'sd0;
		pair_candidate_speculativedemodcordic56 <= 28'sd0;
		pair_candidate_speculativedemodcordic57 <= 28'sd0;
		pair_candidate_speculativedemodcordic58 <= 28'sd0;
		pair_candidate_speculativedemodcordic59 <= 28'sd0;
		pair_candidate_speculativedemodcordic60 <= 28'sd0;
		pair_candidate_speculativedemodcordic61 <= 28'sd0;
		pair_candidate_speculativedemodcordic62 <= 28'sd0;
		pair_candidate_speculativedemodcordic63 <= 28'sd0;
		pair_candidate_speculativedemodcordic64 <= 28'sd0;
		pair_candidate_speculativedemodcordic65 <= 28'sd0;
		pair_candidate_speculativedemodcordic66 <= 28'sd0;
		pair_candidate_speculativedemodcordic67 <= 28'sd0;
		pair_candidate_speculativedemodcordic68 <= 28'sd0;
		pair_candidate_speculativedemodcordic69 <= 28'sd0;
		pair_candidate_speculativedemodcordic70 <= 28'sd0;
		pair_candidate_speculativedemodcordic71 <= 28'sd0;
		pair_candidate_speculativedemodcordic72 <= 28'sd0;
		pair_candidate_speculativedemodcordic73 <= 28'sd0;
		pair_candidate_speculativedemodcordic74 <= 28'sd0;
		pair_candidate_speculativedemodcordic75 <= 28'sd0;
		pair_candidate_speculativedemodcordic76 <= 28'sd0;
		pair_candidate_speculativedemodcordic77 <= 28'sd0;
		pair_candidate_speculativedemodcordic78 <= 28'sd0;
		pair_candidate_speculativedemodcordic79 <= 28'sd0;
		pair_candidate_speculativedemodcordic80 <= 28'sd0;
		pair_reference_bank_bus_dat_r <= 8'd0;
		pair_candidate_bank_bus_dat_r <= 8'd0;
	end
end

endmodule
