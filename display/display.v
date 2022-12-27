module display(clk, reset, run_display, result, addr_result_o, display_out, done_display_o, 
PE_result, SA_3x3_result, SA_2x2_result);

	input clk; 
	input reset;

  input run_display; // state == S_DISPLAY
  input [7:0] result;
    
  output [3:0] addr_result_o;
  output [7:0] display_out;
  output done_display_o;

  output PE_result;
  output SA_3x3_result;
  output SA_2x2_result;

  reg [3:0] addr_result, n_addr_result;
  reg [7:0] display, n_display;
  reg done_display;

  reg [7:0] display_memory [0:11];

endmodule