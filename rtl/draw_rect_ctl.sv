`timescale 1 ns / 1 ps

module draw_rect_ctl(

    input logic mouse_left,
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
    input logic rst,
    input logic clk,

    output logic [11:0] xpos,
    output logic [11:0] ypos
);

import vga_pkg::*;

logic [11:0] fallingCtr;
logic [11:0] xpos_freaze;
logic mouse_state;
logic [19:0] delay;


typedef enum logic [2:0] {

    FOLLOWING,
    FALLING,
    BOTTOM

} state;

state currentState, nextState;


function automatic state getNextState (state currentState, logic mouse_left, logic [11:0] fallingCtr, logic [11:0] xpos_freaze, mouse_state, logic [11:0] delay);

    case(currentState)
        FOLLOWING: begin
            if(mouse_state == 1)begin
                nextState = FALLING;
            end else begin
                nextState = FOLLOWING;
            end

        end
        FALLING: begin
            if(fallingCtr >= GROUNDLVL)begin
                nextState = BOTTOM;
            end else begin
                nextState = FALLING;
            end
        end
        BOTTOM: begin
            if(mouse_state)begin
                nextState = FOLLOWING;
            end else begin
                nextState = BOTTOM;
            end
        end
    endcase
    return nextState;

endfunction

always_ff @(posedge clk) begin
    if(rst)begin

        xpos <= '0;
        ypos <= '0;
        currentState <= FOLLOWING;
        mouse_state <= '0;
        delay <= '0;
    end else begin
        currentState <= nextState;
    end
    if(mouse_left)begin
        mouse_state <= 1;
    end else begin
        mouse_state <= 0;
    end


    nextState = getNextState(currentState, mouse_left, fallingCtr, xpos_freaze, mouse_state, delay);

    case(currentState)
        FOLLOWING:begin
            xpos        <= mouse_xpos;
            ypos        <= mouse_ypos;
            xpos_freaze <= mouse_xpos;
            fallingCtr  <= mouse_ypos;
        end
        FALLING:begin
            if(delay >= 125000) begin
            fallingCtr <= fallingCtr +1;
            xpos       <= xpos_freaze;
            ypos       <= fallingCtr;
            delay      <= '0;
            end else begin
                delay <= delay +1;
            end

        end
        BOTTOM:begin
            xpos     <= xpos_freaze;
            ypos     <= fallingCtr;
        end


    endcase

end
endmodule