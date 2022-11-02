`timescale 1 ns / 10 ps						//For  modules [31:0] but giving [0:31] check pending




`include "./include/sim_ver/DW01_add.v"
//`include "./include/sim_ver/DW_div.v"
//`include "./include/sim_ver/DW_div_function.inc"
`include "./include/sim_ver/DW02_mult.v"
`include "./include/sim_ver/DW_sqrt.v"
`include "./include/sim_ver/DW_shifter.v"
//`include "./include/sim_ver/DW_shifter_function.inc"


module ALU(rA_64bit_val, rB_64bit_val, R_ins, Op_code, WW, ALU_out);

input [0:63] rA_64bit_val, rB_64bit_val;
input [0:5] R_ins, Op_code;
input [0:1] WW;
output [0:63] ALU_out;
reg [0:63] ALU_out;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,			//Instruction from R type depending on INSTR[26:31] bits R_ins
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =  6'b001000, VMULOU = 6'b001001, VSLL = 6'b001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;
			

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010, BRANCH_NZ = 6'b100011, NOP = 6'b111100;	//Type of instruction depending on INSTR[0:5] bits Op_code

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  //Width depending on WW


//****ADDER****
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

//8 8 bit adders
DW01_add #(8) dwad1(rA_8bit_p1,rB_8bit_p1 ,0,ALU_8bit_p1,CO);	
DW01_add #(8) dwad2(rA_8bit_p2,rB_8bit_p2 ,0,ALU_8bit_p2,CO);
DW01_add #(8) dwad3(rA_8bit_p3,rB_8bit_p3 ,0,ALU_8bit_p3,CO);
DW01_add #(8) dwad4(rA_8bit_p4,rB_8bit_p4 ,0,ALU_8bit_p4,CO);
DW01_add #(8) dwad5(rA_8bit_p5,rB_8bit_p5 ,0,ALU_8bit_p5,CO);
DW01_add #(8) dwad6(rA_8bit_p6,rB_8bit_p6 ,0,ALU_8bit_p6,CO);
DW01_add #(8) dwad7(rA_8bit_p7,rB_8bit_p7 ,0,ALU_8bit_p7,CO);
DW01_add #(8) dwad8(rA_8bit_p8,rB_8bit_p8 ,0,ALU_8bit_p8,CO);

//4 16 bit adders
DW01_add #(16) dwad9(rA_16bit_p1,rB_16bit_p1 ,0,ALU_16bit_p1,CO);
DW01_add #(16) dwad10(rA_16bit_p2,rB_16bit_p2 ,0,ALU_16bit_p2,CO);
DW01_add #(16) dwad11(rA_16bit_p3,rB_16bit_p3 ,0,ALU_16bit_p3,CO);
DW01_add #(16) dwad12(rA_16bit_p4,rB_16bit_p4 ,0,ALU_16bit_p4,CO);

//2 32 bit adders
DW01_add #(32) dwad13(rA_32bit_p1,rB_32bit_p1 ,0,ALU_32bit_p1,CO);
DW01_add #(32) dwad14(rA_32bit_p2,rB_32bit_p2 ,0,ALU_32bit_p2,CO);

//For 64 bit adder
DW01_add #(64) dwad15(rA_64bit_p1,rB_64bit_p1 ,0,ALU_64bit_p1,CO);


//****SUBTRACT****
//For 8  16  32 64
wire [0:7] ALU_8bit_sub_p1, ALU_8bit_sub_p2, ALU_8bit_sub_p3, ALU_8bit_sub_p4, ALU_8bit_sub_p5, ALU_8bit_sub_p6, ALU_8bit_sub_p7, ALU_8bit_sub_p8;
wire [0:15] ALU_16bit_sub_p1, ALU_16bit_sub_p2, ALU_16bit_sub_p3, ALU_16bit_sub_p4;
wire [0:31] ALU_32bit_sub_p1, ALU_32bit_sub_p2;
wire [0:63] ALU_64bit_sub_p1;

//8 8 bit subtract
DW01_add #(8) dwad16(rA_8bit_p1,~rB_8bit_p1,1,ALU_8bit_sub_p1,CO);
DW01_add #(8) dwad17(rA_8bit_p2,~rB_8bit_p2,1,ALU_8bit_sub_p2,CO);
DW01_add #(8) dwad18(rA_8bit_p3,~rB_8bit_p3,1,ALU_8bit_sub_p3,CO);
DW01_add #(8) dwad19(rA_8bit_p4,~rB_8bit_p4,1,ALU_8bit_sub_p4,CO);
DW01_add #(8) dwad20(rA_8bit_p5,~rB_8bit_p5,1,ALU_8bit_sub_p5,CO);
DW01_add #(8) dwad21(rA_8bit_p6,~rB_8bit_p6,1,ALU_8bit_sub_p6,CO);
DW01_add #(8) dwad22(rA_8bit_p7,~rB_8bit_p7,1,ALU_8bit_sub_p7,CO);
DW01_add #(8) dwad23(rA_8bit_p8,~rB_8bit_p8,1,ALU_8bit_sub_p8,CO);

