#start_gui
#create_project audio ./audio -part xc7z020clg400-1
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
set_property simulator_language Verilog [current_project]
create_bd_design "system"
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
regenerate_bd_layout
startgroup
set_property -dict [list CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {12.288} CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {0} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0}] [get_bd_cells processing_system7_0]
endgroup
regenerate_bd_layout
startgroup
set_property -dict [list CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0}] [get_bd_cells processing_system7_0]
endgroup
regenerate_bd_layout
set_property ip_repo_paths  ./ip_repo [current_project]
#set_property ip_repo_paths  C:/xup/hls/labs/lab4/ip_repo [current_project]
update_ip_catalog
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
endgroup
startgroup
set_property -dict [list CONFIG.C_GPIO_WIDTH {1} CONFIG.C_IS_DUAL {0} CONFIG.C_ALL_INPUTS {1} ] [get_bd_cells axi_gpio_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:user:audio_codec_ctrl:1.0 audio_codec_ctrl_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_gpio_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins audio_codec_ctrl_0/S_AXI]
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO
connect_bd_intf_net [get_bd_intf_pins axi_gpio_0/GPIO] [get_bd_intf_ports GPIO]
endgroup
#startgroup
#create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO2
#connect_bd_intf_net [get_bd_intf_pins axi_gpio_0/GPIO2] [get_bd_intf_ports GPIO2]
#endgroup
startgroup
create_bd_port -dir O BCLK
connect_bd_net [get_bd_pins /audio_codec_ctrl_0/bclk] [get_bd_ports BCLK]
endgroup
startgroup
create_bd_port -dir O LRCLK
connect_bd_net [get_bd_pins /audio_codec_ctrl_0/lrclk] [get_bd_ports LRCLK]
endgroup
startgroup
create_bd_port -dir O SDATA_O
connect_bd_net [get_bd_pins /audio_codec_ctrl_0/sdata_o] [get_bd_ports SDATA_O]
endgroup
startgroup
create_bd_port -dir O CODEC_ADDRESS
connect_bd_net [get_bd_pins /audio_codec_ctrl_0/codec_address] [get_bd_ports CODEC_ADDRESS]
endgroup
startgroup
create_bd_port -dir I SDATA_I
connect_bd_net [get_bd_pins /audio_codec_ctrl_0/sdata_i] [get_bd_ports SDATA_I]
endgroup
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_1
connect_bd_intf_net [get_bd_intf_pins processing_system7_0/IIC_1] [get_bd_intf_ports IIC_1]
endgroup
startgroup
create_bd_port -dir O -type clk FCLK_CLK1
connect_bd_net [get_bd_pins /processing_system7_0/FCLK_CLK1] [get_bd_ports FCLK_CLK1]
endgroup
regenerate_bd_layout
