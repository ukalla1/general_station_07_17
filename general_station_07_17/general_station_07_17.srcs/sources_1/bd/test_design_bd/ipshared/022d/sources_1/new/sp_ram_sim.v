`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 12/08/2020 12:20:30 PM
// Design Name: 
// Module Name: sp_ram_sim
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

module sp_ram_sim(
    input clk,
    input [`DATAWIDTH-1:0] data_in,
    input en,
    input wea,
    input [`RAM_ADDRSWIDTH_DB-1:0] addrs,
    output [`DATAWIDTH-1:0] data_out
    );
    
    reg [`DATAWIDTH-1:0] ram_sp [`RAM_DEPTH_DATA_BUFF-1:0];
    
    (*keep = "true"*) reg [`DATAWIDTH-1:0] data_out_internal = {`DATAWIDTH{1'b0}};
    
    generate
    if(`INIT_FILE_DB != "") begin: using_init_file
        initial begin
            $readmemb(INIT_FILE, ram_sp, 0, `RAM_DEPTH_DATA_BUFF-1);
        end
    end
    else begin: setting_to_zero
        integer index;
        initial begin
            for(index=0; index<`RAM_DEPTH_DATA_BUFF; index=index+1) begin
                ram_sp[index] <= {(`DATAWIDTH){1'b0}};
            end
        end
    end
    endgenerate
    
    always @(posedge clk) begin
        if(en) begin
            if(wea) begin
                ram_sp[addrs] <= data_in;
            end
            else if(!wea) begin
                data_out_internal <= ram_sp[addrs];
            end
        end
    end
    
    assign data_out = data_out_internal;
    
endmodule