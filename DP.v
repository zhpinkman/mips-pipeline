module DP(input rst, clk, write_signal, sel_immediate, mem_read, mem_write, sel_write_data, input[1:0] reg_window, sel_pc, input[2:0] ALU_control, output ALU_zero, output[3:0] instruction_opcode, output[7:0] instruction_function);
  wire[9:0] pc_load, pc_out, pc_plus_out;
  wire[15:0] instruction, immediate_data;
  wire[15:0] out_reg_i, out_reg_j, ALU_mux_in, ALU_out, mem_out, reg_write_data;
  
  assign instruction_opcode = instruction[15:12];
  assign instruction_function = instruction[7:0];
  
  pc_register my_pc(clk, rst, pc_load, pc_out);
  instruction_mem my_inst(clk, pc_out, 1'b0, 16'b0, instruction);
  
  
  register_file my_reg(clk, instruction[11:10], instruction[9:8], reg_window, reg_write_data, write_signal, out_reg_i, out_reg_j);

  sign_extender my_se(instruction[7:0], immediate_data);
  mux_2 my_m(out_reg_i, immediate_data, sel_immediate, ALU_mux_in);
  
  full_alu my_alu(out_reg_j, ALU_mux_in, ALU_out, ALU_control, ALU_zero);
  
  memory my_mem(clk, instruction[9:0], mem_out, out_reg_i, mem_read, mem_write);
  mux_2 my_m2(ALU_out, mem_out, sel_write_data, reg_write_data);
  
  alu_plus alu_p(pc_out, 10'b0000000001, pc_plus_out);
  mux_4 my_m4(pc_plus_out, {pc_out[9:8], instruction[7:0]}, instruction[9:0], 10'b0, sel_pc, pc_load);
  
endmodule
