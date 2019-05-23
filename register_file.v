module register_file(input clk, input [1:0] r1_add, r2_add, en_wind, input[15:0] write_data, input write_signal, output reg[15:0] r1, r2);
  reg [15:0] regs [0:7] ;
  initial begin
    regs[0]  = 16'b0;
    regs[1]  = 16'b0;
    regs[2]  = 16'b0;
    regs[3]  = 16'b0;
    regs[4]  = 16'b0;
    regs[5]  = 16'b0;
    regs[6]  = 16'b0;
    regs[7]  = 16'b0;
  end
  always @(r1_add, r2_add, en_wind, write_signal, write_data) begin : read
    r1 = regs[( 2*en_wind + r1_add) % 8];
    r2 = regs[( 2*en_wind + r2_add) % 8];
  end
  always @(posedge clk) begin : write
    if(write_signal == 1'b1) begin
      regs[(2*en_wind + r1_add)%8] <= write_data; // always writing on the Ri (first input)
      $display(regs[0], regs[1],regs[3], regs[4], regs[6]);
      $display(write_data);
    end
  end
endmodule 
