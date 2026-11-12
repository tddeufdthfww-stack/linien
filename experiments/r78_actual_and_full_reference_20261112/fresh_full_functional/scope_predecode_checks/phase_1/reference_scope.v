/**
 * $Id: red_pitaya_scope.v 965 2014-01-24 13:39:56Z matej.oblak $
 *
 * @brief Red Pitaya oscilloscope application, used for capturing ADC data
 *        into BRAMs, which can be later read by SW.
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
 * This is simple data aquisition module, primerly used for scilloscope
 * application. It consists from three main parts.
 *
 *
 *                /--------\      /-----------\            /-----\
 *   ADC CHA ---> | DFILT1 | ---> | AVG & DEC | ---------> | BUF | --->  SW
 *                \--------/      \-----------/     |      \-----/
 *                                                  藝         ^
 *                                              /------\      |
 *   ext trigger -----------------------------> | TRIG | -----+
 *                                              \------/      |
 *                                                  ^         藝
 *                /--------\      /-----------\     |      /-----\
 *   ADC CHB ---> | DFILT1 | ---> | AVG & DEC | ---------> | BUF | --->  SW
 *                \--------/      \-----------/            \-----/
 *
 *
 * Input data is optionaly averaged and decimated via average filter.
 *
 * Trigger section makes triggers from input ADC data or external digital
 * signal. To make trigger from analog signal schmitt trigger is used, external
 * trigger goes first over debouncer, which is separate for pos. and neg. edge.
 *
 * Data capture buffer is realized with BRAM. Writing into ram is done with
 * arm/trig logic. With adc_arm_do signal (SW) writing is enabled, this is active
 * until trigger arrives and adc_dly_cnt counts to zero. Value adc_wp_trig
 * serves as pointer which shows when trigger arrived. This is used to show
 * pre-trigger data.
 *
 */



module red_pitaya_scope_reference
(
   // ADC
   input      [ 14-1: 0] adc_a_i         ,  //!< ADC data CHA
   input      [ 14-1: 0] adc_b_i         ,  //!< ADC data CHB
   input      [ 14-1: 0] adc_a_q_i       ,  //!< Quadrature of ADC CHA
   input      [ 14-1: 0] adc_b_q_i       ,  //!< Quadrature of ADC CHA

   input                 adc_clk_i       ,  //!< ADC clock
   input                 adc_rstn_i      ,  //!< ADC reset - active low
   input                 trig_ext_i      ,  //!< external trigger
   input                 trig_asg_i      ,  //!< ASG trigger
   input                 automatically_rearm_i  ,


   // System bus
   input                 sys_clk_i       ,  //!< bus clock
   input                 sys_rstn_i      ,  //!< bus reset - active low
   input      [ 32-1: 0] sys_addr_i      ,  //!< bus saddress
   input      [ 32-1: 0] sys_wdata_i     ,  //!< bus write data
   input      [  4-1: 0] sys_sel_i       ,  //!< bus write byte select
   input                 sys_wen_i       ,  //!< bus write enable
   input                 sys_ren_i       ,  //!< bus read enable
   output     [ 32-1: 0] sys_rdata_o     ,  //!< bus read data
   output                sys_err_o       ,  //!< bus error indicator
   output                sys_ack_o       ,   //!< bus acknowledge signal

   output reg   [ 14-1: 0] written_data,
   output reg   [ 14-1: 0] scope_position,
   output reg              scope_writing_now
);


wire [ 32-1: 0] addr         ;
wire [ 32-1: 0] wdata        ;
wire            wen          ;
wire            ren          ;
reg  [ 32-1: 0] rdata        ;
reg             err          ;
reg             ack          ;
reg             adc_arm_do   ;
reg             adc_rst_do   ;



//---------------------------------------------------------------------------------
//  Input filtering

