/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Top module to draw bagground
 */


 `timescale 1 ns / 1 ps

 module top_draw_gra (
    input  logic clk,
    input  logic rst,

    vga_if_tim.in bg_if_in,
    vga_if.out bg_if_out
);

import vga_pkg::*;

vga_if top_rect_in();
vga_if top_drect_char_in();
vga_if top_image_out();

wire [14:0] address;
wire [11:0] rgb_pixel;

draw_bg u_draw_bg (
    .clk,
    .rst,
    .bg_if_in(bg_if_in),
    .bg_if_out(top_rect_in)
);

draw_image u_draw_image(
    .clk,
    .rst,
    .pixel_addr(address),
    .rgb_pixel(rgb_pixel),
    .in(top_rect_in),
    .out(top_image_out)
);

image_rom u_image_rom(
    .clk,
    .address(address),
    .rgb(rgb_pixel)
);

draw_char_gra u_draw_char(
    .clk(clk),
    .rst(rst),
    .in(top_image_out),
    .out(top_drect_char_in)
);


draw_char_gra2 u_draw_char_2(
    .clk(clk),
    .rst(rst),
    .in(top_drect_char_in),
    .out(bg_if_out)
);
 endmodule