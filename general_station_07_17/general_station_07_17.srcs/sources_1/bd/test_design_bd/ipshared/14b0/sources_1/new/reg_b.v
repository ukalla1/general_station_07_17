`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Uttej
// 
// Create Date: 06/29/2021 08:50:13 AM
// Design Name: 
// Module Name: reg_b
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

//`include "funcs.v"

module reg_b #(
    parameter CLKFBOUT_MULT          = 2,
    parameter CLKFBOUT_PHASE         = 0,
    parameter CLKFBOUT_FRAC          = 125,
    parameter CLKFBOUT_FRAC_EN       = 1,
    parameter BANDWIDTH              = "LOW",
    parameter DIVCLK_DIVIDE          = 2
)(
    input clk,
    input rst,
    input en,
    input wen,
    input [31:0] reg_data_in,
    output reg [31:0] reg_data_out,
    input [4:0] reg_sel,
    input [4:0] ram_addr,
    output reg [38:0] ram_do
    );
    
    (*keep = "true"*) reg [31:0] CLKOUT0_DIVIDE      = 12;         //0
    (*keep = "true"*) reg [31:0] CLKOUT0_PHASE       = 0;         //1
    (*keep = "true"*) reg [31:0] CLKOUT0_DUTY        = 50000;     //const
    (*keep = "true"*) reg [31:0] CLKOUT0_FRAC        = 0;         //2
    (*keep = "true"*) reg CLKOUT0_FRAC_EN            = 0;         //const
    
    (*keep = "true"*) reg [31:0] CLKOUT1_DIVIDE      = 1;         
    (*keep = "true"*) reg [31:0] CLKOUT1_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT1_DUTY        = 50000;
    //
    (*keep = "true"*) reg [31:0] CLKOUT2_DIVIDE      = 1;
    (*keep = "true"*) reg [31:0] CLKOUT2_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT2_DUTY        = 50000;
    //
    (*keep = "true"*) reg [31:0] CLKOUT3_DIVIDE      = 1;
    (*keep = "true"*) reg [31:0] CLKOUT3_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT3_DUTY        = 50000;
    //
    (*keep = "true"*) reg [31:0] CLKOUT4_DIVIDE      = 1;
    (*keep = "true"*) reg [31:0] CLKOUT4_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT4_DUTY        = 50000;
    //
    (*keep = "true"*) reg [31:0] CLKOUT5_DIVIDE      = 1;
    (*keep = "true"*) reg [31:0] CLKOUT5_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT5_DUTY        = 50000;
    //
    (*keep = "true"*) reg [31:0] CLKOUT6_DIVIDE      = 1;
    (*keep = "true"*) reg [31:0] CLKOUT6_PHASE       = 0;
    (*keep = "true"*) reg [31:0] CLKOUT6_DUTY        = 50000;
    
    ///////////////////////////////
    
    (*keep = "true"*) reg [37:0] CLKFBOUT                  = 0;
    (*keep = "true"*) reg [37:0] CLKFBOUT_FRAC_CALC        = 0;
    (*keep = "true"*) reg [9:0]  DIGITAL_FILT              = 0;
    (*keep = "true"*) reg [39:0] LOCK                      = 0;
    (*keep = "true"*) reg [37:0] DIVCLK                    = 0;
    (*keep = "true"*) reg [37:0] CLKOUT0                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT0_REG1              = 0; //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT0_REG2              = 0; //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT0_FRAC_CALC         = 0;
    (*keep = "true"*) reg [15:0] CLKOUT0_FRAC_REG1         = 0;  //See log file for 16 bit reporting of the registe
    (*keep = "true"*) reg [15:0] CLKOUT0_FRAC_REG2         = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [5:0] CLKOUT0_FRAC_REGSHARED     = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT1                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT1_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT1_REG2              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT2                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT2_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT2_REG2              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT3                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT3_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT3_REG2              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT4                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT4_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT4_REG2              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT5                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT5_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT5_REG2              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [37:0] CLKOUT6                   = 0;
    (*keep = "true"*) reg [15:0] CLKOUT6_REG1              = 0;  //See log file for 16 bit reporting of the register
    (*keep = "true"*) reg [15:0] CLKOUT6_REG2              = 0; //See log file for 16 bit reporting of the register
    
    //
    // RAM of:  39 bit word 32 words deep
    (*keep = "true"*)(* rom_style = "distributed" *) reg [38:0]  ram [31:0];
    (*keep = "true"*) wire reg_wen;
