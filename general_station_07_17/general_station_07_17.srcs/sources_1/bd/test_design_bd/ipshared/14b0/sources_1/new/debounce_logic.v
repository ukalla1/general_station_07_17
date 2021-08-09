`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 03/07/2021 01:48:41 PM
// Design Name: 
// Module Name: debounce_logic
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


module debounce_logic #(
    parameter clock_frequency = 100_000_000,
    parameter stable_time = 10
)(
    input clk,
    input rst,
    input button_in,
    output button_out
    );
    
    localparam max_counter_val = (clock_frequency * stable_time) / 1000;
    
    (*keep = "true"*) reg ff1, ff2, out_internal, flag;
    wire xor_out;
    integer counter;
    
    assign button_out = out_internal;
    assign xor_out = ff1 ^ ff2;
    
    always @(posedge clk) begin
        if(rst) begin
            ff1 <= 0;
            ff2 <= 0;
            counter <= 0;
            out_internal <= 0;
            flag <= 0;
        end
        else begin
            ff1 <= button_in;
            ff2 <= ff1;
            
            if(xor_out) begin
                flag <= 0;
                counter <= 0;
            end
            else if (counter < max_counter_val) begin
                counter <= counter + 1'b1;
            end
            else if (!flag) begin
                flag <= 1'b1;
                out_internal <= ff1;
            end
            else begin
                out_internal <= 0;
            end
        end
    end
    
    
    
endmodule
