/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikołaj Słupski
 *
 * Description:
 * Package with vga related constants.
 */

 `timescale 1 ns / 1 ps

 module game_logic(

    input logic clk,
    input logic rst,
    input logic state_bin,
    input logic [3:0] your_person,
    input logic [11:0] xpos,
    input logic [11:0] ypos,
    input logic MouseRight,

    inout logic [7:0] leftUP_Pmod,
    inout logic [7:0] rightUP_Pmod,
    inout logic [7:0] leftDOWN_Pmod,
    inout logic [7:0] rightDOWN_Pmod,

    output logic [2:0] resoult
 );

 import vga_pkg::*;

 logic [2:0] resoult_nxt;
 logic [3:0] selected_person;

 always_comb begin
    if(rightDOWN_Pmod[4]==1)begin
        rightUP_Pmod[4]=your_person[0];
        rightUP_Pmod[5]=your_person[1];
        rightUP_Pmod[6]=your_person[2];
        rightUP_Pmod[7]=your_person[3];
    end

 end

 always_comb begin
    if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0001;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0010;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0011;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0100;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0101;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0110;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0111;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b1000;
    end else if(xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b1001;
    end else begin
        selected_person = 4'b0000;
    end
 end

 always_comb begin
    if(rightDOWN_Pmod[4]==1 && state_bin==4'b0010 && rightUP_Pmod[0]==selected_person[0] && rightUP_Pmod[1]==selected_person[1] && rightUP_Pmod[2]==selected_person[2] && rightUP_Pmod[3]==selected_person[3]) begin
        resoult_nxt = 2'b10;
    end else if(leftDOWN_Pmod[4]==1 && state_bin==4'b0010 && leftUP_Pmod[4]==selected_person[0] && leftUP_Pmod[5]==selected_person[1] && leftUP_Pmod[6]==selected_person[2] && leftUP_Pmod[7]==selected_person[3]) begin
        resoult_nxt = 2'b10;
    end else begin 
        resoult_nxt = 2'b00;
    end

 end

 endmodule