module pe (clk, rst, pe_in, pe_filter, pe_out, mode_i, single_count_9);
    input clk;
    input rst;

    input [7 : 0] pe_in; // pe에 들어오는 input값
    input [7 : 0] pe_filter; // pe에 들어오는 filter값
    input [1:0] mode_i;
    reg [7 : 0] pe_i;
    reg [7 : 0] pe_f;

    output [7 : 0] pe_out; //pe에서의 결과값
    output single_count_9; // single pe 계산에서 9번째 값일 때 1
    reg [7 : 0] pe_o;
    reg single_cnt_9;

    // wire
    wire [7 : 0] mul_out;
    wire [7 : 0] acc_out;
    wire count_9;


    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            pe_i <= 8'b0;
            pe_f <= 8'b0;
        end
        else begin
            pe_i <= pe_in;
            pe_f <= pe_filter;
        end
    end

    eight_bit_multiplier_module eight_bit_multiplier( .a(pe_i), .b(pe_f), .out (mul_out));
    accumulator accumulator_1( .clk(clk), .rst(rst), .acc_vaild(mode_i), .acc_in(mul_out), .acc_out(acc_out), .count_9(count_9));

    always @(*) begin
        pe_o = acc_out;
        if (count_9 == 1) begin
            single_cnt_9 = 1;
        end
        else begin
            single_cnt_9 = 0;
        end
    end

    assign pe_out = pe_o;
    assign single_count_9 = single_cnt_9;

endmodule