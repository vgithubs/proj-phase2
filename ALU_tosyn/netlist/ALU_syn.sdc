###################################################################

# Created by write_sdc on Wed Nov  9 13:22:06 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports Clock]  -name clk  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports {ALU_out[0]}]
set_max_delay 5  -to [get_ports {ALU_out[1]}]
set_max_delay 5  -to [get_ports {ALU_out[2]}]
set_max_delay 5  -to [get_ports {ALU_out[3]}]
set_max_delay 5  -to [get_ports {ALU_out[4]}]
set_max_delay 5  -to [get_ports {ALU_out[5]}]
set_max_delay 5  -to [get_ports {ALU_out[6]}]
set_max_delay 5  -to [get_ports {ALU_out[7]}]
set_max_delay 5  -to [get_ports {ALU_out[8]}]
set_max_delay 5  -to [get_ports {ALU_out[9]}]
set_max_delay 5  -to [get_ports {ALU_out[10]}]
set_max_delay 5  -to [get_ports {ALU_out[11]}]
set_max_delay 5  -to [get_ports {ALU_out[12]}]
set_max_delay 5  -to [get_ports {ALU_out[13]}]
set_max_delay 5  -to [get_ports {ALU_out[14]}]
set_max_delay 5  -to [get_ports {ALU_out[15]}]
set_max_delay 5  -to [get_ports {ALU_out[16]}]
set_max_delay 5  -to [get_ports {ALU_out[17]}]
set_max_delay 5  -to [get_ports {ALU_out[18]}]
set_max_delay 5  -to [get_ports {ALU_out[19]}]
set_max_delay 5  -to [get_ports {ALU_out[20]}]
set_max_delay 5  -to [get_ports {ALU_out[21]}]
set_max_delay 5  -to [get_ports {ALU_out[22]}]
set_max_delay 5  -to [get_ports {ALU_out[23]}]
set_max_delay 5  -to [get_ports {ALU_out[24]}]
set_max_delay 5  -to [get_ports {ALU_out[25]}]
set_max_delay 5  -to [get_ports {ALU_out[26]}]
set_max_delay 5  -to [get_ports {ALU_out[27]}]
set_max_delay 5  -to [get_ports {ALU_out[28]}]
set_max_delay 5  -to [get_ports {ALU_out[29]}]
set_max_delay 5  -to [get_ports {ALU_out[30]}]
set_max_delay 5  -to [get_ports {ALU_out[31]}]
set_max_delay 5  -to [get_ports {ALU_out[32]}]
set_max_delay 5  -to [get_ports {ALU_out[33]}]
set_max_delay 5  -to [get_ports {ALU_out[34]}]
set_max_delay 5  -to [get_ports {ALU_out[35]}]
set_max_delay 5  -to [get_ports {ALU_out[36]}]
set_max_delay 5  -to [get_ports {ALU_out[37]}]
set_max_delay 5  -to [get_ports {ALU_out[38]}]
set_max_delay 5  -to [get_ports {ALU_out[39]}]
set_max_delay 5  -to [get_ports {ALU_out[40]}]
set_max_delay 5  -to [get_ports {ALU_out[41]}]
set_max_delay 5  -to [get_ports {ALU_out[42]}]
set_max_delay 5  -to [get_ports {ALU_out[43]}]
set_max_delay 5  -to [get_ports {ALU_out[44]}]
set_max_delay 5  -to [get_ports {ALU_out[45]}]
set_max_delay 5  -to [get_ports {ALU_out[46]}]
set_max_delay 5  -to [get_ports {ALU_out[47]}]
set_max_delay 5  -to [get_ports {ALU_out[48]}]
set_max_delay 5  -to [get_ports {ALU_out[49]}]
set_max_delay 5  -to [get_ports {ALU_out[50]}]
set_max_delay 5  -to [get_ports {ALU_out[51]}]
set_max_delay 5  -to [get_ports {ALU_out[52]}]
set_max_delay 5  -to [get_ports {ALU_out[53]}]
set_max_delay 5  -to [get_ports {ALU_out[54]}]
set_max_delay 5  -to [get_ports {ALU_out[55]}]
set_max_delay 5  -to [get_ports {ALU_out[56]}]
set_max_delay 5  -to [get_ports {ALU_out[57]}]
set_max_delay 5  -to [get_ports {ALU_out[58]}]
set_max_delay 5  -to [get_ports {ALU_out[59]}]
set_max_delay 5  -to [get_ports {ALU_out[60]}]
set_max_delay 5  -to [get_ports {ALU_out[61]}]
set_max_delay 5  -to [get_ports {ALU_out[62]}]
set_max_delay 5  -to [get_ports {ALU_out[63]}]
set_max_delay 5  -from [list [get_ports {rA_64bit_val[0]}] [get_ports {rA_64bit_val[1]}]       \
[get_ports {rA_64bit_val[2]}] [get_ports {rA_64bit_val[3]}] [get_ports         \
{rA_64bit_val[4]}] [get_ports {rA_64bit_val[5]}] [get_ports {rA_64bit_val[6]}] \
[get_ports {rA_64bit_val[7]}] [get_ports {rA_64bit_val[8]}] [get_ports         \
{rA_64bit_val[9]}] [get_ports {rA_64bit_val[10]}] [get_ports                   \
{rA_64bit_val[11]}] [get_ports {rA_64bit_val[12]}] [get_ports                  \
{rA_64bit_val[13]}] [get_ports {rA_64bit_val[14]}] [get_ports                  \
{rA_64bit_val[15]}] [get_ports {rA_64bit_val[16]}] [get_ports                  \
{rA_64bit_val[17]}] [get_ports {rA_64bit_val[18]}] [get_ports                  \
{rA_64bit_val[19]}] [get_ports {rA_64bit_val[20]}] [get_ports                  \
{rA_64bit_val[21]}] [get_ports {rA_64bit_val[22]}] [get_ports                  \
{rA_64bit_val[23]}] [get_ports {rA_64bit_val[24]}] [get_ports                  \
{rA_64bit_val[25]}] [get_ports {rA_64bit_val[26]}] [get_ports                  \
{rA_64bit_val[27]}] [get_ports {rA_64bit_val[28]}] [get_ports                  \
{rA_64bit_val[29]}] [get_ports {rA_64bit_val[30]}] [get_ports                  \
{rA_64bit_val[31]}] [get_ports {rA_64bit_val[32]}] [get_ports                  \
{rA_64bit_val[33]}] [get_ports {rA_64bit_val[34]}] [get_ports                  \
{rA_64bit_val[35]}] [get_ports {rA_64bit_val[36]}] [get_ports                  \
{rA_64bit_val[37]}] [get_ports {rA_64bit_val[38]}] [get_ports                  \
{rA_64bit_val[39]}] [get_ports {rA_64bit_val[40]}] [get_ports                  \
{rA_64bit_val[41]}] [get_ports {rA_64bit_val[42]}] [get_ports                  \
{rA_64bit_val[43]}] [get_ports {rA_64bit_val[44]}] [get_ports                  \
{rA_64bit_val[45]}] [get_ports {rA_64bit_val[46]}] [get_ports                  \
{rA_64bit_val[47]}] [get_ports {rA_64bit_val[48]}] [get_ports                  \
{rA_64bit_val[49]}] [get_ports {rA_64bit_val[50]}] [get_ports                  \
{rA_64bit_val[51]}] [get_ports {rA_64bit_val[52]}] [get_ports                  \
{rA_64bit_val[53]}] [get_ports {rA_64bit_val[54]}] [get_ports                  \
{rA_64bit_val[55]}] [get_ports {rA_64bit_val[56]}] [get_ports                  \
{rA_64bit_val[57]}] [get_ports {rA_64bit_val[58]}] [get_ports                  \
{rA_64bit_val[59]}] [get_ports {rA_64bit_val[60]}] [get_ports                  \
{rA_64bit_val[61]}] [get_ports {rA_64bit_val[62]}] [get_ports                  \
{rA_64bit_val[63]}] [get_ports {rB_64bit_val[0]}] [get_ports                   \
{rB_64bit_val[1]}] [get_ports {rB_64bit_val[2]}] [get_ports {rB_64bit_val[3]}] \
[get_ports {rB_64bit_val[4]}] [get_ports {rB_64bit_val[5]}] [get_ports         \
{rB_64bit_val[6]}] [get_ports {rB_64bit_val[7]}] [get_ports {rB_64bit_val[8]}] \
[get_ports {rB_64bit_val[9]}] [get_ports {rB_64bit_val[10]}] [get_ports        \
{rB_64bit_val[11]}] [get_ports {rB_64bit_val[12]}] [get_ports                  \
{rB_64bit_val[13]}] [get_ports {rB_64bit_val[14]}] [get_ports                  \
{rB_64bit_val[15]}] [get_ports {rB_64bit_val[16]}] [get_ports                  \
{rB_64bit_val[17]}] [get_ports {rB_64bit_val[18]}] [get_ports                  \
{rB_64bit_val[19]}] [get_ports {rB_64bit_val[20]}] [get_ports                  \
{rB_64bit_val[21]}] [get_ports {rB_64bit_val[22]}] [get_ports                  \
{rB_64bit_val[23]}] [get_ports {rB_64bit_val[24]}] [get_ports                  \
{rB_64bit_val[25]}] [get_ports {rB_64bit_val[26]}] [get_ports                  \
{rB_64bit_val[27]}] [get_ports {rB_64bit_val[28]}] [get_ports                  \
{rB_64bit_val[29]}] [get_ports {rB_64bit_val[30]}] [get_ports                  \
{rB_64bit_val[31]}] [get_ports {rB_64bit_val[32]}] [get_ports                  \
{rB_64bit_val[33]}] [get_ports {rB_64bit_val[34]}] [get_ports                  \
{rB_64bit_val[35]}] [get_ports {rB_64bit_val[36]}] [get_ports                  \
{rB_64bit_val[37]}] [get_ports {rB_64bit_val[38]}] [get_ports                  \
{rB_64bit_val[39]}] [get_ports {rB_64bit_val[40]}] [get_ports                  \
{rB_64bit_val[41]}] [get_ports {rB_64bit_val[42]}] [get_ports                  \
{rB_64bit_val[43]}] [get_ports {rB_64bit_val[44]}] [get_ports                  \
{rB_64bit_val[45]}] [get_ports {rB_64bit_val[46]}] [get_ports                  \
{rB_64bit_val[47]}] [get_ports {rB_64bit_val[48]}] [get_ports                  \
{rB_64bit_val[49]}] [get_ports {rB_64bit_val[50]}] [get_ports                  \
{rB_64bit_val[51]}] [get_ports {rB_64bit_val[52]}] [get_ports                  \
{rB_64bit_val[53]}] [get_ports {rB_64bit_val[54]}] [get_ports                  \
{rB_64bit_val[55]}] [get_ports {rB_64bit_val[56]}] [get_ports                  \
{rB_64bit_val[57]}] [get_ports {rB_64bit_val[58]}] [get_ports                  \
{rB_64bit_val[59]}] [get_ports {rB_64bit_val[60]}] [get_ports                  \
{rB_64bit_val[61]}] [get_ports {rB_64bit_val[62]}] [get_ports                  \
{rB_64bit_val[63]}] [get_ports {R_ins[0]}] [get_ports {R_ins[1]}] [get_ports   \
{R_ins[2]}] [get_ports {R_ins[3]}] [get_ports {R_ins[4]}] [get_ports           \
{R_ins[5]}] [get_ports Op_code] [get_ports {WW[0]}] [get_ports {WW[1]}]        \
[get_ports Reset] [get_ports Clock]]
