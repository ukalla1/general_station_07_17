-makelib xcelium_lib/xil_defaultlib -sv \
  "/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/tools/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/sim_clk_gen_v1_0_2 \
  "../../../../general_station_07_17.srcs/sim_1/bd/test_clk_m/ipshared/d987/hdl/sim_clk_gen_v1_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/test_clk_m/ip/test_clk_m_sim_clk_gen_0_0/sim/test_clk_m_sim_clk_gen_0_0.v" \
  "../../../bd/test_clk_m/sim/test_clk_m.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

