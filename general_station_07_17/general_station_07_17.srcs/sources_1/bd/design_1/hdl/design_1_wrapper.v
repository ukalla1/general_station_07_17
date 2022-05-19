//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Fri Jan 14 09:34:10 2022
//Host        : ukallakuri-Lenovo-YOGA-910-13IKB running 64-bit Ubuntu 20.04.3 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLK_IN1_D_0_clk_n,
    CLK_IN1_D_0_clk_p,
    clk_out1_0);
  input CLK_IN1_D_0_clk_n;
  input CLK_IN1_D_0_clk_p;
  output clk_out1_0;

  wire CLK_IN1_D_0_clk_n;
  wire CLK_IN1_D_0_clk_p;
  wire clk_out1_0;

  design_1 design_1_i
       (.CLK_IN1_D_0_clk_n(CLK_IN1_D_0_clk_n),
        .CLK_IN1_D_0_clk_p(CLK_IN1_D_0_clk_p),
        .clk_out1_0(clk_out1_0));
endmodule
