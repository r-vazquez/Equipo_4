module ALU_Decoder
(
	input 		[1:0]	ALU_Op,
	input 		[5:0]	Funct,
	
	output reg	[2:0]	ALU_Control
);

	localparam	add = 8'b00_100000,
					addi = 8'b00_xxxxxx;	
	
	
	always@({ALU_Op,Funct}) begin
		casex({ALU_Op,Funct})
			add	:	ALU_Control = 3'b000;

			addi	:	ALU_Control = 3'b000;
		endcase
	end
endmodule
