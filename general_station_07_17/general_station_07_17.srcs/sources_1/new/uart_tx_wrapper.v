`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 10/15/2020 08:32:29 AM
// Design Name: 
// Module Name: uart_tx_wrapper
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


module uart_tx_wrapper #(
    parameter DATAWIDTH = 8,
    parameter BITCOUNTMAX = DATAWIDTH,
    parameter SAMPLECOUNTMAX = 5209
)(
    input clk,
    input rst,
    input [DATAWIDTH-1:0] tx_parallel_data,
    input tx_data_load,
    output tx_serial_data,
    output tx_ready
    );
    
    uart_txm_ex #(
        .DATAWIDTH(DATAWIDTH),
        .BITCOUNTMAX(BITCOUNTMAX),
        .SAMPLECOUNTMAX(SAMPLECOUNTMAX)
    )tx(
        .clk(clk),
        .rst(rst),
        .tx_parallel_data(tx_parallel_data),
        .tx_data_load(tx_data_load),
        .tx_serial_data(tx_serial_data),
        .tx_ready(tx_ready)
    );
    
endmodule
