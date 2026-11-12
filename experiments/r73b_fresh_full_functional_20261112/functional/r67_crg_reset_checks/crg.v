/* Machine-generated using Migen */
module actual_crg(
	input adc_p,
	input adc_n,
	input ps_clk,
	input ps_reset,
	output sys_clk,
	output sys_rst,
	output sys_ps_rst
);

wire sys_double_clk;
wire dac_2p_clk;
wire sys_slow_clk;
wire sys_ps_clk;
wire clk_adci;
wire clk_adcb;
wire [5:0] clk;
wire clk_fb;
wire clk_fbb;
wire pll_locked_probe;
wire xilinxasyncresetsynchronizerimpl0_rst_meta;
wire xilinxasyncresetsynchronizerimpl1;
wire xilinxasyncresetsynchronizerimpl1_rst_meta;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign sys_ps_clk = ps_clk;
assign xilinxasyncresetsynchronizerimpl1 = (ps_reset | (~pll_locked_probe));

IBUFGDS IBUFGDS(
	.I(adc_p),
	.IB(adc_n),
	.O(clk_adci)
);

BUFG BUFG(
	.I(clk_adci),
	.O(clk_adcb)
);

PLLE2_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKFBOUT_MULT(4'd8),
	.CLKFBOUT_PHASE(0.0),
	.CLKIN1_PERIOD(8.0),
	.CLKOUT0_DIVIDE(2'd2),
	.CLKOUT0_DUTY_CYCLE(0.5),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_DIVIDE(3'd4),
	.CLKOUT1_DUTY_CYCLE(0.5),
	.CLKOUT1_PHASE(0.0),
	.CLKOUT2_DIVIDE(4'd8),
	.CLKOUT2_DUTY_CYCLE(0.5),
	.CLKOUT2_PHASE(0.0),
	.CLKOUT3_DIVIDE(7'd120),
	.CLKOUT3_DUTY_CYCLE(0.5),
	.CLKOUT3_PHASE(0.0),
	.CLKOUT4_DIVIDE(3'd4),
	.CLKOUT4_DUTY_CYCLE(0.5),
	.CLKOUT4_PHASE(-45.0),
	.CLKOUT5_DIVIDE(3'd4),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT5_PHASE(0.0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_BASE (
	.CLKFBIN(clk_fbb),
	.CLKIN1(clk_adcb),
	.PWRDWN(1'd0),
	.RST(ps_reset),
	.CLKFBOUT(clk_fb),
	.CLKOUT0(clk[0]),
	.CLKOUT1(clk[1]),
	.CLKOUT2(clk[2]),
	.CLKOUT3(clk[3]),
	.CLKOUT4(clk[4]),
	.CLKOUT5(clk[5]),
	.LOCKED(pll_locked_probe)
);

BUFG BUFG_1(
	.I(clk_fb),
	.O(clk_fbb)
);

BUFG BUFG_2(
	.I(clk[1]),
	.O(sys_double_clk)
);

BUFG BUFG_3(
	.I(clk[2]),
	.O(sys_clk)
);

BUFG BUFG_4(
	.I(clk[3]),
	.O(sys_slow_clk)
);

BUFG BUFG_5(
	.I(clk[4]),
	.O(dac_2p_clk)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(ps_reset),
	.Q(xilinxasyncresetsynchronizerimpl0_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_1 (
	.C(sys_ps_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl0_rst_meta),
	.PRE(ps_reset),
	.Q(sys_ps_rst)
);

(* ars_ff1 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_2 (
	.C(sys_clk),
	.CE(1'd1),
	.D(1'd0),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(xilinxasyncresetsynchronizerimpl1_rst_meta)
);

(* ars_ff2 = "true", async_reg = "true" *) FDPE #(
	.INIT(1'd1)
) FDPE_3 (
	.C(sys_clk),
	.CE(1'd1),
	.D(xilinxasyncresetsynchronizerimpl1_rst_meta),
	.PRE(xilinxasyncresetsynchronizerimpl1),
	.Q(sys_rst)
);

endmodule
