## =====================================================
## Nexys A7 - Snake Game Constraints
## Top module: snake_top
## 100 MHz input clock
## =====================================================

## Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5} [get_ports {clk}]


## =====================================================
## Push Buttons
## rst  = Center button
## up   = Up button
## down = Down button
## left = Left button
## right= Right button
## =====================================================

set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst}]
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports {up}]
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports {down}]
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports {left}]
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports {right}]


## =====================================================
## VGA Red
## =====================================================

set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports {red_o[0]}]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports {red_o[1]}]
set_property -dict { PACKAGE_PIN C5 IOSTANDARD LVCMOS33 } [get_ports {red_o[2]}]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports {red_o[3]}]


## =====================================================
## VGA Green
## =====================================================

set_property -dict { PACKAGE_PIN C6 IOSTANDARD LVCMOS33 } [get_ports {green_o[0]}]
set_property -dict { PACKAGE_PIN A5 IOSTANDARD LVCMOS33 } [get_ports {green_o[1]}]
set_property -dict { PACKAGE_PIN B6 IOSTANDARD LVCMOS33 } [get_ports {green_o[2]}]
set_property -dict { PACKAGE_PIN A6 IOSTANDARD LVCMOS33 } [get_ports {green_o[3]}]


## =====================================================
## VGA Blue
## =====================================================

set_property -dict { PACKAGE_PIN B7 IOSTANDARD LVCMOS33 } [get_ports {blue_o[0]}]
set_property -dict { PACKAGE_PIN C7 IOSTANDARD LVCMOS33 } [get_ports {blue_o[1]}]
set_property -dict { PACKAGE_PIN D7 IOSTANDARD LVCMOS33 } [get_ports {blue_o[2]}]
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports {blue_o[3]}]


## =====================================================
## VGA Synchronization
## =====================================================

set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports {hsync_o}]
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVCMOS33 } [get_ports {vsync_o}]


## =====================================================
## Seven-Segment Display
## seg_o[6:0] = {CG, CF, CE, CD, CC, CB, CA}
## =====================================================

set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports {seg_o[0]}]
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports {seg_o[1]}]
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports {seg_o[2]}]
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports {seg_o[3]}]
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports {seg_o[4]}]
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports {seg_o[5]}]
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports {seg_o[6]}]


## =====================================================
## Seven-Segment Anodes
## =====================================================

set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports {an_o[0]}]
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports {an_o[1]}]
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports {an_o[2]}]
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports {an_o[3]}]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {an_o[4]}]
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports {an_o[5]}]
set_property -dict { PACKAGE_PIN K2  IOSTANDARD LVCMOS33 } [get_ports {an_o[6]}]
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports {an_o[7]}]