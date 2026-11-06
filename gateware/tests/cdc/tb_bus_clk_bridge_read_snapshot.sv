`timescale 1ns/1ps
// Directed bundled-data CDC regression for bus_clk_bridge.
// The destination read data/error change immediately AFTER the ACK is
// sampled in the destination clock domain.  The source must still receive
// the response value that was valid at that ACK edge.
// Functional RTL simulation does not model metastability.
module tb_bus_clk_bridge_read_snapshot;
  reg sys_clk = 1'b0;
  reg dst_clk = 1'b0;
  always #4 sys_clk = ~sys_clk;  // 125 MHz
  initial begin
    #1.250;
    forever #4 dst_clk = ~dst_clk;  // 125 MHz, 1.25 ns phase offset
  end

  reg sys_rstn = 1'b0;
  reg dst_rstn = 1'b0;
  reg [31:0] sys_addr = 0;
  reg [31:0] sys_wdata = 0;
  reg sys_ren = 1'b0;
  reg sys_wen = 1'b0;
  wire [31:0] sys_rdata;
  wire sys_err, sys_ack;
  wire [31:0] dst_addr, dst_wdata;
  wire dst_ren, dst_wen;
  reg [31:0] dst_rdata = 0;
  reg dst_err = 0;
  reg dst_ack = 0;
  integer replies = 0;

  bus_clk_bridge dut (
    .sys_clk_i(sys_clk), .sys_rstn_i(sys_rstn),
    .sys_addr_i(sys_addr), .sys_wdata_i(sys_wdata),
    .sys_sel_i(4'hF), .sys_wen_i(sys_wen), .sys_ren_i(sys_ren),
    .sys_rdata_o(sys_rdata), .sys_err_o(sys_err), .sys_ack_o(sys_ack),
    .clk_i(dst_clk), .rstn_i(dst_rstn),
    .addr_o(dst_addr), .wdata_o(dst_wdata),
    .wen_o(dst_wen), .ren_o(dst_ren),
    .rdata_i(dst_rdata), .err_i(dst_err), .ack_i(dst_ack)
  );

  // Emulate a peripheral with registered ACK; invalidate its output on
  // the very next destination-clock edge (the bridge's ACK sampling edge).
  // This is legal for a peripheral: data is valid at ACK sampling.
  always @(posedge dst_clk) begin
    if (!dst_rstn) begin
      dst_ack <= 1'b0;
      dst_rdata <= 32'h0;
      dst_err <= 1'b0;
      replies <= 0;
    end else begin
      dst_ack <= 1'b0;
      if (dst_ren) begin
        if (dst_wen)
          $fatal(1, "[FAIL] Unexpected destination write");
        if (dst_addr !== (32'h4000_0000 + 4*replies))
          $fatal(1, "[FAIL] Wrong destination address: %h", dst_addr);
        if (replies == 0) begin
          dst_rdata <= 32'h1357_A5C3;
          dst_err <= 1'b1;
        end else if (replies == 1) begin
          dst_rdata <= 32'h2468_BDF0;
          dst_err <= 1'b0;
        end else begin
          $fatal(1, "[FAIL] Unexpected third destination request");
        end
        dst_ack <= 1'b1;
        replies <= replies + 1;
      end else if (dst_ack) begin
        // At this edge, DUT reads the previous rdata/err while ACK=1.
        // The peripheral now overwrites both signals by nonblocking assign.
        dst_rdata <= 32'hDEAD_BEEF;
        dst_err <= ~dst_err;
      end
    end
  end

  task automatic read_and_check(
    input [31:0] address,
    input [31:0] expected_data,
    input expected_err
  );
    integer n;
    begin
      @(negedge sys_clk);
      sys_addr = address;
      sys_ren = 1'b1;
      @(posedge sys_clk);
      @(negedge sys_clk);
      sys_ren = 1'b0;

      n = 0;
      while (sys_ack !== 1'b1 && n < 80) begin
        @(negedge sys_clk);
        n = n + 1;
      end
      if (sys_ack !== 1'b1)
        $fatal(1, "[FAIL] Timed out waiting for source ACK");
      #0.001;
      if (sys_rdata !== expected_data || sys_err !== expected_err)
        $fatal(1,
          "[FAIL] Source sampled wrong value: expected %h/%b got %h/%b",
          expected_data, expected_err, sys_rdata, sys_err);
      @(posedge sys_clk);
      #0.001;
      repeat (3) @(negedge sys_clk);
      if (sys_rdata !== expected_data || sys_err !== expected_err)
        $fatal(1, "[FAIL] Returned data/error did not remain stable");
      $display("[PASS] Read snapshot addr=%h data=%h err=%b",
        address, expected_data, expected_err);
    end
  endtask

  initial begin
    repeat (6) @(negedge sys_clk);
    sys_rstn = 1'b1;
    dst_rstn = 1'b1;
    repeat (4) @(negedge sys_clk);
    read_and_check(32'h4000_0000, 32'h1357_A5C3, 1'b1);
    read_and_check(32'h4000_0004, 32'h2468_BDF0, 1'b0);
    if (replies !== 2)
      $fatal(1, "[FAIL] Expected 2 destination reads, got %0d", replies);
    $display("BUS_CLK_BRIDGE_READ_SNAPSHOT_TEST_PASS");
    $finish;
  end

  initial begin
    #10000;
    $fatal(1, "[FAIL] Read snapshot test timeout");
  end
endmodule
