/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * Draw image
 */


 `timescale 1 ns / 1 ps

 module draw_your_person (
     input  logic clk,
     input  logic rst,
     input  logic [11:0] rgb_pixel1,
     input  logic [11:0] rgb_pixel2,
     input  logic [11:0] rgb_pixel3,
     input  logic [11:0] rgb_pixel4,
     input  logic [11:0] rgb_pixel5,
     input  logic [11:0] rgb_pixel6,
     input  logic [11:0] rgb_pixel7,
     input  logic [11:0] rgb_pixel8,
     input  logic [11:0] rgb_pixel9,
     input  logic [11:0] rgb_pixel10,
     input  logic [3:0] your_person,

     output logic [11:0] rgb_out
 
 );
 
 import vga_pkg::*;

 logic [11:0] rgb_out_nxt;

always_ff@(posedge clk)begin
    if(rst) begin
        rgb_out <= rgb_pixel10;
    end
    else begin
        rgb_out <= rgb_out_nxt;
    end
end



always_comb begin
    if(your_person==4'b0001) begin
        rgb_out_nxt = rgb_pixel1;
    end else if(your_person==4'b0010) begin
        rgb_out_nxt = rgb_pixel2;
    end else if(your_person==4'b0011) begin
        rgb_out_nxt = rgb_pixel3;
    end else if(your_person==4'b0100) begin
        rgb_out_nxt = rgb_pixel4;
    end else if(your_person==4'b0101) begin
        rgb_out_nxt = rgb_pixel5;
    end else if(your_person==4'b0110) begin
        rgb_out_nxt = rgb_pixel6;
    end else if(your_person==4'b0111) begin
        rgb_out_nxt = rgb_pixel7;
    end else if(your_person==4'b1000) begin
        rgb_out_nxt = rgb_pixel8;
    end else if(your_person==4'b1001) begin
        rgb_out_nxt = rgb_pixel9;
    end else begin
        rgb_out_nxt = rgb_pixel10;
    end
end



 endmodule