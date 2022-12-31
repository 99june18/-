`timescale 1ns/1ns

module tb_pe;
    reg clk; 
	reg rst;

    reg [7:0] pe_in;
    reg [7:0] pe_filter;
    reg [1:0] mode_i;
    reg activate;

    wire [7:0] pe_in_o;
    wire [7:0] pe_out;

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

        pe_in = 0;
        activate = 0;
        
        pe_filter = 0;
        mode_i = 2'd3;
	end

    initial 
	begin
		@(posedge clk);
        rst = 1;
        
        @(posedge clk); 
        rst = 0;

        @(posedge clk); 
        activate = 1; 
        @(posedge clk);

        //mode single
        @(posedge clk);
        mode_i = 0;
        pe_in = 8'd1;
        pe_filter = 8'd2;
        @(posedge clk);
        pe_in = 8'd2;
        pe_filter = 8'd3;
        @(posedge clk);
        pe_in = 8'd3;
        pe_filter = 8'd4;
        @(posedge clk);
        pe_in = 8'd4;
        pe_filter = 8'd5;
        @(posedge clk);
        pe_in = 8'd5;
        pe_filter = 8'd6;
        @(posedge clk);
        pe_in = 8'd6;
        pe_filter = 8'd7;
        @(posedge clk);
        pe_in = 8'd7;
        pe_filter = 8'd8;
        @(posedge clk);
        pe_in = 8'd8;
        pe_filter = 8'd9;
        @(posedge clk);
        pe_in = 8'd9;
        pe_filter = 8'd10;
        @(posedge clk);
        pe_in = 8'd10;
        pe_filter = 8'd11;

        //mode save
        @(posedge clk);
        mode_i = 2'd1;
        pe_filter = 8'd2;
        @(posedge clk);
        pe_filter = 8'd3;
        @(posedge clk);
        pe_filter = 8'd4;

        //mode sa computation
        @(posedge clk);
        mode_i = 2'd2;
        pe_filter = 8'd1;
        pe_in = 8'd1;
        @(posedge clk);
        pe_filter = 8'd2;
        pe_in = 8'd2;
        @(posedge clk);
        pe_filter = 8'd3;
        pe_in = 8'd3;
        @(posedge clk);
        pe_filter = 8'd4;
        pe_in = 8'd4;
        @(posedge clk);
        pe_filter = 8'd5;
        pe_in = 8'd5;

        @(posedge clk);
        @(posedge clk);
        rst = 1;
	end

    pe u_pe(
        .clk       ( clk       ),
        .rst       ( rst       ),
        .pe_in     ( pe_in     ),
        .pe_filter ( pe_filter ),
        .pe_out    ( pe_out    ),
        .mode_i    ( mode_i    ),
        .activate  ( activate  ),
        .pe_in_o   (   )
    );

endmodule