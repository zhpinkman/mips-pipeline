`include "configs.v"

module full_alu(input [`WORD_LEN-1:0] a, b, input [2:0] control, output reg[`WORD_LEN-1:0] out, output reg zero);
  always @(a, b, control) begin
    out = 31'b0;
    zero = 1'b0;
    case (control)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = a | b;
      4: begin
        if(a<b)
          out = 1;
        else
          out = 0;
      end
    endcase
    if( out == `WORD_LEN'b0 )
          zero = 1'b1;
    $display("ALU %d,%d = %d", a, b, out);
  end
endmodule