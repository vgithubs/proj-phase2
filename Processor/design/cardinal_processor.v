`timescale 1 ns / 10 ps												//wrEn  signal define pending on branch taken//ppp field operation during write back
module cardinal_processor(Clock, Reset);
input Clock;
input Reset;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,					//Instruction op_code depending on INSTR[26:31] bits
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =   6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010; BRANCH_NZ = 6'b100011, NOP = 6'b111100;			//Type of instruction depending on INSTR[0:5] bits

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  
// IF stage signals
reg [0:31] PC;		//positive edge triggered synchronous reset, at reset 32'h0000_0000

reg [0:31] i_memory [0:255]; // instruction memory 256x32				//asynchronous instruction memory - Read operations only(Add condition??????)

reg [0:31] IF_ID_Instr;		//IF ID Stage Register
reg [0:31] IF_ID_PC;


wire [0:31] IF_PC_Adder;
wire [0:31] mux_PC_out;

	
//ID stage signals
reg [0:63] reg_file [0:31] ; // register file 32x64
reg [0:31] ID_EX_Instr;
reg [0:63] ID_EX_A;
reg [0:63] ID_EX_B;
reg [0:31] ID_EX_Imm;


wire ID_EX_BEZ_Comp;
wire ID_EX_BNEZ_Comp;
wire ID_EX_branch_Comp;

wire [0:31] ID_EX_branch_addr;													//Computed branch address PC + Immediate address							

//EX-MEM stage signals
reg [0:31] EX_MEM_WB_Instr;
reg [0:63] EX_MEM_WB_mem_data;
reg [0:63] EX_MEM_WB_reg_data;

reg [0:63] d_memory [0:255];		//data memory 256x64


wire [0:63] ALU_out;

//WB stage signals



//ID stage
assign ID_EX_A = reg_file[IF_ID_Instr[11:15]];
assign ID_EX_B = reg_file[IF_ID_Instr[16:20]];

assign ID_EX_BEZ_Comp = (IF_ID_Instr[0:5] == BRANCH_EZ) && (IF_ID_Instr[11:15] == 0);			//If Branch instruction indicated by Instruction bits 0 to 5 and if RA = 5'b00000

assign ID_EX_BNEZ_Comp = (IF_ID_Instr[0:5] == BRANCH_NZ) && (IF_ID_Instr[11:15] == 1);

assign ID_EX_branch_Comp = ID_EX_BEZ_Comp || ID_EX_BNEZ_Comp;




//IF stage																		
assign IF_PC_Adder = PC + 4;															

assign ID_EX_branch_addr = {{16[IF_ID_Instr[16]}, {IF_ID_Instr[16:31]}} << 2;		//Branch address computation

assign mux_PC_out = ID_EX_branch_Comp ? ID_EX_branch_addr : IF_ID_PC;		//Mux to select next instruction PC + 4 or the address from BEZ

//assign IF_ID_Instr = i_memory[PC];								//Load asynchronously from instruction memory????????






always@(posedge Clock) begin
	if(Reset) begin
		PC <= 32'h0000_0000;							//IF stage registers initialized
		IF_ID_Instr <= 32'h0000_0000;
		IF_ID_PC <= 32'h0000_0000;
		ID_EX_Instr <= 32'h0000_0000;
		ID_EX_A <= 32'h0000_0000;
		ID_EX_B <= 32'h0000_0000;
		ID_EX_Imm <= 32'h0000_0000;
		EX_MEM_WB_Instr <= 32'h0000_0000;
		EX_MEM_WB_mem_data <= 32'h0000_0000;
		EX_MEM_WB_reg_data <= 32'h0000_0000;
	end
	
	else begin
		//IF stage
		if(~STALL) begin
			PC <= mux_PC_out;										//Using assign or non blocking next cycle???????
			IF_ID_PC <= IF_PC_Adder;
			IF_ID_Instr <= i_memory [PC];
		end
		
		//ID stage
	//	if(IF_ID_Instr[11:15] ==  5'b00000) begin					//If RA 11:15, i.e Register 0 is 0 //??????Register 0 is hard wired need to change this
	//		ID_EX_A <= 0;											//Same for RB???
	//	end
	//	ID_EX_A <= reg_file[IF_ID_Instr[11:15]];						//Reading from register file is asynchronous written above
	//	ID_EX_B <= reg_file[IF_ID_Instr[16:20]];
		ID_EX_Instr <= IF_ID_Instr;
		ID_EX_BEZ_Comp <= (ID_EX_A == 0);
		ID_EX_Imm  <= {{16[IF_ID_Instr[16]}, {IF_ID_Instr[16:31]}};		//Sign extend for immediate address to be used in EX stage for LOAD, STORE, BRANCH
		
		//EX-MEM stage
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
				LOAD, STORE: begin
					ALU_out <= ID_EX_A + ID_EX_Imm;
				end
				
			end
			
																								//Memory stage
		case(ID_EX_Instr[0:5])
			LOAD: begin
				EX_MEM_WB_mem_data <= d_memory[ALU_out];
			end
			STORE: begin
				if(wrEn) begin
					d_memory[ALU_out] <= ID_EX_B;
				end
			end
			R_ALU: begin
				EX_MEM_WB_reg_data <= ALU_out;
			end

		endcase
		
		EX_MEM_WB_Instr <= ID_EX_Instr;
		
		//WB stage
		if(wrEn) begin													//Check for stall and branch condition wrEn pending
			case(EX_MEM_WB_Instr[0:5])
				R_ALU: begin
					case(EX_MEM_WB_Instr[21:23])
						a: begin													//All subfields participate
							reg_file[EX_MEM_WB_Instr[6:10]] <= EX_MEM_WB_reg_data;
						end
						
						u: begin													//Upper 32-bit participate
							reg_file[EX_MEM_WB_Instr[6:10]][0:31] <= EX_MEM_WB_reg_data[0:31];						//Check syntax
						end
						
						d: begin													//Lower 32-bits participate
							reg_file[EX_MEM_WB_Instr[6:10]][32:63] <= EX_MEM_WB_reg_data[32:63];
						end
						
						e: begin													//Sub-fields with even index participate
							reg_file[EX_MEM_WB_Instr[6:10]][0:7] <= EX_MEM_WB_reg_data[0:7];
							reg_file[EX_MEM_WB_Instr[6:10]][16:23] <= EX_MEM_WB_reg_data[16:23];
							reg_file[EX_MEM_WB_Instr[6:10]][32:39] <= EX_MEM_WB_reg_data[32:39];
							reg_file[EX_MEM_WB_Instr[6:10]][48:55] <= EX_MEM_WB_reg_data[48:55];
						end
						
						o: begin													//Sub-fields with odd index participate	
							reg_file[EX_MEM_WB_Instr[6:10]][8:15] <= EX_MEM_WB_reg_data[8:15];
							reg_file[EX_MEM_WB_Instr[6:10]][24:31] <= EX_MEM_WB_reg_data[24:31];
							reg_file[EX_MEM_WB_Instr[6:10]][40:47] <= EX_MEM_WB_reg_data[40:47];
							reg_file[EX_MEM_WB_Instr[6:10]][56:63] <= EX_MEM_WB_reg_data[56:63];
						end
					endcase
				end
				
				LOAD: begin
					case(EX_MEM_WB_Instr[21:23])
					reg_file[EX_MEM_WB_Instr[6:10]] <= EX_MEM_WB_mem_data;
				
				
				end
				
				
				
				
				
			endcase
		end
	
	end
	
end
endmodule