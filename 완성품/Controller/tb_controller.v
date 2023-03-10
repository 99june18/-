`timescale 1ns/1ns

module tb_controller;
	reg clk; 
	reg reset;

	reg run;
	reg done_capture;
	reg done_send;
	reg done_PE;
	reg done_SA_3x3;
	reg done_SA_2x2;
	reg [2:0] current_display;
	
	wire state_idle;
	wire state_capture;
	wire state_send;
	wire state_PE;
	wire state_SA_3x3;
	wire state_SA_2x2;
	wire state_display;
	
	// clock
	initial
	begin
	    forever
		begin
		    #10 clk = !clk;
		end
	end

  // initialization
	initial 
	begin
		clk = 0;
    reset = 0;
    run = 0;
    done_capture = 0;
    done_send = 0;
    done_PE = 0;
    done_SA_3x3 = 0;
    done_SA_2x2 = 0;
    current_display = 0;
	end
    
  initial 
	begin
		@(posedge clk); 
    reset = 1;
        
    @(posedge clk);  
    reset = 0;

    @(posedge clk); 
    run = 1;

    @(posedge clk);
    done_capture = 1;
    run = 0;

    @(posedge clk);
    done_send = 0;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    @(posedge clk); 
    done_send = 1;

    @(posedge clk);
    done_send = 0;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

        @(posedge clk); 
        done_PE = 1;

        @(posedge clk);
        done_PE = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(posedge clk); 
        done_SA_3x3 = 1;

        @(posedge clk);
        done_SA_3x3 = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(posedge clk); 
        done_SA_2x2 = 1;

        @(posedge clk);
        done_SA_2x2 = 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(posedge clk); 
        current_display = 4;

        @(posedge clk); 
        current_display = 0;

        @(posedge clk); 
        @(posedge clk);
        reset = 1;
	end

    controller controller0(
    .clk          ( clk          ),
    .reset          ( reset          ),
    .run         ( run         ),
    .done_capture    ( done_capture    ),
    .done_send    ( done_send    ),
    .done_PE ( done_PE  ),
    .done_SA_3x3    ( done_SA_3x3    ),
    .done_SA_2x2    ( done_SA_2x2    ),
    .current_display ( current_display ),
    .state_idle   ( state_idle   ),
    .state_capture  ( state_capture  ),
    .state_send   ( state_send   ),
    .state_PE ( state_PE ),
    .state_SA_3x3   ( state_SA_3x3   ),
    .state_SA_2x2   ( state_SA_2x2   ),
    .state_display ( state_display )
    );

endmodule