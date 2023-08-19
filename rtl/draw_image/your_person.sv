/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * logic to chose person
 */


 `timescale 1 ns / 1 ps

module your_person(
    input logic clk,
    input logic rst,
    input logic MouseRight,
    input logic [11:0] xpos,
    input logic [11:0] ypos,

    output logic [4:0] your_person
);

import vga_pkg::*;

logic [4:0] your_person_nxt;

always_ff@(posedge clk)begin
    if(rst) begin
        your_person <= 5'b00000;
    end else begin
        your_person <= your_person_nxt;
    end
 end


always_comb begin
    if((xpos >= X_1_DIM) && (xpos <= X_1_DIM + A_side) && (ypos >= Y_1_DIM) && (ypos <= Y_1_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b00001;
    end else if((xpos >= X_2_DIM) && (xpos <= X_2_DIM + A_side) && (ypos >= Y_1_DIM) && (ypos <= Y_1_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b00011;
    end else if((xpos >= X_3_DIM) && (xpos <= X_3_DIM + A_side) && (ypos >= Y_1_DIM) && (ypos <= Y_1_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b00111;
    end else if((xpos >= X_1_DIM) && (xpos <= X_1_DIM + A_side) && (ypos >= Y_2_DIM) && (ypos <= Y_2_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b01111;
    end else if((xpos >= X_2_DIM) && (xpos <= X_2_DIM + A_side) && (ypos >= Y_2_DIM) && (ypos <= Y_2_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b11111;
    end else if((xpos >= X_3_DIM) && (xpos <= X_3_DIM + A_side) && (ypos >= Y_2_DIM) && (ypos <= Y_2_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b11110;
    end else if((xpos >= X_1_DIM) && (xpos <= X_1_DIM + A_side) && (ypos >= Y_3_DIM) && (ypos <= Y_3_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b11100;
    end else if((xpos >= X_2_DIM) && (xpos <= X_2_DIM + A_side) && (ypos >= Y_3_DIM) && (ypos <= Y_3_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b11000;
    end else if((xpos >= X_3_DIM) && (xpos <= X_3_DIM + A_side) && (ypos >= Y_3_DIM) && (ypos <= Y_3_DIM + B_side) && MouseRight==1)begin
        your_person_nxt= 5'b10000;
    end
    else begin
        your_person_nxt = your_person;
    end
end



endmodule