library verilog;
use verilog.vl_types.all;
entity alu_plus is
    port(
        a               : in     vl_logic_vector(9 downto 0);
        b               : in     vl_logic_vector(9 downto 0);
        \out\           : out    vl_logic_vector(9 downto 0)
    );
end alu_plus;