/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Top module to draw char in state EkranKoncowy
 */

`timescale 1 ns / 1 ps

module draw_char_2_koniec (
    input logic   clk,
    input logic   rst,

    vga_if.in in,
    vga_if.out out
);

wire [7:0] char_line_pixels;
wire [7:0] char_xy;
wire [3:0] char_line;
wire [6:0] char_code;

draw_rect_char2_koniec u_draw_rect_char2_koniec(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),

    .char_pixels(char_line_pixels),
    .char_xy(char_xy),
    .char_line
);

font_rom u_font_rom_2_koniec(
    .clk(clk),
    .addr({char_code,char_line}),
    .char_line_pixels(char_line_pixels)
);

char_rom_16x16_2_koniec u_char_rom_16x16_2_koniec(
    .char_xy(char_xy),
    .char_code
);


endmodule