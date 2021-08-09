`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 10/14/2020 07:24:11 PM
// Design Name: 
// Module Name: uart_txm_ex
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


module uart_txm_ex #(
    parameter DATAWIDTH = 8,
    parameter BITCOUNTMAX = DATAWIDTH,
    parameter SAMPLECOUNTMAX = 868
)(
    input clk,
    input rst,
    input [DATAWIDTH-1:0] tx_parallel_data,
    input tx_data_load,
    output tx_serial_data,
    output tx_ready
    );
    
//    (*keep = "true"*) reg [DATAWIDTH-1:0] tx_shift_reg;
    
    (*keep = "true"*) reg [DATAWIDTH-1:0] tx_reg;
    
    (*keep = "true"*) reg tx_serial_data_internal, ready_internal;
    
    localparam BCWIDTH = 8, SCWIDTH = clogb2(SAMPLECOUNTMAX-1);
    
    (*keep = "true"*) integer bit_count, cntr = 0;
    
    (*keep = "true"*) integer sample_count;
    
    (*keep = "true"*) reg [1:0] state;
    
//    reg tx_data_load_int;
    
    localparam idle = 2'b00, tx_start = 2'b01, tx_data = 2'b10, stop = 2'b11;
    
    assign tx_serial_data = tx_serial_data_internal;
    
    assign tx_ready = ready_internal;
    
//    always @(posedge clk) begin
//        if(rst) begin
//            tx_data_load_int <= 1'b0;
//        end
//        else begin
//            tx_data_load_int <= tx_data_load;
//        end
//    end
    
    always @(posedge clk) begin
        if(rst) begin
            state <= idle;
            ready_internal <= 1'b1;
//            tx_shift_reg <= {(DATAWIDTH){1'b1}};
            tx_reg <= {(DATAWIDTH){1'b0}};
            tx_serial_data_internal <= 1'b1;
            bit_count <= {(BCWIDTH){1'b0}};
            sample_count <= {(SCWIDTH){1'b0}};
            cntr <= 0;
        end
        else begin
            case(state)
                idle: begin
//                    tx_serial_data_internal <= 1'b1;
//                    tx_shift_reg <= {(DATAWIDTH){1'b1}};
                    cntr <= 0;
                    bit_count <= {(BCWIDTH){1'b0}};
                    sample_count <= {(SCWIDTH){1'b0}};
                    if(tx_data_load) begin
                        tx_serial_data_internal <= 1'b0;
                        tx_reg <= tx_parallel_data;
                        state <= tx_start;
                        ready_internal <= 1'b0;
                    end
                    else begin
                        tx_reg <= {(DATAWIDTH){1'b0}};
                        ready_internal <= 1'b1;
                        state <= idle;
                    end
                end
                
                tx_start: begin
//                    tx_serial_data_internal <= 1'b0;
                    if(sample_count < SAMPLECOUNTMAX-1) begin
                        tx_serial_data_internal <= 1'b0;
                        sample_count <= sample_count + 1'b1;
                        state <= tx_start;
                    end
                    else begin
                        tx_serial_data_internal <= tx_reg[0];
//                        tx_shift_reg <= tx_reg;
                        sample_count <= {(SCWIDTH){1'b0}};
                        state <= tx_data;
                    end
                end
                
                tx_data: begin
//                    tx_serial_data_internal <= tx_shift_reg[0];
                    if(bit_count < BITCOUNTMAX-1) begin
                        if(sample_count < SAMPLECOUNTMAX-1) begin
                            tx_serial_data_internal <= tx_reg[0];
                            sample_count <= sample_count + 1'b1;
                            state <= tx_data;
                            if(sample_count == SAMPLECOUNTMAX-2) begin
                                tx_reg <= {1'b1, tx_reg[DATAWIDTH-1:1]};
                            end
                        end
                        else begin
                            sample_count <= {(SCWIDTH){1'b0}};
                            bit_count <= bit_count + 1'b1;
//                            tx_shift_reg <= {1'b1, tx_shift_reg[DATAWIDTH-1:1]};
                            tx_serial_data_internal <= tx_reg[0];
                            state <= tx_data;
                        end
                    end
                    else begin
                        if(sample_count == 0) begin
                            sample_count <= sample_count + 1'b1;
                            state <= tx_data;
                        end
                        else if (sample_count < SAMPLECOUNTMAX-1) begin
                            sample_count <= sample_count + 1'b1;
                            state <= tx_data;
                            if(sample_count == SAMPLECOUNTMAX-2) begin
                                tx_reg <= {1'b1, tx_reg[DATAWIDTH-1:1]};
                            end
                        end
                        else begin
//                            tx_shift_reg <= {1'b1, tx_shift_reg[DATAWIDTH-1:1]};
                            bit_count <= {(BCWIDTH){1'b0}};
                            sample_count <= {(SCWIDTH){1'b0}};
                            state <= stop;
                            tx_serial_data_internal <= 1'b1;
                        end
                    end
                end
                
                stop: begin
                    if(sample_count < SAMPLECOUNTMAX-1) begin
                        tx_serial_data_internal <= 1'b1;
                        sample_count <= sample_count + 1'b1;
                        state <= stop;
                        if((sample_count == SAMPLECOUNTMAX-3) && (cntr == DATAWIDTH)) begin
                            ready_internal <= 1'b1;
                        end
                        else begin
                            ready_internal <= ready_internal;
                        end
                    end
                    else if(cntr < (DATAWIDTH-8)) begin
                        bit_count <= {(BCWIDTH){1'b0}};
                        sample_count <= {(SCWIDTH){1'b0}};
                        tx_serial_data_internal <= 1'b0;
                        cntr <= (cntr + 8);
                        state <= tx_start;
                    end
                    else begin
                        if(tx_data_load) begin
                            tx_serial_data_internal <= 1'b0;
                            sample_count <= {(SCWIDTH){1'b0}};
                            tx_reg <= tx_parallel_data;
                            state <= tx_start;
                            ready_internal <= 1'b0;
                        end
                        else begin
                            tx_reg <= {(DATAWIDTH){1'b0}};
                            bit_count <= {(BCWIDTH){1'b0}};
                            sample_count <= {(SCWIDTH){1'b0}};
                            ready_internal <= 1'b1;
                            state <= idle;
                        end
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
