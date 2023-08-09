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
    
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {
    ../rtl/vga_pkg.sv
    ../rtl/vga_timing.sv
    ../rtl/vga_if.sv
    ../rtl/top_vga.sv
    ../rtl/draw_bg.sv
    ../rtl/draw_mouse.sv
    ../rtl/draw_char/draw_char.sv
    ../rtl/draw_char_2/draw_char_2.sv
    ../rtl/draw_char/draw_rect_char.sv
    ../rtl/draw_char/char_rom_16x16.sv
    ../rtl/draw_char_2/draw_rect_char2.sv
    ../rtl/draw_char_2/char_rom_16x16_2.sv
    rtl/top_vga_basys3.sv
}

# Specify Verilog design files location         -- EDIT
 set verilog_files {
    ../fpga/rtl/clk_wiz_0_clk_wiz.v
    ../fpga/rtl/clk_wiz_0.v 
    ../rtl/draw_char/font_rom.v 
    ../rtl/draw_char_2/font_rom_2.v 
     
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
