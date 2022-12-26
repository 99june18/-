module display(clk, reset, display_on, c, c_select_o, display_out, done_display_o, 
PE_result, SA_3x3_result, SA_2x2_result);

	input clk; 
	input reset;

  input display_on; // state == S_DISPLAY
  input [7:0] c;
    
  output [3:0] c_select_o;
  output [7:0] display_out;
  output done_display_o;

  output PE_result;
  output SA_3x3_result;
  output SA_2x2_result;

  reg [3:0] c_select, c_select_n;
  reg [7:0] display, display_n;
  reg done_display;

endmodule