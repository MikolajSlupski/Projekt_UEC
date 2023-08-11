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
set project_name vga_project

# Top module name                               -- EDIT
set top_module top_vga_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_vga_basys3.xdc
    constraints/clk_wiz_0.xdc
    constraints/clk_wiz_0_late.xdc
    constraints/clk_Projekt_65MHz.xdc
    constraints/clk_Projekt_65MHz_late.xdc
    
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/vga_pkg.sv
    ../rtl/vga_timing.sv
    ../rtl/vga_if.sv
    ../rtl/vga_if_tim.sv
    ../rtl/top_vga.sv
    ../rtl/top_draw_start.sv
    ../rtl/draw_char_start/draw_char_start.sv
    ../rtl/draw_char_start_2/draw_char_2_start.sv
    ../rtl/draw_start_bg.sv
    ../rtl/draw_koniec_bg.sv
    ../rtl/draw_koniec.sv
    ../rtl/draw_mouse.sv
    ../rtl/draw_char_start/draw_rect_char_start.sv
    ../rtl/draw_char_start/char_rom_16x16_start.sv
    ../rtl/draw_char_start_2/draw_rect_char_2_start.sv
    ../rtl/draw_char_start_2/char_rom_16x16_2_start.sv
    ../rtl/draw_char_koniec/draw_char_koniec.sv
    ../rtl/draw_char_2_koniec/draw_char_2_koniec.sv
    ../rtl/draw_char_koniec/draw_rect_char_koniec.sv
    ../rtl/draw_char_koniec/char_rom_16x16_koniec.sv
    ../rtl/draw_char_2_koniec/draw_rect_char2_koniec.sv
    ../rtl/draw_char_2_koniec/char_rom_16x16_2_koniec.sv
    rtl/top_vga_basys3.sv
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
    ../fpga/rtl/clk_wiz_0_clk_wiz.v
    ../fpga/rtl/clk_wiz_0.v 
    ../fpga/rtl/clk_Projekt_65MHz.v
    ../fpga/rtl/clk_Projekt_65MHz_clk_wiz.v     
    ../rtl/draw_char_koniec/font_rom_koniec.v 
    ../rtl/draw_char_2_koniec/font_rom_2_koniec.v 
    ../rtl/draw_char_start/font_rom_start.v 
    ../rtl/draw_char_start_2/font_rom_2_start.v 
     
 }

# Specify VHDL design files location            -- EDIT
 set vhdl_files {
    ../rtl/MouseCtl.vhd
    ../rtl/Ps2Interface.vhd
    ../rtl/MouseDisplay.vhd
    rtl/top_vga_basys3.sv
    
 }

# Specify files for a memory initialization     -- EDIT
 #set mem_files {
  #  ../rtl/picture/image_rom.data
#}
