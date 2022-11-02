###################################################################

# Created by write_sdc on Wed Nov  2 13:04:08 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_delay 5  -to [get_ports {data_out[7]}]
set_max_delay 5  -to [get_ports {data_out[6]}]
set_max_delay 5  -to [get_ports {data_out[5]}]
set_max_delay 5  -to [get_ports {data_out[4]}]
set_max_delay 5  -to [get_ports {data_out[3]}]
set_max_delay 5  -to [get_ports {data_out[2]}]
set_max_delay 5  -to [get_ports {data_out[1]}]
set_max_delay 5  -to [get_ports {data_out[0]}]
set_max_delay 5  -from [list [get_ports {data_in[7]}] [get_ports {data_in[6]}] [get_ports      \
{data_in[5]}] [get_ports {data_in[4]}] [get_ports {data_in[3]}] [get_ports     \
{data_in[2]}] [get_ports {data_in[1]}] [get_ports {data_in[0]}] [get_ports     \
data_tc] [get_ports {sh[2]}] [get_ports {sh[1]}] [get_ports {sh[0]}]           \
[get_ports sh_tc] [get_ports sh_mode]]
