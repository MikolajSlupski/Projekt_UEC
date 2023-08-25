/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

`timescale 1 ns / 1 ps

module top_vga_basys3 (

    input  wire clk,
    input  wire btnC,

    inout wire PS2Clk,
    inout wire PS2Data,

    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire JA1
);


/**
 * Local variables and signals
 */

wire clk_in, clk_fb, clk_ss, clk_out;
wire locked;
wire pclk;
wire pclk_mirror;
wire clk100MHz, clk65MHz, clk130MHz, clk108MHz;
wire clk40MHz;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */

assign JA1 = pclk_mirror;


/**
 * FPGA submodules placement
 */


clk_wiz_1_clk_wiz u_clk_1 (
    // Clock out ports  
    .clk_100MHz(clk100MHz),
    .clk_65MHz(clk65MHz),
    .clk_40MHz(clk40MHz),
    // Status and control signals               
    .locked(locked),
    // Clock in ports
    .clk(clk)
);



// Mirror pclk on a pin for use by the testbench;
// not functionally required for this design to work.

ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(clk40MHz),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);


/**
 *  Project functional top module
 */

top_vga u_top_vga (
    .clk(clk65MHz),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .ps2_clk(PS2Clk),
    .ps2_data(PS2Data),
    .clk100MHz(clk100MHz),
    .clk65MHz(clk65MHz)
);

endmodule
