/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikołaj Słupski
 *
 * Description:
 * Module with logic to comunicate betwen boards
 */

 `timescale 1 ns / 1 ps

 module game_logic(

    input logic clk,
    input logic rst,
    input logic [5:0] state_bin,    //jest
    input logic [3:0] your_person,  //jest
    input logic [11:0] xpos,
    input logic [11:0] ypos,
    input logic MouseRight,

    input logic [7:0] leftUP_Pmod,
    output logic [7:0] rightUP_Pmod,
    output logic [7:0] leftDOWN_Pmod,
    input logic [7:0] rightDOWN_Pmod,

    output logic [1:0] resoult,
    output logic reset
 );

 import vga_pkg::*;

 logic [1:0] resoult_nxt;
 logic [3:0] selected_person, selected_person_nxt;
 logic [3:0] Pmod_OUT_nxt;
 logic reset_nxt;

 //przypisanie portow wyjsciowych zawierajacych informacje o wybranej/ktora zgadujesz ocsobie i wyniku/czy wygrales czy przegrales
 assign rightUP_Pmod[7:4]=Pmod_OUT_nxt[3:0];
 assign leftDOWN_Pmod[7:4]=Pmod_OUT_nxt[3:0];
 assign rightUP_Pmod[3:2]=resoult[1:0];
 assign leftDOWN_Pmod[1:0]=resoult[1:0];

 //wystawieni stalej 1 na 7 port, aby wiedziec z ktorej strony jest plytka podpieta
 assign leftDOWN_Pmod[3] =0;
 assign rightUP_Pmod[0]=0;


//przesylanie wyniku zgadywania do wewnatrz programu
 always_ff@(posedge clk)begin
    if(rst) begin
        reset <= 'b0;
        resoult <= 2'b00;
        selected_person <= 4'b0000; 
    end else begin
        reset <= reset_nxt;
        resoult <= resoult_nxt;
        selected_person <= selected_person_nxt;
    end
 end

//przesłanie resetu do drugiej płytki
always_comb begin
    if(rst) begin
        rightUP_Pmod[1]= 1;
        leftDOWN_Pmod[2]=1;
    end else begin
        rightUP_Pmod[1]= 0;
        leftDOWN_Pmod[2]=0;
    end
end

 //przypisywanie twojej osoby do zmiennej wewn
 always_comb begin
    if(1)begin
        Pmod_OUT_nxt[0]=your_person[3];
        Pmod_OUT_nxt[1]=your_person[2];
        Pmod_OUT_nxt[2]=your_person[1];
        Pmod_OUT_nxt[3]=your_person[0];
    end
 end

 //zgadywanie osoby wg koordynatow
 always_comb begin
    if(state_bin==4'b0010 && xpos<= X_1_DIM + A_side && xpos>=X_1_DIM && ypos<= Y_1_DIM + B_side && ypos>=Y_1_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0001;
    end else if(state_bin==4'b0010 && xpos<=X_2_DIM + A_side && xpos>=X_2_DIM && ypos<=Y_1_DIM + B_side && ypos>=Y_1_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0010;
    end else if(state_bin==4'b0010 && xpos<=X_3_DIM + A_side && xpos>=X_3_DIM && ypos<=Y_1_DIM + B_side && ypos>=Y_1_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0011;
    end else if(state_bin==4'b0010 && xpos<=X_1_DIM + A_side && xpos>=X_1_DIM && ypos<=Y_2_DIM + B_side  && ypos>=Y_2_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0100;
    end else if(state_bin==4'b0010 && xpos<=X_2_DIM + A_side && xpos>=X_2_DIM && ypos<=Y_2_DIM + B_side  && ypos>=Y_2_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0101;
    end else if(state_bin==4'b0010 && xpos<=X_3_DIM + A_side && xpos>=X_3_DIM && ypos<=Y_2_DIM + B_side  && ypos>=Y_2_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0110;
    end else if(state_bin==4'b0010 && xpos<=X_1_DIM + A_side && xpos>=X_1_DIM && ypos<=Y_3_DIM + B_side  && ypos>=Y_3_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b0111;
    end else if(state_bin==4'b0010 && xpos<=X_2_DIM + A_side && xpos>=X_2_DIM && ypos<=Y_3_DIM + B_side && ypos>=Y_3_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b1000;
    end else if(state_bin==4'b0010 && xpos<=X_3_DIM + A_side && xpos>=X_3_DIM && ypos<=Y_3_DIM + B_side && ypos>=Y_3_DIM && MouseRight==1) begin
        selected_person_nxt = 4'b1001;
    end else begin
        selected_person_nxt = selected_person;
    end
 end

 //porownywanie osoby zgadnietej z informacja z drugiej plytki 2'b10 - wygrana, 2'b01 - przegrana
 always_comb begin
    if(rightDOWN_Pmod[0]==0 && state_bin==4'b00100 && rightDOWN_Pmod[7:4]==selected_person[3:0]) begin
        resoult_nxt = 2'b10;
    end else if(leftUP_Pmod[3]==0 && state_bin==4'b00100 && leftUP_Pmod[7:4]==selected_person[3:0]) begin
        resoult_nxt = 2'b10;
    end else if(rightDOWN_Pmod[0]==0 && state_bin==4'b00100 && rightDOWN_Pmod[7:4]!=selected_person[3:0]) begin
        resoult_nxt = 2'b01;
    end else if(leftUP_Pmod[3]==0 && state_bin==4'b00100 && leftUP_Pmod[7:4]!=selected_person[3:0]) begin
        resoult_nxt = 2'b01;
    end else if(rightDOWN_Pmod[0]==0 && rightDOWN_Pmod[3:2]==2'b01) begin
        resoult_nxt = 2'b10;
    end else if(rightDOWN_Pmod[0]==0 && rightDOWN_Pmod[3:2]==2'b10) begin
        resoult_nxt = 2'b01;
    end else if(leftUP_Pmod[3]==0 && leftUP_Pmod[1:0]==2'b01) begin
        resoult_nxt = 2'b10;
    end else if(leftUP_Pmod[3]==0 && leftUP_Pmod[1:0]==2'b10) begin
        resoult_nxt = 2'b01;
    end else begin 
        resoult_nxt = resoult;
    end

 end

 // logika do resetowania modułów obu płytek naraz  
 always_comb begin
    if(leftUP_Pmod[3]==0 & leftUP_Pmod[2]==1) begin
        reset_nxt = 1;
    end else if(rightDOWN_Pmod[0]==0 & rightDOWN_Pmod[1]==1) begin
        reset_nxt = 1;
    end else begin
        reset_nxt =0;
    end
end


 endmodule