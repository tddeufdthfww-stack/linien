/**
 * $Id: bus_clk_bridge.v 961 2014-01-21 11:40:39Z matej.oblak $
 *
 * @brief Red Pitaya system bus clock crossing bridge.
 *
 * @Author Matej Oblak
 *
 * (c) Red Pitaya  http://www.redpitaya.com
 *
 * This part of code is written in Verilog hardware description language (HDL).
 * Please visit http://en.wikipedia.org/wiki/Verilog
 * for more details on the language used herein.
 */



/**
 * GENERAL DESCRIPTION:
 *
 * Clock domain bridge for system bus.
 *
 *
 *                  /------\
 *   SYSTEM         |      |         PROCESSING
 *   BUS    <-----> | SYNC | <----->    BUS
 *                  |      |
 *                  \------/
 *
 *
 * System bus runs on one clock domain while processing runs on separate. To 
 * simplify transition of writing and reading data this bridge was created.
 * 
 */




module bus_clk_bridge
(
   // system bus
   input                 sys_clk_i     ,  //!< bus clock
   input                 sys_rstn_i    ,  //!< bus reset - active low
   input      [ 32-1: 0] sys_addr_i    ,  //!< bus address
   input      [ 32-1: 0] sys_wdata_i   ,  //!< bus write data
   input      [  4-1: 0] sys_sel_i     ,  //!< bus write byte select
   input                 sys_wen_i     ,  //!< bus write enable
   input                 sys_ren_i     ,  //!< bus read enable
   output     [ 32-1: 0] sys_rdata_o   ,  //!< bus read data
   output                sys_err_o     ,  //!< bus error indicator
   output                sys_ack_o     ,  //!< bus acknowledge signal


   // Destination bus
   input                 clk_i         ,  //!< clock
   input                 rstn_i        ,  //!< reset - active low
   output reg [ 32-1: 0] addr_o        ,  //!< address
   output reg [ 32-1: 0] wdata_o       ,  //!< write data
   output                wen_o         ,  //!< write enable
   output                ren_o         ,  //!< read enable
   input      [ 32-1: 0] rdata_i       ,  //!< read data
   input                 err_i         ,  //!< error indicator
   input                 ack_i         ,  //!< acknowledge signal
   output                src_capture_o    //!< original source request capture condition
);



//---------------------------------------------------------------------------------
//  Synchronize signals between clock domains


reg            sys_rd    ;
reg            sys_wr    ;
reg            sys_do    ;

(* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
reg  [ 2-1: 0] sys_sync  ;

reg            sys_done  ;
reg            dst_do    ;

(* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
reg  [ 2-1: 0] dst_sync  ;

reg            dst_done  ;
// Return data is captured with the destination ACK and held until
// the next completed transaction (bundled-data CDC handshake).
reg  [ 32-1: 0] dst_rdata_hold = 32'h0 ;
reg             dst_err_hold = 1'b0 ;

// Either reset invalidates the complete toggle-handshake epoch. Keeping
// one end's old parity can deadlock after source reset or replay an old
// write after destination reset. Assert both local resets asynchronously,
// release each through its own two-flop synchronizer.
wire bridge_arstn = sys_rstn_i & rstn_i;
(* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
reg [1:0] src_ready = 2'b00;
(* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
reg [1:0] dst_ready = 2'b00;
always @(posedge sys_clk_i or negedge bridge_arstn)
   if (!bridge_arstn) src_ready <= 2'b00;
   else src_ready <= {src_ready[0], 1'b1};
always @(posedge clk_i or negedge bridge_arstn)
   if (!bridge_arstn) dst_ready <= 2'b00;
   else dst_ready <= {dst_ready[0], 1'b1};

// SYS requests are pulses, so requests during reset recovery must not be
// silently dropped. Return a source-clocked error response. A transaction
// already in flight when the destination resets uses the upstream AXI
// timeout/error contract; it is never replayed by a stale toggle.
reg src_fault_ack = 1'b0;
always @(posedge sys_clk_i)
   if (!sys_rstn_i) src_fault_ack <= 1'b0;
   else src_fault_ack <= !src_ready[1] && (sys_wen_i || sys_ren_i);


always @(posedge sys_clk_i) begin
   if (src_ready[1] == 1'b0) begin
      sys_rd   <= 1'b0 ;
      sys_wr   <= 1'b0 ;
      sys_do   <= 1'b0 ;
      sys_sync <= 2'h0 ;
      sys_done <= 1'b0 ;
   end 
   else begin

      if ((sys_do == sys_done) && (sys_wen_i || sys_ren_i)) begin
         addr_o  <= sys_addr_i    ;
         wdata_o <= sys_wdata_i   ;
         sys_rd  <= sys_ren_i     ;
         sys_wr  <= sys_wen_i     ;
         sys_do  <= !sys_do       ;
      end

      sys_sync <= {sys_sync[0], dst_done};
      sys_done <= sys_sync[1];
   end
end


always @(posedge clk_i) begin
   if (dst_ready[1] == 1'b0) begin
      dst_do    <= 1'b0 ;
      dst_sync  <= 2'h0 ;
      dst_done  <= 1'b0 ;
      // Invalidate the epoch through ready/control state. Preserve return
      // payload so a cancelled/reset transaction cannot disturb a word
      // that the source might already be consuming. INIT covers cold start.
   end
   else begin
      dst_sync <= {dst_sync[0], sys_do};
      dst_do   <= dst_sync[1];

      if (ack_i && (dst_do != dst_done)) begin
         dst_rdata_hold <= rdata_i;
         dst_err_hold   <= err_i;
         dst_done       <= dst_do;
      end
   end
end

// No state or CDC stage added; caller mirrors the existing source reset guard.
assign src_capture_o = src_ready[1] &&
                       (sys_do == sys_done) && (sys_wen_i || sys_ren_i);

assign ren_o = dst_ready[1] && sys_rd && (dst_sync[1]^dst_do);
assign wen_o = dst_ready[1] && sys_wr && (dst_sync[1]^dst_do);


// Recovery fault ACK has no destination transfer: return only local zero.
assign sys_rdata_o = src_fault_ack ? 32'h0 : dst_rdata_hold;
assign sys_err_o   = src_fault_ack | dst_err_hold;
assign sys_ack_o   = (src_ready[1] && (sys_done ^ sys_sync[1])) | src_fault_ack;



endmodule
