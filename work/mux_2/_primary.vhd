library verilog;
use verilog.vl_types.all;
entity mux_2 is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        c               : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end mux_2;
