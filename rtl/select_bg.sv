/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikołaj Słupski
 *
 * Description:
 * Package with vga related constants.
 */

 `timescale 1 ns / 1 ps

 module select_bg(

    input logic [5:0] state_bin,
    input logic clk,
    input logic rst,

    vga_if_tim.in bg_if_in,
    vga_if.out bg_if_out

 );

import vga_pkg::*;

;
vga_if_tim top_bg_in();
vga_if top_bg_start();
vga_if top_bg_gra();
vga_if top_bg_koniec();
vga_if top_bg_nxt();


top_draw_koniec u_top_draw_koniec (
   .clk,
   .rst,
   .bg_if_in(bg_if_in),
   .bg_if_out(top_bg_koniec)
);

top_draw_gra u_top_draw_gra(
   .clk,
   .rst,
   .bg_if_in(bg_if_in),
   .bg_if_out(top_bg_gra)
);

top_draw_start u_top_draw_start(
   .clk,
   .rst,
   .bg_if_in(bg_if_in),
   .bg_if_out(top_bg_start)
);

always_ff@(posedge clk)begin
   if(rst)begin
      bg_if_out.vcount  <= top_bg_start.vcount;
      bg_if_out.hcount  <= top_bg_start.hcount;
      bg_if_out.hsync   <= top_bg_start.hsync;
      bg_if_out.vsync   <= top_bg_start.vsync;
      bg_if_out.hblnk   <= top_bg_start.hblnk;
      bg_if_out.vblnk   <= top_bg_start.vblnk;
      bg_if_out.rgb     <= top_bg_start.rgb;
   end else begin
      bg_if_out.vcount  <= top_bg_nxt.vcount;
      bg_if_out.hcount  <= top_bg_nxt.hcount;
      bg_if_out.hsync   <= top_bg_nxt.hsync;
      bg_if_out.vsync   <= top_bg_nxt.vsync;
      bg_if_out.hblnk   <= top_bg_nxt.hblnk;
      bg_if_out.vblnk   <= top_bg_nxt.vblnk;
      bg_if_out.rgb     <= top_bg_nxt.rgb;
   end
end

always_comb begin
   if(state_bin == 6'b0001)begin
      top_bg_nxt.vcount = top_bg_start.vcount;
      top_bg_nxt.hcount = top_bg_start.hcount;
      top_bg_nxt.hsync  = top_bg_start.hsync;
      top_bg_nxt.vsync  = top_bg_start.vsync;
      top_bg_nxt.hblnk  = top_bg_start.hblnk;
      top_bg_nxt.vblnk  = top_bg_start.vblnk;
      top_bg_nxt.rgb    = top_bg_start.rgb;
   end else if(state_bin == 6'b0010 || state_bin == 6'b10000 || state_bin == 6'b100000) begin
      top_bg_nxt.vcount = top_bg_gra.vcount;
      top_bg_nxt.hcount = top_bg_gra.hcount;
      top_bg_nxt.hsync  = top_bg_gra.hsync;
      top_bg_nxt.vsync  = top_bg_gra.vsync;
      top_bg_nxt.hblnk  = top_bg_gra.hblnk;
      top_bg_nxt.vblnk  = top_bg_gra.vblnk;
      top_bg_nxt.rgb    = top_bg_gra.rgb;
   end else if(state_bin == 6'b0100) begin
      top_bg_nxt.vcount = top_bg_koniec.vcount;
      top_bg_nxt.hcount = top_bg_koniec.hcount;
      top_bg_nxt.hsync  = top_bg_koniec.hsync;
      top_bg_nxt.vsync  = top_bg_koniec.vsync;
      top_bg_nxt.hblnk  = top_bg_koniec.hblnk;
      top_bg_nxt.vblnk  = top_bg_koniec.vblnk;
      top_bg_nxt.rgb    = top_bg_koniec.rgb;     
   end else begin
      top_bg_nxt.vcount = top_bg_start.vcount;
      top_bg_nxt.hcount = top_bg_start.hcount;
      top_bg_nxt.hsync  = top_bg_start.hsync;
      top_bg_nxt.vsync  = top_bg_start.vsync;
      top_bg_nxt.hblnk  = top_bg_start.hblnk;
      top_bg_nxt.vblnk  = top_bg_start.vblnk;
      top_bg_nxt.rgb    = top_bg_start.rgb;
   end
end

 endmodule