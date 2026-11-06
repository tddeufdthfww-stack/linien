`timescale 1ns/1ps
// AXI3 -> bus_clk_bridge -> destination-register integration regression.
// Single-beat, serialized read/write transactions with AXI backpressure.
// Does not model metastability or certify full AXI3 protocol compliance.
module tb_axi_bridge_integration;

  reg sys_clk = 1'b0;
  reg dst_clk = 1'b0;
  always #4 sys_clk = ~sys_clk;                  // 125 MHz PS clock
  initial begin
    #1.25;
    forever #4 dst_clk = ~dst_clk;              // 125 MHz, offset by 1.25 ns
  end

  reg sys_rstn = 1'b0;
  reg dst_rstn = 1'b0;
  reg [11:0] awid = 12'h101, wid = 12'h101, arid = 12'h201;
  reg [31:0] awaddr = 0, araddr = 0, wdata = 0;
  reg awvalid = 0, wvalid = 0, arvalid = 0;
  reg bready = 0, rready = 0;

  wire awready, wready, arready, bvalid, rvalid, rlast;
  wire [11:0] bid, rid;
  wire [1:0] bresp, rresp;
  wire [31:0] rdata;

  wire [31:0] sys_addr, sys_wdata, sys_rdata;
  wire [3:0] sys_sel;
  wire sys_wen, sys_ren, sys_ack, sys_err;
  wire [31:0] dst_addr, dst_wdata;
  wire dst_wen, dst_ren;
  reg [31:0] dst_rdata = 0;
  reg dst_ack = 0;
  reg dst_err = 0;

  integer writes_seen = 0, reads_seen = 0;
  integer b_handshakes = 0, r_handshakes = 0;
  integer aw_handshakes = 0, w_handshakes = 0, ar_handshakes = 0;
  reg [31:0] bank [0:7];
  integer k;

  axi_slave #(.AXI_DW(32), .AXI_AW(32), .AXI_IW(12)) axi (
    .axi_clk_i(sys_clk), .axi_rstn_i(sys_rstn),
    .axi_awid_i(awid), .axi_awaddr_i(awaddr),
    .axi_awlen_i(4'd0), .axi_awsize_i(3'b010),
    .axi_awburst_i(2'b01), .axi_awlock_i(2'b00),
    .axi_awcache_i(4'b0), .axi_awprot_i(3'b0),
    .axi_awvalid_i(awvalid), .axi_awready_o(awready),
    .axi_wid_i(wid), .axi_wdata_i(wdata),
    .axi_wstrb_i(4'hF), .axi_wlast_i(1'b1),
    .axi_wvalid_i(wvalid), .axi_wready_o(wready),
    .axi_bid_o(bid), .axi_bresp_o(bresp),
    .axi_bvalid_o(bvalid), .axi_bready_i(bready),
    .axi_arid_i(arid), .axi_araddr_i(araddr),
    .axi_arlen_i(4'd0), .axi_arsize_i(3'b010),
    .axi_arburst_i(2'b01), .axi_arlock_i(2'b00),
    .axi_arcache_i(4'b0), .axi_arprot_i(3'b0),
    .axi_arvalid_i(arvalid), .axi_arready_o(arready),
    .axi_rid_o(rid), .axi_rdata_o(rdata),
    .axi_rresp_o(rresp), .axi_rlast_o(rlast),
    .axi_rvalid_o(rvalid), .axi_rready_i(rready),
    .sys_addr_o(sys_addr), .sys_wdata_o(sys_wdata),
    .sys_sel_o(sys_sel), .sys_wen_o(sys_wen),
    .sys_ren_o(sys_ren), .sys_rdata_i(sys_rdata),
    .sys_err_i(sys_err), .sys_ack_i(sys_ack)
  );

  bus_clk_bridge bridge (
    .sys_clk_i(sys_clk), .sys_rstn_i(sys_rstn),
    .sys_addr_i(sys_addr), .sys_wdata_i(sys_wdata),
    .sys_sel_i(sys_sel), .sys_wen_i(sys_wen),
    .sys_ren_i(sys_ren), .sys_rdata_o(sys_rdata),
    .sys_err_o(sys_err), .sys_ack_o(sys_ack),
    .clk_i(dst_clk), .rstn_i(dst_rstn),
    .addr_o(dst_addr), .wdata_o(dst_wdata),
    .wen_o(dst_wen), .ren_o(dst_ren),
    .rdata_i(dst_rdata), .err_i(dst_err), .ack_i(dst_ack)
  );

  // One-cycle delayed ACK and stable registered read data at destination.
  always @(posedge dst_clk) begin
    if (!dst_rstn) begin
      dst_ack <= 1'b0;
      dst_rdata <= 0;
      writes_seen <= 0;
      reads_seen <= 0;
      for (k = 0; k < 8; k = k + 1)
        bank[k] <= 0;
    end else begin
      dst_ack <= dst_wen || dst_ren;
      if (dst_wen) begin
        if (dst_addr[31:5] !== 27'h2000000)
          $fatal(1, "[FAIL] Unexpected destination write address %h", dst_addr);
        bank[dst_addr[4:2]] <= dst_wdata;
        writes_seen <= writes_seen + 1;
      end
      if (dst_ren) begin
        if (dst_addr[31:5] !== 27'h2000000)
          $fatal(1, "[FAIL] Unexpected destination read address %h", dst_addr);
        dst_rdata <= bank[dst_addr[4:2]];
        reads_seen <= reads_seen + 1;
      end
    end
  end

  // Count AXI clock-edge handshakes rather than signal transitions.
  always @(posedge sys_clk) begin
    if (sys_rstn) begin
      if (awvalid && awready) aw_handshakes = aw_handshakes + 1;
      if (wvalid && wready) w_handshakes = w_handshakes + 1;
      if (arvalid && arready) ar_handshakes = ar_handshakes + 1;
      if (bvalid && bready) b_handshakes = b_handshakes + 1;
      if (rvalid && rready) r_handshakes = r_handshakes + 1;
    end
  end

  task automatic write_word(input [31:0] address,
                            input [31:0] value,
                            input [11:0] id);
    integer n;
    begin
      // Address handshake (AXI3 AW channel).
      @(negedge sys_clk);
      awaddr = address;
      awid = id;
      wid = id;
      awvalid = 1'b1;
      #0.001;
      if (awready !== 1'b1)
        $fatal(1, "[FAIL] AWREADY low for address %h", address);
      @(posedge sys_clk);
      @(negedge sys_clk);
      awvalid = 1'b0;

      // Data handshake (AXI3 W channel).
      wdata = value;
      wvalid = 1'b1;
      #0.001;
      if (wready !== 1'b1)
        $fatal(1, "[FAIL] WREADY low for address %h", address);
      @(posedge sys_clk);
      @(negedge sys_clk);
      wvalid = 1'b0;

      // Hold BREADY low to test AXI response backpressure.
      while (bvalid !== 1'b1) @(negedge sys_clk);
      for (n = 0; n < 3; n = n + 1) begin
        @(posedge sys_clk);
        #0.001;
        if (bvalid !== 1'b1 || bresp !== 2'b00 || bid !== id)
          $fatal(1, "[FAIL] Write response changed during stall");
      end
      @(negedge sys_clk);
      bready = 1'b1;
      @(posedge sys_clk);
      #0.001;
      if (bvalid !== 1'b0)
        $fatal(1, "[FAIL] BVALID not cleared after handshake");
      @(negedge sys_clk);
      bready = 1'b0;
      $display("[PASS] Integrated write addr=%h data=%h", address, value);
    end
  endtask

  task automatic read_word(input [31:0] address,
                           input [31:0] expected,
                           input [11:0] id);
    integer n;
    begin
      @(negedge sys_clk);
      araddr = address;
      arid = id;
      arvalid = 1'b1;
      #0.001;
      if (arready !== 1'b1)
        $fatal(1, "[FAIL] ARREADY low for address %h", address);
      @(posedge sys_clk);
      @(negedge sys_clk);
      arvalid = 1'b0;

      // Hold RREADY low; both data and response must remain stable.
      while (rvalid !== 1'b1) @(negedge sys_clk);
      for (n = 0; n < 3; n = n + 1) begin
        @(posedge sys_clk);
        #0.001;
        if (rvalid !== 1'b1 || rdata !== expected ||
            rid !== id || rresp !== 2'b00 || rlast !== 1'b1)
          $fatal(1,
            "[FAIL] Read response addr=%h expected=%h received=%h",
            address, expected, rdata);
      end
      @(negedge sys_clk);
      rready = 1'b1;
      @(posedge sys_clk);
      #0.001;
      if (rvalid !== 1'b0 || rlast !== 1'b0)
        $fatal(1, "[FAIL] RVALID/RLAST not cleared after handshake");
      @(negedge sys_clk);
      rready = 1'b0;
      $display("[PASS] Integrated read addr=%h data=%h", address, expected);
    end
  endtask

  integer i;
  initial begin
    repeat (6) @(negedge sys_clk);
    sys_rstn = 1'b1;
    dst_rstn = 1'b1;
    repeat (4) @(negedge sys_clk);

    for (i = 0; i < 4; i = i + 1) begin
      write_word(32'h4000_0000 + 4*i, 32'h1357_0000 + i, 12'h101 + i);
      read_word (32'h4000_0000 + 4*i, 32'h1357_0000 + i, 12'h201 + i);
    end

    if (writes_seen !== 4 || reads_seen !== 4 ||
        aw_handshakes !== 4 || w_handshakes !== 4 ||
        ar_handshakes !== 4 || b_handshakes !== 4 ||
        r_handshakes !== 4)
      $fatal(1,
        "[FAIL] Counts: dstW=%0d dstR=%0d AW=%0d W=%0d AR=%0d B=%0d R=%0d",
        writes_seen, reads_seen, aw_handshakes, w_handshakes,
        ar_handshakes, b_handshakes, r_handshakes);



    $display("AXI_BRIDGE_INTEGRATION_TEST_PASS: 4 writes + 4 reads");

    // Reset both clock domains after normal transactions.
    @(negedge sys_clk);
    sys_rstn = 1'b0;
    dst_rstn = 1'b0;

    repeat (6) @(negedge sys_clk);

    // Check reset state.
    if (bvalid !== 1'b0 || rvalid !== 1'b0)
      $fatal(1, "[FAIL] AXI response not cleared by reset");

    if (writes_seen !== 0 ||
        reads_seen !== 0 ||
        bank[4] !== 32'h00000000)
      $fatal(1, "[FAIL] Destination reset state incorrect");

    // Release reset.
    sys_rstn = 1'b1;
    dst_rstn = 1'b1;

    repeat (4) @(negedge sys_clk);

    // Write and read again after reset.
    write_word(32'h4000_0010, 32'hABCD_1234, 12'h105);
    read_word (32'h4000_0010, 32'hABCD_1234, 12'h205);

    // Destination counters reset; testbench AXI counters accumulate.
    if (writes_seen !== 1 ||
        reads_seen !== 1 ||
        aw_handshakes !== 5 ||
        w_handshakes !== 5 ||
        ar_handshakes !== 5 ||
        b_handshakes !== 5 ||
        r_handshakes !== 5)
      $fatal(1, "[FAIL] Reset recovery count mismatch");

    $display("AXI_BRIDGE_RESET_RECOVERY_TEST_PASS");
    $finish;

  end

  initial begin
    #100000;
    $fatal(1, "[FAIL] Integrated test timeout");
  end
endmodule
