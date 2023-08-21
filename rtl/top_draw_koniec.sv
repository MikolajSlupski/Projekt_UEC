/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Top module to draw bg
 */


 `timescale 1 ns / 1 ps

 module top_draw_koniec (
    input  logic clk,
    input  logic rst,
    input  logic [1:0] resoult,

    vga_if_tim.in bg_if_in,
    vga_if.out bg_if_out
);

import vga_pkg::*;

    vga_if top_rect_in();
    vga_if top_drect_char_in();


draw_koniec_bg u_draw_koniec_bg (
    .clk,
    .rst,
    .resoult(resoult),
    .bg_if_in(bg_if_in),
    .bg_if_out(top_rect_in)
);


draw_char_koniec u_draw_char_koniec(
    .clk(clk),
    .rst(rst),
    .in(top_rect_in),
    .out(top_drect_char_in)
);


draw_char_2_koniec u_draw_char_2_koniec(
    .clk(clk),
    .rst(rst),
    .in(top_drect_char_in),
    .out(bg_if_out)
);


 endmodule