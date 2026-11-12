module scope_average_legacy(input [13:0] raw_i,input [47:0] sum_i,input [31:0] dec_i,input avg_i,output reg [13:0] value_o);
always @* begin case(dec_i & {32{avg_i}})
32'h0: value_o = raw_i;
32'h1: value_o = sum_i[15+0 :  0];
32'h2: value_o = sum_i[15+1 :  1];
32'h4: value_o = sum_i[15+2 :  2];
32'h8: value_o = sum_i[15+3 :  3];
32'h10: value_o = sum_i[15+4 :  4];
32'h20: value_o = sum_i[15+5 :  5];
32'h40: value_o = sum_i[15+6 :  6];
32'h80: value_o = sum_i[15+7 :  7];
32'h100: value_o = sum_i[15+8 :  8];
32'h200: value_o = sum_i[15+9 :  9];
32'h400: value_o = sum_i[15+10: 10];
32'h800: value_o = sum_i[15+11: 11];
32'h1000: value_o = sum_i[15+12: 12];
32'h2000: value_o = sum_i[15+13: 13];
32'h4000: value_o = sum_i[15+14: 14];
32'h8000: value_o = sum_i[15+15: 15];
32'h10000: value_o = sum_i[15+16: 16];
32'h20000: value_o = sum_i[15+17 :  17];
32'h40000: value_o = sum_i[15+18 :  18];
32'h80000: value_o = sum_i[15+19 :  19];
32'h100000: value_o = sum_i[15+20 :  20];
32'h200000: value_o = sum_i[15+21 :  21];
32'h400000: value_o = sum_i[15+22 :  22];
32'h800000: value_o = sum_i[15+23 :  23];
32'h1000000: value_o = sum_i[15+24 :  24];
32'h2000000: value_o = sum_i[15+25 :  25];
32'h4000000: value_o = sum_i[15+26: 26];
32'h8000000: value_o = sum_i[15+27: 27];
32'h10000000: value_o = sum_i[15+28: 28];
32'h20000000: value_o = sum_i[15+29: 29];
32'h40000000: value_o = sum_i[15+30: 30];
32'h80000000: value_o = sum_i[15+31: 31];
default: value_o = sum_i[15+0 :  0];
endcase end
endmodule
