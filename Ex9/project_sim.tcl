
set design "Ex9"
set top top
set sim_top top_tb
set device xcvu9p-fsgd2104-2L-e
set proj_dir ./project
set repo_dir ./ip_repo
#set project_constraints constraints.xdc

set test_name "test"

# Build project.
create_project -name ${design} -force -dir "." -part ${device}
set_property source_mgmt_mode DisplayOnly [current_project]  
set_property top ${top} [current_fileset]
puts "Creating Project"

#create_fileset -constrset -quiet constraints

#Todo: Add your IP here
create_ip -name floating_point -vendor xilinx.com -library ip -version 7.1 -module_name floating_point_0
set_property -dict [list CONFIG.Operation_Type {Exponential} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {Medium_Usage} CONFIG.C_Latency {21} CONFIG.C_Rate {1}] [get_ips floating_point_0]

create_ip -name floating_point -vendor xilinx.com -library ip -version 7.1 -module_name floating_point_1
set_property -dict [list CONFIG.Add_Sub_Value {Add}] [get_ips floating_point_1]

create_ip -name floating_point -vendor xilinx.com -library ip -version 7.1 -module_name floating_point_2
set_property -dict [list CONFIG.Operation_Type {Divide} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {29} CONFIG.C_Rate {1}] [get_ips floating_point_2]

read_verilog "top.v"
read_verilog "top_tb.v"
read_verilog "sigmoid.v"

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top ${sim_top} [get_filesets sim_1]
set_property include_dirs ${proj_dir} [get_filesets sim_1]
set_property simulator_language Mixed [current_project]
set_property verilog_define { {SIMULATION=1} } [get_filesets sim_1]
set_property -name xsim.more_options -value {-testplusarg TESTNAME=basic_test} -objects [get_filesets sim_1]
set_property runtime {} [get_filesets sim_1]
set_property target_simulator xsim [current_project]
set_property compxlib.compiled_library_dir {} [current_project]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation
run 1000ns
