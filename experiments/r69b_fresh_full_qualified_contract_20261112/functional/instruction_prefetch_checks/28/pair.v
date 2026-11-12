/* Machine-generated using Migen */
module prefetch_pair(
	input sys_clk,
	input sys_rst,
	input start,
	input advance,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	input [4:0] probe_index,
	output [4:0] idx,
	output [1:0] choice,
	output [7:0] csr_read,
	output [27:0] old_probe,
	output [27:0] new_probe,
	output [27:0] old_mag,
	output [27:0] new_mag,
	output [28:0] old_neg,
	output [28:0] new_neg,
	output old_pos,
	output new_pos,
	output [13:0] old_wait,
	output [13:0] new_wait
);

reg [27:0] pair_csrstorage0_storage_full = 28'd0;
wire [27:0] pair_csrstorage0_storage;
reg pair_csrstorage0_re = 1'd0;
reg [27:0] pair_csrstorage1_storage_full = 28'd0;
wire [27:0] pair_csrstorage1_storage;
reg pair_csrstorage1_re = 1'd0;
reg [27:0] pair_csrstorage2_storage_full = 28'd0;
wire [27:0] pair_csrstorage2_storage;
reg pair_csrstorage2_re = 1'd0;
reg [27:0] pair_csrstorage3_storage_full = 28'd0;
wire [27:0] pair_csrstorage3_storage;
reg pair_csrstorage3_re = 1'd0;
reg [27:0] pair_csrstorage4_storage_full = 28'd0;
wire [27:0] pair_csrstorage4_storage;
reg pair_csrstorage4_re = 1'd0;
reg [27:0] pair_csrstorage5_storage_full = 28'd0;
wire [27:0] pair_csrstorage5_storage;
reg pair_csrstorage5_re = 1'd0;
reg [27:0] pair_csrstorage6_storage_full = 28'd0;
wire [27:0] pair_csrstorage6_storage;
reg pair_csrstorage6_re = 1'd0;
reg [27:0] pair_csrstorage7_storage_full = 28'd0;
wire [27:0] pair_csrstorage7_storage;
reg pair_csrstorage7_re = 1'd0;
reg [27:0] pair_csrstorage8_storage_full = 28'd0;
wire [27:0] pair_csrstorage8_storage;
reg pair_csrstorage8_re = 1'd0;
reg [27:0] pair_csrstorage9_storage_full = 28'd0;
wire [27:0] pair_csrstorage9_storage;
reg pair_csrstorage9_re = 1'd0;
reg [27:0] pair_csrstorage10_storage_full = 28'd0;
wire [27:0] pair_csrstorage10_storage;
reg pair_csrstorage10_re = 1'd0;
reg [27:0] pair_csrstorage11_storage_full = 28'd0;
wire [27:0] pair_csrstorage11_storage;
reg pair_csrstorage11_re = 1'd0;
reg [27:0] pair_csrstorage12_storage_full = 28'd0;
wire [27:0] pair_csrstorage12_storage;
reg pair_csrstorage12_re = 1'd0;
reg [27:0] pair_csrstorage13_storage_full = 28'd0;
wire [27:0] pair_csrstorage13_storage;
reg pair_csrstorage13_re = 1'd0;
reg [27:0] pair_csrstorage14_storage_full = 28'd0;
wire [27:0] pair_csrstorage14_storage;
reg pair_csrstorage14_re = 1'd0;
reg [27:0] pair_csrstorage15_storage_full = 28'd0;
wire [27:0] pair_csrstorage15_storage;
reg pair_csrstorage15_re = 1'd0;
reg [27:0] pair_csrstorage16_storage_full = 28'd0;
wire [27:0] pair_csrstorage16_storage;
reg pair_csrstorage16_re = 1'd0;
reg [27:0] pair_csrstorage17_storage_full = 28'd0;
wire [27:0] pair_csrstorage17_storage;
reg pair_csrstorage17_re = 1'd0;
reg [27:0] pair_csrstorage18_storage_full = 28'd0;
wire [27:0] pair_csrstorage18_storage;
reg pair_csrstorage18_re = 1'd0;
reg [27:0] pair_csrstorage19_storage_full = 28'd0;
wire [27:0] pair_csrstorage19_storage;
reg pair_csrstorage19_re = 1'd0;
reg [27:0] pair_csrstorage20_storage_full = 28'd0;
wire [27:0] pair_csrstorage20_storage;
reg pair_csrstorage20_re = 1'd0;
reg [27:0] pair_csrstorage21_storage_full = 28'd0;
wire [27:0] pair_csrstorage21_storage;
reg pair_csrstorage21_re = 1'd0;
reg [27:0] pair_csrstorage22_storage_full = 28'd0;
wire [27:0] pair_csrstorage22_storage;
reg pair_csrstorage22_re = 1'd0;
reg [27:0] pair_csrstorage23_storage_full = 28'd0;
wire [27:0] pair_csrstorage23_storage;
reg pair_csrstorage23_re = 1'd0;
reg [27:0] pair_csrstorage24_storage_full = 28'd0;
wire [27:0] pair_csrstorage24_storage;
reg pair_csrstorage24_re = 1'd0;
reg [27:0] pair_csrstorage25_storage_full = 28'd0;
wire [27:0] pair_csrstorage25_storage;
reg pair_csrstorage25_re = 1'd0;
reg [27:0] pair_csrstorage26_storage_full = 28'd0;
wire [27:0] pair_csrstorage26_storage;
reg pair_csrstorage26_re = 1'd0;
reg [27:0] pair_csrstorage27_storage_full = 28'd0;
wire [27:0] pair_csrstorage27_storage;
reg pair_csrstorage27_re = 1'd0;
reg [27:0] pair_csrstorage28_storage_full = 28'd0;
wire [27:0] pair_csrstorage28_storage;
reg pair_csrstorage28_re = 1'd0;
reg [27:0] pair_csrstorage29_storage_full = 28'd0;
wire [27:0] pair_csrstorage29_storage;
reg pair_csrstorage29_re = 1'd0;
reg [27:0] pair_csrstorage30_storage_full = 28'd0;
wire [27:0] pair_csrstorage30_storage;
reg pair_csrstorage30_re = 1'd0;
reg [27:0] pair_csrstorage31_storage_full = 28'd0;
wire [27:0] pair_csrstorage31_storage;
reg pair_csrstorage31_re = 1'd0;
reg [13:0] pair_csrstorage32_storage_full = 14'd0;
wire [13:0] pair_csrstorage32_storage;
reg pair_csrstorage32_re = 1'd0;
reg [13:0] pair_csrstorage33_storage_full = 14'd0;
wire [13:0] pair_csrstorage33_storage;
reg pair_csrstorage33_re = 1'd0;
reg [13:0] pair_csrstorage34_storage_full = 14'd0;
wire [13:0] pair_csrstorage34_storage;
reg pair_csrstorage34_re = 1'd0;
reg [13:0] pair_csrstorage35_storage_full = 14'd0;
wire [13:0] pair_csrstorage35_storage;
reg pair_csrstorage35_re = 1'd0;
reg [13:0] pair_csrstorage36_storage_full = 14'd0;
wire [13:0] pair_csrstorage36_storage;
reg pair_csrstorage36_re = 1'd0;
reg [13:0] pair_csrstorage37_storage_full = 14'd0;
wire [13:0] pair_csrstorage37_storage;
reg pair_csrstorage37_re = 1'd0;
reg [13:0] pair_csrstorage38_storage_full = 14'd0;
wire [13:0] pair_csrstorage38_storage;
reg pair_csrstorage38_re = 1'd0;
reg [13:0] pair_csrstorage39_storage_full = 14'd0;
wire [13:0] pair_csrstorage39_storage;
reg pair_csrstorage39_re = 1'd0;
reg [13:0] pair_csrstorage40_storage_full = 14'd0;
wire [13:0] pair_csrstorage40_storage;
reg pair_csrstorage40_re = 1'd0;
reg [13:0] pair_csrstorage41_storage_full = 14'd0;
wire [13:0] pair_csrstorage41_storage;
reg pair_csrstorage41_re = 1'd0;
reg [13:0] pair_csrstorage42_storage_full = 14'd0;
wire [13:0] pair_csrstorage42_storage;
reg pair_csrstorage42_re = 1'd0;
reg [13:0] pair_csrstorage43_storage_full = 14'd0;
wire [13:0] pair_csrstorage43_storage;
reg pair_csrstorage43_re = 1'd0;
reg [13:0] pair_csrstorage44_storage_full = 14'd0;
wire [13:0] pair_csrstorage44_storage;
reg pair_csrstorage44_re = 1'd0;
reg [13:0] pair_csrstorage45_storage_full = 14'd0;
wire [13:0] pair_csrstorage45_storage;
reg pair_csrstorage45_re = 1'd0;
reg [13:0] pair_csrstorage46_storage_full = 14'd0;
wire [13:0] pair_csrstorage46_storage;
reg pair_csrstorage46_re = 1'd0;
reg [13:0] pair_csrstorage47_storage_full = 14'd0;
wire [13:0] pair_csrstorage47_storage;
reg pair_csrstorage47_re = 1'd0;
reg [13:0] pair_csrstorage48_storage_full = 14'd0;
wire [13:0] pair_csrstorage48_storage;
reg pair_csrstorage48_re = 1'd0;
reg [13:0] pair_csrstorage49_storage_full = 14'd0;
wire [13:0] pair_csrstorage49_storage;
reg pair_csrstorage49_re = 1'd0;
reg [13:0] pair_csrstorage50_storage_full = 14'd0;
wire [13:0] pair_csrstorage50_storage;
reg pair_csrstorage50_re = 1'd0;
reg [13:0] pair_csrstorage51_storage_full = 14'd0;
wire [13:0] pair_csrstorage51_storage;
reg pair_csrstorage51_re = 1'd0;
reg [13:0] pair_csrstorage52_storage_full = 14'd0;
wire [13:0] pair_csrstorage52_storage;
reg pair_csrstorage52_re = 1'd0;
reg [13:0] pair_csrstorage53_storage_full = 14'd0;
wire [13:0] pair_csrstorage53_storage;
reg pair_csrstorage53_re = 1'd0;
reg [13:0] pair_csrstorage54_storage_full = 14'd0;
wire [13:0] pair_csrstorage54_storage;
reg pair_csrstorage54_re = 1'd0;
reg [13:0] pair_csrstorage55_storage_full = 14'd0;
wire [13:0] pair_csrstorage55_storage;
reg pair_csrstorage55_re = 1'd0;
reg [13:0] pair_csrstorage56_storage_full = 14'd0;
wire [13:0] pair_csrstorage56_storage;
reg pair_csrstorage56_re = 1'd0;
reg [13:0] pair_csrstorage57_storage_full = 14'd0;
wire [13:0] pair_csrstorage57_storage;
reg pair_csrstorage57_re = 1'd0;
reg [13:0] pair_csrstorage58_storage_full = 14'd0;
wire [13:0] pair_csrstorage58_storage;
reg pair_csrstorage58_re = 1'd0;
reg [13:0] pair_csrstorage59_storage_full = 14'd0;
wire [13:0] pair_csrstorage59_storage;
reg pair_csrstorage59_re = 1'd0;
reg [13:0] pair_csrstorage60_storage_full = 14'd0;
wire [13:0] pair_csrstorage60_storage;
reg pair_csrstorage60_re = 1'd0;
reg [13:0] pair_csrstorage61_storage_full = 14'd0;
wire [13:0] pair_csrstorage61_storage;
reg pair_csrstorage61_re = 1'd0;
reg [13:0] pair_csrstorage62_storage_full = 14'd0;
wire [13:0] pair_csrstorage62_storage;
reg pair_csrstorage62_re = 1'd0;
reg [13:0] pair_csrstorage63_storage_full = 14'd0;
wire [13:0] pair_csrstorage63_storage;
reg pair_csrstorage63_re = 1'd0;
wire [13:0] pair_bus_adr;
wire pair_bus_we;
wire [7:0] pair_bus_dat_w;
reg [7:0] pair_bus_dat_r = 8'd0;
wire pair_peak_03_re;
wire [3:0] pair_peak_03_r;
wire [3:0] pair_peak_03_w;
wire pair_peak_02_re;
wire [7:0] pair_peak_02_r;
wire [7:0] pair_peak_02_w;
wire pair_peak_01_re;
wire [7:0] pair_peak_01_r;
wire [7:0] pair_peak_01_w;
wire pair_peak_00_re;
wire [7:0] pair_peak_00_r;
wire [7:0] pair_peak_00_w;
wire pair_peak_13_re;
wire [3:0] pair_peak_13_r;
wire [3:0] pair_peak_13_w;
wire pair_peak_12_re;
wire [7:0] pair_peak_12_r;
wire [7:0] pair_peak_12_w;
wire pair_peak_11_re;
wire [7:0] pair_peak_11_r;
wire [7:0] pair_peak_11_w;
wire pair_peak_10_re;
wire [7:0] pair_peak_10_r;
wire [7:0] pair_peak_10_w;
wire pair_peak_23_re;
wire [3:0] pair_peak_23_r;
wire [3:0] pair_peak_23_w;
wire pair_peak_22_re;
wire [7:0] pair_peak_22_r;
wire [7:0] pair_peak_22_w;
wire pair_peak_21_re;
wire [7:0] pair_peak_21_r;
wire [7:0] pair_peak_21_w;
wire pair_peak_20_re;
wire [7:0] pair_peak_20_r;
wire [7:0] pair_peak_20_w;
wire pair_peak_33_re;
wire [3:0] pair_peak_33_r;
wire [3:0] pair_peak_33_w;
wire pair_peak_32_re;
wire [7:0] pair_peak_32_r;
wire [7:0] pair_peak_32_w;
wire pair_peak_31_re;
wire [7:0] pair_peak_31_r;
wire [7:0] pair_peak_31_w;
wire pair_peak_30_re;
wire [7:0] pair_peak_30_r;
wire [7:0] pair_peak_30_w;
wire pair_peak_43_re;
wire [3:0] pair_peak_43_r;
wire [3:0] pair_peak_43_w;
wire pair_peak_42_re;
wire [7:0] pair_peak_42_r;
wire [7:0] pair_peak_42_w;
wire pair_peak_41_re;
wire [7:0] pair_peak_41_r;
wire [7:0] pair_peak_41_w;
wire pair_peak_40_re;
wire [7:0] pair_peak_40_r;
wire [7:0] pair_peak_40_w;
wire pair_peak_53_re;
wire [3:0] pair_peak_53_r;
wire [3:0] pair_peak_53_w;
wire pair_peak_52_re;
wire [7:0] pair_peak_52_r;
wire [7:0] pair_peak_52_w;
wire pair_peak_51_re;
wire [7:0] pair_peak_51_r;
wire [7:0] pair_peak_51_w;
wire pair_peak_50_re;
wire [7:0] pair_peak_50_r;
wire [7:0] pair_peak_50_w;
wire pair_peak_63_re;
wire [3:0] pair_peak_63_r;
wire [3:0] pair_peak_63_w;
wire pair_peak_62_re;
wire [7:0] pair_peak_62_r;
wire [7:0] pair_peak_62_w;
wire pair_peak_61_re;
wire [7:0] pair_peak_61_r;
wire [7:0] pair_peak_61_w;
wire pair_peak_60_re;
wire [7:0] pair_peak_60_r;
wire [7:0] pair_peak_60_w;
wire pair_peak_73_re;
wire [3:0] pair_peak_73_r;
wire [3:0] pair_peak_73_w;
wire pair_peak_72_re;
wire [7:0] pair_peak_72_r;
wire [7:0] pair_peak_72_w;
wire pair_peak_71_re;
wire [7:0] pair_peak_71_r;
wire [7:0] pair_peak_71_w;
wire pair_peak_70_re;
wire [7:0] pair_peak_70_r;
wire [7:0] pair_peak_70_w;
wire pair_peak_83_re;
wire [3:0] pair_peak_83_r;
wire [3:0] pair_peak_83_w;
wire pair_peak_82_re;
wire [7:0] pair_peak_82_r;
wire [7:0] pair_peak_82_w;
wire pair_peak_81_re;
wire [7:0] pair_peak_81_r;
wire [7:0] pair_peak_81_w;
wire pair_peak_80_re;
wire [7:0] pair_peak_80_r;
wire [7:0] pair_peak_80_w;
wire pair_peak_93_re;
wire [3:0] pair_peak_93_r;
wire [3:0] pair_peak_93_w;
wire pair_peak_92_re;
wire [7:0] pair_peak_92_r;
wire [7:0] pair_peak_92_w;
wire pair_peak_91_re;
wire [7:0] pair_peak_91_r;
wire [7:0] pair_peak_91_w;
wire pair_peak_90_re;
wire [7:0] pair_peak_90_r;
wire [7:0] pair_peak_90_w;
wire pair_peak_103_re;
wire [3:0] pair_peak_103_r;
wire [3:0] pair_peak_103_w;
wire pair_peak_102_re;
wire [7:0] pair_peak_102_r;
wire [7:0] pair_peak_102_w;
wire pair_peak_101_re;
wire [7:0] pair_peak_101_r;
wire [7:0] pair_peak_101_w;
wire pair_peak_100_re;
wire [7:0] pair_peak_100_r;
wire [7:0] pair_peak_100_w;
wire pair_peak_113_re;
wire [3:0] pair_peak_113_r;
wire [3:0] pair_peak_113_w;
wire pair_peak_112_re;
wire [7:0] pair_peak_112_r;
wire [7:0] pair_peak_112_w;
wire pair_peak_111_re;
wire [7:0] pair_peak_111_r;
wire [7:0] pair_peak_111_w;
wire pair_peak_110_re;
wire [7:0] pair_peak_110_r;
wire [7:0] pair_peak_110_w;
wire pair_peak_123_re;
wire [3:0] pair_peak_123_r;
wire [3:0] pair_peak_123_w;
wire pair_peak_122_re;
wire [7:0] pair_peak_122_r;
wire [7:0] pair_peak_122_w;
wire pair_peak_121_re;
wire [7:0] pair_peak_121_r;
wire [7:0] pair_peak_121_w;
wire pair_peak_120_re;
wire [7:0] pair_peak_120_r;
wire [7:0] pair_peak_120_w;
wire pair_peak_133_re;
wire [3:0] pair_peak_133_r;
wire [3:0] pair_peak_133_w;
wire pair_peak_132_re;
wire [7:0] pair_peak_132_r;
wire [7:0] pair_peak_132_w;
wire pair_peak_131_re;
wire [7:0] pair_peak_131_r;
wire [7:0] pair_peak_131_w;
wire pair_peak_130_re;
wire [7:0] pair_peak_130_r;
wire [7:0] pair_peak_130_w;
wire pair_peak_143_re;
wire [3:0] pair_peak_143_r;
wire [3:0] pair_peak_143_w;
wire pair_peak_142_re;
wire [7:0] pair_peak_142_r;
wire [7:0] pair_peak_142_w;
wire pair_peak_141_re;
wire [7:0] pair_peak_141_r;
wire [7:0] pair_peak_141_w;
wire pair_peak_140_re;
wire [7:0] pair_peak_140_r;
wire [7:0] pair_peak_140_w;
wire pair_peak_153_re;
wire [3:0] pair_peak_153_r;
wire [3:0] pair_peak_153_w;
wire pair_peak_152_re;
wire [7:0] pair_peak_152_r;
wire [7:0] pair_peak_152_w;
wire pair_peak_151_re;
wire [7:0] pair_peak_151_r;
wire [7:0] pair_peak_151_w;
wire pair_peak_150_re;
wire [7:0] pair_peak_150_r;
wire [7:0] pair_peak_150_w;
wire pair_peak_163_re;
wire [3:0] pair_peak_163_r;
wire [3:0] pair_peak_163_w;
wire pair_peak_162_re;
wire [7:0] pair_peak_162_r;
wire [7:0] pair_peak_162_w;
wire pair_peak_161_re;
wire [7:0] pair_peak_161_r;
wire [7:0] pair_peak_161_w;
wire pair_peak_160_re;
wire [7:0] pair_peak_160_r;
wire [7:0] pair_peak_160_w;
wire pair_peak_173_re;
wire [3:0] pair_peak_173_r;
wire [3:0] pair_peak_173_w;
wire pair_peak_172_re;
wire [7:0] pair_peak_172_r;
wire [7:0] pair_peak_172_w;
wire pair_peak_171_re;
wire [7:0] pair_peak_171_r;
wire [7:0] pair_peak_171_w;
wire pair_peak_170_re;
wire [7:0] pair_peak_170_r;
wire [7:0] pair_peak_170_w;
wire pair_peak_183_re;
wire [3:0] pair_peak_183_r;
wire [3:0] pair_peak_183_w;
wire pair_peak_182_re;
wire [7:0] pair_peak_182_r;
wire [7:0] pair_peak_182_w;
wire pair_peak_181_re;
wire [7:0] pair_peak_181_r;
wire [7:0] pair_peak_181_w;
wire pair_peak_180_re;
wire [7:0] pair_peak_180_r;
wire [7:0] pair_peak_180_w;
wire pair_peak_193_re;
wire [3:0] pair_peak_193_r;
wire [3:0] pair_peak_193_w;
wire pair_peak_192_re;
wire [7:0] pair_peak_192_r;
wire [7:0] pair_peak_192_w;
wire pair_peak_191_re;
wire [7:0] pair_peak_191_r;
wire [7:0] pair_peak_191_w;
wire pair_peak_190_re;
wire [7:0] pair_peak_190_r;
wire [7:0] pair_peak_190_w;
wire pair_peak_203_re;
wire [3:0] pair_peak_203_r;
wire [3:0] pair_peak_203_w;
wire pair_peak_202_re;
wire [7:0] pair_peak_202_r;
wire [7:0] pair_peak_202_w;
wire pair_peak_201_re;
wire [7:0] pair_peak_201_r;
wire [7:0] pair_peak_201_w;
wire pair_peak_200_re;
wire [7:0] pair_peak_200_r;
wire [7:0] pair_peak_200_w;
wire pair_peak_213_re;
wire [3:0] pair_peak_213_r;
wire [3:0] pair_peak_213_w;
wire pair_peak_212_re;
wire [7:0] pair_peak_212_r;
wire [7:0] pair_peak_212_w;
wire pair_peak_211_re;
wire [7:0] pair_peak_211_r;
wire [7:0] pair_peak_211_w;
wire pair_peak_210_re;
wire [7:0] pair_peak_210_r;
wire [7:0] pair_peak_210_w;
wire pair_peak_223_re;
wire [3:0] pair_peak_223_r;
wire [3:0] pair_peak_223_w;
wire pair_peak_222_re;
wire [7:0] pair_peak_222_r;
wire [7:0] pair_peak_222_w;
wire pair_peak_221_re;
wire [7:0] pair_peak_221_r;
wire [7:0] pair_peak_221_w;
wire pair_peak_220_re;
wire [7:0] pair_peak_220_r;
wire [7:0] pair_peak_220_w;
wire pair_peak_233_re;
wire [3:0] pair_peak_233_r;
wire [3:0] pair_peak_233_w;
wire pair_peak_232_re;
wire [7:0] pair_peak_232_r;
wire [7:0] pair_peak_232_w;
wire pair_peak_231_re;
wire [7:0] pair_peak_231_r;
wire [7:0] pair_peak_231_w;
wire pair_peak_230_re;
wire [7:0] pair_peak_230_r;
wire [7:0] pair_peak_230_w;
wire pair_peak_243_re;
wire [3:0] pair_peak_243_r;
wire [3:0] pair_peak_243_w;
wire pair_peak_242_re;
wire [7:0] pair_peak_242_r;
wire [7:0] pair_peak_242_w;
wire pair_peak_241_re;
wire [7:0] pair_peak_241_r;
wire [7:0] pair_peak_241_w;
wire pair_peak_240_re;
wire [7:0] pair_peak_240_r;
wire [7:0] pair_peak_240_w;
wire pair_peak_253_re;
wire [3:0] pair_peak_253_r;
wire [3:0] pair_peak_253_w;
wire pair_peak_252_re;
wire [7:0] pair_peak_252_r;
wire [7:0] pair_peak_252_w;
wire pair_peak_251_re;
wire [7:0] pair_peak_251_r;
wire [7:0] pair_peak_251_w;
wire pair_peak_250_re;
wire [7:0] pair_peak_250_r;
wire [7:0] pair_peak_250_w;
wire pair_peak_263_re;
wire [3:0] pair_peak_263_r;
wire [3:0] pair_peak_263_w;
wire pair_peak_262_re;
wire [7:0] pair_peak_262_r;
wire [7:0] pair_peak_262_w;
wire pair_peak_261_re;
wire [7:0] pair_peak_261_r;
wire [7:0] pair_peak_261_w;
wire pair_peak_260_re;
wire [7:0] pair_peak_260_r;
wire [7:0] pair_peak_260_w;
wire pair_peak_273_re;
wire [3:0] pair_peak_273_r;
wire [3:0] pair_peak_273_w;
wire pair_peak_272_re;
wire [7:0] pair_peak_272_r;
wire [7:0] pair_peak_272_w;
wire pair_peak_271_re;
wire [7:0] pair_peak_271_r;
wire [7:0] pair_peak_271_w;
wire pair_peak_270_re;
wire [7:0] pair_peak_270_r;
wire [7:0] pair_peak_270_w;
wire pair_peak_283_re;
wire [3:0] pair_peak_283_r;
wire [3:0] pair_peak_283_w;
wire pair_peak_282_re;
wire [7:0] pair_peak_282_r;
wire [7:0] pair_peak_282_w;
wire pair_peak_281_re;
wire [7:0] pair_peak_281_r;
wire [7:0] pair_peak_281_w;
wire pair_peak_280_re;
wire [7:0] pair_peak_280_r;
wire [7:0] pair_peak_280_w;
wire pair_peak_293_re;
wire [3:0] pair_peak_293_r;
wire [3:0] pair_peak_293_w;
wire pair_peak_292_re;
wire [7:0] pair_peak_292_r;
wire [7:0] pair_peak_292_w;
wire pair_peak_291_re;
wire [7:0] pair_peak_291_r;
wire [7:0] pair_peak_291_w;
wire pair_peak_290_re;
wire [7:0] pair_peak_290_r;
wire [7:0] pair_peak_290_w;
wire pair_peak_303_re;
wire [3:0] pair_peak_303_r;
wire [3:0] pair_peak_303_w;
wire pair_peak_302_re;
wire [7:0] pair_peak_302_r;
wire [7:0] pair_peak_302_w;
wire pair_peak_301_re;
wire [7:0] pair_peak_301_r;
wire [7:0] pair_peak_301_w;
wire pair_peak_300_re;
wire [7:0] pair_peak_300_r;
wire [7:0] pair_peak_300_w;
wire pair_peak_313_re;
wire [3:0] pair_peak_313_r;
wire [3:0] pair_peak_313_w;
wire pair_peak_312_re;
wire [7:0] pair_peak_312_r;
wire [7:0] pair_peak_312_w;
wire pair_peak_311_re;
wire [7:0] pair_peak_311_r;
wire [7:0] pair_peak_311_w;
wire pair_peak_310_re;
wire [7:0] pair_peak_310_r;
wire [7:0] pair_peak_310_w;
wire pair_wait_01_re;
wire [5:0] pair_wait_01_r;
wire [5:0] pair_wait_01_w;
wire pair_wait_00_re;
wire [7:0] pair_wait_00_r;
wire [7:0] pair_wait_00_w;
wire pair_wait_11_re;
wire [5:0] pair_wait_11_r;
wire [5:0] pair_wait_11_w;
wire pair_wait_10_re;
wire [7:0] pair_wait_10_r;
wire [7:0] pair_wait_10_w;
wire pair_wait_21_re;
wire [5:0] pair_wait_21_r;
wire [5:0] pair_wait_21_w;
wire pair_wait_20_re;
wire [7:0] pair_wait_20_r;
wire [7:0] pair_wait_20_w;
wire pair_wait_31_re;
wire [5:0] pair_wait_31_r;
wire [5:0] pair_wait_31_w;
wire pair_wait_30_re;
wire [7:0] pair_wait_30_r;
wire [7:0] pair_wait_30_w;
wire pair_wait_41_re;
wire [5:0] pair_wait_41_r;
wire [5:0] pair_wait_41_w;
wire pair_wait_40_re;
wire [7:0] pair_wait_40_r;
wire [7:0] pair_wait_40_w;
wire pair_wait_51_re;
wire [5:0] pair_wait_51_r;
wire [5:0] pair_wait_51_w;
wire pair_wait_50_re;
wire [7:0] pair_wait_50_r;
wire [7:0] pair_wait_50_w;
wire pair_wait_61_re;
wire [5:0] pair_wait_61_r;
wire [5:0] pair_wait_61_w;
wire pair_wait_60_re;
wire [7:0] pair_wait_60_r;
wire [7:0] pair_wait_60_w;
wire pair_wait_71_re;
wire [5:0] pair_wait_71_r;
wire [5:0] pair_wait_71_w;
wire pair_wait_70_re;
wire [7:0] pair_wait_70_r;
wire [7:0] pair_wait_70_w;
wire pair_wait_81_re;
wire [5:0] pair_wait_81_r;
wire [5:0] pair_wait_81_w;
wire pair_wait_80_re;
wire [7:0] pair_wait_80_r;
wire [7:0] pair_wait_80_w;
wire pair_wait_91_re;
wire [5:0] pair_wait_91_r;
wire [5:0] pair_wait_91_w;
wire pair_wait_90_re;
wire [7:0] pair_wait_90_r;
wire [7:0] pair_wait_90_w;
wire pair_wait_101_re;
wire [5:0] pair_wait_101_r;
wire [5:0] pair_wait_101_w;
wire pair_wait_100_re;
wire [7:0] pair_wait_100_r;
wire [7:0] pair_wait_100_w;
wire pair_wait_111_re;
wire [5:0] pair_wait_111_r;
wire [5:0] pair_wait_111_w;
wire pair_wait_110_re;
wire [7:0] pair_wait_110_r;
wire [7:0] pair_wait_110_w;
wire pair_wait_121_re;
wire [5:0] pair_wait_121_r;
wire [5:0] pair_wait_121_w;
wire pair_wait_120_re;
wire [7:0] pair_wait_120_r;
wire [7:0] pair_wait_120_w;
wire pair_wait_131_re;
wire [5:0] pair_wait_131_r;
wire [5:0] pair_wait_131_w;
wire pair_wait_130_re;
wire [7:0] pair_wait_130_r;
wire [7:0] pair_wait_130_w;
wire pair_wait_141_re;
wire [5:0] pair_wait_141_r;
wire [5:0] pair_wait_141_w;
wire pair_wait_140_re;
wire [7:0] pair_wait_140_r;
wire [7:0] pair_wait_140_w;
wire pair_wait_151_re;
wire [5:0] pair_wait_151_r;
wire [5:0] pair_wait_151_w;
wire pair_wait_150_re;
wire [7:0] pair_wait_150_r;
wire [7:0] pair_wait_150_w;
wire pair_wait_161_re;
wire [5:0] pair_wait_161_r;
wire [5:0] pair_wait_161_w;
wire pair_wait_160_re;
wire [7:0] pair_wait_160_r;
wire [7:0] pair_wait_160_w;
wire pair_wait_171_re;
wire [5:0] pair_wait_171_r;
wire [5:0] pair_wait_171_w;
wire pair_wait_170_re;
wire [7:0] pair_wait_170_r;
wire [7:0] pair_wait_170_w;
wire pair_wait_181_re;
wire [5:0] pair_wait_181_r;
wire [5:0] pair_wait_181_w;
wire pair_wait_180_re;
wire [7:0] pair_wait_180_r;
wire [7:0] pair_wait_180_w;
wire pair_wait_191_re;
wire [5:0] pair_wait_191_r;
wire [5:0] pair_wait_191_w;
wire pair_wait_190_re;
wire [7:0] pair_wait_190_r;
wire [7:0] pair_wait_190_w;
wire pair_wait_201_re;
wire [5:0] pair_wait_201_r;
wire [5:0] pair_wait_201_w;
wire pair_wait_200_re;
wire [7:0] pair_wait_200_r;
wire [7:0] pair_wait_200_w;
wire pair_wait_211_re;
wire [5:0] pair_wait_211_r;
wire [5:0] pair_wait_211_w;
wire pair_wait_210_re;
wire [7:0] pair_wait_210_r;
wire [7:0] pair_wait_210_w;
wire pair_wait_221_re;
wire [5:0] pair_wait_221_r;
wire [5:0] pair_wait_221_w;
wire pair_wait_220_re;
wire [7:0] pair_wait_220_r;
wire [7:0] pair_wait_220_w;
wire pair_wait_231_re;
wire [5:0] pair_wait_231_r;
wire [5:0] pair_wait_231_w;
wire pair_wait_230_re;
wire [7:0] pair_wait_230_r;
wire [7:0] pair_wait_230_w;
wire pair_wait_241_re;
wire [5:0] pair_wait_241_r;
wire [5:0] pair_wait_241_w;
wire pair_wait_240_re;
wire [7:0] pair_wait_240_r;
wire [7:0] pair_wait_240_w;
wire pair_wait_251_re;
wire [5:0] pair_wait_251_r;
wire [5:0] pair_wait_251_w;
wire pair_wait_250_re;
wire [7:0] pair_wait_250_r;
wire [7:0] pair_wait_250_w;
wire pair_wait_261_re;
wire [5:0] pair_wait_261_r;
wire [5:0] pair_wait_261_w;
wire pair_wait_260_re;
wire [7:0] pair_wait_260_r;
wire [7:0] pair_wait_260_w;
wire pair_wait_271_re;
wire [5:0] pair_wait_271_r;
wire [5:0] pair_wait_271_w;
wire pair_wait_270_re;
wire [7:0] pair_wait_270_r;
wire [7:0] pair_wait_270_w;
wire pair_wait_281_re;
wire [5:0] pair_wait_281_r;
wire [5:0] pair_wait_281_w;
wire pair_wait_280_re;
wire [7:0] pair_wait_280_r;
wire [7:0] pair_wait_280_w;
wire pair_wait_291_re;
wire [5:0] pair_wait_291_r;
wire [5:0] pair_wait_291_w;
wire pair_wait_290_re;
wire [7:0] pair_wait_290_r;
wire [7:0] pair_wait_290_w;
wire pair_wait_301_re;
wire [5:0] pair_wait_301_r;
wire [5:0] pair_wait_301_w;
wire pair_wait_300_re;
wire [7:0] pair_wait_300_r;
wire [7:0] pair_wait_300_w;
wire pair_wait_311_re;
wire [5:0] pair_wait_311_r;
wire [5:0] pair_wait_311_w;
wire pair_wait_310_re;
wire [7:0] pair_wait_310_r;
wire [7:0] pair_wait_310_w;
wire pair_sel;
reg [4:0] pair_index = 5'd0;
wire signed [27:0] pair_raw0;
reg signed [27:0] pair_absolute0;
wire signed [28:0] pair_extended0;
reg signed [27:0] pair_mag0 = 28'sd0;
reg signed [28:0] pair_neg0 = 29'sd0;
reg pair_pos0 = 1'd0;
reg [13:0] pair_w0 = 14'd0;
wire signed [27:0] pair_raw1;
reg signed [27:0] pair_absolute1;
wire signed [28:0] pair_extended1;
reg signed [27:0] pair_mag1 = 28'sd0;
reg signed [28:0] pair_neg1 = 29'sd0;
reg pair_pos1 = 1'd0;
reg [13:0] pair_w1 = 14'd0;
wire signed [27:0] pair_raw2;
reg signed [27:0] pair_absolute2;
wire signed [28:0] pair_extended2;
reg signed [27:0] pair_mag2 = 28'sd0;
reg signed [28:0] pair_neg2 = 29'sd0;
reg pair_pos2 = 1'd0;
reg [13:0] pair_w2 = 14'd0;
wire signed [27:0] pair_raw3;
reg signed [27:0] pair_absolute3;
wire signed [28:0] pair_extended3;
reg signed [27:0] pair_mag3 = 28'sd0;
reg signed [28:0] pair_neg3 = 29'sd0;
reg pair_pos3 = 1'd0;
reg [13:0] pair_w3 = 14'd0;
wire signed [27:0] pair_raw4;
reg signed [27:0] pair_absolute4;
wire signed [28:0] pair_extended4;
reg signed [27:0] pair_mag4 = 28'sd0;
reg signed [28:0] pair_neg4 = 29'sd0;
reg pair_pos4 = 1'd0;
reg [13:0] pair_w4 = 14'd0;
wire signed [27:0] pair_raw5;
reg signed [27:0] pair_absolute5;
wire signed [28:0] pair_extended5;
reg signed [27:0] pair_mag5 = 28'sd0;
reg signed [28:0] pair_neg5 = 29'sd0;
reg pair_pos5 = 1'd0;
reg [13:0] pair_w5 = 14'd0;
wire signed [27:0] pair_raw6;
reg signed [27:0] pair_absolute6;
wire signed [28:0] pair_extended6;
reg signed [27:0] pair_mag6 = 28'sd0;
reg signed [28:0] pair_neg6 = 29'sd0;
reg pair_pos6 = 1'd0;
reg [13:0] pair_w6 = 14'd0;
wire signed [27:0] pair_raw7;
reg signed [27:0] pair_absolute7;
wire signed [28:0] pair_extended7;
reg signed [27:0] pair_mag7 = 28'sd0;
reg signed [28:0] pair_neg7 = 29'sd0;
reg pair_pos7 = 1'd0;
reg [13:0] pair_w7 = 14'd0;
wire signed [27:0] pair_raw8;
reg signed [27:0] pair_absolute8;
wire signed [28:0] pair_extended8;
reg signed [27:0] pair_mag8 = 28'sd0;
reg signed [28:0] pair_neg8 = 29'sd0;
reg pair_pos8 = 1'd0;
reg [13:0] pair_w8 = 14'd0;
wire signed [27:0] pair_raw9;
reg signed [27:0] pair_absolute9;
wire signed [28:0] pair_extended9;
reg signed [27:0] pair_mag9 = 28'sd0;
reg signed [28:0] pair_neg9 = 29'sd0;
reg pair_pos9 = 1'd0;
reg [13:0] pair_w9 = 14'd0;
wire signed [27:0] pair_raw10;
reg signed [27:0] pair_absolute10;
wire signed [28:0] pair_extended10;
reg signed [27:0] pair_mag10 = 28'sd0;
reg signed [28:0] pair_neg10 = 29'sd0;
reg pair_pos10 = 1'd0;
reg [13:0] pair_w10 = 14'd0;
wire signed [27:0] pair_raw11;
reg signed [27:0] pair_absolute11;
wire signed [28:0] pair_extended11;
reg signed [27:0] pair_mag11 = 28'sd0;
reg signed [28:0] pair_neg11 = 29'sd0;
reg pair_pos11 = 1'd0;
reg [13:0] pair_w11 = 14'd0;
wire signed [27:0] pair_raw12;
reg signed [27:0] pair_absolute12;
wire signed [28:0] pair_extended12;
reg signed [27:0] pair_mag12 = 28'sd0;
reg signed [28:0] pair_neg12 = 29'sd0;
reg pair_pos12 = 1'd0;
reg [13:0] pair_w12 = 14'd0;
wire signed [27:0] pair_raw13;
reg signed [27:0] pair_absolute13;
wire signed [28:0] pair_extended13;
reg signed [27:0] pair_mag13 = 28'sd0;
reg signed [28:0] pair_neg13 = 29'sd0;
reg pair_pos13 = 1'd0;
reg [13:0] pair_w13 = 14'd0;
wire signed [27:0] pair_raw14;
reg signed [27:0] pair_absolute14;
wire signed [28:0] pair_extended14;
reg signed [27:0] pair_mag14 = 28'sd0;
reg signed [28:0] pair_neg14 = 29'sd0;
reg pair_pos14 = 1'd0;
reg [13:0] pair_w14 = 14'd0;
wire signed [27:0] pair_raw15;
reg signed [27:0] pair_absolute15;
wire signed [28:0] pair_extended15;
reg signed [27:0] pair_mag15 = 28'sd0;
reg signed [28:0] pair_neg15 = 29'sd0;
reg pair_pos15 = 1'd0;
reg [13:0] pair_w15 = 14'd0;
wire signed [27:0] pair_raw16;
reg signed [27:0] pair_absolute16;
wire signed [28:0] pair_extended16;
reg signed [27:0] pair_mag16 = 28'sd0;
reg signed [28:0] pair_neg16 = 29'sd0;
reg pair_pos16 = 1'd0;
reg [13:0] pair_w16 = 14'd0;
wire signed [27:0] pair_raw17;
reg signed [27:0] pair_absolute17;
wire signed [28:0] pair_extended17;
reg signed [27:0] pair_mag17 = 28'sd0;
reg signed [28:0] pair_neg17 = 29'sd0;
reg pair_pos17 = 1'd0;
reg [13:0] pair_w17 = 14'd0;
wire signed [27:0] pair_raw18;
reg signed [27:0] pair_absolute18;
wire signed [28:0] pair_extended18;
reg signed [27:0] pair_mag18 = 28'sd0;
reg signed [28:0] pair_neg18 = 29'sd0;
reg pair_pos18 = 1'd0;
reg [13:0] pair_w18 = 14'd0;
wire signed [27:0] pair_raw19;
reg signed [27:0] pair_absolute19;
wire signed [28:0] pair_extended19;
reg signed [27:0] pair_mag19 = 28'sd0;
reg signed [28:0] pair_neg19 = 29'sd0;
reg pair_pos19 = 1'd0;
reg [13:0] pair_w19 = 14'd0;
wire signed [27:0] pair_raw20;
reg signed [27:0] pair_absolute20;
wire signed [28:0] pair_extended20;
reg signed [27:0] pair_mag20 = 28'sd0;
reg signed [28:0] pair_neg20 = 29'sd0;
reg pair_pos20 = 1'd0;
reg [13:0] pair_w20 = 14'd0;
wire signed [27:0] pair_raw21;
reg signed [27:0] pair_absolute21;
wire signed [28:0] pair_extended21;
reg signed [27:0] pair_mag21 = 28'sd0;
reg signed [28:0] pair_neg21 = 29'sd0;
reg pair_pos21 = 1'd0;
reg [13:0] pair_w21 = 14'd0;
wire signed [27:0] pair_raw22;
reg signed [27:0] pair_absolute22;
wire signed [28:0] pair_extended22;
reg signed [27:0] pair_mag22 = 28'sd0;
reg signed [28:0] pair_neg22 = 29'sd0;
reg pair_pos22 = 1'd0;
reg [13:0] pair_w22 = 14'd0;
wire signed [27:0] pair_raw23;
reg signed [27:0] pair_absolute23;
wire signed [28:0] pair_extended23;
reg signed [27:0] pair_mag23 = 28'sd0;
reg signed [28:0] pair_neg23 = 29'sd0;
reg pair_pos23 = 1'd0;
reg [13:0] pair_w23 = 14'd0;
wire signed [27:0] pair_raw24;
reg signed [27:0] pair_absolute24;
wire signed [28:0] pair_extended24;
reg signed [27:0] pair_mag24 = 28'sd0;
reg signed [28:0] pair_neg24 = 29'sd0;
reg pair_pos24 = 1'd0;
reg [13:0] pair_w24 = 14'd0;
wire signed [27:0] pair_raw25;
reg signed [27:0] pair_absolute25;
wire signed [28:0] pair_extended25;
reg signed [27:0] pair_mag25 = 28'sd0;
reg signed [28:0] pair_neg25 = 29'sd0;
reg pair_pos25 = 1'd0;
reg [13:0] pair_w25 = 14'd0;
wire signed [27:0] pair_raw26;
reg signed [27:0] pair_absolute26;
wire signed [28:0] pair_extended26;
reg signed [27:0] pair_mag26 = 28'sd0;
reg signed [28:0] pair_neg26 = 29'sd0;
reg pair_pos26 = 1'd0;
reg [13:0] pair_w26 = 14'd0;
wire signed [27:0] pair_raw27;
reg signed [27:0] pair_absolute27;
wire signed [28:0] pair_extended27;
reg signed [27:0] pair_mag27 = 28'sd0;
reg signed [28:0] pair_neg27 = 29'sd0;
reg pair_pos27 = 1'd0;
reg [13:0] pair_w27 = 14'd0;
wire signed [27:0] pair_raw28;
reg signed [27:0] pair_absolute28;
wire signed [28:0] pair_extended28;
reg signed [27:0] pair_mag28 = 28'sd0;
reg signed [28:0] pair_neg28 = 29'sd0;
reg pair_pos28 = 1'd0;
reg [13:0] pair_w28 = 14'd0;
wire signed [27:0] pair_raw29;
reg signed [27:0] pair_absolute29;
wire signed [28:0] pair_extended29;
reg signed [27:0] pair_mag29 = 28'sd0;
reg signed [28:0] pair_neg29 = 29'sd0;
reg pair_pos29 = 1'd0;
reg [13:0] pair_w29 = 14'd0;
wire signed [27:0] pair_raw30;
reg signed [27:0] pair_absolute30;
wire signed [28:0] pair_extended30;
reg signed [27:0] pair_mag30 = 28'sd0;
reg signed [28:0] pair_neg30 = 29'sd0;
reg pair_pos30 = 1'd0;
reg [13:0] pair_w30 = 14'd0;
wire signed [27:0] pair_raw31;
reg signed [27:0] pair_absolute31;
wire signed [28:0] pair_extended31;
reg signed [27:0] pair_mag31 = 28'sd0;
reg signed [28:0] pair_neg31 = 29'sd0;
reg pair_pos31 = 1'd0;
reg [13:0] pair_w31 = 14'd0;
reg [1:0] pair_new_prefetch_choice = 2'd0;
wire signed [27:0] pair_new_prefetch_current_signed;
reg signed [27:0] pair_new_absolute0;
reg signed [27:0] pair_new_negative_low0;
wire pair_new_negative_sign0;
reg signed [27:0] pair_new_prefetch_current_magnitude = 28'sd0;
reg signed [28:0] pair_new_prefetch_current_negative = 29'sd0;
reg pair_new_prefetch_current_positive = 1'd0;
reg [13:0] pair_new_prefetch_current_wait = 14'd0;
wire signed [27:0] pair_new_prefetch_next_signed;
reg signed [27:0] pair_new_absolute1;
reg signed [27:0] pair_new_negative_low1;
wire pair_new_negative_sign1;
reg signed [27:0] pair_new_prefetch_next_magnitude = 28'sd0;
reg signed [28:0] pair_new_prefetch_next_negative = 29'sd0;
reg pair_new_prefetch_next_positive = 1'd0;
reg [13:0] pair_new_prefetch_next_wait = 14'd0;
reg [27:0] pair_new_result0;
reg [13:0] pair_new_result1;
wire signed [27:0] pair_new_prefetch_zero_signed;
reg signed [27:0] pair_new_absolute2;
reg signed [27:0] pair_new_negative_low2;
wire pair_new_negative_sign2;
reg signed [27:0] pair_new_prefetch_zero_magnitude = 28'sd0;
reg signed [28:0] pair_new_prefetch_zero_negative = 29'sd0;
reg pair_new_prefetch_zero_positive = 1'd0;
reg [13:0] pair_new_prefetch_zero_wait = 14'd0;
wire signed [27:0] pair_new_prefetch_selected_magnitude;
wire signed [28:0] pair_new_prefetch_selected_negative;
wire pair_new_prefetch_selected_positive;
wire [13:0] pair_new_prefetch_selected_wait;
wire [4:0] pair_next_probe;
reg [27:0] pair_rotated_probe_result;
reg [27:0] comb_array_muxed0;
reg signed [27:0] comb_array_muxed1;
reg signed [28:0] comb_array_muxed2;
reg comb_array_muxed3;
reg [13:0] comb_array_muxed4;
reg [27:0] comb_array_muxed5;
reg signed [27:0] comb_array_muxed6;
reg signed [28:0] comb_array_muxed7;
reg comb_array_muxed8;
reg [13:0] comb_array_muxed9;
reg [13:0] sync_array_muxed;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign pair_bus_adr = csr_adr;
assign pair_bus_we = csr_we;
assign pair_bus_dat_w = csr_dat_w;
assign pair_raw0 = pair_csrstorage0_storage;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	pair_absolute0 <= 28'sd0;
	if ((pair_raw0 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute0 <= pair_raw0;
	end else begin
		pair_absolute0 <= (-pair_raw0);
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign pair_extended0 = pair_absolute0;
assign pair_raw1 = pair_csrstorage1_storage;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	pair_absolute1 <= 28'sd0;
	if ((pair_raw1 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute1 <= pair_raw1;
	end else begin
		pair_absolute1 <= (-pair_raw1);
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign pair_extended1 = pair_absolute1;
assign pair_raw2 = pair_csrstorage2_storage;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	pair_absolute2 <= 28'sd0;
	if ((pair_raw2 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute2 <= pair_raw2;
	end else begin
		pair_absolute2 <= (-pair_raw2);
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign pair_extended2 = pair_absolute2;
assign pair_raw3 = pair_csrstorage3_storage;

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	pair_absolute3 <= 28'sd0;
	if ((pair_raw3 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute3 <= pair_raw3;
	end else begin
		pair_absolute3 <= (-pair_raw3);
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign pair_extended3 = pair_absolute3;
assign pair_raw4 = pair_csrstorage4_storage;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	pair_absolute4 <= 28'sd0;
	if ((pair_raw4 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute4 <= pair_raw4;
	end else begin
		pair_absolute4 <= (-pair_raw4);
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign pair_extended4 = pair_absolute4;
assign pair_raw5 = pair_csrstorage5_storage;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	pair_absolute5 <= 28'sd0;
	if ((pair_raw5 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute5 <= pair_raw5;
	end else begin
		pair_absolute5 <= (-pair_raw5);
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign pair_extended5 = pair_absolute5;
assign pair_raw6 = pair_csrstorage6_storage;

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	pair_absolute6 <= 28'sd0;
	if ((pair_raw6 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute6 <= pair_raw6;
	end else begin
		pair_absolute6 <= (-pair_raw6);
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign pair_extended6 = pair_absolute6;
assign pair_raw7 = pair_csrstorage7_storage;

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	pair_absolute7 <= 28'sd0;
	if ((pair_raw7 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute7 <= pair_raw7;
	end else begin
		pair_absolute7 <= (-pair_raw7);
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign pair_extended7 = pair_absolute7;
assign pair_raw8 = pair_csrstorage8_storage;

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	pair_absolute8 <= 28'sd0;
	if ((pair_raw8 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute8 <= pair_raw8;
	end else begin
		pair_absolute8 <= (-pair_raw8);
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign pair_extended8 = pair_absolute8;
assign pair_raw9 = pair_csrstorage9_storage;

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	pair_absolute9 <= 28'sd0;
	if ((pair_raw9 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute9 <= pair_raw9;
	end else begin
		pair_absolute9 <= (-pair_raw9);
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign pair_extended9 = pair_absolute9;
assign pair_raw10 = pair_csrstorage10_storage;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	pair_absolute10 <= 28'sd0;
	if ((pair_raw10 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute10 <= pair_raw10;
	end else begin
		pair_absolute10 <= (-pair_raw10);
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign pair_extended10 = pair_absolute10;
assign pair_raw11 = pair_csrstorage11_storage;

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	pair_absolute11 <= 28'sd0;
	if ((pair_raw11 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute11 <= pair_raw11;
	end else begin
		pair_absolute11 <= (-pair_raw11);
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign pair_extended11 = pair_absolute11;
assign pair_raw12 = pair_csrstorage12_storage;

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	pair_absolute12 <= 28'sd0;
	if ((pair_raw12 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute12 <= pair_raw12;
	end else begin
		pair_absolute12 <= (-pair_raw12);
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end
assign pair_extended12 = pair_absolute12;
assign pair_raw13 = pair_csrstorage13_storage;

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	pair_absolute13 <= 28'sd0;
	if ((pair_raw13 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute13 <= pair_raw13;
	end else begin
		pair_absolute13 <= (-pair_raw13);
	end
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end
assign pair_extended13 = pair_absolute13;
assign pair_raw14 = pair_csrstorage14_storage;

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	pair_absolute14 <= 28'sd0;
	if ((pair_raw14 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute14 <= pair_raw14;
	end else begin
		pair_absolute14 <= (-pair_raw14);
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign pair_extended14 = pair_absolute14;
assign pair_raw15 = pair_csrstorage15_storage;

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	pair_absolute15 <= 28'sd0;
	if ((pair_raw15 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute15 <= pair_raw15;
	end else begin
		pair_absolute15 <= (-pair_raw15);
	end
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign pair_extended15 = pair_absolute15;
assign pair_raw16 = pair_csrstorage16_storage;

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	pair_absolute16 <= 28'sd0;
	if ((pair_raw16 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute16 <= pair_raw16;
	end else begin
		pair_absolute16 <= (-pair_raw16);
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end
assign pair_extended16 = pair_absolute16;
assign pair_raw17 = pair_csrstorage17_storage;

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	pair_absolute17 <= 28'sd0;
	if ((pair_raw17 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute17 <= pair_raw17;
	end else begin
		pair_absolute17 <= (-pair_raw17);
	end
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end
assign pair_extended17 = pair_absolute17;
assign pair_raw18 = pair_csrstorage18_storage;

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	pair_absolute18 <= 28'sd0;
	if ((pair_raw18 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute18 <= pair_raw18;
	end else begin
		pair_absolute18 <= (-pair_raw18);
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign pair_extended18 = pair_absolute18;
assign pair_raw19 = pair_csrstorage19_storage;

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	pair_absolute19 <= 28'sd0;
	if ((pair_raw19 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute19 <= pair_raw19;
	end else begin
		pair_absolute19 <= (-pair_raw19);
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign pair_extended19 = pair_absolute19;
assign pair_raw20 = pair_csrstorage20_storage;

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	pair_absolute20 <= 28'sd0;
	if ((pair_raw20 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute20 <= pair_raw20;
	end else begin
		pair_absolute20 <= (-pair_raw20);
	end
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end
assign pair_extended20 = pair_absolute20;
assign pair_raw21 = pair_csrstorage21_storage;

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	pair_absolute21 <= 28'sd0;
	if ((pair_raw21 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute21 <= pair_raw21;
	end else begin
		pair_absolute21 <= (-pair_raw21);
	end
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end
assign pair_extended21 = pair_absolute21;
assign pair_raw22 = pair_csrstorage22_storage;

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	pair_absolute22 <= 28'sd0;
	if ((pair_raw22 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute22 <= pair_raw22;
	end else begin
		pair_absolute22 <= (-pair_raw22);
	end
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end
assign pair_extended22 = pair_absolute22;
assign pair_raw23 = pair_csrstorage23_storage;

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	pair_absolute23 <= 28'sd0;
	if ((pair_raw23 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute23 <= pair_raw23;
	end else begin
		pair_absolute23 <= (-pair_raw23);
	end
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end
assign pair_extended23 = pair_absolute23;
assign pair_raw24 = pair_csrstorage24_storage;

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	pair_absolute24 <= 28'sd0;
	if ((pair_raw24 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute24 <= pair_raw24;
	end else begin
		pair_absolute24 <= (-pair_raw24);
	end
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end
assign pair_extended24 = pair_absolute24;
assign pair_raw25 = pair_csrstorage25_storage;

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	pair_absolute25 <= 28'sd0;
	if ((pair_raw25 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute25 <= pair_raw25;
	end else begin
		pair_absolute25 <= (-pair_raw25);
	end
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end
assign pair_extended25 = pair_absolute25;
assign pair_raw26 = pair_csrstorage26_storage;

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	pair_absolute26 <= 28'sd0;
	if ((pair_raw26 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute26 <= pair_raw26;
	end else begin
		pair_absolute26 <= (-pair_raw26);
	end
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end
assign pair_extended26 = pair_absolute26;
assign pair_raw27 = pair_csrstorage27_storage;

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	pair_absolute27 <= 28'sd0;
	if ((pair_raw27 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute27 <= pair_raw27;
	end else begin
		pair_absolute27 <= (-pair_raw27);
	end
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end
assign pair_extended27 = pair_absolute27;
assign pair_raw28 = pair_csrstorage28_storage;

// synthesis translate_off
reg dummy_d_28;
// synthesis translate_on
always @(*) begin
	pair_absolute28 <= 28'sd0;
	if ((pair_raw28 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute28 <= pair_raw28;
	end else begin
		pair_absolute28 <= (-pair_raw28);
	end
// synthesis translate_off
	dummy_d_28 <= dummy_s;
// synthesis translate_on
end
assign pair_extended28 = pair_absolute28;
assign pair_raw29 = pair_csrstorage29_storage;

// synthesis translate_off
reg dummy_d_29;
// synthesis translate_on
always @(*) begin
	pair_absolute29 <= 28'sd0;
	if ((pair_raw29 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute29 <= pair_raw29;
	end else begin
		pair_absolute29 <= (-pair_raw29);
	end
// synthesis translate_off
	dummy_d_29 <= dummy_s;
// synthesis translate_on
end
assign pair_extended29 = pair_absolute29;
assign pair_raw30 = pair_csrstorage30_storage;

// synthesis translate_off
reg dummy_d_30;
// synthesis translate_on
always @(*) begin
	pair_absolute30 <= 28'sd0;
	if ((pair_raw30 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute30 <= pair_raw30;
	end else begin
		pair_absolute30 <= (-pair_raw30);
	end
// synthesis translate_off
	dummy_d_30 <= dummy_s;
// synthesis translate_on
end
assign pair_extended30 = pair_absolute30;
assign pair_raw31 = pair_csrstorage31_storage;

// synthesis translate_off
reg dummy_d_31;
// synthesis translate_on
always @(*) begin
	pair_absolute31 <= 28'sd0;
	if ((pair_raw31 >= $signed({1'd0, 1'd0}))) begin
		pair_absolute31 <= pair_raw31;
	end else begin
		pair_absolute31 <= (-pair_raw31);
	end
// synthesis translate_off
	dummy_d_31 <= dummy_s;
// synthesis translate_on
end
assign pair_extended31 = pair_absolute31;
assign pair_new_prefetch_current_signed = comb_array_muxed0;

// synthesis translate_off
reg dummy_d_32;
// synthesis translate_on
always @(*) begin
	pair_new_absolute0 <= 28'sd0;
	if ((pair_new_prefetch_current_signed >= $signed({1'd0, 1'd0}))) begin
		pair_new_absolute0 <= pair_new_prefetch_current_signed;
	end else begin
		pair_new_absolute0 <= (-pair_new_prefetch_current_signed);
	end
// synthesis translate_off
	dummy_d_32 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_33;
// synthesis translate_on
always @(*) begin
	pair_new_negative_low0 <= 28'sd0;
	if ((pair_new_prefetch_current_signed < $signed({1'd0, 1'd0}))) begin
		pair_new_negative_low0 <= pair_new_prefetch_current_signed;
	end else begin
		pair_new_negative_low0 <= (-pair_new_prefetch_current_signed);
	end
// synthesis translate_off
	dummy_d_33 <= dummy_s;
// synthesis translate_on
end
assign pair_new_negative_sign0 = ((pair_new_prefetch_current_signed > $signed({1'd0, 1'd0})) | ((pair_new_prefetch_current_signed < $signed({1'd0, 1'd0})) & (pair_new_prefetch_current_signed != 28'sd134217728)));

// synthesis translate_off
reg dummy_d_34;
// synthesis translate_on
always @(*) begin
	pair_new_result0 <= 28'd0;
	case (pair_index)
		1'd0: begin
			pair_new_result0 <= pair_csrstorage1_storage;
		end
		1'd1: begin
			pair_new_result0 <= pair_csrstorage2_storage;
		end
		2'd2: begin
			pair_new_result0 <= pair_csrstorage3_storage;
		end
		2'd3: begin
			pair_new_result0 <= pair_csrstorage4_storage;
		end
		3'd4: begin
			pair_new_result0 <= pair_csrstorage5_storage;
		end
		3'd5: begin
			pair_new_result0 <= pair_csrstorage6_storage;
		end
		3'd6: begin
			pair_new_result0 <= pair_csrstorage7_storage;
		end
		3'd7: begin
			pair_new_result0 <= pair_csrstorage8_storage;
		end
		4'd8: begin
			pair_new_result0 <= pair_csrstorage9_storage;
		end
		4'd9: begin
			pair_new_result0 <= pair_csrstorage10_storage;
		end
		4'd10: begin
			pair_new_result0 <= pair_csrstorage11_storage;
		end
		4'd11: begin
			pair_new_result0 <= pair_csrstorage12_storage;
		end
		4'd12: begin
			pair_new_result0 <= pair_csrstorage13_storage;
		end
		4'd13: begin
			pair_new_result0 <= pair_csrstorage14_storage;
		end
		4'd14: begin
			pair_new_result0 <= pair_csrstorage15_storage;
		end
		4'd15: begin
			pair_new_result0 <= pair_csrstorage16_storage;
		end
		5'd16: begin
			pair_new_result0 <= pair_csrstorage17_storage;
		end
		5'd17: begin
			pair_new_result0 <= pair_csrstorage18_storage;
		end
		5'd18: begin
			pair_new_result0 <= pair_csrstorage19_storage;
		end
		5'd19: begin
			pair_new_result0 <= pair_csrstorage20_storage;
		end
		5'd20: begin
			pair_new_result0 <= pair_csrstorage21_storage;
		end
		5'd21: begin
			pair_new_result0 <= pair_csrstorage22_storage;
		end
		5'd22: begin
			pair_new_result0 <= pair_csrstorage23_storage;
		end
		5'd23: begin
			pair_new_result0 <= pair_csrstorage24_storage;
		end
		5'd24: begin
			pair_new_result0 <= pair_csrstorage25_storage;
		end
		5'd25: begin
			pair_new_result0 <= pair_csrstorage26_storage;
		end
		5'd26: begin
			pair_new_result0 <= pair_csrstorage27_storage;
		end
		5'd27: begin
			pair_new_result0 <= pair_csrstorage28_storage;
		end
		5'd28: begin
			pair_new_result0 <= pair_csrstorage29_storage;
		end
		5'd29: begin
			pair_new_result0 <= pair_csrstorage30_storage;
		end
		5'd30: begin
			pair_new_result0 <= pair_csrstorage31_storage;
		end
		5'd31: begin
			pair_new_result0 <= pair_csrstorage0_storage;
		end
		default: begin
			pair_new_result0 <= pair_csrstorage31_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_34 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_35;
// synthesis translate_on
always @(*) begin
	pair_new_result1 <= 14'd0;
	case (pair_index)
		1'd0: begin
			pair_new_result1 <= pair_csrstorage33_storage;
		end
		1'd1: begin
			pair_new_result1 <= pair_csrstorage34_storage;
		end
		2'd2: begin
			pair_new_result1 <= pair_csrstorage35_storage;
		end
		2'd3: begin
			pair_new_result1 <= pair_csrstorage36_storage;
		end
		3'd4: begin
			pair_new_result1 <= pair_csrstorage37_storage;
		end
		3'd5: begin
			pair_new_result1 <= pair_csrstorage38_storage;
		end
		3'd6: begin
			pair_new_result1 <= pair_csrstorage39_storage;
		end
		3'd7: begin
			pair_new_result1 <= pair_csrstorage40_storage;
		end
		4'd8: begin
			pair_new_result1 <= pair_csrstorage41_storage;
		end
		4'd9: begin
			pair_new_result1 <= pair_csrstorage42_storage;
		end
		4'd10: begin
			pair_new_result1 <= pair_csrstorage43_storage;
		end
		4'd11: begin
			pair_new_result1 <= pair_csrstorage44_storage;
		end
		4'd12: begin
			pair_new_result1 <= pair_csrstorage45_storage;
		end
		4'd13: begin
			pair_new_result1 <= pair_csrstorage46_storage;
		end
		4'd14: begin
			pair_new_result1 <= pair_csrstorage47_storage;
		end
		4'd15: begin
			pair_new_result1 <= pair_csrstorage48_storage;
		end
		5'd16: begin
			pair_new_result1 <= pair_csrstorage49_storage;
		end
		5'd17: begin
			pair_new_result1 <= pair_csrstorage50_storage;
		end
		5'd18: begin
			pair_new_result1 <= pair_csrstorage51_storage;
		end
		5'd19: begin
			pair_new_result1 <= pair_csrstorage52_storage;
		end
		5'd20: begin
			pair_new_result1 <= pair_csrstorage53_storage;
		end
		5'd21: begin
			pair_new_result1 <= pair_csrstorage54_storage;
		end
		5'd22: begin
			pair_new_result1 <= pair_csrstorage55_storage;
		end
		5'd23: begin
			pair_new_result1 <= pair_csrstorage56_storage;
		end
		5'd24: begin
			pair_new_result1 <= pair_csrstorage57_storage;
		end
		5'd25: begin
			pair_new_result1 <= pair_csrstorage58_storage;
		end
		5'd26: begin
			pair_new_result1 <= pair_csrstorage59_storage;
		end
		5'd27: begin
			pair_new_result1 <= pair_csrstorage60_storage;
		end
		5'd28: begin
			pair_new_result1 <= pair_csrstorage61_storage;
		end
		5'd29: begin
			pair_new_result1 <= pair_csrstorage62_storage;
		end
		5'd30: begin
			pair_new_result1 <= pair_csrstorage63_storage;
		end
		5'd31: begin
			pair_new_result1 <= pair_csrstorage32_storage;
		end
		default: begin
			pair_new_result1 <= pair_csrstorage63_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_35 <= dummy_s;
// synthesis translate_on
end
assign pair_new_prefetch_next_signed = pair_new_result0;

// synthesis translate_off
reg dummy_d_36;
// synthesis translate_on
always @(*) begin
	pair_new_absolute1 <= 28'sd0;
	if ((pair_new_prefetch_next_signed >= $signed({1'd0, 1'd0}))) begin
		pair_new_absolute1 <= pair_new_prefetch_next_signed;
	end else begin
		pair_new_absolute1 <= (-pair_new_prefetch_next_signed);
	end
// synthesis translate_off
	dummy_d_36 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_37;
// synthesis translate_on
always @(*) begin
	pair_new_negative_low1 <= 28'sd0;
	if ((pair_new_prefetch_next_signed < $signed({1'd0, 1'd0}))) begin
		pair_new_negative_low1 <= pair_new_prefetch_next_signed;
	end else begin
		pair_new_negative_low1 <= (-pair_new_prefetch_next_signed);
	end
// synthesis translate_off
	dummy_d_37 <= dummy_s;
// synthesis translate_on
end
assign pair_new_negative_sign1 = ((pair_new_prefetch_next_signed > $signed({1'd0, 1'd0})) | ((pair_new_prefetch_next_signed < $signed({1'd0, 1'd0})) & (pair_new_prefetch_next_signed != 28'sd134217728)));
assign pair_new_prefetch_zero_signed = pair_csrstorage0_storage;

// synthesis translate_off
reg dummy_d_38;
// synthesis translate_on
always @(*) begin
	pair_new_absolute2 <= 28'sd0;
	if ((pair_new_prefetch_zero_signed >= $signed({1'd0, 1'd0}))) begin
		pair_new_absolute2 <= pair_new_prefetch_zero_signed;
	end else begin
		pair_new_absolute2 <= (-pair_new_prefetch_zero_signed);
	end
// synthesis translate_off
	dummy_d_38 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_39;
// synthesis translate_on
always @(*) begin
	pair_new_negative_low2 <= 28'sd0;
	if ((pair_new_prefetch_zero_signed < $signed({1'd0, 1'd0}))) begin
		pair_new_negative_low2 <= pair_new_prefetch_zero_signed;
	end else begin
		pair_new_negative_low2 <= (-pair_new_prefetch_zero_signed);
	end
// synthesis translate_off
	dummy_d_39 <= dummy_s;
// synthesis translate_on
end
assign pair_new_negative_sign2 = ((pair_new_prefetch_zero_signed > $signed({1'd0, 1'd0})) | ((pair_new_prefetch_zero_signed < $signed({1'd0, 1'd0})) & (pair_new_prefetch_zero_signed != 28'sd134217728)));
assign pair_new_prefetch_selected_magnitude = comb_array_muxed1;
assign pair_new_prefetch_selected_negative = comb_array_muxed2;
assign pair_new_prefetch_selected_positive = comb_array_muxed3;
assign pair_new_prefetch_selected_wait = comb_array_muxed4;
assign pair_next_probe = (probe_index + 1'd1);

// synthesis translate_off
reg dummy_d_40;
// synthesis translate_on
always @(*) begin
	pair_rotated_probe_result <= 28'd0;
	case (probe_index)
		1'd0: begin
			pair_rotated_probe_result <= pair_csrstorage1_storage;
		end
		1'd1: begin
			pair_rotated_probe_result <= pair_csrstorage2_storage;
		end
		2'd2: begin
			pair_rotated_probe_result <= pair_csrstorage3_storage;
		end
		2'd3: begin
			pair_rotated_probe_result <= pair_csrstorage4_storage;
		end
		3'd4: begin
			pair_rotated_probe_result <= pair_csrstorage5_storage;
		end
		3'd5: begin
			pair_rotated_probe_result <= pair_csrstorage6_storage;
		end
		3'd6: begin
			pair_rotated_probe_result <= pair_csrstorage7_storage;
		end
		3'd7: begin
			pair_rotated_probe_result <= pair_csrstorage8_storage;
		end
		4'd8: begin
			pair_rotated_probe_result <= pair_csrstorage9_storage;
		end
		4'd9: begin
			pair_rotated_probe_result <= pair_csrstorage10_storage;
		end
		4'd10: begin
			pair_rotated_probe_result <= pair_csrstorage11_storage;
		end
		4'd11: begin
			pair_rotated_probe_result <= pair_csrstorage12_storage;
		end
		4'd12: begin
			pair_rotated_probe_result <= pair_csrstorage13_storage;
		end
		4'd13: begin
			pair_rotated_probe_result <= pair_csrstorage14_storage;
		end
		4'd14: begin
			pair_rotated_probe_result <= pair_csrstorage15_storage;
		end
		4'd15: begin
			pair_rotated_probe_result <= pair_csrstorage16_storage;
		end
		5'd16: begin
			pair_rotated_probe_result <= pair_csrstorage17_storage;
		end
		5'd17: begin
			pair_rotated_probe_result <= pair_csrstorage18_storage;
		end
		5'd18: begin
			pair_rotated_probe_result <= pair_csrstorage19_storage;
		end
		5'd19: begin
			pair_rotated_probe_result <= pair_csrstorage20_storage;
		end
		5'd20: begin
			pair_rotated_probe_result <= pair_csrstorage21_storage;
		end
		5'd21: begin
			pair_rotated_probe_result <= pair_csrstorage22_storage;
		end
		5'd22: begin
			pair_rotated_probe_result <= pair_csrstorage23_storage;
		end
		5'd23: begin
			pair_rotated_probe_result <= pair_csrstorage24_storage;
		end
		5'd24: begin
			pair_rotated_probe_result <= pair_csrstorage25_storage;
		end
		5'd25: begin
			pair_rotated_probe_result <= pair_csrstorage26_storage;
		end
		5'd26: begin
			pair_rotated_probe_result <= pair_csrstorage27_storage;
		end
		5'd27: begin
			pair_rotated_probe_result <= pair_csrstorage28_storage;
		end
		5'd28: begin
			pair_rotated_probe_result <= pair_csrstorage29_storage;
		end
		5'd29: begin
			pair_rotated_probe_result <= pair_csrstorage30_storage;
		end
		5'd30: begin
			pair_rotated_probe_result <= pair_csrstorage31_storage;
		end
		5'd31: begin
			pair_rotated_probe_result <= pair_csrstorage0_storage;
		end
		default: begin
			pair_rotated_probe_result <= pair_csrstorage31_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_40 <= dummy_s;
// synthesis translate_on
end
assign idx = pair_index;
assign choice = pair_new_prefetch_choice;
assign csr_read = pair_bus_dat_r;
assign old_probe = comb_array_muxed5;
assign new_probe = pair_rotated_probe_result;
assign old_mag = comb_array_muxed6;
assign new_mag = pair_new_prefetch_selected_magnitude;
assign old_neg = comb_array_muxed7;
assign new_neg = pair_new_prefetch_selected_negative;
assign old_pos = comb_array_muxed8;
assign new_pos = pair_new_prefetch_selected_positive;
assign old_wait = comb_array_muxed9;
assign new_wait = pair_new_prefetch_selected_wait;
assign pair_sel = (pair_bus_adr[13:9] == 1'd0);
assign pair_peak_03_r = pair_bus_dat_w[3:0];
assign pair_peak_03_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 1'd0));
assign pair_peak_02_r = pair_bus_dat_w[7:0];
assign pair_peak_02_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 1'd1));
assign pair_peak_01_r = pair_bus_dat_w[7:0];
assign pair_peak_01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 2'd2));
assign pair_peak_00_r = pair_bus_dat_w[7:0];
assign pair_peak_00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 2'd3));
assign pair_peak_13_r = pair_bus_dat_w[3:0];
assign pair_peak_13_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 3'd4));
assign pair_peak_12_r = pair_bus_dat_w[7:0];
assign pair_peak_12_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 3'd5));
assign pair_peak_11_r = pair_bus_dat_w[7:0];
assign pair_peak_11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 3'd6));
assign pair_peak_10_r = pair_bus_dat_w[7:0];
assign pair_peak_10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 3'd7));
assign pair_peak_23_r = pair_bus_dat_w[3:0];
assign pair_peak_23_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd8));
assign pair_peak_22_r = pair_bus_dat_w[7:0];
assign pair_peak_22_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd9));
assign pair_peak_21_r = pair_bus_dat_w[7:0];
assign pair_peak_21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd10));
assign pair_peak_20_r = pair_bus_dat_w[7:0];
assign pair_peak_20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd11));
assign pair_peak_33_r = pair_bus_dat_w[3:0];
assign pair_peak_33_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd12));
assign pair_peak_32_r = pair_bus_dat_w[7:0];
assign pair_peak_32_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd13));
assign pair_peak_31_r = pair_bus_dat_w[7:0];
assign pair_peak_31_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd14));
assign pair_peak_30_r = pair_bus_dat_w[7:0];
assign pair_peak_30_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 4'd15));
assign pair_peak_43_r = pair_bus_dat_w[3:0];
assign pair_peak_43_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd16));
assign pair_peak_42_r = pair_bus_dat_w[7:0];
assign pair_peak_42_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd17));
assign pair_peak_41_r = pair_bus_dat_w[7:0];
assign pair_peak_41_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd18));
assign pair_peak_40_r = pair_bus_dat_w[7:0];
assign pair_peak_40_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd19));
assign pair_peak_53_r = pair_bus_dat_w[3:0];
assign pair_peak_53_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd20));
assign pair_peak_52_r = pair_bus_dat_w[7:0];
assign pair_peak_52_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd21));
assign pair_peak_51_r = pair_bus_dat_w[7:0];
assign pair_peak_51_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd22));
assign pair_peak_50_r = pair_bus_dat_w[7:0];
assign pair_peak_50_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd23));
assign pair_peak_63_r = pair_bus_dat_w[3:0];
assign pair_peak_63_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd24));
assign pair_peak_62_r = pair_bus_dat_w[7:0];
assign pair_peak_62_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd25));
assign pair_peak_61_r = pair_bus_dat_w[7:0];
assign pair_peak_61_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd26));
assign pair_peak_60_r = pair_bus_dat_w[7:0];
assign pair_peak_60_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd27));
assign pair_peak_73_r = pair_bus_dat_w[3:0];
assign pair_peak_73_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd28));
assign pair_peak_72_r = pair_bus_dat_w[7:0];
assign pair_peak_72_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd29));
assign pair_peak_71_r = pair_bus_dat_w[7:0];
assign pair_peak_71_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd30));
assign pair_peak_70_r = pair_bus_dat_w[7:0];
assign pair_peak_70_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 5'd31));
assign pair_peak_83_r = pair_bus_dat_w[3:0];
assign pair_peak_83_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd32));
assign pair_peak_82_r = pair_bus_dat_w[7:0];
assign pair_peak_82_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd33));
assign pair_peak_81_r = pair_bus_dat_w[7:0];
assign pair_peak_81_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd34));
assign pair_peak_80_r = pair_bus_dat_w[7:0];
assign pair_peak_80_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd35));
assign pair_peak_93_r = pair_bus_dat_w[3:0];
assign pair_peak_93_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd36));
assign pair_peak_92_r = pair_bus_dat_w[7:0];
assign pair_peak_92_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd37));
assign pair_peak_91_r = pair_bus_dat_w[7:0];
assign pair_peak_91_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd38));
assign pair_peak_90_r = pair_bus_dat_w[7:0];
assign pair_peak_90_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd39));
assign pair_peak_103_r = pair_bus_dat_w[3:0];
assign pair_peak_103_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd40));
assign pair_peak_102_r = pair_bus_dat_w[7:0];
assign pair_peak_102_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd41));
assign pair_peak_101_r = pair_bus_dat_w[7:0];
assign pair_peak_101_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd42));
assign pair_peak_100_r = pair_bus_dat_w[7:0];
assign pair_peak_100_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd43));
assign pair_peak_113_r = pair_bus_dat_w[3:0];
assign pair_peak_113_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd44));
assign pair_peak_112_r = pair_bus_dat_w[7:0];
assign pair_peak_112_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd45));
assign pair_peak_111_r = pair_bus_dat_w[7:0];
assign pair_peak_111_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd46));
assign pair_peak_110_r = pair_bus_dat_w[7:0];
assign pair_peak_110_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd47));
assign pair_peak_123_r = pair_bus_dat_w[3:0];
assign pair_peak_123_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd48));
assign pair_peak_122_r = pair_bus_dat_w[7:0];
assign pair_peak_122_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd49));
assign pair_peak_121_r = pair_bus_dat_w[7:0];
assign pair_peak_121_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd50));
assign pair_peak_120_r = pair_bus_dat_w[7:0];
assign pair_peak_120_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd51));
assign pair_peak_133_r = pair_bus_dat_w[3:0];
assign pair_peak_133_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd52));
assign pair_peak_132_r = pair_bus_dat_w[7:0];
assign pair_peak_132_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd53));
assign pair_peak_131_r = pair_bus_dat_w[7:0];
assign pair_peak_131_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd54));
assign pair_peak_130_r = pair_bus_dat_w[7:0];
assign pair_peak_130_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd55));
assign pair_peak_143_r = pair_bus_dat_w[3:0];
assign pair_peak_143_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd56));
assign pair_peak_142_r = pair_bus_dat_w[7:0];
assign pair_peak_142_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd57));
assign pair_peak_141_r = pair_bus_dat_w[7:0];
assign pair_peak_141_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd58));
assign pair_peak_140_r = pair_bus_dat_w[7:0];
assign pair_peak_140_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd59));
assign pair_peak_153_r = pair_bus_dat_w[3:0];
assign pair_peak_153_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd60));
assign pair_peak_152_r = pair_bus_dat_w[7:0];
assign pair_peak_152_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd61));
assign pair_peak_151_r = pair_bus_dat_w[7:0];
assign pair_peak_151_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd62));
assign pair_peak_150_r = pair_bus_dat_w[7:0];
assign pair_peak_150_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 6'd63));
assign pair_peak_163_r = pair_bus_dat_w[3:0];
assign pair_peak_163_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd64));
assign pair_peak_162_r = pair_bus_dat_w[7:0];
assign pair_peak_162_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd65));
assign pair_peak_161_r = pair_bus_dat_w[7:0];
assign pair_peak_161_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd66));
assign pair_peak_160_r = pair_bus_dat_w[7:0];
assign pair_peak_160_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd67));
assign pair_peak_173_r = pair_bus_dat_w[3:0];
assign pair_peak_173_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd68));
assign pair_peak_172_r = pair_bus_dat_w[7:0];
assign pair_peak_172_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd69));
assign pair_peak_171_r = pair_bus_dat_w[7:0];
assign pair_peak_171_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd70));
assign pair_peak_170_r = pair_bus_dat_w[7:0];
assign pair_peak_170_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd71));
assign pair_peak_183_r = pair_bus_dat_w[3:0];
assign pair_peak_183_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd72));
assign pair_peak_182_r = pair_bus_dat_w[7:0];
assign pair_peak_182_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd73));
assign pair_peak_181_r = pair_bus_dat_w[7:0];
assign pair_peak_181_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd74));
assign pair_peak_180_r = pair_bus_dat_w[7:0];
assign pair_peak_180_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd75));
assign pair_peak_193_r = pair_bus_dat_w[3:0];
assign pair_peak_193_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd76));
assign pair_peak_192_r = pair_bus_dat_w[7:0];
assign pair_peak_192_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd77));
assign pair_peak_191_r = pair_bus_dat_w[7:0];
assign pair_peak_191_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd78));
assign pair_peak_190_r = pair_bus_dat_w[7:0];
assign pair_peak_190_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd79));
assign pair_peak_203_r = pair_bus_dat_w[3:0];
assign pair_peak_203_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd80));
assign pair_peak_202_r = pair_bus_dat_w[7:0];
assign pair_peak_202_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd81));
assign pair_peak_201_r = pair_bus_dat_w[7:0];
assign pair_peak_201_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd82));
assign pair_peak_200_r = pair_bus_dat_w[7:0];
assign pair_peak_200_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd83));
assign pair_peak_213_r = pair_bus_dat_w[3:0];
assign pair_peak_213_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd84));
assign pair_peak_212_r = pair_bus_dat_w[7:0];
assign pair_peak_212_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd85));
assign pair_peak_211_r = pair_bus_dat_w[7:0];
assign pair_peak_211_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd86));
assign pair_peak_210_r = pair_bus_dat_w[7:0];
assign pair_peak_210_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd87));
assign pair_peak_223_r = pair_bus_dat_w[3:0];
assign pair_peak_223_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd88));
assign pair_peak_222_r = pair_bus_dat_w[7:0];
assign pair_peak_222_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd89));
assign pair_peak_221_r = pair_bus_dat_w[7:0];
assign pair_peak_221_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd90));
assign pair_peak_220_r = pair_bus_dat_w[7:0];
assign pair_peak_220_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd91));
assign pair_peak_233_r = pair_bus_dat_w[3:0];
assign pair_peak_233_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd92));
assign pair_peak_232_r = pair_bus_dat_w[7:0];
assign pair_peak_232_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd93));
assign pair_peak_231_r = pair_bus_dat_w[7:0];
assign pair_peak_231_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd94));
assign pair_peak_230_r = pair_bus_dat_w[7:0];
assign pair_peak_230_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd95));
assign pair_peak_243_r = pair_bus_dat_w[3:0];
assign pair_peak_243_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd96));
assign pair_peak_242_r = pair_bus_dat_w[7:0];
assign pair_peak_242_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd97));
assign pair_peak_241_r = pair_bus_dat_w[7:0];
assign pair_peak_241_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd98));
assign pair_peak_240_r = pair_bus_dat_w[7:0];
assign pair_peak_240_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd99));
assign pair_peak_253_r = pair_bus_dat_w[3:0];
assign pair_peak_253_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd100));
assign pair_peak_252_r = pair_bus_dat_w[7:0];
assign pair_peak_252_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd101));
assign pair_peak_251_r = pair_bus_dat_w[7:0];
assign pair_peak_251_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd102));
assign pair_peak_250_r = pair_bus_dat_w[7:0];
assign pair_peak_250_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd103));
assign pair_peak_263_r = pair_bus_dat_w[3:0];
assign pair_peak_263_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd104));
assign pair_peak_262_r = pair_bus_dat_w[7:0];
assign pair_peak_262_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd105));
assign pair_peak_261_r = pair_bus_dat_w[7:0];
assign pair_peak_261_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd106));
assign pair_peak_260_r = pair_bus_dat_w[7:0];
assign pair_peak_260_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd107));
assign pair_peak_273_r = pair_bus_dat_w[3:0];
assign pair_peak_273_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd108));
assign pair_peak_272_r = pair_bus_dat_w[7:0];
assign pair_peak_272_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd109));
assign pair_peak_271_r = pair_bus_dat_w[7:0];
assign pair_peak_271_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd110));
assign pair_peak_270_r = pair_bus_dat_w[7:0];
assign pair_peak_270_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd111));
assign pair_peak_283_r = pair_bus_dat_w[3:0];
assign pair_peak_283_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd112));
assign pair_peak_282_r = pair_bus_dat_w[7:0];
assign pair_peak_282_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd113));
assign pair_peak_281_r = pair_bus_dat_w[7:0];
assign pair_peak_281_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd114));
assign pair_peak_280_r = pair_bus_dat_w[7:0];
assign pair_peak_280_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd115));
assign pair_peak_293_r = pair_bus_dat_w[3:0];
assign pair_peak_293_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd116));
assign pair_peak_292_r = pair_bus_dat_w[7:0];
assign pair_peak_292_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd117));
assign pair_peak_291_r = pair_bus_dat_w[7:0];
assign pair_peak_291_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd118));
assign pair_peak_290_r = pair_bus_dat_w[7:0];
assign pair_peak_290_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd119));
assign pair_peak_303_r = pair_bus_dat_w[3:0];
assign pair_peak_303_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd120));
assign pair_peak_302_r = pair_bus_dat_w[7:0];
assign pair_peak_302_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd121));
assign pair_peak_301_r = pair_bus_dat_w[7:0];
assign pair_peak_301_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd122));
assign pair_peak_300_r = pair_bus_dat_w[7:0];
assign pair_peak_300_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd123));
assign pair_peak_313_r = pair_bus_dat_w[3:0];
assign pair_peak_313_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd124));
assign pair_peak_312_r = pair_bus_dat_w[7:0];
assign pair_peak_312_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd125));
assign pair_peak_311_r = pair_bus_dat_w[7:0];
assign pair_peak_311_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd126));
assign pair_peak_310_r = pair_bus_dat_w[7:0];
assign pair_peak_310_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 7'd127));
assign pair_wait_01_r = pair_bus_dat_w[5:0];
assign pair_wait_01_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd128));
assign pair_wait_00_r = pair_bus_dat_w[7:0];
assign pair_wait_00_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd129));
assign pair_wait_11_r = pair_bus_dat_w[5:0];
assign pair_wait_11_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd130));
assign pair_wait_10_r = pair_bus_dat_w[7:0];
assign pair_wait_10_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd131));
assign pair_wait_21_r = pair_bus_dat_w[5:0];
assign pair_wait_21_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd132));
assign pair_wait_20_r = pair_bus_dat_w[7:0];
assign pair_wait_20_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd133));
assign pair_wait_31_r = pair_bus_dat_w[5:0];
assign pair_wait_31_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd134));
assign pair_wait_30_r = pair_bus_dat_w[7:0];
assign pair_wait_30_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd135));
assign pair_wait_41_r = pair_bus_dat_w[5:0];
assign pair_wait_41_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd136));
assign pair_wait_40_r = pair_bus_dat_w[7:0];
assign pair_wait_40_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd137));
assign pair_wait_51_r = pair_bus_dat_w[5:0];
assign pair_wait_51_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd138));
assign pair_wait_50_r = pair_bus_dat_w[7:0];
assign pair_wait_50_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd139));
assign pair_wait_61_r = pair_bus_dat_w[5:0];
assign pair_wait_61_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd140));
assign pair_wait_60_r = pair_bus_dat_w[7:0];
assign pair_wait_60_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd141));
assign pair_wait_71_r = pair_bus_dat_w[5:0];
assign pair_wait_71_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd142));
assign pair_wait_70_r = pair_bus_dat_w[7:0];
assign pair_wait_70_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd143));
assign pair_wait_81_r = pair_bus_dat_w[5:0];
assign pair_wait_81_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd144));
assign pair_wait_80_r = pair_bus_dat_w[7:0];
assign pair_wait_80_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd145));
assign pair_wait_91_r = pair_bus_dat_w[5:0];
assign pair_wait_91_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd146));
assign pair_wait_90_r = pair_bus_dat_w[7:0];
assign pair_wait_90_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd147));
assign pair_wait_101_r = pair_bus_dat_w[5:0];
assign pair_wait_101_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd148));
assign pair_wait_100_r = pair_bus_dat_w[7:0];
assign pair_wait_100_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd149));
assign pair_wait_111_r = pair_bus_dat_w[5:0];
assign pair_wait_111_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd150));
assign pair_wait_110_r = pair_bus_dat_w[7:0];
assign pair_wait_110_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd151));
assign pair_wait_121_r = pair_bus_dat_w[5:0];
assign pair_wait_121_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd152));
assign pair_wait_120_r = pair_bus_dat_w[7:0];
assign pair_wait_120_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd153));
assign pair_wait_131_r = pair_bus_dat_w[5:0];
assign pair_wait_131_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd154));
assign pair_wait_130_r = pair_bus_dat_w[7:0];
assign pair_wait_130_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd155));
assign pair_wait_141_r = pair_bus_dat_w[5:0];
assign pair_wait_141_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd156));
assign pair_wait_140_r = pair_bus_dat_w[7:0];
assign pair_wait_140_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd157));
assign pair_wait_151_r = pair_bus_dat_w[5:0];
assign pair_wait_151_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd158));
assign pair_wait_150_r = pair_bus_dat_w[7:0];
assign pair_wait_150_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd159));
assign pair_wait_161_r = pair_bus_dat_w[5:0];
assign pair_wait_161_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd160));
assign pair_wait_160_r = pair_bus_dat_w[7:0];
assign pair_wait_160_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd161));
assign pair_wait_171_r = pair_bus_dat_w[5:0];
assign pair_wait_171_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd162));
assign pair_wait_170_r = pair_bus_dat_w[7:0];
assign pair_wait_170_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd163));
assign pair_wait_181_r = pair_bus_dat_w[5:0];
assign pair_wait_181_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd164));
assign pair_wait_180_r = pair_bus_dat_w[7:0];
assign pair_wait_180_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd165));
assign pair_wait_191_r = pair_bus_dat_w[5:0];
assign pair_wait_191_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd166));
assign pair_wait_190_r = pair_bus_dat_w[7:0];
assign pair_wait_190_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd167));
assign pair_wait_201_r = pair_bus_dat_w[5:0];
assign pair_wait_201_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd168));
assign pair_wait_200_r = pair_bus_dat_w[7:0];
assign pair_wait_200_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd169));
assign pair_wait_211_r = pair_bus_dat_w[5:0];
assign pair_wait_211_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd170));
assign pair_wait_210_r = pair_bus_dat_w[7:0];
assign pair_wait_210_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd171));
assign pair_wait_221_r = pair_bus_dat_w[5:0];
assign pair_wait_221_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd172));
assign pair_wait_220_r = pair_bus_dat_w[7:0];
assign pair_wait_220_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd173));
assign pair_wait_231_r = pair_bus_dat_w[5:0];
assign pair_wait_231_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd174));
assign pair_wait_230_r = pair_bus_dat_w[7:0];
assign pair_wait_230_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd175));
assign pair_wait_241_r = pair_bus_dat_w[5:0];
assign pair_wait_241_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd176));
assign pair_wait_240_r = pair_bus_dat_w[7:0];
assign pair_wait_240_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd177));
assign pair_wait_251_r = pair_bus_dat_w[5:0];
assign pair_wait_251_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd178));
assign pair_wait_250_r = pair_bus_dat_w[7:0];
assign pair_wait_250_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd179));
assign pair_wait_261_r = pair_bus_dat_w[5:0];
assign pair_wait_261_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd180));
assign pair_wait_260_r = pair_bus_dat_w[7:0];
assign pair_wait_260_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd181));
assign pair_wait_271_r = pair_bus_dat_w[5:0];
assign pair_wait_271_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd182));
assign pair_wait_270_r = pair_bus_dat_w[7:0];
assign pair_wait_270_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd183));
assign pair_wait_281_r = pair_bus_dat_w[5:0];
assign pair_wait_281_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd184));
assign pair_wait_280_r = pair_bus_dat_w[7:0];
assign pair_wait_280_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd185));
assign pair_wait_291_r = pair_bus_dat_w[5:0];
assign pair_wait_291_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd186));
assign pair_wait_290_r = pair_bus_dat_w[7:0];
assign pair_wait_290_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd187));
assign pair_wait_301_r = pair_bus_dat_w[5:0];
assign pair_wait_301_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd188));
assign pair_wait_300_r = pair_bus_dat_w[7:0];
assign pair_wait_300_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd189));
assign pair_wait_311_r = pair_bus_dat_w[5:0];
assign pair_wait_311_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd190));
assign pair_wait_310_r = pair_bus_dat_w[7:0];
assign pair_wait_310_re = ((pair_sel & pair_bus_we) & (pair_bus_adr[7:0] == 8'd191));
assign pair_csrstorage0_storage = pair_csrstorage0_storage_full[27:0];
assign pair_peak_03_w = pair_csrstorage0_storage_full[27:24];
assign pair_peak_02_w = pair_csrstorage0_storage_full[23:16];
assign pair_peak_01_w = pair_csrstorage0_storage_full[15:8];
assign pair_peak_00_w = pair_csrstorage0_storage_full[7:0];
assign pair_csrstorage1_storage = pair_csrstorage1_storage_full[27:0];
assign pair_peak_13_w = pair_csrstorage1_storage_full[27:24];
assign pair_peak_12_w = pair_csrstorage1_storage_full[23:16];
assign pair_peak_11_w = pair_csrstorage1_storage_full[15:8];
assign pair_peak_10_w = pair_csrstorage1_storage_full[7:0];
assign pair_csrstorage2_storage = pair_csrstorage2_storage_full[27:0];
assign pair_peak_23_w = pair_csrstorage2_storage_full[27:24];
assign pair_peak_22_w = pair_csrstorage2_storage_full[23:16];
assign pair_peak_21_w = pair_csrstorage2_storage_full[15:8];
assign pair_peak_20_w = pair_csrstorage2_storage_full[7:0];
assign pair_csrstorage3_storage = pair_csrstorage3_storage_full[27:0];
assign pair_peak_33_w = pair_csrstorage3_storage_full[27:24];
assign pair_peak_32_w = pair_csrstorage3_storage_full[23:16];
assign pair_peak_31_w = pair_csrstorage3_storage_full[15:8];
assign pair_peak_30_w = pair_csrstorage3_storage_full[7:0];
assign pair_csrstorage4_storage = pair_csrstorage4_storage_full[27:0];
assign pair_peak_43_w = pair_csrstorage4_storage_full[27:24];
assign pair_peak_42_w = pair_csrstorage4_storage_full[23:16];
assign pair_peak_41_w = pair_csrstorage4_storage_full[15:8];
assign pair_peak_40_w = pair_csrstorage4_storage_full[7:0];
assign pair_csrstorage5_storage = pair_csrstorage5_storage_full[27:0];
assign pair_peak_53_w = pair_csrstorage5_storage_full[27:24];
assign pair_peak_52_w = pair_csrstorage5_storage_full[23:16];
assign pair_peak_51_w = pair_csrstorage5_storage_full[15:8];
assign pair_peak_50_w = pair_csrstorage5_storage_full[7:0];
assign pair_csrstorage6_storage = pair_csrstorage6_storage_full[27:0];
assign pair_peak_63_w = pair_csrstorage6_storage_full[27:24];
assign pair_peak_62_w = pair_csrstorage6_storage_full[23:16];
assign pair_peak_61_w = pair_csrstorage6_storage_full[15:8];
assign pair_peak_60_w = pair_csrstorage6_storage_full[7:0];
assign pair_csrstorage7_storage = pair_csrstorage7_storage_full[27:0];
assign pair_peak_73_w = pair_csrstorage7_storage_full[27:24];
assign pair_peak_72_w = pair_csrstorage7_storage_full[23:16];
assign pair_peak_71_w = pair_csrstorage7_storage_full[15:8];
assign pair_peak_70_w = pair_csrstorage7_storage_full[7:0];
assign pair_csrstorage8_storage = pair_csrstorage8_storage_full[27:0];
assign pair_peak_83_w = pair_csrstorage8_storage_full[27:24];
assign pair_peak_82_w = pair_csrstorage8_storage_full[23:16];
assign pair_peak_81_w = pair_csrstorage8_storage_full[15:8];
assign pair_peak_80_w = pair_csrstorage8_storage_full[7:0];
assign pair_csrstorage9_storage = pair_csrstorage9_storage_full[27:0];
assign pair_peak_93_w = pair_csrstorage9_storage_full[27:24];
assign pair_peak_92_w = pair_csrstorage9_storage_full[23:16];
assign pair_peak_91_w = pair_csrstorage9_storage_full[15:8];
assign pair_peak_90_w = pair_csrstorage9_storage_full[7:0];
assign pair_csrstorage10_storage = pair_csrstorage10_storage_full[27:0];
assign pair_peak_103_w = pair_csrstorage10_storage_full[27:24];
assign pair_peak_102_w = pair_csrstorage10_storage_full[23:16];
assign pair_peak_101_w = pair_csrstorage10_storage_full[15:8];
assign pair_peak_100_w = pair_csrstorage10_storage_full[7:0];
assign pair_csrstorage11_storage = pair_csrstorage11_storage_full[27:0];
assign pair_peak_113_w = pair_csrstorage11_storage_full[27:24];
assign pair_peak_112_w = pair_csrstorage11_storage_full[23:16];
assign pair_peak_111_w = pair_csrstorage11_storage_full[15:8];
assign pair_peak_110_w = pair_csrstorage11_storage_full[7:0];
assign pair_csrstorage12_storage = pair_csrstorage12_storage_full[27:0];
assign pair_peak_123_w = pair_csrstorage12_storage_full[27:24];
assign pair_peak_122_w = pair_csrstorage12_storage_full[23:16];
assign pair_peak_121_w = pair_csrstorage12_storage_full[15:8];
assign pair_peak_120_w = pair_csrstorage12_storage_full[7:0];
assign pair_csrstorage13_storage = pair_csrstorage13_storage_full[27:0];
assign pair_peak_133_w = pair_csrstorage13_storage_full[27:24];
assign pair_peak_132_w = pair_csrstorage13_storage_full[23:16];
assign pair_peak_131_w = pair_csrstorage13_storage_full[15:8];
assign pair_peak_130_w = pair_csrstorage13_storage_full[7:0];
assign pair_csrstorage14_storage = pair_csrstorage14_storage_full[27:0];
assign pair_peak_143_w = pair_csrstorage14_storage_full[27:24];
assign pair_peak_142_w = pair_csrstorage14_storage_full[23:16];
assign pair_peak_141_w = pair_csrstorage14_storage_full[15:8];
assign pair_peak_140_w = pair_csrstorage14_storage_full[7:0];
assign pair_csrstorage15_storage = pair_csrstorage15_storage_full[27:0];
assign pair_peak_153_w = pair_csrstorage15_storage_full[27:24];
assign pair_peak_152_w = pair_csrstorage15_storage_full[23:16];
assign pair_peak_151_w = pair_csrstorage15_storage_full[15:8];
assign pair_peak_150_w = pair_csrstorage15_storage_full[7:0];
assign pair_csrstorage16_storage = pair_csrstorage16_storage_full[27:0];
assign pair_peak_163_w = pair_csrstorage16_storage_full[27:24];
assign pair_peak_162_w = pair_csrstorage16_storage_full[23:16];
assign pair_peak_161_w = pair_csrstorage16_storage_full[15:8];
assign pair_peak_160_w = pair_csrstorage16_storage_full[7:0];
assign pair_csrstorage17_storage = pair_csrstorage17_storage_full[27:0];
assign pair_peak_173_w = pair_csrstorage17_storage_full[27:24];
assign pair_peak_172_w = pair_csrstorage17_storage_full[23:16];
assign pair_peak_171_w = pair_csrstorage17_storage_full[15:8];
assign pair_peak_170_w = pair_csrstorage17_storage_full[7:0];
assign pair_csrstorage18_storage = pair_csrstorage18_storage_full[27:0];
assign pair_peak_183_w = pair_csrstorage18_storage_full[27:24];
assign pair_peak_182_w = pair_csrstorage18_storage_full[23:16];
assign pair_peak_181_w = pair_csrstorage18_storage_full[15:8];
assign pair_peak_180_w = pair_csrstorage18_storage_full[7:0];
assign pair_csrstorage19_storage = pair_csrstorage19_storage_full[27:0];
assign pair_peak_193_w = pair_csrstorage19_storage_full[27:24];
assign pair_peak_192_w = pair_csrstorage19_storage_full[23:16];
assign pair_peak_191_w = pair_csrstorage19_storage_full[15:8];
assign pair_peak_190_w = pair_csrstorage19_storage_full[7:0];
assign pair_csrstorage20_storage = pair_csrstorage20_storage_full[27:0];
assign pair_peak_203_w = pair_csrstorage20_storage_full[27:24];
assign pair_peak_202_w = pair_csrstorage20_storage_full[23:16];
assign pair_peak_201_w = pair_csrstorage20_storage_full[15:8];
assign pair_peak_200_w = pair_csrstorage20_storage_full[7:0];
assign pair_csrstorage21_storage = pair_csrstorage21_storage_full[27:0];
assign pair_peak_213_w = pair_csrstorage21_storage_full[27:24];
assign pair_peak_212_w = pair_csrstorage21_storage_full[23:16];
assign pair_peak_211_w = pair_csrstorage21_storage_full[15:8];
assign pair_peak_210_w = pair_csrstorage21_storage_full[7:0];
assign pair_csrstorage22_storage = pair_csrstorage22_storage_full[27:0];
assign pair_peak_223_w = pair_csrstorage22_storage_full[27:24];
assign pair_peak_222_w = pair_csrstorage22_storage_full[23:16];
assign pair_peak_221_w = pair_csrstorage22_storage_full[15:8];
assign pair_peak_220_w = pair_csrstorage22_storage_full[7:0];
assign pair_csrstorage23_storage = pair_csrstorage23_storage_full[27:0];
assign pair_peak_233_w = pair_csrstorage23_storage_full[27:24];
assign pair_peak_232_w = pair_csrstorage23_storage_full[23:16];
assign pair_peak_231_w = pair_csrstorage23_storage_full[15:8];
assign pair_peak_230_w = pair_csrstorage23_storage_full[7:0];
assign pair_csrstorage24_storage = pair_csrstorage24_storage_full[27:0];
assign pair_peak_243_w = pair_csrstorage24_storage_full[27:24];
assign pair_peak_242_w = pair_csrstorage24_storage_full[23:16];
assign pair_peak_241_w = pair_csrstorage24_storage_full[15:8];
assign pair_peak_240_w = pair_csrstorage24_storage_full[7:0];
assign pair_csrstorage25_storage = pair_csrstorage25_storage_full[27:0];
assign pair_peak_253_w = pair_csrstorage25_storage_full[27:24];
assign pair_peak_252_w = pair_csrstorage25_storage_full[23:16];
assign pair_peak_251_w = pair_csrstorage25_storage_full[15:8];
assign pair_peak_250_w = pair_csrstorage25_storage_full[7:0];
assign pair_csrstorage26_storage = pair_csrstorage26_storage_full[27:0];
assign pair_peak_263_w = pair_csrstorage26_storage_full[27:24];
assign pair_peak_262_w = pair_csrstorage26_storage_full[23:16];
assign pair_peak_261_w = pair_csrstorage26_storage_full[15:8];
assign pair_peak_260_w = pair_csrstorage26_storage_full[7:0];
assign pair_csrstorage27_storage = pair_csrstorage27_storage_full[27:0];
assign pair_peak_273_w = pair_csrstorage27_storage_full[27:24];
assign pair_peak_272_w = pair_csrstorage27_storage_full[23:16];
assign pair_peak_271_w = pair_csrstorage27_storage_full[15:8];
assign pair_peak_270_w = pair_csrstorage27_storage_full[7:0];
assign pair_csrstorage28_storage = pair_csrstorage28_storage_full[27:0];
assign pair_peak_283_w = pair_csrstorage28_storage_full[27:24];
assign pair_peak_282_w = pair_csrstorage28_storage_full[23:16];
assign pair_peak_281_w = pair_csrstorage28_storage_full[15:8];
assign pair_peak_280_w = pair_csrstorage28_storage_full[7:0];
assign pair_csrstorage29_storage = pair_csrstorage29_storage_full[27:0];
assign pair_peak_293_w = pair_csrstorage29_storage_full[27:24];
assign pair_peak_292_w = pair_csrstorage29_storage_full[23:16];
assign pair_peak_291_w = pair_csrstorage29_storage_full[15:8];
assign pair_peak_290_w = pair_csrstorage29_storage_full[7:0];
assign pair_csrstorage30_storage = pair_csrstorage30_storage_full[27:0];
assign pair_peak_303_w = pair_csrstorage30_storage_full[27:24];
assign pair_peak_302_w = pair_csrstorage30_storage_full[23:16];
assign pair_peak_301_w = pair_csrstorage30_storage_full[15:8];
assign pair_peak_300_w = pair_csrstorage30_storage_full[7:0];
assign pair_csrstorage31_storage = pair_csrstorage31_storage_full[27:0];
assign pair_peak_313_w = pair_csrstorage31_storage_full[27:24];
assign pair_peak_312_w = pair_csrstorage31_storage_full[23:16];
assign pair_peak_311_w = pair_csrstorage31_storage_full[15:8];
assign pair_peak_310_w = pair_csrstorage31_storage_full[7:0];
assign pair_csrstorage32_storage = pair_csrstorage32_storage_full[13:0];
assign pair_wait_01_w = pair_csrstorage32_storage_full[13:8];
assign pair_wait_00_w = pair_csrstorage32_storage_full[7:0];
assign pair_csrstorage33_storage = pair_csrstorage33_storage_full[13:0];
assign pair_wait_11_w = pair_csrstorage33_storage_full[13:8];
assign pair_wait_10_w = pair_csrstorage33_storage_full[7:0];
assign pair_csrstorage34_storage = pair_csrstorage34_storage_full[13:0];
assign pair_wait_21_w = pair_csrstorage34_storage_full[13:8];
assign pair_wait_20_w = pair_csrstorage34_storage_full[7:0];
assign pair_csrstorage35_storage = pair_csrstorage35_storage_full[13:0];
assign pair_wait_31_w = pair_csrstorage35_storage_full[13:8];
assign pair_wait_30_w = pair_csrstorage35_storage_full[7:0];
assign pair_csrstorage36_storage = pair_csrstorage36_storage_full[13:0];
assign pair_wait_41_w = pair_csrstorage36_storage_full[13:8];
assign pair_wait_40_w = pair_csrstorage36_storage_full[7:0];
assign pair_csrstorage37_storage = pair_csrstorage37_storage_full[13:0];
assign pair_wait_51_w = pair_csrstorage37_storage_full[13:8];
assign pair_wait_50_w = pair_csrstorage37_storage_full[7:0];
assign pair_csrstorage38_storage = pair_csrstorage38_storage_full[13:0];
assign pair_wait_61_w = pair_csrstorage38_storage_full[13:8];
assign pair_wait_60_w = pair_csrstorage38_storage_full[7:0];
assign pair_csrstorage39_storage = pair_csrstorage39_storage_full[13:0];
assign pair_wait_71_w = pair_csrstorage39_storage_full[13:8];
assign pair_wait_70_w = pair_csrstorage39_storage_full[7:0];
assign pair_csrstorage40_storage = pair_csrstorage40_storage_full[13:0];
assign pair_wait_81_w = pair_csrstorage40_storage_full[13:8];
assign pair_wait_80_w = pair_csrstorage40_storage_full[7:0];
assign pair_csrstorage41_storage = pair_csrstorage41_storage_full[13:0];
assign pair_wait_91_w = pair_csrstorage41_storage_full[13:8];
assign pair_wait_90_w = pair_csrstorage41_storage_full[7:0];
assign pair_csrstorage42_storage = pair_csrstorage42_storage_full[13:0];
assign pair_wait_101_w = pair_csrstorage42_storage_full[13:8];
assign pair_wait_100_w = pair_csrstorage42_storage_full[7:0];
assign pair_csrstorage43_storage = pair_csrstorage43_storage_full[13:0];
assign pair_wait_111_w = pair_csrstorage43_storage_full[13:8];
assign pair_wait_110_w = pair_csrstorage43_storage_full[7:0];
assign pair_csrstorage44_storage = pair_csrstorage44_storage_full[13:0];
assign pair_wait_121_w = pair_csrstorage44_storage_full[13:8];
assign pair_wait_120_w = pair_csrstorage44_storage_full[7:0];
assign pair_csrstorage45_storage = pair_csrstorage45_storage_full[13:0];
assign pair_wait_131_w = pair_csrstorage45_storage_full[13:8];
assign pair_wait_130_w = pair_csrstorage45_storage_full[7:0];
assign pair_csrstorage46_storage = pair_csrstorage46_storage_full[13:0];
assign pair_wait_141_w = pair_csrstorage46_storage_full[13:8];
assign pair_wait_140_w = pair_csrstorage46_storage_full[7:0];
assign pair_csrstorage47_storage = pair_csrstorage47_storage_full[13:0];
assign pair_wait_151_w = pair_csrstorage47_storage_full[13:8];
assign pair_wait_150_w = pair_csrstorage47_storage_full[7:0];
assign pair_csrstorage48_storage = pair_csrstorage48_storage_full[13:0];
assign pair_wait_161_w = pair_csrstorage48_storage_full[13:8];
assign pair_wait_160_w = pair_csrstorage48_storage_full[7:0];
assign pair_csrstorage49_storage = pair_csrstorage49_storage_full[13:0];
assign pair_wait_171_w = pair_csrstorage49_storage_full[13:8];
assign pair_wait_170_w = pair_csrstorage49_storage_full[7:0];
assign pair_csrstorage50_storage = pair_csrstorage50_storage_full[13:0];
assign pair_wait_181_w = pair_csrstorage50_storage_full[13:8];
assign pair_wait_180_w = pair_csrstorage50_storage_full[7:0];
assign pair_csrstorage51_storage = pair_csrstorage51_storage_full[13:0];
assign pair_wait_191_w = pair_csrstorage51_storage_full[13:8];
assign pair_wait_190_w = pair_csrstorage51_storage_full[7:0];
assign pair_csrstorage52_storage = pair_csrstorage52_storage_full[13:0];
assign pair_wait_201_w = pair_csrstorage52_storage_full[13:8];
assign pair_wait_200_w = pair_csrstorage52_storage_full[7:0];
assign pair_csrstorage53_storage = pair_csrstorage53_storage_full[13:0];
assign pair_wait_211_w = pair_csrstorage53_storage_full[13:8];
assign pair_wait_210_w = pair_csrstorage53_storage_full[7:0];
assign pair_csrstorage54_storage = pair_csrstorage54_storage_full[13:0];
assign pair_wait_221_w = pair_csrstorage54_storage_full[13:8];
assign pair_wait_220_w = pair_csrstorage54_storage_full[7:0];
assign pair_csrstorage55_storage = pair_csrstorage55_storage_full[13:0];
assign pair_wait_231_w = pair_csrstorage55_storage_full[13:8];
assign pair_wait_230_w = pair_csrstorage55_storage_full[7:0];
assign pair_csrstorage56_storage = pair_csrstorage56_storage_full[13:0];
assign pair_wait_241_w = pair_csrstorage56_storage_full[13:8];
assign pair_wait_240_w = pair_csrstorage56_storage_full[7:0];
assign pair_csrstorage57_storage = pair_csrstorage57_storage_full[13:0];
assign pair_wait_251_w = pair_csrstorage57_storage_full[13:8];
assign pair_wait_250_w = pair_csrstorage57_storage_full[7:0];
assign pair_csrstorage58_storage = pair_csrstorage58_storage_full[13:0];
assign pair_wait_261_w = pair_csrstorage58_storage_full[13:8];
assign pair_wait_260_w = pair_csrstorage58_storage_full[7:0];
assign pair_csrstorage59_storage = pair_csrstorage59_storage_full[13:0];
assign pair_wait_271_w = pair_csrstorage59_storage_full[13:8];
assign pair_wait_270_w = pair_csrstorage59_storage_full[7:0];
assign pair_csrstorage60_storage = pair_csrstorage60_storage_full[13:0];
assign pair_wait_281_w = pair_csrstorage60_storage_full[13:8];
assign pair_wait_280_w = pair_csrstorage60_storage_full[7:0];
assign pair_csrstorage61_storage = pair_csrstorage61_storage_full[13:0];
assign pair_wait_291_w = pair_csrstorage61_storage_full[13:8];
assign pair_wait_290_w = pair_csrstorage61_storage_full[7:0];
assign pair_csrstorage62_storage = pair_csrstorage62_storage_full[13:0];
assign pair_wait_301_w = pair_csrstorage62_storage_full[13:8];
assign pair_wait_300_w = pair_csrstorage62_storage_full[7:0];
assign pair_csrstorage63_storage = pair_csrstorage63_storage_full[13:0];
assign pair_wait_311_w = pair_csrstorage63_storage_full[13:8];
assign pair_wait_310_w = pair_csrstorage63_storage_full[7:0];

// synthesis translate_off
reg dummy_d_41;
// synthesis translate_on
always @(*) begin
	comb_array_muxed0 <= 28'd0;
	case (pair_index)
		1'd0: begin
			comb_array_muxed0 <= pair_csrstorage0_storage;
		end
		1'd1: begin
			comb_array_muxed0 <= pair_csrstorage1_storage;
		end
		2'd2: begin
			comb_array_muxed0 <= pair_csrstorage2_storage;
		end
		2'd3: begin
			comb_array_muxed0 <= pair_csrstorage3_storage;
		end
		3'd4: begin
			comb_array_muxed0 <= pair_csrstorage4_storage;
		end
		3'd5: begin
			comb_array_muxed0 <= pair_csrstorage5_storage;
		end
		3'd6: begin
			comb_array_muxed0 <= pair_csrstorage6_storage;
		end
		3'd7: begin
			comb_array_muxed0 <= pair_csrstorage7_storage;
		end
		4'd8: begin
			comb_array_muxed0 <= pair_csrstorage8_storage;
		end
		4'd9: begin
			comb_array_muxed0 <= pair_csrstorage9_storage;
		end
		4'd10: begin
			comb_array_muxed0 <= pair_csrstorage10_storage;
		end
		4'd11: begin
			comb_array_muxed0 <= pair_csrstorage11_storage;
		end
		4'd12: begin
			comb_array_muxed0 <= pair_csrstorage12_storage;
		end
		4'd13: begin
			comb_array_muxed0 <= pair_csrstorage13_storage;
		end
		4'd14: begin
			comb_array_muxed0 <= pair_csrstorage14_storage;
		end
		4'd15: begin
			comb_array_muxed0 <= pair_csrstorage15_storage;
		end
		5'd16: begin
			comb_array_muxed0 <= pair_csrstorage16_storage;
		end
		5'd17: begin
			comb_array_muxed0 <= pair_csrstorage17_storage;
		end
		5'd18: begin
			comb_array_muxed0 <= pair_csrstorage18_storage;
		end
		5'd19: begin
			comb_array_muxed0 <= pair_csrstorage19_storage;
		end
		5'd20: begin
			comb_array_muxed0 <= pair_csrstorage20_storage;
		end
		5'd21: begin
			comb_array_muxed0 <= pair_csrstorage21_storage;
		end
		5'd22: begin
			comb_array_muxed0 <= pair_csrstorage22_storage;
		end
		5'd23: begin
			comb_array_muxed0 <= pair_csrstorage23_storage;
		end
		5'd24: begin
			comb_array_muxed0 <= pair_csrstorage24_storage;
		end
		5'd25: begin
			comb_array_muxed0 <= pair_csrstorage25_storage;
		end
		5'd26: begin
			comb_array_muxed0 <= pair_csrstorage26_storage;
		end
		5'd27: begin
			comb_array_muxed0 <= pair_csrstorage27_storage;
		end
		5'd28: begin
			comb_array_muxed0 <= pair_csrstorage28_storage;
		end
		5'd29: begin
			comb_array_muxed0 <= pair_csrstorage29_storage;
		end
		5'd30: begin
			comb_array_muxed0 <= pair_csrstorage30_storage;
		end
		default: begin
			comb_array_muxed0 <= pair_csrstorage31_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_41 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_42;
// synthesis translate_on
always @(*) begin
	comb_array_muxed1 <= 28'sd0;
	case (pair_new_prefetch_choice)
		1'd0: begin
			comb_array_muxed1 <= pair_new_prefetch_current_magnitude;
		end
		1'd1: begin
			comb_array_muxed1 <= pair_new_prefetch_next_magnitude;
		end
		default: begin
			comb_array_muxed1 <= pair_new_prefetch_zero_magnitude;
		end
	endcase
// synthesis translate_off
	dummy_d_42 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_43;
// synthesis translate_on
always @(*) begin
	comb_array_muxed2 <= 29'sd0;
	case (pair_new_prefetch_choice)
		1'd0: begin
			comb_array_muxed2 <= pair_new_prefetch_current_negative;
		end
		1'd1: begin
			comb_array_muxed2 <= pair_new_prefetch_next_negative;
		end
		default: begin
			comb_array_muxed2 <= pair_new_prefetch_zero_negative;
		end
	endcase
// synthesis translate_off
	dummy_d_43 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_44;
// synthesis translate_on
always @(*) begin
	comb_array_muxed3 <= 1'd0;
	case (pair_new_prefetch_choice)
		1'd0: begin
			comb_array_muxed3 <= pair_new_prefetch_current_positive;
		end
		1'd1: begin
			comb_array_muxed3 <= pair_new_prefetch_next_positive;
		end
		default: begin
			comb_array_muxed3 <= pair_new_prefetch_zero_positive;
		end
	endcase
// synthesis translate_off
	dummy_d_44 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_45;
// synthesis translate_on
always @(*) begin
	comb_array_muxed4 <= 14'd0;
	case (pair_new_prefetch_choice)
		1'd0: begin
			comb_array_muxed4 <= pair_new_prefetch_current_wait;
		end
		1'd1: begin
			comb_array_muxed4 <= pair_new_prefetch_next_wait;
		end
		default: begin
			comb_array_muxed4 <= pair_new_prefetch_zero_wait;
		end
	endcase
// synthesis translate_off
	dummy_d_45 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_46;
// synthesis translate_on
always @(*) begin
	comb_array_muxed5 <= 28'd0;
	case (pair_next_probe)
		1'd0: begin
			comb_array_muxed5 <= pair_csrstorage0_storage;
		end
		1'd1: begin
			comb_array_muxed5 <= pair_csrstorage1_storage;
		end
		2'd2: begin
			comb_array_muxed5 <= pair_csrstorage2_storage;
		end
		2'd3: begin
			comb_array_muxed5 <= pair_csrstorage3_storage;
		end
		3'd4: begin
			comb_array_muxed5 <= pair_csrstorage4_storage;
		end
		3'd5: begin
			comb_array_muxed5 <= pair_csrstorage5_storage;
		end
		3'd6: begin
			comb_array_muxed5 <= pair_csrstorage6_storage;
		end
		3'd7: begin
			comb_array_muxed5 <= pair_csrstorage7_storage;
		end
		4'd8: begin
			comb_array_muxed5 <= pair_csrstorage8_storage;
		end
		4'd9: begin
			comb_array_muxed5 <= pair_csrstorage9_storage;
		end
		4'd10: begin
			comb_array_muxed5 <= pair_csrstorage10_storage;
		end
		4'd11: begin
			comb_array_muxed5 <= pair_csrstorage11_storage;
		end
		4'd12: begin
			comb_array_muxed5 <= pair_csrstorage12_storage;
		end
		4'd13: begin
			comb_array_muxed5 <= pair_csrstorage13_storage;
		end
		4'd14: begin
			comb_array_muxed5 <= pair_csrstorage14_storage;
		end
		4'd15: begin
			comb_array_muxed5 <= pair_csrstorage15_storage;
		end
		5'd16: begin
			comb_array_muxed5 <= pair_csrstorage16_storage;
		end
		5'd17: begin
			comb_array_muxed5 <= pair_csrstorage17_storage;
		end
		5'd18: begin
			comb_array_muxed5 <= pair_csrstorage18_storage;
		end
		5'd19: begin
			comb_array_muxed5 <= pair_csrstorage19_storage;
		end
		5'd20: begin
			comb_array_muxed5 <= pair_csrstorage20_storage;
		end
		5'd21: begin
			comb_array_muxed5 <= pair_csrstorage21_storage;
		end
		5'd22: begin
			comb_array_muxed5 <= pair_csrstorage22_storage;
		end
		5'd23: begin
			comb_array_muxed5 <= pair_csrstorage23_storage;
		end
		5'd24: begin
			comb_array_muxed5 <= pair_csrstorage24_storage;
		end
		5'd25: begin
			comb_array_muxed5 <= pair_csrstorage25_storage;
		end
		5'd26: begin
			comb_array_muxed5 <= pair_csrstorage26_storage;
		end
		5'd27: begin
			comb_array_muxed5 <= pair_csrstorage27_storage;
		end
		5'd28: begin
			comb_array_muxed5 <= pair_csrstorage28_storage;
		end
		5'd29: begin
			comb_array_muxed5 <= pair_csrstorage29_storage;
		end
		5'd30: begin
			comb_array_muxed5 <= pair_csrstorage30_storage;
		end
		default: begin
			comb_array_muxed5 <= pair_csrstorage31_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_46 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_47;
// synthesis translate_on
always @(*) begin
	comb_array_muxed6 <= 28'sd0;
	case (pair_index)
		1'd0: begin
			comb_array_muxed6 <= pair_mag0;
		end
		1'd1: begin
			comb_array_muxed6 <= pair_mag1;
		end
		2'd2: begin
			comb_array_muxed6 <= pair_mag2;
		end
		2'd3: begin
			comb_array_muxed6 <= pair_mag3;
		end
		3'd4: begin
			comb_array_muxed6 <= pair_mag4;
		end
		3'd5: begin
			comb_array_muxed6 <= pair_mag5;
		end
		3'd6: begin
			comb_array_muxed6 <= pair_mag6;
		end
		3'd7: begin
			comb_array_muxed6 <= pair_mag7;
		end
		4'd8: begin
			comb_array_muxed6 <= pair_mag8;
		end
		4'd9: begin
			comb_array_muxed6 <= pair_mag9;
		end
		4'd10: begin
			comb_array_muxed6 <= pair_mag10;
		end
		4'd11: begin
			comb_array_muxed6 <= pair_mag11;
		end
		4'd12: begin
			comb_array_muxed6 <= pair_mag12;
		end
		4'd13: begin
			comb_array_muxed6 <= pair_mag13;
		end
		4'd14: begin
			comb_array_muxed6 <= pair_mag14;
		end
		4'd15: begin
			comb_array_muxed6 <= pair_mag15;
		end
		5'd16: begin
			comb_array_muxed6 <= pair_mag16;
		end
		5'd17: begin
			comb_array_muxed6 <= pair_mag17;
		end
		5'd18: begin
			comb_array_muxed6 <= pair_mag18;
		end
		5'd19: begin
			comb_array_muxed6 <= pair_mag19;
		end
		5'd20: begin
			comb_array_muxed6 <= pair_mag20;
		end
		5'd21: begin
			comb_array_muxed6 <= pair_mag21;
		end
		5'd22: begin
			comb_array_muxed6 <= pair_mag22;
		end
		5'd23: begin
			comb_array_muxed6 <= pair_mag23;
		end
		5'd24: begin
			comb_array_muxed6 <= pair_mag24;
		end
		5'd25: begin
			comb_array_muxed6 <= pair_mag25;
		end
		5'd26: begin
			comb_array_muxed6 <= pair_mag26;
		end
		5'd27: begin
			comb_array_muxed6 <= pair_mag27;
		end
		5'd28: begin
			comb_array_muxed6 <= pair_mag28;
		end
		5'd29: begin
			comb_array_muxed6 <= pair_mag29;
		end
		5'd30: begin
			comb_array_muxed6 <= pair_mag30;
		end
		default: begin
			comb_array_muxed6 <= pair_mag31;
		end
	endcase
// synthesis translate_off
	dummy_d_47 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_48;
// synthesis translate_on
always @(*) begin
	comb_array_muxed7 <= 29'sd0;
	case (pair_index)
		1'd0: begin
			comb_array_muxed7 <= pair_neg0;
		end
		1'd1: begin
			comb_array_muxed7 <= pair_neg1;
		end
		2'd2: begin
			comb_array_muxed7 <= pair_neg2;
		end
		2'd3: begin
			comb_array_muxed7 <= pair_neg3;
		end
		3'd4: begin
			comb_array_muxed7 <= pair_neg4;
		end
		3'd5: begin
			comb_array_muxed7 <= pair_neg5;
		end
		3'd6: begin
			comb_array_muxed7 <= pair_neg6;
		end
		3'd7: begin
			comb_array_muxed7 <= pair_neg7;
		end
		4'd8: begin
			comb_array_muxed7 <= pair_neg8;
		end
		4'd9: begin
			comb_array_muxed7 <= pair_neg9;
		end
		4'd10: begin
			comb_array_muxed7 <= pair_neg10;
		end
		4'd11: begin
			comb_array_muxed7 <= pair_neg11;
		end
		4'd12: begin
			comb_array_muxed7 <= pair_neg12;
		end
		4'd13: begin
			comb_array_muxed7 <= pair_neg13;
		end
		4'd14: begin
			comb_array_muxed7 <= pair_neg14;
		end
		4'd15: begin
			comb_array_muxed7 <= pair_neg15;
		end
		5'd16: begin
			comb_array_muxed7 <= pair_neg16;
		end
		5'd17: begin
			comb_array_muxed7 <= pair_neg17;
		end
		5'd18: begin
			comb_array_muxed7 <= pair_neg18;
		end
		5'd19: begin
			comb_array_muxed7 <= pair_neg19;
		end
		5'd20: begin
			comb_array_muxed7 <= pair_neg20;
		end
		5'd21: begin
			comb_array_muxed7 <= pair_neg21;
		end
		5'd22: begin
			comb_array_muxed7 <= pair_neg22;
		end
		5'd23: begin
			comb_array_muxed7 <= pair_neg23;
		end
		5'd24: begin
			comb_array_muxed7 <= pair_neg24;
		end
		5'd25: begin
			comb_array_muxed7 <= pair_neg25;
		end
		5'd26: begin
			comb_array_muxed7 <= pair_neg26;
		end
		5'd27: begin
			comb_array_muxed7 <= pair_neg27;
		end
		5'd28: begin
			comb_array_muxed7 <= pair_neg28;
		end
		5'd29: begin
			comb_array_muxed7 <= pair_neg29;
		end
		5'd30: begin
			comb_array_muxed7 <= pair_neg30;
		end
		default: begin
			comb_array_muxed7 <= pair_neg31;
		end
	endcase
// synthesis translate_off
	dummy_d_48 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_49;
// synthesis translate_on
always @(*) begin
	comb_array_muxed8 <= 1'd0;
	case (pair_index)
		1'd0: begin
			comb_array_muxed8 <= pair_pos0;
		end
		1'd1: begin
			comb_array_muxed8 <= pair_pos1;
		end
		2'd2: begin
			comb_array_muxed8 <= pair_pos2;
		end
		2'd3: begin
			comb_array_muxed8 <= pair_pos3;
		end
		3'd4: begin
			comb_array_muxed8 <= pair_pos4;
		end
		3'd5: begin
			comb_array_muxed8 <= pair_pos5;
		end
		3'd6: begin
			comb_array_muxed8 <= pair_pos6;
		end
		3'd7: begin
			comb_array_muxed8 <= pair_pos7;
		end
		4'd8: begin
			comb_array_muxed8 <= pair_pos8;
		end
		4'd9: begin
			comb_array_muxed8 <= pair_pos9;
		end
		4'd10: begin
			comb_array_muxed8 <= pair_pos10;
		end
		4'd11: begin
			comb_array_muxed8 <= pair_pos11;
		end
		4'd12: begin
			comb_array_muxed8 <= pair_pos12;
		end
		4'd13: begin
			comb_array_muxed8 <= pair_pos13;
		end
		4'd14: begin
			comb_array_muxed8 <= pair_pos14;
		end
		4'd15: begin
			comb_array_muxed8 <= pair_pos15;
		end
		5'd16: begin
			comb_array_muxed8 <= pair_pos16;
		end
		5'd17: begin
			comb_array_muxed8 <= pair_pos17;
		end
		5'd18: begin
			comb_array_muxed8 <= pair_pos18;
		end
		5'd19: begin
			comb_array_muxed8 <= pair_pos19;
		end
		5'd20: begin
			comb_array_muxed8 <= pair_pos20;
		end
		5'd21: begin
			comb_array_muxed8 <= pair_pos21;
		end
		5'd22: begin
			comb_array_muxed8 <= pair_pos22;
		end
		5'd23: begin
			comb_array_muxed8 <= pair_pos23;
		end
		5'd24: begin
			comb_array_muxed8 <= pair_pos24;
		end
		5'd25: begin
			comb_array_muxed8 <= pair_pos25;
		end
		5'd26: begin
			comb_array_muxed8 <= pair_pos26;
		end
		5'd27: begin
			comb_array_muxed8 <= pair_pos27;
		end
		5'd28: begin
			comb_array_muxed8 <= pair_pos28;
		end
		5'd29: begin
			comb_array_muxed8 <= pair_pos29;
		end
		5'd30: begin
			comb_array_muxed8 <= pair_pos30;
		end
		default: begin
			comb_array_muxed8 <= pair_pos31;
		end
	endcase
// synthesis translate_off
	dummy_d_49 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_50;
// synthesis translate_on
always @(*) begin
	comb_array_muxed9 <= 14'd0;
	case (pair_index)
		1'd0: begin
			comb_array_muxed9 <= pair_w0;
		end
		1'd1: begin
			comb_array_muxed9 <= pair_w1;
		end
		2'd2: begin
			comb_array_muxed9 <= pair_w2;
		end
		2'd3: begin
			comb_array_muxed9 <= pair_w3;
		end
		3'd4: begin
			comb_array_muxed9 <= pair_w4;
		end
		3'd5: begin
			comb_array_muxed9 <= pair_w5;
		end
		3'd6: begin
			comb_array_muxed9 <= pair_w6;
		end
		3'd7: begin
			comb_array_muxed9 <= pair_w7;
		end
		4'd8: begin
			comb_array_muxed9 <= pair_w8;
		end
		4'd9: begin
			comb_array_muxed9 <= pair_w9;
		end
		4'd10: begin
			comb_array_muxed9 <= pair_w10;
		end
		4'd11: begin
			comb_array_muxed9 <= pair_w11;
		end
		4'd12: begin
			comb_array_muxed9 <= pair_w12;
		end
		4'd13: begin
			comb_array_muxed9 <= pair_w13;
		end
		4'd14: begin
			comb_array_muxed9 <= pair_w14;
		end
		4'd15: begin
			comb_array_muxed9 <= pair_w15;
		end
		5'd16: begin
			comb_array_muxed9 <= pair_w16;
		end
		5'd17: begin
			comb_array_muxed9 <= pair_w17;
		end
		5'd18: begin
			comb_array_muxed9 <= pair_w18;
		end
		5'd19: begin
			comb_array_muxed9 <= pair_w19;
		end
		5'd20: begin
			comb_array_muxed9 <= pair_w20;
		end
		5'd21: begin
			comb_array_muxed9 <= pair_w21;
		end
		5'd22: begin
			comb_array_muxed9 <= pair_w22;
		end
		5'd23: begin
			comb_array_muxed9 <= pair_w23;
		end
		5'd24: begin
			comb_array_muxed9 <= pair_w24;
		end
		5'd25: begin
			comb_array_muxed9 <= pair_w25;
		end
		5'd26: begin
			comb_array_muxed9 <= pair_w26;
		end
		5'd27: begin
			comb_array_muxed9 <= pair_w27;
		end
		5'd28: begin
			comb_array_muxed9 <= pair_w28;
		end
		5'd29: begin
			comb_array_muxed9 <= pair_w29;
		end
		5'd30: begin
			comb_array_muxed9 <= pair_w30;
		end
		default: begin
			comb_array_muxed9 <= pair_w31;
		end
	endcase
// synthesis translate_off
	dummy_d_50 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_51;
// synthesis translate_on
always @(*) begin
	sync_array_muxed <= 14'd0;
	case (pair_index)
		1'd0: begin
			sync_array_muxed <= pair_csrstorage32_storage;
		end
		1'd1: begin
			sync_array_muxed <= pair_csrstorage33_storage;
		end
		2'd2: begin
			sync_array_muxed <= pair_csrstorage34_storage;
		end
		2'd3: begin
			sync_array_muxed <= pair_csrstorage35_storage;
		end
		3'd4: begin
			sync_array_muxed <= pair_csrstorage36_storage;
		end
		3'd5: begin
			sync_array_muxed <= pair_csrstorage37_storage;
		end
		3'd6: begin
			sync_array_muxed <= pair_csrstorage38_storage;
		end
		3'd7: begin
			sync_array_muxed <= pair_csrstorage39_storage;
		end
		4'd8: begin
			sync_array_muxed <= pair_csrstorage40_storage;
		end
		4'd9: begin
			sync_array_muxed <= pair_csrstorage41_storage;
		end
		4'd10: begin
			sync_array_muxed <= pair_csrstorage42_storage;
		end
		4'd11: begin
			sync_array_muxed <= pair_csrstorage43_storage;
		end
		4'd12: begin
			sync_array_muxed <= pair_csrstorage44_storage;
		end
		4'd13: begin
			sync_array_muxed <= pair_csrstorage45_storage;
		end
		4'd14: begin
			sync_array_muxed <= pair_csrstorage46_storage;
		end
		4'd15: begin
			sync_array_muxed <= pair_csrstorage47_storage;
		end
		5'd16: begin
			sync_array_muxed <= pair_csrstorage48_storage;
		end
		5'd17: begin
			sync_array_muxed <= pair_csrstorage49_storage;
		end
		5'd18: begin
			sync_array_muxed <= pair_csrstorage50_storage;
		end
		5'd19: begin
			sync_array_muxed <= pair_csrstorage51_storage;
		end
		5'd20: begin
			sync_array_muxed <= pair_csrstorage52_storage;
		end
		5'd21: begin
			sync_array_muxed <= pair_csrstorage53_storage;
		end
		5'd22: begin
			sync_array_muxed <= pair_csrstorage54_storage;
		end
		5'd23: begin
			sync_array_muxed <= pair_csrstorage55_storage;
		end
		5'd24: begin
			sync_array_muxed <= pair_csrstorage56_storage;
		end
		5'd25: begin
			sync_array_muxed <= pair_csrstorage57_storage;
		end
		5'd26: begin
			sync_array_muxed <= pair_csrstorage58_storage;
		end
		5'd27: begin
			sync_array_muxed <= pair_csrstorage59_storage;
		end
		5'd28: begin
			sync_array_muxed <= pair_csrstorage60_storage;
		end
		5'd29: begin
			sync_array_muxed <= pair_csrstorage61_storage;
		end
		5'd30: begin
			sync_array_muxed <= pair_csrstorage62_storage;
		end
		default: begin
			sync_array_muxed <= pair_csrstorage63_storage;
		end
	endcase
// synthesis translate_off
	dummy_d_51 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	if (start) begin
		pair_index <= 1'd0;
	end else begin
		if (advance) begin
			pair_index <= (pair_index + 1'd1);
		end
	end
	pair_mag0 <= pair_absolute0;
	pair_neg0 <= (-pair_extended0);
	pair_pos0 <= (pair_raw0 > $signed({1'd0, 1'd0}));
	pair_w0 <= pair_csrstorage32_storage;
	pair_mag1 <= pair_absolute1;
	pair_neg1 <= (-pair_extended1);
	pair_pos1 <= (pair_raw1 > $signed({1'd0, 1'd0}));
	pair_w1 <= pair_csrstorage33_storage;
	pair_mag2 <= pair_absolute2;
	pair_neg2 <= (-pair_extended2);
	pair_pos2 <= (pair_raw2 > $signed({1'd0, 1'd0}));
	pair_w2 <= pair_csrstorage34_storage;
	pair_mag3 <= pair_absolute3;
	pair_neg3 <= (-pair_extended3);
	pair_pos3 <= (pair_raw3 > $signed({1'd0, 1'd0}));
	pair_w3 <= pair_csrstorage35_storage;
	pair_mag4 <= pair_absolute4;
	pair_neg4 <= (-pair_extended4);
	pair_pos4 <= (pair_raw4 > $signed({1'd0, 1'd0}));
	pair_w4 <= pair_csrstorage36_storage;
	pair_mag5 <= pair_absolute5;
	pair_neg5 <= (-pair_extended5);
	pair_pos5 <= (pair_raw5 > $signed({1'd0, 1'd0}));
	pair_w5 <= pair_csrstorage37_storage;
	pair_mag6 <= pair_absolute6;
	pair_neg6 <= (-pair_extended6);
	pair_pos6 <= (pair_raw6 > $signed({1'd0, 1'd0}));
	pair_w6 <= pair_csrstorage38_storage;
	pair_mag7 <= pair_absolute7;
	pair_neg7 <= (-pair_extended7);
	pair_pos7 <= (pair_raw7 > $signed({1'd0, 1'd0}));
	pair_w7 <= pair_csrstorage39_storage;
	pair_mag8 <= pair_absolute8;
	pair_neg8 <= (-pair_extended8);
	pair_pos8 <= (pair_raw8 > $signed({1'd0, 1'd0}));
	pair_w8 <= pair_csrstorage40_storage;
	pair_mag9 <= pair_absolute9;
	pair_neg9 <= (-pair_extended9);
	pair_pos9 <= (pair_raw9 > $signed({1'd0, 1'd0}));
	pair_w9 <= pair_csrstorage41_storage;
	pair_mag10 <= pair_absolute10;
	pair_neg10 <= (-pair_extended10);
	pair_pos10 <= (pair_raw10 > $signed({1'd0, 1'd0}));
	pair_w10 <= pair_csrstorage42_storage;
	pair_mag11 <= pair_absolute11;
	pair_neg11 <= (-pair_extended11);
	pair_pos11 <= (pair_raw11 > $signed({1'd0, 1'd0}));
	pair_w11 <= pair_csrstorage43_storage;
	pair_mag12 <= pair_absolute12;
	pair_neg12 <= (-pair_extended12);
	pair_pos12 <= (pair_raw12 > $signed({1'd0, 1'd0}));
	pair_w12 <= pair_csrstorage44_storage;
	pair_mag13 <= pair_absolute13;
	pair_neg13 <= (-pair_extended13);
	pair_pos13 <= (pair_raw13 > $signed({1'd0, 1'd0}));
	pair_w13 <= pair_csrstorage45_storage;
	pair_mag14 <= pair_absolute14;
	pair_neg14 <= (-pair_extended14);
	pair_pos14 <= (pair_raw14 > $signed({1'd0, 1'd0}));
	pair_w14 <= pair_csrstorage46_storage;
	pair_mag15 <= pair_absolute15;
	pair_neg15 <= (-pair_extended15);
	pair_pos15 <= (pair_raw15 > $signed({1'd0, 1'd0}));
	pair_w15 <= pair_csrstorage47_storage;
	pair_mag16 <= pair_absolute16;
	pair_neg16 <= (-pair_extended16);
	pair_pos16 <= (pair_raw16 > $signed({1'd0, 1'd0}));
	pair_w16 <= pair_csrstorage48_storage;
	pair_mag17 <= pair_absolute17;
	pair_neg17 <= (-pair_extended17);
	pair_pos17 <= (pair_raw17 > $signed({1'd0, 1'd0}));
	pair_w17 <= pair_csrstorage49_storage;
	pair_mag18 <= pair_absolute18;
	pair_neg18 <= (-pair_extended18);
	pair_pos18 <= (pair_raw18 > $signed({1'd0, 1'd0}));
	pair_w18 <= pair_csrstorage50_storage;
	pair_mag19 <= pair_absolute19;
	pair_neg19 <= (-pair_extended19);
	pair_pos19 <= (pair_raw19 > $signed({1'd0, 1'd0}));
	pair_w19 <= pair_csrstorage51_storage;
	pair_mag20 <= pair_absolute20;
	pair_neg20 <= (-pair_extended20);
	pair_pos20 <= (pair_raw20 > $signed({1'd0, 1'd0}));
	pair_w20 <= pair_csrstorage52_storage;
	pair_mag21 <= pair_absolute21;
	pair_neg21 <= (-pair_extended21);
	pair_pos21 <= (pair_raw21 > $signed({1'd0, 1'd0}));
	pair_w21 <= pair_csrstorage53_storage;
	pair_mag22 <= pair_absolute22;
	pair_neg22 <= (-pair_extended22);
	pair_pos22 <= (pair_raw22 > $signed({1'd0, 1'd0}));
	pair_w22 <= pair_csrstorage54_storage;
	pair_mag23 <= pair_absolute23;
	pair_neg23 <= (-pair_extended23);
	pair_pos23 <= (pair_raw23 > $signed({1'd0, 1'd0}));
	pair_w23 <= pair_csrstorage55_storage;
	pair_mag24 <= pair_absolute24;
	pair_neg24 <= (-pair_extended24);
	pair_pos24 <= (pair_raw24 > $signed({1'd0, 1'd0}));
	pair_w24 <= pair_csrstorage56_storage;
	pair_mag25 <= pair_absolute25;
	pair_neg25 <= (-pair_extended25);
	pair_pos25 <= (pair_raw25 > $signed({1'd0, 1'd0}));
	pair_w25 <= pair_csrstorage57_storage;
	pair_mag26 <= pair_absolute26;
	pair_neg26 <= (-pair_extended26);
	pair_pos26 <= (pair_raw26 > $signed({1'd0, 1'd0}));
	pair_w26 <= pair_csrstorage58_storage;
	pair_mag27 <= pair_absolute27;
	pair_neg27 <= (-pair_extended27);
	pair_pos27 <= (pair_raw27 > $signed({1'd0, 1'd0}));
	pair_w27 <= pair_csrstorage59_storage;
	pair_mag28 <= pair_absolute28;
	pair_neg28 <= (-pair_extended28);
	pair_pos28 <= (pair_raw28 > $signed({1'd0, 1'd0}));
	pair_w28 <= pair_csrstorage60_storage;
	pair_mag29 <= pair_absolute29;
	pair_neg29 <= (-pair_extended29);
	pair_pos29 <= (pair_raw29 > $signed({1'd0, 1'd0}));
	pair_w29 <= pair_csrstorage61_storage;
	pair_mag30 <= pair_absolute30;
	pair_neg30 <= (-pair_extended30);
	pair_pos30 <= (pair_raw30 > $signed({1'd0, 1'd0}));
	pair_w30 <= pair_csrstorage62_storage;
	pair_mag31 <= pair_absolute31;
	pair_neg31 <= (-pair_extended31);
	pair_pos31 <= (pair_raw31 > $signed({1'd0, 1'd0}));
	pair_w31 <= pair_csrstorage63_storage;
	if (start) begin
		pair_new_prefetch_choice <= 2'd2;
	end else begin
		if (advance) begin
			pair_new_prefetch_choice <= 1'd1;
		end else begin
			pair_new_prefetch_choice <= 1'd0;
		end
	end
	pair_new_prefetch_current_magnitude <= pair_new_absolute0;
	pair_new_prefetch_current_negative <= {pair_new_negative_sign0, pair_new_negative_low0};
	pair_new_prefetch_current_positive <= (pair_new_prefetch_current_signed > $signed({1'd0, 1'd0}));
	pair_new_prefetch_current_wait <= sync_array_muxed;
	pair_new_prefetch_next_magnitude <= pair_new_absolute1;
	pair_new_prefetch_next_negative <= {pair_new_negative_sign1, pair_new_negative_low1};
	pair_new_prefetch_next_positive <= (pair_new_prefetch_next_signed > $signed({1'd0, 1'd0}));
	pair_new_prefetch_next_wait <= pair_new_result1;
	pair_new_prefetch_zero_magnitude <= pair_new_absolute2;
	pair_new_prefetch_zero_negative <= {pair_new_negative_sign2, pair_new_negative_low2};
	pair_new_prefetch_zero_positive <= (pair_new_prefetch_zero_signed > $signed({1'd0, 1'd0}));
	pair_new_prefetch_zero_wait <= pair_csrstorage32_storage;
	pair_bus_dat_r <= 1'd0;
	if (pair_sel) begin
		case (pair_bus_adr[7:0])
			1'd0: begin
				pair_bus_dat_r <= pair_peak_03_w;
			end
			1'd1: begin
				pair_bus_dat_r <= pair_peak_02_w;
			end
			2'd2: begin
				pair_bus_dat_r <= pair_peak_01_w;
			end
			2'd3: begin
				pair_bus_dat_r <= pair_peak_00_w;
			end
			3'd4: begin
				pair_bus_dat_r <= pair_peak_13_w;
			end
			3'd5: begin
				pair_bus_dat_r <= pair_peak_12_w;
			end
			3'd6: begin
				pair_bus_dat_r <= pair_peak_11_w;
			end
			3'd7: begin
				pair_bus_dat_r <= pair_peak_10_w;
			end
			4'd8: begin
				pair_bus_dat_r <= pair_peak_23_w;
			end
			4'd9: begin
				pair_bus_dat_r <= pair_peak_22_w;
			end
			4'd10: begin
				pair_bus_dat_r <= pair_peak_21_w;
			end
			4'd11: begin
				pair_bus_dat_r <= pair_peak_20_w;
			end
			4'd12: begin
				pair_bus_dat_r <= pair_peak_33_w;
			end
			4'd13: begin
				pair_bus_dat_r <= pair_peak_32_w;
			end
			4'd14: begin
				pair_bus_dat_r <= pair_peak_31_w;
			end
			4'd15: begin
				pair_bus_dat_r <= pair_peak_30_w;
			end
			5'd16: begin
				pair_bus_dat_r <= pair_peak_43_w;
			end
			5'd17: begin
				pair_bus_dat_r <= pair_peak_42_w;
			end
			5'd18: begin
				pair_bus_dat_r <= pair_peak_41_w;
			end
			5'd19: begin
				pair_bus_dat_r <= pair_peak_40_w;
			end
			5'd20: begin
				pair_bus_dat_r <= pair_peak_53_w;
			end
			5'd21: begin
				pair_bus_dat_r <= pair_peak_52_w;
			end
			5'd22: begin
				pair_bus_dat_r <= pair_peak_51_w;
			end
			5'd23: begin
				pair_bus_dat_r <= pair_peak_50_w;
			end
			5'd24: begin
				pair_bus_dat_r <= pair_peak_63_w;
			end
			5'd25: begin
				pair_bus_dat_r <= pair_peak_62_w;
			end
			5'd26: begin
				pair_bus_dat_r <= pair_peak_61_w;
			end
			5'd27: begin
				pair_bus_dat_r <= pair_peak_60_w;
			end
			5'd28: begin
				pair_bus_dat_r <= pair_peak_73_w;
			end
			5'd29: begin
				pair_bus_dat_r <= pair_peak_72_w;
			end
			5'd30: begin
				pair_bus_dat_r <= pair_peak_71_w;
			end
			5'd31: begin
				pair_bus_dat_r <= pair_peak_70_w;
			end
			6'd32: begin
				pair_bus_dat_r <= pair_peak_83_w;
			end
			6'd33: begin
				pair_bus_dat_r <= pair_peak_82_w;
			end
			6'd34: begin
				pair_bus_dat_r <= pair_peak_81_w;
			end
			6'd35: begin
				pair_bus_dat_r <= pair_peak_80_w;
			end
			6'd36: begin
				pair_bus_dat_r <= pair_peak_93_w;
			end
			6'd37: begin
				pair_bus_dat_r <= pair_peak_92_w;
			end
			6'd38: begin
				pair_bus_dat_r <= pair_peak_91_w;
			end
			6'd39: begin
				pair_bus_dat_r <= pair_peak_90_w;
			end
			6'd40: begin
				pair_bus_dat_r <= pair_peak_103_w;
			end
			6'd41: begin
				pair_bus_dat_r <= pair_peak_102_w;
			end
			6'd42: begin
				pair_bus_dat_r <= pair_peak_101_w;
			end
			6'd43: begin
				pair_bus_dat_r <= pair_peak_100_w;
			end
			6'd44: begin
				pair_bus_dat_r <= pair_peak_113_w;
			end
			6'd45: begin
				pair_bus_dat_r <= pair_peak_112_w;
			end
			6'd46: begin
				pair_bus_dat_r <= pair_peak_111_w;
			end
			6'd47: begin
				pair_bus_dat_r <= pair_peak_110_w;
			end
			6'd48: begin
				pair_bus_dat_r <= pair_peak_123_w;
			end
			6'd49: begin
				pair_bus_dat_r <= pair_peak_122_w;
			end
			6'd50: begin
				pair_bus_dat_r <= pair_peak_121_w;
			end
			6'd51: begin
				pair_bus_dat_r <= pair_peak_120_w;
			end
			6'd52: begin
				pair_bus_dat_r <= pair_peak_133_w;
			end
			6'd53: begin
				pair_bus_dat_r <= pair_peak_132_w;
			end
			6'd54: begin
				pair_bus_dat_r <= pair_peak_131_w;
			end
			6'd55: begin
				pair_bus_dat_r <= pair_peak_130_w;
			end
			6'd56: begin
				pair_bus_dat_r <= pair_peak_143_w;
			end
			6'd57: begin
				pair_bus_dat_r <= pair_peak_142_w;
			end
			6'd58: begin
				pair_bus_dat_r <= pair_peak_141_w;
			end
			6'd59: begin
				pair_bus_dat_r <= pair_peak_140_w;
			end
			6'd60: begin
				pair_bus_dat_r <= pair_peak_153_w;
			end
			6'd61: begin
				pair_bus_dat_r <= pair_peak_152_w;
			end
			6'd62: begin
				pair_bus_dat_r <= pair_peak_151_w;
			end
			6'd63: begin
				pair_bus_dat_r <= pair_peak_150_w;
			end
			7'd64: begin
				pair_bus_dat_r <= pair_peak_163_w;
			end
			7'd65: begin
				pair_bus_dat_r <= pair_peak_162_w;
			end
			7'd66: begin
				pair_bus_dat_r <= pair_peak_161_w;
			end
			7'd67: begin
				pair_bus_dat_r <= pair_peak_160_w;
			end
			7'd68: begin
				pair_bus_dat_r <= pair_peak_173_w;
			end
			7'd69: begin
				pair_bus_dat_r <= pair_peak_172_w;
			end
			7'd70: begin
				pair_bus_dat_r <= pair_peak_171_w;
			end
			7'd71: begin
				pair_bus_dat_r <= pair_peak_170_w;
			end
			7'd72: begin
				pair_bus_dat_r <= pair_peak_183_w;
			end
			7'd73: begin
				pair_bus_dat_r <= pair_peak_182_w;
			end
			7'd74: begin
				pair_bus_dat_r <= pair_peak_181_w;
			end
			7'd75: begin
				pair_bus_dat_r <= pair_peak_180_w;
			end
			7'd76: begin
				pair_bus_dat_r <= pair_peak_193_w;
			end
			7'd77: begin
				pair_bus_dat_r <= pair_peak_192_w;
			end
			7'd78: begin
				pair_bus_dat_r <= pair_peak_191_w;
			end
			7'd79: begin
				pair_bus_dat_r <= pair_peak_190_w;
			end
			7'd80: begin
				pair_bus_dat_r <= pair_peak_203_w;
			end
			7'd81: begin
				pair_bus_dat_r <= pair_peak_202_w;
			end
			7'd82: begin
				pair_bus_dat_r <= pair_peak_201_w;
			end
			7'd83: begin
				pair_bus_dat_r <= pair_peak_200_w;
			end
			7'd84: begin
				pair_bus_dat_r <= pair_peak_213_w;
			end
			7'd85: begin
				pair_bus_dat_r <= pair_peak_212_w;
			end
			7'd86: begin
				pair_bus_dat_r <= pair_peak_211_w;
			end
			7'd87: begin
				pair_bus_dat_r <= pair_peak_210_w;
			end
			7'd88: begin
				pair_bus_dat_r <= pair_peak_223_w;
			end
			7'd89: begin
				pair_bus_dat_r <= pair_peak_222_w;
			end
			7'd90: begin
				pair_bus_dat_r <= pair_peak_221_w;
			end
			7'd91: begin
				pair_bus_dat_r <= pair_peak_220_w;
			end
			7'd92: begin
				pair_bus_dat_r <= pair_peak_233_w;
			end
			7'd93: begin
				pair_bus_dat_r <= pair_peak_232_w;
			end
			7'd94: begin
				pair_bus_dat_r <= pair_peak_231_w;
			end
			7'd95: begin
				pair_bus_dat_r <= pair_peak_230_w;
			end
			7'd96: begin
				pair_bus_dat_r <= pair_peak_243_w;
			end
			7'd97: begin
				pair_bus_dat_r <= pair_peak_242_w;
			end
			7'd98: begin
				pair_bus_dat_r <= pair_peak_241_w;
			end
			7'd99: begin
				pair_bus_dat_r <= pair_peak_240_w;
			end
			7'd100: begin
				pair_bus_dat_r <= pair_peak_253_w;
			end
			7'd101: begin
				pair_bus_dat_r <= pair_peak_252_w;
			end
			7'd102: begin
				pair_bus_dat_r <= pair_peak_251_w;
			end
			7'd103: begin
				pair_bus_dat_r <= pair_peak_250_w;
			end
			7'd104: begin
				pair_bus_dat_r <= pair_peak_263_w;
			end
			7'd105: begin
				pair_bus_dat_r <= pair_peak_262_w;
			end
			7'd106: begin
				pair_bus_dat_r <= pair_peak_261_w;
			end
			7'd107: begin
				pair_bus_dat_r <= pair_peak_260_w;
			end
			7'd108: begin
				pair_bus_dat_r <= pair_peak_273_w;
			end
			7'd109: begin
				pair_bus_dat_r <= pair_peak_272_w;
			end
			7'd110: begin
				pair_bus_dat_r <= pair_peak_271_w;
			end
			7'd111: begin
				pair_bus_dat_r <= pair_peak_270_w;
			end
			7'd112: begin
				pair_bus_dat_r <= pair_peak_283_w;
			end
			7'd113: begin
				pair_bus_dat_r <= pair_peak_282_w;
			end
			7'd114: begin
				pair_bus_dat_r <= pair_peak_281_w;
			end
			7'd115: begin
				pair_bus_dat_r <= pair_peak_280_w;
			end
			7'd116: begin
				pair_bus_dat_r <= pair_peak_293_w;
			end
			7'd117: begin
				pair_bus_dat_r <= pair_peak_292_w;
			end
			7'd118: begin
				pair_bus_dat_r <= pair_peak_291_w;
			end
			7'd119: begin
				pair_bus_dat_r <= pair_peak_290_w;
			end
			7'd120: begin
				pair_bus_dat_r <= pair_peak_303_w;
			end
			7'd121: begin
				pair_bus_dat_r <= pair_peak_302_w;
			end
			7'd122: begin
				pair_bus_dat_r <= pair_peak_301_w;
			end
			7'd123: begin
				pair_bus_dat_r <= pair_peak_300_w;
			end
			7'd124: begin
				pair_bus_dat_r <= pair_peak_313_w;
			end
			7'd125: begin
				pair_bus_dat_r <= pair_peak_312_w;
			end
			7'd126: begin
				pair_bus_dat_r <= pair_peak_311_w;
			end
			7'd127: begin
				pair_bus_dat_r <= pair_peak_310_w;
			end
			8'd128: begin
				pair_bus_dat_r <= pair_wait_01_w;
			end
			8'd129: begin
				pair_bus_dat_r <= pair_wait_00_w;
			end
			8'd130: begin
				pair_bus_dat_r <= pair_wait_11_w;
			end
			8'd131: begin
				pair_bus_dat_r <= pair_wait_10_w;
			end
			8'd132: begin
				pair_bus_dat_r <= pair_wait_21_w;
			end
			8'd133: begin
				pair_bus_dat_r <= pair_wait_20_w;
			end
			8'd134: begin
				pair_bus_dat_r <= pair_wait_31_w;
			end
			8'd135: begin
				pair_bus_dat_r <= pair_wait_30_w;
			end
			8'd136: begin
				pair_bus_dat_r <= pair_wait_41_w;
			end
			8'd137: begin
				pair_bus_dat_r <= pair_wait_40_w;
			end
			8'd138: begin
				pair_bus_dat_r <= pair_wait_51_w;
			end
			8'd139: begin
				pair_bus_dat_r <= pair_wait_50_w;
			end
			8'd140: begin
				pair_bus_dat_r <= pair_wait_61_w;
			end
			8'd141: begin
				pair_bus_dat_r <= pair_wait_60_w;
			end
			8'd142: begin
				pair_bus_dat_r <= pair_wait_71_w;
			end
			8'd143: begin
				pair_bus_dat_r <= pair_wait_70_w;
			end
			8'd144: begin
				pair_bus_dat_r <= pair_wait_81_w;
			end
			8'd145: begin
				pair_bus_dat_r <= pair_wait_80_w;
			end
			8'd146: begin
				pair_bus_dat_r <= pair_wait_91_w;
			end
			8'd147: begin
				pair_bus_dat_r <= pair_wait_90_w;
			end
			8'd148: begin
				pair_bus_dat_r <= pair_wait_101_w;
			end
			8'd149: begin
				pair_bus_dat_r <= pair_wait_100_w;
			end
			8'd150: begin
				pair_bus_dat_r <= pair_wait_111_w;
			end
			8'd151: begin
				pair_bus_dat_r <= pair_wait_110_w;
			end
			8'd152: begin
				pair_bus_dat_r <= pair_wait_121_w;
			end
			8'd153: begin
				pair_bus_dat_r <= pair_wait_120_w;
			end
			8'd154: begin
				pair_bus_dat_r <= pair_wait_131_w;
			end
			8'd155: begin
				pair_bus_dat_r <= pair_wait_130_w;
			end
			8'd156: begin
				pair_bus_dat_r <= pair_wait_141_w;
			end
			8'd157: begin
				pair_bus_dat_r <= pair_wait_140_w;
			end
			8'd158: begin
				pair_bus_dat_r <= pair_wait_151_w;
			end
			8'd159: begin
				pair_bus_dat_r <= pair_wait_150_w;
			end
			8'd160: begin
				pair_bus_dat_r <= pair_wait_161_w;
			end
			8'd161: begin
				pair_bus_dat_r <= pair_wait_160_w;
			end
			8'd162: begin
				pair_bus_dat_r <= pair_wait_171_w;
			end
			8'd163: begin
				pair_bus_dat_r <= pair_wait_170_w;
			end
			8'd164: begin
				pair_bus_dat_r <= pair_wait_181_w;
			end
			8'd165: begin
				pair_bus_dat_r <= pair_wait_180_w;
			end
			8'd166: begin
				pair_bus_dat_r <= pair_wait_191_w;
			end
			8'd167: begin
				pair_bus_dat_r <= pair_wait_190_w;
			end
			8'd168: begin
				pair_bus_dat_r <= pair_wait_201_w;
			end
			8'd169: begin
				pair_bus_dat_r <= pair_wait_200_w;
			end
			8'd170: begin
				pair_bus_dat_r <= pair_wait_211_w;
			end
			8'd171: begin
				pair_bus_dat_r <= pair_wait_210_w;
			end
			8'd172: begin
				pair_bus_dat_r <= pair_wait_221_w;
			end
			8'd173: begin
				pair_bus_dat_r <= pair_wait_220_w;
			end
			8'd174: begin
				pair_bus_dat_r <= pair_wait_231_w;
			end
			8'd175: begin
				pair_bus_dat_r <= pair_wait_230_w;
			end
			8'd176: begin
				pair_bus_dat_r <= pair_wait_241_w;
			end
			8'd177: begin
				pair_bus_dat_r <= pair_wait_240_w;
			end
			8'd178: begin
				pair_bus_dat_r <= pair_wait_251_w;
			end
			8'd179: begin
				pair_bus_dat_r <= pair_wait_250_w;
			end
			8'd180: begin
				pair_bus_dat_r <= pair_wait_261_w;
			end
			8'd181: begin
				pair_bus_dat_r <= pair_wait_260_w;
			end
			8'd182: begin
				pair_bus_dat_r <= pair_wait_271_w;
			end
			8'd183: begin
				pair_bus_dat_r <= pair_wait_270_w;
			end
			8'd184: begin
				pair_bus_dat_r <= pair_wait_281_w;
			end
			8'd185: begin
				pair_bus_dat_r <= pair_wait_280_w;
			end
			8'd186: begin
				pair_bus_dat_r <= pair_wait_291_w;
			end
			8'd187: begin
				pair_bus_dat_r <= pair_wait_290_w;
			end
			8'd188: begin
				pair_bus_dat_r <= pair_wait_301_w;
			end
			8'd189: begin
				pair_bus_dat_r <= pair_wait_300_w;
			end
			8'd190: begin
				pair_bus_dat_r <= pair_wait_311_w;
			end
			8'd191: begin
				pair_bus_dat_r <= pair_wait_310_w;
			end
		endcase
	end
	if (pair_peak_03_re) begin
		pair_csrstorage0_storage_full[27:24] <= pair_peak_03_r;
	end
	if (pair_peak_02_re) begin
		pair_csrstorage0_storage_full[23:16] <= pair_peak_02_r;
	end
	if (pair_peak_01_re) begin
		pair_csrstorage0_storage_full[15:8] <= pair_peak_01_r;
	end
	if (pair_peak_00_re) begin
		pair_csrstorage0_storage_full[7:0] <= pair_peak_00_r;
	end
	pair_csrstorage0_re <= pair_peak_00_re;
	if (pair_peak_13_re) begin
		pair_csrstorage1_storage_full[27:24] <= pair_peak_13_r;
	end
	if (pair_peak_12_re) begin
		pair_csrstorage1_storage_full[23:16] <= pair_peak_12_r;
	end
	if (pair_peak_11_re) begin
		pair_csrstorage1_storage_full[15:8] <= pair_peak_11_r;
	end
	if (pair_peak_10_re) begin
		pair_csrstorage1_storage_full[7:0] <= pair_peak_10_r;
	end
	pair_csrstorage1_re <= pair_peak_10_re;
	if (pair_peak_23_re) begin
		pair_csrstorage2_storage_full[27:24] <= pair_peak_23_r;
	end
	if (pair_peak_22_re) begin
		pair_csrstorage2_storage_full[23:16] <= pair_peak_22_r;
	end
	if (pair_peak_21_re) begin
		pair_csrstorage2_storage_full[15:8] <= pair_peak_21_r;
	end
	if (pair_peak_20_re) begin
		pair_csrstorage2_storage_full[7:0] <= pair_peak_20_r;
	end
	pair_csrstorage2_re <= pair_peak_20_re;
	if (pair_peak_33_re) begin
		pair_csrstorage3_storage_full[27:24] <= pair_peak_33_r;
	end
	if (pair_peak_32_re) begin
		pair_csrstorage3_storage_full[23:16] <= pair_peak_32_r;
	end
	if (pair_peak_31_re) begin
		pair_csrstorage3_storage_full[15:8] <= pair_peak_31_r;
	end
	if (pair_peak_30_re) begin
		pair_csrstorage3_storage_full[7:0] <= pair_peak_30_r;
	end
	pair_csrstorage3_re <= pair_peak_30_re;
	if (pair_peak_43_re) begin
		pair_csrstorage4_storage_full[27:24] <= pair_peak_43_r;
	end
	if (pair_peak_42_re) begin
		pair_csrstorage4_storage_full[23:16] <= pair_peak_42_r;
	end
	if (pair_peak_41_re) begin
		pair_csrstorage4_storage_full[15:8] <= pair_peak_41_r;
	end
	if (pair_peak_40_re) begin
		pair_csrstorage4_storage_full[7:0] <= pair_peak_40_r;
	end
	pair_csrstorage4_re <= pair_peak_40_re;
	if (pair_peak_53_re) begin
		pair_csrstorage5_storage_full[27:24] <= pair_peak_53_r;
	end
	if (pair_peak_52_re) begin
		pair_csrstorage5_storage_full[23:16] <= pair_peak_52_r;
	end
	if (pair_peak_51_re) begin
		pair_csrstorage5_storage_full[15:8] <= pair_peak_51_r;
	end
	if (pair_peak_50_re) begin
		pair_csrstorage5_storage_full[7:0] <= pair_peak_50_r;
	end
	pair_csrstorage5_re <= pair_peak_50_re;
	if (pair_peak_63_re) begin
		pair_csrstorage6_storage_full[27:24] <= pair_peak_63_r;
	end
	if (pair_peak_62_re) begin
		pair_csrstorage6_storage_full[23:16] <= pair_peak_62_r;
	end
	if (pair_peak_61_re) begin
		pair_csrstorage6_storage_full[15:8] <= pair_peak_61_r;
	end
	if (pair_peak_60_re) begin
		pair_csrstorage6_storage_full[7:0] <= pair_peak_60_r;
	end
	pair_csrstorage6_re <= pair_peak_60_re;
	if (pair_peak_73_re) begin
		pair_csrstorage7_storage_full[27:24] <= pair_peak_73_r;
	end
	if (pair_peak_72_re) begin
		pair_csrstorage7_storage_full[23:16] <= pair_peak_72_r;
	end
	if (pair_peak_71_re) begin
		pair_csrstorage7_storage_full[15:8] <= pair_peak_71_r;
	end
	if (pair_peak_70_re) begin
		pair_csrstorage7_storage_full[7:0] <= pair_peak_70_r;
	end
	pair_csrstorage7_re <= pair_peak_70_re;
	if (pair_peak_83_re) begin
		pair_csrstorage8_storage_full[27:24] <= pair_peak_83_r;
	end
	if (pair_peak_82_re) begin
		pair_csrstorage8_storage_full[23:16] <= pair_peak_82_r;
	end
	if (pair_peak_81_re) begin
		pair_csrstorage8_storage_full[15:8] <= pair_peak_81_r;
	end
	if (pair_peak_80_re) begin
		pair_csrstorage8_storage_full[7:0] <= pair_peak_80_r;
	end
	pair_csrstorage8_re <= pair_peak_80_re;
	if (pair_peak_93_re) begin
		pair_csrstorage9_storage_full[27:24] <= pair_peak_93_r;
	end
	if (pair_peak_92_re) begin
		pair_csrstorage9_storage_full[23:16] <= pair_peak_92_r;
	end
	if (pair_peak_91_re) begin
		pair_csrstorage9_storage_full[15:8] <= pair_peak_91_r;
	end
	if (pair_peak_90_re) begin
		pair_csrstorage9_storage_full[7:0] <= pair_peak_90_r;
	end
	pair_csrstorage9_re <= pair_peak_90_re;
	if (pair_peak_103_re) begin
		pair_csrstorage10_storage_full[27:24] <= pair_peak_103_r;
	end
	if (pair_peak_102_re) begin
		pair_csrstorage10_storage_full[23:16] <= pair_peak_102_r;
	end
	if (pair_peak_101_re) begin
		pair_csrstorage10_storage_full[15:8] <= pair_peak_101_r;
	end
	if (pair_peak_100_re) begin
		pair_csrstorage10_storage_full[7:0] <= pair_peak_100_r;
	end
	pair_csrstorage10_re <= pair_peak_100_re;
	if (pair_peak_113_re) begin
		pair_csrstorage11_storage_full[27:24] <= pair_peak_113_r;
	end
	if (pair_peak_112_re) begin
		pair_csrstorage11_storage_full[23:16] <= pair_peak_112_r;
	end
	if (pair_peak_111_re) begin
		pair_csrstorage11_storage_full[15:8] <= pair_peak_111_r;
	end
	if (pair_peak_110_re) begin
		pair_csrstorage11_storage_full[7:0] <= pair_peak_110_r;
	end
	pair_csrstorage11_re <= pair_peak_110_re;
	if (pair_peak_123_re) begin
		pair_csrstorage12_storage_full[27:24] <= pair_peak_123_r;
	end
	if (pair_peak_122_re) begin
		pair_csrstorage12_storage_full[23:16] <= pair_peak_122_r;
	end
	if (pair_peak_121_re) begin
		pair_csrstorage12_storage_full[15:8] <= pair_peak_121_r;
	end
	if (pair_peak_120_re) begin
		pair_csrstorage12_storage_full[7:0] <= pair_peak_120_r;
	end
	pair_csrstorage12_re <= pair_peak_120_re;
	if (pair_peak_133_re) begin
		pair_csrstorage13_storage_full[27:24] <= pair_peak_133_r;
	end
	if (pair_peak_132_re) begin
		pair_csrstorage13_storage_full[23:16] <= pair_peak_132_r;
	end
	if (pair_peak_131_re) begin
		pair_csrstorage13_storage_full[15:8] <= pair_peak_131_r;
	end
	if (pair_peak_130_re) begin
		pair_csrstorage13_storage_full[7:0] <= pair_peak_130_r;
	end
	pair_csrstorage13_re <= pair_peak_130_re;
	if (pair_peak_143_re) begin
		pair_csrstorage14_storage_full[27:24] <= pair_peak_143_r;
	end
	if (pair_peak_142_re) begin
		pair_csrstorage14_storage_full[23:16] <= pair_peak_142_r;
	end
	if (pair_peak_141_re) begin
		pair_csrstorage14_storage_full[15:8] <= pair_peak_141_r;
	end
	if (pair_peak_140_re) begin
		pair_csrstorage14_storage_full[7:0] <= pair_peak_140_r;
	end
	pair_csrstorage14_re <= pair_peak_140_re;
	if (pair_peak_153_re) begin
		pair_csrstorage15_storage_full[27:24] <= pair_peak_153_r;
	end
	if (pair_peak_152_re) begin
		pair_csrstorage15_storage_full[23:16] <= pair_peak_152_r;
	end
	if (pair_peak_151_re) begin
		pair_csrstorage15_storage_full[15:8] <= pair_peak_151_r;
	end
	if (pair_peak_150_re) begin
		pair_csrstorage15_storage_full[7:0] <= pair_peak_150_r;
	end
	pair_csrstorage15_re <= pair_peak_150_re;
	if (pair_peak_163_re) begin
		pair_csrstorage16_storage_full[27:24] <= pair_peak_163_r;
	end
	if (pair_peak_162_re) begin
		pair_csrstorage16_storage_full[23:16] <= pair_peak_162_r;
	end
	if (pair_peak_161_re) begin
		pair_csrstorage16_storage_full[15:8] <= pair_peak_161_r;
	end
	if (pair_peak_160_re) begin
		pair_csrstorage16_storage_full[7:0] <= pair_peak_160_r;
	end
	pair_csrstorage16_re <= pair_peak_160_re;
	if (pair_peak_173_re) begin
		pair_csrstorage17_storage_full[27:24] <= pair_peak_173_r;
	end
	if (pair_peak_172_re) begin
		pair_csrstorage17_storage_full[23:16] <= pair_peak_172_r;
	end
	if (pair_peak_171_re) begin
		pair_csrstorage17_storage_full[15:8] <= pair_peak_171_r;
	end
	if (pair_peak_170_re) begin
		pair_csrstorage17_storage_full[7:0] <= pair_peak_170_r;
	end
	pair_csrstorage17_re <= pair_peak_170_re;
	if (pair_peak_183_re) begin
		pair_csrstorage18_storage_full[27:24] <= pair_peak_183_r;
	end
	if (pair_peak_182_re) begin
		pair_csrstorage18_storage_full[23:16] <= pair_peak_182_r;
	end
	if (pair_peak_181_re) begin
		pair_csrstorage18_storage_full[15:8] <= pair_peak_181_r;
	end
	if (pair_peak_180_re) begin
		pair_csrstorage18_storage_full[7:0] <= pair_peak_180_r;
	end
	pair_csrstorage18_re <= pair_peak_180_re;
	if (pair_peak_193_re) begin
		pair_csrstorage19_storage_full[27:24] <= pair_peak_193_r;
	end
	if (pair_peak_192_re) begin
		pair_csrstorage19_storage_full[23:16] <= pair_peak_192_r;
	end
	if (pair_peak_191_re) begin
		pair_csrstorage19_storage_full[15:8] <= pair_peak_191_r;
	end
	if (pair_peak_190_re) begin
		pair_csrstorage19_storage_full[7:0] <= pair_peak_190_r;
	end
	pair_csrstorage19_re <= pair_peak_190_re;
	if (pair_peak_203_re) begin
		pair_csrstorage20_storage_full[27:24] <= pair_peak_203_r;
	end
	if (pair_peak_202_re) begin
		pair_csrstorage20_storage_full[23:16] <= pair_peak_202_r;
	end
	if (pair_peak_201_re) begin
		pair_csrstorage20_storage_full[15:8] <= pair_peak_201_r;
	end
	if (pair_peak_200_re) begin
		pair_csrstorage20_storage_full[7:0] <= pair_peak_200_r;
	end
	pair_csrstorage20_re <= pair_peak_200_re;
	if (pair_peak_213_re) begin
		pair_csrstorage21_storage_full[27:24] <= pair_peak_213_r;
	end
	if (pair_peak_212_re) begin
		pair_csrstorage21_storage_full[23:16] <= pair_peak_212_r;
	end
	if (pair_peak_211_re) begin
		pair_csrstorage21_storage_full[15:8] <= pair_peak_211_r;
	end
	if (pair_peak_210_re) begin
		pair_csrstorage21_storage_full[7:0] <= pair_peak_210_r;
	end
	pair_csrstorage21_re <= pair_peak_210_re;
	if (pair_peak_223_re) begin
		pair_csrstorage22_storage_full[27:24] <= pair_peak_223_r;
	end
	if (pair_peak_222_re) begin
		pair_csrstorage22_storage_full[23:16] <= pair_peak_222_r;
	end
	if (pair_peak_221_re) begin
		pair_csrstorage22_storage_full[15:8] <= pair_peak_221_r;
	end
	if (pair_peak_220_re) begin
		pair_csrstorage22_storage_full[7:0] <= pair_peak_220_r;
	end
	pair_csrstorage22_re <= pair_peak_220_re;
	if (pair_peak_233_re) begin
		pair_csrstorage23_storage_full[27:24] <= pair_peak_233_r;
	end
	if (pair_peak_232_re) begin
		pair_csrstorage23_storage_full[23:16] <= pair_peak_232_r;
	end
	if (pair_peak_231_re) begin
		pair_csrstorage23_storage_full[15:8] <= pair_peak_231_r;
	end
	if (pair_peak_230_re) begin
		pair_csrstorage23_storage_full[7:0] <= pair_peak_230_r;
	end
	pair_csrstorage23_re <= pair_peak_230_re;
	if (pair_peak_243_re) begin
		pair_csrstorage24_storage_full[27:24] <= pair_peak_243_r;
	end
	if (pair_peak_242_re) begin
		pair_csrstorage24_storage_full[23:16] <= pair_peak_242_r;
	end
	if (pair_peak_241_re) begin
		pair_csrstorage24_storage_full[15:8] <= pair_peak_241_r;
	end
	if (pair_peak_240_re) begin
		pair_csrstorage24_storage_full[7:0] <= pair_peak_240_r;
	end
	pair_csrstorage24_re <= pair_peak_240_re;
	if (pair_peak_253_re) begin
		pair_csrstorage25_storage_full[27:24] <= pair_peak_253_r;
	end
	if (pair_peak_252_re) begin
		pair_csrstorage25_storage_full[23:16] <= pair_peak_252_r;
	end
	if (pair_peak_251_re) begin
		pair_csrstorage25_storage_full[15:8] <= pair_peak_251_r;
	end
	if (pair_peak_250_re) begin
		pair_csrstorage25_storage_full[7:0] <= pair_peak_250_r;
	end
	pair_csrstorage25_re <= pair_peak_250_re;
	if (pair_peak_263_re) begin
		pair_csrstorage26_storage_full[27:24] <= pair_peak_263_r;
	end
	if (pair_peak_262_re) begin
		pair_csrstorage26_storage_full[23:16] <= pair_peak_262_r;
	end
	if (pair_peak_261_re) begin
		pair_csrstorage26_storage_full[15:8] <= pair_peak_261_r;
	end
	if (pair_peak_260_re) begin
		pair_csrstorage26_storage_full[7:0] <= pair_peak_260_r;
	end
	pair_csrstorage26_re <= pair_peak_260_re;
	if (pair_peak_273_re) begin
		pair_csrstorage27_storage_full[27:24] <= pair_peak_273_r;
	end
	if (pair_peak_272_re) begin
		pair_csrstorage27_storage_full[23:16] <= pair_peak_272_r;
	end
	if (pair_peak_271_re) begin
		pair_csrstorage27_storage_full[15:8] <= pair_peak_271_r;
	end
	if (pair_peak_270_re) begin
		pair_csrstorage27_storage_full[7:0] <= pair_peak_270_r;
	end
	pair_csrstorage27_re <= pair_peak_270_re;
	if (pair_peak_283_re) begin
		pair_csrstorage28_storage_full[27:24] <= pair_peak_283_r;
	end
	if (pair_peak_282_re) begin
		pair_csrstorage28_storage_full[23:16] <= pair_peak_282_r;
	end
	if (pair_peak_281_re) begin
		pair_csrstorage28_storage_full[15:8] <= pair_peak_281_r;
	end
	if (pair_peak_280_re) begin
		pair_csrstorage28_storage_full[7:0] <= pair_peak_280_r;
	end
	pair_csrstorage28_re <= pair_peak_280_re;
	if (pair_peak_293_re) begin
		pair_csrstorage29_storage_full[27:24] <= pair_peak_293_r;
	end
	if (pair_peak_292_re) begin
		pair_csrstorage29_storage_full[23:16] <= pair_peak_292_r;
	end
	if (pair_peak_291_re) begin
		pair_csrstorage29_storage_full[15:8] <= pair_peak_291_r;
	end
	if (pair_peak_290_re) begin
		pair_csrstorage29_storage_full[7:0] <= pair_peak_290_r;
	end
	pair_csrstorage29_re <= pair_peak_290_re;
	if (pair_peak_303_re) begin
		pair_csrstorage30_storage_full[27:24] <= pair_peak_303_r;
	end
	if (pair_peak_302_re) begin
		pair_csrstorage30_storage_full[23:16] <= pair_peak_302_r;
	end
	if (pair_peak_301_re) begin
		pair_csrstorage30_storage_full[15:8] <= pair_peak_301_r;
	end
	if (pair_peak_300_re) begin
		pair_csrstorage30_storage_full[7:0] <= pair_peak_300_r;
	end
	pair_csrstorage30_re <= pair_peak_300_re;
	if (pair_peak_313_re) begin
		pair_csrstorage31_storage_full[27:24] <= pair_peak_313_r;
	end
	if (pair_peak_312_re) begin
		pair_csrstorage31_storage_full[23:16] <= pair_peak_312_r;
	end
	if (pair_peak_311_re) begin
		pair_csrstorage31_storage_full[15:8] <= pair_peak_311_r;
	end
	if (pair_peak_310_re) begin
		pair_csrstorage31_storage_full[7:0] <= pair_peak_310_r;
	end
	pair_csrstorage31_re <= pair_peak_310_re;
	if (pair_wait_01_re) begin
		pair_csrstorage32_storage_full[13:8] <= pair_wait_01_r;
	end
	if (pair_wait_00_re) begin
		pair_csrstorage32_storage_full[7:0] <= pair_wait_00_r;
	end
	pair_csrstorage32_re <= pair_wait_00_re;
	if (pair_wait_11_re) begin
		pair_csrstorage33_storage_full[13:8] <= pair_wait_11_r;
	end
	if (pair_wait_10_re) begin
		pair_csrstorage33_storage_full[7:0] <= pair_wait_10_r;
	end
	pair_csrstorage33_re <= pair_wait_10_re;
	if (pair_wait_21_re) begin
		pair_csrstorage34_storage_full[13:8] <= pair_wait_21_r;
	end
	if (pair_wait_20_re) begin
		pair_csrstorage34_storage_full[7:0] <= pair_wait_20_r;
	end
	pair_csrstorage34_re <= pair_wait_20_re;
	if (pair_wait_31_re) begin
		pair_csrstorage35_storage_full[13:8] <= pair_wait_31_r;
	end
	if (pair_wait_30_re) begin
		pair_csrstorage35_storage_full[7:0] <= pair_wait_30_r;
	end
	pair_csrstorage35_re <= pair_wait_30_re;
	if (pair_wait_41_re) begin
		pair_csrstorage36_storage_full[13:8] <= pair_wait_41_r;
	end
	if (pair_wait_40_re) begin
		pair_csrstorage36_storage_full[7:0] <= pair_wait_40_r;
	end
	pair_csrstorage36_re <= pair_wait_40_re;
	if (pair_wait_51_re) begin
		pair_csrstorage37_storage_full[13:8] <= pair_wait_51_r;
	end
	if (pair_wait_50_re) begin
		pair_csrstorage37_storage_full[7:0] <= pair_wait_50_r;
	end
	pair_csrstorage37_re <= pair_wait_50_re;
	if (pair_wait_61_re) begin
		pair_csrstorage38_storage_full[13:8] <= pair_wait_61_r;
	end
	if (pair_wait_60_re) begin
		pair_csrstorage38_storage_full[7:0] <= pair_wait_60_r;
	end
	pair_csrstorage38_re <= pair_wait_60_re;
	if (pair_wait_71_re) begin
		pair_csrstorage39_storage_full[13:8] <= pair_wait_71_r;
	end
	if (pair_wait_70_re) begin
		pair_csrstorage39_storage_full[7:0] <= pair_wait_70_r;
	end
	pair_csrstorage39_re <= pair_wait_70_re;
	if (pair_wait_81_re) begin
		pair_csrstorage40_storage_full[13:8] <= pair_wait_81_r;
	end
	if (pair_wait_80_re) begin
		pair_csrstorage40_storage_full[7:0] <= pair_wait_80_r;
	end
	pair_csrstorage40_re <= pair_wait_80_re;
	if (pair_wait_91_re) begin
		pair_csrstorage41_storage_full[13:8] <= pair_wait_91_r;
	end
	if (pair_wait_90_re) begin
		pair_csrstorage41_storage_full[7:0] <= pair_wait_90_r;
	end
	pair_csrstorage41_re <= pair_wait_90_re;
	if (pair_wait_101_re) begin
		pair_csrstorage42_storage_full[13:8] <= pair_wait_101_r;
	end
	if (pair_wait_100_re) begin
		pair_csrstorage42_storage_full[7:0] <= pair_wait_100_r;
	end
	pair_csrstorage42_re <= pair_wait_100_re;
	if (pair_wait_111_re) begin
		pair_csrstorage43_storage_full[13:8] <= pair_wait_111_r;
	end
	if (pair_wait_110_re) begin
		pair_csrstorage43_storage_full[7:0] <= pair_wait_110_r;
	end
	pair_csrstorage43_re <= pair_wait_110_re;
	if (pair_wait_121_re) begin
		pair_csrstorage44_storage_full[13:8] <= pair_wait_121_r;
	end
	if (pair_wait_120_re) begin
		pair_csrstorage44_storage_full[7:0] <= pair_wait_120_r;
	end
	pair_csrstorage44_re <= pair_wait_120_re;
	if (pair_wait_131_re) begin
		pair_csrstorage45_storage_full[13:8] <= pair_wait_131_r;
	end
	if (pair_wait_130_re) begin
		pair_csrstorage45_storage_full[7:0] <= pair_wait_130_r;
	end
	pair_csrstorage45_re <= pair_wait_130_re;
	if (pair_wait_141_re) begin
		pair_csrstorage46_storage_full[13:8] <= pair_wait_141_r;
	end
	if (pair_wait_140_re) begin
		pair_csrstorage46_storage_full[7:0] <= pair_wait_140_r;
	end
	pair_csrstorage46_re <= pair_wait_140_re;
	if (pair_wait_151_re) begin
		pair_csrstorage47_storage_full[13:8] <= pair_wait_151_r;
	end
	if (pair_wait_150_re) begin
		pair_csrstorage47_storage_full[7:0] <= pair_wait_150_r;
	end
	pair_csrstorage47_re <= pair_wait_150_re;
	if (pair_wait_161_re) begin
		pair_csrstorage48_storage_full[13:8] <= pair_wait_161_r;
	end
	if (pair_wait_160_re) begin
		pair_csrstorage48_storage_full[7:0] <= pair_wait_160_r;
	end
	pair_csrstorage48_re <= pair_wait_160_re;
	if (pair_wait_171_re) begin
		pair_csrstorage49_storage_full[13:8] <= pair_wait_171_r;
	end
	if (pair_wait_170_re) begin
		pair_csrstorage49_storage_full[7:0] <= pair_wait_170_r;
	end
	pair_csrstorage49_re <= pair_wait_170_re;
	if (pair_wait_181_re) begin
		pair_csrstorage50_storage_full[13:8] <= pair_wait_181_r;
	end
	if (pair_wait_180_re) begin
		pair_csrstorage50_storage_full[7:0] <= pair_wait_180_r;
	end
	pair_csrstorage50_re <= pair_wait_180_re;
	if (pair_wait_191_re) begin
		pair_csrstorage51_storage_full[13:8] <= pair_wait_191_r;
	end
	if (pair_wait_190_re) begin
		pair_csrstorage51_storage_full[7:0] <= pair_wait_190_r;
	end
	pair_csrstorage51_re <= pair_wait_190_re;
	if (pair_wait_201_re) begin
		pair_csrstorage52_storage_full[13:8] <= pair_wait_201_r;
	end
	if (pair_wait_200_re) begin
		pair_csrstorage52_storage_full[7:0] <= pair_wait_200_r;
	end
	pair_csrstorage52_re <= pair_wait_200_re;
	if (pair_wait_211_re) begin
		pair_csrstorage53_storage_full[13:8] <= pair_wait_211_r;
	end
	if (pair_wait_210_re) begin
		pair_csrstorage53_storage_full[7:0] <= pair_wait_210_r;
	end
	pair_csrstorage53_re <= pair_wait_210_re;
	if (pair_wait_221_re) begin
		pair_csrstorage54_storage_full[13:8] <= pair_wait_221_r;
	end
	if (pair_wait_220_re) begin
		pair_csrstorage54_storage_full[7:0] <= pair_wait_220_r;
	end
	pair_csrstorage54_re <= pair_wait_220_re;
	if (pair_wait_231_re) begin
		pair_csrstorage55_storage_full[13:8] <= pair_wait_231_r;
	end
	if (pair_wait_230_re) begin
		pair_csrstorage55_storage_full[7:0] <= pair_wait_230_r;
	end
	pair_csrstorage55_re <= pair_wait_230_re;
	if (pair_wait_241_re) begin
		pair_csrstorage56_storage_full[13:8] <= pair_wait_241_r;
	end
	if (pair_wait_240_re) begin
		pair_csrstorage56_storage_full[7:0] <= pair_wait_240_r;
	end
	pair_csrstorage56_re <= pair_wait_240_re;
	if (pair_wait_251_re) begin
		pair_csrstorage57_storage_full[13:8] <= pair_wait_251_r;
	end
	if (pair_wait_250_re) begin
		pair_csrstorage57_storage_full[7:0] <= pair_wait_250_r;
	end
	pair_csrstorage57_re <= pair_wait_250_re;
	if (pair_wait_261_re) begin
		pair_csrstorage58_storage_full[13:8] <= pair_wait_261_r;
	end
	if (pair_wait_260_re) begin
		pair_csrstorage58_storage_full[7:0] <= pair_wait_260_r;
	end
	pair_csrstorage58_re <= pair_wait_260_re;
	if (pair_wait_271_re) begin
		pair_csrstorage59_storage_full[13:8] <= pair_wait_271_r;
	end
	if (pair_wait_270_re) begin
		pair_csrstorage59_storage_full[7:0] <= pair_wait_270_r;
	end
	pair_csrstorage59_re <= pair_wait_270_re;
	if (pair_wait_281_re) begin
		pair_csrstorage60_storage_full[13:8] <= pair_wait_281_r;
	end
	if (pair_wait_280_re) begin
		pair_csrstorage60_storage_full[7:0] <= pair_wait_280_r;
	end
	pair_csrstorage60_re <= pair_wait_280_re;
	if (pair_wait_291_re) begin
		pair_csrstorage61_storage_full[13:8] <= pair_wait_291_r;
	end
	if (pair_wait_290_re) begin
		pair_csrstorage61_storage_full[7:0] <= pair_wait_290_r;
	end
	pair_csrstorage61_re <= pair_wait_290_re;
	if (pair_wait_301_re) begin
		pair_csrstorage62_storage_full[13:8] <= pair_wait_301_r;
	end
	if (pair_wait_300_re) begin
		pair_csrstorage62_storage_full[7:0] <= pair_wait_300_r;
	end
	pair_csrstorage62_re <= pair_wait_300_re;
	if (pair_wait_311_re) begin
		pair_csrstorage63_storage_full[13:8] <= pair_wait_311_r;
	end
	if (pair_wait_310_re) begin
		pair_csrstorage63_storage_full[7:0] <= pair_wait_310_r;
	end
	pair_csrstorage63_re <= pair_wait_310_re;
	if (sys_rst) begin
		pair_csrstorage0_storage_full <= 28'd0;
		pair_csrstorage0_re <= 1'd0;
		pair_csrstorage1_storage_full <= 28'd0;
		pair_csrstorage1_re <= 1'd0;
		pair_csrstorage2_storage_full <= 28'd0;
		pair_csrstorage2_re <= 1'd0;
		pair_csrstorage3_storage_full <= 28'd0;
		pair_csrstorage3_re <= 1'd0;
		pair_csrstorage4_storage_full <= 28'd0;
		pair_csrstorage4_re <= 1'd0;
		pair_csrstorage5_storage_full <= 28'd0;
		pair_csrstorage5_re <= 1'd0;
		pair_csrstorage6_storage_full <= 28'd0;
		pair_csrstorage6_re <= 1'd0;
		pair_csrstorage7_storage_full <= 28'd0;
		pair_csrstorage7_re <= 1'd0;
		pair_csrstorage8_storage_full <= 28'd0;
		pair_csrstorage8_re <= 1'd0;
		pair_csrstorage9_storage_full <= 28'd0;
		pair_csrstorage9_re <= 1'd0;
		pair_csrstorage10_storage_full <= 28'd0;
		pair_csrstorage10_re <= 1'd0;
		pair_csrstorage11_storage_full <= 28'd0;
		pair_csrstorage11_re <= 1'd0;
		pair_csrstorage12_storage_full <= 28'd0;
		pair_csrstorage12_re <= 1'd0;
		pair_csrstorage13_storage_full <= 28'd0;
		pair_csrstorage13_re <= 1'd0;
		pair_csrstorage14_storage_full <= 28'd0;
		pair_csrstorage14_re <= 1'd0;
		pair_csrstorage15_storage_full <= 28'd0;
		pair_csrstorage15_re <= 1'd0;
		pair_csrstorage16_storage_full <= 28'd0;
		pair_csrstorage16_re <= 1'd0;
		pair_csrstorage17_storage_full <= 28'd0;
		pair_csrstorage17_re <= 1'd0;
		pair_csrstorage18_storage_full <= 28'd0;
		pair_csrstorage18_re <= 1'd0;
		pair_csrstorage19_storage_full <= 28'd0;
		pair_csrstorage19_re <= 1'd0;
		pair_csrstorage20_storage_full <= 28'd0;
		pair_csrstorage20_re <= 1'd0;
		pair_csrstorage21_storage_full <= 28'd0;
		pair_csrstorage21_re <= 1'd0;
		pair_csrstorage22_storage_full <= 28'd0;
		pair_csrstorage22_re <= 1'd0;
		pair_csrstorage23_storage_full <= 28'd0;
		pair_csrstorage23_re <= 1'd0;
		pair_csrstorage24_storage_full <= 28'd0;
		pair_csrstorage24_re <= 1'd0;
		pair_csrstorage25_storage_full <= 28'd0;
		pair_csrstorage25_re <= 1'd0;
		pair_csrstorage26_storage_full <= 28'd0;
		pair_csrstorage26_re <= 1'd0;
		pair_csrstorage27_storage_full <= 28'd0;
		pair_csrstorage27_re <= 1'd0;
		pair_csrstorage28_storage_full <= 28'd0;
		pair_csrstorage28_re <= 1'd0;
		pair_csrstorage29_storage_full <= 28'd0;
		pair_csrstorage29_re <= 1'd0;
		pair_csrstorage30_storage_full <= 28'd0;
		pair_csrstorage30_re <= 1'd0;
		pair_csrstorage31_storage_full <= 28'd0;
		pair_csrstorage31_re <= 1'd0;
		pair_csrstorage32_storage_full <= 14'd0;
		pair_csrstorage32_re <= 1'd0;
		pair_csrstorage33_storage_full <= 14'd0;
		pair_csrstorage33_re <= 1'd0;
		pair_csrstorage34_storage_full <= 14'd0;
		pair_csrstorage34_re <= 1'd0;
		pair_csrstorage35_storage_full <= 14'd0;
		pair_csrstorage35_re <= 1'd0;
		pair_csrstorage36_storage_full <= 14'd0;
		pair_csrstorage36_re <= 1'd0;
		pair_csrstorage37_storage_full <= 14'd0;
		pair_csrstorage37_re <= 1'd0;
		pair_csrstorage38_storage_full <= 14'd0;
		pair_csrstorage38_re <= 1'd0;
		pair_csrstorage39_storage_full <= 14'd0;
		pair_csrstorage39_re <= 1'd0;
		pair_csrstorage40_storage_full <= 14'd0;
		pair_csrstorage40_re <= 1'd0;
		pair_csrstorage41_storage_full <= 14'd0;
		pair_csrstorage41_re <= 1'd0;
		pair_csrstorage42_storage_full <= 14'd0;
		pair_csrstorage42_re <= 1'd0;
		pair_csrstorage43_storage_full <= 14'd0;
		pair_csrstorage43_re <= 1'd0;
		pair_csrstorage44_storage_full <= 14'd0;
		pair_csrstorage44_re <= 1'd0;
		pair_csrstorage45_storage_full <= 14'd0;
		pair_csrstorage45_re <= 1'd0;
		pair_csrstorage46_storage_full <= 14'd0;
		pair_csrstorage46_re <= 1'd0;
		pair_csrstorage47_storage_full <= 14'd0;
		pair_csrstorage47_re <= 1'd0;
		pair_csrstorage48_storage_full <= 14'd0;
		pair_csrstorage48_re <= 1'd0;
		pair_csrstorage49_storage_full <= 14'd0;
		pair_csrstorage49_re <= 1'd0;
		pair_csrstorage50_storage_full <= 14'd0;
		pair_csrstorage50_re <= 1'd0;
		pair_csrstorage51_storage_full <= 14'd0;
		pair_csrstorage51_re <= 1'd0;
		pair_csrstorage52_storage_full <= 14'd0;
		pair_csrstorage52_re <= 1'd0;
		pair_csrstorage53_storage_full <= 14'd0;
		pair_csrstorage53_re <= 1'd0;
		pair_csrstorage54_storage_full <= 14'd0;
		pair_csrstorage54_re <= 1'd0;
		pair_csrstorage55_storage_full <= 14'd0;
		pair_csrstorage55_re <= 1'd0;
		pair_csrstorage56_storage_full <= 14'd0;
		pair_csrstorage56_re <= 1'd0;
		pair_csrstorage57_storage_full <= 14'd0;
		pair_csrstorage57_re <= 1'd0;
		pair_csrstorage58_storage_full <= 14'd0;
		pair_csrstorage58_re <= 1'd0;
		pair_csrstorage59_storage_full <= 14'd0;
		pair_csrstorage59_re <= 1'd0;
		pair_csrstorage60_storage_full <= 14'd0;
		pair_csrstorage60_re <= 1'd0;
		pair_csrstorage61_storage_full <= 14'd0;
		pair_csrstorage61_re <= 1'd0;
		pair_csrstorage62_storage_full <= 14'd0;
		pair_csrstorage62_re <= 1'd0;
		pair_csrstorage63_storage_full <= 14'd0;
		pair_csrstorage63_re <= 1'd0;
		pair_bus_dat_r <= 8'd0;
		pair_index <= 5'd0;
		pair_mag0 <= 28'sd0;
		pair_neg0 <= 29'sd0;
		pair_pos0 <= 1'd0;
		pair_w0 <= 14'd0;
		pair_mag1 <= 28'sd0;
		pair_neg1 <= 29'sd0;
		pair_pos1 <= 1'd0;
		pair_w1 <= 14'd0;
		pair_mag2 <= 28'sd0;
		pair_neg2 <= 29'sd0;
		pair_pos2 <= 1'd0;
		pair_w2 <= 14'd0;
		pair_mag3 <= 28'sd0;
		pair_neg3 <= 29'sd0;
		pair_pos3 <= 1'd0;
		pair_w3 <= 14'd0;
		pair_mag4 <= 28'sd0;
		pair_neg4 <= 29'sd0;
		pair_pos4 <= 1'd0;
		pair_w4 <= 14'd0;
		pair_mag5 <= 28'sd0;
		pair_neg5 <= 29'sd0;
		pair_pos5 <= 1'd0;
		pair_w5 <= 14'd0;
		pair_mag6 <= 28'sd0;
		pair_neg6 <= 29'sd0;
		pair_pos6 <= 1'd0;
		pair_w6 <= 14'd0;
		pair_mag7 <= 28'sd0;
		pair_neg7 <= 29'sd0;
		pair_pos7 <= 1'd0;
		pair_w7 <= 14'd0;
		pair_mag8 <= 28'sd0;
		pair_neg8 <= 29'sd0;
		pair_pos8 <= 1'd0;
		pair_w8 <= 14'd0;
		pair_mag9 <= 28'sd0;
		pair_neg9 <= 29'sd0;
		pair_pos9 <= 1'd0;
		pair_w9 <= 14'd0;
		pair_mag10 <= 28'sd0;
		pair_neg10 <= 29'sd0;
		pair_pos10 <= 1'd0;
		pair_w10 <= 14'd0;
		pair_mag11 <= 28'sd0;
		pair_neg11 <= 29'sd0;
		pair_pos11 <= 1'd0;
		pair_w11 <= 14'd0;
		pair_mag12 <= 28'sd0;
		pair_neg12 <= 29'sd0;
		pair_pos12 <= 1'd0;
		pair_w12 <= 14'd0;
		pair_mag13 <= 28'sd0;
		pair_neg13 <= 29'sd0;
		pair_pos13 <= 1'd0;
		pair_w13 <= 14'd0;
		pair_mag14 <= 28'sd0;
		pair_neg14 <= 29'sd0;
		pair_pos14 <= 1'd0;
		pair_w14 <= 14'd0;
		pair_mag15 <= 28'sd0;
		pair_neg15 <= 29'sd0;
		pair_pos15 <= 1'd0;
		pair_w15 <= 14'd0;
		pair_mag16 <= 28'sd0;
		pair_neg16 <= 29'sd0;
		pair_pos16 <= 1'd0;
		pair_w16 <= 14'd0;
		pair_mag17 <= 28'sd0;
		pair_neg17 <= 29'sd0;
		pair_pos17 <= 1'd0;
		pair_w17 <= 14'd0;
		pair_mag18 <= 28'sd0;
		pair_neg18 <= 29'sd0;
		pair_pos18 <= 1'd0;
		pair_w18 <= 14'd0;
		pair_mag19 <= 28'sd0;
		pair_neg19 <= 29'sd0;
		pair_pos19 <= 1'd0;
		pair_w19 <= 14'd0;
		pair_mag20 <= 28'sd0;
		pair_neg20 <= 29'sd0;
		pair_pos20 <= 1'd0;
		pair_w20 <= 14'd0;
		pair_mag21 <= 28'sd0;
		pair_neg21 <= 29'sd0;
		pair_pos21 <= 1'd0;
		pair_w21 <= 14'd0;
		pair_mag22 <= 28'sd0;
		pair_neg22 <= 29'sd0;
		pair_pos22 <= 1'd0;
		pair_w22 <= 14'd0;
		pair_mag23 <= 28'sd0;
		pair_neg23 <= 29'sd0;
		pair_pos23 <= 1'd0;
		pair_w23 <= 14'd0;
		pair_mag24 <= 28'sd0;
		pair_neg24 <= 29'sd0;
		pair_pos24 <= 1'd0;
		pair_w24 <= 14'd0;
		pair_mag25 <= 28'sd0;
		pair_neg25 <= 29'sd0;
		pair_pos25 <= 1'd0;
		pair_w25 <= 14'd0;
		pair_mag26 <= 28'sd0;
		pair_neg26 <= 29'sd0;
		pair_pos26 <= 1'd0;
		pair_w26 <= 14'd0;
		pair_mag27 <= 28'sd0;
		pair_neg27 <= 29'sd0;
		pair_pos27 <= 1'd0;
		pair_w27 <= 14'd0;
		pair_mag28 <= 28'sd0;
		pair_neg28 <= 29'sd0;
		pair_pos28 <= 1'd0;
		pair_w28 <= 14'd0;
		pair_mag29 <= 28'sd0;
		pair_neg29 <= 29'sd0;
		pair_pos29 <= 1'd0;
		pair_w29 <= 14'd0;
		pair_mag30 <= 28'sd0;
		pair_neg30 <= 29'sd0;
		pair_pos30 <= 1'd0;
		pair_w30 <= 14'd0;
		pair_mag31 <= 28'sd0;
		pair_neg31 <= 29'sd0;
		pair_pos31 <= 1'd0;
		pair_w31 <= 14'd0;
		pair_new_prefetch_choice <= 2'd0;
		pair_new_prefetch_current_magnitude <= 28'sd0;
		pair_new_prefetch_current_negative <= 29'sd0;
		pair_new_prefetch_current_positive <= 1'd0;
		pair_new_prefetch_current_wait <= 14'd0;
		pair_new_prefetch_next_magnitude <= 28'sd0;
		pair_new_prefetch_next_negative <= 29'sd0;
		pair_new_prefetch_next_positive <= 1'd0;
		pair_new_prefetch_next_wait <= 14'd0;
		pair_new_prefetch_zero_magnitude <= 28'sd0;
		pair_new_prefetch_zero_negative <= 29'sd0;
		pair_new_prefetch_zero_positive <= 1'd0;
		pair_new_prefetch_zero_wait <= 14'd0;
	end
end

endmodule
