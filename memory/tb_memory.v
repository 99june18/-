`timescale 1ns/1ns
`define DELTA 2

module tb_memory;
	reg clk; 
	reg rst;
    
    reg init_valid_i; // == state_write : data is captured one clock later than init_valid_i rising.
    wire done_save_to_external;
    reg [7:0]
        a11,a12,a13,a14,
        a21,a22,a23,a24,
        a31,a32,a33,a34,
        a41,a42,a43,a44;
    reg [7:0]
        b11,b12,b13,
        b21,b22,b23,
        b31,b32,b33;

    reg single_valid_i; // will insert to cmem[0:3]
    reg sys3_valid_i;   // will insert to cmem[4:7]
    reg sys2_valid_i;   // will insert to cmem[8:11]
    reg [7:0] c11,c12,
              c21,c22; // cmem[0:3]->single, cmem[4:7]->sys3, cmem[8,11]->sys2

    reg [4:0] select_from_comp;
    wire [7:0] out_to_comp; // no delay to output
    
    reg [3:0] select_from_display;
    wire [7:0] out_to_display; // no delay to output

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
        rst = 0;

        init_valid_i = 0;
    
        a11 = 0; a12 = 0; a13 = 0; a14 = 0;
        a21 = 0; a22 = 0; a23 = 0; a24 = 0;
        a31 = 0; a32 = 0; a33 = 0; a34 = 0;
        a41 = 0; a42 = 0; a43 = 0; a44 = 0;
        b11 = 0; b12 = 0; b13 = 0; 
        b21 = 0; b22 = 0; b23 = 0; 
        b31 = 0; b32 = 0; b33 = 0; 
        c11 = 0; c12 = 0; 
        c21 = 0; c22 = 0; 
        
        single_valid_i = 0;
        sys3_valid_i = 0;
        sys2_valid_i = 0;

        select_from_comp = 7'd0;
        select_from_display = 4'd0;
	end
    
    initial 
	begin
		@(posedge clk); 
        #(`DELTA) // propagation delay
        rst = 1; // external siganl (external means top input)
        
        @(posedge clk); 
        #(`DELTA) 
        rst = 0;

        @(posedge clk); 
        #(`DELTA) 
        a11 = 8'd1;  a12 = 8'd2;  a13 = 8'd3;  a14 = 8'd4;
        a21 = 8'd5;  a22 = 8'd6;  a23 = 8'd7;  a24 = 8'd8;
        a31 = 8'd9;  a32 = 8'd10; a33 = 8'd11; a34 = 8'd12;
        a41 = 8'd13; a42 = 8'd14; a43 = 8'd15; a44 = 8'd16;
        b11 = 8'd17; b12 = 8'd18; b13 = 8'd19; 
        b21 = 8'd20; b22 = 8'd21; b23 = 8'd22; 
        b31 = 8'd23; b32 = 8'd24; b33 = 8'd25; 

        @(posedge clk);
        init_valid_i = 1; 
        //intial values capture
        @(posedge clk);
        @(posedge clk);
        init_valid_i = 0;

        @(posedge clk);
        // random load test
        @(posedge clk); // load 
        select_from_comp = 5'd10; //a33 == 11
        @(posedge clk);
        select_from_comp = 5'd20; //b22 == 21
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(posedge clk);
        single_valid_i = 1; //single start
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); // single compute wait
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd26;    
        c12 = 8'd27;    
        c21 = 8'd28;    
        c22 = 8'd29;

        @(posedge clk);
        single_valid_i = 0;
        sys3_valid_i = 1; // sys3 start
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); // sys3 compute wait
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd30;    
        c12 = 8'd31; 
        c21 = 8'd32; 
        c22 = 8'd33;

        @(posedge clk);
        sys3_valid_i = 0;
        //c22 = 8'd90; if this statement is exist, anyway c22 will be still 33
        sys2_valid_i = 1; // sys2 start
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); // sys2 compute wait
        @(posedge clk);
        @(posedge clk);
        c11 = 8'd34;    
        c12 = 8'd35; 
        c21 = 8'd36; 
        c22 = 8'd37;
        @(posedge clk);
        sys2_valid_i = 0;

        // random display test
        @(posedge clk); //display
        select_from_display = 4'd0; //c11 of single == 26
        @(posedge clk);
        select_from_display = 4'd6; //c21 of sys3 == 32
        @(posedge clk);
        select_from_display = 4'd11; //c22 of sys2 == 37
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #(`DELTA) 
        rst = 1;
	end

memory memory0(
    .clk                     ( clk                     ),
    .rst                     ( rst                     ),
    .init_valid_i            ( init_valid_i            ),
    .done_save_to_external ( done_save_to_external ),
    .a11                     ( a11                     ),
    .a12                     ( a12                     ),
    .a13                     ( a13                     ),
    .a14                     ( a14                     ),
    .a21                     ( a21                     ),
    .a22                     ( a22                     ),
    .a23                     ( a23                     ),
    .a24                     ( a24                     ),
    .a31                     ( a31                     ),
    .a32                     ( a32                     ),
    .a33                     ( a33                     ),
    .a34                     ( a34                     ),
    .a41                     ( a41                     ),
    .a42                     ( a42                     ),
    .a43                     ( a43                     ),
    .a44                     ( a44                     ),
    .b11                     ( b11                     ),
    .b12                     ( b12                     ),
    .b13                     ( b13                     ),
    .b21                     ( b21                     ),
    .b22                     ( b22                     ),
    .b23                     ( b23                     ),
    .b31                     ( b31                     ),
    .b32                     ( b32                     ),
    .b33                     ( b33                     ),
    .single_valid_i          ( single_valid_i          ),
    .sys3_valid_i            ( sys3_valid_i            ),
    .sys2_valid_i            ( sys2_valid_i            ),
    .c11                     ( c11                     ),
    .c12                     ( c12                     ),
    .c21                     ( c21                     ),
    .c22                     ( c22                     ),
    .select_from_comp        ( select_from_comp        ),
    .out_to_comp             ( out_to_comp             ),
    .select_from_display     ( select_from_display     ),
    .out_to_display          ( out_to_display          )
);


endmodule