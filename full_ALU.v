module full_alu(input [15:0] a, b, output reg[15:0] out, input [2:0] controll, output reg zero);
  always @(a, b, controll) begin
    out = 31'b0;
    zero = 1'b0;
    case (controll)
      0: out = a; // move Rj to Ri
      1: out = a + b;
      2: out = a - b;
      3: out = b - a;
      4: out = a & b;
      5: out = a | b;
      6: out = !(a);
      7: out = a; // no operation
    endcase
    if( out == 16'b0 )
          zero = 1'b1;
  end
endmodule