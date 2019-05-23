module pc_register(input clk, rst,input [9:0] in, output reg[9:0] out);
  always @ (posedge clk , posedge rst)begin
    if(rst) out = 10'b0;
    else begin
      out <= in;
    end
  end
endmodule
