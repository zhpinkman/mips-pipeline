library verilog;
use verilog.vl_types.all;
entity layer_reg_ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        hazard_detected_signal: in     vl_logic;
        WB_en           : in     vl_logic;
        MEM_read        : in     vl_logic;
        MEM_write       : in     vl_logic;
        br_taken        : in     vl_logic;
        WB_en_out       : out    vl_logic;
        MEM_read_out    : out    vl_logic;
        MEM_write_out   : out    vl_logic;
        br_taken_out    : out    vl_logic;
        EXE_function_in : in     vl_logic_vector(1 downto 0);
        EXE_function_out: out    vl_logic_vector(1 downto 0);
        pc_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        reg1            : in     vl_logic_vector(31 downto 0);
        reg2            : in     vl_logic_vector(31 downto 0);
        pc_out          : out    vl_logic_vector(31 downto 0);
        instruction_out : out    vl_logic_vector(31 downto 0);
        reg1_out        : out    vl_logic_vector(31 downto 0);
        reg2_out        : out    vl_logic_vector(31 downto 0)
    );
end layer_reg_ID;
