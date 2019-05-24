library verilog;
use verilog.vl_types.all;
entity instruction_mem is
    port(
        clk             : in     vl_logic;
        adr             : in     vl_logic_vector(31 downto 0);
        inst            : out    vl_logic_vector(31 downto 0)
    );
end instruction_mem;