//4 16 bit subtract
DW01_add #(16) dwad24(rA_16bit_p1,~rB_16bit_p1,1,ALU_16bit_sub_p1,CO);
DW01_add #(16) dwad25(rA_16bit_p2,~rB_16bit_p2,1,ALU_16bit_sub_p2,CO);
DW01_add #(16) dwad26(rA_16bit_p3,~rB_16bit_p3,1,ALU_16bit_sub_p3,CO);
DW01_add #(16) dwad27(rA_16bit_p4,~rB_16bit_p4,1,ALU_16bit_sub_p4,CO);

//2 32 bit subtract
DW01_add #(32) dwad28(rA_32bit_p1,~rB_32bit_p1,1,ALU_32bit_sub_p1,CO);
DW01_add #(32) dwad29(rA_32bit_p2,~rB_32bit_p2,1,ALU_32bit_sub_p2,CO);

//For 64 bit subtract
DW01_add #(64) dwad30(rA_64bit_p1,~rB_64bit_p1,1,ALU_64bit_sub_p1,CO);


//***Multiply Even****

//For 8  16  32
wire [0:7] ALU_8bit_mult_p1, ALU_8bit_mult_p2, ALU_8bit_mult_p3, ALU_8bit_mult_p4;
wire [0:15] ALU_16bit_mult_p1, ALU_16bit_mult_p2;
wire [0:31] ALU_32bit_mult_p1;
// 8bit 
DW02_mult #(8, 8) dwm1(rA_8bit_p1,rB_8bit_p1,0,ALU_8bit_mult_p1);
DW02_mult #(8, 8) dwm2(rA_8bit_p2,rB_8bit_p2,0,ALU_8bit_mult_p2);
DW02_mult #(8, 8) dwm3(rA_8bit_p3,rB_8bit_p3,0,ALU_8bit_mult_p3);
DW02_mult #(8, 8) dwm4(rA_8bit_p4,rB_8bit_p4,0,ALU_8bit_mult_p4);
//16 bit
DW02_mult #(16, 16) dwm5(rA_16bit_p1,rB_16bit_p1,0,ALU_16bit_mult_p1);
DW02_mult #(16, 16) dwm6(rA_16bit_p2,rB_16bit_p2,0,ALU_16bit_mult_p2);
//32 bit
DW02_mult #(32, 32) dwm7(rA_32bit_p1,rB_32bit_p1,0,ALU_32bit_mult_p1);



//***Multiply Odd***
//For 8  16  32
wire [0:7] ALU_8bit_mult_odd_p1, ALU_8bit_mult_odd_p2, ALU_8bit_mult_odd_p3, ALU_8bit_mult_odd_p4;
wire [0:15] ALU_16bit_mult_odd_p1, ALU_16bit_mult_odd_p2;
wire [0:31] ALU_32bit_mult_odd_p1;
//8 bit
DW02_mult #(8, 8) dwm8(rA_8bit_p1,rB_8bit_p1,0,ALU_8bit_mult_odd_p1);
DW02_mult #(8, 8) dwm9(rA_8bit_p2,rB_8bit_p2,0,ALU_8bit_mult_odd_p2);
DW02_mult #(8, 8) dwm10(rA_8bit_p3,rB_8bit_p3,0,ALU_8bit_mult_odd_p3);
DW02_mult #(8, 8) dwm11(rA_8bit_p4,rB_8bit_p4,0,ALU_8bit_mult_odd_p4);	

//16bit
DW02_mult #(16, 16) dwm12(rA_16bit_p1,rB_16bit_p1,0,ALU_16bit_mult_odd_p1);
DW02_mult #(16, 16) dwm13(rA_16bit_p2,rB_16bit_p2,0,ALU_16bit_mult_odd_p2);

//32 bit
DW02_mult #(32, 32) dwm14(rA_32bit_p1,rB_32bit_p1,0,ALU_32bit_mult_odd_p1);


