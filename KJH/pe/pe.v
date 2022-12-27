module pe (clk, rst, pe_in, pe_filter, pe_out, mode_i, activate, pe_in_o, activate_o,mode_o);
    input clk;
    input rst;

    input [7:0] pe_in; // pe에 들어오는 input값
    input [7:0] pe_filter; // pe에 들어오는 filter값
    input [1:0] mode_i;
    input activate;

    output [7:0] pe_in_o;
    output [7:0] pe_out; //pe에서의 결과값
    output activate_o;
    output [1:0] mode_o;

    reg [7:0] pe_w;
    reg [7:0] activate_w;
    reg [1:0] mode_w;
    reg [7:0] sum_out_w;
    reg [7:0] data, data_w;

    wire [7 : 0] mul_out;
    wire [7 : 0] acc_out;
    wire [7 : 0] sum_out;

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
        if (mode_i == 2) begin
        data_w = pe_filter;
        end
	end

    //타이밍용 ff 4개
    d_flip_flop_behavioral_module u_d_flip_flop_behavioral_module_1(
        .d   ( pe_in ),
        .clk ( clk ),
        .q   ( pe_w   ),
        .q_bar ( )
    );
    d_flip_flop_behavioral_module u_d_flip_flop_behavioral_module_2(
        .d   ( activate   ),
        .clk ( clk ),
        .q   ( activate_w ),
        .q_bar ( )
    );
    d_flip_flop_behavioral_module u_d_flip_flop_behavioral_module_3(
        .d   ( mode_i ),
        .clk ( clk ),
        .q   ( mode_w ),
        .q_bar ( )
    );
    d_flip_flop_behavioral_module u_d_flip_flop_behavioral_module_4(
        .d   ( sum_out   ),
        .clk ( clk ),
        .q   ( sum_out_w ),
        .q_bar ( )
    );

    reg [7:0] mux_out;
    //mux 2 to 1
    always@(*)
	begin
		if (mode_i == 0)
			mux_out = pe_filter;
		else
			mux_out = data;
	end

    //mux 4 to 1
    reg [7:0] mux2_out;
    always@(*)
	begin
		if (mode_i == 0)
			mux2_out = acc_out;
		else if (mode_i == 1)
			mux2_out = sum_out_w;
        else if (mode_i == 2)
			mux2_out = data;
        else
            mux2_out = 0;
	end

    eight_bit_multiplier_module eight_bit_multiplier( .a(mux_out), .b(pe_in), .out (mul_out));
    accumulator accumulator_1( .clk(clk), .rst(rst), .acc_vaild(mode_i == 0), .acc_in(mul_out), .acc_out(acc_out), .count_9( ));
    eight_bit_full_adder_module u_eight_bit_full_adder_module(.a(mul_out), .b(pe_filter), .cin(1'b0), .sum(sum_out), .cout (  ));

    assign pe_out = mux2_out;
    assign pe_in_o = pe_w;
    assign activate_o = activate_w;
    assign mode_o = mode_i;

endmodule