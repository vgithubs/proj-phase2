`timescale 1 ns / 10 ps

`include "./include/sim_ver/DW_sqrt.v"
`include "./include/sim_ver/DW01_add.v"
`include "./include/sim_ver/DW02_mult.v"
`include "./include/sim_ver/DW_div.v"



module ALU(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

input [0:63] rA_64bit_val, rB_64bit_val;
input [0:5] R_ins, Op_code;
input [0:1] WW;
output ALU_out;


parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,			//Instruction from R type depending on INSTR[26:31] bits R_ins
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =  6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010; BRANCH_NZ = 6'b100011, NOP = 6'b111100;	//Type of instruction depending on INSTR[0:5] bits Op_code

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  //Width depending on WW


//rA_64bit_val= ID_EX_Instr[11:15];			
//rB_64bit_val = ID_EX_Instr[16:20];			

//case(ID_EX_Instr[0:5])
case(Op_code)
	R_ALU: begin
		
		//case(ID_EX_Instr[26:31])	
		case(R_ins)
			VAND: begin
				ALU_out[0:63] = rA_64bit_val & rB_64bit_val;
			end
			
			VOR: begin
				ALU_out[0:63] = rA_64bit_val | rB_64bit_val;
			end
			
			VXOR: begin
				ALU_out[0:63] = rA_64bit_val ^ rB_64bit_val;
			end
			
			VNOT: begin
				ALU_out[0:63] = ~rA_64bit_val;
			end
			
			VMOV: begin
				ALU_out[0:63] = rA_64bit_val;
			end
				
				
			VADD: begin		
				case(WW)									
			//	case(ID_EX_Instr[24:25])						//Depending on WW field

					Width_8:	begin
							//	DW01_add dwadder(A,B,CI,SUM,CO);
								DW01_add dwad1(rA_64bit_val[0:7],rB_64bit_val[0:7],0,ALU_out[0:7],CO);
								DW01_add dwad2(rA_64bit_val[8:15],rB_64bit_val[8:15],0,ALU_out[8:15],CO);
								DW01_add dwad3(rA_64bit_val[16:23],rB_64bit_val[16:23],0,ALU_out[16:23],CO);
								DW01_add dwad4(rA_64bit_val[24:31],rB_64bit_val[24:31],0,ALU_out[24:31],CO);
								DW01_add dwad5(rA_64bit_val[32:39],rB_64bit_val[32:39],0,ALU_out[32:39],CO);
								DW01_add dwad6(rA_64bit_val[40:47],rB_64bit_val[40:47],0,ALU_out[40:47],CO);
								DW01_add dwad7(rA_64bit_val[48:55],rB_64bit_val[48:55],0,ALU_out[48:55],CO);
								DW01_add dwad8(rA_64bit_val[56:63],rB_64bit_val[56:63],0,ALU_out[56:63],CO);
					end

					Width_16:	begin
								DW01_add dwad9(rA_64bit_val[0:15],rB_64bit_val[0:15],0,ALU_out[0:15],CO);
								DW01_add dwad10(rA_64bit_val[16:31],rB_64bit_val[16:31],0,ALU_out[16:31],CO);
								DW01_add dwad11(rA_64bit_val[32:47],rB_64bit_val[32:47],0,ALU_out[32:47],CO);
								DW01_add dwad12(rA_64bit_val[48:63],rB_64bit_val[48:63],0,ALU_out[48:63],CO);
					end

					Width_32:  begin
								DW01_add dwad13(rA_64bit_val[0:31],rB_64bit_val[0:31],0,ALU_out[0:31],CO);
								DW01_add dwad14(rA_64bit_val[32:63],rB_64bit_val[32:63],0,ALU_out[32:63],CO);

					end

					Width_64:	begin
								DW01_add dwad15(rA_64bit_val[0:63],rB_64bit_val[0:63],0,ALU_out[0:63],CO);
					end

				/*	Width_8: 	begin
								ALU_out[0:7] = rA_64bit_val[0:7] + rB_64bit_val[0:7];
								ALU_out[8:15] = rA_64bit_val[8:15] + rB_64bit_val[8:15];
								ALU_out[16:23] = rA_64bit_val[16:23] + rB_64bit_val[16:23];
								ALU_out[24:31] = rA_64bit_val[24:31]+ rB_64bit_val[24:31];
								ALU_out[32:39] = rA_64bit_val[32:39] + rB_64bit_val[32:39];
								ALU_out[40:47] = rA_64bit_val[40:47] + rB_64bit_val[40:47];
								ALU_out[48:55] = rA_64bit_val[48:55] + rB_64bit_val[48:55];
								ALU_out[56:63] = rA_64bit_val[56:63] + rB_64bit_val[56:63];
					end
								
					Width_16:	begin
								ALU_out[0:15] = rA_64bit_val[0:15] + rB_64bit_val[0:15];
								ALU_out[16:31] = rA_64bit_val[16:31] + rB_64bit_val[16:31];
								ALU_out[32:47] = rA_64bit_val[32:47] + rB_64bit_val[32:47];
								ALU_out[48:63] = rA_64bit_val[48:63] + rB_64bit_val[48:63];
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA_64bit_val[0:31] + rB_64bit_val[0:31];
								ALU_out[32:63] = rA_64bit_val[32:63] + rB_64bit_val[32:63];
					end
					
					
					Width_64:	begin
								ALU_out[0:63] = rA_64bit_val[0:63] + rB_64bit_val[0:63];
					end*/
					
				endcase
			end
			
			VSUB: begin											
				//case(ID_EX_Instr[24:25])						//Depending on WW field					//Check if to add designware module for 2's complement, also check if carry is discarded?????
				case(WW)	
					Width_8:	begin
							//	DW01_add dwadder(A,B,CI,SUM,CO);
							DW01_add dwad16(rA_64bit_val[0:7],~rB_64bit_val[0:7],1,ALU_out[0:7],CO);
							DW01_add dwad17(rA_64bit_val[8:15],~rB_64bit_val[8:15],1,ALU_out[8:15],CO);
							DW01_add dwad18(rA_64bit_val[16:23],~rB_64bit_val[16:23],1,ALU_out[16:23],CO);
							DW01_add dwad19(rA_64bit_val[24:31],~rB_64bit_val[24:31],1,ALU_out[24:31],CO);
							DW01_add dwad20(rA_64bit_val[32:39],~rB_64bit_val[32:39],1,ALU_out[32:39],CO);
							DW01_add dwad21(rA_64bit_val[40:47],~rB_64bit_val[40:47],1,ALU_out[40:47],CO);
							DW01_add dwad22(rA_64bit_val[48:55],~rB_64bit_val[48:55],1,ALU_out[48:55],CO);
							DW01_add dwad23(rA_64bit_val[56:63],~rB_64bit_val[56:63],1,ALU_out[56:63],CO);
					end

					Width_16:	begin
							DW01_add dwad24(rA_64bit_val[0:15],~rB_64bit_val[0:15],1,ALU_out[0:15],CO);
							DW01_add dwad25(rA_64bit_val[16:31],~rB_64bit_val[16:31],1,ALU_out[16:31],CO);
							DW01_add dwad26(rA_64bit_val[32:47],~rB_64bit_val[32:47],1,ALU_out[32:47],CO);
							DW01_add dwad27(rA_64bit_val[48:63],~rB_64bit_val[48:63],1,ALU_out[48:63],CO);
					end

					Width_32:  begin
							DW01_add dwad28(rA_64bit_val[0:31],~rB_64bit_val[0:31],1,ALU_out[0:31],CO);
							DW01_add dwad29(rA_64bit_val[32:63],~rB_64bit_val[32:63],1,ALU_out[32:63],CO);
					end

					Width_64:	begin
							DW01_add dwad30(rA_64bit_val[0:63],~rB_64bit_val[0:63],1,ALU_out[0:63],CO);
					end
					
					/*Width_8: 	begin
								ALU_out[0:7] = rA_64bit_val[0:7] + (~rB_64bit_val[0:7]) + 1;
								ALU_out[8:15] = rA_64bit_val[8:15] + (~rB_64bit_val[8:15]) + 1;
								ALU_out[16:23] = rA_64bit_val[16:23] + (~rB_64bit_val[16:23]) + 1;
								ALU_out[24:31] = rA_64bit_val[24:31] + (~rB_64bit_val[24:31]) + 1;
								ALU_out[32:39] = rA_64bit_val[32:39] + (~rB_64bit_val[32:39]) + 1;
								ALU_out[40:47] = rA_64bit_val[40:47] + (~rB_64bit_val[40:47]) + 1;
								ALU_out[48:55] = rA_64bit_val[48:55] + (~rB_64bit_val[48:55]) + 1;
								ALU_out[56:63] = rA_64bit_val[56:63] + (~rB_64bit_val[56:63]) + 1;
					end

					Width_16:	begin
								ALU_out[0:15] = rA_64bit_val[0:15] + (~rB_64bit_val[0:15]) + 1;
								ALU_out[16:31] = rA_64bit_val[16:31] + (~rB_64bit_val[16:31]) + 1;
								ALU_out[32:47] = rA_64bit_val[32:47] + (~rB_64bit_val[32:47]) + 1;
								ALU_out[48:63] = rA_64bit_val[48:63] + (~rB_64bit_val[48:63]) + 1;
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA_64bit_val[0:31] + (~rB_64bit_val[0:31]) + 1;
								ALU_out[32:63] = rA_64bit_val[32:63] + (~rB_64bit_val[32:63]) + 1;
					end
					
					
					Width_64:	begin
								ALU_out[0:63] = rA_64bit_val[0:63] + (~rB_64bit_val[0:63]) + 1
					end;*/
					
				endcase
			end
			
			VMULEU: begin
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:	begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						DW02_mult dwm1(rA_64bit_val[0:7],rB_64bit_val[0:7],0,ALU_out[0:15]);
						DW02_mult dwm2(rA_64bit_val[16:23],rB_64bit_val[16:23],0,ALU_out[16:31]);
						DW02_mult dwm3(rA_64bit_val[32:39],rB_64bit_val[32:39],0,ALU_out[32:47]);
						DW02_mult dwm4(rA_64bit_val[48:54],rB_64bit_val[48:54],0,ALU_out[48:63]);	
					end

					Width_16:	begin
						DW02_mult dwm5(rA_64bit_val[0:15],rB_64bit_val[0:15],0,ALU_out[0:31]);
						DW02_mult dwm6(rA_64bit_val[32:47],rB_64bit_val[32:47],0,ALU_out[32:63]);
					end

					Width_32:  begin
						DW02_mult dwm7(rA_64bit_val[0:31],rB_64bit_val[0:31],0,ALU_out[0:63]);
					end

					
				/*	Width_8:    begin
								ALU_out[0:15] = rA_64bit_val[0:7] * rB_64bit_val[0:7];
								ALU_out[16:31] = rA_64bit_val[16:23] * rB_64bit_val[16:23];
								ALU_out[32:47] = rA_64bit_val[32:39] * rB_64bit_val[32:39];
								ALU_out[48:63] = rA_64bit_val[48:54] * rB_64bit_val[48:54];
					end		
					
					Width_16: 	begin
								ALU_out[0:31] = rA_64bit_val[0:15] * rB_64bit_val[0:15];
								ALU_out[32:63] = rA_64bit_val[32:47] * rB_64bit_val[32:47];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA_64bit_val[0:31] * rB_64bit_val[0:31];
					end*/
				endcase
			end
			
			VMULOU: begin
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:	begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						DW02_mult dwm8(rA_64bit_val[8:15],rB_64bit_val[8:15],0,ALU_out[0:15]);
						DW02_mult dwm9(rA_64bit_val[24:31],rB_64bit_val[24:31],0,ALU_out[16:31]);
						DW02_mult dwm10(rA_64bit_val[40:47],rB_64bit_val[40:47],0,ALU_out[32:47]);
						DW02_mult dwm11(rA_64bit_val[55:63],rB_64bit_val[55:63],0,ALU_out[48:63]);	
					end

					Width_16:	begin
						DW02_mult dwm12(rA_64bit_val[16:31],rB_64bit_val[16:31],0,ALU_out[0:31]);
						DW02_mult dwm13(rA_64bit_val[48:63],rB_64bit_val[48:63],0,ALU_out[32:63]);
					end

					Width_32:  begin
						DW02_mult dwm14(rA_64bit_val[32:63],rB_64bit_val[32:63],0,ALU_out[0:63]);
					end
				/*	Width_8:    begin
								ALU_out[0:15] = rA_64bit_val[8:15] * rB_64bit_val[8:15];
								ALU_out[16:31] = rA_64bit_val[24:31] * rB_64bit_val[24:31];
								ALU_out[32:47] = rA_64bit_val[40:47] * rB_64bit_val[40:47];
								ALU_out[48:63] = rA_64bit_val[55:63] * rB_64bit_val[55:63];
					end
					
					Width_16:	begin
								ALU_out[0:31] = rA_64bit_val[16:31] * rB_64bit_val[16:31];
								ALU_out[32:63] = rA_64bit_val[48:63] * rB_64bit_val[48:63];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA_64bit_val[32:63] * rB_64bit_val[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
					end*/
				endcase
				
			end
			
			
	/*		VSLL: begin
				case(ID_EX_Instr[24:25])
				
				endcase
			
			end
			
			
			VSRL: begin
				case(ID_EX_Instr[24:25])
				
				endcase
			end
			
			VSRA: begin
				case(ID_EX_Instr[24:25])
				
				endcase
			end	*/
			
			VRTTH: begin	
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:	begin
								ALU_out[0:7] = {rA_64bit_val[4:7], rA_64bit_val[0:3]};
								ALU_out[8:15] = {rA_64bit_val[12:15], rA_64bit_val[8:11]};
								ALU_out[16:23] = {rA_64bit_val[20:23], rA_64bit_val[16:19]};
								ALU_out[24:31] = {rA_64bit_val[28:31], rA_64bit_val[24:27]};
								ALU_out[32:39] = {rA_64bit_val[36:39], rA_64bit_val[32:35]};
								ALU_out[40:47] = {rA_64bit_val[44:47], rA_64bit_val[40:43]};
								ALU_out[48:55] = {rA_64bit_val[52:55], rA_64bit_val[48:51]};
								ALU_out[56:63] = {rA_64bit_val[60:63], rA_64bit_val[56:59]};
					end
						
					Width_16:	begin
								ALU_out[0:15] = {rA_64bit_val[8:15], rA_64bit_val[0:7]};
								ALU_out[16:31] = {rA_64bit_val[24:31], rA_64bit_val[16:23]};
								ALU_out[32:47] = {rA_64bit_val[40:47], rA_64bit_val[32:39]};
								ALU_out[48:63] = {rA_64bit_val[56:63], rA_64bit_val[48:55]};
					end
							
					Width_32:	begin
								ALU_out[0:31] = {rA_64bit_val[16:31], rA_64bit_val[0:15]};
								ALU_out[32:63] = {rA_64bit_val[48:63], rA_64bit_val[32:47]};
					end
							
					Width_64: 	begin
								ALU_out[0:63] = {rA_64bit_val[32:63], rA_64bit_val[0:31]};
					end
					
				endcase
				
				
			end	
			
			VDIV: begin				//USE DESIGNWARE and divide by 0 condition pending
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8: 	begin
							//	DW_div dwdivision(a, b, quotient, remainder, divide_by_0);
								DW_div dwdivi1(rA_64bit_val[0:7], rB_64bit_val[0:7], ALU_out[0:7], remainder, divide_by_0);
								DW_div dwdivi2(rA_64bit_val[8:15], rB_64bit_val[8:15], ALU_out[8:15], remainder, divide_by_0);
								DW_div dwdivi3(rA_64bit_val[16:23], rB_64bit_val[16:23], ALU_out[16:23], remainder, divide_by_0);
								DW_div dwdivi4(rA_64bit_val[24:31], rB_64bit_val[24:31], ALU_out[24:31], remainder, divide_by_0);
								DW_div dwdivi5(rA_64bit_val[32:39], rB_64bit_val[32:39], ALU_out[32:39], remainder, divide_by_0);
								DW_div dwdivi6(rA_64bit_val[40:47], rB_64bit_val[40:47], ALU_out[40:47], remainder, divide_by_0);
								DW_div dwdivi7(rA_64bit_val[48:55], rB_64bit_val[48:55], ALU_out[48:55], remainder, divide_by_0);
								DW_div dwdivi8(rA_64bit_val[56:63], rB_64bit_val[56:63], ALU_out[56:63], remainder, divide_by_0);
					end
								
					Width_16:	begin
								DW_div dwdivi9(rA_64bit_val[0:15], rB_64bit_val[0:15], ALU_out[0:15], remainder, divide_by_0);
								DW_div dwdivi10(rA_64bit_val[16:31], rB_64bit_val[16:31], ALU_out[16:31], remainder, divide_by_0);
								DW_div dwdivi11(rA_64bit_val[32:47], rB_64bit_val[32:47], ALU_out[32:47], remainder, divide_by_0);
								DW_div dwdivi12(rA_64bit_val[48:63], rB_64bit_val[48:63], ALU_out[48:63], remainder, divide_by_0);
					end
					
					
					
					Width_32:	begin
								DW_div dwdivi13(rA_64bit_val[0:31], rB_64bit_val[0:31], ALU_out[0:31], remainder, divide_by_0);
								DW_div dwdivi14(rA_64bit_val[32:63], rB_64bit_val[32:63], ALU_out[32:63], remainder, divide_by_0);
					end
				
				
					Width_64:	begin
								DW_div dwdivi15(rA_64bit_val[0:63], rB_64bit_val[0:63], ALU_out[0:63], remainder, divide_by_0);
					end
					
				/*	Width_8: 	begin
								ALU_out[0:7] = rA_64bit_val[0:7] / rB_64bit_val[0:7];
								ALU_out[8:15] = rA_64bit_val[8:15] / rB_64bit_val[8:15];
								ALU_out[16:23] = rA_64bit_val[16:23] / rB_64bit_val[16:23];
								ALU_out[24:31] = rA_64bit_val[24:31] / rB_64bit_val[24:31];
								ALU_out[32:39] = rA_64bit_val[32:39] / rB_64bit_val[32:39];
								ALU_out[40:47] = rA_64bit_val[40:47] / rB_64bit_val[40:47];
								ALU_out[48:55] = rA_64bit_val[48:55] / rB_64bit_val[48:55];
								ALU_out[56:63] = rA_64bit_val[56:63] / rB_64bit_val[56:63];
					end
								
					Width_16:	begin
								ALU_out[0:15] = rA_64bit_val[0:15] / rB_64bit_val[0:15];
								ALU_out[16:31] = rA_64bit_val[16:31] / rB_64bit_val[16:31];
								ALU_out[32:47] = rA_64bit_val[32:47] / rB_64bit_val[32:47];
								ALU_out[48:63] = rA_64bit_val[48:63] / rB_64bit_val[48:63];
					end
					
					
					
					Width_32:	begin
								ALU_out[0:31] = rA_64bit_val[0:31] / rB_64bit_val[0:31];
								ALU_out[32:63] = rA_64bit_val[32:63] / rB_64bit_val[32:63];
					end
				
				
					Width_64:	begin
								ALU_out[0:63] = rA_64bit_val[0:63] / rB_64bit_val[0:63];
					end*/
					
				endcase
				
			end
			
			VMOD: begin																//Can be combined with VDIV remainder as output modulus, check later
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8: 	begin
								ALU_out[0:7] = rA_64bit_val[0:7] % rB_64bit_val[0:7];
								ALU_out[8:15] = rA_64bit_val[8:15] % rB_64bit_val[8:15];
								ALU_out[16:23] = rA_64bit_val[16:23] % rB_64bit_val[16:23];
								ALU_out[24:31] = rA_64bit_val[24:31] % rB_64bit_val[24:31];
								ALU_out[32:39] = rA_64bit_val[32:39] % rB_64bit_val[32:39];
								ALU_out[40:47] = rA_64bit_val[40:47] % rB_64bit_val[40:47];
								ALU_out[48:55] = rA_64bit_val[48:55] % rB_64bit_val[48:55];
								ALU_out[56:63] = rA_64bit_val[56:63] % rB_64bit_val[56:63];
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA_64bit_val[0:31] % rB_64bit_val[0:31];
								ALU_out[32:63] = rA_64bit_val[32:63] % rB_64bit_val[32:63];
					end
				
				
					Width_64:	begin
								ALU_out[0:63] = rA_64bit_val[0:63] % rB_64bit_val[0:63];
					end
					
				endcase
			end
			
			VSQEU: begin
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:   begin
								DW02_mult dwm15(rA_64bit_val[0:7],rA_64bit_val[0:7],0,ALU_out[0:15]);
								DW02_mult dwm16(rA_64bit_val[16:23],rA_64bit_val[16:23],0,ALU_out[16:31]);
								DW02_mult dwm17(rA_64bit_val[32:39],rA_64bit_val[32:39],0,ALU_out[32:47]);
								DW02_mult dwm18(rA_64bit_val[48:54],rA_64bit_val[48:54],0,ALU_out[48:63]);
					end
								
					
					Width_16: 	begin
								DW02_mult dwm19(rA_64bit_val[0:15],rA_64bit_val[0:15],0,ALU_out[0:31]);
								DW02_mult dwm20(rA_64bit_val[32:47],rA_64bit_val[32:47],0,ALU_out[32:63]);
					end

					Width_32:	begin
								DW02_mult dwm21(rA_64bit_val[0:31],rA_64bit_val[0:31],0,ALU_out[0:63]);
					end

				/*	Width_8:   begin
							    ALU_out[0:15] = rA_64bit_val[0:7] * rA_64bit_val[0:7];
								ALU_out[16:31] = rA_64bit_val[16:23] * rA_64bit_val[16:23];
								ALU_out[32:47] = rA_64bit_val[32:39] * rA_64bit_val[32:39];
								ALU_out[48:63] = rA_64bit_val[48:54] * rA_64bit_val[48:54];
					end
								
					
					Width_16: 	begin
								ALU_out[0:31] = rA_64bit_val[0:15] * rA_64bit_val[0:15];
								ALU_out[32:63] = rA_64bit_val[32:47] * rA_64bit_val[32:47];
					end

					Width_32:	begin
								ALU_out[0:63] = rA_64bit_val[0:31] * rA_64bit_val[0:31];
					end*/
				endcase
			end
				
			VSQOU: begin
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:	begin
								DW02_mult dwm22(rA_64bit_val[8:15],rA_64bit_val[8:15],0,ALU_out[0:15]);
								DW02_mult dwm23(rA_64bit_val[24:31],rA_64bit_val[24:31],0,ALU_out[16:31]);
								DW02_mult dwm24(rA_64bit_val[40:47],rA_64bit_val[40:47],0,ALU_out[32:47]);
								DW02_mult dwm25(rA_64bit_val[55:63],rA_64bit_val[55:63],0,ALU_out[48:63]);
					end
					
					Width_16:	begin
								DW02_mult dwm26(rA_64bit_val[16:31],rA_64bit_val[16:31],0,ALU_out[0:31]);
								DW02_mult dwm27(rA_64bit_val[48:63],rA_64bit_val[48:63],0,ALU_out[32:63]);
					end
								
					Width_32:	begin
								DW02_mult dwm28(rA_64bit_val[32:63],rA_64bit_val[32:63],0,ALU_out[0:63]);				//Width_64 is not possible as 64x64 multiplication not supported
					end
				/*	Width_8:	begin
						    	ALU_out[0:15] = rA_64bit_val[8:15] * rA_64bit_val[8:15];
								ALU_out[16:31] = rA_64bit_val[24:31] * rA_64bit_val[24:31];
								ALU_out[32:47] = rA_64bit_val[40:47] * rA_64bit_val[40:47];
								ALU_out[48:63] = rA_64bit_val[55:63] * rA_64bit_val[55:63];
					end
					
					Width_16:	begin
								ALU_out[0:31] = rA_64bit_val[16:31] * rA_64bit_val[16:31];
								ALU_out[32:63] = rA_64bit_val[48:63] * rA_64bit_val[48:63];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA_64bit_val[32:63] * rA_64bit_val[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
					end */
				endcase
			end
			
			
			VSQRT: begin
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:  begin
					  			DW_sqrt dwsq1(rA_64bit_val[0:7], ALU_out[0:7]);
								DW_sqrt dwsq2(rA_64bit_val[8:15], ALU_out[8:15]);
								DW_sqrt dwsq3(rA_64bit_val[16:23], ALU_out[16:23]);
								DW_sqrt dwsq4(rA_64bit_val[24:31], ALU_out[24:31]);
								DW_sqrt dwsq5(rA_64bit_val[32:39], ALU_out[32:39]);
								DW_sqrt dwsq6(rA_64bit_val[40:47], ALU_out[40:47]);
								DW_sqrt dwsq7(rA_64bit_val[48:55], ALU_out[48:55]);
								DW_sqrt dwsq8(rA_64bit_val[56:63], ALU_out[56:63]);
					end

					
					Width_16:	begin

								DW_sqrt dwsq9(rA_64bit_val[0:15], ALU_out[0:15]);
								DW_sqrt dwsq10(rA_64bit_val[16:31], ALU_out[16:31]);
								DW_sqrt dwsq11(rA_64bit_val[32:47], ALU_out[32:47]);
								DW_sqrt dwsq12(rA_64bit_val[48:63], ALU_out[48:63]);
					end
								
					Width_32:	begin
								DW_sqrt dw_sqrt13(rA_64bit_val[0:31], ALU_out[0:31]);	
								DW_sqrt dw_sqrt14(rA_64bit_val[32:63], ALU_out[32:63]);
					end			

					Width_64:	begin
								DW_sqrt dw_sqrt15(rA_64bit_val[0:63], ALU_out[0:63]);
					end
				endcase
				
			
			end
			
			
			
		
																							//Branch and branch not equal to zero what if not taken?
		// LOAD, STORE: begin
			// ALU_out = rA_64bit_val+ ID_EX_Imm;
		// end

		//Extra comment
		
		//Load, store, branch, nop pending, in each case for width decide for default
	end
endcase