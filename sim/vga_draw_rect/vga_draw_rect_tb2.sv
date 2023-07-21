

 `timescale 1 ns / 1 ps

module vga_draw_rect_tb;

import vga_pkg::*;

logic clk;
logic rst;
logic mouse_left;
logic [11:0] mouse_xpos;
logic [11:0] mouse_ypos;
logic [11:0] xpos;
logic [11:0] ypos;

logic [11:0] fallingCtr;
logic [11:0] xpos_freaze;
logic mouse_state;
logic [19:0] delay;


localparam CLK_PERIOD = 25; //40MHz


// Clock generator
initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


//reset 
initial begin
    rst = 1'b0;
#(1.25*CLK_PERIOD) rst = 1'b1;
    rst = 1'b1;
#(2.00*CLK_PERIOD) rst = 1'b0;
end


//seting positions
initial begin
    mouse_xpos = 200;
    mouse_ypos = 0;

end


//mouse left click
initial begin
    mouse_left = 0;
#(20*CLK_PERIOD) mouse_left = 1;
    mouse_left = 1;
#(21*CLK_PERIOD) mouse_left = 0;
end

draw_rect_ctl dut(
    .clk,
    .rst,
    .mouse_left(mouse_left),
    .xpos(xpos),
    .ypos(ypos),
    .mouse_xpos(mouse_xpos),
    .mouse_ypos(mouse_ypos)

);

initial begin
    
    @(posedge rst);
    @(negedge rst);

    wait (ypos == 534);
    @(negedge ypos);
    @(negedge ypos);

    $finish;
end

endmodule
