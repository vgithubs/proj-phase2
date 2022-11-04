###################################################################

# Created by write_sdc on Sat Oct  1 13:39:51 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports clk_out]
set_max_delay 5  -from [list [get_ports clk] [get_ports rst]]
