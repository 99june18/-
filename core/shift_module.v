//left shift module for multiplier

module shift_module (a, shift, out);
    
    input [7:0] a;
    input [2:0] shift;

    output [7:0] out;
    
    reg [7:0] out;

    always @ (a or shift) 
    begin
        case(shift)
            3'b000: 
            begin
                out[0] = a[0];
                out[1] = a[1];
                out[2] = a[2];
                out[3] = a[3];
                out[4] = a[4];
                out[5] = a[5];
                out[6] = a[6];
                out[7] = a[7];
            end
            3'b001: 
            begin
                out[0] = 1'b0;
                out[1] = a[0];
                out[2] = a[1];
                out[3] = a[2];
                out[4] = a[3];
                out[5] = a[4];
                out[6] = a[5];
                out[7] = a[6];
            end
            3'b010: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = a[0];
                out[3] = a[1];
                out[4] = a[2];
                out[5] = a[3];
                out[6] = a[4];
                out[7] = a[5];
            end
            3'b011: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = a[0];
                out[4] = a[1];
                out[5] = a[2];
                out[6] = a[3];
                out[7] = a[4];
            end
            3'b100: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = 1'b0;
                out[4] = a[0];
                out[5] = a[1];
                out[6] = a[2];
                out[7] = a[3];
            end
            3'b101: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = 1'b0;
                out[4] = 1'b0;
                out[5] = a[0];
                out[6] = a[1];
                out[7] = a[2];
            end
            3'b110: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = 1'b0;
                out[4] = 1'b0;
                out[5] = 1'b0;
                out[6] = a[0];
                out[7] = a[1];
            end
            3'b111: 
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = 1'b0;
                out[4] = 1'b0;
                out[5] = 1'b0;
                out[6] = 1'b0;
                out[7] = a[0];
            end
            default:
            begin
                out[0] = 1'b0;
                out[1] = 1'b0;
                out[2] = 1'b0;
                out[3] = 1'b0;
                out[4] = 1'b0;
                out[5] = 1'b0;
                out[6] = 1'b0;
                out[7] = 1'b0;
            end
        endcase
    end
endmodule