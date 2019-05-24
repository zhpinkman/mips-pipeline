library verilog;
use verilog.vl_types.all;
entity full_alu is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        control         : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic
    );
end full_alu;
