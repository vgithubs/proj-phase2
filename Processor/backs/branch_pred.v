module Branch_Predictor(Clock, Reset, Instruction, Current, pred_actual, Prediction);					

	//parameter bits_for_BPB = 3;			//0 to 8 bits can be used to determine location of BPB
	
	integer i;
    
    
	input Clock, Reset;
	input [0:31] Instruction;
	input [0:1] pred_actual;
	input [0:3] Current;
	output Prediction;	

    wire [0:3] location_number;
    reg Branch_Pred_buffer [0:15];				// 64 locations buffer taking last 6 bits of Instruction

	assign location_number = Instruction[28 : 31];	//Lower bits of PC address to index Branch_Pred_buffe	
	
    assign Prediction = Branch_Pred_buffer[Current];

	always @(posedge Clock) begin
	    if(Reset) begin
			for (i=0; i<16; i=i+1)
				Branch_Pred_buffer[i] <= 1'b1;
		end
		
		else begin
			if (Instruction[0:5] == 6'b100010 || Instruction[0:5] == 6'b100011) begin		//If the instruction is branch then only update the BPB and transfer predicted output
				case(pred_actual)
					2'b01: begin
						Branch_Pred_buffer[location_number] <= 1'b1;					//Case 01: predicted: 0 not taken, actual: 1 taken
					end
					2'b10: begin
						Branch_Pred_buffer[location_number] <= 1'b0;					//Case 10: predicted: 1 taken, actual: 0 not taken
					end
				endcase
			end
        end		
	end
	
	
	
	


endmodule