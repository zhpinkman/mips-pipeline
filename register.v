module register #(parameter n = 8)(input clk, rst, en, input [n-1:0] in, output [n-1:0] out);
  reg[n-1:0] r;
  always @ (posedge clk , posedge rst)begin
    if(rst) r <= 0;
    else
      if(en)
        r <= in;
        
  end
  assign out = r;
endmodule

