module tb_clock;
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

	frequency_divider_by3 freq1(clk,rst,out_clk);
endmodule
