onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+test_clk_m -L xil_defaultlib -L xpm -L sim_clk_gen_v1_0_2 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.test_clk_m xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {test_clk_m.udo}

run -all

endsim

quit -force
