`timescale 1ns/1ns
`define DELTA 2

module tb_memory;
	reg clk; 
	reg reset;

  reg run_valid_i; 
                    
  reg PE_valid_i;  
  reg SA_3x3_valid_i; 
  reg SA_2x2_valid_i;  


  wire done_capture;

  reg [7:0]
    a11, a12, a13, a14,
    a21, a22, a23, a24,
    a31, a32, a33, a34,
    a41, a42, a43, a44;
  reg [7:0]
    b11, b12, b13,
    b21, b22, b23,
    b31, b32, b33;
  reg [7:0] 
    c11, c12,
    c21, c22;

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

	//clock
	initial
	begin
	    forever
		begin
		    #10 clk = !clk;
		end
	end

    // initialization
	initial 
	begin
		clk = 0;
        reset = 0;

        run_valid_i = 0;
    
        a11 = 0; a12 = 0; a13 = 0; a14 = 0;
        a21 = 0; a22 = 0; a23 = 0; a24 = 0;
        a31 = 0; a32 = 0; a33 = 0; a34 = 0;
        a41 = 0; a42 = 0; a43 = 0; a44 = 0;
        b11 = 0; b12 = 0; b13 = 0; 
        b21 = 0; b22 = 0; b23 = 0; 
        b31 = 0; b32 = 0; b33 = 0; 
        c11 = 0; c12 = 0; 
        c21 = 0; c22 = 0; 
        
        PE_valid_i = 0;
        SA_3x3_valid_i = 0;
        SA_2x2_valid_i = 0;
	end
    
    initial 
	begin
		@(posedge clk); 
        #(`DELTA)
        reset = 1;
        
        @(posedge clk); 
        #(`DELTA) 
        reset = 0;

        @(posedge clk); 
        #(`DELTA) 
        a11 = 8'd1;  a12 = 8'd2;  a13 = 8'd3;  a14 = 8'd4;
        a21 = 8'd5;  a22 = 8'd6;  a23 = 8'd7;  a24 = 8'd8;
        a31 = 8'd9;  a32 = 8'd10; a33 = 8'd11; a34 = 8'd12;
        a41 = 8'd13; a42 = 8'd14; a43 = 8'd15; a44 = 8'd16;
        b11 = 8'd17; b12 = 8'd18; b13 = 8'd19; 
        b21 = 8'd20; b22 = 8'd21; b23 = 8'd22; 
        b31 = 8'd23; b32 = 8'd24; b33 = 8'd25;

        @(posedge clk);
        run_valid_i = 1; 
        @(posedge clk);
        @(posedge clk);
        run_valid_i = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(posedge clk);
        PE_valid_i = 1; 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd26;    
        c12 = 8'd27;    
        c21 = 8'd28;    
        c22 = 8'd29;
        @(posedge clk);
        PE_valid_i = 0;

        SA_3x3_valid_i = 1; 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd30;    
        c12 = 8'd31; 
        c21 = 8'd32; 
        c22 = 8'd33;
        @(posedge clk);
        SA_3x3_valid_i = 0;
        
        SA_2x2_valid_i = 1; 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd34;    
        c12 = 8'd35; 
        c21 = 8'd36; 
        c22 = 8'd37;
        @(posedge clk);
        SA_2x2_valid_i = 0;

        @(posedge clk); 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #(`DELTA) 
        reset = 1;
	end

memory memory0(
    .clk                     ( clk                     ),
    .reset                     ( reset                     ),
    .run_valid_i            ( run_valid_i            ),
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
    .PE_valid_i          ( PE_valid_i          ),
    .SA_3x3_valid_i            ( SA_3x3_valid_i            ),
    .SA_2x2_valid_i            ( SA_2x2_valid_i            ),
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


endmodule