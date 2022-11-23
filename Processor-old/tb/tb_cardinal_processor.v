/////////////////////////////////////////////////////////
// Filename       	: tb_cardinal_processor.v 				  
// Description    	: Cardinal Processor Simulation Testbench
/////////////////////////////////////////////////////////
// Test Bench for the Cardinal Processor RTL Verification
//Design folder has: cardinal_processor.v, ALU.v,reg_file.v

//Define the clock cycle
`define CYCLE_TIME 100

// Include Files
// Memory Files
`include "./include/dmem.v"
`include "./include/imem.v"
`include "./include/gscl45nm.v"

//Design File
`include "./design/cardinal_processor.v"

// This testbench instantiates the following modules:
// a. 64-bit Variable width Cardinal Processor, 
// b. 256 X 32 bit word Instruction memory
// c. 256 X 64 bit word Data memory

module tb_cardinal_processor;

reg Clock, Reset;

wire [0:7] node0_pc_out; //8  bit
wire [0:31] node0_inst_in;
wire [0:7] node0_addr_out; // 8 bit
wire [0:63] node0_d_out, node0_d_in;
wire node0_memEn, node0_memWrEn;

integer dmem0_dump_file;		// Channel Descriptor for DMEM0 final dump
integer reg0_dump_file;
integer i;
integer cycle_number;

imem IM_node0 (
	.memAddr (node0_pc_out),	// Only 8-bits are used in this project
	.dataOut (node0_inst_in)		// 32-bit  Instruction
	);
	
dmem DM_node0 (
	.clk 		(Clock),				// System Clock
	.memEn		(node0_memEn),			// data-memory enable (to avoid spurious reads)
	.memWrEn	(node0_memWrEn),		// data-memory Write Enable
	.memAddr	(node0_addr_out),	// 8-bit Memory address
	.dataIn		(node0_d_out),			// 64-bit data to data-memory
	.dataOut	(node0_d_in)			// 64-bit data from data-memory
	);

cardinal_processor cp(
	.Clock(Clock), 
	.Reset(Reset), 
	.Instr_Addr(node0_pc_out), 
	.Instruction(node0_inst_in), 
	.Mem_Addr(node0_addr_out), 
	.Data_Out(node0_d_out), 
	.Data_In(node0_d_in), 
	.DmemEn(node0_memEn), 
	.DmemWrEn(node0_memWrEn)
	);

//  Instruction input of processor is coming from Imem

always #(`CYCLE_TIME / 2) Clock <= ~Clock;	
initial begin
    #50000
    $finish;
end
	
initial begin
	$readmemh("imem_36.fill", IM_node0.MEM); 	// loading instruction memory into node0
	$readmemh("dmem.fill", DM_node0.MEM); 	// loading data memory into node0
	
	Clock <= 0;				// initialize Clock
	Reset <= 1'b1;				// reset the CPU 
	repeat(5) @(negedge Clock);		// wait for 5 clock cycles
	Reset <= 1'b0;				// de-activate reset signal after 5ns

	// Convention for the last instruction
	// We would have a last instruction NOP  => 32'h00000000
	wait (node0_inst_in == 32'h00000000);
	// Let us see how much did you stall
	$display("The program completed in %d cycles", cycle_number);
	// Let us now flush the pipe line
	repeat(5) @(negedge Clock); 
	// Open file for output
	dmem0_dump_file = $fopen("cmp_test.dmem0.dump"); // assigning the channel descriptor for output file

	// Let us now dump all the locations of the data memory now
	for (i=0; i<128; i=i+1) 
	begin
		$fdisplay(dmem0_dump_file, "Memory location #%5d : %h", i, DM_node0.MEM[i]);
	end
	$fclose(dmem0_dump_file);
	
	// Let us now dump all the locations of the register file
	// Open file for output
	reg0_dump_file = $fopen("cmp_test.reg0.dump"); // assigning the channel descriptor for output file
	for (i=0; i<32; i=i+1) 
	begin
		//$fdisplay(reg0_dump_file, "Memory location #%d : %h ", i, proc_one.register_file1.data_arr[i]);
		$fdisplay(reg0_dump_file, "%0d: %h", i, cp.rf.data_arr[i]);
	end
	$fclose(reg0_dump_file);
	$finish;
end // initial begin

//// ******************** Cycle Counter ******************** \\\\

always @ (posedge Clock)
begin
	if (Reset)
		cycle_number <= 0;
	else
		cycle_number <= cycle_number + 1;
end

endmodule