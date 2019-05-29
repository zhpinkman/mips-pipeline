`include "configs.v"

module memory (input clk, input [`ADDRESS_LEN-1:0] adr, output reg[`WORD_LEN-1:0] out,input[`WORD_LEN-1:0] write_data, input mem_read, mem_write);
  reg [`WORD_LEN-1:0] regs [0:`MEMORY_SIZE-1];
  initial begin
    regs[32] = 1;
    regs[33] = 10;
    
    regs[0] = 333;
    regs[1] = 334;
    regs[2] = 335;
    regs[3] = 300;
    regs[4] = 4;
    regs[5] = 15;
    regs[6] = 41;
    regs[7] = 14;
    regs[8] = 2;
    regs[9] = 0;
    regs[10] = 6;
    regs[11] = 9;
    
    regs[250] = 20;
    regs[251] = 10;
    regs[252] = 200;
    regs[253] = 100;
    regs[254] = 234;
    regs[255] = 555;
    regs[256] = 111;
    regs[257] = 355;
    regs[258] = 111;
    
    regs[1000] = 10;
    regs[1001] = 20;
    regs[1002] = 200;
    regs[1003] = 100;
    regs[1004] = 234;
    regs[1005] = 555;
    regs[1006] = 111;
    regs[1007] = 355;
    regs[1008] = 111;
    
    regs[1000] = 7;
    regs[503] = 32'b0000000000000100;
    regs[504] = 32'b0000000000000101;
    regs[505] = 32'b0000000000000110;
    regs[506] = 32'b0000000000000111;
    regs[507] = 32'b0000000000001000;
    regs[508] = 32'b0000000000001001;
    regs[509] = 32'b0000000000001010;
  end
  reg[1024:0] i;
  always @(negedge clk) begin : write
    if(mem_write == 1)begin
      regs[adr] = write_data;
      $display("WRITE mem[%d] = %d", adr, write_data);
    end
  end
  always @(adr, mem_read, mem_write) begin
    if(mem_read == 1)
      out <= regs[adr];
      $display("READ mem[1%d] = %d", adr, regs[adr]);
      for(i=0; i<11; i=i+1)
        $display("Mem[%d] = %d", i, regs[i]);
    end
endmodule
