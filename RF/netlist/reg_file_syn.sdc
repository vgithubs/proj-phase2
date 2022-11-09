###################################################################

# Created by write_sdc on Mon Nov  7 20:56:31 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports {data_r1[0]}]
set_max_delay 5  -to [get_ports {data_r1[1]}]
set_max_delay 5  -to [get_ports {data_r1[2]}]
set_max_delay 5  -to [get_ports {data_r1[3]}]
set_max_delay 5  -to [get_ports {data_r1[4]}]
set_max_delay 5  -to [get_ports {data_r1[5]}]
set_max_delay 5  -to [get_ports {data_r1[6]}]
set_max_delay 5  -to [get_ports {data_r1[7]}]
set_max_delay 5  -to [get_ports {data_r1[8]}]
set_max_delay 5  -to [get_ports {data_r1[9]}]
set_max_delay 5  -to [get_ports {data_r1[10]}]
set_max_delay 5  -to [get_ports {data_r1[11]}]
set_max_delay 5  -to [get_ports {data_r1[12]}]
set_max_delay 5  -to [get_ports {data_r1[13]}]
set_max_delay 5  -to [get_ports {data_r1[14]}]
set_max_delay 5  -to [get_ports {data_r1[15]}]
set_max_delay 5  -to [get_ports {data_r1[16]}]
set_max_delay 5  -to [get_ports {data_r1[17]}]
set_max_delay 5  -to [get_ports {data_r1[18]}]
set_max_delay 5  -to [get_ports {data_r1[19]}]
set_max_delay 5  -to [get_ports {data_r1[20]}]
set_max_delay 5  -to [get_ports {data_r1[21]}]
set_max_delay 5  -to [get_ports {data_r1[22]}]
set_max_delay 5  -to [get_ports {data_r1[23]}]
set_max_delay 5  -to [get_ports {data_r1[24]}]
set_max_delay 5  -to [get_ports {data_r1[25]}]
set_max_delay 5  -to [get_ports {data_r1[26]}]
set_max_delay 5  -to [get_ports {data_r1[27]}]
set_max_delay 5  -to [get_ports {data_r1[28]}]
set_max_delay 5  -to [get_ports {data_r1[29]}]
set_max_delay 5  -to [get_ports {data_r1[30]}]
set_max_delay 5  -to [get_ports {data_r1[31]}]
set_max_delay 5  -to [get_ports {data_r1[32]}]
set_max_delay 5  -to [get_ports {data_r1[33]}]
set_max_delay 5  -to [get_ports {data_r1[34]}]
set_max_delay 5  -to [get_ports {data_r1[35]}]
set_max_delay 5  -to [get_ports {data_r1[36]}]
set_max_delay 5  -to [get_ports {data_r1[37]}]
set_max_delay 5  -to [get_ports {data_r1[38]}]
set_max_delay 5  -to [get_ports {data_r1[39]}]
set_max_delay 5  -to [get_ports {data_r1[40]}]
set_max_delay 5  -to [get_ports {data_r1[41]}]
set_max_delay 5  -to [get_ports {data_r1[42]}]
set_max_delay 5  -to [get_ports {data_r1[43]}]
set_max_delay 5  -to [get_ports {data_r1[44]}]
set_max_delay 5  -to [get_ports {data_r1[45]}]
set_max_delay 5  -to [get_ports {data_r1[46]}]
set_max_delay 5  -to [get_ports {data_r1[47]}]
set_max_delay 5  -to [get_ports {data_r1[48]}]
set_max_delay 5  -to [get_ports {data_r1[49]}]
set_max_delay 5  -to [get_ports {data_r1[50]}]
set_max_delay 5  -to [get_ports {data_r1[51]}]
set_max_delay 5  -to [get_ports {data_r1[52]}]
set_max_delay 5  -to [get_ports {data_r1[53]}]
set_max_delay 5  -to [get_ports {data_r1[54]}]
set_max_delay 5  -to [get_ports {data_r1[55]}]
set_max_delay 5  -to [get_ports {data_r1[56]}]
set_max_delay 5  -to [get_ports {data_r1[57]}]
set_max_delay 5  -to [get_ports {data_r1[58]}]
set_max_delay 5  -to [get_ports {data_r1[59]}]
set_max_delay 5  -to [get_ports {data_r1[60]}]
set_max_delay 5  -to [get_ports {data_r1[61]}]
set_max_delay 5  -to [get_ports {data_r1[62]}]
set_max_delay 5  -to [get_ports {data_r1[63]}]
set_max_delay 5  -to [get_ports {data_r2[0]}]
set_max_delay 5  -to [get_ports {data_r2[1]}]
set_max_delay 5  -to [get_ports {data_r2[2]}]
set_max_delay 5  -to [get_ports {data_r2[3]}]
set_max_delay 5  -to [get_ports {data_r2[4]}]
set_max_delay 5  -to [get_ports {data_r2[5]}]
set_max_delay 5  -to [get_ports {data_r2[6]}]
set_max_delay 5  -to [get_ports {data_r2[7]}]
set_max_delay 5  -to [get_ports {data_r2[8]}]
set_max_delay 5  -to [get_ports {data_r2[9]}]
set_max_delay 5  -to [get_ports {data_r2[10]}]
set_max_delay 5  -to [get_ports {data_r2[11]}]
set_max_delay 5  -to [get_ports {data_r2[12]}]
set_max_delay 5  -to [get_ports {data_r2[13]}]
set_max_delay 5  -to [get_ports {data_r2[14]}]
set_max_delay 5  -to [get_ports {data_r2[15]}]
set_max_delay 5  -to [get_ports {data_r2[16]}]
set_max_delay 5  -to [get_ports {data_r2[17]}]
set_max_delay 5  -to [get_ports {data_r2[18]}]
set_max_delay 5  -to [get_ports {data_r2[19]}]
set_max_delay 5  -to [get_ports {data_r2[20]}]
set_max_delay 5  -to [get_ports {data_r2[21]}]
set_max_delay 5  -to [get_ports {data_r2[22]}]
set_max_delay 5  -to [get_ports {data_r2[23]}]
set_max_delay 5  -to [get_ports {data_r2[24]}]
set_max_delay 5  -to [get_ports {data_r2[25]}]
set_max_delay 5  -to [get_ports {data_r2[26]}]
set_max_delay 5  -to [get_ports {data_r2[27]}]
set_max_delay 5  -to [get_ports {data_r2[28]}]
set_max_delay 5  -to [get_ports {data_r2[29]}]
set_max_delay 5  -to [get_ports {data_r2[30]}]
set_max_delay 5  -to [get_ports {data_r2[31]}]
set_max_delay 5  -to [get_ports {data_r2[32]}]
set_max_delay 5  -to [get_ports {data_r2[33]}]
set_max_delay 5  -to [get_ports {data_r2[34]}]
set_max_delay 5  -to [get_ports {data_r2[35]}]
set_max_delay 5  -to [get_ports {data_r2[36]}]
set_max_delay 5  -to [get_ports {data_r2[37]}]
set_max_delay 5  -to [get_ports {data_r2[38]}]
set_max_delay 5  -to [get_ports {data_r2[39]}]
set_max_delay 5  -to [get_ports {data_r2[40]}]
set_max_delay 5  -to [get_ports {data_r2[41]}]
set_max_delay 5  -to [get_ports {data_r2[42]}]
set_max_delay 5  -to [get_ports {data_r2[43]}]
set_max_delay 5  -to [get_ports {data_r2[44]}]
set_max_delay 5  -to [get_ports {data_r2[45]}]
set_max_delay 5  -to [get_ports {data_r2[46]}]
set_max_delay 5  -to [get_ports {data_r2[47]}]
set_max_delay 5  -to [get_ports {data_r2[48]}]
set_max_delay 5  -to [get_ports {data_r2[49]}]
set_max_delay 5  -to [get_ports {data_r2[50]}]
set_max_delay 5  -to [get_ports {data_r2[51]}]
set_max_delay 5  -to [get_ports {data_r2[52]}]
set_max_delay 5  -to [get_ports {data_r2[53]}]
set_max_delay 5  -to [get_ports {data_r2[54]}]
set_max_delay 5  -to [get_ports {data_r2[55]}]
set_max_delay 5  -to [get_ports {data_r2[56]}]
set_max_delay 5  -to [get_ports {data_r2[57]}]
set_max_delay 5  -to [get_ports {data_r2[58]}]
set_max_delay 5  -to [get_ports {data_r2[59]}]
set_max_delay 5  -to [get_ports {data_r2[60]}]
set_max_delay 5  -to [get_ports {data_r2[61]}]
set_max_delay 5  -to [get_ports {data_r2[62]}]
set_max_delay 5  -to [get_ports {data_r2[63]}]
set_max_delay 5  -from [list [get_ports clk] [get_ports rst] [get_ports wr_en] [get_ports      \
{ppp[0]}] [get_ports {ppp[1]}] [get_ports {ppp[2]}] [get_ports {addr_r1[0]}]   \
[get_ports {addr_r1[1]}] [get_ports {addr_r1[2]}] [get_ports {addr_r1[3]}]     \
[get_ports {addr_r1[4]}] [get_ports {addr_r2[0]}] [get_ports {addr_r2[1]}]     \
[get_ports {addr_r2[2]}] [get_ports {addr_r2[3]}] [get_ports {addr_r2[4]}]     \
[get_ports {in_addr[0]}] [get_ports {in_addr[1]}] [get_ports {in_addr[2]}]     \
[get_ports {in_addr[3]}] [get_ports {in_addr[4]}] [get_ports {in_data[0]}]     \
[get_ports {in_data[1]}] [get_ports {in_data[2]}] [get_ports {in_data[3]}]     \
[get_ports {in_data[4]}] [get_ports {in_data[5]}] [get_ports {in_data[6]}]     \
[get_ports {in_data[7]}] [get_ports {in_data[8]}] [get_ports {in_data[9]}]     \
[get_ports {in_data[10]}] [get_ports {in_data[11]}] [get_ports {in_data[12]}]  \
[get_ports {in_data[13]}] [get_ports {in_data[14]}] [get_ports {in_data[15]}]  \
[get_ports {in_data[16]}] [get_ports {in_data[17]}] [get_ports {in_data[18]}]  \
[get_ports {in_data[19]}] [get_ports {in_data[20]}] [get_ports {in_data[21]}]  \
[get_ports {in_data[22]}] [get_ports {in_data[23]}] [get_ports {in_data[24]}]  \
[get_ports {in_data[25]}] [get_ports {in_data[26]}] [get_ports {in_data[27]}]  \
[get_ports {in_data[28]}] [get_ports {in_data[29]}] [get_ports {in_data[30]}]  \
[get_ports {in_data[31]}] [get_ports {in_data[32]}] [get_ports {in_data[33]}]  \
[get_ports {in_data[34]}] [get_ports {in_data[35]}] [get_ports {in_data[36]}]  \
[get_ports {in_data[37]}] [get_ports {in_data[38]}] [get_ports {in_data[39]}]  \
[get_ports {in_data[40]}] [get_ports {in_data[41]}] [get_ports {in_data[42]}]  \
[get_ports {in_data[43]}] [get_ports {in_data[44]}] [get_ports {in_data[45]}]  \
[get_ports {in_data[46]}] [get_ports {in_data[47]}] [get_ports {in_data[48]}]  \
[get_ports {in_data[49]}] [get_ports {in_data[50]}] [get_ports {in_data[51]}]  \
[get_ports {in_data[52]}] [get_ports {in_data[53]}] [get_ports {in_data[54]}]  \
[get_ports {in_data[55]}] [get_ports {in_data[56]}] [get_ports {in_data[57]}]  \
[get_ports {in_data[58]}] [get_ports {in_data[59]}] [get_ports {in_data[60]}]  \
[get_ports {in_data[61]}] [get_ports {in_data[62]}] [get_ports {in_data[63]}]]
