/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk, Mikołaj Słupski, Wojciech Szczepka 
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic rst,
    input  logic clk100MHz,
    input  logic clk65MHz,
    output logic [14:0] led,

    inout  logic ps2_clk,
    inout  logic ps2_data,
    input  logic [7:0] leftUP_Pmod,
    output  logic [7:0] rightUP_Pmod,
    output  logic [7:0] leftDOWN_Pmod,
    input  logic [7:0] rightDOWN_Pmod,



    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);

    vga_if top_bg_out();
    vga_if_tim top_bg_in();
    vga_if top_dmouse_in();
    vga_if top_out();
    vga_if top_draw_image();


/**
 * Local variables and signals
 */

// VGA signals from rectangle
wire [11:0] mouse_xpos;
wire [11:0] mouse_ypos;

logic MouseLeft, MouseRight;
logic [5:0] state_bin;
logic rst_sys;
logic Rst, RST, reset;
logic [3:0] your_person;
logic [1:0] resoult;

/**
 * Signals assignments
 */

assign vs = top_out.vsync;
assign hs = top_out.hsync;
assign {r,g,b} = top_out.rgb;
assign led [0] =rightDOWN_Pmod[0];
assign led[1] = rightDOWN_Pmod[1];
assign led[3:2] = rightDOWN_Pmod[3:2];
assign led[4] = leftUP_Pmod[3];
assign led[5] = leftUP_Pmod[2];
assign led[7:6] = leftUP_Pmod[1:0];
assign led[8] = Rst;
assign led[9] = RST;
assign led[11:10]= rightUP_Pmod[3:2];
assign led[13:12]= leftDOWN_Pmod[1:0];
assign led[14]= 0;


always_comb begin
    Rst = rst || rst_sys || reset;
end

always_comb begin
    RST = rst || rst_sys;
end


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk(clk65MHz),
    .rst,
    .tim_if_out(top_bg_in)
);

MouseCtl u_MouseCtl (
    .clk(clk100MHz),
    .rst(rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .left(MouseLeft),
    .value(),
    .setx(),
    .sety(),
    .setmax_x(),
    .setmax_y(),
    .zpos(),
    .middle(),
    .new_event(),
    .right(MouseRight)

);

draw_mouse u_draw_mouse(
    .clk(clk100MHz),
    .rst(rst),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos), 
    .dmouse_if_in(top_draw_image),
    .dmouse_if_out(top_out)
);


select_bg u_select_bg(
    .bg_if_in(top_bg_in),
    .bg_if_out(top_bg_out),
    .clk(clk65MHz),
    .rst(rst),
    .state_bin(state_bin),
    .resoult(resoult)
);

main_State_Machine u_main_State_Machine(
    .clk(clk100MHz),
    .rst(Rst),
    .MouseLeft(MouseLeft),
    .MouseRight(MouseRight),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .state_bin(state_bin),
    .resoult(resoult),
    .rst_sys(rst_sys)
);

top_draw_image_1 u_top_draw_image_1(
    .clk(clk65MHz),
    .rst(Rst),
    .MouseLeft(MouseLeft),
    .MouseRight(MouseRight),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .state_bin(state_bin),
    .your_person(your_person),
    .in(top_bg_out),
    .out(top_draw_image)
);

game_logic u_game_logic(
    .clk(clk65MHz),
    .rst(Rst),
    .MouseRight(MouseRight),
    .xpos(mouse_xpos),
    .ypos(mouse_ypos),
    .your_person(your_person),
    .state_bin(state_bin),
    .leftUP_Pmod(leftUP_Pmod),
    .rightUP_Pmod(rightUP_Pmod),
    .leftDOWN_Pmod(leftDOWN_Pmod),
    .rightDOWN_Pmod(rightDOWN_Pmod),
    .resoult(resoult),
    .reset(reset),
    .rst_sys(RST)
);

endmodule
