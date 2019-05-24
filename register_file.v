`include "configs.v"

module register_file(input clk, input [4:0] r1_add, r2_add, write_add, input[`WORD_LEN-1:0] write_data, input write_signal, output[`WORD_LEN-1:0] r1, r2);
  reg [`WORD_LEN-1:0] regs [0:31] ;
  initial begin
    regs[0]  = 32'b0;
  end

  always @(negedge clk) begin : write
    if(write_signal == 1'b1) begin
      regs[write_add] <= write_data;
      //$display(regs[0], regs[1],regs[3], regs[4], regs[6]);
      //$display(write_data);
    end
    regs[0] <= 32'b0;
  end
  
  assign r1 = regs[r1_add];
  assign r2 = regs[r2_add];
endmodule 
