`include "configs.v"
module mux_2(input [`WORD_LEN-1:0] a, b, input c, output reg[`WORD_LEN-1:0] out);
  always @(a, b, c) begin
    out = `WORD_LEN'b0;
    if(c == 1'b0)
      out = a;
    else if(c == 1'b1)
      out = b;
  end
endmodule