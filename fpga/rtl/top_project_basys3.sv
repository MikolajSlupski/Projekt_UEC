/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk, Wojciech Szczepka, Mikołaj Słupski
 *
 * Description:
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

`timescale 1 ns / 1 ps

module top_project_basys3 (
    input  wire clk,
    input  wire btnC,

    inout wire PS2Clk,
    inout wire PS2Data,

    input logic [7:0] JA,
    input logic [7:0] JC,
    output logic [7:0] JB,
    output logic [7:0] JXADC,

    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue
);


/**
 * Local variables and signals
 */

wire locked;
wire clk130MHz, clk65MHz;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */


/**
 * FPGA submodules placement
 */
clk_wiz_1_clk_wiz u_clk_wiz_1 (
    .clk_130MHz(clk130MHz),
    .clk_65MHz(clk65MHz),           
    .locked(locked),
    .clk(clk)
);

/**
 *  Project functional top module
 */

top_project u_top_project (
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .ps2_clk(PS2Clk),
    .ps2_data(PS2Data),
    .clk130MHz(clk130MHz),
    .clk65MHz(clk65MHz),
    .leftUP_Pmod(JA),
    .rightUP_Pmod(JB),
    .leftDOWN_Pmod(JXADC),
    .rightDOWN_Pmod(JC)
); 

endmodule
