vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/sim_clk_gen_v1_0_2

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap sim_clk_gen_v1_0_2 activehdl/sim_clk_gen_v1_0_2

vlog -work xil_defaultlib  -sv2k12 \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work sim_clk_gen_v1_0_2  -v2k5 \
"../../../../general_station_07_17.srcs/sim_1/bd/test_clk_s/ipshared/d987/hdl/sim_clk_gen_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/test_clk_s/ip/test_clk_s_sim_clk_gen_0_0/sim/test_clk_s_sim_clk_gen_0_0.v" \
"../../../bd/test_clk_s/sim/test_clk_s.v" \

vlog -work xil_defaultlib \
"glbl.v"

