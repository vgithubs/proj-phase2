module reg_file(clk, rst, wr_en, ppp, addr_r1, addr_r2, data_r1, data_r2, in_addr, in_data);
 
input clk;
input rst;

//signals for write back
input wr_en;
input [0:2] ppp; //for selective write back as per spec (ppt page 9)
input [0:5] in_addr;
input [0:63] in_data;

input [0:5] addr_r1, addr_r2; //rA rB addresses from instruction

output reg [0:63] data_r1; //rA data
output reg [0:63] data_r2; //rB data

reg [0:63] data_arr [0:31]; //register array

integer i;
 
always @(posedge clk) begin
	data_arr[0] <= 64'd0; // R0 hardcoded
	if(rst) begin //initialising everything to 0
		for(i=1; i<32; i=i+1) begin
			data_arr[i] <= 64'd0;
 		end
	end
	else begin
		if(wr_en && (in_addr != 0)) begin //only write back if address not 0
			case(ppp) //for selective write back as per spec (ppt page 9)
			3'b000: data_arr[in_addr] <= in_data;
			3'b001: data_arr[in_addr][0:31] <= in_data[0:31];
			3'b010: data_arr[in_addr][32:63] <= in_data[32:63];
			3'b011: begin
				data_arr[in_addr][0:7] <= in_data[0:7];
				data_arr[in_addr][16:23] <= in_data[16:23];
				data_arr[in_addr][32:39] <= in_data[32:39];
				data_arr[in_addr][48:55] <= in_data[48:55];
			end
			3'b100: begin
				data_arr[in_addr][8:15] <= in_data[8:15];
				data_arr[in_addr][24:31] <= in_data[24:31];
				data_arr[in_addr][40:47] <= in_data[40:47];
				data_arr[in_addr][56:63] <= in_data[56:63];
			end
			endcase
		end 
	end
end

always @(*) begin
	if(rst) begin
		data_r1 = 64'd0;
		data_r2 = 64'd0;
	end
	else begin //IFRF - Internally Forwarding Register File
		if(wr_en && in_addr == addr_r1) begin
				case(ppp) 
					3'b000: data_r1 = in_data;
					3'b001: begin
						data_r1[0:31] = in_data[0:31];
						data_r1[32:63] = data_arr[in_addr][32:63];
					end
					3'b011: begin
						data_r1[0:7] = in_data[0:7];
						data_r1[8:15] = data_arr[in_addr][8:15];
						data_r1[16:23] = in_data[16:23];
						data_r1[24:31] = data_arr[in_addr][24:31];
						data_r1[32:39] = in_data[32:39];
						data_r1[40:47] = data_arr[in_addr][40:47];
						data_r1[48:55] = in_data[48:55];
						data_r1[56:63] = data_arr[in_addr][56:63];
					end
					3'b100: begin
						data_r1[0:7] = data_arr[in_addr][0:7];
						data_r1[8:15] = in_data[8:15];
						data_r1[16:23] = data_arr[in_addr][16:23];
						data_r1[24:31] = in_data[24:31];
						data_r1[32:39] = data_arr[in_addr][32:39];
						data_r1[40:47] = in_data[40:47];
						data_r1[48:55] = data_arr[in_addr][48:55];
						data_r1[56:63] = in_data[56:63];
					end
					default: data_r1 = in_data;
				endcase
			end
			else
				data_r1 = data_arr[addr_r1];

			if(wr_en && in_addr == addr_r2) begin
				case(ppp) 
					3'b000: data_r2 = in_data;
					3'b001: begin
						data_r2[0:31] = in_data[0:31];
						data_r2[32:63] = data_arr[in_addr][32:63];
					end
					3'b011: begin
						data_r2[0:7] = in_data[0:7];
						data_r2[8:15] = data_arr[in_addr][8:15];
						data_r2[16:23] = in_data[16:23];
						data_r2[24:31] = data_arr[in_addr][24:31];
						data_r2[32:39] = in_data[32:39];
						data_r2[40:47] = data_arr[in_addr][40:47];
						data_r2[48:55] = in_data[48:55];
						data_r2[56:63] = data_arr[in_addr][56:63];
					end
					3'b100: begin
						data_r2[0:7] = data_arr[in_addr][0:7];
						data_r2[8:15] = in_data[8:15];
						data_r2[16:23] = data_arr[in_addr][16:23];
						data_r2[24:31] = in_data[24:31];
						data_r2[32:39] = data_arr[in_addr][32:39];
						data_r2[40:47] = in_data[40:47];
						data_r2[48:55] = data_arr[in_addr][48:55];
						data_r2[56:63] = in_data[56:63];
					end
					default: data_r2 = in_data;
				endcase
			end
			else
				data_r2 = data_arr[addr_r2];
		end
end

endmodule