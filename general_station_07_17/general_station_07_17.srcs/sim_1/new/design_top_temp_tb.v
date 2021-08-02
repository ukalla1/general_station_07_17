`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 12/24/2020 04:18:38 PM
// Design Name: 
// Module Name: design_top_temp_tb
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

//`include "parameters.vh"
`include "parameters_top.vh"

`define POST_IMPLE_TEST

module design_top_temp_tb(
    );
    
    reg  clk100M = 0;
    reg  clk20M = 0;
    
    reg diff_clk_test_n = 1, diff_clk_test_p = 0;
    integer diff_clk_test_period = 5;
    
    reg  rst = 0;
    reg  rst_clk_en = 0;
    reg  rx_serial_in = 0;
    wire tx_serial_out;
    `ifdef MASTER
        wire m_rx_err;
        reg  trigger = 0;
    `else
        reg trigger_slave = 0;
        wire s_rx_err;
    `endif
    
    `ifdef VERIF
        wire [`DATAWIDTH-1:0] LED_OUT;
    `endif
    
    reg uart_on = 0;
    wire uart_serial_out;
    wire uart_tx_ready;
    
    integer period_100M = 10, period_20M = 50, i= 0, j = 0;
    
    reg [`DATAWIDTH-1:0] data = 0;
    
    wire diff_clk_0_clk_n, diff_clk_0_clk_p;
    
//    design_2_wrapper clk_gen(
//        .diff_clk_0_clk_n(diff_clk_0_clk_n),
//        .diff_clk_0_clk_p(diff_clk_0_clk_p)
//    );
    `ifndef POST_IMPLE_TEST
        test_clock_gen_wrapper clk_gen(
            .diff_clk_0_clk_n(diff_clk_0_clk_n),
            .diff_clk_0_clk_p(diff_clk_0_clk_p)
        );
    `endif
    
    top uut(
        `ifndef POST_IMPLE_TEST
            .CLK_IN1_D_0_clk_n(diff_clk_0_clk_n),
            .CLK_IN1_D_0_clk_p(diff_clk_0_clk_p),
        `else
            .CLK_IN1_D_0_clk_n(diff_clk_test_n),
            .CLK_IN1_D_0_clk_p(diff_clk_test_p),
        `endif
        .rst(rst),
        .rst_clk_en(rst_clk_en),
        `ifdef MASTER
            .trigger_master(trigger),
//            .m_rx_err(m_rx_err),
//        `else
//            .trigger_slave(trigger_slave),
//            .s_rx_err(s_rx_err),
        `endif
        .rx_serial_in(rx_serial_in),
        .tx_serial_out(tx_serial_out),
        `ifdef VERIF
            .LED_OUT(LED_OUT),
        `endif
        .uart_on(uart_on),
        .uart_serial_out(uart_serial_out)
//        .uart_tx_ready(uart_tx_ready)
    );
    
//    design_top_temp uut(
//        .clk100M(clk100M),
//        .clk20M(clk20M),
//        .rst(rst),
//        `ifdef MASTER
//            .trigger(trigger),
//            .m_rx_err(m_rx_err),
//        `else
//            .trigger_slave(trigger_slave),
//            .s_rx_err(s_rx_err),
//        `endif
//        .rx_serial_in(rx_serial_in),
//        .tx_serial_out(tx_serial_out),
//        .uart_on(uart_on),
//        .uart_serial_out(uart_serial_out),
//        .uart_tx_ready(uart_tx_ready)
//    );
    
    always begin
        forever #(diff_clk_test_period/2.0) diff_clk_test_n = ~diff_clk_test_n;
    end
    
    always begin
        forever #(diff_clk_test_period/2.0) diff_clk_test_p = ~diff_clk_test_p;
    end
    
    always begin
        forever #(period_100M/2) clk100M = ~clk100M;
    end
    
    always begin
        forever #(period_20M/2) clk20M = ~clk20M;
    end
    
    initial begin
        #(20*period_100M);        
        `ifdef MASTER
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b1;
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(500*period_20M);
            
             #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(500*period_20M);
            
            rx_serial_in = 1'b0;
            
            #(100*period_20M);
            
            trigger = 1'b1;
            
            #(100*period_100M);
            
            trigger = 1'b0;
            
            #(1000*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < 8 ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
    //        for ( i=5 ; i < 6 ; i=i+1)begin
    //            data = i;
    //            for(j=0; j < 8 ; j=j+1)begin
    //                rx_serial_in = data[j]^1;
    //                #(period_20M);
    //                rx_serial_in = data[j]^0;
    //               #(period_20M);
    //            end
    //        end
            rx_serial_in = 1'b0;
            
            #(1000*period_20M);
            
            uart_on = 1'b1;
            #(50*period_20M);
            uart_on = 1'b0;
            
            
            #(((`SAMPLECOUNTMAX *`DATAWIDTH)*4)*period_20M);
            
            #(1000*period_20M);
            
            #(1000*period_20M);
            
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b1;
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(10*period_100M);
            
            #(100*period_20M);
            
            trigger = 1'b1;
            
            #(100*period_100M);
            
            trigger = 1'b0;
            
            #(1000*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < `DATAWIDTH ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
    //        for ( i=5 ; i < 6 ; i=i+1)begin
    //            data = i;
    //            for(j=0; j < 8 ; j=j+1)begin
    //                rx_serial_in = data[j]^1;
    //                #(period_20M);
    //                rx_serial_in = data[j]^0;
    //               #(period_20M);
    //            end
    //        end
            rx_serial_in = 1'b0;
            
            #(1000*period_20M);
            
            uart_on = 1'b1;
            #(50*period_20M);
            uart_on = 1'b0;
            
            
            #(((`SAMPLECOUNTMAX *`DATAWIDTH)*4)*period_20M);
            
            #(1000*period_20M);
            
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b1;
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(10*period_100M);
            
            #(100*period_20M);
            
            trigger = 1'b1;
            
            #(100*period_100M);
            
            trigger = 1'b0;
            
            #(1000*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < `DATAWIDTH ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
    //        for ( i=5 ; i < 6 ; i=i+1)begin
    //            data = i;
    //            for(j=0; j < 8 ; j=j+1)begin
    //                rx_serial_in = data[j]^1;
    //                #(period_20M);
    //                rx_serial_in = data[j]^0;
    //               #(period_20M);
    //            end
    //        end
            rx_serial_in = 1'b0;
            
            #(100*period_20M);
            
            uart_on = 1'b1;
            #(50*period_20M);
            uart_on = 1'b0;
            
            
            #(((`SAMPLECOUNTMAX *`DATAWIDTH)*4)*period_20M);
            $finish;
        
        `else
           #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b1;
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(500*period_20M);
            
             #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(10*period_20M);
            rst = 1'b0;
            
            #(500*period_20M);
            
            rx_serial_in = 1'b0;
            
            #(100*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < 8 ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
            for ( i=1500 ; i < 1501 ; i=i+1)begin
                data = {{32{1'b0}},i};
                for(j=0; j < `DATAWIDTH ; j=j+1)begin
                    rx_serial_in = data[j]^1;
                    #(period_20M);
                    rx_serial_in = data[j]^0;
                   #(period_20M);
                end
            end
            rx_serial_in = 1'b0;
            
            #(100*period_20M);
            
            trigger_slave = 1'b1;
            
            #(100*period_100M);
            
            trigger_slave = 1'b0;
            
            #(300*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < 8 ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
            for ( i=2500 ; i < 2501 ; i=i+1)begin
                data = i;
                for(j=0; j < `DATAWIDTH ; j=j+1)begin
                    rx_serial_in = data[j]^1;
                    #(period_20M);
                    rx_serial_in = data[j]^0;
                   #(period_20M);
                end
            end
            rx_serial_in = 1'b0;
            
            #(200*period_100M);
            
            #(10000*period_100M);
            
            uart_on = 1'b1;
            #(200*period_20M);
            uart_on = 1'b0;
           
            
            #(((`SAMPLECOUNTMAX *`DATAWIDTH)*6)*period_100M);
            
            uart_on = 1'b0;
            
            #(100_000 * period_20M);
            
            #(100*period_20M)

            #(10*period_20M);
            rst = 1'b1;
//            rst_clk_en = 1'b1;
            #(10*period_20M);
            rst = 1'b1;
            rst_clk_en = 1'b0;
            #(50*period_20M);
            rst = 1'b0;
            
            #(10*period_20M);
            
            rx_serial_in = 1'b1;
            
            #(100*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < 8 ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
            for ( i=1800 ; i < 1801 ; i=i+1)begin
                data = {{32{1'b0}},i};
                for(j=0; j < `DATAWIDTH ; j=j+1)begin
                    rx_serial_in = data[j]^1;
                    #(period_20M);
                    rx_serial_in = data[j]^0;
                   #(period_20M);
                end
            end
            rx_serial_in = 1'b0;
            
            #(100*period_20M);
            
            trigger_slave = 1'b1;
            
            #(100*period_100M);
            
            trigger_slave = 1'b0;
            
            #(300*period_20M);
            
            data = `PREAMBLE;
            #(period_20M);
            for(j=0; j < `DATAWIDTH ; j=j+1)begin
                rx_serial_in = data[j]^1;
                #(period_20M);
                rx_serial_in = data[j]^0;
                #(period_20M);
            end
            
            for ( i=2200 ; i < 2201 ; i=i+1)begin
                data = i;
                for(j=0; j < `DATAWIDTH ; j=j+1)begin
                    rx_serial_in = data[j]^1;
                    #(period_20M);
                    rx_serial_in = data[j]^0;
                   #(period_20M);
                end
            end
            rx_serial_in = 1'b0;
            
            #(200*period_100M);
            
            #(10000*period_100M);
            
            uart_on = 1'b1;
            #(200*period_20M);
            uart_on = 1'b0;
           
            
            #(((`SAMPLECOUNTMAX *`DATAWIDTH)*6)*period_100M);
            
            uart_on = 1'b0;
            
            #(100*period_20M)
            
            $finish;
        `endif
    end
    
endmodule
