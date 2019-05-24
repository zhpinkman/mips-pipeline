`include "configs.v"

module instruction_mem(input clk, input [`ADDRESS_LEN-1:0] adr, output reg[`WORD_LEN-1:0] inst);
  reg [`WORD_LEN-1:0] regs[0:`MEMORY_SIZE-1];
  reg [`ADDRESS_LEN-1:0] cnt = 0;
  initial begin
 
  
  regs[0] = 16'b1100010100010001;
  regs[1] = 16'b0001010111110100;
  regs[2] = 16'b0000000111110100;
  regs[3] = 16'b1000000000000010;
  regs[4] = 16'b0001000111111110;
  regs[5] = 16'b0010110000000111;
  regs[6] = 16'b0000000111110100;
  regs[7] = 16'b1100101000010001;
  regs[8] = 16'b0100100100001010;
  regs[9] = 16'b0000000111110100;
  regs[10] = 16'b1000110000000010;
  regs[11] = 16'b1000011110000001;
  regs[12] = 16'b1100010100000011;
  regs[13] = 16'b1100101000010100;
  regs[14] = 16'b1101101000001101;
  regs[15] = 16'b1000011000001000;
  regs[16] = 16'b1000100100000100;
  regs[17] = 16'b1101010100000010;
  regs[18] = 16'b1110010100010010;
  regs[19] = 16'b1111010100011000;
  regs[20] = 16'b0001010111110100;
  regs[21] = 16'b1000110100000010;
  regs[22] = 16'b1000100110000010;
  regs[23] = 16'b1100100100000000;
  regs[24] = 16'b1000101110000011;
  regs[25] = 16'b1000110000000010;
  end
  
  always @(adr) begin
    inst = regs[adr];
  end
endmodule