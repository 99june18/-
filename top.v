module top (clk, reset, run, 
a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
b11, b12, b13, b21, b22, b23, b31, b32, b33,
display_result, display_current_state);


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

  output [7:0] display_result;
  output [2:0] display_current_state;


	wire  [7:0] c11,c12,
                c21,c22;

	wire done_capture;
	wire done_send;
	wire done_PE;
	wire done_SA_3x3;
	wire done_SA_2x2;
	wire [2:0] current_display;

	wire state_idle;
	wire state_capture;
	wire state_send;
	wire state_PE;
	wire state_SA_3x3;
	wire state_SA_2x2;
	wire state_display;

controller u_controller(
    .clk          ( clk          ),
    .reset          ( reset          ),
    .run         ( run         ),
    .done_capture    ( done_capture    ),
    .done_send    ( done_send    ),
    .done_PE ( done_PE  ),
    .done_SA_3x3    ( done_SA_3x3    ),
    .done_SA_2x2    ( done_SA_2x2    ),
    .current_display ( current_display ),
    .state_idle   ( state_idle   ),
    .state_capture  ( state_capture  ),
    .state_send   ( state_send   ),
    .state_PE ( state_PE ),
    .state_SA_3x3   ( state_SA_3x3   ),
    .state_SA_2x2   ( state_SA_2x2   ),
    .state_display ( state_display )
    );

  wire [7:0]
    a11_o, a12_o, a13_o, a14_o,
    a21_o, a22_o, a23_o, a24_o,
    a31_o, a32_o, a33_o, a34_o,
    a41_o, a42_o, a43_o, a44_o;
  wire [7:0]
    b11_o, b12_o, b13_o, 
    b21_o, b22_o, b23_o, 
    b31_o, b32_o, b33_o;

  wire [7:0] 
    c11_PE, c12_PE, 
    c21_PE, c22_PE;
  wire [7:0]
    c11_3x3, c12_3x3,
    c21_3x3, c22_3x3;
  wire [7:0]
    c11_2x2, c12_2x2,
    c21_2x2, c22_2x2;
memory u_memory(
    .clk                     ( clk                     ),
    .reset                     ( reset                     ),
    .run_valid_i            ( state_capture            ),
    .a11                     ( a11                     ),
    .a12                     ( a12                     ),
    .a13                     ( a13                     ),
    .a14                     ( a14                     ),
    .a21                     ( a21                     ),
    .a22                     ( a22                     ),
    .a23                     ( a23                     ),
    .a24                     ( a24                     ),
    .a31                     ( a31                     ),
    .a32                     ( a32                     ),
    .a33                     ( a33                     ),
    .a34                     ( a34                     ),
    .a41                     ( a41                     ),
    .a42                     ( a42                     ),
    .a43                     ( a43                     ),
    .a44                     ( a44                     ),
    .b11                     ( b11                     ),
    .b12                     ( b12                     ),
    .b13                     ( b13                     ),
    .b21                     ( b21                     ),
    .b22                     ( b22                     ),
    .b23                     ( b23                     ),
    .b31                     ( b31                     ),
    .b32                     ( b32                     ),
    .b33                     ( b33                     ),
    .a11_o                     ( a11_o                     ),
    .a12_o                     ( a12_o                     ),
    .a13_o                     ( a13_o                     ),
    .a14_o                     ( a14_o                     ),
    .a21_o                     ( a21_o                     ),
    .a22_o                     ( a22_o                     ),
    .a23_o                     ( a23_o                     ),
    .a24_o                     ( a24_o                     ),
    .a31_o                     ( a31_o                     ),
    .a32_o                     ( a32_o                     ),
    .a33_o                     ( a33_o                     ),
    .a34_o                     ( a34_o                     ),
    .a41_o                     ( a41_o                     ),
    .a42_o                     ( a42_o                     ),
    .a43_o                     ( a43_o                     ),
    .a44_o                     ( a44_o                     ),
    .b11_o                     ( b11_o                     ),
    .b12_o                     ( b12_o                     ),
    .b13_o                     ( b13_o                     ),
    .b21_o                     ( b21_o                     ),
    .b22_o                     ( b22_o                     ),
    .b23_o                     ( b23_o                     ),
    .b31_o                     ( b31_o                     ),
    .b32_o                     ( b32_o                     ),
    .b33_o                     ( b33_o                     ),
    .PE_valid_i          ( state_PE          ),
    .SA_3x3_valid_i            ( state_SA_3x3            ),
    .SA_2x2_valid_i            ( state_SA_2x2            ),
    .c11                     ( c11                     ),
    .c12                     ( c12                     ),
    .c21                     ( c21                     ),
    .c22                     ( c22                     ),
    .c11_PE                     ( c11_PE                     ),
    .c12_PE                     ( c12_PE                     ),
    .c21_PE                     ( c21_PE                     ),
    .c22_PE                     ( c22_PE                     ),
    .c11_3x3                     ( c11_3x3                     ),
    .c12_3x3                     ( c12_3x3                     ),
    .c21_3x3                     ( c21_3x3                     ),
    .c22_3x3                     ( c22_3x3                     ),
    .c11_2x2                     ( c11_2x2                     ),
    .c12_2x2                     ( c12_2x2                     ),
    .c21_2x2                     ( c21_2x2                     ),
    .c22_2x2                     ( c22_2x2                     ),
    .done_capture        ( done_capture        )
);

core_module u_core_module(
        .clk           ( clk           ),
        .rst           ( reset           ),
        .active_send  ( state_send  ),
        .active_single ( state_PE ),
        .active_sa3    ( state_SA_3x3    ),
        .active_sa2    ( state_SA_2x2    ),
        .a11           ( a11           ),
        .a12           ( a12           ),
        .a13           ( a13           ),
        .a14           ( a14           ),
        .a21           ( a21           ),
        .a22           ( a22           ),
        .a23           ( a23           ),
        .a24           ( a24           ),
        .a31           ( a31           ),
        .a32           ( a32           ),
        .a33           ( a33           ),
        .a34           ( a34           ),
        .a41           ( a41           ),
        .a42           ( a42           ),
        .a43           ( a43           ),
        .a44           ( a44           ),
        .b11           ( b11           ),
        .b12           ( b12           ),
        .b13           ( b13           ),
        .b21           ( b21           ),
        .b22           ( b22           ),
        .b23           ( b23           ),
        .b31           ( b31           ),
        .b32           ( b32           ),
        .b33           ( b33           ),
        .c11           ( c11           ),
        .c12           ( c12           ),
        .c21           ( c21           ),
        .c22           ( c22           ),
        .done_send    ( done_send    ),
        .done_single   ( done_PE   ),
        .done_sa3      ( done_SA_3x3      ),
        .done_sa2      ( done_SA_2x2      )
    );

display u_display(
    .clk            ( clk            ),
    .reset            ( reset            ),
    .run_display     ( state_display     ),
    .c11_PE      ( c11_PE     ),
    .c12_PE      ( c12_PE     ),
    .c21_PE      ( c21_PE     ),
    .c22_PE      ( c22_PE     ),
    .c11_3x3      ( c11_3x3     ),
    .c12_3x3      ( c12_3x3     ),
    .c21_3x3      ( c21_3x3     ),
    .c22_3x3      ( c22_3x3     ),
    .c11_2x2      ( c11_2x2     ),
    .c12_2x2      ( c12_2x2     ),
    .c21_2x2      ( c21_2x2     ),
    .c22_2x2      ( c22_2x2     ),
    .display_result_o     ( display_result     ),
    .state_display_o    ( display_current_state    )
);
endmodule