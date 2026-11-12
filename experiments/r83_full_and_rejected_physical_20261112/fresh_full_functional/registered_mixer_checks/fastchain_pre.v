/* Machine-generated using Migen */
module fastchain_pre_wrapper(
	input sys_clk,
	input sys_rst,
	input signed [13:0] adc,
	input signed [13:0] offset,
	input signed [24:0] dy,
	input [31:0] phase,
	input ce,
	input [13:0] csr_adr,
	input csr_we,
	input [7:0] csr_dat_w,
	output signed [24:0] pre,
	output signed [24:0] y
);

wire signed [13:0] wrapper_adc;
wire signed [24:0] wrapper_out_i;
wire signed [24:0] wrapper_pre_out_i;
wire wrapper_out_i_update_en;
wire signed [24:0] wrapper_out_q;
reg [1:0] wrapper_y_tap_storage_full = 2'd0;
wire [1:0] wrapper_y_tap_storage;
reg wrapper_y_tap_re = 1'd0;
reg wrapper_invert_storage_full = 1'd0;
wire wrapper_invert_storage;
reg wrapper_invert_re = 1'd0;
wire signed [24:0] wrapper_x0;
wire signed [24:0] wrapper_dx;
wire signed [24:0] wrapper_dy;
wire signed [13:0] wrapper_x1;
wire signed [13:0] wrapper_i;
wire signed [13:0] wrapper_q0;
reg [31:0] wrapper_delay_storage_full = 32'd0;
wire [31:0] wrapper_delay_storage;
reg wrapper_delay_re = 1'd0;
reg [3:0] wrapper_multiplier_storage_full = 4'd1;
wire [3:0] wrapper_multiplier_storage;
reg wrapper_multiplier_re = 1'd0;
wire [13:0] wrapper_phase;
wire signed [14:0] wrapper_phase_value;
reg signed [14:0] wrapper_cordic_xi;
reg signed [14:0] wrapper_cordic_yi;
reg signed [14:0] wrapper_cordic_zi;
wire signed [14:0] wrapper_cordic_xo;
wire signed [14:0] wrapper_cordic_yo;
wire signed [14:0] wrapper_cordic_zo;
wire wrapper_cordic_new_in;
wire wrapper_cordic_new_out;
wire signed [16:0] wrapper_cordic0;
reg signed [16:0] wrapper_cordic1 = 17'sd0;
reg signed [16:0] wrapper_cordic2 = 17'sd0;
reg signed [16:0] wrapper_cordic3 = 17'sd0;
reg signed [16:0] wrapper_cordic4 = 17'sd0;
reg signed [16:0] wrapper_cordic5 = 17'sd0;
reg signed [16:0] wrapper_cordic6 = 17'sd0;
reg signed [16:0] wrapper_cordic7 = 17'sd0;
reg signed [16:0] wrapper_cordic8 = 17'sd0;
reg signed [16:0] wrapper_cordic9 = 17'sd0;
reg signed [16:0] wrapper_cordic10 = 17'sd0;
reg signed [16:0] wrapper_cordic11 = 17'sd0;
reg signed [16:0] wrapper_cordic12 = 17'sd0;
reg signed [16:0] wrapper_cordic13 = 17'sd0;
reg signed [16:0] wrapper_cordic14 = 17'sd0;
reg signed [16:0] wrapper_cordic15 = 17'sd0;
wire signed [16:0] wrapper_cordic16;
reg signed [16:0] wrapper_cordic17 = 17'sd0;
reg signed [16:0] wrapper_cordic18 = 17'sd0;
reg signed [16:0] wrapper_cordic19 = 17'sd0;
reg signed [16:0] wrapper_cordic20 = 17'sd0;
reg signed [16:0] wrapper_cordic21 = 17'sd0;
reg signed [16:0] wrapper_cordic22 = 17'sd0;
reg signed [16:0] wrapper_cordic23 = 17'sd0;
reg signed [16:0] wrapper_cordic24 = 17'sd0;
reg signed [16:0] wrapper_cordic25 = 17'sd0;
reg signed [16:0] wrapper_cordic26 = 17'sd0;
reg signed [16:0] wrapper_cordic27 = 17'sd0;
reg signed [16:0] wrapper_cordic28 = 17'sd0;
reg signed [16:0] wrapper_cordic29 = 17'sd0;
reg signed [16:0] wrapper_cordic30 = 17'sd0;
reg signed [16:0] wrapper_cordic31 = 17'sd0;
wire signed [16:0] wrapper_cordic32;
reg signed [16:0] wrapper_cordic33 = 17'sd0;
reg signed [16:0] wrapper_cordic34 = 17'sd0;
reg signed [16:0] wrapper_cordic35 = 17'sd0;
reg signed [16:0] wrapper_cordic36 = 17'sd0;
reg signed [16:0] wrapper_cordic37 = 17'sd0;
reg signed [16:0] wrapper_cordic38 = 17'sd0;
reg signed [16:0] wrapper_cordic39 = 17'sd0;
reg signed [16:0] wrapper_cordic40 = 17'sd0;
reg signed [16:0] wrapper_cordic41 = 17'sd0;
reg signed [16:0] wrapper_cordic42 = 17'sd0;
reg signed [16:0] wrapper_cordic43 = 17'sd0;
reg signed [16:0] wrapper_cordic44 = 17'sd0;
reg signed [16:0] wrapper_cordic45 = 17'sd0;
reg signed [16:0] wrapper_cordic46 = 17'sd0;
reg signed [16:0] wrapper_cordic47 = 17'sd0;
wire wrapper_cordic_dir0;
wire wrapper_cordic_dir1;
wire wrapper_cordic_dir2;
wire wrapper_cordic_dir3;
wire wrapper_cordic_dir4;
wire wrapper_cordic_dir5;
wire wrapper_cordic_dir6;
wire wrapper_cordic_dir7;
wire wrapper_cordic_dir8;
wire wrapper_cordic_dir9;
wire wrapper_cordic_dir10;
wire wrapper_cordic_dir11;
wire wrapper_cordic_dir12;
wire wrapper_cordic_dir13;
wire wrapper_cordic_dir14;
wire signed [14:0] wrapper_xi;
wire signed [14:0] wrapper_yi;
wire signed [14:0] wrapper_zi;
wire wrapper_q1;
reg signed [16:0] wrapper_ya = 17'sd0;
reg signed [24:0] wrapper_limitcsr0_limitcsr0_y0 = 25'sd0;
reg wrapper_limitcsr0_limitcsr0_error0 = 1'd0;
reg wrapper_limitcsr0_update_en0 = 1'd1;
wire signed [25:0] wrapper_limitcsr0_x0;
reg [24:0] wrapper_limitcsr0_min_storage_full0 = 25'd16777216;
wire [24:0] wrapper_limitcsr0_min_storage0;
reg wrapper_limitcsr0_min_re0 = 1'd0;
reg [24:0] wrapper_limitcsr0_max_storage_full0 = 25'd16777215;
wire [24:0] wrapper_limitcsr0_max_storage0;
reg wrapper_limitcsr0_max_re0 = 1'd0;
wire signed [25:0] wrapper_limitcsr0_limit_x0;
reg signed [25:0] wrapper_limitcsr0_limit_y0;
reg signed [25:0] wrapper_limitcsr0_limit_max0 = 26'sd0;
reg signed [25:0] wrapper_limitcsr0_limit_min0 = 26'sd0;
reg wrapper_limitcsr0_limit_railed0;
wire signed [24:0] wrapper_iir0_x0;
reg signed [24:0] wrapper_iir0_y0 = 25'sd0;
wire wrapper_iir0_hold0;
wire wrapper_iir0_clear0;
reg wrapper_iir0_error0 = 1'd0;
reg [26:0] wrapper_iir0_storage_full0 = 27'd0;
wire [26:0] wrapper_iir0_storage0;
reg wrapper_iir0_re0 = 1'd0;
reg signed [17:0] wrapper_iir0_a10 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage0_storage_full0 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage0_storage0;
reg wrapper_iir0_csrstorage0_re0 = 1'd0;
reg signed [17:0] wrapper_iir0_b00 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage1_storage_full0 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage1_storage0;
reg wrapper_iir0_csrstorage1_re0 = 1'd0;
reg signed [17:0] wrapper_iir0_b10 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage2_storage_full0 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage2_storage0;
reg wrapper_iir0_csrstorage2_re0 = 1'd0;
reg signed [42:0] wrapper_iir0_z0r0 = 43'sd0;
reg signed [24:0] wrapper_iir0_y_lim0;
wire signed [42:0] wrapper_iir0_y_next0;
reg [2:0] wrapper_iir0_y_pat0 = 3'd7;
reg signed [24:0] wrapper_iir0_y1 = 25'sd0;
wire wrapper_iir0_railed0;
reg signed [42:0] wrapper_iir0_zr0 = 43'sd0;
wire signed [42:0] wrapper_iir0_z0;
reg signed [42:0] wrapper_iir0_zr1 = 43'sd0;
wire signed [42:0] wrapper_iir0_z1;
reg signed [42:0] wrapper_iir0_zr2 = 43'sd0;
wire signed [42:0] wrapper_iir0_z2;
wire signed [24:0] wrapper_iir0_x1;
reg signed [24:0] wrapper_iir0_y2 = 25'sd0;
wire wrapper_iir0_hold1;
wire wrapper_iir0_clear1;
reg wrapper_iir0_error1 = 1'd0;
reg [26:0] wrapper_iir0_storage_full1 = 27'd0;
wire [26:0] wrapper_iir0_storage1;
reg wrapper_iir0_re1 = 1'd0;
reg signed [17:0] wrapper_iir0_a11 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage0_storage_full1 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage0_storage1;
reg wrapper_iir0_csrstorage0_re1 = 1'd0;
reg signed [17:0] wrapper_iir0_a2 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage1_storage_full1 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage1_storage1;
reg wrapper_iir0_csrstorage1_re1 = 1'd0;
reg signed [17:0] wrapper_iir0_b01 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage2_storage_full1 = 18'd0;
wire [17:0] wrapper_iir0_csrstorage2_storage1;
reg wrapper_iir0_csrstorage2_re1 = 1'd0;
reg signed [17:0] wrapper_iir0_b11 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage3_storage_full = 18'd0;
wire [17:0] wrapper_iir0_csrstorage3_storage;
reg wrapper_iir0_csrstorage3_re = 1'd0;
reg signed [17:0] wrapper_iir0_b2 = 18'sd0;
reg [17:0] wrapper_iir0_csrstorage4_storage_full = 18'd0;
wire [17:0] wrapper_iir0_csrstorage4_storage;
reg wrapper_iir0_csrstorage4_re = 1'd0;
reg signed [42:0] wrapper_iir0_z0r1 = 43'sd0;
reg signed [24:0] wrapper_iir0_y_lim1;
wire signed [42:0] wrapper_iir0_y_next1;
reg [2:0] wrapper_iir0_y_pat1 = 3'd7;
reg signed [24:0] wrapper_iir0_y3 = 25'sd0;
wire wrapper_iir0_railed1;
reg signed [42:0] wrapper_iir0_zr3 = 43'sd0;
wire signed [42:0] wrapper_iir0_z3;
reg signed [42:0] wrapper_iir0_zr4 = 43'sd0;
wire signed [42:0] wrapper_iir0_z4;
reg signed [42:0] wrapper_iir0_zr5 = 43'sd0;
wire signed [42:0] wrapper_iir0_z5;
reg signed [42:0] wrapper_iir0_zr6 = 43'sd0;
wire signed [42:0] wrapper_iir0_z6;
reg signed [42:0] wrapper_iir0_zr7 = 43'sd0;
wire signed [42:0] wrapper_iir0_z7;
reg signed [24:0] wrapper_limitcsr0_limitcsr0_y1 = 25'sd0;
reg wrapper_limitcsr0_limitcsr0_error1 = 1'd0;
wire wrapper_limitcsr0_update_en1;
wire signed [27:0] wrapper_limitcsr0_x1;
reg [24:0] wrapper_limitcsr0_min_storage_full1 = 25'd16777216;
wire [24:0] wrapper_limitcsr0_min_storage1;
reg wrapper_limitcsr0_min_re1 = 1'd0;
reg [24:0] wrapper_limitcsr0_max_storage_full1 = 25'd16777215;
wire [24:0] wrapper_limitcsr0_max_storage1;
reg wrapper_limitcsr0_max_re1 = 1'd0;
wire signed [27:0] wrapper_limitcsr0_limit_x1;
reg signed [27:0] wrapper_limitcsr0_limit_y1;
reg signed [27:0] wrapper_limitcsr0_limit_max1 = 28'sd0;
reg signed [27:0] wrapper_limitcsr0_limit_min1 = 28'sd0;
reg wrapper_limitcsr0_limit_railed1;
reg signed [24:0] wrapper_limitcsr1_limitcsr1_y0 = 25'sd0;
reg wrapper_limitcsr1_limitcsr1_error0 = 1'd0;
reg wrapper_limitcsr1_update_en0 = 1'd1;
wire signed [25:0] wrapper_limitcsr1_x0;
reg [24:0] wrapper_limitcsr1_min_storage_full0 = 25'd16777216;
wire [24:0] wrapper_limitcsr1_min_storage0;
reg wrapper_limitcsr1_min_re0 = 1'd0;
reg [24:0] wrapper_limitcsr1_max_storage_full0 = 25'd16777215;
wire [24:0] wrapper_limitcsr1_max_storage0;
reg wrapper_limitcsr1_max_re0 = 1'd0;
wire signed [25:0] wrapper_limitcsr1_limit_x0;
reg signed [25:0] wrapper_limitcsr1_limit_y0;
reg signed [25:0] wrapper_limitcsr1_limit_max0 = 26'sd0;
reg signed [25:0] wrapper_limitcsr1_limit_min0 = 26'sd0;
reg wrapper_limitcsr1_limit_railed0;
wire signed [24:0] wrapper_iir1_x0;
reg signed [24:0] wrapper_iir1_y0 = 25'sd0;
wire wrapper_iir1_hold0;
wire wrapper_iir1_clear0;
reg wrapper_iir1_error0 = 1'd0;
reg [26:0] wrapper_iir1_storage_full0 = 27'd0;
wire [26:0] wrapper_iir1_storage0;
reg wrapper_iir1_re0 = 1'd0;
reg signed [17:0] wrapper_iir1_a10 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage3_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage3_storage;
reg wrapper_iir1_csrstorage3_re = 1'd0;
reg signed [17:0] wrapper_iir1_b00 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage4_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage4_storage;
reg wrapper_iir1_csrstorage4_re = 1'd0;
reg signed [17:0] wrapper_iir1_b10 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage5_storage_full0 = 18'd0;
wire [17:0] wrapper_iir1_csrstorage5_storage0;
reg wrapper_iir1_csrstorage5_re0 = 1'd0;
reg signed [42:0] wrapper_iir1_z0r0 = 43'sd0;
reg signed [24:0] wrapper_iir1_y_lim0;
wire signed [42:0] wrapper_iir1_y_next0;
reg [2:0] wrapper_iir1_y_pat0 = 3'd7;
reg signed [24:0] wrapper_iir1_y1 = 25'sd0;
wire wrapper_iir1_railed0;
reg signed [42:0] wrapper_iir1_zr0 = 43'sd0;
wire signed [42:0] wrapper_iir1_z0;
reg signed [42:0] wrapper_iir1_zr1 = 43'sd0;
wire signed [42:0] wrapper_iir1_z1;
reg signed [42:0] wrapper_iir1_zr2 = 43'sd0;
wire signed [42:0] wrapper_iir1_z2;
wire signed [24:0] wrapper_iir1_x1;
reg signed [24:0] wrapper_iir1_y2 = 25'sd0;
wire wrapper_iir1_hold1;
wire wrapper_iir1_clear1;
reg wrapper_iir1_error1 = 1'd0;
reg [26:0] wrapper_iir1_storage_full1 = 27'd0;
wire [26:0] wrapper_iir1_storage1;
reg wrapper_iir1_re1 = 1'd0;
reg signed [17:0] wrapper_iir1_a11 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage5_storage_full1 = 18'd0;
wire [17:0] wrapper_iir1_csrstorage5_storage1;
reg wrapper_iir1_csrstorage5_re1 = 1'd0;
reg signed [17:0] wrapper_iir1_a2 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage6_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage6_storage;
reg wrapper_iir1_csrstorage6_re = 1'd0;
reg signed [17:0] wrapper_iir1_b01 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage7_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage7_storage;
reg wrapper_iir1_csrstorage7_re = 1'd0;
reg signed [17:0] wrapper_iir1_b11 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage8_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage8_storage;
reg wrapper_iir1_csrstorage8_re = 1'd0;
reg signed [17:0] wrapper_iir1_b2 = 18'sd0;
reg [17:0] wrapper_iir1_csrstorage9_storage_full = 18'd0;
wire [17:0] wrapper_iir1_csrstorage9_storage;
reg wrapper_iir1_csrstorage9_re = 1'd0;
reg signed [42:0] wrapper_iir1_z0r1 = 43'sd0;
reg signed [24:0] wrapper_iir1_y_lim1;
wire signed [42:0] wrapper_iir1_y_next1;
reg [2:0] wrapper_iir1_y_pat1 = 3'd7;
reg signed [24:0] wrapper_iir1_y3 = 25'sd0;
wire wrapper_iir1_railed1;
reg signed [42:0] wrapper_iir1_zr3 = 43'sd0;
wire signed [42:0] wrapper_iir1_z3;
reg signed [42:0] wrapper_iir1_zr4 = 43'sd0;
wire signed [42:0] wrapper_iir1_z4;
reg signed [42:0] wrapper_iir1_zr5 = 43'sd0;
wire signed [42:0] wrapper_iir1_z5;
reg signed [42:0] wrapper_iir1_zr6 = 43'sd0;
wire signed [42:0] wrapper_iir1_z6;
reg signed [42:0] wrapper_iir1_zr7 = 43'sd0;
wire signed [42:0] wrapper_iir1_z7;
reg signed [24:0] wrapper_limitcsr1_limitcsr1_y1 = 25'sd0;
reg wrapper_limitcsr1_limitcsr1_error1 = 1'd0;
reg wrapper_limitcsr1_update_en1 = 1'd1;
wire signed [27:0] wrapper_limitcsr1_x1;
reg [24:0] wrapper_limitcsr1_min_storage_full1 = 25'd16777216;
wire [24:0] wrapper_limitcsr1_min_storage1;
reg wrapper_limitcsr1_min_re1 = 1'd0;
reg [24:0] wrapper_limitcsr1_max_storage_full1 = 25'd16777215;
wire [24:0] wrapper_limitcsr1_max_storage1;
reg wrapper_limitcsr1_max_re1 = 1'd0;
wire signed [27:0] wrapper_limitcsr1_limit_x1;
reg signed [27:0] wrapper_limitcsr1_limit_y1;
reg signed [27:0] wrapper_limitcsr1_limit_max1 = 28'sd0;
reg signed [27:0] wrapper_limitcsr1_limit_min1 = 28'sd0;
reg wrapper_limitcsr1_limit_railed1;
wire [13:0] wrapper_bus_adr;
wire wrapper_bus_we;
wire [7:0] wrapper_bus_dat_w;
reg [7:0] wrapper_bus_dat_r = 8'd0;
wire wrapper_y_tap0_re;
wire [1:0] wrapper_y_tap0_r;
wire [1:0] wrapper_y_tap0_w;
wire wrapper_invert0_re;
wire wrapper_invert0_r;
wire wrapper_invert0_w;
wire wrapper_demod_delay3_re;
wire [7:0] wrapper_demod_delay3_r;
wire [7:0] wrapper_demod_delay3_w;
wire wrapper_demod_delay2_re;
wire [7:0] wrapper_demod_delay2_r;
wire [7:0] wrapper_demod_delay2_w;
wire wrapper_demod_delay1_re;
wire [7:0] wrapper_demod_delay1_r;
wire [7:0] wrapper_demod_delay1_w;
wire wrapper_demod_delay0_re;
wire [7:0] wrapper_demod_delay0_r;
wire [7:0] wrapper_demod_delay0_w;
wire wrapper_demod_multiplier0_re;
wire [3:0] wrapper_demod_multiplier0_r;
wire [3:0] wrapper_demod_multiplier0_w;
wire wrapper_x_limit_1_min3_re;
wire wrapper_x_limit_1_min3_r;
wire wrapper_x_limit_1_min3_w;
wire wrapper_x_limit_1_min2_re;
wire [7:0] wrapper_x_limit_1_min2_r;
wire [7:0] wrapper_x_limit_1_min2_w;
wire wrapper_x_limit_1_min1_re;
wire [7:0] wrapper_x_limit_1_min1_r;
wire [7:0] wrapper_x_limit_1_min1_w;
wire wrapper_x_limit_1_min0_re;
wire [7:0] wrapper_x_limit_1_min0_r;
wire [7:0] wrapper_x_limit_1_min0_w;
wire wrapper_x_limit_1_max3_re;
wire wrapper_x_limit_1_max3_r;
wire wrapper_x_limit_1_max3_w;
wire wrapper_x_limit_1_max2_re;
wire [7:0] wrapper_x_limit_1_max2_r;
wire [7:0] wrapper_x_limit_1_max2_w;
wire wrapper_x_limit_1_max1_re;
wire [7:0] wrapper_x_limit_1_max1_r;
wire [7:0] wrapper_x_limit_1_max1_w;
wire wrapper_x_limit_1_max0_re;
wire [7:0] wrapper_x_limit_1_max0_r;
wire [7:0] wrapper_x_limit_1_max0_w;
wire wrapper_iir_c_1_z03_re;
wire [2:0] wrapper_iir_c_1_z03_r;
wire [2:0] wrapper_iir_c_1_z03_w;
wire wrapper_iir_c_1_z02_re;
wire [7:0] wrapper_iir_c_1_z02_r;
wire [7:0] wrapper_iir_c_1_z02_w;
wire wrapper_iir_c_1_z01_re;
wire [7:0] wrapper_iir_c_1_z01_r;
wire [7:0] wrapper_iir_c_1_z01_w;
wire wrapper_iir_c_1_z00_re;
wire [7:0] wrapper_iir_c_1_z00_r;
wire [7:0] wrapper_iir_c_1_z00_w;
wire wrapper_iir_c_1_a12_re;
wire [1:0] wrapper_iir_c_1_a12_r;
wire [1:0] wrapper_iir_c_1_a12_w;
wire wrapper_iir_c_1_a11_re;
wire [7:0] wrapper_iir_c_1_a11_r;
wire [7:0] wrapper_iir_c_1_a11_w;
wire wrapper_iir_c_1_a10_re;
wire [7:0] wrapper_iir_c_1_a10_r;
wire [7:0] wrapper_iir_c_1_a10_w;
wire wrapper_iir_c_1_b02_re;
wire [1:0] wrapper_iir_c_1_b02_r;
wire [1:0] wrapper_iir_c_1_b02_w;
wire wrapper_iir_c_1_b01_re;
wire [7:0] wrapper_iir_c_1_b01_r;
wire [7:0] wrapper_iir_c_1_b01_w;
wire wrapper_iir_c_1_b00_re;
wire [7:0] wrapper_iir_c_1_b00_r;
wire [7:0] wrapper_iir_c_1_b00_w;
wire wrapper_iir_c_1_b12_re;
wire [1:0] wrapper_iir_c_1_b12_r;
wire [1:0] wrapper_iir_c_1_b12_w;
wire wrapper_iir_c_1_b11_re;
wire [7:0] wrapper_iir_c_1_b11_r;
wire [7:0] wrapper_iir_c_1_b11_w;
wire wrapper_iir_c_1_b10_re;
wire [7:0] wrapper_iir_c_1_b10_r;
wire [7:0] wrapper_iir_c_1_b10_w;
wire wrapper_iir_d_1_z03_re;
wire [2:0] wrapper_iir_d_1_z03_r;
wire [2:0] wrapper_iir_d_1_z03_w;
wire wrapper_iir_d_1_z02_re;
wire [7:0] wrapper_iir_d_1_z02_r;
wire [7:0] wrapper_iir_d_1_z02_w;
wire wrapper_iir_d_1_z01_re;
wire [7:0] wrapper_iir_d_1_z01_r;
wire [7:0] wrapper_iir_d_1_z01_w;
wire wrapper_iir_d_1_z00_re;
wire [7:0] wrapper_iir_d_1_z00_r;
wire [7:0] wrapper_iir_d_1_z00_w;
wire wrapper_iir_d_1_a12_re;
wire [1:0] wrapper_iir_d_1_a12_r;
wire [1:0] wrapper_iir_d_1_a12_w;
wire wrapper_iir_d_1_a11_re;
wire [7:0] wrapper_iir_d_1_a11_r;
wire [7:0] wrapper_iir_d_1_a11_w;
wire wrapper_iir_d_1_a10_re;
wire [7:0] wrapper_iir_d_1_a10_r;
wire [7:0] wrapper_iir_d_1_a10_w;
wire wrapper_iir_d_1_a22_re;
wire [1:0] wrapper_iir_d_1_a22_r;
wire [1:0] wrapper_iir_d_1_a22_w;
wire wrapper_iir_d_1_a21_re;
wire [7:0] wrapper_iir_d_1_a21_r;
wire [7:0] wrapper_iir_d_1_a21_w;
wire wrapper_iir_d_1_a20_re;
wire [7:0] wrapper_iir_d_1_a20_r;
wire [7:0] wrapper_iir_d_1_a20_w;
wire wrapper_iir_d_1_b02_re;
wire [1:0] wrapper_iir_d_1_b02_r;
wire [1:0] wrapper_iir_d_1_b02_w;
wire wrapper_iir_d_1_b01_re;
wire [7:0] wrapper_iir_d_1_b01_r;
wire [7:0] wrapper_iir_d_1_b01_w;
wire wrapper_iir_d_1_b00_re;
wire [7:0] wrapper_iir_d_1_b00_r;
wire [7:0] wrapper_iir_d_1_b00_w;
wire wrapper_iir_d_1_b12_re;
wire [1:0] wrapper_iir_d_1_b12_r;
wire [1:0] wrapper_iir_d_1_b12_w;
wire wrapper_iir_d_1_b11_re;
wire [7:0] wrapper_iir_d_1_b11_r;
wire [7:0] wrapper_iir_d_1_b11_w;
wire wrapper_iir_d_1_b10_re;
wire [7:0] wrapper_iir_d_1_b10_r;
wire [7:0] wrapper_iir_d_1_b10_w;
wire wrapper_iir_d_1_b22_re;
wire [1:0] wrapper_iir_d_1_b22_r;
wire [1:0] wrapper_iir_d_1_b22_w;
wire wrapper_iir_d_1_b21_re;
wire [7:0] wrapper_iir_d_1_b21_r;
wire [7:0] wrapper_iir_d_1_b21_w;
wire wrapper_iir_d_1_b20_re;
wire [7:0] wrapper_iir_d_1_b20_r;
wire [7:0] wrapper_iir_d_1_b20_w;
wire wrapper_y_limit_1_min3_re;
wire wrapper_y_limit_1_min3_r;
wire wrapper_y_limit_1_min3_w;
wire wrapper_y_limit_1_min2_re;
wire [7:0] wrapper_y_limit_1_min2_r;
wire [7:0] wrapper_y_limit_1_min2_w;
wire wrapper_y_limit_1_min1_re;
wire [7:0] wrapper_y_limit_1_min1_r;
wire [7:0] wrapper_y_limit_1_min1_w;
wire wrapper_y_limit_1_min0_re;
wire [7:0] wrapper_y_limit_1_min0_r;
wire [7:0] wrapper_y_limit_1_min0_w;
wire wrapper_y_limit_1_max3_re;
wire wrapper_y_limit_1_max3_r;
wire wrapper_y_limit_1_max3_w;
wire wrapper_y_limit_1_max2_re;
wire [7:0] wrapper_y_limit_1_max2_r;
wire [7:0] wrapper_y_limit_1_max2_w;
wire wrapper_y_limit_1_max1_re;
wire [7:0] wrapper_y_limit_1_max1_r;
wire [7:0] wrapper_y_limit_1_max1_w;
wire wrapper_y_limit_1_max0_re;
wire [7:0] wrapper_y_limit_1_max0_r;
wire [7:0] wrapper_y_limit_1_max0_w;
wire wrapper_x_limit_2_min3_re;
wire wrapper_x_limit_2_min3_r;
wire wrapper_x_limit_2_min3_w;
wire wrapper_x_limit_2_min2_re;
wire [7:0] wrapper_x_limit_2_min2_r;
wire [7:0] wrapper_x_limit_2_min2_w;
wire wrapper_x_limit_2_min1_re;
wire [7:0] wrapper_x_limit_2_min1_r;
wire [7:0] wrapper_x_limit_2_min1_w;
wire wrapper_x_limit_2_min0_re;
wire [7:0] wrapper_x_limit_2_min0_r;
wire [7:0] wrapper_x_limit_2_min0_w;
wire wrapper_x_limit_2_max3_re;
wire wrapper_x_limit_2_max3_r;
wire wrapper_x_limit_2_max3_w;
wire wrapper_x_limit_2_max2_re;
wire [7:0] wrapper_x_limit_2_max2_r;
wire [7:0] wrapper_x_limit_2_max2_w;
wire wrapper_x_limit_2_max1_re;
wire [7:0] wrapper_x_limit_2_max1_r;
wire [7:0] wrapper_x_limit_2_max1_w;
wire wrapper_x_limit_2_max0_re;
wire [7:0] wrapper_x_limit_2_max0_r;
wire [7:0] wrapper_x_limit_2_max0_w;
wire wrapper_iir_c_2_z03_re;
wire [2:0] wrapper_iir_c_2_z03_r;
wire [2:0] wrapper_iir_c_2_z03_w;
wire wrapper_iir_c_2_z02_re;
wire [7:0] wrapper_iir_c_2_z02_r;
wire [7:0] wrapper_iir_c_2_z02_w;
wire wrapper_iir_c_2_z01_re;
wire [7:0] wrapper_iir_c_2_z01_r;
wire [7:0] wrapper_iir_c_2_z01_w;
wire wrapper_iir_c_2_z00_re;
wire [7:0] wrapper_iir_c_2_z00_r;
wire [7:0] wrapper_iir_c_2_z00_w;
wire wrapper_iir_c_2_a12_re;
wire [1:0] wrapper_iir_c_2_a12_r;
wire [1:0] wrapper_iir_c_2_a12_w;
wire wrapper_iir_c_2_a11_re;
wire [7:0] wrapper_iir_c_2_a11_r;
wire [7:0] wrapper_iir_c_2_a11_w;
wire wrapper_iir_c_2_a10_re;
wire [7:0] wrapper_iir_c_2_a10_r;
wire [7:0] wrapper_iir_c_2_a10_w;
wire wrapper_iir_c_2_b02_re;
wire [1:0] wrapper_iir_c_2_b02_r;
wire [1:0] wrapper_iir_c_2_b02_w;
wire wrapper_iir_c_2_b01_re;
wire [7:0] wrapper_iir_c_2_b01_r;
wire [7:0] wrapper_iir_c_2_b01_w;
wire wrapper_iir_c_2_b00_re;
wire [7:0] wrapper_iir_c_2_b00_r;
wire [7:0] wrapper_iir_c_2_b00_w;
wire wrapper_iir_c_2_b12_re;
wire [1:0] wrapper_iir_c_2_b12_r;
wire [1:0] wrapper_iir_c_2_b12_w;
wire wrapper_iir_c_2_b11_re;
wire [7:0] wrapper_iir_c_2_b11_r;
wire [7:0] wrapper_iir_c_2_b11_w;
wire wrapper_iir_c_2_b10_re;
wire [7:0] wrapper_iir_c_2_b10_r;
wire [7:0] wrapper_iir_c_2_b10_w;
wire wrapper_iir_d_2_z03_re;
wire [2:0] wrapper_iir_d_2_z03_r;
wire [2:0] wrapper_iir_d_2_z03_w;
wire wrapper_iir_d_2_z02_re;
wire [7:0] wrapper_iir_d_2_z02_r;
wire [7:0] wrapper_iir_d_2_z02_w;
wire wrapper_iir_d_2_z01_re;
wire [7:0] wrapper_iir_d_2_z01_r;
wire [7:0] wrapper_iir_d_2_z01_w;
wire wrapper_iir_d_2_z00_re;
wire [7:0] wrapper_iir_d_2_z00_r;
wire [7:0] wrapper_iir_d_2_z00_w;
wire wrapper_iir_d_2_a12_re;
wire [1:0] wrapper_iir_d_2_a12_r;
wire [1:0] wrapper_iir_d_2_a12_w;
wire wrapper_iir_d_2_a11_re;
wire [7:0] wrapper_iir_d_2_a11_r;
wire [7:0] wrapper_iir_d_2_a11_w;
wire wrapper_iir_d_2_a10_re;
wire [7:0] wrapper_iir_d_2_a10_r;
wire [7:0] wrapper_iir_d_2_a10_w;
wire wrapper_iir_d_2_a22_re;
wire [1:0] wrapper_iir_d_2_a22_r;
wire [1:0] wrapper_iir_d_2_a22_w;
wire wrapper_iir_d_2_a21_re;
wire [7:0] wrapper_iir_d_2_a21_r;
wire [7:0] wrapper_iir_d_2_a21_w;
wire wrapper_iir_d_2_a20_re;
wire [7:0] wrapper_iir_d_2_a20_r;
wire [7:0] wrapper_iir_d_2_a20_w;
wire wrapper_iir_d_2_b02_re;
wire [1:0] wrapper_iir_d_2_b02_r;
wire [1:0] wrapper_iir_d_2_b02_w;
wire wrapper_iir_d_2_b01_re;
wire [7:0] wrapper_iir_d_2_b01_r;
wire [7:0] wrapper_iir_d_2_b01_w;
wire wrapper_iir_d_2_b00_re;
wire [7:0] wrapper_iir_d_2_b00_r;
wire [7:0] wrapper_iir_d_2_b00_w;
wire wrapper_iir_d_2_b12_re;
wire [1:0] wrapper_iir_d_2_b12_r;
wire [1:0] wrapper_iir_d_2_b12_w;
wire wrapper_iir_d_2_b11_re;
wire [7:0] wrapper_iir_d_2_b11_r;
wire [7:0] wrapper_iir_d_2_b11_w;
wire wrapper_iir_d_2_b10_re;
wire [7:0] wrapper_iir_d_2_b10_r;
wire [7:0] wrapper_iir_d_2_b10_w;
wire wrapper_iir_d_2_b22_re;
wire [1:0] wrapper_iir_d_2_b22_r;
wire [1:0] wrapper_iir_d_2_b22_w;
wire wrapper_iir_d_2_b21_re;
wire [7:0] wrapper_iir_d_2_b21_r;
wire [7:0] wrapper_iir_d_2_b21_w;
wire wrapper_iir_d_2_b20_re;
wire [7:0] wrapper_iir_d_2_b20_r;
wire [7:0] wrapper_iir_d_2_b20_w;
wire wrapper_y_limit_2_min3_re;
wire wrapper_y_limit_2_min3_r;
wire wrapper_y_limit_2_min3_w;
wire wrapper_y_limit_2_min2_re;
wire [7:0] wrapper_y_limit_2_min2_r;
wire [7:0] wrapper_y_limit_2_min2_w;
wire wrapper_y_limit_2_min1_re;
wire [7:0] wrapper_y_limit_2_min1_r;
wire [7:0] wrapper_y_limit_2_min1_w;
wire wrapper_y_limit_2_min0_re;
wire [7:0] wrapper_y_limit_2_min0_r;
wire [7:0] wrapper_y_limit_2_min0_w;
wire wrapper_y_limit_2_max3_re;
wire wrapper_y_limit_2_max3_r;
wire wrapper_y_limit_2_max3_w;
wire wrapper_y_limit_2_max2_re;
wire [7:0] wrapper_y_limit_2_max2_r;
wire [7:0] wrapper_y_limit_2_max2_w;
wire wrapper_y_limit_2_max1_re;
wire [7:0] wrapper_y_limit_2_max1_r;
wire [7:0] wrapper_y_limit_2_max1_w;
wire wrapper_y_limit_2_max0_re;
wire [7:0] wrapper_y_limit_2_max0_r;
wire [7:0] wrapper_y_limit_2_max0_w;
wire wrapper_sel;
reg signed [24:0] array_muxed0;
reg signed [24:0] array_muxed1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign wrapper_adc = adc;
assign wrapper_dx = 1'd0;
assign wrapper_dy = dy;
assign wrapper_limitcsr0_update_en1 = ce;
assign pre = wrapper_pre_out_i;
assign y = wrapper_out_i;
assign wrapper_bus_adr = csr_adr;
assign wrapper_bus_we = csr_we;
assign wrapper_bus_dat_w = csr_dat_w;
assign wrapper_x0 = (wrapper_adc <<< 4'd11);
assign wrapper_x1 = wrapper_adc;
assign wrapper_phase = phase;
assign wrapper_pre_out_i = wrapper_limitcsr0_limit_y1;
assign wrapper_out_i_update_en = wrapper_limitcsr0_update_en1;
assign wrapper_limitcsr0_x0 = ((wrapper_i <<< 4'd11) + wrapper_dx);
assign wrapper_iir0_x0 = wrapper_limitcsr0_limitcsr0_y0;
assign wrapper_iir0_hold0 = 1'd0;
assign wrapper_iir0_clear0 = 1'd0;
assign wrapper_iir0_x1 = wrapper_iir0_y0;
assign wrapper_iir0_hold1 = 1'd0;
assign wrapper_iir0_clear1 = 1'd0;
assign wrapper_limitcsr0_x1 = ((wrapper_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((array_muxed0 + (wrapper_ya <<< 4'd11)) + (offset <<< 4'd11)));
assign wrapper_out_i = wrapper_limitcsr0_limitcsr0_y1;
assign wrapper_limitcsr1_x0 = ((wrapper_q0 <<< 4'd11) + wrapper_dx);
assign wrapper_iir1_x0 = wrapper_limitcsr1_limitcsr1_y0;
assign wrapper_iir1_hold0 = 1'd0;
assign wrapper_iir1_clear0 = 1'd0;
assign wrapper_iir1_x1 = wrapper_iir1_y0;
assign wrapper_iir1_hold1 = 1'd0;
assign wrapper_iir1_clear1 = 1'd0;
assign wrapper_limitcsr1_x1 = ((wrapper_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((array_muxed1 + (wrapper_ya <<< 4'd11)) + (offset <<< 4'd11)));
assign wrapper_out_q = wrapper_limitcsr1_limitcsr1_y1;
assign wrapper_phase_value = (((wrapper_phase * wrapper_multiplier_storage) + wrapper_delay_storage) <<< 1'd1);
assign wrapper_xi = wrapper_x1;
assign wrapper_zi = wrapper_phase_value;
assign wrapper_yi = 1'd0;
assign wrapper_i = (wrapper_cordic_xo >>> 1'd1);
assign wrapper_q0 = (wrapper_cordic_yo >>> 1'd1);
assign wrapper_cordic0 = (wrapper_cordic_xi <<< 2'd2);
assign wrapper_cordic16 = (wrapper_cordic_yi <<< 2'd2);
assign wrapper_cordic32 = (wrapper_cordic_zi <<< 2'd2);
assign wrapper_cordic_xo = (wrapper_cordic15 >>> 2'd2);
assign wrapper_cordic_yo = (wrapper_cordic31 >>> 2'd2);
assign wrapper_cordic_zo = (wrapper_cordic47 >>> 2'd2);
assign wrapper_cordic_new_out = 1'd1;
assign wrapper_cordic_new_in = 1'd1;
assign wrapper_cordic_dir0 = (wrapper_cordic32 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir1 = (wrapper_cordic33 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir2 = (wrapper_cordic34 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir3 = (wrapper_cordic35 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir4 = (wrapper_cordic36 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir5 = (wrapper_cordic37 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir6 = (wrapper_cordic38 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir7 = (wrapper_cordic39 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir8 = (wrapper_cordic40 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir9 = (wrapper_cordic41 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir10 = (wrapper_cordic42 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir11 = (wrapper_cordic43 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir12 = (wrapper_cordic44 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir13 = (wrapper_cordic45 < $signed({1'd0, 1'd0}));
assign wrapper_cordic_dir14 = (wrapper_cordic46 < $signed({1'd0, 1'd0}));
assign wrapper_q1 = (wrapper_zi[13] ^ wrapper_zi[14]);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	wrapper_cordic_xi <= 15'sd0;
	wrapper_cordic_yi <= 15'sd0;
	wrapper_cordic_zi <= 15'sd0;
	if (wrapper_q1) begin
		{wrapper_cordic_zi, wrapper_cordic_yi, wrapper_cordic_xi} <= {(wrapper_zi + $signed({1'd0, 15'd16384})), (-wrapper_yi), (-wrapper_xi)};
	end else begin
		{wrapper_cordic_zi, wrapper_cordic_yi, wrapper_cordic_xi} <= {wrapper_zi, wrapper_yi, wrapper_xi};
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign wrapper_limitcsr0_limit_x0 = wrapper_limitcsr0_x0;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	wrapper_limitcsr0_limit_y0 <= 26'sd0;
	wrapper_limitcsr0_limit_railed0 <= 1'd0;
	if ((wrapper_limitcsr0_limit_x0 >= wrapper_limitcsr0_limit_max0)) begin
		wrapper_limitcsr0_limit_y0 <= wrapper_limitcsr0_limit_max0;
		wrapper_limitcsr0_limit_railed0 <= 1'd1;
	end else begin
		if ((wrapper_limitcsr0_limit_x0 <= wrapper_limitcsr0_limit_min0)) begin
			wrapper_limitcsr0_limit_y0 <= wrapper_limitcsr0_limit_min0;
			wrapper_limitcsr0_limit_railed0 <= 1'd1;
		end else begin
			wrapper_limitcsr0_limit_y0 <= wrapper_limitcsr0_limit_x0;
			wrapper_limitcsr0_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir0_railed0 = (~((wrapper_iir0_y_next0[42:40] == $signed({1'd0, wrapper_iir0_y_pat0})) | (wrapper_iir0_y_next0[42:40] == $signed({1'd0, (~wrapper_iir0_y_pat0)}))));

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	wrapper_iir0_y_lim0 <= 25'sd0;
	if (wrapper_iir0_railed0) begin
		wrapper_iir0_y_lim0 <= wrapper_iir0_y0;
	end else begin
		wrapper_iir0_y_lim0 <= wrapper_iir0_y_next0[42:16];
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir0_z0 = (wrapper_iir0_zr0 + (wrapper_iir0_x0 * wrapper_iir0_b10));
assign wrapper_iir0_z1 = (wrapper_iir0_zr1 + (wrapper_iir0_x0 * wrapper_iir0_b00));
assign wrapper_iir0_z2 = (wrapper_iir0_zr2 + (wrapper_iir0_y1 * wrapper_iir0_a10));
assign wrapper_iir0_y_next0 = wrapper_iir0_z2;
assign wrapper_iir0_railed1 = (~((wrapper_iir0_y_next1[42:40] == $signed({1'd0, wrapper_iir0_y_pat1})) | (wrapper_iir0_y_next1[42:40] == $signed({1'd0, (~wrapper_iir0_y_pat1)}))));

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	wrapper_iir0_y_lim1 <= 25'sd0;
	if (wrapper_iir0_railed1) begin
		wrapper_iir0_y_lim1 <= wrapper_iir0_y2;
	end else begin
		wrapper_iir0_y_lim1 <= wrapper_iir0_y_next1[42:16];
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir0_z3 = (wrapper_iir0_zr3 + (wrapper_iir0_x1 * wrapper_iir0_b2));
assign wrapper_iir0_z4 = (wrapper_iir0_zr4 + (wrapper_iir0_x1 * wrapper_iir0_b11));
assign wrapper_iir0_z5 = (wrapper_iir0_zr5 + (wrapper_iir0_x1 * wrapper_iir0_b01));
assign wrapper_iir0_z6 = (wrapper_iir0_zr6 + (wrapper_iir0_y3 * wrapper_iir0_a2));
assign wrapper_iir0_z7 = (wrapper_iir0_zr7 + (wrapper_iir0_y3 * wrapper_iir0_a11));
assign wrapper_iir0_y_next1 = wrapper_iir0_z7;
assign wrapper_limitcsr0_limit_x1 = wrapper_limitcsr0_x1;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	wrapper_limitcsr0_limit_y1 <= 28'sd0;
	wrapper_limitcsr0_limit_railed1 <= 1'd0;
	if ((wrapper_limitcsr0_limit_x1 >= wrapper_limitcsr0_limit_max1)) begin
		wrapper_limitcsr0_limit_y1 <= wrapper_limitcsr0_limit_max1;
		wrapper_limitcsr0_limit_railed1 <= 1'd1;
	end else begin
		if ((wrapper_limitcsr0_limit_x1 <= wrapper_limitcsr0_limit_min1)) begin
			wrapper_limitcsr0_limit_y1 <= wrapper_limitcsr0_limit_min1;
			wrapper_limitcsr0_limit_railed1 <= 1'd1;
		end else begin
			wrapper_limitcsr0_limit_y1 <= wrapper_limitcsr0_limit_x1;
			wrapper_limitcsr0_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign wrapper_limitcsr1_limit_x0 = wrapper_limitcsr1_x0;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	wrapper_limitcsr1_limit_y0 <= 26'sd0;
	wrapper_limitcsr1_limit_railed0 <= 1'd0;
	if ((wrapper_limitcsr1_limit_x0 >= wrapper_limitcsr1_limit_max0)) begin
		wrapper_limitcsr1_limit_y0 <= wrapper_limitcsr1_limit_max0;
		wrapper_limitcsr1_limit_railed0 <= 1'd1;
	end else begin
		if ((wrapper_limitcsr1_limit_x0 <= wrapper_limitcsr1_limit_min0)) begin
			wrapper_limitcsr1_limit_y0 <= wrapper_limitcsr1_limit_min0;
			wrapper_limitcsr1_limit_railed0 <= 1'd1;
		end else begin
			wrapper_limitcsr1_limit_y0 <= wrapper_limitcsr1_limit_x0;
			wrapper_limitcsr1_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir1_railed0 = (~((wrapper_iir1_y_next0[42:40] == $signed({1'd0, wrapper_iir1_y_pat0})) | (wrapper_iir1_y_next0[42:40] == $signed({1'd0, (~wrapper_iir1_y_pat0)}))));

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	wrapper_iir1_y_lim0 <= 25'sd0;
	if (wrapper_iir1_railed0) begin
		wrapper_iir1_y_lim0 <= wrapper_iir1_y0;
	end else begin
		wrapper_iir1_y_lim0 <= wrapper_iir1_y_next0[42:16];
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir1_z0 = (wrapper_iir1_zr0 + (wrapper_iir1_x0 * wrapper_iir1_b10));
assign wrapper_iir1_z1 = (wrapper_iir1_zr1 + (wrapper_iir1_x0 * wrapper_iir1_b00));
assign wrapper_iir1_z2 = (wrapper_iir1_zr2 + (wrapper_iir1_y1 * wrapper_iir1_a10));
assign wrapper_iir1_y_next0 = wrapper_iir1_z2;
assign wrapper_iir1_railed1 = (~((wrapper_iir1_y_next1[42:40] == $signed({1'd0, wrapper_iir1_y_pat1})) | (wrapper_iir1_y_next1[42:40] == $signed({1'd0, (~wrapper_iir1_y_pat1)}))));

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	wrapper_iir1_y_lim1 <= 25'sd0;
	if (wrapper_iir1_railed1) begin
		wrapper_iir1_y_lim1 <= wrapper_iir1_y2;
	end else begin
		wrapper_iir1_y_lim1 <= wrapper_iir1_y_next1[42:16];
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign wrapper_iir1_z3 = (wrapper_iir1_zr3 + (wrapper_iir1_x1 * wrapper_iir1_b2));
assign wrapper_iir1_z4 = (wrapper_iir1_zr4 + (wrapper_iir1_x1 * wrapper_iir1_b11));
assign wrapper_iir1_z5 = (wrapper_iir1_zr5 + (wrapper_iir1_x1 * wrapper_iir1_b01));
assign wrapper_iir1_z6 = (wrapper_iir1_zr6 + (wrapper_iir1_y3 * wrapper_iir1_a2));
assign wrapper_iir1_z7 = (wrapper_iir1_zr7 + (wrapper_iir1_y3 * wrapper_iir1_a11));
assign wrapper_iir1_y_next1 = wrapper_iir1_z7;
assign wrapper_limitcsr1_limit_x1 = wrapper_limitcsr1_x1;

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	wrapper_limitcsr1_limit_y1 <= 28'sd0;
	wrapper_limitcsr1_limit_railed1 <= 1'd0;
	if ((wrapper_limitcsr1_limit_x1 >= wrapper_limitcsr1_limit_max1)) begin
		wrapper_limitcsr1_limit_y1 <= wrapper_limitcsr1_limit_max1;
		wrapper_limitcsr1_limit_railed1 <= 1'd1;
	end else begin
		if ((wrapper_limitcsr1_limit_x1 <= wrapper_limitcsr1_limit_min1)) begin
			wrapper_limitcsr1_limit_y1 <= wrapper_limitcsr1_limit_min1;
			wrapper_limitcsr1_limit_railed1 <= 1'd1;
		end else begin
			wrapper_limitcsr1_limit_y1 <= wrapper_limitcsr1_limit_x1;
			wrapper_limitcsr1_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign wrapper_sel = (wrapper_bus_adr[13:9] == 1'd0);
assign wrapper_y_tap0_r = wrapper_bus_dat_w[1:0];
assign wrapper_y_tap0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 1'd0));
assign wrapper_invert0_r = wrapper_bus_dat_w[0];
assign wrapper_invert0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 1'd1));
assign wrapper_demod_delay3_r = wrapper_bus_dat_w[7:0];
assign wrapper_demod_delay3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 2'd2));
assign wrapper_demod_delay2_r = wrapper_bus_dat_w[7:0];
assign wrapper_demod_delay2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 2'd3));
assign wrapper_demod_delay1_r = wrapper_bus_dat_w[7:0];
assign wrapper_demod_delay1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 3'd4));
assign wrapper_demod_delay0_r = wrapper_bus_dat_w[7:0];
assign wrapper_demod_delay0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 3'd5));
assign wrapper_demod_multiplier0_r = wrapper_bus_dat_w[3:0];
assign wrapper_demod_multiplier0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 3'd6));
assign wrapper_x_limit_1_min3_r = wrapper_bus_dat_w[0];
assign wrapper_x_limit_1_min3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 3'd7));
assign wrapper_x_limit_1_min2_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_min2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd8));
assign wrapper_x_limit_1_min1_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_min1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd9));
assign wrapper_x_limit_1_min0_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_min0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd10));
assign wrapper_x_limit_1_max3_r = wrapper_bus_dat_w[0];
assign wrapper_x_limit_1_max3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd11));
assign wrapper_x_limit_1_max2_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_max2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd12));
assign wrapper_x_limit_1_max1_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_max1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd13));
assign wrapper_x_limit_1_max0_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_1_max0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd14));
assign wrapper_iir_c_1_z03_r = wrapper_bus_dat_w[2:0];
assign wrapper_iir_c_1_z03_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 4'd15));
assign wrapper_iir_c_1_z02_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_z02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd16));
assign wrapper_iir_c_1_z01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_z01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd17));
assign wrapper_iir_c_1_z00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_z00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd18));
assign wrapper_iir_c_1_a12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_1_a12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd19));
assign wrapper_iir_c_1_a11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_a11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd20));
assign wrapper_iir_c_1_a10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_a10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd21));
assign wrapper_iir_c_1_b02_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_1_b02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd22));
assign wrapper_iir_c_1_b01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_b01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd23));
assign wrapper_iir_c_1_b00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_b00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd24));
assign wrapper_iir_c_1_b12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_1_b12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd25));
assign wrapper_iir_c_1_b11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_b11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd26));
assign wrapper_iir_c_1_b10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_1_b10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd27));
assign wrapper_iir_d_1_z03_r = wrapper_bus_dat_w[2:0];
assign wrapper_iir_d_1_z03_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd28));
assign wrapper_iir_d_1_z02_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_z02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd29));
assign wrapper_iir_d_1_z01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_z01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd30));
assign wrapper_iir_d_1_z00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_z00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 5'd31));
assign wrapper_iir_d_1_a12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_1_a12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd32));
assign wrapper_iir_d_1_a11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_a11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd33));
assign wrapper_iir_d_1_a10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_a10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd34));
assign wrapper_iir_d_1_a22_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_1_a22_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd35));
assign wrapper_iir_d_1_a21_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_a21_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd36));
assign wrapper_iir_d_1_a20_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_a20_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd37));
assign wrapper_iir_d_1_b02_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_1_b02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd38));
assign wrapper_iir_d_1_b01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd39));
assign wrapper_iir_d_1_b00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd40));
assign wrapper_iir_d_1_b12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_1_b12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd41));
assign wrapper_iir_d_1_b11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd42));
assign wrapper_iir_d_1_b10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd43));
assign wrapper_iir_d_1_b22_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_1_b22_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd44));
assign wrapper_iir_d_1_b21_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b21_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd45));
assign wrapper_iir_d_1_b20_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_1_b20_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd46));
assign wrapper_y_limit_1_min3_r = wrapper_bus_dat_w[0];
assign wrapper_y_limit_1_min3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd47));
assign wrapper_y_limit_1_min2_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_min2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd48));
assign wrapper_y_limit_1_min1_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_min1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd49));
assign wrapper_y_limit_1_min0_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_min0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd50));
assign wrapper_y_limit_1_max3_r = wrapper_bus_dat_w[0];
assign wrapper_y_limit_1_max3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd51));
assign wrapper_y_limit_1_max2_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_max2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd52));
assign wrapper_y_limit_1_max1_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_max1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd53));
assign wrapper_y_limit_1_max0_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_1_max0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd54));
assign wrapper_x_limit_2_min3_r = wrapper_bus_dat_w[0];
assign wrapper_x_limit_2_min3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd55));
assign wrapper_x_limit_2_min2_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_min2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd56));
assign wrapper_x_limit_2_min1_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_min1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd57));
assign wrapper_x_limit_2_min0_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_min0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd58));
assign wrapper_x_limit_2_max3_r = wrapper_bus_dat_w[0];
assign wrapper_x_limit_2_max3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd59));
assign wrapper_x_limit_2_max2_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_max2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd60));
assign wrapper_x_limit_2_max1_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_max1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd61));
assign wrapper_x_limit_2_max0_r = wrapper_bus_dat_w[7:0];
assign wrapper_x_limit_2_max0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd62));
assign wrapper_iir_c_2_z03_r = wrapper_bus_dat_w[2:0];
assign wrapper_iir_c_2_z03_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 6'd63));
assign wrapper_iir_c_2_z02_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_z02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd64));
assign wrapper_iir_c_2_z01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_z01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd65));
assign wrapper_iir_c_2_z00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_z00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd66));
assign wrapper_iir_c_2_a12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_2_a12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd67));
assign wrapper_iir_c_2_a11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_a11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd68));
assign wrapper_iir_c_2_a10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_a10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd69));
assign wrapper_iir_c_2_b02_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_2_b02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd70));
assign wrapper_iir_c_2_b01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_b01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd71));
assign wrapper_iir_c_2_b00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_b00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd72));
assign wrapper_iir_c_2_b12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_c_2_b12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd73));
assign wrapper_iir_c_2_b11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_b11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd74));
assign wrapper_iir_c_2_b10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_c_2_b10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd75));
assign wrapper_iir_d_2_z03_r = wrapper_bus_dat_w[2:0];
assign wrapper_iir_d_2_z03_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd76));
assign wrapper_iir_d_2_z02_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_z02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd77));
assign wrapper_iir_d_2_z01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_z01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd78));
assign wrapper_iir_d_2_z00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_z00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd79));
assign wrapper_iir_d_2_a12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_2_a12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd80));
assign wrapper_iir_d_2_a11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_a11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd81));
assign wrapper_iir_d_2_a10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_a10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd82));
assign wrapper_iir_d_2_a22_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_2_a22_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd83));
assign wrapper_iir_d_2_a21_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_a21_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd84));
assign wrapper_iir_d_2_a20_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_a20_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd85));
assign wrapper_iir_d_2_b02_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_2_b02_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd86));
assign wrapper_iir_d_2_b01_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b01_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd87));
assign wrapper_iir_d_2_b00_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b00_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd88));
assign wrapper_iir_d_2_b12_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_2_b12_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd89));
assign wrapper_iir_d_2_b11_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b11_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd90));
assign wrapper_iir_d_2_b10_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b10_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd91));
assign wrapper_iir_d_2_b22_r = wrapper_bus_dat_w[1:0];
assign wrapper_iir_d_2_b22_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd92));
assign wrapper_iir_d_2_b21_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b21_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd93));
assign wrapper_iir_d_2_b20_r = wrapper_bus_dat_w[7:0];
assign wrapper_iir_d_2_b20_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd94));
assign wrapper_y_limit_2_min3_r = wrapper_bus_dat_w[0];
assign wrapper_y_limit_2_min3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd95));
assign wrapper_y_limit_2_min2_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_min2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd96));
assign wrapper_y_limit_2_min1_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_min1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd97));
assign wrapper_y_limit_2_min0_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_min0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd98));
assign wrapper_y_limit_2_max3_r = wrapper_bus_dat_w[0];
assign wrapper_y_limit_2_max3_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd99));
assign wrapper_y_limit_2_max2_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_max2_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd100));
assign wrapper_y_limit_2_max1_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_max1_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd101));
assign wrapper_y_limit_2_max0_r = wrapper_bus_dat_w[7:0];
assign wrapper_y_limit_2_max0_re = ((wrapper_sel & wrapper_bus_we) & (wrapper_bus_adr[6:0] == 7'd102));
assign wrapper_y_tap_storage = wrapper_y_tap_storage_full[1:0];
assign wrapper_y_tap0_w = wrapper_y_tap_storage_full[1:0];
assign wrapper_invert_storage = wrapper_invert_storage_full;
assign wrapper_invert0_w = wrapper_invert_storage_full;
assign wrapper_delay_storage = wrapper_delay_storage_full[31:0];
assign wrapper_demod_delay3_w = wrapper_delay_storage_full[31:24];
assign wrapper_demod_delay2_w = wrapper_delay_storage_full[23:16];
assign wrapper_demod_delay1_w = wrapper_delay_storage_full[15:8];
assign wrapper_demod_delay0_w = wrapper_delay_storage_full[7:0];
assign wrapper_multiplier_storage = wrapper_multiplier_storage_full[3:0];
assign wrapper_demod_multiplier0_w = wrapper_multiplier_storage_full[3:0];
assign wrapper_limitcsr0_min_storage0 = wrapper_limitcsr0_min_storage_full0[24:0];
assign wrapper_x_limit_1_min3_w = wrapper_limitcsr0_min_storage_full0[24];
assign wrapper_x_limit_1_min2_w = wrapper_limitcsr0_min_storage_full0[23:16];
assign wrapper_x_limit_1_min1_w = wrapper_limitcsr0_min_storage_full0[15:8];
assign wrapper_x_limit_1_min0_w = wrapper_limitcsr0_min_storage_full0[7:0];
assign wrapper_limitcsr0_max_storage0 = wrapper_limitcsr0_max_storage_full0[24:0];
assign wrapper_x_limit_1_max3_w = wrapper_limitcsr0_max_storage_full0[24];
assign wrapper_x_limit_1_max2_w = wrapper_limitcsr0_max_storage_full0[23:16];
assign wrapper_x_limit_1_max1_w = wrapper_limitcsr0_max_storage_full0[15:8];
assign wrapper_x_limit_1_max0_w = wrapper_limitcsr0_max_storage_full0[7:0];
assign wrapper_iir0_storage0 = wrapper_iir0_storage_full0[26:0];
assign wrapper_iir_c_1_z03_w = wrapper_iir0_storage_full0[26:24];
assign wrapper_iir_c_1_z02_w = wrapper_iir0_storage_full0[23:16];
assign wrapper_iir_c_1_z01_w = wrapper_iir0_storage_full0[15:8];
assign wrapper_iir_c_1_z00_w = wrapper_iir0_storage_full0[7:0];
assign wrapper_iir0_csrstorage0_storage0 = wrapper_iir0_csrstorage0_storage_full0[17:0];
assign wrapper_iir_c_1_a12_w = wrapper_iir0_csrstorage0_storage_full0[17:16];
assign wrapper_iir_c_1_a11_w = wrapper_iir0_csrstorage0_storage_full0[15:8];
assign wrapper_iir_c_1_a10_w = wrapper_iir0_csrstorage0_storage_full0[7:0];
assign wrapper_iir0_csrstorage1_storage0 = wrapper_iir0_csrstorage1_storage_full0[17:0];
assign wrapper_iir_c_1_b02_w = wrapper_iir0_csrstorage1_storage_full0[17:16];
assign wrapper_iir_c_1_b01_w = wrapper_iir0_csrstorage1_storage_full0[15:8];
assign wrapper_iir_c_1_b00_w = wrapper_iir0_csrstorage1_storage_full0[7:0];
assign wrapper_iir0_csrstorage2_storage0 = wrapper_iir0_csrstorage2_storage_full0[17:0];
assign wrapper_iir_c_1_b12_w = wrapper_iir0_csrstorage2_storage_full0[17:16];
assign wrapper_iir_c_1_b11_w = wrapper_iir0_csrstorage2_storage_full0[15:8];
assign wrapper_iir_c_1_b10_w = wrapper_iir0_csrstorage2_storage_full0[7:0];
assign wrapper_iir0_storage1 = wrapper_iir0_storage_full1[26:0];
assign wrapper_iir_d_1_z03_w = wrapper_iir0_storage_full1[26:24];
assign wrapper_iir_d_1_z02_w = wrapper_iir0_storage_full1[23:16];
assign wrapper_iir_d_1_z01_w = wrapper_iir0_storage_full1[15:8];
assign wrapper_iir_d_1_z00_w = wrapper_iir0_storage_full1[7:0];
assign wrapper_iir0_csrstorage0_storage1 = wrapper_iir0_csrstorage0_storage_full1[17:0];
assign wrapper_iir_d_1_a12_w = wrapper_iir0_csrstorage0_storage_full1[17:16];
assign wrapper_iir_d_1_a11_w = wrapper_iir0_csrstorage0_storage_full1[15:8];
assign wrapper_iir_d_1_a10_w = wrapper_iir0_csrstorage0_storage_full1[7:0];
assign wrapper_iir0_csrstorage1_storage1 = wrapper_iir0_csrstorage1_storage_full1[17:0];
assign wrapper_iir_d_1_a22_w = wrapper_iir0_csrstorage1_storage_full1[17:16];
assign wrapper_iir_d_1_a21_w = wrapper_iir0_csrstorage1_storage_full1[15:8];
assign wrapper_iir_d_1_a20_w = wrapper_iir0_csrstorage1_storage_full1[7:0];
assign wrapper_iir0_csrstorage2_storage1 = wrapper_iir0_csrstorage2_storage_full1[17:0];
assign wrapper_iir_d_1_b02_w = wrapper_iir0_csrstorage2_storage_full1[17:16];
assign wrapper_iir_d_1_b01_w = wrapper_iir0_csrstorage2_storage_full1[15:8];
assign wrapper_iir_d_1_b00_w = wrapper_iir0_csrstorage2_storage_full1[7:0];
assign wrapper_iir0_csrstorage3_storage = wrapper_iir0_csrstorage3_storage_full[17:0];
assign wrapper_iir_d_1_b12_w = wrapper_iir0_csrstorage3_storage_full[17:16];
assign wrapper_iir_d_1_b11_w = wrapper_iir0_csrstorage3_storage_full[15:8];
assign wrapper_iir_d_1_b10_w = wrapper_iir0_csrstorage3_storage_full[7:0];
assign wrapper_iir0_csrstorage4_storage = wrapper_iir0_csrstorage4_storage_full[17:0];
assign wrapper_iir_d_1_b22_w = wrapper_iir0_csrstorage4_storage_full[17:16];
assign wrapper_iir_d_1_b21_w = wrapper_iir0_csrstorage4_storage_full[15:8];
assign wrapper_iir_d_1_b20_w = wrapper_iir0_csrstorage4_storage_full[7:0];
assign wrapper_limitcsr0_min_storage1 = wrapper_limitcsr0_min_storage_full1[24:0];
assign wrapper_y_limit_1_min3_w = wrapper_limitcsr0_min_storage_full1[24];
assign wrapper_y_limit_1_min2_w = wrapper_limitcsr0_min_storage_full1[23:16];
assign wrapper_y_limit_1_min1_w = wrapper_limitcsr0_min_storage_full1[15:8];
assign wrapper_y_limit_1_min0_w = wrapper_limitcsr0_min_storage_full1[7:0];
assign wrapper_limitcsr0_max_storage1 = wrapper_limitcsr0_max_storage_full1[24:0];
assign wrapper_y_limit_1_max3_w = wrapper_limitcsr0_max_storage_full1[24];
assign wrapper_y_limit_1_max2_w = wrapper_limitcsr0_max_storage_full1[23:16];
assign wrapper_y_limit_1_max1_w = wrapper_limitcsr0_max_storage_full1[15:8];
assign wrapper_y_limit_1_max0_w = wrapper_limitcsr0_max_storage_full1[7:0];
assign wrapper_limitcsr1_min_storage0 = wrapper_limitcsr1_min_storage_full0[24:0];
assign wrapper_x_limit_2_min3_w = wrapper_limitcsr1_min_storage_full0[24];
assign wrapper_x_limit_2_min2_w = wrapper_limitcsr1_min_storage_full0[23:16];
assign wrapper_x_limit_2_min1_w = wrapper_limitcsr1_min_storage_full0[15:8];
assign wrapper_x_limit_2_min0_w = wrapper_limitcsr1_min_storage_full0[7:0];
assign wrapper_limitcsr1_max_storage0 = wrapper_limitcsr1_max_storage_full0[24:0];
assign wrapper_x_limit_2_max3_w = wrapper_limitcsr1_max_storage_full0[24];
assign wrapper_x_limit_2_max2_w = wrapper_limitcsr1_max_storage_full0[23:16];
assign wrapper_x_limit_2_max1_w = wrapper_limitcsr1_max_storage_full0[15:8];
assign wrapper_x_limit_2_max0_w = wrapper_limitcsr1_max_storage_full0[7:0];
assign wrapper_iir1_storage0 = wrapper_iir1_storage_full0[26:0];
assign wrapper_iir_c_2_z03_w = wrapper_iir1_storage_full0[26:24];
assign wrapper_iir_c_2_z02_w = wrapper_iir1_storage_full0[23:16];
assign wrapper_iir_c_2_z01_w = wrapper_iir1_storage_full0[15:8];
assign wrapper_iir_c_2_z00_w = wrapper_iir1_storage_full0[7:0];
assign wrapper_iir1_csrstorage3_storage = wrapper_iir1_csrstorage3_storage_full[17:0];
assign wrapper_iir_c_2_a12_w = wrapper_iir1_csrstorage3_storage_full[17:16];
assign wrapper_iir_c_2_a11_w = wrapper_iir1_csrstorage3_storage_full[15:8];
assign wrapper_iir_c_2_a10_w = wrapper_iir1_csrstorage3_storage_full[7:0];
assign wrapper_iir1_csrstorage4_storage = wrapper_iir1_csrstorage4_storage_full[17:0];
assign wrapper_iir_c_2_b02_w = wrapper_iir1_csrstorage4_storage_full[17:16];
assign wrapper_iir_c_2_b01_w = wrapper_iir1_csrstorage4_storage_full[15:8];
assign wrapper_iir_c_2_b00_w = wrapper_iir1_csrstorage4_storage_full[7:0];
assign wrapper_iir1_csrstorage5_storage0 = wrapper_iir1_csrstorage5_storage_full0[17:0];
assign wrapper_iir_c_2_b12_w = wrapper_iir1_csrstorage5_storage_full0[17:16];
assign wrapper_iir_c_2_b11_w = wrapper_iir1_csrstorage5_storage_full0[15:8];
assign wrapper_iir_c_2_b10_w = wrapper_iir1_csrstorage5_storage_full0[7:0];
assign wrapper_iir1_storage1 = wrapper_iir1_storage_full1[26:0];
assign wrapper_iir_d_2_z03_w = wrapper_iir1_storage_full1[26:24];
assign wrapper_iir_d_2_z02_w = wrapper_iir1_storage_full1[23:16];
assign wrapper_iir_d_2_z01_w = wrapper_iir1_storage_full1[15:8];
assign wrapper_iir_d_2_z00_w = wrapper_iir1_storage_full1[7:0];
assign wrapper_iir1_csrstorage5_storage1 = wrapper_iir1_csrstorage5_storage_full1[17:0];
assign wrapper_iir_d_2_a12_w = wrapper_iir1_csrstorage5_storage_full1[17:16];
assign wrapper_iir_d_2_a11_w = wrapper_iir1_csrstorage5_storage_full1[15:8];
assign wrapper_iir_d_2_a10_w = wrapper_iir1_csrstorage5_storage_full1[7:0];
assign wrapper_iir1_csrstorage6_storage = wrapper_iir1_csrstorage6_storage_full[17:0];
assign wrapper_iir_d_2_a22_w = wrapper_iir1_csrstorage6_storage_full[17:16];
assign wrapper_iir_d_2_a21_w = wrapper_iir1_csrstorage6_storage_full[15:8];
assign wrapper_iir_d_2_a20_w = wrapper_iir1_csrstorage6_storage_full[7:0];
assign wrapper_iir1_csrstorage7_storage = wrapper_iir1_csrstorage7_storage_full[17:0];
assign wrapper_iir_d_2_b02_w = wrapper_iir1_csrstorage7_storage_full[17:16];
assign wrapper_iir_d_2_b01_w = wrapper_iir1_csrstorage7_storage_full[15:8];
assign wrapper_iir_d_2_b00_w = wrapper_iir1_csrstorage7_storage_full[7:0];
assign wrapper_iir1_csrstorage8_storage = wrapper_iir1_csrstorage8_storage_full[17:0];
assign wrapper_iir_d_2_b12_w = wrapper_iir1_csrstorage8_storage_full[17:16];
assign wrapper_iir_d_2_b11_w = wrapper_iir1_csrstorage8_storage_full[15:8];
assign wrapper_iir_d_2_b10_w = wrapper_iir1_csrstorage8_storage_full[7:0];
assign wrapper_iir1_csrstorage9_storage = wrapper_iir1_csrstorage9_storage_full[17:0];
assign wrapper_iir_d_2_b22_w = wrapper_iir1_csrstorage9_storage_full[17:16];
assign wrapper_iir_d_2_b21_w = wrapper_iir1_csrstorage9_storage_full[15:8];
assign wrapper_iir_d_2_b20_w = wrapper_iir1_csrstorage9_storage_full[7:0];
assign wrapper_limitcsr1_min_storage1 = wrapper_limitcsr1_min_storage_full1[24:0];
assign wrapper_y_limit_2_min3_w = wrapper_limitcsr1_min_storage_full1[24];
assign wrapper_y_limit_2_min2_w = wrapper_limitcsr1_min_storage_full1[23:16];
assign wrapper_y_limit_2_min1_w = wrapper_limitcsr1_min_storage_full1[15:8];
assign wrapper_y_limit_2_min0_w = wrapper_limitcsr1_min_storage_full1[7:0];
assign wrapper_limitcsr1_max_storage1 = wrapper_limitcsr1_max_storage_full1[24:0];
assign wrapper_y_limit_2_max3_w = wrapper_limitcsr1_max_storage_full1[24];
assign wrapper_y_limit_2_max2_w = wrapper_limitcsr1_max_storage_full1[23:16];
assign wrapper_y_limit_2_max1_w = wrapper_limitcsr1_max_storage_full1[15:8];
assign wrapper_y_limit_2_max0_w = wrapper_limitcsr1_max_storage_full1[7:0];

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 25'sd0;
	case (wrapper_y_tap_storage)
		1'd0: begin
			array_muxed0 <= wrapper_iir0_x0;
		end
		1'd1: begin
			array_muxed0 <= wrapper_iir0_y0;
		end
		default: begin
			array_muxed0 <= wrapper_iir0_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 25'sd0;
	case (wrapper_y_tap_storage)
		1'd0: begin
			array_muxed1 <= wrapper_iir1_x0;
		end
		1'd1: begin
			array_muxed1 <= wrapper_iir1_y0;
		end
		default: begin
			array_muxed1 <= wrapper_iir1_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	wrapper_ya <= (wrapper_dy >>> 4'd11);
	wrapper_cordic1 <= (wrapper_cordic0 + (wrapper_cordic_dir0 ? (wrapper_cordic16 >>> 1'd0) : (-(wrapper_cordic16 >>> 1'd0))));
	wrapper_cordic17 <= (wrapper_cordic16 + (wrapper_cordic_dir0 ? (-(wrapper_cordic0 >>> 1'd0)) : (wrapper_cordic0 >>> 1'd0)));
	wrapper_cordic33 <= (wrapper_cordic32 + (wrapper_cordic_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	wrapper_cordic2 <= (wrapper_cordic1 + (wrapper_cordic_dir1 ? (wrapper_cordic17 >>> 1'd1) : (-(wrapper_cordic17 >>> 1'd1))));
	wrapper_cordic18 <= (wrapper_cordic17 + (wrapper_cordic_dir1 ? (-(wrapper_cordic1 >>> 1'd1)) : (wrapper_cordic1 >>> 1'd1)));
	wrapper_cordic34 <= (wrapper_cordic33 + (wrapper_cordic_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	wrapper_cordic3 <= (wrapper_cordic2 + (wrapper_cordic_dir2 ? (wrapper_cordic18 >>> 2'd2) : (-(wrapper_cordic18 >>> 2'd2))));
	wrapper_cordic19 <= (wrapper_cordic18 + (wrapper_cordic_dir2 ? (-(wrapper_cordic2 >>> 2'd2)) : (wrapper_cordic2 >>> 2'd2)));
	wrapper_cordic35 <= (wrapper_cordic34 + (wrapper_cordic_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	wrapper_cordic4 <= (wrapper_cordic3 + (wrapper_cordic_dir3 ? (wrapper_cordic19 >>> 2'd3) : (-(wrapper_cordic19 >>> 2'd3))));
	wrapper_cordic20 <= (wrapper_cordic19 + (wrapper_cordic_dir3 ? (-(wrapper_cordic3 >>> 2'd3)) : (wrapper_cordic3 >>> 2'd3)));
	wrapper_cordic36 <= (wrapper_cordic35 + (wrapper_cordic_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	wrapper_cordic5 <= (wrapper_cordic4 + (wrapper_cordic_dir4 ? (wrapper_cordic20 >>> 3'd4) : (-(wrapper_cordic20 >>> 3'd4))));
	wrapper_cordic21 <= (wrapper_cordic20 + (wrapper_cordic_dir4 ? (-(wrapper_cordic4 >>> 3'd4)) : (wrapper_cordic4 >>> 3'd4)));
	wrapper_cordic37 <= (wrapper_cordic36 + (wrapper_cordic_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	wrapper_cordic6 <= (wrapper_cordic5 + (wrapper_cordic_dir5 ? (wrapper_cordic21 >>> 3'd5) : (-(wrapper_cordic21 >>> 3'd5))));
	wrapper_cordic22 <= (wrapper_cordic21 + (wrapper_cordic_dir5 ? (-(wrapper_cordic5 >>> 3'd5)) : (wrapper_cordic5 >>> 3'd5)));
	wrapper_cordic38 <= (wrapper_cordic37 + (wrapper_cordic_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	wrapper_cordic7 <= (wrapper_cordic6 + (wrapper_cordic_dir6 ? (wrapper_cordic22 >>> 3'd6) : (-(wrapper_cordic22 >>> 3'd6))));
	wrapper_cordic23 <= (wrapper_cordic22 + (wrapper_cordic_dir6 ? (-(wrapper_cordic6 >>> 3'd6)) : (wrapper_cordic6 >>> 3'd6)));
	wrapper_cordic39 <= (wrapper_cordic38 + (wrapper_cordic_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	wrapper_cordic8 <= (wrapper_cordic7 + (wrapper_cordic_dir7 ? (wrapper_cordic23 >>> 3'd7) : (-(wrapper_cordic23 >>> 3'd7))));
	wrapper_cordic24 <= (wrapper_cordic23 + (wrapper_cordic_dir7 ? (-(wrapper_cordic7 >>> 3'd7)) : (wrapper_cordic7 >>> 3'd7)));
	wrapper_cordic40 <= (wrapper_cordic39 + (wrapper_cordic_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	wrapper_cordic9 <= (wrapper_cordic8 + (wrapper_cordic_dir8 ? (wrapper_cordic24 >>> 4'd8) : (-(wrapper_cordic24 >>> 4'd8))));
	wrapper_cordic25 <= (wrapper_cordic24 + (wrapper_cordic_dir8 ? (-(wrapper_cordic8 >>> 4'd8)) : (wrapper_cordic8 >>> 4'd8)));
	wrapper_cordic41 <= (wrapper_cordic40 + (wrapper_cordic_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	wrapper_cordic10 <= (wrapper_cordic9 + (wrapper_cordic_dir9 ? (wrapper_cordic25 >>> 4'd9) : (-(wrapper_cordic25 >>> 4'd9))));
	wrapper_cordic26 <= (wrapper_cordic25 + (wrapper_cordic_dir9 ? (-(wrapper_cordic9 >>> 4'd9)) : (wrapper_cordic9 >>> 4'd9)));
	wrapper_cordic42 <= (wrapper_cordic41 + (wrapper_cordic_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	wrapper_cordic11 <= (wrapper_cordic10 + (wrapper_cordic_dir10 ? (wrapper_cordic26 >>> 4'd10) : (-(wrapper_cordic26 >>> 4'd10))));
	wrapper_cordic27 <= (wrapper_cordic26 + (wrapper_cordic_dir10 ? (-(wrapper_cordic10 >>> 4'd10)) : (wrapper_cordic10 >>> 4'd10)));
	wrapper_cordic43 <= (wrapper_cordic42 + (wrapper_cordic_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	wrapper_cordic12 <= (wrapper_cordic11 + (wrapper_cordic_dir11 ? (wrapper_cordic27 >>> 4'd11) : (-(wrapper_cordic27 >>> 4'd11))));
	wrapper_cordic28 <= (wrapper_cordic27 + (wrapper_cordic_dir11 ? (-(wrapper_cordic11 >>> 4'd11)) : (wrapper_cordic11 >>> 4'd11)));
	wrapper_cordic44 <= (wrapper_cordic43 + (wrapper_cordic_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	wrapper_cordic13 <= (wrapper_cordic12 + (wrapper_cordic_dir12 ? (wrapper_cordic28 >>> 4'd12) : (-(wrapper_cordic28 >>> 4'd12))));
	wrapper_cordic29 <= (wrapper_cordic28 + (wrapper_cordic_dir12 ? (-(wrapper_cordic12 >>> 4'd12)) : (wrapper_cordic12 >>> 4'd12)));
	wrapper_cordic45 <= (wrapper_cordic44 + (wrapper_cordic_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	wrapper_cordic14 <= (wrapper_cordic13 + (wrapper_cordic_dir13 ? (wrapper_cordic29 >>> 4'd13) : (-(wrapper_cordic29 >>> 4'd13))));
	wrapper_cordic30 <= (wrapper_cordic29 + (wrapper_cordic_dir13 ? (-(wrapper_cordic13 >>> 4'd13)) : (wrapper_cordic13 >>> 4'd13)));
	wrapper_cordic46 <= (wrapper_cordic45 + (wrapper_cordic_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	wrapper_cordic15 <= (wrapper_cordic14 + (wrapper_cordic_dir14 ? (wrapper_cordic30 >>> 4'd14) : (-(wrapper_cordic30 >>> 4'd14))));
	wrapper_cordic31 <= (wrapper_cordic30 + (wrapper_cordic_dir14 ? (-(wrapper_cordic14 >>> 4'd14)) : (wrapper_cordic14 >>> 4'd14)));
	wrapper_cordic47 <= (wrapper_cordic46 + (wrapper_cordic_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	if (wrapper_limitcsr0_update_en0) begin
		wrapper_limitcsr0_limit_min0 <= {{1{wrapper_limitcsr0_min_storage0[24]}}, wrapper_limitcsr0_min_storage0};
		wrapper_limitcsr0_limit_max0 <= {{1{wrapper_limitcsr0_max_storage0[24]}}, wrapper_limitcsr0_max_storage0};
		wrapper_limitcsr0_limitcsr0_y0 <= wrapper_limitcsr0_limit_y0;
		wrapper_limitcsr0_limitcsr0_error0 <= wrapper_limitcsr0_limit_railed0;
	end
	wrapper_iir0_a10 <= wrapper_iir0_csrstorage0_storage0;
	wrapper_iir0_b00 <= wrapper_iir0_csrstorage1_storage0;
	wrapper_iir0_b10 <= wrapper_iir0_csrstorage2_storage0;
	wrapper_iir0_z0r0 <= (wrapper_iir0_storage0 <<< 5'd16);
	wrapper_iir0_error0 <= wrapper_iir0_railed0;
	wrapper_iir0_y0 <= wrapper_iir0_y_lim0;
	if (wrapper_iir0_clear0) begin
		wrapper_iir0_y1 <= 1'd0;
	end else begin
		if ((~wrapper_iir0_hold0)) begin
			wrapper_iir0_y1 <= wrapper_iir0_y_lim0;
		end
	end
	wrapper_iir0_zr0 <= wrapper_iir0_z0r0;
	wrapper_iir0_zr1 <= wrapper_iir0_z0;
	wrapper_iir0_zr2 <= wrapper_iir0_z1;
	wrapper_iir0_a11 <= wrapper_iir0_csrstorage0_storage1;
	wrapper_iir0_a2 <= wrapper_iir0_csrstorage1_storage1;
	wrapper_iir0_b01 <= wrapper_iir0_csrstorage2_storage1;
	wrapper_iir0_b11 <= wrapper_iir0_csrstorage3_storage;
	wrapper_iir0_b2 <= wrapper_iir0_csrstorage4_storage;
	wrapper_iir0_z0r1 <= (wrapper_iir0_storage1 <<< 5'd16);
	wrapper_iir0_error1 <= wrapper_iir0_railed1;
	wrapper_iir0_y2 <= wrapper_iir0_y_lim1;
	if (wrapper_iir0_clear1) begin
		wrapper_iir0_y3 <= 1'd0;
	end else begin
		if ((~wrapper_iir0_hold1)) begin
			wrapper_iir0_y3 <= wrapper_iir0_y_lim1;
		end
	end
	wrapper_iir0_zr3 <= wrapper_iir0_z0r1;
	wrapper_iir0_zr4 <= wrapper_iir0_z3;
	wrapper_iir0_zr5 <= wrapper_iir0_z4;
	wrapper_iir0_zr6 <= wrapper_iir0_z5;
	wrapper_iir0_zr7 <= wrapper_iir0_z6;
	if (wrapper_limitcsr0_update_en1) begin
		wrapper_limitcsr0_limit_min1 <= {{3{wrapper_limitcsr0_min_storage1[24]}}, wrapper_limitcsr0_min_storage1};
		wrapper_limitcsr0_limit_max1 <= {{3{wrapper_limitcsr0_max_storage1[24]}}, wrapper_limitcsr0_max_storage1};
		wrapper_limitcsr0_limitcsr0_y1 <= wrapper_limitcsr0_limit_y1;
		wrapper_limitcsr0_limitcsr0_error1 <= wrapper_limitcsr0_limit_railed1;
	end
	if (wrapper_limitcsr1_update_en0) begin
		wrapper_limitcsr1_limit_min0 <= {{1{wrapper_limitcsr1_min_storage0[24]}}, wrapper_limitcsr1_min_storage0};
		wrapper_limitcsr1_limit_max0 <= {{1{wrapper_limitcsr1_max_storage0[24]}}, wrapper_limitcsr1_max_storage0};
		wrapper_limitcsr1_limitcsr1_y0 <= wrapper_limitcsr1_limit_y0;
		wrapper_limitcsr1_limitcsr1_error0 <= wrapper_limitcsr1_limit_railed0;
	end
	wrapper_iir1_a10 <= wrapper_iir1_csrstorage3_storage;
	wrapper_iir1_b00 <= wrapper_iir1_csrstorage4_storage;
	wrapper_iir1_b10 <= wrapper_iir1_csrstorage5_storage0;
	wrapper_iir1_z0r0 <= (wrapper_iir1_storage0 <<< 5'd16);
	wrapper_iir1_error0 <= wrapper_iir1_railed0;
	wrapper_iir1_y0 <= wrapper_iir1_y_lim0;
	if (wrapper_iir1_clear0) begin
		wrapper_iir1_y1 <= 1'd0;
	end else begin
		if ((~wrapper_iir1_hold0)) begin
			wrapper_iir1_y1 <= wrapper_iir1_y_lim0;
		end
	end
	wrapper_iir1_zr0 <= wrapper_iir1_z0r0;
	wrapper_iir1_zr1 <= wrapper_iir1_z0;
	wrapper_iir1_zr2 <= wrapper_iir1_z1;
	wrapper_iir1_a11 <= wrapper_iir1_csrstorage5_storage1;
	wrapper_iir1_a2 <= wrapper_iir1_csrstorage6_storage;
	wrapper_iir1_b01 <= wrapper_iir1_csrstorage7_storage;
	wrapper_iir1_b11 <= wrapper_iir1_csrstorage8_storage;
	wrapper_iir1_b2 <= wrapper_iir1_csrstorage9_storage;
	wrapper_iir1_z0r1 <= (wrapper_iir1_storage1 <<< 5'd16);
	wrapper_iir1_error1 <= wrapper_iir1_railed1;
	wrapper_iir1_y2 <= wrapper_iir1_y_lim1;
	if (wrapper_iir1_clear1) begin
		wrapper_iir1_y3 <= 1'd0;
	end else begin
		if ((~wrapper_iir1_hold1)) begin
			wrapper_iir1_y3 <= wrapper_iir1_y_lim1;
		end
	end
	wrapper_iir1_zr3 <= wrapper_iir1_z0r1;
	wrapper_iir1_zr4 <= wrapper_iir1_z3;
	wrapper_iir1_zr5 <= wrapper_iir1_z4;
	wrapper_iir1_zr6 <= wrapper_iir1_z5;
	wrapper_iir1_zr7 <= wrapper_iir1_z6;
	if (wrapper_limitcsr1_update_en1) begin
		wrapper_limitcsr1_limit_min1 <= {{3{wrapper_limitcsr1_min_storage1[24]}}, wrapper_limitcsr1_min_storage1};
		wrapper_limitcsr1_limit_max1 <= {{3{wrapper_limitcsr1_max_storage1[24]}}, wrapper_limitcsr1_max_storage1};
		wrapper_limitcsr1_limitcsr1_y1 <= wrapper_limitcsr1_limit_y1;
		wrapper_limitcsr1_limitcsr1_error1 <= wrapper_limitcsr1_limit_railed1;
	end
	wrapper_bus_dat_r <= 1'd0;
	if (wrapper_sel) begin
		case (wrapper_bus_adr[6:0])
			1'd0: begin
				wrapper_bus_dat_r <= wrapper_y_tap0_w;
			end
			1'd1: begin
				wrapper_bus_dat_r <= wrapper_invert0_w;
			end
			2'd2: begin
				wrapper_bus_dat_r <= wrapper_demod_delay3_w;
			end
			2'd3: begin
				wrapper_bus_dat_r <= wrapper_demod_delay2_w;
			end
			3'd4: begin
				wrapper_bus_dat_r <= wrapper_demod_delay1_w;
			end
			3'd5: begin
				wrapper_bus_dat_r <= wrapper_demod_delay0_w;
			end
			3'd6: begin
				wrapper_bus_dat_r <= wrapper_demod_multiplier0_w;
			end
			3'd7: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_min3_w;
			end
			4'd8: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_min2_w;
			end
			4'd9: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_min1_w;
			end
			4'd10: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_min0_w;
			end
			4'd11: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_max3_w;
			end
			4'd12: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_max2_w;
			end
			4'd13: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_max1_w;
			end
			4'd14: begin
				wrapper_bus_dat_r <= wrapper_x_limit_1_max0_w;
			end
			4'd15: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_z03_w;
			end
			5'd16: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_z02_w;
			end
			5'd17: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_z01_w;
			end
			5'd18: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_z00_w;
			end
			5'd19: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_a12_w;
			end
			5'd20: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_a11_w;
			end
			5'd21: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_a10_w;
			end
			5'd22: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b02_w;
			end
			5'd23: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b01_w;
			end
			5'd24: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b00_w;
			end
			5'd25: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b12_w;
			end
			5'd26: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b11_w;
			end
			5'd27: begin
				wrapper_bus_dat_r <= wrapper_iir_c_1_b10_w;
			end
			5'd28: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_z03_w;
			end
			5'd29: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_z02_w;
			end
			5'd30: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_z01_w;
			end
			5'd31: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_z00_w;
			end
			6'd32: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a12_w;
			end
			6'd33: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a11_w;
			end
			6'd34: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a10_w;
			end
			6'd35: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a22_w;
			end
			6'd36: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a21_w;
			end
			6'd37: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_a20_w;
			end
			6'd38: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b02_w;
			end
			6'd39: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b01_w;
			end
			6'd40: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b00_w;
			end
			6'd41: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b12_w;
			end
			6'd42: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b11_w;
			end
			6'd43: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b10_w;
			end
			6'd44: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b22_w;
			end
			6'd45: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b21_w;
			end
			6'd46: begin
				wrapper_bus_dat_r <= wrapper_iir_d_1_b20_w;
			end
			6'd47: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_min3_w;
			end
			6'd48: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_min2_w;
			end
			6'd49: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_min1_w;
			end
			6'd50: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_min0_w;
			end
			6'd51: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_max3_w;
			end
			6'd52: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_max2_w;
			end
			6'd53: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_max1_w;
			end
			6'd54: begin
				wrapper_bus_dat_r <= wrapper_y_limit_1_max0_w;
			end
			6'd55: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_min3_w;
			end
			6'd56: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_min2_w;
			end
			6'd57: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_min1_w;
			end
			6'd58: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_min0_w;
			end
			6'd59: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_max3_w;
			end
			6'd60: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_max2_w;
			end
			6'd61: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_max1_w;
			end
			6'd62: begin
				wrapper_bus_dat_r <= wrapper_x_limit_2_max0_w;
			end
			6'd63: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_z03_w;
			end
			7'd64: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_z02_w;
			end
			7'd65: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_z01_w;
			end
			7'd66: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_z00_w;
			end
			7'd67: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_a12_w;
			end
			7'd68: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_a11_w;
			end
			7'd69: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_a10_w;
			end
			7'd70: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b02_w;
			end
			7'd71: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b01_w;
			end
			7'd72: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b00_w;
			end
			7'd73: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b12_w;
			end
			7'd74: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b11_w;
			end
			7'd75: begin
				wrapper_bus_dat_r <= wrapper_iir_c_2_b10_w;
			end
			7'd76: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_z03_w;
			end
			7'd77: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_z02_w;
			end
			7'd78: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_z01_w;
			end
			7'd79: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_z00_w;
			end
			7'd80: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a12_w;
			end
			7'd81: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a11_w;
			end
			7'd82: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a10_w;
			end
			7'd83: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a22_w;
			end
			7'd84: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a21_w;
			end
			7'd85: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_a20_w;
			end
			7'd86: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b02_w;
			end
			7'd87: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b01_w;
			end
			7'd88: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b00_w;
			end
			7'd89: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b12_w;
			end
			7'd90: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b11_w;
			end
			7'd91: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b10_w;
			end
			7'd92: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b22_w;
			end
			7'd93: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b21_w;
			end
			7'd94: begin
				wrapper_bus_dat_r <= wrapper_iir_d_2_b20_w;
			end
			7'd95: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_min3_w;
			end
			7'd96: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_min2_w;
			end
			7'd97: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_min1_w;
			end
			7'd98: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_min0_w;
			end
			7'd99: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_max3_w;
			end
			7'd100: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_max2_w;
			end
			7'd101: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_max1_w;
			end
			7'd102: begin
				wrapper_bus_dat_r <= wrapper_y_limit_2_max0_w;
			end
		endcase
	end
	if (wrapper_y_tap0_re) begin
		wrapper_y_tap_storage_full[1:0] <= wrapper_y_tap0_r;
	end
	wrapper_y_tap_re <= wrapper_y_tap0_re;
	if (wrapper_invert0_re) begin
		wrapper_invert_storage_full <= wrapper_invert0_r;
	end
	wrapper_invert_re <= wrapper_invert0_re;
	if (wrapper_demod_delay3_re) begin
		wrapper_delay_storage_full[31:24] <= wrapper_demod_delay3_r;
	end
	if (wrapper_demod_delay2_re) begin
		wrapper_delay_storage_full[23:16] <= wrapper_demod_delay2_r;
	end
	if (wrapper_demod_delay1_re) begin
		wrapper_delay_storage_full[15:8] <= wrapper_demod_delay1_r;
	end
	if (wrapper_demod_delay0_re) begin
		wrapper_delay_storage_full[7:0] <= wrapper_demod_delay0_r;
	end
	wrapper_delay_re <= wrapper_demod_delay0_re;
	if (wrapper_demod_multiplier0_re) begin
		wrapper_multiplier_storage_full[3:0] <= wrapper_demod_multiplier0_r;
	end
	wrapper_multiplier_re <= wrapper_demod_multiplier0_re;
	if (wrapper_x_limit_1_min3_re) begin
		wrapper_limitcsr0_min_storage_full0[24] <= wrapper_x_limit_1_min3_r;
	end
	if (wrapper_x_limit_1_min2_re) begin
		wrapper_limitcsr0_min_storage_full0[23:16] <= wrapper_x_limit_1_min2_r;
	end
	if (wrapper_x_limit_1_min1_re) begin
		wrapper_limitcsr0_min_storage_full0[15:8] <= wrapper_x_limit_1_min1_r;
	end
	if (wrapper_x_limit_1_min0_re) begin
		wrapper_limitcsr0_min_storage_full0[7:0] <= wrapper_x_limit_1_min0_r;
	end
	wrapper_limitcsr0_min_re0 <= wrapper_x_limit_1_min0_re;
	if (wrapper_x_limit_1_max3_re) begin
		wrapper_limitcsr0_max_storage_full0[24] <= wrapper_x_limit_1_max3_r;
	end
	if (wrapper_x_limit_1_max2_re) begin
		wrapper_limitcsr0_max_storage_full0[23:16] <= wrapper_x_limit_1_max2_r;
	end
	if (wrapper_x_limit_1_max1_re) begin
		wrapper_limitcsr0_max_storage_full0[15:8] <= wrapper_x_limit_1_max1_r;
	end
	if (wrapper_x_limit_1_max0_re) begin
		wrapper_limitcsr0_max_storage_full0[7:0] <= wrapper_x_limit_1_max0_r;
	end
	wrapper_limitcsr0_max_re0 <= wrapper_x_limit_1_max0_re;
	if (wrapper_iir_c_1_z03_re) begin
		wrapper_iir0_storage_full0[26:24] <= wrapper_iir_c_1_z03_r;
	end
	if (wrapper_iir_c_1_z02_re) begin
		wrapper_iir0_storage_full0[23:16] <= wrapper_iir_c_1_z02_r;
	end
	if (wrapper_iir_c_1_z01_re) begin
		wrapper_iir0_storage_full0[15:8] <= wrapper_iir_c_1_z01_r;
	end
	if (wrapper_iir_c_1_z00_re) begin
		wrapper_iir0_storage_full0[7:0] <= wrapper_iir_c_1_z00_r;
	end
	wrapper_iir0_re0 <= wrapper_iir_c_1_z00_re;
	if (wrapper_iir_c_1_a12_re) begin
		wrapper_iir0_csrstorage0_storage_full0[17:16] <= wrapper_iir_c_1_a12_r;
	end
	if (wrapper_iir_c_1_a11_re) begin
		wrapper_iir0_csrstorage0_storage_full0[15:8] <= wrapper_iir_c_1_a11_r;
	end
	if (wrapper_iir_c_1_a10_re) begin
		wrapper_iir0_csrstorage0_storage_full0[7:0] <= wrapper_iir_c_1_a10_r;
	end
	wrapper_iir0_csrstorage0_re0 <= wrapper_iir_c_1_a10_re;
	if (wrapper_iir_c_1_b02_re) begin
		wrapper_iir0_csrstorage1_storage_full0[17:16] <= wrapper_iir_c_1_b02_r;
	end
	if (wrapper_iir_c_1_b01_re) begin
		wrapper_iir0_csrstorage1_storage_full0[15:8] <= wrapper_iir_c_1_b01_r;
	end
	if (wrapper_iir_c_1_b00_re) begin
		wrapper_iir0_csrstorage1_storage_full0[7:0] <= wrapper_iir_c_1_b00_r;
	end
	wrapper_iir0_csrstorage1_re0 <= wrapper_iir_c_1_b00_re;
	if (wrapper_iir_c_1_b12_re) begin
		wrapper_iir0_csrstorage2_storage_full0[17:16] <= wrapper_iir_c_1_b12_r;
	end
	if (wrapper_iir_c_1_b11_re) begin
		wrapper_iir0_csrstorage2_storage_full0[15:8] <= wrapper_iir_c_1_b11_r;
	end
	if (wrapper_iir_c_1_b10_re) begin
		wrapper_iir0_csrstorage2_storage_full0[7:0] <= wrapper_iir_c_1_b10_r;
	end
	wrapper_iir0_csrstorage2_re0 <= wrapper_iir_c_1_b10_re;
	if (wrapper_iir_d_1_z03_re) begin
		wrapper_iir0_storage_full1[26:24] <= wrapper_iir_d_1_z03_r;
	end
	if (wrapper_iir_d_1_z02_re) begin
		wrapper_iir0_storage_full1[23:16] <= wrapper_iir_d_1_z02_r;
	end
	if (wrapper_iir_d_1_z01_re) begin
		wrapper_iir0_storage_full1[15:8] <= wrapper_iir_d_1_z01_r;
	end
	if (wrapper_iir_d_1_z00_re) begin
		wrapper_iir0_storage_full1[7:0] <= wrapper_iir_d_1_z00_r;
	end
	wrapper_iir0_re1 <= wrapper_iir_d_1_z00_re;
	if (wrapper_iir_d_1_a12_re) begin
		wrapper_iir0_csrstorage0_storage_full1[17:16] <= wrapper_iir_d_1_a12_r;
	end
	if (wrapper_iir_d_1_a11_re) begin
		wrapper_iir0_csrstorage0_storage_full1[15:8] <= wrapper_iir_d_1_a11_r;
	end
	if (wrapper_iir_d_1_a10_re) begin
		wrapper_iir0_csrstorage0_storage_full1[7:0] <= wrapper_iir_d_1_a10_r;
	end
	wrapper_iir0_csrstorage0_re1 <= wrapper_iir_d_1_a10_re;
	if (wrapper_iir_d_1_a22_re) begin
		wrapper_iir0_csrstorage1_storage_full1[17:16] <= wrapper_iir_d_1_a22_r;
	end
	if (wrapper_iir_d_1_a21_re) begin
		wrapper_iir0_csrstorage1_storage_full1[15:8] <= wrapper_iir_d_1_a21_r;
	end
	if (wrapper_iir_d_1_a20_re) begin
		wrapper_iir0_csrstorage1_storage_full1[7:0] <= wrapper_iir_d_1_a20_r;
	end
	wrapper_iir0_csrstorage1_re1 <= wrapper_iir_d_1_a20_re;
	if (wrapper_iir_d_1_b02_re) begin
		wrapper_iir0_csrstorage2_storage_full1[17:16] <= wrapper_iir_d_1_b02_r;
	end
	if (wrapper_iir_d_1_b01_re) begin
		wrapper_iir0_csrstorage2_storage_full1[15:8] <= wrapper_iir_d_1_b01_r;
	end
	if (wrapper_iir_d_1_b00_re) begin
		wrapper_iir0_csrstorage2_storage_full1[7:0] <= wrapper_iir_d_1_b00_r;
	end
	wrapper_iir0_csrstorage2_re1 <= wrapper_iir_d_1_b00_re;
	if (wrapper_iir_d_1_b12_re) begin
		wrapper_iir0_csrstorage3_storage_full[17:16] <= wrapper_iir_d_1_b12_r;
	end
	if (wrapper_iir_d_1_b11_re) begin
		wrapper_iir0_csrstorage3_storage_full[15:8] <= wrapper_iir_d_1_b11_r;
	end
	if (wrapper_iir_d_1_b10_re) begin
		wrapper_iir0_csrstorage3_storage_full[7:0] <= wrapper_iir_d_1_b10_r;
	end
	wrapper_iir0_csrstorage3_re <= wrapper_iir_d_1_b10_re;
	if (wrapper_iir_d_1_b22_re) begin
		wrapper_iir0_csrstorage4_storage_full[17:16] <= wrapper_iir_d_1_b22_r;
	end
	if (wrapper_iir_d_1_b21_re) begin
		wrapper_iir0_csrstorage4_storage_full[15:8] <= wrapper_iir_d_1_b21_r;
	end
	if (wrapper_iir_d_1_b20_re) begin
		wrapper_iir0_csrstorage4_storage_full[7:0] <= wrapper_iir_d_1_b20_r;
	end
	wrapper_iir0_csrstorage4_re <= wrapper_iir_d_1_b20_re;
	if (wrapper_y_limit_1_min3_re) begin
		wrapper_limitcsr0_min_storage_full1[24] <= wrapper_y_limit_1_min3_r;
	end
	if (wrapper_y_limit_1_min2_re) begin
		wrapper_limitcsr0_min_storage_full1[23:16] <= wrapper_y_limit_1_min2_r;
	end
	if (wrapper_y_limit_1_min1_re) begin
		wrapper_limitcsr0_min_storage_full1[15:8] <= wrapper_y_limit_1_min1_r;
	end
	if (wrapper_y_limit_1_min0_re) begin
		wrapper_limitcsr0_min_storage_full1[7:0] <= wrapper_y_limit_1_min0_r;
	end
	wrapper_limitcsr0_min_re1 <= wrapper_y_limit_1_min0_re;
	if (wrapper_y_limit_1_max3_re) begin
		wrapper_limitcsr0_max_storage_full1[24] <= wrapper_y_limit_1_max3_r;
	end
	if (wrapper_y_limit_1_max2_re) begin
		wrapper_limitcsr0_max_storage_full1[23:16] <= wrapper_y_limit_1_max2_r;
	end
	if (wrapper_y_limit_1_max1_re) begin
		wrapper_limitcsr0_max_storage_full1[15:8] <= wrapper_y_limit_1_max1_r;
	end
	if (wrapper_y_limit_1_max0_re) begin
		wrapper_limitcsr0_max_storage_full1[7:0] <= wrapper_y_limit_1_max0_r;
	end
	wrapper_limitcsr0_max_re1 <= wrapper_y_limit_1_max0_re;
	if (wrapper_x_limit_2_min3_re) begin
		wrapper_limitcsr1_min_storage_full0[24] <= wrapper_x_limit_2_min3_r;
	end
	if (wrapper_x_limit_2_min2_re) begin
		wrapper_limitcsr1_min_storage_full0[23:16] <= wrapper_x_limit_2_min2_r;
	end
	if (wrapper_x_limit_2_min1_re) begin
		wrapper_limitcsr1_min_storage_full0[15:8] <= wrapper_x_limit_2_min1_r;
	end
	if (wrapper_x_limit_2_min0_re) begin
		wrapper_limitcsr1_min_storage_full0[7:0] <= wrapper_x_limit_2_min0_r;
	end
	wrapper_limitcsr1_min_re0 <= wrapper_x_limit_2_min0_re;
	if (wrapper_x_limit_2_max3_re) begin
		wrapper_limitcsr1_max_storage_full0[24] <= wrapper_x_limit_2_max3_r;
	end
	if (wrapper_x_limit_2_max2_re) begin
		wrapper_limitcsr1_max_storage_full0[23:16] <= wrapper_x_limit_2_max2_r;
	end
	if (wrapper_x_limit_2_max1_re) begin
		wrapper_limitcsr1_max_storage_full0[15:8] <= wrapper_x_limit_2_max1_r;
	end
	if (wrapper_x_limit_2_max0_re) begin
		wrapper_limitcsr1_max_storage_full0[7:0] <= wrapper_x_limit_2_max0_r;
	end
	wrapper_limitcsr1_max_re0 <= wrapper_x_limit_2_max0_re;
	if (wrapper_iir_c_2_z03_re) begin
		wrapper_iir1_storage_full0[26:24] <= wrapper_iir_c_2_z03_r;
	end
	if (wrapper_iir_c_2_z02_re) begin
		wrapper_iir1_storage_full0[23:16] <= wrapper_iir_c_2_z02_r;
	end
	if (wrapper_iir_c_2_z01_re) begin
		wrapper_iir1_storage_full0[15:8] <= wrapper_iir_c_2_z01_r;
	end
	if (wrapper_iir_c_2_z00_re) begin
		wrapper_iir1_storage_full0[7:0] <= wrapper_iir_c_2_z00_r;
	end
	wrapper_iir1_re0 <= wrapper_iir_c_2_z00_re;
	if (wrapper_iir_c_2_a12_re) begin
		wrapper_iir1_csrstorage3_storage_full[17:16] <= wrapper_iir_c_2_a12_r;
	end
	if (wrapper_iir_c_2_a11_re) begin
		wrapper_iir1_csrstorage3_storage_full[15:8] <= wrapper_iir_c_2_a11_r;
	end
	if (wrapper_iir_c_2_a10_re) begin
		wrapper_iir1_csrstorage3_storage_full[7:0] <= wrapper_iir_c_2_a10_r;
	end
	wrapper_iir1_csrstorage3_re <= wrapper_iir_c_2_a10_re;
	if (wrapper_iir_c_2_b02_re) begin
		wrapper_iir1_csrstorage4_storage_full[17:16] <= wrapper_iir_c_2_b02_r;
	end
	if (wrapper_iir_c_2_b01_re) begin
		wrapper_iir1_csrstorage4_storage_full[15:8] <= wrapper_iir_c_2_b01_r;
	end
	if (wrapper_iir_c_2_b00_re) begin
		wrapper_iir1_csrstorage4_storage_full[7:0] <= wrapper_iir_c_2_b00_r;
	end
	wrapper_iir1_csrstorage4_re <= wrapper_iir_c_2_b00_re;
	if (wrapper_iir_c_2_b12_re) begin
		wrapper_iir1_csrstorage5_storage_full0[17:16] <= wrapper_iir_c_2_b12_r;
	end
	if (wrapper_iir_c_2_b11_re) begin
		wrapper_iir1_csrstorage5_storage_full0[15:8] <= wrapper_iir_c_2_b11_r;
	end
	if (wrapper_iir_c_2_b10_re) begin
		wrapper_iir1_csrstorage5_storage_full0[7:0] <= wrapper_iir_c_2_b10_r;
	end
	wrapper_iir1_csrstorage5_re0 <= wrapper_iir_c_2_b10_re;
	if (wrapper_iir_d_2_z03_re) begin
		wrapper_iir1_storage_full1[26:24] <= wrapper_iir_d_2_z03_r;
	end
	if (wrapper_iir_d_2_z02_re) begin
		wrapper_iir1_storage_full1[23:16] <= wrapper_iir_d_2_z02_r;
	end
	if (wrapper_iir_d_2_z01_re) begin
		wrapper_iir1_storage_full1[15:8] <= wrapper_iir_d_2_z01_r;
	end
	if (wrapper_iir_d_2_z00_re) begin
		wrapper_iir1_storage_full1[7:0] <= wrapper_iir_d_2_z00_r;
	end
	wrapper_iir1_re1 <= wrapper_iir_d_2_z00_re;
	if (wrapper_iir_d_2_a12_re) begin
		wrapper_iir1_csrstorage5_storage_full1[17:16] <= wrapper_iir_d_2_a12_r;
	end
	if (wrapper_iir_d_2_a11_re) begin
		wrapper_iir1_csrstorage5_storage_full1[15:8] <= wrapper_iir_d_2_a11_r;
	end
	if (wrapper_iir_d_2_a10_re) begin
		wrapper_iir1_csrstorage5_storage_full1[7:0] <= wrapper_iir_d_2_a10_r;
	end
	wrapper_iir1_csrstorage5_re1 <= wrapper_iir_d_2_a10_re;
	if (wrapper_iir_d_2_a22_re) begin
		wrapper_iir1_csrstorage6_storage_full[17:16] <= wrapper_iir_d_2_a22_r;
	end
	if (wrapper_iir_d_2_a21_re) begin
		wrapper_iir1_csrstorage6_storage_full[15:8] <= wrapper_iir_d_2_a21_r;
	end
	if (wrapper_iir_d_2_a20_re) begin
		wrapper_iir1_csrstorage6_storage_full[7:0] <= wrapper_iir_d_2_a20_r;
	end
	wrapper_iir1_csrstorage6_re <= wrapper_iir_d_2_a20_re;
	if (wrapper_iir_d_2_b02_re) begin
		wrapper_iir1_csrstorage7_storage_full[17:16] <= wrapper_iir_d_2_b02_r;
	end
	if (wrapper_iir_d_2_b01_re) begin
		wrapper_iir1_csrstorage7_storage_full[15:8] <= wrapper_iir_d_2_b01_r;
	end
	if (wrapper_iir_d_2_b00_re) begin
		wrapper_iir1_csrstorage7_storage_full[7:0] <= wrapper_iir_d_2_b00_r;
	end
	wrapper_iir1_csrstorage7_re <= wrapper_iir_d_2_b00_re;
	if (wrapper_iir_d_2_b12_re) begin
		wrapper_iir1_csrstorage8_storage_full[17:16] <= wrapper_iir_d_2_b12_r;
	end
	if (wrapper_iir_d_2_b11_re) begin
		wrapper_iir1_csrstorage8_storage_full[15:8] <= wrapper_iir_d_2_b11_r;
	end
	if (wrapper_iir_d_2_b10_re) begin
		wrapper_iir1_csrstorage8_storage_full[7:0] <= wrapper_iir_d_2_b10_r;
	end
	wrapper_iir1_csrstorage8_re <= wrapper_iir_d_2_b10_re;
	if (wrapper_iir_d_2_b22_re) begin
		wrapper_iir1_csrstorage9_storage_full[17:16] <= wrapper_iir_d_2_b22_r;
	end
	if (wrapper_iir_d_2_b21_re) begin
		wrapper_iir1_csrstorage9_storage_full[15:8] <= wrapper_iir_d_2_b21_r;
	end
	if (wrapper_iir_d_2_b20_re) begin
		wrapper_iir1_csrstorage9_storage_full[7:0] <= wrapper_iir_d_2_b20_r;
	end
	wrapper_iir1_csrstorage9_re <= wrapper_iir_d_2_b20_re;
	if (wrapper_y_limit_2_min3_re) begin
		wrapper_limitcsr1_min_storage_full1[24] <= wrapper_y_limit_2_min3_r;
	end
	if (wrapper_y_limit_2_min2_re) begin
		wrapper_limitcsr1_min_storage_full1[23:16] <= wrapper_y_limit_2_min2_r;
	end
	if (wrapper_y_limit_2_min1_re) begin
		wrapper_limitcsr1_min_storage_full1[15:8] <= wrapper_y_limit_2_min1_r;
	end
	if (wrapper_y_limit_2_min0_re) begin
		wrapper_limitcsr1_min_storage_full1[7:0] <= wrapper_y_limit_2_min0_r;
	end
	wrapper_limitcsr1_min_re1 <= wrapper_y_limit_2_min0_re;
	if (wrapper_y_limit_2_max3_re) begin
		wrapper_limitcsr1_max_storage_full1[24] <= wrapper_y_limit_2_max3_r;
	end
	if (wrapper_y_limit_2_max2_re) begin
		wrapper_limitcsr1_max_storage_full1[23:16] <= wrapper_y_limit_2_max2_r;
	end
	if (wrapper_y_limit_2_max1_re) begin
		wrapper_limitcsr1_max_storage_full1[15:8] <= wrapper_y_limit_2_max1_r;
	end
	if (wrapper_y_limit_2_max0_re) begin
		wrapper_limitcsr1_max_storage_full1[7:0] <= wrapper_y_limit_2_max0_r;
	end
	wrapper_limitcsr1_max_re1 <= wrapper_y_limit_2_max0_re;
	if (sys_rst) begin
		wrapper_y_tap_storage_full <= 2'd0;
		wrapper_y_tap_re <= 1'd0;
		wrapper_invert_storage_full <= 1'd0;
		wrapper_invert_re <= 1'd0;
		wrapper_delay_storage_full <= 32'd0;
		wrapper_delay_re <= 1'd0;
		wrapper_multiplier_storage_full <= 4'd1;
		wrapper_multiplier_re <= 1'd0;
		wrapper_cordic1 <= 17'sd0;
		wrapper_cordic2 <= 17'sd0;
		wrapper_cordic3 <= 17'sd0;
		wrapper_cordic4 <= 17'sd0;
		wrapper_cordic5 <= 17'sd0;
		wrapper_cordic6 <= 17'sd0;
		wrapper_cordic7 <= 17'sd0;
		wrapper_cordic8 <= 17'sd0;
		wrapper_cordic9 <= 17'sd0;
		wrapper_cordic10 <= 17'sd0;
		wrapper_cordic11 <= 17'sd0;
		wrapper_cordic12 <= 17'sd0;
		wrapper_cordic13 <= 17'sd0;
		wrapper_cordic14 <= 17'sd0;
		wrapper_cordic15 <= 17'sd0;
		wrapper_cordic17 <= 17'sd0;
		wrapper_cordic18 <= 17'sd0;
		wrapper_cordic19 <= 17'sd0;
		wrapper_cordic20 <= 17'sd0;
		wrapper_cordic21 <= 17'sd0;
		wrapper_cordic22 <= 17'sd0;
		wrapper_cordic23 <= 17'sd0;
		wrapper_cordic24 <= 17'sd0;
		wrapper_cordic25 <= 17'sd0;
		wrapper_cordic26 <= 17'sd0;
		wrapper_cordic27 <= 17'sd0;
		wrapper_cordic28 <= 17'sd0;
		wrapper_cordic29 <= 17'sd0;
		wrapper_cordic30 <= 17'sd0;
		wrapper_cordic31 <= 17'sd0;
		wrapper_cordic33 <= 17'sd0;
		wrapper_cordic34 <= 17'sd0;
		wrapper_cordic35 <= 17'sd0;
		wrapper_cordic36 <= 17'sd0;
		wrapper_cordic37 <= 17'sd0;
		wrapper_cordic38 <= 17'sd0;
		wrapper_cordic39 <= 17'sd0;
		wrapper_cordic40 <= 17'sd0;
		wrapper_cordic41 <= 17'sd0;
		wrapper_cordic42 <= 17'sd0;
		wrapper_cordic43 <= 17'sd0;
		wrapper_cordic44 <= 17'sd0;
		wrapper_cordic45 <= 17'sd0;
		wrapper_cordic46 <= 17'sd0;
		wrapper_cordic47 <= 17'sd0;
		wrapper_ya <= 17'sd0;
		wrapper_limitcsr0_limitcsr0_y0 <= 25'sd0;
		wrapper_limitcsr0_limitcsr0_error0 <= 1'd0;
		wrapper_limitcsr0_min_storage_full0 <= 25'd16777216;
		wrapper_limitcsr0_min_re0 <= 1'd0;
		wrapper_limitcsr0_max_storage_full0 <= 25'd16777215;
		wrapper_limitcsr0_max_re0 <= 1'd0;
		wrapper_limitcsr0_limit_max0 <= 26'sd0;
		wrapper_limitcsr0_limit_min0 <= 26'sd0;
		wrapper_iir0_y0 <= 25'sd0;
		wrapper_iir0_error0 <= 1'd0;
		wrapper_iir0_storage_full0 <= 27'd0;
		wrapper_iir0_re0 <= 1'd0;
		wrapper_iir0_a10 <= 18'sd0;
		wrapper_iir0_csrstorage0_storage_full0 <= 18'd0;
		wrapper_iir0_csrstorage0_re0 <= 1'd0;
		wrapper_iir0_b00 <= 18'sd0;
		wrapper_iir0_csrstorage1_storage_full0 <= 18'd0;
		wrapper_iir0_csrstorage1_re0 <= 1'd0;
		wrapper_iir0_b10 <= 18'sd0;
		wrapper_iir0_csrstorage2_storage_full0 <= 18'd0;
		wrapper_iir0_csrstorage2_re0 <= 1'd0;
		wrapper_iir0_z0r0 <= 43'sd0;
		wrapper_iir0_y1 <= 25'sd0;
		wrapper_iir0_zr0 <= 43'sd0;
		wrapper_iir0_zr1 <= 43'sd0;
		wrapper_iir0_zr2 <= 43'sd0;
		wrapper_iir0_y2 <= 25'sd0;
		wrapper_iir0_error1 <= 1'd0;
		wrapper_iir0_storage_full1 <= 27'd0;
		wrapper_iir0_re1 <= 1'd0;
		wrapper_iir0_a11 <= 18'sd0;
		wrapper_iir0_csrstorage0_storage_full1 <= 18'd0;
		wrapper_iir0_csrstorage0_re1 <= 1'd0;
		wrapper_iir0_a2 <= 18'sd0;
		wrapper_iir0_csrstorage1_storage_full1 <= 18'd0;
		wrapper_iir0_csrstorage1_re1 <= 1'd0;
		wrapper_iir0_b01 <= 18'sd0;
		wrapper_iir0_csrstorage2_storage_full1 <= 18'd0;
		wrapper_iir0_csrstorage2_re1 <= 1'd0;
		wrapper_iir0_b11 <= 18'sd0;
		wrapper_iir0_csrstorage3_storage_full <= 18'd0;
		wrapper_iir0_csrstorage3_re <= 1'd0;
		wrapper_iir0_b2 <= 18'sd0;
		wrapper_iir0_csrstorage4_storage_full <= 18'd0;
		wrapper_iir0_csrstorage4_re <= 1'd0;
		wrapper_iir0_z0r1 <= 43'sd0;
		wrapper_iir0_y3 <= 25'sd0;
		wrapper_iir0_zr3 <= 43'sd0;
		wrapper_iir0_zr4 <= 43'sd0;
		wrapper_iir0_zr5 <= 43'sd0;
		wrapper_iir0_zr6 <= 43'sd0;
		wrapper_iir0_zr7 <= 43'sd0;
		wrapper_limitcsr0_limitcsr0_y1 <= 25'sd0;
		wrapper_limitcsr0_limitcsr0_error1 <= 1'd0;
		wrapper_limitcsr0_min_storage_full1 <= 25'd16777216;
		wrapper_limitcsr0_min_re1 <= 1'd0;
		wrapper_limitcsr0_max_storage_full1 <= 25'd16777215;
		wrapper_limitcsr0_max_re1 <= 1'd0;
		wrapper_limitcsr0_limit_max1 <= 28'sd0;
		wrapper_limitcsr0_limit_min1 <= 28'sd0;
		wrapper_limitcsr1_limitcsr1_y0 <= 25'sd0;
		wrapper_limitcsr1_limitcsr1_error0 <= 1'd0;
		wrapper_limitcsr1_min_storage_full0 <= 25'd16777216;
		wrapper_limitcsr1_min_re0 <= 1'd0;
		wrapper_limitcsr1_max_storage_full0 <= 25'd16777215;
		wrapper_limitcsr1_max_re0 <= 1'd0;
		wrapper_limitcsr1_limit_max0 <= 26'sd0;
		wrapper_limitcsr1_limit_min0 <= 26'sd0;
		wrapper_iir1_y0 <= 25'sd0;
		wrapper_iir1_error0 <= 1'd0;
		wrapper_iir1_storage_full0 <= 27'd0;
		wrapper_iir1_re0 <= 1'd0;
		wrapper_iir1_a10 <= 18'sd0;
		wrapper_iir1_csrstorage3_storage_full <= 18'd0;
		wrapper_iir1_csrstorage3_re <= 1'd0;
		wrapper_iir1_b00 <= 18'sd0;
		wrapper_iir1_csrstorage4_storage_full <= 18'd0;
		wrapper_iir1_csrstorage4_re <= 1'd0;
		wrapper_iir1_b10 <= 18'sd0;
		wrapper_iir1_csrstorage5_storage_full0 <= 18'd0;
		wrapper_iir1_csrstorage5_re0 <= 1'd0;
		wrapper_iir1_z0r0 <= 43'sd0;
		wrapper_iir1_y1 <= 25'sd0;
		wrapper_iir1_zr0 <= 43'sd0;
		wrapper_iir1_zr1 <= 43'sd0;
		wrapper_iir1_zr2 <= 43'sd0;
		wrapper_iir1_y2 <= 25'sd0;
		wrapper_iir1_error1 <= 1'd0;
		wrapper_iir1_storage_full1 <= 27'd0;
		wrapper_iir1_re1 <= 1'd0;
		wrapper_iir1_a11 <= 18'sd0;
		wrapper_iir1_csrstorage5_storage_full1 <= 18'd0;
		wrapper_iir1_csrstorage5_re1 <= 1'd0;
		wrapper_iir1_a2 <= 18'sd0;
		wrapper_iir1_csrstorage6_storage_full <= 18'd0;
		wrapper_iir1_csrstorage6_re <= 1'd0;
		wrapper_iir1_b01 <= 18'sd0;
		wrapper_iir1_csrstorage7_storage_full <= 18'd0;
		wrapper_iir1_csrstorage7_re <= 1'd0;
		wrapper_iir1_b11 <= 18'sd0;
		wrapper_iir1_csrstorage8_storage_full <= 18'd0;
		wrapper_iir1_csrstorage8_re <= 1'd0;
		wrapper_iir1_b2 <= 18'sd0;
		wrapper_iir1_csrstorage9_storage_full <= 18'd0;
		wrapper_iir1_csrstorage9_re <= 1'd0;
		wrapper_iir1_z0r1 <= 43'sd0;
		wrapper_iir1_y3 <= 25'sd0;
		wrapper_iir1_zr3 <= 43'sd0;
		wrapper_iir1_zr4 <= 43'sd0;
		wrapper_iir1_zr5 <= 43'sd0;
		wrapper_iir1_zr6 <= 43'sd0;
		wrapper_iir1_zr7 <= 43'sd0;
		wrapper_limitcsr1_limitcsr1_y1 <= 25'sd0;
		wrapper_limitcsr1_limitcsr1_error1 <= 1'd0;
		wrapper_limitcsr1_min_storage_full1 <= 25'd16777216;
		wrapper_limitcsr1_min_re1 <= 1'd0;
		wrapper_limitcsr1_max_storage_full1 <= 25'd16777215;
		wrapper_limitcsr1_max_re1 <= 1'd0;
		wrapper_limitcsr1_limit_max1 <= 28'sd0;
		wrapper_limitcsr1_limit_min1 <= 28'sd0;
		wrapper_bus_dat_r <= 8'd0;
	end
end

endmodule
