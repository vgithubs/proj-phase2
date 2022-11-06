////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2002 - 2016 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    RPH             Aug 2002
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: cd0d09e3
// DesignWare_release: K-2015.06-DWBB_201506.5.2
//
////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------
//
// ABSTRACT:  Boundary Scan Cell Type WC_S1_S
//
//           
//  Input Parameters:   value   Description
//  =========== 	====    ===========
//  rst_mode            0 to 3  0 - FFs have no set or reset
//                              1 - FFs with reset
//                              2 - FFs with set
//                              3 - FFs with both set and reset
//              
//  Input Ports:   	Size    Description
//  =========== 	====    ===========
//  shift_clk           1 bit   shift clock

//  rst_n               1 bit   active low reset    
//  shift_en            1 bit   shift enable
//  capture_en          1 bit   Capture enable
//  safe_control        1 bit   Safe control
    
//  safe_value          1 bit   Safe value  
//  cfi                 1 bit    
//  cti                 1 bit    
//  
//  Output Ports    	Size    Description
//  ============	====    ===========
//  cfo                 1 bit
//  cfo_n               1 bit
//  cto             	1 bit    
//              
//              
//
//
// MODIFIED: 
//
//      LMSU    02/03/2016 
//              Eliminated function calling from sequential always block in
//              order for NLP tool to correctly infer FFs
//
//	RJK	6/23/2011
//		Added toggle_state input as requested by DFT team
//
module DW_wc_s1_s (shift_clk, rst_n, set_n, shift_en, capture_en, safe_control, 
		   safe_value, cti, cfi, cfo, cfo_n, cto, toggle_state );
   
   parameter rst_mode = 0;

   input  shift_clk;

   input  rst_n;
   input  set_n;
   
   input  shift_en;
   input  capture_en;
   input  safe_control;
   input  safe_value;
   input  cti;
   input  cfi;
   
   output cfo;   
   output cfo_n;
   output cto;

   input  toggle_state;

   // synopsys translate_off

   reg 	  temp_cto;
   wire	  temp_cti;

   assign temp_cti = (shift_en === 1'b1) ? (cti | (cti ^ cti)) :
		     (shift_en === 1'b0) ? temp_cto ^ toggle_state :
		     1'bX;
   assign cfo = (safe_control === 1'b1 ) ? (safe_value | (safe_value ^ safe_value)) :
		(safe_control === 1'b0 ) ? temp_cto : 
		1'bX;
   assign cfo_n = (safe_control === 1'b1 ) ? (~safe_value | (~safe_value ^ ~safe_value)) :
		  (safe_control === 1'b0 ) ? ~temp_cto : 
		  1'bX;
   assign cto = temp_cto;

   generate if (rst_mode==0) begin : GEN_RM_EQ_0
     always @(posedge shift_clk) begin : SHIFT_PROC
       if (capture_en === 1'b0)
         temp_cto <= (cfi | (cfi ^ cfi));
       else if (capture_en === 1'b1)
         temp_cto <= temp_cti;
       else
         temp_cto <= 1'bX;
     end // block: SHIFT_PROC
   end endgenerate

   generate if (rst_mode==1) begin : GEN_RM_EQ_1
     always @(posedge shift_clk or negedge rst_n) begin : SHIFT_PROC
       if (rst_n === 1'b0)
         temp_cto <= 1'b0;
       else begin
         if (capture_en === 1'b0)
           temp_cto <= (cfi | (cfi ^ cfi));
         else if (capture_en === 1'b1)
           temp_cto <= temp_cti;
         else
           temp_cto <= 1'bX;
       end
     end // block: SHIFT_PROC
   end endgenerate

   generate if (rst_mode==2) begin : GEN_RM_EQ_2
     always @(posedge shift_clk or negedge set_n) begin : SHIFT_PROC
       if (set_n === 1'b0)
         temp_cto <= 1'b1;
       else begin
         if (capture_en === 1'b0)
           temp_cto <= (cfi | (cfi ^ cfi));
         else if (capture_en === 1'b1)
           temp_cto <= temp_cti;
         else
           temp_cto <= 1'bX;
       end
     end // block: SHIFT_PROC
   end endgenerate

   generate if (rst_mode==3) begin : GEN_RM_EQ_3
     // chkSEQver-pragma allow_3_triggers
     always @(posedge shift_clk or negedge rst_n or negedge set_n) begin : SHIFT_PROC
       if (rst_n === 1'b0)
         temp_cto <= 1'b0;
       else if (set_n === 1'b0)
         temp_cto <= 1'b1;
       else begin
         if (capture_en === 1'b0)
           temp_cto <= (cfi | (cfi ^ cfi));
         else if (capture_en === 1'b1)
           temp_cto <= temp_cti;
         else
           temp_cto <= 1'bX;
       end
     end // block: SHIFT_PROC
   end endgenerate

  //---------------------------------------------------------------------------
  // Parameter legality check
  //---------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if ( (rst_mode < 0) || (rst_mode > 3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter rst_mode (legal range: 0 to 3)",
	rst_mode );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


  //---------------------------------------------------------------------------
  // Report unknown clock inputs
  //---------------------------------------------------------------------------
  
  always @ (shift_clk) begin : clk_monitor 
    if ( (shift_clk !== 1'b0) && (shift_clk !== 1'b1) && ($time > 0) )
      $display( "WARNING: %m :\n  at time = %t, detected unknown value, %b, on shift_clk input.",
                $time, shift_clk );
    end // clk_monitor   
   // synopsys translate_on 
   
endmodule // DW_wc_s1_s

	 
