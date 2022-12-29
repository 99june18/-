//This is for the 1-bit full adder module.

module full_adder_gatelevel_module (a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;

	wire xor_out_1;
	wire xnor_out_1, xnor_out_2;
	wire not_out_1;

	wire and_out_1, and_out_2, and_out_3;
	wire or_out_1;

	//sum
	xnor_gatelevel_gate INST_xnor_gatelevel_gate_1(.a ( b ), .b ( cin ), .out ( xnor_out_1 ));
	not_gate INST_not_gate_1(.a(xnor_out_1), .out(xor_out_1));

	xnor_gatelevel_gate INST_xnor_gatelevel_gate_2(.a ( a ), .b ( xor_out_1 ), .out ( xnor_out_2 ));
	not_gate INST_not_gate_2(.a(xnor_out_2), .out(sum));

	//cout
	and_gate INST_and_gate_1 (.a(a), .b(b), .out(and_out_1));
	and_gate INST_and_gate_2 (.a(b), .b(cin), .out(and_out_2));
	and_gate INST_and_gate_3 (.a(cin), .b(a), .out(and_out_3));

	or_gate INST_or_gate_1 (.a(and_out_1), .b(and_out_2), .out(or_out_1));
	or_gate INST_or_gate_2 (.a(or_out_1), .b(and_out_3), .out(cout));

endmodule
