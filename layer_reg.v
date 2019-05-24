`include "configs.v"

module layer_reg(input clk, rst, hazard_detected_signal, input[`ADDRESS_LEN-1:0] pc_in, instruction_in, output reg [`ADDRESS_LEN-1:0] pc_out, instruction_out);
  always@(posedge clk, posedge rst)begin
    if(hazard_detected_signal)begin
      {pc_out, instruction_out} <= 0;
    end
    else begin
      pc_out <= pc_in;
      instruction_out <= instruction_in;
    end
  end
  
endmodule


module layer_reg_ID(input clk, rst, hazard_detected_signal, WB_en, MEM_read, MEM_write, br_taken, output reg WB_en_out, MEM_read_out, MEM_write_out, br_taken_out, input[1:0]EXE_function_in, output reg[1:0]EXE_function_out,  input[`ADDRESS_LEN-1:0] pc_in, instruction_in, reg1, reg2, output reg [`ADDRESS_LEN-1:0] pc_out, instruction_out, reg1_out, reg2_out );
  always@(posedge clk, posedge rst)begin
    if(rst)begin
      pc_out <= 0;
      instruction_out <= 0;
    end
    else begin
      pc_out <= pc_in;
      instruction_out <= instruction_in;
      br_taken_out <= br_taken;
      EXE_function_out <= EXE_function_in;
      reg1_out <= reg1;
      reg2_out <= reg2;
      if(hazard_detected_signal)begin
        WB_en_out <= 0;
        MEM_read_out <= 0;
        MEM_write_out <= 0;
      end
      else begin
        WB_en_out <= WB_en;
        MEM_read_out <= MEM_read;
        MEM_write_out <= MEM_write;
      end
    end
  end
  
endmodule


module layer_reg_EXE(input clk, rst, WB_en, MEM_read, MEM_write, output reg WB_en_out, MEM_read_out, MEM_write_out, input[`ADDRESS_LEN-1:0] pc_in, instruction_in, ALU_result, ST_value, output reg [`ADDRESS_LEN-1:0] pc_out, instruction_out, ALU_result_out, ST_value_out );
  always@(posedge clk, posedge rst)begin
    if(rst)begin
      pc_out <= 0;
      instruction_out <= 0;
    end
    else begin
      pc_out <= pc_in;
      instruction_out <= instruction_in;
      WB_en_out <= WB_en;
      MEM_read_out <= MEM_read;
      MEM_write_out <= MEM_write;
      ALU_result_out <= ALU_result;
      ST_value_out <= ST_value;
    end
  end
  
endmodule

module layer_reg_MEM(input clk, rst, WB_en, MEM_read, output reg WB_en_out, MEM_read_out, input[`ADDRESS_LEN-1:0] pc_in, instruction_in, ALU_result, MEM_out, output reg [`ADDRESS_LEN-1:0] pc_out, instruction_out, ALU_result_out, WB_MEM_out );
  always@(posedge clk, posedge rst)begin
    if(rst)begin
      pc_out <= 0;
      instruction_out <= 0;
    end
    else begin
      pc_out <= pc_in;
      instruction_out <= instruction_in;
      WB_en_out <= WB_en;
      MEM_read_out <= MEM_read;
      ALU_result_out <= ALU_result;
      WB_MEM_out <= MEM_out;
    end
  end
  
endmodule