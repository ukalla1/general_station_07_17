onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+axi_iic_0 -L xpm -L lib_pkg_v1_0_2 -L lib_cdc_v1_0_2 -L axi_lite_ipif_v3_0_4 -L interrupt_control_v3_1_4 -L axi_iic_v2_1_0 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi_iic_0 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {axi_iic_0.udo}

run -all

endsim

quit -force