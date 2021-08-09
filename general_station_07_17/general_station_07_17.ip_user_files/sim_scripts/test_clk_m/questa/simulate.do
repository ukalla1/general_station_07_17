onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib test_clk_m_opt

do {wave.do}

view wave
view structure
view signals

do {test_clk_m.udo}

run -all

quit -force
