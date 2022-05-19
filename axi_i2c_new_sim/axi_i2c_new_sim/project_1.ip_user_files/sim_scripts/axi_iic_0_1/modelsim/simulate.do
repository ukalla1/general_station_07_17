onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L lib_pkg_v1_0_2 -L lib_cdc_v1_0_2 -L axi_lite_ipif_v3_0_4 -L interrupt_control_v3_1_4 -L axi_iic_v2_0_19 -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.axi_iic_0

do {wave.do}

view wave
view structure
view signals

do {axi_iic_0.udo}

run -all

quit -force
