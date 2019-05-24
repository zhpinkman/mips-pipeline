`include "configs.v"
module mux_4(input [`WORD_LEN-1:0] a, b, c, d, input [1:0] control, output reg[`WORD_LEN-1:0] out);
  always @(a, b, c, d, control) begin
    out = `WORD_LEN-1'b0;
    if(control == 2'b00)
      out = a;
    else if(control == 2'b01)
      out = b;
    else if(control == 2'b10)
      out = c;
    else if(control == 2'b11)
      out = d;
  end
endmodule
