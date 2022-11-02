module cardinal_processor(Clock, Reset, Instr_Addr, Instruction, Mem_Addr, Data_Out, Data_In);

input Clock;
input Reset;

//Imem
input [0:31] Instruction;
output [0:7] Instr_Addr;

//Dmem
input [0:63] Data_In;
output [0:63] Data_Out;
output [0:7] Mem_Addr;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,					//Instruction op_code depending on INSTR[26:31] bits
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =   6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010; BRANCH_NZ = 6'b100011, NOP = 6'b111100;			//Type of instruction depending on INSTR[0:5] bits

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  

// IF stage signals
reg [0:7] PC; 	
reg [0:31] IF_ID;	//IF ID Stage Register (Incoming Instruction)
reg WBFF; //Wrist band FF for flushing on stall and branch
wire [0:7] PC_next; 
wire [0:7] Next_Addr; //Mux output -> either branch output or PC+1
	
//ID stage signals
wire flush; //Input to WBFF in IF
reg stall; //HDU_Br output
reg [0:63] ID_EX_rA_data;
reg [0:63] ID_EX_rB_data;
reg [0:15] ID_EX; //[0:4] rD_Addr, [5:9] PPPWW, [10:15] ALU_case;
	//Control signals
	//ALU_op - if ALU_op
	//Reg_Wr - if write to register in WB
	//Mem_Rd - identify load (required for 2 clk stalls)
	//Mem_Wr - identify store (load-store dependency check?)
	//Branch - identify branch
	//Mem_to_Reg - Choosing between ALU_data or Mem_data in WB stage
	reg ALU_op, Mem_Rd, Mem_Wr, Branch, Reg_Wr, Mem_to_Reg;
reg BEZ;
reg BNEZ;						
reg_file rf(.clk(clock), .rst(reset), .wr_en(EX_MEM[8]), .ppp(IF_ID[21:23]), .addr_r1(IF_ID[11:15]), .addr_r2(IF_ID[16:20]), 
	.data_r1(ID_EX_rA_data), .data_r2(ID_EX_rB_data), .in_addr(EX_MEM[3:7]), .in_data(WB_data));


//EX-MEM stage signals
reg [0:9] EX_MEM; // [0:2] ppp, [3:7] rD_Addr, Reg_Wr, Mem_to_Reg;
reg [0:63] EX_MEM_mem_data;
reg [0:63] EX_MEM_reg_data;

//WB stage signals
reg [0:63] WB_data; //selection betweeen mem_data and reg_data using Mem_to_Reg



//ID stage
assign ID_EX_A = reg_file[IF_ID_Instr[11:15]];
assign ID_EX_B = reg_file[IF_ID_Instr[16:20]];

assign ID_EX_BEZ_Comp = (IF_ID_Instr[0:5] == BRANCH_EZ) && (IF_ID_Instr[11:15] == 0);			//If Branch instruction indicated by Instruction bits 0 to 5 and if RA = 5'b00000

assign ID_EX_BNEZ_Comp = (IF_ID_Instr[0:5] == BRANCH_NZ) && (IF_ID_Instr[11:15] == 1);

assign ID_EX_branch_Comp = ID_EX_BEZ_Comp || ID_EX_BNEZ_Comp;




//IF stage																		
assign PC_next = PC + 1'b1;														
assign mux_PC_out = ID_EX_branch_Comp ? ID_EX_branch_addr : IF_ID_PC;		//Mux to select next instruction PC + 4 or the address from BEZ







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

		ID_EX_Instr <= IF_ID_Instr;
		ID_EX_BEZ_Comp <= (ID_EX_A == 0);
		ID_EX_Imm  <= {{16[IF_ID_Instr[16]}, {IF_ID_Instr[16:31]}};		//Sign extend for immediate address to be used in EX stage for LOAD, STORE, BRANCH
		
		end
	
	end
	
end
endmodule