/*


//For 8 16 32 64 bits
wire [0:7] ALU_8bit_div_p1, ALU_8bit_div_p2, ALU_8bit_div_p3, ALU_8bit_div_p4, ALU_8bit_div_p5, ALU_8bit_div_p6, ALU_8bit_div_p7, ALU_8bit_div_p8;
wire [0:15] ALU_16bit_div_p1, ALU_16bit_div_p2, ALU_16bit_div_p3, ALU_16bit_div_p4;
wire [0:31] ALU_32bit_div_p1, ALU_32bit_div_p2;
wire [0:63] ALU_64bit_div_p1;

//For  8 bit
DW_div  #(8, 8, 0, 1) dwdivi1(rA_8bit_p1,rB_8bit_p1, ALU_8bit_div_p1, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi2(rA_8bit_p2,rB_8bit_p2, ALU_8bit_div_p2, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi3(rA_8bit_p3,rB_8bit_p3, ALU_8bit_div_p3, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi4(rA_8bit_p4,rB_8bit_p4, ALU_8bit_div_p4, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi5(rA_8bit_p5,rB_8bit_p5, ALU_8bit_div_p5, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi6(rA_8bit_p6,rB_8bit_p6, ALU_8bit_div_p6, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi7(rA_8bit_p7,rB_8bit_p7, ALU_8bit_div_p7, remainder, divide_by_0);
DW_div #(8, 8, 0, 1) dwdivi8(rA_8bit_p8,rB_8bit_p8, ALU_8bit_div_p8, remainder, divide_by_0);

//For 16 bit
DW_div #(16, 16, 0, 1) dwdivi9(rA_16bit_p1,rB_16bit_p1, ALU_16bit_div_p1, remainder, divide_by_0);
DW_div #(16, 16, 0, 1) dwdivi10(rA_16bit_p2,rB_16bit_p2, ALU_16bit_div_p2, remainder, divide_by_0);
DW_div #(16, 16, 0, 1) dwdivi11(rA_16bit_p3,rB_16bit_p3, ALU_16bit_div_p3, remainder, divide_by_0);
DW_div #(16, 16, 0, 1) dwdivi12(rA_16bit_p4,rB_16bit_p4, ALU_16bit_div_p4, remainder, divide_by_0);

//For  32 bit
DW_div #(32, 32, 0, 1) dwdivi13(rA_32bit_p1,rB_32bit_p1, ALU_32bit_div_p1, remainder, divide_by_0);
DW_div #(32, 32, 0, 1) dwdivi14(rA_32bit_p2,rB_32bit_p2, ALU_32bit_div_p2, remainder, divide_by_0);

//For 64 bit
DW_div #(64, 64, 0, 1) dwdivi15(rA_64bit_p1,rB_64bit_p1, ALU_64bit_div_p1, remainder, divide_by_0);

*/
//***Square Even***
//For 8  16  32
wire [0:7] ALU_8bit_sqe_p1, ALU_8bit_sqe_p2, ALU_8bit_sqe_p3, ALU_8bit_sqe_p4;
wire [0:15] ALU_16bit_sqe_p1, ALU_16bit_sqe_p2;
wire [0:31] ALU_32bit_sqe_p1;
//For 8 bit
DW02_mult #(8, 8) dwm15(rA_8bit_p1,rA_8bit_p1,0,ALU_8bit_sqe_p1);
DW02_mult #(8, 8) dwm16(rA_8bit_p2,rA_8bit_p2,0,ALU_8bit_sqe_p2);
DW02_mult #(8, 8) dwm17(rA_8bit_p3,rA_8bit_p3,0,ALU_8bit_sqe_p3);
DW02_mult #(8, 8) dwm18(rA_8bit_p4,rA_8bit_p4,0,ALU_8bit_sqe_p4);
//For 16 bit
DW02_mult #(16, 16) dwm19(rA_16bit_p1,rA_16bit_p1,0,ALU_16bit_sqe_p1);
DW02_mult #(16, 16) dwm20(rA_16bit_p2,rA_16bit_p2,0,ALU_16bit_sqe_p2);
//For 32 bit
DW02_mult #(32, 32) dwm21(rA_32bit_p1,rA_32bit_p1,0,ALU_32bit_sqe_p1);


//***Square Odd***
//For 8  16  32
wire [0:7] ALU_8bit_sqo_p1, ALU_8bit_sqo_p2, ALU_8bit_sqo_p3, ALU_8bit_sqo_p4;
wire [0:15] ALU_16bit_sqo_p1, ALU_16bit_sqo_p2;
wire [0:31] ALU_32bit_sqo_p1;
//For 8 bit
DW02_mult #(8, 8) dwm22(rA_8bit_p1,rA_8bit_p1,0,ALU_8bit_sqo_p1);
DW02_mult #(8, 8) dwm23(rA_8bit_p2,rA_8bit_p2,0,ALU_8bit_sqo_p2);
DW02_mult #(8, 8) dwm24(rA_8bit_p3,rA_8bit_p3,0,ALU_8bit_sqo_p3);
DW02_mult #(8, 8) dwm25(rA_8bit_p4,rA_8bit_p4,0,ALU_8bit_sqo_p4);
//For 16  bit
DW02_mult #(16, 16) dwm26(rA_16bit_p1,rA_16bit_p1,0,ALU_16bit_sqo_p1);
DW02_mult #(16, 16) dwm27(rA_16bit_p2,rA_16bit_p2,0,ALU_16bit_sqo_p2);
//For 32 bit
DW02_mult #(32, 32) dwm28(rA_32bit_p1,rA_32bit_p1,0,ALU_32bit_sqo_p1);



//***Square Root***
//For 8 16 32 64 bits

