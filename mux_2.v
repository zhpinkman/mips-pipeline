module mux_2(input [15:0] a, b, input c, output reg[15:0] out);
  always @(a, b, c) begin
    out = 16'b0;
    if(c == 1'b0)
      out = a;
    else if(c == 1'b1)
      out = b;
  end
endmodule