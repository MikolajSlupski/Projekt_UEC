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

    output logic [1:0] resoult
 );

 import vga_pkg::*;

 logic [1:0] resoult_nxt;
 logic [3:0] selected_person;
 logic [3:0] Pmod_OUT_nxt;

 //przypisanie portow wyjsciowych zawierajacych informacje o wybranej/ktora zgadujesz ocsobie i wyniku/czy wygrales czy przegrales
 assign rightUP_Pmod[7:4]=Pmod_OUT_nxt[3:0];
 assign leftUP_Pmod[3:0]=Pmod_OUT_nxt[3:0];
 assign rightDOWN_Pmod[6:5]=resoult_nxt[1:0];
 assign leftDOWN_Pmod[2:1]=resoult_nxt[1:0];

 //wystawieni stalej 1 na 7 port, aby wiedziec z ktorej strony jest plytka podpieta
 assign leftDOWN_Pmod[7] =1;
 assign rightDOWN_Pmod[7]=1; 

//przesylanie wyniku zgadywania do wewnatrz programu
 always_ff@(posedge clk)begin
    if(rst) begin
        resoult <= 2'b00;
    end else begin
        resoult <= resoult_nxt;
    end
 end

 //przypisywanie twojej osoby do zmiennej wewn
 always_comb begin
    if(1)begin
        Pmod_OUT_nxt[0]=your_person[0];
        Pmod_OUT_nxt[1]=your_person[1];
        Pmod_OUT_nxt[2]=your_person[2];
        Pmod_OUT_nxt[3]=your_person[3];
    end
 end

 //zgadywanie osoby wg koordynatow
 always_comb begin
    if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0001;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0010;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0011;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0100;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0101;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0110;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b0111;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b1000;
    end else if(state_bin==4'b0010 && xpos<="wsp" && xpos>="wsp" && ypos<="wsp" && ypos>="wsp" && MouseRight==1) begin
        selected_person = 4'b1001;
    end else begin
        selected_person = 4'b0000;
    end
 end

 //porownywanie osoby zgadnietej z informacja z drugiej plytki 2'b10 - wygrana, 2'b01 - przegrana
 always_comb begin
    if(rightDOWN_Pmod[4]==1 && state_bin==4'b0010 && rightUP_Pmod[3:0]==selected_person[3:0]) begin
        resoult_nxt = 2'b10;
    end else if(leftDOWN_Pmod[4]==1 && state_bin==4'b0010 && leftUP_Pmod[7:4]==selected_person[3:0]) begin
        resoult_nxt = 2'b10;
    end else if(rightDOWN_Pmod[4]==1 && state_bin==4'b0010 && rightUP_Pmod[3:0]!=selected_person[3:0]) begin
        resoult_nxt = 2'b01;
    end else if(leftDOWN_Pmod[4]==1 && state_bin==4'b0010 && leftUP_Pmod[7:4]!=selected_person[3:0]) begin
        resoult_nxt = 2'b01;
    end else if(rightDOWN_Pmod[4]==1 && rightDOWN_Pmod[2:1]==2'b01) begin
        resoult_nxt = 2'b10;
    end else if(rightDOWN_Pmod[4]==1 && rightDOWN_Pmod[2:1]==2'b10) begin
        resoult_nxt = 2'b01;
    end else if(rightDOWN_Pmod[4]==1 && leftDOWN_Pmod[6:5]==2'b01) begin
        resoult_nxt = 2'b10;
    end else if(rightDOWN_Pmod[4]==1 && leftDOWN_Pmod[6:5]==2'b10) begin
        resoult_nxt = 2'b01;
    end else begin 
        resoult_nxt = 2'b00;
    end

 end

 endmodule