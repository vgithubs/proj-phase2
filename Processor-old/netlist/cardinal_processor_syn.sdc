###################################################################

# Created by write_sdc on Fri Nov 11 04:25:27 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports Clock]  -name clk  -period 16  -waveform {0 8}
