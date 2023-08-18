/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Top module to draw image
 */


 `timescale 1 ns / 1 ps

 module top_draw_image_1 (
     input  logic clk,
     input  logic rst,
 
     vga_if.in in,
     vga_if.out out
 
 );
 
 import vga_pkg::*;
 
wire [14:0] address;
wire [11:0] rgb_pixel1, rgb_pixel2, rbg_pixel3, rgb_pixel4, rgb_pixel5, rbg_pixel6;

 draw_image_1 u_draw_image_1(
    .clk,
    .rst,
    .pixel_addr(address),
    .rgb_pixel1(rgb_pixel1),
    .rgb_pixel2(rgb_pixel2),
    .rgb_pixel3(rbg_pixel3),
    .rgb_pixel4(rgb_pixel4),
    .rgb_pixel5(rgb_pixel5),
    .rgb_pixel6(rbg_pixel6),
    .in(in),
    .out(out)
);

image_rom_1 u_image_rom_1(
    .clk,
    .address(address),
    .rgb(rgb_pixel1)
);

image_rom_2 u_image_rom_2(
    .clk,
    .address(address),
    .rgb(rgb_pixel2)
);

image_rom_3 u_image_rom_3(
    .clk,
    .address(address),
    .rgb(rbg_pixel3)
);

image_rom_4 u_image_rom_4(
    .clk,
    .address(address),
    .rgb(rgb_pixel4)
);

image_rom_5 u_image_rom_5(
    .clk,
    .address(address),
    .rgb(rgb_pixel5)
);

image_rom_6 u_image_rom_6(
    .clk,
    .address(address),
    .rgb(rbg_pixel6)
);

 endmodule