
`timescale 1 ns / 1 ps

<<<<<<<< HEAD:rtl/draw_char_start/draw_rect_char_start.sv

module draw_rect_char_start (

========
module draw_rect_char_gra (
>>>>>>>> Ekran_Gry:rtl/draw_char_gra/draw_rect_char_gra.sv
    input  logic clk,
    input  logic rst,
     
    input  logic [7:0] char_pixels,
 
    vga_if.in in,
    vga_if.out out,
 
    output logic [7:0] char_xy,
    output logic [3:0] char_line
 
);
 
import vga_pkg::*;

logic [10:0]  hcount_in_rect, vcount_in_rect;
     
logic hsync_nxt, vsync_nxt, hblnk_nxt, vblnk_nxt;
logic hsync_nxt2, vsync_nxt2, hblnk_nxt2, vblnk_nxt2;
logic [10:0] hcount_nxt, vcount_nxt;
logic [10:0] hcount_nxt2, vcount_nxt2;
     
logic [11:0] rgb_nxt3, rgb_nxt2, rgb_nxt;
     
     
 
always_ff @(posedge clk) begin 
    if (rst) begin
        {out.vcount, out.vsync, out.vblnk, out.hcount, out.hsync, out.hblnk, out.rgb} <= '0;
        {vcount_nxt, vsync_nxt, vblnk_nxt, hcount_nxt, hsync_nxt, hblnk_nxt, rgb_nxt} <= '0;
        {vcount_nxt2, vsync_nxt2, vblnk_nxt2, hcount_nxt2, hsync_nxt2, hblnk_nxt2, rgb_nxt2} <= '0;
    end else begin
        {out.vcount, out.vsync, out.vblnk, out.hcount, out.hsync, out.hblnk, out.rgb} <= {vcount_nxt2, vsync_nxt2, vblnk_nxt2, hcount_nxt2, hsync_nxt2, hblnk_nxt2, rgb_nxt3};
        {vcount_nxt2, vsync_nxt2, vblnk_nxt2, hcount_nxt2, hsync_nxt2, hblnk_nxt2, rgb_nxt2} <= {vcount_nxt, vsync_nxt, vblnk_nxt, hcount_nxt, hsync_nxt, hblnk_nxt, rgb_nxt};
        {vcount_nxt, vsync_nxt, vblnk_nxt, hcount_nxt, hsync_nxt, hblnk_nxt, rgb_nxt} <= {in.vcount, in.vsync, in.vblnk, in.hcount, in.hsync, in.hblnk, in.rgb};
    end
end
 
         
// rgb
always_comb begin
    if (in.vcount <= RECT_CHAR_Y + RECT_Y && in.vcount >= RECT_Y && in.hcount <= RECT_CHAR_X + RECT_X && in.hcount >= RECT_X) begin
        if (char_pixels[4'b1000-hcount_in_rect[2:0]]) 
            rgb_nxt3 = L_COLOR;
        else
            rgb_nxt3 = BG_COLOR;
    end else begin 
        rgb_nxt3 = rgb_nxt2;
    end
end
      
      
assign char_xy = {vcount_in_rect[7:4], hcount_in_rect[6:3]};
assign char_line = vcount_in_rect[3:0];
      
assign vcount_in_rect = in.vcount - RECT_Y;
assign hcount_in_rect = in.hcount - RECT_X;
   
     
 endmodule