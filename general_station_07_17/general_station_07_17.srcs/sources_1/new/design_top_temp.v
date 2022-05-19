`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 12/08/2020 12:19:30 PM
// Design Name: 
// Module Name: design_top_temp
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

module design_top_temp #(
    parameter t_r_f_ratio = (`RXF/(`TXF/2))             //r_t_f_ratio
)(
    (* gated_clock = "yes" *) input wire clk100M,
    input wire clk20M,
    input wire rst,
    `ifdef MASTER
        input wire trigger,
        output reg m_rx_err,
    `else
//        input wire trigger_slave,
        output reg s_rx_err,
        output wire signed [`DATAWIDTH-1:0] phase_computed_tmp,
        output reg re_prog_on,
        input pts_trigger,
//        output reg [`DATAWIDTH-1:0] referesh_rate,
    `endif
    input wire rx_serial_in,
    output wire tx_serial_out,
    `ifdef VERIF
        output wire [`DATAWIDTH-1:0] LED_OUT,
    `endif
    
    input wire uart_on,
    output wire uart_serial_out,
    output wire uart_tx_ready
    );
    
    localparam timeOut = (t_r_f_ratio * `DATAWIDTH) + 20;           //20 for the final 4 0's Manchester encoded
    
    wire [`DATAWIDTH-1:0] ts_count;
    (*keep = "true"*) reg cntr_en;
