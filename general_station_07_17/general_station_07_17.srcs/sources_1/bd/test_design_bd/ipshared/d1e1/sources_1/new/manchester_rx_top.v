`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 11/03/2020 09:26:54 PM
// Design Name: 
// Module Name: manchester_rx_top
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

module manchester_rx_top #(
    parameter t_r_f_ratio = 10
)(
    input clk,
    input rst,
//    input enb,
    input serial_din,
//    input [`RAM_ADDRSWIDTH_M-1:0] ram_addrb,
    output [`DATAWIDTH-1:0] parallel_dout,
    output rx_ready,
    output dv_broadCast
    );
    
    (*keep = "true"*) wire data_valid;//, rx_ready_internal;
    
    (*keep = "true"*) reg [`DATAWIDTH-1:0] parallel_dout_reg;
    
//    reg [`RAM_ADDRSWIDTH_M-1:0] ram_addra, ram_addrb_delayed;
    
    (*keep = "true"*) wire [`DATAWIDTH-1:0] parallel_dout_rx;
    
//    ram_dp__sim_par #(
//        .DATA_WIDTH(`DATAWIDTH),
//        .RAM_DEPTH(`RAM_DEPTH),
//        .ADDRS_WIDTH(`RAM_ADDRSWIDTH_M)
//    )ram(
//        .clk(clk),
//        .wea(data_valid),
//        .enb(enb),
//        .addra(ram_addra),
//        .addrb(ram_addrb),
//        .dina(parallel_dout_rx),
//        .doutb(parallel_dout)
//    );
    
    manchester_rx_m #(
        .t_r_f_ratio(t_r_f_ratio)
    )rx_m(
        .clk(clk),
        .rst(rst),
        .serial_din(serial_din),
        .data_valid(data_valid),
        .parallel_dout(parallel_dout_rx),
        .rx_ready(rx_ready),
        .dv_broadCast(dv_broadCast)
    );

    assign parallel_dout = parallel_dout_reg;
    
//    always @(posedge clk) begin
//        if(rst) begin
//            ram_addra <= {`RAM_ADDRSWIDTH_M{1'b0}};
//        end
//        else begin
//            if(data_valid) begin
//                ram_addra <= ram_addra + 1'b1;
//            end
//        end
//    end

    always @(posedge clk) begin
        if(rst) begin
            parallel_dout_reg <= {`DATAWIDTH{1'b0}};
//            rx_ready <= 1'b0;
        end
        else begin
            if(data_valid) begin
                parallel_dout_reg <= parallel_dout_rx;
//                rx_ready <= rx_ready_internal;
            end
        end
    end
    
endmodule
