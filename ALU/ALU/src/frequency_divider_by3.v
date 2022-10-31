module frequency_divider_by3(clk,rst, clk_out);
 
input clk;
input rst;
output clk_out;
 
reg [1:0] pos_count, neg_count;
 
always @(posedge clk)
	if (~rst)
		pos_count <=0;
	else if (pos_count ==2'b10) 
		pos_count <= 0;
	else 
		pos_count<= pos_count +1;
 
always @(negedge clk)
	if (~rst)
		neg_count <=0;
	else  if (neg_count == 2'b10) 
		neg_count <= 0;
	else 
		neg_count<= neg_count +1;
 
assign clk_out = ((pos_count == 2'b10) || (neg_count == 2'b10));
endmodule

