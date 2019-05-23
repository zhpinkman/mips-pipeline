module layer_reg(input clk, rst, input[9:0] pc_in, output[9:0] pc_out);
  register #(10)(clk, rst, pc_in, pc_out);
  
endmodule
