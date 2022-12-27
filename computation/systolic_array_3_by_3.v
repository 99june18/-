

module systolic_array_3_by_3 (clk, rst, active_sa3,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,done_sa3,c11,c12,c21,c22);

    input clk,rst,active_sa3;
    
    input [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
    
    input [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    output done_sa3;

    output [7:0] c11,c12,c21,c22;

    reg [7:0] input_data_1, input_filter_1;
    reg [7:0] input_data_2, input_filter_2;
    reg [7:0] input_data_3, input_filter_3;

    reg [5:0] state, next_state;

    wire [7:0] pe1_w, pe2_w, pe3_w, pe4_w, pe5_w, pe6_w, pe7_w, pe8_w, pe9_w;
    wire [7:0] pe1_in_w, pe2_in_w, pe4_in_w, pe5_in_w, pe7_in_w, pe8_in_w;

    reg [1:0] mode1, mode2, mode3;
    wire [1:0] mode_w1, mode_w2, mode_w3, mode_w4, mode_w5, mode_w6;

    wire active_w1, active_w2, active_w3, active_w4, active_w5, active_w6;
    reg done_sa3_w;

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, 
              S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16;


    //acc port
    
    reg [7:0] input_acc1, input_acc2, input_acc3, input_acc4;
    reg active_acc1, active_acc2, active_acc3, active_acc4;
    wire [7:0] c11_w, c12_w, c21_w, c22_w;

    always @(posedge clk or posedge rst) 
    begin
        if(rst == 1'b1) 
        begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;

        if (rst == 1'b1)
			next_state <= S0;
		else if(active_sa3 == 1'b1) 
        begin
            active_acc1 = 1'b1;
            active_acc2 = 1'b1;
            active_acc3 = 1'b1;
            active_acc4 = 1'b1;

			case (state)
                S0: 
                begin
                    mode1 = 2;
                    mode2 = 2;
                    mode3 = 2;

                    input_filter_1 = b31;
                    input_filter_2 = b32;
                    input_filter_3 = b33;

                    next_state <= S1;
                end
                S1: 
                begin
                    mode1 = 2;
                    mode2 = 2;
                    mode3 = 2;

                    input_filter_1 = b21;
                    input_filter_2 = b22;
                    input_filter_3 = b23;

                    next_state <= S2;
                end
                S2: 
                begin
                    mode1 = 2;
                    mode2 = 2;
                    mode3 = 2;

                    input_filter_1 = b11;
                    input_filter_2 = b12;
                    input_filter_3 = b13;

                    next_state <= S3;
                end
                S3: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a11;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    next_state <= S4;
                end
                S4: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a12;
                    input_data_2 = a21;
                    input_data_3 = 8'b0;

                    next_state <= S5;
                end
                S5: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a13;
                    input_data_2 = a22;
                    input_data_3 = a31;

                    next_state <= S6;
                end
                S6: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a14;
                    input_data_2 = a23;
                    input_data_3 = a32;

                    input_acc1 = pe7_w;

                    next_state <= S7;
                end
                S7: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a21;
                    input_data_2 = a24;
                    input_data_3 = a33;

                    input_acc2 = pe7_w;

                    next_state <= S8;
                end
                S8: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a22;
                    input_data_2 = a31;
                    input_data_3 = a34;

                    input_acc1 = pe8_w;

                    next_state <= S9;
                end
                S9: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a23;
                    input_data_2 = a32;
                    input_data_3 = a41;

                    input_acc2 = pe8_w;

                    next_state <= S10;
                end
                S10: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = a24;
                    input_data_2 = a33;
                    input_data_3 = a42;

                    input_acc3 = pe7_w;
                    input_acc1 = pe9_w;

                    next_state <= S11;
                end
                S11: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = a34;
                    input_data_3 = a43;

                    input_acc4 = pe7_w;
                    input_acc2 = pe9_w;

                    next_state <= S12;
                end
                S12: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = a44;

                    input_acc3 = pe8_w;

                    next_state <= S13;
                end
                S13: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc4 = pe8_w;

                    next_state <= S14;
                end
                S14: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc3 = pe9_w;

                    next_state <= S15;
                end
                S15: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc4 = pe9_w;

                    next_state <= S16;
                end
                S16: 
                begin
                    mode1 = 3;
                    mode2 = 3;
                    mode3 = 3;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    done_sa3_w = 1'b1;

                    next_state <= 0;
                end
                
            endcase
        end
    end

    assign done_sa3 = done_sa3_w;
    assign c11 = c11_w;
    assign c12 = c12_w;
    assign c21 = c21_w;
    assign c22 = c22_w;

endmodule