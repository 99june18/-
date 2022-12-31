`timescale 1ns/1ns

module tb_single_process_array;

	reg clk; 
	reg rst;
	reg active_single;

    reg [7:0]
        a11,a12,a13,a14,
        a21,a22,a23,a24,
        a31,a32,a33,a34,
        a41,a42,a43,a44;
    reg [7:0]
        b11,b12,b13,
        b21,b22,b23,
        b31,b32,b33;

    wire done_single;
	wire [7:0] c11, c12, c21, c22; 

    integer i;

    //c11 = 192, c12 = 237, c21 = 116, c22 = 161이 나온다.
    single_process_array u_single_process_array(
        .clk           ( clk           ),
        .rst           ( rst           ),
        .active_single ( active_single ),
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
        .done_single   ( done_single   ),
        .c11           ( c11           ),
        .c12           ( c12           ),
        .c21           ( c21           ),
        .c22           ( c22           )
    );

	initial
	begin
	    forever
		begin
		    #10 clk = !clk;
		end
	end

	initial 
	begin
		clk = 0;
        rst = 1;
        active_single = 0;

        a11 = 1;  a12 = 2;  a13 = 3;  a14 = 4;
        a21 = 5;  a22 = 6;  a23 = 7;  a24 = 8;
        a31 = 9;  a32 = 10; a33 = 11; a34 = 12;
        a41 = 13; a42 = 14; a43 = 15; a44 = 16;
        b11 = 1; b12 = 2; b13 = 3; 
        b21 = 4; b22 = 5; b23 = 6;
        b31 = 7; b32 = 8; b33 = 9;
	end

    initial 
	begin
		#20 rst = 0;
        for (i = 0; i < 37; i = i+1) begin
            active_single = 1;
            @(posedge clk);
        end
        active_single = 0;
	end

endmodule