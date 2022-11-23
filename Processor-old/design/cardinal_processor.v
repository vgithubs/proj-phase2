`include "./include/reg_file.v"
`include "./include/ALU.v"

module cardinal_processor(Clock, Reset, Instr_Addr, Instruction, Mem_Addr, Data_Out, Data_In, DmemEn, DmemWrEn);

input Clock;
input Reset;

//Imem
input [0:31] Instruction;
output [0:7] Instr_Addr;

//Dmem
input [0:63] Data_In;
output [0:63] Data_Out;
output [0:7] Mem_Addr;
output DmemEn, DmemWrEn;

parameter   VAND = 6'b000001, VOR =  6'b000010, VXOR = 6'b000011, VNOT = 6'b000100, VMOV = 6'b000101,					//Instruction op_code depending on INSTR[26:31] bits
			VADD = 6'b000110, VSUB = 6'b000111, VMULEU =   6'b001000, VMULOU = 6'b001001, VSLL = 001010,
			VSRL = 6'b001011, VSRA = 6'b001100, VRTTH = 6'b001101, VDIV = 6'b001110, VMOD = 6'b001111,
			VSQEU = 6'b010000, VSQOU = 6'b010001, VSQRT = 6'b010010, VNOP = 6'b000000;

parameter R_ALU = 6'b101010, LOAD = 6'b100000, STORE = 6'b100001, BRANCH_EZ = 6'b100010, BRANCH_NZ = 6'b100011, NOP = 6'b111100;			//Type of instruction depending on INSTR[0:5] bits

parameter Width_8 = 2'b00, Width_16 = 2'b01, Width_32 = 2'b10, Width_64 = 2'b11;  

// IF stage signals
reg [0:7] PC;
reg [0:31] IF_ID;	//IF ID Stage Register (Incoming Instruction)
reg WBFF; //Wrist band FF for flushing on stall and branch
wire [0:7] PC_next; 
wire [0:7] Next_Addr; //Mux output -> either branch output or PC+1

//ID stage signals
wire flush; //Input to WBFF in IF
wire stall_br; //HDU_Br output
reg stall_lw; //stall the pipeline for a load instr
reg fwd_rA, fwd_rB;// Fu
reg fwd_store;
reg [0:63] ID_EX_rA_rD_data;
reg [0:63] ID_EX_rB_data;
reg [0:29] ID_EX; //[0:4] rD_Addr, [5:9] PPPWW, [10:15] ALU_case, [16:23] Immediate Address, Control Signals (remaining);
//Control signals
//ALU_op - if ALU_op
//Reg_Wr - if write to register in WB
//Mem_Rd - identify load (required for 2 clk stalls)
//Mem_Wr - identify store (load-store dependency check?)
//Branch - identify branch
//Mem_to_Reg - Choosing between ALU_data or Mem_data in WB stage
reg ALU_op, Mem_Rd, Mem_Wr, Branch, Reg_Wr, Mem_to_Reg;
wire BEZ;
wire BNEZ;	

wire [0:7] LD_Mem_Addr, ST_Mem_Addr;

wire [0:63] rA_rD_data, rB_data;	
wire [0:4] rA_rD_addr, rB_addr;				

//EX-MEM stage signals
reg [0:9] EX_WB; // [0:2] ppp, [3:7] rD_Addr, Reg_Wr, Mem_to_Reg;
reg [0:63] EX_WB_mem_data;
reg [0:63] EX_WB_reg_data;
wire [0:63] EX_rA_rD, EX_rB;
wire [0:63] ALU_out;

//WB stage signals
wire [0:63] WB_data; //selection betweeen mem_data and reg_data using Mem_to_Reg
reg [0:63] WB_PPP_rA_rD, WB_PPP_rB; //to forward while taking PPP in consideration

//***

//IF stage
assign PC_next = PC + 1'b1;
assign BEZ = (rA_rD_data == 0);
assign BNEZ = (rA_rD_data != 0);
assign flush = Branch && ((BEZ && (IF_ID[0:5]==BRANCH_EZ)) || (BNEZ && (IF_ID[0:5]==BRANCH_NZ))); //IF_flush
assign Next_Addr = flush ? IF_ID[24:31] : PC_next; //Switch addr on branch

assign Instr_Addr = PC;

always @(posedge Clock) begin
	if(Reset) begin
		WBFF <= 1;
		PC <= 0;
		IF_ID <= 0;
	end
	else begin
		if(!stall_lw && !stall_br) begin
			WBFF <= ~flush;
			PC <= Next_Addr;
			IF_ID <= Instruction;
		end
	end