wire [ 14-1: 0] adc_a_filt_in  ;
wire [ 14-1: 0] adc_a_filt_out ;
wire [ 14-1: 0] adc_b_filt_in  ;
wire [ 14-1: 0] adc_b_filt_out ;
wire [ 14-1: 0] adc_a_q_filt_out ;
wire [ 14-1: 0] adc_b_q_filt_out ;
reg  [ 18-1: 0] set_a_filt_aa  ;
reg  [ 25-1: 0] set_a_filt_bb  ;
reg  [ 25-1: 0] set_a_filt_kk  ;
reg  [ 25-1: 0] set_a_filt_pp  ;
reg  [ 18-1: 0] set_b_filt_aa  ;
reg  [ 25-1: 0] set_b_filt_bb  ;
reg  [ 25-1: 0] set_b_filt_kk  ;
reg  [ 25-1: 0] set_b_filt_pp  ;


assign adc_a_filt_in = adc_a_i ;
assign adc_b_filt_in = adc_b_i ;
// this replaces the filtering of the original FPGA image by a simple assignment
assign adc_a_filt_out = adc_a_filt_in ;
assign adc_b_filt_out = adc_b_filt_in ;
assign adc_a_q_filt_out = adc_a_q_i ;
assign adc_b_q_filt_out = adc_b_q_i ;


//---------------------------------------------------------------------------------
//  Decimate input data

reg  [ 14-1: 0] adc_a_dat     ;
reg  [ 14-1: 0] adc_b_dat     ;
reg  [ 14-1: 0] adc_a_q_dat     ;
reg  [ 14-1: 0] adc_b_q_dat     ;
reg  [ 48-1: 0] adc_a_sum     ;
reg  [ 48-1: 0] adc_b_sum     ;
reg  [ 48-1: 0] adc_a_q_sum     ;
reg  [ 48-1: 0] adc_b_q_sum     ;
reg  [ 32-1: 0] set_dec       ;
reg  [ 32-1: 0] adc_dec_cnt   ;
reg             set_avg_en    ;
reg             adc_dv        ;
wire [13:0] average_a;
scope_average_select_reference average_select_a(.raw_i(adc_a_filt_out),.sum_i(adc_a_sum),.dec_i(set_dec),.avg_i(set_avg_en),.value_o(average_a));
wire [13:0] average_b;
scope_average_select_reference average_select_b(.raw_i(adc_b_filt_out),.sum_i(adc_b_sum),.dec_i(set_dec),.avg_i(set_avg_en),.value_o(average_b));
wire [13:0] average_aq;
scope_average_select_reference average_select_aq(.raw_i(adc_a_q_filt_out),.sum_i(adc_a_q_sum),.dec_i(set_dec),.avg_i(set_avg_en),.value_o(average_aq));
wire [13:0] average_bq;
scope_average_select_reference average_select_bq(.raw_i(adc_b_q_filt_out),.sum_i(adc_b_q_sum),.dec_i(set_dec),.avg_i(set_avg_en),.value_o(average_bq));


always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      adc_a_sum   <= 48'h0 ;
      adc_b_sum   <= 48'h0 ;
      adc_a_q_sum   <= 48'h0 ;
      adc_b_q_sum   <= 48'h0 ;
      adc_dec_cnt <= 32'h0 ;
      adc_dv      <=  1'b0 ;
   end
   else begin
      if ((adc_dec_cnt >= set_dec) || adc_arm_do) begin // start again or arm
         adc_dec_cnt <= 32'h1                   ;
         adc_a_sum   <= $signed(adc_a_filt_out) ;
         adc_b_sum   <= $signed(adc_b_filt_out) ;
         adc_a_q_sum   <= $signed(adc_a_q_filt_out) ;
         adc_b_q_sum   <= $signed(adc_b_q_filt_out) ;
      end
      else begin
         adc_dec_cnt <= adc_dec_cnt + 32'h1 ;
         adc_a_sum   <= $signed(adc_a_sum) + $signed(adc_a_filt_out) ;
         adc_b_sum   <= $signed(adc_b_sum) + $signed(adc_b_filt_out) ;
         adc_a_q_sum   <= $signed(adc_a_q_sum) + $signed(adc_a_q_filt_out) ;
         adc_b_q_sum   <= $signed(adc_b_q_sum) + $signed(adc_b_q_filt_out) ;
      end

      adc_dv <= (adc_dec_cnt >= set_dec) ;

      adc_a_dat <= average_a;
      adc_b_dat <= average_b;
      adc_a_q_dat <= average_aq;
      adc_b_q_dat <= average_bq;

   end
