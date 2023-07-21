`timescale 1 ns / 1 ps

module draw_rect (

    input  logic clk,
    input  logic rst,

    input  logic [11:0] xpos,
    input  logic [11:0] ypos,

    input logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr,

    vga_if.in rect_if_in,

    vga_if.out rect_if_out
);

import vga_pkg::*;

logic [11:0] rgb_out;
logic [5:0] xaddr;
logic [5:0] yaddr;

logic [10:0] vcount_nxt;
logic [10:0] hcount_nxt;
logic vsync_nxt, vblnk_nxt,hsync_nxt, hblnk_nxt;
logic [11:0] rgb_nxt;
logic [11:0] xpos_nxt;
logic [11:0] ypos_nxt;

logic [10:0] vcount_nxt2;
logic [10:0] hcount_nxt2;
logic vsync_nxt2, vblnk_nxt2, hsync_nxt2, hblnk_nxt2;
logic [11:0] rgb_nxt2;
logic [11:0] xpos_nxt2;
logic [11:0] ypos_nxt2;

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        rect_if_out.vcount <= '0;
        rect_if_out.vsync  <= '0;
        rect_if_out.vblnk  <= '0;
        rect_if_out.hcount <= '0;
        rect_if_out.hsync  <= '0;
        rect_if_out.hblnk  <= '0;
        rect_if_out.rgb    <= '0;
        pixel_addr         <= '0;

    end else begin
        rect_if_out.vcount <= vcount_nxt2;
        rect_if_out.vsync  <= vsync_nxt2;
        rect_if_out.vblnk  <= vblnk_nxt2;
        rect_if_out.hcount <= hcount_nxt2;
        rect_if_out.hsync  <= hsync_nxt2;
        rect_if_out.hblnk  <= hblnk_nxt2;
        rect_if_out.rgb    <= rgb_out;
        pixel_addr         <= {yaddr,xaddr};
    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        vcount_nxt <= '0;
        vsync_nxt  <= '0;
        vblnk_nxt  <= '0;
        hcount_nxt <= '0;
        hsync_nxt  <= '0;
        hblnk_nxt  <= '0;
        rgb_nxt    <= '0;
        xpos_nxt   <= '0;
        ypos_nxt   <= '0;

    end else begin
        vcount_nxt <= rect_if_in.vcount;
        vsync_nxt  <= rect_if_in.vsync;
        vblnk_nxt  <= rect_if_in.vblnk;
        hcount_nxt <= rect_if_in.hcount;
        hsync_nxt <= rect_if_in.hsync;
        hblnk_nxt  <= rect_if_in.hblnk;
        rgb_nxt    <= rect_if_in.rgb;
        xpos_nxt   <= xpos;
        ypos_nxt   <= ypos;

    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        vcount_nxt2 <= '0;
        vsync_nxt2  <= '0;
        vblnk_nxt2  <= '0;
        hcount_nxt2 <= '0;
        hsync_nxt2  <= '0;
        hblnk_nxt2  <= '0;
        rgb_nxt2    <= '0;
        xpos_nxt2   <= '0;
        ypos_nxt2   <= '0;

    end else begin
        vcount_nxt2 <= vcount_nxt;
        vsync_nxt2  <= vsync_nxt;
        vblnk_nxt2  <= vblnk_nxt;
        hcount_nxt2 <= hcount_nxt;
        hsync_nxt2 <= hsync_nxt;
        hblnk_nxt2  <= hblnk_nxt;
        rgb_nxt2   <= rgb_nxt;
        xpos_nxt2   <= xpos;
        ypos_nxt2   <= ypos;
    end
end

always_comb begin

    if((rect_if_in.hcount >= xpos+2) && (rect_if_in.hcount < xpos + Rect_wide) && (rect_if_in.vcount >= ypos) && (rect_if_in.vcount < ypos + Rect_hight)) 
        rgb_out = rgb_pixel; 
    else
        rgb_out = rgb_nxt2;

end

always_comb begin

    xaddr = rect_if_in.hcount - xpos;
    yaddr = rect_if_in.vcount - ypos;

end


endmodule