end

//register file operation
assign rA_rD_addr = (Mem_Wr || Branch) ? IF_ID[6:10] : IF_ID[11:15];
assign rB_addr = IF_ID[16:20];
reg_file rf(.clk(Clock), .rst(Reset), .wr_en(EX_WB[8]), .ppp(EX_WB[0:2]), .addr_r1(rA_rD_addr), .addr_r2(rB_addr), 
	.data_r1(rA_rD_data), .data_r2(rB_data), .in_addr(EX_WB[3:7]), .in_data(WB_data));

//Control logic
always @(*) begin
	//WBFF reset on flush and power on
	if(WBFF) begin
		case(IF_ID[0:5])
			R_ALU: begin
				ALU_op = 1; Mem_Rd = 0; Mem_Wr = 0; Branch = 0; Reg_Wr = 1; Mem_to_Reg = 0;
			end
			LOAD: begin
				ALU_op = 0; Mem_Rd = 1; Mem_Wr = 0; Branch = 0; Reg_Wr = 1; Mem_to_Reg = 1;
			end
			STORE: begin
				ALU_op = 0; Mem_Rd = 0; Mem_Wr = 1; Branch = 0; Reg_Wr = 0; Mem_to_Reg = 0;
			end
			BRANCH_EZ: begin
				ALU_op = 0; Mem_Rd = 0; Mem_Wr = 0; Branch = 1; Reg_Wr = 0; Mem_to_Reg = 0;
			end
			BRANCH_NZ: begin
				ALU_op = 0; Mem_Rd = 0; Mem_Wr = 0; Branch = 1; Reg_Wr = 0; Mem_to_Reg = 0;
			end
			NOP: begin
				ALU_op = 0; Mem_Rd = 0; Mem_Wr = 0; Branch = 0; Reg_Wr = 0; Mem_to_Reg = 0;
			end
			default: begin
				ALU_op = 0; Mem_Rd = 0; Mem_Wr = 0; Branch = 0; Reg_Wr = 0; Mem_to_Reg = 0;
			end
		endcase		
	end
	else begin
		ALU_op = 0; Mem_Rd = 0; Mem_Wr = 0; Branch = 0; Reg_Wr = 0; Mem_to_Reg = 0;
	end
end

//Stall logic
assign stall_br = Branch && (ID_EX[0:4]==IF_ID[6:10]) && (ID_EX[0:4]!=0);

always @(posedge Clock) begin
	if(!stall_lw && Mem_Rd)
		stall_lw <= 1;
	else stall_lw <= 0;
end

//Forwarding logic
always @(posedge Clock) begin
	if(Mem_Wr && (ID_EX[0:4]==IF_ID[6:10]) && (ID_EX[0:4]!=0))
		fwd_store <= 1;
	else fwd_store <= 0;

	if((ID_EX[0:4]==IF_ID[11:15]) && (ID_EX[0:4]!=0))
		fwd_rA <= 1;
	else fwd_rA <= 0;
	if((ID_EX[0:4]==IF_ID[16:20]) && (ID_EX[0:4]!=0))
		fwd_rB <= 1;
	else fwd_rB <= 0;
end

//Load-Store in EX
assign Data_Out = fwd_store ? WB_PPP_rA_rD : ID_EX_rA_rD_data;
assign Mem_Addr = ID_EX[16:23];
assign DmemEn = ID_EX[26] || ID_EX[25];
assign DmemWrEn = ID_EX[26];

//ALU with forwarding (with PPP consideration)
assign EX_rA_rD = fwd_rA ? WB_PPP_rA_rD : ID_EX_rA_rD_data;
assign EX_rB = fwd_rB ? WB_PPP_rB : ID_EX_rB_data;
ALU alu1(.rA_64bit_val(EX_rA_rD), .rB_64bit_val(EX_rB), .R_ins(ID_EX[10:15]), .Op_code(ID_EX[24]), .WW(ID_EX[8:9]), .ALU_out(ALU_out));