end








//---------------------------------------------------------------------------------
//  ADC buffer RAM

localparam RSZ = 14 ;  // RAM size 2^RSZ


reg   [  14-1: 0] adc_a_buf [0:(1<<RSZ)-1] ;
reg   [  14-1: 0] adc_b_buf [0:(1<<RSZ)-1] ;
reg   [  14-1: 0] adc_a_q_buf [0:(1<<RSZ)-1] ;
reg   [  14-1: 0] adc_b_q_buf [0:(1<<RSZ)-1] ;
reg   [  14-1: 0] adc_a_rd      ;
reg   [  14-1: 0] adc_b_rd      ;
reg   [  14-1: 0] adc_a_q_rd      ;
reg   [  14-1: 0] adc_b_q_rd      ;
reg   [ RSZ-1: 0] adc_wp        ;
reg   [ RSZ-1: 0] adc_raddr     ;
reg   [ RSZ-1: 0] adc_a_raddr   ;
reg   [ RSZ-1: 0] adc_b_raddr   ;
reg   [ RSZ-1: 0] adc_a_q_raddr   ;
reg   [ RSZ-1: 0] adc_b_q_raddr   ;
reg   [   4-1: 0] adc_rval      ;
wire              adc_rd_dv     ;
reg               adc_we        ;
reg               adc_trig      ;

reg   [ RSZ-1: 0] adc_wp_trig   ;
reg   [ RSZ-1: 0] adc_wp_cur    ;
reg   [  32-1: 0] set_dly       ;
reg   [  32-1: 0] adc_dly_cnt   ;
reg               adc_dly_do    ;


