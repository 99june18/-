module pe (clk, rst, pe_in, pe_filter, pe_out);
    input clk;
    input rst;

    input [7 : 0] pe_in;
    input [7 : 0] pe_filter;
    reg [7 : 0] pe_i;
    reg [7 : 0] pe_f;

    output [7 : 0] pe_out;

    // reg
    wire [7 : 0] mul_out;
    wire [7 : 0] acc_out;
    reg [7 : 0] pe_o;
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
    accumulator accumulator_1( .clk(clk), .rst(rst), .acc_in(mul_out), .acc_out(acc_out), .count_9(count_9));

    always @(*) begin
        if (count_9) begin
            pe_o <= acc_out;
        end
    end

    assign pe_out = pe_o;


endmodule