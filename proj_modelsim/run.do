if [file exists work] {vdel -all}
vlib work
vlog +incdir+../ -f files.f
#vlog -f files.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs=+acc work.MIPS_TB
do wave.do
run

