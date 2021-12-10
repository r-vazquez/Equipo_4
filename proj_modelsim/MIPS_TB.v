module MIPS_TB;

reg	clk_tb = 0;
reg	reset_tb;

wire 	[7:0] GPIO_o_tb;


MIPS_Multi_Cycle	DUT	(
									.clk			(clk_tb),
									.reset		(reset_tb),
									.GPIO_Out	(GPIO_o_tb)
								);

/*********************************************************/
initial begin // Clock generator
	forever #2 clk_tb = !clk_tb;
end
/*********************************************************/

initial begin		
	#0 	reset_tb = 0;
	#1 	reset_tb = 1;
end

endmodule
