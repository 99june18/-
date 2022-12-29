

module computation_memory_module (clk, rst, activate, a11_in,a12_in,a13_in,a14_in,a21_in,a22_in,a23_in,a24_in,a31_in,a32_in,a33_in,a34_in,
a41_in,a42_in,a43_in,a44_in,b11_in,b12_in,b13_in,b21_in,b22_in,b23_in, b31_in,b32_in,b33_in,
activate_done,a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44,b11,b12,b13,b21,b22,b23,b31,b32,b33);

    input clk,rst,activate;
    input [7:0] a11_in,a12_in,a13_in,a14_in,
                a21_in,a22_in,a23_in,a24_in,
                a31_in,a32_in,a33_in,a34_in,
                a41_in,a42_in,a43_in,a44_in;

    input [7:0] b11_in,b12_in,b13_in,
                b21_in,b22_in,b23_in,
                b31_in,b32_in,b33_in;
    
    output activate_done;

    output [7:0] a11,a12,a13,a14,
                 a21,a22,a23,a24,
                 a31,a32,a33,a34,
                 a41,a42,a43,a44;

    output [7:0] b11,b12,b13,
                 b21,b22,b23,
                 b31,b32,b33;

    reg [7:0] storage_data[0:15], storage_filter[0:8];
    reg activate_done_w;

    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1)
        begin
            storage_data[0] <= 8'b0; storage_data[1] <= 8'b0; storage_data[2] <= 8'b0; storage_data[3] <= 8'b0;
            storage_data[4] <= 8'b0; storage_data[5] <= 8'b0; storage_data[6] <= 8'b0; storage_data[7] <= 8'b0;
            storage_data[8] <= 8'b0; storage_data[9] <= 8'b0; storage_data[10] <= 8'b0; storage_data[11] <= 8'b0;
            storage_data[12] <= 8'b0; storage_data[13] <= 8'b0; storage_data[14] <= 8'b0; storage_data[15] <= 8'b0;
            
            storage_filter[0] <= 8'b0; storage_filter[1] <= 8'b0; storage_filter[2] <= 8'b0;
            storage_filter[3] <= 8'b0; storage_filter[4] <= 8'b0; storage_filter[5] <= 8'b0;
            storage_filter[6] <= 8'b0; storage_filter[7] <= 8'b0; storage_filter[8] <= 8'b0;
            activate_done_w <= 1'b0;
        end else begin
            if (activate == 1'b1) 
            begin
                storage_data[0] <= a11_in; storage_data[1] <= a12_in; storage_data[2] <= a13_in; storage_data[3] <= a14_in;
                storage_data[4] <= a21_in; storage_data[5] <= a22_in; storage_data[6] <= a23_in; storage_data[7] <= a24_in;
                storage_data[8] <= a31_in; storage_data[9] <= a32_in; storage_data[10] <= a33_in; storage_data[11] <= a34_in;
                storage_data[12] <= a41_in; storage_data[13] <= a42_in; storage_data[14] <= a43_in; storage_data[15] <= a44_in;
                
                storage_filter[0] <= b11_in; storage_filter[1] <= b12_in; storage_filter[2] <= b13_in;
                storage_filter[3] <= b21_in; storage_filter[4] <= b22_in; storage_filter[5] <= b23_in;
                storage_filter[6] <= b31_in; storage_filter[7] <= b32_in; storage_filter[8] <= b33_in;
                activate_done_w <= 1'b1;
            end else begin
                activate_done_w <= 1'b0;
            end
        end
    end

    assign activate_done = activate_done_w;
    
    assign a11 = storage_data[0];
    assign a12 = storage_data[1];
    assign a13 = storage_data[2];
    assign a14 = storage_data[3];
    assign a21 = storage_data[4];
    assign a22 = storage_data[5];
    assign a23 = storage_data[6];
    assign a24 = storage_data[7];
    assign a31 = storage_data[8];
    assign a32 = storage_data[9];
    assign a33 = storage_data[10];
    assign a34 = storage_data[11];
    assign a41 = storage_data[12];
    assign a42 = storage_data[13];
    assign a43 = storage_data[14];
    assign a44 = storage_data[15];

    assign b11 = storage_filter[0];
    assign b12 = storage_filter[1];
    assign b13 = storage_filter[2];
    assign b21 = storage_filter[3];
    assign b22 = storage_filter[4];
    assign b23 = storage_filter[5];
    assign b31 = storage_filter[6];
    assign b32 = storage_filter[7];
    assign b33 = storage_filter[8];
    
endmodule