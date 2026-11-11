`timescale 1ns/1ps
module tb_r62_analog;
reg sys_clk=1;always #4 sys_clk=~sys_clk;
reg sys_double_clk=1;always #2 sys_double_clk=~sys_double_clk;
reg dac_2p_clk=1;initial begin #1.5;dac_2p_clk=0;forever #2 dac_2p_clk=~dac_2p_clk;end
reg sys_rst=1;reg[15:0]adc_data_a=0,adc_data_b=0;
reg[13:0]dac_a=0,dac_b=0;wire[13:0]adc_a,adc_b,dac_data;
wire[1:0]adc_clk;wire adc_cdcs,dac_rst,dac_sel,dac_clk,dac_wrt;
analog_under_test dut(.*);
integer k=0,i,seed=2026111262,checked=0,reset_checks=0;
reg[15:0]word_a=0,word_b=0;
reg[13:0]shadow_a=0,shadow_b=0,expected_dac=0,expected_adc_a=0,expected_adc_b=0;
reg[13:0]consumer_a=0,consumer_b=0;
reg[16383:0]seen_a=0,seen_b=0;
function automatic[13:0]encode(input[15:0]v);encode=v[15:2]^14'h1fff;endfunction
always@(posedge sys_clk)begin
 consumer_a<=adc_a;consumer_b<=adc_b;
 expected_dac=shadow_a;
 if(sys_rst)begin shadow_a=0;shadow_b=0;end
 else begin shadow_a=dac_a^14'h1fff;shadow_b=dac_b^14'h1fff;end
 if(k>20)begin
  #0.2;
  if(dac_data!==expected_dac || dac_sel!==0)$fatal(1,"DAC_A_SLOT_FAIL k=%0d got=%h expected=%h sel=%b",k,dac_data,expected_dac,dac_sel);
  if(consumer_a!==expected_adc_a || consumer_b!==expected_adc_b)$fatal(1,"ADC_CONSUMER_SAMPLE_INDEX_FAIL k=%0d",k);
 end
end
always@(negedge sys_clk)begin
 expected_adc_a=sys_rst?14'h1fff:encode(word_a);
 expected_adc_b=sys_rst?14'h1fff:encode(word_b);
 #0.2;
 if(k>20)begin
  if(adc_a!==expected_adc_a || adc_b!==expected_adc_b)$fatal(1,"ADC_CAPTURE_FAIL k=%0d a=%h/%h b=%h/%h rst=%b",k,adc_a,expected_adc_a,adc_b,expected_adc_b,sys_rst);
  if(dac_data!==shadow_b || dac_sel!==1)$fatal(1,"DAC_B_SLOT_FAIL k=%0d",k);
  if(adc_clk!==2'b10 || adc_cdcs!==1 || dac_rst!==sys_rst)$fatal(1,"ANALOG_CONTROL_FAIL");
  checked=checked+1;
  if(sys_rst)reset_checks=reset_checks+1;
  else begin seen_a[word_a[15:2]]=1;seen_b[word_b[15:2]]=1;end
 end
end
initial begin
 for(k=0;k<32832;k=k+1)begin
  @(posedge sys_clk);#0.4;
  // Each bit arrives 0.40..1.00 ns after CLKOUT+; a 0.6 ns spread.
  // The native clock has no inserted physical delay: use explicit word tags.
  word_a={k[13:0],k[1:0]};word_b={~k[13:0],~k[1:0]};
  for(i=0;i<16;i=i+1)begin
   adc_data_a[i]<=#((i%7)*0.1)word_a[i];
   adc_data_b[i]<=#(((15-i)%7)*0.1)word_b[i];
  end
  sys_rst=(k<20 || (k>=16410 && k<16415));
  dac_a=$random(seed);dac_b=$random(seed);
 end
 @(negedge sys_clk);#1;
 if(checked<32800 || reset_checks!=5 || (&seen_a)!==1 || (&seen_b)!==1)$fatal(1,"ANALOG_COVERAGE_FAIL checks=%0d resets=%0d all=%b/%b",checked,reset_checks,&seen_a,&seen_b);
 $display("R62_ANALOG_FUNCTIONAL_PASS checks=%0d full14bit_both_lanes=1 reset_checks=%0d sample_edge=falling consumer=next_rising dac_slots=original",checked,reset_checks);
 $finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
