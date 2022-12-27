

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


endmodule