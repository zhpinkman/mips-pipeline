library verilog;
use verilog.vl_types.all;
entity layer_reg_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        WB_en           : in     vl_logic;
        MEM_read        : in     vl_logic;
        WB_en_out       : out    vl_logic;
        MEM_read_out    : out    vl_logic;
        pc_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        ALU_result      : in     vl_logic_vector(31 downto 0);
        MEM_out         : in     vl_logic_vector(31 downto 0);
        pc_out          : out    vl_logic_vector(31 downto 0);
        instruction_out : out    vl_logic_vector(31 downto 0);
        ALU_result_out  : out    vl_logic_vector(31 downto 0);
        WB_MEM_out      : out    vl_logic_vector(31 downto 0)
    );
end layer_reg_MEM;
