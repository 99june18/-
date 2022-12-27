module memory (clk, reset, run_valid_i, done_capture, 
a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44,
b11, b12, b13, b21, b22, b23, b31, b32, b33, c11, c12, c21, c22,
a11_o, a12_o, a13_o, a14_o, a21_o, a22_o, a23_o, a24_o, a31_o, a32_o, a33_o, a34_o, a41_o, a42_o, a43_o, a44_o,
b11_o, b12_o, b13_o, b21_o, b22_o, b23_o, b31_o, b32_o, b33_o, 
c11_PE, c12_PE, c21_PE, c22_PE, c11_3x3, c12_3x3, c21_3x3, c22_3x3, c11_2x2, c12_2x2, c21_2x2, c22_2x2,
PE_valid_i, SA_3x3_valid_i, SA_2x2_valid_i,
addr_core, data_core_o, addr_display, data_display_o);

	input clk; 
	input reset;

  input run_valid_i; // == state_write : data is captured one clock later than init_valid_i rising.
                    
  output reg done_capture;

  input [7:0]
    a11, a12, a13, a14,
    a21, a22, a23, a24,
    a31, a32, a33, a34,
    a41, a42, a43, a44;
  input [7:0]
    b11, b12, b13,
    b21, b22, b23,
    b31, b32, b33;
  input [7:0] 
    c11, c12,
    c21, c22; // cmem[0:3]->single, cmem[4:7]->sys3, cmem[8,11]->sys2

  output [7:0]
    a11_o, a12_o, a13_o, a14_o,
    a21_o, a22_o, a23_o, a24_o,
    a31_o, a32_o, a33_o, a34_o,
    a41_o, a42_o, a43_o, a44_o;
  output [7:0]
    b11_o, b12_o, b13_o, 
    b21_o, b22_o, b23_o, 
    b31_o, b32_o, b33_o;

  output [7:0] 
    c11_PE, c12_PE, 
    c21_PE, c22_PE;
  output [7:0]
    c11_3x3, c12_3x3,
    c21_3x3, c22_3x3;
  output [7:0]
    c11_2x2, c12_2x2,
    c21_2x2, c22_2x2;



  input PE_valid_i; // will insert to cmem[0:3]
  input SA_3x3_valid_i;   // will insert to cmem[4:7]
  input SA_2x2_valid_i;   // will insert to cmem[8:11]

  input [4:0] addr_core;
  output [7:0] data_core_o;
  wire [7:0] data_core_wire;
    
  input [3:0] addr_display;
  output [7:0] data_display_o;
  wire [7:0] data_display_wire;
    
  // memory of input
  reg [7:0] memory_input [0:15];
  // memory of filter
  reg [7:0] memory_filter [0:8];
  // memory of result from computation, PE [0:3], SA_3x3 [4:7], SA_2x2 [8:11]
  reg [7:0] memory_result [0:11];


  initial
    done_capture <= 1'b0;

  // capture input to memory
  always @(posedge clk or posedge reset) 
  begin
    if (reset == 1'b1) begin
      memory_input[0] <= 8'b0; memory_input[1] <= 8'b0; memory_input[2] <= 8'b0; memory_input[3] <= 8'b0;
      memory_input[4] <= 8'b0; memory_input[5] <= 8'b0; memory_input[6] <= 8'b0; memory_input[7] <= 8'b0;
      memory_input[8] <= 8'b0; memory_input[9] <= 8'b0; memory_input[10] <= 8'b0; memory_input[11] <= 8'b0;
      memory_input[12] <= 8'b0; memory_input[13] <= 8'b0; memory_input[14] <= 8'b0; memory_input[15] <= 8'b0;

      memory_filter[0] <= 8'b0; memory_filter[1] <= 8'b0; memory_filter[2] <= 8'b0;
      memory_filter[3] <= 8'b0; memory_filter[4] <= 8'b0; memory_filter[5] <= 8'b0;
      memory_filter[6] <= 8'b0; memory_filter[7] <= 8'b0; memory_filter[8] <= 8'b0;
      // done_capture <= 1'b0;
    end 
    else if (run_valid_i) begin
      memory_input[0] <= a11; memory_input[1] <= a12; memory_input[2] <= a13; memory_input[3]  <= a14;
      memory_input[4] <= a21; memory_input[5] <= a22; memory_input[6] <= a23; memory_input[7]  <= a24;
      memory_input[8] <= a31; memory_input[9] <= a32; memory_input[10] <= a33; memory_input[11] <= a34;
      memory_input[12] <= a41; memory_input[13] <= a42; memory_input[14] <= a43; memory_input[15] <= a44;
      
      memory_filter[0] <= b11; memory_filter[1] <= b12; memory_filter[2] <= b13;
      memory_filter[3] <= b21; memory_filter[4] <= b22; memory_filter[5] <= b23;
      memory_filter[6] <= b31; memory_filter[7] <= b32; memory_filter[8] <= b33;
      done_capture <= 1'b1;
    end else begin
      //done_capture <= 1'b0;
    end
  end

  always @(posedge clk or posedge reset) 
  begin
    if (reset == 1'b1) begin
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


  assign a11_o = memory_input[0];
  assign a12_o = memory_input[1];
  assign a13_o = memory_input[2];
  assign a14_o = memory_input[3];

  assign a21_o = memory_input[4];
  assign a22_o = memory_input[5];
  assign a23_o = memory_input[6];
  assign a24_o = memory_input[7];

  assign a31_o = memory_input[8];
  assign a32_o = memory_input[9];
  assign a33_o = memory_input[10];
  assign a34_o = memory_input[11];

  assign a41_o = memory_input[12];
  assign a42_o = memory_input[13];
  assign a43_o = memory_input[14];
  assign a44_o = memory_input[15];

  assign b11_o = memory_filter[0];
  assign b12_o = memory_filter[1];
  assign b13_o = memory_filter[2];

  assign b21_o = memory_filter[3];
  assign b22_o = memory_filter[4];
  assign b23_o = memory_filter[5];

  assign b31_o = memory_filter[6];
  assign b32_o = memory_filter[7];
  assign b33_o = memory_filter[8];
  
  assign c11_PE = memory_result[0];
  assign c12_PE = memory_result[1];
  assign c21_PE = memory_result[2];
  assign c22_PE = memory_result[3];

  assign c11_3x3 = memory_result[4];
  assign c12_3x3 = memory_result[5];
  assign c21_3x3 = memory_result[6];
  assign c22_3x3 = memory_result[7];

  assign c11_2x2= memory_result[8];
  assign c12_2x2 = memory_result[9];
  assign c21_2x2 = memory_result[10];
  assign c22_2x2 = memory_result[11];

endmodule