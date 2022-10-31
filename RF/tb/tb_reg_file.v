module tb_reg_file;
	reg clk;
    reg rst;

    reg wr_en;
	reg [2:0] ppp;
    reg [5:0] in_addr;
    reg [63:0] in_data;

    reg [5:0] addr_r1, addr_r2;

    wire [63:0] data_r1;
    wire [63:0] data_r2;

	reg_file rf1(clk, rst, wr_en, ppp, addr_r1, addr_r2, data_r1, data_r2, in_addr, in_data);
	
	initial
		clk = 1'b0;
	always
		#2 clk = ~clk;
	
    initial begin    
		//$monitor($time,"clk = %b,rst = %b,out_clk = %b",clk,rst,out_clk);
		rst = 0;
		#6 rst = 1;
		#6 rst = 0;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=0; in_addr = 5'd17; ppp = 3'b0;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd17;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd22; addr_r1 = 5'd17; addr_r2 = 5'd22;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd13; ppp = 3'b010; addr_r1 = 5'd13;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd12; ppp = 3'b100;
		#8 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd15; ppp = 3'b0; addr_r1 = 5'd15; addr_r2 = 5'd12;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd9; ppp = 3'b0; addr_r1 = 5'd15; addr_r2 = 5'd9; 
		#20 $finish;
	end
endmodule
