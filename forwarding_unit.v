`include "configs.v"

module forwarding_unit(input[4:0] EXE_src1, EXE_src2, EXE_dest, WB_dest, MEM_dest, input EXE_MEM_write, WB_en, MEM_WB_en, output reg[1:0] forward_signal_mux_1, forward_signal_mux_2_3);
  always@(*)begin
    forward_signal_mux_1 = 0;
    forward_signal_mux_2_3 = 0;
    if(MEM_WB_en && MEM_dest==EXE_src1 && MEM_dest!=0)begin
      forward_signal_mux_1 = 1;
    end
    if(MEM_WB_en && MEM_dest==EXE_src2 && MEM_dest!=0)begin
      forward_signal_mux_2_3 = 1;
    end
    if(WB_en && WB_dest==EXE_src1 && WB_dest!=0)begin
      forward_signal_mux_1 = 2;
    end
    if(WB_en && WB_dest==EXE_src2 && WB_dest!=0)begin
      forward_signal_mux_2_3 = 2;
    end
    
  end
  
endmodule