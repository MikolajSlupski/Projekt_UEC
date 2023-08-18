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
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    input  logic clk100MHz,
    input  logic clk65MHz,

    inout  logic ps2_clk,
    inout  logic ps2_data,

    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

    vga_if top_bg_out();
    vga_if_tim top_bg_in();
    vga_if top_dmouse_in();
    vga_if top_out();
    vga_if top_draw_image();


/**
 * Local variables and signals
 */

// VGA signals from rectangle
wire [11:0] mouse_xpos;
wire [11:0] mouse_ypos;

logic MouseLeft, MouseRight;
logic [3:0] state_bin;

/**
 * Signals assignments
 */

assign vs = top_out.vsync;
assign hs = top_out.hsync;
assign {r,g,b} = top_out.rgb;



//assign addr = (u_char_rom_16x16.char_code << 4 | u_draw_rect_char.char_line);



/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk(clk65MHz),
    .rst,
    .tim_if_out(top_bg_in)
);

MouseCtl u_MouseCtl (
    .clk(clk100MHz),
    .rst(rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .left(MouseLeft),
    .value(),
    .setx(),
    .sety(),
    .setmax_x(),
    .setmax_y(),
    .zpos(),
    .middle(),
    .new_event(),
    .right(MouseRight)

);

draw_mouse u_draw_mouse(
    .clk(clk100MHz),
    .rst(rst),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    
    .dmouse_if_in(top_draw_image),

    .dmouse_if_out(top_out)
);


select_bg u_select_bg(
    .bg_if_in(top_bg_in),
    .bg_if_out(top_bg_out),
    .clk(clk65MHz),
    .rst(rst),
    .state_bin(state_bin)
);

main_State_Machine u_main_State_Machine(
    .clk(clk100MHz),
    .rst(rst),
    .MouseLeft(MouseLeft),
    .MouseRight(MouseRight),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .state_bin(state_bin)
);

top_draw_image_1 u_top_draw_image_1(
    .clk(clk65MHz),
    .rst,
    .MouseLeft(MouseLeft),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .in(top_bg_out),
    .out(top_draw_image)
);

endmodule
