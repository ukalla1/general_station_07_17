`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 02/13/2021 11:53:55 AM
// Design Name: 
// Module Name: top
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

`include "parameters_top.vh"

module top(
//    input CLK_IN1_D_0_clk_n,
//    input CLK_IN1_D_0_clk_p,
    input clk100M_0,
    input rst,
    input rst_clk_en,
    `ifdef MASTER
        input trigger_master,
//        output m_rx_err,
//    `else
//        input trigger_slave,
//        output s_rx_err,
    `endif
    input rx_serial_in,
    output tx_serial_out,
    `ifdef VERIF
        output [8-1:0] LED_OUT,
//        output reg tmp_trigger,
    `endif
    output CLK_VERIF_OUT,
    
    input uart_on,
    output uart_serial_out
//    output uart_tx_ready
    );
    
//    (*keep = "true"*) wire clk100M_0;
//    wire clk20M_0;
    
//    (*keep = "true"*) reg rst_reg;
    
//    `ifdef MASTER
        wire m_rx_err;
        (*keep = "true"*) wire trigger_master_internal;
//    `else
        wire s_rx_err;
        (*keep = "true"*) wire trigger_slave_internal;
        (*keep = "true"*) wire [`DATAWIDTH-1:0] phase_computed_tmp;
        
        (*keep = "true"*) wire uart_on_internal;
        
        localparam phase = 360000, phase_sel = 5'b00000, divide = 12;
    
        (*keep = "true"*) wire drp_ready, locked, design_clk_tmp, re_prog_on, re_prog_on_internal, PSDONE;
        
        (*gated_clock = "yes"*) wire design_clk, design_clk_ttmp;
        
        (*keep = "true"*) reg re_prog_on0, re_prog_on1, re_prog_on2, re_prog_on3, re_prog_on4; 
        
        (*keep = "true"*) reg [32-1:0] clk_param_in = 0;
        (*keep = "true"*) wire [32-1:0] clk_param_out;
        (*keep = "true"*) reg [4:0] clk_param_sel;
        (*keep = "true"*) reg clk_param_en = 0, clk_param_wen = 0, PSEN = 0, PSID = 0 , sstep = 0;
        
        `ifndef MASTER
        (*keep = "true"*) wire pts_trigger; 
        `endif
        
        integer cntr = 0;
//    `endif
    wire uart_tx_ready;
    
    wire [`DATAWIDTH-1:0] LED_OUT_internal;
    
    localparam idle = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
    (*keep = "true"*) reg [1:0] state =  idle;
    
//    design_1_wrapper top_sub0(
//        .CLK_IN1_D_0_clk_n(CLK_IN1_D_0_clk_n),
//        .CLK_IN1_D_0_clk_p(CLK_IN1_D_0_clk_p),
//        .clk_out1_0(clk100M_0)
//    );

//    design_2_wrapper top_sub0(
//        .CLK_IN1_D_0_clk_n(CLK_IN1_D_0_clk_n),
//        .CLK_IN1_D_0_clk_p(CLK_IN1_D_0_clk_p),
//        .clk_ip_out_0(clk100M_0)
//    );
    
//    `ifdef SLAVE
    top_mmcme2 feedback(
        
        .SSTEP (sstep),
//        input    STATE,
        .RST (rst & rst_clk_en),
        .CLKIN (clk100M_0),
        .CLKIN2 (1'b0),
        .CLKINSEL (1'b1),
        .SRDY (drp_ready),
 		.LOCKED_OUT (locked),
        .CLK0OUT (design_clk_tmp),
        //
        .clk_param_in (clk_param_in),
        .clk_param_sel (clk_param_sel),
        .clk_param_en (clk_param_en),
        .clk_param_wen (clk_param_wen),
        .clk_param_out (clk_param_out),
        //
        .PSDONE (PSDONE),
        .PSEN (PSEN),
        .PSINCDEC (PSID)
    );
//    `endif
    
    debounce_logic #(
        .clock_frequency ((`RXF) * (1000000)),
//        .clock_frequency ((`RXF)),
        .stable_time (10)
    )dbl(
        `ifdef MASTER
        .button_out (trigger_master_internal),
        .button_in (trigger_master),
//        `else
//        .button_out (trigger_slave_internal),
//        .button_in (trigger_slave),
        `endif
        .clk (design_clk),
        .rst (rst)
    );
    
    debounce_logic #(
//        .clock_frequency ((`RXF) * (1000000)),
        .clock_frequency ((`RXF)),
        .stable_time (10)
    )dbl_uart(
        .button_out (uart_on_internal),
        .button_in (uart_on),
        .clk (design_clk),
        .rst (rst)
    );
    
    design_top_temp top_sub1(
        .clk100M(design_clk),
        .clk20M(0),
        .rst(rst),
        `ifdef MASTER
            .trigger(trigger_master_internal),
            .m_rx_err(m_rx_err),
        `else
//            .trigger_slave(trigger_slave_internal),
            .s_rx_err(s_rx_err),
            .phase_computed_tmp(phase_computed_tmp),
            .re_prog_on(re_prog_on),
            .pts_trigger(pts_trigger),
        `endif
        .rx_serial_in(rx_serial_in),
        .tx_serial_out(tx_serial_out),
        `ifdef VERIF
            .LED_OUT(LED_OUT_internal),
        `endif
        
        .uart_on(uart_on_internal),
        .uart_serial_out(uart_serial_out),
        .uart_tx_ready(uart_tx_ready)
    );
    
    
    ODDR ODDR_CLKOUT (.Q(CLK_VERIF_OUT), .C(design_clk), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(rst), .S(1'b0));
    
    BUFG design_Clk_buf(.I(design_clk_ttmp), .O(design_clk));
    
    always @(posedge design_clk) begin
        if(rst) begin
            re_prog_on0 <= 0;
            re_prog_on1 <= 0;
            re_prog_on2 <= 0;
            re_prog_on3 <= 0;
            re_prog_on4 <= 0;
        end
        else begin
            re_prog_on0 <= re_prog_on;
            re_prog_on1 <= re_prog_on0;
            re_prog_on2 <= re_prog_on1;
            re_prog_on3 <= re_prog_on2;
            re_prog_on4 <= re_prog_on4;
        end
    end
    
    assign re_prog_on_internal = re_prog_on0 | re_prog_on1 | re_prog_on2 | re_prog_on3 | re_prog_on4 | re_prog_on;
    
    `ifndef MASTER
    assign pts_trigger = re_prog_on;
    `endif
    
    assign LED_OUT = LED_OUT_internal[15:8];
    
    assign design_clk_ttmp = design_clk_tmp & locked;
    
    always @(posedge clk100M_0) begin
//        rst_reg <= rst;
        
        `ifdef SLAVE
        if(rst) begin
            state <= idle;
            clk_param_sel <= 0;
            clk_param_in <= 0;
            clk_param_en <= 1'b0;
            clk_param_wen <= 1'b0;
            cntr <= 0;
            sstep <= 0;
//            pts_trigger <= 0;
        end
        else begin
            case(state)
                idle: begin
                    if(re_prog_on_internal) begin
                        if(!locked) begin
                            state <= idle;
                        end
                        else begin
                            state <= s1;
//                            pts_trigger <= 1'b1;
                            cntr <= phase_computed_tmp;
                        end
                    end
                    else begin
                        state <= idle;
                        clk_param_sel <= 0;
                        clk_param_in <= 0;
                        clk_param_en <= 1'b0;
                        clk_param_wen <= 1'b0;
                    end
                end
                
                s1: begin
//                    pts_trigger <= 1'b0;
                    sstep <= 1'b0;
//                    if(cntr > 0) begin
                        clk_param_sel <= phase_sel;
                        clk_param_in <= divide;
                        clk_param_en <= 1'b1;
                        clk_param_wen <= 1'b1;
                        state <= s2;
//                    end
//                    else begin
//                        state <= idle;
//                    end
                end
                
                s2: begin
                    state <= s3;
                    clk_param_sel <= 0;
                    clk_param_in <= 0;
                    clk_param_en <= 1'b0;
                    clk_param_wen <= 1'b0;
                    sstep <= 1'b1;
                end
                
                s3: begin
                    if(drp_ready) begin
                        sstep <= 1'b0;
//                        state <= s1;
                        state <= idle;
                        cntr <= cntr - 1'b1;
                    end
                    else begin
                        sstep <= 1'b0;
                        state <= s3;
                    end
                end
            endcase
        end
        `endif
        
//        if(rst_reg) begin
//            `ifdef MASTER
//            tmp_trigger <= trigger_master_internal;
//            `else
//            tmp_trigger <= trigger_slave_internal;
//            `endif
//        end
    end
    
endmodule