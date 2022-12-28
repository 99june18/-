

module computation_module (clk,rst,active_store,active_single,active_sa3,active_sa2,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,
b11,b12,b13,b21,b22,b23,b31,b32,b33,c11,c12,c21,c22,done_store,done_single,single_sa3,single_sa2,computation_done);

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
    output done_store, done_single, single_sa3, single_sa2;
    output computation_done;


endmodule