/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (
    input  logic clk,
    input  logic rst,

    vga_if.in bg_if_in,

    vga_if.out bg_if_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;



/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        bg_if_out.vcount <= '0;
        bg_if_out.vsync  <= '0;
        bg_if_out.vblnk  <= '0;
        bg_if_out.hcount <= '0;
        bg_if_out.hsync  <= '0;
        bg_if_out.hblnk  <= '0;
        bg_if_out.rgb    <= '0;
    end else begin
        bg_if_out.vcount <= bg_if_in.vcount;
        bg_if_out.vsync  <= bg_if_in.vsync;
        bg_if_out.vblnk  <= bg_if_in.vblnk;
        bg_if_out.hcount <= bg_if_in.hcount;
        bg_if_out.hsync  <= bg_if_in.hsync;
        bg_if_out.hblnk  <= bg_if_in.hblnk;
        bg_if_out.rgb    <= rgb_nxt;
        
    end
end

always_comb begin : bg_comb_blk
    if (bg_if_in.vblnk || bg_if_in.hblnk) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (bg_if_in.vcount == 0)                     // - top edge:
            rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
        else if (bg_if_in.vcount == VER_PIXELS - 1)   // - bottom edge:
            rgb_nxt = 12'hf_0_0;                // - - make a red line.
        else if (bg_if_in.hcount == 0)                // - left edge:
            rgb_nxt = 12'h0_f_0;                // - - make a green line.
        else if (bg_if_in.hcount == HOR_PIXELS - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

        // Add your code here.
        
        //M
        else if((bg_if_in.hcount >=50) && (bg_if_in.hcount <= 100) && (bg_if_in.vcount >=10) && (bg_if_in.vcount<=425)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount >=240) && (bg_if_in.hcount <= 290) && (bg_if_in.vcount >=10) && (bg_if_in.vcount<=425)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount >= 100) && (bg_if_in.hcount <= 170) && (bg_if_in.hcount - bg_if_in.vcount <=90) && (bg_if_in.hcount - bg_if_in.vcount >= 0)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount >= 170) && (bg_if_in.hcount <= 240) && (bg_if_in.hcount + bg_if_in.vcount >=250) && (bg_if_in.hcount + bg_if_in.vcount <=340)) rgb_nxt = 12'h0_f_0;
        
        //S
        else if((bg_if_in.hcount>=350) && (bg_if_in.hcount <= 430) && (bg_if_in.hcount + bg_if_in.vcount >= 440) && (bg_if_in.hcount + bg_if_in.vcount <= 490)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=510) && (bg_if_in.hcount <= 590) && (bg_if_in.hcount - bg_if_in.vcount >= 450) && (bg_if_in.hcount - bg_if_in.vcount <= 500)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=430) && (bg_if_in.hcount <= 510) && (bg_if_in.vcount >= 10) && (bg_if_in.vcount <= 60)) rgb_nxt = 12'h0_f_0;
    
        else if((bg_if_in.hcount>=350) && (bg_if_in.hcount <= 430) && (bg_if_in.hcount - bg_if_in.vcount >= 195) && (bg_if_in.hcount - bg_if_in.vcount <= 245)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=430) && (bg_if_in.hcount <= 510) && (bg_if_in.vcount >= 185) && (bg_if_in.vcount <= 235)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=510) && (bg_if_in.hcount <= 590) && (bg_if_in.hcount - bg_if_in.vcount >= 275) && (bg_if_in.hcount - bg_if_in.vcount <= 325)) rgb_nxt = 12'h0_f_0;

        
        else if((bg_if_in.hcount>=510) && (bg_if_in.hcount <= 590) && (bg_if_in.hcount + bg_if_in.vcount >= 885) && (bg_if_in.hcount + bg_if_in.vcount <= 935)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=430) && (bg_if_in.hcount <= 510) && (bg_if_in.vcount >= 375) && (bg_if_in.vcount <= 425)) rgb_nxt = 12'h0_f_0;
        else if((bg_if_in.hcount>=350) && (bg_if_in.hcount <= 430) && (bg_if_in.hcount - bg_if_in.vcount >= 5) && (bg_if_in.hcount - bg_if_in.vcount <= 55)) rgb_nxt = 12'h0_f_0;
        
        else                                    // The rest of active display pixels:
            rgb_nxt = 12'h8_8_8;                // - fill with gray.
    end
end

endmodule
