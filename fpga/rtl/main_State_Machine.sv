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
    input logic [1:0] resoult,

    output logic [5:0] state_bin,
    output logic rst_sys

 );

 import vga_pkg::*;

 enum logic[5:0]{

    EkranStartowy = 6'b00001,
    EkranGry = 6'b00010,
    EkranKoncowy = 6'b00100,
    Step = 6'b01000,
    EkranWyboru =6'b10000,
    Step2 = 6'b100000

 }state;


 always_ff@(posedge clk) begin
    if(rst)begin
        state <= EkranStartowy;
        state_bin <= state;
    end else begin

        case(state)
            EkranStartowy: begin
                if(((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y && ypos>=RECT_Y)||(xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y_2 && ypos>=RECT_Y_2)) && MouseLeft==1)begin
                    state <= EkranWyboru;
                    state_bin <= state;
                end else begin
                    state <= EkranStartowy;
                    state_bin <= state;
                    rst_sys <= 1'b0;
                end
            end
            
            EkranGry: begin
                if(MouseRight==1 || resoult == 2'b01 || resoult == 2'b10)begin
                    state <= EkranKoncowy;
                    state_bin <= state;
                end else begin
                    state <= EkranGry;
                    state_bin <= state;
                end
            end

            EkranKoncowy: begin
                if((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y && ypos>=RECT_Y)&& MouseLeft==1) begin
                    state <= EkranWyboru;
                    state_bin <= state;
                    rst_sys <= 1'b1;
                end else if((xpos<=RECT_CHAR_X + RECT_X_MIDDLE && xpos>=RECT_X_MIDDLE && ypos<=RECT_CHAR_Y + RECT_Y_2 && ypos>=RECT_Y_2)&& MouseLeft==1) begin
                    state <= Step;
                    state_bin <= state;
                end else begin
                    state <= EkranKoncowy;
                    state_bin <= state;
                end
            end
            Step: begin
                if(MouseLeft ==0) begin
                    state <= EkranStartowy;
                    state_bin <= state;
                end
                else begin
                    state <= Step;
                    state_bin <= state;
                    rst_sys <= 1'b1;
                end
            end
            EkranWyboru: begin
                if(MouseRight==1) begin
                    state <= Step2;
                    state_bin <= state;
                end else begin
                    state <= EkranWyboru;
                    state_bin <= state;
                    rst_sys <= 1'b0;
                end
            end
            Step2: begin
                if(MouseRight ==0) begin
                    state <= EkranGry;
                    state_bin <= state;
                end
                else begin
                    state <= Step2;
                    state_bin <= state;
                end
            end
        endcase
    end

 end

 endmodule