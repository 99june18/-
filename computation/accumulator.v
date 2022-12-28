module accumulator(clk, rst, acc_vaild, acc_in, acc_out);

    input clk;
    input rst;

    input [7 : 0] acc_in; //8bit 곱셈기에서 나온 값
    input acc_vaild;      // vaild 신호가 있어야 acc작동한다

    output [7 : 0] acc_out; //acc 결과값
    reg [7 : 0] acc, acc_n; //값 임시 저장

    reg [3 : 0] count, count_n; //9까지 세야함

    wire [7 : 0] acc_w; // 8bit 덧셈기에서 나온 값

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            acc <= 8'd0;
            count <= 4'b0;
        end
        else begin
            acc <= acc_n;
            count <= count_n;
        end
    end

    always @(*) begin
        if (acc_vaild == 1'b1) begin
            if (count == 4'b1001) begin
                count_n = 4'b0001;
                acc_n = acc_in;
            end
            else begin
                acc_n = acc_w;
                count_n = count + 1;
            end
        end
        else begin
            acc_n = acc;
            count_n = count;
        end
    end

    eight_bit_full_adder_module eight_bit_full_adder(.a(acc), .b(acc_in), .cin(1'b0), .sum(acc_w), .cout());

    assign acc_out = acc;
endmodule