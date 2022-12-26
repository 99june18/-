module top (clk, reset, run, 
a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
b11, b12, b13, b21, b22, b23, b31, b32, b33,
display_o, PE_result, SA_3x3_result, SA_2x2_result);


	input clk; 
	input reset;
	input run;
	input [7:0]
    a11, a12, a13, a14,
    a21, a22, a23, a24,
    a31, a32, a33, a34,
    a41, a42 ,a43, a44;
  input [7:0]
    b11 ,b12, b13,
    b21, b22, b23,
    b31, b32, b33;

  output [7:0] display_o;
  output PE_result;
  output SA_3x3_result;
  output SA_2x2_result;

endmodule