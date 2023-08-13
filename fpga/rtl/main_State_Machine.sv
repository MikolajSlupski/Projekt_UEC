/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikołaj Słupski
 *
 * Description:
 * Package with vga related constants.
 */

`timescale 1 ns / 1 ps

 module main_State_Machine (

    input logic clk,
    input logic rst,
    input logic MouseLeft,
    input logic MouseRight,
    input logic [11:0] xpos,
    input logic [11:0] ypos,

    output logic [3:0] state_bin

 );

 import vga_pkg::*;

 enum logic[3:0]{

    EkranStartowy = 4'b0001,
    EkranGry = 4'b0010,
    EkranKoncowy = 4'b0100

 }state;


 always_ff@(posedge clk) begin
    if(rst)begin
        state <= EkranStartowy;
        state_bin <= state;
    end else begin

        case(state)
            EkranStartowy: begin
                if(((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y && ypos>=RECT_Y)||(xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y_2 && ypos>=RECT_Y_2)) && MouseLeft==1)begin
                    state <= EkranGry;
                    state_bin <= state;
                end else begin
                    state <= EkranStartowy;
                    state_bin <= state;
                end
            end
            
            EkranGry: begin
                if(MouseRight==1)begin
                    state <= EkranKoncowy;
                    state_bin <= state;
                end else begin
                    state <= EkranGry;
                    state_bin <= state;
                end
            end

            EkranKoncowy: begin
                if((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y && ypos>=RECT_Y)&& MouseLeft==1) begin
                    state <= EkranStartowy;
                    state_bin <= state;
                end else if((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y_2 && ypos>=RECT_Y_2)&& MouseLeft==1) begin
                    state <= EkranGry;
                    state_bin <= state;
                end else begin
                    state <= EkranKoncowy;
                    state_bin <= state;
                end
            end
        endcase
    end

 end

 endmodule