library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        WB_en           : out    vl_logic;
        MEM_read        : out    vl_logic;
        MEM_write       : out    vl_logic;
        EXE_function    : out    vl_logic_vector(1 downto 0);
        is_br           : out    vl_logic_vector(1 downto 0)
    );
end control_unit;