//    wire trigger_ts;
    (*keep = "true"*) reg trigger_ts;
    
    localparam idle = 4'b0000, idle_cntr_en = 4'b0001, begin_ops = 4'b0010, tx_idle = 4'b0011, tx_cntr = 4'b0100, rx_idle = 4'b0101, uart_idle = 4'b0110, uart_ops = 4'b0111, uart_mem_read = 4'b1010;
    `ifdef SLAVE
        localparam compute_delta = 4'b1000, rx_idle_wait = 4'b1001, referesh_compute = 4'b1011, referesh_comp_temp = 4'b1100;
        (*keep = "true"*) reg [3:0] state = idle;
    `else
        (*keep = "true"*) reg [3:0] state = idle;
    `endif
    
    wire tx_ready;
    (*keep = "true"*) reg tx_on, rst_state_mach;
    
    (*keep = "true"*) reg [`RAM_ADDRSWIDTH_DB-1:0] dbuff_mem_addra, dbuff_mem_addra_uart, dbuff_mem_addra_internal, dbuff_mem_addra_internal_1, dbuff_mem_addra_internal_2, dbuff_mem_addra_internal_3, dbuff_mem_addra_internal_4;
    (*keep = "true"*) reg dbuff_mem_wea, dbuff_mem_en;
    (*keep = "true"*) reg [`DATAWIDTH-1:0] ts_count_internal = 0;
    wire [`DATAWIDTH-1:0] mem_out;
    
    (*keep = "true"*) reg [7:0] cntr = 0;
    
    (*keep = "true"*) reg [`DATAWIDTH-1:0] ts_count_internal_tmp;
    wire [`DATAWIDTH-1:0] parallel_dout;
    wire rx_ready, dv_broadCast;
    (*keep = "true"*) reg  trigger_int_tx;
    
    (*keep = "true"*) reg uart_tx_load, uart_mem_en, uart_flag, uart_tx_load_internal;
    wire uart_tx_ready_internal;
    
    `ifdef SLAVE
        (*keep = "true"*) reg slave_rx_flag, slave_trigger_internal, ops_2, rf_flag = 0, comp_flag = 0;
        
        (*keep = "true"*) reg compute_on, compute_on_internal, trigger_slave;
        (*keep = "true"*)  wire compute_done;
       
        (*keep = "true"*) wire signed [`DATAWIDTH-1:0] delta_cntr;
        (*keep = "true"*) wire [`DATAWIDTH-1:0] referesh_cntr_reg0;
        
        (*keep = "true"*) reg [`DATAWIDTH-1:0] referesh_cntr_reg1 = 0;
        (*keep = "true"*) reg signed [`DATAWIDTH-1:0] referesh_rate = 0;
    `endif
    
    cntr_tst ts_gen(
        .clk(clk100M),
        .rst(rst),
        .en(cntr_en),
        .trigger(trigger_ts),
        `ifndef MASTER 
        .set (re_prog_on),
        .delta_cntr (delta_cntr),
        `endif
        .cnt(ts_count)
    );
    
    manchester_tx_top tx_m(
        .clk(clk100M),
        .rst(rst),
        .tx_on(tx_on),
        .o_tx_ready(tx_ready),
        .manch_out(tx_serial_out),
        `ifdef MASTER
            .coarse_tx_din(ts_count_internal),
        `endif
        .rst_state_mach(rst_state_mach)
    );
    
//    cdc_wrapper_df tx_m(
//        .clk100M(clk100M),
//        .clk20M(clk20M),
//        .rst(rst),
//        .tx_on(tx_on),
//        .tx_ready(tx_ready),
//        .manch_out(tx_serial_out),
//        `ifdef MASTER
//            .coarse_tx_din(ts_count_internal),
//        `endif
//        .rst_state_mach(rst_state_mach)
//    );
    
    `ifdef MASTER
        sp_ram_sim dbuff(
            .clk(clk100M),
            .data_in(ts_count_internal),
            .en(dbuff_mem_en),
            .wea(dbuff_mem_wea),
            .addrs(dbuff_mem_addra_internal),
            .data_out(mem_out)
        );
    `else
        buff_cal_wrapper dbuff(
            .clk(clk100M),
            .rst(rst),
            .data_in(ts_count_internal),
            .en(dbuff_mem_en),
            .wea(dbuff_mem_wea),
            .addrs(dbuff_mem_addra_internal),
            .compute_on(compute_on),
            .data_out(mem_out),
            .compute_done(compute_done),
            .phase_computed_tmp(delta_cntr),
            .referesh_cntr_0(referesh_cntr_reg0)
        );
    `endif
    
    manchester_rx_top #(
        .t_r_f_ratio(t_r_f_ratio)
    )rx_m(
        .clk(clk100M),
        .rst(rst),
        .serial_din(rx_serial_in),
        .parallel_dout(parallel_dout),
        .rx_ready(rx_ready),
        .dv_broadCast(dv_broadCast)
    );
    
    uart_tx_wrapper #(
        .DATAWIDTH(`DATAWIDTH),
        .BITCOUNTMAX(`BITCOUNTMAX),
        .SAMPLECOUNTMAX(`SAMPLECOUNTMAX)
    )uart(
        .clk(clk100M),
        .rst(rst),
        .tx_parallel_data(mem_out),
        .tx_data_load(uart_tx_load_internal),
        .tx_serial_data(uart_serial_out),
        .tx_ready(uart_tx_ready_internal)
    );
    
    `ifdef MASTER
        always @(*) begin
            if(rst) begin
                trigger_int_tx = 0;
            end
            else begin
                if(state == idle_cntr_en) begin
                    if(!rx_ready) begin
                        trigger_int_tx = 1'b1;
                    end
                    else begin
                        trigger_int_tx = 0;
                    end
                end
                else begin
                    trigger_int_tx = 0;
                end
            end
        end
    `else
        always @(*) begin
            if(rst) begin
                trigger_int_tx = 0;
            end
            else begin
                if(state == idle_cntr_en) begin
                    if(!rx_ready && !ops_2) begin
                        trigger_int_tx = 1'b1;
                    end
                    else begin
                        trigger_int_tx = 0;
                    end
                end
                else begin
                    trigger_int_tx = 0;
                end
            end
        end
        
        always @(posedge clk100M) begin
            if(rst) begin
                re_prog_on <= 0;
            end
            else begin
                re_prog_on <= compute_done;
            end
        end        
