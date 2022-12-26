module memory (clk, reset, run_valid_i, done_capture, 
a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
b11, b12, b13, b21, b22, b23, b31, b32, b33, c11, c12, c21, c22,
PE_valid_i, SA_3x3_valid_i, SA_2x2_valid_i,
addr_core, data_core_o, addr_display, data_display_o);

	input clk; 
	input reset;

  input run_valid_i; // == state_write : data is captured one clock later than init_valid_i rising.
                    
  output reg done_capture;

  input [7:0]
    a11,a12,a13,a14,
    a21,a22,a23,a24,
    a31,a32,a33,a34,
    a41,a42,a43,a44;
  input [7:0]
    b11,b12,b13,
    b21,b22,b23,
    b31,b32,b33;
  input [7:0] 
    c11,c12,
    c21,c22; // cmem[0:3]->single, cmem[4:7]->sys3, cmem[8,11]->sys2


  input PE_valid_i; // will insert to cmem[0:3]
  input SA_3x3_valid_i;   // will insert to cmem[4:7]
  input SA_2x2_valid_i;   // will insert to cmem[8:11]

  input [4:0] addr_core;
  output [7:0] data_core_o;
  wire [7:0] data_to_core_wire;
    
  input [3:0] addr_display;
  output [7:0] data_display_o;
  wire [7:0] data_display_wire;
    
  // memory of a [0:15] and b [16:24]
  reg [7:0] memory_ab [0:24];
  // memory of result from computation, PE [0:3], SA_3x3 [4:7], SA_2x2 [8:11]
  reg [7:0] memory_result [0:11];


  initial
    done_capture <= 1'b0;

  // capture input to memory
  always @(posedge clk or posedge reset) 
  begin
    if(reset == 1'b1) begin
      memory_ab[0] <= 8'b0; memory_ab[1] <= 8'b0; memory_ab[2] <= 8'b0; memory_ab[3] <= 8'b0;
      memory_ab[4] <= 8'b0; memory_ab[5] <= 8'b0; memory_ab[6] <= 8'b0; memory_ab[7] <= 8'b0;
      memory_ab[8] <= 8'b0; memory_ab[9] <= 8'b0; memory_ab[10] <= 8'b0; memory_ab[11] <= 8'b0;
      memory_ab[12] <= 8'b0; memory_ab[13] <= 8'b0; memory_ab[14] <= 8'b0; memory_ab[15] <= 8'b0;
      memory_ab[16] <= 8'b0; memory_ab[17] <= 8'b0; memory_ab[18] <= 8'b0;
      memory_ab[19] <= 8'b0; memory_ab[20] <= 8'b0; memory_ab[21] <= 8'b0;
      memory_ab[22] <= 8'b0; memory_ab[23] <= 8'b0; memory_ab[24] <= 8'b0;
      // done_capture <= 1'b0;
    end 
    else if (run_valid_i) begin
      memory_ab[0] <= a11; memory_ab[1] <= a12; memory_ab[2] <= a13; memory_ab[3]  <= a14;
      memory_ab[4] <= a21; memory_ab[5] <= a22; memory_ab[6] <= a23; memory_ab[7]  <= a24;
      memory_ab[8] <= a31; memory_ab[9] <= a32; memory_ab[10] <= a33; memory_ab[11] <= a34;
      memory_ab[12] <= a41; memory_ab[13] <= a42; memory_ab[14] <= a43; memory_ab[15] <= a44;
      memory_ab[16] <= b11; memory_ab[17] <= b12; memory_ab[18] <= b13;
      memory_ab[19] <= b21; memory_ab[20] <= b22; memory_ab[21] <= b23;
      memory_ab[22] <= b31; memory_ab[23] <= b32; memory_ab[24] <= b33;
      done_capture <= 1'b1;
    end else begin
      //done_capture <= 1'b0;
    end
  end

  always @(posedge clk or posedge reset) 
  begin
    if(reset == 1'b1) begin
      memory_result[0] <= 8'b0; memory_result[1] <= 8'b0; 
      memory_result[2] <= 8'b0; memory_result[3] <= 8'b0; 
      memory_result[4] <= 8'b0; memory_result[5] <= 8'b0; 
      memory_result[6] <= 8'b0; memory_result[7] <= 8'b0; 
      memory_result[8] <= 8'b0; memory_result[9] <= 8'b0; 
      memory_result[10] <= 8'b0; memory_result[11] <= 8'b0; 
    end 
    else if (PE_valid_i == 1'b1) begin
      memory_result[0] <= c11; memory_result[1] <= c12; 
      memory_result[2] <= c21; memory_result[3] <= c22; 
    end 
    else if (SA_3x3_valid_i == 1'b1) begin
      memory_result[4] <= c11; memory_result[5] <= c12; 
      memory_result[6] <= c21; memory_result[7] <= c22; 
    end 
    else if (SA_2x2_valid_i == 1'b1) begin
      memory_result[8] <= c11; memory_result[9] <= c12; 
      memory_result[10] <= c21; memory_result[11] <= c22; 
    end
  end


endmodule