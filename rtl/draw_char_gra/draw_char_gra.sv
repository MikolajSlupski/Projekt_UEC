`timescale 1 ns / 1 ps

<<<<<<<< HEAD:rtl/draw_char_start/draw_char_start.sv
module draw_char_start (
========
module draw_char_gra (
>>>>>>>> Ekran_Gry:rtl/draw_char_gra/draw_char_gra.sv
    input logic   clk,
    input logic   rst,

    vga_if.in in,
    vga_if.out out
);

wire [7:0] char_line_pixels;
wire [7:0] char_xy;
wire [3:0] char_line;
wire [6:0] char_code;

<<<<<<<< HEAD:rtl/draw_char_start/draw_char_start.sv
draw_rect_char_start u_draw_rect_char_start(
========
draw_rect_char_gra u_draw_rect_char_gra(
>>>>>>>> Ekran_Gry:rtl/draw_char_gra/draw_char_gra.sv
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),

    .char_pixels(char_line_pixels),
    .char_xy(char_xy),
    .char_line
);

font_rom_start u_font_rom_start(
    .clk(clk),
    .addr({char_code,char_line}),
    .char_line_pixels(char_line_pixels)
);

<<<<<<<< HEAD:rtl/draw_char_start/draw_char_start.sv
char_rom_16x16_start u_char_rom_16x16_start(
========
char_rom_16x16_gra u_char_rom_16x16_gra(
>>>>>>>> Ekran_Gry:rtl/draw_char_gra/draw_char_gra.sv
    .char_xy(char_xy),
    .char_code
);

endmodule