module MIPS_Processor
(
	input 			MAX10_CLK1_50,
	input 	[9:9] SW,
	
	output	[7:0]	LEDR
);

	wire clk;

	cont_1s_RCO	clock	(
								.mclk 	(MAX10_CLK1_50),
								.reset	(SW),
								.RCO		(clk)
							);

	MIPS_Multi_Cycle	MIPS	(
										.clk			(clk),
										.reset		(SW),
										.GPIO_Out	(LEDR)
									);
endmodule
