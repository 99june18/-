module controller(clk, reset, run, 
done_capture, done_send, done_PE, done_3x3_SA , done_2x2_SA, done_display, 
state_idle, state_capture, state_send, state_PE, state_3x3_SA, state_2x2_SA, state_display);

	input clk; 
	input reset;
	input run;
	input done_capture;
	input done_send;
	input done_PE;
	input done_3x3_SA;
	input done_2x2_SA;
	input done_display;
	
	output state_idle;
	output state_capture;
	output state_send;
	output state_PE;
	output state_3x3_SA;
	output state_2x2_SA;
	output state_display;

	reg	[2:0] state, n_state;
	
	//States
	parameter S_IDLE = 0, S_CAPTURE = 1, S_SEND = 2, S_PE = 3, S_SA_3x3 = 4, S_SA_2x2 = 5, S_DISPLAY = 6;


endmodule