//Testbench for Arithmetic and Logic Unit
`timescale 1ns/10ps
module tb_ALU;
	reg [0:63] rA_64bit_val, rB_64bit_val;
	reg [0:5] R_ins, Op_code;
	reg [0:1] WW;
	wire [0:63] ALU_out;

	ALU alu_one(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

	initial begin
		$monitor($time,"rA_64bit_val = %h, rB_64bit_val = %h, R_ins = %b, Op_code = %b, WW = %b, ALU_out = %h" ,rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);
		
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

		//VADD WW field is 00, 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd5;
		rB_64bit_val = 64'd10;
		R_ins = 6'b000110;
		WW = 00;

		//VADD WW field is 00, 8 bit Operand width, 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 00;

		//VADD WW field is 01, 16 bit Operand width, 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 01;

		//VADD WW field is 10, 32 bit Operand width, 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 10;

		//VADD WW field is 11, 64 bit Operand width, 
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 11;



		//VSUB WW field is 10, 32 bit Operand width,
		#10; 
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h0F0F0F0F_11111111;
		R_ins = 6'b000111;
		WW = 10;

		//VSUB WW field is 11, 64 bit Operand width,
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000111;
		WW = 11;

		//VMULEU rA[0:15] = FF00 and rB[0:15] = 0002, rA[32:47] =  FFFF, rB[32:47] = 000F,   o/p is ALU[0:31] = 1FE0016, ALU[32:63] = EFFF1
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'h00020000_000F0001;
		R_ins = 6'b001000;
		WW = 01;

		//VMULEU o/p 400 , WW is 10 32 bit
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd20;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001000;
		WW = 10;

		//VMULOU, WW is 01,  16 bit
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'h00020000_000F0001;
		R_ins = 6'b001001;
		WW = 01;

		//VMULOU, WW is 10, 32 bit
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd20;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001001;
		WW = 10;
		

		//VSLL

		//VSRL

		//VSRA

		//VRTTH, First 32 bits are now last 32 bits
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFFFFFFFF_00000000;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001101;
		WW = 11;

		//VDIV check 8 bits result, pending for divide by zero case
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFF00FF00_FF00FF00;		
		rB_64bit_val = 64'h11221122_44444444;
		R_ins = 6'b001110;
		WW = 00;
		
		//VMOD
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'd102;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001111;
		WW = 11;
		
		//VSQEU
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 	64'h00000040_00000001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010000;
		WW = 10;

		//VSQOU	
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000040_00000001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010001;
		WW = 10;

		//VSQRT
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000040_00000001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 11;	


		//VSQRT
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000040_00000001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 11;	

		//VSQRT
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hFF01FFFF_10040001;	//last 8 square root of 16, 4, 0, 1	
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 00;

		//VSQRT
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000640_00040001;		//First  8 digits last 4 is 640 i.e. 1600 in decimal
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 01;

		//VSQRT
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000640_00040001;		//First  8 digits last 4 is 640 i.e. 1600 in decimal
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 10;

		//VSLL
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000640_00040001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001010;
		WW = 00;

		//VSRL
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000640_00040001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001011;
		WW = 10;


		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h00000640_00040001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001100;
		WW = 00;
		
		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h01010101_FFFFEEEE;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001100;
		WW = 00;

		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h8900FFF0_60120100;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001100;
		WW = 00;

		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'h8900FFF0_60120100;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001100;
		WW = 00;

		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h02020202_02020202;
		R_ins = 6'b001100;
		WW = 00;

		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030003_00030003;
		R_ins = 6'b001100;
		WW = 01;


	//	//VSRA
	//	#10;
	//	Op_code = 6'b101010;
	//	rA_64bit_val = 64'hF0E1F2A2_01010101;		
	//	rB_64bit_val = 64'd10;
	//	R_ins = 6'b001100;
	//	WW = 10;

		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000005_00000005;
		R_ins = 6'b001100;
		WW = 10;

		
		//VSRA
		#10;
		Op_code = 6'b101010;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
	//	rB_64bit_val = 64'h00000000_00000008;
		rB_64bit_val = 64'h00000000_00000006;
		R_ins = 6'b001100;
		WW = 11;


		#20 $finish;
	end
endmodule