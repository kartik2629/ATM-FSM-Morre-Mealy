## Generated SDC file "atm.out.sdc"

## Copyright (C) 2023  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 22.1std.1 Build 917 02/14/2023 SC Lite Edition"

## DATE    "Fri Jul 14 18:13:58 2023"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {Clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {Clk}] -rise_to [get_clocks {Clk}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {Clk}] -rise_to [get_clocks {Clk}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {Clk}] -fall_to [get_clocks {Clk}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {Clk}] -fall_to [get_clocks {Clk}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {Clk}] -rise_to [get_clocks {Clk}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {Clk}] -rise_to [get_clocks {Clk}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {Clk}] -fall_to [get_clocks {Clk}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {Clk}] -fall_to [get_clocks {Clk}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {Pin[0]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {Pin[0]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {Pin[1]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {Pin[1]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {accNumber[0]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {accNumber[0]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {accNumber[1]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {accNumber[1]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[0]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[0]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[1]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[1]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[2]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[2]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[3]}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {amount_in[3]}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {card_inserted}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {card_inserted}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {dep}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {dep}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {enter}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {enter}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {mini_s}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {mini_s}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {reset}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {reset}]
set_input_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {with_d}]
set_input_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {with_d}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {accountfound}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {accountfound}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[0]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[0]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[1]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[1]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[2]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[2]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[3]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[3]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[4]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}] 1.000 [get_ports {balance[4]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[5]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[5]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[6]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[6]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[7]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[7]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[8]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[8]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[9]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[9]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[10]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[10]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[11]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[11]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[12]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[12]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[13]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[13]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[14]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[14]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {balance[15]}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {balance[15]}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {clk_out}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {clk_out}]
set_output_delay -add_delay -max -clock [get_clocks {Clk}]  1.000 [get_ports {pinfound}]
set_output_delay -add_delay -min -clock [get_clocks {Clk}]  1.000 [get_ports {pinfound}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

