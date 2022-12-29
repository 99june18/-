

module systolic_array_2_by_2 (clk, rst, active_sa2,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,done_sa2,c11,c12,c21,c22);

    input clk,rst,active_sa2;
    
    input [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
    
    input [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    output done_sa2;

    output [7:0] c11,c12,c21,c22;

    reg [7:0] input_data_1, input_filter_1;
    reg [7:0] input_data_2, input_filter_2;

    reg [4:0] state, next_state;

    wire [7:0] pe1_w, pe2_w, pe3_w, pe4_w;
    wire [7:0] pe1_in_w, pe3_in_w;

    reg [1:0] mode;

    reg done_sa2_w;

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, 
              S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16, S17 = 17, S18 = 18, 
              S19 = 19, S20 = 20, S21 = 21, S22 = 22, S23 = 23, S24 = 24, S25 = 25, S26 = 26, S27 = 27, 
              S28 = 28;

    reg [7:0] input_acc1, input_acc2, input_acc3, input_acc4;
    reg active_acc1, active_acc2, active_acc3, active_acc4;
    wire [7:0] c11_w, c12_w, c21_w, c22_w;

    pe pe_1(.clk(clk), .rst(rst), .pe_in(input_data_1), .pe_filter(input_filter_1), .pe_out(pe1_w), .mode_i(mode),
        .activate(1'b1), .pe_in_o(pe1_in_w), .activate_o());
    pe pe_2(.clk(clk), .rst(rst), .pe_in(pe1_in_w), .pe_filter(input_filter_2), .pe_out(pe2_w), .mode_i(mode),
        .activate(1'b1), .pe_in_o(), .activate_o());
    pe pe_3(.clk(clk), .rst(rst), .pe_in(input_data_2), .pe_filter(pe1_w), .pe_out(pe3_w), .mode_i(mode),
        .activate(1'b1), .pe_in_o(pe3_in_w), .activate_o());
    pe pe_4(.clk(clk), .rst(rst), .pe_in(pe3_in_w), .pe_filter(pe2_w), .pe_out(pe4_w), .mode_i(mode),
        .activate(1'b1), .pe_in_o(), .activate_o());

    accumulator acc_c11(.clk(clk), .rst(rst),
        .acc_vaild(active_acc1), .acc_in(input_acc1), .acc_out(c11_w));
    accumulator acc_c12(.clk(clk), .rst(rst),
        .acc_vaild(active_acc2), .acc_in(input_acc2), .acc_out(c12_w));
    accumulator acc_c21(.clk(clk), .rst(rst),
        .acc_vaild(active_acc3), .acc_in(input_acc3), .acc_out(c21_w));
    accumulator acc_c22(.clk(clk), .rst(rst),
        .acc_vaild(active_acc4), .acc_in(input_acc4), .acc_out(c22_w));

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

        input_data_1 = 0;
        input_filter_1 = 0;
        input_data_2 = 0; 
        input_filter_2 = 0;

        mode = 3;
        done_sa2_w = 0;

        if (rst == 1'b1)
			next_state = S0;
		else if(active_sa2 == 1'b1) 
        begin
            active_acc1 = 1'b0;
            active_acc2 = 1'b0;
            active_acc3 = 1'b0;
            active_acc4 = 1'b0;

			case (state)
                S0: 
                begin
                    mode = 1;

                    input_filter_1 = b23;
                    input_filter_2 = b22;

                    next_state = S1;
                end
                S1: 
                begin
                    mode = 1;

                    input_filter_1 = b33;
                    input_filter_2 = b32;

                    next_state = S2;
                end
                S2: 
                begin
                    mode = 2;

                    input_data_1 = a11;
                    input_data_2 = 8'b0;

                    next_state = S3;
                end
                S3: 
                begin
                    mode = 2;

                    input_data_1 = a12;
                    input_data_2 = a21;

                    next_state = S4;
                end
                S4: 
                begin
                    mode = 2;

                    input_data_1 = a13;
                    input_data_2 = a22;

                    active_acc1 = 1'b1;
                    input_acc1 = pe3_w;
                    
                    next_state = S5;
                end
                S5: 
                begin
                    mode = 2;

                    input_data_1 = a21;
                    input_data_2 = a23;

                    active_acc2 = 1'b1;
                    input_acc2 = pe3_w;

                    next_state = S6;
                end
                S6: 
                begin
                    mode = 2;

                    input_data_1 = a22;
                    input_data_2 = a31;

                    active_acc1 = 1'b1;
                    input_acc1 = pe4_w;

                    next_state = S7;
                end
                S7: 
                begin
                    mode = 2;

                    input_data_1 = a23;
                    input_data_2 = a32;

                    active_acc2 = 1'b1;
                    active_acc3 = 1'b1;
                    input_acc2 = pe4_w;
                    input_acc3 = pe3_w;

                    next_state = S8;
                end
                S8: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = a33;

                    active_acc4 = 1'b1;
                    input_acc4 = pe3_w;

                    next_state = S9;
                end
                S9: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = 0;

                    active_acc3 = 1'b1;
                    input_acc3 = pe4_w;

                    next_state = S10;
                end
                S10: 
                begin
                    mode = 1;

                    input_filter_1 = b21;
                    input_filter_2 = b12;

                    active_acc4 = 1'b1;
                    input_acc4 = pe4_w;

                    next_state = S11;
                end
                S11: 
                begin
                    mode = 1;

                    input_filter_1 = b31;
                    input_filter_2 = b13;

                    next_state = S12;
                end
                S12: 
                begin
                    mode = 2;

                    input_data_1 = a13;
                    input_data_2 = 0;

                    next_state = S13;
                end
                S13: 
                begin
                    mode = 2;

                    input_data_1 = a14;
                    input_data_2 = a23;

                    next_state = S14;
                end
                S14: 
                begin
                    mode = 2;

                    input_data_1 = a23;
                    input_data_2 = a24;

                    active_acc1 = 1'b1;
                    input_acc1 = pe3_w;

                    next_state = S15;
                end
                S15: 
                begin
                    mode = 2;

                    input_data_1 = a24;
                    input_data_2 = a33;

                    active_acc2 = 1'b1;
                    input_acc2 = pe3_w;

                    next_state = S16;
                end
                S16: 
                begin
                    mode = 2;

                    input_data_1 = a31;
                    input_data_2 = a34;

                    active_acc3 = 1'b1;
                    input_acc3 = pe3_w;

                    next_state = S17;
                end
                S17: 
                begin
                    mode = 2;

                    input_data_1 = a32;
                    input_data_2 = a32;

                    active_acc4 = 1'b1;
                    input_acc4 = pe3_w;

                    next_state = S18;
                end
                S18: 
                begin
                    mode = 2;

                    input_data_1 = a41;
                    input_data_2 = a33;

                    next_state = S19;
                end
                S19: 
                begin
                    mode = 2;

                    input_data_1 = a42;
                    input_data_2 = a42;

                    active_acc1 = 1'b1;
                    input_acc1 = pe4_w;

                    next_state = S20;
                end
                S20: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = a43;

                    active_acc2 = 1'b1;
                    input_acc2 = pe4_w;

                    next_state = S21;
                end
                S21: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = 0;

                    active_acc3 = 1'b1;
                    input_acc3 = pe4_w;

                    next_state = S22;
                end
                S22: 
                begin
                    mode = 1;

                    input_filter_1 = 0;
                    input_filter_2 = b11;

                    active_acc4 = 1'b1;
                    input_acc4 = pe4_w;

                    next_state = S23;
                end
                S23: 
                begin
                    mode = 1;

                    input_filter_1 = b11;
                    input_filter_2 = 0;

                    next_state = S24;
                end
                S24: 
                begin
                    mode = 2;

                    input_data_1 = a33;
                    input_data_2 = a34;

                    next_state = S25;
                end
                S25: 
                begin
                    mode = 2;

                    input_data_1 = a43;
                    input_data_2 = a44;

                    next_state = S26;
                end
                S26: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = 0;

                    active_acc1 = 1'b1;
                    input_acc1 = pe3_w;
                    active_acc2 = 1'b1;
                    input_acc2 = pe4_w;

                    next_state = S27;
                end
                S27: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = 0;

                    active_acc3 = 1'b1;
                    input_acc3 = pe3_w;
                    active_acc4 = 1'b1;
                    input_acc4 = pe4_w;

                    next_state = S28;
                end
                S28: 
                begin
                    mode = 2;

                    input_data_1 = 0;
                    input_data_2 = 0;

                    done_sa2_w = 1'b1;

                    next_state = S0;
                end
            endcase
        end
    end

    assign done_sa2 = done_sa2_w;
    assign c11 = c11_w;
    assign c12 = c12_w;
    assign c21 = c21_w;
    assign c22 = c22_w;

endmodule