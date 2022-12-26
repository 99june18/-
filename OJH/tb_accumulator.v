`timescale 1ns/1ns

module tb_accumulater;

	reg CLK; 
	reg RST;

	reg [7:0] ACC_IN;
 	
    wire [7:0] ACC_OUT;
	wire COUNT_9;

    accumulator accumulator_1(.clk(CLK), .rst(RST), .acc_in(ACC_IN), .acc_out(ACC_OUT), .count_9(COUNT_9));

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
        ACC_IN = 5;
	end

    initial 
	begin
		#20 RST = 0;


	end


endmodule