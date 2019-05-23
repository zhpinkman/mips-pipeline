module mux_4(input [9:0] a, b, c, d, input [1:0] controll, output reg[9:0] out);
  always @(a, b, c, d, controll) begin
    out = 10'b0;
    if(controll == 2'b00)
      out = a;
    else if(controll == 2'b01)
      out = b;
    else if(controll == 2'b10)
      out = c;
    else if(controll == 2'b11)
      out = d;
  end
endmodule
