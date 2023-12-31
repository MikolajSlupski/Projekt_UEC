# Copyright (C) 2023  AGH University of Science and Technology
# MTM UEC2
# Author: Piotr Kaczmarczyk
# Modified: Wojciech Szczepka
# Description:
# Project detiles required for generate_bitstream.tcl
# Make sure that project_name, top_module and target are correct.
# Provide paths to all the files required for synthesis and implementation.
# Depending on the file type, it should be added in the corresponding section.
# If the project does not use files of some type, leave the corresponding section commented out.

#-----------------------------------------------------#
#                   Project details                   #
#-----------------------------------------------------#
# Project name                                  -- EDIT
set project_name Zgadnij_Kto_To

# Top module name                               -- EDIT
set top_module top_project_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_vga_basys3.xdc
    constraints/clk_wiz_1.xdc
    constraints/clk_wiz_1_late.xdc
    
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/vga_pkg.sv
    ../rtl/vga_timing.sv
    ../rtl/vga_if.sv
    ../rtl/vga_if_tim.sv
    ../rtl/top_project.sv
    ../rtl/select_bg.sv
    ../rtl/game_logic.sv
    ../rtl/draw_bg/draw_bg.sv
    ../rtl/draw_bg/top_draw_gra.sv
    ../rtl/draw_bg/top_draw_start.sv
    ../rtl/draw_bg/draw_gra_bg.sv
    ../rtl/draw_bg/top_draw_koniec.sv
    ../rtl/mouse/draw_mouse.sv
    ../rtl/draw_char_start/draw_char_start.sv
    ../rtl/draw_char_gra/draw_char_gra.sv
    ../rtl/draw_char_gra/draw_rect_char_gra.sv
    ../rtl/draw_char_gra/char_rom_16x16_gra.sv
    ../rtl/draw_char_start/draw_rect_char_start.sv
    ../rtl/draw_char_start/char_rom_16x16_start.sv
    ../rtl/draw_char_koniec/draw_char_koniec.sv
    ../rtl/draw_char_2_koniec/draw_char_2_koniec.sv
    ../rtl/draw_char_koniec/draw_rect_char_koniec.sv
    ../rtl/draw_char_koniec/char_rom_16x16_koniec.sv
    ../rtl/draw_char_2_koniec/draw_rect_char2_koniec.sv
    ../rtl/draw_char_2_koniec/char_rom_16x16_2_koniec.sv
    ../rtl/draw_image/draw_image_1.sv
    ../rtl/draw_image/top_draw_image_1.sv
    ../rtl/draw_image/image_rom_1.sv
    ../rtl/draw_image/image_rom_2.sv
    ../rtl/draw_image/image_rom_3.sv
    ../rtl/draw_image/image_rom_4.sv
    ../rtl/draw_image/image_rom_5.sv
    ../rtl/draw_image/image_rom_6.sv
    ../rtl/draw_image/image_rom_7.sv
    ../rtl/draw_image/image_rom_8.sv
    ../rtl/draw_image/image_rom_9.sv
    ../rtl/draw_image/image_rom_revers.sv
    ../rtl/draw_image/picture_logic1.sv
    ../rtl/draw_image/picture_logic2.sv
    ../rtl/draw_image/picture_logic3.sv
    ../rtl/draw_image/picture_logic4.sv
    ../rtl/draw_image/picture_logic5.sv
    ../rtl/draw_image/picture_logic6.sv
    ../rtl/draw_image/picture_logic7.sv
    ../rtl/draw_image/picture_logic8.sv
    ../rtl/draw_image/picture_logic9.sv
    ../rtl/draw_image/your_person.sv
    ../rtl/draw_image/draw_your_person.sv
    ../rtl/main_State_Machine.sv

    rtl/top_project_basys3.sv
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
    ../fpga/rtl/clk_wiz_1_clk_wiz.v
    ../fpga/rtl/clk_wiz_1.v 
    ../rtl/draw_char_gra/font_rom.v
     
 }

# Specify VHDL design files location            -- EDIT
 set vhdl_files {
    ../rtl/mouse/MouseCtl.vhd
    ../rtl/mouse/Ps2Interface.vhd
    ../rtl/mouse/MouseDisplay.vhd
    
 }

# Specify files for a memory initialization     -- EDIT
 set mem_files {
    ../rtl/image/1.dat
    ../rtl/image/2.dat
    ../rtl/image/3.dat
    ../rtl/image/4.dat
    ../rtl/image/5.dat
    ../rtl/image/6.dat
    ../rtl/image/7.dat
    ../rtl/image/8.dat
    ../rtl/image/9.dat
    ../rtl/image/10.dat

}
