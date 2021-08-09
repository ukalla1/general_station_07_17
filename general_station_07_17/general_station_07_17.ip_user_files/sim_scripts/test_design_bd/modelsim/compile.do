vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ip/test_design_bd_top_slave_0_0/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../bd/test_design_bd/ipshared/d1e1/sources_1/new" "+incdir+../../../bd/test_design_bd/ipshared/d1e1/sources_1/imports/MMCME2_DRP" "+incdir+../../../bd/test_design_bd/ipshared/1dcd/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/d1e1/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/d1e1/sources_1/imports/MMCME2_DRP" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/85a3" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/1dcd/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/1dcd/sources_1/imports/MMCME2_DRP" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ip/test_design_bd_top_0_0/sources_1/bd/design_1/ipshared/85a3" \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ip/test_design_bd_top_slave_0_0/sources_1/bd/design_1/ipshared/85a3" "+incdir+../../../bd/test_design_bd/ipshared/d1e1/sources_1/new" "+incdir+../../../bd/test_design_bd/ipshared/d1e1/sources_1/imports/MMCME2_DRP" "+incdir+../../../bd/test_design_bd/ipshared/1dcd/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/d1e1/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/d1e1/sources_1/imports/MMCME2_DRP" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/85a3" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/1dcd/sources_1/new" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ipshared/1dcd/sources_1/imports/MMCME2_DRP" "+incdir+../../../../general_station_07_17.srcs/sources_1/bd/test_design_bd/ip/test_design_bd_top_0_0/sources_1/bd/design_1/ipshared/85a3" \
"../../../bd/test_design_bd/ip/test_design_bd_top_slave_0_0/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/test_design_bd/ip/test_design_bd_top_slave_0_0/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/buff_cal_wrapper.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/cntr_tst.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/debounce_logic.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/design_top_temp.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/manchester_rx_m.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/manchester_rx_top.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/manchester_tx_m.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/manchester_tx_top.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/mmcm_drp_rcf_0628.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/reg_b.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/sp_ram_sim.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/top_mmcme2.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/uart_tx_wrapper.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/uart_txm_ex.v" \
"../../../bd/test_design_bd/ipshared/d1e1/sources_1/new/top.v" \
"../../../bd/test_design_bd/ip/test_design_bd_top_slave_0_0/sim/test_design_bd_top_slave_0_0.v" \
"../../../bd/test_design_bd/ip/test_design_bd_clk_wiz_0_0/test_design_bd_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/test_design_bd/ip/test_design_bd_clk_wiz_0_0/test_design_bd_clk_wiz_0_0.v" \
"../../../bd/test_design_bd/ip/test_design_bd_clk_wiz_0_1/test_design_bd_clk_wiz_0_1_clk_wiz.v" \
"../../../bd/test_design_bd/ip/test_design_bd_clk_wiz_0_1/test_design_bd_clk_wiz_0_1.v" \
"../../../bd/test_design_bd/sim/test_design_bd.v" \
"../../../bd/test_design_bd/ip/test_design_bd_top_0_0/sim/test_design_bd_top_0_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

