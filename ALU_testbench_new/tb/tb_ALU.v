//Testbench for Arithmetic and Logic Unit
`timescale 1ns/10ps
module tb_ALU;
	reg [0:63] rA_64bit_val, rB_64bit_val;
	reg [0:5] R_ins;
	reg Op_code;
	reg [0:1] WW;
	wire [0:63] ALU_out;

	ALU alu_one(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

	initial begin
		$monitor($time,"rA_64bit_val = %h, rB_64bit_val = %h, R_ins = %b, Op_code = %b, WW = %b, ALU_out = %h" ,rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);
		
		//VAND of decimal numbers 15 and 14, WW field doesn't matter, o/p is 14	  -						
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000001;
		WW = 10;

		//VAND, WW field doesn't matter, o/p is 64'hF0000000F_00000000 
		#10;
		Op_code = 1'b1;		
		rA_64bit_val = 64'hFFFFFFFF_00000000;
		rB_64bit_val = 64'hF000000F_00001111;
		R_ins = 6'b000001;
		WW = 00;

		//VOR decimal numbers 15 and 14, WW field doesn't matter, o/p is 15  
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000010;
		WW = 10;

		//VOR, WW field doesn't matter, o/p is 64'hFF000011_11111111   -
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000000_11111100;
		rB_64bit_val = 64'h00000011_11111111;
		R_ins = 6'b000010;
		WW = 11;

		//VXOR decimal numbers 15 and 14, WW field doesn't matter, o/p is 1  
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd15;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000011;
		WW = 10;

		//VNOT decimal numbers rA_content = 64'd0, WW field doesn't matter, output all 64 bits as 1  
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd0;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000100;
		WW = 10;

		//VNOT decimal numbers rA_content = 64'd0, WW field doesn't matter, output all 64 bits as 0 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000100;
		WW = 10;
		
		//VMOV decimal numbers rA_content = 64'hFFFFFFFF_00000000, WW field doesn't matter, output 64'hFFFFFFFF_00000000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_00000000;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000101;
		WW = 10;

		//VMOV decimal numbers rA_content = 64'd5, WW field doesn't matter, output 64'd5
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd5;
		rB_64bit_val = 64'd14;
		R_ins = 6'b000101;
		WW = 10;

		//VADD WW field is 00,  8 bit, check if generated carry-bit is ignored, output 64'd15
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd5;
		rB_64bit_val = 64'd10;
		R_ins = 6'b000110;
		WW = 00;

		//VADD WW field is 00, 8 bit Operand width, output: 111, 133, 1FE, 1FE, 110, 110, 1fd, 1C0: 1133FE1010FDC0
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h1234FFFF_1111FEC1;
		R_ins = 6'b000110;
		WW = 00;

		//VADD WW field is 01, 16 bit Operand width, output: FFFF, FFFF, 11110 , 11110 out 64'hFFFFFFFF11101110
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 01;


		//VADD WW field is 01, 16 bit Operand width, output: FFFF,  15677,  1FFFE , 1FFFE	out 64'hFFFF5677FFFEFFFE
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;			
		rB_64bit_val = 64'h00005678_FFFFFFFF;
		R_ins = 6'b000110;
		WW = 01;

		//VADD WW field is 10, 32 bit Operand width, o/p FFFFFFFF 111111110 out 64'hFFFFFFFF_11111110
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 10;

		//VADD WW field is 10, 32 bit Operand width, out 1FF000776, 1FFFF1233 : FF000776FFFF1233
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'hFF000777_FFFF1234;
		R_ins = 6'b000110;
		WW = 10;

		//VADD WW field is 11, 64 bit Operand width, output 64'h0000000011111110
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000110;
		WW = 11;


		//VADD WW field is 11, 64 bit Operand width, output 1FF000777, 1FFFF1233 output 64'h 1FF000777FFFF1233
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'hFF000777_FFFF1234;
		R_ins = 6'b000110;
		WW = 11;



		//VSUB WW field is 00, 8 bit Operand width, rB 00FFF888_0000EDCB,  100 , 1FF, 1F8, 188, 100, 100, 1ED, 1CB output 00FFF8880000EDCB
		#10; 
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'hFF000777_FFFF1234;
		R_ins = 6'b000111;
		WW = 00;

		//VSUB WW field is 01, 16 bit Operand width, rB  00FFF888_0000EDCB, 100FF, 1F888 , 10000, 1EDCB output 00FFF8880000EDCB
		#10; 
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'hFF000777_FFFF1234;
		R_ins = 6'b000111;
		WW = 01;

		//VSUB WW field is 10, 32 bit Operand width, rB F0F0F0F0_EEEEEEEE, output: F0F0F0F0_EEEEEEEE
		#10; 
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h0F0F0F0F_11111111;
		R_ins = 6'b000111;
		WW = 10;
  
		//VSUB WW field is 10, 32 bit Operand width, rB 00FFF888_0000EDCB  100FFF888, 10000EDCB output 64'h00FFF8880000EDCB
		#10; 
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'hFF000777_FFFF1234;
		R_ins = 6'b000111;
		WW = 10;


		//VSUB WW field is 11, 64 bit Operand width, rB FFFFFFFF_EEEEEEEE  output: FFFFFFFF_EEEEEEEE
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_FFFFFFFF;
		rB_64bit_val = 64'h00000000_11111111;
		R_ins = 6'b000111;
		WW = 11;


		//VSUB WW field is 11, 64 bit Operand width, rB 00000000_0000FFFE output 0000000011121110
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h00000000_11111111;
		rB_64bit_val = 64'hFFFFFFFF_FFFF0001;
		R_ins = 6'b000111;
		WW = 11;

		//VMULEU, WW 8bit: FE01, 0000, CB34, 0000  output
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000001_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001000;
		WW = 00;

		//VMULEU, WW 16 bit: output FE02FE00, CC0E33F1
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001000;
		WW = 01;

		//VMULEU, WW is 10 32 bit output FE02FE00FF000000
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001000;
		WW = 10;
		
		//VMULOU, WW is 00, 8 bit 0000, 0000, 0EF1, 00FF output: 0000_0000_0EF1_00FF
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001001;
		WW = 00;


		//VMULOU, WW is 01, 16 bit  00000000_0000FFFF
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001001;
		WW = 01;

		//VMULOU, WW is 10, 32 bit, output CC0F000033F10000   waveform output: CC0F0000_33F0FFFF
		#10;
		Op_code = 1'b1;
		rA_64bit_val =  64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001001;
		WW = 10;

		//VMULOU, WW is 10, 32 bit, output CB43D9290FC12000  : waveform CB43D9290FC12340
		#10;
		Op_code = 1'b1;
		rA_64bit_val =  64'hFF000000_FF012340;		
		rB_64bit_val = 64'hFF020001_CC0F0001;
		R_ins = 6'b001001;
		WW = 10;

		//VMULOU, WW is 10, 32 bit, output CC0F000033F10000   waveform output: CC0F0000_33F0FFFF
		#10;
		Op_code = 1'b1;
		rA_64bit_val =  64'hFF000000_FFFFFFFF;		
		rB_64bit_val = 64'hFF020001_10000000;
		R_ins = 6'b001001;
		WW = 10;
		

		//VRTTH, WW 8bit, output FF214365_87873654
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001101;
		WW = 00;

		//VRTTH, WW 16 bit, output 12FF5634_78784534
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;	
		rB_64bit_val = 64'd20;
		R_ins = 6'b001101;
		WW = 01;

		//VRTTH, 10 WW 32bit,  output 3456FF1263457878
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001101;
		WW = 10;


		//VRTTH, First 32 bits are now last 32 bits output 00000000_FFFFFFFF
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFFFFFFFF_00000000;		
		rB_64bit_val = 64'd20;
		R_ins = 6'b001101;
		WW = 11;

		//VDIV WW 8 bits, 01_00_01_56__00_00_01_04
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val = 64'hFFFF3401_FFDE3211;
		R_ins = 6'b001110;
		WW = 00;

		//VDIV WW 8 bits, 01_(divide_by_zero) 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val = 64'hFF00FF00_FF00FF00;
		R_ins = 6'b001110;
		WW = 00;


		//VDIV 16 bits, 0001_0004__0002_0002
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 	64'hFF00FE08_FF99FF01;
		rB_64bit_val =  64'hFF003456_78786345;	
		R_ins = 6'b001110;
		WW = 01;
		

		//VDIV 32 bits , output 00000001_00000000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val =  64'hFF00FF00_FF00FF00;
		R_ins = 6'b001110;
		WW = 10;


		//VDIV 64 bits, output  00000000_00000001 Remainder : -EDCBA98787A000
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val =  64'hFF00FF00_FF00FF00;
		R_ins = 6'b001110;
		WW = 11;



		//VMOD WW 8 bits, output 00_01_23_00__0C_08_09_01 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF12FF56_78786345;		
		rB_64bit_val = 64'hFF113701_12101211;
		R_ins = 6'b001111;
		WW = 00;

		//VMOD WW 16 bits, output 0001_2352__0C18_08f0 -
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF12FF56_78786345;		
		rB_64bit_val = 64'hFF113701_12101211;
		R_ins = 6'b001111;
		WW = 01;


		//VMOD WW 32 bits, output 0001C855_0C17F6DF - 0001C855_0C17F6DF
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF12FF56_78786345;		
		rB_64bit_val = 64'hFF113701_12101211;
		R_ins = 6'b001111;
		WW = 10;

		//VMOD WW 64 bits, output ED00A98787A000   waveform output: 0001C855_66685134
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF12FF56_78786345;		
		rB_64bit_val = 64'hFF113701_12101211;
		R_ins = 6'b001111;
		WW = 11;


		//VMOD WW 64 bit, output: 00000000_00000002 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'd102;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001111;
		WW = 11;

		//VMOD WW 64 bit, output: Remainder : -ED00A98787A000 waveform output: 00113555_79776445
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF123456_78786345;		
		rB_64bit_val =  64'hFF00FF00_FF00FF00;
		R_ins = 6'b001111;
		WW = 11;

		
		//VSQEU, WW 00 8 bit, output: 1000_0000_1324_0100 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 	64'h40010040_46231001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010000;
		WW = 00;

		

		//VSQEU WW 01 16 bit, output 4001 square 10008001,_ 133728C9
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 	64'h40010040_46231001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010000;
		WW = 01;

		//VSQEU WW 32, output 1000802100801000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 	64'h40010040_46231001;
		rB_64bit_val = 64'd10;
		R_ins = 6'b010000;
		WW = 10;

		//VSQEU WW 32, output FFFFFFFE00000000 waveform output: FFFFFFFE_00000001
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 	64'hFFFFFFFF_46231001;
		rB_64bit_val = 64'd10;
		R_ins = 6'b010000;
		WW = 10;


		//VSQOU	WW 8bit, output: 00011000_04C90001 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h40010040_46231001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010001;
		WW = 00;

		//VSQOU, WW 16 bit, output: 0001000_01002001 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h40010040_46231001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010001;
		WW = 01;

		//VSQOU	WW 32 bits, output: 1337318DED462001 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h40010040_46231001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010001;
		WW = 10;

		//VSQRT, waveform output: 00000000_00080000 , ra d: 274877906945 square root 524288.000001 hex 80000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h00000040_00000001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 11;	


		//VSQRT waveform output: 0F010F0F_04020001	sqaure root of FF is F 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hFF01FFFF_10040001;	//last 8 square root of 16, 4, 0, 1	
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 00;

		//VSQRT	waveform output: 00000028_00020001      640 is 1600, 28 is 40 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h00000640_00040001;		//First  8 digits last 4 is 640 i.e. 1600 in decimal
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 01;

		//VSQRT waveform output: 00000028_00000200   40001: 262145 in decimal square root 512 hex:200 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h00000640_00040001;		//First  8 digits last 4 is 640 i.e. 1600 in decimal
		rB_64bit_val = 64'd10;
		R_ins = 6'b010010;
		WW = 10;


		//VSRA, WW 8bit, output: FCF8FCE8_00000000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h02020202_02020202;
		R_ins = 6'b001100;
		WW = 00;

		//VSRA WW 16bit, output: FE1CFE54_00200020 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030003_00030003;
		R_ins = 6'b001100;
		WW = 01;


		//VSRA, ww 10 32 bit, output FF870F95_00080808 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000005_00000005;
		R_ins = 6'b001100;
		WW = 10;

		
		//VSRA, WW 11 32 bits, output FFC387CA_88040404 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000000_00000006;
		R_ins = 6'b001100;
		WW = 11;



		//VSLL WW 8bit, output: 00000640_004000_04 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h00000640_00040001;		
		rB_64bit_val = 64'd10;
		R_ins = 6'b001010;
		WW = 00;

		//VSLL WW 64 bit,  shift by A 10 bits , 87CA8804_04040400 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000000_0000000A;
		R_ins = 6'b001010;
		WW = 11;

		//VSLL,  32  bit WW, output:E1C3544_04040400 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000001_0000000A;
		R_ins = 6'b001010;
		WW = 10;

		//VSLL,  16  bit WW, output: 8708_E544_0101_0400 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030001_0000000A;
		R_ins = 6'b001010;
		WW = 01;

		//VSLL,  8  bit WW, output: F0_08_F2_44_04_80_01_04 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030001_020FF00A;
		R_ins = 6'b001010;
		WW = 00;

		//VSRL, 64 bit, output: _003c387C_A8804040 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000000_0000000A;
		R_ins = 6'b001011;
		WW = 11;

		//VSRL,  32  bit WW, 7870F951_00004040 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00000001_0000000A;
		R_ins = 6'b001011;
		WW = 10;

		//VSRL,  16  bit WW, 1E1C_7951_0101_0000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030001_0000000A;
		R_ins = 6'b001011;
		WW = 01;

		//VSRL, 8 bit WW, output: F01CF251_00000100   
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'hF0E1F2A2_01010101;		
		rB_64bit_val = 64'h00030001_020FF00A;
		R_ins = 6'b001011;
		WW = 00;
	

		//VSRA, WW 16bit, output: FCF8FCE8_00000000 
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h024486c9_66666666;		
		rB_64bit_val = 64'h00000000_0000000f;
		R_ins = 6'b001100;
		WW = 01;

		//VSRA, WW 16bit, output: 0488_E1B2_3333_CCCC
		#10;
		Op_code = 1'b1;
		rA_64bit_val = 64'h024486c9_66666666;		
		rB_64bit_val = 64'h000F0002_0001000f;
		R_ins = 6'b001100;
		WW = 01;


		#20 $finish;
		
	end
endmodule