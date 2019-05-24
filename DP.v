`include "configs.v"

module MIPS(input clk , rst);
  wire hazard_detected_signal;
  wire[`ADDRESS_LEN-1:0] pc_load, pc_address, pc_plus_out, ID_PC, EXE_PC;
  wire[`WORD_LEN-1:0] instruction, ID_instruction, ID_reg1, ID_reg2;
  wire[`WORD_LEN-1:0] EXE_instruction, EXE_reg1, EXE_reg2, ALU_result, EXE_ST_val, ALU_src1, ALU_src2;
  wire ID_WB_en, ID_MEM_read, ID_MEM_write, EXE_WB_en, EXE_MEM_read, EXE_MEM_write, EXE_br_taken, zero;
  wire[1:0] ID_EXE_function, EXE_function, ID_is_br, forwarding_mux_control;
  
  // IF ---------------------
  mux_2 branch_mux(4, offset, br_taken, pc_add_value);
  alu_plus pc_adder(pc_address, pc_add_value , pc_reg_in);
  register my_pc(clk, rst, hazard_detected_signal, pc_reg_in, pc_address);
  instruction_mem my_inst(clk, pc_address, instruction);
  
  layer_reg IF2ID(.clk(clk), .rst(rst), .hazard_detected_signal(hazard_detected_signal), .pc_in(pc_address), 
                  .instruction_in(instruction), .pc_out(ID_PC), .instruction_out(ID_instruction));
  
  // ID ---------------------
  
  register_file my_reg_file(clk, ID_instruction[25:21], ID_instruction[20:16], ID_instruction[15:11], WB_result, WB_en, ID_reg1, ID_reg2);
  assign ID_br_taken = (ID_is_br==1)?1: //JMP
                       (ID_is_br==2)&&(ID_reg1==ID_reg2)?1: //BEQ
                       (ID_is_br==3)&&(ID_reg1!=ID_reg2)?1: //BNE
                        0;
                        
  layer_reg_ID ID2EXE(.clk(clk), .rst(rst), .hazard_detected_signal(hazard_detected_signal), .WB_en(ID_WB_en), .MEM_read(ID_MEM_read), .MEM_write(ID_MEM_write), .br_taken(ID_br_taken), .WB_en_out(EXE_WB_en), .MEM_read_out(EXE_MEM_read), .MEM_write_out(EXE_MEM_write), .br_taken_out(EXE_br_taken), .EXE_function_in(ID_EXE_function), .EXE_function_out(EXE_function),  .pc_in(ID_PC), .instruction_in(ID_instruction), .reg1(ID_reg1), .reg2(ID_reg2), .pc_out(EXE_pc), .instruction_out(EXE_instruction), .reg1_out(EXE_reg1), .reg2_out(EXE_reg2) );
  //TODO: HAZARD UNIT
  
  control_unit controller(ID_instruction, ID_WB_en, ID_MEM_read, ID_MEM_write, ID_EXE_function, ID_is_br);
  
  //EXE ----------------------
  mux_4 ALU_src1_mux(EXE_reg1, MEM_ALU_result, WB_result , 0, forwarding_mux_control, ALU_src1);
  mux_4 ALU_src2_mux(EXE_reg2, MEM_ALU_result, WB_result , 0, forwarding_mux_control, ALU_src2);
  mux_4 Store_value_mux(EXE_reg2, MEM_ALU_result, WB_result , 0, forwarding_mux_control, EXE_ST_val);
  full_alu ALU(ALU_src1, ALU_src2, EXE_function, ALU_result, zero);
  
  layer_reg_EXE EXE2MEM(.clk(clk), .rst(rst), .WB_en(EXE_WB_en), .MEM_read(EXE_MEM_read), .MEM_write(EXE_MEM_write), .WB_en_out(MEM_WB_en), .MEM_read_out(MEM_read), .MEM_write_out(MEM_write), .pc_in(EXE_PC), .instruction_in(EXE_instruction), .ALU_result(ALU_result), .ST_value(ST_value), .pc_out(MEM_PC), .instruction_out(MEM_instruction), .ALU_result_out(MEM_ALU_result), .ST_value_out(MEM_ST_value) );
  //TODO: Forwarding Unit
  
  //MEM ----------------------
  memory mem(clk, MEM_ALU_result, MEM_out, MEM_ST_vale, MEM_read, MEM_write);
  layer_reg_MEM MEM2WB(.clk(clk), .rst(rst), .WB_en(MEM_WB_en), .MEM_read(MEM_read), .WB_en_out(WB_en), .MEM_read_out(WB_MEM_read), .pc_in(MEM_PC), .instruction_in(MEM_instruction), .ALU_result(MEM_ALU_result), .MEM_out(MEM_out), .pc_out(WB_PC), .instruction_out(WB_instruction), .ALU_result_out(WB_ALU_result), .WB_MEM_out(WB_MEM_out) );
  
  //WB ------------------------
  mux_2 m2(WB_MEM_out, WB_ALU_result, WB_MEM_read, WB_result);
  
  
endmodule
