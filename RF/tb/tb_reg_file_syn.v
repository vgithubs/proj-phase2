`include "./include/gscl45nm.v"

module tb_reg_file_syn;
	reg clk;
    reg rst;

    reg wr_en;
    reg [5:0] in_addr;
    reg [63:0] in_data;

    reg [5:0] addr_r1, addr_r2;

    wire [63:0] data_r1;
    wire [63:0] data_r2;

	reg_file rf1 (clk, rst, wr_en, addr_r1, addr_r2, data_r1, data_r2, in_addr, in_data);
	
	initial
		clk = 1'b0;
	always
		#2 clk = ~clk;
	
    initial begin    
		//$monitor($time,"clk = %b,rst = %b,out_clk = %b",clk,rst,out_clk);
		rst = 0;
		#6 rst = 1;
		#6 rst = 0;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=0; in_addr = 5'd17;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd17;
		#4 in_data[31:0]=$random; in_data[63:32]=$random; wr_en=1; in_addr = 5'd22; addr_r1 = 5'd17; addr_r2 = 5'd22;
		#20 $finish;
	end

	initial begin
		$sdf_annotate("./netlist/reg_file_syn.sdf", rf1,,"sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");	//http://www.pldworld.com/_hdl/2/_ref/se_html/manual_html/c_sdf10.html
		$enable_warnings;
		$log("ncsim.log");
	end
endmodule
