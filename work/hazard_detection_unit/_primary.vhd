library verilog;
use verilog.vl_types.all;
entity hazard_detection_unit is
    port(
        ID_src1         : in     vl_logic_vector(4 downto 0);
        ID_src2         : in     vl_logic_vector(4 downto 0);
        EXE_dest        : in     vl_logic_vector(4 downto 0);
        MEM_dest        : in     vl_logic_vector(4 downto 0);
        EXE_MEM_read    : in     vl_logic;
        MEM_MEM_read    : in     vl_logic;
        is_br           : in     vl_logic;
        is_jmp          : in     vl_logic;
        hazard_detected : out    vl_logic
    );
end hazard_detection_unit;
