`timescale 1ns/1ps
// AXI3 read-response backpressure regression for Linien/Red Pitaya axi_slave.
// Deliberately holds RREADY low after RVALID to check AXI requirements.
// A failure indicates a protocol issue to investigate, not a syntax error.
module tb_axi_slave_read;

  reg clk = 1'b0;
  always #4 clk = ~clk;  // 125 MHz

  reg rstn = 1'b0;
  reg arvalid = 1'b0;
  reg rready = 1'b0;
  reg sys_ack = 1'b0;
  reg [31:0] sys_rdata = 32'b0;

  wire arready;
  wire [11:0] rid;
  wire [31:0] rdata;
  wire [1:0] rresp;
  wire rlast, rvalid;
  wire [31:0] sys_addr, sys_wdata;
  wire [3:0] sys_sel;
  wire sys_wen, sys_ren;

  axi_slave #(
    .AXI_DW(32),
    .AXI_AW(32),
    .AXI_IW(12)
  ) dut (
    .axi_clk_i(clk), .axi_rstn_i(rstn),

    .axi_awid_i(12'b0), .axi_awaddr_i(32'b0),
    .axi_awlen_i(4'b0), .axi_awsize_i(3'b010),
    .axi_awburst_i(2'b01), .axi_awlock_i(2'b0),
    .axi_awcache_i(4'b0), .axi_awprot_i(3'b0),
    .axi_awvalid_i(1'b0), .axi_awready_o(),

    .axi_wid_i(12'b0), .axi_wdata_i(32'b0),
    .axi_wstrb_i(4'b0), .axi_wlast_i(1'b1),
    .axi_wvalid_i(1'b0), .axi_wready_o(),

    .axi_bid_o(), .axi_bresp_o(), .axi_bvalid_o(),
    .axi_bready_i(1'b1),

    .axi_arid_i(12'h123), .axi_araddr_i(32'h40000100),
    .axi_arlen_i(4'b0), .axi_arsize_i(3'b010),
    .axi_arburst_i(2'b01), .axi_arlock_i(2'b0),
    .axi_arcache_i(4'b0), .axi_arprot_i(3'b0),
    .axi_arvalid_i(arvalid), .axi_arready_o(arready),

    .axi_rid_o(rid), .axi_rdata_o(rdata),
    .axi_rresp_o(rresp), .axi_rlast_o(rlast),
    .axi_rvalid_o(rvalid), .axi_rready_i(rready),

    .sys_addr_o(sys_addr), .sys_wdata_o(sys_wdata),
    .sys_sel_o(sys_sel), .sys_wen_o(sys_wen),
    .sys_ren_o(sys_ren),
    .sys_rdata_i(sys_rdata), .sys_err_i(1'b0),
    .sys_ack_i(sys_ack)
  );

  initial begin
    repeat (5) @(negedge clk);
    rstn = 1'b1;

    // Present one valid single-beat AXI3 read address.
    @(negedge clk);
    arvalid = 1'b1;
    @(posedge clk);
    if (arready !== 1'b1)
      $fatal(1, "[FAIL] ARREADY did not accept the read request");
    @(negedge clk);
    arvalid = 1'b0;

    // Produce a one-cycle system-bus ACK and known read data.
    repeat (2) @(negedge clk);
    sys_rdata = 32'hA5C3_1234;
    sys_ack = 1'b1;
    @(posedge clk);
    #0.001;
    if (rvalid !== 1'b1 || rdata !== 32'hA5C3_1234)
      $fatal(1, "[FAIL] Initial AXI read response missing/incorrect: RVALID=%b RDATA=%h", rvalid, rdata);
    $display("[PASS] Initial read response: RVALID=1 RDATA=%h", rdata);

    // Stall the AXI master. The response must remain valid and unchanged.
    @(negedge clk);
    sys_ack = 1'b0;
    sys_rdata = 32'hDEAD_BEEF; // test that RDATA holds its response snapshot
    @(posedge clk);
    #0.001;
    if (rvalid !== 1'b1)
      $fatal(1, "[FAIL] AXI RVALID dropped while RREADY=0");
    if (rdata !== 32'hA5C3_1234)
      $fatal(1, "[FAIL] AXI RDATA changed while RVALID=1 and RREADY=0: %h", rdata);

    repeat (3) begin
      @(posedge clk);
      #0.001;
      if (rvalid !== 1'b1 || rdata !== 32'hA5C3_1234)
        $fatal(1, "[FAIL] AXI response not held during backpressure");
    end

   
    // Check the response before accepting it.
    @(negedge clk);

    if (rvalid !== 1'b1 ||
        rdata !== 32'hA5C3_1234 ||
        rid !== 12'h123 ||
        rresp !== 2'b00 ||
        rlast !== 1'b1)
      $fatal(1, "[FAIL] Invalid AXI read response before handshake");

    // Master accepts the response.
    rready = 1'b1;

    @(posedge clk);
    #0.001;

    // No other transaction is pending.
    if (rvalid !== 1'b0 || rlast !== 1'b0)
      $fatal(1, "[FAIL] Read response not cleared after handshake");

    if (arready !== 1'b1)
      $fatal(1, "[FAIL] Read address channel did not return to idle");

    $display("AXI_READ_HANDSHAKE_TEST_PASS");
    $display("AXI_READ_BACKPRESSURE_TEST_PASS");
    $finish;

  end

  initial begin
    #3000;
    $fatal(1, "[FAIL] Global timeout in AXI backpressure test");
  end
endmodule
