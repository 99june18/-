

module eight_bit_multiplier_module (a, b, out);

    input [7:0] a, b;

    output [7:0] out;

    wire [7:0] shift_a1, shift_a2, shift_a3, shift_a4, shift_a5, shift_a6, shift_a7;
    wire [7:0] out0, out1, out2, out3, out4, out5, out6, out7;
    wire [7:0] add0, add1, add2, add3, add4, add5;

    shift_module INST_shift_module_1(.a(a), .shift(3'b001), .out(shift_a1));
    shift_module INST_shift_module_2(.a(a), .shift(3'b010), .out(shift_a2));
    shift_module INST_shift_module_3(.a(a), .shift(3'b011), .out(shift_a3));
    shift_module INST_shift_module_4(.a(a), .shift(3'b100), .out(shift_a4));
    shift_module INST_shift_module_5(.a(a), .shift(3'b101), .out(shift_a5));
    shift_module INST_shift_module_6(.a(a), .shift(3'b110), .out(shift_a6));
    shift_module INST_shift_module_7(.a(a), .shift(3'b111), .out(shift_a7));

    assign out0 = (b[0] == 0) ? (8'b0) : (a);
    assign out1 = (b[1] == 0) ? (8'b0) : (shift_a1); 
    assign out2 = (b[2] == 0) ? (8'b0) : (shift_a2); 
    assign out3 = (b[3] == 0) ? (8'b0) : (shift_a3); 
    assign out4 = (b[4] == 0) ? (8'b0) : (shift_a4); 
    assign out5 = (b[5] == 0) ? (8'b0) : (shift_a5); 
    assign out6 = (b[6] == 0) ? (8'b0) : (shift_a6); 
    assign out7 = (b[7] == 0) ? (8'b0) : (shift_a7);

    eight_bit_full_adder_module INST_eight_bit_full_adder_module_1
    (.a(out0), .b(out1), .cin(1'b0), .sum(add0), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_2
    (.a(add0), .b(out2), .cin(1'b0), .sum(add1), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_3
    (.a(add1), .b(out3), .cin(1'b0), .sum(add2), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_4
    (.a(add2), .b(out4), .cin(1'b0), .sum(add3), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_5
    (.a(add3), .b(out5), .cin(1'b0), .sum(add4), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_6
    (.a(add4), .b(out6), .cin(1'b0), .sum(add5), .cout());
    eight_bit_full_adder_module INST_eight_bit_full_adder_module_7
    (.a(add5), .b(out7), .cin(1'b0), .sum(out ),  .cout());

endmodule