wire [0:3] ALU_8bit_sqrt_p1, ALU_8bit_sqrt_p2, ALU_8bit_sqrt_p3, ALU_8bit_sqrt_p4, ALU_8bit_sqrt_p5, ALU_8bit_sqrt_p6, ALU_8bit_sqrtv_p7, ALU_8bit_sqrt_p8;
wire [0:7] ALU_16bit_sqrt_p1, ALU_16bit_sqrt_p2, ALU_16bit_sqrt_p3, ALU_16bit_sqrt_p4;
wire [0:15] ALU_32bit_sqrt_p1, ALU_32bit_sqrt_p2;
wire [0:31] ALU_64bit_sqrt_p1;		//According to module root width
//For 8 bit
DW_sqrt #(8, 0) dwsq1(rA_8bit_p1, ALU_8bit_sqrt_p1);
DW_sqrt #(8, 0) dwsq2(rA_8bit_p2, ALU_8bit_sqrt_p2);
DW_sqrt #(8, 0) dwsq3(rA_8bit_p3, ALU_8bit_sqrt_p3);
DW_sqrt #(8, 0) dwsq4(rA_8bit_p4, ALU_8bit_sqrt_p4);
DW_sqrt #(8, 0) dwsq5(rA_8bit_p5, ALU_8bit_sqrt_p5);
DW_sqrt #(8, 0) dwsq6(rA_8bit_p6, ALU_8bit_sqrt_p6);
DW_sqrt #(8, 0) dwsq7(rA_8bit_p7, ALU_8bit_sqrt_p7);
DW_sqrt #(8, 0) dwsq8(rA_8bit_p8, ALU_8bit_sqrt_p8);
//For 16 bit
DW_sqrt #(16, 0) dwsq9(rA_16bit_p1, ALU_16bit_sqrt_p1);
DW_sqrt #(16, 0) dwsq10(rA_16bit_p2, ALU_16bit_sqrt_p2);
DW_sqrt #(16, 0) dwsq11(rA_16bit_p3, ALU_16bit_sqrt_p3);
DW_sqrt #(16, 0) dwsq12(rA_16bit_p4, ALU_16bit_sqrt_p4);
//For 32 bit
DW_sqrt #(32, 0) dw_sqrt13(rA_32bit_p1, ALU_32bit_sqrt_p1);	
DW_sqrt #(32, 0) dw_sqrt14(rA_32bit_p2, ALU_32bit_sqrt_p2);
//For 64 bit
DW_sqrt #(64, 0) dw_sqrt15(rA_64bit_p1, ALU_64bit_sqrt_p1);






//***
//For 8 16 32 64
wire [0:7] ALU_8bit_shift_p1, ALU_8bit_shift_p2, ALU_8bit_shift_p3, ALU_8bit_shift_p4, ALU_8bit_shift_p5, ALU_8bit_shift_p6, ALU_8bit_shift_p7, ALU_8bit_shift_p8;
wire [0:15] ALU_16bit_shift_p1, ALU_16bit_shift_p2, ALU_16bit_shift_p3, ALU_16bit_shift_p4;
wire [0:31] ALU_32bit_shift_p1, ALU_32bit_shift_p2;
wire [0:63] ALU_64bit_shift_p1;


reg [0:2]amt_to_shift_8b_p1, amt_to_shift_8b_p2, amt_to_shift_8b_p3, amt_to_shift_8b_p4, amt_to_shift_8b_p5, amt_to_shift_8b_p6, amt_to_shift_8b_p7, amt_to_shift_8b_p8;
reg [0:3]amt_to_shift_16b_p1, amt_to_shift_16b_p2, amt_to_shift_16b_p3, amt_to_shift_16b_p4;
reg [0:4]amt_to_shift_32b_p1;
reg [0:4]amt_to_shift_32b_p2;
reg [0:5]amt_to_shift;

//FOr 8 bit
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift1(rA_8bit_p1, 0,(~((~amt_to_shift_8b_p1) + 1)), 0, 1, ALU_8bit_shift_p1);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift2(rA_8bit_p2, 0, (~((~amt_to_shift_8b_p2) + 1)), 0, 1, ALU_8bit_shift_p2);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift3(rA_8bit_p3, 0, (~((~amt_to_shift_8b_p3) + 1)), 0, 1, ALU_8bit_shift_p3);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift4(rA_8bit_p4, 0, (~((~amt_to_shift_8b_p4) + 1)), 0, 1, ALU_8bit_shift_p4);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift5(rA_8bit_p5, 0, (~((~amt_to_shift_8b_p5) + 1)), 0, 1, ALU_8bit_shift_p5);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift6(rA_8bit_p6, 0, (~((~amt_to_shift_8b_p6) + 1)), 0, 1, ALU_8bit_shift_p6);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift7(rA_8bit_p7, 0, (~((~amt_to_shift_8b_p7) + 1)), 0, 1, ALU_8bit_shift_p7);
DW_shifter #(.data_width(8), .sh_width(3), .inv_mode(2)) dwshift8(rA_8bit_p8, 0, (~((~amt_to_shift_8b_p8) + 1)), 0, 1, ALU_8bit_shift_p8);

