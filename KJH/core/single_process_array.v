

module single_process_array(clk,rst,active_single,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,done_single,c11,c12,c21,c22);

    input clk,rst,active_single;
    
    input [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
    
    input [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    output done_single;

    output [7:0] c11,c12,c21,c22;

    reg [7:0] input_data, input_filter;
    reg [1:0] pe_mode;
    wire [7:0] pe_output;

    reg [5:0] state, next_state;
    reg [7:0] c11_output, c12_output, c21_output, c22_output;

    reg done_single_w;

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, 
              S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16, S17 = 17, S18 = 18, 
              S19 = 19, S20 = 20, S21 = 21, S22 = 22, S23 = 23, S24 = 24, S25 = 25, S26 = 26, S27 = 27, 
              S28 = 28, S29 = 29, S30 = 30, S31 = 31, S32 = 32, S33 = 33, S34 = 34, S35 = 35, S36 = 36,
              S37 = 37;

    always @(posedge clk or posedge rst) 
    begin
        if(rst == 1'b1) 
        begin
            state <= S0;
            c11_output <= 8'b0;
            c12_output <= 8'b0;
            c21_output <= 8'b0;
            c22_output <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*)
    begin
        next_state = state;
        
		if (rst == 1'b1)
			next_state <= S0;
		else if(active_single == 1'b1) 
        begin
            pe_mode = 1;
			case (state)
                S0: 
                begin
                    input_data = a11;
                    input_filter = b33;

                    next_state <= S1;
                end
                S1: 
                begin
                    input_data = a12;
                    input_filter = b32;

                    next_state <= S2;
                end
                S2: 
                begin
                    input_data = a13;
                    input_filter = b31;

                    next_state <= S3;
                end
                S3: 
                begin
                    input_data = a21;
                    input_filter = b23;

                    next_state <= S4;
                end
                S4: 
                begin
                    input_data = a22;
                    input_filter = b22;

                    next_state <= S5;
                end
                S5: 
                begin
                    input_data = a23;
                    input_filter = b21;

                    next_state <= S6;
                end
                S6: 
                begin
                    input_data = a31;
                    input_filter = b13;

                    next_state <= S7;
                end
                S7: 
                begin
                    input_data = a32;
                    input_filter = b12;

                    next_state <= S8;
                end
                S8: 
                begin
                    input_data = a33;
                    input_filter = b11;

                    next_state <= S9;
                end
                S9: 
                begin
                    input_data = a12;
                    input_filter = b33;

                    c11_output = pe_output;

                    next_state <= S10;
                end
                S10: 
                begin
                    input_data = a13;
                    input_filter = b32;

                    next_state <= S11;
                end
                S11: 
                begin
                    input_data = a14;
                    input_filter = b31;

                    next_state <= S12;
                end
                S12: 
                begin
                    input_data = a22;
                    input_filter = b23;

                    next_state <= S13;
                end
                S13: 
                begin
                    input_data = a23;
                    input_filter = b22;

                    next_state <= S14;
                end
                S14: 
                begin
                    input_data = a24;
                    input_filter = b21;

                    next_state <= S15;
                end
                S15: 
                begin
                    input_data = a32;
                    input_filter = b13;

                    next_state <= S16;
                end
                S16: 
                begin
                    input_data = a33;
                    input_filter = b12;

                    next_state <= S17;
                end
                S17: 
                begin
                    input_data = a34;
                    input_filter = b11;

                    next_state <= S18;
                end
                S18: 
                begin
                    input_data = a21;
                    input_filter = b33;

                    c12_output = pe_output;

                    next_state <= S19;
                end
                S19: 
                begin
                    input_data = a22;
                    input_filter = b32;

                    next_state <= S20;
                end
                S20: 
                begin
                    input_data = a23;
                    input_filter = b31;

                    next_state <= S21;
                end
                S21: 
                begin
                    input_data = a31;
                    input_filter = b23;

                    next_state <= S22;
                end
                S22: 
                begin
                    input_data = a32;
                    input_filter = b22;

                    next_state <= S23;
                end
                S23: 
                begin
                    input_data = a33;
                    input_filter = b21;

                    next_state <= S24;
                end
                S24: 
                begin
                    input_data = a41;
                    input_filter = b13;

                    next_state <= S25;
                end
                S25: 
                begin
                    input_data = a42;
                    input_filter = b12;

                    next_state <= S26;
                end
                S26: 
                begin
                    input_data = a43;
                    input_filter = b11;

                    next_state <= S27;
                end
                S27: 
                begin
                    input_data = a22;
                    input_filter = b33;

                    c21_output = pe_output;

                    next_state <= S28;
                end
                S28: 
                begin
                    input_data = a23;
                    input_filter = b32;

                    next_state <= S29;
                end
                S29: 
                begin
                    input_data = a24;
                    input_filter = b31;

                    next_state <= S30;
                end
                S30: 
                begin
                    input_data = a32;
                    input_filter = b23;

                    next_state <= S31;
                end
                S31: 
                begin
                    input_data = a33;
                    input_filter = b22;

                    next_state <= S32;
                end
                S32: 
                begin
                    input_data = a34;
                    input_filter = b21;

                    next_state <= S33;
                end
                S33: 
                begin
                    input_data = a42;
                    input_filter = b13;

                    next_state <= S34;
                end
                S34: 
                begin
                    input_data = a43;
                    input_filter = b12;

                    next_state <= S35;
                end
                S35: 
                begin
                    input_data = a44;
                    input_filter = b11;

                    next_state <= S36;
                end
                S36: 
                begin
                    input_data = 8'b0;
                    input_filter = 8'b0;

                    c22_output = pe_output;

                    next_state <= S37;
                end
                S37: 
                begin
                    input_data = 8'b0;
                    input_filter = 8'b0;

                    next_state = 0;

                    done_single_w = 1'b1;
                end
            endcase
        end
    end

    assign done_single = done_single_w;
    assign c11 = c11_output;
    assign c12 = c12_output;
    assign c21 = c21_output;
    assign c22 = c22_output;

endmodule