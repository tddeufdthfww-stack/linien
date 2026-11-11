`timescale 1ns/1ps
module tb_r63_analog;
localparam real PHI=3.5, BUFFER=0.85;
reg clk125_pad=1;always #4 clk125_pad=~clk125_pad;
reg double_source=1;always #2 double_source=~double_source;
reg dac_source=1;initial begin #1.5;dac_source=0;forever #2 dac_source=~dac_source;end
wire sys_clk,sys_double_clk,dac_2p_clk;
assign #(PHI)sys_clk=clk125_pad;
assign #(PHI)sys_double_clk=double_source;
assign #(PHI)dac_2p_clk=dac_source;
reg sys_rst=1;reg[15:0]adc_data_a=0,adc_data_b=0;
reg[13:0]dac_a=0,dac_b=0;
wire[48:0]old_outputs,new_outputs;
wire[13:0]old_adc_a,old_adc_b,new_adc_a,new_adc_b;
analog_pair dut(.*);
integer k=0,i,seed=2026111263,checked=0,reset_checks=0,paired_checks=0;
reg[15:0]word_a=0,word_b=0;
reg[13:0]expected_a=14'h1fff,expected_b=14'h1fff,last_a=14'h1fff,last_b=14'h1fff;
reg[13:0]old_cons_a=0,new_cons_a=0,old_cons_b=0,new_cons_b=0;
reg[16383:0]seen_a=0,seen_b=0;
function automatic[13:0]encode(input[15:0]v);encode=v[15:2]^14'h1fff;endfunction
always@(posedge sys_clk)begin
 old_cons_a<=old_adc_a;new_cons_a<=new_adc_a;old_cons_b<=old_adc_b;new_cons_b<=new_adc_b;
 expected_a=sys_rst?14'h1fff:encode(word_a);
 expected_b=sys_rst?14'h1fff:encode(word_b);
 #0.2;
 if(k>20)begin
  if(old_adc_a!==expected_a || new_adc_a!==expected_a || old_adc_b!==expected_b || new_adc_b!==expected_b)
   $fatal(1,"ADC_WORD_INDEX_FAIL k=%0d phi=%0.3f a=%h/%h/%h b=%h/%h/%h",k,PHI,old_adc_a,new_adc_a,expected_a,old_adc_b,new_adc_b,expected_b);
  if(old_cons_a!==last_a || new_cons_a!==last_a || old_cons_b!==last_b || new_cons_b!==last_b)
   $fatal(1,"ADC_NEXT_CONSUMER_WORD_FAIL k=%0d",k);
  checked=checked+1;
  if(sys_rst)reset_checks=reset_checks+1;
  else begin seen_a[word_a[15:2]]=1;seen_b[word_b[15:2]]=1;end
 end
 last_a=expected_a;last_b=expected_b;
end
always@(posedge sys_double_clk or negedge sys_double_clk)begin
 #0.2;
 if(k>20)begin
  if(old_outputs!==new_outputs)$fatal(1,"ANALOG_SETTLED_PAIR_MISMATCH k=%0d",k);
  paired_checks=paired_checks+1;
 end
end
initial begin
 for(k=0;k<32832;k=k+1)begin
  @(posedge clk125_pad);#0.01;
  word_a={k[13:0],k[1:0]};word_b={~k[13:0],~k[1:0]};
  for(i=0;i<16;i=i+1)begin
   adc_data_a[i]<=#(BUFFER+(i%7)*0.1)word_a[i];
   adc_data_b[i]<=#(BUFFER+((15-i)%7)*0.1)word_b[i];
  end
  sys_rst=(k<20 || (k>=16410 && k<16415));
  dac_a=$random(seed);dac_b=$random(seed);
 end
 repeat(2)@(negedge sys_clk);#1;
 if(checked<32800 || reset_checks!=5 || (&seen_a)!==1 || (&seen_b)!==1 || paired_checks<130000)
  $fatal(1,"R63_COVERAGE_FAIL checks=%0d resets=%0d all=%b/%b paired=%0d",checked,reset_checks,&seen_a,&seen_b,paired_checks);
 $display("R63_ANALOG_SAME_WORD_NATIVE_PASS checks=%0d paired=%0d full14bit_both_lanes=1 reset_checks=%0d phi=%0.3f buffer=%0.3f",checked,paired_checks,reset_checks,PHI,BUFFER);
 $finish;
end
initial begin #400000;$fatal(1,"timeout");end
endmodule