//    (*keep = "true"*) reg [5:0]   ram_addr;
//    (*keep = "true"*) reg [38:0]  ram_do;
    (*keep = "true"*) integer ii;
    
    assign reg_wen = en & wen;
    
    always @(posedge clk) begin
        if(rst) begin
            CLKOUT0_DIVIDE      <= 12;       
            CLKOUT0_PHASE       <= 0;       
            CLKOUT0_DUTY        <= 50000;   
            CLKOUT0_FRAC        <= 0;       
            CLKOUT0_FRAC_EN     <= 0;
            
            CLKOUT1_DIVIDE      <= 1;
            CLKOUT1_PHASE       <= 0;
            CLKOUT1_DUTY        <= 50000;
            //
            CLKOUT2_DIVIDE      <= 1;
            CLKOUT2_PHASE       <= 0;
            CLKOUT2_DUTY        <= 50000;
            //
            CLKOUT3_DIVIDE      <= 1;
            CLKOUT3_PHASE       <= 0;
            CLKOUT3_DUTY        <= 50000;
            //
            CLKOUT4_DIVIDE      <= 1;
            CLKOUT4_PHASE       <= 0;
            CLKOUT4_DUTY        <= 50000;
            //
            CLKOUT5_DIVIDE      <= 1;
            CLKOUT5_PHASE       <= 0;
            CLKOUT5_DUTY        <= 50000;
            //
            CLKOUT6_DIVIDE      <= 1;
            CLKOUT6_PHASE       <= 0;
            CLKOUT6_DUTY        <= 50000;
            
            reg_data_out        <= 0;
        end
        else begin
            CLKOUT0_DIVIDE      <= CLKOUT0_DIVIDE;       
            CLKOUT0_PHASE       <= CLKOUT0_PHASE;       
            CLKOUT0_DUTY        <= CLKOUT0_DUTY;   
            CLKOUT0_FRAC        <= CLKOUT0_FRAC;       
            CLKOUT0_FRAC_EN     <= CLKOUT0_FRAC_EN;
            
            CLKOUT1_DIVIDE      <= CLKOUT1_DIVIDE;
            CLKOUT1_PHASE       <= CLKOUT1_PHASE;
            CLKOUT1_DUTY        <= CLKOUT1_DUTY;
            //
            CLKOUT2_DIVIDE      <= CLKOUT2_DIVIDE;
            CLKOUT2_PHASE       <= CLKOUT2_PHASE;
            CLKOUT2_DUTY        <= CLKOUT2_DUTY;
            //
            CLKOUT3_DIVIDE      <= CLKOUT3_DIVIDE;
            CLKOUT3_PHASE       <= CLKOUT3_PHASE;
            CLKOUT3_DUTY        <= CLKOUT3_DUTY;
            //
            CLKOUT4_DIVIDE      <= CLKOUT4_DIVIDE;
            CLKOUT4_PHASE       <= CLKOUT4_PHASE;
            CLKOUT4_DUTY        <= CLKOUT4_DUTY;
            //
            CLKOUT5_DIVIDE      <= CLKOUT5_DIVIDE;
            CLKOUT5_PHASE       <= CLKOUT5_PHASE;
            CLKOUT5_DUTY        <= CLKOUT5_DUTY;
            //
            CLKOUT6_DIVIDE      <= CLKOUT6_DIVIDE;
            CLKOUT6_PHASE       <= CLKOUT6_PHASE;
            CLKOUT6_DUTY        <= CLKOUT6_DUTY;
            if(reg_wen) begin
                    case(reg_sel)
                        5'b00000: begin
                            CLKOUT0_DIVIDE      <= reg_data_in;
                        end
                        5'b00001: begin
                            CLKOUT0_PHASE       <= reg_data_in; 
                        end
                        5'b00010: begin
                            CLKOUT0_FRAC        <= reg_data_in;
                        end
                        5'b00011: begin
                            CLKOUT1_DIVIDE      <= reg_data_in;
                        end
                        5'b00100: begin
                            CLKOUT1_PHASE       <= reg_data_in;
                        end
                        5'b00101: begin
                            CLKOUT1_DUTY        <= reg_data_in;
                        end
                        5'b00110: begin
                            CLKOUT2_DIVIDE      <= reg_data_in;
                        end
                        5'b00111: begin
                            CLKOUT2_PHASE       <= reg_data_in;
                        end
                        5'b01000: begin
                            CLKOUT2_DUTY        <= reg_data_in;
                        end
                        5'b01001: begin
                            CLKOUT3_DIVIDE      <= reg_data_in;
                        end
                        5'b01010: begin
                            CLKOUT3_PHASE       <= reg_data_in;
                        end
                        5'b01011: begin
                            CLKOUT3_DUTY        <= reg_data_in;
                        end
                        5'b01100: begin
                            CLKOUT4_DIVIDE      <= reg_data_in;
                        end
                        5'b01101: begin
                            CLKOUT4_PHASE       <= reg_data_in;
                        end
                        5'b01110: begin
                            CLKOUT4_DUTY        <= reg_data_in;
                        end
                        5'b01111: begin
                            CLKOUT5_DIVIDE      <= reg_data_in;
                        end
                        5'b10000: begin
                            CLKOUT5_PHASE       <= reg_data_in;
                        end
                        5'b10001: begin
                            CLKOUT5_DUTY        <= reg_data_in;
                        end
                        5'b10010: begin
                            CLKOUT6_DIVIDE      <= reg_data_in;
                        end
                        5'b10011: begin
                            CLKOUT6_PHASE       <= reg_data_in;
                        end
                        5'b10100: begin
                            CLKOUT6_DUTY        <= reg_data_in;
                        end
                        5'b10101: begin
                            CLKOUT0_FRAC_EN     <= reg_data_in[0];
                        end
                    endcase
                end
                else begin
                    reg_data_out        <= CLKOUT0_DIVIDE;
                    case(reg_sel)
                        5'b00000: begin
                            reg_data_out        <= CLKOUT0_DIVIDE;
                        end
                        5'b00001: begin
                            reg_data_out        <= CLKOUT0_PHASE;
                        end
                        5'b00010: begin
                            reg_data_out        <= CLKOUT0_FRAC;
                        end
                        5'b00011: begin
                            reg_data_out        <= CLKOUT1_DIVIDE;
                        end
                        5'b00100: begin
                            reg_data_out        <= CLKOUT1_PHASE;
                        end
                        5'b00101: begin
                            reg_data_out        <= CLKOUT1_DUTY;
                        end
                        5'b00110: begin
                            reg_data_out        <= CLKOUT2_DIVIDE;
                        end
                        5'b00111: begin
                            reg_data_out        <= CLKOUT2_PHASE;
                        end
                        5'b01000: begin
                            reg_data_out        <= CLKOUT2_DUTY;
                        end
                        5'b01001: begin
                            reg_data_out        <= CLKOUT3_DIVIDE;
                        end
                        5'b01010: begin
                            reg_data_out        <= CLKOUT3_PHASE;
                        end
                        5'b01011: begin
                            reg_data_out        <= CLKOUT3_DUTY;
                        end
                        5'b01100: begin
                            reg_data_out        <= CLKOUT4_DIVIDE;
                        end
                        5'b01101: begin
                            reg_data_out        <= CLKOUT4_PHASE;
                        end
                        5'b01110: begin
                            reg_data_out        <= CLKOUT4_DUTY;
                        end
                        5'b01111: begin
                            reg_data_out        <= CLKOUT5_DIVIDE;
                        end
                        5'b10000: begin
                            reg_data_out        <= CLKOUT5_PHASE;
                        end
                        5'b10001: begin
                            reg_data_out        <= CLKOUT5_DUTY;
                        end
                        5'b10010: begin
                            reg_data_out        <= CLKOUT6_DIVIDE;
                        end
                        5'b10011: begin
                            reg_data_out        <= CLKOUT6_PHASE;
                        end
                        5'b10100: begin
                            reg_data_out        <= CLKOUT6_DUTY;
                        end
                    endcase
            end
        end
    end
    
    `include "mmcme2_drp_func.h"
        
    always @(*) begin
        CLKFBOUT                  = mmcm_count_calc(CLKFBOUT_MULT, CLKFBOUT_PHASE, 50000);
        CLKFBOUT_FRAC_CALC        = mmcm_frac_count_calc(CLKFBOUT_MULT, CLKFBOUT_PHASE, 50000, CLKFBOUT_FRAC);
        DIGITAL_FILT              = mmcm_filter_lookup(CLKFBOUT_MULT, BANDWIDTH);
        LOCK                      = mmcm_lock_lookup(CLKFBOUT_MULT);
        DIVCLK                    = mmcm_count_calc(DIVCLK_DIVIDE, 0, 50000);
        CLKOUT0                   = mmcm_count_calc(CLKOUT0_DIVIDE, CLKOUT0_PHASE, CLKOUT0_DUTY);
        CLKOUT0_REG1              = CLKOUT0[15:0]; //See log file for 16 bit reporting of the register
        CLKOUT0_REG2              = CLKOUT0[31:16]; //See log file for 16 bit reporting of the registe
        CLKOUT0_FRAC_CALC         = mmcm_frac_count_calc(CLKOUT0_DIVIDE, CLKOUT0_PHASE, 50000, CLKOUT0_FRAC);
        CLKOUT0_FRAC_REG1         = CLKOUT0_FRAC_CALC[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT0_FRAC_REG2         = CLKOUT0_FRAC_CALC[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT0_FRAC_REGSHARED    = CLKOUT0_FRAC_CALC[37:32];  //See log file for 16 bit reporting of the register
        CLKOUT1                   = mmcm_count_calc(CLKOUT1_DIVIDE, CLKOUT1_PHASE, CLKOUT1_DUTY);
        CLKOUT1_REG1              = CLKOUT1[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT1_REG2              = CLKOUT1[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT2                   = mmcm_count_calc(CLKOUT2_DIVIDE, CLKOUT2_PHASE, CLKOUT2_DUTY);
        CLKOUT2_REG1              = CLKOUT2[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT2_REG2              = CLKOUT2[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT3                   = mmcm_count_calc(CLKOUT3_DIVIDE, CLKOUT3_PHASE, CLKOUT3_DUTY);
        CLKOUT3_REG1              = CLKOUT3[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT3_REG2              = CLKOUT3[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT4                   = mmcm_count_calc(CLKOUT4_DIVIDE, CLKOUT4_PHASE, CLKOUT4_DUTY);
        CLKOUT4_REG1              = CLKOUT4[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT4_REG2              = CLKOUT4[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT5                   = mmcm_count_calc(CLKOUT5_DIVIDE, CLKOUT5_PHASE, CLKOUT5_DUTY);
        CLKOUT5_REG1              = CLKOUT5[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT5_REG2              = CLKOUT5[31:16];  //See log file for 16 bit reporting of the register
        CLKOUT6                   = mmcm_count_calc(CLKOUT6_DIVIDE, CLKOUT6_PHASE, CLKOUT6_DUTY);
        CLKOUT6_REG1              = CLKOUT6[15:0];  //See log file for 16 bit reporting of the register
        CLKOUT6_REG2              = CLKOUT6[31:16]; //See log file for 16 bit reporting of the register
    end
    
    always @(posedge clk) begin
        ram[0] <= {7'h28, 16'h0000, 16'hFFFF};
        
        // Store CLKOUT0 divide and phase
        ram[1]  <= (CLKOUT0_FRAC_EN == 0) ? {7'h09, 16'h8000, CLKOUT0[31:16]}: {7'h09, 16'h8000, CLKOUT0_FRAC_CALC[31:16]};
        ram[2]  <= (CLKOUT0_FRAC_EN == 0) ? {7'h08, 16'h1000, CLKOUT0[15:0]}: {7'h08, 16'h1000, CLKOUT0_FRAC_CALC[15:0]};
        
        // Store CLKOUT1 divide and phase
        ram[3]  <= {7'h0A, 16'h1000, CLKOUT1[15:0]};
        ram[4]  <= {7'h0B, 16'hFC00, CLKOUT1[31:16]};
        
        // Store CLKOUT2 divide and phase
        ram[5]  <= {7'h0C, 16'h1000, CLKOUT2[15:0]};
        ram[6]  <= {7'h0D, 16'hFC00, CLKOUT2[31:16]};
        
        // Store CLKOUT3 divide and phase
        ram[7]  <= {7'h0E, 16'h1000, CLKOUT3[15:0]};
        ram[8]  <= {7'h0F, 16'hFC00, CLKOUT3[31:16]};
        
        // Store CLKOUT4 divide and phase
        ram[9]  <= {7'h10, 16'h1000, CLKOUT4[15:0]};
        ram[10]  <= {7'h11, 16'hFC00, CLKOUT4[31:16]};
        
        // Store CLKOUT5 divide and phase
        ram[11] <= {7'h06, 16'h1000, CLKOUT5[15:0]};
        ram[12] <= (CLKOUT0_FRAC_EN == 0) ? {7'h07, 16'hC000, CLKOUT5[31:16]}: {7'h07, 16'hC000, CLKOUT5[31:30], CLKOUT0_FRAC_CALC[35:32],CLKOUT5[25:16]};
        
        // Store CLKOUT6 divide and phase
        ram[13] <= {7'h12, 16'h1000, CLKOUT6[15:0]};
        ram[14] <= (CLKFBOUT_FRAC_EN == 0) ? {7'h13, 16'hC000, CLKOUT6[31:16]}: {7'h13, 16'hC000, CLKOUT6[31:30], CLKFBOUT_FRAC_CALC[35:32],CLKOUT6[25:16]};
        
        // Store the input divider
        ram[15] <= {7'h16, 16'hC000, {2'h0, DIVCLK[23:22], DIVCLK[11:0]} };
        
        // Store the feedback divide and phase
        ram[16] <= (CLKFBOUT_FRAC_EN == 0) ? {7'h14, 16'h1000, CLKFBOUT[15:0]}: {7'h14, 16'h1000, CLKFBOUT_FRAC_CALC[15:0]};
        ram[17] <= (CLKFBOUT_FRAC_EN == 0) ? {7'h15, 16'h8000, CLKFBOUT[31:16]}: {7'h15, 16'h8000, CLKFBOUT_FRAC_CALC[31:16]};
        
        // Store the lock settings
        ram[18] <= {7'h18, 16'hFC00, {6'h00, LOCK[29:20]} };
        ram[19] <= {7'h19, 16'h8000, {1'b0 , LOCK[34:30], LOCK[9:0]} };
        ram[20] <= {7'h1A, 16'h8000, {1'b0 , LOCK[39:35], LOCK[19:10]} };
        
        // Store the filter settings
        ram[21] <= {7'h4E, 16'h66FF, DIGITAL_FILT[9], 2'h0, DIGITAL_FILT[8:7], 2'h0, DIGITAL_FILT[6], 8'h00 };
        ram[22] <= {7'h4F, 16'h666F, DIGITAL_FILT[5], 2'h0, DIGITAL_FILT[4:3], 2'h0, DIGITAL_FILT[2:1], 2'h0, DIGITAL_FILT[0], 4'h0 };
        
        ram[23] <= {7'h28,32'h0000_0000};
        
        for(ii = 24; ii < 32; ii = ii +1) begin
          ram[ii] <= 0;
        end
       
        ram_do <= ram[ram_addr];
        
    end
    
endmodule