//For 16 bit

DW_shifter #(.data_width(16), .sh_width(4), .inv_mode(2)) dwshift9(rA_16bit_p1, 0, (~((~amt_to_shift_16b_p1) + 1)), 0, 1, ALU_16bit_shift_p1);
DW_shifter #(.data_width(16), .sh_width(4), .inv_mode(2)) dwshift10(rA_16bit_p2, 0, (~((~amt_to_shift_16b_p2) + 1)), 0, 1, ALU_16bit_shift_p2);
DW_shifter #(.data_width(16), .sh_width(4), .inv_mode(2)) dwshift11(rA_16bit_p3, 0, (~((~amt_to_shift_16b_p3) + 1)), 0, 1, ALU_16bit_shift_p3);
DW_shifter #(.data_width(16), .sh_width(4), .inv_mode(2)) dwshift12(rA_16bit_p4, 0, (~((~amt_to_shift_16b_p4) + 1)), 0, 1, ALU_16bit_shift_p4);


//For 32 bit

DW_shifter #(.data_width(32), .sh_width(5), .inv_mode(2)) dwshift13(rA_32bit_p1, 0, (~((~amt_to_shift_32b_p1) + 1)), 0, 1, ALU_32bit_shift_p1);
DW_shifter #(.data_width(32), .sh_width(5), .inv_mode(2)) dwshift14(rA_32bit_p2, 0, (~((~amt_to_shift_32b_p2) + 1)), 0, 1, ALU_32bit_shift_p2);

//For 64 bit


