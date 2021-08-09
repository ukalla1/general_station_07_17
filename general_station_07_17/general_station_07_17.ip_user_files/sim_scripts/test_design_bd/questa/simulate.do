onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib test_design_bd_opt

do {wave.do}

view wave
view structure
view signals

do {test_design_bd.udo}

run -all

quit -force
