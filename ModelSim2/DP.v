`include "configs.v"

module MIPS(input clk , rst);
  wire hazard_detected_signal;
  wire[`ADDRESS_LEN-1:0] pc_address, ID_PC, EXE_PC;
  wire[`WORD_LEN-1:0] instruction, ID_instruction, ID_reg1, ID_reg2;
  wire[`WORD_LEN-1:0] EXE_instruction, EXE_reg1, EXE_reg2, EXE_reg2_store, ALU_result, EXE_ST_value, ALU_src1, ALU_src2;
  wire[`WORD_LEN-1:0] MEM_instruction;
  wire[`WORD_LEN-1:0] WB_instruction;
  wire ID_WB_en, ID_MEM_read, ID_MEM_write, EXE_WB_en, EXE_MEM_read, EXE_MEM_write, EXE_br_taken, zero;
  wire[2:0] ID_EXE_function, EXE_function;
  wire[1:0] forward_signal_mux_1, forward_signal_mux_2_3, ID_is_br;
  wire[`WORD_LEN-1:0] branch_offset, pc_add_value, pc_reg_in2, pc_reg_in, WB_result, MEM_ALU_result, MEM_ST_value, MEM_PC, MEM_out, WB_PC, WB_ALU_result, WB_MEM_out;
  wire immediate_signal, ID_br_mux_control;
  wire[`WORD_LEN-1:0] ID_val2;
  wire[4:0] ID_dest, EXE_dest, MEM_dest, WB_dest;
  
  always @(posedge clk)begin
    $display("IF:%d, ID:%d, EXE:%d, MEM:%d, WB:%d", pc_address, ID_PC, EXE_PC, MEM_PC, WB_PC);
  end
  
  // IF ---------------------
  assign branch_offset = { {16{ID_instruction[15]}},ID_instruction[15:0]};
  mux_2 branch_mux(1, branch_offset , ID_br_mux_control, pc_add_value);
  alu_plus pc_adder(pc_address, pc_add_value , pc_reg_in);
  
  mux_2 jmp_mux(pc_reg_in , {pc_address[31:26],ID_instruction[25:0]} , (ID_is_br==1)/*is jmp*/, pc_reg_in2);
  
  register my_pc(clk, rst, ~hazard_detected_signal, pc_reg_in2, pc_address);
  instruction_mem my_inst(clk, pc_address, instruction);
  
  
  layer_reg IF2ID(.clk(clk), .rst(rst), .hazard_detected_signal(hazard_detected_signal), .pc_in(pc_address), 
                  .instruction_in(instruction), .pc_out(ID_PC), .instruction_out(ID_instruction),
                  .freeze(hazard_detected_signal), .flush(ID_br_taken)
                  );
  
  // ID ---------------------
  
  register_file my_reg_file(clk, ID_instruction[25:21], ID_instruction[20:16], WB_dest, WB_result, WB_en, ID_reg1, ID_reg2);
  assign ID_br_taken = (ID_is_br==1)?1: //JMP
                       ((ID_is_br==2)&&(ID_reg1==ID_reg2))?1: //BEQ
                       ((ID_is_br==3)&&(ID_reg1!=ID_reg2))?1: //BNE
                        0;
  assign ID_br_mux_control = 
                       ((ID_is_br==2)&&(ID_reg1==ID_reg2))?1: //BEQ
                       ((ID_is_br==3)&&(ID_reg1!=ID_reg2))?1: //BNE
                        0;
  mux_2 reg2ORimmediate(ID_reg2, { {16{ID_instruction[15]}},ID_instruction[15:0]} /*LW SW offset to be added to reg1*/, immediate_signal, ID_val2);
  assign ID_dest = (ID_instruction[31:26]==6'b100011)?ID_instruction[20:16]:ID_instruction[15:11];
  layer_reg_ID ID2EXE(.clk(clk), .rst(rst), .hazard_detected_signal(hazard_detected_signal), .WB_en(ID_WB_en), .MEM_read(ID_MEM_read), .MEM_write(ID_MEM_write), .br_taken(ID_br_taken), .ID_dest(ID_dest), .EXE_dest(EXE_dest), 
  .WB_en_out(EXE_WB_en), .MEM_read_out(EXE_MEM_read), .MEM_write_out(EXE_MEM_write), .br_taken_out(EXE_br_taken), .EXE_function_in(ID_EXE_function), .EXE_function_out(EXE_function),  .pc_in(ID_PC), .instruction_in(ID_instruction), .reg1(ID_reg1), .reg2(ID_val2), .pc_out(EXE_PC), .instruction_out(EXE_instruction), .reg1_out(EXE_reg1), .reg2_out(EXE_reg2), .reg2_pure_in(ID_reg2),.reg2_pure_out(EXE_reg2_store) );
  
  hazard_detection_unit hazard_detector(.ID_src1(ID_instruction[25:21]), .ID_src2(ID_instruction[20:16]), .EXE_dest(EXE_dest), .MEM_dest(MEM_dest), .EXE_MEM_read(EXE_MEM_read), .MEM_MEM_read(MEM_read), .is_br(ID_br_taken), .is_jmp(ID_is_br==1) , .hazard_detected(hazard_detected_signal) );

  
  control_unit controller(ID_instruction, ID_WB_en, ID_MEM_read, ID_MEM_write, ID_EXE_function, ID_is_br, immediate_signal);
  
  //EXE ----------------------
  mux_4 ALU_src1_mux(EXE_reg1, MEM_ALU_result, WB_result , 0, forward_signal_mux_1, ALU_src1);
  mux_4 ALU_src2_mux(EXE_reg2, MEM_ALU_result, WB_result , 0, forward_signal_mux_2_3, ALU_src2);
  mux_4 Store_value_mux(EXE_reg2_store, MEM_ALU_result, WB_result , 0, forward_signal_mux_2_3, EXE_ST_value);
  full_alu ALU(ALU_src1, ALU_src2, EXE_function, ALU_result, zero);
  
  layer_reg_EXE EXE2MEM(.clk(clk), .rst(rst), .WB_en(EXE_WB_en), .MEM_read(EXE_MEM_read), .MEM_write(EXE_MEM_write), 
  .WB_en_out(MEM_WB_en), .MEM_read_out(MEM_read), .MEM_write_out(MEM_write), .pc_in(EXE_PC), .instruction_in(EXE_instruction), .ALU_result(ALU_result), .ST_value(EXE_ST_value), .pc_out(MEM_PC), .instruction_out(MEM_instruction), .ALU_result_out(MEM_ALU_result), .ST_value_out(MEM_ST_value),
  .EXE_dest(EXE_dest), .MEM_dest(MEM_dest)
   );
  //TODO: Forwarding Unit
  forwarding_unit forward_unit(.EXE_src1(EXE_instruction[25:21]), .EXE_src2(EXE_instruction[20:16]), .EXE_dest(EXE_dest), .WB_dest(WB_dest), .MEM_dest(MEM_dest), .EXE_MEM_write(EXE_MEM_write), .WB_en(WB_en), .MEM_WB_en(MEM_WB_en), .forward_signal_mux_1(forward_signal_mux_1), .forward_signal_mux_2_3(forward_signal_mux_2_3));

  
  //MEM ----------------------
  memory mem(clk, MEM_ALU_result, MEM_out, MEM_ST_value, MEM_read, MEM_write);
  layer_reg_MEM MEM2WB(.clk(clk), .rst(rst), .WB_en(MEM_WB_en), .MEM_read(MEM_read), .WB_en_out(WB_en), .MEM_read_out(WB_MEM_read), .pc_in(MEM_PC), .instruction_in(MEM_instruction), .ALU_result(MEM_ALU_result), .MEM_out(MEM_out), 
  .pc_out(WB_PC), .instruction_out(WB_instruction), .ALU_result_out(WB_ALU_result), .WB_MEM_out(WB_MEM_out), 
  .MEM_dest(MEM_dest), .WB_dest(WB_dest)
   );
  
  //WB ------------------------
  mux_2 m2(WB_ALU_result, WB_MEM_out, WB_MEM_read, WB_result);
  
  
endmodule

