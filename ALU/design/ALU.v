`timescale 1 ns / 10 ps

`include "./include/sim_ver/DW_sqrt.v"
`include "./include/sim_ver/DW01_add.v"
`include "./include/sim_ver/DW02_mult.v"
`include "./include/sim_ver/DW_div.v"



module ALU (ID_EX_Instr, ALU_out);

input ID_EX_Instr;
output ALU_out;


parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,			//Instruction op_code depending on INSTR[26:31] bits
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =  6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010; BRANCH_NZ = 6'b100011, NOP = 6'b111100;	//Type of instruction depending on INSTR[0:5] bits

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  


rA= ID_EX_Instr[11:15];			
rB = ID_EX_Instr[16:20];			

case(ID_EX_Instr[0:5])

	R_ALU: begin
		
		case(ID_EX_Instr[26:31])	
			VAND: begin
				ALU_out[0:63] = rA & rB;
			end
			
			VOR: begin
				ALU_out[0:63] = rA | rB;
			end
			
			VXOR: begin
				ALU_out[0:63] = rA ^ rB;
			end
			
			VNOT: begin
				ALU_out[0:63] = ~rA;
			end
			
			VMOV: begin
				ALU_out[0:63] = rA;
			end
				
				
			VADD: begin											
				case(ID_EX_Instr[24:25])						//Depending on WW field

					Width_8:	begin
							//	DW01_add dwadder(A,B,CI,SUM,CO);
								DW01_add dwad1(rA[0:7],rB[0:7],0,ALU_out[0:7],CO);
								DW01_add dwad2(rA[8:15],rB[8:15],0,ALU_out[8:15],CO);
								DW01_add dwad3(rA[16:23],rB[16:23],0,ALU_out[16:23],CO);
								DW01_add dwad4(rA[24:31],rB[24:31],0,ALU_out[24:31],CO);
								DW01_add dwad5(rA[32:39],rB[32:39],0,ALU_out[32:39],CO);
								DW01_add dwad6(rA[40:47],rB[40:47],0,ALU_out[40:47],CO);
								DW01_add dwad7(rA[48:55],rB[48:55],0,ALU_out[48:55],CO);
								DW01_add dwad8(rA[56:63],rB[56:63],0,ALU_out[56:63],CO);
					end

					Width_16:	begin
								DW01_add dwad9(rA[0:15],rB[0:15],0,ALU_out[0:15],CO);
								DW01_add dwad10(rA[16:31],rB[16:31],0,ALU_out[16:31],CO);
								DW01_add dwad11(rA[32:47],rB[32:47],0,ALU_out[32:47],CO);
								DW01_add dwad12(rA[48:63],rB[48:63],0,ALU_out[48:63],CO);
					end

					Width_32:  begin
								DW01_add dwad13(rA[0:31],rB[0:31],0,ALU_out[0:31],CO);
								DW01_add dwad14(rA[32:63],rB[32:63],0,ALU_out[32:63],CO);

					end

					Width_64:	begin
								DW01_add dwad15(rA[0:63],rB[0:63],0,ALU_out[0:63],CO);
					end

				/*	Width_8: 	begin
								ALU_out[0:7] = rA[0:7] + rB[0:7];
								ALU_out[8:15] = rA[8:15] + rB[8:15];
								ALU_out[16:23] = rA[16:23] + rB[16:23];
								ALU_out[24:31] = rA[24:31]+ rB[24:31];
								ALU_out[32:39] = rA[32:39] + rB[32:39];
								ALU_out[40:47] = rA[40:47] + rB[40:47];
								ALU_out[48:55] = rA[48:55] + rB[48:55];
								ALU_out[56:63] = rA[56:63] + rB[56:63];
					end
								
					Width_16:	begin
								ALU_out[0:15] = rA[0:15] + rB[0:15];
								ALU_out[16:31] = rA[16:31] + rB[16:31];
								ALU_out[32:47] = rA[32:47] + rB[32:47];
								ALU_out[48:63] = rA[48:63] + rB[48:63];
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA[0:31] + rB[0:31];
								ALU_out[32:63] = rA[32:63] + rB[32:63];
					end
					
					
					Width_64:	begin
								ALU_out[0:63] = rA[0:63] + rB[0:63];
					end*/
					
				endcase
			end
			
			VSUB: begin											
				case(ID_EX_Instr[24:25])						//Depending on WW field					//Check if to add designware module for 2's complement, also check if carry is discarded?????
					
					Width_8:	begin
							//	DW01_add dwadder(A,B,CI,SUM,CO);
							DW01_add dwad16(rA[0:7],~rB[0:7],1,ALU_out[0:7],CO);
							DW01_add dwad17(rA[8:15],~rB[8:15],1,ALU_out[8:15],CO);
							DW01_add dwad18(rA[16:23],~rB[16:23],1,ALU_out[16:23],CO);
							DW01_add dwad19(rA[24:31],~rB[24:31],1,ALU_out[24:31],CO);
							DW01_add dwad20(rA[32:39],~rB[32:39],1,ALU_out[32:39],CO);
							DW01_add dwad21(rA[40:47],~rB[40:47],1,ALU_out[40:47],CO);
							DW01_add dwad22(rA[48:55],~rB[48:55],1,ALU_out[48:55],CO);
							DW01_add dwad23(rA[56:63],~rB[56:63],1,ALU_out[56:63],CO);
					end

					Width_16:	begin
							DW01_add dwad24(rA[0:15],~rB[0:15],1,ALU_out[0:15],CO);
							DW01_add dwad25(rA[16:31],~rB[16:31],1,ALU_out[16:31],CO);
							DW01_add dwad26(rA[32:47],~rB[32:47],1,ALU_out[32:47],CO);
							DW01_add dwad27(rA[48:63],~rB[48:63],1,ALU_out[48:63],CO);
					end

					Width_32:  begin
							DW01_add dwad28(rA[0:31],~rB[0:31],1,ALU_out[0:31],CO);
							DW01_add dwad29(rA[32:63],~rB[32:63],1,ALU_out[32:63],CO);
					end

					Width_64:	begin
							DW01_add dwad30(rA[0:63],~rB[0:63],1,ALU_out[0:63],CO);
					end
					
					/*Width_8: 	begin
								ALU_out[0:7] = rA[0:7] + (~rB[0:7]) + 1;
								ALU_out[8:15] = rA[8:15] + (~rB[8:15]) + 1;
								ALU_out[16:23] = rA[16:23] + (~rB[16:23]) + 1;
								ALU_out[24:31] = rA[24:31] + (~rB[24:31]) + 1;
								ALU_out[32:39] = rA[32:39] + (~rB[32:39]) + 1;
								ALU_out[40:47] = rA[40:47] + (~rB[40:47]) + 1;
								ALU_out[48:55] = rA[48:55] + (~rB[48:55]) + 1;
								ALU_out[56:63] = rA[56:63] + (~rB[56:63]) + 1;
					end

					Width_16:	begin
								ALU_out[0:15] = rA[0:15] + (~rB[0:15]) + 1;
								ALU_out[16:31] = rA[16:31] + (~rB[16:31]) + 1;
								ALU_out[32:47] = rA[32:47] + (~rB[32:47]) + 1;
								ALU_out[48:63] = rA[48:63] + (~rB[48:63]) + 1;
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA[0:31] + (~rB[0:31]) + 1;
								ALU_out[32:63] = rA[32:63] + (~rB[32:63]) + 1;
					end
					
					
					Width_64:	begin
								ALU_out[0:63] = rA[0:63] + (~rB[0:63]) + 1
					end;*/
					
				endcase
			end
			
			VMULEU: begin
				case(ID_EX_Instr[24:25])
					Width_8:	begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						DW02_mult dwm1(rA[0:7],rB[0:7],0,ALU_out[0:15]);
						DW02_mult dwm2(rA[16:23],rB[16:23],0,ALU_out[16:31]);
						DW02_mult dwm3(rA[32:39],rB[32:39],0,ALU_out[32:47]);
						DW02_mult dwm4(rA[48:54],rB[48:54],0,ALU_out[48:63]);	
					end

					Width_16:	begin
						DW02_mult dwm5(rA[0:15],rB[0:15],0,ALU_out[0:31]);
						DW02_mult dwm6(rA[32:47],rB[32:47],0,ALU_out[32:63]);
					end

					Width_32:  begin
						DW02_mult dwm7(rA[0:31],rB[0:31],0,ALU_out[0:63]);
					end

					
				/*	Width_8:    begin
								ALU_out[0:15] = rA[0:7] * rB[0:7];
								ALU_out[16:31] = rA[16:23] * rB[16:23];
								ALU_out[32:47] = rA[32:39] * rB[32:39];
								ALU_out[48:63] = rA[48:54] * rB[48:54];
					end		
					
					Width_16: 	begin
								ALU_out[0:31] = rA[0:15] * rB[0:15];
								ALU_out[32:63] = rA[32:47] * rB[32:47];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA[0:31] * rB[0:31];
					end*/
				endcase
			end
			
			VMULOU: begin
				case(ID_EX_Instr[24:25])
					Width_8:	begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						DW02_mult dwm8(rA[8:15],rB[8:15],0,ALU_out[0:15]);
						DW02_mult dwm9(rA[24:31],rB[24:31],0,ALU_out[16:31]);
						DW02_mult dwm10(rA[40:47],rB[40:47],0,ALU_out[32:47]);
						DW02_mult dwm11(rA[55:63],rB[55:63],0,ALU_out[48:63]);	
					end

					Width_16:	begin
						DW02_mult dwm12(rA[16:31],rB[16:31],0,ALU_out[0:31]);
						DW02_mult dwm13(rA[48:63],rB[48:63],0,ALU_out[32:63]);
					end

					Width_32:  begin
						DW02_mult dwm14(rA[32:63],rB[32:63],0,ALU_out[0:63]);
					end
				/*	Width_8:    begin
								ALU_out[0:15] = rA[8:15] * rB[8:15];
								ALU_out[16:31] = rA[24:31] * rB[24:31];
								ALU_out[32:47] = rA[40:47] * rB[40:47];
								ALU_out[48:63] = rA[55:63] * rB[55:63];
					end
					
					Width_16:	begin
								ALU_out[0:31] = rA[16:31] * rB[16:31];
								ALU_out[32:63] = rA[48:63] * rB[48:63];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA[32:63] * rB[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
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
				case(ID_EX_Instr[24:25])
					Width_8:	begin
								ALU_out[0:7] = {rA[4:7], rA[0:3]};
								ALU_out[8:15] = {rA[12:15], rA[8:11]};
								ALU_out[16:23] = {rA[20:23], rA[16:19]};
								ALU_out[24:31] = {rA[28:31], rA[24:27]};
								ALU_out[32:39] = {rA[36:39], rA[32:35]};
								ALU_out[40:47] = {rA[44:47], rA[40:43]};
								ALU_out[48:55] = {rA[52:55], rA[48:51]};
								ALU_out[56:63] = {rA[60:63], rA[56:59]};
					end
						
					Width_16:	begin
								ALU_out[0:15] = {rA[8:15], rA[0:7]};
								ALU_out[16:31] = {rA[24:31], rA[16:23]};
								ALU_out[32:47] = {rA[40:47], rA[32:39]};
								ALU_out[48:63] = {rA[56:63], rA[48:55]};
					end
							
					Width_32:	begin
								ALU_out[0:31] = {rA[16:31], rA[0:15]};
								ALU_out[32:63] = {rA[48:63], rA[32:47]};
					end
							
					Width_64: 	begin
								ALU_out[0:63] = {rA[32:63], rA[0:31]};
					end
					
				endcase
				
				
			end	
			
			VDIV: begin				//USE DESIGNWARE and divide by 0 condition pending
				case(ID_EX_Instr[24:25])
					Width_8: 	begin
							//	DW_div dwdivision(a, b, quotient, remainder, divide_by_0);
								DW_div dwdivi1(rA[0:7], rB[0:7], ALU_out[0:7], remainder, divide_by_0);
								DW_div dwdivi2(rA[8:15], rB[8:15], ALU_out[8:15], remainder, divide_by_0);
								DW_div dwdivi3(rA[16:23], rB[16:23], ALU_out[16:23], remainder, divide_by_0);
								DW_div dwdivi4(rA[24:31], rB[24:31], ALU_out[24:31], remainder, divide_by_0);
								DW_div dwdivi5(rA[32:39], rB[32:39], ALU_out[32:39], remainder, divide_by_0);
								DW_div dwdivi6(rA[40:47], rB[40:47], ALU_out[40:47], remainder, divide_by_0);
								DW_div dwdivi7(rA[48:55], rB[48:55], ALU_out[48:55], remainder, divide_by_0);
								DW_div dwdivi8(rA[56:63], rB[56:63], ALU_out[56:63], remainder, divide_by_0);
					end
								
					Width_16:	begin
								DW_div dwdivi9(rA[0:15], rB[0:15], ALU_out[0:15], remainder, divide_by_0);
								DW_div dwdivi10(rA[16:31], rB[16:31], ALU_out[16:31], remainder, divide_by_0);
								DW_div dwdivi11(rA[32:47], rB[32:47], ALU_out[32:47], remainder, divide_by_0);
								DW_div dwdivi12(rA[48:63], rB[48:63], ALU_out[48:63], remainder, divide_by_0);
					end
					
					
					
					Width_32:	begin
								DW_div dwdivi13(rA[0:31], rB[0:31], ALU_out[0:31], remainder, divide_by_0);
								DW_div dwdivi14(rA[32:63], rB[32:63], ALU_out[32:63], remainder, divide_by_0);
					end
				
				
					Width_64:	begin
								DW_div dwdivi15(rA[0:63], rB[0:63], ALU_out[0:63], remainder, divide_by_0);
					end
					
				/*	Width_8: 	begin
								ALU_out[0:7] = rA[0:7] / rB[0:7];
								ALU_out[8:15] = rA[8:15] / rB[8:15];
								ALU_out[16:23] = rA[16:23] / rB[16:23];
								ALU_out[24:31] = rA[24:31] / rB[24:31];
								ALU_out[32:39] = rA[32:39] / rB[32:39];
								ALU_out[40:47] = rA[40:47] / rB[40:47];
								ALU_out[48:55] = rA[48:55] / rB[48:55];
								ALU_out[56:63] = rA[56:63] / rB[56:63];
					end
								
					Width_16:	begin
								ALU_out[0:15] = rA[0:15] / rB[0:15];
								ALU_out[16:31] = rA[16:31] / rB[16:31];
								ALU_out[32:47] = rA[32:47] / rB[32:47];
								ALU_out[48:63] = rA[48:63] / rB[48:63];
					end
					
					
					
					Width_32:	begin
								ALU_out[0:31] = rA[0:31] / rB[0:31];
								ALU_out[32:63] = rA[32:63] / rB[32:63];
					end
				
				
					Width_64:	begin
								ALU_out[0:63] = rA[0:63] / rB[0:63];
					end*/
					
				endcase
				
			end
			
			VMOD: begin																//Can be combined with VDIV remainder as output modulus, check later
				case(ID_EX_Instr[24:25])
					Width_8: 	begin
								ALU_out[0:7] = rA[0:7] % rB[0:7];
								ALU_out[8:15] = rA[8:15] % rB[8:15];
								ALU_out[16:23] = rA[16:23] % rB[16:23];
								ALU_out[24:31] = rA[24:31] % rB[24:31];
								ALU_out[32:39] = rA[32:39] % rB[32:39];
								ALU_out[40:47] = rA[40:47] % rB[40:47];
								ALU_out[48:55] = rA[48:55] % rB[48:55];
								ALU_out[56:63] = rA[56:63] % rB[56:63];
					end
					
					
					Width_32:	begin
								ALU_out[0:31] = rA[0:31] % rB[0:31];
								ALU_out[32:63] = rA[32:63] % rB[32:63];
					end
				
				
					Width_64:	begin
								ALU_out[0:63] = rA[0:63] % rB[0:63];
					end
					
				endcase
			end
			
			VSQEU: begin
				case(ID_EX_Instr[24:25])
					Width_8:   begin
								DW02_mult dwm15(rA[0:7],rA[0:7],0,ALU_out[0:15]);
								DW02_mult dwm16(rA[16:23],rA[16:23],0,ALU_out[16:31]);
								DW02_mult dwm17(rA[32:39],rA[32:39],0,ALU_out[32:47]);
								DW02_mult dwm18(rA[48:54],rA[48:54],0,ALU_out[48:63]);
					end
								
					
					Width_16: 	begin
								DW02_mult dwm19(rA[0:15],rA[0:15],0,ALU_out[0:31]);
								DW02_mult dwm20(rA[32:47],rA[32:47],0,ALU_out[32:63]);
					end

					Width_32:	begin
								DW02_mult dwm21(rA[0:31],rA[0:31],0,ALU_out[0:63]);
					end

				/*	Width_8:   begin
							    ALU_out[0:15] = rA[0:7] * rA[0:7];
								ALU_out[16:31] = rA[16:23] * rA[16:23];
								ALU_out[32:47] = rA[32:39] * rA[32:39];
								ALU_out[48:63] = rA[48:54] * rA[48:54];
					end
								
					
					Width_16: 	begin
								ALU_out[0:31] = rA[0:15] * rA[0:15];
								ALU_out[32:63] = rA[32:47] * rA[32:47];
					end

					Width_32:	begin
								ALU_out[0:63] = rA[0:31] * rA[0:31];
					end*/
				endcase
			end
				
			VSQOU: begin
				case(ID_EX_Instr[24:25])
					Width_8:	begin
								DW02_mult dwm22(rA[8:15],rA[8:15],0,ALU_out[0:15]);
								DW02_mult dwm23(rA[24:31],rA[24:31],0,ALU_out[16:31]);
								DW02_mult dwm24(rA[40:47],rA[40:47],0,ALU_out[32:47]);
								DW02_mult dwm25(rA[55:63],rA[55:63],0,ALU_out[48:63]);
					end
					
					Width_16:	begin
								DW02_mult dwm26(rA[16:31],rA[16:31],0,ALU_out[0:31]);
								DW02_mult dwm27(rA[48:63],rA[48:63],0,ALU_out[32:63]);
					end
								
					Width_32:	begin
								DW02_mult dwm28(rA[32:63],rA[32:63],0,ALU_out[0:63]);				//Width_64 is not possible as 64x64 multiplication not supported
					end
				/*	Width_8:	begin
						    	ALU_out[0:15] = rA[8:15] * rA[8:15];
								ALU_out[16:31] = rA[24:31] * rA[24:31];
								ALU_out[32:47] = rA[40:47] * rA[40:47];
								ALU_out[48:63] = rA[55:63] * rA[55:63];
					end
					
					Width_16:	begin
								ALU_out[0:31] = rA[16:31] * rA[16:31];
								ALU_out[32:63] = rA[48:63] * rA[48:63];
					end
								
					Width_32:	begin
								ALU_out[0:63] = rA[32:63] * rA[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
					end */
				endcase
			end
			
			
			VSQRT: begin
				case(ID_EX_Instr[24:25])
					Width_8:  begin
					  			DW_sqrt dwsq1(rA[0:7], ALU_out[0:7]);
								DW_sqrt dwsq2(rA[8:15], ALU_out[8:15]);
								DW_sqrt dwsq3(rA[16:23], ALU_out[16:23]);
								DW_sqrt dwsq4(rA[24:31], ALU_out[24:31]);
								DW_sqrt dwsq5(rA[32:39], ALU_out[32:39]);
								DW_sqrt dwsq6(rA[40:47], ALU_out[40:47]);
								DW_sqrt dwsq7(rA[48:55], ALU_out[48:55]);
								DW_sqrt dwsq8(rA[56:63], ALU_out[56:63]);
					end

					
					Width_16:	begin

								DW_sqrt dwsq9(rA[0:15], ALU_out[0:15]);
								DW_sqrt dwsq10(rA[16:31], ALU_out[16:31]);
								DW_sqrt dwsq11(rA[32:47], ALU_out[32:47]);
								DW_sqrt dwsq12(rA[48:63], ALU_out[48:63]);
					end
								
					Width_32:	begin
								DW_sqrt dw_sqrt13(rA[0:31], ALU_out[0:31]);	
								DW_sqrt dw_sqrt14(rA[32:63], ALU_out[32:63]);
					end			

					Width_64:	begin
								DW_sqrt dw_sqrt15(rA[0:63], ALU_out[0:63]);
					end
				endcase
				
			
			end
			
			
			
		
																							//Branch and branch not equal to zero what if not taken?
		// LOAD, STORE: begin
			// ALU_out = rA+ ID_EX_Imm;
		// end

		//Extra comment
		
	end
endcase