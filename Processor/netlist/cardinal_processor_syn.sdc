###################################################################

# Created by write_sdc on Fri Nov 11 23:17:58 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports Clock]  -name clk  -period 6.5  -waveform {0 3.25}
