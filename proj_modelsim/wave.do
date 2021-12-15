onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_TB/DUT/DataPath/clk
add wave -noupdate /MIPS_TB/DUT/DataPath/reset
add wave -noupdate -radix unsigned /MIPS_TB/DUT/DataPath/GPIO_i
add wave -noupdate -radix decimal /MIPS_TB/DUT/DataPath/GPIO_o
add wave -noupdate /MIPS_TB/DUT/DataPath/PC_En
add wave -noupdate /MIPS_TB/DUT/DataPath/I_or_D
add wave -noupdate /MIPS_TB/DUT/DataPath/Mem_Write
add wave -noupdate /MIPS_TB/DUT/DataPath/IR_Write
add wave -noupdate /MIPS_TB/DUT/DataPath/Reg_Dst
add wave -noupdate /MIPS_TB/DUT/DataPath/Mem_to_Reg
add wave -noupdate /MIPS_TB/DUT/DataPath/Reg_Write
add wave -noupdate /MIPS_TB/DUT/DataPath/ALU_Src_A
add wave -noupdate /MIPS_TB/DUT/DataPath/ALU_Src_B
add wave -noupdate /MIPS_TB/DUT/DataPath/ALU_Control
add wave -noupdate /MIPS_TB/DUT/DataPath/PC_Src
add wave -noupdate /MIPS_TB/DUT/DataPath/Zero
add wave -noupdate -radix unsigned /MIPS_TB/DUT/Control/State_and_Signals/state
add wave -noupdate /MIPS_TB/DUT/DataPath/Op
add wave -noupdate /MIPS_TB/DUT/DataPath/Funct
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/PC_Next
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/PC
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Adr
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Read_Data
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Instr
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Data
add wave -noupdate -radix unsigned /MIPS_TB/DUT/DataPath/Write_Register
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Write_Data
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/RD1
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/RD2
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/A
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/B
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Sign_Imm
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Shifted_Imm
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Src_A
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/Src_B
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/ALU_Result
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/ALU_Out
add wave -noupdate -radix hexadecimal /MIPS_TB/DUT/DataPath/PC_Jump
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {138 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {175 ps} {201 ps}
