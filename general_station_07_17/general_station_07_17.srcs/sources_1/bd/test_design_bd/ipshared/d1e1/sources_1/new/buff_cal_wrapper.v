`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 01/13/2021 02:20:27 PM
// Design Name: 
// Module Name: buff_cal_wrapper
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

module buff_cal_wrapper(
    input clk,
    input rst,
    input [`DATAWIDTH-1:0] data_in,
    input en,
    input wea,
    input compute_on,
    input [`RAM_ADDRSWIDTH_DB-1:0] addrs,
    output reg [`DATAWIDTH-1:0] data_out,
    output reg compute_done,
    output reg signed [`DATAWIDTH-1:0] phase_computed_tmp,
    output reg [`DATAWIDTH-1:0] referesh_cntr_0
    );
    
    wire signed [`DATAWIDTH-1:0] delta_comp;
    (*keep = "true"*) reg en_comp, wea_comp;
    (*keep = "true"*) reg [`RAM_ADDRSWIDTH_DB-1:0] addrs_comp;
    
    (*keep = "true"*) reg [`DATAWIDTH-1:0] num0, num1;
    
    (*keep = "true"*) reg signed [`DATAWIDTH:0] sub0, sub1, tmp_delta;
    
    (*keep = "true"*) reg [`DATAWIDTH-1:0] data_internal;
    (*keep = "true"*) reg en_internal, wea_interanl;
    (*keep = "true"*) reg [`RAM_ADDRSWIDTH_DB-1:0] addrs_internal;
    wire [`DATAWIDTH-1:0] mem_out;
    
    (*keep = "true"*) reg pass1_flag, sub1_flag;
    
    (*keep = "true"*) reg [2:0] state;
    
    localparam idle = 3'b000, mem_read = 3'b001, inter_ops0 = 3'b010, inter_ops1 = 3'b011, add_partials = 3'b100, div_vals = 3'b101, stop = 3'b110, tmp_idle = 3'b111;
    
    sp_ram_sim dbuff(
        .clk(clk),
        .data_in(data_internal),
        .en(en_internal),
        .wea(wea_interanl),
        .addrs(addrs_internal),
        .data_out(mem_out)
    );
    
    assign delta_comp = (wea_comp) ? tmp_delta >> 1 : 0;
    
    always @(*) begin
        if(rst) begin
            data_internal = 0;
            en_internal = 0;
            wea_interanl = 0;
            addrs_internal = 0;
            data_out = 0;
        end
        else if(!compute_on) begin
            data_internal = data_in;
            en_internal = en;
            wea_interanl = wea;
            addrs_internal = addrs;
            data_out = mem_out;
        end
        else begin
            data_internal = delta_comp;
            en_internal = en_comp;
            wea_interanl = wea_comp;
            addrs_internal = addrs_comp;
            data_out = {`DATAWIDTH{1'bz}};
        end
    end
    
    always @(posedge clk) begin
        if(rst) begin
            phase_computed_tmp <= 0;
        end
        else begin
            if(wea_comp)    
                phase_computed_tmp <= delta_comp;
        end
    end
    
    always @(posedge clk) begin
        if(rst) begin
            state <= idle;
            en_comp <= 1'b0;
            wea_comp <= 1'b0;
            addrs_comp <= 0;
            num0 <= 0;
            num1 <= 0;
            sub0 <= 0;
            sub1 <= 0;
            tmp_delta <= 0;
            pass1_flag <= 1'b0;
            sub1_flag <= 1'b0;
            compute_done <= 1'b0;
            referesh_cntr_0 <= 0;
        end
        else begin
            case(state)
                idle: begin
                    compute_done <= 1'b0;
                    pass1_flag <= 1'b0;
                    sub1_flag <= 1'b0;
                    wea_comp <= 1'b0;
                    en_comp <= 1'b0;
                    if(compute_on) begin
                        addrs_comp <= addrs - 4;
                        state <= mem_read;
                    end
                    else begin
                        state <= idle;
                    end
                end
                
                mem_read: begin
                    en_comp <= 1'b1;
                    state <= tmp_idle;
                end
                
                tmp_idle: begin
                    en_comp <= 1'b0;
                    state <= inter_ops0;
                end
                
                inter_ops0: begin
                    en_comp <= 1'b0;
                    addrs_comp <= addrs_comp + 1'b1;
//                    num0 <= mem_out;
//                    num1 <= num0;
//                    if(!pass1_flag) begin
//                        state <= mem_read;
//                        pass1_flag <= 1'b1;
//                    end
//                    else begin
//                        state <= inter_ops1;
//                        pass1_flag <= 1'b0;
//                    end
                    if(!pass1_flag && !sub1_flag) begin
                        num0 <= mem_out;
                        state <= mem_read;
                        pass1_flag <= 1'b1;
                    end
                    else if(pass1_flag && !sub1_flag) begin
                        state <= inter_ops1;
//                        num1 <= twos_comp(mem_out);
                        num1 <= mem_out;
                        referesh_cntr_0 <= mem_out;
                        pass1_flag <= 1'b0;
                    end
                    else if(!pass1_flag && sub1_flag) begin
//                        num0 <= twos_comp(mem_out);
                        num0 <= mem_out;
                        state <= mem_read;
                        pass1_flag <= 1'b1;
                    end
                    else if(pass1_flag && sub1_flag) begin
                        num1 <= mem_out;
                        state <= inter_ops1;
                        pass1_flag <= 1'b0;
                    end
                end
                
                inter_ops1: begin
                    if(!sub1_flag) begin
//                        if(num1 < num0) begin
//                            sub0 <= num0 - num1;
//                        end
//                        else begin
//                            sub0 <= num1 - num0;
//                        end
                        sub0 <= num0 - num1;
//                        sub0 <= {num0[`DATAWIDTH-1], num0} + {num1[`DATAWIDTH-1], num1};
                        sub1_flag <= 1'b1;
                        state <= mem_read;
                    end
                    else begin
//                        if(num1 < num0) begin
//                            sub1 <= num0 - num1;
//                        end
//                        else begin
//                            sub1 <= num1 - num0;
//                        end
//                        sub1 <= {num0[`DATAWIDTH-1], num0} + {num1[`DATAWIDTH-1], num1};
                        sub1 <= num1 - num0;
                        sub1_flag <= 1'b0;
                        state <= add_partials;
                    end
                end
                
                add_partials: begin
                    tmp_delta <= sub0 - sub1;
                    state <= div_vals;
                end
                
                div_vals: begin
                    en_comp <= 1'b1;
                    wea_comp <= 1'b1;
                    compute_done <= 1'b1;
                    state <= stop;
                end
                
                stop: begin
                    en_comp <= 1'b0;
                    wea_comp <= 1'b0;
//                    compute_done <= 1'b1;
                    state <= idle;
                end
                
                default: begin
                    state <= idle;
                end
            endcase
        end
    end
    
    function [`DATAWIDTH-1:0] twos_comp (input [`DATAWIDTH-1:0] num);
        reg [`DATAWIDTH-1:0] comp_num;
        begin
            comp_num = ~num;
            twos_comp = comp_num + {{(`DATAWIDTH-1){1'b0}},{1'b1}};
        end
    endfunction
    
endmodule
