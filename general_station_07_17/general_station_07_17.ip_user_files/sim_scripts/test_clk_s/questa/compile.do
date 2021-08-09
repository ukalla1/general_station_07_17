vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/sim_clk_gen_v1_0_2

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap sim_clk_gen_v1_0_2 questa_lib/msim/sim_clk_gen_v1_0_2

vlog -work xil_defaultlib -64 -sv \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work sim_clk_gen_v1_0_2 -64 \
"../../../../general_station_07_17.srcs/sim_1/bd/test_clk_s/ipshared/d987/hdl/sim_clk_gen_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/test_clk_s/ip/test_clk_s_sim_clk_gen_0_0/sim/test_clk_s_sim_clk_gen_0_0.v" \
"../../../bd/test_clk_s/sim/test_clk_s.v" \

vlog -work xil_defaultlib \
"glbl.v"

