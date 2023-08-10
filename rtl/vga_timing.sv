/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,

    vga_if.out tim_if_out
);


import vga_pkg::*;


/**
 * Local variables and signals
 */

// Add your signals and variables here.
logic [10:0] hcount_nxt;
logic [10:0] vcount_nxt;

logic hsync_nxt;
logic vsync_nxt;
logic hblnk_nxt;
logic vblnk_nxt;

/**
 * Internal logic
 */

// Add your code here.

// horizontal counter
always_ff @(posedge clk)begin
  if(rst)
    tim_if_out.hcount <= 11'b0;
  else 
    tim_if_out.hcount <= hcount_nxt;
  end

always_comb begin 
  if (tim_if_out.hcount ==HOR_TOTAL_TIME)
    hcount_nxt = 11'b0;
  else 
    hcount_nxt = tim_if_out.hcount + 1;
  
end
   
// vertcal counter
always_ff @(posedge clk)begin
if(rst)
  tim_if_out.vcount  <= 11'b0;
else 

  tim_if_out.vcount  <= vcount_nxt;
end  

always_comb begin

  if (tim_if_out.hcount ==HOR_TOTAL_TIME)begin
    if(tim_if_out.vcount ==VER_TOTAL_TIME)
      vcount_nxt = 11'b0;
    else
      vcount_nxt = tim_if_out.vcount  + 1;
  end
  else
    vcount_nxt = tim_if_out.vcount ;

end

// timing controll


always_ff @(posedge clk)begin
  if(rst)begin
    tim_if_out.hblnk <= 0;
    tim_if_out.hsync <= 0;
    tim_if_out.vblnk <= 0;
    tim_if_out.vsync <= 0;
    
  end
  else begin

    tim_if_out.hblnk <= hblnk_nxt;
    tim_if_out.vblnk <= vblnk_nxt;
    tim_if_out.hsync <= hsync_nxt;
    tim_if_out.vsync <= vsync_nxt;
  
  end
end

always_comb begin

  if (tim_if_out.hcount >= HOR_BLANK_START && tim_if_out.hcount <= HOR_TOTAL_TIME -1)
    hblnk_nxt = 1;
  else
    hblnk_nxt = 0;

  if (tim_if_out.hcount >= HOR_SYNC_START -1 && tim_if_out.hcount < HOR_SYNC_END)
    hsync_nxt = 1;
  else
    hsync_nxt = 0;

  if (((tim_if_out.vcount  > VER_BLANK_START && tim_if_out.vcount  <= VER_TOTAL_TIME ) || (tim_if_out.hcount ==HOR_TOTAL_TIME && (tim_if_out.vcount  > VER_BLANK_START -1 ))) && ~(tim_if_out.vcount  == VER_TOTAL_TIME && tim_if_out.hcount == HOR_TOTAL_TIME))
    vblnk_nxt = 1;
  else
    vblnk_nxt = 0;

  if (((tim_if_out.vcount  >= VER_SYNC_START && tim_if_out.vcount  < VER_SYNC_END) || (tim_if_out.hcount ==HOR_TOTAL_TIME && (tim_if_out.vcount  == VER_SYNC_START -1 ))) && ~(tim_if_out.vcount  == VER_SYNC_END-1 && tim_if_out.hcount == HOR_TOTAL_TIME))
    vsync_nxt = 1;
  else
    vsync_nxt = 0;

end



endmodule
