`timescale 1 ns / 10 ps						
//`include "./include/sim_ver/DW01_add.v"
`include "./include/sim_ver/DW_div.v"
`include "./include/sim_ver/DW02_mult.v"
`include "./include/sim_ver/DW_sqrt.v"
`include "./include/sim_ver/DW_shifter.v"
`include "./include/sim_ver/DW01_addsub.v"

module ALU(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

input [0:63] rA_64bit_val, rB_64bit_val;
input [0:5] R_ins; //Instruction type
input Op_code; //Enable signal for ALU
input [0:1] WW;
output [0:63] ALU_out;
reg [0:63] ALU_out;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,			//Instruction from R type depending on INSTR[26:31] bits R_ins
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =  6'b001000, VMULOU = 6'b001001, VSLL = 6'b001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;

parameter R_ALU = 1'b1; //Op_code	

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  //Width depending on WW

reg signed [0:63] ALU_out_signed;

//For 8,16,32,64 inputs
reg [0:7] rA_8bit_p1, rB_8bit_p1, rA_8bit_p2, rB_8bit_p2, rA_8bit_p3, rB_8bit_p3,  rA_8bit_p4, rB_8bit_p4, rA_8bit_p5, rB_8bit_p5, rA_8bit_p6, rB_8bit_p6, rA_8bit_p7, rB_8bit_p7, rA_8bit_p8, rB_8bit_p8;
reg [0:15] rA_16bit_p1, rB_16bit_p1, rA_16bit_p2, rB_16bit_p2, rA_16bit_p3, rB_16bit_p3,  rA_16bit_p4, rB_16bit_p4;
reg [0:31] rA_32bit_p1,rB_32bit_p1, rA_32bit_p2,rB_32bit_p2;
reg [0:63] rA_64bit_p1,rB_64bit_p1;

//for adder
wire [0:6] carry_in;
wire [0:6] carry_out;
reg add_or_sub; //to choose between add and sub

//8bit adders
DW01_addsub #(8) as1 (.A(rA_64bit_val[0:7]), .B(rB_64bit_val[0:7]),     .CI(carry_in[0]), .ADD_SUB(add_or_sub), .SUM(ALU_out[0:7]), .CO()); //MSB
DW01_addsub #(8) as2 (.A(rA_64bit_val[8:15]), .B(rB_64bit_val[8:15]),   .CI(carry_in[1]), .ADD_SUB(add_or_sub), .SUM(ALU_out[8:15]), .CO(carry_out[0]));
DW01_addsub #(8) as3 (.A(rA_64bit_val[16:23]), .B(rB_64bit_val[16:23]), .CI(carry_in[2]), .ADD_SUB(add_or_sub), .SUM(ALU_out[16:23]), .CO(carry_out[1]));
DW01_addsub #(8) as4 (.A(rA_64bit_val[24:31]), .B(rB_64bit_val[24:31]), .CI(carry_in[3]), .ADD_SUB(add_or_sub), .SUM(ALU_out[24:31]), .CO(carry_out[2]));
DW01_addsub #(8) as5 (.A(rA_64bit_val[32:39]), .B(rB_64bit_val[32:39]), .CI(carry_in[4]), .ADD_SUB(add_or_sub), .SUM(ALU_out[32:39]), .CO(carry_out[3]));
DW01_addsub #(8) as6 (.A(rA_64bit_val[40:47]), .B(rB_64bit_val[40:47]), .CI(carry_in[5]), .ADD_SUB(add_or_sub), .SUM(ALU_out[40:47]), .CO(carry_out[4]));
DW01_addsub #(8) as7 (.A(rA_64bit_val[48:55]), .B(rB_64bit_val[48:55]), .CI(carry_in[6]), .ADD_SUB(add_or_sub), .SUM(ALU_out[48:55]), .CO(carry_out[5]));
DW01_addsub #(8) as8 (.A(rA_64bit_val[56:63]), .B(rB_64bit_val[56:63]), .CI(0), .ADD_SUB(add_or_sub), .SUM(ALU_out[56:63]), .CO(carry_out[6])); //LSB


//***Multiply and Square Even and Odd****

wire [0:15] ALU_8bit_mult_p1, ALU_8bit_mult_p2, ALU_8bit_mult_p3, ALU_8bit_mult_p4;
wire [0:31] ALU_16bit_mult_p1, ALU_16bit_mult_p2;
wire [0:63] ALU_32bit_mult_p1;
// 8bit 
DW02_mult #(8, 8) dwm1(rA_8bit_p1, rB_8bit_p1, 1'b0, ALU_8bit_mult_p1);
DW02_mult #(8, 8) dwm2(rA_8bit_p2, rB_8bit_p2, 1'b0, ALU_8bit_mult_p2);
DW02_mult #(8, 8) dwm3(rA_8bit_p3, rB_8bit_p3, 1'b0, ALU_8bit_mult_p3);
DW02_mult #(8, 8) dwm4(rA_8bit_p4, rB_8bit_p4, 1'b0, ALU_8bit_mult_p4);
//16 bit
DW02_mult #(16, 16) dwm5(rA_16bit_p1, rB_16bit_p1, 1'b0, ALU_out[0:31]);
DW02_mult #(16, 16) dwm6(rA_16bit_p2, rB_16bit_p2, 1'b0, ALU_out[32:63]);
//32 bit
DW02_mult #(32, 32) dwm7(rA_32bit_p1, rB_32bit_p1, 1'b0, ALU_out[0:63]);


// Divider for Quotient and Mod
reg [0:7] rA_8bit_div_p1, rB_8bit_div_p1, rA_8bit_div_p2, rB_8bit_div_p2, rA_8bit_div_p3, rB_8bit_div_p3,  rA_8bit_div_p4, rB_8bit_div_p4, rA_8bit_div_p5, rB_8bit_div_p5, rA_8bit_div_p6, rB_8bit_div_p6, rA_8bit_div_p7, rB_8bit_div_p7, rA_8bit_div_p8, rB_8bit_div_p8;
wire [0:7] ALU_8bit_div_p1, ALU_8bit_div_p2, ALU_8bit_div_p3, ALU_8bit_div_p4, ALU_8bit_div_p5, ALU_8bit_div_p6, ALU_8bit_div_p7, ALU_8bit_div_p8;
reg [0:15] rA_16bit_div_p1, rB_16bit_div_p1, rA_16bit_div_p2, rB_16bit_div_p2, rA_16bit_div_p3, rB_16bit_div_p3,  rA_16bit_div_p4, rB_16bit_div_p4;
wire [0:15] ALU_16bit_div_p1, ALU_16bit_div_p2, ALU_16bit_div_p3, ALU_16bit_div_p4;
reg [0:31] rA_32bit_div_p1,rB_32bit_div_p1, rA_32bit_div_p2,rB_32bit_div_p2;
wire [0:31] ALU_32bit_div_p1, ALU_32bit_div_p2;
reg [0:63] rA_64bit_div_p1,rB_64bit_div_p1;
wire [0:63] ALU_64bit_div_p1;


wire [0:7] rem_8bit_div_p1, rem_8bit_div_p2, rem_8bit_div_p3, rem_8bit_div_p4, rem_8bit_div_p5, rem_8bit_div_p6, rem_8bit_div_p7, rem_8bit_div_p8;
wire [0:15] rem_16bit_div_p1, rem_16bit_div_p2, rem_16bit_div_p3, rem_16bit_div_p4;
wire [0:31] rem_32bit_div_p1, rem_32bit_div_p2;
wire [0:63] rem_64bit_div_p1;


//For  8 bit
//DW_div  #(8, 8, 0, 1) dwdivi1(rA_8bit_p1,rB_8bit_p1, ALU_8bit_div_p1, remainder, divide_by_0); parameters 8,8,0,0 tc_mode: unsigned, rem_mode:0 a mod b
DW_div  #(8, 8, 0, 0) dwdivi1(.a(rA_8bit_div_p1), .b(rB_8bit_div_p1), .quotient(ALU_8bit_div_p1), .remainder(rem_8bit_div_p1), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi2(.a(rA_8bit_div_p2), .b(rB_8bit_div_p2), .quotient(ALU_8bit_div_p2), .remainder(rem_8bit_div_p2), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi3(.a(rA_8bit_div_p3), .b(rB_8bit_div_p3), .quotient(ALU_8bit_div_p3), .remainder(rem_8bit_div_p3), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi4(.a(rA_8bit_div_p4), .b(rB_8bit_div_p4), .quotient(ALU_8bit_div_p4), .remainder(rem_8bit_div_p4), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi5(.a(rA_8bit_div_p5), .b(rB_8bit_div_p5), .quotient(ALU_8bit_div_p5), .remainder(rem_8bit_div_p5), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi6(.a(rA_8bit_div_p6), .b(rB_8bit_div_p6), .quotient(ALU_8bit_div_p6), .remainder(rem_8bit_div_p6), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi7(.a(rA_8bit_div_p7), .b(rB_8bit_div_p7), .quotient(ALU_8bit_div_p7), .remainder(rem_8bit_div_p7), .divide_by_0());
DW_div #(8, 8, 0, 0) dwdivi8(.a(rA_8bit_div_p8), .b(rB_8bit_div_p8), .quotient(ALU_8bit_div_p8), .remainder(rem_8bit_div_p8), .divide_by_0());

// //For 16 bit
DW_div #(16, 16, 0, 0) dwdivi9(.a(rA_16bit_div_p1),.b(rB_16bit_div_p1), .quotient(ALU_16bit_div_p1), .remainder(rem_16bit_div_p1), .divide_by_0());
DW_div #(16, 16, 0, 0) dwdivi10(.a(rA_16bit_div_p2),.b(rB_16bit_div_p2), .quotient(ALU_16bit_div_p2), .remainder(rem_16bit_div_p2), .divide_by_0());
DW_div #(16, 16, 0, 0) dwdivi11(.a(rA_16bit_div_p3),.b(rB_16bit_div_p3), .quotient(ALU_16bit_div_p3), .remainder(rem_16bit_div_p3), .divide_by_0());
DW_div #(16, 16, 0, 0) dwdivi12(.a(rA_16bit_div_p4),.b(rB_16bit_div_p4), .quotient(ALU_16bit_div_p4), .remainder(rem_16bit_div_p4), .divide_by_0());

//For  32 bit
DW_div #(32, 32, 0, 0) dwdivi13(.a(rA_32bit_div_p1),.b(rB_32bit_div_p1), .quotient(ALU_32bit_div_p1), .remainder(rem_32bit_div_p1), .divide_by_0());
DW_div #(32, 32, 0, 0) dwdivi14(.a(rA_32bit_div_p2),.b(rB_32bit_div_p2), .quotient(ALU_32bit_div_p2), .remainder(rem_32bit_div_p2), .divide_by_0());

//For 64 bit
DW_div #(64, 64, 0, 0) dwdivi15(.a(rA_64bit_div_p1),.b(rB_64bit_div_p1), .quotient(ALU_64bit_div_p1), .remainder(rem_64bit_div_p1), .divide_by_0());


//***Square Root***

//For 8 bit
DW_sqrt #(8, 0) dwsq1(rA_64bit_val[0:7], ALU_8bit_sqrt_p1);
DW_sqrt #(8, 0) dwsq2(rA_64bit_val[0:7], ALU_8bit_sqrt_p2);
DW_sqrt #(8, 0) dwsq3(rA_64bit_val[0:7], ALU_8bit_sqrt_p3);
DW_sqrt #(8, 0) dwsq4(rA_64bit_val[0:7], ALU_8bit_sqrt_p4);
DW_sqrt #(8, 0) dwsq5(rA_64bit_val[0:7], ALU_8bit_sqrt_p5);
DW_sqrt #(8, 0) dwsq6(rA_64bit_val[0:7], ALU_8bit_sqrt_p6);
DW_sqrt #(8, 0) dwsq7(rA_64bit_val[0:7], ALU_8bit_sqrt_p7);
DW_sqrt #(8, 0) dwsq8(rA_64bit_val[0:7], ALU_8bit_sqrt_p8);
//For 16 bit
DW_sqrt #(16, 0) dwsq9(rA_64bit_val[0:7], ALU_16bit_sqrt_p1);
DW_sqrt #(16, 0) dwsq10(rA_64bit_val[0:7], ALU_16bit_sqrt_p2);
DW_sqrt #(16, 0) dwsq11(rA_64bit_val[0:7], ALU_16bit_sqrt_p3);
DW_sqrt #(16, 0) dwsq12(rA_64bit_val[0:7], ALU_16bit_sqrt_p4);
//For 32 bit
DW_sqrt #(32, 0) dw_sqrt13(rA_64bit_val[0:7], ALU_32bit_sqrt_p1);	
DW_sqrt #(32, 0) dw_sqrt14(rA_64bit_val[0:7], ALU_32bit_sqrt_p2);
//For 64 bit
DW_sqrt #(64, 0) dw_sqrt15(rA_64bit_val[0:7], ALU_64bit_sqrt_p1);

// //***
// //For 8 16 32 64
// wire [0:7] ALU_8bit_shift_p1, ALU_8bit_shift_p2, ALU_8bit_shift_p3, ALU_8bit_shift_p4, ALU_8bit_shift_p5, ALU_8bit_shift_p6, ALU_8bit_shift_p7, ALU_8bit_shift_p8;
// wire [0:15] ALU_16bit_shift_p1, ALU_16bit_shift_p2, ALU_16bit_shift_p3, ALU_16bit_shift_p4;
// wire [0:31] ALU_32bit_shift_p1, ALU_32bit_shift_p2;
// wire [0:63] ALU_64bit_shift_p1;

//DW_shifter_func (func_data_in, func_data_tc, func_sh, func_sh_tc, func_sh_mode, data_out_func);

// reg [0:3]amt_to_shift_8b_p1, amt_to_shift_8b_p2, amt_to_shift_8b_p3, amt_to_shift_8b_p4, amt_to_shift_8b_p5, amt_to_shift_8b_p6, amt_to_shift_8b_p7, amt_to_shift_8b_p8;
// reg [0:4]amt_to_shift_16b_p1, amt_to_shift_16b_p2, amt_to_shift_16b_p3, amt_to_shift_16b_p4;
// reg [0:5]amt_to_shift_32b_p1;
// reg [0:5]amt_to_shift_32b_p2;
// reg [0:6]amt_to_shift;

// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift1(rA_8bit_p1, 1'b1, amt_to_shift_8b_p1, 1'b1, 1'b1, ALU_8bit_shift_p1);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift2(rA_8bit_p2, 1'b1, amt_to_shift_8b_p2, 1'b1, 1'b1, ALU_8bit_shift_p2);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift3(rA_8bit_p3, 1'b1, amt_to_shift_8b_p3, 1'b1, 1'b1, ALU_8bit_shift_p3);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift4(rA_8bit_p4, 1'b1, amt_to_shift_8b_p4, 1'b1, 1'b1, ALU_8bit_shift_p4);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift5(rA_8bit_p5, 1'b1, amt_to_shift_8b_p5, 1'b1, 1'b1, ALU_8bit_shift_p5);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift6(rA_8bit_p6, 1'b1, amt_to_shift_8b_p6, 1'b1, 1'b1, ALU_8bit_shift_p6);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift7(rA_8bit_p7, 1'b1, amt_to_shift_8b_p7, 1'b1, 1'b1, ALU_8bit_shift_p7);
// DW_shifter #(.data_width(8), .sh_width(4), .inv_mode(0)) dwshift8(rA_8bit_p8, 1'b1, amt_to_shift_8b_p8, 1'b1, 1'b1, ALU_8bit_shift_p8);

// //For 16 bit

// DW_shifter #(.data_width(16), .sh_width(5), .inv_mode(0)) dwshift9(rA_16bit_p1, 1'b1, amt_to_shift_16b_p1, 1'b1, 1'b1, ALU_16bit_shift_p1);
// DW_shifter #(.data_width(16), .sh_width(5), .inv_mode(0)) dwshift10(rA_16bit_p2, 1'b1, amt_to_shift_16b_p2, 1'b1, 1'b1, ALU_16bit_shift_p2);
// DW_shifter #(.data_width(16), .sh_width(5), .inv_mode(0)) dwshift11(rA_16bit_p3, 1'b1, amt_to_shift_16b_p3, 1'b1, 1'b1, ALU_16bit_shift_p3);
// DW_shifter #(.data_width(16), .sh_width(5), .inv_mode(0)) dwshift12(rA_16bit_p4, 1'b1, amt_to_shift_16b_p4, 1'b1, 1'b1, ALU_16bit_shift_p4);

// //For 32 bit

// DW_shifter #(.data_width(32), .sh_width(6), .inv_mode(0)) dwshift13(rA_32bit_p1, 1'b1, amt_to_shift_32b_p1, 1'b1, 1'b1, ALU_32bit_shift_p1);
// DW_shifter #(.data_width(32), .sh_width(6), .inv_mode(0)) dwshift14(rA_32bit_p2, 1'b1, amt_to_shift_32b_p2, 1'b1, 1'b1, ALU_32bit_shift_p2);

// //For 64 bit

// DW_shifter #(.data_width(64), .sh_width(7), .inv_mode(0)) dwshift15(rA_64bit_p1, 1'b1, amt_to_shift, 1'b1, 1'b1, ALU_64bit_shift_p1); //8 bit with rB

always @(*) begin		
	case(Op_code) 
		R_ALU: begin	
			case(R_ins)
				VAND: ALU_out[0:63] = rA_64bit_val & rB_64bit_val;
				VOR: ALU_out[0:63] = rA_64bit_val | rB_64bit_val;
				VXOR: ALU_out[0:63] = rA_64bit_val ^ rB_64bit_val;
				VNOT: ALU_out[0:63] = ~rA_64bit_val;
				VMOV: ALU_out[0:63] = rA_64bit_val;
				VADD: begin	
					add_or_sub = 0;	
					case(WW)
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
				
				VSUB: begin	
					add_or_sub = 1;				
					case(WW)
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

			VMULEU: begin
				carry_in = 7'd0;
				case(WW)
					Width_8: begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						rA_8bit_p1 = rA_64bit_val[0:7];
						rB_8bit_p1 = rB_64bit_val[0:7];
						rA_8bit_p2 = rA_64bit_val[16:23];
						rB_8bit_p2 = rB_64bit_val[16:23];
						rA_8bit_p3 = rA_64bit_val[32:39];
						rB_8bit_p3 = rB_64bit_val[32:39];
						rA_8bit_p4 = rA_64bit_val[48:55];
						rB_8bit_p4 = rB_64bit_val[48:55];
					end
					Width_16:	begin
						rA_16bit_p1 = rA_64bit_val[0:15];
						rB_16bit_p1 = rB_64bit_val[0:15];
						rA_16bit_p2 = rA_64bit_val[32:47];
						rB_16bit_p2 = rB_64bit_val[32:47];
					end
					Width_32:  begin
						rA_32bit_p1 = rA_64bit_val[0:31];
						rB_32bit_p1 = rB_64bit_val[0:31];
					end
				endcase
			end
			VMULOU: begin
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:	begin
						//DW02_mult(A,B,TC,PRODUCT), TC: '0' => unsigned multiplication
						rA_8bit_p1 = rA_64bit_val[8:15];
						rB_8bit_p1 = rB_64bit_val[8:15];
						rA_8bit_p2 = rA_64bit_val[24:31];
						rB_8bit_p2 = rB_64bit_val[24:31];
						rA_8bit_p3 = rA_64bit_val[40:47];
						rB_8bit_p3 = rB_64bit_val[40:47];
						rA_8bit_p4 = rA_64bit_val[55:63];
						rB_8bit_p4 = rB_64bit_val[55:63];
					end
					Width_16:	begin
						rA_16bit_p1 = rA_64bit_val[16:31];
						rB_16bit_p1 = rB_64bit_val[16:31];
						rA_16bit_p2 = rA_64bit_val[48:63];
						rB_16bit_p2 = rB_64bit_val[48:63];
					end
					Width_32:  begin
						rA_32bit_p1 = rA_64bit_val[32:63];
						rB_32bit_p1 = rB_64bit_val[32:63];
					end
				endcase
			end
			VSLL: begin
				case(WW)
					Width_8: begin
						ALU_out[0:7] =  rA_64bit_val[0:7]  << rB_64bit_val[5:7];	
						ALU_out[8:15] =  rA_64bit_val[8:15]  << rB_64bit_val[13:15];
						ALU_out[16:23] =  rA_64bit_val[16:23]  << rB_64bit_val[21:23];
						ALU_out[24:31] =  rA_64bit_val[24:31]  << rB_64bit_val[29:31];
						ALU_out[32:39] =  rA_64bit_val[32:39]  << rB_64bit_val[37:39];
						ALU_out[40:47] =  rA_64bit_val[40:47]  << rB_64bit_val[45:47];
						ALU_out[48:55] =  rA_64bit_val[48:55]  << rB_64bit_val[53:55];
						ALU_out[56:63] =  rA_64bit_val[56:63]  << rB_64bit_val[61:63];
					end

					Width_16: begin
						ALU_out[0:15] =  rA_64bit_val[0:15]  << rB_64bit_val[12:15];	  
						ALU_out[16:31] =  rA_64bit_val[16:31]  << rB_64bit_val[28:31];
						ALU_out[32:47] =  rA_64bit_val[32:47]  << rB_64bit_val[44:47];
						ALU_out[48:63] =  rA_64bit_val[48:63]  << rB_64bit_val[60:63];
						
					end

					Width_32: begin
						ALU_out[0:31] =  rA_64bit_val[0:31]  << rB_64bit_val[27:31];		
						ALU_out[32:63] =  rA_64bit_val[32:63]  << rB_64bit_val[59:63];
					end

					Width_64: begin
						ALU_out[0:63] = rA_64bit_val[0:63] << rB_64bit_val[58:63];
					end
				endcase
			end
			VSRL: begin
					case(WW)
					Width_8: begin
							ALU_out[0:7] =  rA_64bit_val[0:7]  >> rB_64bit_val[5:7];	  
							ALU_out[8:15] =  rA_64bit_val[8:15]  >> rB_64bit_val[13:15];
							ALU_out[16:23] =  rA_64bit_val[16:23]  >> rB_64bit_val[21:23];
							ALU_out[24:31] =  rA_64bit_val[24:31]  >> rB_64bit_val[29:31];
							ALU_out[32:39] =  rA_64bit_val[32:39]  >> rB_64bit_val[37:39];
							ALU_out[40:47] =  rA_64bit_val[40:47]  >> rB_64bit_val[45:47];
							ALU_out[48:55] =  rA_64bit_val[48:55]  >> rB_64bit_val[53:55];
							ALU_out[56:63] =  rA_64bit_val[56:63]  >> rB_64bit_val[61:63];
						end

						Width_16: begin
							ALU_out[0:15] =  rA_64bit_val[0:15]  >> rB_64bit_val[12:15];	 
							ALU_out[16:31] =  rA_64bit_val[16:31]  >> rB_64bit_val[28:31];
							ALU_out[32:47] =  rA_64bit_val[32:47]  >> rB_64bit_val[44:47];
							ALU_out[48:63] =  rA_64bit_val[48:63]  >> rB_64bit_val[60:63];
						end

						Width_32: begin
							ALU_out[0:31] =  rA_64bit_val[0:31]  >> rB_64bit_val[27:31];		
							ALU_out[32:63] =  rA_64bit_val[32:63]  >> rB_64bit_val[59:63];
						end

						Width_64: begin
							ALU_out[0:63] = rA_64bit_val[0:63] >> rB_64bit_val[58:63];
						end
					endcase
				end
			VSRA: begin
				case(WW)
					Width_8: begin
						ALU_out_signed[0:7] =  $signed(rA_64bit_val[0:7])  >>> rB_64bit_val[5:7];	  
						ALU_out_signed[8:15] =  $signed(rA_64bit_val[8:15])  >>> rB_64bit_val[13:15];
						ALU_out_signed[16:23] =  $signed(rA_64bit_val[16:23])  >>> rB_64bit_val[21:23];
						ALU_out_signed[24:31] =  $signed(rA_64bit_val[24:31])  >>> rB_64bit_val[29:31];
						ALU_out_signed[32:39] =  $signed(rA_64bit_val[32:39])  >>> rB_64bit_val[37:39];
						ALU_out_signed[40:47] =  $signed(rA_64bit_val[40:47])  >>> rB_64bit_val[45:47];
						ALU_out_signed[48:55] =  $signed(rA_64bit_val[48:55])  >>> rB_64bit_val[53:55];
						ALU_out_signed[56:63] =  $signed(rA_64bit_val[56:63])  >>> rB_64bit_val[61:63];
						ALU_out = ALU_out_signed;
					end

					Width_16: begin
						ALU_out_signed[0:15] =  $signed(rA_64bit_val[0:15])  >>> rB_64bit_val[12:15];	 
						ALU_out_signed[16:31] =  $signed(rA_64bit_val[16:31])  >>> rB_64bit_val[28:31];
						ALU_out_signed[32:47] =  $signed(rA_64bit_val[32:47])  >>> rB_64bit_val[44:47];
						ALU_out_signed[48:63] =  $signed(rA_64bit_val[48:63])  >>> rB_64bit_val[60:63];
						ALU_out = ALU_out_signed;
					end

					Width_32: begin
						ALU_out_signed[0:31] =  $signed(rA_64bit_val[0:31])  >>> rB_64bit_val[27:31];		
						ALU_out_signed[32:63] =  $signed(rA_64bit_val[32:63])  >>> rB_64bit_val[59:63];
						ALU_out = ALU_out_signed;
					end

					Width_64: begin
						ALU_out_signed[0:63] = $signed(rA_64bit_val[0:63]) >>> rB_64bit_val[58:63];
						ALU_out = ALU_out_signed;
					end
				endcase
			end
			VRTTH: begin	
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
		VDIV: begin				
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8: 	begin
						rA_8bit_div_p1 = rA_64bit_val[0:7];
						rB_8bit_div_p1 = rB_64bit_val[0:7];
						ALU_out[0:7] = ALU_8bit_div_p1;
						
						rA_8bit_div_p2 = rA_64bit_val[8:15];
						rB_8bit_div_p2 = rB_64bit_val[8:15];
						ALU_out[8:15] = ALU_8bit_div_p2;

						rA_8bit_div_p3 = rA_64bit_val[16:23];
						rB_8bit_div_p3 = rB_64bit_val[16:23];
						ALU_out[16:23] = ALU_8bit_div_p3;

						rA_8bit_div_p4 = rA_64bit_val[24:31];
						rB_8bit_div_p4 = rB_64bit_val[24:31];
						ALU_out[24:31] = ALU_8bit_div_p4;

						rA_8bit_div_p5 = rA_64bit_val[32:39];
						rB_8bit_div_p5 = rB_64bit_val[32:39];
						ALU_out[32:39] = ALU_8bit_div_p5;

						rA_8bit_div_p6 = rA_64bit_val[40:47];
						rB_8bit_div_p6 = rB_64bit_val[40:47];
						ALU_out[40:47] = ALU_8bit_div_p6;

						rA_8bit_div_p7 = rA_64bit_val[48:55];
						rB_8bit_div_p7 = rB_64bit_val[48:55];
						ALU_out[48:55] = ALU_8bit_div_p7;

						rA_8bit_div_p8 = rA_64bit_val[56:63];
						rB_8bit_div_p8 = rB_64bit_val[56:63];
						ALU_out[56:63] = ALU_8bit_div_p8;
					end
					Width_16:	begin
						rA_16bit_div_p1 = rA_64bit_val[0:15];
						rB_16bit_div_p1 = rB_64bit_val[0:15];
						ALU_out[0:15] = ALU_16bit_div_p1;

						rA_16bit_div_p2 = rA_64bit_val[16:31];
						rB_16bit_div_p2 = rB_64bit_val[16:31];
						ALU_out[16:31] = ALU_16bit_div_p2;

						rA_16bit_div_p3 = rA_64bit_val[32:47];
						rB_16bit_div_p3 = rB_64bit_val[32:47];
						ALU_out[32:47] = ALU_16bit_div_p3;

						rA_16bit_div_p4 = rA_64bit_val[48:63];
						rB_16bit_div_p4 = rB_64bit_val[48:63];
						ALU_out[48:63] = ALU_16bit_div_p4;

					end
					Width_32:	begin
						rA_32bit_div_p1 = rA_64bit_val[0:31];
						rB_32bit_div_p1 = rB_64bit_val[0:31];
						ALU_out[0:31] = ALU_32bit_div_p1;

						rA_32bit_div_p2 = rA_64bit_val[32:63];
						rB_32bit_div_p2 = rB_64bit_val[32:63];
						ALU_out[32:63] = ALU_32bit_div_p2;
					end
					Width_64:	begin
						rA_64bit_div_p1 = rA_64bit_val[0:63];
						rB_64bit_div_p1 = rB_64bit_val[0:63];
						ALU_out[0:63] = ALU_64bit_div_p1;
					end
				endcase
			end
		VMOD: begin															
				case(WW)
					Width_8: 	begin
						rA_8bit_div_p1 = rA_64bit_val[0:7];
						rB_8bit_div_p1 = rB_64bit_val[0:7];
						ALU_out[0:7] = rem_8bit_div_p1;

						rA_8bit_div_p2 = rA_64bit_val[8:15];
						rB_8bit_div_p2 = rB_64bit_val[8:15];
						ALU_out[8:15] = rem_8bit_div_p2;

						rA_8bit_div_p3 = rA_64bit_val[16:23];
						rB_8bit_div_p3 = rB_64bit_val[16:23];
						ALU_out[16:23] = rem_8bit_div_p3;

						rA_8bit_div_p4 = rA_64bit_val[24:31];
						rB_8bit_div_p4 = rB_64bit_val[24:31];
						ALU_out[24:31] = rem_8bit_div_p4;

						rA_8bit_div_p5 = rA_64bit_val[32:39];
						rB_8bit_div_p5 = rB_64bit_val[32:39];
						ALU_out[32:39] = rem_8bit_div_p5;

						rA_8bit_div_p6 = rA_64bit_val[40:47];
						rB_8bit_div_p6 = rB_64bit_val[40:47];
						ALU_out[40:47] = rem_8bit_div_p6;

						rA_8bit_div_p7 = rA_64bit_val[48:55];
						rB_8bit_div_p7 = rB_64bit_val[48:55];
						ALU_out[48:55] = rem_8bit_div_p7;

						rA_8bit_div_p8 = rA_64bit_val[56:63];
						rB_8bit_div_p8 = rB_64bit_val[56:63];
						ALU_out[56:63] = rem_8bit_div_p8;
					end
								
					Width_16:	begin
						rA_16bit_div_p1 = rA_64bit_val[0:15];
						rB_16bit_div_p1 = rB_64bit_val[0:15];
						ALU_out[0:15] = rem_16bit_div_p1;

						rA_16bit_div_p2 = rA_64bit_val[16:31];
						rB_16bit_div_p2 = rB_64bit_val[16:31];
						ALU_out[16:31] = rem_16bit_div_p2;

						rA_16bit_div_p3 = rA_64bit_val[32:47];
						rB_16bit_div_p3 = rB_64bit_val[32:47];
						ALU_out[32:47] = rem_16bit_div_p3;

						rA_16bit_div_p4 = rA_64bit_val[48:63];
						rB_16bit_div_p4 = rB_64bit_val[48:63];
						ALU_out[48:63] = rem_16bit_div_p4;
					end
					Width_32:	begin
						rA_32bit_div_p1 = rA_64bit_val[0:31];
						rB_32bit_div_p1 = rB_64bit_val[0:31];
						ALU_out[0:31] = rem_32bit_div_p1;

						rA_32bit_div_p2 = rA_64bit_val[32:63];
						rB_32bit_div_p2 = rB_64bit_val[32:63];
						ALU_out[32:63] = rem_32bit_div_p2;
					end
					Width_64:	begin
						rA_64bit_div_p1 = rA_64bit_val[0:63];
						rB_64bit_div_p1 = rB_64bit_val[0:63];
						ALU_out[0:63] = rem_64bit_div_p1;
					end	
				endcase
			end
			VSQEU: begin
				case(WW)
					Width_8:   begin
						rA_8bit_p1 = rA_64bit_val[0:7];
						rA_8bit_p2 = rA_64bit_val[16:23];
						rA_8bit_p3 = rA_64bit_val[32:39];
						rA_8bit_p4 = rA_64bit_val[48:55];
						rB_8bit_p1 = rA_64bit_val[0:7];
						rB_8bit_p2 = rA_64bit_val[16:23];
						rB_8bit_p3 = rA_64bit_val[32:39];
						rB_8bit_p4 = rA_64bit_val[48:55];
					end
					Width_16: 	begin
						rA_16bit_p1 = rA_64bit_val[0:15];
						rA_16bit_p2 = rA_64bit_val[32:47];
						rB_16bit_p1 = rA_64bit_val[0:15];
						rB_16bit_p2 = rA_64bit_val[32:47];
						end
					Width_32:	begin
						rA_32bit_p1 = rA_64bit_val[0:31];
						rB_32bit_p1 = rA_64bit_val[0:31];
						end
				endcase
			end
			VSQOU: begin
				case(WW)
					Width_8:	begin
						rA_8bit_p1 = rA_64bit_val[8:15];
						rA_8bit_p2 = rA_64bit_val[24:31];
						rA_8bit_p3 = rA_64bit_val[40:47];
						rA_8bit_p4 = rA_64bit_val[55:63];
						rA_8bit_p1 = rA_64bit_val[8:15];
						rA_8bit_p2 = rA_64bit_val[24:31];
						rA_8bit_p3 = rA_64bit_val[40:47];
						rA_8bit_p4 = rA_64bit_val[55:63];
						rB_8bit_p1 = rA_64bit_val[8:15];
						rB_8bit_p2 = rA_64bit_val[24:31];
						rB_8bit_p3 = rA_64bit_val[40:47];
						rB_8bit_p4 = rA_64bit_val[55:63];
						rB_8bit_p1 = rA_64bit_val[8:15];
						rB_8bit_p2 = rA_64bit_val[24:31];
						rB_8bit_p3 = rA_64bit_val[40:47];
						rB_8bit_p4 = rA_64bit_val[55:63];
						end
					Width_16:	begin
						rA_16bit_p1 = rA_64bit_val[16:31];
						rA_16bit_p2 = rA_64bit_val[48:63];
						rB_16bit_p1 = rA_64bit_val[16:31];
						rB_16bit_p2 = rA_64bit_val[48:63];
						end
					Width_32:	begin
						rA_32bit_p1 = rA_64bit_val[32:63];
						rB_32bit_p1 = rA_64bit_val[32:63];
						end
				endcase
			end
			VSQRT: begin
				//case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:  begin


								rA_8bit_p1 = rA_64bit_val[0:7];
								ALU_out[0:7] = ALU_8bit_sqrt_p1;

								rA_8bit_p2 = rA_64bit_val[8:15];
								ALU_out[8:15] = ALU_8bit_sqrt_p2;

								rA_8bit_p3 = rA_64bit_val[16:23];
								ALU_out[16:23] = ALU_8bit_sqrt_p3;

								rA_8bit_p4 = rA_64bit_val[24:31];
								ALU_out[24:31] = ALU_8bit_sqrt_p4;

								rA_8bit_p5 = rA_64bit_val[32:39];
								ALU_out[32:39] = ALU_8bit_sqrt_p5;

								rA_8bit_p6 = rA_64bit_val[40:47];
								ALU_out[40:47] = ALU_8bit_sqrt_p6;

								rA_8bit_p7 = rA_64bit_val[48:55];
								ALU_out[48:55] = ALU_8bit_sqrt_p7;

								rA_8bit_p8 = rA_64bit_val[56:63];
								ALU_out[56:63] = ALU_8bit_sqrt_p8;

					end

					
					Width_16:	begin


								rA_16bit_p1 = rA_64bit_val[0:15];
								ALU_out[0:15] = ALU_16bit_sqrt_p1;
								rA_16bit_p2 = rA_64bit_val[16:31];
								ALU_out[16:31] = ALU_16bit_sqrt_p2;

								rA_16bit_p3 = rA_64bit_val[32:47];
								ALU_out[32:47] = ALU_16bit_sqrt_p3;

								rA_16bit_p4 = rA_64bit_val[48:63];
								ALU_out[48:63] = ALU_16bit_sqrt_p4;

					end
								
					Width_32:	begin

								rA_32bit_p1 = rA_64bit_val[0:31];
								ALU_out[0:31] = ALU_32bit_sqrt_p1;

								rA_32bit_p2 = rA_64bit_val[32:63];
								ALU_out[32:63] = ALU_32bit_sqrt_p2;

					end			

					Width_64:	begin
								rA_64bit_p1 = rA_64bit_val[0:63];
								ALU_out[0:63] = ALU_64bit_sqrt_p1;
					end
				endcase
				
			
			end

		endcase
									
		end

	default: ALU_out[0:63] = 64'd0;
	endcase
end
endmodule
