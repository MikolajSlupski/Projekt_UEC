/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikołaj Słupski  
 *
 * Description:
 * Interface with RGB signal 
 */
interface vga_if;

    reg [10:0] vcount;
    reg        vsync;
    reg        vblnk;
    reg [10:0] hcount;
    reg        hsync;
    reg        hblnk;
    reg [11:0] rgb;

    modport in(
        input vcount, hcount, hsync, vsync, hblnk, vblnk, rgb
    );

    modport out(
        output vcount, hcount, hsync, vsync, hblnk, vblnk, rgb
    );
    


endinterface

