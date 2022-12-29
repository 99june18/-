

module core_module (clk,rst,active_send,active_single,active_sa3,active_sa2,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,c11,c12,c21,c22,done_send,done_single,done_sa3,done_sa2);

    input clk, rst;
    input active_send, active_single, active_sa3, active_sa2;

    input [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
                
    input [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    output [7:0] c11,c12,c21,c22;
    output done_send, done_single, done_sa3, done_sa2;

    wire [7:0] c11_single, c12_single, c21_single, c22_single;
    wire [7:0] c11_sa3, c12_sa3, c21_sa3, c22_sa3;
    wire [7:0] c11_sa2, c12_sa2, c21_sa2, c22_sa2;

    reg [7:0] c11_w,c12_w,c21_w,c22_w;

    always @ (*) begin
        if (active_single == 1'b1) begin
            c11_w = c11_single; 
            c12_w = c12_single;
            c21_w = c21_single; 
            c22_w = c22_single;
        end else if (active_sa3 == 1'b1) begin
            c11_w = c11_sa3; 
            c12_w = c12_sa3;
            c21_w = c21_sa3; 
            c22_w = c22_sa3;
        end else if (active_sa2 == 1'b1) begin
            c11_w = c11_sa2; 
            c12_w = c12_sa2;
            c21_w = c21_sa2; 
            c22_w = c22_sa2;
        end else begin
            c11_w = 8'b0; 
            c12_w = 8'b0; 
            c21_w = 8'b0; 
            c22_w = 8'b0;
        end
    end

    reg activate_n, activate_w;

    always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
            activate_n <= 1'b0;
        end else begin
            activate_n <= activate_w;
        end
	end

    always @ (*)
	begin
        activate_w = activate_n;

        if (active_send == 1'b1) begin
            activate_w = active_send;
        end else begin
            activate_w = 0;
        end
	end

    //single
    single_process_array u_single_process_array(
        .clk           ( clk           ),
        .rst           ( rst           ),
        .active_single ( active_single ),
        .a11           ( a11           ),
        .a12           ( a12           ),
        .a13           ( a13           ),
        .a14           ( a14          ),
        .a21           ( a21           ),
        .a22           ( a22           ),
        .a23           ( a23           ),
        .a24           ( a24          ),
        .a31           ( a31           ),
        .a32           ( a32           ),
        .a33           ( a33           ),
        .a34           ( a34           ),
        .a41           ( a41           ),
        .a42           ( a42           ),
        .a43           ( a43           ),
        .a44           ( a44          ),
        .b11           ( b11           ),
        .b12           ( b12           ),
        .b13           ( b13           ),
        .b21           ( b21           ),
        .b22           ( b22           ),
        .b23           ( b23           ),
        .b31           ( b31           ),
        .b32           ( b32           ),
        .b33           ( b33           ),
        .done_single   ( done_single   ),
        .c11           ( c11_single           ),
        .c12           ( c12_single           ),
        .c21           ( c21_single           ),
        .c22           ( c22_single           )
    );

    //sa3
    systolic_array_3_by_3 u_systolic_array_3_by_3(
        .clk        ( clk        ),
        .rst        ( rst        ),
        .active_sa3 ( active_sa3 ),
        .a11           ( a11           ),
        .a12           ( a12           ),
        .a13           ( a13           ),
        .a14           ( a14          ),
        .a21           ( a21           ),
        .a22           ( a22           ),
        .a23           ( a23           ),
        .a24           ( a24          ),
        .a31           ( a31           ),
        .a32           ( a32           ),
        .a33           ( a33           ),
        .a34           ( a34           ),
        .a41           ( a41           ),
        .a42           ( a42           ),
        .a43           ( a43           ),
        .a44           ( a44          ),
        .b11           ( b11           ),
        .b12           ( b12           ),
        .b13           ( b13           ),
        .b21           ( b21           ),
        .b22           ( b22           ),
        .b23           ( b23           ),
        .b31           ( b31           ),
        .b32           ( b32           ),
        .b33           ( b33           ),
        .done_sa3   ( done_sa3   ),
        .c11        ( c11_sa3        ),
        .c12        ( c12_sa3        ),
        .c21        ( c21_sa3        ),
        .c22        ( c22_sa3        )
    );

    //sa2
    systolic_array_2_by_2 u_systolic_array_2_by_2(
        .clk        ( clk        ),
        .rst        ( rst        ),
        .active_sa2 ( active_sa2 ),
        .a11           ( a11           ),
        .a12           ( a12           ),
        .a13           ( a13           ),
        .a14           ( a14          ),
        .a21           ( a21           ),
        .a22           ( a22           ),
        .a23           ( a23           ),
        .a24           ( a24          ),
        .a31           ( a31           ),
        .a32           ( a32           ),
        .a33           ( a33           ),
        .a34           ( a34           ),
        .a41           ( a41           ),
        .a42           ( a42           ),
        .a43           ( a43           ),
        .a44           ( a44          ),
        .b11           ( b11           ),
        .b12           ( b12           ),
        .b13           ( b13           ),
        .b21           ( b21           ),
        .b22           ( b22           ),
        .b23           ( b23           ),
        .b31           ( b31           ),
        .b32           ( b32           ),
        .b33           ( b33           ),
        .done_sa2   ( done_sa2   ),
        .c11        ( c11_sa2        ),
        .c12        ( c12_sa2        ),
        .c21        ( c21_sa2        ),
        .c22        ( c22_sa2        )
    );

    assign c11 = c11_w;
    assign c12 = c12_w;
    assign c21 = c21_w;
    assign c22 = c22_w;
    assign done_send = activate_n;

endmodule