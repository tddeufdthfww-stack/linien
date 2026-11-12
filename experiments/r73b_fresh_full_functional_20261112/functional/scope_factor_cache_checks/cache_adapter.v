module scope_factor_cache_adapter(input [13:0] raw_i,input [47:0] sum_i,
 input [31:0] dec_i,input avg_i,output [13:0] value_o);
 wire [4:0] sh;wire z;
 scope_dec_factor_decode decode(dec_i,sh,z);
 scope_average_cached select(raw_i,sum_i,sh,z,avg_i,value_o);
endmodule
