`timescale 1 ns / 100 ps

module ALU (ID_EX_Instr, ALU_out);

input ID_EX_Instr;
output ALU_out;


parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,					//Instruction op_code depending on INSTR[26:31] bits
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =   6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010; BRANCH_NZ = 6'b100011, NOP = 6'b111100;			//Type of instruction depending on INSTR[0:5] bits

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  


ID_EX_A = ID_EX_Instr[11:15];			//rA
ID_EX_B = ID_EX_Instr[16:20];			//rB

case(ID_EX_Instr[0:5])
		
	R_ALU: begin
	
		case(ID_EX_Instr[26:31])	
			VAND: begin
				ALU_out[0:63] <= ID_EX_A & ID_EX_B;
			end
			
			VOR: begin
				ALU_out[0:63] <= ID_EX_A | ID_EX_B;
			end
			
			VXOR: begin
				ALU_out[0:63] <= ID_EX_A ^ ID_EX_B;
			end
			
			VNOT: begin
				ALU_out[0:63] <= ~ID_EX_A;
			end
			
			VMOV: begin
				ALU_out[0:63] <= ID_EX_A;
			end
				
				
			VADD: begin											
				case(ID_EX_Instr[24:25])						//Depending on WW field
					Width_8: 	ALU_out[0:7] <= ID_EX_A[0:7] + ID_EX_B[0:7];
								ALU_out[8:15] <= ID_EX_A[8:15] + ID_EX_B[8:15];
								ALU_out[16:23] <= ID_EX_A[16:23] + ID_EX_B[16:23];
								ALU_out[24:31] <= ID_EX_A[24:31]+ ID_EX_B[24:31];
								ALU_out[32:39] <= ID_EX_A[32:39] + ID_EX_B[32:39];
								ALU_out[40:47] <= ID_EX_A[40:47] + ID_EX_B[40:47];
								ALU_out[48:55] <= ID_EX_A[48:55] + ID_EX_B[48:55];
								ALU_out[56:63] <= ID_EX_A[56:63] + ID_EX_B[56:63];
								
					Width_16:	ALU_out[0:15] <= ID_EX_A[0:15] + ID_EX_B[0:15];
								ALU_out[16:31] <= ID_EX_A[16:31] + ID_EX_B[16:31];
								ALU_out[32:47] <= ID_EX_A[32:47] + ID_EX_B[32:47];
								ALU_out[48:63] <= ID_EX_A[48:63] + ID_EX_B[48:63];
					
					
					
					Width_32:	ALU_out[0:31] <= ID_EX_A[0:31] + ID_EX_B[0:31];
								ALU_out[32:63] <= ID_EX_A[32:63] + ID_EX_B[32:63];
					
					
					
					Width_64:	ALU_out[0:63] <= ID_EX_A[0:63] + ID_EX_B[0:63];
					
				endcase
			end
			
			VSUB: begin											
				case(ID_EX_Instr[24:25])						//Depending on WW field					//Check if to add designware module for 2's complement, also check if carry is discarded?????
					Width_8: 	ALU_out[0:7] <= ID_EX_A[0:7] + (~ID_EX_B[0:7]) + 1;
								ALU_out[8:15] <= ID_EX_A[8:15] + (~ID_EX_B[8:15]) + 1;
								ALU_out[16:23] <= ID_EX_A[16:23] + (~ID_EX_B[16:23]) + 1;
								ALU_out[24:31] <= ID_EX_A[24:31] + (~ID_EX_B[24:31]) + 1;
								ALU_out[32:39] <= ID_EX_A[32:39] + (~ID_EX_B[32:39]) + 1;
								ALU_out[40:47] <= ID_EX_A[40:47] + (~ID_EX_B[40:47]) + 1;
								ALU_out[48:55] <= ID_EX_A[48:55] + (~ID_EX_B[48:55]) + 1;
								ALU_out[56:63] <= ID_EX_A[56:63] + (~ID_EX_B[56:63]) + 1;
								
					Width_16:	ALU_out[0:15] <= ID_EX_A[0:15] + (~ID_EX_B[0:15]) + 1;
								ALU_out[16:31] <= ID_EX_A[16:31] + (~ID_EX_B[16:31]) + 1;
								ALU_out[32:47] <= ID_EX_A[32:47] + (~ID_EX_B[32:47]) + 1;
								ALU_out[48:63] <= ID_EX_A[48:63] + (~ID_EX_B[48:63]) + 1;
					
					
					
					Width_32:	ALU_out[0:31] <= ID_EX_A[0:31] + (~ID_EX_B[0:31]) + 1;
								ALU_out[32:63] <= ID_EX_A[32:63] + (~ID_EX_B[32:63]) + 1;
					
					
					
					Width_64:	ALU_out[0:63] <= ID_EX_A[0:63] + (~ID_EX_B[0:63]) + 1;
					
				endcase
			end
			
			VMULEU: begin
				case(ID_EX_Instr[24:25])
					Width_8:    ALU_out[0:15] <= ID_EX_A[0:7] * ID_EX_B[0:7];
								ALU_out[16:31] <= ID_EX_A[16:23] * ID_EX_B[16:23];
								ALU_out[32:47] <= ID_EX_A[32:39] * ID_EX_B[32:39];
								ALU_out[48:63] <= ID_EX_A[48:54] * ID_EX_B[48:54];
								
					
					Width_16: 	ALU_out[0:31] <= ID_EX_A[0:15] * ID_EX_B[0:15];
								ALU_out[32:63] <= ID_EX_A[32:47] * ID_EX_B[32:47];
								
					Width_32:	ALU_out[0:63] <= ID_EX_A[0:31] * ID_EX_B[0:31];
				endcase
			end
			
			VMULOU: begin
				case(ID_EX_Instr[24:25])
					Width_8:    ALU_out[0:15] <= ID_EX_A[8:15] * ID_EX_B[8:15];
								ALU_out[16:31] <= ID_EX_A[24:31] * ID_EX_B[24:31];
								ALU_out[32:47] <= ID_EX_A[40:47] * ID_EX_B[40:47];
								ALU_out[48:63] <= ID_EX_A[55:63] * ID_EX_B[55:63];
					
					Width_16:	ALU_out[0:31] <= ID_EX_A[16:31] * ID_EX_B[16:31];
								ALU_out[32:63] <= ID_EX_A[48:63] * ID_EX_B[48:63];
								
					Width_32:	ALU_out[0:63] <= ID_EX_A[32:63] * ID_EX_B[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
				endcase
				
			end
			
			
			VSLL: begin
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
			end
			
			VRTTH: begin	
				case(ID_EX_Instr[24:25])
					Width_8:	ALU_out[0:7] <= {ID_EX_A[4:7], ID_EX_A[0:3]};
								ALU_out[8:15] <= {ID_EX_A[12:15], ID_EX_A[8:11]};
								ALU_out[16:23] <= {ID_EX_A[20:23], ID_EX_A[16:19]};
								ALU_out[24:31] <= {ID_EX_A[28:31], ID_EX_A[24:27]};
								ALU_out[32:39] <= {ID_EX_A[36:39], ID_EX_A[32:35]};
								ALU_out[40:47] <= {ID_EX_A[44:47], ID_EX_A[40:43]};
								ALU_out[48:55] <= {ID_EX_A[52:55], ID_EX_A[48:51]};
								ALU_out[56:63] <= {ID_EX_A[60:63], ID_EX_A[56:59]};
						
					Width_16:	ALU_out[0:15] <= {ID_EX_A[8:15], ID_EX_A[0:7]};
								ALU_out[16:31] <= {ID_EX_A[24:31], ID_EX_A[16:23]};
								ALU_out[32:47] <= {ID_EX_A[40:47], ID_EX_A[32:39]};
								ALU_out[48:63] <= {ID_EX_A[56:63], ID_EX_A[48:55]};
							'
					Width_32:	ALU_out[0:31] <= {ID_EX_A[16:31], ID_EX_A[0:15]};
								ALU_out[32:63] <= {ID_EX_A[48:63], ID_EX_A[32:47]};
							
					Width_64: 	ALU_out[0:63] <= {ID_EX_A[32:63], ID_EX_A[0:31]};
					
				endcase
				
				
			end	
			
			VDIV: begin				//USE DESIGNWARE and divide by 0 condition pending
				case(ID_EX_Instr[24:25])
					Width_8: 	ALU_out[0:7] <= ID_EX_A[0:7] / ID_EX_B[0:7];
								ALU_out[8:15] <= ID_EX_A[8:15] / ID_EX_B[8:15];
								ALU_out[16:23] <= ID_EX_A[16:23] / ID_EX_B[16:23];
								ALU_out[24:31] <= ID_EX_A[24:31] / ID_EX_B[24:31];
								ALU_out[32:39] <= ID_EX_A[32:39] / ID_EX_B[32:39];
								ALU_out[40:47] <= ID_EX_A[40:47] / ID_EX_B[40:47];
								ALU_out[48:55] <= ID_EX_A[48:55] / ID_EX_B[48:55];
								ALU_out[56:63] <= ID_EX_A[56:63] / ID_EX_B[56:63];
								
					Width_16:	ALU_out[0:15] <= ID_EX_A[0:15] / ID_EX_B[0:15];
								ALU_out[16:31] <= ID_EX_A[16:31] / ID_EX_B[16:31];
								ALU_out[32:47] <= ID_EX_A[32:47] / ID_EX_B[32:47];
								ALU_out[48:63] <= ID_EX_A[48:63] / ID_EX_B[48:63];
					
					
					
					Width_32:	ALU_out[0:31] <= ID_EX_A[0:31] / ID_EX_B[0:31];
								ALU_out[32:63] <= ID_EX_A[32:63] / ID_EX_B[32:63];
				
				
				
					Width_64:	ALU_out[0:63] <= ID_EX_A[0:63] / ID_EX_B[0:63];
					
				endcase
				
			end
			
			VMOD: begin
				case(ID_EX_Instr[24:25])
					Width_8: 	ALU_out[0:7] <= ID_EX_A[0:7] % ID_EX_B[0:7];
								ALU_out[8:15] <= ID_EX_A[8:15] % ID_EX_B[8:15];
								ALU_out[16:23] <= ID_EX_A[16:23] % ID_EX_B[16:23];
								ALU_out[24:31] <= ID_EX_A[24:31] % ID_EX_B[24:31];
								ALU_out[32:39] <= ID_EX_A[32:39] % ID_EX_B[32:39];
								ALU_out[40:47] <= ID_EX_A[40:47] % ID_EX_B[40:47];
								ALU_out[48:55] <= ID_EX_A[48:55] % ID_EX_B[48:55];
								ALU_out[56:63] <= ID_EX_A[56:63] % ID_EX_B[56:63];
								ALU_out[16:31] <= ID_EX_A[16:31] % ID_EX_B[16:31];
								ALU_out[32:47] <= ID_EX_A[32:47] % ID_EX_B[32:47];
								ALU_out[48:63] <= ID_EX_A[48:63] % ID_EX_B[48:63];
					
					
					
					Width_32:	ALU_out[0:31] <= ID_EX_A[0:31] % ID_EX_B[0:31];
								ALU_out[32:63] <= ID_EX_A[32:63] % ID_EX_B[32:63];
				
				
				
					Width_64:	ALU_out[0:63] <= ID_EX_A[0:63] % ID_EX_B[0:63];
					
				endcase
			end
			
			VSQEU: begin
				case(ID_EX_Instr[24:25])
					Width_8:    ALU_out[0:15] <= ID_EX_A[0:7] * ID_EX_A[0:7];
								ALU_out[16:31] <= ID_EX_A[16:23] * ID_EX_A[16:23];
								ALU_out[32:47] <= ID_EX_A[32:39] * ID_EX_A[32:39];
								ALU_out[48:63] <= ID_EX_A[48:54] * ID_EX_A[48:54];
								
					
					Width_16: 	ALU_out[0:31] <= ID_EX_A[0:15] * ID_EX_A[0:15];
								ALU_out[32:63] <= ID_EX_A[32:47] * ID_EX_A[32:47];
								
					Width_32:	ALU_out[0:63] <= ID_EX_A[0:31] * ID_EX_A[0:31];
				endcase
			end
				
			VSQOU: begin
				case(ID_EX_Instr[24:25])
					Width_8:    ALU_out[0:15] <= ID_EX_A[8:15] * ID_EX_A[8:15];
								ALU_out[16:31] <= ID_EX_A[24:31] * ID_EX_A[24:31];
								ALU_out[32:47] <= ID_EX_A[40:47] * ID_EX_A[40:47];
								ALU_out[48:63] <= ID_EX_A[55:63] * ID_EX_A[55:63];
					
					Width_16:	ALU_out[0:31] <= ID_EX_A[16:31] * ID_EX_A[16:31];
								ALU_out[32:63] <= ID_EX_A[48:63] * ID_EX_A[48:63];
								
					Width_32:	ALU_out[0:63] <= ID_EX_A[32:63] * ID_EX_A[32:63];				//Width_64 is not possible as 64x64 multiplication not supported
				endcase
			end
			
			
			VSQRT: begin
			
			
			
			end
			
			
			end
		endcase
		
																							//Branch and branch not equal to zero what if not taken?
		// LOAD, STORE: begin
			// ALU_out <= ID_EX_A + ID_EX_Imm;
		// end
		
	end
endcase