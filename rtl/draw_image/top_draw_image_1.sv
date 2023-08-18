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
     input  logic MouseLeft,
     input  logic [11:0] xpos,
     input  logic [11:0] ypos,
 
     vga_if.in in,
     vga_if.out out
 
 );
 
 import vga_pkg::*;
 
wire [13:0] address;
wire [11:0] rgb_pixel1, rgb_pixel2, rbg_pixel3, rgb_pixel4, rgb_pixel5, rbg_pixel6, rgb_pixel7, rgb_pixel8, rbg_pixel9, rbg_pixel10, rgb_out;

 draw_image_1 u_draw_image_1(
    .clk,
    .rst,
    .pixel_addr(address),
    .rgb_pixel1(rgb_out),
    .rgb_pixel2(rgb_pixel2),
    .rgb_pixel3(rbg_pixel3),
    .rgb_pixel4(rgb_pixel4),
    .rgb_pixel5(rgb_pixel5),
    .rgb_pixel6(rbg_pixel6),
    .rgb_pixel7(rgb_pixel7),
    .rgb_pixel8(rgb_pixel8),
    .rgb_pixel9(rbg_pixel9),
    .in(in),
    .out(out)
);

picture_logic u_picture_logic(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel1),
    .rgb_in2(rbg_pixel10),
    .rgb_out(rgb_out)
    
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

image_rom_7 u_image_rom_7(
    .clk,
    .address(address),
    .rgb(rgb_pixel7)
);

image_rom_8 u_image_rom_8(
    .clk,
    .address(address),
    .rgb(rgb_pixel8)
);

image_rom_9 u_image_rom_9(
    .clk,
    .address(address),
    .rgb(rbg_pixel9)
);

image_rom_revers u_image_rom_revers(
    .clk,
    .address(address),
    .rgb(rbg_pixel10)
);

 endmodule