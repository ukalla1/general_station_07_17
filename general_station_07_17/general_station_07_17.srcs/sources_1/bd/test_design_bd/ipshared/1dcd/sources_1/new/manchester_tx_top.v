`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 11/03/2020 11:56:49 AM
// Design Name: 
// Module Name: manchester_tx_top
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

module manchester_tx_top(
    input clk,              //input clk
    input rst,              //global reset signal
    input tx_on,            //input trasnmitter on signal
    output o_tx_ready,     //transmission done soft signal
    output manch_out,        //the manchester encoded output
    `ifdef MASTER
        input [`DATAWIDTH-1:0]coarse_tx_din,
    `endif
    input rst_state_mach
//    input fine_tx_din
    );
    
//    localparam RAM_ADDRSWIDTH = clogb2(`RAM_DEPTH-1);  //Memory address width computation (function call)
    
    (*keep = "true"*) reg tx_on_internal;
    
//    reg [`RAM_ADDRSWIDTH_M-1:0] ram_addrb;
    
//    wire [`DATAWIDTH-1:0] mem_out;
    
    (*keep = "true"*) wire tx_ready;
    
    (*keep = "true"*) reg [2:0] state;
    
    (*keep = "true"*) reg [8-1:0] preamble = `PREAMBLE;
    (*keep = "true"*) reg [`DATAWIDTH-1:0] tx_in;
    `ifdef MASTER
        (*keep = "true"*) reg [`DATAWIDTH-1:0] coarse_ts_reg;
    `endif
    
    localparam idle = 3'b000, tx_preamble = 3'b001, coarse_read = 3'b010, tx_data = 3'b011, stop = 3'b100;
    
    //The dual port ram that the transmitter reads from
//    ram_dp__sim_par #(
//        .DATA_WIDTH(`DATAWIDTH),
//        .RAM_DEPTH(`RAM_DEPTH),
//        .INIT_FILE(`RAM_INITFILE),
//        .ADDRS_WIDTH(`RAM_ADDRSWIDTH_M)
//    )ram(
//        .clk(clk),
//        .wea(tx_mem_wea),
//        .enb(tx_ready),
//        .dina(tx_mem_din),
//        .addra(tx_mem_addra),
//        .addrb(ram_addrb),
//        .doutb(mem_out)
//    );
    
    ////Instantiating the transmitter module
    manchester_tx_m tx_m(
        .clk(clk),
        .rst(rst),
        .parallel_din(tx_in),
        .tx_on(tx_on_internal),
        .tx_ready(tx_ready),
        .dout(manch_out)
    );
    
    assign o_tx_ready = (state == idle || state == stop) ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        if(rst) begin
            state <= idle;
            tx_on_internal <= 1'b0;
//            ram_addrb <= {`RAM_ADDRSWIDTH_M{1'b0}};
            tx_in <= {`DATAWIDTH{1'b0}};
            `ifdef MASTER
                coarse_ts_reg <= {`DATAWIDTH{1'b0}};
            `endif
        end
        else begin
            case(state)
                idle: begin
                    if(tx_on) begin
                        `ifdef MASTER
                            coarse_ts_reg <= coarse_tx_din;
                        `endif
                        if(tx_ready) begin
                            state <= tx_preamble;
                            tx_on_internal <= tx_on;
                            tx_in <= {{56{1'b0}}, preamble};
                        end
                        else begin
                            state <= idle;
                            tx_on_internal <= 1'b0;
                            tx_in <= {`DATAWIDTH{1'b0}};
                        end
                    end
                    else begin
                        state <= idle;
                        tx_on_internal <= 1'b0;
                        tx_in <= {`DATAWIDTH{1'b0}};
                    end
                end
                
                tx_preamble: begin
                    if(!tx_ready) begin
                        state <= tx_preamble;
                    end
                    else begin
                        `ifdef MASTER
                            state <= coarse_read;
                            tx_in <= coarse_ts_reg;
                        `else
                            state <= stop;
                            tx_on_internal <= 1'b0;
                        `endif
                    end
                end
                
                coarse_read: begin
//                    ram_addrb <= ram_addrb + 1'b1;
//                    tx_in <= mem_out;
                    state <= tx_data;
                end
                
//                fine_read: begin
//                        tx_in <= fine_ts_reg;
//                    state <= tx_data;
//                        fine_done = 1'b1;
//                end
                
                tx_data: begin
                    if(!tx_ready) begin
                        state <= tx_data;
                    end
                    else begin
//                        if(ram_addrb == {`RAM_ADDRSWIDTH_M{1'b1}}) begin
//                            state <= stop;
//                            ram_addrb <= {`RAM_ADDRSWIDTH_M{1'b0}};
//                            tx_on_internal <= 1'b0;
//                        end
//                        else begin
//                            state <= mem_read;
//                        end
                        tx_on_internal <= 1'b0;
                        state <= stop;
                    end
                end
                
                stop: begin
                    if(rst_state_mach) begin
                        state <= idle;
                    end
                    else begin
                        state <= stop;
                    end
                end
                
                default: begin
                    state <= idle;
                end
                
            endcase
        end
    end
    
    function integer clogb2;
        input integer depth;
        integer result;
        begin
            result = depth;
            for (clogb2=0; result>0; clogb2=clogb2+1) begin
                result = result >> 1;
            end
        end
    endfunction
    
endmodule
