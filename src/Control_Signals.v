module Control_Signals
(
	input 			clk,
	input 			reset,
	input		[5:0]	Op,
		
	output  			PC_Write,
	output			I_or_D,
	output 			Mem_Write,
	output 			IR_Write,
	output 			Reg_Dst,
	output 			Mem_to_Reg,
	output 			Reg_Write,
	output 			ALU_Src_A,
	output 	[1:0]	ALU_Src_B,
	output 	[1:0]	ALU_Op,
	output 			PC_Src
);

	localparam	IF = 4'b0000,
					ID = 4'b0001,
					EX_R = 4'b0010,
					EX_I = 4'b0011,
					WB_R = 4'b0100,
					WB_I = 4'b0101;
							
	reg	[3:0]		state;
	reg	[3:0]		next_state;
	reg	[12:0]	control_bus;
	
	always@(posedge clk) begin
		if(!reset) state <= IF; 
		else state <= next_state;
	end
	
	always@(state or Op) begin
		control_bus = 13'b0_0_0_0_0_0_0_0_00_00_0;
		case (state)
			IF	:	begin
						control_bus = 13'b1_0_0_1_0_0_0_0_01_00_0;
						/*PC_Write = 1'b1;
						I_or_D = 1'b0;
						Mem_Write = 1'b0;
						IR_Write = 1'b1;
						Reg_Dst = 1'b0;
						Mem_to_Reg = 1'b0;
						Reg_Write = 1'b0;
						ALU_Src_A = 1'b0;
						ALU_Src_B = 2'b01;
						ALU_Control = 3'b000;
						PC_Src = 1'b0;*/
					
						next_state = ID;
					end
						
			
			ID		:	begin
							control_bus = 13'b0_0_0_0_0_0_0_0_11_00_0;
							/*PC_Write = 1'b0;
							IR_Write = 1'b0;
							ALU_Src_B = 2'b11;*/
							next_state = (!Op) ? EX_R : EX_I;  
						end
			
			EX_R	:	begin
							control_bus = 13'b0_0_0_0_0_0_0_1_00_00_0;
							/*ALU_Src_A = 1'b1;
							ALU_Src_B = 2'b00;
							ALU_Control = 3'b000;*/
							
							next_state = WB_R;
						end

			EX_I	: 	begin
							control_bus = 13'b0_0_0_0_0_0_0_1_10_00_0;
							/*ALU_Src_A = 1'b1;
							ALU_Src_B = 2'b10;
							ALU_Control = 3'b000;*/
							
							next_state = WB_I;
						end

			WB_R	:	begin
							control_bus = 13'b0_0_0_0_1_0_1_1_00_00_0;
							/*Reg_Dst = 1'b1;
							Mem_to_Reg = 1'b0;
							Reg_Write = 1'b1;*/
						
							next_state = IF;
						end
								
			WB_I	:	begin
							control_bus = 13'b0_0_0_0_0_0_1_1_00_00_0;
							/*Reg_Dst = 1'b0;
							Mem_to_Reg = 1'b0;
							Reg_Write = 1'b1;*/
						
							next_state = IF;
						end
			
			default	:	next_state = IF;
		endcase
	end
	
	assign PC_Write = control_bus[12];
	assign I_or_D = control_bus[11];
	assign Mem_Write = control_bus[10];
	assign IR_Write = control_bus[9];
	assign Reg_Dst = control_bus[8];
	assign Mem_to_Reg = control_bus[7];
	assign Reg_Write = control_bus[6];
	assign ALU_Src_A = control_bus[5];
	assign ALU_Src_B = control_bus[4:3];
	assign ALU_Op = control_bus[2:1];
	assign PC_Src = control_bus[0];
	
endmodule
