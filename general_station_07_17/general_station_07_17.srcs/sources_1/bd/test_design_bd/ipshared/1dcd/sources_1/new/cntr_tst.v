`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 12/08/2020 12:18:09 PM
// Design Name: 
// Module Name: cntr_tst
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

module cntr_tst(
    input rst,
    input clk,
    input en,
    input trigger,
    `ifndef MASTER
    input set,
    input signed [`DATAWIDTH-1:0] delta_cntr,
    `endif
    output [`DATAWIDTH-1:0] cnt
    );
    
    (*keep="true"*) reg [`DATAWIDTH-1:0] cntr, tmp_cntr, cntr_internal;
    
    always@(posedge clk) begin
        if(rst) begin
            cntr <= {`DATAWIDTH{1'b0}};
            tmp_cntr <= {`DATAWIDTH{1'b0}};
        end
        else begin
            `ifndef MASTER
            if(set) begin
                cntr <= cntr - delta_cntr;
            end
            else if(en) begin
                cntr <= cntr + 1'b1;
            end
            else begin
                cntr <= cntr;
            end
            `else
            if(en) begin
                cntr <= cntr + 1'b1;
            end
            else begin
                cntr <= cntr;
            end
            `endif
            
            if(trigger) begin
                tmp_cntr <= cntr_internal;
            end
            else begin
                tmp_cntr <= tmp_cntr;
            end
        end
    end
    
    always @(*) begin
        if(rst) begin
            cntr_internal = 0;
        end
        else if(trigger) begin
            cntr_internal = cntr;
        end
        else begin
            cntr_internal = tmp_cntr;
        end
    end
    
    assign cnt = cntr_internal;
    
endmodule