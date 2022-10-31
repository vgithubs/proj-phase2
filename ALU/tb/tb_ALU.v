//Testbench for Arithmetic and Logic Unit
`timescale 1ns/10ps
module tb_ALU;
	reg [0:63] rA_64bit_val, rB_64bit_val;
	reg [0:5] R_ins, Op_code;
	reg [0:1] WW;
	wire ALU_out;

	ALU alu_one(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

	initial begin
		$monitor($time,"rA_64bit_val = %b, rB_64bit_val = %b, R_ins = %b, Op_code = %b, WW = %b, ALU_out = %b" ,rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);
		
		//VAND of decimal numbers 15 and 14, WW field doesn't matter, o/p is 14								
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000001;
		WW = 10;

		//VOR decimal numbers 15 and 14, WW field doesn't matter, o/p is 15 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000010;
		WW = 10;

		//VXOR decimal numbers 15 and 14, WW field doesn't matter, o/p is 1
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000011;
		WW = 10;

		//VNOT decimal numbers rA_content = 64'd0, WW field doesn't matter, output all 64 bits as 1
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd0;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000100;
		WW = 10;
		
		//VMOV decimal numbers rA_content = 64'hFFFFFFFF_00000000, WW field doesn't matter, output 64'hFFFFFFFF_00000000
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_00000000;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000101;
		WW = 10;

		//
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_00000000;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000101;
		WW = 10;

		#20 $finish;
	end
endmodule