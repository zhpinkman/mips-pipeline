library verilog;
use verilog.vl_types.all;
entity layer_reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        hazard_detected_signal: in     vl_logic;
        pc_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        pc_out          : out    vl_logic_vector(31 downto 0);
        instruction_out : out    vl_logic_vector(31 downto 0)
    );
end layer_reg;
