`include "configs.v"

module memory (input clk, input [`ADDRESS_LEN-1:0] adr, output reg[`WORD_LEN-1:0] out,input[`WORD_LEN-1:0] write_data, input mem_read, mem_write);
  reg [`WORD_LEN-1:0] regs [0:`MEMORY_SIZE-1];
  initial begin
    regs[500] = 32'b0000000000000001;
    regs[501] = 32'b0000000000000010;
    regs[502] = 32'b0000000000000011;
    regs[503] = 32'b0000000000000100;
    regs[504] = 32'b0000000000000101;
    regs[505] = 32'b0000000000000110;
    regs[506] = 32'b0000000000000111;
    regs[507] = 32'b0000000000001000;
    regs[508] = 32'b0000000000001001;
    regs[509] = 32'b0000000000001010;
  end
  always @(posedge clk) begin : write
    if(mem_write == 1'b1)begin
      regs[adr] <= write_data;
      $display(write_data);
    end
  end
  always @(adr, mem_read, mem_write) begin
    if(mem_read == 1'b1)
      out =  regs[adr];
    end
endmodule
