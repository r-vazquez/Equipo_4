module Mux4x1
#
(
	parameter N = 32
)
(
	input			[1:0]		Selector,
	input			[N-1:0]	I_0,
	input			[N-1:0]	I_1,
	input			[N-1:0]	I_2,
	input			[N-1:0]	I_3,
	
	output reg 	[N-1:0]	Mux_Out
);

	always@(*) begin
		case (Selector)
			0	:	Mux_Out = I_0;
			1	:	Mux_Out = I_1;
			2	:	Mux_Out = I_2;
			3	:	Mux_Out = I_3;
		endcase	
	end	
endmodule
