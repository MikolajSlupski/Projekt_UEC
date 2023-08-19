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
wire [11:0] rgb_pixel1, rgb_pixel2, rgb_pixel3, rgb_pixel4, rgb_pixel5, rgb_pixel6, rgb_pixel7, rgb_pixel8, rgb_pixel9, rgb_pixel10;
wire [11:0] rgb_out1, rgb_out2, rgb_out3, rgb_out4, rgb_out5, rgb_out6, rgb_out7, rgb_out8, rgb_out9;

 draw_image_1 u_draw_image_1(
    .clk,
    .rst,
    .pixel_addr(address),
    .rgb_pixel1(rgb_out1),
    .rgb_pixel2(rgb_out2),
    .rgb_pixel3(rgb_out3),
    .rgb_pixel4(rgb_out4),
    .rgb_pixel5(rgb_out5),
    .rgb_pixel6(rgb_out6),
    .rgb_pixel7(rgb_out7),
    .rgb_pixel8(rgb_out8),
    .rgb_pixel9(rgb_out9),
    .in(in),
    .out(out)
);

picture_logic1 u_picture_logic1(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel1),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out1)
);

picture_logic2 u_picture_logic2(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel2),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out2)
);

picture_logic3 u_picture_logic3(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel3),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out3)
);

picture_logic4 u_picture_logic4(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel4),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out4)
);

picture_logic5 u_picture_logic5(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel5),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out5)
);

picture_logic6 u_picture_logic6(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel6),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out6)
);

picture_logic7 u_picture_logic7(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel7),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out7)
);

picture_logic8 u_picture_logic8(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel8),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out8)
);

picture_logic9 u_picture_logic9(
    .clk,
    .rst,
    .xpos,
    .ypos,
    .MouseLeft,
    .rgb_in1(rgb_pixel9),
    .rgb_in2(rgb_pixel10),
    .rgb_out(rgb_out9)
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
    .rgb(rgb_pixel3)
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
    .rgb(rgb_pixel6)
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
    .rgb(rgb_pixel9)
);

image_rom_revers u_image_rom_revers(
    .clk,
    .address(address),
    .rgb(rgb_pixel10)
);

 endmodule