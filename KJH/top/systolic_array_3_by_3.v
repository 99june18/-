

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

    reg [4:0] state, next_state;

    wire [7:0] pe1_w, pe2_w, pe3_w, pe4_w, pe5_w, pe6_w, pe7_w, pe8_w, pe9_w;
    wire [7:0] pe1_in_w, pe2_in_w, pe4_in_w, pe5_in_w, pe7_in_w, pe8_in_w;

    reg [1:0] mode;
    reg done_sa3_w;

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, 
              S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16;


    pe u_pe_1(.clk(clk),.rst(rst),.pe_in(input_data_1),.pe_filter(input_filter_1),.pe_out(pe1_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe1_in_w));
    pe u_pe_2(.clk(clk),.rst(rst),.pe_in(pe1_in_w),.pe_filter(input_filter_2),.pe_out(pe2_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe2_in_w));
    pe u_pe_3(.clk(clk),.rst(rst),.pe_in(pe2_in_w),.pe_filter(input_filter_3),.pe_out(pe3_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o( ));
    
    pe u_pe_4(.clk(clk),.rst(rst),.pe_in(input_data_2),.pe_filter(pe1_w),.pe_out(pe4_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe4_in_w));
    pe u_pe_5(.clk(clk),.rst(rst),.pe_in(pe4_in_w),.pe_filter(pe2_w),.pe_out(pe5_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe5_in_w));
    pe u_pe_6(.clk(clk),.rst(rst),.pe_in(pe5_in_w),.pe_filter(pe3_w),.pe_out(pe6_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o( ));
    
    pe u_pe_7(.clk(clk),.rst(rst),.pe_in(input_data_3),.pe_filter(pe4_w),.pe_out(pe7_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe7_in_w));
    pe u_pe_8(.clk(clk),.rst(rst),.pe_in(pe7_in_w),.pe_filter(pe5_w),.pe_out(pe8_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o(pe8_in_w));
    pe u_pe_9(.clk(clk),.rst(rst),.pe_in(pe8_in_w),.pe_filter(pe6_w),.pe_out(pe9_w),
    .mode_i(mode), .activate(1'b1),.pe_in_o( ));

    //acc port
    reg [7:0] input_acc1, input_acc2, input_acc3, input_acc4;
    reg active_acc1, active_acc2, active_acc3, active_acc4;
    wire [7:0] c11_w, c12_w, c21_w, c22_w;

    accumulator u_accumulator_systolic_1
    (.clk(clk), .rst(rst), .acc_vaild (active_acc1), .acc_in(input_acc1), .acc_out(c11_w));
    accumulator u_accumulator_systolic_2
    (.clk(clk), .rst(rst), .acc_vaild (active_acc2), .acc_in(input_acc2), .acc_out(c12_w));
    accumulator u_accumulator_systolic_3
    (.clk(clk), .rst(rst), .acc_vaild (active_acc3), .acc_in(input_acc3), .acc_out(c21_w));
    accumulator u_accumulator_systolic_4
    (.clk(clk), .rst(rst), .acc_vaild (active_acc4), .acc_in(input_acc4), .acc_out(c22_w));


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
        input_data_3 = 0; 
        input_filter_3 = 0;

        mode = 3;
        done_sa3_w = 0;

        if (rst == 1'b1)
			next_state = S0;
		else if(active_sa3 == 1'b1) 
        begin
            active_acc1 = 1'b0;
            active_acc2 = 1'b0;
            active_acc3 = 1'b0;
            active_acc4 = 1'b0;
            
			case (state)
                S0: 
                begin
                    mode = 1;

                    input_filter_1 = b13;
                    input_filter_2 = b12;
                    input_filter_3 = b11;

                    next_state = S1;
                end
                S1: 
                begin
                    mode = 1;

                    input_filter_1 = b23;
                    input_filter_2 = b22;
                    input_filter_3 = b21;

                    next_state = S2;
                end
                S2: 
                begin
                    mode = 1;

                    input_filter_1 = b33;
                    input_filter_2 = b32;
                    input_filter_3 = b31;

                    next_state = S3;
                end
                S3: 
                begin
                    mode = 2;

                    input_data_1 = a11;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    next_state = S4;
                end
                S4: 
                begin
                    mode = 2;

                    input_data_1 = a12;
                    input_data_2 = a21;
                    input_data_3 = 8'b0;

                    next_state = S5;
                end
                S5: 
                begin
                    mode = 2;

                    input_data_1 = a13;
                    input_data_2 = a22;
                    input_data_3 = a31;

                    next_state = S6;
                end
                S6: 
                begin
                    mode = 2;

                    input_data_1 = a14;
                    input_data_2 = a23;
                    input_data_3 = a32;

                    input_acc1 = pe7_w;
                    active_acc1 = 1'b1;

                    next_state = S7;
                end
                S7: 
                begin
                    mode = 2;

                    input_data_1 = a21;
                    input_data_2 = a24;
                    input_data_3 = a33;

                    input_acc2 = pe7_w;
                    active_acc2 = 1'b1;

                    next_state = S8;
                end
                S8: 
                begin
                    mode = 2;

                    input_data_1 = a22;
                    input_data_2 = a31;
                    input_data_3 = a34;

                    input_acc1 = pe8_w;
                    active_acc1 = 1'b1;

                    next_state = S9;
                end
                S9: 
                begin
                    mode = 2;

                    input_data_1 = a23;
                    input_data_2 = a32;
                    input_data_3 = a41;

                    input_acc2 = pe8_w;
                    active_acc2 = 1'b1;

                    next_state = S10;
                end
                S10: 
                begin
                    mode = 2;

                    input_data_1 = a24;
                    input_data_2 = a33;
                    input_data_3 = a42;

                    input_acc3 = pe7_w;
                    input_acc1 = pe9_w;
                    active_acc3 = 1'b1;
                    active_acc1 = 1'b1;

                    next_state = S11;
                end
                S11: 
                begin
                    mode = 2;

                    input_data_1 = 8'b0;
                    input_data_2 = a34;
                    input_data_3 = a43;

                    input_acc4 = pe7_w;
                    input_acc2 = pe9_w;
                    active_acc4 = 1'b1;
                    active_acc2 = 1'b1;

                    next_state = S12;
                end
                S12: 
                begin
                    mode = 2;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = a44;

                    input_acc3 = pe8_w;
                    active_acc3 = 1'b1;

                    next_state = S13;
                end
                S13: 
                begin
                    mode = 2;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc4 = pe8_w;
                    active_acc4 = 1'b1;

                    next_state = S14;
                end
                S14: 
                begin
                    mode = 2;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc3 = pe9_w;
                    active_acc3 = 1'b1;

                    next_state = S15;
                end
                S15: 
                begin
                    mode = 2;
                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    input_acc4 = pe9_w;
                    active_acc4 = 1'b1;

                    next_state = S16;
                end
                S16: 
                begin
                    mode = 2;

                    input_data_1 = 8'b0;
                    input_data_2 = 8'b0;
                    input_data_3 = 8'b0;

                    done_sa3_w = 1'b1;

                    next_state = 0;
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