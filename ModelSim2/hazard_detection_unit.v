`include "configs.v"

module hazard_detection_unit(input[4:0] ID_src1, ID_src2, EXE_dest, MEM_dest, input EXE_MEM_read, MEM_MEM_read, is_br,is_jmp, output hazard_detected );
    assign hazard_detected = (
                               ( EXE_MEM_read && (ID_src1==EXE_dest || ID_src2==EXE_dest) )
                             //||( MEM_MEM_read && (ID_src1==MEM_dest || ID_src2==MEM_dest) )
                             );
endmodule
