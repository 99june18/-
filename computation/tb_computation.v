`timescale 1ns/1ns

module tb_computation;

    reg clk; 
	reg rst;

    reg active_store, active_single, active_sa3, active_sa2;

    reg [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
                
    reg [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    wire [7:0] c11,c12,c21,c22;
    wire done_store, done_single, done_sa3, done_sa2;

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
        rst = 0;

        active_store = 0; 
        active_single = 0; 
        active_sa3 = 0; 
        active_sa2 = 0;

        a11 = 0; a12 = 0; a13 = 0; a14 = 0;
        a21 = 0; a22 = 0; a23 = 0; a24 = 0;
        a31 = 0; a32 = 0; a33 = 0; a34 = 0;
        a41 = 0; a42 = 0; a43 = 0; a44 = 0;

        b11 = 0; b12 = 0; b13 = 0;
        b21 = 0; b22 = 0; b23 = 0;
        b31 = 0; b32 = 0; b33 = 0;
    end

    integer i;

    initial 
	begin
        @(posedge clk);
        rst = 1;

        @(posedge clk); 
        rst = 0;

        @(posedge clk);
        active_store = 1;
        a11 = 1; a12 = 2; a13 = 3; a14 = 4;
        a21 = 1; a22 = 2; a23 = 3; a24 = 4;
        a31 = 1; a32 = 2; a33 = 3; a34 = 4;
        a41 = 1; a42 = 2; a43 = 3; a44 = 4;

        b11 = 1; b12 = 1; b13 = 1;
        b21 = 2; b22 = 2; b23 = 2;
        b31 = 3; b32 = 3; b33 = 3;
        @(posedge clk);
        active_store = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        for (i = 0; i < 38/*done count number+1*/; i = i+1) begin
            active_single = 1;
            @(posedge clk);
        end
        active_single = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        for (i = 0; i < 17/*done count number+1*/; i = i+1) begin
            active_sa3 = 1;
            @(posedge clk);
        end
        active_sa3 = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        for (i = 0; i < 29/*done count number+1*/; i = i+1) begin
            active_sa2 = 1;
            @(posedge clk);
        end
        active_sa2 = 0;

    end

    computation_module u_computation_module(
        .clk           ( clk           ),
        .rst           ( rst           ),
        .active_store  ( active_store  ),
        .active_single ( active_single ),
        .active_sa3    ( active_sa3    ),
        .active_sa2    ( active_sa2    ),
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
        .done_store    ( done_store    ),
        .done_single   ( done_single   ),
        .done_sa3      ( done_sa3      ),
        .done_sa2      ( done_sa2      )
    );

endmodule