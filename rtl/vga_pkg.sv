/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Mikolaj Slupski
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 1280 x 720 @ using a 65 MHz clock;
// Remember, Counting form zero !!!
localparam HOR_PIXELS = 1280;//1024;//1280, 800;
localparam VER_PIXELS = 720;//768;//720, 600;
//total_time
localparam HOR_TOTAL_TIME = 1650;//1344;//1650, 1055;
localparam VER_TOTAL_TIME = 750;//806;//750, 627;

localparam HOR_SYNC_START = 1390;//1048;//1390, 840;
localparam VER_SYNC_START = 725;//771;//725, 601;

localparam HOR_SYNC_TIME = 41;//136;//41, 128;
localparam VER_SYNC_TIME = 6;//7;//6, 4;

localparam HOR_SYNC_END = HOR_SYNC_START + HOR_SYNC_TIME;
localparam VER_SYNC_END = VER_SYNC_START + VER_SYNC_TIME;

localparam HOR_BLANK_START = 1279;//1023;//1279, 799;
localparam VER_BLANK_START = 719;//767;//719, 599;



// Add VGA timing parameters here and refer to them in other modules.

//Rectangle parameters

localparam Rect_X = 100;
localparam Rect_Y = 300;

localparam Rect_wide = 50;
localparam Rect_hight = 64;

localparam Rect_RGB = 12'hf_f_f; //12'hR_G_B

localparam GROUNDLVL = 534;

// Char parameters

localparam L_COLOR = 12'he_f_f, BG_COLOR = 12'h6_0_d;
localparam RECT_X = 600, RECT_Y = 100;

localparam A = 7'h41, B=7'h42, C=7'h43, D=7'h44, E=7'h45, F=7'h46, G=7'h47, H=7'h48, I=7'h49, J=7'h4a, K=7'h4b, L=7'h4c, M=7'h4d,
 N=7'h4e, O=7'h4f, P=7'h50, Q=8'h51, R=7'h52, S=7'h53, T=7'h54, U=7'h55, V=7'h56, W=7'h57, X=7'h58, Y=7'h59, Z=7'h5a;

localparam a = 7'h61, b=7'h62, c=7'h63, d=7'h64, e=7'h65, f=7'h66, g=7'h67, h=7'h68, i=7'h69, j=7'h6a, k=7'h6b, l=7'h6c, m=7'h6d,
 n=7'h6e, o=7'h6f, p=7'h70, q=8'h71, r=7'h72, s=7'h73, t=7'h74, u=7'h75, v=7'h76, w=7'h77, x=7'h78, y=7'h79, z=7'h7a;

localparam zero=7'h30, one=7'h31, two=7'h32, three=7'h33, four=7'h34, five=7'h35, six=7'h36, seven=7'h37, eight=7'h38, nine=7'h39;
localparam Spc =7'h20;
endpackage
