module pe (clk, rst, pe_in, pe_filter, pe_out, mode_i, activate, pe_in_o);
    input clk;
    input rst;

    input [7:0] pe_in; // pe에 들어오는 input값
    input [7:0] pe_filter; // pe에 들어오는 filter값
    input [1:0] mode_i;
    input activate;

    output [7:0] pe_in_o;
    output [7:0] pe_out; //pe에서의 결과값

    reg [7:0] pe_n, pe_w;
    reg [7:0] activate_n, activate_w;
    reg [1:0] mode_n, mode_w;
    reg [7:0] sum_out_n, sum_out_w;
    reg [7:0] data, data_w;

    wire [7:0] mul_out;
    wire [7:0] acc_out;
    wire [7:0] sum_out;

    parameter
    single_mode  = 0, 
    save_mode    = 1, 
    sa_mode    = 2,
    initial_mode = 3;

    //저장용 ff
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            data <= 8'b0;
        end else begin
            data <= data_w;
        end
    end

    always @ (*)
    begin
        data_w = data;
        if (mode_i == save_mode) begin
        data_w = pe_filter;
        end
	end

    //타이밍용 ff 3개
    always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
            pe_n        <= 8'b0;
            sum_out_n     <= 8'b0;
            mode_n        <= initial_mode;
        end else begin
			pe_n          <= pe_w;
            sum_out_n   <= sum_out_w;
            mode_n      <= mode_w;
        end
	end

    always @ (*)
	begin
        pe_w             = pe_n;            
        if (mode_i != initial_mode) begin
            pe_w             = pe_in;
        end
        mode_w          = mode_i;
        sum_out_w       = sum_out_n;
        if (activate && mode_i != initial_mode) begin
            sum_out_w       = sum_out;
        end
	end
   
    //mux 2 to 1
    reg [7:0] mux_out;
    always@(*)
	begin
		if (mode_i == single_mode)
			mux_out = pe_filter;
		else
			mux_out = data;
	end

    //mux 4 to 1
    reg [7:0] mux2_out;
    always@(*)
	begin
		if (mode_n == single_mode)
			mux2_out = acc_out;
		else if (mode_n == sa_mode)
			mux2_out = sum_out_n;
        else if (mode_n == save_mode)
			mux2_out = data;
        else
            mux2_out = 0;
	end

    eight_bit_multiplier_module eight_bit_multiplier(.a(pe_in), .b(mux_out), .out (mul_out));

    accumulator u_accumulator(
        .clk       ( clk       ),
        .rst       ( rst       ),
        .acc_vaild ( mode_i == single_mode ),
        .acc_in    ( mul_out  ),
        .acc_out   ( acc_out   )
    );

    eight_bit_full_adder_module u_eight_bit_full_adder_module(.a(mul_out), .b(pe_filter), .cin(1'b0), .sum(sum_out), .cout (  ));

    assign pe_out = mux2_out;
    assign pe_in_o = pe_n;

endmodule