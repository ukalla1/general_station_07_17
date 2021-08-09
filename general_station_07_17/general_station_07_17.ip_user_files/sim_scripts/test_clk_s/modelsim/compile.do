vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/sim_clk_gen_v1_0_2

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap sim_clk_gen_v1_0_2 modelsim_lib/msim/sim_clk_gen_v1_0_2

vlog -work xil_defaultlib -64 -incr -sv \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work sim_clk_gen_v1_0_2 -64 -incr \
"../../../../general_station_07_17.srcs/sim_1/bd/test_clk_s/ipshared/d987/hdl/sim_clk_gen_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../bd/test_clk_s/ip/test_clk_s_sim_clk_gen_0_0/sim/test_clk_s_sim_clk_gen_0_0.v" \
"../../../bd/test_clk_s/sim/test_clk_s.v" \

vlog -work xil_defaultlib \
"glbl.v"