always @(*) begin
	case(EX_WB[0:2])
		3'b000: begin
			WB_PPP_rA_rD = WB_data[0:63];

			WB_PPP_rB = WB_data[0:63];
		end
		3'b001: begin
			WB_PPP_rA_rD[0:31] = WB_data[0:31];
			WB_PPP_rA_rD[32:63] = ID_EX_rA_rD_data[32:63];
			
			WB_PPP_rB[0:31] = WB_data[0:31];
			WB_PPP_rB[32:63] = ID_EX_rB_data[32:63];
		end
		3'b010: begin
			WB_PPP_rA_rD[0:31] = ID_EX_rA_rD_data[0:31];
			WB_PPP_rA_rD[32:63] = WB_data[32:63];
			
			WB_PPP_rB[0:31] = ID_EX_rB_data[0:31];
			WB_PPP_rB[32:63] = WB_data[32:63];
		end
		3'b011: begin
			WB_PPP_rA_rD[0:7] = WB_data[0:7];
			WB_PPP_rA_rD[8:15] = ID_EX_rA_rD_data[8:15];
			WB_PPP_rA_rD[16:23] = WB_data[16:23];
			WB_PPP_rA_rD[24:31] = ID_EX_rA_rD_data[24:31];
			WB_PPP_rA_rD[32:39] = WB_data[32:39];
			WB_PPP_rA_rD[40:47] = ID_EX_rA_rD_data[40:47];
			WB_PPP_rA_rD[48:55] = WB_data[48:55];
			WB_PPP_rA_rD[56:63] = ID_EX_rA_rD_data[56:63];

			WB_PPP_rB[0:7] = WB_data[0:7];
			WB_PPP_rB[8:15] = ID_EX_rB_data[8:15];
			WB_PPP_rB[16:23] = WB_data[16:23];
			WB_PPP_rB[24:31] = ID_EX_rB_data[24:31];
			WB_PPP_rB[32:39] = WB_data[32:39];
			WB_PPP_rB[40:47] = ID_EX_rB_data[40:47];
			WB_PPP_rB[48:55] = WB_data[48:55];
			WB_PPP_rB[56:63] = ID_EX_rB_data[56:63];
			
		end
		3'b100: begin
			WB_PPP_rA_rD[0:7] = ID_EX_rA_rD_data[0:7];
			WB_PPP_rA_rD[8:15] = WB_data[8:15];
			WB_PPP_rA_rD[16:23] = ID_EX_rA_rD_data[16:23];
			WB_PPP_rA_rD[24:31] = WB_data[24:31];
			WB_PPP_rA_rD[32:39] = ID_EX_rA_rD_data[32:39];
			WB_PPP_rA_rD[40:47] = WB_data[40:47];
			WB_PPP_rA_rD[48:55] = ID_EX_rA_rD_data[48:55];
			WB_PPP_rA_rD[56:63] = WB_data[56:63];

			WB_PPP_rB[0:7] = ID_EX_rB_data[0:7];
			WB_PPP_rB[8:15] = WB_data[8:15];
			WB_PPP_rB[16:23] = ID_EX_rB_data[16:23];
			WB_PPP_rB[24:31] = WB_data[24:31];
			WB_PPP_rB[32:39] = ID_EX_rB_data[32:39];
			WB_PPP_rB[40:47] = WB_data[40:47];
			WB_PPP_rB[48:55] = ID_EX_rB_data[48:55];
			WB_PPP_rB[56:63] = WB_data[56:63];
		end
		default: begin
			WB_PPP_rA_rD = WB_data;

			WB_PPP_rB = WB_data;
		end
	endcase
end

//Dataflow
assign WB_data = EX_WB[9]? EX_WB_mem_data : EX_WB_reg_data;

always @(posedge Clock) begin
	if(Reset) begin
		ID_EX <= 0;
		ID_EX_rA_rD_data <= 0;
		ID_EX_rB_data <= 0;
		EX_WB <= 0;
		EX_WB_mem_data <= 0;
		EX_WB_reg_data <= 0;
	end
	else begin
		if(~stall_lw) begin
			//EXMEM_WB
				EX_WB <= {ID_EX[5:7], ID_EX[0:4], ID_EX[28:29]}; // [0:2] ppp, [3:7] rD_Addr, Reg_Wr, Mem_to_Reg;
				EX_WB_mem_data <= Data_In;
				EX_WB_reg_data <= ALU_out;
			if(~stall_br) begin
				//ID_EXMEM
				ID_EX <= {IF_ID[6:10], IF_ID[21:25], IF_ID[26:31], IF_ID[24:31], ALU_op, Mem_Rd, Mem_Wr, Branch, Reg_Wr, Mem_to_Reg}; //0:29
				ID_EX_rA_rD_data <= rA_rD_data;
				ID_EX_rB_data <= rB_data;
				
			end
			else begin
				ID_EX <= 30'd0;
				ID_EX_rA_rD_data <= 64'd0;
				ID_EX_rB_data <= 64'd0;
			end
			
		end
	end
end

endmodule