###################################################################

# Created by write_sdc on Thu Nov 10 19:08:51 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports Clock]  -name clk  -period 5.5  -waveform {0 2.75}
