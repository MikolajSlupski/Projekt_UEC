
`timescale 1 ns / 1 ps

module draw_char_gra2 (

    input logic   clk,
    input logic   rst,

    vga_if.in in,
    vga_if.out out
);

wire [7:0] char_line_pixels;
wire [7:0] char_xy;
wire [3:0] char_line;
wire [6:0] char_code;

draw_rect_char_gra2 u_draw_rect_char_gra2(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),

    .char_pixels(char_line_pixels),
    .char_xy(char_xy),
    .char_line
);

font_rom_2 u_font_rom_2(
    .clk(clk),
    .addr({char_code,char_line}),
    .char_line_pixels(char_line_pixels)
);

char_rom_16x16_gra2 u_char_rom_16x16_gra2(

    .char_xy(char_xy),
    .char_code
);


endmodule