/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;

vga_if_tim top_timing_tb();

/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;

wire [10:0] vcount, hcount;
wire        vsync,  hsync;
wire        vblnk,  hblnk;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
                       rst = 1'b0;
    #(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


/**
 * Dut placement
 */

vga_timing dut(
    .clk,
    .rst,
    .tim_if_out(top_timing_tb)
);

/**
 * Tasks and functions
 */

 // Here you can declare tasks with immediate assertions (assert).


/**
 * Assertions
 */

// Here you can declare concurrent assertions (assert property).
 
//horizontal testing
 assert property (@(negedge clk) rst == 0 ##1 rst == 0 |-> hcount <= 1055) else 
 $error("hcount exceed it's max value! hcount value:", hcount);
assert property (@(negedge clk) ((hcount >= 800) && (hcount <= 967) |-> (hblnk == 1))) else 
 $error("hblnk not active in hcount, vcount:", hcount, vcount);

assert property (@(posedge clk) ((hcount >= 840) && (hcount <= 967) |-> (hsync == 1))) else
 $error("hsync not active in hcount, vcount:", hcount, vcount);

// vertical testing
assert property (@(negedge clk) rst == 0 ## 1 rst == 0 |-> vcount <= 627) else
 $error("vcount exceed it's max value! vcount value:", vcount);    

assert property (@(posedge clk) ((vcount >= 600) && (vcount <= 627) |-> (vblnk == 1))) else
 $error("vblnk not active in hcount, vcount:", hcount, vcount);

assert property (@(posedge clk) ((vcount >= 601) && (vcount <= 604) |-> (vsync == 1))) else
 $error("vsync not active in hcount, vcount:", hcount, vcount);

/**
 * Main test
 */

initial begin
    @(posedge rst);
    @(negedge rst);

    wait (vsync == 1'b0);
    @(negedge vsync)
    @(negedge vsync)

    $finish;
end

endmodule
