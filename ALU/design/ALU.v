`timescale 1 ns / 10 ps						//For  modules [31:0] but giving [0:31] check pending

//`include "./include/sim_ver/DW_sqrt.v"
//`include "./include/sim_ver/DW02_mult.v"
//`include "./include/sim_ver/DW_div.v"


`include "./include/sim_ver/DW01_add.v"



module ALU(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

input [0:63] rA_64bit_val, rB_64bit_val;
input [0:5] R_ins, Op_code;
input [0:1] WW;
output [0:63] ALU_out;
reg [0:63] ALU_out;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,			//Instruction from R type depending on INSTR[26:31] bits R_ins
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =  6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			


parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010, BRANCH_NZ = 6'b100011, NOP = 6'b111100;	//Type of instruction depending on INSTR[0:5] bits Op_code
parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  //Width depending on WW

//For 8bit adders
reg [0:7] rA_8bit_p1, rB_8bit_p1, rA_8bit_p2, rB_8bit_p2, rA_8bit_p3, rB_8bit_p3,  rA_8bit_p4, rB_8bit_p4, rA_8bit_p5, rB_8bit_p5, rA_8bit_p6, rB_8bit_p6, rA_8bit_p7, rB_8bit_p7, rA_8bit_p8, rB_8bit_p8;
wire [0:7] ALU_8bit_p1, ALU_8bit_p2, ALU_8bit_p3, ALU_8bit_p4, ALU_8bit_p5, ALU_8bit_p6, ALU_8bit_p7, ALU_8bit_p8;

//For 16 bit adders
reg [0:15] rA_16bit_p1, rB_16bit_p1, rA_16bit_p2, rB_16bit_p2, rA_16bit_p3, rB_16bit_p3,  rA_16bit_p4, rB_16bit_p4;
wire [0:15] ALU_16bit_p1, ALU_16bit_p2, ALU_16bit_p3, ALU_16bit_p4;

//For 32 bit adders
reg [0:31] rA_32bit_p1,rB_32bit_p1, rA_32bit_p2,rB_32bit_p2;
wire [0:31] ALU_32bit_p1, ALU_32bit_p2; 

//For 64 bit adder
reg [0:63] rA_64bit_p1,rB_64bit_p1;
wire [0:63] ALU_64bit_p1;

//for adder (should this be reg??) (Yes)
reg [0:6] carry_in;
wire [0:6] carry_out;

//8bit adders
DW01_add #(8) add1 (.A(rA_64bit_val[0:7]), .B(rB_64bit_val[0:7]), .CI(carry_in[0]), .SUM(ALU_out[0:7]), .CO()); //MSB
DW01_add #(8) add2 (.A(rA_64bit_val[8:15]), .B(rB_64bit_val[8:15]), .CI(carry_in[1]), .SUM(ALU_out[8:15]), .CO(carry_out[0]));
DW01_add #(8) add3 (.A(rA_64bit_val[16:23]), .B(rB_64bit_val[16:23]), .CI(carry_in[2]), .SUM(ALU_out[16:23]), .CO(carry_out[1]));
DW01_add #(8) add4 (.A(rA_64bit_val[24:31]), .B(rB_64bit_val[24:31]), .CI(carry_in[3]), .SUM(ALU_out[24:31]), .CO(carry_out[2]));
DW01_add #(8) add5 (.A(rA_64bit_val[32:39]), .B(rB_64bit_val[32:39]), .CI(carry_in[4]), .SUM(ALU_out[32:39]), .CO(carry_out[3]));
DW01_add #(8) add6 (.A(rA_64bit_val[40:47]), .B(rB_64bit_val[40:47]), .CI(carry_in[5]), .SUM(ALU_out[40:47]), .CO(carry_out[4]));
DW01_add #(8) add7 (.A(rA_64bit_val[48:55]), .B(rB_64bit_val[48:55]), .CI(carry_in[6]), .SUM(ALU_out[48:55]), .CO(carry_out[5]));
DW01_add #(8) add8 (.A(rA_64bit_val[56:63]), .B(rB_64bit_val[56:63]), .CI(0), .SUM(ALU_out[56:63]), .CO(carry_out[6])); //LSB

// //8 8 bit adders
// DW01_add #(8) dwad1(.rA_8bit_p1,rB_8bit_p1 ,0,ALU_8bit_p1,CO);	
// DW01_add #(8) dwad2(rA_8bit_p2,rB_8bit_p2 ,0,ALU_8bit_p2,CO);
// DW01_add #(8) dwad3(rA_8bit_p3,rB_8bit_p3 ,0,ALU_8bit_p3,CO);
// DW01_add #(8) dwad4(rA_8bit_p4,rB_8bit_p4 ,0,ALU_8bit_p4,CO);
// DW01_add #(8) dwad5(rA_8bit_p5,rB_8bit_p5 ,0,ALU_8bit_p5,CO);
// DW01_add #(8) dwad6(rA_8bit_p6,rB_8bit_p6 ,0,ALU_8bit_p6,CO);
// DW01_add #(8) dwad7(rA_8bit_p7,rB_8bit_p7 ,0,ALU_8bit_p7,CO);
// DW01_add #(8) dwad8(rA_8bit_p8,rB_8bit_p8 ,0,ALU_8bit_p8,CO);

// //4 16 bit adders
// DW01_add #(16) dwad9(rA_16bit_p1,rB_16bit_p1 ,0,ALU_16bit_p1,CO);
// DW01_add #(16) dwad10(rA_16bit_p2,rB_16bit_p2 ,0,ALU_16bit_p2,CO);
// DW01_add #(16) dwad11(rA_16bit_p3,rB_16bit_p3 ,0,ALU_16bit_p3,CO);
// DW01_add #(16) dwad12(rA_16bit_p4,rB_16bit_p4 ,0,ALU_16bit_p4,CO);

// //2 32 bit adders
// DW01_add #(32) dwad13(rA_32bit_p1,rB_32bit_p1 ,0,ALU_32bit_p1,CO);
// DW01_add #(32) dwad14(rA_32bit_p2,rB_32bit_p2 ,0,ALU_32bit_p2,CO);

// //For 64 bit adder
// DW01_add #(64) dwad15(rA_64bit_p1,rB_64bit_p1 ,0,ALU_64bit_p1,CO);

always @(*) begin		


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

									rA_8bit_p1 = rA_64bit_val[0:7];
									rB_8bit_p1 = rB_64bit_val[0:7];
									ALU_out[0:7] = ALU_8bit_p1;

									rA_8bit_p2 = rA_64bit_val[8:15];
									rB_8bit_p2 = rB_64bit_val[8:15];
									ALU_out[8:15] = ALU_8bit_p2;

									rA_8bit_p3 = rA_64bit_val[16:23];
									rB_8bit_p3 = rB_64bit_val[16:23];
									ALU_out[16:23] = ALU_8bit_p3;

									rA_8bit_p4 = rA_64bit_val[24:31];
									rB_8bit_p4 = rB_64bit_val[24:31];
									ALU_out[24:31] = ALU_8bit_p4;

									rA_8bit_p5 = rA_64bit_val[32:39];
									rB_8bit_p5 = rB_64bit_val[32:39];
									ALU_out[32:39] = ALU_8bit_p5;

									rA_8bit_p6 = rA_64bit_val[40:47];
									rB_8bit_p6 = rB_64bit_val[40:47];
									ALU_out[40:47] = ALU_8bit_p6;

									rA_8bit_p7 = rA_64bit_val[48:55];
									rB_8bit_p7 = rB_64bit_val[48:55];
									ALU_out[48:55] = ALU_8bit_p7;

									rA_8bit_p8 = rA_64bit_val[56:63];
									rB_8bit_p8 = rB_64bit_val[56:63];
									ALU_out[56:63] = ALU_8bit_p8;

						end

						Width_16:	begin

									rA_16bit_p1 = rA_64bit_val[0:15];
									rB_16bit_p1 = rB_64bit_val[0:15];
									ALU_out[0:15] = ALU_16bit_p1;

									rA_16bit_p2 = rA_64bit_val[16:31];
									rB_16bit_p2 = rB_64bit_val[16:31];
									ALU_out[16:31] = ALU_16bit_p2;

									rA_16bit_p3 = rA_64bit_val[32:47];
									rB_16bit_p3 = rB_64bit_val[32:47];
									ALU_out[32:47] = ALU_16bit_p3;

									rA_16bit_p4 = rA_64bit_val[48:63];
									rB_16bit_p4 = rB_64bit_val[48:63];
									ALU_out[48:63] = ALU_16bit_p4;

						end

						Width_32:  begin
									
									rA_32bit_p1 = rA_64bit_val[0:31];
									rB_16bit_p1 = rB_64bit_val[0:31];
									ALU_out[0:31] = ALU_32bit_p1;

									rA_32bit_p2 = rA_64bit_val[32:63];
									rB_32bit_p2 = rB_64bit_val[32:63];
									ALU_out[32:63] = ALU_32bit_p2;

						end

						Width_64:	begin
									
									rA_64bit_p1 = rA_64bit_val[0:63];
									rB_64bit_p1 = rB_64bit_val[0:63];
									ALU_out[0:63] = ALU_64bit_p1;
						end
				endcase
				end
		endcase
									
		end
	endcase

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
						carry_in = 7'd0;
					end
					Width_16:	begin
						carry_in[6] = carry_out[6];
						carry_in[4] = carry_out[4];
						carry_in[2] = carry_out[2];
						carry_in[0] = carry_out[0];
						carry_in[5] = 0;
						carry_in[3] = 0;
						carry_in[1] = 0;
					end
					Width_32:	begin
						carry_in[6] = carry_out[6];
						carry_in[5] = carry_out[5];
						carry_in[4] = carry_out[4];
						
						carry_in[3] = 0;
						carry_in[2] = carry_out[2];
						carry_in[1] = carry_out[1];
						carry_in[0] = carry_out[0];
					end
					Width_64:	begin
						carry_in[6] = carry_out[6];
						carry_in[5] = carry_out[5];
						carry_in[4] = carry_out[4];
						carry_in[3] = carry_out[3];
						carry_in[2] = carry_out[2];
						carry_in[1] = carry_out[1];
						carry_in[0] = carry_out[0];
					end
				endcase
			end
		endcase
		//Branch and branch not equal to zero what if not taken?
		// LOAD, STORE: begin
			// ALU_out = rA_64bit_val+ ID_EX_Imm;
		// end

		//Extra comment
		
		//Load, store, branch, nop pending, in each case for width decide for default								*/
	end
endcase


end

endmodule