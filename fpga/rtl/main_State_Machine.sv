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
    input logic xpos,
    input logic ypos

 );


 enum logic[3:0]{

    EkranStartowy = 4'b0001,
    EkranGry = 4'b0010,
    EkranKoncowy = 4'b0100

 }state;


 always_ff@(posedge clk) begin
    if(rst)begin
        state <= EkranStartowy;
    end else begin

        case(state)
            EkranStartowy: begin
                if(xpos<=640 && xpos>=0 && ypos<=720 && ypos>=0 && MouseLeft==1)begin
                    state <= EkranGry;
                end else begin
                    state <= EkranStartowy;
                end
            end
            
            EkranGry: begin
                if(MouseRight==1)begin
                    state <= EkranKoncowy;
                end else begin
                    state <= EkranGry;
                end
            end

            EkranKoncowy: begin
                if(xpos<=1280 && xpos>=640 && ypos<=720 && ypos>=0 && MouseLeft==1) begin
                    state <= EkranStartowy;
                end else if(xpos<=640 && xpos>=0 && ypos<=720 && ypos>=0 && MouseLeft==1) begin
                    state <= EkranGry;
                end else begin
                    state <= EkranKoncowy;
                end
            end
        endcase
    end

 end

 endmodule