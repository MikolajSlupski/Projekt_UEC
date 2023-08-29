/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb(

    
);

import vga_pkg::*;

vga_if_tim timing_if_in();

/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;


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
    .tim_if_out(timing_if_in)
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
 assert property (@(negedge clk) rst == 0 ##1 rst == 0 |-> timing_if_in.hcount <= 1344) else 
 $error("timing_if_in.hcount exceed it's max value! timing_if_in.hcount value:", timing_if_in.hcount);
assert property (@(negedge clk) ((timing_if_in.hcount >= 1024) && (timing_if_in.hcount <= 1344) |-> (timing_if_in.hblnk == 1))) else 
 $error("timing_if_in.hblnk not active in timing_if_in.hcount, timing_if_in.vcount:", timing_if_in.hcount, timing_if_in.vcount);

assert property (@(posedge clk) ((timing_if_in.hcount >= 1048) && (timing_if_in.hcount <= 1184) |-> (timing_if_in.hsync == 1))) else
 $error("timing_if_in.hsync not active in timing_if_in.hcount, timing_if_in.vcount:", timing_if_in.hcount, timing_if_in.vcount);

// vertical testing
assert property (@(negedge clk) rst == 0 ## 1 rst == 0 |-> timing_if_in.vcount <= 806) else
 $error("timing_if_in.vcount exceed it's max value! timing_if_in.vcount value:", timing_if_in.vcount);    

assert property (@(posedge clk) ((timing_if_in.vcount >= 768) && (timing_if_in.vcount <= 806) |-> (timing_if_in.vblnk == 1))) else
 $error("timing_if_in.vblnk not active in timing_if_in.hcount, timing_if_in.vcount:", timing_if_in.hcount, timing_if_in.vcount);

assert property (@(posedge clk) ((timing_if_in.vcount >= 771) && (timing_if_in.vcount <= 777) |-> (timing_if_in.vsync == 1))) else
 $error("timing_if_in.vsync not active in timing_if_in.hcount, timing_if_in.vcount:", timing_if_in.hcount, timing_if_in.vcount);

/**
 * Main test
 */

initial begin
    @(posedge rst);
    @(negedge rst);

    wait (timing_if_in.vsync == 1'b0);
    @(negedge timing_if_in.vsync)
    @(negedge timing_if_in.vsync)

    $finish;
end

endmodule
