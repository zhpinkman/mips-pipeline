library verilog;
use verilog.vl_types.all;
entity pc_register is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \in\            : in     vl_logic_vector(9 downto 0);
        \out\           : out    vl_logic_vector(9 downto 0)
    );
end pc_register;
