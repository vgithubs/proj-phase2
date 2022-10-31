/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP5-5
// Date      : Sat Oct  1 13:39:51 2022
/////////////////////////////////////////////////////////////


module frequency_divider_by3 ( clk, rst, clk_out );
  input clk, rst;
  output clk_out;
  wire   N6, N7, N14, n1, n2, n3, n4, n5, n6, n7, n8;
  wire   [1:0] pos_count;
  wire   [1:0] neg_count;

  DFFPOSX1 pos_count_reg_0_ ( .D(N6), .CLK(clk), .Q(pos_count[0]) );
  DFFPOSX1 pos_count_reg_1_ ( .D(N7), .CLK(clk), .Q(pos_count[1]) );
  DFFNEGX1 neg_count_reg_0_ ( .D(N14), .CLK(clk), .Q(neg_count[0]) );
  DFFNEGX1 neg_count_reg_1_ ( .D(n2), .CLK(clk), .Q(neg_count[1]) );
  OAI21X1 U7 ( .A(neg_count[0]), .B(n3), .C(n8), .Y(clk_out) );
  NOR3X1 U9 ( .A(n4), .B(pos_count[1]), .C(n1), .Y(N7) );
  NOR3X1 U10 ( .A(n4), .B(pos_count[1]), .C(pos_count[0]), .Y(N6) );
  NAND3X1 U11 ( .A(neg_count[0]), .B(n3), .C(rst), .Y(n6) );
  NOR3X1 U12 ( .A(n4), .B(neg_count[1]), .C(neg_count[0]), .Y(N14) );
  BUFX2 U13 ( .A(n6), .Y(n7) );
  AND2X1 U14 ( .A(pos_count[1]), .B(n1), .Y(n5) );
  INVX1 U15 ( .A(n5), .Y(n8) );
  INVX1 U16 ( .A(n7), .Y(n2) );
  INVX1 U17 ( .A(neg_count[1]), .Y(n3) );
  INVX1 U18 ( .A(pos_count[0]), .Y(n1) );
  INVX1 U19 ( .A(rst), .Y(n4) );
endmodule

