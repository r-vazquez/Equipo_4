module MIPS_Multi_Cycle
(
	input 			clk,
	input 			reset,
	
	output	[7:0]	GPIO_Out
);

	wire	[5:0]	Op_w;
	wire	[5:0] Funct_w;
	wire 			PC_Write_w;
	wire 			I_or_D_w;
	wire 			Mem_Write_w;
	wire 			IR_Write_w;
	wire 			Reg_Dst_w;
	wire 			Mem_to_Reg_w;
	wire 			Reg_Write_w;
	wire 			ALU_Src_A_w;
	wire	[1:0]	ALU_Src_B_w;
	wire 	[2:0]	ALU_Control_w;
	wire 			PC_Src_w;
	
	Control_Unit	Control	(
										.clk				(clk),
										.reset			(reset),
										.Op				(Op_w),
										.Funct			(Funct_w),
										.PC_Write		(PC_Write_w),
										.I_or_D			(I_or_D_w),
										.Mem_Write		(Mem_Write_w),
										.IR_Write		(IR_Write_w),
										.Reg_Dst			(Reg_Dst_w),
										.Mem_to_Reg		(Mem_to_Reg_w),
										.Reg_Write		(Reg_Write_w),
										.ALU_Src_A		(ALU_Src_A_w),
										.ALU_Src_B		(ALU_Src_B_w),
										.ALU_Control	(ALU_Control_w),
										.PC_Src			(PC_Src_w)
									);
	
	Data_Path	#
					(
						.DATA_WIDTH(32)
					)
					DataPath	(
									.clk				(clk),
									.reset			(reset),
									.GPIO_o			(GPIO_Out),
									.PC_Write		(PC_Write_w),
									.I_or_D			(I_or_D_w),
									.Mem_Write		(Mem_Write_w),
									.IR_Write		(IR_Write_w),
									.Reg_Dst			(Reg_Dst_w),
									.Mem_to_Reg		(Mem_to_Reg_w),
									.Reg_Write		(Reg_Write_w),
									.ALU_Src_A		(ALU_Src_A_w),
									.ALU_Src_B		(ALU_Src_B_w),
									.ALU_Control	(ALU_Control_w),
									.PC_Src			(PC_Src_w),
									.Op				(Op_w),
									.Funct			(Funct_w)
								);


endmodule
