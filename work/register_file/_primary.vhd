library verilog;
use verilog.vl_types.all;
entity register_file is
    port(
        clk             : in     vl_logic;
        r1_add          : in     vl_logic_vector(4 downto 0);
        r2_add          : in     vl_logic_vector(4 downto 0);
        write_add       : in     vl_logic_vector(4 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        write_signal    : in     vl_logic;
        r1              : out    vl_logic_vector(31 downto 0);
        r2              : out    vl_logic_vector(31 downto 0)
    );
end register_file;
