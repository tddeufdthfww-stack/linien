`timescale 1ns/1ps
// CDC functional test for Linien bus_clk_bridge.
// This checks a stable/readable destination register interface. It does NOT
// prove metastability immunity, safe payload CDC, or AXI-level correctness.
module tb_bus_clk_bridge;

  reg sys_clk = 0;
  reg dst_clk = 0;

  // PS clock: 125 MHz
  always #4 sys_clk = ~sys_clk;

  // ADC-derived clock: 125 MHz, configurable phase offset
  // PHASE_PS is expressed in picoseconds.
  integer phase_ps = 1250;

  initial begin
    if ($value$plusargs("PHASE_PS=%d", phase_ps))
      $display("[CONFIG] PHASE_PS=%0d", phase_ps);

    if (phase_ps < 0 || phase_ps >= 8000)
      $fatal(1, "Invalid phase offset: %0d ps", phase_ps);

    #(phase_ps / 1000.0);
    forever #4 dst_clk = ~dst_clk;
  end

  // Verify clock periods and phase offset
  realtime sys_t0, sys_t1;
  realtime dst_t0, dst_t1;

  initial begin
    fork
      begin
        @(posedge sys_clk);
        sys_t0 = $realtime;
        @(posedge sys_clk);
        sys_t1 = $realtime;
      end
      begin
        @(posedge dst_clk);
        dst_t0 = $realtime;
        @(posedge dst_clk);
        dst_t1 = $realtime;
      end
    join

    $display("[CLOCK] SYS period = %0.3f ns",
             sys_t1 - sys_t0);
    $display("[CLOCK] DST period = %0.3f ns",
             dst_t1 - dst_t0);
    $display("[CLOCK] Phase offset = %0.3f ns",
             dst_t0 - sys_t0);

    // Compare integer picoseconds, not exact binary floating-point equality.
    // Non-binary fractions such as 1 ps otherwise spuriously fail at 1 ps precision.
    if ($rtoi((sys_t1 - sys_t0) * 1000.0 + 0.5) != 8000 ||
        $rtoi((dst_t1 - dst_t0) * 1000.0 + 0.5) != 8000 ||
        $rtoi((dst_t0 - sys_t0) * 1000.0 + 0.5) != phase_ps)
      $fatal(1, "Clock configuration mismatch");
  end

  reg sys_rstn = 0;
  reg dst_rstn = 0;
  reg [31:0] sys_addr = 0, sys_wdata = 0;
  reg [3:0] sys_sel = 4'hF;
  reg sys_wen = 0, sys_ren = 0;
  wire [31:0] sys_rdata;
  wire sys_err, sys_ack;

  wire [31:0] dst_addr, dst_wdata;
  wire dst_wen, dst_ren;
  reg [31:0] dst_rdata = 0;
  reg dst_ack = 0;  // ACK is initially inactive
  reg dst_err = 0;
  integer writes_seen = 0, reads_seen = 0, errors = 0;
  integer ack_pulses_seen = 0;
  reg [31:0] last_waddr = 0, last_wdata = 0;

  bus_clk_bridge dut (
    .sys_clk_i(sys_clk), .sys_rstn_i(sys_rstn),
    .sys_addr_i(sys_addr), .sys_wdata_i(sys_wdata),
    .sys_sel_i(sys_sel), .sys_wen_i(sys_wen), .sys_ren_i(sys_ren),
    .sys_rdata_o(sys_rdata), .sys_err_o(sys_err), .sys_ack_o(sys_ack),
    .clk_i(dst_clk), .rstn_i(dst_rstn),
    .addr_o(dst_addr), .wdata_o(dst_wdata),
    .wen_o(dst_wen), .ren_o(dst_ren),
    .rdata_i(dst_rdata), .err_i(dst_err), .ack_i(dst_ack)
  );
 
  // Check bundled-data stability during a CDC transaction.
  reg payload_pending = 0;
  reg previous_request_toggle = 0;

  reg [31:0] held_addr = 0;
  reg [31:0] held_wdata = 0;
  reg held_rd = 0;
  reg held_wr = 0;

  // Observe source-domain request launches.
  always @(negedge sys_clk) begin
    if (!sys_rstn || !dst_rstn) begin
      payload_pending = 0;
      previous_request_toggle = dut.sys_do;
    end else begin

    if (dut.sys_do !== previous_request_toggle) begin
        if (payload_pending)
          $fatal(1, "[FAIL] New request before previous completion");

        payload_pending = 1;
        held_addr = dst_addr;
        held_wdata = dst_wdata;
        held_rd = dut.sys_rd;
        held_wr = dut.sys_wr;
    end

    previous_request_toggle = dut.sys_do;

    if (payload_pending) begin
        if ((dst_addr !== held_addr) ||
            (dst_wdata !== held_wdata) ||
            (dut.sys_rd !== held_rd) ||
            (dut.sys_wr !== held_wr))
          $fatal(1, "[FAIL] CDC payload changed while pending");

        if (sys_ack)
          payload_pending = 0;
      end
    end
  end

  // Check the same payload from destination-clock observations.
  always @(negedge dst_clk) begin
    if (sys_rstn && dst_rstn && payload_pending) begin
      if ((dst_addr !== held_addr) ||
          (dst_wdata !== held_wdata) ||
          (dut.sys_rd !== held_rd) ||
          (dut.sys_wr !== held_wr))
        $fatal(1, "[FAIL] CDC payload unstable in destination domain");
    end
  end

  // Destination model: registered, one-cycle ACK
  always @(posedge dst_clk) begin
    if (!dst_rstn) begin
      writes_seen <= 0;
      reads_seen <= 0;
      dst_rdata <= 0;
      last_waddr <= 0;
      last_wdata <= 0;
      dst_ack <= 0;
    end else begin
      // Generate ACK from the previous cycle's request
      dst_ack <= (dst_wen || dst_ren);

      if (dst_wen) begin
        writes_seen <= writes_seen + 1;
        last_waddr <= dst_addr;
        last_wdata <= dst_wdata;
      end

      if (dst_ren) begin
        reads_seen <= reads_seen + 1;
        dst_rdata <= dst_addr ^ 32'h5A69B4C3;
      end
    end
  end

  // Verify that each ACK pulse lasts exactly one dst_clk cycle.
  always @(posedge dst_ack) begin
    if (dst_rstn) begin
      ack_pulses_seen = ack_pulses_seen + 1;

      // Check ACK after the next destination clock edge.
      @(posedge dst_clk);
      #0.001;

      if (dst_ack !== 1'b0) begin
        $fatal(1,
          "[FAIL] ACK width exceeds one destination clock cycle");
      end
    end
  end

  task automatic wait_ack;
    integer count;
    begin
      count = 0;
      while ((sys_ack !== 1'b1) && (count < 80)) begin
        @(negedge sys_clk);
        count = count + 1;
      end
      if (sys_ack !== 1'b1) begin
        $display("[FAIL] ACK timeout at t=%0t", $time);
        errors = errors + 1;
        $fatal(1, "ACK timeout");
      end
      // Wait until bridge returns to idle before starting another request.
      count = 0;
      while ((sys_ack === 1'b1) && (count < 80)) begin
        @(negedge sys_clk);
        count = count + 1;
      end
      if (sys_ack !== 1'b0) begin
        $display("[FAIL] ACK stuck high");
        errors = errors + 1;
        $fatal(1, "ACK stuck high");
      end
    end
  endtask

  task automatic do_write(input [31:0] addr, input [31:0] data);
    integer prev;
    begin
      prev = writes_seen;
      @(negedge sys_clk);
      sys_addr = addr;
      sys_wdata = data;
      sys_wen = 1;
      sys_ren = 0;
      @(negedge sys_clk);
      sys_wen = 0;
      wait_ack();
      if ((writes_seen != prev + 1) || (last_waddr !== addr) || (last_wdata !== data)) begin
        $display("[FAIL] Write addr=%h data=%h observed addr=%h data=%h count=%0d", addr, data, last_waddr, last_wdata, writes_seen);
        errors = errors + 1;
      end else begin
        $display("[PASS] Write addr=%h data=%h", addr, data);
      end
    end
  endtask

  task automatic do_read(input [31:0] addr);
    integer prev;
    reg [31:0] expected;
    reg [31:0] read_data_at_ack;
    begin
      expected = addr ^ 32'h5A69B4C3;
      prev = reads_seen;
      @(negedge sys_clk);
      sys_addr = addr;
      sys_ren = 1;
      sys_wen = 0;
      @(negedge sys_clk);
      sys_ren = 0;

      // Wait for the acknowledge signal
      @(posedge sys_ack);

      // Sample data on the next system clock edge
      @(posedge sys_clk);

      if (sys_ack !== 1'b1)
        $fatal(1, "ACK was not valid at sampling edge");

      read_data_at_ack = sys_rdata;

      // Wait for transaction completion
      wait_ack();

      if ((reads_seen != prev + 1) ||
          (read_data_at_ack !== expected)) begin
        $display(
          "[FAIL] Read addr=%h expected=%h got=%h count=%0d",
          addr, expected, read_data_at_ack, reads_seen
        );
        errors = errors + 1;
      end else begin
        $display(
          "[PASS] Read addr=%h data=%h",
          addr, read_data_at_ack
        );
      end
    end
  endtask

  // Main functional test
  integer i;

  initial begin
    repeat (5) @(negedge sys_clk);

    sys_rstn = 1'b1;
    dst_rstn = 1'b1;

    repeat (4) @(negedge sys_clk);

    for (i = 0; i < 8; i = i + 1) begin
      do_write(32'h40000000 + i*4,
               32'h12340000 + i);

      do_read(32'h40000100 + i*4);
    end

      if ((errors == 0) &&
        (writes_seen == 8) &&
        (reads_seen == 8) &&
        (ack_pulses_seen == 16)) begin

      $display("ACK_PULSE_TEST_PASS: 16 one-cycle ACK pulses");
      $display("BUS_CLK_BRIDGE_TEST_PASS: 8 writes + 8 reads");
      $finish;

    end else begin
      $fatal(1,
        "BUS_CLK_BRIDGE_TEST_FAIL: errors=%0d writes=%0d reads=%0d ack_pulses=%0d",
        errors, writes_seen, reads_seen, ack_pulses_seen);
    end
end
  // Global simulation timeout protection
  initial begin
    #100000;
    $fatal(1, "[FAIL] Global simulation timeout");
  end

endmodule
