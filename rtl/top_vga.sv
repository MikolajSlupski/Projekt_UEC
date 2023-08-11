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

    inout  logic ps2_clk,
    inout  logic ps2_data,

    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

    
    vga_if_tim top_bg_in();
    vga_if top_dmouse_in();
    vga_if top_out();
    vga_if top_bg_out();

/**
 * Local variables and signals
 */

// VGA signals from timing
//wire [10:0] vcount_tim, hcount_tim;
//wire vsync_tim, hsync_tim;
//wire vblnk_tim, hblnk_tim;

// VGA signals from background
//wire [10:0] vcount_bg, hcount_bg;
//wire vsync_bg, hsync_bg;
//wire vblnk_bg, hblnk_bg;
//wire [11:0] rgb_bg;

// VGA signals from rectangle
wire [10:0] vcount_rt, hcount_rt;
wire vsync_rt, hsync_rt;
wire vblnk_rt, hblnk_rt;
wire [11:0] rgb_rt;
wire [11:0] xpos;
wire [11:0] ypos;
wire [11:0] mouse_xpos;
wire [11:0] mouse_ypos;
wire left;

wire [11:0] pixel_addr_wire;
wire[11:0] rgb_pixel_wire;

wire [7:0] char_line_pixels, char_line_pixels2;
wire [10:0] addr;
wire [7:0] char_xy, char_xy2;
wire [3:0] char_line, char_line2;
wire [6:0] char_code, char_code2;



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
    .clk,
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
    .left(left),
    .value(),
    .setx(),
    .sety(),
    .setmax_x(),
    .setmax_y(),
    .zpos(),
    .middle(),
    .new_event(),
    .right()

);

draw_mouse u_draw_mouse(

    .clk(clk100MHz),
    .rst(rst),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    
    .dmouse_if_in(top_bg_out),

    .dmouse_if_out(top_out)
);


top_draw_start u_top_draw_start (
    .clk,
    .rst,
    .bg_if_in(top_bg_in),
    .bg_if_out(top_bg_out)
);



endmodule
