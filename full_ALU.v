`include "configs.v"

module full_alu(input [`WORD_LEN-1:0] a, b, input [1:0] control, output reg[`WORD_LEN-1:0] out, output reg zero);
  always @(a, b, control) begin
    out = 31'b0;
    zero = 1'b0;
    case (control)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = a | b;
    endcase
    if( out == `WORD_LEN'b0 )
          zero = 1'b1;
  end
endmodule