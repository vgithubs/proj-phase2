######################################################################
#
# EE-577b 2020 FALL
# : DesignCompiler synthesis script
#   modified by Linyi Hong
#
# use this script as a template for synthesizing combinational logic
#
######################################################################

# Setting variable for design_name. (top module name)
set design_name $env(DESIGN_NAME);

## For NCSUFreePDK45nm library
set search_path [ list . \
                  /home/scf-22/ee577/NCSU45PDK/FreePDK45/osu_soc/lib/files ]
set target_library { gscl45nm.db }
set synthetic_library [list dw_foundation.sldb standard.sldb ]
set link_library [list * gscl45nm.db dw_foundation.sldb standard.sldb]


# Reading source verilog file.
# copy your verilog file into ./src/ before synthesis.
read_verilog ./src/${design_name}.v ;


analyze -format verilog /usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW_sqrt_pipe.v
elaborate DW_sqrt_pipe

analyze -format verilog /usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW02_mult.v
elaborate DW02_mult

analyze -format verilog /usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW_div_pipe.v
elaborate DW_div_pipe

analyze -format verilog /usr/local/synopsys/Design_Compiler/K-2015.06-SP5-5/dw/sim_ver/DW01_addsub.v
elaborate DW01_addsub



# Setting $design_name as current working design.
# Use this command before setting any constraints.
current_design $design_name ;

# If you have multiple instances of the same module,
# use this so that DesignCompiler optimizes each instance separately.
uniquify ;

# Linking your design into the cells in standard cell libraries.
# This command checks whether your design can be compiled
link ;

# Create a clock with period of 5.
create_clock -name clk -period 6.5 -waveform [list 0 3.25] [get_ports Clock]

# Setting timing constraints for combinational logic.
# Specifying maximum delay from inputs to outputs
#set_max_delay 5.0 -to [all_outputs];
#set_max_delay 5.0 -from [all_inputs];

# "check_design" checks the internal representation of the
# current design for consistency and issues error and
# warning messages as appropriate.
check_design > report/$design_name.check_design ;

# Perforing synthesis and optimization on the current_design.
#set compile_ultra_ungroup_small_heirarchies_false ;
#compile_ultra -gate_clock -retime ;
compile;

# For better synthesis result, use "compile_ultra" command.
# compile_ultra is doing automatic ungrouping during optimization,
# therefore sometimes it's hard to figure out the critical path 
# from the synthesized netlist.
# So, use "compile" command for now.

# Writing the synthesis result into Synopsys db format.
# You can read the saved db file into DesignCompiler later using
# "read_db" command for further analysis (timing, area...).
#write -xg_force_db -format db -hierarchy -out db/$design_name.db ;

# Generating timing and are report of the synthezied design.
report_timing > report/$design_name.timing ;
report_area -hierarchy > report/$design_name.area ;
report_power -hierarchy > report/$design_name.power ;
report_clock_gating > report/$design_name.gating;

# Writing synthesized gate-level verilog netlist.
# This verilog netlist will be used for post-synthesis gate-level simulation.
change_names -rules verilog -hierarchy ;
write -format verilog -hierarchy -out netlist/${design_name}_syn.v ;

# Writing Standard Delay Format (SDF) back-annotation file.
# This delay information can be used for post-synthesis simulation.
write_sdf netlist/${design_name}_syn.sdf;
write_sdc netlist/${design_name}_syn.sdc

