###################################################################

# Created by write_sdc on Tue Nov  8 20:48:45 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports Clock]  -name clk  -period 5  -waveform {0 2.5}
set_max_delay 5  -to [get_ports {Instr_Addr[0]}]
set_max_delay 5  -to [get_ports {Instr_Addr[1]}]
set_max_delay 5  -to [get_ports {Instr_Addr[2]}]
set_max_delay 5  -to [get_ports {Instr_Addr[3]}]
set_max_delay 5  -to [get_ports {Instr_Addr[4]}]
set_max_delay 5  -to [get_ports {Instr_Addr[5]}]
set_max_delay 5  -to [get_ports {Instr_Addr[6]}]
set_max_delay 5  -to [get_ports {Instr_Addr[7]}]
set_max_delay 5  -to [get_ports {Mem_Addr[0]}]
set_max_delay 5  -to [get_ports {Mem_Addr[1]}]
set_max_delay 5  -to [get_ports {Mem_Addr[2]}]
set_max_delay 5  -to [get_ports {Mem_Addr[3]}]
set_max_delay 5  -to [get_ports {Mem_Addr[4]}]
set_max_delay 5  -to [get_ports {Mem_Addr[5]}]
set_max_delay 5  -to [get_ports {Mem_Addr[6]}]
set_max_delay 5  -to [get_ports {Mem_Addr[7]}]
set_max_delay 5  -to [get_ports {Data_Out[0]}]
set_max_delay 5  -to [get_ports {Data_Out[1]}]
set_max_delay 5  -to [get_ports {Data_Out[2]}]
set_max_delay 5  -to [get_ports {Data_Out[3]}]
set_max_delay 5  -to [get_ports {Data_Out[4]}]
set_max_delay 5  -to [get_ports {Data_Out[5]}]
set_max_delay 5  -to [get_ports {Data_Out[6]}]
set_max_delay 5  -to [get_ports {Data_Out[7]}]
set_max_delay 5  -to [get_ports {Data_Out[8]}]
set_max_delay 5  -to [get_ports {Data_Out[9]}]
set_max_delay 5  -to [get_ports {Data_Out[10]}]
set_max_delay 5  -to [get_ports {Data_Out[11]}]
set_max_delay 5  -to [get_ports {Data_Out[12]}]
set_max_delay 5  -to [get_ports {Data_Out[13]}]
set_max_delay 5  -to [get_ports {Data_Out[14]}]
set_max_delay 5  -to [get_ports {Data_Out[15]}]
set_max_delay 5  -to [get_ports {Data_Out[16]}]
set_max_delay 5  -to [get_ports {Data_Out[17]}]
set_max_delay 5  -to [get_ports {Data_Out[18]}]
set_max_delay 5  -to [get_ports {Data_Out[19]}]
set_max_delay 5  -to [get_ports {Data_Out[20]}]
set_max_delay 5  -to [get_ports {Data_Out[21]}]
set_max_delay 5  -to [get_ports {Data_Out[22]}]
set_max_delay 5  -to [get_ports {Data_Out[23]}]
set_max_delay 5  -to [get_ports {Data_Out[24]}]
set_max_delay 5  -to [get_ports {Data_Out[25]}]
set_max_delay 5  -to [get_ports {Data_Out[26]}]
set_max_delay 5  -to [get_ports {Data_Out[27]}]
set_max_delay 5  -to [get_ports {Data_Out[28]}]
set_max_delay 5  -to [get_ports {Data_Out[29]}]
set_max_delay 5  -to [get_ports {Data_Out[30]}]
set_max_delay 5  -to [get_ports {Data_Out[31]}]
set_max_delay 5  -to [get_ports {Data_Out[32]}]
set_max_delay 5  -to [get_ports {Data_Out[33]}]
set_max_delay 5  -to [get_ports {Data_Out[34]}]
set_max_delay 5  -to [get_ports {Data_Out[35]}]
set_max_delay 5  -to [get_ports {Data_Out[36]}]
set_max_delay 5  -to [get_ports {Data_Out[37]}]
set_max_delay 5  -to [get_ports {Data_Out[38]}]
set_max_delay 5  -to [get_ports {Data_Out[39]}]
set_max_delay 5  -to [get_ports {Data_Out[40]}]
set_max_delay 5  -to [get_ports {Data_Out[41]}]
set_max_delay 5  -to [get_ports {Data_Out[42]}]
set_max_delay 5  -to [get_ports {Data_Out[43]}]
set_max_delay 5  -to [get_ports {Data_Out[44]}]
set_max_delay 5  -to [get_ports {Data_Out[45]}]
set_max_delay 5  -to [get_ports {Data_Out[46]}]
set_max_delay 5  -to [get_ports {Data_Out[47]}]
set_max_delay 5  -to [get_ports {Data_Out[48]}]
set_max_delay 5  -to [get_ports {Data_Out[49]}]
set_max_delay 5  -to [get_ports {Data_Out[50]}]
set_max_delay 5  -to [get_ports {Data_Out[51]}]
set_max_delay 5  -to [get_ports {Data_Out[52]}]
set_max_delay 5  -to [get_ports {Data_Out[53]}]
set_max_delay 5  -to [get_ports {Data_Out[54]}]
set_max_delay 5  -to [get_ports {Data_Out[55]}]
set_max_delay 5  -to [get_ports {Data_Out[56]}]
set_max_delay 5  -to [get_ports {Data_Out[57]}]
set_max_delay 5  -to [get_ports {Data_Out[58]}]
set_max_delay 5  -to [get_ports {Data_Out[59]}]
set_max_delay 5  -to [get_ports {Data_Out[60]}]
set_max_delay 5  -to [get_ports {Data_Out[61]}]
set_max_delay 5  -to [get_ports {Data_Out[62]}]
set_max_delay 5  -to [get_ports {Data_Out[63]}]
set_max_delay 5  -to [get_ports DmemEn]
set_max_delay 5  -to [get_ports DmemWrEn]
set_max_delay 5  -from [list [get_ports Clock] [get_ports Reset] [get_ports {Instruction[0]}]  \
[get_ports {Instruction[1]}] [get_ports {Instruction[2]}] [get_ports           \
{Instruction[3]}] [get_ports {Instruction[4]}] [get_ports {Instruction[5]}]    \
[get_ports {Instruction[6]}] [get_ports {Instruction[7]}] [get_ports           \
{Instruction[8]}] [get_ports {Instruction[9]}] [get_ports {Instruction[10]}]   \
[get_ports {Instruction[11]}] [get_ports {Instruction[12]}] [get_ports         \
{Instruction[13]}] [get_ports {Instruction[14]}] [get_ports {Instruction[15]}] \
[get_ports {Instruction[16]}] [get_ports {Instruction[17]}] [get_ports         \
{Instruction[18]}] [get_ports {Instruction[19]}] [get_ports {Instruction[20]}] \
[get_ports {Instruction[21]}] [get_ports {Instruction[22]}] [get_ports         \
{Instruction[23]}] [get_ports {Instruction[24]}] [get_ports {Instruction[25]}] \
[get_ports {Instruction[26]}] [get_ports {Instruction[27]}] [get_ports         \
{Instruction[28]}] [get_ports {Instruction[29]}] [get_ports {Instruction[30]}] \
[get_ports {Instruction[31]}] [get_ports {Data_In[0]}] [get_ports              \
{Data_In[1]}] [get_ports {Data_In[2]}] [get_ports {Data_In[3]}] [get_ports     \
{Data_In[4]}] [get_ports {Data_In[5]}] [get_ports {Data_In[6]}] [get_ports     \
{Data_In[7]}] [get_ports {Data_In[8]}] [get_ports {Data_In[9]}] [get_ports     \
{Data_In[10]}] [get_ports {Data_In[11]}] [get_ports {Data_In[12]}] [get_ports  \
{Data_In[13]}] [get_ports {Data_In[14]}] [get_ports {Data_In[15]}] [get_ports  \
{Data_In[16]}] [get_ports {Data_In[17]}] [get_ports {Data_In[18]}] [get_ports  \
{Data_In[19]}] [get_ports {Data_In[20]}] [get_ports {Data_In[21]}] [get_ports  \
{Data_In[22]}] [get_ports {Data_In[23]}] [get_ports {Data_In[24]}] [get_ports  \
{Data_In[25]}] [get_ports {Data_In[26]}] [get_ports {Data_In[27]}] [get_ports  \
{Data_In[28]}] [get_ports {Data_In[29]}] [get_ports {Data_In[30]}] [get_ports  \
{Data_In[31]}] [get_ports {Data_In[32]}] [get_ports {Data_In[33]}] [get_ports  \
{Data_In[34]}] [get_ports {Data_In[35]}] [get_ports {Data_In[36]}] [get_ports  \
{Data_In[37]}] [get_ports {Data_In[38]}] [get_ports {Data_In[39]}] [get_ports  \
{Data_In[40]}] [get_ports {Data_In[41]}] [get_ports {Data_In[42]}] [get_ports  \
{Data_In[43]}] [get_ports {Data_In[44]}] [get_ports {Data_In[45]}] [get_ports  \
{Data_In[46]}] [get_ports {Data_In[47]}] [get_ports {Data_In[48]}] [get_ports  \
{Data_In[49]}] [get_ports {Data_In[50]}] [get_ports {Data_In[51]}] [get_ports  \
{Data_In[52]}] [get_ports {Data_In[53]}] [get_ports {Data_In[54]}] [get_ports  \
{Data_In[55]}] [get_ports {Data_In[56]}] [get_ports {Data_In[57]}] [get_ports  \
{Data_In[58]}] [get_ports {Data_In[59]}] [get_ports {Data_In[60]}] [get_ports  \
{Data_In[61]}] [get_ports {Data_In[62]}] [get_ports {Data_In[63]}]]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_ID_EX_rB_data_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_ID_EX_rB_data_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_ID_EX_rB_data_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_ID_EX_rB_data_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells clk_gate_IF_ID_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells clk_gate_IF_ID_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells clk_gate_IF_ID_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells clk_gate_IF_ID_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_31_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_31_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_30_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_30_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_29_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_29_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_28_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_28_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_27_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_27_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_26_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_26_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_25_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_25_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_24_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_24_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_23_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_23_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_22_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_22_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_21_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_21_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_20_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_20_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_19_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_19_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_18_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_18_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_17_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_17_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_16_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_16_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_15_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_15_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_14_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_14_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_13_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_13_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_12_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_12_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_11_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_11_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_10_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_10_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_9_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_9_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_8_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_8_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_7_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_7_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_6_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_6_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_5_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_5_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_4_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_4_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_3_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_3_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_2_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_2_/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__2/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__2/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__2/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__2/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__1/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__1/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__1/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__1/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__0/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1__0/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__0/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1__0/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1_/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
rf/clk_gate_data_arr_reg_1_/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1_/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
rf/clk_gate_data_arr_reg_1_/main_gate]
