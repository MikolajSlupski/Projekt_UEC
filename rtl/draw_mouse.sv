`timescale 1 ns / 1 ps

module draw_mouse(

    input  logic clk,
    input  logic rst,

    input  logic [11:0] xpos,
    input  logic [11:0] ypos,

    vga_if.in dmouse_if_in,

    vga_if.out dmouse_if_out

);

logic [10:0] hcount_nxt;
logic [10:0] vcount_nxt;
logic blnk_nxt;
//logic hsync_nxt;
//logic vsync_nxt;
logic [11:0] rgb_nxt;

always_ff @(posedge clk)begin

    if(rst) begin
        hcount_nxt <= 0;
        vcount_nxt <= 0;
        dmouse_if_out.hsync  <= 0;  
        dmouse_if_out.vsync  <= 0;
        blnk_nxt   <= 0;
        rgb_nxt    <= 0;

    end else begin
        hcount_nxt <= dmouse_if_in.hcount;
        vcount_nxt <= dmouse_if_in.vcount;
        dmouse_if_out.hsync  <= dmouse_if_in.hsync;  
        dmouse_if_out.vsync  <= dmouse_if_in.vsync;
        blnk_nxt   <= (dmouse_if_in.hblnk || dmouse_if_in.vblnk);
        rgb_nxt    <= dmouse_if_in.rgb;
   end

end


MouseDisplay u_MouseDispaly(

    .xpos(xpos),
    .ypos(ypos),

    .pixel_clk(clk),
    
    .hcount(hcount_nxt),
    .vcount(vcount_nxt),
    .rgb_in(rgb_nxt),
    .blank(blnk_nxt),

    .rgb_out(dmouse_if_out.rgb)

);

endmodule