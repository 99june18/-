`timescale 1ns/1ns

module tb_multiplier_and_adder;

	reg [7:0] a;
	reg [7:0] b;

    wire [7:0] out;

eight_bit_multiplier_module u_eight_bit_multiplier_module(
    .a ( a ),
    .b ( b ),
    .out ( out )
);

    initial 
	begin
		    a = 8'b00000000; b = 8'b00000000;
	 
		 #10 a = 8'b00000001; b = 8'b00000010;

         #10 a = 8'b00000100; b = 8'b00010000;

         #10 a = 8'b01000000; b = 8'b00001100;

         #10 a = 8'b00001001; b = 8'b01110000;
	end

endmodule