//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Tue Aug  3 21:03:21 2021
//Host        : ukallakuri-Lenovo-YOGA-910-13IKB running 64-bit Ubuntu 20.04.2 LTS
//Command     : generate_target test_clk_s.bd
//Design      : test_clk_s
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "test_clk_s,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=test_clk_s,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "test_clk_s.hwdef" *) 
module test_clk_s
   (diff_clk_0_clk_n,
    diff_clk_0_clk_p);
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 diff_clk_0 CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME diff_clk_0, CAN_DEBUG false, FREQ_HZ 200000000" *) output diff_clk_0_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 diff_clk_0 CLK_P" *) output diff_clk_0_clk_p;

  wire sim_clk_gen_0_diff_clk_CLK_N;
  wire sim_clk_gen_0_diff_clk_CLK_P;

  assign diff_clk_0_clk_n = sim_clk_gen_0_diff_clk_CLK_N;
  assign diff_clk_0_clk_p = sim_clk_gen_0_diff_clk_CLK_P;
  test_clk_s_sim_clk_gen_0_0 sim_clk_gen_0
       (.clk_n(sim_clk_gen_0_diff_clk_CLK_N),
        .clk_p(sim_clk_gen_0_diff_clk_CLK_P));
endmodule
