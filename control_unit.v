`include "configs.v"

module control_unit(input[`WORD_LEN-1:0] instruction, output reg WB_en, MEM_read, MEM_write, output reg[1:0] EXE_function, is_br);
  always @(*)begin
    {WB_en, MEM_read, MEM_write} = 0;
    case(instruction[31:26])
      
      6'b000000:begin //RTYPE
        WB_en = 1;
        case(instruction[5:0])
          6'b100000: EXE_function = 0; //ADD
          6'b100010: EXE_function = 1; //SUB
          6'b100100: EXE_function = 2; //AND
          6'b100001: EXE_function = 3; //OR
        endcase
      end
      
      6'b100011: begin MEM_read = 1; WB_en = 1;  end //LW
      6'b101011: MEM_write = 1; //SW
      
      6'b000010: is_br = 1; //JMP
      
      6'b000100: is_br = 2; //BEQ
      6'b000101: is_br = 3; //BNE
      
      
    endcase
    
  end
endmodule