/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Robert Szczygiel
 * Modified: Piotr Kaczmarczyk
 *
 * Description:
 * This is the ROM for the 'AGH48x64.png' image.
 * The image size is 48 x 64 pixels.
 * The input 'address' is a 12-bit number, composed of the concatenated
 * 6-bit y and 6-bit x pixel coordinates.
 * The output 'rgb' is 12-bit number with concatenated
 * red, green and blue color values (4-bit each)
 */

module image_rom_4 (
    input  logic clk ,
    input  logic [13:0] address,  // address = {addry[5:0], addrx[5:0]}
    output logic [11:0] rgb
);


/**
 * Local variables and signals
 */

reg [13:0] rom [0:16383];


/**
 * Memory initialization from a file
 */

/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/image/4.dat", rom);


/**
 * Internal logic
 */

always_ff @(posedge clk)
    rgb <= rom[address];

endmodule
