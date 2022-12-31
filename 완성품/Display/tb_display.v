`timescale 1ns/1ns
`define DELTA 2

module tb_display;

	reg clk; 
	reg reset;

  reg run_display; // state == S_DISPLAY
  reg [7:0] 
  c11_PE, c12_PE, 
  c21_PE, c22_PE,
  c11_3x3, c12_3x3, 
  c21_3x3, c22_3x3, 
  c11_2x2, c12_2x2, 
  c21_2x2, c22_2x2;

  wire [7:0] display_result_o;
  wire [2:0] state_display_o; // controller의 current_display와 연결

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
    run_display = 0; // state == S_DISPLAY
    c11_PE = 8'b0; 
    c12_PE = 8'b0;
    c21_PE = 8'b0;
    c22_PE = 8'b0;
    c11_3x3 = 8'b0; 
    c12_3x3 = 8'b0;
    c21_3x3 = 8'b0;
    c22_3x3 = 8'b0;
    c11_2x2 = 8'b0;
    c12_2x2 = 8'b0;
    c21_2x2 = 8'b0;
    c22_2x2 = 8'b0;
	end

  initial 
	begin
		@(posedge clk); 
      #(`DELTA)
      reset = 1; 
        
      @(posedge clk); 
      #(`DELTA) 
      reset = 0;
      @(posedge clk); 
      #(`DELTA) 
      run_display = 1;
      c11_PE = 8'd1; 
      c12_PE = 8'd2;
      c21_PE = 8'd3;
      c22_PE = 8'd4;
      c11_3x3 = 8'd5; 
      c12_3x3 = 8'd6;
      c21_3x3 = 8'd7;
      c22_3x3 = 8'd8;
      c11_2x2 = 8'd9;
      c12_2x2 = 8'd10;
      c21_2x2 = 8'd11;
      c22_2x2 = 8'd12;

      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
            @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
            @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
            @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      reset = 1;
	end

display u_display(
    .clk            ( clk            ),
    .reset            ( reset            ),
    .run_display     ( run_display     ),
    .c11_PE      ( c11_PE     ),
    .c12_PE      ( c12_PE     ),
    .c21_PE      ( c21_PE     ),
    .c22_PE      ( c22_PE     ),
    .c11_3x3      ( c11_3x3     ),
    .c12_3x3      ( c12_3x3     ),
    .c21_3x3      ( c21_3x3     ),
    .c22_3x3      ( c22_3x3     ),
    .c11_2x2      ( c11_2x2     ),
    .c12_2x2      ( c12_2x2     ),
    .c21_2x2      ( c21_2x2     ),
    .c22_2x2      ( c22_2x2     ),
    .display_result_o     ( display_result_o     ),
    .state_display_o    ( state_display_o    )
);

endmodule