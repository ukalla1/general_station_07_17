`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2021 03:07:18 PM
// Design Name: 
// Module Name: mmcm_drp_rcf_0628
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

module mmcm_drp_rcf_0628 #(
    //generic//
    parameter REGISTER_LOCKED       = "Reg",
    parameter USE_REG_LOCKED        = "No",
    //VCO//
    parameter CLKFBOUT_MULT          = 2,
    parameter CLKFBOUT_PHASE         = 0,
    parameter CLKFBOUT_FRAC          = 125,
    parameter CLKFBOUT_FRAC_EN       = 1,
    parameter BANDWIDTH              = "LOW",
    parameter DIVCLK_DIVIDE          = 1
)(
    input clk,
    input rst,
    input [31:0] clk_param_in,
    input [4:0] clk_param_sel,
    input clk_param_en,
    input clk_param_wen,
    output [31:0] clk_param_out,
    //
    input             SEN,
    output reg        SRDY,
    // These signals are to be connected to the MMCM_ADV by port name.
    // Their use matches the MMCM port description in the Device User Guide.
    input      [15:0] DO,
    input             DRDY,
    input             LOCK_REG_CLK_IN,
    input             LOCKED_IN,
    output reg        DWE,
    output reg        DEN,
    output reg [6:0]  DADDR,
    output reg [15:0] DI,
    output            DCLK,
    output reg        RST_MMCM,
    output            LOCKED_OUT
    );
    
    reg [4:0] ram_addr = 0;
    wire [38:0] ram_do;
    //
    wire        IntLocked;
    wire        IntRstMmcm;
    
    reg         next_srdy;
    reg [4:0]   next_ram_addr;
    reg [6:0]   next_daddr;
    reg         next_dwe;
    reg         next_den;
    reg         next_rst_mmcm;
    reg [15:0]  next_di;
    
    wire LOCKED_OUT_int;
    
    //**************************************************************************
    // Everything below is associated whith the state machine that is used to
    // Read/Modify/Write to the MMCM.
    //**************************************************************************

    // State Definitions
    localparam RESTART      = 4'h1;
    localparam WAIT_LOCK    = 4'h2;
    localparam WAIT_SEN     = 4'h3;
    localparam ADDRESS      = 4'h4;
    localparam WAIT_A_DRDY  = 4'h5;
    localparam BITMASK      = 4'h6;
    localparam BITSET       = 4'h7;
    localparam WRITE        = 4'h8;
    localparam WAIT_DRDY    = 4'h9;

    // State sync
    reg [3:0]  current_state   = RESTART;
    reg [3:0]  next_state      = RESTART;

    // These variables are used to keep track of the number of iterations that
    //    each state takes to reconfigure.
    // STATE_COUNT_CONST is used to reset the counters and should match the
    //    number of registers necessary to reconfigure each state.
    localparam STATE_COUNT_CONST  = 23;
    reg [4:0] state_count         = STATE_COUNT_CONST;
    reg [4:0] next_state_count    = STATE_COUNT_CONST;
    
    reg_b #(
        .CLKFBOUT_MULT          (CLKFBOUT_MULT),
        .CLKFBOUT_PHASE         (CLKFBOUT_PHASE),
        .CLKFBOUT_FRAC          (CLKFBOUT_FRAC),
        .CLKFBOUT_FRAC_EN       (CLKFBOUT_FRAC_EN),
        .BANDWIDTH              (BANDWIDTH),
        .DIVCLK_DIVIDE          (DIVCLK_DIVIDE)
    )reg_bank(
        .clk                    (clk),
        .rst                    (rst),
        .en                     (clk_param_en),
        .wen                    (clk_param_wen),
        .reg_data_in            (clk_param_in),
        .reg_data_out           (clk_param_out),
        .reg_sel                (clk_param_sel),
        .ram_addr               (ram_addr),
        .ram_do                 (ram_do)
    );
    
    
    FDRE #(
        .INIT           (0),
        .IS_C_INVERTED  (0),
        .IS_D_INVERTED  (0),
        .IS_R_INVERTED  (0)
    ) mmcme3_drp_I_Fdrp (
        .D      (LOCKED_IN),
        .CE     (1'b1),
        .R      (IntRstMmcm),
        .C      (LOCK_REG_CLK_IN),
        .Q      (LOCKED_OUT_int)
    );
    
    assign LOCKED_OUT = LOCKED_OUT_int;
    
    assign IntLocked = LOCKED_IN;
    
    assign IntRstMmcm = RST_MMCM;
    
    assign DCLK = clk;
    
    // This block assigns the next register value from the state machine below
    always @(posedge clk) begin
       DADDR       <= next_daddr;
       DWE         <= next_dwe;
       DEN         <= next_den;
       RST_MMCM    <= next_rst_mmcm;
       DI          <= next_di;

       SRDY        <= next_srdy;

       ram_addr    <= next_ram_addr;
       state_count <= next_state_count;
    end

    // This block assigns the next state, reset is syncronous.
    always @(posedge clk) begin
       if(rst) begin
          current_state <= RESTART;
       end else begin
          current_state <= next_state;
       end
    end
    
    always @(*) begin
       // Setup the default values
       next_srdy         = 1'b0;
       next_daddr        = DADDR;
       next_dwe          = 1'b0;
       next_den          = 1'b0;
       next_rst_mmcm     = RST_MMCM;
       next_di           = DI;
       next_ram_addr     = ram_addr;
       next_state_count  = state_count;

       case (current_state)
          // If RST is asserted reset the machine
          RESTART: begin
             next_daddr     = 7'h00;
             next_di        = 16'h0000;
             next_ram_addr  = 5'h00;
             next_rst_mmcm  = 1'b1;
             next_state     = WAIT_LOCK;
          end

          // Waits for the MMCM to assert IntLocked - once it does asserts SRDY
          WAIT_LOCK: begin
             // Make sure reset is de-asserted
             next_rst_mmcm   = 1'b0;
             // Reset the number of registers left to write for the next
             // reconfiguration event.
             next_state_count = STATE_COUNT_CONST ;
             next_ram_addr = 5'h00;

             if(IntLocked) begin
                // MMCM is IntLocked, go on to wait for the SEN signal
                next_state  = WAIT_SEN;
                // Assert SRDY to indicate that the reconfiguration module is
                // ready
                next_srdy   = 1'b1;
             end else begin
                // Keep waiting, IntLocked has not asserted yet
                next_state  = WAIT_LOCK;
             end
          end

          // Wait for the next SEN pulse and set the ROM addr appropriately
          //    based on SADDR
          WAIT_SEN: begin
             next_ram_addr = 5'h00;
             if (SEN) begin
                next_ram_addr = 5'h00;
                // Go on to address the MMCM
                next_state = ADDRESS;
             end else begin
                // Keep waiting for SEN to be asserted
                next_state = WAIT_SEN;
             end
          end

          // Set the address on the MMCM and assert DEN to read the value
          ADDRESS: begin
             // Reset the DCM through the reconfiguration
             next_rst_mmcm  = 1'b1;
             // Enable a read from the MMCM and set the MMCM address
             next_den       = 1'b1;
             next_daddr     = ram_do[38:32];

             // Wait for the data to be ready
             next_state     = WAIT_A_DRDY;
          end

          // Wait for DRDY to assert after addressing the MMCM
          WAIT_A_DRDY: begin
             if (DRDY) begin
                // Data is ready, mask out the bits to save
                next_state = BITMASK;
             end else begin
                // Keep waiting till data is ready
                next_state = WAIT_A_DRDY;
             end
          end

          // Zero out the bits that are not set in the mask stored in rom
          BITMASK: begin
             // Do the mask
             next_di     = ram_do[31:16] & DO;
             // Go on to set the bits
             next_state  = BITSET;
          end

          // After the input is masked, OR the bits with calculated value in rom
          BITSET: begin
             // Set the bits that need to be assigned
             next_di           = ram_do[15:0] | DI;
             // Set the next address to read from ROM
             next_ram_addr     = ram_addr + 1'b1;
             // Go on to write the data to the MMCM
             next_state        = WRITE;
          end

          // DI is setup so assert DWE, DEN, and RST_MMCM.  Subtract one from the
          //    state count and go to wait for DRDY.
          WRITE: begin
             // Set WE and EN on MMCM
             next_dwe          = 1'b1;
             next_den          = 1'b1;

             // Decrement the number of registers left to write
             next_state_count  = state_count - 1'b1;
             // Wait for the write to complete
             next_state        = WAIT_DRDY;
          end

          // Wait for DRDY to assert from the MMCM.  If the state count is not 0
          //    jump to ADDRESS (continue reconfiguration).  If state count is
          //    0 wait for lock.
          WAIT_DRDY: begin
             if(DRDY) begin
                // Write is complete
                if(state_count > 0) begin
                   // If there are more registers to write keep going
                   next_state  = ADDRESS;
                end else begin
                   // There are no more registers to write so wait for the MMCM
                   // to lock
                   next_state  = WAIT_LOCK;
                end
             end else begin
                // Keep waiting for write to complete
                next_state     = WAIT_DRDY;
             end
          end

          // If in an unknown state reset the machine
          default: begin
             next_state = RESTART;
          end
       endcase
    end
    
endmodule
