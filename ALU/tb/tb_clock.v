/*module tb_clock;
	reg clk;
	reg rst;
	wire out_clk;

	initial
		clk = 1'b0;
	always
		#2.5 clk = ~clk;
	initial begin
		$monitor($time,"clk = %b,rst = %b,out_clk = %b",clk,rst,out_clk);
		rst =0;
		#5 rst =1;
		#20 $finish;
	end

	frequency_divider_by3 freq1(cl,rst,out_clk);
endmodule
*/

module tb_ALU;
	reg ID_EX_Instr;
	wire ALU_out;

	ALU alu_ex(ID_EX_Instr, ALU_out);

	initial begin
		$monitor($time,"ID_EX_Instr = %b, ALU_out = %b",ID_EX_Instr, ALU_out);
		
		//VAND
		101010 rD rA rB 000WW 000001										

		#20 $finish;
	end
endmodule