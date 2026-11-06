`timescale 1ns/1ps
// AXI3 single-beat write-response backpressure regression for Linien.
// Verify one write, BVALID/BRESP/BID holding under BREADY=0,
// and exactly one response handshake when BREADY becomes 1.
// This is a functional test, not a complete AXI3 compliance suite.
module tb_axi_slave_write;

  reg clk = 1'b0;
  always #4 clk = ~clk;  // 125 MHz

  reg rstn = 1'b0;
  reg awvalid = 1'b0;
  reg wvalid = 1'b0;
  reg bready = 1'b0;
  reg sys_ack = 1'b0;

  reg [11:0] awid = 12'h3A5;
  reg [31:0] awaddr = 32'h4000_0020;
  reg [31:0] wdata = 32'h5A3C_1278;

  wire awready, wready, bvalid;
  wire [11:0] bid;
  wire [1:0] bresp;
  wire [31:0] sys_addr, sys_wdata;
  wire [3:0] sys_sel;
  wire sys_wen, sys_ren;

  integer aw_accepted = 0;
  integer w_accepted = 0;
  integer writes_seen = 0;
  integer responses_accepted = 0;

  axi_slave #(
    .AXI_DW(32),
    .AXI_AW(32),
    .AXI_IW(12)
  ) dut (
    .axi_clk_i(clk), .axi_rstn_i(rstn),

    .axi_awid_i(awid), .axi_awaddr_i(awaddr),
    .axi_awlen_i(4'b0), .axi_awsize_i(3'b010),
    .axi_awburst_i(2'b01), .axi_awlock_i(2'b0),
    .axi_awcache_i(4'b0), .axi_awprot_i(3'b0),
    .axi_awvalid_i(awvalid), .axi_awready_o(awready),

    .axi_wid_i(12'h3A5), .axi_wdata_i(wdata),
    .axi_wstrb_i(4'hF), .axi_wlast_i(1'b1),
    .axi_wvalid_i(wvalid), .axi_wready_o(wready),

    .axi_bid_o(bid), .axi_bresp_o(bresp),
    .axi_bvalid_o(bvalid), .axi_bready_i(bready),

    .axi_arid_i(12'b0), .axi_araddr_i(32'b0),
    .axi_arlen_i(4'b0), .axi_arsize_i(3'b010),
    .axi_arburst_i(2'b01), .axi_arlock_i(2'b0),
    .axi_arcache_i(4'b0), .axi_arprot_i(3'b0),
    .axi_arvalid_i(1'b0), .axi_arready_o(),

    .axi_rid_o(), .axi_rdata_o(), .axi_rresp_o(),
    .axi_rlast_o(), .axi_rvalid_o(), .axi_rready_i(1'b1),

    .sys_addr_o(sys_addr), .sys_wdata_o(sys_wdata),
    .sys_sel_o(sys_sel), .sys_wen_o(sys_wen),
    .sys_ren_o(sys_ren),
    .sys_rdata_i(32'b0), .sys_err_i(1'b0),
    .sys_ack_i(sys_ack)
  );

  // Observe events at their actual clock-edge handshakes.
  always @(posedge clk) begin
    if (rstn) begin
      if (awvalid && awready)
        aw_accepted = aw_accepted + 1;
      if (wvalid && wready)
        w_accepted = w_accepted + 1;
      if (sys_wen) begin
        writes_seen = writes_seen + 1;
        if (sys_addr !== 32'h4000_0020 ||
            sys_wdata !== 32'h5A3C_1278 ||
            sys_sel !== 4'hF)
          $fatal(1, "[FAIL] Incorrect system-bus write: addr=%h data=%h sel=%h",
                 sys_addr, sys_wdata, sys_sel);
      end
      if (bvalid && bready)
        responses_accepted = responses_accepted + 1;
      if (sys_ren !== 1'b0)
        $fatal(1, "[FAIL] Unexpected system-bus read request");
    end
  end

  initial begin
    repeat (5) @(negedge clk);
    rstn = 1'b1;

    // AXI3 AW address handshake.
    @(negedge clk);
    awvalid = 1'b1;
    #0.001;
    if (awready !== 1'b1)
      $fatal(1, "[FAIL] AWREADY did not accept the address");
    @(posedge clk);
    @(negedge clk);
    awvalid = 1'b0;

    // AXI3 W data handshake in a later cycle.
    @(negedge clk);
    wvalid = 1'b1;
    #0.001;
    if (wready !== 1'b1)
      $fatal(1, "[FAIL] WREADY did not accept the write data");
    @(posedge clk);
    @(negedge clk);
    wvalid = 1'b0;

    // Allow the internal registered system-bus write to be observed.
    repeat (2) @(negedge clk);
    if (writes_seen !== 1)
      $fatal(1, "[FAIL] Expected one system-bus write, got %0d", writes_seen);

    // One-cycle acknowledgment from the downstream register bus.
    sys_ack = 1'b1;
    @(posedge clk);
    #0.001;
    if (bvalid !== 1'b1 || bresp !== 2'b00 || bid !== 12'h3A5)
      $fatal(1, "[FAIL] Initial AXI write response: BVALID=%b BRESP=%b BID=%h",
             bvalid, bresp, bid);
    $display("[PASS] Initial write response: BVALID=1 BRESP=%b BID=%h", bresp, bid);

    @(negedge clk);
    sys_ack = 1'b0;
    // Change incoming values; a pending response must not change.
    awid = 12'h678;
    awaddr = 32'h4000_0990;
    wdata = 32'hDEAD_BEEF;

    repeat (4) begin
      @(posedge clk);
      #0.001;
      if (bvalid !== 1'b1)
        $fatal(1, "[FAIL] AXI BVALID dropped while BREADY=0");
      if (bresp !== 2'b00 || bid !== 12'h3A5)
        $fatal(1, "[FAIL] AXI BRESP/BID changed during backpressure: BRESP=%b BID=%h",
               bresp, bid);
    end

    if (responses_accepted !== 0)
      $fatal(1, "[FAIL] Response accepted before BREADY");

    // Complete the AXI write response handshake.
    @(negedge clk);
    bready = 1'b1;
    @(posedge clk);
    #0.001;
    if (bvalid !== 1'b0)
      $fatal(1, "[FAIL] AXI BVALID did not clear after BREADY handshake");

    repeat (2) begin
      @(posedge clk);
      #0.001;
      if (bvalid !== 1'b0)
        $fatal(1, "[FAIL] Unexpected repeated AXI write response");
    end

    if (aw_accepted !== 1 || w_accepted !== 1 ||
        writes_seen !== 1 || responses_accepted !== 1)
      $fatal(1,
        "[FAIL] Transaction counts: AW=%0d W=%0d sys_write=%0d B=%0d",
        aw_accepted, w_accepted, writes_seen, responses_accepted);

    $display("AXI_WRITE_BACKPRESSURE_TEST_PASS");
    $finish;
  end

  initial begin
    #3000;
    $fatal(1, "[FAIL] AXI write test global timeout");
  end
endmodule
