`timescale 1ns/1ns

module tb_top;

	reg clk; 
	reg reset;
	reg run;
	reg [7:0]
        a11,a12,a13,a14,
        a21,a22,a23,a24,
        a31,a32,a33,a34,
        a41,a42,a43,a44;
    reg [7:0]
        b11,b12,b13,
        b21,b22,b23,
        b31,b32,b33;

  wire [7:0] display_result;
  wire [2:0] display_current_state;
	
	//clock
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
        reset = 0;
        run = 0;
        @(posedge clk);
        reset = 1;
        @(posedge clk); 
        reset = 0;
        @(posedge clk);
        
        a11 = 8;    a12 = 6;    a13 = 10;   a14 = 10;
        a21 = 9;    a22 = 1;    a23 = 10;   a24 =  5;
        a31 = 1;    a32 = 3;    a33 =  1;   a34 =  8;
        a41 = 10;   a42 = 6;    a43 = 10;   a44 =  1;

        b11 = 2;    b12 = 5;    b13 =  5; 
        b21 = 5;    b22 = 3;    b23 =  5; 
        b31 = 4;    b32 = 0;    b33 =  4; 
	end

    integer i;

    initial 
	begin        
        @(posedge clk);
        @(posedge clk);
        run = 1;

        @(posedge clk);

        @(posedge clk);
        for (i = 0; i < 87; i = i+1) begin
        @(posedge clk);
        end

        $display("single_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("single_c22 : %d", display_result);
        $display("current state : %d\n", display_current_state);

        @(posedge clk);
        $display("systolic3_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic3_c22 : %d", display_result);
        $display("current state : %d\n", display_current_state);

        @(posedge clk);
        $display("systolic2_c11 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c12 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c21 : %d", display_result);
        $display("current state : %d", display_current_state);

        @(posedge clk);
        $display("systolic2_c22 : %d", display_result);
        $display("current state : %d", display_current_state);
	end

top u_top(
    .clk  ( clk  ),
    .reset  ( reset  ),
    .run ( run ),
    .a11  ( a11  ),
    .a12  ( a12  ),
    .a13  ( a13  ),
    .a14  ( a14  ),
    .a21  ( a21  ),
    .a22  ( a22  ),
    .a23  ( a23  ),
    .a24  ( a24  ),
    .a31  ( a31  ),
    .a32  ( a32  ),
    .a33  ( a33  ),
    .a34  ( a34  ),
    .a41  ( a41  ),
    .a42  ( a42  ),
    .a43  ( a43  ),
    .a44  ( a44  ),
    .b11  ( b11  ),
    .b12  ( b12  ),
    .b13  ( b13  ),
    .b21  ( b21  ),
    .b22  ( b22  ),
    .b23  ( b23  ),
    .b31  ( b31  ),
    .b32  ( b32  ),
    .b33  ( b33  ),
    .display_result ( display_result ),
    .display_current_state ( display_current_state )
);

endmodule