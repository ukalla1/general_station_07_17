`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2021 12:32:57 PM
// Design Name: 
// Module Name: test_setup_bd_wrapper_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_setup_bd_wrapper_tb(

    );
    
    wire CLK_IN1_D_0_clk_n;
    wire CLK_IN1_D_0_clk_p;
    wire CLK_IN1_D_1_clk_n;
    wire CLK_IN1_D_1_clk_p;
    wire CLK_VERIF_OUT_0;
    wire CLK_VERIF_OUT_1;
    wire LED_OUT_0;
    wire LED_OUT_1;
    reg rst_0 = 1'b1;
    reg rst_1 = 1'b1;
    reg rst_clk_en_0 = 1'b1;
    reg rst_clk_en_1 = 1'b1;
    reg trigger_master_0 = 1'b0;
    reg uart_on_0 = 1'b0;
    reg uart_on_1 = 1'b0;
    wire uart_serial_out_0;
    wire uart_serial_out_1;
    
    integer period = 10;
    
    test_clk_s_wrapper s_clk_gen (
        .diff_clk_0_clk_n (CLK_IN1_D_1_clk_n),
        .diff_clk_0_clk_p (CLK_IN1_D_1_clk_p)
    );
    
    test_clk_m_wrapper m_clk_gen (
        .diff_clk_0_clk_n (CLK_IN1_D_0_clk_n),
        .diff_clk_0_clk_p (CLK_IN1_D_0_clk_p)
    );
    
    test_design_bd_wrapper uut (
        .CLK_IN1_D_0_clk_n (CLK_IN1_D_0_clk_n),
        .CLK_IN1_D_0_clk_p (CLK_IN1_D_0_clk_p),
        .CLK_IN1_D_1_clk_n (CLK_IN1_D_1_clk_n),
        .CLK_IN1_D_1_clk_p (CLK_IN1_D_1_clk_p),
        .CLK_VERIF_OUT_0 (CLK_VERIF_OUT_0),
        .CLK_VERIF_OUT_1 (CLK_VERIF_OUT_1),
        .LED_OUT_0 (LED_OUT_0),
        .LED_OUT_1 (LED_OUT_1),
        .rst_0 (rst_0),
        .rst_1 (rst_1),
        .rst_clk_en_0 (rst_clk_en_0),
        .rst_clk_en_1 (rst_clk_en_1),
        .trigger_master_0 (trigger_master_0),
        .uart_on_0 (uart_on_0),
        .uart_on_1 (uart_on_1),
        .uart_serial_out_0 (uart_serial_out_0),
        .uart_serial_out_1 (uart_serial_out_1)
    );
    
    initial begin
        #(500*period);
        
        rst_clk_en_0 = 1'b0;
        rst_clk_en_1 = 1'b0;
        
        #(500*period);
        #(500*period);
        
        rst_0 = 1'b0;
        rst_1 = 1'b0;
        
        #(500*period);
        #(500*period);
        
        #(5000*period);
        
        trigger_master_0 = 1'b1;
        
        #(1000000 * 1000);
        
        trigger_master_0 = 1'b0;
        
        #(1000000);
        
        $finish;
    end
    
endmodule
