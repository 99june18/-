`timescale 1ns/1ns

module tb_systolic_array_2_by_2;

	reg clk; 
	reg rst;
    reg active_sa2;

	reg [7:0]
        a11,a12,a13,a14,
        a21,a22,a23,a24,
        a31,a32,a33,a34,
        a41,a42,a43,a44;
    reg [7:0]
        b11,b12,b13,
        b21,b22,b23,
        b31,b32,b33;
    
    wire done_sa2;
    wire [7:0] c11,c12,c21,c22;

	initial
	begin
	    forever
		begin
		    #10 clk = !clk;
		end
	end

    // initial setting
	initial 
	begin
		clk = 0;
        rst = 0;

        a11 = 1;  a12 = 2;  a13 = 3;  a14 = 0;
        a21 = 0;  a22 = 1;  a23 = 2;  a24 = 3;
        a31 = 3;  a32 = 0;  a33 = 1;  a34 = 2;
        a41 = 2;  a42 = 3;  a43 = 0;  a44 = 1;
        b11 = 2; b12 = 0; b13 = 1; 
        b21 = 0; b22 = 1; b23 = 2; 
        b31 = 1; b32 = 0; b33 = 2; 

        // should be 15, 16, 6, 15
        // because this module does not rotate filter
        // if filter rotated, 
        // should be 11, 12, 10, 11

        active_sa2 = 0;
	end

    integer i;

    initial 
	begin
		@(posedge clk); 
        rst = 1; // external siganl (external means top input)
        
        @(posedge clk); 
        rst = 0;

        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        for (i = 0; i < 29; i = i+1) begin
            active_sa2 = 1;
            @(posedge clk);
        end
        active_sa2 = 0;


	end

    systolic_array_2_by_2 u_systolic_array_2_by_2(
        .clk        ( clk        ),
        .rst        ( rst        ),
        .active_sa2 ( active_sa2 ),
        .a11        ( a11        ),
        .a12        ( a12        ),
        .a13        ( a13        ),
        .a14        ( a14        ),
        .a21        ( a21        ),
        .a22        ( a22        ),
        .a23        ( a23        ),
        .a24        ( a24        ),
        .a31        ( a31        ),
        .a32        ( a32        ),
        .a33        ( a33        ),
        .a34        ( a34        ),
        .a41        ( a41        ),
        .a42        ( a42        ),
        .a43        ( a43        ),
        .a44        ( a44        ),
        .b11        ( b11        ),
        .b12        ( b12        ),
        .b13        ( b13        ),
        .b21        ( b21        ),
        .b22        ( b22        ),
        .b23        ( b23        ),
        .b31        ( b31        ),
        .b32        ( b32        ),
        .b33        ( b33        ),
        .done_sa2   ( done_sa2   ),
        .c11        ( c11        ),
        .c12        ( c12        ),
        .c21        ( c21        ),
        .c22        ( c22        )
    );


endmodule