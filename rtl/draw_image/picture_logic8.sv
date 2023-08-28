/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Wojciech Szczepka
 *
 * Description:
 * logic to reverse pictures
 */


 `timescale 1 ns / 1 ps

module picture_logic8(

    input logic clk,
    input logic rst,
    input logic MouseLeft,
    input logic [11:0] xpos,
    input logic [11:0] ypos,
    input logic [11:0] rgb_in1,
    input logic [11:0] rgb_in2,
    output logic [11:0] rgb_out
);

import vga_pkg::*;

enum logic[3:0]{

   Obraz = 4'b0001,
   Step1 = 4'b0010,
   Tlo = 4'b0100,
   Step2 = 4'b1000

}state1;

always_ff@(posedge clk) begin
    if(rst)begin
        state1 <= Obraz;
    end else begin
        case(state1)
            Obraz: begin
                if((xpos >= X_2_DIM) && (xpos <= X_2_DIM + A_side) && (ypos >= Y_3_DIM) && (ypos <= Y_3_DIM + B_side) && MouseLeft==1)begin
                    state1 <= Step1;   
                end else begin
                    state1 <= Obraz;
                    rgb_out <= rgb_in1;
                end
            end
            Step1: begin
                if (MouseLeft==0) begin
                    state1 <= Tlo;
                end
                else begin
                    state1 <= Step1;
                end
            end
            Tlo: begin
                if ((xpos >= X_2_DIM) && (xpos <= X_2_DIM + A_side) && (ypos >= Y_3_DIM) && (ypos <= Y_3_DIM + B_side) && MouseLeft==1)begin
                    state1 <=Step2;
                end
                else begin
                    state1 <=Tlo;
                    rgb_out <= rgb_in2;
                end
            end
            Step2: begin
                if(MouseLeft==0) begin
                    state1 <= Obraz;
                end
                else begin
                    state1 <= Step2;
                end
            end
        endcase
    end
end

endmodule