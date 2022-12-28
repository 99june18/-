module pe (clk, rst, pe_in, pe_filter, pe_out, mode_in);
    input clk;
    input rst;

    input [7 : 0] pe_in; // pe에 들어오는 input값
    input [7 : 0] pe_filter; // pe에 들어오는 filter값
    input [1:0] mode_in;
    reg [7 : 0] pe_i, pe_i_n;
    reg [7 : 0] pe_f, pe_f_n;
    reg [1 : 0] mode, mode_n;

    output [7 : 0] pe_out; //pe에서의 결과값
    reg [7 : 0] pe_o;

    // wire
    wire [7 : 0] mul_out;
    wire [7 : 0] acc_out;

    parameter
    reset_mode       = 0,
    accumulator_mode = 1;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            pe_i <= 8'b0;
            pe_f <= 8'b0;
            mode <= reset_mode;
        end
        else begin
            pe_i <= pe_i_n;
            pe_f <= pe_f_n;
            mode <= mode_n;
        end
    end

    always @ (*)
	begin
        mode_n = mode_in;
        pe_f_n = pe_f;
        pe_i_n = pe_i; 
        if (mode_in != reset_mode) begin
        pe_i_n = pe_in;
        pe_f_n = pe_filter;
        end
        
	end

    eight_bit_multiplier_module eight_bit_multiplier( .a(pe_in), .b(pe_filter), .out (mul_out));
    accumulator_single accumulator_1( .clk(clk), .rst(rst), .acc_vaild(mode_in == accumulator_mode), .acc_in(mul_out), .acc_out(acc_out));

    always @(*) begin
        case(mode)
        reset_mode       : pe_o = 8'd0;
        accumulator_mode : pe_o = acc_out;
        default          : pe_o = 8'd0; 
        endcase
    end

    assign pe_out = pe_o;

endmodule