//        assign re_prog_on = compute_done;
    `endif
    
    `ifdef VERIF
        assign LED_OUT = ts_count_internal;
    `endif
    
    `ifdef MASTER
        always @(*) begin
            if(rst) begin
                trigger_ts = 0;
            end
            else begin
                trigger_ts = trigger | trigger_int_tx;
            end
        end
    `else
        always @(*) begin
            if(rst) begin
                trigger_ts = 0;
            end
            else begin
                trigger_ts = trigger_slave | trigger_int_tx | pts_trigger;
            end
        end
        
        assign phase_computed_tmp = delta_cntr;
    `endif
    
    assign uart_tx_ready = uart_tx_ready_internal;
    
    always @(*) begin
        case(uart_mem_en)
            1'b0: begin
                `ifdef MASTER
                    dbuff_mem_addra_internal = dbuff_mem_addra_internal_2;
                `else
                    if(compute_on) begin
                        dbuff_mem_addra_internal = dbuff_mem_addra_internal_4;
                    end
                    else begin
                        dbuff_mem_addra_internal = dbuff_mem_addra_internal_4;
                    end
                `endif
            end
            1'b1: begin
                dbuff_mem_addra_internal = dbuff_mem_addra_uart;
            end
            default: begin
                dbuff_mem_addra_internal = dbuff_mem_addra_internal_4;
            end
        endcase 
    end
    
    always @(posedge clk100M) begin
        if(rst) begin
            uart_tx_load_internal <= 0;
            dbuff_mem_addra_internal_1 <= 0;
            dbuff_mem_addra_internal_2 <= 0;
            dbuff_mem_addra_internal_3 <= 0;
            dbuff_mem_addra_internal_4 <= 0;
        end
        else begin
            uart_tx_load_internal <= uart_tx_load;
            dbuff_mem_addra_internal_1 <= dbuff_mem_addra;
            dbuff_mem_addra_internal_2 <= dbuff_mem_addra_internal_1;
            dbuff_mem_addra_internal_3 <= dbuff_mem_addra_internal_2;
            dbuff_mem_addra_internal_4 <= dbuff_mem_addra_internal_3;
        end
    end
    
    
    //statemachine
    
    always @(posedge clk100M) begin
        if(rst) begin
            state <= idle;
            cntr_en <= 1'b0;
            tx_on <= 1'b0;
            dbuff_mem_wea <= 1'b0;
            dbuff_mem_en <= 1'b0;
            rst_state_mach <= 1'b0;
            dbuff_mem_addra <= 0;
            cntr <= 0;
//            trigger_int_tx <= 1'b0;
            ts_count_internal <= {`DATAWIDTH{1'b0}};
            ts_count_internal_tmp <= {`DATAWIDTH{1'b0}};
            dbuff_mem_addra_uart <= 0;
            uart_mem_en <= 1'b0;
            uart_tx_load <= 1'b0;
            uart_flag <= 1'b0;
            `ifdef SLAVE
                slave_rx_flag <= 1'b0;
                slave_trigger_internal <= 1'b0;
                ops_2 <= 1'b0;
                compute_on <= 1'b0;
                compute_on_internal <= 1'b0;
                trigger_slave <= 0;
                referesh_cntr_reg1 <= 0;
                referesh_rate <= 0;
                rf_flag <= 0;
                comp_flag <= 0;
            `else
                m_rx_err <= 1'b0;
            `endif
        end
        else begin
            case (state)
                idle: begin
                    if(!rst) begin
                        cntr_en <= 1'b1;
                        state <= idle_cntr_en;
                        dbuff_mem_addra <= 0;
                        dbuff_mem_addra_uart <= 0;
                    end
                end
                
                idle_cntr_en: begin
                    dbuff_mem_wea <= 1'b0;
                    dbuff_mem_en <= 1'b0;
                    uart_tx_load <= 1'b0;
                    `ifdef MASTER
                        if(trigger) begin
                    `else
                        if(trigger_slave) begin
                    `endif
                        dbuff_mem_en <= 1'b1;
                        rst_state_mach <= 1'b0;
                        tx_on <= 1'b1;
                        ts_count_internal <= ts_count;
                        `ifdef SLAVE
                            ops_2 <= 1'b0;
                            slave_rx_flag <= 1'b0;
                            slave_trigger_internal <= 1'b1;
                            trigger_slave <= 1'b0;
                        `endif
                        state <= begin_ops;
                    end
                    else if(!rx_ready) begin
                        dbuff_mem_en <= 1'b0;
                        rst_state_mach <= 1'b1;
                        state <= rx_idle;
                        `ifdef SLAVE
                            slave_rx_flag <= 1'b0;
                            slave_trigger_internal <= 1'b0;
                        `endif
                    end
                    `ifdef SLAVE
                        else if(compute_on_internal) begin
                            state <= compute_delta;
                            comp_flag <= 0;
//                            dbuff_mem_addra <= dbuff_mem_addra + 1'b1;
                        end
                        
                        else if(pts_trigger) begin
                            referesh_cntr_reg1 <= ts_count;
                            state <= referesh_compute;
                            rf_flag <= 1;
                        end
                    `endif
                    else if(uart_on) begin
                        state <= uart_mem_read;
                        dbuff_mem_addra_uart <= 0;
                        uart_mem_en <= 1'b1;
                    end
                    else begin
                        state <= idle_cntr_en;
                        rst_state_mach <= 1'b1;
//                        ts_count_internal <= 0;
                        `ifdef SLAVE
                            slave_trigger_internal <= 1'b0;
                            trigger_slave <= 0;
                            referesh_cntr_reg1 <= 0;
                            comp_flag <= 0;
                        `endif
                        tx_on <= 1'b0;
                        dbuff_mem_wea <= 1'b0;
                        dbuff_mem_en <= 1'b0;
                        cntr <= 0;
                        ts_count_internal_tmp <= {`DATAWIDTH{1'b0}};
                        dbuff_mem_addra_uart <= 0;
                        uart_mem_en <= 1'b0;
                        uart_flag <= 1'b0;
                    end
                end
                
                `ifdef MASTER
                    rx_idle : begin
                        rst_state_mach <= 1'b0;
                        tx_on <= 1'b1;
                        ts_count_internal <= ts_count;
                        state <= begin_ops;
//                        ts_count_internal_tmp <= ts_count;
//                        if(dv_broadCast) begin
//                            rst_state_mach <= 1'b0;
//                            tx_on <= 1'b1;
//                            ts_count_internal <= ts_count_internal_tmp;
//                            state <= begin_ops;
//                        end
//                        else begin
//                            if(cntr < timeOut) begin
//                                state <= rx_idle;
//                                rst_state_mach <= 1'b1;
//                                cntr <= cntr + 1'b1;
//                            end
//                            else begin
//                                cntr <= 0;
//                                m_rx_err <= 1'b1;
//                                state <= idle_cntr_en;
//                            end
//                        end
                    end
                    
                    begin_ops: begin
                        ts_count_internal <= ts_count_internal;
                        cntr <= 0;
                        dbuff_mem_wea <= 1'b1;
                        dbuff_mem_en <= 1'b1;
                        dbuff_mem_addra <= dbuff_mem_addra + 1'b1;
                        state <=  tx_idle;
                    end
                `else
                    rx_idle : begin
                        dbuff_mem_wea <= 1'b0;
                        dbuff_mem_en <= 1'b0;
//                        ts_count_internal_tmp <= ts_count;
                        if(rx_ready) begin
                            ts_count_internal <= parallel_dout;
                            ops_2 <= 1'b0;
                            if(ops_2) begin
                                compute_on_internal <= 1'b1;
                            end
                            state <= begin_ops;
                        end
//                        else if(dv_broadCast && !slave_rx_flag) begin
//                            state <= begin_ops;
//                            ts_count_internal <= ts_count_internal_tmp;
//                        end
                        else if(!slave_rx_flag) begin
                            state <= begin_ops;
                            ts_count_internal <= ts_count;
                        end
//                        else begin
//                            if(cntr < timeOut) begin
//                                state <= rx_idle;
//                                cntr <= cntr + 1'b1;
//                            end
//                            else begin
//                                cntr <= 0;
//                                s_rx_err <= 1'b1;
//                                state <= idle_cntr_en;
//                            end
//                        end
                    end
                    
                    begin_ops: begin
                        ts_count_internal <= ts_count_internal;
                        cntr <= 0;
                        if(!ops_2) begin
                            dbuff_mem_wea <= 1'b1;
                            dbuff_mem_en <= 1'b1;
                            dbuff_mem_addra <= dbuff_mem_addra + 1'b1;
                        end
                        
                        if(rf_flag) begin
                            state <= idle_cntr_en;
//                            ts_count_internal <= referesh_rate;
                            rf_flag <= 0;
                        end
                        else if(slave_rx_flag) begin
                            state <= rx_idle_wait;
                        end
                        else if(slave_trigger_internal) begin
                            state <= tx_idle;
                        end
                        else begin
                            slave_rx_flag <= 1'b1;
                            state <= rx_idle;
                        end
                    end
                    
                    rx_idle_wait: begin
                        dbuff_mem_wea <= 1'b0;
                        dbuff_mem_en <= 1'b0;
                        if(cntr < {3'b00, 5'b10111}) begin
                            cntr <= cntr + 1'b1;
                            state <= rx_idle_wait;
                        end
                        else begin
                            cntr <= 0;
                            state <= idle_cntr_en;
                        end
                        
                        if(!compute_on_internal) begin
                            dbuff_mem_addra <= 2;
                            trigger_slave <= 1'b1;
                        end
                        else begin
                            dbuff_mem_addra <= dbuff_mem_addra;
                        end
                    end
                    
                `endif
                
                tx_idle: begin
                    dbuff_mem_wea <= 1'b0;
                    dbuff_mem_en <= 1'b0;
//                    /////////////////////////***********************/////////////////////////
                    if(cntr < {3'b000, 5'b011010}) begin
                    /////////////////////////***********************/////////////////////////
                        cntr <= cntr + 1'b1;
                        state <= tx_idle;
                    end
                    else begin
                        tx_on <= 1'b0;
                        state <= tx_cntr;
                        cntr <= 0;
                    end
                end
                
                tx_cntr: begin  
                    if(!tx_ready) begin
                        state <= tx_cntr;
                    end
                    else begin
                        state <= idle_cntr_en;
                        `ifdef SLAVE
                            slave_trigger_internal <= 1'b0;
                            ops_2 <= 1'b1;
                        `endif
                    end
                end
                
                `ifdef SLAVE
                    compute_delta: begin
                        compute_on_internal <= 1'b0;
                        compute_on <= 1'b1;
                        if(!comp_flag) begin
                            comp_flag <= 1'b1;
                            state <=  compute_delta;
                            dbuff_mem_addra <= dbuff_mem_addra + 1'b1;
                        end
                        else if(compute_done)begin
                            compute_on <= 1'b0;
                            state <= idle_cntr_en;
//                            dbuff_mem_addra <= dbuff_mem_addra + 1'b1;
                        end
                        else begin
                           state <= compute_delta; 
                        end
                    end
                    
                    referesh_compute: begin
                        referesh_rate <= referesh_cntr_reg1 - referesh_cntr_reg0;
//                        ts_count_internal <= referesh_rate;
                        state <= referesh_comp_temp;
                    end
                    
                    referesh_comp_temp : begin
                        ts_count_internal <= referesh_rate;
                        state <= begin_ops;
                    end
                `endif
                
                uart_mem_read: begin
                    dbuff_mem_en <= 1'b1;
                    uart_tx_load <= 1'b1;
                    uart_flag <= 0;
                    state <= uart_idle;
                end
                
                uart_idle: begin
                    dbuff_mem_en <= 1'b0;
                    uart_tx_load <= 1'b0;
                    if(!uart_flag) begin
                        dbuff_mem_addra_uart <= dbuff_mem_addra_uart + 1'b1;
                        uart_flag <= 1'b1;
                        state <= uart_idle;
                    end
                    else begin
                        uart_flag <= 1'b0;
                        state <= uart_ops;
                    end
                end
                
                uart_ops: begin
                    if(!uart_tx_ready_internal) begin
                        state <= uart_ops;
                    end
                    else begin
                        if(dbuff_mem_addra_uart <= dbuff_mem_addra) begin
                            state <= uart_mem_read;
                        end
                        else begin
                            state <= idle;
                            uart_mem_en <= 1'b0;
                        end
                    end
                end
                
                default: begin
                    state <= idle;
                end
            endcase
        end
    end
    
//    function integer cal_TO;
//        input integer t_r_f_ratio;
//        integer i, j;
//        for (i=0; i<(`DATAWIDTH/2); i=i+1) begin
//            j = t_r_f_ratio;
//            t_r_f_ratio = j << 1;
//        end
//    endfunction
    
endmodule