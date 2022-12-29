module display (clk, reset, run_display, 
c11_PE, c12_PE, c21_PE, c22_PE, c11_3x3, c12_3x3, c21_3x3, c22_3x3, c11_2x2, c12_2x2, c21_2x2, c22_2x2,
display_result_o, state_display_o);

	input clk; 
	input reset;

  input run_display; // state == S_DISPLAY
  input [7:0] 
  c11_PE, c12_PE, 
  c21_PE, c22_PE,
  c11_3x3, c12_3x3, 
  c21_3x3, c22_3x3, 
  c11_2x2, c12_2x2, 
  c21_2x2, c22_2x2;

  output [7:0] display_result_o;
  output [2:0] state_display_o; // controller의 current_display와 연결

  reg [7:0] display_result, n_display_result;

  reg [7:0] display_memory [0:11];

  reg done_capture_displaymemory;

// save the results to display memory
	always @ (*)
  begin
    if (reset == 1'b1) begin
      display_memory[0] <= 8'b0; display_memory[1] <= 8'b0; display_memory[2] <= 8'b0; display_memory[3] <= 8'b0;
      display_memory[4] <= 8'b0; display_memory[5] <= 8'b0; display_memory[6] <= 8'b0; display_memory[7] <= 8'b0;
      display_memory[8] <= 8'b0; display_memory[9] <= 8'b0; display_memory[10] <= 8'b0; display_memory[11] <= 8'b0;
    end
    else if (run_display == 1'b1) begin
      display_memory[0] <= c11_PE; display_memory[1] <= c12_PE; 
      display_memory[2] <= c21_PE; display_memory[3] <= c22_PE;
      display_memory[4] <= c11_3x3; display_memory[5] <= c12_3x3; 
      display_memory[6] <= c21_3x3; display_memory[7] <= c22_3x3;
      display_memory[8] <= c11_2x2; display_memory[9] <= c12_2x2; 
      display_memory[10] <= c21_2x2; display_memory[11] <= c22_2x2;
      done_capture_displaymemory <= 1'b1;
    end
  end

reg [2:0] state_display, n_state_display;

parameter S_PE_IDLE = 0, S_PE_DISPLAY = 1, S_3x3_DISPLAY = 2, S_2x2_DISPLAY = 3, S_DONE_DISPLAY = 4;

reg [3:0] num1, num2;

always @(posedge clk or posedge reset) begin
  if (reset == 1'b1) 
    begin
      num1 <= 4'b0; num2 <= 4'b0;
      state_display <= 3'b0; n_state_display <= 3'b0;
      display_result  <= 8'b0; n_display_result <= 8'b0;
    end
    else begin
      num1 <= num2;
      display_result  <= n_display_result;
      state_display  <= n_state_display;
    end
  end
// display the results
  always @(*) begin
    if (done_capture_displaymemory == 1'b1) begin
      if (num1 == 12) begin
        n_state_display <= S_DONE_DISPLAY;
        n_display_result <= 8'b0;
      end
      else begin
      n_display_result = display_memory[num1];
      num2 = num1 + 1;
        if (num1 == 0) begin
          n_state_display <= S_PE_DISPLAY;
        end
        if (num1 == 4) begin
          n_state_display <= S_3x3_DISPLAY;
        end
        else if (num1 == 8) begin
          n_state_display <= S_2x2_DISPLAY;
        end
        else if (num1 == 12) begin
          n_state_display <= S_DONE_DISPLAY;
        end
      end
    end
  end

  assign state_display_o = state_display;
  assign display_result_o = display_result;
endmodule