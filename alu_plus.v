`include "configs.v"

module alu_plus(input [`ADDRESS_LEN-1:0] a, b , output [`ADDRESS_LEN-1:0]out);
  assign out = a + b;
endmodule