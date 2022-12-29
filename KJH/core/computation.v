

module computation_module (clk,rst,active_store,active_single,active_sa3,active_sa2,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,c11,c12,c21,c22,done_store,done_single,done_sa3,done_sa2);

    input clk, rst;
    input active_store, active_single, active_sa3, active_sa2;

    input [7:0] a11,a12,a13,a14,
                a21,a22,a23,a24,
                a31,a32,a33,a34,
                a41,a42,a43,a44;
                
    input [7:0] b11,b12,b13,
                b21,b22,b23,
                b31,b32,b33;

    output [7:0] c11,c12,c21,c22;
    output done_store, done_single, done_sa3, done_sa2;

    wire [7:0]
        a11_w,a12_w,a13_w,a14_w,
        a21_w,a22_w,a23_w,a24_w,
        a31_w,a32_w,a33_w,a34_w,
        a41_w,a42_w,a43_w,a44_w;
    wire [7:0]
        b11_w,b12_w,b13_w,
        b21_w,b22_w,b23_w,
        b31_w,b32_w,b33_w;

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

    //memory
    computation_memory_module u_computation_memory_module(
        .clk           ( clk           ),
        .rst           ( rst           ),
        .activate      ( active_store  ),
        .a11_in        ( a11        ),
        .a12_in        ( a12        ),
        .a13_in        ( a13        ),
        .a14_in        ( a14        ),
        .a21_in        ( a21        ),
        .a22_in        ( a22        ),
        .a23_in        ( a23        ),
        .a24_in        ( a24        ),
        .a31_in        ( a31        ),
        .a32_in        ( a32        ),
        .a33_in        ( a33        ),
        .a34_in        ( a34        ),
        .a41_in        ( a41        ),
        .a42_in        ( a42        ),
        .a43_in        ( a43        ),
        .a44_in        ( a44        ),
        .b11_in        ( b11        ),
        .b12_in        ( b12        ),
        .b13_in        ( b13        ),
        .b21_in        ( b21        ),
        .b22_in        ( b22        ),
        .b23_in        ( b23        ),
        .b31_in        ( b31        ),
        .b32_in        ( b32        ),
        .b33_in        ( b33        ),
        .activate_done ( done_store ),
        .a11           ( a11_w           ),
        .a12           ( a12_w           ),
        .a13           ( a13_w           ),
        .a14           ( a14_w          ),
        .a21           ( a21_w           ),
        .a22           ( a22_w           ),
        .a23           ( a23_w           ),
        .a24           ( a24_w           ),
        .a31           ( a31_w           ),
        .a32           ( a32_w           ),
        .a33           ( a33_w           ),
        .a34           ( a34_w           ),
        .a41           ( a41_w           ),
        .a42           ( a42_w           ),
        .a43           ( a43_w           ),
        .a44           ( a44_w          ),
        .b11           ( b11_w           ),
        .b12           ( b12_w           ),
        .b13           ( b13_w           ),
        .b21           ( b21_w           ),
        .b22           ( b22_w           ),
        .b23           ( b23_w           ),
        .b31           ( b31_w           ),
        .b32           ( b32_w           ),
        .b33           ( b33_w           )
    );

    //single
    single_process_array u_single_process_array(
        .clk           ( clk           ),
        .rst           ( rst           ),
        .active_single ( active_single ),
        .a11           ( a11_w           ),
        .a12           ( a12_w           ),
        .a13           ( a13_w           ),
        .a14           ( a14_w          ),
        .a21           ( a21_w           ),
        .a22           ( a22_w           ),
        .a23           ( a23_w           ),
        .a24           ( a24_w           ),
        .a31           ( a31_w           ),
        .a32           ( a32_w           ),
        .a33           ( a33_w           ),
        .a34           ( a34_w           ),
        .a41           ( a41_w           ),
        .a42           ( a42_w           ),
        .a43           ( a43_w           ),
        .a44           ( a44_w          ),
        .b11           ( b11_w           ),
        .b12           ( b12_w           ),
        .b13           ( b13_w           ),
        .b21           ( b21_w           ),
        .b22           ( b22_w           ),
        .b23           ( b23_w           ),
        .b31           ( b31_w           ),
        .b32           ( b32_w           ),
        .b33           ( b33_w           ),
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
        .a11           ( a11_w           ),
        .a12           ( a12_w           ),
        .a13           ( a13_w           ),
        .a14           ( a14_w          ),
        .a21           ( a21_w           ),
        .a22           ( a22_w           ),
        .a23           ( a23_w           ),
        .a24           ( a24_w           ),
        .a31           ( a31_w           ),
        .a32           ( a32_w           ),
        .a33           ( a33_w           ),
        .a34           ( a34_w           ),
        .a41           ( a41_w           ),
        .a42           ( a42_w           ),
        .a43           ( a43_w           ),
        .a44           ( a44_w          ),
        .b11           ( b11_w           ),
        .b12           ( b12_w           ),
        .b13           ( b13_w           ),
        .b21           ( b21_w           ),
        .b22           ( b22_w           ),
        .b23           ( b23_w           ),
        .b31           ( b31_w           ),
        .b32           ( b32_w           ),
        .b33           ( b33_w           ),
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
        .a11           ( a11_w           ),
        .a12           ( a12_w           ),
        .a13           ( a13_w           ),
        .a14           ( a14_w          ),
        .a21           ( a21_w           ),
        .a22           ( a22_w           ),
        .a23           ( a23_w           ),
        .a24           ( a24_w           ),
        .a31           ( a31_w           ),
        .a32           ( a32_w           ),
        .a33           ( a33_w           ),
        .a34           ( a34_w           ),
        .a41           ( a41_w           ),
        .a42           ( a42_w           ),
        .a43           ( a43_w           ),
        .a44           ( a44_w          ),
        .b11           ( b11_w           ),
        .b12           ( b12_w           ),
        .b13           ( b13_w           ),
        .b21           ( b21_w           ),
        .b22           ( b22_w           ),
        .b23           ( b23_w           ),
        .b31           ( b31_w           ),
        .b32           ( b32_w           ),
        .b33           ( b33_w           ),
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

endmodule