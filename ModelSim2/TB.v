`timescale 1ns/1ns
module TB();
	reg clk=0, rst=0;

	MIPS my_mips(clk, rst);


	
	always #10 clk = ~clk; //50MHz


	initial begin
		rst = 1;
	  #33;
		rst = 0;
	  #10000;
    
	  $stop;

		
	end

endmodule





