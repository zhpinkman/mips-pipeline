library verilog;
use verilog.vl_types.all;
entity forwarding_unit is
    port(
        EXE_src1        : in     vl_logic_vector(4 downto 0);
        EXE_src2        : in     vl_logic_vector(4 downto 0);
        EXE_dest        : in     vl_logic_vector(4 downto 0);
        WB_dest         : in     vl_logic_vector(4 downto 0);
        MEM_dest        : in     vl_logic_vector(4 downto 0);
        EXE_MEM_write   : in     vl_logic;
        WB_en           : in     vl_logic;
        MEM_WB_en       : in     vl_logic;
        forward_signal_mux_1: out    vl_logic_vector(1 downto 0);
        forward_signal_mux_2_3: out    vl_logic_vector(1 downto 0)
    );
end forwarding_unit;
