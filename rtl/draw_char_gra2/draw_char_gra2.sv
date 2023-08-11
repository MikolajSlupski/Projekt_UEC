
`timescale 1 ns / 1 ps

<<<<<<<< HEAD:rtl/draw_char_koniec/draw_char_koniec.sv
module draw_char_koniec (
========
module draw_char_gra2 (
>>>>>>>> Ekran_Gry:rtl/draw_char_gra2/draw_char_gra2.sv
    input logic   clk,
    input logic   rst,

    vga_if.in in,
    vga_if.out out
);

wire [7:0] char_line_pixels;
wire [7:0] char_xy;
wire [3:0] char_line;
wire [6:0] char_code;

<<<<<<<< HEAD:rtl/draw_char_koniec/draw_char_koniec.sv
draw_rect_char_koniec u_draw_rect_char_koniec(
========
draw_rect_char_gra2 u_draw_rect_char_gra2(
>>>>>>>> Ekran_Gry:rtl/draw_char_gra2/draw_char_gra2.sv
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),

    .char_pixels(char_line_pixels),
    .char_xy(char_xy),
    .char_line
);

font_rom_koniec u_font_rom_koniec(
    .clk(clk),
    .addr({char_code,char_line}),
    .char_line_pixels(char_line_pixels)
);

<<<<<<<< HEAD:rtl/draw_char_koniec/draw_char_koniec.sv
char_rom_16x16_koniec u_char_rom_16x16_koniec(
========
char_rom_16x16_gra2 u_char_rom_16x16_gra2(
>>>>>>>> Ekran_Gry:rtl/draw_char_gra2/draw_char_gra2.sv
    .char_xy(char_xy),
    .char_code
);


endmodule