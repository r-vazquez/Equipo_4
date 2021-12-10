module Data_Path
#
(
	parameter DATA_WIDTH = 32
)
(
	//INPUTS
	input clk,
	input reset,
	
	//OUTPUTS
	output 	[7:0] GPIO_o,
	
	//CONTROL SIGNALS
	input 			PC_Write,
	input 			I_or_D,
	input 			Mem_Write,
	input 			IR_Write,
	input 			Reg_Dst,
	input 			Mem_to_Reg,
	input 			Reg_Write,
	input 			ALU_Src_A,
	input		[1:0]	ALU_Src_B,
	input 	[2:0]	ALU_Control,
	input 			PC_Src,
	
	output	[5:0]	Op,
	output 	[5:0] Funct
);

	wire	[DATA_WIDTH-1:0]	PC_Next;
	wire	[DATA_WIDTH-1:0]	PC;
	wire	[DATA_WIDTH-1:0]	Adr;
	wire	[DATA_WIDTH-1:0]	Read_Data;
	wire	[DATA_WIDTH-1:0]	Instr;
	wire	[DATA_WIDTH-1:0]	Data;
	wire	[4:0]					Write_Register;
	wire	[DATA_WIDTH-1:0]	Write_Data;
	wire	[DATA_WIDTH-1:0]	RD1;
	wire	[DATA_WIDTH-1:0]	RD2;
	wire	[DATA_WIDTH-1:0]	A;
	wire	[DATA_WIDTH-1:0]	B;
	wire	[DATA_WIDTH-1:0]	Sign_Imm;
	wire	[DATA_WIDTH-1:0]	Src_A;
	wire	[DATA_WIDTH-1:0]	Src_B;
	wire	[DATA_WIDTH-1:0]	ALU_Result;
	wire	[DATA_WIDTH-1:0]	ALU_Out;
	

	Register	#
				(
					.RESET_VALUE(32'h400000)
				)
				Program_Counter
				(
					.clk		(clk),
					.reset	(reset),
					.enable	(PC_Write),
					.d(PC_Next),
					//.d			((PC_Next < 32'h400000) ? 32'h400000 : PC_Next),
					.q			(PC)
				);
	
	Mux2x1	Instr_or_Data	(
										.Selector	(I_or_D),
										.I_0			(PC),
										.I_1			(ALU_Out),
										.Mux_Out		(Adr)
									);
			
	Memory_System	ROM_RAM	(
										.clk					(clk),
										.Write_Enable_i	(Mem_Write),
										.Write_Data_i		(B),
										.Address_i			(Adr),
										.Instruction_o		(Read_Data)
									);
	
	Register	Instruction_Register	(
												.clk		(clk),
												.reset	(reset),
												.enable	(IR_Write),
												.d			(Read_Data),
												.q			(Instr)
											);
			
	Register	Data_Register	(
										.clk		(clk),
										.reset	(reset),
										.enable	(1'b1),
										.d			(Read_Data),
										.q			(Data)
									);
									
	Mux2x1	#
				(
					.DATA_WIDTH	(5)
				)
				Rrt_or_Rrd
				(
					.Selector	(Reg_Dst),
					.I_0			(Instr[20:16]),
					.I_1			(Instr[15:11]),
					.Mux_Out		(Write_Register)
				);
	
	Mux2x1	ALUout_or_Data	(
										.Selector	(Mem_to_Reg),
										.I_0			(ALU_Out),
										.I_1			(Data),
										.Mux_Out		(Write_Data)
									);
									
	Register_File	Reg_File	(
										.clk						(clk),
										.reset					(reset),
										.Reg_Write_i			(Reg_Write),
										.Write_Register_i		(Write_Register),
										.Read_Register_1_i	(Instr[25:21]),
										.Read_Register_2_i	(Instr[20:16]),
										.Write_Data_i			(Write_Data),
										.Read_Data_1_o			(RD1),
										.Read_Data_2_o			(RD2)
									);
									
	Register	A_Register	(
									.clk		(clk),
									.reset	(reset),
									.enable	(1'b1),
									.d			(RD1),
									.q			(A)
								);
								
	Register	B_Register	(
									.clk		(clk),
									.reset	(reset),
									.enable	(1'b1),
									.d			(RD2),
									.q			(B)
								);
								
	Sign_Extend	Sign_Ext	(
									.Imm				(Instr[15:0]),
									.Sign_Ext_Imm	(Sign_Imm)
								);
	
	Mux2x1	PC_or_A	(
								.Selector	(ALU_Src_A),
								.I_0			(PC),
								.I_1			(A),
								.Mux_Out		(Src_A)
							);
							
	Mux4x1	B_Input	(
								.Selector	(ALU_Src_B),
								.I_0			(B),
								.I_1			(4),
								.I_2			(Sign_Imm),
								.I_3			(0),
								.Mux_Out		(Src_B)
							);
	
	ALU	ALU	(
						.Control	(ALU_Control),
						.A			(Src_A),
						.B			(Src_B),
						.Result	(ALU_Result)
					);
	
	Register	Result_Register	(
											.clk		(clk),
											.reset	(reset),
											.enable	(1'b1),
											.d			(ALU_Result),
											.q			(ALU_Out)
										);

	Mux2x1	Program_Count_Incr	(
												.Selector	(PC_Src),
												.I_0			(ALU_Result),
												.I_1			(ALU_Out),
												.Mux_Out		(PC_Next)
											);		
	
	assign Op = Instr[31:26];
	assign Funct = Instr[5:0];
	assign GPIO_o = ALU_Result[7:0];
								
endmodule
