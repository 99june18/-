`timescale 1ns/1ns

module tb_computation_memory;

    reg CLK;
    reg rst;
    reg activate;
    reg [7:0] a11_in,a12_in,a13_in,a14_in,
                a21_in,a22_in,a23_in,a24_in,
                a31_in,a32_in,a33_in,a34_in,
                a41_in,a42_in,a43_in,a44_in;
    reg [7:0] b11_in,b12_in,b13_in,
                b21_in,b22_in,b23_in,
                b31_in,b32_in,b33_in;

    wire activate_done;

    wire [7:0] a11,a12,a13,a14,
                 a21,a22,a23,a24,
                 a31,a32,a33,a34,
                 a41,a42,a43,a44;

    wire [7:0] b11,b12,b13,
                 b21,b22,b23,
                 b31,b32,b33;

computation_memory_module u_computation_memory_module(
    .clk           ( CLK           ),
    .rst           ( rst           ),
    .activate      ( activate      ),
    .a11_in        ( a11_in        ),
    .a12_in        ( a12_in        ),
    .a13_in        ( a13_in        ),
    .a14_in        ( a14_in        ),
    .a21_in        ( a21_in        ),
    .a22_in        ( a22_in        ),
    .a23_in        ( a23_in        ),
    .a24_in        ( a24_in        ),
    .a31_in        ( a31_in        ),
    .a32_in        ( a32_in        ),
    .a33_in        ( a33_in        ),
    .a34_in        ( a34_in        ),
    .a41_in        ( a41_in        ),
    .a42_in        ( a42_in        ),
    .a43_in        ( a43_in        ),
    .a44_in        ( a44_in        ),
    .b11_in        ( b11_in        ),
    .b12_in        ( b12_in        ),
    .b13_in        ( b13_in        ),
    .b21_in        ( b21_in        ),
    .b22_in        ( b22_in        ),
    .b23_in        ( b23_in        ),
    .b31_in        ( b31_in        ),
    .b32_in        ( b32_in        ),
    .b33_in        ( b33_in        ),
    .activate_done ( activate_done ),
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
    .b33           ( b33           )
);

    initial
	begin
		 CLK = 1'b0;
         rst = 1'b1;
         activate = 1'b0;
         a11_in = 8'b0;
         a12_in = 8'b0; 
         a13_in = 8'b0;
         a14_in = 8'b0;
         a21_in = 8'b0; a22_in = 8'b0; a23_in = 8'b0; a24_in = 8'b0;
         a31_in = 8'b0; a32_in = 8'b0; a33_in = 8'b0; a34_in = 8'b0;
         a41_in = 8'b0; a42_in = 8'b0; a43_in = 8'b0; a44_in = 8'b0;
         b11_in = 8'b0; b12_in = 8'b0; b13_in = 8'b0;
         b21_in = 8'b0; b22_in = 8'b0; b23_in = 8'b0;
         b31_in = 8'b0; b32_in = 8'b0; b33_in = 8'b0;
    end

    initial
    begin
		 forever
		 begin
			#5 CLK = !CLK;
		 end
	end
    
    //값이 먼저들와야한다.
    //그 이후 activate가 껴지는 순서 > 안그러면 done신호가 불안정
    initial
    begin
        #10 rst = 1'b0;

        #10 a11_in = 8'd3; a12_in = 8'd3; a13_in = 8'd3; a14_in = 8'd3;
            a21_in = 8'd4; a22_in = 8'd4; a23_in = 8'd4; a24_in = 8'd4;
            a31_in = 8'd9; a32_in = 8'd9; a33_in = 8'd9; a34_in = 8'd9;
            a41_in = 8'd14; a42_in = 8'd14; a43_in = 8'd14; a44_in = 8'd14;
            b11_in = 8'd11; b12_in = 8'd11; b13_in = 8'd11;
            b21_in = 8'd2; b22_in = 8'd2; b23_in = 8'd2;
            b31_in = 8'd9; b32_in = 8'd9; b33_in = 8'd9;

        #10 rst = 1'b0; activate = 1'b0;

        #10 rst = 1'b0; activate = 1'b1;

        #10 rst = 1'b1;

        #10 rst = 1'b0;

        #10 a11_in = 8'd3; a12_in = 8'd3; a13_in = 8'd3; a14_in = 8'd3;
            a21_in = 8'd4; a22_in = 8'd4; a23_in = 8'd4; a24_in = 8'd4;
            a31_in = 8'd9; a32_in = 8'd9; a33_in = 8'd9; a34_in = 8'd9;
            a41_in = 8'd14; a42_in = 8'd14; a43_in = 8'd14; a44_in = 8'd14;
            b11_in = 8'd11; b12_in = 8'd11; b13_in = 8'd11;
            b21_in = 8'd2; b22_in = 8'd2; b23_in = 8'd2;
            b31_in = 8'd9; b32_in = 8'd9; b33_in = 8'd9;

        #10 rst = 1'b0; activate = 1'b0;

        #10 rst = 1'b0; activate = 1'b1;

    end
endmodule