library verilog;
use verilog.vl_types.all;
entity DP is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        write_signal    : in     vl_logic;
        sel_immediate   : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        sel_write_data  : in     vl_logic;
        reg_window      : in     vl_logic_vector(1 downto 0);
        sel_pc          : in     vl_logic_vector(1 downto 0);
        ALU_control     : in     vl_logic_vector(2 downto 0);
        ALU_zero        : out    vl_logic;
        instruction_opcode: out    vl_logic_vector(3 downto 0);
        instruction_function: out    vl_logic_vector(7 downto 0)
    );
end DP;
