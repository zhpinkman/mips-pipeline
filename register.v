module register #(parameter n = 8)(input clk, rst,input [n-1:0] in, output reg[n-1:0] out);
  always @ (posedge clk , posedge rst)begin
    if(rst) out = 0;
    else
      out <= in;
  end
endmodule

