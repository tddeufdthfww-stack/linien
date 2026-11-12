//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Thu Nov 12 17:26:15 2026
//Host        : DESKTOP-UPVE1P4 running 64-bit major release  (build 9200)
//Command     : generate_target linien_ps_only.bd
//Design      : linien_ps_only
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "linien_ps_only,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=linien_ps_only,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "linien_ps_only.hwdef" *) 
module linien_ps_only
   (DDR_0_addr,
    DDR_0_ba,
    DDR_0_cas_n,
    DDR_0_ck_n,
    DDR_0_ck_p,
    DDR_0_cke,
    DDR_0_cs_n,
    DDR_0_dm,
    DDR_0_dq,
    DDR_0_dqs_n,
    DDR_0_dqs_p,
    DDR_0_odt,
    DDR_0_ras_n,
    DDR_0_reset_n,
    DDR_0_we_n,
    FCLK_CLK0,
    FCLK_RESET0_N_0,
    FIXED_IO_0_ddr_vrn,
    FIXED_IO_0_ddr_vrp,
    FIXED_IO_0_mio,
    FIXED_IO_0_ps_clk,
    FIXED_IO_0_ps_porb,
    FIXED_IO_0_ps_srstb,
    M_AXI_GP0_0_araddr,
    M_AXI_GP0_0_arburst,
    M_AXI_GP0_0_arcache,
    M_AXI_GP0_0_arid,
    M_AXI_GP0_0_arlen,
    M_AXI_GP0_0_arlock,
    M_AXI_GP0_0_arprot,
    M_AXI_GP0_0_arqos,
    M_AXI_GP0_0_arready,
    M_AXI_GP0_0_arsize,
    M_AXI_GP0_0_arvalid,
    M_AXI_GP0_0_awaddr,
    M_AXI_GP0_0_awburst,
    M_AXI_GP0_0_awcache,
    M_AXI_GP0_0_awid,
    M_AXI_GP0_0_awlen,
    M_AXI_GP0_0_awlock,
    M_AXI_GP0_0_awprot,
    M_AXI_GP0_0_awqos,
    M_AXI_GP0_0_awready,
    M_AXI_GP0_0_awsize,
    M_AXI_GP0_0_awvalid,
    M_AXI_GP0_0_bid,
    M_AXI_GP0_0_bready,
    M_AXI_GP0_0_bresp,
    M_AXI_GP0_0_bvalid,
    M_AXI_GP0_0_rdata,
    M_AXI_GP0_0_rid,
    M_AXI_GP0_0_rlast,
    M_AXI_GP0_0_rready,
    M_AXI_GP0_0_rresp,
    M_AXI_GP0_0_rvalid,
    M_AXI_GP0_0_wdata,
    M_AXI_GP0_0_wid,
    M_AXI_GP0_0_wlast,
    M_AXI_GP0_0_wready,
    M_AXI_GP0_0_wstrb,
    M_AXI_GP0_0_wvalid);
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 ADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DDR_0, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) inout [14:0]DDR_0_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 BA" *) inout [2:0]DDR_0_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CAS_N" *) inout DDR_0_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CK_N" *) inout DDR_0_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CK_P" *) inout DDR_0_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CKE" *) inout DDR_0_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CS_N" *) inout DDR_0_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DM" *) inout [3:0]DDR_0_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQ" *) inout [31:0]DDR_0_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQS_N" *) inout [3:0]DDR_0_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQS_P" *) inout [3:0]DDR_0_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 ODT" *) inout DDR_0_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 RAS_N" *) inout DDR_0_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 RESET_N" *) inout DDR_0_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 WE_N" *) inout DDR_0_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.FCLK_CLK0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.FCLK_CLK0, CLK_DOMAIN linien_ps_only_processing_system7_0_FCLK_CLK0, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) output FCLK_CLK0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.FCLK_RESET0_N_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.FCLK_RESET0_N_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output FCLK_RESET0_N_0;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 DDR_VRN" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME FIXED_IO_0, CAN_DEBUG false" *) inout FIXED_IO_0_ddr_vrn;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 DDR_VRP" *) inout FIXED_IO_0_ddr_vrp;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 MIO" *) inout [53:0]FIXED_IO_0_mio;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_CLK" *) inout FIXED_IO_0_ps_clk;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_PORB" *) inout FIXED_IO_0_ps_porb;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_SRSTB" *) inout FIXED_IO_0_ps_srstb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI_GP0_0, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, DATA_WIDTH 32, FREQ_HZ 125000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 12, INSERT_VIP 0, MAX_BURST_LENGTH 16, NUM_READ_OUTSTANDING 8, NUM_READ_THREADS 4, NUM_WRITE_OUTSTANDING 8, NUM_WRITE_THREADS 4, PHASE 0.000, PROTOCOL AXI3, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) output [31:0]M_AXI_GP0_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARBURST" *) output [1:0]M_AXI_GP0_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARCACHE" *) output [3:0]M_AXI_GP0_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARID" *) output [11:0]M_AXI_GP0_0_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARLEN" *) output [3:0]M_AXI_GP0_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARLOCK" *) output [1:0]M_AXI_GP0_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARPROT" *) output [2:0]M_AXI_GP0_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARQOS" *) output [3:0]M_AXI_GP0_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARREADY" *) input M_AXI_GP0_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARSIZE" *) output [2:0]M_AXI_GP0_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 ARVALID" *) output M_AXI_GP0_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWADDR" *) output [31:0]M_AXI_GP0_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWBURST" *) output [1:0]M_AXI_GP0_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWCACHE" *) output [3:0]M_AXI_GP0_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWID" *) output [11:0]M_AXI_GP0_0_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWLEN" *) output [3:0]M_AXI_GP0_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWLOCK" *) output [1:0]M_AXI_GP0_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWPROT" *) output [2:0]M_AXI_GP0_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWQOS" *) output [3:0]M_AXI_GP0_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWREADY" *) input M_AXI_GP0_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWSIZE" *) output [2:0]M_AXI_GP0_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 AWVALID" *) output M_AXI_GP0_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 BID" *) input [11:0]M_AXI_GP0_0_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 BREADY" *) output M_AXI_GP0_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 BRESP" *) input [1:0]M_AXI_GP0_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 BVALID" *) input M_AXI_GP0_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RDATA" *) input [31:0]M_AXI_GP0_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RID" *) input [11:0]M_AXI_GP0_0_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RLAST" *) input M_AXI_GP0_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RREADY" *) output M_AXI_GP0_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RRESP" *) input [1:0]M_AXI_GP0_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 RVALID" *) input M_AXI_GP0_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WDATA" *) output [31:0]M_AXI_GP0_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WID" *) output [11:0]M_AXI_GP0_0_wid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WLAST" *) output M_AXI_GP0_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WREADY" *) input M_AXI_GP0_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WSTRB" *) output [3:0]M_AXI_GP0_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI_GP0_0 WVALID" *) output M_AXI_GP0_0_wvalid;

  wire [14:0]processing_system7_DDR_ADDR;
  wire [2:0]processing_system7_DDR_BA;
  wire processing_system7_DDR_CAS_N;
  wire processing_system7_DDR_CKE;
  wire processing_system7_DDR_CK_N;
  wire processing_system7_DDR_CK_P;
  wire processing_system7_DDR_CS_N;
  wire [3:0]processing_system7_DDR_DM;
  wire [31:0]processing_system7_DDR_DQ;
  wire [3:0]processing_system7_DDR_DQS_N;
  wire [3:0]processing_system7_DDR_DQS_P;
  wire processing_system7_DDR_ODT;
  wire processing_system7_DDR_RAS_N;
  wire processing_system7_DDR_RESET_N;
  wire processing_system7_DDR_WE_N;
  wire processing_system7_FCLK_CLK0;
  wire processing_system7_FCLK_RESET0_N;
  wire processing_system7_FIXED_IO_DDR_VRN;
  wire processing_system7_FIXED_IO_DDR_VRP;
  wire [53:0]processing_system7_FIXED_IO_MIO;
  wire processing_system7_FIXED_IO_PS_CLK;
  wire processing_system7_FIXED_IO_PS_PORB;
  wire processing_system7_FIXED_IO_PS_SRSTB;
  wire [31:0]processing_system7_M_AXI_GP0_ARADDR;
  wire [1:0]processing_system7_M_AXI_GP0_ARBURST;
  wire [3:0]processing_system7_M_AXI_GP0_ARCACHE;
  wire [11:0]processing_system7_M_AXI_GP0_ARID;
  wire [3:0]processing_system7_M_AXI_GP0_ARLEN;
  wire [1:0]processing_system7_M_AXI_GP0_ARLOCK;
  wire [2:0]processing_system7_M_AXI_GP0_ARPROT;
  wire [3:0]processing_system7_M_AXI_GP0_ARQOS;
  wire processing_system7_M_AXI_GP0_ARREADY;
  wire [2:0]processing_system7_M_AXI_GP0_ARSIZE;
  wire processing_system7_M_AXI_GP0_ARVALID;
  wire [31:0]processing_system7_M_AXI_GP0_AWADDR;
  wire [1:0]processing_system7_M_AXI_GP0_AWBURST;
  wire [3:0]processing_system7_M_AXI_GP0_AWCACHE;
  wire [11:0]processing_system7_M_AXI_GP0_AWID;
  wire [3:0]processing_system7_M_AXI_GP0_AWLEN;
  wire [1:0]processing_system7_M_AXI_GP0_AWLOCK;
  wire [2:0]processing_system7_M_AXI_GP0_AWPROT;
  wire [3:0]processing_system7_M_AXI_GP0_AWQOS;
  wire processing_system7_M_AXI_GP0_AWREADY;
  wire [2:0]processing_system7_M_AXI_GP0_AWSIZE;
  wire processing_system7_M_AXI_GP0_AWVALID;
  wire [11:0]processing_system7_M_AXI_GP0_BID;
  wire processing_system7_M_AXI_GP0_BREADY;
  wire [1:0]processing_system7_M_AXI_GP0_BRESP;
  wire processing_system7_M_AXI_GP0_BVALID;
  wire [31:0]processing_system7_M_AXI_GP0_RDATA;
  wire [11:0]processing_system7_M_AXI_GP0_RID;
  wire processing_system7_M_AXI_GP0_RLAST;
  wire processing_system7_M_AXI_GP0_RREADY;
  wire [1:0]processing_system7_M_AXI_GP0_RRESP;
  wire processing_system7_M_AXI_GP0_RVALID;
  wire [31:0]processing_system7_M_AXI_GP0_WDATA;
  wire [11:0]processing_system7_M_AXI_GP0_WID;
  wire processing_system7_M_AXI_GP0_WLAST;
  wire processing_system7_M_AXI_GP0_WREADY;
  wire [3:0]processing_system7_M_AXI_GP0_WSTRB;
  wire processing_system7_M_AXI_GP0_WVALID;
  wire [0:0]spi0_ss_high_dout;

  assign FCLK_CLK0 = processing_system7_FCLK_CLK0;
  assign FCLK_RESET0_N_0 = processing_system7_FCLK_RESET0_N;
  assign M_AXI_GP0_0_araddr[31:0] = processing_system7_M_AXI_GP0_ARADDR;
  assign M_AXI_GP0_0_arburst[1:0] = processing_system7_M_AXI_GP0_ARBURST;
  assign M_AXI_GP0_0_arcache[3:0] = processing_system7_M_AXI_GP0_ARCACHE;
  assign M_AXI_GP0_0_arid[11:0] = processing_system7_M_AXI_GP0_ARID;
  assign M_AXI_GP0_0_arlen[3:0] = processing_system7_M_AXI_GP0_ARLEN;
  assign M_AXI_GP0_0_arlock[1:0] = processing_system7_M_AXI_GP0_ARLOCK;
  assign M_AXI_GP0_0_arprot[2:0] = processing_system7_M_AXI_GP0_ARPROT;
  assign M_AXI_GP0_0_arqos[3:0] = processing_system7_M_AXI_GP0_ARQOS;
  assign M_AXI_GP0_0_arsize[2:0] = processing_system7_M_AXI_GP0_ARSIZE;
  assign M_AXI_GP0_0_arvalid = processing_system7_M_AXI_GP0_ARVALID;
  assign M_AXI_GP0_0_awaddr[31:0] = processing_system7_M_AXI_GP0_AWADDR;
  assign M_AXI_GP0_0_awburst[1:0] = processing_system7_M_AXI_GP0_AWBURST;
  assign M_AXI_GP0_0_awcache[3:0] = processing_system7_M_AXI_GP0_AWCACHE;
  assign M_AXI_GP0_0_awid[11:0] = processing_system7_M_AXI_GP0_AWID;
  assign M_AXI_GP0_0_awlen[3:0] = processing_system7_M_AXI_GP0_AWLEN;
  assign M_AXI_GP0_0_awlock[1:0] = processing_system7_M_AXI_GP0_AWLOCK;
  assign M_AXI_GP0_0_awprot[2:0] = processing_system7_M_AXI_GP0_AWPROT;
  assign M_AXI_GP0_0_awqos[3:0] = processing_system7_M_AXI_GP0_AWQOS;
  assign M_AXI_GP0_0_awsize[2:0] = processing_system7_M_AXI_GP0_AWSIZE;
  assign M_AXI_GP0_0_awvalid = processing_system7_M_AXI_GP0_AWVALID;
  assign M_AXI_GP0_0_bready = processing_system7_M_AXI_GP0_BREADY;
  assign M_AXI_GP0_0_rready = processing_system7_M_AXI_GP0_RREADY;
  assign M_AXI_GP0_0_wdata[31:0] = processing_system7_M_AXI_GP0_WDATA;
  assign M_AXI_GP0_0_wid[11:0] = processing_system7_M_AXI_GP0_WID;
  assign M_AXI_GP0_0_wlast = processing_system7_M_AXI_GP0_WLAST;
  assign M_AXI_GP0_0_wstrb[3:0] = processing_system7_M_AXI_GP0_WSTRB;
  assign M_AXI_GP0_0_wvalid = processing_system7_M_AXI_GP0_WVALID;
  assign processing_system7_M_AXI_GP0_ARREADY = M_AXI_GP0_0_arready;
  assign processing_system7_M_AXI_GP0_AWREADY = M_AXI_GP0_0_awready;
  assign processing_system7_M_AXI_GP0_BID = M_AXI_GP0_0_bid[11:0];
  assign processing_system7_M_AXI_GP0_BRESP = M_AXI_GP0_0_bresp[1:0];
  assign processing_system7_M_AXI_GP0_BVALID = M_AXI_GP0_0_bvalid;
  assign processing_system7_M_AXI_GP0_RDATA = M_AXI_GP0_0_rdata[31:0];
  assign processing_system7_M_AXI_GP0_RID = M_AXI_GP0_0_rid[11:0];
  assign processing_system7_M_AXI_GP0_RLAST = M_AXI_GP0_0_rlast;
  assign processing_system7_M_AXI_GP0_RRESP = M_AXI_GP0_0_rresp[1:0];
  assign processing_system7_M_AXI_GP0_RVALID = M_AXI_GP0_0_rvalid;
  assign processing_system7_M_AXI_GP0_WREADY = M_AXI_GP0_0_wready;
  linien_ps_only_processing_system7_0 processing_system7
       (.CAN0_PHY_RX(1'b0),
        .CAN1_PHY_RX(1'b0),
        .DDR_Addr(DDR_0_addr[14:0]),
        .DDR_BankAddr(DDR_0_ba[2:0]),
        .DDR_CAS_n(DDR_0_cas_n),
        .DDR_CKE(DDR_0_cke),
        .DDR_CS_n(DDR_0_cs_n),
        .DDR_Clk(DDR_0_ck_p),
        .DDR_Clk_n(DDR_0_ck_n),
        .DDR_DM(DDR_0_dm[3:0]),
        .DDR_DQ(DDR_0_dq[31:0]),
        .DDR_DQS(DDR_0_dqs_p[3:0]),
        .DDR_DQS_n(DDR_0_dqs_n[3:0]),
        .DDR_DRSTB(DDR_0_reset_n),
        .DDR_ODT(DDR_0_odt),
        .DDR_RAS_n(DDR_0_ras_n),
        .DDR_VRN(FIXED_IO_0_ddr_vrn),
        .DDR_VRP(FIXED_IO_0_ddr_vrp),
        .DDR_WEB(DDR_0_we_n),
        .FCLK_CLK0(processing_system7_FCLK_CLK0),
        .FCLK_RESET0_N(processing_system7_FCLK_RESET0_N),
        .GPIO_I({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .IRQ_F2P(1'b0),
        .MIO(FIXED_IO_0_mio[53:0]),
        .M_AXI_GP0_ACLK(processing_system7_FCLK_CLK0),
        .M_AXI_GP0_ARADDR(processing_system7_M_AXI_GP0_ARADDR),
        .M_AXI_GP0_ARBURST(processing_system7_M_AXI_GP0_ARBURST),
        .M_AXI_GP0_ARCACHE(processing_system7_M_AXI_GP0_ARCACHE),
        .M_AXI_GP0_ARID(processing_system7_M_AXI_GP0_ARID),
        .M_AXI_GP0_ARLEN(processing_system7_M_AXI_GP0_ARLEN),
        .M_AXI_GP0_ARLOCK(processing_system7_M_AXI_GP0_ARLOCK),
        .M_AXI_GP0_ARPROT(processing_system7_M_AXI_GP0_ARPROT),
        .M_AXI_GP0_ARQOS(processing_system7_M_AXI_GP0_ARQOS),
        .M_AXI_GP0_ARREADY(processing_system7_M_AXI_GP0_ARREADY),
        .M_AXI_GP0_ARSIZE(processing_system7_M_AXI_GP0_ARSIZE),
        .M_AXI_GP0_ARVALID(processing_system7_M_AXI_GP0_ARVALID),
        .M_AXI_GP0_AWADDR(processing_system7_M_AXI_GP0_AWADDR),
        .M_AXI_GP0_AWBURST(processing_system7_M_AXI_GP0_AWBURST),
        .M_AXI_GP0_AWCACHE(processing_system7_M_AXI_GP0_AWCACHE),
        .M_AXI_GP0_AWID(processing_system7_M_AXI_GP0_AWID),
        .M_AXI_GP0_AWLEN(processing_system7_M_AXI_GP0_AWLEN),
        .M_AXI_GP0_AWLOCK(processing_system7_M_AXI_GP0_AWLOCK),
        .M_AXI_GP0_AWPROT(processing_system7_M_AXI_GP0_AWPROT),
        .M_AXI_GP0_AWQOS(processing_system7_M_AXI_GP0_AWQOS),
        .M_AXI_GP0_AWREADY(processing_system7_M_AXI_GP0_AWREADY),
        .M_AXI_GP0_AWSIZE(processing_system7_M_AXI_GP0_AWSIZE),
        .M_AXI_GP0_AWVALID(processing_system7_M_AXI_GP0_AWVALID),
        .M_AXI_GP0_BID(processing_system7_M_AXI_GP0_BID),
        .M_AXI_GP0_BREADY(processing_system7_M_AXI_GP0_BREADY),
        .M_AXI_GP0_BRESP(processing_system7_M_AXI_GP0_BRESP),
        .M_AXI_GP0_BVALID(processing_system7_M_AXI_GP0_BVALID),
        .M_AXI_GP0_RDATA(processing_system7_M_AXI_GP0_RDATA),
        .M_AXI_GP0_RID(processing_system7_M_AXI_GP0_RID),
        .M_AXI_GP0_RLAST(processing_system7_M_AXI_GP0_RLAST),
        .M_AXI_GP0_RREADY(processing_system7_M_AXI_GP0_RREADY),
        .M_AXI_GP0_RRESP(processing_system7_M_AXI_GP0_RRESP),
        .M_AXI_GP0_RVALID(processing_system7_M_AXI_GP0_RVALID),
        .M_AXI_GP0_WDATA(processing_system7_M_AXI_GP0_WDATA),
        .M_AXI_GP0_WID(processing_system7_M_AXI_GP0_WID),
        .M_AXI_GP0_WLAST(processing_system7_M_AXI_GP0_WLAST),
        .M_AXI_GP0_WREADY(processing_system7_M_AXI_GP0_WREADY),
        .M_AXI_GP0_WSTRB(processing_system7_M_AXI_GP0_WSTRB),
        .M_AXI_GP0_WVALID(processing_system7_M_AXI_GP0_WVALID),
        .PS_CLK(FIXED_IO_0_ps_clk),
        .PS_PORB(FIXED_IO_0_ps_porb),
        .PS_SRSTB(FIXED_IO_0_ps_srstb),
        .SPI0_MISO_I(1'b0),
        .SPI0_MOSI_I(1'b0),
        .SPI0_SCLK_I(1'b0),
        .SPI0_SS_I(spi0_ss_high_dout),
        .USB0_VBUS_PWRFAULT(1'b0));
  linien_ps_only_spi0_ss_high_0 spi0_ss_high
       (.dout(spi0_ss_high_dout));
endmodule