// Write
always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      adc_wp      <= {RSZ{1'b0}};
      adc_we      <=  1'b0      ;
      adc_wp_trig <= {RSZ{1'b0}};
      adc_wp_cur  <= {RSZ{1'b0}};
      adc_dly_cnt <= 32'h0      ;
      adc_dly_do  <=  1'b0      ;
   end
   else begin
      if (adc_arm_do)
         adc_we <= 1'b1 ;
      else if (((adc_dly_do || adc_trig) && (adc_dly_cnt == 32'h0)) || adc_rst_do) //delayed reached or reset
         adc_we <= 1'b0 ;


      if (adc_rst_do)
         adc_wp <= {RSZ{1'b0}};
      else if (adc_we && adc_dv)
         adc_wp <= adc_wp + 1'b1 ;

      if (adc_rst_do)
         adc_wp_trig <= {RSZ{1'b0}};
      else if (adc_trig && !adc_dly_do)
         adc_wp_trig <= adc_wp_cur ; // save write pointer at trigger arrival

      if (adc_rst_do)
         adc_wp_cur <= {RSZ{1'b0}};
      else if (adc_we && adc_dv)
         adc_wp_cur <= adc_wp ; // save current write pointer


      if (adc_trig)
         adc_dly_do  <= 1'b1 ;
      else if ((adc_dly_do && (adc_dly_cnt == 32'b0)) || adc_rst_do || adc_arm_do) //delayed reached or reset
         adc_dly_do  <= 1'b0 ;

      if (adc_dly_do && adc_we && adc_dv)
         adc_dly_cnt <= adc_dly_cnt + {32{1'b1}} ; // -1
      else if (!adc_dly_do)
         adc_dly_cnt <= set_dly ;

   end
end

always @(posedge adc_clk_i) begin
   if (adc_we && adc_dv) begin
      adc_a_buf[adc_wp] <= adc_a_dat ;
      adc_b_buf[adc_wp] <= adc_b_dat ;
      adc_a_q_buf[adc_wp] <= adc_a_q_dat ;
      adc_b_q_buf[adc_wp] <= adc_b_q_dat ;

      written_data <= adc_a_dat ;
   end
   scope_position <= adc_wp;
   scope_writing_now <= adc_we && adc_dv;
end

// Read
always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0)
      adc_rval <= 4'h0 ;
   else
      adc_rval <= {adc_rval[2:0], (ren || wen)};
end
assign adc_rd_dv = adc_rval[3];

always @(posedge adc_clk_i) begin
   adc_raddr   <= addr[RSZ+1:2] ; // address synchronous to clock
   adc_a_raddr <= adc_raddr     ; // double register
   adc_b_raddr <= adc_raddr     ; // otherwise memory corruption at reading
   adc_a_q_raddr <= adc_raddr     ; // double register
   adc_b_q_raddr <= adc_raddr     ; // otherwise memory corruption at reading
   adc_a_rd    <= adc_a_buf[adc_a_raddr] ;
   adc_b_rd    <= adc_b_buf[adc_b_raddr] ;
   adc_a_q_rd    <= adc_a_q_buf[adc_a_q_raddr] ;
   adc_b_q_rd    <= adc_b_q_buf[adc_b_q_raddr] ;
end





//---------------------------------------------------------------------------------
//
//  Trigger source selector

reg               adc_trig_ap      ;
reg               adc_trig_an      ;
reg               adc_trig_bp      ;
reg               adc_trig_bn      ;
reg               adc_trig_sw      ;
reg   [   4-1: 0] set_trig_src     ;
wire              ext_trig_p       ;
wire              ext_trig_n       ;
wire              asg_trig_p       ;
wire              asg_trig_n       ;


always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      adc_arm_do    <= 1'b0 ;
      adc_rst_do    <= 1'b0 ;
      adc_trig_sw   <= 1'b0 ;
      set_trig_src  <= 4'h0 ;
      adc_trig      <= 1'b0 ;
   end
   else begin
      adc_arm_do  <= (automatically_rearm_i && (adc_we == 1'b0)) || (wen && (addr[19:0]==20'h0) && wdata[0]) ; // SW ARM
      adc_rst_do  <= wen && (addr[19:0]==20'h0) && wdata[1] ;
      adc_trig_sw <= wen && (addr[19:0]==20'h4) ; // SW trigger

      if (wen && (addr[19:0]==20'h4))
         set_trig_src <= wdata[3:0] ;
      else if (((adc_dly_do || adc_trig) && (adc_dly_cnt == 32'h0)) || adc_rst_do) //delayed reached or reset
         set_trig_src <= 4'h0 ;

      case (set_trig_src)
          4'd1 : adc_trig <= adc_trig_sw   ; // manual
          4'd2 : adc_trig <= adc_trig_ap   ; // A ch rising edge
          4'd3 : adc_trig <= adc_trig_an   ; // A ch falling edge
          4'd4 : adc_trig <= adc_trig_bp   ; // B ch rising edge
          4'd5 : adc_trig <= adc_trig_bn   ; // B ch falling edge
          4'd6 : adc_trig <= ext_trig_p    ; // external - rising edge
          4'd7 : adc_trig <= ext_trig_n    ; // external - falling edge
          4'd8 : adc_trig <= asg_trig_p    ; // ASG - rising edge
          4'd9 : adc_trig <= asg_trig_n    ; // ASG - falling edge
       default : adc_trig <= 1'b0          ;
      endcase
   end
end




//---------------------------------------------------------------------------------
//
//  Trigger created from input signal

reg  [  2-1: 0] adc_scht_ap  ;
reg  [  2-1: 0] adc_scht_an  ;
reg  [  2-1: 0] adc_scht_bp  ;
reg  [  2-1: 0] adc_scht_bn  ;
reg  [ 14-1: 0] set_a_tresh  ;
reg  [ 14-1: 0] set_a_treshp ;
reg  [ 14-1: 0] set_a_treshm ;
reg  [ 14-1: 0] set_b_tresh  ;
reg  [ 14-1: 0] set_b_treshp ;
reg  [ 14-1: 0] set_b_treshm ;
reg  [ 14-1: 0] set_a_hyst   ;
reg  [ 14-1: 0] set_b_hyst   ;

always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      adc_scht_ap  <=  2'h0 ;
      adc_scht_an  <=  2'h0 ;
      adc_scht_bp  <=  2'h0 ;
      adc_scht_bn  <=  2'h0 ;
      adc_trig_ap  <=  1'b0 ;
      adc_trig_an  <=  1'b0 ;
      adc_trig_bp  <=  1'b0 ;
      adc_trig_bn  <=  1'b0 ;
   end
   else begin
      set_a_treshp <= set_a_tresh + set_a_hyst ; // calculate positive
      set_a_treshm <= set_a_tresh - set_a_hyst ; // and negative treshold
      set_b_treshp <= set_b_tresh + set_b_hyst ;
      set_b_treshm <= set_b_tresh - set_b_hyst ;

      if (adc_dv) begin
              if ($signed(adc_a_dat) >= $signed(set_a_tresh ))      adc_scht_ap[0] <= 1'b1 ;  // treshold reached
         else if ($signed(adc_a_dat) <  $signed(set_a_treshm))      adc_scht_ap[0] <= 1'b0 ;  // wait until it goes under hysteresis
              if ($signed(adc_a_dat) <= $signed(set_a_tresh ))      adc_scht_an[0] <= 1'b1 ;  // treshold reached
         else if ($signed(adc_a_dat) >  $signed(set_a_treshp))      adc_scht_an[0] <= 1'b0 ;  // wait until it goes over hysteresis

              if ($signed(adc_b_dat) >= $signed(set_b_tresh ))      adc_scht_bp[0] <= 1'b1 ;
         else if ($signed(adc_b_dat) <  $signed(set_b_treshm))      adc_scht_bp[0] <= 1'b0 ;
              if ($signed(adc_b_dat) <= $signed(set_b_tresh ))      adc_scht_bn[0] <= 1'b1 ;
         else if ($signed(adc_b_dat) >  $signed(set_b_treshp))      adc_scht_bn[0] <= 1'b0 ;
      end

      adc_scht_ap[1] <= adc_scht_ap[0] ;
      adc_scht_an[1] <= adc_scht_an[0] ;
      adc_scht_bp[1] <= adc_scht_bp[0] ;
      adc_scht_bn[1] <= adc_scht_bn[0] ;

      adc_trig_ap <= adc_scht_ap[0] && !adc_scht_ap[1] ; // make 1 cyc pulse
      adc_trig_an <= adc_scht_an[0] && !adc_scht_an[1] ;
      adc_trig_bp <= adc_scht_bp[0] && !adc_scht_bp[1] ;
      adc_trig_bn <= adc_scht_bn[0] && !adc_scht_bn[1] ;
   end
end







//---------------------------------------------------------------------------------
//
//  External trigger

reg  [  3-1: 0] ext_trig_in    ;
reg  [  2-1: 0] ext_trig_dp    ;
reg  [  2-1: 0] ext_trig_dn    ;
reg  [ 20-1: 0] ext_trig_debp  ;
reg  [ 20-1: 0] ext_trig_debn  ;
reg  [  3-1: 0] asg_trig_in    ;
reg  [  2-1: 0] asg_trig_dp    ;
reg  [  2-1: 0] asg_trig_dn    ;
reg  [ 20-1: 0] asg_trig_debp  ;
reg  [ 20-1: 0] asg_trig_debn  ;


always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      ext_trig_in   <=  3'h0 ;
      ext_trig_dp   <=  2'h0 ;
      ext_trig_dn   <=  2'h0 ;
      ext_trig_debp <= 20'h0 ;
      ext_trig_debn <= 20'h0 ;
      asg_trig_in   <=  3'h0 ;
      asg_trig_dp   <=  2'h0 ;
      asg_trig_dn   <=  2'h0 ;
      asg_trig_debp <= 20'h0 ;
      asg_trig_debn <= 20'h0 ;
   end
   else begin
      //----------- External trigger
      // synchronize FFs
      ext_trig_in <= {ext_trig_in[1:0],trig_ext_i} ;

      // look for input changes
      if ((ext_trig_debp == 20'h0) && (ext_trig_in[1] && !ext_trig_in[2]))
         ext_trig_debp <= 20'd62500 ; // ~0.5ms
      else if (ext_trig_debp != 20'h0)
         ext_trig_debp <= ext_trig_debp - 20'd1 ;

      if ((ext_trig_debn == 20'h0) && (!ext_trig_in[1] && ext_trig_in[2]))
         ext_trig_debn <= 20'd62500 ; // ~0.5ms
      else if (ext_trig_debn != 20'h0)
         ext_trig_debn <= ext_trig_debn - 20'd1 ;

      // update output values
      ext_trig_dp[1] <= ext_trig_dp[0] ;
      if (ext_trig_debp == 20'h0)
         ext_trig_dp[0] <= ext_trig_in[1] ;

      ext_trig_dn[1] <= ext_trig_dn[0] ;
      if (ext_trig_debn == 20'h0)
         ext_trig_dn[0] <= ext_trig_in[1] ;




      //----------- ASG trigger
      // synchronize FFs
      asg_trig_in <= {asg_trig_in[1:0],trig_asg_i} ;

      // look for input changes
      if ((asg_trig_debp == 20'h0) && (asg_trig_in[1] && !asg_trig_in[2]))
         asg_trig_debp <= 20'd62500 ; // ~0.5ms
      else if (asg_trig_debp != 20'h0)
         asg_trig_debp <= asg_trig_debp - 20'd1 ;

      if ((asg_trig_debn == 20'h0) && (!asg_trig_in[1] && asg_trig_in[2]))
         asg_trig_debn <= 20'd62500 ; // ~0.5ms
      else if (asg_trig_debn != 20'h0)
         asg_trig_debn <= asg_trig_debn - 20'd1 ;

      // update output values
      asg_trig_dp[1] <= asg_trig_dp[0] ;
      if (asg_trig_debp == 20'h0)
         asg_trig_dp[0] <= asg_trig_in[1] ;

      asg_trig_dn[1] <= asg_trig_dn[0] ;
      if (asg_trig_debn == 20'h0)
         asg_trig_dn[0] <= asg_trig_in[1] ;
   end
end


assign ext_trig_p = (ext_trig_dp == 2'b01) ;
assign ext_trig_n = (ext_trig_dn == 2'b10) ;
assign asg_trig_p = (asg_trig_dp == 2'b01) ;
assign asg_trig_n = (asg_trig_dn == 2'b10) ;










//---------------------------------------------------------------------------------
//
//  System bus connection


always @(posedge adc_clk_i) begin
   if (adc_rstn_i == 1'b0) begin
      set_a_tresh   <=  14'd5000   ;
      set_b_tresh   <= -14'd5000   ;
      set_dly       <=  32'd0      ;
      set_dec       <=  32'd1      ;
      set_a_hyst    <=  14'd20     ;
      set_b_hyst    <=  14'd20     ;
      set_avg_en    <=   1'b1      ;
      set_a_filt_aa <=  18'h0      ;
      set_a_filt_bb <=  25'h0      ;
      set_a_filt_kk <=  25'hFFFFFF ;
      set_a_filt_pp <=  25'h0      ;
      set_b_filt_aa <=  18'h0      ;
      set_b_filt_bb <=  25'h0      ;
      set_b_filt_kk <=  25'hFFFFFF ;
      set_b_filt_pp <=  25'h0      ;
   end
   else begin
      if (wen) begin
         if (addr[19:0]==20'h8)    set_a_tresh <= wdata[14-1:0] ;
         if (addr[19:0]==20'hC)    set_b_tresh <= wdata[14-1:0] ;
         if (addr[19:0]==20'h10)   set_dly     <= wdata[32-1:0] ;
         if (addr[19:0]==20'h14)   set_dec     <= wdata[32-1:0] ;
         if (addr[19:0]==20'h20)   set_a_hyst  <= wdata[14-1:0] ;
         if (addr[19:0]==20'h24)   set_b_hyst  <= wdata[14-1:0] ;
         if (addr[19:0]==20'h28)   set_avg_en  <= wdata[     0] ;

         if (addr[19:0]==20'h30)   set_a_filt_aa <= wdata[18-1:0] ;
         if (addr[19:0]==20'h34)   set_a_filt_bb <= wdata[25-1:0] ;
         if (addr[19:0]==20'h38)   set_a_filt_kk <= wdata[25-1:0] ;
         if (addr[19:0]==20'h3C)   set_a_filt_pp <= wdata[25-1:0] ;
         if (addr[19:0]==20'h40)   set_b_filt_aa <= wdata[18-1:0] ;
         if (addr[19:0]==20'h44)   set_b_filt_bb <= wdata[25-1:0] ;
         if (addr[19:0]==20'h48)   set_b_filt_kk <= wdata[25-1:0] ;
         if (addr[19:0]==20'h4C)   set_b_filt_pp <= wdata[25-1:0] ;
      end
   end
end





always @(*) begin
   err <= 1'b0 ;

   casez (addr[19:0])
     20'h00004 : begin ack <= 1'b1;          rdata <= {{32- 4{1'b0}}, set_trig_src}       ; end

     20'h00008 : begin ack <= 1'b1;          rdata <= {{32-14{1'b0}}, set_a_tresh}        ; end
     20'h0000C : begin ack <= 1'b1;          rdata <= {{32-14{1'b0}}, set_b_tresh}        ; end
     20'h00010 : begin ack <= 1'b1;          rdata <= {               set_dly}            ; end
     20'h00014 : begin ack <= 1'b1;          rdata <= {{32-32{1'b0}}, set_dec}            ; end

     20'h00018 : begin ack <= 1'b1;          rdata <= {{32-RSZ{1'b0}}, adc_wp_cur}        ; end
     20'h0001C : begin ack <= 1'b1;          rdata <= {{32-RSZ{1'b0}}, adc_wp_trig}       ; end

     20'h00020 : begin ack <= 1'b1;          rdata <= {{32-14{1'b0}}, set_a_hyst}         ; end
     20'h00024 : begin ack <= 1'b1;          rdata <= {{32-14{1'b0}}, set_b_hyst}         ; end

     20'h00028 : begin ack <= 1'b1;          rdata <= {{32- 1{1'b0}}, set_avg_en}         ; end

     20'h00030 : begin ack <= 1'b1;          rdata <= {{32-18{1'b0}}, set_a_filt_aa}      ; end
     20'h00034 : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_a_filt_bb}      ; end
     20'h00038 : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_a_filt_kk}      ; end
     20'h0003C : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_a_filt_pp}      ; end
     20'h00040 : begin ack <= 1'b1;          rdata <= {{32-18{1'b0}}, set_b_filt_aa}      ; end
     20'h00044 : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_b_filt_bb}      ; end
     20'h00048 : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_b_filt_kk}      ; end
     20'h0004C : begin ack <= 1'b1;          rdata <= {{32-25{1'b0}}, set_b_filt_pp}      ; end

     20'h1???? : begin ack <= adc_rd_dv;     rdata <= {2'h0,adc_b_rd,2'h0,adc_a_rd}              ; end
     20'h2???? : begin ack <= adc_rd_dv;     rdata <= {2'h0,adc_b_q_rd,2'h0,adc_a_q_rd}          ; end

       default : begin ack <= 1'b1;          rdata <=  32'h0                              ; end
   endcase
end






// bridge between ADC and sys clock
bus_clk_bridge_reference i_bridge
(
   .sys_clk_i     (  sys_clk_i      ),
   .sys_rstn_i    (  sys_rstn_i     ),
   .sys_addr_i    (  sys_addr_i     ),
   .sys_wdata_i   (  sys_wdata_i    ),
   .sys_sel_i     (  sys_sel_i      ),
   .sys_wen_i     (  sys_wen_i      ),
   .sys_ren_i     (  sys_ren_i      ),
   .sys_rdata_o   (  sys_rdata_o    ),
   .sys_err_o     (  sys_err_o      ),
   .sys_ack_o     (  sys_ack_o      ),

   .clk_i         (  adc_clk_i      ),
   .rstn_i        (  adc_rstn_i     ),
   .addr_o        (  addr           ),
   .wdata_o       (  wdata          ),
   .wen_o         (  wen            ),
   .ren_o         (  ren            ),
   .rdata_i       (  rdata          ),
   .err_i         (  err            ),
   .ack_i         (  ack            )
);






endmodule


// Purely combinational: preserve all original averaging/truncation cases.
module scope_average_select_reference(
    input [13:0] raw_i, input [47:0] sum_i,
    input [31:0] dec_i, input avg_i, output reg [13:0] value_o
);
(* KEEP = "TRUE" *) reg [13:0] mean;
always @* begin
   case (dec_i)
      32'h0: mean = raw_i;
      32'h1: mean = sum_i[15+0 :  0];
      32'h2: mean = sum_i[15+1 :  1];
      32'h4: mean = sum_i[15+2 :  2];
      32'h8: mean = sum_i[15+3 :  3];
      32'h10: mean = sum_i[15+4 :  4];
      32'h20: mean = sum_i[15+5 :  5];
      32'h40: mean = sum_i[15+6 :  6];
      32'h80: mean = sum_i[15+7 :  7];
      32'h100: mean = sum_i[15+8 :  8];
      32'h200: mean = sum_i[15+9 :  9];
      32'h400: mean = sum_i[15+10: 10];
      32'h800: mean = sum_i[15+11: 11];
      32'h1000: mean = sum_i[15+12: 12];
      32'h2000: mean = sum_i[15+13: 13];
      32'h4000: mean = sum_i[15+14: 14];
      32'h8000: mean = sum_i[15+15: 15];
      32'h10000: mean = sum_i[15+16: 16];
      32'h20000: mean = sum_i[15+17 :  17];
      32'h40000: mean = sum_i[15+18 :  18];
      32'h80000: mean = sum_i[15+19 :  19];
      32'h100000: mean = sum_i[15+20 :  20];
      32'h200000: mean = sum_i[15+21 :  21];
      32'h400000: mean = sum_i[15+22 :  22];
      32'h800000: mean = sum_i[15+23 :  23];
      32'h1000000: mean = sum_i[15+24 :  24];
      32'h2000000: mean = sum_i[15+25 :  25];
      32'h4000000: mean = sum_i[15+26: 26];
      32'h8000000: mean = sum_i[15+27: 27];
      32'h10000000: mean = sum_i[15+28: 28];
      32'h20000000: mean = sum_i[15+29: 29];
      32'h40000000: mean = sum_i[15+30: 30];
      32'h80000000: mean = sum_i[15+31: 31];
      default: mean = sum_i[15+0 :  0];
   endcase
end
always @* begin
   case (avg_i)
      1'b0: value_o = raw_i;
      1'b1: value_o = mean;
      default: begin
         // Exact original case behavior for an unknown averaging control.
         if (dec_i === 32'd0) value_o = raw_i;
         else value_o = sum_i[15:0];
      end
   endcase
end
endmodule
