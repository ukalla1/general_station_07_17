//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Tue Aug  3 21:03:30 2021
//Host        : ukallakuri-Lenovo-YOGA-910-13IKB running 64-bit Ubuntu 20.04.2 LTS
//Command     : generate_target test_clk_s_wrapper.bd
//Design      : test_clk_s_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module test_clk_s_wrapper
   (diff_clk_0_clk_n,
    diff_clk_0_clk_p);
  output diff_clk_0_clk_n;
  output diff_clk_0_clk_p;

  wire diff_clk_0_clk_n;
  wire diff_clk_0_clk_p;

  test_clk_s test_clk_s_i
       (.diff_clk_0_clk_n(diff_clk_0_clk_n),
        .diff_clk_0_clk_p(diff_clk_0_clk_p));
endmodule
