//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Tue Aug  3 21:03:28 2021
//Host        : ukallakuri-Lenovo-YOGA-910-13IKB running 64-bit Ubuntu 20.04.2 LTS
//Command     : generate_target test_design_bd_wrapper.bd
//Design      : test_design_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module test_design_bd_wrapper
   (CLK_IN1_D_0_clk_n,
    CLK_IN1_D_0_clk_p,
    CLK_IN1_D_1_clk_n,
    CLK_IN1_D_1_clk_p,
    CLK_VERIF_OUT_0,
    CLK_VERIF_OUT_1,
    LED_OUT_0,
    LED_OUT_1,
    rst_0,
    rst_1,
    rst_clk_en_0,
    rst_clk_en_1,
    trigger_master_0,
    uart_on_0,
    uart_on_1,
    uart_serial_out_0,
    uart_serial_out_1);
  input CLK_IN1_D_0_clk_n;
  input CLK_IN1_D_0_clk_p;
  input CLK_IN1_D_1_clk_n;
  input CLK_IN1_D_1_clk_p;
  output CLK_VERIF_OUT_0;
  output CLK_VERIF_OUT_1;
  output [7:0]LED_OUT_0;
  output [7:0]LED_OUT_1;
  input rst_0;
  input rst_1;
  input rst_clk_en_0;
  input rst_clk_en_1;
  input trigger_master_0;
  input uart_on_0;
  input uart_on_1;
  output uart_serial_out_0;
  output uart_serial_out_1;

  wire CLK_IN1_D_0_clk_n;
  wire CLK_IN1_D_0_clk_p;
  wire CLK_IN1_D_1_clk_n;
  wire CLK_IN1_D_1_clk_p;
  wire CLK_VERIF_OUT_0;
  wire CLK_VERIF_OUT_1;
  wire [7:0]LED_OUT_0;
  wire [7:0]LED_OUT_1;
  wire rst_0;
  wire rst_1;
  wire rst_clk_en_0;
  wire rst_clk_en_1;
  wire trigger_master_0;
  wire uart_on_0;
  wire uart_on_1;
  wire uart_serial_out_0;
  wire uart_serial_out_1;

  test_design_bd test_design_bd_i
       (.CLK_IN1_D_0_clk_n(CLK_IN1_D_0_clk_n),
        .CLK_IN1_D_0_clk_p(CLK_IN1_D_0_clk_p),
        .CLK_IN1_D_1_clk_n(CLK_IN1_D_1_clk_n),
        .CLK_IN1_D_1_clk_p(CLK_IN1_D_1_clk_p),
        .CLK_VERIF_OUT_0(CLK_VERIF_OUT_0),
        .CLK_VERIF_OUT_1(CLK_VERIF_OUT_1),
        .LED_OUT_0(LED_OUT_0),
        .LED_OUT_1(LED_OUT_1),
        .rst_0(rst_0),
        .rst_1(rst_1),
        .rst_clk_en_0(rst_clk_en_0),
        .rst_clk_en_1(rst_clk_en_1),
        .trigger_master_0(trigger_master_0),
        .uart_on_0(uart_on_0),
        .uart_on_1(uart_on_1),
        .uart_serial_out_0(uart_serial_out_0),
        .uart_serial_out_1(uart_serial_out_1));
endmodule
