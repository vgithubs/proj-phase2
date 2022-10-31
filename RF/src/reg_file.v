module reg_file(clk, rst, wr_en, addr_r1, addr_r2, data_r1, data_r2, in_addr, in_data);
 
input clk;
input rst;

input wr_en;
input [5:0] in_addr;
input [63:0] in_data;

input [5:0] addr_r1, addr_r2;

output reg [63:0] data_r1;
output reg [63:0] data_r2;

reg [63:0] data_arr [31:0];

integer i;
 
always @(posedge clk) begin
	data_arr[0] <= 64'd0;
	if(rst) begin
		for(i=1; i<32; i=i+1) begin
			data_arr[i] <= 64'd0;
 		end
	end
	else begin
		if(wr_en) begin
			data_arr[in_addr] <= in_data;
		end 
	end
end

always @(*) begin
	if(rst) begin
		data_r1 = 64'd0;
		data_r2 = 64'd0;
	end
	else begin
		data_r1 = data_arr[addr_r1];
		data_r2 = data_arr[addr_r2];
	end
end

endmodule