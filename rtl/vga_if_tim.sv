
interface vga_if_tim;

    reg [10:0] vcount;
    reg        vsync;
    reg        vblnk;
    reg [10:0] hcount;
    reg        hsync;
    reg        hblnk;

    modport in(
        input vcount, hcount, hsync, vsync, hblnk, vblnk
    );

    modport out(
        output vcount, hcount, hsync, vsync, hblnk, vblnk
    );
    


endinterface