DW_shifter #(.data_width(64), .sh_width(6), .inv_mode(2)) dwshift15(rA_64bit_p1, 0, (~((~amt_to_shift) + 1)), 0, 1, ALU_64bit_shift_p1); //8 bit with rB
//101010 shift by 42, 22 010110
//110110 shift by 54, 10 001010 
//011111 shift by 31, 33 100001
//therefore 42xor111111 + 1?
//54xor111111+1?
//31xor111111+1??????
//DO THIS FOR ALL
//Therefore sh should be rB[27:31] xor 11111 + 1 (for 32 bit). Do similar for 8, 16, 64. Enjoy!!



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
									rB_32bit_p1 = rB_64bit_val[0:31];
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


				VSUB: begin											
				//case(ID_EX_Instr[24:25])						//Depending on WW field					//Check if to add designware module for 2's complement, also check if carry is discarded?????
				case(WW)	
					Width_8:	begin
							//	DW01_add dwadder(A,B,CI,SUM,CO);
									rA_8bit_p1 = rA_64bit_val[0:7];
									rB_8bit_p1 = rB_64bit_val[0:7];
									ALU_out[0:7] = ALU_8bit_sub_p1;

									rA_8bit_p2 = rA_64bit_val[8:15];
									rB_8bit_p2 = rB_64bit_val[8:15];
									ALU_out[8:15] = ALU_8bit_sub_p2;

									rA_8bit_p3 = rA_64bit_val[16:23];
									rB_8bit_p3 = rB_64bit_val[16:23];
									ALU_out[16:23] = ALU_8bit_sub_p3;

									rA_8bit_p4 = rA_64bit_val[24:31];
									rB_8bit_p4 = rB_64bit_val[24:31];
									ALU_out[24:31] = ALU_8bit_sub_p4;

									rA_8bit_p5 = rA_64bit_val[32:39];
									rB_8bit_p5 = rB_64bit_val[32:39];
									ALU_out[32:39] = ALU_8bit_sub_p5;

									rA_8bit_p6 = rA_64bit_val[40:47];
									rB_8bit_p6 = rB_64bit_val[40:47];
									ALU_out[40:47] = ALU_8bit_sub_p6;

									rA_8bit_p7 = rA_64bit_val[48:55];
									rB_8bit_p7 = rB_64bit_val[48:55];
									ALU_out[48:55] = ALU_8bit_sub_p7;

									rA_8bit_p8 = rA_64bit_val[56:63];
									rB_8bit_p8 = rB_64bit_val[56:63];
									ALU_out[56:63] = ALU_8bit_sub_p8;
					end

					Width_16:	begin
									rA_16bit_p1 = rA_64bit_val[0:15];
									rB_16bit_p1 = rB_64bit_val[0:15];
									ALU_out[0:15] = ALU_16bit_sub_p1;

									rA_16bit_p2 = rA_64bit_val[16:31];
									rB_16bit_p2 = rB_64bit_val[16:31];
									ALU_out[16:31] = ALU_16bit_sub_p2;

									rA_16bit_p3 = rA_64bit_val[32:47];
									rB_16bit_p3 = rB_64bit_val[32:47];
									ALU_out[32:47] = ALU_16bit_sub_p3;

									rA_16bit_p4 = rA_64bit_val[48:63];
									rB_16bit_p4 = rB_64bit_val[48:63];
									ALU_out[48:63] = ALU_16bit_sub_p4;
					end

					Width_32:  begin
									rA_32bit_p1 = rA_64bit_val[0:31];
									rB_32bit_p1 = rB_64bit_val[0:31];
									ALU_out[0:31] = ALU_32bit_sub_p1;

									rA_32bit_p2 = rA_64bit_val[32:63];
									rB_32bit_p2 = rB_64bit_val[32:63];
									ALU_out[32:63] = ALU_32bit_sub_p2;
							
					end

					Width_64:	begin
									rA_64bit_p1 = rA_64bit_val[0:63];
									rB_64bit_p1 = rB_64bit_val[0:63];
									ALU_out[0:63] = ALU_64bit_sub_p1;
					end
					
				endcase
			end

			VMULEU: begin
			//	case(ID_EX_Instr[24:25])
				case(WW)
					Width_8:    begin
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
						ALU_out[0:15] = ALU_8bit_mult_odd_p1;

						rA_8bit_p2 = rA_64bit_val[24:31];
						rB_8bit_p2 = rB_64bit_val[24:31];
						ALU_out[16:31] = ALU_8bit_mult_odd_p2;

						rA_8bit_p3 = rA_64bit_val[40:47];
						rB_8bit_p3 = rB_64bit_val[40:47];
						ALU_out[32:47] = ALU_8bit_mult_odd_p3;

						rA_8bit_p4 = rA_64bit_val[55:63];
						rB_8bit_p4 = rB_64bit_val[55:63];
						ALU_out[48:63] = ALU_8bit_mult_odd_p4;

					end

					Width_16:	begin

						rA_16bit_p1 = rA_64bit_val[16:31];
						rB_16bit_p1 = rB_64bit_val[16:31];
						ALU_out[0:31] = ALU_16bit_mult_odd_p1;

						rA_16bit_p2 = rA_64bit_val[48:63];
						rB_16bit_p2 = rB_64bit_val[48:63];
						ALU_out[32:63] = ALU_16bit_mult_odd_p2;
					end

					Width_32:  begin
						rA_32bit_p1 = rA_64bit_val[32:63];
						rB_32bit_p1 = rB_64bit_val[32:63];
						ALU_out[0:63] = ALU_32bit_mult_odd_p1;
					end
				
				endcase
				
			end



					
			VSLL: begin
				case(WW)
					Width_8: begin
						ALU_out[0:7] =  rA_64bit_val[0:7]  << rB_64bit_val[5:7];	  //Left  shift by  3 bits as width is 8 bits
						ALU_out[8:15] =  rA_64bit_val[8:15]  << rB_64bit_val[13:15];
						ALU_out[16:23] =  rA_64bit_val[16:23]  << rB_64bit_val[21:23];
						ALU_out[24:31] =  rA_64bit_val[24:31]  << rB_64bit_val[29:31];
						ALU_out[32:39] =  rA_64bit_val[32:39]  << rB_64bit_val[37:39];
						ALU_out[40:47] =  rA_64bit_val[40:47]  << rB_64bit_val[45:47];
						ALU_out[48:55] =  rA_64bit_val[48:55]  << rB_64bit_val[53:55];
						ALU_out[56:63] =  rA_64bit_val[56:63]  << rB_64bit_val[61:63];
					end

					Width_16: begin
						ALU_out[0:15] =  rA_64bit_val[0:15]  << rB_64bit_val[12:15];	  //Left  shift by  4 bits as width is 16 bits
						ALU_out[16:31] =  rA_64bit_val[16:31]  << rB_64bit_val[28:31];
						ALU_out[32:47] =  rA_64bit_val[32:47]  << rB_64bit_val[44:47];
						ALU_out[48:63] =  rA_64bit_val[48:63]  << rB_64bit_val[60:63];
						
					end

					Width_32: begin
						ALU_out[0:31] =  rA_64bit_val[0:31]  << rB_64bit_val[27:31];		//Left  shift by  5 bits as width is 32 bits
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
						ALU_out[0:7] =  rA_64bit_val[0:7]  >> rB_64bit_val[5:7];	  //Right shift by  3 bits as width is 8 bits
						ALU_out[8:15] =  rA_64bit_val[8:15]  >> rB_64bit_val[13:15];
						ALU_out[16:23] =  rA_64bit_val[16:23]  >> rB_64bit_val[21:23];
						ALU_out[24:31] =  rA_64bit_val[24:31]  >> rB_64bit_val[29:31];
						ALU_out[32:39] =  rA_64bit_val[32:39]  >> rB_64bit_val[37:39];
						ALU_out[40:47] =  rA_64bit_val[40:47]  >> rB_64bit_val[45:47];
						ALU_out[48:55] =  rA_64bit_val[48:55]  >> rB_64bit_val[53:55];
						ALU_out[56:63] =  rA_64bit_val[56:63]  >> rB_64bit_val[61:63];
					end

					Width_16: begin
						ALU_out[0:15] =  rA_64bit_val[0:15]  >> rB_64bit_val[12:15];	  //Right shift by 4 bits as width is 16 bits
						ALU_out[16:31] =  rA_64bit_val[16:31]  >> rB_64bit_val[28:31];
						ALU_out[32:47] =  rA_64bit_val[32:47]  >> rB_64bit_val[44:47];
						ALU_out[48:63] =  rA_64bit_val[48:63]  >> rB_64bit_val[60:63];
					end

					Width_32: begin
						ALU_out[0:31] =  rA_64bit_val[0:31]  >> rB_64bit_val[27:31];		//Right shift by  5 bits as width is 32 bits
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
					//	DW_shifter(data_in, data_tc, sh, sh_tc, sh_mode, data_out);
						rA_8bit_p1 = rA_64bit_val[0:7];
						amt_to_shift_8b_p1 = rB_64bit_val[5:7];
						ALU_out[0:7] = ALU_8bit_shift_p1;

						rA_8bit_p2 = rA_64bit_val[8:15];
						amt_to_shift_8b_p2 = rB_64bit_val[13:15];
						ALU_out[8:15] = ALU_8bit_shift_p2;

						rA_8bit_p3 = rA_64bit_val[16:23];
						amt_to_shift_8b_p3 = rB_64bit_val[21:23];
						ALU_out[16:23] = ALU_8bit_shift_p3;

						rA_8bit_p4 = rA_64bit_val[24:31];
						amt_to_shift_8b_p4 = rB_64bit_val[29:31];
						ALU_out[24:31] = ALU_8bit_shift_p4;

						rA_8bit_p5 = rA_64bit_val[32:39];
						amt_to_shift_8b_p5 = rB_64bit_val[37:39];
						ALU_out[32:39] = ALU_8bit_shift_p5;

						rA_8bit_p6 = rA_64bit_val[40:47];
						amt_to_shift_8b_p6 = rB_64bit_val[45:47];
						ALU_out[40:47] = ALU_8bit_shift_p6;

						rA_8bit_p7 = rA_64bit_val[48:55];
						amt_to_shift_8b_p7 = rB_64bit_val[53:55];
						ALU_out[48:55] = ALU_8bit_shift_p7;

						rA_8bit_p8 = rA_64bit_val[56:63];
						amt_to_shift_8b_p8 = rB_64bit_val[61:63];
						ALU_out[56:63] = ALU_8bit_shift_p8;
					end

					Width_16: begin
						rA_16bit_p1 = rA_64bit_val[0:15];
						amt_to_shift_16b_p1 = rB_64bit_val[12:15];
						ALU_out[0:15] = ALU_16bit_shift_p1;

						rA_16bit_p2 = rA_64bit_val[16:31];
						amt_to_shift_16b_p2 = rB_64bit_val[28:31];
						ALU_out[16:31] = ALU_16bit_shift_p2;

						rA_16bit_p3 = rA_64bit_val[32:47];
						amt_to_shift_16b_p3 = rB_64bit_val[44:47];
						ALU_out[32:47] =ALU_16bit_shift_p3;

						rA_16bit_p4 = rA_64bit_val[48:63];
						amt_to_shift_16b_p4 = rB_64bit_val[60:63];
						ALU_out[48:63] = ALU_16bit_shift_p4;
					end

					Width_32: begin
						rA_32bit_p1 = rA_64bit_val[0:31];
					//	amt_to_shift_32b_p1 = 5'b00101;
						amt_to_shift_32b_p1 = rB_64bit_val[27:31];
						ALU_out[0:31] = ALU_32bit_shift_p1;

						rA_32bit_p2 = rA_64bit_val[32:63];
						amt_to_shift_32b_p2 = rB_64bit_val[59:63];
						ALU_out[32:63] = ALU_32bit_shift_p2;

					end

					Width_64:  begin
						rA_64bit_p1 = rA_64bit_val[0:63];
						amt_to_shift = rB_64bit_val[58:63];
						ALU_out[0:63] = ALU_64bit_shift_p1;
						
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


		VDIV: begin				//USE DESIGNWARE and divide by 0 condition pending
				//case(ID_EX_Instr[24:25])
				case(WW)


					Width_8: 	begin
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
					end
				/*	Width_8: 	begin
							//	DW_div dwdivision(a, b, quotient, remainder, divide_by_0);

								rA_8bit_p1 = rA_64bit_val[0:7];
								rB_8bit_p1 = rB_64bit_val[0:7];
								ALU_out[0:7] = ALU_8bit_div_p1;

								rA_8bit_p2 = rA_64bit_val[8:15];
								rB_8bit_p2 = rB_64bit_val[8:15];
								ALU_out[8:15] = ALU_8bit_div_p2;

								rA_8bit_p3 = rA_64bit_val[16:23];
								rB_8bit_p3 = rB_64bit_val[16:23];
								ALU_out[16:23] = ALU_8bit_div_p3;

								rA_8bit_p4 = rA_64bit_val[24:31];
								rB_8bit_p4 = rB_64bit_val[24:31];
								ALU_out[24:31] = ALU_8bit_div_p4;

								rA_8bit_p5 = rA_64bit_val[32:39];
								rB_8bit_p5 = rB_64bit_val[32:39];
								ALU_out[32:39] = ALU_8bit_div_p5;

								rA_8bit_p6 = rA_64bit_val[40:47];
								rB_8bit_p6 = rB_64bit_val[40:47];
								ALU_out[40:47] = ALU_8bit_div_p6;

								rA_8bit_p7 = rA_64bit_val[48:55];
								rB_8bit_p7 = rB_64bit_val[48:55];
								ALU_out[48:55] = ALU_8bit_div_p7;

								rA_8bit_p8 = rA_64bit_val[56:63];
								rB_8bit_p8 = rB_64bit_val[56:63];
								ALU_out[56:63] = ALU_8bit_div_p8;
					end
								
					Width_16:	begin

								rA_16bit_p1 = rA_64bit_val[0:15];
								rB_16bit_p1 = rB_64bit_val[0:15];
								ALU_out[0:15] = ALU_16bit_div_p1;

								rA_16bit_p2 = rA_64bit_val[16:31];
								rB_16bit_p2 = rB_64bit_val[16:31];
								ALU_out[16:31] = ALU_16bit_div_p2;

								rA_16bit_p3 = rA_64bit_val[32:47];
								rB_16bit_p3 = rB_64bit_val[32:47];
								ALU_out[32:47] = ALU_16bit_div_p3;

								rA_16bit_p4 = rA_64bit_val[48:63];
								rB_16bit_p4 = rB_64bit_val[48:63];
								ALU_out[48:63] = ALU_16bit_div_p4;

					end
					
					
					
					Width_32:	begin

								rA_32bit_p1 = rA_64bit_val[0:31];
								rB_32bit_p1 = rB_64bit_val[0:31];
								ALU_out[0:31] = ALU_32bit_div_p1;

								rA_32bit_p2 = rA_64bit_val[32:63];
								rB_32bit_p2 = rB_64bit_val[32:63];
								ALU_out[32:63] = ALU_32bit_div_p2;
					end
				
				
					Width_64:	begin

								rA_64bit_p1 = rA_64bit_val[0:63];
								rB_64bit_p1 = rB_64bit_val[0:63];
								ALU_out[0:63] = ALU_64bit_div_p1;
								
					end*/
					
				endcase
				
			end


			VMOD: begin															
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
				case(WW)
					Width_8:   begin

								rA_8bit_p1 = rA_64bit_val[0:7];
								
								ALU_out[0:15] = ALU_8bit_sqe_p1;

								rA_8bit_p2 = rA_64bit_val[16:23];
								
								ALU_out[16:31] = ALU_8bit_sqe_p2;

								rA_8bit_p3 = rA_64bit_val[32:39];
								
								ALU_out[32:47] = ALU_8bit_sqe_p3;

								rA_8bit_p4 = rA_64bit_val[48:54];
								
								ALU_out[48:63] = ALU_8bit_sqe_p4;
					end
								
					
					Width_16: 	begin

								rA_16bit_p1 = rA_64bit_val[0:15];
								
								ALU_out[0:31] = ALU_16bit_sqe_p1;

								rA_16bit_p2 = rA_64bit_val[32:47];
								
								ALU_out[32:63] = ALU_16bit_sqe_p2;

						
					end

					Width_32:	begin

								rA_32bit_p1 = rA_64bit_val[0:31];
								ALU_out[0:63] = ALU_32bit_sqe_p1;
								
					end

				endcase
			end



			VSQOU: begin
				
				case(WW)
					Width_8:	begin


								rA_8bit_p1 = rA_64bit_val[8:15];
								
								ALU_out[0:15] = ALU_8bit_sqo_p1;

								rA_8bit_p2 = rA_64bit_val[24:31];
							
								ALU_out[16:31] = ALU_8bit_sqo_p2;

								rA_8bit_p3 = rA_64bit_val[40:47];
								
								ALU_out[32:47] = ALU_8bit_sqo_p3;

								rA_8bit_p4 = rA_64bit_val[55:63];
								
								ALU_out[48:63] = ALU_8bit_sqo_p4;

					end
					
					Width_16:	begin


								rA_16bit_p1 = rA_64bit_val[16:31];
								
								ALU_out[0:31] = ALU_16bit_sqo_p1;

								rA_16bit_p2 = rA_64bit_val[48:63];
								
								ALU_out[32:63] = ALU_16bit_sqo_p2;
						
					end
								
					Width_32:	begin
								rA_32bit_p1 = rA_64bit_val[32:63];
								
								ALU_out[0:63] = ALU_32bit_sqo_p1;		//Width_64 is not possible as 64x64 multiplication not supported
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
	endcase
end
endmodule