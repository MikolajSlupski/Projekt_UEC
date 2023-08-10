/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Draw background in start game
 */


 `timescale 1 ns / 1 ps

 module draw_end_bg (
    input  logic clk,
    input  logic rst,

    vga_if_tim.in bg_if_in,
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
         
         else                                    // The rest of active display pixels:
             rgb_nxt = 12'h8_8_f;                // - fill with gray.
     end
 end
 
 endmodule
 