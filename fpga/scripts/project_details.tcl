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
    ../rtl/draw_bg.sv
    ../rtl/draw_gra_bg.sv
    ../rtl/draw_mouse.sv
    ../rtl/draw_char_gra/draw_char_gra.sv
    ../rtl/draw_char_gra2/draw_char_gra2.sv
    ../rtl/draw_char_gra/draw_rect_char_gra.sv
    ../rtl/draw_char_gra/char_rom_16x16_gra.sv
    ../rtl/draw_char_gra2/draw_rect_char_gra2.sv
    ../rtl/draw_char_gra2/char_rom_16x16_gra2.sv
    rtl/top_vga_basys3.sv
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
    ../fpga/rtl/clk_wiz_0_clk_wiz.v
    ../fpga/rtl/clk_wiz_0.v 
    ../fpga/rtl/clk_Projekt_65MHz.v
    ../fpga/rtl/clk_Projekt_65MHz_clk_wiz.v 
    ../rtl/draw_char_gra/font_rom.v 
    ../rtl/draw_char_gra2/font_rom_2.v 
     
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
