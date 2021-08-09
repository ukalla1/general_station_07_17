//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Tue Aug  3 21:03:03 2021
//Host        : ukallakuri-Lenovo-YOGA-910-13IKB running 64-bit Ubuntu 20.04.2 LTS
//Command     : generate_target test_design_bd.bd
//Design      : test_design_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "test_design_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=test_design_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "test_design_bd.hwdef" *) 
module test_design_bd
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D_0 CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK_IN1_D_0, CAN_DEBUG false, FREQ_HZ 100000000" *) input CLK_IN1_D_0_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D_0 CLK_P" *) input CLK_IN1_D_0_clk_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D_1 CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK_IN1_D_1, CAN_DEBUG false, FREQ_HZ 100000000" *) input CLK_IN1_D_1_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 CLK_IN1_D_1 CLK_P" *) input CLK_IN1_D_1_clk_p;
  output CLK_VERIF_OUT_0;
  output CLK_VERIF_OUT_1;
  output [7:0]LED_OUT_0;
  output [7:0]LED_OUT_1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_1 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_1, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_1;
  input rst_clk_en_0;
  input rst_clk_en_1;
  input trigger_master_0;
  input uart_on_0;
  input uart_on_1;
  output uart_serial_out_0;
  output uart_serial_out_1;

  wire CLK_IN1_D_0_1_CLK_N;
  wire CLK_IN1_D_0_1_CLK_P;
  wire CLK_IN1_D_1_1_CLK_N;
  wire CLK_IN1_D_1_1_CLK_P;
  wire clk_wiz_0_clk_100M_0_0;
  wire clk_wiz_1_clk_100M_0_0;
  wire rst_0_1;
  wire rst_1_1;
  wire rst_clk_en_0_1;
  wire rst_clk_en_1_1;
  wire top_0_CLK_VERIF_OUT;
  wire [7:0]top_0_LED_OUT;
  wire top_0_tx_serial_out;
  wire top_0_uart_serial_out;
  wire top_slave_0_CLK_VERIF_OUT;
  wire [7:0]top_slave_0_LED_OUT;
  wire top_slave_0_tx_serial_out;
  wire top_slave_0_uart_serial_out;
  wire trigger_master_0_1;
  wire uart_on_0_1;
  wire uart_on_1_1;

  assign CLK_IN1_D_0_1_CLK_N = CLK_IN1_D_0_clk_n;
  assign CLK_IN1_D_0_1_CLK_P = CLK_IN1_D_0_clk_p;
  assign CLK_IN1_D_1_1_CLK_N = CLK_IN1_D_1_clk_n;
  assign CLK_IN1_D_1_1_CLK_P = CLK_IN1_D_1_clk_p;
  assign CLK_VERIF_OUT_0 = top_0_CLK_VERIF_OUT;
  assign CLK_VERIF_OUT_1 = top_slave_0_CLK_VERIF_OUT;
  assign LED_OUT_0[7:0] = top_0_LED_OUT;
  assign LED_OUT_1[7:0] = top_slave_0_LED_OUT;
  assign rst_0_1 = rst_0;
  assign rst_1_1 = rst_1;
  assign rst_clk_en_0_1 = rst_clk_en_0;
  assign rst_clk_en_1_1 = rst_clk_en_1;
  assign trigger_master_0_1 = trigger_master_0;
  assign uart_on_0_1 = uart_on_0;
  assign uart_on_1_1 = uart_on_1;
  assign uart_serial_out_0 = top_0_uart_serial_out;
  assign uart_serial_out_1 = top_slave_0_uart_serial_out;
  test_design_bd_clk_wiz_0_0 clk_wiz_0
       (.clk_100M_0_0(clk_wiz_0_clk_100M_0_0),
        .clk_in1_n(CLK_IN1_D_1_1_CLK_N),
        .clk_in1_p(CLK_IN1_D_1_1_CLK_P));
  test_design_bd_clk_wiz_0_1 clk_wiz_1
       (.clk_100M_0_0(clk_wiz_1_clk_100M_0_0),
        .clk_in1_n(CLK_IN1_D_0_1_CLK_N),
        .clk_in1_p(CLK_IN1_D_0_1_CLK_P));
  test_design_bd_top_0_0 top_0
       (.CLK_VERIF_OUT(top_0_CLK_VERIF_OUT),
        .LED_OUT(top_0_LED_OUT),
        .clk100M_0(clk_wiz_0_clk_100M_0_0),
        .rst(rst_0_1),
        .rst_clk_en(rst_clk_en_0_1),
        .rx_serial_in(top_slave_0_tx_serial_out),
        .trigger_master(trigger_master_0_1),
        .tx_serial_out(top_0_tx_serial_out),
        .uart_on(uart_on_0_1),
        .uart_serial_out(top_0_uart_serial_out));
  test_design_bd_top_slave_0_0 top_slave_0
       (.CLK_VERIF_OUT(top_slave_0_CLK_VERIF_OUT),
        .LED_OUT(top_slave_0_LED_OUT),
        .clk100M_0(clk_wiz_1_clk_100M_0_0),
        .rst(rst_1_1),
        .rst_clk_en(rst_clk_en_1_1),
        .rx_serial_in(top_0_tx_serial_out),
        .tx_serial_out(top_slave_0_tx_serial_out),
        .uart_on(uart_on_1_1),
        .uart_serial_out(top_slave_0_uart_serial_out));
endmodule
