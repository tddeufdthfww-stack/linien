`timescale 1ns/1ps
// AXI3 -> bus_clk_bridge -> destination-register integration regression.
// Single-beat, serialized read/write transactions with AXI backpressure.
// Does not model metastability or certify full AXI3 protocol compliance.
module tb_fault_contract;

  reg sys_clk = 1'b0;
  reg dst_clk = 1'b0; reg run_dst=1; reg[2:0]arsize=3'b010;
  always #4 sys_clk = ~sys_clk;                  // 125 MHz PS clock
  initial begin
    #0.001;
    forever #4 if(run_dst)dst_clk = ~dst_clk;              // 125 MHz, offset by 1.25 ns
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
  wire sys_wen, sys_ren, sys_ack, sys_err; wire sys_abort; wire sys_bus_rstn=sys_rstn & ~sys_abort;
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
    .axi_arlen_i(4'd0), .axi_arsize_i(arsize),
    .axi_arburst_i(2'b01), .axi_arlock_i(2'b00),
    .axi_arcache_i(4'b0), .axi_arprot_i(3'b0),
    .axi_arvalid_i(arvalid), .axi_arready_o(arready),
    .axi_rid_o(rid), .axi_rdata_o(rdata),
    .axi_rresp_o(rresp), .axi_rlast_o(rlast),
    .axi_rvalid_o(rvalid), .axi_rready_i(rready),
    .sys_addr_o(sys_addr), .sys_wdata_o(sys_wdata),
    .sys_sel_o(sys_sel), .sys_wen_o(sys_wen),
    .sys_ren_o(sys_ren), .sys_rdata_i(sys_rdata),
    .sys_err_i(sys_err), .sys_ack_i(sys_ack), .sys_abort_o(sys_abort)
  );

  bus_clk_bridge bridge (
    .sys_clk_i(sys_clk), .sys_rstn_i(sys_bus_rstn),
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


  localparam integer MODE=5;
  task automatic read_error(input[31:0]expected);
    integer n;reg[31:0]snapshot;
    begin
      @(negedge sys_clk);araddr=32'h40000000;arid=12'h692;arvalid=1;
      if(MODE==2)arsize=3'b001;
      @(posedge sys_clk);if(!arready)$fatal(1,"ARREADY_FAIL");
      @(negedge sys_clk);arvalid=0;n=0;
      while(rvalid!==1)begin @(negedge sys_clk);n=n+1;if(n>65)$fatal(1,"ERROR_READ_TIMEOUT");end
      if(rresp!==2'b10 || rid!==12'h692 || rlast!==1)$fatal(1,"ERROR_RESPONSE_FAIL");
      if(rdata!==expected)$fatal(1,"INVALID_PAYLOAD_NOT_SOURCE_ZERO mode=%0d value=%h expected=%h",MODE,rdata,expected);
      snapshot=rdata;
      repeat(8)begin @(posedge sys_clk);#0.001;if(!rvalid || rresp!==2'b10 || rid!==12'h692 || rdata!==snapshot || !rlast)$fatal(1,"ERROR_BACKPRESSURE_FAIL");end
      @(negedge sys_clk);rready=1;@(posedge sys_clk);#0.001;if(rvalid || rlast)$fatal(1,"R_NOT_RETIRED");
      @(negedge sys_clk);rready=0;arsize=3'b010;
    end
  endtask
  task automatic write_timeout;
    integer n;
    begin
      @(negedge sys_clk);awaddr=32'h40000004;awid=12'h693;wid=12'h693;awvalid=1;
      @(posedge sys_clk);if(!awready)$fatal(1,"AWREADY_FAIL");
      @(negedge sys_clk);awvalid=0;wdata=32'hbaadf00d;wvalid=1;
      @(posedge sys_clk);if(!wready)$fatal(1,"WREADY_FAIL");
      @(negedge sys_clk);wvalid=0;n=0;
      while(!bvalid)begin @(negedge sys_clk);n=n+1;if(n>65)$fatal(1,"WRITE_TIMEOUT_MISSING");end
      repeat(8)begin @(posedge sys_clk);#0.001;if(!bvalid || bresp!==2'b10 || bid!==12'h693)$fatal(1,"WRITE_TIMEOUT_BACKPRESSURE_FAIL");end
      @(negedge sys_clk);bready=1;@(posedge sys_clk);#0.001;if(bvalid)$fatal(1,"B_NOT_RETIRED");
      @(negedge sys_clk);bready=0;
    end
  endtask
  integer before_writes;
  initial begin
    repeat(6)@(negedge sys_clk);sys_rstn=1;dst_rstn=1;repeat(8)@(negedge sys_clk);
    write_word(32'h40000000,32'h11223344,12'h101);
    read_word(32'h40000000,32'h11223344,12'h201);
    if(bridge.dst_rdata_hold!==32'h11223344)$fatal(1,"PRECONDITION_HELD_DATA_FAIL");
    if(MODE==0)begin
      @(negedge dst_clk);run_dst=0;#0.1;dst_rstn=0;
      read_error(32'h0);
    end else if(MODE==1)begin
      @(negedge dst_clk);run_dst=0;
      read_error(32'h0);
    end else if(MODE==2)begin
      read_error(32'h0);
    end else if(MODE==3)begin
      @(negedge dst_clk);run_dst=0;before_writes=writes_seen;
      write_timeout();run_dst=1;
      repeat(24)@(negedge sys_clk);
      if(writes_seen!=before_writes)$fatal(1,"TIMED_OUT_WRITE_REPLAYED_AFTER_CLOCK_RESUME before=%0d now=%0d",before_writes,writes_seen);
      write_word(32'h40000004,32'h55667788,12'h104);
      read_word(32'h40000004,32'h55667788,12'h204);
    end else if(MODE==4)begin
      dst_err=1;read_error(32'h11223344);dst_err=0;
    end else if(MODE==5)begin
      @(negedge dst_clk);dst_rstn=0;repeat(8)@(negedge dst_clk);
      if(bridge.dst_rdata_hold!==32'h11223344)$fatal(1,"INVALID_EPOCH_CHANGED_HELD_RETURN_PAYLOAD");
    end
    $display("R69_FAULT_PAYLOAD_AND_TIMEOUT_CONTRACT_PASS mode=%0d",MODE);$finish;
  end
  initial begin #30000;$fatal(1,"fault contract timeout");end
endmodule
