module controller(clk, reset, run, 
done_capture, done_send, done_PE, done_SA_3x3 , done_SA_2x2, current_display, 
state_idle, state_capture, state_send, state_PE, state_SA_3x3, state_SA_2x2, state_display);

	input clk; 
	input reset;
	input run;
	input done_capture;
	input done_send;
	input done_PE;
	input done_SA_3x3;
	input done_SA_2x2;
	input [2:0] current_display;  //S_PE_IDLE = 0, S_PE_DISPLAY = 1, S_3x3_DISPLAY = 2, S_2x2_DISPLAY = 3, S_DONE_DISPLAY = 4;
	
	output state_idle;
	output state_capture;
	output state_send;
	output state_PE;
	output state_SA_3x3;
	output state_SA_2x2;
	output state_display;

	reg	[2:0] state, n_state;
	
	//States
	parameter S_IDLE = 0, S_CAPTURE = 1, S_SEND = 2, S_PE = 3, S_SA_3x3 = 4, S_SA_2x2 = 5, S_DISPLAY = 6;


	//reset and propagation
	always @ (posedge clk or posedge reset) begin
		if (reset == 1'b1)
			state <= S_IDLE;
		else
			state <= n_state;
	end


	//state machine
	always @ (*)
	begin
		n_state = state;
		case (state)
			S_IDLE:
			begin
				if (run == 1'b1)
					n_state = S_CAPTURE;
			end
			S_CAPTURE:
			begin
				if (done_capture == 1'b1)
					n_state = S_SEND;
			end
			S_SEND:
			begin
				if (done_send == 1'b1)
					n_state = S_PE;
			end
			S_PE:
			begin
				if (done_PE == 1'b1)
					n_state = S_SA_3x3;
			end
			S_SA_3x3:
			begin
				if (done_SA_3x3 == 1'b1)
					n_state = S_SA_2x2;
			end
			S_SA_2x2:
			begin
				if (done_SA_2x2 == 1'b1)
					n_state = S_DISPLAY;
			end
			S_DISPLAY:
			begin
				if (current_display == 3'b100)
					n_state = S_IDLE;
			end
			default:
			begin
				n_state = S_IDLE;
			end
		endcase
	end
	
	assign state_idle 	= (state == S_IDLE);
	assign state_capture 	= (state == S_CAPTURE);
	assign state_send 	= (state == S_SEND);
	assign state_PE = (state == S_PE);
	assign state_SA_3x3 	= (state == S_SA_3x3);
	assign state_SA_2x2 	= (state == S_SA_2x2);
	assign state_display 	= (state == S_DISPLAY);
endmodule