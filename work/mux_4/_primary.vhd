library verilog;
use verilog.vl_types.all;
entity mux_4 is
    port(
        a               : in     vl_logic_vector(9 downto 0);
        b               : in     vl_logic_vector(9 downto 0);
        c               : in     vl_logic_vector(9 downto 0);
        d               : in     vl_logic_vector(9 downto 0);
        controll        : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(9 downto 0)
    );
end mux_4;
