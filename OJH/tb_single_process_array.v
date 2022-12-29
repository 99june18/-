`timescale 1ns/1ns

module tb_single_process_array;

	reg CLK; 
	reg RST;
	reg ACTIVE_SINGLE;

    wire DONE_SINGLE;
	wire [7:0] C11, C12, C21, C22; 

    //c11 = 192, c12 = 237, c21 = 116, c22 = 161이 나온다.
    single_process_array u_single_process_array(
        .clk           ( CLK          ),
        .rst           ( RST          ),
        .active_single ( ACTIVE_SINGLE ),
        .a11           ( 1           ),
        .a12           ( 2           ),
        .a13           ( 3          ),
        .a14           ( 4           ),
        .a21           ( 5          ),
        .a22           ( 6           ),
        .a23           ( 7           ),
        .a24           ( 8           ),
        .a31           ( 9           ),
        .a32           ( 10          ),
        .a33           ( 11           ),
        .a34           ( 12           ),
        .a41           ( 13           ),
        .a42           ( 14           ),
        .a43           ( 15           ),
        .a44           ( 16           ),
        .b11           ( 1           ),
        .b12           ( 2           ),
        .b13           ( 3           ),
        .b21           ( 4           ),
        .b22           ( 5           ),
        .b23           ( 6           ),
        .b31           ( 7           ),
        .b32           ( 8           ),
        .b33           ( 9           ),
        .done_single   ( DONE_SINGLE   ),
        .c11           ( C11           ),
        .c12           ( C12           ),
        .c21           ( C21           ),
        .c22           ( C22           )
    );


	initial
	begin
	    forever
		begin
		    #10 CLK = !CLK;
		end
	end

    // initial setting
	initial 
	begin
		CLK = 0;
        RST = 1;
	end

    initial 
	begin
		#20 RST = 0;
        #20 ACTIVE_SINGLE = 1;
	end

endmodule