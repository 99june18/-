`timescale 1ns/1ns

module tb_single;

	reg CLK; 
	reg RST;
	reg ACTIVE_SINGLE;

    wire DONE_SINGLE;
	wire [7:0] C11, C12, C21, C22; 

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
        .b11           ( 17           ),
        .b12           ( 18           ),
        .b13           ( 19           ),
        .b21           ( 20           ),
        .b22           ( 21           ),
        .b23           ( 22           ),
        .b31           ( 23           ),
        .b32           ( 24           ),
        .b33           ( 25           ),
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
        #20    ACTIVE_SINGLE = 1;

	end


endmodule